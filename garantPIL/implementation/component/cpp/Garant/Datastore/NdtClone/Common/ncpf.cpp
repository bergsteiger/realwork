
#include "garantPIL/implementation/component/cpp/Garant/Datastore/NdtClone/Common/ncpf.h"

#include <cstdlib>
#include <cstring>


namespace NdtClone {

#define DO_DEBUG 1
#undef DO_DEBUG

#define EMPTYCELL   0
#define VALIDCELL   1
#define DELETEDCELL 2

#define ENABLE_CACHESTAT 1
#undef ENABLE_CACHESTAT

#define THEHASH(x)  (((unsigned)x) * 2654435767UL)

#define DELETEINFOBYPOS(a) (a)->st=DELETEDCELL

#ifdef DO_DEBUG
static void printList(const char *name, struct pageinfo *l, unsigned n );


static void printList(const char *name, struct pageinfo *l, unsigned n )
{
	printf("====> %s\n", name );
	int i = 0;
	while(l){
		printf("page %ld, last %p, first %p\n", l->page, l->last, l->first );
		i++;
		l = l->first;
	}
	printf("expected %d, got %d\n", n, i );
}
#endif

//##ModelId=3BFE7DEA02BD
void NCPagedFile :: printCacheStat(FILE *lf)
{
#ifdef ENABLE_CACHESTAT
	fprintf(lf, "Cache stat on file %s.\n", FileName );
	fprintf(lf, "Read   attempts: %ld\n", ratt );
	fprintf(lf, "Write  attempts: %ld\n", watt );
	fprintf(lf, "Forced pageouts: %ld\n", pageouts );
	rhit += frh;
	whit += fwh;
	if( ratt ){
	fprintf(lf, " Read    hits: %ld (%f%%)\n", rhit, rhit*100.0/ratt );
	fprintf(lf, "pRead    hits: %ld (%f%%)\n", frh, frh*100.0/ratt );
	}
	if( watt ){
	fprintf(lf, " Write   hits: %ld (%f%%)\n", whit, whit*100.0/watt );
	fprintf(lf, "pWrite   hits: %ld (%f%%)\n", fwh, fwh*100.0/watt );
	}
	if( ratt+watt ){
	fprintf(lf, " Average hits: %ld (%f%%)\n", rhit+whit, 
								(rhit+whit)*100.0/(ratt+watt) );

	fprintf(lf, "pAverage hits: %ld (%f%%)\n", frh+fwh, 
								(frh+fwh)*100.0/ (ratt+watt) );
	}
#endif
}

//##ModelId=3BFE7DEA028A
NCPagedFile :: NCPagedFile(const char *n,
									int m,
									int npages,
									unsigned t, long database_version)
	: PagedFile((char*)n, m, database_version),
	cpcount(0),
	threshold(t),
	cont(0),
	ratt(0),watt(0),rhit(0),whit(0),fwh(0),frh(0),pageouts(0)
{
	if( npages < 10 ) npages = 10;
	cpn = npages;
	//if( IsOk() ){
		initCache();
	//}
}

void NCPagedFile :: Create  ( short s, bool bLockPath  )
{
	PagedFile :: Create  ( s, bLockPath );
	initCache();
}

extern "C" {
static int cmppi(const void *p1, const void *p2);
}

int cmppi(const void *p1, const void *p2)
{
	return (int)((*((ppageinfo*)p1))->page - (*((ppageinfo*)p2))->page);
}

//##ModelId=3BFE7DEA029E
NCPagedFile :: ~NCPagedFile()
{

#ifndef __GNUC__
	ppageinfo *pages = (ppageinfo *) calloc(cpn, sizeof(ppageinfo));
#else
	ppageinfo pages[cpn];
#endif
	int pagesin = 0;
	pageinfo *cpi = 0;
	for(cpi = fu; cpi ; cpi=cpi->last ){
		if( cpi->m ){
			pages[pagesin++]=cpi;
		}
	}
	if( pagesin ){
		qsort(pages,pagesin, sizeof(ppageinfo),cmppi);
		for( int i =0; i< pagesin; i++ ){
			PagedFile :: PutPage(pages[i]->page, pages[i]->buf);
		}
	}
	for(cpi = fu; cpi ; cpi=cpi->last ){
		free( cpi->buf );
	}
	free(cont);
#ifndef __GNUC__
	free(pages);
#endif

#ifdef ENABLE_CACHESTAT
	printCacheStat(stdout);
#endif
}
//##ModelId=3BFE7DEA02C6
void NCPagedFile :: flushpages()
{
	int sz;
	if( threshold ){
		sz = cpn / threshold;
		if( !sz ) sz = 1;
	}else{
		sz = 1;
	}
#ifndef __GNUC__
	ppageinfo *pages = (ppageinfo *)calloc(sz, sizeof(ppageinfo));
#else
	ppageinfo pages[sz];
#endif

	int pagesin = 0;
	for(pageinfo *cpi = fu; cpi && (pagesin<sz) ; cpi=cpi->last ){
		if( cpi->m ){
			pages[pagesin++]=cpi;
		}
	}
	if( pagesin > 1 ){
		qsort(pages,pagesin, sizeof(ppageinfo),cmppi);
		for( int i =0; i< pagesin; i++ ){
			PagedFile :: PutPage(pages[i]->page, pages[i]->buf);
			pages[i]->m = 0;
		}
		#ifdef ENABLE_CACHESTAT
			pageouts += pagesin;
		#endif
	}else if(pagesin > 0) {
		PagedFile :: PutPage((*pages)->page, (*pages)->buf);
		(*pages)->m = 0;
		#ifdef ENABLE_CACHESTAT
			pageouts ++;
		#endif
	}
#ifndef __GNUC__
	free(pages);
#endif
}
//##ModelId=3BFE7DEA02BC
void NCPagedFile :: initCache()
{
	size = ((cpn)<<3)/7;
	if ( cont ) free ( cont );
	cont = (struct pageinfo *)calloc(size,sizeof(struct pageinfo));
	for (unsigned i = 0; i < size; ++i) cont[i].st = EMPTYCELL;
	// allocate dummy page
	pageinfo *thepage = allocInfoByN(-1);
	thepage->m = 0;
	if ( PageSize ) thepage->buf = (char*) malloc(PageSize);
	else thepage->buf = 0;
	//memcpy(thepage->buf, SystemPageBuf, PageSize);
	thepage->last = thepage->first = 0;
	lu = fu = thepage;
	cpcount=1;
}
//##ModelId=3BFE7DEA02A0
int	NCPagedFile :: GetPage ( long page, void * buf )
{
	#ifdef DO_DEBUG
		printList(FileName, lu, cpcount );
	#endif

	#ifdef ENABLE_CACHESTAT
		ratt++;
	#endif

	if( lu->page == page ) {
		#ifdef ENABLE_CACHESTAT
			frh++;
		#endif
		memcpy(buf, lu->buf, PageSize);
		return PageSize;
	}
	pageinfo *thepage = getInfoByN(page);
	if( thepage ){
		#ifdef ENABLE_CACHESTAT
			rhit++;
		#endif
		memcpy(buf, thepage->buf, PageSize);
		// relink page to top
		// thepage can't be lu!
		thepage->last->first = thepage->first;
		if( thepage != fu ){
			thepage->first->last = thepage->last;
		}else {
			thepage->last->first = 0;
			fu = thepage->last;
		}
		lu->last = thepage;
		thepage->first = lu;
		thepage->last = 0;
		lu = thepage;
		return PageSize;
	}else{
		char *sb = 0;
		if( cpcount >= cpn ){
			sb = fu->buf;
			if( fu->m ) {
				flushpages();
			}
			DELETEINFOBYPOS(fu);
			(fu = fu->last )->first = 0;
			cpcount --;
		}
		if( !sb ) sb=(char*)malloc(PageSize);
		// we SHOULD have free space
		pageinfo *thepage = allocInfoByN(page);
		thepage->m = 0;
		int rv = PagedFile :: GetPage (page, (thepage ->buf = sb) );
		memcpy(buf, sb, PageSize);
		// link page to top
		lu->last = thepage;
		thepage->first = lu;
		thepage->last = 0;
		lu = thepage;
		cpcount++;
		return rv;
	}
	return PageSize;
}

//##ModelId=3BFE7DEA02A8
int	NCPagedFile :: PutPage ( long page, void * buf )
{
	#ifdef DO_DEBUG
		printList(FileName, lu, cpcount );
	#endif

	#ifdef ENABLE_CACHESTAT
		watt++;
	#endif

	if( lu->page == page ) {
		#ifdef ENABLE_CACHESTAT
			fwh++;
		#endif
		memcpy(lu->buf, buf, PageSize);
		lu->m = 1;
		return PageSize;
	}

	pageinfo *thepage = getInfoByN(page);
	if( thepage ){
		#ifdef ENABLE_CACHESTAT
				whit++;
		#endif
		memcpy(thepage->buf, buf, PageSize);
		thepage->m = 1;
		// relink page to top
		thepage->last->first = thepage->first;
		if( thepage != fu ){
			thepage->first->last = thepage->last;
		}else {
			thepage->last->first = 0;
			fu = thepage->last;
		}
		lu->last = thepage;
		thepage->first = lu;
		thepage->last = 0;
		lu = thepage;
		return PageSize;
	}else{
		char *sb = 0;
		if( cpcount >= cpn ){
			sb = fu->buf;
			if( fu->m ) {
				flushpages();
			}
			DELETEINFOBYPOS(fu);
			(fu = fu->last )->first = 0;
			cpcount --;
		}
		if( !sb ) sb=(char*)malloc(PageSize);
		// we SHOULD have free space
		pageinfo *thepage = allocInfoByN(page);
		thepage->m = 1;
		memcpy((thepage->buf=sb), buf, PageSize);
		// link page to top
		lu->last = thepage;
		thepage->first = lu;
		thepage->last = 0;
		lu = thepage;
		cpcount++;
	}
	return PageSize;
}

static inline unsigned int doublehashinc(unsigned int h, unsigned int s)
{
	unsigned int dh =  ((h / s) % s);
	return (dh > 1)? dh : 1;
}

//##ModelId=3BFE7DEA02D2
struct pageinfo * NCPagedFile :: allocInfoByN(long item)
{
	unsigned int bestspot = size;
	unsigned int hashval = (unsigned int) THEHASH(item);
	unsigned int h = hashval % size;
	for (unsigned int i = 0; i <= size; ++i){
		if (cont[h].st == EMPTYCELL){
			if (bestspot >= size) bestspot = h;
			cont[bestspot].page = item;
			cont[bestspot].st = VALIDCELL;
			return cont+bestspot;
		}else if( cont[h].st == DELETEDCELL) {
			if (bestspot >= size) bestspot = h;
		} 

		if (i == 0)
			h = (h + doublehashinc(hashval, size)) % size;
		else if (++h >= size)
			h -= size;
	}
	cont[bestspot].st = VALIDCELL;
	cont[bestspot].page = item;
	return cont+bestspot;
}

//##ModelId=3BFE7DEA02D0
struct pageinfo * NCPagedFile :: getInfoByN(long item)
{
	unsigned int hashval = (unsigned int) THEHASH(item);
	unsigned int h = hashval % size;
	for (unsigned int i = 0; i <= size; ++i){
		if (cont[h].st == EMPTYCELL){
			return 0;
		}else if( cont[h].st == VALIDCELL && cont[h].page == item ){
			return cont+h;
		}

		if (i == 0)
			h = (h + doublehashinc(hashval, size)) % size;
		else if (++h >= size)
			h -= size;
	}
	return 0;
}

//##ModelId=3BFE7DEA02C7
void NCPagedFile :: deletePage(long item)
{
	unsigned int hashval = (unsigned int) THEHASH(item);
	unsigned int h = hashval % size;
	for (unsigned int i = 0; i <= size; ++i){
		if (cont[h].st == EMPTYCELL)
			return;
		else if( cont[h].st == VALIDCELL && cont[h].page == item ){
			cont[h].st = DELETEDCELL;
			return;
		}

		if (i == 0)
			h = (h + doublehashinc(hashval, size)) % size;
		else if (++h >= size)
			h -= size;
	}
}

} // namespace NdtClone
