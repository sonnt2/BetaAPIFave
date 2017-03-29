//
//  TestPropertiesUtility.m
//  TestRationFace
//
//  Created by REC03 on 3/29/17.
//  Copyright © 2017 com.devMoney. All rights reserved.
//

#import "TestPropertiesUtility.h"

@implementation TestPropertiesUtility

+ (id) valueForKeyOfMaster:(NSString *)keyName master:(NSString *)masterName {
    //Get path of master plist
     NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"masterData" ofType:@"plist"];
    
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        NSString *documentRootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        plistPath = [documentRootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", masterName]];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
            NSLog(@"The file %@ is not exist", plistPath);
        }
    }
    // Get data from plist file then add to object Data
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSPropertyListFormat format;
    NSError *errorDesc = nil;
    NSDictionary *propertyListDic = (NSDictionary*)[NSPropertyListSerialization propertyListWithData:plistXML options:NSPropertyListImmutable format:&format error:&errorDesc];
    
    // Check value of mater data
    if (propertyListDic) {
        return [propertyListDic valueForKey:keyName];
    }
    
    NSLog(@"Error reading plist: %@, format: %zd", errorDesc, format);
    return nil;
}

@end
