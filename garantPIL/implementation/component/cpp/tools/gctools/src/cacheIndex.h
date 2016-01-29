// cacheIndex.h
#ifndef _cacheIndex_h
#define _cacheIndex_h

#include "u_int32_t.SplaySet.h"
#include "u_int32_t.caddr_t.SplayMap.h"
#include "FString.caddr_t.SplayMap.h"

#include "index.h"
struct date;

class CIdxShortInt {
  public:
    void add(const u_int32_t t, int status);
  	CIdxShortInt(Index *);
	~CIdxShortInt();
  protected:
  	u_int32_tcaddr_tSplayMap mp;
	Index *idx;
};

class CIdxDate {
  public:
    void add(const date *d, u_int32_t id);
  	CIdxDate(Index *);
	~CIdxDate();
  protected:
  	u_int32_tcaddr_tSplayMap mp;
	Index *idx;
};

class CIdxRefDate {
public:
    void add(const date *d, u_int32_t id, u_int32_t sub);
    void add(const date d, u_int32_t id, u_int32_t sub);
  	CIdxRefDate(Index *);
	~CIdxRefDate();
protected:
  	u_int32_tcaddr_tSplayMap mp;
	Index *idx;
};

class CIdxShortRef {
public:
    void add(const short d, u_int32_t id, u_int32_t sub);
  	CIdxShortRef (Index *);
	~CIdxShortRef ();
protected:
  	u_int32_tcaddr_tSplayMap mp;
	Index *idx;
};

class CIdxString {
  public:
    void add(FString &s, u_int32_t id);
    void add(const char *, size_t l, u_int32_t id);
  	CIdxString(Index *);
	~CIdxString();
  protected:
  	FStringcaddr_tSplayMap mp;
	Index *idx;
};

class HIndex;
class RefCollection;
class DocCollection;
class FStringSplaySet;

class CIdxHStringIndex {
  public:
	class DataProcessor {
	public:
		virtual void publishData(void *key, void *d) =0;
		virtual int prepublishData(void *key, void *d) =0;
		virtual void mergeData(void **target, void *source) =0;
		virtual void clearData(void *d) =0;
	};
	class TreeNode {
	public:
		TreeNode(HIndex *i) :
			node(0), nnodes(0), a_nnodes(0), 
			key(0), data(0), idx(i) {}
		
		~TreeNode();
		void takeTextKey(int &id,char *k,void *d);
		void collectData(DataProcessor *dp);
		int prepublish(DataProcessor *dp);
		void publish(DataProcessor *dp);
		void clearData(DataProcessor *dp);
		u_int32_t countChildren();
		TreeNode **node;
		int nnodes;
		int a_nnodes;
		void *key;
		void *data;
		HIndex *idx;
	};

	CIdxHStringIndex(HIndex *idx);
//	virtual ~CIdxHStringIndex();
	void buildHindexTree(DataProcessor *dp);
  protected:
  	FStringcaddr_tSplayMap mp;
	HIndex *idx;
};

class CIdxClass : public CIdxHStringIndex {
  public:
	struct ClassData {
		//RefCollection *rc;
		std::deque<u_int64_t> *rc;
		FStringSplaySet *ss;
	};
	class ClassDP : public CIdxHStringIndex::DataProcessor {
	public:
		ClassDP (HIndex *i) : idx(i) {} 
		virtual void publishData(void *key, void *d);
		virtual int prepublishData(void *key, void *d) { return 1; };
		virtual void mergeData(void **target, void *source);
		virtual void clearData(void *d);
		void printData(void *key, void *d);
	protected:
		HIndex *idx;
	};
    void add(const char *, size_t l, u_int32_t t, u_int32_t sub);
    void add(const char *, size_t l, const char *, size_t);
  	CIdxClass(HIndex *);
	~CIdxClass();
};

class CIdxPrefix : public CIdxHStringIndex {
  public:
	struct PrefixData {
		//RefCollection *rc;
		std::deque<u_int64_t> *rc;
		int maxdata, indata;
		char *data;
	};
	class PrefixDP : public CIdxHStringIndex::DataProcessor {
	public:
		PrefixDP (HIndex *i) : idx(i) {} 
		virtual void publishData(void *key, void *d);
		virtual int prepublishData(void *key, void *d);
		virtual void mergeData(void **target, void *source);
		virtual void clearData(void *d);
		void printData(void *key, void *d);
	protected:
		HIndex *idx;
	};
	void add(const char *, size_t l, u_int32_t t, u_int32_t sub);
	void add(const char *, size_t l, const char *, size_t);
  	CIdxPrefix(HIndex *);
	~CIdxPrefix();
};

class CIdxAdopted : public CIdxHStringIndex {
  public:
	struct AdoptedData {
		//DocCollection *dc;
		std::deque<long> *dc;
		FStringSplaySet    *ss;
	};
	class AdoptedDP : public CIdxHStringIndex::DataProcessor {
	public:
		AdoptedDP (HIndex *i) : idx(i) {}
		virtual void publishData(void *key, void *d);
		virtual int prepublishData(void *key, void *d) { return 1; };
		virtual void mergeData(void **target, void *source);
		virtual void clearData(void *d);
		void printData(void *key, void *d);
	protected:
		HIndex *idx;
	};
    void add(const char *, size_t l, u_int32_t t );
    void add(const char *, size_t l, const char *, size_t);
  	CIdxAdopted(HIndex *);
	~CIdxAdopted();
};

class CIdxHRefs : public CIdxHStringIndex {
  public:
	  class HRefsDP : public CIdxHStringIndex::DataProcessor {
	public:
		HRefsDP (HIndex *i) : idx(i) {}
		virtual void publishData(void *key, void *d);
		virtual int prepublishData(void *key, void *d) { return 1; };
		virtual void mergeData(void **target, void *source);
		virtual void clearData(void *d);
	protected:
		HIndex *idx;
	};
    void add(const char *, size_t l, u_int32_t t, u_int32_t sub );
  	CIdxHRefs(HIndex *);
	~CIdxHRefs();
};

class CIdxHRefsEx : public CIdxHStringIndex {
  public:
	  class HRefsExDP : public CIdxHStringIndex::DataProcessor {
	public:
		HRefsExDP (HIndex *i) : idx(i) {}
		virtual void publishData(void *key, void *d);
		virtual int prepublishData(void *key, void *d) { return 1; };
		virtual void mergeData(void **target, void *source);
		virtual void clearData(void *d);
	protected:
		HIndex *idx;
	};
    void add(const char *, size_t l, u_int32_t t, u_int32_t sub );
  	CIdxHRefsEx(HIndex *);
	~CIdxHRefsEx();
};

class CIdxHDocs : public CIdxHStringIndex {
  public:
	  class HDocsDP : public CIdxHStringIndex::DataProcessor {
	public:
		HDocsDP (HIndex *i) : idx(i) {}
		virtual void publishData(void *key, void *d);
		virtual int prepublishData(void *key, void *d) { return 1; };
		virtual void mergeData(void **target, void *source);
		virtual void clearData(void *d);
	protected:
		HIndex *idx;
	};
    void add(const char *, size_t l, u_int32_t t);
  	CIdxHDocs(HIndex *);
	~CIdxHDocs();
};

class CIdxHDocsEx : public CIdxHStringIndex {
  public:
	  class HDocsDP : public CIdxHStringIndex::DataProcessor {
	public:
		HDocsDP (HIndex *i) : idx(i) {}
		virtual void publishData(void *key, void *d);
		virtual int prepublishData(void *key, void *d) { return 1; };
		virtual void mergeData(void **target, void *source);
		virtual void clearData(void *d);
	protected:
		HIndex *idx;
	};
    void add(const char *, size_t l, u_int32_t t);
  	CIdxHDocsEx(HIndex *);
	~CIdxHDocsEx();
};

#endif

