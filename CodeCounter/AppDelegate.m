//
//  AppDelegate.m
//  CodeCounter
//
//  Created by su xinde on 13-10-25.
//  Copyright (c) 2013年 su xinde. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

- (int)rows:(NSString *)filePath;

@end

@implementation AppDelegate

@synthesize window;
@synthesize finderPathField;
@synthesize outPutField;
@synthesize cb_h;
@synthesize cb_m;
@synthesize cb_mm;
@synthesize cb_c;
@synthesize cb_cc;
@synthesize cb_cpp;
@synthesize cb_hpp;
@synthesize cb_java;
@synthesize isAllSelected;

#pragma mark -
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    isAllSelected = FALSE;
    [self selectAllAction:nil];
    
}

#pragma mark - customized methods

- (int)rows:(NSString *)filepath
{
    char c;
    int  h = 0;
    FILE *fp;
    
    fp = fopen([filepath UTF8String], "r");
    
    if (fp == NULL)
        return -1;
    
    while ((c = fgetc(fp)) != EOF) {
        if (c == '\n')
        {
            h++;
        } else {
            c = fgetc(fp);//这里处理最后一行可能没有换行标记
            if (c == EOF){
                h++;
                break;
            } else if (c == '\n') {
                h++;
            }
        }
    }
    
    fclose(fp);
    
    return h;
}

- (IBAction)selectAllAction:(id)sender
{
    isAllSelected = !isAllSelected;
    
    [cb_h setState:isAllSelected];
    [cb_c setState:isAllSelected];
    [cb_cpp setState:isAllSelected];
    [cb_cc setState:isAllSelected];
    [cb_hpp setState:isAllSelected];
    [cb_java setState:isAllSelected];
    [cb_m setState:isAllSelected];
    [cb_mm setState:isAllSelected];
    
}

- (IBAction)getCodeLineNum:(id)sender
{

    //获取路径
    NSString *path = [finderPathField stringValue];
    NSLog(@"文件路径%@", path);
    //检查文件是否存在
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if ([filemanager fileExistsAtPath:path]) {
        //获取路径
        int num = 0;
        NSArray *arr = [self getAllDirsInPath:path];
        
        for (NSString *inpath in arr) {
            num += [self rows:inpath];
        }
        NSLog(@"%d", num);
        [self.outPutField setStringValue:[NSString stringWithFormat:@"总行数: %d", num]];
    } else {
        [self.outPutField setStringValue:@"请输入正确的路径"];
    }
    
}

- (BOOL)checkFileType:(NSString *)path
{
    NSString *extensionName = [path pathExtension];
    NSLog(@"后缀名%@", extensionName);
    if (self.cb_h.state == NSOnState && [extensionName isEqualToString:@"h"])
        return YES;
    if (self.cb_m.state == NSOnState && [extensionName isEqualToString:@"m"])
        return YES;
    if (self.cb_mm.state == NSOnState && [extensionName isEqualToString:@"mm"])
        return YES;
    if (self.cb_c.state == NSOnState && [extensionName isEqualToString:@"c"])
        return YES;
    if (self.cb_cc.state == NSOnState && [extensionName isEqualToString:@"cc"])
        return YES;
    if (self.cb_cpp.state == NSOnState && [extensionName isEqualToString:@"cpp"])
        return YES;
    if (self.cb_hpp.state == NSOnState && [extensionName isEqualToString:@"hpp"])
        return YES;
    if (self.cb_java.state == NSOnState && [extensionName isEqualToString:@"java"])
        return YES;
    return NO;
}

- (NSArray *)getAllDirsInPath:(NSString *)inputPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableArray *dirArray = [NSMutableArray arrayWithCapacity:0];
    BOOL isDir = NO;
    [fileManager fileExistsAtPath:inputPath isDirectory:(&isDir)];
    if(isDir == NO){
        if([self checkFileType:inputPath])
            [dirArray addObject:inputPath];
        
        return dirArray;
    }
    
    isDir = NO;
    
    NSError *error = nil;
    NSArray *fileList = nil;
    
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
	fileList = [fileManager contentsOfDirectoryAtPath:inputPath error:&error];
    
    //在上面那段程序中获得的fileList中列出文件夹名
	for (NSString *file in fileList) {
		NSString *path = [inputPath stringByAppendingPathComponent:file];
		[fileManager fileExistsAtPath:path isDirectory:(&isDir)];
		if (!isDir) {
            if ([self checkFileType:path])
                [dirArray addObject:path];
		} else {
            [dirArray addObjectsFromArray:[self getAllDirsInPath:path]];
        }
		isDir = NO;
	}
	return dirArray;
}


#pragma mark - dealloc
- (void)dealloc
{
    [super dealloc];
}


@end
