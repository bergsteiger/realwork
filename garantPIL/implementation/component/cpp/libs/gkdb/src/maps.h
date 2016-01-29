#ifndef __GKDB_CONTAINERS_MAPS__
#define __GKDB_CONTAINERS_MAPS__

#include "osdep.h"

struct HNode;

struct UInt32ToUInt32MapItem {
	u_int32_t key;
	u_int32_t data;
};

struct UInt32ToUInt32MapRow {
	u_int32_t key;
	unsigned allocated;
	unsigned count;
	UInt32ToUInt32MapItem *items;
};

typedef void (*UInt32ToUInt32ForeachFunc)(u_int32_t, u_int32_t);

class UInt32ToUInt32Map {
	protected:
		unsigned m_nGran;
		unsigned m_nRows;
		unsigned m_nMaxRows;
		UInt32ToUInt32MapRow *m_pRows;
	public:
		// Construction
		UInt32ToUInt32Map(unsigned);
		~UInt32ToUInt32Map();
		// Operations
		int Lookup(u_int32_t key, u_int32_t& rdata);
		void Set(u_int32_t key, u_int32_t data);
		void Delete(u_int32_t key);
		void Foreach(UInt32ToUInt32ForeachFunc);
};

struct UInt32ToHNodeMapItem {
	u_int32_t key;
	HNode *data;
};

struct UInt32ToHNodeMapRow {
	u_int32_t key;
	unsigned allocated;
	unsigned count;
	UInt32ToHNodeMapItem *items;
};

typedef void (*UInt32ToHNodeForeachFunc)(u_int32_t, HNode *);

class UInt32ToHNodeMap {
	protected:
		unsigned m_nGran;
		unsigned m_nRows;
		unsigned m_nMaxRows;
		UInt32ToHNodeMapRow *m_pRows;
	public:
		// Construction
		UInt32ToHNodeMap(unsigned);
		~UInt32ToHNodeMap();
		// Operations
		int Lookup(u_int32_t key, HNode *& rdata);
		void Set(u_int32_t key, HNode *data);
		void Delete(u_int32_t key);
		void Foreach(UInt32ToHNodeForeachFunc);
};

extern "C" {
int uint32cmp(const void * p1, const void * p2);
}

#endif  // __GKDB_CONTAINERS_MAPS__
