%option noyywrap
%option nounput
%option prefix="lsm_"

%x COMMENT
%x SOURCEKEEP
%x SERROR
%x GETEQSET


%{                   
	#include <stdio.h>
	#include <unistd.h>
	#include <string.h>
//	#include "FString.FString.SplayMap.h"
//	#include "FString.long.SplayMap.h"
//	#include "FString.SplaySet.h"
	#include "CaseString.defs.h"
	#include "gclog.h"
	#include "hnode.h"
	#include "gardefs.h"
	static int cln;
	static char *fullName, *stripName;
	static int fbpos, sbpos;
	static void finishName();
	static int theKeySize;
	static CaseStringCaseStringSplayMap *theMap;
	static HNode * mapTree;
	static int bIsFlushed;
	static unsigned char bWasFatal = 0;
// sourcepart [0-9]{3}=[^ \t\r\n\\][^\r\n\\:]*
%}

comment ^[#;].*
whitespace [ \t\r]
sourcepart [0-9]{3}=[^\t\r\n\\]*[^ \t\r\n\\]
%%
<*>\r
<INITIAL>{comment} BEGIN(COMMENT);
<COMMENT>.+ ;
<COMMENT>\n gclog.setLN(++cln); BEGIN(INITIAL);
<INITIAL>{whitespace}
<INITIAL>\n gclog.setLN(++cln);
<INITIAL>{sourcepart} { 			
						if( yyleng < theKeySize ){
							bIsFlushed =0;
							strcpy(fullName,yytext);
							fbpos = yyleng;
							strcpy(stripName, yytext+4);
							sbpos = yyleng-4;
							BEGIN(SOURCEKEEP);
						}else{
							gclog.setLN(cln);
							gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Раздел длиннее %d символов.\n",
								theKeySize -1 );
							BEGIN(COMMENT);
							bIsFlushed =1;
						}
					}
<SOURCEKEEP>\\
<SOURCEKEEP>{sourcepart} {
							if( yyleng < theKeySize ){
								fullName[fbpos++]='\\';
								strcpy(fullName+fbpos,yytext);
								fbpos += yyleng;
								stripName[sbpos++]='\\';
								strcpy(stripName+sbpos,yytext+4);
								sbpos+=yyleng-4;
							}else{
								gclog.setLN(cln);
								gclog.printfC(AdvLogger::LOG_ERROR, 
									AdvLogger::CD_KOI,
									"Раздел длиннее %d символов.\n",
									theKeySize -1 );
								BEGIN(COMMENT);
								bIsFlushed =1;
							}
						}
<SOURCEKEEP>[ \t]*\r?\n finishName(); gclog.setLN(++cln); BEGIN(INITIAL);
<*>. 			yymore(); BEGIN(SERROR); 
<SERROR>.+ {
				gclog.setLN(cln);
				gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
					"Ошибка формата около ");
				gclog.printfCP(AdvLogger::CD_ALT, "'%s'\n", yytext );
			}
<SERROR>\n cln++; gclog.setLN(cln); BEGIN(INITIAL);
%%

#include "garcomp.h"
#include <vector>

bool	ignore_folders = false;
extern	std::deque<std::string> errors;

void finishName()
{
	FString t(stripName);

	HNode * nnew = 0;
	HN_STATUS st = mapTree->addNode(t.chars(),nnew);

	if( (theMap->contains(t) || (st & INS_BRK)) && !ignore_folders)
	{
		gclog.setLN(cln);
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"Повторяющийся или неполный ключ ");
		gclog.printfCP(AdvLogger::CD_ALT,"'%s'\n",t.chars());
		t.bDoFree = 1;
		bIsFlushed =1;
		return;
	}

	if ((st & INS_CONT) && !ignore_folders)
	{
		HNode * p = 0;
		for (p = nnew->parent; !p->bIsFinal; p = p->parent);
		FString bad(p->path());
		theMap->del(bad);
		gclog.setLN((int)(p->p));
		p->bIsFinal = 0;
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"Повторяющийся или неполный ключ ");
		gclog.printfCP(AdvLogger::CD_ALT,"'%s'\n",bad.chars());
	}

	if (st & INS_CASE)
	{
		gclog.setLN(cln);
		gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_WIN,"мЕБЕПМШИ ПЕЦХЯРП. нДХМ ХГ СГКНБ ЯРПНЙХ НОПЕДЕКЕМ Б ДПСЦНЛ ПЕЦХЯРПЕ: ");
		gclog.printfCP(AdvLogger::CD_ALT,"'%s'\n",t.chars());
		bWasFatal = 1;
		bIsFlushed =1;
		return;
	}

	FString f(fullName);
 	(*theMap)[t]=f;

	bIsFlushed =1;
}

int loadStringMap(CaseStringCaseStringSplayMap *m, const char *fn, int maxKeyLength, bool b_ignore_folders = false)
{
	yyin = fopen( fn, "r" );
	if( !yyin ){
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
			"Ошибка открытия файла %s\n", fn);
		return 1;
	}
	gclog.setFileName( fn );
	theKeySize = maxKeyLength;
	theMap = m;

	mapTree = new HNode;

	fullName = (char*)malloc(8192);
	stripName = (char*)malloc(8192);
	fbpos = sbpos =0;
	cln = 1;
	gclog.setLN(1);
	bIsFlushed = 0;
	ignore_folders = b_ignore_folders;
	BEGIN(INITIAL);
	yylex();
	ignore_folders = false;

	if( !bIsFlushed ){
		finishName();		
	}

	fclose(yyin);
	free( fullName );
	free( stripName );
	delete mapTree;
	if (bWasFatal) exit (1);
	return 0;
}
