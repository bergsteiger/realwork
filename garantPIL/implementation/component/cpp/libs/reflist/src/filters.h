#ifndef __GKDBFILTERS_H__
#define __GKDBFILTERS_H__

#include "doccol.h"
#include "refcol.h"
#include "gardefs.h"
#include "base.h"
#include "store.h"

// enum for index's key type.
enum key_type {
	ktDate = sizeof(date),
	ktShort = sizeof (short),
	ktAsciiz = 0		// special key (pointers for real keys).
};

// enum for index's data type.
enum data_type {
	dtDocs,
	dtRefs
};

// filterId enum defines for all known kernel filter.
enum fcond_type {
	INDF_BYSEGMENT,
	INDF_BYSTATUS,
	INDF_BYCATEGORY,
	INDF_BYJUSTICE,
	INDF_BYADOPTED,
	INDF_BYDOCKIND,
};

#define MAX_INDEX_NAME 	64

// index for filtering (kernel filter name associated with indices
// and key and data type.
struct index_type {
	fcond_type filterId;               	// kernel filter id.
	char       indName[MAX_INDEX_NAME];	// associated index name.
	key_type   keyType;                	// associated index key type.
	data_type  dataType;               	// associated index data type.
};

// find known kernel filters by its id in global const static varible.
const index_type* FindIndFilter ( short indfId );

class Filter;
class FiltersColl;

// kernel filter with its selected keys (ind-filter).
class ind_filter : public Storable {
	const index_type* m_pIndFilter;	// kernel filter.
	u_int16_t         m_lKeyCount;	// selected key count.
	void*             voidKeys;	// keys buffer.
	Filter*           m_pOwner;	// owner Filter.

	friend Filter;
public:
	ind_filter ( const ind_filter&, Filter* pOwner = 0 ); // copy constructor.
	ind_filter ( fcond_type indfId, Filter* pOwner = 0 ); // creates ind-filter for selected kernel filter.
	ind_filter ( Store* pStore, Filter* pOwner = 0 ); // creates ind-filter from Store
	~ind_filter ();
	void Reset (); // delete all key

	int16_t AddKey ( const void* keyBuf ); // adds one key from buffer.
	int16_t DelKey ( const void* keyBuf ); // delete key

	int16_t FindKey ( const void* keyBuf ); // rerurn position of key
	inline const void* operator [] ( u_int16_t pos ) const { // returns one key from buffer by pos.
		return GetKey (pos);
	}
	const void* GetKey ( u_int16_t pos ) const;
	inline const void * GetKeys ( u_int16_t& count ) const { // gets pointer to all keys buffer and keys count.
		count = m_lKeyCount;
		return voidKeys;
	}
	char**	GetCharKeys( u_int16_t &count ); // return dynamicly created array of pointers on string keys (caller must free after use)

	inline fcond_type GetFilterId () const { // returns kernel filter id.
		return m_pIndFilter->filterId;
	}
	inline u_int16_t KeySize() const { // returns key size.
		return m_pIndFilter->keyType > 0 ? m_pIndFilter->keyType : sizeof (void*);
	}
	inline u_int16_t Count () const { // return count of keys
		return m_lKeyCount;
	}
protected :
	virtual int Get ( Store * pStore ); // load from Store
	virtual int Put ( Store * pStore ); // save into Store
public :
	inline virtual short Tag() const {
		return 0x2142; // 4A24L;
	};
};

// class for representation user's Filter.
class Filter : public Storable {
	char*         m_pName;         // user's Filter name.
	ind_filter**  m_pIndFilters;   // array of ind-filters.
	u_int16_t     m_lCount;        // count of ind-filters.
	RefCollection * m_pFilterRefs; // RefCollection for this filter.
	Base*         m_pBase;         // Base for this filter.
	short         m_bBuilded;      // indicate then RefCollection is fully builded and actual.
	short         m_bValid;        // indicate then Filter is valid for current base.
	//bool          m_is_validate;   // this filter is validate?

	friend ind_filter;
	friend FiltersColl;
public:
	Filter ( const Filter& ); // copy constructor, don't copy RefCollection, with name and Base.
	Filter ( const char * name, Base* base = 0 );
	~Filter ();
	Filter& operator = ( const Filter& copy ); // makes copy, don't copy RefCollection
	void MoveTo ( Filter& move ); // move all object data (expect Name and Base)
	void Reset (); // cleans up filter.
	int16_t Del ( fcond_type indfId ); // delete ind-filter with id from Filter.
	int16_t Add ( ind_filter& filter ); // add new or overwrite exist ind-filter.
	int16_t Find ( fcond_type indfId ) const; // return position for ind-filter with specified filter id.
	ind_filter * operator [] ( u_int16_t pos ) const; // return exist ind-filter by its position.
	ind_filter * Get ( fcond_type indfId ); // return exist ind-filter by its filter id.
	void SetBase ( Base* base ); // set Base for Filter.
	short Validate (); // check Filter validation, set m_bValid
	inline short IsValid () const { // return valid status
		return m_bValid;
	}
	RefCollection* BuildRefs (); // rebuild RefCollection for Filter.
	const RefCollection* GetRefs (); // return exist RefCollection or calls BuildRefs if needed.
	inline short IsBuilded () const { // return builded status.
		return m_bBuilded;
	}
	inline const char* Name () const { // return user Filter name.
		return m_pName;
	}
	inline void ReName ( const char* name ) { // rename Filter.
		free ( m_pName );
		m_pName = strdup ( name );
	}
	inline u_int16_t GetCount () const { return m_lCount; }
	//inline void SetValidate (bool flag) { m_is_validate = flag; }
protected :
	virtual int Get(Store *); // load from Store
	virtual int Put(Store *); // save into Store
public :
	inline virtual short Tag() const {
		return 0x3263; //5B35L;
	};
};

// user's Filters collection
class FiltersColl {
	Filter **     m_pFilters;    // array of all saved user's filters.
	Filter *      m_pTempFilter; // temporary user Filter.
	u_int16_t     m_lCount;      // count of saved user's filters.
	char*         m_pDefault;    // default saved user Filter (name).
	char*         m_pFileName;   // IniFile for loading and saveing collection.
	//bool          m_is_validate;
public:
	Base*         m_pBase;       // Base for all Filters in collection.
protected :
	int16_t Add ( Filter *filter ); // add internaly created filter into array of saved Filters.
	void Reset (); // cleans collection.
	int16_t MakeRealPos ( u_int16_t& pos );
	int16_t MakeValidPos ( u_int16_t& pos );
public :
	int16_t RealFind ( const char* name ); // returns real position for saved Filter by name
	FiltersColl ( const char* iniName = 0, Base* base = 0/*, bool validate = true*/); // default constructor, try to load collection from IniFile.
	~FiltersColl ();
	int HasBase(void) { return (m_pBase != 0); }
	void SetBase ( Base * base ); // set Base for all Filters.
	u_int16_t Count () { // get count of valid user's Filters
		u_int16_t validCount = 0;
		for ( u_int16_t l=0; l < m_lCount; l++ )
			if ( m_pFilters[l]->IsValid() ) validCount++;

		return validCount; 
	}
	int16_t Add ( Filter &filter ); // add specified user's Filter
	int16_t SaveTemp ( const char * name ); // move exist TempFilter into array of saved user's Filters
	Filter *  operator [] ( u_int16_t pos ); // return saved Filter by its valid position
	Filter * Get ( const char * name ); // return saved Filter by name
	Filter * GetTemp (); // returns exist or create new Temp Filter
	int16_t Find ( const char* name ); // returns valid position for saved Filter by name
	Filter * GetDefault (); // return default Filter
	inline int16_t DefaultPos () { // returns valid position of default Filter
		return Find(m_pDefault);
	}
	int16_t SetDefault ( int16_t pos ); // makes saved Filter default by valid position
	int16_t SetDefault ( const char * name ) { // makes saved Filter default by name
		int16_t validpos = Find(name);
		if ( validpos == -1 ) return -1;
		return SetDefault ( validpos );
	}
	int16_t Delete ( u_int16_t pos ); // delete user's Filter from array by valid pos
	int16_t Delete ( const char * name ) { // delete user's Filter from array by name
		int16_t validpos = Find(name);
		if ( validpos == -1 ) return -1;
		return Delete ( validpos );
	}
	/*inline const char* FilterName ( u_int16_t pos ) { // return saved Filter's name by position
		return pos<m_lCount ? m_pFilters[pos]->Name() : 0;
	}*/
	int16_t Load ( const char *filename = 0 ); // Load filters collection from file
	int16_t Save ( const char *filename = 0 ); // Save filters collection from file
protected :
	virtual int Get(Store *); // load collection from Store
	virtual int Put(Store *); // save collection into Store
public :
	inline virtual short Tag() const {
		return 0x4374;//6C46L;
	};
};

#endif
