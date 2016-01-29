%option noyywrap
%option nounput
%option prefix="gbel_"

%x COMMENT
%x BERROR
%x RNAME
%x ENAME
%x CODE
%x WEIGHT

%{
//#include "FString.long.SplayMap.h"
#include "CaseString.defs.h"
#include "gardefs.h"
#include "garcomp.h"
#include "gclog.h"
#include "belongs.h"

static int cln;
static FStringlongSplayMap *tm;
static signed int id;
static ThreadCompileInfo *inf;
static void getline(char *text, int leng, char* str);
%}

comment ^[#;].*
whitespace [ \t\r]

%%
<*>\r
<INITIAL>{comment} BEGIN(COMMENT);
<COMMENT>.+ ;
<COMMENT>\n cln++; gclog.setLN(cln); BEGIN(INITIAL);
<INITIAL>{whitespace}
<INITIAL>\n cln++; gclog.setLN(cln);
<INITIAL>[0-9]+ { 
		id = atoi(yytext); 
		if (!id) {
			gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
				"Идентификатор базы (BaseId) не может равняться 0\n");
			BEGIN(BERROR);
		}
		if (id > MAX_BASES) {
			gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
				"Идентификатор базы (BaseId) не может превосходить %d\n",
				MAX_BASES-1);
			BEGIN(BERROR);
		}
		if( id < 0 ){
			gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
				"Неверный идентификатор базы (BaseId)\n");
			BEGIN(BERROR);
		}
		BEGIN(CODE); 
	}
<CODE>{whitespace}
<CODE>[^ \t\r\n]+ {
		FString ucs(yytext);
		(*tm)[ucs] = id;
		BEGIN(WEIGHT);
	}
<WEIGHT>{whitespace}
<WEIGHT>[0-9]+ {
		inf->basesCore[id].weight = atoi(yytext);
		BEGIN(RNAME);
	}
<RNAME>{whitespace}
<RNAME>\|[^\|]+\| { 
			getline(yytext, yyleng, inf->basesCore[id].name); 
			BEGIN(ENAME); 
		}
<ENAME>{whitespace}
<ENAME>\|[^\|]+\| { 
			getline(yytext, yyleng, inf->basesCore[id].nameEng); 
			BEGIN(INITIAL); 
		}
<ENAME>\n {
			gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI, 
				"Отсутствует английское название для базы %d.\n", id);
			strcpy(inf->basesCore[id].nameEng, inf->basesCore[id].name);
			cln++;
			gclog.setLN(cln);
			BEGIN(INITIAL);
		}
<*>.      yymore(); BEGIN(BERROR);
<BERROR>.+ {
		gclog.setLN(cln);
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
			"Ошибка формата около ");
		gclog.printfCP(AdvLogger::CD_ALT, "'%s'\n", yytext );
	}
<BERROR>\n cln++; gclog.setLN(cln); BEGIN(INITIAL);

%%
void getline(char *text, int leng, char* str)
{
	if (leng > BASE_NAME_SIZE) {
		str[0] = 0;
		return;
	}
	strncpy(str, text+1, leng-2);
}
int readBelongsMap(const char * fn, ThreadCompileInfo *info)
{
	tm = info->belongsMap = new CaseStringlongSplayMap(0);
	inf = info;
	yyin = fopen(fn, "r");
	if( !yyin ){
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
			"Ошибка открытия файла описания баз (%s)\n", fn);
		return 1;
	}
	gclog.setFileName(fn);
	cln = 1;
	gclog.setLN(1);
	yylex();
	fclose(yyin);

	return 0;
}
