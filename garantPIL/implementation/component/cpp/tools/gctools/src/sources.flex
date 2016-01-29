%option noyywrap
%option nounput
%option prefix="gsrc_"

%x COMMENT
%x SOURCEKEEP
%x SERROR
%x SUFFIXGET
%x SUFFIXFIND
%x GETEQSET


%{                   
	#include <stdio.h>
	#include <vector>
	#include <unistd.h>
	#include <string.h>
//	#include "FString.FString.SplayMap.h"
//	#include "FString.long.SplayMap.h"
//	#include "FString.SplaySet.h"
	#include "CaseString.defs.h"
	#include "sources.h"
	#include "hnode.h"
	#include "gclog.h"
	#include "gardefs.h"
	static int cln;
	static char *fullsrc, *stripsrc;
	static int fbpos, sbpos;
	static SourcesInfo *pSI;
	static struct SourcesInfo::SourceInfo *sinfo = NULL;
	static int nInSources = 0;
	static int maxInSources = 0;
	static unsigned char isDefaultTer;
	static unsigned char isSrcFlushed;
	static HNode * srcTree;
	static void finishSource();
	static unsigned char bWasFatal = 0;

	extern	std::deque<std::string> errors;
%}

comment ^[#;].*
whitespace [ \t\r]
sourcepart [0-9]{3}=[^ \t\r\n\\][^\r\n\\\|]*
suffixpart [^ \t\r\n]+[^\r\n]*[^ \t\r\n]
%%
<*>\r
<INITIAL>{comment} BEGIN(COMMENT);
<COMMENT>.+ ;
<COMMENT>\n cln++; gclog.setLN(cln); BEGIN(INITIAL);
<INITIAL>{whitespace}
<INITIAL>\n cln++; gclog.setLN(cln);
<INITIAL>{sourcepart} {
						isSrcFlushed = 0;
						isDefaultTer=0;
						if( yyleng < ADOPTED_KEY_SIZE ){
							strcpy(fullsrc,yytext);
							fbpos = yyleng;
							strcpy(stripsrc, yytext+4);
							sbpos = yyleng-4;
							BEGIN(SOURCEKEEP);
						}else{
							gclog.setLN(cln);
							gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Раздел длиннее %d символов.\n",
								ADOPTED_KEY_SIZE -1 );
							BEGIN(COMMENT);
						}
					}
<SOURCEKEEP>\\
<SOURCEKEEP>{sourcepart} {
							if( yyleng < ADOPTED_KEY_SIZE ){
								fullsrc[fbpos++]='\\';
								strcpy(fullsrc+fbpos,yytext);
								fbpos += yyleng;
								stripsrc[sbpos++]='\\';
								strcpy(stripsrc+sbpos,yytext+4);
								sbpos+=yyleng-4;
							}else{
								gclog.setLN(cln);
								gclog.printfC (errors, AdvLogger::LOG_ERROR, 
									AdvLogger::CD_KOI,
									"Раздел длиннее %d символов.\n",
									ADOPTED_KEY_SIZE -1 );
								BEGIN(COMMENT);
							}
						}
<SOURCEKEEP>\|   isDefaultTer = 1; BEGIN(SUFFIXFIND);
<SOURCEKEEP>\n   finishSource(); isSrcFlushed = 1; BEGIN(INITIAL);
<SUFFIXFIND>{whitespace}
<SUFFIXFIND>{suffixpart} finishSource(); isSrcFlushed = 1; BEGIN(COMMENT);
<*>. 			yymore(); BEGIN(SERROR); 
<SERROR>.+ {
				gclog.setLN(cln);
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
					"Ошибка формата около ");
				gclog.printfCP(AdvLogger::CD_ALT, "'%s'\n", yytext );
			}
<SERROR>\n cln++; gclog.setLN(cln); BEGIN(INITIAL);
%%

#include "garcomp.h"

void finishSource()
{
	if( nInSources >= maxInSources )
	{
		maxInSources+= 200;
		sinfo = (SourcesInfo::SourceInfo *) realloc( sinfo, maxInSources*sizeof(SourcesInfo::SourceInfo));
	}

	FString t(stripsrc);

	HNode * nnew = 0;
	HN_STATUS st = srcTree->addNode(t.chars(),nnew);

	if( pSI->sm->contains(t) || (st & INS_BRK))
	{
		gclog.setLN(cln);
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"Повторяющийся или неполный ключ ");
		gclog.printfCP(AdvLogger::CD_ALT,"'%s'\n",t.chars());
		t.bDoFree = 1;
		return;
	}

	if (st & INS_CONT)
	{
		HNode * p = 0;
		for (p = nnew->parent; !p->bIsFinal; p = p->parent);
		FString bad(p->path());
		pSI->sm->del(bad);
		gclog.setLN((int)(p->p));
		p->bIsFinal = 0;
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"Повторяющийся или неполный ключ ");
		gclog.printfCP(AdvLogger::CD_ALT,"'%s'\n",bad.chars());
	}

	if (st & INS_CASE)
	{
		gclog.setLN(cln);
		gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_WIN,"мЕБЕПМШИ ПЕЦХЯРП. нДХМ ХГ СГКНБ ЯРПНЙХ НОПЕДЕКЕМ Б ДПСЦНЛ ПЕЦХЯРПЕ: ");
		gclog.printfCP(AdvLogger::CD_ALT,"'%s'\n",t.chars());
		bWasFatal = 1;
		return;
	}

	(*(pSI->sm))[t] = nInSources;
	sinfo[nInSources].sourceName = (char *)malloc(fbpos+1);
	memcpy(sinfo[nInSources].sourceName,fullsrc,fbpos+1);
	sinfo[nInSources].nameLength = fbpos+1;
	sinfo[nInSources].territoryN = new u_int32_tSplaySet;
	if (isDefaultTer)
	{
		char* p = strdup(yytext), * q = strchr(p,'|');
		char* p1 = p;

		for ( ; ; )
		{
			char * q = strchr(p,'|');
			FString tt(p,q?q-p:strlen(p));
			
			if( pSI->tm->contains(tt) )
			{
				sinfo[nInSources].territoryN->add((*(pSI->tm))[tt]);
			}
			else
			{
				gclog.setLN(cln);
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
					"Неизвестная TERRITORY ");
				gclog.printfCP(AdvLogger::CD_ALT, "'%s'", yytext);
				gclog.printfCP(AdvLogger::CD_KOI, " для источника.\n");
			}
			tt.bDoFree = 1;
			if (!q) break;
			else p = q+1;
		}
		free(p1);
	}
	nInSources++;
}
int readSourcesInfo(SourcesInfo *si, const char *fn)
{
	yyin = mpcxc_fopen( fn, "r" );
	if( !yyin ){
		gclog.noHdr();
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
			"Ошибка открытия файла источников\n");
		return 1;
	}
	gclog.setFileName( fn );

	srcTree = new HNode;

	fullsrc = (char*)malloc(8192);
	stripsrc = (char*)malloc(8192);
	pSI = si;
	si->sm = new CaseStringlongSplayMap(-1);
	nInSources = 0;
	cln = 1;
	gclog.setLN(1);
	isDefaultTer = 0;
	yylex();
	if (!isSrcFlushed) finishSource();

	fclose(yyin);
	free( fullsrc );
	free( stripsrc );
	si->sinfo = sinfo;
	si->sourceCount = nInSources;

	delete srcTree;

	if (bWasFatal) exit(1);
	return 0;
}
