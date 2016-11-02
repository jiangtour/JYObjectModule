//
//  JYRLMObject.m
//  JYObjectModule
//
//  Created by devedbox on 16/8/27.
//  Copyright © 2016年 jiangyou. All rights reserved.
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

#import "JYRLMObject.h"
#import "JYObject.h"

@implementation JYRLMObject
+ (void)load {
}

- (BOOL)available {
    if ([self conformsToProtocol:@protocol(JYObject)] && [self respondsToSelector:@selector(objectId)]) {
        if (![[NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] '__placeholder' OR SELF MATCHES[cd] '__placeholder'"] evaluateWithObject:[self valueForKeyPath:@"objectId"]]) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)shouldStoreToRealm {
    return YES;
}

#pragma mark - Realm support
+ (NSArray *)indexedProperties
{
    Class cls = self;
    if (cls == JYRLMObject.class) {
        return nil;
    }
    
    NSArray *indexedProperties = JYObject.indexedProperties;
    return indexedProperties;
}
+ (nullable NSDictionary *)defaultPropertyValues
{
    Class cls = self;
    if (cls == JYRLMObject.class) {
        return nil;
    }
    
    NSDictionary *defaultPropertyValues = JYObject.defaultPropertyValues;
    return defaultPropertyValues;
}
+ (nullable NSString *)primaryKey
{
    Class cls = self;
    if (cls == JYRLMObject.class) {
        return nil;
    }
    
    NSString *primaryKey = JYObject.primaryKey;
    return primaryKey;
}
+ (nullable NSArray *)ignoredProperties
{
    Class cls = self;
    if (cls == JYRLMObject.class) {
        return nil;
    }
    
    NSArray *ignoredProperties = JYObject.ignoredProperties;
    return ignoredProperties;
}
+ (NSArray *)requiredProperties
{
    Class cls = self;
    if (cls == JYRLMObject.class) {
        return nil;
    }
    
    NSArray *requiredProperties = JYObject.requiredProperties;
    return requiredProperties;
}
@end

@implementation NSArray (JYRLMObject)
- (NSArray *)addObjectsFromArray:(NSArray *)otherArray {
    NSMutableArray *cmd = [self mutableCopy];
    [cmd addObjectsFromArray:otherArray];
    return [cmd copy];
}
@end

@implementation NSDictionary (JYRLMObject)
- (instancetype)addEntriesFromDictionary:(NSDictionary *)otherDictionary {
    NSMutableDictionary *cmd = [self mutableCopy];
    [cmd addEntriesFromDictionary:otherDictionary];
    return [cmd copy];
}
@end
