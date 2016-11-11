//
//  RLMRealm+KeyValue.m
//  JYObjectModule
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "RLMObject+KeyValue.h"
#import <MJExtension/MJExtension.h>
#import <objc/runtime.h>

NSString *const JYKeyValueObjectPlaceholder = @"__placeholder";
int64_t const JYKeyValueIntPlaceholder = -1001;
float const JYKeyValueFloatPlaceholder = -1001.0;
double const JYKeyValueDoublePlaceholder = JYKeyValueFloatPlaceholder;

@implementation NSObject (KeyValue)

- (NSDictionary *)keyValue {
    // Get the class schema.
    NSMutableDictionary *schema = [[self.class classSchemaWithClass:self.class] mutableCopy];
    // Set value to schema.
    
    NSArray *keys = [schema allKeys];
    
    for (NSString *key in keys) {
        // Get object.
        id obj = schema[key];
        // Check type of object.
        if ([obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSData class]] || [obj isKindOfClass:[NSDate class]]) { // Basic types.
            schema[key] = [self valueForKey:key];
        } else if ([obj isKindOfClass:[NSArray class]]) { // RLMArray.
            // Set Object.
            NSMutableArray *objects = [@[] mutableCopy];
            
            RLMArray *array = [self valueForKey:key];
            
            for (int i = 0; i < [array count]; i++) {
                RLMObject *_obj = array[i];
                
                [objects addObject:_obj.keyValue];
            }
            
            schema[key] = objects;
        } else if ([obj isKindOfClass:[NSDictionary class]]) { // RLMObject.
            schema[key] = [[self valueForKey:key] keyValue];
        } else {
            id obj = [self valueForKey:key];
            if (obj) {
                schema[key] = obj;
            } else {
                schema[key] = JYKeyValueObjectPlaceholder;
            }
        }
    }
    return schema;
}

+ (instancetype)objectWithKeyValue:(NSDictionary *)object {
    if (!object || ![object isKindOfClass:NSDictionary.class]) {
        return [self new];
    }
    // Get the class schema for the class.
    NSDictionary *schema = [self classSchemaWithClass:self];
    // Set value of the schema:
    NSArray *keys = [schema allKeys];
    
    // Convert object to completed object.
    object = [self convertObject:object withSchema:schema];
    
    NSObject *newObject = [self mj_objectWithKeyValues:object];
    
    if (!newObject) {
        return [self new];
    }
    
    for (int i = 0; i < keys.count; i ++) {
        // Key.
        NSString *key = keys[i];
        id obj = object[key];
        // Check type of object.
        if ([obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSData class]] || [obj isKindOfClass:[NSDate class]]) { // Basic types.
            [newObject setValue:obj forKey:key];
        } else if ([obj isKindOfClass:[NSArray class]]) { // RLMArray.
            // Set Object.
            for (int i = 0; i < [obj count]; i++) {
                id _obj = obj[i];
                // Get property.
                MJProperty *property = [MJProperty cachedPropertyWithProperty:class_getProperty(self, [key UTF8String])];
                
                static const char arrayPrefix[] = "NSArray<";
                static const int arrayPrefixLen = sizeof(arrayPrefix) - 1;
                const char *code = property.type.code.UTF8String;
                
                // get object class from type string - @"RLMArray<objectClassName>"
                NSString *objectClassName = [[NSString alloc] initWithBytes:code + arrayPrefixLen length:strlen(code + arrayPrefixLen) - 1 // drop trailing >"
                                                                   encoding:NSUTF8StringEncoding];
                
                Class objectClass = NSClassFromString(objectClassName);
                
                if (objectClass != NULL) {
                    // Initialize a new RLMObject.
                    NSObject *childObject = [objectClass objectWithKeyValue:_obj];
                    
                    if (childObject) {
                        [[newObject valueForKey:key] addObject:childObject];
                    }
                } else {
                    return [self objectWithKeyValue:object];
                }
            }
        } else if ([obj isKindOfClass:[NSDictionary class]]) { // NSObject.
            // Get property.
            MJProperty *property = [MJProperty cachedPropertyWithProperty:class_getProperty(self, [key UTF8String])];
            // Initialize a new NSObject.
            NSObject *childObject = [property.type.typeClass objectWithKeyValue:obj];
            // Set child object to father object.
            [newObject setValue:childObject forKey:key];
        } else {
            return [self objectWithKeyValue:object];
        }
    }
    return newObject;
}

+ (NSDictionary *)convertJSONObject:(NSDictionary *)object withObjectClass:(Class _Nonnull)cls {
    // Get the map of object class.
    NSDictionary *objectSchema = [self classSchemaWithClass:cls];
    
    NSDictionary *_object = [self convertObject:object withSchema:objectSchema];
    
    return _object;
}

+ (NSDictionary *)cleanSchemaWithClass:(Class _Nonnull)cls {
    NSDictionary *schema = [self classSchemaWithClass:cls];
    
    return [self cleanKeyValueWithObject:schema];
}

+ (NSDictionary *)cleanKeyValueWithObject:(NSDictionary *)object {
    // Filter the NSArray&NSDictionary objects.
    NSMutableDictionary *clean = [NSMutableDictionary dictionary];
    
    NSArray *allkeys = [object allKeys];
    
    for (int i = 0; i < allkeys.count; i++) {
        NSString *key = allkeys[i];
        
        id obj = object[key];
        
        if (![obj isKindOfClass:[NSArray class]] && ![obj isKindOfClass:[NSDictionary class]]) {
            [clean setObject:obj forKey:key];
        }
    }
    return clean;
}

+ (NSDictionary *)classSchemaWithClass:(Class _Nonnull)cls {
    NSMutableDictionary *properiesInfo = [@{} mutableCopy];
    
    Class objectClass = cls;
    Class superClass = class_getSuperclass(objectClass);
    
    while (superClass && superClass != RLMObject.class) {
        unsigned int count = 0;
        objc_property_t *properties = class_copyPropertyList(objectClass, &count);
        
        // Get the class properties info.
        for (int i = 0; i < count; i++) {
            NSString *name = @(property_getName(properties[i]));
            
            // Initialize a property object.
            MJProperty *property = [MJProperty cachedPropertyWithProperty:properties[i]];
            
            unsigned int count;
            objc_property_attribute_t *attrs = property_copyAttributeList(properties[i], &count);
            
            BOOL isReadOnly = NO;
            for (size_t i = 0; i < count; ++i) {
                if (*attrs[i].name == 'R') {
                    isReadOnly = YES;
                }
            }
            free(attrs);
            
            if (isReadOnly) {
                continue;
            }
            
            const char *code = property.type.code.UTF8String;
            char objcType = *code;
            
            switch (objcType) {
                case 's':   // short
                case 'i':   // int
                case 'l':   // long
                case 'q':   // long long
                    properiesInfo[name]=@(JYKeyValueIntPlaceholder);
                    break;
                case 'f':   // float
                    properiesInfo[name]=@(JYKeyValueFloatPlaceholder);
                    break;
                case 'd':   // double
                    properiesInfo[name]=@(JYKeyValueDoublePlaceholder);
                    break;
                case 'c':   // BOOL is stored as char - since rlm has no char type this is ok
                case 'B':   // BOOL
                    properiesInfo[name]=@(0);
                    break;
                default:
                {
                    static const char arrayPrefix[] = "RLMArray<";
                    static const int arrayPrefixLen = sizeof(arrayPrefix) - 1;
                    
                    static const char numberPrefix[] = "NSNumber<";
                    static const int numberPrefixLen = sizeof(numberPrefix) - 1;
                    
                    NSString *_objectClassName;
                    
                    if (strcmp(code, "NSString") == 0) { // NSString
                        properiesInfo[name]=JYKeyValueObjectPlaceholder;
                    } else if (strcmp(code, "NSDate") == 0) { // NSDate
                        properiesInfo[name]=[NSDate dateWithTimeIntervalSince1970:0];
                    } else if (strcmp(code, "NSData") == 0) { // NSData
                        properiesInfo[name]=[JYKeyValueObjectPlaceholder dataUsingEncoding:NSUTF8StringEncoding];
                    } else if (strncmp(code, arrayPrefix, arrayPrefixLen) == 0) { // RLMPropertyTypeArray
                        // get object class from type string - @"RLMArray<objectClassName>"
                        _objectClassName = [[NSString alloc] initWithBytes:code + arrayPrefixLen length:strlen(code + arrayPrefixLen) - 1 // drop trailing >"
                                                                  encoding:NSUTF8StringEncoding];
                        
                        Class cls = NSClassFromString(_objectClassName);
                        if (!cls) {
                            [NSException raise:RLMExceptionName format:
                             @"Property '%@' is of type 'RLMArray<%@>' which is not a supported RLMArray object type. "
                             @"RLMArrays can only contain instances of RLMObject subclasses. "
                             @"See https://realm.io/docs/objc/latest/#to-many for more information.", name, _objectClassName];
                        }
                        properiesInfo[name]=@[];
                    } else if (strncmp(code, numberPrefix, numberPrefixLen) == 0) {
                        // get number type from type string - @"NSNumber<objectClassName>"
                        NSString *numberType = [[NSString alloc] initWithBytes:code + numberPrefixLen length:strlen(code + numberPrefixLen) - 1 // drop trailing >"
                                                                      encoding:NSUTF8StringEncoding];
                        
                        if ([numberType isEqualToString:@"RLMInt"]) { // RLMInt
                            properiesInfo[name]=@(JYKeyValueIntPlaceholder);
                        } else if ([numberType isEqualToString:@"RLMFloat"]) { // RLMFloat
                            properiesInfo[name]=@(JYKeyValueFloatPlaceholder);
                        } else if ([numberType isEqualToString:@"RLMDouble"]) { // RLMDouble
                            properiesInfo[name]=@(JYKeyValueDoublePlaceholder);
                        } else if ([numberType isEqualToString:@"RLMBool"]) { // RLMBool
                            properiesInfo[name]=@(JYKeyValueIntPlaceholder);
                        } else {
                            [NSException raise:RLMExceptionName format:@"Property '%@' is of type 'NSNumber<%@>' which is not a supported NSNumber object type.\nNSNumbers can only be RLMInt, RLMFloat, RLMDouble, and RLMBool at the moment.See https://realm.io/docs/objc/latest for more information.", name, property.type.code];
                        }
                    } else if (strcmp(code, "NSNumber") == 0) {
                        [NSException raise:RLMExceptionName format:@"Property '%@' requires a protocol defining the contained type - example: NSNumber<RLMInt>.", name];
                    } else if (strcmp(code, "RLMArray") == 0) {
                        [NSException raise:RLMExceptionName format:@"Property '%@' requires a protocol defining the contained type - example: RLMArray<Person>.", name];
                    } else { // RLMPropertyTypeObject
                        NSString *className;
                        Class cls = nil;
                        if (code[1] == '\0') {
                            className = @"id";
                            properiesInfo[name]=[NSObject new];
                        } else {
                            cls = property.type.typeClass;
                            if (!cls) {
                                [NSException raise:RLMExceptionName format:@"Property '%@' is declared as '%@', which is not a supported RLMObject property type. "
                                 @"All properties must be primitives, NSString, NSDate, NSData, NSNumber, RLMArray, RLMLinkingObjects, or subclasses of RLMObject. "
                                 @"See https://realm.io/docs/objc/latest/api/Classes/RLMObject.html for more information.", name, className];
                            }
                            NSDictionary *childPropertiesInfo = [self classSchemaWithClass:cls];
                            properiesInfo[name]=childPropertiesInfo;
                        }
                    }
                }
                    break;
            }
        }
        
        free(properties);
        
        objectClass = superClass;
        superClass = class_getSuperclass(objectClass);
    }
    
    return [properiesInfo copy];
}

+ (NSDictionary *)convertObject:(NSDictionary *)object withSchema:(NSDictionary *)objectSchema {
    // Copy object.
    NSMutableDictionary *mutableObject = [object mutableCopy];
    
    if (!mutableObject) {
        mutableObject = [@{} mutableCopy];
    }
    
    NSArray *keys = [objectSchema allKeys];
    
    for (int i = 0; i < keys.count; i ++) {
        NSString *key = keys[i];
        // Get object if schema.
        id obj = objectSchema[key];
        
        id object = mutableObject[key];
        // Handle with NSNull object.
        if ([mutableObject.allKeys containsObject:key] && [object isKindOfClass:[NSNull class]]) {
            mutableObject[key] = [self appendNullIndicatorWithObject:[obj copy]];
        }
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary *childObject = [self convertObject:[mutableObject[key] copy] withSchema:objectSchema[key]];
            // Replace the child object.
            mutableObject[keys[i]] = childObject;
        } else {
            // Check the object.
            if (![mutableObject.allKeys containsObject:key]) {
                mutableObject[key] = objectSchema[key];
            }
        }
    }
    
    return [mutableObject copy];
}

+ (id _Nonnull)appendNullIndicatorWithObject:(id _Nonnull)object {
    if ([object isKindOfClass:NSDictionary.class]) {
        NSMutableDictionary *obj = [object mutableCopy];
        // Append null.
        NSArray *keys = [object allKeys];
        
        for (int i = 0; i < keys.count; i ++) {
            id _obj = [self appendNullIndicatorWithObject:obj[keys[i]]];
            [obj setObject:_obj forKey:keys[i]];
        }
        
        return obj;
    } else if ([object isKindOfClass:NSString.class]) {
        return [object stringByAppendingString:@"_null"];
    } else {
        return object;
    }
}

+ (RLMObject *)resolvedObjectForObjectClass:(Class)objCls withKayValue:(NSDictionary *)keyValue {
    return [objCls objectWithKeyValue:keyValue];
}

@end

@implementation RLMObject (KeyValue)
- (NSDictionary *)keyValue {
    // Get the class schema.
    NSMutableDictionary *schema = [[self.class classSchemaWithClass:self.class] mutableCopy];
    // Set value to schema.
    
    NSArray *keys = [schema allKeys];
    
    for (NSString *key in keys) {
        // Get object.
        id obj = schema[key];
        // Check type of object.
        if ([obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSData class]] || [obj isKindOfClass:[NSDate class]]) { // Basic types.
            schema[key] = [self valueForKey:key];
        } else if ([obj isKindOfClass:[NSArray class]]) { // RLMArray.
            // Set Object.
            NSMutableArray *objects = [@[] mutableCopy];
            
            RLMArray *array = [self valueForKey:key];
            
            for (int i = 0; i < [array count]; i++) {
                RLMObject *_obj = array[i];
                
                [objects addObject:_obj.keyValue];
            }
            
            schema[key] = objects;
        } else if ([obj isKindOfClass:[NSDictionary class]]) { // RLMObject.
            schema[key] = [[self valueForKey:key] keyValue];
        } else {
            id obj = [self valueForKey:key];
            if (obj) {
                schema[key] = obj;
            } else {
                schema[key] = JYKeyValueObjectPlaceholder;
            }
        }
    }
    return schema;
}

+ (instancetype)objectWithKeyValue:(NSDictionary *)object {
    if (!object || ![object isKindOfClass:NSDictionary.class]) {
        return [self new];
    }
    // Get the class schema for the class.
    NSDictionary *schema = [self classSchemaWithClass:self];
    // Set value of the schema:
    NSArray *keys = [schema allKeys];
    
    // Convert object to completed object.
    object = [self convertObject:object withSchema:schema];
    
    RLMObject *newObject = [[self alloc] initWithValue:[self cleanKeyValueWithObject:object]];
    
    if (!newObject) {
        return [self new];
    }
    
    for (int i = 0; i < keys.count; i ++) {
        // Key.
        NSString *key = keys[i];
        id obj = object[key];
        // Check type of object.
        if ([obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSData class]] || [obj isKindOfClass:[NSDate class]]) { // Basic types.
            [newObject setValue:obj forKey:key];
        } else if ([obj isKindOfClass:[NSArray class]]) { // RLMArray.
            // Set Object.
            for (int i = 0; i < [obj count]; i++) {
                id _obj = obj[i];
                // Get property.
                MJProperty *property = [MJProperty cachedPropertyWithProperty:class_getProperty(self, [key UTF8String])];
                
                static const char arrayPrefix[] = "RLMArray<";
                static const int arrayPrefixLen = sizeof(arrayPrefix) - 1;
                const char *code = property.type.code.UTF8String;
                
                // get object class from type string - @"RLMArray<objectClassName>"
                NSString *objectClassName = [[NSString alloc] initWithBytes:code + arrayPrefixLen length:strlen(code + arrayPrefixLen) - 1 // drop trailing >"
                                                                   encoding:NSUTF8StringEncoding];
                
                Class objectClass = NSClassFromString(objectClassName);
                
                if (objectClass != NULL) {
                    // Initialize a new RLMObject.
                    RLMObject *childObject = [objectClass objectWithKeyValue:_obj];
                    
                    if (childObject) {
                        [[newObject valueForKey:key] addObject:childObject];
                    }
                } else {
                    return [[self alloc] initWithValue:object];
                }
            }
        } else if ([obj isKindOfClass:[NSDictionary class]]) { // RLMObject.
            // Get property.
            MJProperty *property = [MJProperty cachedPropertyWithProperty:class_getProperty(self, [key UTF8String])];
            // Initialize a new RLMObject.
            RLMObject *childObject = [self resolvedObjectForObjectClass:property.type.typeClass withKayValue:obj];
            // Set child object to father object.
            [newObject setValue:childObject forKey:key];
        } else {
            return [[self alloc] initWithValue:object];
        }
    }
    return newObject;
}
@end
