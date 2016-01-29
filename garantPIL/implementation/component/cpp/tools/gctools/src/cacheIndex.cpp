#include "shared/Core/fix/mpcxc.h"
/*
 * cvs id was here $
 */
#include <cstdio>
#include <deque>

#include "cacheIndex.h"
#include "gardefs.h"
#include "index.h"
#include "hindex.h"
#include "refcol.h"
#include "doccol.h"
#include "stringz.h"
#include "FString.SplaySet.h"
#include "recode.h"
#include "u_int64_t.SplaySet.h"

static int write2index(Index *idx, const void *k, const void *d, size_t len);
static int w_str2index(Index *idx, const char *k, const void *d, size_t len);
extern	bool	b_recode;

CIdxShortInt :: CIdxShortInt(Index *i): mp(0), idx(i) { }
CIdxDate :: CIdxDate(Index *i): mp(0), idx(i) { }
CIdxRefDate :: CIdxRefDate(Index *i): mp(0), idx(i) { }
CIdxShortRef :: CIdxShortRef(Index *i): mp(0), idx(i) { }
CIdxString :: CIdxString(Index *i): mp(0), idx(i) { }

void CIdxShortInt::add(u_int32_t id, int status)
{
	u_int32_tSplaySet *st = (u_int32_tSplaySet*) (mp[status]);
	if( !st ){
		st = new u_int32_tSplaySet();
		mp[status] = (caddr_t) st;
	}
	st->add(id);
}


void CIdxDate::add(const date *d, u_int32_t id)
{
	assert( sizeof(date) == sizeof(u_int32_t) );
	u_int32_tSplaySet *st = (u_int32_tSplaySet*) (mp[*(u_int32_t*)d]);
	if( !st ){
		st = new u_int32_tSplaySet();
		mp[*(u_int32_t*)d] = (caddr_t) st;
	}
	st->add(id);
}

void CIdxRefDate::add(const date *d, u_int32_t id, u_int32_t sub)
{
	assert( sizeof(date) == sizeof(u_int32_t) );
	u_int64_tSplaySet *st = (u_int64_tSplaySet*) (mp[*(u_int32_t*)d]);
	if( !st ){
		st = new u_int64_tSplaySet();
		mp[*(u_int32_t*)d] = (caddr_t) st;
	}
	u_int64_t to_add = (((u_int64_t)id)<<32) + ((u_int64_t)sub);
	st->add(to_add);
}

void CIdxRefDate::add(const date d, u_int32_t id, u_int32_t sub)
{
	add(&d, id, sub);
}

void CIdxShortRef::add(const short d, u_int32_t id, u_int32_t sub)
{
	u_int64_tSplaySet *st = (u_int64_tSplaySet*) (mp[(u_int32_t)d]);
	if( !st ){
		st = new u_int64_tSplaySet();
		mp[(u_int32_t)d] = (caddr_t) st;
	}
	u_int64_t to_add = (((u_int64_t)id)<<32) + ((u_int64_t)sub);
	st->add(to_add);
}

void CIdxString::add(FString &s, u_int32_t id)
{
	u_int32_tSplaySet *st = 0;
	if( mp.contains(s) ){
		st = (u_int32_tSplaySet*) (mp[s]);
	}else{
		FString tmp(s.chars(),s.length());
		st = new u_int32_tSplaySet();
		mp[tmp] = (caddr_t) st;
	}
	st->add(id);
}

void CIdxString::add(const char *sp, size_t l, u_int32_t id)
{
#ifdef	WINENCODE
	char* recode = strdup( sp );
	if (b_recode) Recoding(cd_dos,cd_win,recode,sp);
	FString s(recode,l);
	free(recode);
#else
	FString s(sp,l);
#endif
	u_int32_tSplaySet *st = 0;

	if( mp.contains(s) ){
		st = (u_int32_tSplaySet*) (mp[s]);
		s.bDoFree = 1;
	}else{
		st = new u_int32_tSplaySet();
		mp[s] = (caddr_t) st;
	}
	st->add(id);
}


CIdxShortInt :: ~CIdxShortInt()
{
	int nitems = mp.length();
	if ( !nitems ) {
		printf("Index %s shutdown completed (empty)\n", idx->Name);
		return;
	}
	int lastP = -1;
	int count =0;
	u_int32_t ll= 0, *ba= 0, *p;
	for( Pix ki=mp.first();ki;mp.next(ki) ){
		count++;
		int tmp = (count*100)/nitems;
		if( tmp > lastP ){
			lastP = tmp;
			printf("Shutting down %s index: %d keys, %d%% done.\r", idx->Name, nitems, lastP);
			fflush(stdout);
		}
		u_int32_t k = mp.key(ki);
		u_int32_tSplaySet *st = (u_int32_tSplaySet*) mp.contents(ki);
		u_int32_t l = st->length();
		if( l ){
			if(l > ll){ ba = (u_int32_t*)realloc(ba, sizeof(u_int32_t)*l); ll= l; }
			p = ba;
			for( Pix i=st->first(); i; st->next(i) ) *p++ = (*st)(i);
			int16_t rk = (int16_t)k;
			write2index(idx,&rk,ba,l*sizeof(u_int32_t) );
		}
		delete st;
	}
	if(ba) free(ba);
	printf("Index %s shutdown completed; total %d keys processed.\n", idx->Name, nitems );
}

CIdxDate :: ~CIdxDate()
{
	int nitems = mp.length();
	if ( !nitems ) {
		printf("Index %s shutdown completed (empty)\n", idx->Name);
		return;
	}
	int lastP = -1;
	int count =0;
	u_int32_t ll= 0, *ba= 0, *p;
	for( Pix ki=mp.first();ki;mp.next(ki) ){
		count++;
		int tmp = (count*100)/nitems;
		if( tmp > lastP ){
			lastP = tmp;
			printf("Shutting down %s index: %d keys, %d%% done.\r", idx->Name, nitems, lastP);
			fflush(stdout);
		}
		u_int32_t k = mp.key(ki);
		u_int32_tSplaySet *st = (u_int32_tSplaySet*) mp.contents(ki);
		u_int32_t l = st->length();
		if( l ){
			if(l > ll){ ba = (u_int32_t*)realloc(ba, sizeof(u_int32_t)*l); ll= l; }
			p = ba;
			for( Pix i=st->first(); i; st->next(i) ) *p++ = (*st)(i);
			write2index(idx,&k,ba,l*sizeof(u_int32_t) );
		}
		delete st;
	}
	if(ba) free(ba);
	printf("Index %s shutdown completed; total %d keys processed.\n", idx->Name, nitems );
}

CIdxRefDate :: ~CIdxRefDate()
{
	int nitems = mp.length();
	if ( !nitems ) {
		printf("Index %s shutdown completed (empty)\n", idx->Name);
		return;
	}
	int lastP = -1;
	int count =0;
	u_int64_t ll= 0, *ba= 0, *p;
	for( Pix ki=mp.first();ki;mp.next(ki) ){
		count++;
		int tmp = (count*100)/nitems;
		if( tmp > lastP ){
			lastP = tmp;
			printf("Shutting down %s index: %d keys, %d%% done.\r", idx->Name, nitems, lastP );
			fflush(stdout);
		}
		u_int32_t k = mp.key(ki);
		u_int64_tSplaySet *st = (u_int64_tSplaySet*) mp.contents(ki);
		u_int32_t l = st->length();
		if (l) {
			if(l > ll) {
				ba = (u_int64_t*)realloc(ba, sizeof(u_int64_t)*l); 
				ll= l;
			}
			p = ba;
			for( Pix i=st->first(); i; st->next(i) ) {
				u_int64_t ati = (*st)(i);
				u_int64_t toput = (ati >> 32) + ((ati & 0xFFFFFFFF) << 32);
				*p++ = toput;
			}
			write2index(idx,&k,ba,l*sizeof(u_int64_t) );
		}
		delete st;
	}
	if(ba) free(ba);
	printf("Index %s shutdown completed; total %d keys processed.\n", idx->Name, nitems );
}

CIdxShortRef :: ~CIdxShortRef ()
{
	int nitems = mp.length();
	if ( !nitems ) {
		printf("Index %s shutdown completed (empty)\n", idx->Name);
		return;
	}
	int lastP = -1;
	int count =0;
	u_int64_t ll= 0, *ba= 0, *p;
	for( Pix ki=mp.first();ki;mp.next(ki) ){
		count++;
		int tmp = (count*100)/nitems;
		if( tmp > lastP ){
			lastP = tmp;
			printf("Shutting down %s index: %d keys, %d%% done.\r", idx->Name, nitems, lastP );
			fflush(stdout);
		}
		u_int32_t k = mp.key(ki);
		u_int64_tSplaySet *st = (u_int64_tSplaySet*) mp.contents(ki);
		u_int32_t l = st->length();
		if (l) {
			if(l > ll) {
				ba = (u_int64_t*)realloc(ba, sizeof(u_int64_t)*l); 
				ll= l;
			}
			p = ba;
			for( Pix i=st->first(); i; st->next(i) ) {
				u_int64_t ati = (*st)(i);
				u_int64_t toput = (ati >> 32) + ((ati & 0xFFFFFFFF) << 32);
				*p++ = toput;
			}
			write2index(idx,&k,ba,l*sizeof(u_int64_t) );
		}
		delete st;
	}
	if(ba) free(ba);
	printf("Index %s shutdown completed; total %d keys processed.\n", idx->Name, nitems );
}

CIdxString :: ~CIdxString()
{
	int nitems = mp.length();
	if ( !nitems ) {
		printf("Index %s shutdown completed (empty)\n", idx->Name);
		return;
	}
	int lastP = -1;
	int count =0;
	u_int32_t ll= 0, *ba= 0, *p;

	char *key = new char [idx->KeyLength];
	for( Pix ki=mp.first();ki;mp.next(ki) ){
		count++;
		int tmp = (count*100)/nitems;
		if( tmp > lastP ){
			lastP = tmp;
			printf ("Shutting down %s index: %d keys, %d%% done.\r", idx->Name, nitems, lastP);
		}
		FString k = mp.key(ki);
		u_int32_tSplaySet *st = (u_int32_tSplaySet*) mp.contents(ki);
		u_int32_t l = st->length();
		if( l ){
			if(l > ll){ ba = (u_int32_t*)realloc(ba, sizeof(u_int32_t)*l); ll= l; }
			p = ba;
			for( Pix i=st->first(); i; st->next(i) )
				*p++ = (*st)(i);
			strcpy (key, k.chars ());
			w_str2index (idx, key, ba, l*sizeof(u_int32_t));
		}
		delete st;
	}
	delete []key;
	if(ba) free(ba);
	printf("Index %s shutdown completed; total %d keys processed.\n", idx->Name, nitems );

	for( Pix i=mp.first();i;mp.next(i) )
		mp.key(i).bDoFree =1;
}


int write2index(Index *idx, const void *k, const void *d, size_t len)
{
	Stream *str = idx->Open((void *)k, 1 );
	if( str ){
		if( len != (unsigned) (str->Write((void *)d,len)) ){
			fprintf(stderr, "Warning: partial write on an index.\n");
			idx->Close(str);
			return 1;
		}
		idx->Close(str);
	}else{
		fprintf(stderr, "Can't open stream on an index.\n");
		return 1;
	}
	return 0;
}

int w_str2index(Index *idx, const char *k, const void *d, size_t len)
{
	char key[256]; strcpy(key,k);

	Stream *str = idx->Open((void *)key, 1 );
	if( str ){
		if( len != (unsigned) (str->Write((void *)d,len)) ){
			fprintf(stderr, "Warning: partial write on an index.\n");
			idx->Close(str);
			return 1;
		}
		idx->Close(str);
	}else{
		fprintf(stderr, "Can't open stream on an index.\n");
		return 1;
	}
	return 0;
}

CIdxHStringIndex :: CIdxHStringIndex(HIndex *i): mp(0), idx(i) {}

CIdxHStringIndex::TreeNode :: ~TreeNode()
{
	
}
void CIdxHStringIndex::buildHindexTree(DataProcessor *dp)
{
	printf ("Shutting down %s index\r", idx->Name);

	TreeNode root(idx);
	int rks = idx->KeyLength - idx->nstreams*(STRSZSZ+idx->ImmDataSize);
	root.key = malloc(rks);
	bzero(root.key,rks);
	idx->Level(root.key) = -1;
	for( Pix i=mp.first(); i; mp.next(i) ){
		char *thekey = strdup(mp.key(i).chars());
		root.takeTextKey(idx->LastId,thekey,mp.contents(i));
		free(thekey);
	}
	root.collectData(dp);
	root.countChildren();
	root.prepublish(dp);
	root.publish(dp);
	root.clearData(dp);

	printf("Index %s shutdown completed; total %d keys processed.\n", idx->Name, idx->LastId);
}

void CIdxHStringIndex::TreeNode::publish ( DataProcessor *dp )
{
	if( idx->Level(key) != -1 ){
		dp->publishData(key, data );
	}
	for( int i=0; i< nnodes; i++ )
		node[i]->publish(dp);
}

u_int32_t CIdxHStringIndex::TreeNode::countChildren()
{
	u_int32_t allMy = 0;
	for( int i=0; i< nnodes; i++)
		allMy += node[i]->countChildren();
	allMy += nnodes;

	idx->OwnChildrenCount(key) = nnodes;
	idx->AllChildrenCount(key) = allMy;

	return allMy;
}

int CIdxHStringIndex::TreeNode::prepublish(DataProcessor *dp)
{
	int all = 0;

	if( idx->Level(key) != -1 )
		if ( dp->prepublishData(key, data ))
			all++;

	int ch = 0;
	for( int i=0; i< nnodes; i++ ) {
		int acount = node[i]->prepublish(dp);
		if ( acount ) {
			all += acount;
			ch  += acount;
		}
		else
			idx->OwnChildrenCount(key)--;
	}

	idx->AllChildrenCount(key) = ch;

	return all;
}

void CIdxHStringIndex::TreeNode::collectData(DataProcessor *dp)
{
	for( int i=0; i< nnodes; i++){
		node[i]->collectData(dp);
		if( idx->Level(key) != -1 ){
			dp->mergeData( &data, node[i]->data );
		}
	}
}

void CIdxHStringIndex::TreeNode::clearData(DataProcessor *dp)
{
	for( int i=0; i< nnodes; i++)
		node[i]->clearData(dp);

	if( idx->Level(key) != -1 ){
		dp->clearData( data );
		data = 0;
	}
}

void CIdxHStringIndex::TreeNode::takeTextKey(int &id,char*k,void*d)
{
	char *p=strchr(k,'\\');
	if( p ) {
		*p = 0;
	}
	int i;
	for( i=0; i< nnodes; i++ ){
		if ( idx->CompareKeys(idx->Text(node[i]->key),k) == 0){
			break;
		}
	}
	if( i >= nnodes ){
		// no such key - allocate node
		if ( nnodes >= a_nnodes ){
			a_nnodes +=10;
			node = (TreeNode**)realloc(node,sizeof(TreeNode)*a_nnodes);
		}
		node[i] = new TreeNode(idx);
		nnodes++;
		int rks = idx->KeyLength - 
			idx->nstreams*(STRSZSZ+idx->ImmDataSize);
		node[i]->key = malloc(rks);
		if( ! node[i]->key ){
			fprintf(stderr, "\nGive me more memory next time!\n");
			getchar();
			exit(0);
		}
		bzero(node[i]->key,rks);
		idx->Level(node[i]->key) = idx->Level(key)+1;
		idx->Id(node[i]->key) = ++id;
		idx->Parent(node[i]->key) = idx->Id(key);
		strcpy((char*)(idx->Text(node[i]->key)), k );
	}

	if( p && p[1] ){
		node[i]->takeTextKey(id,p+1,d);
	}else{
		node[i]->data = d;
	}
}

CIdxClass :: CIdxClass(HIndex *i): CIdxHStringIndex (i) {}

void CIdxClass::add(const char *sp, size_t l, u_int32_t t, u_int32_t sub)
{
#ifdef	WINENCODE
	char* recode = strdup( sp );
	if (b_recode) Recoding(cd_dos,cd_win,recode,sp);
	FString s(recode,l);
	free(recode);
#else
	FString s(sp,l);
#endif

	ClassData *cd = 0;
	if( mp.contains(s) ){
		cd = (ClassData*) (mp[s]);
		s.bDoFree = 1;
	}else{
		cd = (ClassData*)malloc( sizeof(ClassData));
		bzero((caddr_t)cd, sizeof(ClassData));
		mp[s] = (caddr_t) cd;
	}
	
	if (cd->rc == 0)
		cd->rc = new std::deque<u_int64_t>;

	u_int64_t rf = (((u_int64_t) t) << 32) + sub;
	cd->rc->push_back (rf);
}

void CIdxClass::add(const char *sp, size_t l, const char *str, size_t len)
{
#ifdef	WINENCODE
	char* recode = strdup( sp );
	if (b_recode) Recoding(cd_dos,cd_win,recode,sp);
	FString s(recode,l);
	free(recode);

	recode = strdup( str );
	if (b_recode) Recoding(cd_dos,cd_win,recode,str);
	FString data(recode,len);
	free(recode);
#else
	FString s(sp,l);
	FString data(str,len);
#endif

	ClassData *cd = 0;
	if( mp.contains(s) ){
		cd = (ClassData*) (mp[s]);
		s.bDoFree = 1;
	}else{
		cd = (ClassData*)malloc( sizeof(ClassData));
		bzero((caddr_t)cd, sizeof(ClassData));
		mp[s] = (caddr_t) cd;
	}
	if( cd->ss == 0 ){
		cd->ss = new FStringSplaySet();
	}

	if( cd->ss->contains(data) ){
		data.bDoFree = 1;
	}else{
		cd->ss->add(data);
	}
}


void CIdxClass::ClassDP::publishData(void *key, void *d)
{
	ClassData *tcd = (ClassData*) d;

	if (tcd->rc && tcd->rc->size ()) {
		std::deque<u_int64_t> *deque_refs = tcd->rc;
		std::sort (deque_refs->begin (), deque_refs->end ());
		RefCollection refs;
		for (std::deque<u_int64_t>::const_iterator it = deque_refs->begin (); it != deque_refs->end (); ++it) {
			Ref at_it = {(long)((*it>>32) & 0xFFFFFFFF), (long) (*it & 0xFFFFFFFF)};
			refs.Insert (&at_it);
		}
		Stream *str = idx->Index::OpenN(key,0,1);
		refs.Put (str);
		idx->Close (str);
	}

	if (tcd->ss) {
		char *buf = 0;
		int offset = 0;
		int bufsize = 0;
		for (Pix i= tcd->ss->first(); i; tcd->ss->next(i) ){
			FString s = (*(tcd->ss))(i);
			if( offset + (int)s.length() +1 >= bufsize ){
				bufsize += 8000 + s.length();
				buf = (char*)realloc( buf, bufsize);
			}
			strcpy(buf+offset, s.chars());
			offset += s.length() +1;
		}
		free (buf);
	}
}

void CIdxClass::ClassDP::clearData(void *d)
{
	ClassData *tcd = (ClassData*) d;
	if( tcd->rc ){
		delete tcd->rc;
		tcd->rc = 0;
	}
	if( tcd->ss ){
		for (Pix i= tcd->ss->first(); i; tcd->ss->next(i) ){
			(*(tcd->ss))(i).bDoFree = 1;
		}
		delete tcd->ss;
		tcd->ss = 0;
	}
	free(d);
}

extern	bool	bClassMerge;

void CIdxClass::ClassDP::mergeData(void **target, void *source)
{
	if (!source)
		return;

	if (!*target)
		*target = calloc (1, sizeof(ClassData));

	ClassData *tcd = (ClassData*) *target;
	ClassData *scd = (ClassData*) source;
	
	if (scd->rc) {
		if (!tcd->rc)
			tcd->rc = new std::deque<u_int64_t>;

		std::deque<u_int64_t>::const_iterator it;
		RefCollection source_refs, target_refs;
		for (it = scd->rc->begin (); it != scd->rc->end (); ++it) {
			Ref at_it = {(long)((*it>>32) & 0xFFFFFFFF), (long) (*it & 0xFFFFFFFF)};
			source_refs.Insert (&at_it);
		}
		for (it = tcd->rc->begin (); it != tcd->rc->end (); ++it) {
			Ref at_it = {(long)((*it>>32) & 0xFFFFFFFF), (long) (*it & 0xFFFFFFFF)};
			target_refs.Insert (&at_it);
		}
		bClassMerge = true;
		target_refs.Merge (source_refs);
		bClassMerge = false;

		tcd->rc->clear ();
		for (int pages = 0; pages < target_refs.PageCount; pages++) {
			Ref* ptr = (Ref*) target_refs.Pages [pages];
			for (int elems = 0; elems < target_refs.Count [pages]; elems++, ptr++) {
				u_int64_t rf = (((u_int64_t) ptr->DocId) << 32) + ptr->Sub;
				tcd->rc->push_back (rf);
			}
		}

		/*
		if (!tcd->rc)
			tcd->rc = new RefCollection();

		bClassMerge = true;
		tcd->rc->Merge(*(scd->rc));
		bClassMerge = false;
		*/
	}
	if( scd->ss ){
		if( !tcd->ss )
			tcd->ss = new FStringSplaySet();
/* There is a bug in this line. Because of operator |= don't copy
   strings, so we have the same pointer in two nodes.
   When we deleting nodes, the deleting of the second node will failed */
/*		(*(tcd->ss)) |= (*(scd->ss));*/
		for (Pix i=scd->ss->first();i;scd->ss->next(i)) {
			FString new_s(((*(scd->ss))(i)).chars());
			tcd->ss->add(new_s);
		}
	}
}

void CIdxClass::ClassDP::printData(void *key, void *d)
{
	ClassData *tcd = (ClassData*) d;
	printf("== id: %d == pid %d == level %d == '%s' ==\n",
		   idx->Id(key), idx->Parent(key), idx->Level(key), idx->Text(key));
	if( tcd->rc ){
		/*
		for(int i=0; i< tcd->rc->ItemCount; i++ ){
			Ref rf = (*(tcd->rc))[i] ;
			printf( "(%ld, %ld)", rf.DocId, rf.Sub );
		}
		printf("\n");
		*/
	}
	if( tcd->ss ){
		char *buf = 0;
		int offset = 0;
		int bufsize = 0;
		for (Pix i= tcd->ss->first(); i; tcd->ss->next(i) ){
			FString s = (*(tcd->ss))(i);
			printf("\t<'%s'>\n", s.chars() );
		}
		printf("\n");
	}
}



CIdxClass::~CIdxClass()
{
	ClassDP cdp(idx);
	buildHindexTree(&cdp);
}


CIdxAdopted :: CIdxAdopted(HIndex *i): CIdxHStringIndex (i) {}

void CIdxAdopted::add(const char *sp, size_t l, u_int32_t t)
{
#ifdef	WINENCODE
	char* recode = strdup( sp );
	if (b_recode) Recoding(cd_dos,cd_win,recode,sp);
	FString s(recode,l);
	free(recode);
#else
	FString s(sp,l);
#endif

	AdoptedData *cd = 0;
	if( mp.contains(s) ){
		cd = (AdoptedData*) (mp[s]);
		s.bDoFree = 1;
	}else{
		cd = (AdoptedData*)malloc( sizeof(AdoptedData));
		bzero((caddr_t)cd, sizeof(AdoptedData));
		mp[s] = (caddr_t) cd;
	}
	if( cd->dc == 0 )
		cd->dc = new std::deque<long>;
		//cd->dc = new DocCollection();

	//cd->dc->Add(t);
	cd->dc->push_back (t);
}

void CIdxAdopted::add(const char *sp, size_t l, const char *str, size_t len)
{
#ifdef	WINENCODE
	char* recode = strdup( sp );
	if (b_recode) Recoding(cd_dos,cd_win,recode,sp);
	FString s(recode,l);
	free(recode);

	recode = strdup( str );
	if (b_recode) Recoding(cd_dos,cd_win,recode,str);
	FString data(recode,len);
	free(recode);
#else
	FString s(sp,l);
	FString data(str,len);
#endif

	AdoptedData *cd = 0;
	if( mp.contains(s) ){
		cd = (AdoptedData*) (mp[s]);
		s.bDoFree = 1;
	}else{
		cd = (AdoptedData*)malloc( sizeof(AdoptedData));
		bzero((caddr_t)cd, sizeof(AdoptedData));
		mp[s] = (caddr_t) cd;
	}
	if( cd->ss == 0 ){
		cd->ss = new FStringSplaySet();
	}

	if( cd->ss->contains(data) ){
		data.bDoFree = 1;
	}else{
		cd->ss->add(data);
	}
}


void CIdxAdopted::AdoptedDP::publishData(void *key, void *d)
{
	AdoptedData *tcd = (AdoptedData*) d;
	if( tcd->dc && /*tcd->dc->Count*/tcd->dc->size ()){
		Stream *str = idx->Index::OpenN (key,0,1);
		std::sort (tcd->dc->begin (), tcd->dc->end ());
		DocCollection docs;
		for (std::deque<long>::const_iterator it = tcd->dc->begin (); it != tcd->dc->end (); ++it) {
			long at_it = *it;
			docs.Insert (&at_it);
		}
		//tcd->dc->Put(str);
		docs.Put (str);
		idx->Close(str);
	}
	if( tcd->ss ){
		char *buf = 0;
		int offset = 0;
		int bufsize = 0;
		for (Pix i= tcd->ss->first(); i; tcd->ss->next(i) ){
			FString s = (*(tcd->ss))(i);
			if( offset + (int)s.length() +1 >= bufsize ){
				bufsize += 8000 + s.length();
				buf = (char*)realloc( buf, bufsize);
			}
			strcpy(buf+offset, s.chars());
			offset += s.length() +1;
		}
		free(buf);
	}
}
void CIdxAdopted::AdoptedDP::clearData(void *d)
{
	AdoptedData *tcd = (AdoptedData*) d;
	if( tcd->dc ){
		delete tcd->dc;
		tcd->dc = 0;
	}
	if( tcd->ss ){
		for (Pix i= tcd->ss->first(); i; tcd->ss->next(i) )
			(*(tcd->ss))(i).bDoFree = 1;
		delete tcd->ss;
		tcd->dc = 0;
	}
	free(d);
}

void CIdxAdopted::AdoptedDP::mergeData(void **target, void *source)
{
	if( !source )
		return;

	if( ! *target )
		*target = calloc(1, sizeof(AdoptedData));
	AdoptedData *tcd = (AdoptedData*) *target;
	AdoptedData *scd = (AdoptedData*) source;
	if( scd->dc ){
		if( !tcd->dc )
			//tcd->dc = new DocCollection();
			tcd->dc = new std::deque <long>;
		//tcd->dc->Merge(*(scd->dc));
		tcd->dc->insert (tcd->dc->begin (), scd->dc->begin (), scd->dc->end ());
	}
	if( scd->ss ){
		if( !tcd->ss )
			tcd->ss = new FStringSplaySet();
/* There is a bug in this line. Because of operator |= don't copy
   strings, so we have the same pointer in two nodes.
   When we deleting nodes, the deleting of the second node will failed */
/*		(*(tcd->ss)) |= (*(scd->ss));*/
		for (Pix i=scd->ss->first();i;scd->ss->next(i))
		{
			FString new_s(((*(scd->ss))(i)).chars());
			tcd->ss->add(new_s);
		}

	}
}

void CIdxAdopted::AdoptedDP::printData(void *key, void *d)
{
	/*
	AdoptedData *tcd = (AdoptedData*) d;
	printf("== id: %d == pid %d == level %d == '%s' ==\n",
		   idx->Id(key), idx->Parent(key), idx->Level(key), idx->Text(key));
	if( tcd->dc ){
		for(int i=0; i< tcd->dc->ItemCount; i++ ){
			printf( "(%ld)", (*(tcd->dc))[i] );
		}
		printf("\n");
	}
	if( tcd->ss ){
		char *buf = 0;
		int offset = 0;
		int bufsize = 0;
		for (Pix i= tcd->ss->first(); i; tcd->ss->next(i) ){
			FString s = (*(tcd->ss))(i);
			printf("\t<'%s'>\n", s.chars() );
		}
		printf("\n");
	}
	*/
}



CIdxAdopted::~CIdxAdopted()
{
	AdoptedDP cdp(idx);
	buildHindexTree(&cdp);
}

///////////////////////////////////////////////////////////////////////

CIdxHRefs :: CIdxHRefs(HIndex *i): CIdxHStringIndex (i) {}

void CIdxHRefs::add(const char *sp, size_t l, u_int32_t t, u_int32_t sub)
{
#ifdef	WINENCODE
	char* recode = strdup( sp );
	if (b_recode) Recoding(cd_dos,cd_win,recode,sp);
	FString s(recode,l);
	free(recode);
#else
	FString s(sp,l);
#endif

	RefCollection *cd = 0;
	if( mp.contains(s) ){
		cd = (RefCollection*) (mp[s]);
		s.bDoFree = 1;
	}else{
		cd = new RefCollection();
		mp[s] = (caddr_t) cd;
	}
	Ref rf; rf.DocId = t, rf.Sub = sub;

	cd->Add(rf);
}


void CIdxHRefs::HRefsDP::publishData(void *key, void *d)
{
	RefCollection *dc = (RefCollection *)d;
	if( dc && dc->Count){
		Stream *str = idx->Index::OpenN(key,0,1);
		dc->Put(str);
		idx->Close(str);
	}
}

void CIdxHRefs::HRefsDP::clearData(void *d)
{
	RefCollection *dc = (RefCollection *)d;
	if( dc )
		delete dc;
}

void CIdxHRefs::HRefsDP::mergeData(void **target, void *source)
{
	if( !source )
		return;

	if( ! *target )
		*target = new RefCollection();

	RefCollection *tdc = (RefCollection*) *target;
	RefCollection *sdc = (RefCollection*) source;
	if( sdc ){
		tdc->Merge(*(sdc));
	}
}


CIdxHRefs::~CIdxHRefs()
{
	HRefsDP cdp(idx);
	buildHindexTree(&cdp);
}

///////////////////////////////////////////////////////////////////////

CIdxHRefsEx :: CIdxHRefsEx(HIndex *i): CIdxHStringIndex (i) {}

void CIdxHRefsEx::add(const char *sp, size_t l, u_int32_t t, u_int32_t sub)
{
#ifdef	WINENCODE
	char* recode = strdup( sp );
	if (b_recode) Recoding(cd_dos,cd_win,recode,sp);
	FString s(recode,l);
	free(recode);
#else
	FString s(sp,l);
#endif

	std::deque<u_int64_t>* cd = 0;
	if( mp.contains(s) ){
		cd = (std::deque<u_int64_t>*) (mp[s]);
		s.bDoFree = 1;
	} else {
		cd = new std::deque<u_int64_t>;
		mp[s] = (caddr_t) cd;
	}
	u_int64_t rf = (((u_int64_t) t) << 32) + sub;
	cd->push_back (rf);
}


void CIdxHRefsEx::HRefsExDP::publishData(void *key, void *d)
{
	std::deque<u_int64_t> *dc = (std::deque<u_int64_t>*) d;
	if (dc && dc->size ()){
		std::sort (dc->begin (), dc->end ());
		RefCollection refs;
		for (std::deque<u_int64_t>::const_iterator it = dc->begin (); it != dc->end (); ++it) {
			Ref at_it = {(long)((*it>>32) & 0xFFFFFFFF), (long) (*it & 0xFFFFFFFF)};
			refs.Insert (&at_it);
		}

		Stream *str = idx->Index::OpenN (key,0,1);
		refs.Put (str);
		idx->Close (str);
	}
}

void CIdxHRefsEx::HRefsExDP::clearData(void *d)
{
	std::deque<u_int64_t> *dc = (std::deque<u_int64_t>*) d;
	if (dc)
		delete dc;
}

void CIdxHRefsEx::HRefsExDP::mergeData(void **target, void *source)
{
	if (!source)
		return;

	if (!*target)
		*target = new std::deque <u_int64_t>;

	std::deque <u_int64_t> *tdc = (std::deque <u_int64_t>*) *target;
	std::deque <u_int64_t> *sdc = (std::deque <u_int64_t>*) source;

	std::deque<u_int64_t>::const_iterator it;
	RefCollection source_refs, target_refs;
	for (it = sdc->begin (); it != sdc->end (); ++it) {
		Ref at_it = {(long)((*it>>32) & 0xFFFFFFFF), (long) (*it & 0xFFFFFFFF)};
		source_refs.Insert (&at_it);
	}
	for (it = tdc->begin (); it != tdc->end (); ++it) {
		Ref at_it = {(long)((*it>>32) & 0xFFFFFFFF), (long) (*it & 0xFFFFFFFF)};
		target_refs.Insert (&at_it);
	}
	target_refs.Merge (source_refs);

	tdc->clear ();
	for (int pages = 0; pages < target_refs.PageCount; pages++) {
		Ref* ptr = (Ref*) target_refs.Pages [pages];
		for (int elems = 0; elems < target_refs.Count [pages]; elems++, ptr++) {
			u_int64_t rf = (((u_int64_t) ptr->DocId) << 32) + ptr->Sub;
			tdc->push_back (rf);
		}
	}
}


CIdxHRefsEx::~CIdxHRefsEx()
{
	HRefsExDP cdp(idx);
	buildHindexTree(&cdp);
}

/////////////////////////////////////////////////////////////
CIdxHDocs :: CIdxHDocs (HIndex *i): CIdxHStringIndex (i) {}

void CIdxHDocs::add(const char *sp, size_t l, u_int32_t t)
{
#ifdef	WINENCODE
	char* recode = strdup( sp );
	if (b_recode) Recoding(cd_dos,cd_win,recode,sp);
	FString s(recode,l);
	free(recode);
#else
	FString s(sp,l);
#endif

	DocCollection *cd = 0;
	if( mp.contains(s) ){
		cd = (DocCollection*) (mp[s]);
		s.bDoFree = 1;
	}else{
		cd = new DocCollection();
		mp[s] = (caddr_t) cd;
	}

	cd->Add(t);
}


void CIdxHDocs::HDocsDP::publishData(void *key, void *d)
{
	DocCollection *dc = (DocCollection *)d;
	if( dc && dc->Count){
		Stream *str = idx->Index::OpenN(key,0,1);
		dc->Put(str);
		idx->Close(str);
	}
}

void CIdxHDocs::HDocsDP::clearData(void *d)
{
	DocCollection *dc = (DocCollection *)d;
	if( dc )
		delete dc;
}

void CIdxHDocs::HDocsDP::mergeData(void **target, void *source)
{
	if( !source )
		return;

	if( ! *target )
		*target = new DocCollection();

	DocCollection *tdc = (DocCollection*) *target;
	DocCollection *sdc = (DocCollection*) source;
	if( sdc ){
		tdc->Merge(*(sdc));
	}
}


CIdxHDocs::~CIdxHDocs()
{
	HDocsDP cdp(idx);
	buildHindexTree(&cdp);
}

/////////////////////////////////////////////////////////////
CIdxHDocsEx :: CIdxHDocsEx (HIndex *i): CIdxHStringIndex (i) {}

void CIdxHDocsEx::add(const char *sp, size_t l, u_int32_t t)
{
#ifdef	WINENCODE
	char* recode = strdup( sp );
	if (b_recode) Recoding(cd_dos,cd_win,recode,sp);
	FString s(recode,l);
	free(recode);
#else
	FString s(sp,l);
#endif

	std::deque<long> *cd = 0;
	if( mp.contains(s) ){
		cd = (std::deque<long>*) (mp[s]);
		s.bDoFree = 1;
	}else{
		cd = new std::deque <long>;
		mp[s] = (caddr_t) cd;
	}

	cd->push_back (t);
}


void CIdxHDocsEx::HDocsDP::publishData(void *key, void *d)
{
	std::deque<long> *dc = (std::deque<long>*)d;
	if (dc && dc->size ()) {
		std::sort (dc->begin (), dc->end ());
		DocCollection docs;
		for (std::deque<long>::const_iterator it = dc->begin (); it != dc->end (); ++it) {
			long at_it = *it;
			docs.Insert (&at_it);
		}

		Stream *str = idx->Index::OpenN (key,0,1);
		docs.Put (str);
		idx->Close(str);
	}
}

void CIdxHDocsEx::HDocsDP::clearData(void *d)
{
	std::deque<long>*dc = (std::deque<long>*)d;
	if (dc)
		delete dc;
}

void CIdxHDocsEx::HDocsDP::mergeData(void **target, void *source)
{
	if (!source)
		return;

	if (!*target)
		*target = new std::deque <long>;

	std::deque <long> *tdc = (std::deque <long>*) *target;
	std::deque <long> *sdc = (std::deque <long>*) source;
	tdc->insert (tdc->begin (), sdc->begin (), sdc->end ());
}

CIdxHDocsEx::~CIdxHDocsEx()
{
	HDocsDP cdp(idx);
	buildHindexTree(&cdp);
}

/////////////////////////////////////////////////////////////

CIdxPrefix :: CIdxPrefix(HIndex *i): CIdxHStringIndex (i) {}

void CIdxPrefix::add(const char *sp, size_t l, u_int32_t t, u_int32_t sub)
{
#ifdef	WINENCODE
	char* recode = strdup( sp );
	if (b_recode) Recoding(cd_dos,cd_win,recode,sp);
	FString s(recode,l);
	free(recode);
#else
	FString s(sp,l);
#endif
	PrefixData *cd = 0;
	if( mp.contains(s) ){
		cd = (PrefixData*) (mp[s]);
		s.bDoFree = 1;
	}else{
		cd = (PrefixData*)malloc( sizeof(PrefixData));
		bzero((caddr_t)cd, sizeof(PrefixData));
		mp[s] = (caddr_t) cd;
	}

	if (cd->rc == 0)
		cd->rc = new std::deque<u_int64_t>;

	u_int64_t rf = (((u_int64_t) t) << 32) + sub;
	cd->rc->push_back (rf);
}

void CIdxPrefix::add(const char *sp, size_t l, const char *str, size_t len)
{
#ifdef	WINENCODE
	char* recode = strdup( sp );
	if (b_recode) Recoding(cd_dos,cd_win,recode,sp);
	FString s(recode,l);
	free(recode);

	recode = strdup( str );
	if (b_recode) Recoding(cd_dos,cd_win,recode,str);
#else
	FString s(sp,l);
#endif

	PrefixData *cd = 0;
	if( mp.contains(s) ){
		cd = (PrefixData*) (mp[s]);
		s.bDoFree = 1;
	}else{
		cd = (PrefixData*)malloc( sizeof(PrefixData));
		bzero((caddr_t)cd, sizeof(PrefixData));
		mp[s] = (caddr_t) cd;
	}
	if( cd->indata + (int)len >= cd->maxdata ){
		cd->maxdata = cd->indata + len + 500;
		cd->data = (char *) realloc( cd->data, cd->maxdata );
	}
#ifdef	WINENCODE
	memcpy( cd->data + cd->indata, recode, len );
	free(recode);
#else
	memcpy( cd->data + cd->indata, str, len );
#endif
	cd->indata += len;
}

void CIdxPrefix::PrefixDP::publishData(void *key, void *d)
{
	PrefixData *tcd = (PrefixData*) d;
	if( tcd->rc && tcd->rc->size ()) {
		std::deque<u_int64_t> *deque_refs = tcd->rc;
		std::sort (deque_refs->begin (), deque_refs->end ());
		RefCollection refs;
		for (std::deque<u_int64_t>::const_iterator it = deque_refs->begin (); it != deque_refs->end (); ++it) {
			Ref at_it = {(long)((*it>>32) & 0xFFFFFFFF), (long) (*it & 0xFFFFFFFF)};
			refs.Insert (&at_it);
		}
		Stream *str = idx->Index::OpenN(key,0,1);
		refs.Put (str);
		idx->Close (str);
	}
}

void CIdxPrefix::PrefixDP::clearData(void *d)
{
	PrefixData *tcd = (PrefixData*) d;
	if( tcd->rc ){
		delete tcd->rc;
	}
	if( tcd->data ){
		free( tcd->data );
	}
	free(d);
}

void CIdxPrefix::PrefixDP::mergeData(void **target, void *source)
{
	if( !source )
		return;

	if( ! *target )
		*target = calloc(1, sizeof(PrefixData));

	PrefixData *tcd = (PrefixData*) *target;
	PrefixData *scd = (PrefixData*) source;
	if (scd->rc) {
		if (!tcd->rc)
			tcd->rc = new std::deque<u_int64_t>;

		std::deque<u_int64_t>::const_iterator it;
		RefCollection source_refs, target_refs;
		for (it = scd->rc->begin (); it != scd->rc->end (); ++it) {
			Ref at_it = {(long)((*it>>32) & 0xFFFFFFFF), (long) (*it & 0xFFFFFFFF)};
			source_refs.Insert (&at_it);
		}
		for (it = tcd->rc->begin (); it != tcd->rc->end (); ++it) {
			Ref at_it = {(long)((*it>>32) & 0xFFFFFFFF), (long) (*it & 0xFFFFFFFF)};
			target_refs.Insert (&at_it);
		}
		target_refs.Merge (source_refs);

		tcd->rc->clear ();
		for (int pages = 0; pages < target_refs.PageCount; pages++) {
			Ref* ptr = (Ref*) target_refs.Pages [pages];
			for (int elems = 0; elems < target_refs.Count [pages]; elems++, ptr++) {
				u_int64_t rf = (((u_int64_t) ptr->DocId) << 32) + ptr->Sub;
				tcd->rc->push_back (rf);
			}
		}

		/*
		if( !tcd->rc )
			tcd->rc = new RefCollection();
		tcd->rc->Merge(*(scd->rc));
		*/
	}
}

void CIdxPrefix::PrefixDP::printData(void *key, void *d)
{
	PrefixData *tcd = (PrefixData*) d;
	printf("== id: %d == pid %d == level %d == '%s' ==\n",
		   idx->Id(key), idx->Parent(key), idx->Level(key), idx->Text(key));
	if( tcd->rc ){
		/*
		for(int i=0; i< tcd->rc->ItemCount; i++ ){
			Ref rf = (*(tcd->rc))[i] ;
			printf( "(%ld, %ld)", rf.DocId, rf.Sub );
		}
		printf("\n");
		*/
	}
	if( tcd->data && tcd->indata){
		ZStrings dp(tcd->data, tcd->indata );
		for( int i = 0; i< dp.count(); i++){
			printf("<'%s'>\n", dp[i]->ptr );
		}
		printf("\n");
	}
}

CIdxPrefix::~CIdxPrefix()
{
	PrefixDP cdp(idx);
	buildHindexTree(&cdp);
}

int CIdxPrefix::PrefixDP::prepublishData(void *key, void *d)
{
	PrefixData *tcd = (PrefixData*) d;
	if( tcd->rc && tcd->rc->size ())
		return 1;
	else
		return 0;
}


