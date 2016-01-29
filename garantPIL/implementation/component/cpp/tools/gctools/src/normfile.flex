%option noyywrap
%option nounput
%option prefix="gnf_"

%x COMMENT
%x SERROR
%x GETNORM


%{                   
	#include <stdio.h>
	#include <unistd.h>
	#include <string.h>
	#include "FString.SplaySet.h"
	#include "CaseString.defs.h"
	#include "norminfo.h"
	#include "gclog.h"
	#include "gardefs.h"
	static int cln;
	static NormInfo *normInfo;
	static char * normDefault;
	static int isDefault;
	static void doNorm();
%}

comment ^[#;].*
whitespace [ \t\r]
norm ^!NORM[ \t]+
normdefault ^!DEFAULT[ \t]+
normtext [^ \t\r\n]+[^\r\n]*[^ \t\r\n]
%%
<*>\r
<INITIAL>{comment} BEGIN(COMMENT);
<COMMENT>.+ ;
<COMMENT>\n cln++; gclog.setLN(cln); BEGIN(INITIAL);
<INITIAL>{whitespace}
<INITIAL>\n cln++; gclog.setLN(cln);
<INITIAL>{norm} { 
	isDefault = 0; 
	BEGIN(GETNORM); 
	}
<INITIAL>{normdefault} { 
	isDefault = 1; 
	BEGIN(GETNORM); }
<GETNORM>{normtext} {
	doNorm();
	}
<*>. 			yymore(); BEGIN(SERROR); 
<SERROR>.+ {
				gclog.setLN(cln);
				gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
					"Ошибка формата около ");
				gclog.printfCP(AdvLogger::CD_ALT, "'%s'\n", yytext );
			}
<SERROR>\n cln++; gclog.setLN(cln); BEGIN(INITIAL);
%%
void doNorm()
{
	if( yyleng < CATEGORY_KEY_SIZE ){
		if( !isDefault ){
			FString t(yytext);
			if( !normInfo->norms->contains( t ) ){
				normInfo->norms->add(t);
			}else{
				gclog.setLN(cln);
				gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, 
					"Название уже было.\n" );
			}
		}else{
			if( !normDefault ) {
				normDefault = strdup(yytext);
			}else{
				gclog.setLN(cln);
				gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, 
					"Название по умолчанию уже установлено.\n" );
			}
		}
	}else{
		gclog.setLN(cln);
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, 
			"Название длиннее %d символов.\n",
			CATEGORY_KEY_SIZE -1 );
	}
	BEGIN(COMMENT);
}

int readNormInfo(NormInfo *ni, const char *fn)
{
	yyin = fopen( fn, "r" );
	if( !yyin ){
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
			"Ошибка открытия файла норм/категорий\n");
		return 1;
	}
	gclog.setFileName( fn );
	normInfo = ni;
	normInfo->norms = new CaseStringSplaySet();
	normInfo->default_ = NULL;

	normDefault = NULL;
	cln = 1;
	gclog.setLN(1);
	yylex();
	fclose(yyin);
	if( normDefault ){
		normInfo->default_ = new FString(normDefault );
		free( normDefault );
		if( !normInfo->norms->contains( * normInfo->default_ ) ){
			gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
			"Значение по умолчанию не эталонное.\n");
		}
	}else{
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
			"Значение по умолчанию не установлено.\n");
		normInfo->default_ = new FString("***DEFAULT***");
	}
	return 0;
}
