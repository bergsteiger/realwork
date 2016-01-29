%option noyywrap
%option nounput
%option prefix="gkw_"

%x COMMENT
%x PERROR
%x GETTOPKEY
%x GETSKEY
%x GETREFS
%x GETLEFTKEY
%x GETRIGHTKEY
%x FINALIZEEQ


%{                   
#include <stdio.h>
#include <vector>
#include "garcomp.h"
#include "CaseString.defs.h"
#include "collect.h"

extern std::deque<std::string> errors;

static int cln;
static int backTo;
static char *keyBuf = NULL;
static char *aNewKey = NULL;
static void doTopKey();
static void doSKey();
static void getFullRef();
static void getPartialRef();
static void insertRef(long id, long sub );
static void flushRefs();
static int topKeyLength = 0;
static int realLength = 0;
static Ref *refs = NULL;
static int nRefs = 0;
static int maxRefs = 0;
static ThreadCompileInfo *inf = NULL;
static CaseStringSplaySet * topKeys;
static CaseStringSplaySet * subKeys;
static Collection * leftKeys;
static Collection * rightKeys;
static CaseStringSplaySet * fastRightKeys;
static Collection* equalKeywords; //ª®««¥ªæ¨ï íª¢¨¢ «¥­â­ëå ª«îç¥© (áâà®ª¨)
static int equalKeys = 0;
static Ref** equalRefs; //ª®««¥ªæ¨ï ¬ áá¨¢®¢ Ref®¢
static Collection* equalRefsCount;
static void doLeftKey();
static void doRightKey();
%}

comment ^[#;].*
ws [ \t\\]
notws [^ \t\r\n]
topkey ^!KEY[ \t]*
eq ^!EQ[ \t]*
%%
<*>\r
<*>{comment} { if( backTo != COMMENT ) backTo=YYSTATE; BEGIN(COMMENT); }
<COMMENT>.+ ;
<COMMENT>\n gclog.setLN(++cln); BEGIN(backTo);
<INITIAL>{topkey} BEGIN(GETTOPKEY);
<INITIAL>^{ws}+ BEGIN(GETSKEY);
<INITIAL>{eq} BEGIN(GETLEFTKEY);
<GETTOPKEY>.*{notws}+ doTopKey();
<GETTOPKEY>{ws}+ ;
<GETTOPKEY>\n gclog.setLN(++cln); BEGIN(INITIAL);
<GETSKEY>{notws}+.*: doSKey();
<GETREFS>{ws}
<GETREFS>[0-9]+\.[0-9]+ getFullRef();
<GETREFS>[0-9]+ getPartialRef();
<GETREFS>. backTo=INITIAL; yymore(); BEGIN(PERROR);
<GETREFS>\n gclog.setLN(++cln); flushRefs(); BEGIN(INITIAL);
<GETLEFTKEY>{notws}+.*= doLeftKey();
<GETRIGHTKEY>.* doRightKey();
<FINALIZEEQ>\n gclog.setLN(++cln); BEGIN(INITIAL);
<PERROR>[^\r\n]+ { 
					gclog.printfC(errors, AdvLogger::LOG_ERROR, AdvLogger::CD_ALT, "Žè¨¡ª  á¨­â ªá¨á  àï¤®¬ á '"%s'\n", yytext ); 
							
				}
<PERROR>\n gclog.setLN(++cln); BEGIN(backTo);
<INITIAL>\n gclog.setLN(++cln); 
<*>. 			yymore(); backTo=INITIAL; BEGIN(PERROR); 
%%

void flushEqualKeys()
{
	if ( equalKeys )
	{
		for( int i = 0; i < equalKeys; i++ )
		{
			Ref* aRefs = equalRefs[i];
			char* aKey=(char*)equalKeywords->GetItem(i);
			inf->dbproc->addKeyWord(aKey,strlen(aKey)+1,aRefs,*(int*)equalRefsCount->GetItem(i)*sizeof(Ref));
			//printf("%s: ", aKey );
			//for ( int j = 0; j<*(int*)equalRefsCount->GetItem(i); j++ )
			//	printf( "%d.%d ", aRefs[j].DocId, aRefs[j].Sub );
			free(aRefs);
			//printf("\n");
		}
		//printf("\n");
		free( equalRefs );
		equalKeywords->FreeAll();
		equalRefsCount->FreeAll();
	}
	equalKeys=0;
}

void flushRefs()
{
	if (nRefs)
	{
		inf->dbproc->addKeyWord(keyBuf,realLength+1,refs,nRefs*sizeof(Ref));
		if ( rightKeys->ItemCount )
		{
			char* aSlashPos = strchr(keyBuf,'\\');
			FString subKey(keyBuf,aSlashPos-keyBuf); subKey.bDoFree= 1;
			if ( fastRightKeys->contains(subKey))
			{
				for ( int i = 0; i < rightKeys->ItemCount; i++ )
					if ( !strcmp( subKey.chars(), (char*)rightKeys->GetItem(i)))
					{
						strcat(strcpy(aNewKey,(char*)leftKeys->GetItem(i)),aSlashPos);

						Ref* copyRefs=(Ref*)malloc(nRefs*sizeof(Ref));
						for ( int j = 0; j<nRefs; j++ ) {
							copyRefs[j]=refs[j];
							//printf( "%d.%d ",copyRefs[j].DocId,copyRefs[j].Sub);
						}
						//printf("\n");

						if ( equalKeys )
							equalRefs = (Ref**)realloc(equalRefs,sizeof(Ref*)*(equalKeys+1));
						else
							equalRefs = (Ref**)malloc(sizeof(Ref*));

						equalRefs[equalKeys]=copyRefs;
						equalKeywords->Add(aNewKey);
						equalRefsCount->Add(&nRefs);
						equalKeys++;
						break;
					}
			}
		}
	}
	nRefs = 0;
}
void insertRef(long id, long sub )
{
	if( nRefs >= maxRefs ){
		maxRefs += 1000;
		refs = (Ref*) realloc(refs, sizeof(Ref)*maxRefs);
	}
	for( int i=0; i<nRefs; i++){
		if( refs[i].DocId == id && refs[i].Sub == sub ){
			gclog.printfC(AdvLogger::LOG_WARNING_MPCXC, AdvLogger::CD_KOI,"ðÏ×ÔÏÒÑÀÝÁÑÓÑ ÓÓÙÌËÁ %ld.%ld\n",
				id - REAL_DOC_OFFS, sub );
			return;
		}
	}
	refs[nRefs].DocId = id;
	refs[nRefs].Sub = sub;
	nRefs++;
}
void getFullRef()
{
	long id = atoi(yytext) + REAL_DOC_OFFS;
	long sub = atoi(strchr(yytext,'.')+1);
	if( inf->topicSubs->contains(id) && !inf->inDocs->contains(id))
	{
		if( inf->relatedS->contains(id) )
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN,"Íåâåðíàÿ ññûëêà: êëþ÷åâîå ñëîâî íå ìîæåò ññûëàòüñÿ íà ñïðàâêó %ld.\n", id - REAL_DOC_OFFS);
		else
		if( sub==0 || (*(inf->topicSubs))[id].contains(sub) )
		{
			insertRef(id,sub);
		}
		else if(inf->ref_doc_check)
		{
			gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,"îÅ×ÅÒÎÁÑ ÓÓÙÌËÁ: ÎÅÔ ÓÁÂÁ %ld × ÄÏËÕÍÅÎÔÅ %ld.\n", sub, id - REAL_DOC_OFFS);
		}
	}
	else if(inf->ref_doc_check && !inf->inDocs->contains(id))
	{
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "îÅ×ÅÒÎÁÑ ÓÓÙÌËÁ: ÎÅÔ ÄÏËÕÍÅÎÔÁ %ld.\n",id-REAL_DOC_OFFS);
	}
}

void getPartialRef()
{
	long id = atoi(yytext) + REAL_DOC_OFFS;
	if( inf->topicSubs->contains(id) && !inf->inDocs->contains(id) )
	{
		insertRef(id,0);
	}
	else if(inf->ref_doc_check && !inf->inDocs->contains(id))
	{
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "îÅ×ÅÒÎÁÑ ÓÓÙÌËÁ: ÎÅÔ ÄÏËÕÍÅÎÔÁ %ld.\n",id-REAL_DOC_OFFS);
	}
}

void doSKey()
{
	if( topKeyLength == 0 )
	{
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "ëÌÀÞÅ×ÁÑ ÚÁÐÉÓØ ÂÅÚ ÚÁÇÌÁ×ÎÏÇÏ ÐÕÎËÔÁ.\n");
		backTo = INITIAL;
		BEGIN(COMMENT);
		return;
	}
	if( strchr(yytext,'\\') != NULL )
	{
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI, "ëÌÀÞÅ×ÏÅ ÓÌÏ×Ï ÎÅ ÍÏÖÅÔ ÓÏÄÅÒÖÁÔØ ÓÌÅÛ.\n");
		backTo = INITIAL;
		BEGIN(COMMENT);
		return;
	}
	int i = yyleng-1;
	while( i && (yytext[i] == ' ' || yytext[i] == '\t' || yytext[i]==':') ) i--;
	if( i >= SEC_KW_SIZE-1 )
	{
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_KOI,  "ëÌÀÞ ×ÔÏÒÏÇÏ ÕÒÏ×ÎÑ ÄÌÉÎÅÅ %d.\n", SEC_KW_SIZE );
		backTo = INITIAL;
		BEGIN(COMMENT);
		return;
	}
	FString subKey(yytext,yyleng); subKey.bDoFree= 1;
	if (subKeys->contains(subKey))
	{
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ïîâòîðÿþùååñÿ ïîäâûðàæåíèå.\n");
		subKey.bDoFree = 1;
		backTo = INITIAL;
		BEGIN(COMMENT);
		return;
	}
	i++;
	subKeys->add(subKey);
	subKey.bDoFree= 0;
	strncpy(keyBuf+topKeyLength,yytext,i);
	realLength = topKeyLength+i;
	keyBuf[realLength] = 0;
	backTo = INITIAL;
	nRefs = 0;
	BEGIN(GETREFS);
}
void doTopKey()
{
	topKeyLength = 0;
	if( strchr(yytext,'\\') != NULL )
	{
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Íåäîïóñòèìûé ñèìâîë '\\' â âûðàæåíèè.\n");
		return;
	}
	if( yyleng >= PRIME_KW_SIZE )
	{
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Äëèíà âûðàæåíèÿ áîëüøå ÷åì %d ñèìâîëîâ.\n", PRIME_KW_SIZE);
		return;
	}
	FString topKey(yytext,yyleng);
	if (topKeys->contains(topKey))
	{
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Ïîâòîðÿþùàÿñÿ êîìàíäà !KEY.\n");
		topKey.bDoFree = 1;
		return;
	}
	{
		for (int i = 0; i < leftKeys->ItemCount; i++) {
			char* ati = (char*) leftKeys->GetItem (i);
			if (!strcmp (ati, topKey.chars ())) {
				gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Îáíàðóæåíà ñèòóàöèÿ-äóáëü\n");
				topKey.bDoFree = 1;
				return;
			}
		}
	}
	topKeys->add(topKey);
	topKeyLength = topKey.length();
	strcpy(keyBuf, topKey.chars() );
	keyBuf[topKeyLength++] = '\\';
	if ( equalKeys )
		flushEqualKeys();
	for (Pix pix = subKeys->first(); pix; subKeys->next(pix)) (*subKeys)(pix).bDoFree = 1;
	subKeys->clear();
}

int procKWfile(ThreadCompileInfo *i, const char *fn)
{
	yyin= fopen(fn, "rb" );
	if( !yyin ) return 1;
	keyBuf = (char*) malloc(PRIME_KW_SIZE+1+SEC_KW_SIZE+1);
	aNewKey = (char*) malloc(PRIME_KW_SIZE+1+SEC_KW_SIZE+1);
	topKeys = new CaseStringSplaySet;
	subKeys = new CaseStringSplaySet;
	leftKeys = new Collection( PRIME_KW_SIZE+1, 100 );
	rightKeys = new Collection( SEC_KW_SIZE+1, 100 );
	fastRightKeys = new CaseStringSplaySet;
	equalKeywords = new Collection( PRIME_KW_SIZE+SEC_KW_SIZE+2,100);
	equalRefsCount = new Collection(sizeof(int),100);
	equalRefs = NULL;
	equalKeys = 0;
	gclog.setFileName(fn);
	inf = i;
	cln =1 ;
	topKeyLength = 0;
	realLength = 0;
	refs = NULL;
	nRefs = 0;
	maxRefs = 0;
	yylex();
	flushRefs();
	flushEqualKeys();
	free(keyBuf);
	free(aNewKey);
	Pix pix;
	for (pix = topKeys->first(); pix; topKeys->next(pix)) (*topKeys)(pix).bDoFree = 1;
	for (pix = subKeys->first(); pix; subKeys->next(pix)) (*subKeys)(pix).bDoFree = 1;
	for (pix = fastRightKeys->first(); pix; fastRightKeys->next(pix)) (*fastRightKeys)(pix).bDoFree = 1;
	delete topKeys;
	delete subKeys;
	delete leftKeys;
	delete rightKeys;
	delete fastRightKeys;
	delete equalRefsCount;
	delete equalKeywords;
	if( refs ) free(refs);
	return 0;
}

void	doLeftKey()
{
	if ( yyleng > PRIME_KW_SIZE )
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Äëèíà âûðàæåíèÿ áîëüøå ÷åì %d ñèìâîëîâ.\n", PRIME_KW_SIZE);
	else
	{
		char* aLeftKey = new char[ PRIME_KW_SIZE + 1 ];
		strcpy( aLeftKey, yytext );
		aLeftKey[ strlen( aLeftKey ) - 1 ] = 0;
		leftKeys->Add(aLeftKey);
		delete aLeftKey;
	}
	BEGIN(GETRIGHTKEY);
}

void	doRightKey()
{
	if ( yyleng > PRIME_KW_SIZE )
		gclog.printfC (errors, AdvLogger::LOG_ERROR, AdvLogger::CD_WIN, "Äëèíà âûðàæåíèÿ áîëüøå ÷åì %d ñèìâîëîâ.\n", PRIME_KW_SIZE);
	else
	{
		char* aRightKey = new char[ PRIME_KW_SIZE + 1 ];
		strcpy( aRightKey, yytext );
		aRightKey[ strlen( aRightKey ) - 1 ] = 0;
		FString rightKey(aRightKey);
		fastRightKeys->add(rightKey);
		rightKeys->Add(aRightKey);
		delete aRightKey;
	}
	BEGIN(FINALIZEEQ);
}
