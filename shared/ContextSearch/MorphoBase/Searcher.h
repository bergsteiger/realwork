////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/MorphoBase/Searcher.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::MorphoBase::Searcher
//
// Searcher
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MORPHOBASE_SEARCHER_H__
#define __SHARED_CONTEXTSEARCH_MORPHOBASE_SEARCHER_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/MorphoBase/SearchStream.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"
#include "shared/DB/DBCore/DBCore.h"

//#UC START# *4F313B660191_CUSTOM_INCLUDES*
//#UC END# *4F313B660191_CUSTOM_INCLUDES*

namespace ContextSearch {

// Searcher
class Searcher {
	SET_OBJECT_COUNTER (Searcher)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// ��������� ��� �������� �������� ������� ���� ������� ���������
	typedef std::vector < SearchStream* > StreamPointers;

	// ���������
	static const size_t GREAT_RESERVE_SIZE; // ������ ��� ��������������

public:
	// ������� ����
	struct CacheNode {
		// ����
		std::string key;
		// �����
		SearchStream* stream;
	};

	// ��� �������
	typedef std::vector < CacheNode > StreamsCache;

	// StreamDestroy
	struct StreamDestroy : public std::unary_function<CacheNode, void> {
		void operator () (CacheNode& param_) const;
	};

private:
	// ������ �������
	typedef std::vector < StreamPointers > Streams;



//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// ��������� �����
	static bool compare_mask_equal (unsigned long x, unsigned long y);

	// �������� ���� (min � max) ��������� ����� start_id � ��������������� ������� ����������, ���
	// �������� �� ������� ����� �������
	static void get_next_pair (Search::DocIdPair& pair, StreamPointers& sp, DBComm::DocId start_id);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit Searcher (const Search::AlgorithmProperties& properties);

public:
	~Searcher ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ��������
	bool add (const std::string& str, size_t i);

	// ������� ���� ����� ��� ��������� ���������
	bool get_data (Relevancy::DataVector& result, DBComm::DocId doc_id, bool& has_block);

	// ������� ���� ����� ��� ��������� ���������
	bool get_data (
		Relevancy::DataVector& result
		, DBComm::DocId doc_id
		, bool& has_block
		, size_t offset
		, DBCore::ExtrPair& extr
	);

	// ���������� ����������� ���������
	size_t get_min_size (DBComm::DocId doc_id, size_t& pos);

	// ������ ��������� ��������
	DBComm::DocId get_next (DBComm::DocId border);

	// �������� ��� ��������-����������
	size_t get_prog_value ();

	// ��������������� ��������
	bool prev_load (
		Relevancy::DataVector& result
		, DBComm::DocId doc_id
		, bool& has_block
		, size_t offset
		, DBCore::ExtrPair& extr
	);

	// ����� ��������� ���������
	bool search (DBComm::DocId id);

	// �������������
	void set (const Search::PhraseEx& in);

	// �������������
	bool set (const Search::Phrase& in);

private:
	// �������� �����
	bool add_stream (const std::string& norma, const std::string& forma, StreamPointers& streams);

	// �������� ������� ��� �������
	bool get_data (
		Relevancy::Positions& out
		, StreamPointers& streams
		, DBComm::DocId doc_id
		, bool& has_block
		, const DBCore::ExtrPair& extr
	);

	// ����� �����
	void reset ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	StreamsCache m_cache;

	size_t m_offset;

	Search::DocIdPair m_pair;

	size_t m_pos;

	Search::AlgorithmProperties m_properties;

	Streams m_streams;

//#UC START# *4F313B660191*
//#UC END# *4F313B660191*
}; // class Searcher

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MORPHOBASE_SEARCHER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

