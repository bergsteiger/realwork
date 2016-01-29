/*
 * $Id: gcini.h,v 2.33 2015/02/09 12:32:11 young Exp $
 */

#ifndef _gcini_h
#define _gcinit_h


#include "osdep.h"
class FStringSplaySet;

struct GCParameters
{
	struct {
		int nbelongs;
		int16_t *belongs;
		int nbelongs_i;
		int16_t *belongs_i;
	} here_info;
	char * belongsMapFile;
	char * weightsTableFile;
	char * classFile;
	char * kindFile;
	char * serviceInfoFile;

	char*	inpharmFirmsFile;
	char*	inpharmAtcsFile;
	char*	inpharmRegStatusesFile;
	char*	inpharmLekFormsFile;
	char*	inpharmCountriesFile;
	char*	inpharmPharmGroupsFile;
	char*	inpharmPharmEffectsFile;
	char*	inpharmChaptersFile;
	char*	inpharmMkbsFile;

	char * annoUserFile;
	char * annoOrganizationFile;
	char * annoTaxFile;
	char * annoInterestFile;
	char * annoKindFile;
	char * kwFile;
	char * outName;
	char * revDate;
	char * iniSatDate;
	char * iniTodayDate;
	char * iniMaxDate;
	char * typesFile;
	char * territoryFile;
	char * sourcesFile;
	char * pubSourceFile;
	char * warningsFile;
	char * normFile;
	char * priorityTableFile;
	char * objTypesFile;
	char * objRoot;
	char * outRTFile;
	char * outOFile;
	FStringSplaySet *inRTFile;
	FStringSplaySet *inOFile;
	int  mfCompress;
	int  ndtCompress;
	int  do_stdout;
	int  ref_table_gen;
	int  obj_table_gen;
	int  ref_doc_check;
	int  iniSbrf;
	int  ref_vincluded_check;
	int  fatal_ifnotinbelongs;
	int  name_len_check;
	int  text_command_check;
	int  print_prefix_ex;
	int  sub_title_check;
	int  extrn_ref_fatal;
	int  printRU;
	char *catFile;
	char *logFile;
	char *logEncoding;

	short	TopicRanges;
	int32_t*	LoTopicRanges;
	int32_t*	HiTopicRanges;
};

int readParams(GCParameters *p, FILE *f );
#endif
