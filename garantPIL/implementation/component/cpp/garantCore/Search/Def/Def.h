////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/Search/Def/Def.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garantCore::Search::Def
//
// ����� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_DEF_H__
#define __GARANTCORE_SEARCH_DEF_H__

#include "shared/Core/sys/std_inc.h"
#include <set>
#include <vector>
#include "garantCore/SearchAdapterLib/Adapter/Adapter.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/collect.h"
#include "shared/GCL/data/std_defs.h"

namespace Search {

// ���������� ��������
typedef char MergeOp;

#pragma pack (push, 1)

// ���
struct QueryTag {
	// ����
	std::string key;
	// ������
	std::string val;
	// ���������� ��������
	MergeOp op;
	//#UC START# *50A514AF0034*
	QueryTag () {
	}
	QueryTag (const std::string& _key) : key (_key) {
	}
	QueryTag (const std::string& _key, const std::string& _val, MergeOp _op) : key (_key), val (_val), op (_op) {
	}

	bool operator == (const std::string& str) const {
		return key == str;
	}
	bool operator != (const std::string& str) const {
		return key != str;
	}
	//#UC END# *50A514AF0034*
};

#pragma pack (pop)

// ������ �����
typedef std::vector < QueryTag > QueriesTags;

#pragma pack (push, 1)

// ��������� ������
struct SearchProp {
	// ������������� ���������
	unsigned long doc_id;
	// ������������ ������ ���������� ������
	long max_res_size;
	// ������
	const SortedCollection* init;
	// ������
	SearchAdapterLib::Adapter::IFilter* filter;
	// ����������� �������
	GCL::StrVector ctx_src;
	SearchProp () : doc_id(0) {
		//#UC START# *50A9FEBC01E1_DEF_INIT_CTOR*
		init = 0;
		filter = 0;
		info_collector = 0;

		max_res_size = std::numeric_limits <long>::max () - 1;
		//#UC END# *50A9FEBC01E1_DEF_INIT_CTOR**cpp*
	}
	//#UC START# *50A9FEBC01E1*
	ContextSearch::Defs::IRelevancyInfo* info_collector;
	//#UC END# *50A9FEBC01E1*
};

#pragma pack (pop)

#pragma pack (push, 1)

// ��������� ������
struct SearchResult {
	// ������� �������� ������
	bool is_cut;
	// ������� ���������� ������ �������������
	bool is_interrupted;
	// ������ ������� ������
	size_t full_size;
	SearchResult () : is_cut(false), is_interrupted(false), full_size(0) {
		//#UC START# *509D097B02AD_DEF_INIT_CTOR*
		//#UC END# *509D097B02AD_DEF_INIT_CTOR**cpp*
	}
	//#UC START# *509D097B02AD*
	Core::Aptr <SortedCollection> list;
	//#UC END# *509D097B02AD*
};

#pragma pack (pop)

class IQuery;
typedef ::Core::Var<IQuery> IQuery_var;
typedef ::Core::Var<const IQuery> IQuery_cvar;
// ������
class IQuery
	: virtual public ::Core::IObject
{
public:
	// ������
	virtual const std::string& get_data () const = 0;

	// ���
	virtual const std::string& get_type () const = 0;
};

class IBooleanQuery;
typedef ::Core::Var<IBooleanQuery> IBooleanQuery_var;
typedef ::Core::Var<const IBooleanQuery> IBooleanQuery_cvar;
// ���������� ������
class IBooleanQuery
	: virtual public IQuery
{
public:
	// �������� ������
	virtual void add (IQuery* query, MergeOp op) = 0;

	// ���������� ��������
	virtual size_t get_count () const = 0;
};

class ISearcher;
typedef ::Core::Var<ISearcher> ISearcher_var;
typedef ::Core::Var<const ISearcher> ISearcher_cvar;
// ��������� ����������
class ISearcher
	: virtual public ::Core::IObject
{
public:
	// ���������
	virtual SearchResult* execute (const std::string& query, const SearchProp& prop) = 0;

	// ���������
	virtual SearchResult* execute (IQuery* query, const SearchProp& prop) = 0;
};

// ���� ��������
static const std::string BOOL_TYPE = "BOOL"; // ��� ����������� �������
static const std::string BODY_TYPE = "MorphoText"; // ��� ������������ ������� ��� ������ � ������
static const std::string TITLE_TYPE = "MorphoName"; // ��� ������������ ������� ��� ������ � ����������

// ��������� ���������
typedef std::set < short > Segments;

// ���������� ����
class InvalidKey : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ���������� ��������
static const char so_AND = '&'; // AND
static const char so_OR = '|'; // OR
static const char so_NOT = '~'; // NOT

class IBooleanFilter;
typedef ::Core::Var<IBooleanFilter> IBooleanFilter_var;
typedef ::Core::Var<const IBooleanFilter> IBooleanFilter_cvar;
// ���������� ������
class IBooleanFilter
	: virtual public SearchAdapterLib::Adapter::IFilter
{
public:
	// ��������
	virtual void add (SearchAdapterLib::Adapter::IFilter* in) = 0;
};

} // namespace Search


#endif //__GARANTCORE_SEARCH_DEF_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
