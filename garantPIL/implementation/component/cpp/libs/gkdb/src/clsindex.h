/*
 * $Id: clsindex.h,v 1.14 2006/08/10 17:22:51 cyberz Exp $
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
 * (HIndex:HIndexKey; keyValue; Size ; ImmData
 *     |       1      4     4        2               1            4  ImmDataSize
 *     |
 *
 * Author Alex V. Boreskoff
 *
 */

#ifndef	__MERGED_HINDEX__
#define	__MERGED_HINDEX__

#include "btiter.h"
#include "hindex.h"
#include "maps.h"

#define	MAX_HINDEX_LEVELS	10

struct HNode {
	u_int32_t nid;
	u_int16_t count;
	u_int16_t level;
	char *name;
	u_int32_t id[1];
};

class ClsIndex : public HIndex 
{
	protected:
		UInt32ToUInt32Map *id2node; // map from hindex key id to merged node;
		UInt32ToHNodeMap *nid2node; // map from node id to merged node
		u_int32_t m_nLastNodeID;

	public:
		ClsIndex(PagedFile *, char *, StreamFile *, int);
		~ClsIndex();
		// ClsIterator support
		u_int32_t CreateNode(short level, int count, u_int32_t *idlist, char *name =0); // used to create new node
		u_int32_t GetMappedID(u_int32_t id); // used to check and get node id containing given key id.
		HNode *GetNode(u_int32_t id); // used to retrieve node from node id

		// Key strings retrieving support
		char *FullName(BTKEY, char *);
};

class ClsIterator : public BTIterator
{
	protected:
		int m_itCount;
		BTIterator **m_pitReal;
		HNode *m_pNode;
		int *m_iActive;
		int m_nActive;
		int m_nMinCount;
		int *m_nMinIndex;
		u_int32_t *m_IDs;
		u_int16_t m_State;
		BTKEY m_pKey;

		void SetAtNode(u_int32_t nid);
		void SmartSet(void);
		void SelectKey(void);
	public:
		ClsIterator(const BTree *, BTKEY = 0);
		~ClsIterator();
		int	Set   ( BTKEY );	// sets to first item (or node) >= key
		BTKEY Key () const;		// returns current item (may be node)
		void next();
		void prev();
		void operator++ (void); // GARANT_MSVC7 needs declaration
};

#endif  // __MERGED_HINDEX__
