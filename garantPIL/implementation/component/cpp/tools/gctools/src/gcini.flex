%option noyywrap
%option nounput
%option case-insensitive
%option prefix="gini_"

%x COMMENT
%x PARSEERROR
%x GENERIC
%x WARNINGS
%x GETREST_NO_WS_STR
%x GETINRTF
%x GETREST_SINGLE_NUMBER
%x GETREST_SINGLE_BOOL
%x GET_BELONGS
%x GET_IBELONGS


%{                   
	#include <stdio.h>
	#include <string.h>
	#include "gcini.h"
	#include "gclog.h"
	#include "garcomp.h"
	#include "FString.SplaySet.h"

	static void *target;
	static GCParameters *theParams;
	static int backTo = 0;
	static int lastBelong = 0;
	static int belongsLength = 0;
	static int16_t *belongs = NULL;
	static int lastBelong_i = 0;
	static int belongsLength_i = 0;
	static int16_t *belongs_i = NULL;
	static int cln;
	static FStringSplaySet **rttbl;
%}

comment ^[#;].+
ws [ \t\r]
generic "[Generic]"
%%
<*>\r
<*>{comment} { if( backTo != COMMENT ) backTo=YYSTATE; BEGIN(COMMENT); }
<COMMENT>.+ ;
<COMMENT>\n gclog.setLN(cln++); BEGIN(backTo);
<INITIAL>{ws}+
<INITIAL>[ \t]*{generic}[ \t]* BEGIN(GENERIC);
<GENERIC>^ClassFile[ \t]*=[ \t]* { 
							 target = &(theParams->classFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^KindFile[ \t]*=[ \t]* { 
							 target = &(theParams->kindFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^BelongFile[ \t]*=[ \t]* { 
							 target = &(theParams->belongsMapFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^ComplectInfo[ \t]*=[ \t]* { 
							 target = &(theParams->weightsTableFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^KeywordFile[ \t]*=[ \t]* { 
							 target = &(theParams->kwFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^PublicationSourceFile[ \t]*=[ \t]* { 
							 target = &(theParams->pubSourceFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^OutFiles[ \t]*=[ \t]* { 
							 target = &(theParams->outName);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^ObjTypesFile[ \t]*=[ \t]* { 
							 target = &(theParams->objTypesFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^ObjectRootPath[ \t]*=[ \t]* { 
							 target = &(theParams->objRoot);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^RevisionDate[ \t]*=[ \t]* { 
							 target = &(theParams->revDate);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^SatDate[ \t]*=[ \t]* { 
							 target = &(theParams->iniSatDate);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^TodayDate[ \t]*=[ \t]* { 
							 target = &(theParams->iniTodayDate);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^MaxDate[ \t]*=[ \t]* { 
							 target = &(theParams->iniMaxDate);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^Sbrf[ \t]*=[ \t]* { 
							 target = &(theParams->iniSbrf);
							 backTo = GENERIC;
							 BEGIN(GETREST_SINGLE_BOOL);
							}
<GENERIC>^SourcesFile[ \t]*=[ \t]* { 
							 target = &(theParams->sourcesFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^TypesFile[ \t]*=[ \t]* { 
							 target = &(theParams->typesFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^ServiceInfoFile[ \t]*=[ \t]* { 
							 target = &(theParams->serviceInfoFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^InpharmFirmsFile[ \t]*=[ \t]* { 
							 target = &(theParams->inpharmFirmsFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^InpharmCountriesFile[ \t]*=[ \t]* { 
							 target = &(theParams->inpharmCountriesFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^InpharmPharmGroupsFile[ \t]*=[ \t]* { 
							 target = &(theParams->inpharmPharmGroupsFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^InpharmPharmEffectsFile[ \t]*=[ \t]* { 
							 target = &(theParams->inpharmPharmEffectsFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^InpharmMkbsFile[ \t]*=[ \t]* { 
							 target = &(theParams->inpharmMkbsFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^InpharmChaptersFile[ \t]*=[ \t]* { 
							 target = &(theParams->inpharmChaptersFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^InpharmAtcsFile[ \t]*=[ \t]* { 
							 target = &(theParams->inpharmAtcsFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^InpharmRegStatusesFile[ \t]*=[ \t]* { 
							 target = &(theParams->inpharmRegStatusesFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^InpharmLekFormsFile[ \t]*=[ \t]* { 
							 target = &(theParams->inpharmLekFormsFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^AnnoUserFile[ \t]*=[ \t]* { 
							 target = &(theParams->annoUserFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^AnnoOrganizationFile[ \t]*=[ \t]* { 
							 target = &(theParams->annoOrganizationFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^AnnoTaxFile[ \t]*=[ \t]* { 
							 target = &(theParams->annoTaxFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^AnnoInterestFile[ \t]*=[ \t]* { 
							 target = &(theParams->annoInterestFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^AnnoKindFile[ \t]*=[ \t]* { 
							 target = &(theParams->annoKindFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^TerritoryFile[ \t]*=[ \t]* { 
							 target = &(theParams->territoryFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^WarningsFile[ \t]*=[ \t]* { 
							 target = &(theParams->warningsFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^NormFile[ \t]*=[ \t]* { 
							 target = &(theParams->normFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^CatFile[ \t]*=[ \t]* { 
							 target = &(theParams->catFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^LogFile[ \t]*=[ \t]* { 
							 target = &(theParams->logFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^PriorityTableFile[ \t]*=[ \t]* { 
							 target = &(theParams->priorityTableFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^InReferenceTableFile[ \t]*=[ \t]* { 
							 backTo = GENERIC;
							 rttbl = & (theParams->inRTFile );
							 BEGIN(GETINRTF);
							}
<GENERIC>^InObjectTableFile[ \t]*=[ \t]* { 
							 backTo = GENERIC;
							 rttbl = & (theParams->inOFile );
							 BEGIN(GETINRTF);
							}
<GENERIC>^OutReferenceTableFile[ \t]*=[ \t]* { 
							 target = &(theParams->outRTFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^GenerateRefTable[ \t]*=[ \t]* { 
							 target = &(theParams->ref_table_gen);
							 backTo = GENERIC;
							 BEGIN(GETREST_SINGLE_BOOL);
							}
<GENERIC>^OutObjectTableFile[ \t]*=[ \t]* { 
							 target = &(theParams->outOFile);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^GenerateObjectTable[ \t]*=[ \t]* { 
							 target = &(theParams->obj_table_gen);
							 backTo = GENERIC;
							 BEGIN(GETREST_SINGLE_BOOL);
							}

<GENERIC>^FatalExternReference[ \t]*=[ \t]* { 
							 target = &(theParams->extrn_ref_fatal);
							 backTo = GENERIC;
							 BEGIN(GETREST_SINGLE_BOOL);
							}
<GENERIC>^LogEncoding[ \t]*=[ \t]* { 
							 target = &(theParams->logEncoding);
							 backTo = GENERIC;
							 BEGIN(GETREST_NO_WS_STR);
							}
<GENERIC>^BelongsList[ \t]*=[ \t]* { 
							 backTo = GENERIC;
							 BEGIN(GET_BELONGS);
							}
<GENERIC>^IgnoreBelongsList[ \t]*=[ \t]* { 
							 backTo = GENERIC;
							 BEGIN(GET_IBELONGS);
							}
<GENERIC>^MFCompressLevel[ \t]*=[ \t]* { 
							 target = &(theParams->mfCompress);
							 backTo = GENERIC;
							 BEGIN(GETREST_SINGLE_NUMBER);
							}
<GENERIC>^EnableStdout[ \t]*=[ \t]* { 
							 target = &(theParams->do_stdout);
							 backTo = GENERIC;
							 BEGIN(GETREST_SINGLE_BOOL);
							}
<GENERIC>^CheckReference[ \t]*=[ \t]* { 
							 target = &(theParams->ref_doc_check);
							 backTo = GENERIC;
							 BEGIN(GETREST_SINGLE_BOOL);
							}
<GENERIC>^CheckVIncluded[ \t]*=[ \t]* { 
							 target = &(theParams->ref_vincluded_check);
							 backTo = GENERIC;
							 BEGIN(GETREST_SINGLE_BOOL);
							}
<GENERIC>^FatalIfNotInBelongsList[ \t]*=[ \t]* { 
							 target = &(theParams->fatal_ifnotinbelongs);
							 backTo = GENERIC;
							 BEGIN(GETREST_SINGLE_BOOL);
							}
<GENERIC>^CheckNameLength[ \t]*=[ \t]* { 
							 target = &(theParams->name_len_check);
							 backTo = GENERIC;
							 BEGIN(GETREST_SINGLE_BOOL);
							}
<GENERIC>^CheckTextCommand[ \t]*=[ \t]* {
								target = &(theParams->text_command_check);
								backTo = GENERIC;
								BEGIN(GETREST_SINGLE_BOOL);
							}
<GENERIC>^PrintPrefixExInfo[ \t]*=[ \t]* {
								target = &(theParams->print_prefix_ex);
								backTo = GENERIC;
								BEGIN(GETREST_SINGLE_BOOL);
							}
<GENERIC>^CheckUntitledSubs[ \t]*=[ \t]* {
								target = &(theParams->sub_title_check);
								backTo = GENERIC;
								BEGIN(GETREST_SINGLE_BOOL);
							}
<GENERIC>^NDTCompress[ \t]*=[ \t]* { 
							 target = &(theParams->ndtCompress);
							 backTo = GENERIC;
							 BEGIN(GETREST_SINGLE_BOOL);
							}
<GENERIC>^HideInfoMessages[ \t]*=[ \t]* { 
							 target = &(gclog.bHideInfoMessages);
							 backTo = GENERIC;
							 BEGIN(GETREST_SINGLE_BOOL);
							}
<GENERIC>^TopicsLo[ \t]*=[ \t]* { 
	theParams->TopicRanges++;
	theParams->LoTopicRanges = (int32_t*) realloc( theParams->LoTopicRanges, sizeof(int32_t) * theParams->TopicRanges );
	target = &theParams->LoTopicRanges[ theParams->TopicRanges-1 ];
	backTo = GENERIC;
	BEGIN(GETREST_SINGLE_NUMBER);
}
<GENERIC>^TopicsHi[ \t]*=[ \t]* { 
	theParams->HiTopicRanges = (int32_t*) realloc( theParams->HiTopicRanges, sizeof(int32_t) * theParams->TopicRanges );
	target = &theParams->HiTopicRanges[ theParams->TopicRanges-1 ];
	backTo = GENERIC;
	BEGIN(GETREST_SINGLE_NUMBER);
}
<GENERIC>\n gclog.setLN(cln++);
<GETREST_SINGLE_BOOL>{ws}+
<GETREST_SINGLE_BOOL>on|yes|1 { *(int*)target = 1; BEGIN(COMMENT); }
<GETREST_SINGLE_BOOL>off|no|0 { *(int*)target = 0; BEGIN(COMMENT); }
<GETREST_SINGLE_NUMBER>{ws}+
<GETREST_SINGLE_NUMBER>[0-9]+ { *(int*)target = atoi(yytext); BEGIN(COMMENT); }
<GET_BELONGS>[ \t,\r]+
<GET_BELONGS>[0-9]+ {
						if( lastBelong >= belongsLength ){
							belongsLength += 20;
							belongs = (int16_t*) realloc(belongs, 
									sizeof(int16_t) * belongsLength);
						}
						belongs[lastBelong++]=atoi(yytext);
					}
<GET_BELONGS>\n {
					belongs = (int16_t*) realloc(belongs,
									sizeof(int16_t) * lastBelong);
					theParams->here_info.nbelongs = lastBelong;
					theParams->here_info.belongs = belongs;
					gclog.setLN(cln++); BEGIN(GENERIC);
				}
<GET_IBELONGS>[ \t,\r]+
<GET_IBELONGS>[0-9]+ {
						if( lastBelong_i >= belongsLength_i ){
							belongsLength_i += 20;
							belongs_i = (int16_t*) realloc(belongs_i, 
									sizeof(int16_t) * belongsLength_i);
						}
						belongs_i[lastBelong_i++]=atoi(yytext);
					}
<GET_IBELONGS>\n {
					belongs_i = (int16_t*) realloc(belongs_i,
									sizeof(int16_t) * lastBelong_i);
					theParams->here_info.nbelongs_i = lastBelong_i;
					theParams->here_info.belongs_i = belongs_i;
					gclog.setLN(cln++); BEGIN(GENERIC);
				}
<GETINRTF>[ \t\r]+
<GETINRTF>[^ \t\r\n]+ { 
						if( !*rttbl ){
							*rttbl = new FStringSplaySet();
						}
						FString s(yytext);
						if( (*rttbl)->contains(s) ){
							gclog.printfC(
								AdvLogger::LOG_WARNING_MPCXC,
								AdvLogger::CD_KOI,
								"рПЧФПТСАЭЙКУС ЖБКМ ЧОЕЫОЙИ УУЩМПЛ %s\n",
								yytext
								);
						}else{
							(*rttbl)->add(s);
						}
						BEGIN(COMMENT);
					}
<GETREST_NO_WS_STR>[ \t\r]+
<GETREST_NO_WS_STR>[^ \t\r\n]+ { 
								*(char **)target = strdup(yytext);
								BEGIN(COMMENT);
							}

<*>. 		{
				if( backTo != COMMENT ) backTo=YYSTATE;
				yymore(); BEGIN(PARSEERROR); 
			}
<PARSEERROR>.+ {
				gclog.printfC(
					AdvLogger::LOG_ERROR,
					AdvLogger::CD_KOI,
					"пЫЙВЛБ УЙОФБЛУЙУБ ТСДПН У '%s'\n", yytext ); 
			}
<PARSEERROR>\n gclog.setLN(cln++); BEGIN(backTo);
<INITIAL>\n gclog.setLN(cln++);;
<*>[\n] {
				gclog.printfC(
					AdvLogger::LOG_WARNING_MPCXC,
					AdvLogger::CD_KOI,
					"оЕПЦЙДБООЩК ЛПОЕГ УФТПЛЙ\n"); 
				BEGIN(backTo);
				gclog.setLN(cln++);
			}
%%

int readParams(GCParameters *p, FILE *f )
{
	theParams = p;

	gclog.setFileName("gc.ini");
	gclog.setLogName("gc.ini.log",1);

	gclog.noHdr();
	gclog.printfC(AdvLogger::LOG_INFO_MPCXC,AdvLogger::CD_WIN, "Компилятор приступает к считыванию файла конфигурации <gcini>\n");
	gclog.noHdr();
	gclog.printfC(AdvLogger::LOG_INFO_MPCXC,AdvLogger::CD_WIN, "При обнаружении ошибок в этом файле компилятор выведет сообщения на экран и в лог-файл gc.ini.log\n");
	gclog.noHdr();
	gclog.printfC(AdvLogger::LOG_INFO_MPCXC,AdvLogger::CD_WIN, "Если ошибок не обнаружится, то файл останется пустым\n");

	cln = 1;
	yyin = f;
	yylex();
	return 0;
}
