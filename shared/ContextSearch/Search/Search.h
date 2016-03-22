////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/Search/Search.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::ContextSearch::Search
//
// ���������� � ���� ��� ���������� ������������ ������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_SEARCH_H__
#define __SHARED_CONTEXTSEARCH_SEARCH_H__

#include "shared/Core/sys/std_inc.h"
#include <set>
#include <vector>
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/Defs/Defs.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/Morpho/Def/Def.h"

namespace ContextSearch {
namespace Search {

// ����� (��������)
typedef std::vector < std::string > Phrase;

#pragma pack (push, 1)

// ��������� ��������� �����-������
struct AlgorithmProperties {
	// ���� ������
	unsigned long flags;
	// ������� �������
	DBComm::IStreamsFactory* factory;
	// ������������ ����� ���������
	size_t max_fragment;
	// ������������
	Morpho::Def::INormalizer* normalizer;
	// ������� ���� � ������� �������������
	Defs::IRelevancyInfo* collector;
	// ������������
	DBComm::IDBCommunicator* comm;
	// ��������� ��� wildcard
	DBComm::IWildCard* wild_mng;
	AlgorithmProperties ()
		: flags(0)
		, factory(0)
		, max_fragment(0)
		, normalizer(0)
		, collector(0)
		, comm(0)
		, wild_mng(0)
	{
		//#UC START# *49FEC0BB02CC_DEF_INIT_CTOR*
		//#UC END# *49FEC0BB02CC_DEF_INIT_CTOR**cpp*
	}
	//#UC START# *49FEC0BB02CC*
	AlgorithmProperties (const AlgorithmProperties& copy) {
		flags = copy.flags;
		factory = copy.factory;
		max_fragment = copy.max_fragment;
		normalizer = copy.normalizer;
		collector = copy.collector;
		comm = copy.comm;
		wild_mng = copy.wild_mng;
	}
	//#UC END# *49FEC0BB02CC*
};

#pragma pack (pop)

// ��������� ��������� �����-������
static const size_t RESERVE_SIZE = 1024; // ������ ��������������
static const size_t WORDS_LIMIT = 10; // ������������ ���������� ���� �������
static const size_t PROGRESS_DOCS1000 = 2000; // ���������� ��������, ����� ������� ��������-��������� �������� �������� ���� ���������

#pragma pack (push, 1)

// ���� id
struct DocIdPair {
	// ����������� id ���������
	DBComm::DocId min_id;
	// ������������ id ���������
	DBComm::DocId max_id;
};

#pragma pack (pop)

// �������� �����-�������
static const unsigned long SP_TITLES = 0x0001; // ������ ������� � ����������
static const unsigned long SP_IGNORE_CACHE = 0x0002; // ���������� ���� �������
static const unsigned long SP_STRONG_DEFLATE = 0x0004; // ���������� ����������� ��� ������� ����

// �������� ��� ������� ���������� ���������
enum AlgorithmSelector {
	as_Partial // as_Partial
	, as_Default // as_Default
	, as_Simple // as_Simple
};

#pragma pack (push, 1)

// ���������
struct FragmentsPair {
	// ������� ���������
	Core::Box<Relevancy::Fragments> data;
	// ��������� ����������� � ������
	Core::Box<Relevancy::Fragments> block_data;
};

#pragma pack (pop)

// ��������� ��� ��������� (��������������� �������) ����������
typedef Defs::RelevancyDocuments RelevancyDocuments;

// ������������� ������ ������-������
typedef std::set < std::string > StringSet;

// ����������� �����
typedef std::vector < StringSet > PhraseEx;

class IWorker;
typedef ::Core::Var<IWorker> IWorker_var;
typedef ::Core::Var<const IWorker> IWorker_cvar;
// ��������� ��� ���������� ������������� ��������� � ������������ ������
class IWorker
	: virtual public ::Core::IObject
{
public:
	// �������������
	virtual void init (Relevancy::IAlgorithm* alg) = 0;

	// ������� ���������
	virtual RelevancyDocuments* _retn () = 0;

	// �������� ������ �� ������ ������������� ��������� ���������
	virtual void add (DBComm::DocId doc_id) = 0;

	// ��������� �����
	virtual void shutdown () = 0;
};

/// factory interface for IWorker
class IWorkerFactory {
public:
	// �������
	static IWorker* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// ������ �� ������
struct SplitRequest {
	// ������ ���������� �������
	Relevancy::Data data;
	// ��������
	Phrase context;

	SplitRequest (const SplitRequest& copy);

	SplitRequest& operator = (const SplitRequest& copy);
	//#UC START# *49CCFF74015A*
	SplitRequest () {
	}

	bool operator < (const SplitRequest& val) const {
		return (context.size () < val.context.size ());
	}

	bool operator == (const SplitRequest& val) const {
		return (context.size () == val.context.size () && data == val.data);
	}
	//#UC END# *49CCFF74015A*
};

#pragma pack (pop)

#pragma pack (push, 1)

// ����������� ��������� ������
struct RequestEx {
	// �������
	PhraseEx context;
	// ������ ���������� �������
	Relevancy::Data data;
};

#pragma pack (pop)

// ���������� ������ �������������
class CanceledByUser : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ ��������� ��������
typedef std::vector < SplitRequest > SplitRequests;

// ������ ����������� ��������� ��������
typedef std::vector < RequestEx > RequestsEx;

// �����
typedef std::vector < Phrase > Phrases;

class IRequestView;
typedef ::Core::Var<IRequestView> IRequestView_var;
typedef ::Core::Var<const IRequestView> IRequestView_cvar;
// ������������� ������������ �������
class IRequestView
	: virtual public ::Core::IObject
{
public:
	// �����
	virtual const Phrases& get_spans () const = 0;

	// ������ ������������
	virtual const SplitRequests& get_sequence () const = 0;

	// ���
	virtual AlgorithmSelector get_type () const = 0;

	// �������
	virtual bool build (const Phrase& in, const std::string& src) = 0;
};

/// factory interface for IRequestView
class IRequestViewFactory {
public:
	typedef std::vector<AlgorithmSelector> KeySet;
	
	static KeySet* keys ();
public:
	// �������
	static IRequestView* make (
		DBComm::IDBCommunicator* comm
		, Morpho::Def::INormalizer* normalizer
	, AlgorithmSelector key
	) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ����� ������ ����������� � �������� �� ���������� ������
typedef Defs::InvisibleBlocks InvisibleBlocks;

class IAlgorithm;
typedef ::Core::Var<IAlgorithm> IAlgorithm_var;
typedef ::Core::Var<const IAlgorithm> IAlgorithm_cvar;
// ��������� ��������� �����-������
class IAlgorithm
	: virtual public ::Core::IObject
{
public:
	// ������ ����������� ����������
	virtual Defs::Fragments* get_fragments (DBComm::DocId doc_id, const Defs::InvisibleBlocks& blocks) = 0;

	// �����
	virtual void search (Defs::IResCollector* collector, Defs::IFilter* filter) = 0;
};

/// factory interface for IAlgorithm
class IAlgorithmFactory {
public:
	typedef std::vector<AlgorithmSelector> KeySet;
	
	static KeySet* keys ();
public:
	// �������
	static IAlgorithm* make (
		IRequestView* view
		, DBComm::IProgress* progress
		, const AlgorithmProperties& properties
	, AlgorithmSelector key
	) /*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ������
typedef Defs::IFilter IFilter;
typedef Defs::IFilter_var IFilter_var;
typedef Defs::IFilter_cvar IFilter_cvar;

// ��������� ��� ���������� ������
typedef Defs::IResCollector IResCollector;
typedef Defs::IResCollector_var IResCollector_var;
typedef Defs::IResCollector_cvar IResCollector_cvar;

// �� ��������� ���������� ������
class InvalidSpans : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

} // namespace Search
} // namespace ContextSearch

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <ContextSearch::Search::IWorker> {
	typedef ContextSearch::Search::IWorkerFactory Factory;
};
template <>
struct TypeTraits <ContextSearch::Search::IRequestView> {
	typedef ContextSearch::Search::IRequestViewFactory Factory;
};
template <>
struct TypeTraits <ContextSearch::Search::IAlgorithm> {
	typedef ContextSearch::Search::IAlgorithmFactory Factory;
};
} // namespace Core


#endif //__SHARED_CONTEXTSEARCH_SEARCH_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
