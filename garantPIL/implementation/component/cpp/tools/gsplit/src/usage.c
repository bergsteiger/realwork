#include <stdio.h>

#include "garver.h"
#include "../../../libs/mrglib/src/gdbapi.h"

void usage(void)
{
	printf("Usage: gsplit [-?h] [-o <path>] [-f set_spec_file] basename\n");
}

void help(void)
{
	printf("Usage: gsplit [options] basename\n");
	printf("Valid options are:\n");
	printf("\t-? or -h for help;\n");
	printf("\t-e to use messages in English (default is Russian)\n");
	printf("\t-o <path> to specify output bases path\n");
	printf("\t-f <filename> to specify set description filename\n");
	printf("\t-l <filename> to specify log filename\n");
	printf("\t-r <filename> to specify result filename\n");
	printf("\t-d <0..3> to specify debug info logging level\n\n");
	printf("Set description file format:\n");
	printf("   [{Kbytes} or {Kbytes-}]name:seg1 [seg2 [seg3 [...]]\n");
	printf("For Demo base:\n");
	printf("   or: {Demo}name:\n");
	printf("   or: {Demo}name:seg1 [seg2 [seg3[...]]\n");
	printf("   or: {Demo}name:seg1 [seg2[S] [seg3[S][...]] [<[PIC] [RTF] [XLS]]\n");
	printf("   or: {Demo}name:seg1 [seg2[S] [seg3[S][...]] [<ObjDocID_1 [ObjDocID_2][...]]\n");
	printf("   or: {Demo}name:&DocID_1 [DocID_2][...] [<ObjDocID_1 [ObjDocID_2][...]]\n");
	printf("   or: {Demo}name:&DocID_1 [DocID_2][...] [<[PIC] [RTF] [XLS]]\n");
	printf("where name is the output base name,\n");
	printf("      seg1...segN is the segment numbres included in set.\n");
	printf("\nNote 1: if set size in Kbytes specified,\n\tSecond subFiles - ignore.\n");
	printf("\nNote 2: if set description filename not specified,\n\tstandart input is assumed.\n");
	printf("\nNote 3: Result file, if specified, contains '0' as success flag.\n");
}

