// CBDataStore.h
// Copyright (c) 2016 陈超邦.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

@interface CBDataStore : NSObject

/**
 *  Open or crate specified databaseQueue and specified table.
 *
 *  @param dbName    name of the databaseQueue.
 *  @param tableName name of the table.
 *
 *  @return the instance.
 */
- (instancetype)initDatabaseWithDBName:(NSString *)dbName
                             tableName:(NSString *)tableName;

/**
 *  Delete the specified table.
 *
 *  @param tableName name of the table.
 */
- (void)deleteTableWithName:(NSString *)tableName;

/**
 *  Easy method used to store any kind of object.
 *
 *  @param object    unlimited kind of object.
 *  @param key       special id of the object.
 *  @param tableName name of the data table.
 */
- (void)saveObject:(id)object
           withKey:(NSString *)key
         intoTable:(NSString *)tableName;

/**
 *  Easy method used to get specified object.
 *
 *  @param key       special id of the object.
 *  @param tableName name of the data table.
 *
 *  @return specified object.
 */
- (id)getObjectWithKey:(NSString *)key
             fromTable:(NSString *)tableName;

/**
 *  Easy method used to delete single kind of object from specified table.
 *
 *  @param key       special id of the object.
 *  @param tableName name of the data table.
 */
- (void)deleteObjectWithKey:(NSString *)key
                  fromTable:(NSString *)tableName;


@end
