#include <stdlib.h>
#include <string.h>
#include "maps.h"

extern "C" {
extern int bfindgex(const void *, const void *, int, int, int (*)(const void *, const void *));


int uint32cmp(const void *p1, const void *p2)
{
	if (*((u_int32_t *)p1) > *((u_int32_t *)p2)) return 1;
	if (*((u_int32_t *)p1) < *((u_int32_t *)p2)) return 1;
	return 0;
}

} // extern "C"

//////////////////////////////////////////////////////////////////////
// UInt32ToUInt32Map implementation

UInt32ToUInt32Map::UInt32ToUInt32Map(unsigned gran)
{
	m_nGran = gran;
	m_nMaxRows = 16;
	m_nRows = 0;
	m_pRows = new UInt32ToUInt32MapRow[64];
	memset(m_pRows, 0, sizeof(UInt32ToUInt32MapRow)<<4);
}

UInt32ToUInt32Map::~UInt32ToUInt32Map()
{
	for(unsigned int i=0; i<m_nRows; i++) // GARANT_SIGNED
		delete[] m_pRows[i].items;
	delete[] m_pRows;
}

void UInt32ToUInt32Map::Set(u_int32_t key, u_int32_t data)
{
	unsigned icount, ic;
	UInt32ToUInt32MapRow *pRow, *pNewRows;
	int rx, ix;
//	UInt32ToUInt32MapItem *pItem;

	if (m_nRows == 0) { // Map empty : init 1st row
		pRow = m_pRows;
		pRow->items = new UInt32ToUInt32MapItem[64];
		pRow->allocated = 64;
		pRow->count = 1;
		pRow->key = pRow->items[0].key = key;
		pRow->items[0].data = data;
		m_nRows++;
		return;
	}
	// Find the target row
	rx = bfindgex(&key, m_pRows, m_nRows, sizeof(UInt32ToUInt32MapRow), uint32cmp);
	if (rx == m_nRows) --rx;
	else if (!rx || (key != m_pRows[rx].key)) rx--;
	pRow = m_pRows + rx;
	// Try to find  in row
	ix = bfindgex(&key, pRow->items, pRow->count, sizeof(UInt32ToUInt32MapItem), uint32cmp);
	if (ix < pRow->count && uint32cmp(&(pRow->items[ix].key), &key)) {
		pRow->items[ix].data = data;
		return;
	}
	// Check for row overflow
	if (pRow->count == pRow->allocated) {
		if(m_nRows == m_nMaxRows) {
			pNewRows = new UInt32ToUInt32MapRow[m_nMaxRows<<1];
			memcpy(pNewRows, m_pRows, m_nRows*sizeof(UInt32ToUInt32MapRow));
			delete [] m_pRows;
			m_pRows = pNewRows; m_nMaxRows <<= 1;
		}
		if (rx < m_nRows-1)
			memmove(m_pRows+rx+2, m_pRows+rx+1, (m_nRows-1-rx)*sizeof(UInt32ToUInt32MapRow));
		pRow[1].items = new UInt32ToUInt32MapItem[m_nGran];
		icount = pRow->count>>1; ic = pRow->count-icount;
		memcpy(pRow[1].items, pRow->items+icount, ic*sizeof(UInt32ToUInt32MapItem));
		pRow[1].key = pRow[1].items[0].key;
		pRow->count = icount;
		pRow[1].count = ic;
		if (ix>=icount) {
			pRow++;
			ix -= icount;
		}
		if (ix < pRow->count)
			memmove(pRow->items+ix+1, pRow->items+ix, (pRow->count-ix)*sizeof(UInt32ToUInt32MapItem));
		pRow->items[ix].key = key;
		pRow->items[ix].data = data;
	}
	else {
		if (ix < pRow->count) // expand in row
			memmove(pRow->items+ix+1, pRow->items+ix, (pRow->count-ix)*sizeof(UInt32ToUInt32MapItem));
		pRow->items[ix].key = key;
		pRow->items[ix].data = data;
	}
}

int UInt32ToUInt32Map::Lookup(u_int32_t key, u_int32_t& rdata)
{
	int rx;
	UInt32ToUInt32MapItem *pItem;
	UInt32ToUInt32MapRow *pRow;

	rx = bfindgex(&key, m_pRows, m_nRows, sizeof(UInt32ToUInt32MapRow), uint32cmp);
	if (rx == m_nRows) return 0;
	if (rx) {
		if (key != m_pRows[rx].key) rx--;
		else {
			rdata = m_pRows[rx].items[0].data;
			return 1;
		}
	}
	else {
		if (key < m_pRows->key) return 0;
		else if (key == m_pRows->key) {
			rdata = m_pRows[rx].items[0].data;
			return 1;
		}
	}
	pRow = m_pRows + rx;
	pItem = (UInt32ToUInt32MapItem *)bsearch(&key, pRow->items, pRow->count, sizeof(UInt32ToUInt32MapItem), uint32cmp);
	if (!pItem) return 0;
	rdata = pItem->data;
	return 1;
}

UInt32ToHNodeMap::UInt32ToHNodeMap(unsigned gran)
{
	m_nGran = gran;
	m_nMaxRows = 16;
	m_nRows = 0;
	m_pRows = new UInt32ToHNodeMapRow[64];
	memset(m_pRows, 0, sizeof(UInt32ToHNodeMapRow)<<4);
}

UInt32ToHNodeMap::~UInt32ToHNodeMap()
{
	for(int i=0; i<m_nRows; i++)
		delete[] m_pRows[i].items;
	delete[] m_pRows;
}

void UInt32ToHNodeMap::Set(u_int32_t key, HNode * data)
{
	UInt32ToHNodeMapRow *pRow, *pNewRows;
	int ix, rx;
	int ic, icount;

	if (m_nRows == 0) { // Map empty : init 1st row
		pRow = m_pRows;
		pRow->items = new UInt32ToHNodeMapItem[64];
		pRow->allocated = 64;
		pRow->count = 1;
		pRow->key = pRow->items[0].key = key;
		pRow->items[0].data = data;
		m_nRows++;
		return;
	}
	// Find the target row
	rx = bfindgex(&key, m_pRows, m_nRows, sizeof(UInt32ToHNodeMapRow), uint32cmp);
	if (rx == m_nRows) --rx;
	else if (!rx || (key != m_pRows[rx].key)) rx--;
	pRow = m_pRows + rx;
	// Try to find  in row
	ix = bfindgex(&key, pRow->items, pRow->count, sizeof(UInt32ToHNodeMapItem), uint32cmp);
	if (ix < pRow->count && uint32cmp(&(pRow->items[ix].key), &key)) {
		pRow->items[ix].data = data;
		return;
	}
	// Check for row overflow
	if (pRow->count == pRow->allocated) {
		if(m_nRows == m_nMaxRows) {
			pNewRows = new UInt32ToHNodeMapRow[m_nMaxRows<<1];
			memcpy(pNewRows, m_pRows, m_nRows*sizeof(UInt32ToHNodeMapRow));
			delete [] m_pRows;
			m_pRows = pNewRows; m_nMaxRows <<= 1;
		}
		if (rx < m_nRows-1)
			memmove(m_pRows+rx+2, m_pRows+rx+1, (m_nRows-1-rx)*sizeof(UInt32ToHNodeMapRow));
		pRow[1].items = new UInt32ToHNodeMapItem[m_nGran];
		icount = pRow->count>>1; ic = pRow->count-icount;
		memcpy(pRow[1].items, pRow->items+icount, ic*sizeof(UInt32ToHNodeMapItem));
		pRow[1].key = pRow[1].items[0].key;
		pRow->count = icount;
		pRow[1].count = ic;
		if (ix>=icount) {
			pRow++;
			ix -= icount;
		}
		if (ix < pRow->count)
			memmove(pRow->items+ix+1, pRow->items+ix, (pRow->count-ix)*sizeof(UInt32ToHNodeMapItem));
		pRow->items[ix].key = key;
		pRow->items[ix].data = data;
	}
	else {
		if (ix < pRow->count) // expand
			memmove(pRow->items+ix+1, pRow->items+ix, (pRow->count-ix)*sizeof(UInt32ToHNodeMapItem));
		pRow->items[ix].key = key;
		pRow->items[ix].data = data;
	}
}

int UInt32ToHNodeMap::Lookup(u_int32_t key, HNode *& rdata)
{
	int rx;
	UInt32ToHNodeMapItem *pItem;
	UInt32ToHNodeMapRow *pRow;

	rx = bfindgex(&key, m_pRows, m_nRows, sizeof(UInt32ToHNodeMapRow), uint32cmp);
	if (rx == m_nRows) return 0;
	if (rx) {
		if (key != m_pRows[rx].key) rx--;
		else {
			rdata = m_pRows[rx].items[0].data;
			return 1;
		}
	}
	else {
		if (key < m_pRows[rx].key) return 0;
		else if (key == m_pRows->key) {
			rdata = m_pRows[rx].items[0].data;
			return 1;
		}
	}
	pRow = m_pRows + rx;
	pItem = (UInt32ToHNodeMapItem *)bsearch(&key, pRow->items, pRow->count, sizeof(UInt32ToHNodeMapItem), uint32cmp);
	if (!pItem) return 0;
	rdata = pItem->data;
	return 1;
}

void UInt32ToHNodeMap::Foreach(UInt32ToHNodeForeachFunc func)
{
	unsigned i, j;

	for(i=0; i<m_nRows; i++) {
		if(m_pRows[i].count == 0) break;
		for(j=0; j<m_pRows[i].count; j++)
			(*func)(m_pRows[i].items[j].key, m_pRows[i].items[j].data);
	}
}

