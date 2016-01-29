////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/impl/Search_i/SpanQuery.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::Search_i::SpanQuery
//
// SpanQuery
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_SEARCH_I_SPANQUERY_H__
#define __SHARED_CONTEXTSEARCH_SEARCH_I_SPANQUERY_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/ContextSearch/MorphoBase/Searcher.h"

namespace ContextSearch {
namespace Search_i {

// SpanQuery
class SpanQuery {

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	// ������
	enum SpanStatus {
		st_None // ������
		, st_Load // ��������
		, st_Bad // ������
		, st_PrevLoad // �������� ��������
	};

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// ��������� �������
	static bool compare_mask_less (unsigned long x, unsigned long y);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	SpanQuery (const std::string& key, const Search::AlgorithmProperties& prop);

public:
	~SpanQuery ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// �������� ���� � ���������
	void add_to (std::string& context);

	// �������� �� ����������
	bool check (DBComm::DocId doc_id) const;

	// �������� ���
	void clear ();

	// ������
	const Relevancy::DataVector& get () const;

	// ������ ������������������
	const Relevancy::Positions& get_first () const;

	// ����
	const std::string& get_key () const;

	// �����
	DBComm::DocId get_next (DBComm::DocId border);

	// ��������� �������� ��� ��������-����������
	size_t get_prog_value ();

	// ������
	size_t get_size () const;

	// ������� ��� ����������
	size_t get_sort_attr (DBComm::DocId doc_id);

	// ���������
	void inc ();

	// �������� �� �������������
	bool is_load () const;

	// �������� �������
	bool load (DBComm::DocId doc_id, DBComm::ExtrPair& extr, long offset, bool& has_block);

	// ��������
	bool operator == (DBComm::DocId doc_id) const;

	// ��������
	bool operator == (const std::string& key) const;

	// ��������������� ��������
	bool prev_load (DBComm::DocId doc_id, DBComm::ExtrPair& extr, long offset, bool& has_block);

	// ����� ���������
	bool search_doc (DBComm::DocId id);

private:
	// ������ ������� �����
	bool deflate ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	unsigned short m_count;

	Relevancy::DataVector m_data;

	Relevancy::DataVector m_deflate_data;

	bool m_deflated;

	DBComm::ExtrPair m_extr;

	bool m_has_block;

	DBComm::DocId m_id;

	Relevancy::IndexChain m_index;

	std::string m_key;

	std::string m_new_key;

	size_t m_offset;

	size_t m_pos;

	Core::Box<Searcher> m_searcher;

	size_t m_size;

	SpanStatus m_status;
}; // class SpanQuery

} // namespace Search_i
} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_SEARCH_I_SPANQUERY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

