#include "shared/Core/fix/mpcxc.h"

/*
 * cvs id was here $
 */

#ifndef __DELTA_MERGER_H__
#define __DELTA_MERGER_H__ 1

#include <unistd.h>

#ifdef _USE_CORBA_CONVERTS
	#include "merger.h"
#endif

#include "garver.h"
#include "osdep.h"
#include "adds.h"
#include "garutils.h"
#include "SplaySet.h"
#include "SplayMap.h"
#include "SharedData.h"
#include "ListSet.h"

// STRUCTURES 

struct Period
{
	revision old_date;
	revision new_date;

	Period () {};
	Period (revision oldrev, revision newrev) : old_date (oldrev), new_date (newrev) {};
	int operator < (const Period& c ) const {
		int res = CompRevs (&old_date, &c.old_date);
		if ( res ) return res < 0;
		else return CompRevs (&new_date, &c.new_date) < 0;
	}
	int operator > (const Period& c ) const {
		int res = CompRevs (&old_date, &c.old_date);
		if ( res ) return res > 0;
		else return CompRevs (&new_date, &c.new_date) > 0;
	}
#ifdef _USE_CORBA_CONVERTS
	operator StrPeriod() const;
	Period& operator = ( const StrPeriod& );
#endif
};

class DeltaMerger
{
public:
	class LoadingExcept
	{
	protected :
		const char* m_filename;
	public:	
		LoadingExcept () : m_filename (0) {};
		LoadingExcept ( const LoadingExcept& copy ) 
			: m_filename ( strdup (copy.m_filename) ) {
		};
		LoadingExcept ( const char* filename ) 
			: m_filename ( strdup ( filename ) ) {
		};
		virtual ~LoadingExcept () {
			if ( m_filename ) free ( (char*)m_filename );
		};
		const char* filename() {
			return m_filename;
		};
#ifdef _USE_CORBA_CONVERTS
		virtual operator Merger::LoadingExcept () const = 0;
#endif
	};
	class InvalidVersion : public LoadingExcept
	{
		long m_rightver;
	public:
		InvalidVersion ( const InvalidVersion& copy ) 
			: LoadingExcept(copy), m_rightver(copy.m_rightver) {};
		InvalidVersion ( const char* filename, long ver ) 
			: LoadingExcept(filename), m_rightver(ver) {};
		long rightver () {
			return m_rightver;
		};
#ifdef _USE_CORBA_CONVERTS
		operator Merger::LoadingExcept () const;
#endif
	};
	class InvalidSize : public LoadingExcept
	{
	public:
		InvalidSize ( const InvalidSize& copy ) 
			: LoadingExcept(copy) {};
		InvalidSize ( const char* filename ) 
			: LoadingExcept(filename) {};
#ifdef _USE_CORBA_CONVERTS
		operator Merger::LoadingExcept () const;
#endif
	};	
	class DifferentRev : public LoadingExcept
	{
		Period m_diffrev;
		short m_isOld;
	public:
		DifferentRev ( const DifferentRev& copy ) 
			: LoadingExcept(copy), m_diffrev(copy.m_diffrev), m_isOld(copy.m_isOld) {};
		DifferentRev ( const char* filename, const Period& p, short isOld ) 
			: LoadingExcept(filename), m_diffrev(p), m_isOld(isOld) {};
		Period diffrev() {
			return m_diffrev;
		}
		short isOld () {
			return m_isOld;
		}
#ifdef _USE_CORBA_CONVERTS
		operator Merger::LoadingExcept () const;
#endif
	};
	class DifferentClass : public LoadingExcept
	{
		long m_classId;
	public:
		DifferentClass ( const DifferentClass& copy ) 
			: LoadingExcept(copy), m_classId(copy.m_classId) {};
		DifferentClass ( const char* filename, long classId ) 
			: LoadingExcept(filename), m_classId(classId) {};
		long classId() {
			return m_classId;
		}
#ifdef _USE_CORBA_CONVERTS
		operator Merger::LoadingExcept () const;
#endif
	};
	class MultySegs : public LoadingExcept
	{
	public:
		MultySegs ( const MultySegs& copy ) 
			: LoadingExcept(copy) {};
		MultySegs ( const char* filename ) 
			: LoadingExcept(filename) {};
#ifdef _USE_CORBA_CONVERTS
		operator Merger::LoadingExcept () const;
#endif
	};
	class Overlapping : public LoadingExcept
	{
		SplaySet<unsigned short> m_segs;
	public:
		Overlapping ( const Overlapping& copy ) 
			: LoadingExcept(copy), m_segs (copy.m_segs) {};
		Overlapping ( const SplaySet<unsigned short>& segs ) 
			: LoadingExcept("unknown"), m_segs(segs) {};
#ifdef _USE_CORBA_CONVERTS
		operator Merger::LoadingExcept () const;
#endif
	};
	class DifferentBody : public LoadingExcept
	{
		long m_id;
	public:
		DifferentBody ( const DifferentBody& copy ) 
			: LoadingExcept(copy), m_id(copy.m_id) {};
		DifferentBody ( const char* filename, long id ) 
			: LoadingExcept(filename), m_id(id) {};
		long id() {
			return m_id;
		}
#ifdef _USE_CORBA_CONVERTS
		operator Merger::LoadingExcept () const;
#endif
	};
	class OpenError : public LoadingExcept
	{
	public:
		OpenError ( const OpenError& copy ) 
			: LoadingExcept(copy) {};
		OpenError ( const char* filename ) 
			: LoadingExcept(filename) {};
#ifdef _USE_CORBA_CONVERTS
		operator Merger::LoadingExcept () const;
#endif
	};	
	
	class AssemblingExcept
	{
	public:
		virtual ~AssemblingExcept () {};
#ifdef _USE_CORBA_CONVERTS
		virtual operator Merger::AssemblingExcept () const = 0;
#endif
	};
	class UnexistSegs : public AssemblingExcept
	{
		SplaySet<unsigned short> m_segs;
	public:
		UnexistSegs ( const UnexistSegs& copy ) 
			: AssemblingExcept(copy), m_segs(copy.m_segs) {};
		UnexistSegs ( SplaySet<unsigned short>& segs ) 
			: m_segs(segs) {};
		SplaySet<unsigned short> segs () {
			return m_segs;
		}
#ifdef _USE_CORBA_CONVERTS
		operator Merger::AssemblingExcept () const;
#endif
	};
	class UnexistPeriod : public AssemblingExcept
	{		
	public:
		UnexistPeriod ( const UnexistPeriod& copy ) 
			: AssemblingExcept(copy) {};
		UnexistPeriod () {};
#ifdef _USE_CORBA_CONVERTS
		operator Merger::AssemblingExcept () const;
#endif
	};
	class CreateError : public AssemblingExcept
	{
		char* m_filename;
	public:	
		CreateError ( const CreateError& copy ) 
			: m_filename ( strdup (copy.m_filename) ) {};
		CreateError ( const char* filename ) 
			: m_filename ( strdup ( filename ) ) {};
		~CreateError () {
			if ( m_filename ) free ( m_filename );
		};
		const char* filename() {
			return m_filename;
		};
#ifdef _USE_CORBA_CONVERTS
		operator Merger::AssemblingExcept () const;
#endif
	};
	class UnknownError : virtual public AssemblingExcept, virtual public LoadingExcept
	{
	public:
		UnknownError ( const UnknownError& copy ) 
			: LoadingExcept(copy) {};
		UnknownError () 
			: LoadingExcept("unknown") {};
		UnknownError ( const char* filename ) 
			: LoadingExcept(filename) {};
#ifdef _USE_CORBA_CONVERTS
		operator Merger::AssemblingExcept () const;
		operator Merger::LoadingExcept () const;
		operator Merger::UnknownExcept () const;
#endif
	};	

	struct Settings 
	{		
		SString out_name;
		SplaySet <unsigned short> mrg_segs;
		Period period;

		Settings () : out_name() {};
#ifdef _USE_CORBA_CONVERTS
		operator StrSettings() const;
		Settings& operator = ( const StrSettings& );
#endif
	};

protected:
	struct SegDelta
	{
		Period period;
		unsigned short seg;
		
		SegDelta ( const Period& p, unsigned short s ) : period(p), seg(s) {}; 
		int operator < (const SegDelta& c ) const {
			if ( seg != c.seg ) return seg < c.seg;
			else return period < c.period;
		}
		int operator > (const SegDelta& c ) const {
			if ( seg != c.seg ) return seg > c.seg;
			else return period > c.period;
		}
	};

	class LastUsedDelta : public ListSet<SegDelta>
	{
	public:
		LastUsedDelta () {};
		
		int getLastUsed ( Period& p, unsigned short& s ) const {
			if ( !lfirst ) return 0;
			p = lfirst->item.period;
			s = lfirst->item.seg;
			return 1;
		}
		int activate ( const Period& per, unsigned short s ) {
			SegDelta item ( per, s );
			Point p = seek ( item );
			if ( !p ) return 0;
			makeLast (p);
			return 1;
		}
	};
	
	struct InFile {
		SString name;
		FILE* file;
		unsigned short seg;
		long docCount;

		int operator < (InFile& c ) {
			return name < c.name;
		}
		int operator > (InFile& c ) {
			return name > c.name;
		}
	};

	class InDeltas : public LinkedObj, public SplaySet<InFile>
	{
	public:
		~InDeltas () {
			release ();
		}

		SplaySet<unsigned short> segs;
		Period period;
		long classId;
		long version;

		Point addInFile (SString name) {
			InFile infile;
			infile.name = name;
			infile.file = mpcxc_fopen ( infile.name, "rb" );
			if ( !infile.file ) {
				printf ( "Can't open file (%s)\n", (char*)infile.name );
				perror ("error is");
				DeltaMerger::OpenError ex (infile.name);
				throw ex;
			}
			return add (infile);
		};

		virtual void last_destroy() {
			for ( Point p = first(); p; next(p) )				
				if ( ((SplayNode*)p)->item.file ) fclose ( ((SplayNode*)p)->item.file );
		}
	};

	#pragma pack(1)
	struct BaseInfoDiff
	{
		char Name [BASE_NAME_SIZE];
		char NameEng [BASE_NAME_SIZE];
		char AuthorName [NAME_SIZE];
		unsigned short Weight;
		long SplashTopic;
		long BannerTopic;
	};
	#pragma pack()

	typedef std::vector<long> CorrsContainer;
	typedef std::vector<Ref> CorrsRefContainer;
	struct CorrDocData {
		CorrDocData () {}
		CorrDocData (unsigned short segment) : segment (segment) {}
		bool operator== (const CorrDocData& other) const {
			return this->segment == other.segment;
		}

		unsigned short segment;
		u_int32_t delCorrIndex;
		u_int32_t addCorrIndex;
	};
	typedef std::vector<CorrDocData> CorrDocDataContainer;
	typedef std::map<long, CorrDocDataContainer> CorrsByIdContainer;

	typedef std::vector<long> NewCorrsContainer;
	typedef std::vector<CorrRef> NewCorrsRefContainer;
	struct NewCorrDocData {
		NewCorrDocData () {}
		NewCorrDocData (unsigned short segment) : segment (segment) {}
		bool operator== (const NewCorrDocData& other) const {
			return this->segment == other.segment;
		}

		unsigned short segment;
		u_int32_t delCorrIndex;
		u_int32_t addCorrIndex;
		u_int32_t andCorrIndex;
	};
	typedef std::vector<NewCorrDocData> NewCorrDocDataContainer;
	typedef std::map<long, NewCorrDocDataContainer> NewCorrsByIdContainer;

	struct DocDelta
	{
		char type;
		char mask;
		long unpacked_size;
		std::vector<char> data;
	};

	struct BlobDelta
	{
		short type;
		std::vector<char> data;
	};

	struct DeltaCache {
		long version;
		std::set<unsigned short> segs;

		std::map <unsigned short, BaseInfoDiff> mapBInfos;
		typedef std::map <unsigned short, std::vector<char> > VarsContainer;
		VarsContainer mapVars;
		typedef std::map <std::vector<char>, std::vector<char> > GLMapContainer;
		GLMapContainer mapGLMap;
		typedef std::map <std::vector<char>, std::vector<char> > DKCache;
		typedef std::map <unsigned short, DKCache> DKindsContainer;
		DKindsContainer mapDKinds;

		std::map <unsigned short, std::vector<long> > docs, del_docs;
		std::map <unsigned short, std::vector<ObjKey> > blobs, del_blobs;

		std::vector<date> control_dates;
		std::vector<std::vector<Ref> > control_refs;

		typedef std::map<long, DocDelta> DocDeltaContainer;
		DocDeltaContainer map_chg_docs, map_new_docs;
		SplayMap <unsigned short, SplayMap <long, char> > mapDocs;
		SplayMap <unsigned short, SplayMap <long, short> > mapBlobs;

		typedef std::map<long, BlobDelta> BlobDeltaContainer;
		BlobDeltaContainer map_chg_blobs, map_new_blobs;

		std::map <unsigned short, CorrsContainer> corrs_by_segment_container;
		std::vector <CorrsRefContainer> corr_containers;
		CorrsByIdContainer corrs_for_doc;

		std::map <unsigned short, NewCorrsContainer> new_corrs_by_segment_container;
		std::vector <NewCorrsRefContainer> new_corr_containers;
		NewCorrsByIdContainer new_corrs_for_doc;

		std::map<unsigned short, long> map_seg_searchcachesize;
		std::map<unsigned short, void*> map_seg_searchcachedata;

		long	synMdelcount, synMaddcount;
		char	*synMdel, *synMadd;

		long	CVardelcount, CVaraddcount;
		char	*CVardel, *CVaradd;
		long	CVardelsize, CVaraddsize;

		long	hashaddcount;
		long	hashaddsize;
		char	*hashadd;

		long	relef_addcount, relef_delcount;
		long	relef_addsize, relef_delsize;
		long	*relef_add, *relef_del;

		long	typingerrors_addcount, typingerrors_delcount;
		long	typingerrors_addsize, typingerrors_delsize;
		char	*typingerrors_add, *typingerrors_del;

		long	goodwords_addcount, goodwords_delcount;
		long	goodwords_addsize, goodwords_delsize;
		char	*goodwords_add, *goodwords_del;

		long	kindCorrsize;
		char*	kindCorrdiff;

		long	key6_delcount, key6_addcount;
		std::vector<long> key6_keys_to_delete;
		std::vector<long> key6_to_add_id;
		std::vector<std::string> key6_to_add_key;

		long	Ssyndelcount, Ssynaddcount;
		char	*Ssyndel, *Ssynadd;

		long classId;
		int	m_used;
		DeltaCache () : m_used (0), typingerrors_delcount(-1), typingerrors_addcount(-1), relef_addcount(-1), relef_delcount (-1), synMdelcount (-1), synMaddcount (-1), Ssyndelcount (-1), Ssynaddcount (-1), CVardelcount(-1), CVaraddcount(-1), hashaddcount(-1), kindCorrsize(-1), kindCorrdiff(0), key6_delcount(-1), key6_addcount(-1), goodwords_addcount(-1), goodwords_delcount(-1), typingerrors_addsize(0), typingerrors_delsize(0) {
			corr_containers.push_back (CorrsRefContainer ());
			new_corr_containers.push_back (NewCorrsRefContainer ());
		};
	};

public:
	DeltaMerger ( unsigned long mlim = 0, unsigned long dlim = 0 );
	~DeltaMerger () {};

	int loadDeltas (const SplaySet <SString> & mrgFiles);
	int assemblingDelta (Settings& settings);
	SplaySet<unsigned short> whatForPeriod (Period& p);
	SplaySet<Period> getAllPeriods ();

	SplaySet <unsigned short> setSegs (Period& p) {
		SplaySet<unsigned short> result;
		for (std::set<unsigned short>::const_iterator seg_it = m_mapDelta[p].segs.begin (); seg_it != m_mapDelta[p].segs.end (); seg_it++) {
			unsigned short seg = *seg_it;
			result.add (seg);
		}
		return result;
	};

protected:
#ifdef _WIN32
	friend void _checkForUnloading (void*);
#elif defined (unix)
	friend void* _checkForUnloading (void*);
#endif

	//
	// Здесь хранятся все дельты по периодам
	//
	std::map <Period, DeltaCache>	m_mapDelta;

	LastUsedDelta	m_lastUsed;
	unsigned long	m_phsMemLimit;
	unsigned long	m_dayLimit;
	//
	// Сейчас польземся глобальным мутексом
	//

	InDeltas	openDeltas( const SplaySet<SString> &inFiles );
	void		checkForUnloading( int inThread );
	int		unloadSegDelta( Period& p, unsigned short seg );
	int		unloadPeriodDelta ( Period& per );
	
	void		unloadingByPeriod ();
	void		unloadingByUsedMem ();
	
	void		checkCache ( const char* mess );
	void		printCacheInfo ( logtype_t );

protected:
	long	delta_version;
};

#endif

