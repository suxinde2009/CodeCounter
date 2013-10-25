//
//  AppDelegate.h
//  CodeCounter
//
//  Created by su xinde on 13-10-25.
//  Copyright (c) 2013年 su xinde. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow    *window;
@property (assign) IBOutlet NSTextField *finderPathField;
@property (assign) IBOutlet NSTextField *outPutField;
@property (assign) BOOL     isAllSelected;
@property (assign) IBOutlet NSButton    *cb_h;
@property (assign) IBOutlet NSButton    *cb_m;
@property (assign) IBOutlet NSButton    *cb_mm;
@property (assign) IBOutlet NSButton    *cb_c;
@property (assign) IBOutlet NSButton    *cb_cc;
@property (assign) IBOutlet NSButton    *cb_cpp;
@property (assign) IBOutlet NSButton    *cb_hpp;
@property (assign) IBOutlet NSButton    *cb_java;

- (IBAction)selectAllAction:(id)sender;
- (IBAction)getCodeLineNum:(id)sender;

@end
