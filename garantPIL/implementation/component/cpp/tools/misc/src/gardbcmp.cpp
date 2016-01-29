#include "shared/Core/fix/mpcxc.h"
#include "gardbcmp.h"
#include "garver.h"
#include "btiter.h"
#include "stdbase.h"
#include "long.SplaySet.h"
#include "u_int32_t.SplaySet.h"
#include "FString.SplaySet.h"
#include "u_int32_t.SplaySet.h"
#include "u_int64_t.SplaySet.h"
#include "FString.long.SplayMap.h"
#include "long.long.SplayMap.h"
#include "u_int32_t.FString.SplayMap.h"

static u_int32_tFStringSplayMap stats(FString(""));
static u_int32_tFStringSplayMap attrs(FString(""));

IndexComparator::IndexComparator( const Base *_b1, const Base *_b2, const char *_name, int _strno )
{
	idx1 = ((Base *)_b1) -> FindIndex ( _name );
	idx2 = ((Base *)_b2) -> FindIndex ( _name );
	
	if ( idx1 && idx2 )
	{
	}
	
	if (idxHeaderCompare())
	{
	}
	
	str1 = (Stream *) calloc (_strno,sizeof(Stream*));
	str2 = (Stream *) calloc (_strno,sizeof(Stream*));
	
	idxName = (char*)_name;
	strno = _strno;
}

IndexComparator::~IndexComparator()
{
}

unsigned char IndexComparator::idxHeaderCompare()
{
	if (idx1 -> KeyCount != idx2 -> KeyCount)
	{
		return 0;
	}
	if (idx1 -> KeyLength != idx2 -> KeyLength)
	{
		return 0;
	}
	if (idx1 -> Height != idx2 -> Height)
	{
		return 0;
	}
	return 1;
}

unsigned char AttrsIndexComparator::keyCompare(const void* key)
{
	curStream = 0;
	int wasErrors = 0;
	str1 = idx1 -> OpenN ( key, 0 );
	str2 = idx2 -> OpenN ( key, 0 );
	
	if (!(str1 && str2))
	{
		if (str1 || str2)
		{
			if (str1)
				fprintf (stdout, "\tBase 2: No stream for the key '%ld : %s' found.\n", ((AttrKey*)key)->DocId, attrs[((AttrKey*)key)->AttrTag].chars());
			if (str2)
				fprintf (stdout, "\tBase 1: No stream for the key '%ld : %s' found.\n", ((AttrKey*)key)->DocId, attrs[((AttrKey*)key)->AttrTag].chars());
			return 0;
		}
		return 1;
	}

	void *data1 = malloc ( str1->Length() );
	void *data2 = malloc ( str2->Length() );
	int n1 = str1 -> Read ( data1, str1->Length() );
	int n2 = str2 -> Read ( data2, str2->Length() );
	
	if (!dataCompare(data1,n1,data2,n2))
	{
		wasErrors = 1;
	}
	free(data1);
	free(data2);

	idx1->Close(str1);
	idx2->Close(str2);
	if (wasErrors) return 0;
	else return 1;
}

unsigned char BlobIndexComparator::keyCompare(const void* key)
{
	int wasErrors = 0;
	for (int i = 0; i < 2; i++)
	{
		str1+=i; str2+=i;
		curStream = i;
		str1 = idx1 -> OpenN ( key, i );
		str2 = idx2 -> OpenN ( key, i );
		
		if (!(str1 && str2))
		{
			if (!str1)
				fprintf (stdout, "\tBase 1: No stream for the key '%ld' found.\n", *((u_int32_t*)key));
			if (!str2)
				fprintf (stdout, "\tBase 2: No stream for the key '%ld' found.\n", *((u_int32_t*)key));
			wasErrors = 1;
			continue;
		}
		
		void *data1 = malloc ( str1->Length() );
		void *data2 = malloc ( str2->Length() );
		int n1 = str1 -> Read ( data1, str1->Length() );
		int n2 = str2 -> Read ( data2, str2->Length() );
		
		idx1->Close(str1);
		idx2->Close(str2);
		str1-=i; str2-=i;

		if (n1!=n2 || memcmp(data1,data2,n1)!=0)
		{
			if (i)
			{
				fprintf(stdout, "\tBlobs are different in these bases\n");
			}
			free(data1);
			free(data2);
			wasErrors = 1;
			continue;
		}
		free(data1);
		free(data2);
	}
	if (wasErrors) return 0;
	else return 1;
}

unsigned char Int32DocsIndexComparator::indexCompare ()
{
	int wasErrors = 0;
	BTIterator it1 ( idx1 );
	BTIterator it2 ( idx2 );
	
	u_int32_tSplaySet keys1;
	u_int32_tSplaySet keys2;
	
	for ( ; !it1.End ( ); )
	{
		u_int32_t t = 0;
		u_int32_t t1 = 0;
		if (idxName != "Status")
			t = *((u_int32_t*)it1.Key());
		else
		{
			unsigned short uit = *((unsigned short*)it1.Key());
			t = uit;
		}
		if (!keys1.contains(t))	keys1.add(t);
		++it1;
		t1 = t;
	}
	for ( ; !it2.End ( ); )
	{
		u_int32_t t;
		if (idxName != "Status")
			t = *((u_int32_t*)it2.Key());
		else
		{
			unsigned short uit = *((unsigned short*)it2.Key());
			t = uit;
		}
		if (!keys2.contains(t))	keys2.add(t);
		++it2;
	}
	
	Pix i;
	if (keys1 != keys2)
	{
		for (i=keys1.first();i;keys1.next(i))
			if (!keys2.contains(keys1(i)))
			{
				if (idxName == "Status")
					printf("\tBase 1: key '%s' is not presented in Base 2\n",stats[keys1(i)].chars());
				else if (idxName == "Date" || idxName == "RDate" || idxName == "VIncluded" ||
						 idxName == "VChanged" || idxName == "VAbolished" || idxName == "VAnonced" ||
						 idxName == "VLControl" || idxName == "SortDate")
				{
					u_int32_t key = keys1(i);
					date* dkey = (date*)&key;
					printf("\tBase 1: key '%ld/%ld/%ld' is not presented in Base 2\n",dkey->da_year,dkey->da_mon,dkey->da_day);
				}
				else
					printf("\tBase 1: key '%ld' is not presented in Base 2\n",keys1(i));
				wasErrors = 1;
			}
		for (i=keys2.first();i;keys2.next(i))
			if (!keys1.contains(keys2(i)))
			{
				if (idxName == "Status")
					printf("\tBase 2: key '%s' is not presented in Base 1\n",stats[keys2(i)].chars());
				else if (idxName == "Date" || idxName == "RDate" || idxName == "VIncluded" ||
						 idxName == "VChanged" || idxName == "VAbolished" || idxName == "VAnonced" ||
						 idxName == "VLControl" || idxName == "SortDate")
				{
					u_int32_t key = keys2(i);
					date* dkey = (date*)&key;
					printf("\tBase 2: key '%ld/%ld/%ld' is not presented in Base 1\n",dkey->da_year,dkey->da_mon,dkey->da_day);
				}
				else
					printf("\tBase 2: key '%ld' is not presented in Base 1\n",keys2(i));
				wasErrors = 1;
			}
			
		return 0;
	}
	
	for (i=keys1.first();i;keys1.next(i))
	{
		u_int32_t t = keys1(i);
		if (!keyCompare(&t))
		{
			if (idxName == "Status")
				printf("\tDiffers in data for key '%s' was found\n\n",stats[keys1(i)].chars());
			else if (idxName == "Date" || idxName == "RDate" || idxName == "VIncluded" ||
				idxName == "VChanged" || idxName == "VAbolished" || idxName == "VAnonced" ||
				idxName == "VLControl" || idxName == "SortDate")
			{
				date* dkey = (date*)&t;
				printf("\tDiffers in data for key '%ld/%ld/%ld' was found\n\n",dkey->da_year,dkey->da_mon,dkey->da_day);
			}
			else
				fprintf(stdout, "\tDiffers in data for key '%ld' was found\n\n",t);
			wasErrors = 1;
		}
	}
	
	if (wasErrors) return 0;
	return 1;
}

unsigned char Int64DocsIndexComparator::indexCompare ()
{
	int wasErrors = 0;
	BTIterator it1 ( idx1 );
	BTIterator it2 ( idx2 );
	
	u_int64_tSplaySet keys1;
	u_int64_tSplaySet keys2;
	
	for ( ; !it1.End ( ); )
	{
		u_int64_t t = *((u_int64_t*)it1.Key());
		if (!keys1.contains(t))	keys1.add(t);
		++it1;
	}
	for ( ; !it2.End ( ); )
	{
		u_int64_t t = *((u_int64_t*)it2.Key());
		if (!keys2.contains(t))	keys2.add(t);
		++it2;
	}
	
	Pix i;
	if (keys1 != keys2)
	{
		for (i=keys1.first();i;keys1.next(i))
			if (!keys2.contains(keys1(i)))
			{
				u_int64_t key = keys1(i); 
				char* skey = (char*)&key;
				printf("\tBase 1: key '%c%c%c%c%c%c%c%c' is not presented in Base 2\n",skey[0],skey[1],skey[2],skey[3],skey[4],skey[5],skey[6],skey[7]);
				wasErrors = 1;
			}
		for (i=keys2.first();i;keys2.next(i))
			if (!keys1.contains(keys2(i)))
			{
				u_int64_t key = keys2(i); 
				char* skey = (char*)&key;
				printf("\tBase 2: key '%c%c%c%c%c%c%c%c' is not presented in Base 1\n",skey[0],skey[1],skey[2],skey[3],skey[4],skey[5],skey[6],skey[7]);
				wasErrors = 1;
			}

		return 0;
	}
	
	for (i=keys1.first();i;keys1.next(i))
	{
		u_int64_t t = keys1(i);
		if (!keyCompare(&t))
		{
			char* skey = (char*)&t;
			fprintf(stdout, "\tDiffers in data for key '%c%c%c%c%c%c%c%c' was found\n\n",skey[0],skey[1],skey[2],skey[3],skey[4],skey[5],skey[6],skey[7]);
			wasErrors = 1;
		}
	}
	if (wasErrors) return 0;
	return 1;
}

unsigned char StrDocsIndexComparator::indexCompare ()
{
	int wasErrors = 0;
	BTIterator it1 ( idx1 );
	BTIterator it2 ( idx2 );
	
	FStringSplaySet keys1;
	FStringSplaySet keys2;
	
	for ( ; !it1.End ( ); )
	{
		FString t((char*)it1.Key());
		if (!keys1.contains(t))	keys1.add(t);
		++it1;
	}
	for ( ; !it2.End ( ); )
	{
		FString t((char*)it2.Key());
		if (!keys2.contains(t))	keys2.add(t);
		++it2;
	}
	
	Pix i;
	if (keys1 != keys2)
	{
		for (i=keys1.first();i;keys1.next(i))
			if (!keys2.contains(keys1(i)))
			{
				printf("\tBase 1: key '%s' is not presented in Base 2\n",keys1(i).chars());
				wasErrors = 1;
			}
		for (i=keys2.first();i;keys2.next(i))
			if (!keys1.contains(keys2(i)))
			{
				printf("\tBase 2: key '%s' is not presented in Base 1\n",keys2(i).chars());
				wasErrors = 1;
			}

		return 0;
	}
	
	for (i=keys1.first();i;keys1.next(i))
	{
		if (!keyCompare(keys1(i).chars()))
		{
			fprintf(stdout, "\tDiffers in data for key '%s' was found\n\n",keys1(i).chars());
			wasErrors = 1;
		}
	}
	if (wasErrors) return 0;
	return 1;
}

unsigned char BlobIndexComparator::indexCompare ()
{
	int wasErrors = 0;
	
	BTIterator it1 ( idx1 );
	BTIterator it2 ( idx2 );
	
	longSplaySet docIDs1; 
	longSplaySet docIDs2; 
	
	longSplaySet docIDs; 

	for ( ; !it1.End ( ); )
	{
		long docID = ((ObjKey*) it1.Key ( )) -> id;
		if ( docID >= 100000 )
			if (!docIDs1.contains(docID))
				docIDs1.add(docID);
		++it1;
	}
	
	for ( ; !it2.End ( ); )
	{
		long docID = ((ObjKey*) it2.Key ( )) -> id;
		if ( docID >= 100000 )
			if (!docIDs2.contains(docID))
				docIDs2.add(docID);
		++it2;
	}

	Pix vi;
	if (docIDs1 != docIDs2)
	{
		for (vi = docIDs1.first();vi;docIDs1.next(vi))
		{
			if (!docIDs2.contains(docIDs1(vi)))
			{
				fprintf(stdout, "\tBase 1: object '%ld' was not found in Base 2\n",docIDs1(vi));
				wasErrors = 1;
			}
			else
				docIDs.add(docIDs1(vi));
		}
		for (vi = docIDs2.first();vi;docIDs2.next(vi))
		{
			if (!docIDs1.contains(docIDs2(vi)))
			{
				fprintf(stdout, "\tBase 2: object '%ld' was not found in Base 1\n",docIDs2(vi));
				wasErrors = 1;
			}
		}
	}
	else
		docIDs = docIDs1;

	for (vi = docIDs.first();vi;docIDs.next(vi))
	{
		ObjKey key;
		key.id = docIDs(vi);
		
		if (!keyCompare(&key))
		{
			fprintf(stdout, "\tDiffers for key  '%ld' was found\n\n",key.id);
			wasErrors = 1;
		}
	}

	if (wasErrors) return 0;
	return 1;
}

unsigned char RefIndexComparator::indexCompare ()
{
	int wasErrors = 0;
	BTIterator it1 ( idx1 );
	BTIterator it2 ( idx2 );
	
	u_int32_tSplaySet keys1;
	u_int32_tSplaySet keys2;
	
	for ( ; !it1.End ( ); )
	{
		u_int32_t t = *((u_int32_t*)it1.Key());
		if (!keys1.contains(t))	keys1.add(t);
		++it1;
	}
	for ( ; !it2.End ( ); )
	{
		u_int32_t t = *((u_int32_t*)it2.Key());
		if (!keys2.contains(t))	keys2.add(t);
		++it2;
	}
	
	Pix i;
	if (keys1 != keys2)
	{
		for (i=keys1.first();i;keys1.next(i))
			if (!keys2.contains(keys1(i)))
			{
				printf("\tBase 1: key '%ld' is not presented in Base 2\n",keys1(i));
				wasErrors = 1;
			}
		for (i=keys2.first();i;keys2.next(i))
			if (!keys1.contains(keys2(i)))
			{
				printf("\tBase 2: key '%ld' is not presented in Base 1\n",keys2(i));
				wasErrors = 1;
			}

		return 0;
	}

	curStream = 0;
	for (i=keys1.first();i;keys1.next(i))
	{
		u_int32_t t = keys1(i);
		if (!keyCompare(&t))
		{
			fprintf(stdout, "Differs in data for key '%ld' was found\n\n",t);
			wasErrors = 1;
		}
	}
	
	if (wasErrors) return 0;
	return 1;
}

unsigned char StrsIndexComparator::keyCompare (const void* key)
{
	int wasErrors = 0;

	if (idxName == "Class"		||	idxName == "DocKind"	||	idxName == "Adopted"	||
		idxName == "Type"		||	idxName == "KeyWord"	||	idxName == "PublishedIn"||
		idxName == "Territory")
	{
		str1 = ((HIndex*)idx1) -> OpenN ( key, curStream );
		str2 = ((HIndex*)idx2) -> OpenN ( key, curStream );
		if (!(str1 && str2))
		{
			if (!str1)
				fprintf (stdout, "\tBase 1: No stream for the key '%s' found.\n", ((HIndex::HIndexKey*)key)->text);
			if (!str2)
				fprintf (stdout, "\tBase 2: No stream for the key '%s' found.\n", ((HIndex::HIndexKey*)key)->text);
			return 0;
		}
	}
	else
	{
		str1 = idx1 -> OpenN ( key, curStream );
		str2 = idx2 -> OpenN ( key, curStream );
		if (!(str1 && str2))
		{
			if (!str1)
				fprintf (stdout, "\tBase 1: No stream for the key '%s' found.\n", (char*)key);
			if (!str2)
				fprintf (stdout, "\tBase 2: No stream for the key '%s' found.\n", (char*)key);
			return 0;
		}
	}
	
	
	int size1 =0;
	int size2 =0;
	
	if ( (size1=str1->Length()) != (size2=str2->Length()) )
	{
		idx1->Close(str1);
		idx2->Close(str2);
		return 0;
	}
	
	if ( size1 == 0 )
		return 1;
	
	char *d1 = (char*)malloc ( size1 );
	char *d2 = (char*)malloc ( size2 );
	int l1 = str1 -> Read ( d1, size1 );
	int l2 = str2 -> Read ( d2, size2 );
	
	FStringSplaySet strs1;
	FStringSplaySet strs2;
	
	char* p;
	for (p = d1; (p-d1) < l1; p += (strlen(p)+1))
	{
		FString t(p,strlen(p));
		strs1.add(t);
	}
	for (p = d2; (p-d2) < l2; p += (strlen(p)+1))
	{
		FString t(p,strlen(p));
		strs2.add(t);
	}
	
	Pix i;
	for (i=strs1.first();i;strs1.next(i))
		if (!strs2.contains(strs1(i)))
		{
			printf("\tBase 1: string '%s' is not presented in Base 2\n",strs1(i).chars());
			wasErrors = 1;
		}
	for (i=strs2.first();i;strs2.next(i))
		if (!strs1.contains(strs2(i)))
		{
			printf("\tBase 2: string '%s' is not presented in Base 1\n",strs2(i).chars());
			wasErrors = 1;
		}
	idx1->Close(str1);
	idx2->Close(str2);
	if (wasErrors) return 0;
	return 1;
}

unsigned char DocsIndexComparator::keyCompare (const void* key)
{
	if (idxName == "Class"		||	idxName == "DocKind"	||	idxName == "Adopted"	||
		idxName == "Type"		||	idxName == "KeyWord"	||	idxName == "PublishedIn"||
		idxName == "Territory")
	{
		str1 = ((HIndex*)idx1) -> OpenN ( key, curStream );
		str2 = ((HIndex*)idx2) -> OpenN ( key, curStream );
		
		if (!(str1 && str2))
		{
			if (!str1)
				fprintf (stdout, "\tBase 1: No stream for the key '%ld' found.\n", *((u_int32_t*)key));
			if (!str2)
				fprintf (stdout, "\tBase 2: No stream for the key '%ld' found.\n", *((u_int32_t*)key));
			return 0;
		}
	}
	else
	{
		str1 = idx1 -> OpenN ( key, curStream );
		str2 = idx2 -> OpenN ( key, curStream );
		
		if (!(str1 && str2))
		{
			if (!str1)
				fprintf (stdout, "\tBase 1: No stream for the key '%ld' found.\n", *((u_int32_t*)key));
			if (!str2)
				fprintf (stdout, "\tBase 2: No stream for the key '%ld' found.\n", *((u_int32_t*)key));
			return 0;
		}
	}
	
	curStream = 0;
	
	int wasErrors = 0;
	int i;
	
	if ( idxName != "Respondent" &&  idxName != "Correspondent" &&  idxName != "Class" &&  idxName != "Type" &&  idxName != "KeyWord"  &&  idxName != "DocKind")
	{
		DocCollection col1, col2;
		
		col1.Get ( str1 );
		col2.Get ( str2 );
		
		DocCollection tmp ( col1 );
		tmp.Intersect ( col2 );
		col1.Minus ( tmp );
		col2.Minus ( tmp );
		
		if (col1.ItemCount)
		{
			printf ("\tBase 1: data differs from Base 2: | ");
			for (i=0;i<col1.ItemCount;i++) printf("%ld | ",col1[i]); printf("\n");
			wasErrors = 1;
		}
		if (col2.ItemCount)
		{
			printf ("\tBase 2: data differs from Base 1: | ");
			for (i=0;i<col2.ItemCount;i++) printf("%ld | ",col2[i]); printf("\n");
			wasErrors = 1;
		}
	}
	else
	{
		RefCollection col1, col2;

		col1.Get ( str1 );
		col2.Get ( str2 );

		RefCollection tmp ( col1 );
		tmp.Intersect ( col2 );
		col1.Minus ( tmp );
		col2.Minus ( tmp );

		if (col1.ItemCount)
		{
			printf ("\tBase 1: data differs from Base 2: | ");
			for (i=0;i<col1.ItemCount;i++) printf("%ld.%ld | ",col1[i].DocId,col1[i].Sub); printf("\n");
			wasErrors = 1;
		}
		if (col2.ItemCount)
		{
			printf ("\tBase 2: data differs from Base 1: | ");
			for (i=0;i<col2.ItemCount;i++) printf("%ld.%ld | ",col2[i].DocId,col2[i].Sub); printf("\n");
			wasErrors = 1;
		}
	}
	idx1->Close(str1);
	idx2->Close(str2);
	if (wasErrors) return 0;
	return 1;
}

unsigned char AuxIndexComparator::indexCompare ()
{
	int wasError = 0;
	
	curStream = 0;
	int wasErrors = 0;
	str1 = idx1 -> OpenN ( "Here", 0 );
	str2 = idx2 -> OpenN ( "Here", 0 );
	
	if (str1 && str2)
	{
		int size1 =0;
		int size2 =0;
		
		if ( (size1=str1->Length()) != (size2=str2->Length()) )
		{
			fprintf(stdout, "Differs in stream length for key 'Here'\n");
			wasErrors = 1;
		}
		
		short *d1 = (short*) malloc ( size1 );
		short *d2 = (short*) malloc ( size2 );
		
		int l1 = str1 -> Read ( d1, size1 ) / sizeof(short);
		int l2 = str2 -> Read ( d2, size2 ) / sizeof(short);
		
		int i;
		printf ("Segments in Base 1: | ");
		for (i=0;i<l1;i++) printf("%d | ",d1[i]); printf("\n");
		printf ("Segments in Base 2: | ");
		for (i=0;i<l2;i++) printf("%d | ",d2[i]); printf("\n\n\n");

		idx1->Close(str1);
		idx2->Close(str2);
	}
	else
	{
		wasErrors = 1;
		fprintf(stdout, "Cannot open one of the srreams for key 'Here'\n");
	}

	str1 = idx1 -> OpenN ( "Base", 0 );
	str2 = idx2 -> OpenN ( "Base", 0 );
	
	if (str1 && str2)
	{
		int size1 =0;
		int size2 =0;
		
		if ( (size1=str1->Length()) != (size2=str2->Length()) )
		{
			fprintf(stdout, "Differs in stream length for key 'Base'\n");
			wasErrors = 1;
		}
		
		BaseInfo *d1 = (BaseInfo*) malloc ( size1 );
		BaseInfo *d2 = (BaseInfo*) malloc ( size2 );
		
		int l1 = str1 -> Read ( d1, size1 ) / sizeof(BaseInfo);
		int l2 = str2 -> Read ( d2, size2 ) / sizeof(BaseInfo);
		
		int i;
//		printf ("BaseInfo for Base 1: | ");
//		for (i=0;i<l1;i++) printf("%d - %s | ",d1[i].BaseId,d1[i].Name); printf("\n");
//		printf ("BaseInfo for Base 2: | ");
//		for (i=0;i<l2;i++) printf("%d - %s | ",d2[i].BaseId,d2[i].Name); printf("\n\n\n");
		
		idx1->Close(str1);
		idx2->Close(str2);
	}
	else
	{
		wasErrors = 1;
		fprintf(stdout, "Cannot open one of the srreams for key 'Here'\n");
	}
	
	if (wasError) return 0;
	return 1;
}

unsigned char AttrsIndexComparator::docsCompare ()
{
	int wasErrors = 0;

	BTIterator it1 ( idx1 );
	BTIterator it2 ( idx2 );
	
	longSplaySet docIDs1; 
	longSplaySet docIDs2; 
	
	longSplaySet docIDs; 

	for ( ; !it1.End ( ); )
	{
		long docID = ((AttrKey*) it1.Key ( )) -> DocId;
		if ( docID >= 100000 )
			if (!docIDs1.contains(docID))
				docIDs1.add(docID);
		++it1;
	}
	
	for ( ; !it2.End ( ); )
	{
		long docID = ((AttrKey*) it2.Key ( )) -> DocId;
		if ( docID >= 100000 )
			if (!docIDs2.contains(docID))
				docIDs2.add(docID);
		++it2;
	}

	Pix vi;
	if (docIDs1 != docIDs2)
	{
		for (vi = docIDs1.first();vi;docIDs1.next(vi))
		{
			if (!docIDs2.contains(docIDs1(vi)))
			{
				fprintf(stdout, "\tBase 1: document '%ld' was not found in Base 2\n",docIDs1(vi));
				wasErrors = 1;
			}
			else
				docIDs.add(docIDs1(vi));
		}
		for (vi = docIDs2.first();vi;docIDs2.next(vi))
		{
			if (!docIDs1.contains(docIDs2(vi)))
			{
				fprintf(stdout, "\tBase 2: document '%ld' was not found in Base 1\n",docIDs2(vi));
				wasErrors = 1;
			}
		}
	}
	else
		docIDs = docIDs1;

	for (Pix il=docIDs.first();il;docIDs.next(il))
	{
		AttrKey key;
		key.DocId = docIDs(il);
		key.AttrTag = IDD_INFO;
		Stream * str1 = idx1 -> Open ( &key );
		Stream * str2 = idx2 -> Open ( &key );
		
		DocInfo doc1;
		DocInfo doc2;
		Document* docum1;
		Document* docum2;
		char *para1;
		char *para2;
		
		str1 -> Read ( &doc1, sizeof (DocInfo) ); idx1 -> Close ( str1 );
		str2 -> Read ( &doc2, sizeof (DocInfo) ); idx2 -> Close ( str2 );
		
		if ( doc1.ParaCount != doc2.ParaCount )
		{
			wasErrors = 1;
		}
		
		docum1 = new Document ( (Base*) b1, key.DocId );
		docum2 = new Document ( (Base*) b2, key.DocId );
		
		for (int i = 0; i < doc1.ParaCount; i++ )
		{
			para1 = docum1 -> GetPara ( i );
			para2 = docum2 -> GetPara ( i );
			
			if ( ParaSize ( para1 ) == ParaSize ( para2 ) )
			{
				if ( memcmp(para1,para2,ParaSize(para1)) != 0 )
				{
					wasErrors = 1;
				}
			}
			else
			{
				wasErrors = 1;
			}
		}
		delete docum1;
		delete docum2;
		if (wasErrors) fprintf(stdout, "\tDiffers in documents' body. ID: '%ld'\n",key.DocId);
	}
	if (wasErrors) return 0;
	return 1;
}

unsigned char AttrsIndexComparator::indexCompare ()
{
	int wasErrors = 0;
	
	BTIterator it1 ( idx1 );
	BTIterator it2 ( idx2 );
	
	longSplaySet docIDs1; 
	longSplaySet docIDs2; 
	
	longSplaySet docIDs; 

	for ( ; !it1.End ( ); )
	{
		long docID = ((AttrKey*) it1.Key ( )) -> DocId;
		if ( docID >= 100000 )
			if (!docIDs1.contains(docID))
				docIDs1.add(docID);
		++it1;
	}
	
	for ( ; !it2.End ( ); )
	{
		long docID = ((AttrKey*) it2.Key ( )) -> DocId;
		if ( docID >= 100000 )
			if (!docIDs2.contains(docID))
				docIDs2.add(docID);
		++it2;
	}

	Pix vi;
	if (docIDs1 != docIDs2)
	{
		for (vi = docIDs1.first();vi;docIDs1.next(vi))
		{
			if (!docIDs2.contains(docIDs1(vi)))
			{
				fprintf(stdout, "\tBase 1: document '%ld' was not found in Base 2\n",docIDs1(vi));
				wasErrors = 1;
			}
			else
				docIDs.add(docIDs1(vi));
		}
		for (vi = docIDs2.first();vi;docIDs2.next(vi))
		{
			if (!docIDs1.contains(docIDs2(vi)))
			{
				fprintf(stdout, "\tBase 2: document '%ld' was not found in Base 1\n",docIDs2(vi));
				wasErrors = 1;
			}
		}
	}
	else
		docIDs = docIDs1;

	for (vi = docIDs.first();vi;docIDs.next(vi))
	{
		AttrKey key;
		key.DocId = docIDs(vi);

		curKey.DocId = key.DocId;
		const int* tagIDs;
		const char** stagIDs;
		int tagCount = getTagIDs(tagIDs);
		int i;
		for (i = 0; i < tagCount; i++)
		{
			key.AttrTag = tagIDs[i];
			curKey.AttrTag = key.AttrTag;
			if (!keyCompare(&key))
			{
				fprintf(stdout, "\tDiffers in key '%ld -- %s'\n\n",key.DocId,attrs[tagIDs[i]].chars());
				wasErrors = 1;
			}
		}
	}
	if (wasErrors) return 0;
	return 1;
}

unsigned char HIndexComparator::indexCompare ()
{
	int wasErrors = 0;
	u_int32_tFStringSplayMap cs1(FString(""));
	u_int32_tFStringSplayMap cs2(FString(""));

	u_int32_tSplaySet nodes1;
	u_int32_tSplaySet leafs1;
	longlongSplayMap cp1(0);
	u_int32_tSplaySet nodes2;
	u_int32_tSplaySet leafs2;
	longlongSplayMap cp2(0);


	FStringSplaySet keys1;
	FStringSplaySet keys2;

	for( BTIterator it1(DocsIndexComparator::idx1); ! it1.End(); ++it1 )
	{
		const void * k = it1.Key();
		long id = ((HIndex*)DocsIndexComparator::idx1)->Id(k);
		long pid = ((HIndex*)DocsIndexComparator::idx1)->Parent(k);
		long lev = ((HIndex*)DocsIndexComparator::idx1)->Level(k);

		cp1[id] = pid;
		nodes1.add(pid);
		cs1[id] = (char*)((HIndex*)DocsIndexComparator::idx1)->Text(k);
	}

	for( BTIterator it2(DocsIndexComparator::idx2); ! it2.End(); ++it2 )
	{
		const void * k = it2.Key();
		long id = ((HIndex*)DocsIndexComparator::idx2)->Id(k);
		long pid = ((HIndex*)DocsIndexComparator::idx2)->Parent(k);

		cp2[id] = pid;
		nodes2.add(pid);
		cs2[id] = (char*)((HIndex*)DocsIndexComparator::idx2)->Text(k);
	}

	Pix i;
	for (i=cp1.first();i;cp1.next(i))
	{
		long id = cp1.key(i);
		if (!nodes1.contains(id))
			leafs1.add(id);
	}
	for (i=cp2.first();i;cp2.next(i))
	{
		long id = cp2.key(i);
		if (!nodes2.contains(id))
			leafs2.add(id);
	}

	for (i=leafs1.first();i;leafs1.next(i))
	{
		long id = leafs1(i);
		long pid;
		FString * t = new FString(cs1[id].chars());
		for (pid = cp1[id]; pid; id = pid, pid = cp1[id] )
		{
			if (!cp1.contains(pid)) break;
			const char* preS = cs1[pid].chars();
			const char* postS = t->chars();
			char* str = new char[strlen(preS)+1+strlen(postS)+1];
			strcpy(str,preS); str[strlen(preS)] = '\\'; 
			strcpy(str+strlen(preS)+1,postS);
			delete t;
			t = new FString(str);
			free(str);
		}
		if (pid)
		{
			wasErrors = 1;
			fprintf(stdout, "Base1: bad node with key '|%ld|%ld|%s|'",id,pid,cs1[id].chars());
		}
		else
			keys1.add(*t);
	}

	for (i=leafs2.first();i;leafs2.next(i))
	{
		long id = leafs2(i);
		long pid;
		FString * t = new FString(cs2[id].chars());
		for (pid = cp2[id]; pid; id = pid, pid = cp2[id] )
		{
			if (!cp2.contains(pid)) break;
			const char* preS = cs2[pid].chars();
			const char* postS = t->chars();
			char* str = new char[strlen(preS)+1+strlen(postS)+1];
			strcpy(str,preS); str[strlen(preS)] = '\\'; 
			strcpy(str+strlen(preS)+1,postS);
			delete t;
			t = new FString(str);
			free(str);
		}
		if (pid)
		{
			wasErrors = 1;
			fprintf(stdout, "Base 2: bad node with key '|%ld|%ld|%s|'",id,pid,cs2[id].chars());
		}
		else
			keys2.add(*t);
	}

	if (keys1 != keys2)
	{
		for (i=keys1.first();i;keys1.next(i))
			if (!keys2.contains(keys1(i)))
			{
				printf("\tBase 1: key '%s' is not presented in Base 2\n",keys1(i).chars());
				wasErrors = 1;
			}
		for (i=keys2.first();i;keys2.next(i))
			if (!keys1.contains(keys2(i)))
			{
				printf("\tBase 2: key '%s' is not presented in Base 1\n",keys2(i).chars());
				wasErrors = 1;
			}

		return 0;
	}

	DocsIndexComparator::curStream = 0;
	for (i = keys1.first();i;keys1.next(i))
	{
		if (!DocsIndexComparator::keyCompare(keys1(i).chars()))
		{
			fprintf(stdout, "\tDiffers in data for key '%s' was found\n\n",keys1(i).chars());
			wasErrors = 1;
		}
	}

	if ( StrsIndexComparator::idxName == "Class" ||  StrsIndexComparator::idxName == "DocKind" ||  StrsIndexComparator::idxName == "Adopted" )
	{
		StrsIndexComparator::curStream = 1;
		StrsIndexComparator::str1++; StrsIndexComparator::str2++;
		for (Pix i = keys1.first();i;keys1.next(i))
		{
			if (!StrsIndexComparator::keyCompare(keys1(i).chars()))
			{
				fprintf(stdout, "\tDiffers in data for key '%s' was found\n\n",keys1(i).chars());
				wasErrors = 1;
			}
		}
		StrsIndexComparator::str1--; StrsIndexComparator::str2--;
	}

	if (wasErrors) return 0;
	return 1;
}

unsigned char StrAttrsIndexComparator::dataCompare (const void* data1, int len1, const void* data2, int len2)
{
	char* d1 = (char*)data1;
	int l1 = len1 / sizeof(char);
	char* d2 = (char*)data2;
	int l2 = len2 / sizeof(char);

	FStringSplaySet ss1;
	FStringSplaySet ss2;

	char* p;
	for (p = d1; (p-d1) < l1; p += (strlen(p)+1))
	{
		FString t(p,strlen(p));
		ss1.add(t);
	}
	for (p = d2; (p-d2) < l2; p += (strlen(p)+1))
	{
		FString t(p,strlen(p));
		ss2.add(t);
	}

	if (ss1 != ss2)
	{
		Pix i;
		printf("\tDiffers in attribute value:\n\tBase 1: | ");
		for (i=ss1.first();i;ss1.next(i))
		{
			printf("%s | ",ss1(i).chars());
		}
		printf("\n\tBase 2: | ");
		for (i=ss2.first();i;ss2.next(i))
		{
			printf("%s | ",ss2(i).chars());
		}
		printf("\n");
		return 0;
	}
	return 1;
}

unsigned char DateAttrsIndexComparator::dataCompare (const void* data1, int len1, const void* data2, int len2)
{
	int wasErrors = 0;
	u_int32_tSplaySet dates1;
	u_int32_tSplaySet dates2;
	
	date * p;
	int ic;
	for ( ic=0, p = (date*)data1; ic < len1/sizeof(date); ic++,p++)
	{
		u_int32_t t = *((u_int32_t*)p);
		if (!dates1.contains(t))	dates1.add(t);
	}
	for ( ic=0, p = (date*)data2; ic < len2/sizeof(date); ic++,p++)
	{
		u_int32_t t = *((u_int32_t*)p);
		if (!dates2.contains(t))	dates2.add(t);
	}

	Pix i;
	if (dates1 != dates2)
	{
		printf("\tDiffers in attribute value:\n\tBase 1: | ");
		for (i=dates1.first();i;dates1.next(i))
		{
			u_int32_t key = dates1(i);
			if (curKey.AttrTag != IDD_BASES && curKey.AttrTag != IDD_BLOB)
			{
				date* dkey = (date*)&key;
				printf("%ld/%ld/%ld | ",dkey->da_year,dkey->da_mon,dkey->da_day);
			}
			else
				printf("%ld | ",key);
		}
		printf("\n\tBase 2: | ");
		for (i=dates2.first();i;dates2.next(i))
		{
			u_int32_t key = dates2(i);
			if (curKey.AttrTag != IDD_BASES && curKey.AttrTag != IDD_BLOB)
			{
				date* dkey = (date*)&key;
				printf("%ld/%ld/%ld | ",dkey->da_year,dkey->da_mon,dkey->da_day);
			}
			else
				printf("%ld | ",key);
		}
		printf("\n");
		return 0;
	}
	return 1;
}

unsigned char SubAttrsIndexComparator::dataCompare (const void* data1, int len1, const void* data2, int len2)
{
	int wasErrors = 0;
	u_int64_tSplaySet subs1;
	u_int64_tSplaySet subs2;
	
	SubDesc * p;
	int ic;
	for ( ic=0, p = (SubDesc*)data1; ic < len1/sizeof(SubDesc); ic++,p++)
	{
		u_int64_t t = *((u_int64_t*)p);
		if (!subs1.contains(t))	subs1.add(t);
	}
	for ( ic=0, p = (SubDesc*)data2; ic < len2/sizeof(SubDesc); ic++,p++)
	{
		u_int64_t t = *((u_int64_t*)p);
		if (!subs2.contains(t))	subs2.add(t);
	}

	Pix i;
	if (subs1 != subs2)
	{
		printf("\tDiffers in attribute value:\n\tBase 1: | ");
		for (i=subs1.first();i;subs1.next(i))
		{
			u_int64_t key = subs1(i);
			SubDesc* dkey = (SubDesc*)&key;
			printf("%ld.%ld | ",dkey->Sub,dkey->Para);
		}
		printf("\n\tBase 2: | ");
		for (i=subs2.first();i;subs2.next(i))
		{
			u_int64_t key = subs2(i);
			SubDesc* dkey = (SubDesc*)&key;
			printf("%ld.%ld | ",dkey->Sub,dkey->Para);
		}
		printf("\n");
		return 0;
	}
	return 1;
}

unsigned char InfoAttrsIndexComparator::dataCompare (const void* data1, int len1, const void* data2, int len2)
{
	if (!(len1 == len2 && len2 == sizeof(DocInfo)))
	{
		printf("\tBad data for Document Info\n");
		return 0;
	}

	DocInfo* di1 = (DocInfo*)data1;
	DocInfo* di2 = (DocInfo*)data2;
	if (di1->Size		!= di2->Size		|| 
		di1->ParaCount	!= di2->ParaCount	|| 
		di1->Status		!= di2->Status		|| 
		di1->Force		!= di2->Force)
	{
		printf("\tDiffers in Info for '%ld':\n",curKey.DocId);
		printf("\tBase 1:\n\t\tTitle - '%s'\n\t\tSize - '%ld'\n\t\tParaCount - '%ld'\n\t\tStatus - '%s'\n\t\tForce - '%ld'\n\t\tRelated - '%ld'\n",
			di1->Title,di1->Size,di1->ParaCount,stats[(u_int32_t)(unsigned short)(di1->Status)].chars(),di1->Force,di1->Related);
		printf("\tBase 2:\n\t\tTitle - '%s'\n\t\tSize - '%ld'\n\t\tParaCount - '%ld'\n\t\tStatus - '%s'\n\t\tForce - '%ld'\n\t\tRelated - '%ld'\n",
			di2->Title,di2->Size,di2->ParaCount,stats[(u_int32_t)(unsigned short)(di2->Status)].chars(),di2->Force,di2->Related);
		return 0;
	}
	return 1;
}

int usage ( char *str )
{
	fprintf( stdout, "GARANT Base comparator v%s (%s %s)\n", GARANT_VERSION, __DATE__, __TIME__);
	fprintf( stdout, "Usage: %s <base 1> <base 2>\n", str);
	fprintf( stdout, "Options: -h for this help\n");
	return 0;
}

static char* IDX[] = 
{
	"Aux", "Date", "RDate", "VIncluded", "VChanged", "VAbolished", "SortDate", "VAnonced",
	"VLControl", "Category", "Number", "RCode", "Status", "Segment", "Respondent", "Correspondent", "SubName", "Attrs", "Attrs", "Attrs",
	"Blob", "Class", "Type", "KeyWord", "PublishedIn", "Territory", "DocKind", "Adopted",
	"Attrs", "Context",	"NameContext", g_yakNick
};

int main(int argc, char* argv[])
{
	fprintf ( stdout, "Garant base comparator.\n" );

	int s = 0;
	unsigned char bReadDocs = 1;

	if ( argc < 3 )
	       return usage ( argv [0] );

	if ( !strcmpi ( argv [1], "-h" ) )
	       return usage ( argv [0] );

	if ( !strcmpi ( argv [1], "-d" ) )
	{ bReadDocs = 0; s++; }

	if ( !strcmpi ( argv [2], "-h" ) )
	       return usage ( argv [0] );

	FStringSplaySet indxs;
	if (argc > 3+s)
	{
		for (int iii = 3+s; iii < argc; iii++)
		{
			FString sind(argv[iii]);
			indxs.add(sind);
		}
	}
	else
	{
		for (int iii = 0; iii < 31; iii++)
		{
			FString sind(IDX[iii]);
			indxs.add(sind);
		}
	}

	Base *b1 = new YBase ( argv [1+s], ACE_OS_O_RDONLY );
	Base *b2 = new YBase ( argv [2+s], ACE_OS_O_RDONLY );

	fprintf ( stdout, "Base 1 :  %s \n", argv [1+s] );
	fprintf ( stdout, "Base 2 :  %s \n\n\n", argv [2+s] );

	if ( !b1 || !b1 -> IsOk ( ) )
	{
		fprintf ( stderr, "Base %s not ok.\n", argv [1+s] );
		return usage ( argv [0] );
	}

	if ( !b2 || !b2 -> IsOk ( ) )
	{
		fprintf ( stderr, "Base %s not ok.\n", argv [2+s] );
		return usage ( argv [0] );
	}

	stats[DS_ACTIVE] = "DS_ACTIVE";
	stats[DS_ABOLISHED] = "DS_ABOLISHED";
	stats[DS_PREACTIVE] = "DS_PREACTIVE";
	stats[DS_MOJREG] = "DS_MOJREG";
	stats[DS_MOJNOTREG] = "DS_MOJNOTREG";
	stats[DS_NODOC] = "DS_NODOC";
	stats[DS_DOC] = "DS_DOC";
	stats[DS_ISDOC] = "DS_ISDOC";
	stats[DS_ISCOMMENT] = "DS_ISCOMMENT";
	stats[DS_ISFORM] = "DS_ISFORM";
	stats[DS_ISPROJECT] = "DS_ISPROJECT";
	stats[DS_ISPRACTIK] = "DS_ISPRACTIK";
	stats[DS_ISPRAKTIC] = "DS_ISPRAKTIC";
	stats[DS_ISINTER] = "DS_ISINTER";
	stats[DS_ISQUESTION] = "DS_ISQUESTION";
	stats[DS_ISBREFER] = "DS_ISBREFER";
	stats[DS_MOJOTHER] = "DS_MOJOTHER";
	
	attrs[IDD_INFO] = "IDD_INFO";
	attrs[IDD_BASES] = "IDD_BASES";
	attrs[IDD_BLOB] = "IDD_BLOB";
	attrs[IDD_NAME] = "IDD_NAME";
	attrs[IDD_ID] = "IDD_ID";
	attrs[IDD_TERRITORY] = "IDD_TERRITORY";
	attrs[IDD_SOURCE] = "IDD_SOURCE";
	attrs[IDD_DIV] = "IDD_DIV";
	attrs[IDD_KEY] = "IDD_KEY";
	attrs[IDD_TYPE] = "IDD_TYPE";
	attrs[IDD_RCODE] = "IDD_RCODE";
	attrs[IDD_DOCKIND] = "IDD_DOCKIND";
	attrs[IDD_WARNING] = "IDD_WARNING";
	attrs[IDD_CATEGORY] = "IDD_CATEGORY";
	attrs[IDD_PUBLISHEDIN] = "IDD_PUBLISHEDIN";
	attrs[IDD_DATE] = "IDD_DATE";
	attrs[IDD_VINCLUDED] = "IDD_VINCLUDED";
	attrs[IDD_VCHANGED] = "IDD_VCHANGED";
	attrs[IDD_VABOLISHED] = "IDD_VABOLISHED";
	attrs[IDD_RDATE] = "IDD_RDATE";
	attrs[IDD_SORTDATE] = "IDD_SORTDATE";
	attrs[IDD_VANONCED] = "IDD_VANONCED";
	attrs[IDD_VLCONTROL] = "IDD_VLCONTROL";
	attrs[IDD_SUBS] = "IDD_SUBS";
	
	IndexComparator** comps = new IndexComparator*[31];
	comps[0] = new AuxIndexComparator(b1,b2,"Aux",1);
	comps[1] = new Int32DocsIndexComparator(b1,b2,"Date",1);
	comps[2] = new Int32DocsIndexComparator(b1,b2,"RDate",1);
	comps[3] = new Int32DocsIndexComparator(b1,b2,"VIncluded",1);
	comps[4] = new Int32DocsIndexComparator(b1,b2,"VChanged",1);
	comps[5] = new Int32DocsIndexComparator(b1,b2,"VAbolished",1);
	comps[6] = new Int32DocsIndexComparator(b1,b2,"SortDate",1);
	comps[7] = new Int32DocsIndexComparator(b1,b2,"VAnonced",1);
	comps[8] = new Int32DocsIndexComparator(b1,b2,"VLControl",1);
	comps[9] = new StrDocsIndexComparator(b1,b2,"Category",1);
	comps[10] = new StrDocsIndexComparator(b1,b2,"Number",1);
	comps[11] = new StrDocsIndexComparator(b1,b2,"RCode",1);
	comps[12] = new Int32DocsIndexComparator(b1,b2,"Status",1);
	comps[13] = new Int32DocsIndexComparator(b1,b2,"Segment",1);
	comps[14] = new Int32DocsIndexComparator(b1,b2,"Respondent",1);
	comps[15] = new Int32DocsIndexComparator(b1,b2,"Correspondent",1);
	comps[16] = new RefIndexComparator(b1,b2,"SubName",1);
	comps[17] = new StrAttrsIndexComparator(b1,b2,"Attrs",1);
	comps[18] = new SubAttrsIndexComparator(b1,b2,"Attrs",1);
	comps[19] = new DateAttrsIndexComparator(b1,b2,"Attrs",1);
	comps[20] = new BlobIndexComparator(b1,b2,"Blob",2);
	comps[21] = (DocsIndexComparator*)new HIndexComparator(b1,b2,"Class",2);
	comps[22] = (DocsIndexComparator*)new HIndexComparator(b1,b2,"Type",1);
	comps[23] = (DocsIndexComparator*)new HIndexComparator(b1,b2,"KeyWord",1);
	comps[24] = (DocsIndexComparator*)new HIndexComparator(b1,b2,"PublishedIn",1);
	comps[25] = (DocsIndexComparator*)new HIndexComparator(b1,b2,"Territory",1);
	comps[26] = (DocsIndexComparator*)new HIndexComparator(b1,b2,"DocKind",2);
	comps[27] = (DocsIndexComparator*)new HIndexComparator(b1,b2,"Adopted",2);
	comps[28] = new InfoAttrsIndexComparator(b1,b2,"Attrs",1);
	comps[29] = new Int64DocsIndexComparator(b1,b2,"Context",1);
	comps[30] = new Int64DocsIndexComparator(b1,b2,"NameContext",1);

	if (!comps[0]->indexCompare())
	{
		return 1;
	}
	for (int i = 1; i < 31; i++)
	{
		FString idx_name(IDX[i]);
		idx_name.bDoFree = 1;
		if (indxs.contains(idx_name))
		{
			fprintf (stdout, "Start comparing index '%s'...\n",IDX[i]);
			if (!comps[i]->indexCompare())
			{
				fprintf (stdout, "...Errors found.\n\n");
			}
			else
			{
				fprintf (stdout, "...OK.\n\n");
			}
		}
		delete comps[i];
	}
	delete[] comps;

	fprintf (stdout, "Start comparing documents ...\n");
	AttrsIndexComparator * comp = new InfoAttrsIndexComparator(b1,b2,"Attrs",1);
	if (!comp->docsCompare())
	{
		fprintf (stdout, "...Errors found.\n\n");
	}
	else
	{
		fprintf (stdout, "...OK.\n\n");
	}
	delete comp;
	return 0;
}

