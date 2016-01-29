#include "shared/Core/fix/mpcxc.h"
#include "u_int64_t.CtxLongSet.SplayMap.h"
#include "base.h"

//#include <sys/time.h>
#include <sys/resource.h> // MPCXC study for replace

/*
 * $Id: ctxwords.cpp,v 2.31 2013/05/08 13:37:48 dolgop Exp $
 */

bool	gctxWinEncode = false;

void setLimits()
{
#if defined(unix) && !defined(__CYGWIN32__)
	struct rlimit rl;

	getrlimit( RLIMIT_DATA, &rl );
	rl.rlim_cur = rl.rlim_max;
	setrlimit( RLIMIT_DATA, &rl );

#ifndef sun
	getrlimit( RLIMIT_RSS, &rl );
	rl.rlim_cur = rl.rlim_max;
	setrlimit( RLIMIT_RSS, &rl );

	getrlimit( RLIMIT_MEMLOCK, &rl );
	rl.rlim_cur = rl.rlim_max;
	setrlimit( RLIMIT_MEMLOCK, &rl );
#endif
#endif
}

#ifdef WITH_DBL_THREAD
int compareLong( const void *arg1, const void *arg2 )
{
   /* Compare all of both strings: */
   if( *( long* ) arg1 < * ( long* ) arg2 )
	   return -1;
   return 1;
}
extern int bCTXTlast;
#endif

void flushIt(	Base *base , u_int64_tCtxLongSetSplayMap &ctxmap, char *idxName )
{
	int nitems = ctxmap.length();
	if ( !nitems )
		return;

	ContextIndex *ind = (ContextIndex *) base -> FindIndex ( idxName );
	int lastP = -1;
	int count =0;
	for( Pix i = ctxmap.first(); i; ctxmap.next(i) ){
		count++;
		int tmp = (count*100)/nitems;
		if( tmp > lastP ){
			lastP = tmp;
			printf("Flushing %d keys, %d%% done.\r", nitems, lastP );
			fflush(stdout);
		}
		CtxLongSet *sp = &ctxmap.contents(i);
		if( sp->lastI ){
			u_int64_t k = ctxmap.key(i);
			Stream *str = ind->Open( (char *) &k , 1 );
			if( str ){
				str->Seek(str->Length());
#ifdef WITH_DBL_THREAD
	if(!bCTXTlast)
		// Sort remaining tags using Quicksort algorithm: //
		qsort( (void *)sp->e, (size_t)sp->lastI, sizeof( long ), compareLong );
#endif
				unsigned tmp = str->Write( sp->e, sp->lastI * sizeof(long) );
				if( tmp != sp->lastI * sizeof(long) ){
					printf("Write failed for key '%s'\n",(char *)&k);
					exit(1);
				}
				ind->Close( str );
			}else{
				printf("Can't create stream for key '%s'\n",(char *)&k);
				exit(1);
			}
		}
		free( sp->e );
	}
	ctxmap.clear();
	printf(
		"Flushing %d keys successfuly done.\n%s index now has %d keys.\n",
		nitems, idxName, (int)(ind->KeyCount) );
}

#undef CXTWORDS_STANDALONE

#ifdef CXTWORDS_STANDALONE

#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <sys/mman.h>

struct Ref {
	long a;
	long b __attribute__((packed));
};
#else
	#include "ctxwords.h"
	#include "gardefs.h"
#endif

#include <cstdio>

unsigned getParaWord(char *dst, const char **src, unsigned &l, int *f)
{
	char *to = dst;
	unsigned length =l;
	int bWasWord = 0;

	while(length){
#ifdef	WINENCODE
		if( ( gctxWinEncode && IS_CTX_CHAR_WIN(*(*src)) ) || ( !gctxWinEncode && IS_CTX_CHAR(*(*src))) ){
#else
		if( IS_CTX_CHAR(*(*src)) ){
#endif
			*to = *(*src)++;
#ifdef	WINENCODE
			if ( gctxWinEncode )
				QUICK_R_WIN_TOUPPER_WIN(*to)
			else			
				QUICK_R_DOS_TOUPPER_WIN(*to)
#else
			QUICK_R_TOUPPER(*to);
#endif
			if ( to - dst < 32 )
				to++;
			length--;
			bWasWord = 1;
		}else if ((*(*src) == '.') && (length > 1)
					&& IS_NUMBER(*((*src)-1)) && (IS_NUMBER((*src)[1]))){
			*to = *(*src)++;
			to++;
			length--;
		}else{
			if( bWasWord )
				// end word //
				break;
			if( *(*src) == '\x4' ){
				if( *f ){
					(*src)++; length --;
					*f = 0;
					switch( *(*src) ){
						case REFTYPE_REFLIST:
						case REFTYPE_BLOB:
							{
								unsigned t = *(short*)((*src)+1);
								if( !t ) t = 1;
								t*=sizeof(Ref);
								t+= 1 + sizeof(short);
								CORE_DUMP_ON_CHECK((t<=length), 
												"ref outside bounds.");
								length-=t;
								(*src)+=t;
							}
							break;
						case REFTYPE_CLASS:
							while( length && *(*src) ){
								(*src)++;
								length--;
							}
							if( length ){
								(*src)++;
								length--;
							}else{
								fprintf(stderr,"\n\nBadNews!\n\n");
							}
					}
				}else{
					(*src)++;
					length --;
					*f = 1;
				}
			}else{
				(*src)++;
				length --;
			}
		}
	}
	CORE_DUMP_ON_CHECK((l>=length), "outside para.");
	l=length;
	return static_cast<unsigned> (to-dst);
}

#ifdef CXTWORDS_STANDALONE

int main(int argc, char ** argv)
{
	if( argc !=2 ){
		cout << "Usage is" << endl;
	}
	struct stat st;

	int fd = ace_os_open(argv[1], ACE_OS_O_RDONLY );
	fstat(fd, &st);

	void *ptr=mmap(0,st.st_size,PROT_READ,MAP_SHARED,fd,0);
	if ( !ptr ){
		cout << "map failed." << endl;
		return 1;
	}
	char buf[128];
	unsigned len = st.st_size;
	const char *src = (const char*)ptr;
	while(bzero(buf,sizeof(buf)),getParaWord(buf, &src, len )){
		cout << buf << endl;
	}
}

#endif 

#include        "dociter.h"

void __cdecl pPutInMap(void *p_ctxTextMap, char *buf, int len, long Id, int j, int32_t *p_itemsDone)
{
	if(!p_ctxTextMap)
		return;
	CtxLongSet *sp = &(*((u_int64_tCtxLongSetSplayMap *)p_ctxTextMap))[*(u_int64_t*)buf];
	if( sp->lastElemV != Id ){
		if( sp->lastI >= sp->capacity ){
			sp->capacity += GROW_BY;
			sp->e=(long*)realloc(sp->e,sizeof(long)*sp->capacity);
			if( !sp->e ){
				printf("\nNo memory!\n");
				exit(1);
			}
			(*p_itemsDone)++;
		}
		sp->e[sp->lastI++] = Id;
		sp->lastElemV = Id;
	}
}

int gctx_putMap(	Base *base, int32_t maxItems, void (__cdecl *pPutInMap)(void *, char *, int, long, int, int32_t *),
				void *p_ctxTextMapP,
				void *p_ctxNameMapP)
{
	DocInfo	   docInfo;
	char	   buf [128];
	char namebuf[DOC_NAME_SIZE+1];

	printf("Collecting documents..."); fflush(stdout);
	DocIterator* it = new DocIterator( base );
	printf("done.\n"); fflush(stdout);

	u_int64_tCtxLongSetSplayMap *p_ctxNameMap= (u_int64_tCtxLongSetSplayMap *)p_ctxNameMapP;
	u_int64_tCtxLongSetSplayMap *p_ctxTextMap= (u_int64_tCtxLongSetSplayMap *)p_ctxTextMapP;

	int32_t itemsDone = 0;
#ifdef _DEBUG
	long parsed= 0;
#endif
	for ( ; !it->End (); ++(*it) ) {
		long  Id = it->Id ();

		if ( Id < ID_BORDER ) continue;
#ifdef _DEBUG
		parsed++;
		if(parsed > 15000)
			break;
#endif

		base->FindDocAttr(Id,IDD_INFO,(char *)&docInfo, sizeof(docInfo));

		if(p_ctxNameMap && !( docInfo.Status & (DS_DOC|DS_EDITION)))
				continue;

		printf("\rProcessing doc %d", Id); 
		fflush(stdout);

		unsigned len= 0;
		if(p_ctxNameMap){
			base->FindDocName(Id, namebuf);
			len= static_cast<unsigned> (strlen(namebuf));
		}
		namebuf[DOC_NAME_SIZE]= 0;
		const char *src = namebuf;
		int at_f = 0;
#ifdef	WINENCODE
		gctxWinEncode = true;
#endif
		if(p_ctxNameMap)
		 while ( *(u_int64_t*)buf=0, getParaWord(buf,&src,len, &at_f) ){
			CtxLongSet *sp = &(*p_ctxNameMap)[*(u_int64_t*)buf];
			if( sp->lastElemV != Id ){
				if( sp->lastI >= sp->capacity ){
					sp->capacity += GROW_BY;
					sp->e=(long*)realloc(sp->e,sizeof(long)*sp->capacity);
					if( !sp->e ){
						printf("\nNo memory!\n");
						exit(1);
					}
					itemsDone++;
				}
				sp->e[sp->lastI++] = Id;
				sp->lastElemV = Id;
			}
		}
#ifdef	WINENCODE
		gctxWinEncode = false;
#endif

		Document * doc = base -> GetDoc ( Id );

		for ( int j = 0; j < doc -> Stat.ParaCount; j++ ) {
			char  * ptr  = doc -> GetPara ( j );
			unsigned len = TextSize ( ptr ), wordLen;
			const char *src = ParaText ( ptr );
			int at_f = 0;
			while ( *(u_int64_t*)buf=0, (wordLen= getParaWord(buf,&src,len, &at_f)) ){
				#if CTX_WORD_SIZE == 5 && BYTEORDER == 1234
					*(u_int64_t*)buf &= 0x000000ffffffffffULL;
				#elif CTX_WORD_SIZE ==8
					// no mask
				#else
					#error dont know how to handle (specify mask) :)
				#endif
				pPutInMap(p_ctxTextMapP, buf, wordLen, Id, j, &itemsDone);
			}
		}
		delete doc;
		#ifndef __GO32__
			printf("  (%dk)", (itemsDone*GROW_BY*sizeof(long))/1024 );
		#else
			printf("  (%ldk)", (itemsDone*GROW_BY*sizeof(long))/1024 );
		#endif
		fflush(stdout);
		if( maxItems != -1 ){
			if( maxItems < itemsDone ){
				printf("\nMemory limit reached, flush initiated.\n");
				flushIt( base, *p_ctxTextMap, "Context" );
				flushIt( base, *p_ctxNameMap, "NameContext" );
				long tmp = itemsDone = 
					p_ctxNameMap->length()
					+ p_ctxTextMap->length();
				if( tmp >= maxItems ){
					printf("Keys tree too big to fit into memory limit.\n");
					maxItems = ((tmp * GROW_BY *sizeof(long)) +
								( 1024 * 1024 -1 ) ) / (1024 * 1024);
					printf("Memory limit extended to %dM.\n", maxItems );
					maxItems*= (((1024*1024)/GROW_BY)/sizeof(long));
				}
			}
		}
	}
	printf("\nAll documents done. Flushing rest of keys.\n");
	delete it;
	return 0;
}


int gctx_main(	Base *base, int32_t maxItems,
				u_int64_tCtxLongSetSplayMap *p_ctxTextMap,
				u_int64_tCtxLongSetSplayMap *p_ctxNameMap)
{
	return gctx_putMap(base, maxItems, pPutInMap, p_ctxTextMap, p_ctxNameMap);
}

