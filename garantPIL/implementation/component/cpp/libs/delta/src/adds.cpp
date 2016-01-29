#include "shared/Core/fix/mpcxc.h"
/*
 * $Id: adds.cpp,v 2.67 2015/07/24 10:23:36 young Exp $
 */
			      // adds.cpp //
///////////////////////////////////////////////////////////////////////////////
//									     //
// Purpose:								     //
//	Define the BaseInfoMap class and some functions			     //
//									     //
// Author:								     //
//	Garant-Service							     //
//									     //
///////////////////////////////////////////////////////////////////////////////

extern	short DELTA_DATA_VERSION;

#include <cstdlib> // GARANT_GCC
#include <cstdio>
#include <ctime>

#include "adds.h"
#include "dhr_ver.h"
#include "gardefs.h"
#include "StorableSplaySet.h"
#include "garver.h"
#include "basemask.h"
#include "garutils.h"
#include "rev.h"

//////////////////////////////////////////////////////////////////////////////

int	CCr [16];

extern Logger logger;

//////////////////////////////////////////////////////////////////////////////
//			     BaseInfoMap				    //
//////////////////////////////////////////////////////////////////////////////

BaseInfo BaseInfoMap::bi_dummy;

	BaseInfoMap::BaseInfoMap( Base* base )
	: SplayMap<short, BaseInfo>(bi_dummy) 
{
	if( base )
	{
		StorableSplaySet<short>	here;
		Stream*			str;

		str = base->FindIndex("Aux")->Open("Here");

		here.Get ( str );
		base->FindIndex("Aux")->Close( str );
		here._add(0);
			
		for ( Point p = here.first(); p; here.next(p) )
		{
			BaseInfo info;

			if ( base->FindBaseInfo ( here.contents (p), info ) )
				add ( here.contents (p), info );
			else
				logger.printf ( lt_error, "Can't open BaseInfo for %d seg\n", here.contents (p) );
		}
	}		
}

//////////////////////////////////////////////////////////////////////////////

int	BaseInfoMap::SaveInfo ( Base* base ) 
{
	int	res = 1;

	if( base )
	{
		for( Point p = first (); p; next (p) )
			if ( !base->ReplaceBaseInfo ( key (p), &contents (p) ) )
			{
				res = 0;
				logger.printf ( lt_error, "Can't update BaseInfo for %d seg\n", contents (p).BaseId );
			}
	} else
		res = 0;

	return res;
}

//////////////////////////////////////////////////////////////////////////////
//			    BlobIterator				    //
//////////////////////////////////////////////////////////////////////////////

void BlobIterator :: next () 
{
	if( !End() )
	{
		do
			BTIterator::next();  
		while( !(End() || CheckCurrentKey()) );
	}
}

//////////////////////////////////////////////////////////////////////////////

void BlobIterator::prev(void)
{
	do
		BTIterator::prev(); 
	while ( !CheckCurrentKey() );
}

//////////////////////////////////////////////////////////////////////////////

int BlobIterator::CheckCurrentKey(void)
{	
	const void	*pkey = Key();
	
	if( !m_pids || !pkey )
		return 1;
		
	StorableSplaySet<unsigned short>	ids;
	Stream					*pstr;

	if ( pstr = ((Index *)tree)->OpenN( pkey, 1 ) )
	{
		ids.Get(pstr);
		((Index *)tree)->Close(pstr);
	}

	return ids & (*m_pids);
}

//////////////////////////////////////////////////////////////////////////////
//			    functions					    //
//////////////////////////////////////////////////////////////////////////////

short objcmp ( Stream * str1, Stream * str2 )
{
	short res = BO_BLBEQU;

	ObjInfo inf1;
	ObjInfo inf2;
	if ( str1->Read ( &inf1, sizeof(ObjInfo) ) != sizeof(ObjInfo) )
		return res;
	if ( str2->Read ( &inf2, sizeof(ObjInfo) ) != sizeof(ObjInfo) )
		return res;	

	if ( inf1.crc32!=inf2.crc32 )
		res |= BO_OBJCHG|BO_INFCHG;
	if ( inf1.type!=inf2.type || strncmp(inf1.name, inf2.name, NAME_SIZE) || memcmp(inf1.reserved, inf2.reserved, 16) )
		res |= BO_INFCHG;
	
	{
		long	tailSize1 = str1->Length() - sizeof(ObjInfo) - inf1.size;
		long	tailSize2 = str2->Length() - sizeof(ObjInfo) - inf2.size;

		if ( tailSize1 == tailSize2 )
		{
			void	*tail1 = malloc ( tailSize1 );
			void	*tail2 = malloc ( tailSize2 );

			str1->SeekCur(inf1.size);
			str2->SeekCur(inf2.size);
			str1->Read ( tail1, tailSize1 );
			str2->Read ( tail2, tailSize2 );

			if ( memcmp ( tail1, tail2, tailSize1 ) )
				res |= BO_TALCHG;

			free ( tail1 );
			free ( tail2 );

		} else
			res |= BO_TALCHG;		
	}

	return res;
}

//////////////////////////////////////////////////////////////////////////////

short bicmp ( BaseInfo& a, BaseInfo& b )
{	
	return  strcmp (a.Name,       b.Name)       ||
		strcmp (a.NameEng,    b.NameEng)    ||
		strcmp (a.AuthorName, b.AuthorName) ||
		a.Weight        != b.Weight         ||
		a.SplashTopic   != b.SplashTopic    ||
		a.BannerTopic   != b.BannerTopic;
}

//////////////////////////////////////////////////////////////////////////////

int DocInfoCmp ( DocInfo& a, DocInfo& b, bool compare_lastParaID )
{
	/* ATTENTION!!! Compare only this filds :

	char	 Title [DOC_SHORT_NAME_SIZE];
	struct date	 FirstDate;
	struct date	 LastDate;
	short	 Force;
	short	 HyperRefs;
	short	 GreenComments;
	short	 Status;
	short	 Status_ex;
	long	 Related

	for VERSION56 (revisions) compare
	long	prevEdition
	long	nextEdition
	char	reserved
	*/
	int res = strcmp ( a.Title, b.Title );
	if ( !res )
		res = CompDates ( &a.FirstDate, &b.FirstDate );
	if ( !res )
		res = CompDates ( &a.LastDate, &b.LastDate );
	if ( !res )
		res = !( a.Force == b.Force &&
			 a.HyperRefs == b.HyperRefs &&
			 a.GreenComments == b.GreenComments &&
			 a.Status == b.Status &&
			 a.Status_ex == b.Status_ex &&
			 a.Related == b.Related && 
			 a.prevEdition == b.prevEdition &&
			 a.nextEdition == b.nextEdition &&
			 a.reserved_short == b.reserved_short &&
			 a.reserved_short2== b.reserved_short2 &&
			 a.Status_exex_part1 == b.Status_exex_part1 &&
			 a.Status_exex_part2 == b.Status_exex_part2 &&
			 a.long_respondents == b.long_respondents &&
			 a.hi_long_respondents == b.hi_long_respondents &&
			 (!compare_lastParaID || (compare_lastParaID && (a.lastParaID == b.lastParaID)))
			);

	return res;
}

//////////////////////////////////////////////////////////////////////////////

long SaveStream ( Stream* pstr, FILE* pfile, long from, long count, short saveCount )
{
	if( from == -1 )
		from = pstr->Tell();
	else
		pstr->Seek(from);

	if( count == -1 )
		count = pstr->Length() - from;

	if (count <= 0)
	{
		count = 0;
		if ( saveCount )
			fwrite ( &count, sizeof ( count ), 1, pfile );
	} else {
		void* buf = malloc ( count );

		assert ( buf );
		pstr->Read ( buf, count );

		if ( saveCount )
			fwrite ( &count, sizeof ( count ), 1, pfile );

		fwrite ( buf, 1, count, pfile );
		free ( buf );
	}

	return count + saveCount ? sizeof ( count ) : 0;
} 

//////////////////////////////////////////////////////////////////////////////

StringZ * LoadStrz ( Base* base, long docId, int tag )
{
	long	size = 0;
	void	*buf = base->LoadAttr( docId, tag, size );

	if ( size <= 0 || !buf )
		return 0;

	int	withSub = (tag==IDD_KEY ||
			   tag==IDD_DIV ||
			   tag == IDD_DOCKIND ||
			   tag == IDD_TYPE ) ? 1 : 0; // Keys with sub
	
	//
	// store all data into StringZ
	//
	StringZ*	ret = new StringZ((char*)buf, size, withSub, 1 );

	//
	// and free loaded buf
	//
	free( buf );
	return ret;
}
 
//////////////////////////////////////////////////////////////////////////////

int readSubs(const char *str, DocCollection *& pSubColl)
{
	char *eptr;
	pSubColl = new DocCollection ( );

	while( *str )
	{
		unsigned long	b = strtoul(str,&eptr,10);
		if( *eptr != ',' &&  *eptr != ':' )
		{
			OkBox ("Error!", "Unexpected char in given string.\n");
			delete pSubColl;
			return 0;
		}
		pSubColl->Add ( b );
		if( *eptr ==':' )
			break;
		str = eptr+1;
	}
	return 1;
}

//////////////////////////////////////////////////////////////////////////////

inline int isdigit ( char c )
{
	return c=='0'||c=='1'||c=='2'||c=='3'||c=='4'||c=='5'||c=='6'||c=='7'||c=='8'||c=='9';
}

//////////////////////////////////////////////////////////////////////////////

int read_unsignedlongs ( SplaySet<long>& set, const char * filename )
{
	int	file = ace_os_open ( filename, ACE_OS_O_RDONLY | ACE_OS_O_BINARY );

	if( file == -1 )
		return 0;

	size_t count = ace_os_filesize(file); // filelength() - were
	
	char	*buf = (char*) malloc ( count+2 );

	buf[count] = 0;

	if( count != (size_t) ace_os_read ( file, buf, count ) )
	{
		ace_os_close ( file );
		return 0;
	}

	ace_os_close ( file );	
	
	char	*begin = buf;
	char	*end = buf;
	
	for ( size_t l = 0; l < count + 1; l ++, end ++)
	{
		if ( !isdigit ( *end ) )
		{
			if ( begin == end )
				begin++;
			else {
				*end = 0;
				long ul;
				sscanf ( begin, "%ld", &ul );
				if ( ul > 0 )
					set.add( (ul += 100000) );
				begin = end+1;
			}
		}		
	}

	free (buf);
	return 1;
}

//////////////////////////////// visualize ///////////////////////////////////

char gmess_pDocsUp [] = "Обновление информационного банка";
char gmess_pDocsUpEn[]= "Updating base";

#define TOTAL_COUNT_OF_FLUSHING 2

long g_lDocProcCount    = 0;
long g_lAllDoc          = 0;
long g_siPrevDocPerc    = 0;
long g_lCtxProcCount    = 0;
long g_lAllCtx          = 0;
long g_siPrevCtxPerc    = 0;
long g_lMemProcCount    = 0;
long g_lAllMem          = 0;
long g_siPrevMemPerc    = 0;
long g_lAllPara          = 0;
long g_lParaProcCount    = 0;
long g_siPrevParaPerc    = 0;
long g_lFlushCounter	=0;
long totalFlushs = TOTAL_COUNT_OF_FLUSHING;

static ProgressScreen* g_pScreen;

//////////////////////////////////////////////////////////////////////////////

void SetProgressScreen ( ProgressScreen* screen )
{
	g_pScreen = screen;
}

ProgressScreen* GetProgressScreen()
{
	return g_pScreen;
}

//////////////////////////////////////////////////////////////////////////////

void DocsProcCreate ( long lDocInDelta, bool bEnglish )
{
	g_lAllDoc = lDocInDelta;
	g_lDocProcCount = 0;
	g_siPrevDocPerc = 0;
	
	g_pScreen->SetMessage( bEnglish ? gmess_pDocsUpEn : gmess_pDocsUp );
	g_pScreen->SetProgress( 0 );
}

//////////////////////////////////////////////////////////////////////////////

void AddDelta ( long lDeltaCount, bool bEnglish )
{
	g_lDocProcCount += lDeltaCount;
	short siNewPerc = (short)(( g_lDocProcCount * 100 ) / g_lAllDoc);
	if ( siNewPerc >= 0 && siNewPerc <= 100 ) {
		if ( siNewPerc > g_siPrevDocPerc ) {
			char pbuf[256];
			g_pScreen->SetProgress( siNewPerc );
			sprintf ( pbuf, bEnglish ? "%s (%ld docs updated)" : "%s (обработано %ld док.)", bEnglish ? gmess_pDocsUpEn : gmess_pDocsUp, g_lDocProcCount );
			g_pScreen->SetMessage( pbuf );
			g_siPrevDocPerc = siNewPerc;
		}
	}
}

//////////////////////////////////////////////////////////////////////////////

void DiffProcCreate ( long lDocInDelta )
{
	g_lAllDoc = lDocInDelta;
	g_lDocProcCount = 0;
	g_siPrevDocPerc = 0;

	g_pScreen->SetMessage( "Delta creation in progress..." );
	g_pScreen->SetProgress( 0 );
}

//////////////////////////////////////////////////////////////////////////////

void AddDiff ( long lDeltaCount )
{
	g_lDocProcCount += lDeltaCount;
	short siNewPerc = (short)((((u_int64_t) g_lDocProcCount * 100 ) / g_lAllDoc) & 0x7FFF);
	if ( siNewPerc >= 0 && siNewPerc <= 100 ) {
		if ( siNewPerc > g_siPrevDocPerc ) {
			char pbuf [256];

			g_pScreen->SetProgress( siNewPerc );
			sprintf ( pbuf, "Delta creation in %d%% (processed %ld docs)", 
				siNewPerc, g_lDocProcCount );
			
			g_pScreen->SetMessage( pbuf );
			g_siPrevDocPerc = siNewPerc;
		}
	}
}


//////////////////////////////////////////////////////////////////////////////

void FlushCreate ( long lFlushingCount, bool bEnglish )
{
	g_lAllCtx = lFlushingCount;
	g_lCtxProcCount = 0;
	g_siPrevCtxPerc = 0;
    
	char pbuf[256];

	sprintf ( pbuf, bEnglish ? "Updating indexes (%ld from %ld)" : "Обновление поисковых индексов (%ld из %ld)", ++g_lFlushCounter, totalFlushs );
			
	g_pScreen->SetMessage( pbuf );
	g_pScreen->SetProgress( 0 );
}

//////////////////////////////////////////////////////////////////////////////

void FlushDestroy (bool bEnglish)
{
	g_lAllCtx = 0;
	g_lCtxProcCount = 0;
	g_siPrevCtxPerc = 0;

	g_pScreen->SetMessage( bEnglish ? gmess_pDocsUpEn : gmess_pDocsUp );
	g_pScreen->SetProgress( g_siPrevDocPerc );
}

//////////////////////////////////////////////////////////////////////////////

void AddFlushing ( long lCount )
{
	g_lCtxProcCount += lCount;

	short	siNewPerc = (short)(( g_lCtxProcCount * 100 ) / g_lAllCtx);

	if ( siNewPerc >= 0 && siNewPerc <= 100 )
	{
		if ( siNewPerc > g_siPrevCtxPerc )
		{
			g_pScreen->SetProgress( siNewPerc );
			g_siPrevCtxPerc = siNewPerc;
		}
	}
}

//////////////////////////////////////////////////////////////////////////////

void SetSegmentName ( char* pName, int iCur, int iAll, bool b_english_face )
{
	char pbuf[1024];

	if ( iAll )
		sprintf ( pbuf, b_english_face ? "Segment \"%s\" (%d from %d)" : "Сегмент \"%s\" (%d из %d)", pName, iCur, iAll );
	else
		sprintf ( pbuf, "%s", pName );

	g_pScreen->SetSubMessage( pbuf );
}			
			
//////////////////////////////////////////////////////////////////////////////

void CleanSegmentName () 
{
	g_pScreen->SetSubMessage( "" );
}

//////////////////////////////////////////////////////////////////////////////

void ParaProcCreate ( long lParaCount )
{
	g_lAllPara = lParaCount;
	g_lParaProcCount = 0;
	g_siPrevParaPerc = 0;
        
	char pBuff [256];

	sprintf ( pBuff, "Processing large document (%ld paras)", g_lAllPara );
	g_pScreen->SetMessage( pBuff );
	g_pScreen->SetProgress( 0 );
}

//////////////////////////////////////////////////////////////////////////////

void ParaProcDestroy ()
{
	g_lAllPara = 0;
	g_lParaProcCount = 0;
	g_siPrevParaPerc = 0;
	g_pScreen->SetMessage( "Docs delting" );
	g_pScreen->SetProgress( g_siPrevDocPerc );
}

//////////////////////////////////////////////////////////////////////////////

void AddPara ( long lCount )
{
	//! TODO - g_lAllPara - глобальный, поэтому из другого потока может стать равным 0
	/*
	g_lParaProcCount += lCount;

	short siNewPerc = (short)(( g_lParaProcCount * 100 ) / g_lAllPara);

	if ( siNewPerc >= 0 && siNewPerc <= 100 )
	{
       		if ( siNewPerc > g_siPrevParaPerc )
		{
			g_pScreen->SetProgress( siNewPerc );
			g_siPrevParaPerc = siNewPerc;
		}
	}
	*/
}

////////////////////////////// check ready ///////////////////////////////////

static char *bad_status_msg    = "Неверная информация о состоянии базы.";
static char *not_ready_msg     = "База не готова к обновлению.";
static char *not_ready_logmsg  = "База %s не готова к обновлению.";
static char *not_ready_loginfo = "Небходимо применить к базе %s следующие программы:\n";

//////////////////////////////////////////////////////////////////////////////

int check_ready_status ( short tid, Base *pBase, LogSession* plog )
{
	int16_t		x, y;
	char		*missing, *s;
	u_int32_t	status;

	if( status = pBase->CheckReady(tid) )
	{
		s = missing = GetProcessDescription(status, x, y);
		if (!missing)
			/*
			tr_show_message(bad_status_msg);
			*/
			g_pScreen->SetMessage( bad_status_msg );
		else {
			/*
			tr_show_message(not_ready_msg);
			*/
			g_pScreen->SetMessage( not_ready_msg );
			plog->printf(lt_error, not_ready_logmsg, pBase->textFile->FileName );
			plog->printf(lt_error, not_ready_loginfo, pBase->textFile->FileName );
			s = missing = GetProcessDescription(status, x, y);
			do
			{
				plog->printf(lt_error, "\t%s\n", s);
				s += strlen(s) + 1;
			} while(*s);
			free(missing);
		}
		return 0;
	}
	return 1;
}

void fprintLog ( LogSession* plog, logtype_t type, log_struct* pStruct, char* pHeader, int iExtendetLog, int delta_version) {
	assert ( plog );
	assert ( pStruct );
	char buf[128];
	
	if ( pHeader ) plog->printf ( type, "%s", pHeader );
	plog->printf ( type, "\n  Дельта %s обновляет :\n", pStruct->pDltName );
	plog->printf ( type, "\tКомплект из %ld сегментов:\n\t  ", pStruct->segs->length() );
	for (Point p = pStruct->segs->first(); p; pStruct->segs->next(p)) 
		plog->printf ( type, " %d", pStruct->segs->contents(p) );
	plog->printf ( type, "\n");					
	plog->printf ( type, "\tОт числа : %s\n", sprintRev ( buf, pStruct->pOldRev ) );
	plog->printf ( type, "\tДо числа : %s\n", sprintRev ( buf, pStruct->pNewRev ) );
	plog->printf ( type, "\n  Версия файла дельты : \"%d\"\n\n", delta_version );

	if ( !iExtendetLog ) return;

	struct tm *newtime;
	time_t aclock;
	::time( &aclock );
   	newtime = localtime( &aclock ); 

	plog->printf ( type, "\n\t Start Time \t\t: %s\n", asctime( newtime ) );	
	plog->printf ( type, "\t Old Base \t: \"%s\"\n", pStruct->pArgv[1] );
	plog->printf ( type, "\t New Base \t: \"%s\"\n", pStruct->pArgv[2] );
	
	plog->printf ( type, "\n\t Run with args (%d) :", pStruct->iArgc );

	for (int ii=0;ii<pStruct->iArgc;ii++) 
		plog->printf ( type, " \"%s\"", pStruct->pArgv [ii] );
	plog->printf ( type, "\n\n");	
}

///////////////////////////////////////////////////////////////////////////////
//			End of file "adds.cpp"				     //
///////////////////////////////////////////////////////////////////////////////
