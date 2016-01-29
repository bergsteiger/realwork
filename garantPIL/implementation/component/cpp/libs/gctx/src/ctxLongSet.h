// ctxLongSet.h

#ifndef _ctxLongSet_h
#define _ctxLongSet_h
#pragma pack(1)
struct CtxLongSet {
	long lastElemV;
	long lastI;
	long capacity;
	long *e;
};
#ifdef MULTI_INDEX_STREAM_FILE
	struct CtxItemSet {
		long Id, Para, Word;
		CtxItemSet *pLast;
	};
#endif
#pragma pack()
#endif
