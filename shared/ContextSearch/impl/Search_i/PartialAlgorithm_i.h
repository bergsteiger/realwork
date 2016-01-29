////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/impl/Search_i/PartialAlgorithm_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::ContextSearch::Search_i::PartialAlgorithm_i
// ��������� ���������� ������ �������� ��� ��������� IAlgorithm
//
// ���������� ���������� ���������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_SEARCH_I_PARTIALALGORITHM_I_H__
#define __SHARED_CONTEXTSEARCH_SEARCH_I_PARTIALALGORITHM_I_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/GCL/data/std_defs.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/ContextSearch/impl/Search_i/SpanQuery.h"
#include "shared/ContextSearch/impl/Search_i/SpansQuery.h"

namespace ContextSearch {
namespace Search_i {

class PartialAlgorithm_i; // self forward Var
typedef ::Core::Var<PartialAlgorithm_i> PartialAlgorithm_i_var;
typedef ::Core::Var<const PartialAlgorithm_i> PartialAlgorithm_i_cvar;

class PartialAlgorithm_i_factory;

// ���������� ���������� ���������� ���������
class PartialAlgorithm_i:
	virtual public Search::IAlgorithm
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (PartialAlgorithm_i)
	friend class PartialAlgorithm_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// ������
	typedef std::vector < SpansQuery > PartialQuery;

	// ������ ������������� �������
	class QueryData {

	//////////////////////////////////////////////////////////////////////////////////////////
	// nested declarations
public:
		// �����
		typedef std::vector < SpanQuery* > Spans;

	private:
		// ������������� ��������
		struct SortAttr {
			// ���������� ����������� ���������
			size_t sz;
			// ������� � ������� ������
			size_t pos;
			// ����� �����
			size_t len;
		};

		// CompareSpans
		struct CompareSpans : public std::binary_function<SortAttr, SortAttr, bool> {
			bool operator () (const SortAttr& first_param_, const SortAttr& second_param_) const;
		};

		// ������������� �������� (�� ������)
		typedef std::vector < SortAttr > SortAttrs;

	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		QueryData (const GCL::StrVector& in, const Spans& spans, const Search::AlgorithmProperties& properties);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		// �������� ������������� ������
		void check (DBComm::DocId doc_id);

		// �������� ���������
		void get_fragments (Relevancy::Fragments& out, DBComm::DocId doc_id);

		// ������ �������������
		void get_relevancy (Relevancy::RelevancyDocInfo& out);

	private:
		// �������� �� ������� ����������� ����� �������
		bool check_intersect ();

		// �������� �������
		bool load (DBComm::DocId doc_id, bool& has_block);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		Relevancy::IAlgorithm_var m_algorithm;

		Relevancy::IRelevancyInfo* m_collector;

		DBComm::IDBCommunicator* m_communicator;

		std::string m_context;

		Relevancy::DataVector m_data;

		long m_offset;

		SortAttrs m_sort_attr;

		Relevancy::Positions m_span_pos;

		Spans m_spans;

	//#UC START# *521207E7010D*
	private:
		Relevancy::IndexChain m_ends;
		Relevancy::IndexChain m_index; 
	//#UC END# *521207E7010D*
	}; // class QueryData

	// ������ ��������
	typedef std::vector < QueryData > QueriesData;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PartialAlgorithm_i (
		Search::IRequestView* view
		, DBComm::IProgress* progress
		, const Search::AlgorithmProperties& properties
	);

	virtual ~PartialAlgorithm_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ������ �������������
	bool get_relevancy (Relevancy::RelevancyDocInfo& out);

	// �����
	bool next (Search::DocIdPair& result);

	// �������� ��������� ��������-����������
	bool set_progress (size_t i);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	QueriesData m_data;

	DBComm::IProgress_var m_progress;

	Search::AlgorithmProperties m_properties;

	PartialQuery m_query;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Search::IAlgorithm
	// ������ ����������� ����������
	virtual Defs::Fragments* get_fragments (DBComm::DocId doc_id, const Defs::InvisibleBlocks& blocks);

	// implemented method from Search::IAlgorithm
	// �����
	virtual void search (Defs::IResCollector* collector, Defs::IFilter* filter);
}; // class PartialAlgorithm_i

} // namespace Search_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_SEARCH_I_PARTIALALGORITHM_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
