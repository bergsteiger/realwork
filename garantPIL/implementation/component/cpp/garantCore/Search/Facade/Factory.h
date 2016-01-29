////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garantPIL/implementation/component/cpp/garantCore/Search/Facade/Factory.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> garantCore::Search::Facade::Factory
//
// �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCH_FACADE_FACTORY_H__
#define __GARANTCORE_SEARCH_FACADE_FACTORY_H__

#include "shared/Core/sys/std_inc.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/SearchB.h"
#include "garantCore/Search/Def/Def.h"

namespace Search {

// �����
class Factory {
	SET_OBJECT_COUNTER (Factory)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// �������
	static IBooleanQuery* make_boolean_query ();

	// �������
	static IBooleanQuery* make_boolean_query (const std::string& str);

	// �������
	static IQuery* make_query (const std::string& type, const std::string& str);

	// �������
	static ISearcher* make_searcher (SearchBase* base);

}; // class Factory

} // namespace Search


#endif //__GARANTCORE_SEARCH_FACADE_FACTORY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

