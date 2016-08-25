// CBDataStore.m
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

#import "CBDataStore.h"
#import "FMDB.h"

@interface CBDataStore()

@property (nonatomic, strong, readwrite) FMDatabaseQueue *dbQueue;

@end

@implementation CBDataStore

- (instancetype)initDatabaseWithDBName:(NSString *)dbName
                             tableName:(NSString *)tableName {
    self = [super init];
    
    if (self) {
        NSAssert(dbName.length, @"String of the dbName can't be empty.");
        
        NSAssert(tableName.length, @"String of the tableName can't be empty.");
        
        NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:dbName];
        
        NSLog(@"%@", path);
        
        if (_dbQueue) {
            [_dbQueue close];
        }
        
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:path];
        
        __block BOOL tableExit = NO;
        
        [_dbQueue inDatabase:^(FMDatabase *db) {
            tableExit = [db tableExists:tableName];
        }];
        
        if (!tableExit) {
            NSString * sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (OBJECTID TEXT NOT NULL, DATA TEXT NOT NULL, SAVETIME TEXT NOT NULL, PRIMARY KEY(OBJECTID))", tableName];
            
            __block BOOL crateTableSuccess = NO;
            
            [_dbQueue inDatabase:^(FMDatabase *db) {
                crateTableSuccess = [db executeUpdate:sql];
            }];
            
            if (!crateTableSuccess) {
                NSLog(@"Failed to crate the table named %@", tableName);
            }
        }
    }
    return self;
}


+ (void)deleteTableWithDBName:(NSString *)dbName
                    tableName:(NSString *)tableName {

    NSAssert(tableName.length, @"String of the tableName can't be empty.");
    
    NSString * sql = [NSString stringWithFormat:@" DROP TABLE '%@' ", tableName];
    
    __block BOOL deleteTableSuccess = NO;
    
    FMDatabaseQueue *dbQueue = [FMDatabaseQueue databaseQueueWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:dbName]];
    
    [dbQueue inDatabase:^(FMDatabase *db) {
        deleteTableSuccess = [db executeUpdate:sql];
    }];
    
    if (!deleteTableSuccess) {
        NSLog(@"Failed to delete the table named %@", tableName);
    }
}

- (void)saveObject:(id)object
           withKey:(NSString *)key
         intoTable:(NSString *)tableName {
    NSAssert(object, @"Object which wanna be saved can't be nil.");
    
    NSAssert(key.length, @"String of the objectID can't be empty.");
    
    NSAssert(tableName.length, @"String of the tableName can't be empty.");
    
    NSError *error;
    
    NSData *data;
    
    if ([NSJSONSerialization isValidJSONObject:object]) {
        data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    }
    
    if (error) {
        NSLog(@"%@", error);
        
        return;
    }
    
    NSString * dataString = [[NSString alloc] initWithData:data encoding:(NSUTF8StringEncoding)];
    
    NSDate * currentTime = [NSDate date];
    
    NSString * sql = [NSString stringWithFormat:@"REPLACE INTO %@ (OBJECTID, DATA, SAVETIME) values (?, ?, ?)", tableName];
    
    __block BOOL saveObjectSuccess = NO;
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        saveObjectSuccess = [db executeUpdate:sql, key, dataString, currentTime];
    }];
    
    if (!saveObjectSuccess) {
        NSLog(@"Failed to save the object with key : %@ from the table : %@", key,tableName);
    }
}

- (id)getObjectWithKey:(NSString *)key
             fromTable:(NSString *)tableName {
    NSAssert(key.length, @"String of the objectID can't be empty.");
    
    NSAssert(tableName.length, @"String of the tableName can't be empty.");
    
    NSString * sql = [NSString stringWithFormat:@"SELECT DATA from %@ where OBJECTID = ? Limit 1", tableName];
    
    __block NSString *dataString;
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *resultSet = [db executeQuery:sql, key];
        
        if ([resultSet next]) {
            dataString = [resultSet stringForColumn:@"DATA"];
        }
        [resultSet close];
    }];
    
    id data;
    
    if (dataString) {
        NSError * error;
        
        data = [NSJSONSerialization JSONObjectWithData:[dataString dataUsingEncoding:NSUTF8StringEncoding]
                                               options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            NSLog(@"%@", error);
            
            return nil;
        }
    }
    return data;
}

- (void)deleteObjectWithKey:(NSString *)key
                  fromTable:(NSString *)tableName {
    NSAssert(key.length, @"String of the objectID can't be empty.");
    
    NSAssert(tableName.length, @"String of the tableName can't be empty.");
    
    NSString * sql = [NSString stringWithFormat:@"DELETE from %@ where OBJECTID = ?", tableName];
    
    __block BOOL deleteObjectSuccess = NO;
    
    [_dbQueue inDatabase:^(FMDatabase *db) {
        deleteObjectSuccess = [db executeUpdate:sql, key];
    }];
    
    if (!deleteObjectSuccess) {
        NSLog(@"Failed to delete the object with key : %@ from the table : %@", key,tableName);
    }
}
@end
