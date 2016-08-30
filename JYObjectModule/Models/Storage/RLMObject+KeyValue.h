//
//  RLMRealm+KeyValue.h
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

#import <Realm/Realm.h>

@interface RLMObject (KeyValue)
/// Initializes an unmanaged instance of a Realm object.
///
/// Pass in an NSDictionary instance to set the values of the object's properties.
///
/// Call `addObject:` on an `RLMRealm` instance to add an unmanaged object into that Realm.
///
/// @see `[RLMRealm addObject:]`
+ (instancetype _Nonnull)objectWithKeyValue:(NSDictionary * _Nullable)object;
/// Get the key value object of the RLMObject's instance.
///
/// @discusstion If the object if nil, this priperty will return the schema of the class.
///
@property(readonly, nonatomic, nonnull) NSDictionary *keyValue;
@end