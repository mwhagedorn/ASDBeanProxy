//
// Created by Mike Hagedorn on 8/15/14.
// Copyright (c) 2014 appsdynamic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Bean-iOS-OSX-SDK/PTDBeanManager.h>

extern NSString *const ASDBeanFoundNotification;

@interface ASDBeanProxy : NSObject <PTDBeanManagerDelegate>

@property(weak, nonatomic) id delegate;
@property(nonatomic, readonly) NSArray *connectedBeans;

@end