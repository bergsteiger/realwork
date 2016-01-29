////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/Search/Cache/AttrCache.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Cache::AttrCache
//
// ��� ����� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_CACHE_ATTRCACHE_H__
#define __GARANTCORE_SEARCH_CACHE_ATTRCACHE_H__

#include "shared/Core/sys/std_inc.h"
#include "ace/Singleton.h"
#include "shared/GCL/data/std_defs.h"

namespace Search {

// ��� ����� ���������
class AttrCache {

	// singleton declaration
	typedef ACE_Singleton <AttrCache, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <AttrCache, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static AttrCache* instance () {
		return Singleton::instance();
	}

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	// ���� ���������
	enum AttributeType {
		at_Unknown // �����������
		, at_Date // ����/�������� ���
		, at_String // ������
		, at_Integer // �����
		, at_Hierarchical // �������������
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AttrCache ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ��� ��������
	AttributeType get_type (const std::string& str) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GCL::StrSet m_date_attr;

	GCL::StrSet m_int_attr;

	GCL::StrSet m_str_attr;
}; // class AttrCache

} // namespace Search


#endif //__GARANTCORE_SEARCH_CACHE_ATTRCACHE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

