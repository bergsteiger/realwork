#include "shared/Core/fix/mpcxc.h"

#include "clsindex.h"

#include "shared/Core/fix/mpcxc.h" // GARANT_GCC

#include <cstdlib>

#define CIS_SELECTED   0x8000
#define CIS_KCHECKDONE 0x4000

ClsIndex::ClsIndex(PagedFile * f, char * name, StreamFile * s, int imm_size) :
	HIndex(f, name, s) // GARANT_MSVC7 , imm_size
{
	u_int32_t idlist[32];
	int count;

	m_nLastNodeID = 1;
	id2node = new UInt32ToUInt32Map(64);
	nid2node = new UInt32ToHNodeMap(32);
	BTIterator it(this);

	for(count=0; Level(it.Key()) == 0; ++it)
		idlist[count++] = Id(it.Key());
	CreateNode(0, count, idlist);
}

u_int32_t ClsIndex::CreateNode(short level, int count, u_int32_t *idlist, char *name)
{
	HNode *pNode;

	pNode = (HNode *)malloc(sizeof(HNode)+(count-1)<<2);
	pNode->level = level;
	pNode ->name = (name) ? strdup(name) : 0;
	pNode->nid = m_nLastNodeID++;
	pNode->count = count;
	memcpy(pNode->id, idlist, count<<2);
	nid2node->Set(pNode->nid, pNode);
	for(int i=0; i<count; i++)
		id2node->Set(idlist[i], pNode->nid);
	return pNode->nid;
}

u_int32_t ClsIndex::GetMappedID(u_int32_t id)
{
	u_int32_t tmpid;
	u_int32_t i;

	if(id2node->Lookup(id, tmpid))
		return tmpid | 0x80000000;
	else return id;
}

HNode *ClsIndex::GetNode(u_int32_t id)
{
	HNode *pNode;

	id &= 0x7FFFFFFF;
	if(!nid2node->Lookup(id, pNode)) return 0;
	return pNode;
}

ClsIterator::ClsIterator(const BTree *btree, BTKEY start) : BTIterator(btree, 0)
{
	m_nMinIndex = (int *)malloc(32*sizeof(int));
	m_pitReal = (BTIterator **)malloc(32*sizeof(BTIterator *));
	m_iActive = (int *)malloc(32*sizeof(int));
	m_IDs = (u_int32_t *)malloc(128);
	m_nActive = 0;
	m_nMinCount = 0;
	m_itCount = 0;
	m_pNode = 0;
	m_pKey = malloc(256);
	m_State = 0;
	if(start) Set(start);
}

int ClsIterator::Set(BTKEY key)
{
	long pid;
	ClsIndex *ix = (ClsIndex *)tree;
	BTKEY tmpkey;

	pid = ix->Parent(key);
	if (!pid & 0x80000000) // received parent isn't node
		pid = ix->GetMappedID(pid); // check for merged real parent
	if (pid & 0x80000000) // real parent is node
		SetAtNode(pid);
	else {
		m_pNode = 0;
		return BTIterator::Set(key);
	}
	return 1;
}

void ClsIterator::operator++ (void)
{
	BTKEY tmpkey;
	long id, pid;
	HNode *pNode;
	int i, j;
	ClsIndex *ix;

	ix = (ClsIndex *)tree;
	if (m_pNode) {
		if (!(m_State & CIS_SELECTED)) SelectKey();
		m_State &= ~CIS_SELECTED;
		for (i=0; i<m_nMinCount; i++) {
			*((m_pitReal[m_nMinIndex[i]]))++;
			tmpkey = m_pitReal[m_nMinIndex[i]]->Key();
			pid = ix->Parent(tmpkey);
			if (!bsearch(&pid, m_pNode->id, m_pNode->count, 4, uint32cmp)) { // Remove from Active!
				for(j=0; j<m_nActive-1 && m_iActive[j] != m_nMinIndex[i]; j++);
				if (j < m_nActive-1)
					memmove(m_iActive+j, m_iActive+j+1, (m_nActive-j-1)<<2);
				m_nActive--;
			}
		}
		if (!m_nActive) { // Current node children finished.
			BTIterator::Set(m_pitReal[0]->Key());
			SmartSet();
		}
		else SelectKey();
	}
	else {
		++(*((BTIterator *)this));
	}
}

void ClsIterator::SetAtNode(u_int32_t nid)
{
	int i, count;
	ClsIndex *ix;
	BTKEY tmpkey;

	m_pNode = ix->GetNode(nid);
	count = (m_itCount<m_pNode->count) ? m_itCount : m_pNode->count;
	tmpkey = (BTKEY)alloca(160);
	for(i=0; i<count; i++) {
		ix->BuildKey((char *)tmpkey, "", m_pNode->level, m_pNode->id[i]);
		m_pitReal[i]->Set(tmpkey);
	}
	for(i=m_itCount; i<m_pNode->count; i++) {
		ix->BuildKey((char *)tmpkey, "", m_pNode->level, m_pNode->id[i]);
		m_pitReal[i] = new BTIterator(tree, tmpkey);
		m_itCount++;
	}
	for(m_nActive=0, i=0; i<m_pNode->count; i++) {
		if(ix->Parent(m_pitReal[i]->Key()) == m_pNode->id[i]) {
			m_iActive[m_nActive] = i;
			m_nActive++;
		}
	}
	SelectKey();
}

void ClsIterator::SmartSet(void)
{
	BTKEY tmpkey;
	u_int32_t pid, nid;
	ClsIndex *ix;
	HNode *pNode;

	ix = (ClsIndex *)tree;
	tmpkey = BTIterator::Key();
	m_State &= ~CIS_KCHECKDONE;
	do {
		pid = ix->Parent(tmpkey);
		nid = ix->GetMappedID(pid);
		if (nid & 0x80000000) { // Parent is node member
			pNode = ix->GetNode(nid);
			if (pNode->id[0] == pid) // Accept node as parent
				SetAtNode(nid);
			else { // Skip all keys with such parent
				do {
					++(*((BTIterator *)this));
					tmpkey = BTIterator::Key();
				} while (ix->Parent(tmpkey) == pid);
			}
		}
		else {
			m_State |= CIS_KCHECKDONE;
			m_pNode = 0;
		}
	} while(m_State & CIS_KCHECKDONE);
	m_State &= ~CIS_KCHECKDONE;
	if (m_pNode) SelectKey();
}

BTKEY ClsIterator::Key() const
{
	if (m_pNode) return m_pKey;
	else return BTIterator::Key();
}

void ClsIterator::SelectKey(void)
{
	ClsIndex *ix;
	BTKEY minkey, tmpkey;
	int i, cmp;
	u_int32_t nid;

	if (!m_pNode) return;
	ix = (ClsIndex *)tree;
	minkey = m_pitReal[m_iActive[0]]->Key();
	m_nMinCount = 1; m_nMinIndex[0] = 0;
	m_IDs[0] = ix->Id(minkey);
	for (i=1; i<m_nActive; i++) {
		tmpkey = m_pitReal[m_iActive[i]]->Key();
		cmp = strcmp(ix->Text(tmpkey), ix->Text(minkey));
		if(cmp < 0) {
			m_nMinCount = 1;
			m_nMinIndex[0] = m_iActive[i]; m_IDs[0] = ix->Id(tmpkey);
			minkey = tmpkey;
		}
		else if (!cmp) {
			m_nMinIndex[m_nMinCount] = m_iActive[i];
			m_IDs[m_nMinCount] = ix->Id(tmpkey);
			m_nMinCount++;
		}
	}
	ix->BuildKey((char *)m_pKey,(char *)(ix->Text(minkey)), ix->Level(minkey),(long)(m_pNode->id));
	if (m_nMinCount > 1) {
		nid = ix->CreateNode(ix->Level(minkey), m_nMinCount, m_IDs, (char *)ix->Text(minkey));
		((HIndex::HIndexKey *)m_pKey)->id = nid;
	}
	else ((HIndex::HIndexKey *)m_pKey)->id = ix->Id(minkey);
	m_State |= CIS_SELECTED;
}

