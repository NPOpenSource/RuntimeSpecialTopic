//
//  ViewController.m
//  Mach-o-parse
//
//  Created by 温杰 on 2018/4/19.
//  Copyright © 2018年 温杰. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

typedef struct mach_new_header {
    uint32_t    magic;        /* mach magic number identifier */
    uint32_t    cputype;    /* cpu specifier */
    uint16_t    cpusubtype;    /* machine specifier */
    uint8_t     zhanwei;
    uint8_t     caps;
    uint32_t    filetype;    /* type of file */
    uint32_t    ncmds;        /* number of load commands */
    uint32_t    sizeofcmds;    /* the size of all the load commands */
    uint32_t    flags;        /* flags */
    uint32_t    reserved;
} Mach_O_Header;

void printHeader(Mach_O_Header header){
    NSLog(@"header magic 0x%0x",header.magic);
    NSLog(@"header cputype %d",header.cputype);
    NSLog(@"header cpusubtype %d",header.cpusubtype);
    NSLog(@"header caps 0x%x",header.caps);
    NSLog(@"header filetype %d",header.filetype);
    NSLog(@"header ncmds %d",header.ncmds);
    NSLog(@"header sizeofcmds %d",header.sizeofcmds);
    NSLog(@"header flags 0x%0x",header.flags);
}

typedef struct  {
    uint32_t cmd;       /* type of load command */
    uint32_t cmdsize;   /* total size of command in bytes */
}Mach_O_load_command;


void printLoadCommand(Mach_O_load_command loadCommand){
    NSLog(@"loadCommand cmd 0x%0x",loadCommand.cmd);
    NSLog(@"loadCommand cmdsize %0d",loadCommand.cmdsize);
}
typedef struct  { /* for 64-bit architectures */
    char        segname[16];    /* segment name */
    uint64_t    vmaddr;        /* memory address of this segment */
    uint64_t    vmsize;        /* memory size of this segment */
    uint64_t    fileoff;    /* file offset of this segment */
    uint64_t    filesize;    /* amount to map from the file */
    uint32_t    maxprot;    /* maximum VM protection */
    uint32_t    initprot;    /* initial VM protection */
    uint32_t    nsects;        /* number of sections in segment */
    uint32_t    flags;        /* flags */
}Mach_O_segment_command;

void printSegment_command(Mach_O_segment_command segmentCommand){
    NSLog(@"segmentCommand segname %s",segmentCommand.segname);
    NSLog(@"segmentCommand vmaddr 0x%llx",segmentCommand.vmaddr);
    NSLog(@"segmentCommand vmsize %llu",segmentCommand.vmsize);
    NSLog(@"segmentCommand fileoff 0x%llx",segmentCommand.fileoff);
    NSLog(@"segmentCommand filesize %llu",segmentCommand.filesize);
    NSLog(@"segmentCommand maxprot 0x%x",segmentCommand.maxprot);
    NSLog(@"segmentCommand initprot 0x%x",segmentCommand.initprot);
    NSLog(@"segmentCommand nsects %d",segmentCommand.nsects);
    NSLog(@"segmentCommand flags 0x%x",segmentCommand.flags);

}


typedef struct  { /* for 64-bit architectures */
    char        sectname[16];    /* name of this section */
    char        segname[16];    /* segment this section goes in */
    uint64_t    addr;        /* memory address of this section */
    uint64_t    size;        /* size in bytes of this section */
    uint32_t    offset;        /* file offset of this section */
    uint32_t    align;        /* section alignment (power of 2) */
    uint32_t    reloff;        /* file offset of relocation entries */
    uint32_t    nreloc;        /* number of relocation entries */
    uint32_t    flags;        /* flags (section type and attributes)*/
    uint32_t    reserved1;    /* reserved (for offset or index) */
    uint32_t    reserved2;    /* reserved (for count or sizeof) */
    uint32_t    reserved3;    /* reserved */
}Mach_O_section;

void printSection_command(Mach_O_section sectionCommand){
    NSLog(@"sectionCommand secname %s",sectionCommand.sectname);
    NSLog(@"sectionCommand segname %s",sectionCommand.segname);
    NSLog(@"sectionCommand addr 0x%llx",sectionCommand.addr);
    NSLog(@"sectionCommand size %llu",sectionCommand.size);
    NSLog(@"sectionCommand offset %d",sectionCommand.offset);
    NSLog(@"sectionCommand align %d",sectionCommand.align);
    NSLog(@"sectionCommand reloff %d",sectionCommand.reloff);
    NSLog(@"sectionCommand nreloc %d",sectionCommand.nreloc);
    NSLog(@"sectionCommand flags %d",sectionCommand.flags);
}


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     NSData *mach = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"out"]];
    static int location =0;
    Mach_O_Header  header ;
    [mach getBytes:&header range:NSMakeRange(0, sizeof(Mach_O_Header))];
    location =sizeof(Mach_O_Header);
    printHeader(header);

    for (int i=0; i<header.ncmds; i++) {
        Mach_O_load_command loadCommand;
        Mach_O_segment_command segment;
        [mach getBytes:&loadCommand range:NSMakeRange(location, sizeof(Mach_O_load_command))];
        location+=sizeof(Mach_O_load_command);
        printLoadCommand(loadCommand);
       
        NSUInteger length = loadCommand.cmdsize;
        length-=8;
      
        [mach getBytes:&segment range:NSMakeRange(location, sizeof(Mach_O_segment_command))];
        location+=sizeof(Mach_O_segment_command);
            printSegment_command(segment);
        length-=sizeof(Mach_O_segment_command);
        
        if (length>0) {
            Mach_O_section section ;
            [mach getBytes:&section range:NSMakeRange(location, sizeof(Mach_O_section))];
            location+=sizeof(Mach_O_section);
            printSection_command(section);
            length-=sizeof(Mach_O_section);
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
