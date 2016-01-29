/*
 * $Id: hindex.h,v 2.18 2010/09/20 14:13:48 romank Exp $
 *
 *
 * Basic class for handling multi-level indices
 * all keys area given in the normal MSDOS form, e.g.
 * parent1\parent2\....\key
 *
 * data can be associated with every item independently whether it's a leaf node
 * or directory
 *
 * structure of index record
 *
 * (HIndex:HIndexKey; keyValue; IndexRecordData{ns}
 *
 * Author Alex V. Boreskoff
 *
 */

#ifndef	__HIERARCHICAL_INDEX__
#define	__HIERARCHICAL_INDEX__

#include "index.h"

#define	MAX_HINDEX_LEVELS	10

class HIndex : public Index {
public:
	typedef HIndexKeyData HIndexKey;

	char	   DirNameCache [512];		// cache previous multi-level op
	long	   DirIdCache   [MAX_HINDEX_LEVELS];

	HIndex ( PagedFile * f, const char * name, StreamFile * s) 
		: Index ( f, name, s )
	{
		if(!(file->m_mode & (~0x3000)))
			file->m_mode |= GKDB::BT_GO_TO_ROOT;
		DirNameCache [0] = '\0';	// flush cache
	}

	const char* Text ( BTKEY key ) const
	{
		return ((HIndexKey*)key)->text;
	}

	signed char & Level ( BTKEY key ) const 
	{
		return ((HIndexKey*)key)->level;
	}

	u_int32_t & Parent ( BTKEY key ) const
	{
		return ((HIndexKey*)key)->parent;
	}

	u_int32_t & Id ( BTKEY key ) const
	{
		return ((HIndexKey*)key)->id;
	}

	u_int32_t & OwnChildrenCount ( BTKEY key ) const
	{
		return ((HIndexKey*)key)->chCount;
	}

	u_int32_t & AllChildrenCount ( BTKEY key ) const 
	{
		return ((HIndexKey*)key)->achCount;
	}

	u_int32_t OwnDataSize( BTKEY key, int sn=0) const
	{
		return recordData(key,sn)->header.realDataLength;
	}

	u_int16_t CanDelete(BTKEY key) const
	{
		return (OwnChildrenCount(key)||OwnDataSize(key)) ? 0 : 1;
	}

	void          * BuildKey(char * buf, const char *val,int level=0,long parId=0l);
	virtual char  * FullName    ( BTKEY, char * buf );
	virtual BTKEY		FullKey(const char *key);
	virtual	void Create(short keysize,short rndv,short ns=1,short immsize=0);
	virtual	int	 Compare     ( BTKEY, BTKEY ) const;
	virtual	int	 CompareKeys ( const char *, const char *) const;
	virtual	Stream * Open(BTKEY,int autoCreate=0, int*pCreated=0);
	virtual	Stream * OpenN(BTKEY, int sn, int ac=0, int *pCreated=0);
	virtual	int	 Delete      ( BTKEY );
	virtual	int	 DeleteTree  ( BTKEY );

protected:
	int	OpenLevel(char *keyBuf,char *name,int level,long parId,int autoCreate);
	void IncChildren(int level, char* dirName); 
					// increase ChildrenCount thru all levels 
	void DecChildren(int level, char *dirName);
					// decrease ChildrenCount thru all levels
};

#endif
