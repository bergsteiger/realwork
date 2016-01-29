#include "shared/Core/fix/mpcxc.h"

#include "ncpf.h"

#include <cstdlib>
#include <cstring>
#include "ace/OS.h"

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

NCPagedFile :: NCPagedFile(LPPF_PARAM pPrm)
	: PagedFile(pPrm),
	cpcount(0),
	cont(0),
	ratt(0),watt(0),rhit(0),whit(0),fwh(0),frh(0),pageouts(0)
{
	m_buffer= 0;
	cpn = 100;

	initCache();
}

NCPagedFile :: NCPagedFile(const char *n,
									int m,
									int npages,
									unsigned t)
	: PagedFile((char*)n, m),
	cpcount(0),
	threshold(t),
	cont(0),
	ratt(0),watt(0),rhit(0),whit(0),fwh(0),frh(0),pageouts(0)
{
	m_buffer= 0;
	if( npages < 10 ) npages = 10;
	cpn = npages;

	initCache();
}

void NCPagedFile :: Create  ( short s, bool bLockPath )
{
	PagedFile::Create ( s, bLockPath );
	initCache();
}

extern "C" {
static int cmppi(const void *p1, const void *p2);
}

int cmppi(const void *p1, const void *p2)
{
	return (int)((*((ppageinfo*)p1))->page - (*((ppageinfo*)p2))->page);
}

NCPagedFile :: ~NCPagedFile()
{
	if(cpn)
		flushpages(cpn);

	for(pageinfo *cpi = fu; cpi ; cpi=cpi->last ){
		free( cpi->buf );
	}
	free(cont);

#ifdef ENABLE_CACHESTAT
	printCacheStat(stdout);
#endif
	this->Delete();
}

void NCPagedFile :: flushpages(int pcount)
{
	int sz;
	if(pcount == -1){
		if( threshold ){
			sz = cpn / threshold;
			if( !sz ) sz = 1;
		}else{
			sz = 1;
		}
	}else
		sz = pcount;
#ifndef __GNUC__
	ppageinfo *pages = (ppageinfo *)calloc(sz, sizeof(ppageinfo));
#else
	ppageinfo pages[sz];
#endif

	int pagesin = 0;
	if ( fu ) for(pageinfo *cpi = fu; cpi && (pagesin<sz) ; cpi=cpi->last ){
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
	}else if(pagesin){
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

void NCPagedFile :: initCache()
{
	lu = fu = 0;

	if(!IsOk())
		return;

	size = ((cpn)<<3)/7;
	if ( cont ) free ( cont );
	cont = (struct pageinfo *)calloc(size,sizeof(struct pageinfo));
	for (unsigned i = 0; i < size; ++i) cont[i].st = EMPTYCELL;
	// allocate dummy page
	pageinfo *thepage = allocInfoByN(-1);
	thepage->m = 0;
	if ( PageSize ) thepage->buf = (char*) malloc(PageSize);
	else thepage->buf = 0;

	thepage->last = thepage->first = 0;
	lu = fu = thepage;
	cpcount=1;
}

int	NCPagedFile :: Update(int acces)
{
	if(m_count == 0){
		m_buffer= 0;
		return 0;
	}
	char *sb = 0;
	int count;
	long page=m_first- m_count;
	pageinfo **thepages= 0, **next;

	m_first-= m_count;

	do{
		if(m_count > cpn)
			count= cpn;
		else
			count= m_count;

		if(thepages == 0){
			if((thepages= (pageinfo **)malloc(sizeof(pageinfo *)*count)) == 0)
				return -5;
			next= thepages;
		}
		while(count--){
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
			*next = allocInfoByN(page);
			(*next)->m = 0;
			(*next) ->buf = sb;
			// link page to top
			lu->last = *next;
			(*next)->first = lu;
			(*next)->last = 0;
			lu = *next;
			cpcount++;
			page++;
			next++;
		}
		if(acces == ACE_OS_O_RDONLY){
			int indx= 0;
			m_readed.pFileHandles= m_postFileHandles;
			m_readed.accesMode= m_mode;
			m_readed.processMode= ACE_OS_O_RDONLY;
			m_readed.FileName= FileName;
			m_readed.maxFile_per_bytes= m_max_paged_file_per_bytes;
			m_readed.pFilePoss= m_postFilePoss;
			m_readed.pHeader= SystemPageBuf;
			m_readed.pUncompressBuffer= rbuf;
			m_readed.pPackTable= (unsigned int*)pageOffs;
			m_readed.PackArraySize= m_PackArraySize;
			m_readed.MessageForNextFunc= m_MessageForNextFunc;
			m_readed.CloseProcessFunc= m_CloseProcessFunc;
			m_readed.page= m_first;
			m_readed.buf= m_buffer;
			ROinitCntxt();
//#if defined(BRDR) || defined(BRDR32) || defined(INSTLL_CIB)
			m_readed.pCrptTag= m_pCryptoTag;
//#endif
			
			indx= IsNextTom( &m_readed );
			long curr_page= m_readed.page;
			
			if(m_count > cpn)
				count= cpn;
			else
				count= m_count;
				
			m_readed.page= m_first + count;
			if(indx == IsNextTom( &m_readed )){
				m_readed.page= curr_page;
				
				if(otherFileOpen(indx, &m_readed))
					return -1;

				if(m_postFilePoss[indx] != curr_page
					&& c_io_lseek ( m_postFileHandles[indx],
						curr_page * PageSize, ACE_OS_SEEK_SET ) != curr_page * PageSize)
					return -1;
	
				if(c_io_read(m_postFileHandles[indx], m_buffer, count * PageSize) != count * PageSize){
					m_postFilePoss[indx] = curr_page;
					return -1;
				}
	
				m_postFilePoss[indx]= curr_page+ count;
	
				for(indx= 0; indx < count; indx++){
					if(memcpy(thepages[indx]->buf, m_buffer, PageSize) == 0)
						return -1;
					m_buffer = (char*)m_buffer + PageSize;
				}
				m_first += count;
			}else
   //#endif
			for(indx= 0; indx < count; indx++){
				if(	!PagedFile::GetPage(m_first, m_buffer)
					|| memcpy(thepages[indx]->buf, m_buffer, PageSize) == 0)
					return -1;
				m_buffer = (char*)m_buffer + PageSize;
				m_first++;
			}
		}else{
			free(thepages);
			m_buffer = 0;
			return -1;
		}
	}while((m_count -= count) > 0);

	free(thepages);
	m_buffer = 0;
	return 0;
}

int	NCPagedFile :: GetPage ( int page, void * buf )
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
	}else if(m_buffer != 0 && m_first==page){
		m_first++;
		m_count++;
		return 1;
	}else{
		if(m_buffer != 0 && Update(ACE_OS_O_RDONLY))
			return 0;
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
		thepage = allocInfoByN(page);
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

int	NCPagedFile :: PutPage ( int page, void * buf )
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
		thepage = allocInfoByN(page);
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

int NCPagedFile :: Delete(int Remove)
{
	int ret= PagedFile::Delete(Remove);

	if(PageSize != 512 && SystemPageBuf){
		FreeBuf(SystemPageBuf);
		SystemPageBuf= 0;
	}
	return ret;
}
