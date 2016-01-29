%option noyywrap
%option nounput
%option prefix="gcla_"

%x COMMENT
%x GETREST
%x FERROR
%x GETVERSION
%x GETEQID
%x GETEQSET
%x GETNOSUF
%x GETPREFIXEX

%{                   
#include <osdep.h>
#include <stdio.h>
#include <unistd.h>
//#include "FString.long.SplayMap.h"
//#include "FString.SplaySet.h"
//#include "FString.caddr_t.SplayMap.h"
//#include "FString.SplaySet.h"
#include "CaseString.defs.h"
#include "classes.h"
#include "hnode.h"
#include "gardefs.h"
#include "garcomp.h"
#include "gclog.h"
	static int cln;
	static char *fullsrc, *stripsrc;
	static char *ft, *ts;
	static int print_prefix;
	static void doGetRest();
	static void doNoSuffix();
	static int prepend;
	static int enableClasses;
	static int enablePrefixes;
	static ClassesInfo *pCI;
	static void (*end_of_rest)();
	static void *end_of_rest_param;
	static void (*rest_slash)();
	static void claEndOfRest(), claSlash(), endOfClasses();
	static void setPrefixSlash(), setPrefixEndOfRest();
	static void prefixSlash(), prefixEndOfRest();
	static void setupEQ(), doEQ(), finishEQ();
	static struct ClassesInfo::ClassInfo *classInfo = 0;
	static struct ClassesInfo::PrefixInfo *prefixInfo = 0;
	static int nInClasses = 0;
	static int maxInClasses = 0;
	static int nInPrefixes = 0;
	static int maxInPrefixes = 0;
	static unsigned char isClassFlushed = 0;
	static unsigned char isEQFlushed = 0;
	static int *cEqs = 0, nEq=0, cEq=0, mEq=0;
	static int endOfClassesDone = 0;
	static int endOfPrefixesDone = 0;
	static void setPrefixTypes();
	static void endOfPrefixes();
	static void parsePrefixEx();
	static HNode * clsTree;
	static HNode * pfxTree;

	static unsigned char bWasFatal = 0;

unsigned char isPrefixType(CaseStringSplaySet& prefixGroup, FString& prefix)
{
	for (Pix pix = prefixGroup.first(); pix; prefixGroup.next(pix))
	{
		if ((prefix.length() == prefixGroup(pix).length()) && (strcasecmp(prefix.chars(),prefixGroup(pix).chars()) == 0)) return 1;
		if ((prefix.length() < prefixGroup(pix).length()) || (prefix.chars()[prefixGroup(pix).length()] != '\\')) continue;

		char * subprefix = new char[prefixGroup(pix).length()+1];
		memcpy(subprefix,prefix.chars(),prefixGroup(pix).length());
		subprefix[prefixGroup(pix).length()] = 0;
		unsigned char res = (strcasecmp(subprefix,prefixGroup(pix).chars()) == 0);
		delete subprefix;
		if (res) return 1;
	}
	return 0;
}

void setPrefixTypes()
{
	for( int i=0; i<nInPrefixes; i++)
	{
		FString s( prefixInfo[i].prefixName );
		prefixInfo[i].prefixType = 0;

		//if (isPrefixType(*pCI->docPrefixes,s))  prefixInfo[i].prefixType |= DS_ISDOC;
		/*
		if (isPrefixType(*pCI->commPrefixes,s)) prefixInfo[i].prefixType |= DS_ISCOMMENT;
		if (isPrefixType(*pCI->formPrefixes,s)) prefixInfo[i].prefixType |= DS_ISFORM;
		if (isPrefixType(*pCI->projPrefixes,s)) prefixInfo[i].prefixType |= DS_ISPROJECT;
		if (isPrefixType(*pCI->prakPrefixes,s)) prefixInfo[i].prefixType |= DS_ISPRAKTIC;
		if (isPrefixType(*pCI->intePrefixes,s)) prefixInfo[i].prefixType |= DS_ISINTER;
		if (isPrefixType(*pCI->quesPrefixes,s)) prefixInfo[i].prefixType |= DS_ISQUESTION;
		if (isPrefixType(*pCI->brefPrefixes,s)) prefixInfo[i].prefixType |= DS_ISBREFER;
		*/
	}
}


#define SETUPPREFIX(target) \
							prepend =0;\
							ft=fullsrc; \
							ts=stripsrc;\
							end_of_rest = setPrefixEndOfRest; \
							end_of_rest_param= pCI->target; \
							rest_slash = setPrefixSlash; \
							BEGIN(GETREST);







%}

comment ^[#;].*
whitespace [ \t\r]
sourcepart [0-9]{3}=[^ \t\r\n\\][^\r\n\\]*
suffixpart [0-9]{3}=.*[^ \t\r\n]
versprefix ^!VERSION[ \t]*
allprefix ^!ALLPREFIX[ \t]*
docsprefix ^!DOCSPREFIX[ \t]*
commprefix ^!COMMPREFIX[ \t]*
formprefix ^!FORMPREFIX[ \t]*
prakprefix ^!PRAKPREFIX[ \t]*
projprefix ^!PROJPREFIX[ \t]*
inteprefix ^!INTEPREFIX[ \t]*
quesprefix ^!QUESPREFIX[ \t]*
brefprefix ^!BREFPREFIX[ \t]*
prefix ^!PREFIX[ \t]*
prefixex ^!PREFIXEX[ \t]+
classprefix ^!CLASS[ \t]+
eqprefix   ^!EQ[\t ]*
%%
<*>\r
<INITIAL>{comment} BEGIN(COMMENT);
<COMMENT>.+ ;
<COMMENT>\n cln++; BEGIN(INITIAL);
<GETREST>{whitespace}
<GETREST>{sourcepart} doGetRest();
<GETREST>[\\] { if(rest_slash) (*rest_slash)(); }
<GETREST>\n { if(end_of_rest) (*end_of_rest)(); isClassFlushed = 1; BEGIN(INITIAL); cln++;}
<GETVERSION>[0-9]+ {
						if( ! pCI-> v )
							pCI->v = atoi(yytext);
						else{
							gclog.setLN(cln);
							gclog.printfC(AdvLogger::LOG_ERROR, 
								AdvLogger::CD_KOI, "Версия уже помечена.\n");
						}
					}
<GETVERSION>\n { BEGIN(INITIAL); cln++; }
<INITIAL>{whitespace}
<INITIAL>{versprefix} BEGIN(GETVERSION);

<INITIAL>{allprefix}  { SETUPPREFIX(allPrefixes) }
<INITIAL>{docsprefix} { SETUPPREFIX(docPrefixes) }
<INITIAL>{commprefix} { SETUPPREFIX(commPrefixes); }
<INITIAL>{formprefix} { SETUPPREFIX(formPrefixes); }
<INITIAL>{prakprefix} { SETUPPREFIX(prakPrefixes); }
<INITIAL>{projprefix} { SETUPPREFIX(projPrefixes); }
<INITIAL>{quesprefix} { SETUPPREFIX(quesPrefixes); }
<INITIAL>{inteprefix} { SETUPPREFIX(intePrefixes); }
<INITIAL>{brefprefix} { SETUPPREFIX(brefPrefixes); }
<INITIAL>{classprefix} {
						if( enableClasses ){
							prepend = 0;
							ft=fullsrc;
							ts=stripsrc;
							end_of_rest = claEndOfRest;
							rest_slash = claSlash;
							isClassFlushed = 0;
							BEGIN(GETREST);
						}else{
							gclog.printfC(AdvLogger::LOG_ERROR, 
								AdvLogger::CD_KOI,
					"Нельзя использовать CLASS после EQ или PREFIXEX\n");
						}
					}
<INITIAL>{prefix} {
						if( enablePrefixes ){
							prepend = 0;
							ft=fullsrc;
							ts=stripsrc;
							end_of_rest = prefixEndOfRest;
							rest_slash = prefixSlash;
							BEGIN(GETREST);
						}else{
							gclog.printfC(AdvLogger::LOG_ERROR, 
								AdvLogger::CD_KOI,
							"Нельзя использовать PREFIX после PREFIXEX\n");
						}
					}
<INITIAL>{eqprefix} if( !endOfClassesDone ) isEQFlushed = 0; endOfClasses(); BEGIN(GETEQID);
<INITIAL>{prefixex} {
						if( !endOfPrefixesDone ) 
								endOfPrefixes();
						if( !endOfClassesDone ) 
								endOfClasses();
						BEGIN(GETPREFIXEX);
					}
<GETPREFIXEX>[^ \t\r\n\\][^\r\n]* parsePrefixEx();
<GETPREFIXEX>[\r\n]+ gclog.setLN(++cln); BEGIN(INITIAL);
<GETEQID>[0-9]+ setupEQ();
<GETEQSET>[ \t,\r]+
<GETEQSET>[0-9]+ doEQ();
<GETEQSET>\n  finishEQ(); isEQFlushed = 1; BEGIN(INITIAL); gclog.setLN(++cln);
<*>. 			yymore(); BEGIN(FERROR); 
<FERROR>.+ {
				gclog.setLN(cln);
				gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
					"Ошибка формата около '%s'\n", yytext ); 
			}
<FERROR>\n gclog.setLN(++cln); BEGIN(INITIAL);
<INITIAL>\n gclog.setLN(++cln);
%%

void parsePrefixEx()
{
	char *bf = strdup(yytext);
	gclog.setLN(cln);
	int jumpType = 0;
	char *pfx, *unname, *cls;
	char *p, *q;
	
	pfx = bf;
	char *cmd = strchr( bf, ':' );
	if (!cmd) return;
	*cmd = 0;
	
	FString pf(pfx); pf.bDoFree=1;
	
	FString *pt = pCI->pTranslate( pf, ClassesInfo::TRANSPREFIX );
	if( !pt ) {
		gclog.setLN(cln);
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
			"Не могу распознать префикс ");
		gclog.printfCP(AdvLogger::CD_ALT, "'%s'\n", pfx);
		return;
	}

	for (p = cmd+1, q = strchr(p,';'); *p; p = q+1, q = strchr(p,';'))
	{
		if (!q)
		{
			gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"Command is not finished with ';'");
			return;
		}
		*q = 0;
		
		char * tmp = strchr(p,':');
		if (!tmp)
		{
			jumpType = 0;
			unname = p;
			cls = q;
		}
		else
		{
			*tmp = 0;
			unname = p;
			cls = tmp+1;
			char * jump = q-1;
			while ((jump > cls) && (*jump == '\\'))
			{
				*jump = 0;
				jumpType++;
				jump--;
			}
		}
		
		FString c(cls); c.bDoFree=1;
		FString *ct = 0;
		if (*cls)
		{
			ct = pCI->pTranslate( c, ClassesInfo::TRANSCLASS );
			if( !ct ) {
				gclog.setLN(cln);
				gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"Не могу распознать класс ");
				gclog.printfCP(AdvLogger::CD_ALT, "'%s'\n", cls);
				continue;
			}
		}
		else
		{
			ct = new FString("");
		}

		if (jumpType == 2 && *unname == 0)
		{

#undef CHECKEX
#define CHECKEX(a) if (pCI->a->contains(*pt))	\
			{	\
				gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"мЕ ЛНЦС ДНАЮБХРЭ ЯОХЯНЙ ДНЙСЛЕМРНБ-ОНРНЛЙНБ ЙМНОЙХ НЯМНБМНЦН ЛЕМЧ. йНЛЮМДЮ ХЦМНПХПСЕРЯЪ.\n");	\
				continue;	\
			}


			CHECKEX(allPrefixes);
			CHECKEX(docPrefixes);
			CHECKEX(commPrefixes);
			CHECKEX(formPrefixes);
			CHECKEX(projPrefixes);
			CHECKEX(prakPrefixes);
			CHECKEX(intePrefixes);
			CHECKEX(quesPrefixes);
			CHECKEX(brefPrefixes);

#undef CHECKEX
		}
		
		ClassesInfo::UnodeInfo *ninfo = (ClassesInfo::UnodeInfo *)(*(pCI->unodes))[*pt];
		if( !ninfo )
		{
			ninfo = (ClassesInfo::UnodeInfo *)calloc( 1, sizeof( ClassesInfo::UnodeInfo ));
			(*(pCI->unodes))[*pt] = (caddr_t)ninfo;
		}
		if( ninfo->nIn >= ninfo->maxIn )
		{
			ninfo->maxIn += 10;
			ninfo->node = (ClassesInfo::UnodeInfo::NI*)realloc( ninfo->node,sizeof(ClassesInfo::UnodeInfo::NI)*ninfo->maxIn );
		}
		ninfo->node[ninfo->nIn].jtype = jumpType;
		ninfo->node[ninfo->nIn].uname = strdup(unname);
		ninfo->node[ninfo->nIn].cls = strdup(ct->chars());

		delete ct;

		if (print_prefix)
		{
			gclog.printfC(AdvLogger::LOG_INFO_MPCXC, AdvLogger::CD_ALT,
				"PREFIXEX (%d)>>%s:%s:%s<<\n",
				ninfo->node[ninfo->nIn].jtype,
				pt->chars(),
				ninfo->node[ninfo->nIn].uname,
				ninfo->node[ninfo->nIn].cls );
		}
		ninfo->nIn ++;
	}

	delete pt;

	if( bf ) free(bf);
	yymore(); BEGIN(FERROR);
}

void setupEQ()
{
	cEq = atoi(yytext) - 1;
	if( cEq < 0 || cEq >= nInClasses ){
		gclog.setLN(cln);
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
			"Неверный номер EQ: %d\n", cEq);
		BEGIN(COMMENT);
	}else{
		BEGIN(GETEQSET);
	}
	nEq = 0;
}

void doEQ()
{
	if (yytext[0] < '0' || yytext[0] > '9') 
	{
		gclog.setLN(cln);
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
			"Неверный идентификатор класса %s.\n", yytext ); 
	}
	int t = atoi(yytext) -1;
	if( t < nInClasses )
	{
		if( nEq >= mEq )
		{
			mEq += 10;
			cEqs = (int*)realloc(cEqs,mEq*sizeof(int));
		}
		cEqs[nEq++] = t;
	}else{
		gclog.setLN(cln);
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
			"Неверный идентификатор класса %d.\n", t ); 
	}
}
void finishEQ()
{
	if( nEq )
	{
		classInfo[cEq].equals = (int*) realloc(classInfo[cEq].equals,
						(classInfo[cEq].nEquals+nEq)*sizeof(int));
		for( ;nEq; nEq--)
			classInfo[cEq].equals[classInfo[cEq].nEquals++]=cEqs[nEq-1];
	}
}

void endOfClasses()
{
	enableClasses = 0;
	endOfClassesDone = 1;
	classInfo = (ClassesInfo::ClassInfo *)realloc(classInfo,
			sizeof(ClassesInfo::ClassInfo)*nInClasses);
	pCI->classCount = nInClasses;
	pCI->clInfo = classInfo;
}
void endOfPrefixes()
{
	enablePrefixes = 0;
	endOfPrefixesDone = 1;
	prefixInfo = (ClassesInfo::PrefixInfo *)realloc(prefixInfo,
			sizeof(ClassesInfo::PrefixInfo)*nInPrefixes);
	pCI->prefixCount = nInPrefixes;
	pCI->pfxInfo = prefixInfo;
}
void claEndOfRest()
{
	FString s(stripsrc, ts - stripsrc);
	
	HNode * nnew = 0;
	HN_STATUS st = clsTree->addNode(s.chars(),nnew);

	if( (*(pCI->cm)).contains(s) || (st & INS_BRK))
	{
		gclog.setLN(cln);
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"Повторяющийся или неполный ключ ");
		gclog.printfCP(AdvLogger::CD_ALT,"'%s'\n",s.chars());
		return;
	}

	if (st & INS_CONT)
	{
		HNode * p = 0;
		for (p = nnew->parent; !p->bIsFinal; p = p->parent);
		FString bad(p->path());
		(*(pCI->cm)).del(bad);
		gclog.setLN((int)(p->p));
		p->bIsFinal = 0;
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"Повторяющийся или неполный ключ ");
		gclog.printfCP(AdvLogger::CD_ALT,"'%s'\n",bad.chars());
	}

	if (st & INS_CASE)
	{
		gclog.setLN(cln);
		gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_WIN,"мЕБЕПМШИ ПЕЦХЯРП. нДХМ ХГ СГКНБ ЯРПНЙХ НОПЕДЕКЕМ Б ДПСЦНЛ ПЕЦХЯРПЕ: ");
		gclog.printfCP(AdvLogger::CD_ALT,"'%s'\n",s.chars());
		bWasFatal = 1;
		return;
	}

	s.bDoFree = 0;
	(*(pCI->cm))[s] = nInClasses;
	nnew->p = (void*)cln;
	int t=classInfo[nInClasses].nameLength = ft-fullsrc+1;
	char *p = (char*)malloc(t);
	if (!p) {
		gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_KOI,
			"Переполнение памяти.\n");
		bWasFatal = 1;
		return;
	}
	memcpy(p, fullsrc, t);
	classInfo[nInClasses].className = p;
	classInfo[nInClasses].nEquals = 0;
	classInfo[nInClasses].equals = 0;
	nInClasses++;
}

void prefixEndOfRest()
{
	FString s(stripsrc, ts - stripsrc);
	HNode * nnew = 0;
	HN_STATUS st = pfxTree->addNode(s.chars(),nnew);

	if( (*(pCI->pm)).contains(s) && (st & INS_BRK))
	{
		gclog.setLN(cln);
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"Повторяющийся или неполный ключ ");
		gclog.printfCP(AdvLogger::CD_ALT,"'%s'\n",s.chars());
		return;
	}

	if (st & INS_CONT)
	{
		HNode * p = 0;
		for (p = nnew->parent; !p->bIsFinal; p = p->parent);
		FString bad(p->name);
		FString pn(p->name);
		(*(pCI->cm)).del(pn);
		gclog.setLN((int)(p->p));
		p->bIsFinal = 0;
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"Повторяющийся или неполный ключ ");
		gclog.printfCP(AdvLogger::CD_ALT,"'%s'\n",p->name);
	}

	if (st & INS_CASE)
	{
		gclog.setLN(cln);
		gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_WIN,"мЕБЕПМШИ ПЕЦХЯРП. нДХМ ХГ СГКНБ ЯРПНЙХ НОПЕДЕКЕМ Б ДПСЦНЛ ПЕЦХЯРПЕ: ");
		gclog.printfCP(AdvLogger::CD_ALT,"'%s'\n",s.chars());
		bWasFatal = 1;
		return;
	}

	if( nInPrefixes >= maxInPrefixes ){
		maxInPrefixes += 100;
		prefixInfo = (ClassesInfo::PrefixInfo *)realloc(prefixInfo,
					sizeof(ClassesInfo::PrefixInfo)*maxInPrefixes);
	}

	s.bDoFree = 0;
	(*(pCI->pm))[s] = nInPrefixes;
	nnew->p = (void*)cln;
	int t=prefixInfo[nInPrefixes].nameLength = ft-fullsrc+1;
	char *p = (char*)malloc(t);
	if (!p) {
		gclog.printfC(AdvLogger::LOG_FATAL, AdvLogger::CD_KOI,
			"Переполнение памяти.\n");
		bWasFatal = 1;
		return;
	}
	memcpy(p, fullsrc, t);
	prefixInfo[nInPrefixes].prefixName = p;
	prefixInfo[nInPrefixes].prefixType = 0;
	nInPrefixes++;
}

void setPrefixEndOfRest()
{
	FString s(fullsrc, ft - fullsrc);
	FStringSplaySet *a = (FStringSplaySet*)end_of_rest_param;
	if( (*a).contains(s) ){
		gclog.setLN(cln);
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
			"Prefix ");
		gclog.printfCP(AdvLogger::CD_ALT, "'%s'", s.chars());
		gclog.printfCP(AdvLogger::CD_KOI, " уже существует.\n");
	}else{
		s.bDoFree = 0;
		(*a).add(s);
	}
}

void claSlash()
{
	if( !prepend ){
		// check whether the space available
		if( nInClasses >= maxInClasses ){
			maxInClasses += 10000;
			classInfo = (ClassesInfo::ClassInfo *)realloc(classInfo,
						sizeof(ClassesInfo::ClassInfo)*maxInClasses);
		}
		prepend = '\\';
	}
}
void setPrefixSlash()
{
	if( !prepend ){
		prepend = '\\';
	}
}
void prefixSlash()
{
	if( !prepend ){
		// check whether the space available
		if( nInPrefixes >= maxInPrefixes ){
			maxInPrefixes += 100;
			prefixInfo = (ClassesInfo::PrefixInfo *)realloc(prefixInfo,
						sizeof(ClassesInfo::PrefixInfo)*maxInPrefixes);
		}
		prepend = '\\';
	}
}
void doGetRest()
{
	if( yyleng >= CLASS_KEY_SIZE ){
		gclog.setLN(cln);
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
			"Раздел длиннее %d символов.\n", CLASS_KEY_SIZE - 1);
		BEGIN(COMMENT);
		return;
	}
	if( ft ){
		if( prepend ){
			*ft++ = prepend;
		}
		strcpy(ft,yytext);
		ft += yyleng;
	}
	if( ts ){
		if( prepend ){
			*ts++=prepend;
		}
		strcpy(ts, yytext+4);
		ts += yyleng-4;
	}
}
FString * ClassesInfo:: pTranslate(FString &key,
	ClassesInfo::TranslateWhat w, int bTheLast)
{
	CaseStringlongSplayMap *m = cm;
	if( w == TRANSPREFIX ) m = pm;

	Pix i = m->nearest(key);
	if( i ){
		long n = m->contents(i);
		char *tptr = 0;
		if( w == TRANSPREFIX ) tptr = pfxInfo[n].prefixName;		
		else tptr = clInfo[n].className;

		char *cptr = (char *) key.chars();
		char *cpPtr, *tpPtr;
		/* FIXIT  - just a trick */
		if( bTheLast && cptr[key.length()-1] == '\\' )
			cptr[key.length()-1]= 0;
		for(;;){
			cpPtr = strchr(cptr,'\\');
			tpPtr = strchr(tptr,'\\');
			if( cpPtr ){
				if( tpPtr ){
					if( ((tpPtr-tptr)-4) == (cpPtr - cptr) ){
						if( str_n_case_cmp(cptr, tptr+4, cpPtr - cptr ) == 0 ){
							cptr = cpPtr+1;
							tptr = tpPtr+1;
						}else{
							goto last_try;
						}
					}else{
						goto last_try;
					}
				}else{
					goto last_try;
				}
			}else{
				// looks like last part
				cpPtr = strchr(cptr,0);
				if( !tpPtr ) tpPtr = strchr(tptr,0);
				if( ((tpPtr-tptr)-4) == (cpPtr - cptr) ){
					if( str_n_case_cmp(cptr, tptr+4, cpPtr - cptr ) == 0 ){
						// got it!
						char *tptr = 0;
						if( w == TRANSPREFIX ) tptr = pfxInfo[n].prefixName;
						else tptr = clInfo[n].className;

						FString *t = new FString(tptr,tpPtr-tptr);
						return t;
					}else{
						goto last_try;
					}
				}else{
					goto last_try;
				}
			}
		}
	}else{
		gclog.printf(AdvLogger::LOG_ERROR,
			"Can't find nearest to '%s'\n", key.chars());
	}
last_try:
	if( bTheLast )
		return 0;
	
	char *buf = (char*)malloc(key.length()+1);
	memcpy(buf,key.chars(),key.length());
	buf[key.length()]='\\';
	FString tkey(buf, key.length()+1 ); tkey.bDoFree =1;
	FString *t = pTranslate(tkey, w, 1);
	free(buf);
	return t;
}

int readClassInfo(ClassesInfo & ci, const char *fn, int print_pfx_ex)
{
#if defined(__CYGWIN32__) || defined(__GO32__) || defined(__MSVC__)
	yyin = mpcxc_fopen( fn, "rb" );
#else
	yyin = mpcxc_fopen( fn, "r" );
#endif
	if( !yyin ){
		gclog.noHdr();
		gclog.printfC(AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,
			"Не могу открыть файл классов\n");
		return 1;
	}
	gclog.setFileName( fn );
	print_prefix = print_pfx_ex;
	clsTree = new HNode;
	pfxTree = new HNode;

	fullsrc = (char*)malloc(8192);
	stripsrc = (char*)malloc(8192);
	pCI = &ci;
	ci.cm = new CaseStringlongSplayMap(-1);
	classInfo = 0;
	maxInClasses = nInClasses = 0;

	ci.pm = new CaseStringlongSplayMap(-1);
	prefixInfo = 0;
	maxInPrefixes = nInPrefixes = 0;

	ci.allPrefixes = new CaseStringSplaySet();
	ci.docPrefixes = new CaseStringSplaySet();
	ci.commPrefixes = new CaseStringSplaySet();
	ci.formPrefixes = new CaseStringSplaySet();
	ci.projPrefixes = new CaseStringSplaySet();
	ci.prakPrefixes = new CaseStringSplaySet();
	ci.intePrefixes = new CaseStringSplaySet();
	ci.quesPrefixes = new CaseStringSplaySet();
	ci.brefPrefixes = new CaseStringSplaySet();
	ci.unodes = new CaseStringcaddr_tSplayMap(0);

	cln = 1;
	gclog.setLN(1);
	enableClasses = 1;
	endOfClassesDone = 0;
	enablePrefixes = 1;
	endOfPrefixesDone = 0;
	yylex();
	if (!isClassFlushed) if(end_of_rest) (*end_of_rest)();
	if (!isEQFlushed) finishEQ();

	fclose(yyin);
	free( fullsrc );
	free( stripsrc );
	if( !endOfClassesDone) endOfClasses();
	if( !endOfPrefixesDone) endOfPrefixes();
	setPrefixTypes();

	delete clsTree;
	delete pfxTree;
	if (bWasFatal) exit(1);
	return 0;
}
int checkPartialTranslate(ClassesInfo & ci)
{
	CaseStringlongSplayMap *cm = ci.cm;
	for( Pix i= cm->first(); i; cm->next(i) ){
		FString t = cm->key(i);
		char *tb = strdup(t.chars());
		char *lptr = tb+t.length();
		while( tb < lptr ){
			while( tb < lptr && *lptr != '\\' ) lptr--;
			if( lptr > tb ){
				*lptr = 0;
				FString tp(tb); tp.bDoFree=1;
				FString *ttr = ci.pTranslate(tp,ClassesInfo::TRANSCLASS);
				if( !ttr ){
					gclog.noHdr();
					gclog.printf(AdvLogger::LOG_ERROR,
							"pTranslate: Failed on %s\n", tp.chars());
					return 1;
				}
				ttr->bDoFree = 1;
				delete ttr;
			}
		}
		free(tb);
	}
	return 0;
}
