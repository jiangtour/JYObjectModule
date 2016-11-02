//
//  JYRLMObject.h
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

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import <objc/runtime.h>
/*!
 *  JYRLMObject basic realm object.
 */
@interface JYRLMObject : RLMObject
/*!
 *  Is the object available.
 */
@property(readonly, nonatomic) BOOL available;
/*!
 *  Should store the object to Realm database. Default is YES.
 *
 *  @return a boolean value.
 */
+ (BOOL)shouldStoreToRealm;
@end

@interface NSArray (JYRLMObject)
- (nonnull instancetype)addObjectsFromArray:(NSArray * _Nonnull)otherArray;
@end

@interface NSDictionary (JYRLMObject)
- (nonnull instancetype)addEntriesFromDictionary:(NSDictionary *_Nonnull)otherDictionary;
@end
