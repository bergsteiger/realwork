#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include <sys/types.h>

#include "garver.h"
#include "osdep.h"
#include "basemask.h"
#include "stdbase.h"
#include "gardefs.h"
#include "btiter.h"
#include "dociter.h"
#include "refcol.h"
#include "doccol.h"
#include "hnode.h"
#include "fstring.h"
#include "Pix.h"
#include "SplayMap.h"
#include "SplaySet.h"
#include "pack.h"

#include <map>

const	short	federalSegs[] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,171,198,199,200,201,202,206,207,208,209,211,212,213,214,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,235,238,239 };

SplaySet<short>	segs;
bool	b_single_base = false;
bool	b_check_documents = true;

static	YBase * b;
static	YBase ** bset = 0;
static	int nbases;

int checkBaseInfo()
{
	int i = 0, j = 0;
	Index * idx = b->FindIndex("Aux");

	Stream * str = idx -> OpenN ( "Base", 0 );
	
	if (!str)
	{
		fprintf(stdout, "FATAL_ERROR: Cannot load Aux Index in base '%s'\n",b->textFile->FileName);
		return 0;
	}
	
	int size = str->Length();
	
	BaseInfo *bi = (BaseInfo*) malloc ( size );
	int l = str -> Read ( bi, size ) / sizeof(BaseInfo);
	idx->Close(str);

	SplaySet<short> bases_ids;
	for (i = 0; i < l; i++)
		bases_ids.add(bi[i].BaseId);


	for (i = 0; i < nbases; i++)
	{
		Index * cidx = bset[i]->FindIndex("Aux");
		Stream * cstr = cidx -> OpenN ( "Base", 0 );
		
		if (!cstr)
		{
			fprintf(stdout, "FATAL_ERROR: Cannot load Aux Index in base '%s'\n",bset[i]->textFile->FileName);
			continue;
		}
		
		int csize = cstr->Length();
		
		BaseInfo *cbi = (BaseInfo*) malloc ( csize );
		int cl = cstr -> Read ( cbi, csize ) / sizeof(BaseInfo);
		cidx->Close(cstr);
		
		for (j = 0; j < cl; j++)
		{
			if (!bases_ids.contains(cbi[j].BaseId))
			{
				fprintf(stdout, "WARNING: Base '%s'. Segment '%ld' is not presented in main base '%s'.\n",bset[i]->textFile->FileName, cbi[j].BaseId, b->textFile->FileName);
			}

			if (cbi[j].RecCount < 0)
			{
				fprintf(stdout, "WARNING: Base '%s', segment: %d. RecCount is negative (%ld)\n",bset[i]->textFile->FileName, j, cbi[j].RecCount);
			}
			if (cbi[j].RecSize < 0)
			{
				fprintf(stdout, "WARNING: Base '%s', segment: %d. RecSize is negative (%ld)\n",bset[i]->textFile->FileName, j, cbi[j].RecSize);
			}
			if (cbi[j].DocCount < 0)
			{
				fprintf(stdout, "WARNING: Base '%s', segment: %d. DocCount is negative (%ld)\n",bset[i]->textFile->FileName, j, cbi[j].DocCount);
			}
			/*
			if (cbi[j].DocSize < 0)
			{
				fprintf(stdout, "WARNING: Base '%s', segment: %d. DocSize is negative (%ld)\n",bset[i]->textFile->FileName, j, cbi[j].DocSize);
			}
			*/
			if (cbi[j].FormsCount < 0)
			{
				fprintf(stdout, "WARNING: Base '%s', segment: %d. FormsCount is negative (%ld)\n",bset[i]->textFile->FileName, j, cbi[j].FormsCount);
			}
			if (cbi[j].GreenComments < 0)
			{
				fprintf(stdout, "WARNING: Base '%s', segment: %d. GreenComments is negative (%ld)\n",bset[i]->textFile->FileName, j, cbi[j].GreenComments);
			}
			if (cbi[j].HyperRefs < 0)
			{
				fprintf(stdout, "WARNING: Base '%s', segment: %d. HyperRefs is negative (%ld)\n",bset[i]->textFile->FileName, j, cbi[j].HyperRefs);
			}
			if (cbi[j].CommonDocCount < 0)
			{
				fprintf(stdout, "WARNING: Base '%s', segment: %d. CommonDocCount is negative (%ld)\n",bset[i]->textFile->FileName, j, cbi[j].CommonDocCount);
			}
			if (cbi[j].SplashTopic < 0)
			{
				fprintf(stdout, "WARNING: Base '%s', segment: %d. SplashTopic is negative (%ld)\n",bset[i]->textFile->FileName, j, cbi[j].SplashTopic);
			}
		}

		free(cbi);

	}
	free(bi);
	return 1;
}

int checkDocBelongs()
{
	SplaySet<short> bHere;
	SplaySet<short> baseHere;

	Index * cidx = b->FindIndex("Aux");
	Stream * cstr = cidx -> OpenN ( "Here", 0 );

	if (!cstr){
		fprintf(stdout, "FATAL_ERROR: Cannot load Aux Index in base '%s'\n",b->textFile->FileName);
	}

	int csize = cstr->Length();
		
	short * here_belongs = (short*) malloc ( csize );
	int cl = cstr -> Read ( here_belongs, csize ) / sizeof(short);
	cidx->Close(cstr);

	bHere.clear();

	for (int j = 0; j < cl; j++){
		bHere.add(here_belongs[j]);
	}

	free(here_belongs);

	for (int i = 0; i < nbases; i++) {
		Index * cidx = bset[i]->FindIndex("Aux");
		Stream * cstr = cidx -> OpenN ( "Here", 0 );
		
		if (!cstr)
		{
			fprintf(stdout, "FATAL_ERROR: Cannot load Aux Index in base '%s'\n",bset[i]->textFile->FileName);
			continue;
		}
		
		int csize = cstr->Length();
		
		short * here_belongs = (short*) malloc ( csize );
		int cl = cstr -> Read ( here_belongs, csize ) / sizeof(short);
		cidx->Close(cstr);

		baseHere.clear();

		for (int j = 0; j < cl; j++)
			baseHere.add(here_belongs[j]);

		free(here_belongs);

		if (bHere & baseHere){
			fprintf(stdout, "FATAL_ERROR: Cross link in complect found (%s, %s)\n",b->textFile->FileName,bset[i]->textFile->FileName);
		}

		DocIterator it (bset[i]);
		for (;!it.End();++it) {
			int count;
			short belongs[MAX_BASES];

			long docID = it.Id();
			if ( docID < 100000 ) continue;

			if ((count=bset[i]->FindDocAttr(docID,IDD_BASES,belongs,sizeof(belongs))/sizeof(short)) == 0) {
				fprintf(stdout,"FATAL_ERROR: Document %d in base %s not contains any belongs\n",docID,bset[i]->textFile->FileName);
				continue;
			}

			for (int j=0; j < count ;j++){
				if (!baseHere.contains(belongs[j])){
					bool found = false;
					if ( segs.length()) {
						for ( int ii = 0; ii < count && !found; ii++ )
							if ( segs.contains( belongs[ii] ))
								found = true;
					}

					if ( !found ) {
						bool bfederal = false;
						for ( short ii = 0; !bfederal && ii < sizeof( federalSegs ) / sizeof( short ); ii++ )
							bfederal = belongs[j] == federalSegs[ii];

						if ( bfederal )
							fprintf(stdout,"FATAL_ERROR: Segment '%d' is not presented in Base '%s', but contains doc '%d'\n",belongs[j],bset[i]->textFile->FileName,docID);
						else
							fprintf(stdout,"WARNING: Segment '%d' is not presented in Base '%s', but contains doc '%d'\n",belongs[j],bset[i]->textFile->FileName,docID);
					}
				}
			}
		}
	}
	return 1;
}

int checkCompInfo()
{
	Index * midx = b->FindIndex("Aux");

	Stream * mstr = midx -> OpenN ( "Comp", 0 );
	
	if (!mstr || !mstr->Length())
	{
		fprintf(stdout, "FATAL_ERROR: Cannot load 'Complect info' in base '%s'\n",b->textFile->FileName);
		return 0;
	}
	
	int msize = mstr->Length();
	
	BaseWeight *mbi = (BaseWeight*) malloc ( msize );
	int ml = mstr -> Read ( mbi, msize ) / sizeof(BaseWeight);
	midx->Close(mstr);

	for (int i = 0; i < nbases; i++)
	{
		Index * cidx = bset[i]->FindIndex("Aux");
		Stream * cstr = cidx -> OpenN ( "Comp", 0 );
		
		if (!cstr)
		{
			fprintf(stdout, "FATAL_ERROR: Cannot load Aux Index in base '%s'\n",bset[i]->textFile->FileName);
			continue;
		}
		
		int csize = cstr->Length();
		
		BaseWeight *cbi = (BaseWeight*) malloc ( csize );
		int cl = cstr -> Read ( cbi, csize ) / sizeof(BaseWeight);
		cidx->Close(cstr);

		if (cl != ml)
		{
			fprintf(stdout, "WARNING: Base '%s' differs in number of Complects (main '%s')\n",bset[i]->textFile->FileName,b->textFile);
			continue;
		}

		for (int j = 0; j < cl; j++)
		{
			if (cbi[j].min != mbi[j].min || cbi[j].max != mbi[j].max || strcmp(cbi[j].name,mbi[j].name))
			{
				fprintf(stdout, "WARNING: Base '%s' differs in Complects: %s;min:%d;max:%d (main '%s': %s;min:%d;max:%d)\n",bset[i]->textFile->FileName,cbi[j].name,cbi[j].min,cbi[j].max,b->textFile->FileName,mbi[j].name,mbi[j].min,mbi[j].max);
				break;
			}
		}
		free(cbi);
	}
	free(mbi);
	return 1;
}

int checkClassInfo()
{
	Index * midx = b->FindIndex("Aux");

	Stream * mstr = midx -> OpenN ( "Clas", 0 );
	
	if (!mstr)
	{
		fprintf(stdout, "FATAL_ERROR: Cannot load Aux Index in base '%s'\n",b->textFile->FileName);
		return 0;
	}
	
	int msize = mstr->Length();
	if (msize != sizeof(u_int32_t))
	{
		fprintf(stdout, "FATAL_ERROR: Bad data in Aux Index in base '%s'\n",b->textFile->FileName);
		return 0;
	}
	
	u_int32_t ver = 0;
	mstr -> Read ( &ver, msize );
	midx->Close(mstr);

	for (int i = 0; i < nbases; i++)
	{
		Index * cidx = bset[i]->FindIndex("Aux");
		Stream * cstr = cidx -> OpenN ( "Clas", 0 );
		
		if (!cstr)
		{
			fprintf(stdout, "FATAL_ERROR: Cannot load Aux Index in base '%s'\n",bset[i]->textFile->FileName);
			continue;
		}
		
		int csize = cstr->Length();
		if (csize != sizeof(u_int32_t))
		{
			fprintf(stdout, "FATAL_ERROR: Bad data in Aux Index in base '%s'\n",bset[i]->textFile->FileName);
			return 0;
		}

		u_int32_t cver = 0;
		cstr -> Read ( &cver, csize );
		cidx->Close(cstr);

		if (cver != ver)
		{
			fprintf(stdout, "FATAL_ERROR: Clax version in Base '%s' is not compatible.\n",bset[i]->textFile->FileName);
			continue;
		}

	}
	return 1;
}

int compareStrAttr(long ID, int tag, Base * b1, Base * b2)
{
	AttrKey key;

	key.DocId = ID;
	key.AttrTag = tag;
	
	Stream * str1 = b1 -> FindIndex( "Attrs" ) -> Open ( &key );
	Stream * str2 = b2 -> FindIndex( "Attrs" ) -> Open ( &key );

	if (!(str1 || str2))
		return 1;

	if ((str1 || str2) && !(str1 && str2))
		return 0;

	if (str2->Length() != str1->Length())
	{
		b1 -> FindIndex( "Attrs" ) -> Close ( str1 );
		b2 -> FindIndex( "Attrs" ) -> Close ( str2 );
		return 0;
	}
	
	char * buf1 = (char*)malloc(str1->Length());
	char * buf2 = (char*)malloc(str2->Length());
	
	unsigned long len1 = str1 -> Read ( buf1, str1->Length() ); b1 -> FindIndex( "Attrs" ) -> Close ( str1 );
	unsigned long len2 = str2 -> Read ( buf2, str2->Length() ); b2 -> FindIndex( "Attrs" ) -> Close ( str2 );

	{
	char* data = (char*) buf1;
	if (data [3] == 0) {
		long unpacked_size = *(long*) buf1;
		void gk_huge* unpacked_data = malloc (unpacked_size);
		G_UNZIP (data + sizeof (long), len1 - sizeof (long), unpacked_data, unpacked_size);
		gk_free (buf1);
		buf1 = (char*) unpacked_data;
		len1 = unpacked_size;
	}
	data = (char*) buf2;
	if (data [3] == 0) {
		long unpacked_size = *(long*) buf2;
		void gk_huge* unpacked_data = malloc (unpacked_size);
		G_UNZIP (data + sizeof (long), len2 - sizeof (long), unpacked_data, unpacked_size);
		gk_free (buf2);
		buf2 = (char*) unpacked_data;
		len2 = unpacked_size;
	}
	}

	SplaySet<FString> ss1;
	SplaySet<FString> ss2;

	char * p = buf1;
	while ((unsigned long)(p - buf1) < len1)
	{
		FString fs(p,strlen(p));
		fs.bDoFree = 0;
		ss1.add(fs);
		p += strlen(p)+1;
	}
	p = buf2;
	while ((unsigned long)(p - buf2) < len2)
	{
		FString fs(p,strlen(p));
		fs.bDoFree = 0;
		ss2.add(fs);
		p += strlen(p)+1;
	}

	free(buf1);
	free(buf2);

	for (Pix pix1 = ss1.first(); pix1; ss1.next(pix1))
		ss1(pix1).bDoFree = 1;
	for (Pix pix2 = ss2.first(); pix2; ss2.next(pix2))
		ss2(pix2).bDoFree = 1;

	if (ss1 == ss2)
		return 1;
	else
		return 0;
}

int compareDateAttr(long ID, int tag, Base * b1, Base * b2)
{
	AttrKey key;

	key.DocId = ID;
	key.AttrTag = tag;
	
	Stream * str1 = b1 -> FindIndex( "Attrs" ) -> Open ( &key );
	Stream * str2 = b2 -> FindIndex( "Attrs" ) -> Open ( &key );

	if (!(str1 || str2))
		return 1;

	if ((str1 || str2) && !(str1 && str2))
		return 0;

	if (str2->Length() != str1->Length())
	{
		b1 -> FindIndex( "Attrs" ) -> Close ( str1 );
		b2 -> FindIndex( "Attrs" ) -> Close ( str2 );
		return 0;
	}
	
	u_int32_t * buf1 = (u_int32_t*)malloc(str1->Length());
	u_int32_t * buf2 = (u_int32_t*)malloc(str2->Length());
	
	unsigned long len1 = str1 -> Read ( buf1, str1->Length() ) / sizeof(u_int32_t); b1 -> FindIndex( "Attrs" ) -> Close ( str1 );
	unsigned long len2 = str2 -> Read ( buf2, str2->Length() ) / sizeof(u_int32_t); b2 -> FindIndex( "Attrs" ) -> Close ( str2 );

	SplaySet<u_int32_t> us1;
	SplaySet<u_int32_t> us2;

	u_int32_t * p = 0;
	unsigned long i = 0;

	for (p=buf1, i=0; i < len1; i++, p++)
		us1.add(*p);
	for (p=buf2, i=0; i < len2; i++, p++)
		us2.add(*p);

	free(buf1);
	free(buf2);

	if (us1 == us2)
		return 1;
	else
		return 0;
}

int compareSubAttr(long ID, int tag, Base * b1, Base * b2)
{
	AttrKey key;

	key.DocId = ID;
	key.AttrTag = tag;
	
	Stream * str1 = b1 -> FindIndex( "Attrs" ) -> Open ( &key );
	Stream * str2 = b2 -> FindIndex( "Attrs" ) -> Open ( &key );

	if (!(str1 || str2))
		return 1;

	if ((str1 || str2) && !(str1 && str2))
		return 0;

	if (str2->Length() != str1->Length())
	{
		b1 -> FindIndex( "Attrs" ) -> Close ( str1 );
		b2 -> FindIndex( "Attrs" ) -> Close ( str2 );
		return 0;
	}
	
	u_int64_t * buf1 = (u_int64_t*)malloc(str1->Length());
	u_int64_t * buf2 = (u_int64_t*)malloc(str2->Length());
	
	unsigned long len1 = str1 -> Read ( buf1, str1->Length() ) / sizeof(u_int64_t); b1 -> FindIndex( "Attrs" ) -> Close ( str1 );
	unsigned long len2 = str2 -> Read ( buf2, str2->Length() ) / sizeof(u_int64_t); b2 -> FindIndex( "Attrs" ) -> Close ( str2 );

	SplaySet<u_int64_t> us1;
	SplaySet<u_int64_t> us2;

	u_int64_t * p = 0;
	unsigned long i = 0;

	for (p=buf1, i=0; i < len1; i++, p++)
		us1.add(*p);
	for (p=buf2, i=0; i < len2; i++, p++)
		us2.add(*p);

	free(buf1);
	free(buf2);

	if (us1 == us2)
		return 1;
	else
		return 0;
}

int compareBaseAttr(long ID, int tag, Base * b1, Base * b2)
{
	AttrKey key;

	key.DocId = ID;
	key.AttrTag = tag;
	
	Stream * str1 = b1 -> FindIndex( "Attrs" ) -> Open ( &key );
	Stream * str2 = b2 -> FindIndex( "Attrs" ) -> Open ( &key );

	if (!(str1 || str2))
		return 1;

	if ((str1 || str2) && !(str1 && str2))
		return 0;

	if (str2->Length() != str1->Length())
	{
		b1 -> FindIndex( "Attrs" ) -> Close ( str1 );
		b2 -> FindIndex( "Attrs" ) -> Close ( str2 );
		return 0;
	}
	
	u_int16_t * buf1 = (u_int16_t*)malloc(str1->Length());
	u_int16_t * buf2 = (u_int16_t*)malloc(str2->Length());
	
	unsigned long len1 = str1 -> Read ( buf1, str1->Length() ) / sizeof(u_int16_t); b1 -> FindIndex( "Attrs" ) -> Close ( str1 );
	unsigned long len2 = str2 -> Read ( buf2, str2->Length() ) / sizeof(u_int16_t); b2 -> FindIndex( "Attrs" ) -> Close ( str2 );

	SplaySet<u_int16_t> us1;
	SplaySet<u_int16_t> us2;

	u_int16_t * p = 0;
	unsigned long i = 0;

	for (p=buf1, i=0; i < len1; i++, p++)
		us1.add(*p);
	for (p=buf2, i=0; i < len2; i++, p++)
		us2.add(*p);

	free(buf1);
	free(buf2);

	if (us1 == us2)
		return 1;
	else
		return 0;
}

#define CHECK_STR(tag) if (!compareStrAttr(ID,tag,b1,b2)) return 0;
#define CHECK_DATE(tag) if (!compareDateAttr(ID,tag,b1,b2)) return 0;
#define CHECK_SUB(tag) if (!compareSubAttr(ID,tag,b1,b2)) return 0;
#define CHECK_BASE(tag) if (!compareBaseAttr(ID,tag,b1,b2)) return 0;

int compareDoc(long ID, Base * b1, Base * b2)
{
	AttrKey key;

	key.DocId = ID;
	key.AttrTag = IDD_INFO;
	
	Stream * str1 = b1 -> FindIndex( "Attrs" ) -> Open ( &key );
	Stream * str2 = b2 -> FindIndex( "Attrs" ) -> Open ( &key );
	
	DocInfo doc1;
	DocInfo doc2;
	
	str1 -> Read ( &doc1, sizeof (DocInfo) ); b2 -> FindIndex( "Attrs" ) -> Close ( str1 );
	str2 -> Read ( &doc2, sizeof (DocInfo) ); b2 -> FindIndex( "Attrs" ) -> Close ( str2 );
	
	if ( doc1.ParaCount != doc2.ParaCount )
		return 0;
	
	Document docum1( b1, ID );
	Document docum2( b2, ID );
	char *para1;
	char *para2;

	for (int i = 0; i < doc1.ParaCount; i++ )
	{
		para1 = docum1.GetPara ( i );
		para2 = docum2.GetPara ( i );
		
		if ( TextSize ( para1 ) == TextSize ( para2 ) )
		{
			if ( memcmp(ParaText ( para1 ),ParaText ( para2 ),TextSize(para1)) != 0 )
				return 0;
		}
		else
			return 0;
	}

#ifndef	VERSION61
	CHECK_STR(IDD_NAME);
#endif
	CHECK_STR(IDD_ID);
	CHECK_STR(IDD_ADDCODE);
	CHECK_STR(IDD_TERRITORY);
	CHECK_STR(IDD_SOURCE);
	CHECK_STR(IDD_DIV);
	CHECK_STR(IDD_KEY);
	CHECK_STR(IDD_TYPE);
	CHECK_STR(IDD_RCODE);
	CHECK_STR(IDD_DOCKIND);
	CHECK_STR(IDD_KIND);
	CHECK_STR(IDD_WARNING);
	CHECK_STR(IDD_CATEGORY);
	CHECK_STR(IDD_PUBLISHEDIN);
	CHECK_DATE(IDD_DATE);
	CHECK_DATE(IDD_VINCLUDED);
	CHECK_DATE(IDD_VCHANGED);
	CHECK_DATE(IDD_VABOLISHED);
	CHECK_DATE(IDD_RDATE);
	CHECK_DATE(IDD_SORTDATE);
	CHECK_DATE(IDD_VANONCED);
	CHECK_DATE(IDD_VLCONTROL);
	CHECK_BASE(IDD_BASES);

	return 1;
}

typedef SplaySet<long> _longSplaySet;

int checkDocs()
{
	int i = 0;
	Base ** bases = new Base*[nbases+1];
	bases[0] = b;
	for (i = 0; i < nbases; i++)
		bases[i+1] = bset[i];
	int bases_num = nbases+1;
	
	SplaySet<long> dflt;
	SplayMap<long,_longSplaySet> base_docs(dflt);
	
	for (i=0; i<bases_num; i++)
	{
		BTIterator it ( bases[i]->FindIndex( "Attrs" ) );
		SplaySet<long> docIDs;
		
		double count_step = (double)(bases[i]->FindIndex( "Attrs" )->KeyCount) / 100;
		double count = 0;
		int perc = 0;
		
		fprintf(stderr, "Collecting documents in base '%s'... 0%%    \r",bases[i]->textFile->FileName);
		for ( count = 0; !it.End ( ); count+=1) {
			if (perc < (int)(count/count_step)) {
				perc = (int)(count/count_step);
				fprintf(stderr, "Collecting documents in base '%s'... %ld%%    \r",bases[i]->textFile->FileName,(int)(count/count_step));
			}

			if ( ((AttrKey*) it.Key())->AttrTag == IDD_INFO ) {
				long docID = ((AttrKey*) it.Key ( )) -> DocId;

				if ( docID >= 100000 ) {
					long longI = (long)i;
					if ( !base_docs[docID].contains(longI)) {
						long	aKeySize;
						void*	aKeys = ((AttrIndex*)bases[i]->FindIndex( "Attrs" ))->Load( docID, IDD_KEY, aKeySize );
						if ( aKeySize ) {
							Collection *listKeys = new Collection( PRIME_KW_SIZE * 2 + 32, 40 );
							char* aKey = (char*) aKeys;
							while ( aKey - (char*)aKeys < aKeySize ) {
								char* aaKey = new char[ PRIME_KW_SIZE * 2 + 32 ];
								strcpy( aaKey, aKey );
								listKeys->Add( aaKey );
								aKey += strlen( aKey ) + 1;
							}
							int aFound = 0;
							for ( int ii = 0; ii < listKeys->ItemCount - 1 && !aFound; ii++ )
								for ( int jj = ii + 1; jj < listKeys->ItemCount; jj++ )
									if ( !strcmp( (char*)listKeys->GetItem(ii), (char*)listKeys->GetItem(jj))) {
										printf( "\nFATAL_ERROR: Duplicated keywords. Doc: %ld\n", docID );
										aFound = 1;
										break;
									}
							delete listKeys;
							gk_free( aKeys );
						}
					}

					base_docs[docID]._add((long)i);
				}
			}

			++it;
		}
		fprintf(stderr, "Collecting documents in base '%s'... 100%%    \n",bases[i]->textFile->FileName);

		base_docs[i] = docIDs;
	}

	Pix pix;
	SplaySet<long> single_keys;

	for (pix = base_docs.first(); pix; base_docs.next(pix))
	{
		if (base_docs.contents(pix).length() < 2) single_keys.add(base_docs.key(pix));
	}

	for (pix = single_keys.first(); pix; single_keys.next(pix))
	{
		base_docs.del(single_keys(pix));
	}
	
	double count_step = (double)(base_docs.length()) / 100;
	double count = 0;
	int perc = 0;
	
	fprintf(stderr, "Comparing documents in all bases... 0%%    \r");
	for (count = 0, pix = base_docs.first(); pix; base_docs.next(pix), count+=1)
	{
		if (perc < (int)(count/count_step))
		{
			perc = (int)(count/count_step);
			fprintf(stderr, "Comparing documents in all bases... %ld%%    \r",(int)(count/count_step));
		}

		long ID = base_docs.key(pix);
		SplaySet<long> bss = base_docs.contents(pix);

		Pix pix1;
		long first = bss(pix1 = bss.first());
		for (bss.next(pix1); pix1; bss.next(pix1))
			if (!compareDoc(ID, bases[first], bases[bss(pix1)]))
				printf("FATAL_ERROR: Document %ld is not the same in all bases. Bases '%s', '%s'.\n",ID,bases[first]->textFile->FileName,bases[bss(pix1)]->textFile->FileName);
	}
	fprintf(stderr, "Comparing documents in all bases... 100%%    \n");

	delete[] bases;
	return 1;
}

char* getbasename( int i )
{
	if ( i )
		return bset[i-1]->textFile->FileName;
	else
		return b->textFile->FileName;
}

int checkRIndex(const char* name)
{
	HNode * root = new HNode(1);
	int badbase;

	BTIterator it(b->FindIndex(name));

	for (;!it.End();) {
		char* key = (char *)(it.Key());

		if (strlen(key) != 0) {
			HNode * new_node = 0;
			HN_STATUS st = root->addNode(key,new_node,badbase);
		}
		++it;
	}

	for (int i = 0; i < nbases; i++) {
		BTIterator cit(bset[i]->FindIndex(name));

		for (;!cit.End();) {
			char* key = (char*)(cit.Key());
			if (strlen(key) != 0) {
				HNode * new_node = 0;
				HN_STATUS st = root->addNode(key,new_node,badbase,i+1);
				if (st & INS_CONT) {
					fprintf(stdout,"FATAL_ERROR: Index '%s' is not the same in all bases. Bases '%s' and '%s'\n",name,bset[i]->textFile->FileName, getbasename(badbase) );
					fprintf(stdout,"\tBad key: '%s'\n",key);
					fprintf(stdout,"\tReason: Key is longer in this base than in another base\n");
				}
				if (st & INS_BRK) {
					fprintf(stdout,"FATAL_ERROR: Index '%s' is not the same in all bases. Bases '%s' and '%s'\n",name,bset[i]->textFile->FileName, getbasename(badbase) );
					fprintf(stdout,"\tBad key: '%s'\n",key);
					fprintf(stdout,"\tReason: Key is shorter in this base than in another base\n");
				}
				if (st & INS_CASE) {
					fprintf(stdout,"FATAL_ERROR: Index '%s' is not the same in all bases. Bases '%s' and '%s'\n",name,bset[i]->textFile->FileName, getbasename(badbase) );
					fprintf(stdout,"\tBad key: '%s'\n",key);
					fprintf(stdout,"\tReason: Case prefix is not equal\n");
				}
				if (st & INS_DIFFN) {
					fprintf(stdout,"ERROR: Index '%s' is not the same in all bases. Bases '%s' and '%s' \n",name,bset[i]->textFile->FileName, getbasename(badbase) );
					fprintf(stdout,"\tBad key: '%s'\n",key);
					fprintf(stdout,"\tReason: Sort prefix is not equal\n");
				}
			}
			++cit;
		}
	}
	delete root;
	return 1;
}

int	check_hindex (const char *name)
{
	int ok = 1;
	char base_name [MAX_PATH];
	strcpy (base_name, b->keyFile->FileName);
	*strrchr (base_name, '.') = 0;
	std::map<std::string,std::string> map_fullname_basename;
	std::map<std::string,std::string> map_prefix_basename;

	char prefix [4]; prefix [3] = 0;
	std::map<std::string,std::string> map_fullname_sortprefix;
	std::map<std::string,std::string> map_fullsortprefix_fullname;

	std::map<long,std::string> map_id_name;
	std::map<long,std::string> map_id_sortprefix;
	std::map<long,long> map_id_parentid;

	Index* index = b->FindIndex (name);
	for (BTIterator btit (index); !btit.End (); ++btit) {
		HIndex::HIndexKey *key = (HIndex::HIndexKey*) btit.Key ();
		map_id_parentid.insert (std::map<long,long>::value_type (key->id, key->parent));
		strncpy (prefix, key->text, 3);

		if (key->level) {
			std::string name = map_id_name.find (key->parent)->second;
			name += "\\";
			name += key->text+4;

			std::string sprefix = map_id_sortprefix.find (key->parent)->second;
			sprefix += "\\";
			sprefix += prefix;
			map_id_name.insert (std::map<long,std::string>::value_type (key->id, name));
			map_id_sortprefix.insert (std::map<long,std::string>::value_type (key->id, sprefix));

			if (map_fullname_sortprefix.find (name) == map_fullname_sortprefix.end ()) {
				map_fullname_sortprefix.insert (std::map<std::string,std::string>::value_type (name, prefix));
				map_fullname_basename.insert (std::map<std::string,std::string>::value_type (name, base_name));
			} else {
				fprintf(stdout,"ERROR: Разные сортировочные префиксы у %s, база %s\n", name.c_str (), base_name);
				ok = 0;
			}
			if (map_fullsortprefix_fullname.find (sprefix) == map_fullsortprefix_fullname.end ()) {
				map_fullsortprefix_fullname.insert (std::map<std::string,std::string>::value_type (sprefix, name));
				map_prefix_basename.insert (std::map<std::string,std::string>::value_type (sprefix, base_name));
			} else {
				if (strcmp (name.c_str (), map_fullsortprefix_fullname.find (sprefix)->second.c_str ())) {
					fprintf(stdout,"ERROR: Одинаковые сортировочные префиксы у %s и %s, база %s\n", name.c_str (), map_fullsortprefix_fullname.find (sprefix)->second.c_str (), base_name);
					ok = 0;
				}
			}
		} else {
			map_id_name.insert (std::map<long,std::string>::value_type (key->id, key->text+4));
			map_id_sortprefix.insert (std::map<long,std::string>::value_type (key->id, prefix));

			if (map_fullname_sortprefix.find (key->text+4) == map_fullname_sortprefix.end ()) {
				map_fullname_sortprefix.insert (std::map<std::string,std::string>::value_type (key->text+4, prefix));
				map_fullname_basename.insert (std::map<std::string,std::string>::value_type (key->text+4, base_name));
			} else {
				fprintf(stdout,"ERROR: Разные сортировочные префиксы у %s, база %s\n", key->text+4, base_name);
				ok = 0;
			}

			if (map_fullsortprefix_fullname.find (prefix) == map_fullsortprefix_fullname.end ()) {
				map_fullsortprefix_fullname.insert (std::map<std::string,std::string>::value_type (prefix, key->text+4));
				map_prefix_basename.insert (std::map<std::string,std::string>::value_type (prefix, base_name));
			} else {
				if (strcmp (key->text+4, map_fullsortprefix_fullname.find (prefix)->second.c_str ())) {
					fprintf(stdout,"ERROR: Одинаковые сортировочные префиксы у %s и %s, база %s\n", key->text+4, map_fullsortprefix_fullname.find (prefix)->second.c_str (), base_name);
					ok = 0;
				}
			}
		}
	}

	for (int i = 0; i < nbases; i++) {
		strcpy (base_name, bset[i]->keyFile->FileName);
		*strrchr (base_name, '.') = 0;

		map_id_name.clear ();
		map_id_sortprefix.clear ();
		map_id_parentid.clear ();
		Index* index = bset [i]->FindIndex (name);

		for (BTIterator btit (index); !btit.End (); ++btit) {
			HIndex::HIndexKey *key = (HIndex::HIndexKey*) btit.Key ();
			map_id_parentid.insert (std::map<long,long>::value_type (key->id, key->parent));
			strncpy (prefix, key->text, 3);
			if (key->level) {
				std::string name = map_id_name.find (key->parent)->second;
				name += "\\";
				name += key->text+4;

				std::string sprefix = map_id_sortprefix.find (key->parent)->second;
				sprefix += "\\";
				sprefix += prefix;

				map_id_name.insert (std::map<long,std::string>::value_type (key->id, name));
				map_id_sortprefix.insert (std::map<long,std::string>::value_type (key->id, sprefix));

				std::map<std::string,std::string>::const_iterator map_it = map_fullname_sortprefix.find (name);
				if (map_it == map_fullname_sortprefix.end ()) {
					map_fullname_sortprefix.insert (std::map<std::string,std::string>::value_type (name, prefix));
					map_fullname_basename.insert (std::map<std::string,std::string>::value_type (name, base_name));
				} else {
					if (strcmp (map_it->second.c_str (), prefix)) {
						fprintf(stdout,"ERROR: Разные сортировочные префиксы у %s, базы %s и %s\n", map_it->first.c_str (), base_name, map_fullname_basename.find (name)->second.c_str ());
						ok = 0;
					}
				}
				if (map_fullsortprefix_fullname.find (sprefix) == map_fullsortprefix_fullname.end ()) {
					map_fullsortprefix_fullname.insert (std::map<std::string,std::string>::value_type (sprefix, name));
					map_prefix_basename.insert (std::map<std::string,std::string>::value_type (sprefix, base_name));
				} else {
					if (strcmp (name.c_str (), map_fullsortprefix_fullname.find (sprefix)->second.c_str ())) {
						fprintf(stdout,"ERROR: Одинаковые сортировочные префиксы у %s и %s, базы %s и %s\n", name.c_str (), map_fullsortprefix_fullname.find (sprefix)->second.c_str (), base_name, map_prefix_basename.find (sprefix)->second.c_str ());
						ok = 0;
					}
				}
			} else {
				map_id_name.insert (std::map<long,std::string>::value_type (key->id, key->text+4));
				map_id_sortprefix.insert (std::map<long,std::string>::value_type (key->id, prefix));

				std::map<std::string,std::string>::const_iterator map_it = map_fullname_sortprefix.find (key->text+4);
				if (map_it == map_fullname_sortprefix.end ()) {
					map_fullname_sortprefix.insert (std::map<std::string,std::string>::value_type (key->text+4, prefix));
					map_fullname_basename.insert (std::map<std::string,std::string>::value_type (key->text+4, base_name));
				} else {
					if (strcmp (map_it->second.c_str (), prefix)) {
						fprintf(stdout,"ERROR: Разные сортировочные префиксы у %s, базы %s и %s\n", map_it->first.c_str (), base_name, map_fullname_basename.find (key->text+4)->second.c_str ());
						ok = 0;
					}
				}

				if (map_fullsortprefix_fullname.find (prefix) == map_fullsortprefix_fullname.end ()) {
					map_fullsortprefix_fullname.insert (std::map<std::string,std::string>::value_type (prefix, key->text+4));
					map_prefix_basename.insert (std::map<std::string,std::string>::value_type (prefix, base_name));
				} else {
					if (strcmp (key->text+4, map_fullsortprefix_fullname.find (prefix)->second.c_str ())) {
						fprintf(stdout,"ERROR: Одинаковые сортировочные префиксы %s и %s, базы %s и %s\n", key->text+4, map_fullsortprefix_fullname.find (prefix)->second.c_str (), base_name, map_prefix_basename.find (prefix)->second.c_str ());
						ok = 0;
					}
				}
			}
		}
	}

	return ok;
}

int checkHIndex(const char* name, bool b_publishedin = false)
{
	std::map<std::string, std::set<std::string> > map_key_bases;

	char buf[10000], shrinked_str [10000];
	HNode * root = new HNode(1);
	int badbase;

	BTIterator it(b->FindIndex(name));
	std::map<std::string, std::set<std::string> > map_keys;

	char base_name [256];
	strcpy (base_name, b->keyFile->FileName);
	*strrchr (base_name, '.') = 0;

	for (;!it.End();++it) {
		HIndex::HIndexKey* key = (HIndex::HIndexKey*)(it.Key());
		if (b_publishedin && key->level > 2)
			continue;

		char * full_key = ((HIndex*)b->FindIndex(name))->FullName(it.Key(),buf);
		strcpy (shrinked_str, buf);
		char* toput = shrinked_str;
		char *token = strtok (shrinked_str, "\\");
		while (token) {
			if (toput != shrinked_str) {
				toput++;
				*toput = '\\';
				toput++;
			}
			int length = strlen (token)-4;
			memcpy (toput, token+4, length+1);
			toput += length - 1;
			token = strtok (0, "\\");
		}

		short levels = 0;
		/*
		if (b_publishedin) {
			char* ptr = full_key;
			while (strchr (ptr, '\\')) {
				levels++;
				ptr = strchr (ptr, '\\')+1;
			}
		}
		*/
		if (levels < 3) {
			if (strrchr (shrinked_str, '\\')) {
				*strrchr (shrinked_str, '\\') = '\0';
				std::map<std::string, std::set<std::string> >::iterator it = map_keys.find (shrinked_str);
				std::string key = strrchr (full_key, '\\')+1;
				if (it == map_keys.end ()) {
					std::set<std::string> to_put;
					to_put.insert (key);
					map_keys.insert (std::map<std::string, std::set<std::string> >::value_type (shrinked_str, to_put));
				} else {
					it->second.insert (key);
				}

				std::map<std::string, std::set<std::string> >::iterator map_it = map_key_bases.find (key);
				if (map_it == map_key_bases.end ()) {
					std::set<std::string> base_names;
					base_names.insert (base_name);
					map_key_bases.insert (std::map<std::string, std::set <std::string> >::value_type (key, base_names));
				} else {
					map_it->second.insert (base_name);
				}
			} else {
				std::map<std::string, std::set<std::string> >::iterator it = map_keys.find ("root");
				if (it == map_keys.end ()) {
					std::set<std::string> to_put;
					to_put.insert (full_key);
					map_keys.insert (std::map<std::string, std::set<std::string> >::value_type ("root", to_put));
				} else {
					it->second.insert (full_key);
				}

				std::map<std::string, std::set<std::string> >::iterator map_it = map_key_bases.find (full_key);
				if (map_it == map_key_bases.end ()) {
					std::set<std::string> base_names;
					base_names.insert (base_name);
					map_key_bases.insert (std::map<std::string, std::set <std::string> >::value_type (full_key, base_names));
				} else {
					map_it->second.insert (base_name);
				}
			}
		}

		if (/*!b_publishedin &&*/ key->chCount == 0) {
			HNode * new_node = 0;
			HN_STATUS st = root->addNode(full_key,new_node,badbase);
		}
	}

	for (int i = 0; i < nbases; i++) {
		BTIterator cit(bset[i]->FindIndex(name));
		strcpy (base_name, bset[i]->keyFile->FileName);
		*strrchr (base_name, '.') = 0;

		for (;!cit.End();++cit) {
			HIndex::HIndexKey* key = (HIndex::HIndexKey*)(cit.Key());
			if (b_publishedin && key->level > 2)
				continue;

			char * full_key = ((HIndex*)bset[i]->FindIndex(name))->FullName(cit.Key(),buf);

			strcpy (shrinked_str, buf);
			char* toput = shrinked_str;
			char *token = strtok (shrinked_str, "\\");
			while (token) {
				if (toput != shrinked_str) {
					toput++;
					*toput = '\\';
					toput++;
				}
				int length = strlen (token)-4;
				memcpy (toput, token+4, length+1);
				toput += length - 1;
				token = strtok (0, "\\");
			}
			if (strrchr (shrinked_str, '\\')) {
				*strrchr (shrinked_str, '\\') = '\0';
				std::map<std::string, std::set<std::string> >::iterator it = map_keys.find (shrinked_str);
				std::string key = strrchr (full_key, '\\')+1;
				if (it == map_keys.end ()) {
					std::set<std::string> to_put;
					to_put.insert (key);
					map_keys.insert (std::map<std::string, std::set<std::string> >::value_type (shrinked_str, to_put));
				} else {
					it->second.insert (key);
				}

				std::map<std::string, std::set<std::string> >::iterator map_it = map_key_bases.find (key);
				if (map_it == map_key_bases.end ()) {
					std::set<std::string> base_names;
					base_names.insert (base_name);
					map_key_bases.insert (std::map<std::string, std::set <std::string> >::value_type (key, base_names));
				} else {
					map_it->second.insert (base_name);
				}
			} else {
				std::map<std::string, std::set<std::string> >::iterator it = map_keys.find ("root");
				if (it == map_keys.end ()) {
					std::set<std::string> to_put;
					to_put.insert (full_key);
					map_keys.insert (std::map<std::string, std::set<std::string> >::value_type ("root", to_put));
				} else {
					it->second.insert (full_key);
				}

				std::map<std::string, std::set<std::string> >::iterator map_it = map_key_bases.find (full_key);
				if (map_it == map_key_bases.end ()) {
					std::set<std::string> base_names;
					base_names.insert (base_name);
					map_key_bases.insert (std::map<std::string, std::set <std::string> >::value_type (full_key, base_names));
				} else {
					map_it->second.insert (base_name);
				}
			}

			if (/*!b_publishedin && */key->chCount == 0) {
				HNode * new_node = 0;
				HN_STATUS st = root->addNode(full_key,new_node,badbase,i+1);
				if (st & INS_CONT) {
					fprintf(stdout,"FATAL_ERROR: Index '%s' is not the same in all bases. Bases '%s' and '%s'\n",name,bset[i]->textFile->FileName, getbasename(badbase));
					fprintf(stdout,"\tBad key: '%s'\n",full_key);
					fprintf(stdout,"\tReason: Key is longer in this base than in another base\n");
				}
				if (st & INS_BRK) {
					fprintf(stdout,"FATAL_ERROR: Index '%s' is not the same in all bases. Bases '%s' and '%s'\n",name,bset[i]->textFile->FileName, getbasename(badbase));
					fprintf(stdout,"\tBad key: '%s'\n",full_key);
					fprintf(stdout,"\tReason: Key is shorter in this base than in another base\n");
				}
				if (st & INS_CASE) {
					fprintf(stdout,"FATAL_ERROR: Index '%s' is not the same in all bases. Bases '%s' and '%s'\n",name,bset[i]->textFile->FileName, getbasename(badbase));
					fprintf(stdout,"\tBad key: '%s'\n",full_key);
					fprintf(stdout,"\tReason: Case prefix is not equal\n");
				}
				if (st & INS_DIFFN) {
					fprintf(stdout,"ERROR: Index '%s' is not the same in all bases. Bases '%s' and '%s'\n",name,bset[i]->textFile->FileName, getbasename(badbase));
					fprintf(stdout,"\tBad key: '%s'\n",full_key);
					fprintf(stdout,"\tReason: Sort prefix is not equal\n");
				}
			}
		}
	}

	char prefix [4], prefix2 [4];
	prefix [3] = 0; prefix2 [3] = 0;
	for (std::map<std::string, std::set<std::string> >::const_iterator it = map_keys.begin (); it != map_keys.end (); it++) {
		for (std::set<std::string>::const_iterator it2 = it->second.begin (); it2 != it->second.end (); it2++) {
			strncpy (prefix, it2->c_str (), 3);
			std::set<std::string>::const_iterator it3 = it2;
			for (it3++; it3 != it->second.end (); it3++) {
				strncpy (prefix2, it3->c_str (), 3);
				if (!strcmp (prefix, prefix2)) {
					fprintf(stdout,"ERROR: Одинаковый сортировочный префикс у %s и %s, родительский узел: %s, базы1:", it2->c_str (), it3->c_str (), it->first.c_str ());
					std::map<std::string, std::set<std::string> >::const_iterator base_it = map_key_bases.find (it2->c_str ());
					if (base_it != map_key_bases.end ())
						for (std::set<std::string>::const_iterator str_it = base_it->second.begin (); str_it != base_it->second.end (); str_it++)
							fprintf (stdout," %s", str_it->c_str ());
					fprintf (stdout,", базы2:");
					base_it = map_key_bases.find (it3->c_str ());
					if (base_it != map_key_bases.end ())
						for (std::set<std::string>::const_iterator str_it = base_it->second.begin (); str_it != base_it->second.end (); str_it++)
							fprintf (stdout," %s", str_it->c_str ());
					fprintf (stdout,"\n");					
				} else {
					if (!strcmp (it2->c_str () + 4, it3->c_str () + 4)) {
						fprintf(stdout,"ERROR: Разные сортировочные префиксы у %s и %s, родительский узел: %s, базы1:", it2->c_str (), it3->c_str (), it->first.c_str ());
						std::map<std::string, std::set<std::string> >::const_iterator base_it = map_key_bases.find (it2->c_str ());
						if (base_it != map_key_bases.end ())
							for (std::set<std::string>::const_iterator str_it = base_it->second.begin (); str_it != base_it->second.end (); str_it++)
								fprintf (stdout," %s", str_it->c_str ());
						fprintf (stdout,", базы2:");
						base_it = map_key_bases.find (it3->c_str ());
						if (base_it != map_key_bases.end ())
							for (std::set<std::string>::const_iterator str_it = base_it->second.begin (); str_it != base_it->second.end (); str_it++)
								fprintf (stdout," %s", str_it->c_str ());
						fprintf (stdout,"\n");					
					}
				}
			}
		}
	}

	delete root;
	return 1;
}

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	{
		VER_PARAM verParam;
		int	i;

		verParam.exeId= TID_GREGTST;			// defines BASEMASK.H
		verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
		verParam.stdOut= stdout;
		verParam.pDate= __DATE__;
		verParam.pTime= __TIME__;

		if((i=_imp_GVersion(&argc, argv, &verParam))){
			if(i == VC_ADD_OK){
			}else{
			}
	#ifdef _DEBUG
			printf("\n *** GREGTST Debug Version. For test, only... ***\n\n");
	#else
			exit(0);
	#endif
		}
	}

	if ( argc < 2 ) {
		printf ( "Garant base merge checker.\n"  );
		printf ( "Usage: gregtst <main base> <base1> ... <baseN>\n" );
		exit   ( 1 );
	}

#ifdef WIN32 // GARANT_WIN32
	{
		int option;
		char *opts;

		option= argc;
		while(--option){
			if((opts= strchr(argv[option], '/')) && !memcmp(opts+1,"///",3)){
				strcpy(opts, opts+2);
				strcpy(opts, "\\\\");
			}
		}

		option= argc;
		while(--option){
			if((opts= strchr(argv[option], '/')) && *(opts+1) == '/'){
				opts[0] = opts[2];
				strcpy(opts+1, opts+2);
				opts[1] = ':';
			}
		}

		option= argc;
		while(--option){
			while((opts= strchr(argv[option], '/'))){
				*opts= '\\';
			}
		}
	}
#endif

	b = new YBase ( argv [1], ACE_OS_O_RDONLY );
	if ( !b || !b -> IsOk ( ) ) {
		printf ( "WARNING: seems like base '%s' does not exist or not ok.\n", argv [1] );
		return 1;
	}

	int i;
	if (argc > 2)
		bset = new YBase*[argc-2];
	else
		b_single_base = true;
	nbases = 0;

	bool xoption = false;
	for (i=2; i<argc; i++) {
		if ( xoption ) {
			short seg = (short)atol(argv[i]);
			segs.add( seg );
		} else
		if ( !strcmp( argv[i], "-x" ) || !strcmp( argv[i], "-X" )) {
			xoption = true;
		} else if (!strcmp (argv [i], "-nocheckdocuments")) {
			b_check_documents = false;
		} else {
			bset[nbases] = new YBase ( argv [i], ACE_OS_O_RDONLY );
			if ( !bset[nbases] || !bset[nbases] -> IsOk ( ) ) {
				printf ( "WARNING: seems like base '%s' does not exist or not ok.\n", argv [i] );
				continue;
			}
			nbases++;
		}
	}

	printf ( "Checking bases Info ...\n");
	if (!checkBaseInfo()) printf ( "\tNot Ok.\n\n");
	else printf ( "\tPassed.\n\n");

	printf ( "Checking complect Info ...\n");
	if (!checkCompInfo()) printf ( "\tNot Ok.\n\n");
	else printf ( "\tPassed.\n\n");

	printf ( "Checking topic belongs ...\n");
	if (!checkDocBelongs()) printf ( "\tNot Ok.\n\n");
	else printf ( "\tPassed.\n\n");

	printf ( "Checking clax Info ...\n");
	if (!checkClassInfo()) printf ( "\tNot Ok.\n\n");
	else printf ( "\tPassed.\n\n");

	if (!b_single_base && b_check_documents) {
		printf ( "Checking documents ...\n");
		if (!checkDocs()) printf ( "\tNot Ok.\n\n");
		else printf ( "\tPassed.\n\n");
	} else {
		printf ( "Checking documents ... Skipped\n\n");
	}

	printf ( "Checking index 'Class' ...\n");
	if (!check_hindex("Class")) printf ( "\tNot Ok.\n\n");
	else printf ( "\tPassed.\n\n");

	printf ( "Checking index 'DocKind' ...\n");
	if (!check_hindex("DocKind")) printf ( "\tNot Ok.\n\n");
	else printf ( "\tPassed.\n\n");
	
	printf ( "Checking index 'Kind' ...\n");
	if (!check_hindex("Kind")) printf ( "\tNot Ok.\n\n");
	else printf ( "\tPassed.\n\n");
	
	printf ( "Checking index 'Category' ...\n");
	if (!checkRIndex("Category")) printf ( "\tNot Ok.\n\n");
	else printf ( "\tPassed.\n\n");
	
	printf ( "Checking index 'Adopted' ...\n");
	if (!check_hindex("Adopted")) printf ( "\tNot Ok.\n\n");
	else printf ( "\tPassed.\n\n");

	printf ( "Checking index 'Territory' ...\n");
	if (!check_hindex("Territory")) printf ( "\tNot Ok.\n\n");
	else printf ( "\tPassed.\n\n");
	
	printf ( "Checking index 'Type' ...\n");
	if (!check_hindex("Type")) printf ( "\tNot Ok.\n\n");
	else printf ( "\tPassed.\n\n");

	printf ( "Checking index 'ServiceInfo' ...\n");
	if (!check_hindex("ServiceInfo")) printf ( "\tNot Ok.\n\n");
	else printf ( "\tPassed.\n\n");

	printf ( "Checking index 'PublishedIn' ...\n");
	if (!check_hindex("PublishedIn")) printf ( "\tNot Ok.\n\n");
	else printf ( "\tPassed.\n\n");

	delete b;
	for (i=0; i<nbases; i++)
		delete bset[i];
	if (bset)
		delete[] bset;

	return 0;
}
