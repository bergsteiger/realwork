%option noyywrap
%option nounput
%option prefix="gbtbl_"

%x COMMENT
%x PARSEERROR

%{                   
	#include <stdio.h>
	#include <vector>
	#include <string.h>
	#include "gcini.h"
	#include "garcomp.h"
	#include "blobtable.h"
	#include "fstringer.h"
	#include "FString.SplaySet.h"
	#include "u_int32_t.SplaySet.h"
	#include "u_int32_t.VHSet.h"

	static GCParameters *theParams;
	static u_int32_tSplaySet *blobs; 
	static int wasDupes;
	static int cln;
%}

comment ^[#;].+
ws [ \t\r]
blobid [0-9]+
blobinfo [^ \t\r\n]+[^\r\n]*[^ \t\r\n]\|[^ \t\r\n]+[^\r\n]*[^ \t\r\n]\|
advblob {blobid}[ \t]+{blobinfo}\n
sngblob {blobid}\n

%%
<*>\r
<*>{comment} BEGIN(COMMENT);
<COMMENT>.+ ;
<COMMENT>\n gclog.setLN(cln++); BEGIN(INITIAL);
<INITIAL>{ws}+
<INITIAL>{sngblob} 	{
				long blobtmp = atoi(yytext)+100000;
				if( ! blobs->contains(blobtmp) )
				{
					blobs->add(blobtmp);
				}
				else
				{
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Повторяющийся объект %d\n",blobtmp-100000);
					wasDupes = 1;
				}
			}
<INITIAL>{advblob} 	{
				long blobtmp = atoi(yytext)+100000;
				if( ! blobs->contains(blobtmp) )
				{
					blobs->add(blobtmp);
				}
				else
				{
					gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Повторяющийся объект %d\n",blobtmp-100000);
					wasDupes = 1;
				}
			}
<*>. 			BEGIN(PARSEERROR); 
<PARSEERROR>.+ 		gclog.printfC (errors, AdvLogger::LOG_ERROR,AdvLogger::CD_KOI,"Ошибка синтаксиса рядом с '%s'\n", yytext );
<PARSEERROR>\n 		gclog.setLN(cln++); BEGIN(INITIAL);
%%

void generateBlobTable(ThreadCompileInfo& tcinfo, GCParameters *p)
{
	FILE* f = fopen(p->outOFile,"w");
	if (!f) {
		gclog.noHdr();
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Невозможно открыть на запись '%s'\n", 
			p->outOFile);
		return;
	}
	u_int32_tSet *b = tcinfo.blobs;
	int c = 0;

	for(Pix i = b->first(); i; b->next(i)) {
		long id = (*b)(i);
		if (id>100105 && id<100113)
			continue;
		fprintf(f, "%d\n", id );
	}

	fprintf(f,"\n");
	fclose(f);
}

extern	bool bIgnoreTvsErrors;
extern	std::deque<std::string> errors;

int readBlobTable(ThreadCompileInfo& tcinfo, GCParameters *p)
{
//	grpRE reDocId("^([0-9]+).*");

	FStringSplaySet *infs = p->inOFile;

	if (!infs)
	{
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI,"Не указан файл таблицы внешних объектов.\n");
		return 0;
	}
	int wasDupes = 0;
	for( Pix i=infs->first(); i; infs->next(i) ){
		const char *name = ((*infs)(i)).chars();
		FileStringer fst(name);
		if (!fst.OK())
		{
			gclog.noHdr();
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Невозможно открыть на чтение '%s'\n", 
				name);
			continue;
		}
		gclog.setFileName(name);
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_KOI,"Чтение таблицы внешних объектов.\n");


		const char *buf;
		int l;
		int cl = 0;
		long cnt = -1;
		while((buf = fst.gets(l)) != NULL) {
			gclog.setLN(++cl);
			const char* s = buf;
			while (*s == ' ' || *s == '\t') s++;
			cnt = atoi(s);
			if (tcinfo.blobs->contains(cnt))
			{
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "Duplicated blob %d\n", cnt-100000);
				if (!bIgnoreTvsErrors) wasDupes =1;
			}
			else
			{
				tcinfo.blobs->add(cnt);
			}
		}
	}
	return wasDupes;
}

void rehashBlobTbl(ThreadCompileInfo& tcinfo)
{
	u_int32_tSet *o = tcinfo.blobs;
	int l = o->length();
	if( !l ) l=10;
	u_int32_tSet *n = new u_int32_tVHSet( VHMAPREALSIZE(l) );
	for( Pix i = o->first(); i; o->next(i) ){
		n->add( (*o)(i) );
	}
	tcinfo.blobs = n;
	delete o;
}
