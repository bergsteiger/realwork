#ifndef	__PILOT_GARANT_INDICES__
#define __PILOT_GARANT_INDICES__

#include "garantPIL/implementation/component/cpp/Garant/Datastore/NdtClone/Common/gardefs.h"
#include "garantPIL/implementation/component/cpp/Garant/Datastore/NdtClone/Common/RecoverableIndex.h"

namespace NdtClone {

const unsigned short MaxWordSize_c = 128;

template <typename RecoveryPolicy>
class	LongIndex : public RecoverableIndex <RecoveryPolicy> {
public:
	LongIndex (PagedFile* f, const char *n, StreamFile* s, short rndv, int stream_count) 
		: RecoverableIndex <RecoveryPolicy> (f, n, s, sizeof (long) , rndv, stream_count) {
	}
	
	virtual	int	Compare (BTKEY key1, BTKEY key2) const {
		return (*(long*) key1 > *(long*) key2) ? 1 : (*(long*) key1 < *(long*) key2) ? -1 : 0;
	}
};

template <typename RecoveryPolicy>
class	ContextIndex : public RecoverableIndex <RecoveryPolicy> {
public:
	ContextIndex (PagedFile* f, const char* n, StreamFile* s, short rndv, int stream_count) 
		: RecoverableIndex <RecoveryPolicy> (f, n, s, MaxWordSize_c, rndv, stream_count) {
	}

	virtual	int	Compare (BTKEY key1, BTKEY key2) const {
		return strncmp ((char*) key1, (char*) key2, MaxWordSize_c);
	}
	
	virtual	Stream* OpenN(BTKEY key, int sn, int AutoCreate = 0, int* pCreated = 0) {
		if (!key) {
			return Index::OpenN (0, 0);
		}

		int memSz = this->KeyLength - this->nstreams * (STRSZSZ + this->ImmDataSize);
		int len;
		void *keyBuff = alloca (memSz);
		if (memSz > (len = strlen ((const char*)key))) {
			memcpy (keyBuff, key, len + 1);
		} else {
			memcpy (keyBuff, key, memSz);
			((char*)keyBuff)[memSz] = 0;
		}

		return Index::OpenN (keyBuff, sn, AutoCreate, pCreated);
	}

};

struct ids_t {
	long uid; // profile id
	long cid; // class id
	long oid; // object id

	ids_t	() : uid (0), cid (0), oid (0) {}
	ids_t	(long u, long c, long o) : uid (u), cid (c), oid (o) {}
};

template <typename RecoveryPolicy>
class IdsIndex : public RecoverableIndex <RecoveryPolicy> {
public:
	IdsIndex (PagedFile* f, const char* n, StreamFile* s, short rndv, int stream_count) 
		: RecoverableIndex <RecoveryPolicy> (f, n, s, sizeof (NdtClone::ids_t), rndv, stream_count) {
	}

	virtual	int	Compare (BTKEY key1, BTKEY key2) const {
		ids_t *pid1 = (ids_t*)key1, *pid2 = (ids_t*)key2;

		return (pid1->uid > pid2->uid) ? 1 : (pid1->uid < pid2->uid) ? -1 :
			(pid1->cid > pid2->cid) ? 1 : (pid1->cid < pid2->cid) ? -1 :
			(pid1->oid > pid2->oid) ? 1 : (pid1->oid < pid2->oid) ? -1 : 0;
	}
};

} // namespace NdtClone


#endif
