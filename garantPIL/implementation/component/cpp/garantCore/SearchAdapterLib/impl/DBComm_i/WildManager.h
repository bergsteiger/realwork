////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/DBComm_i/WildManager.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::SearchAdapterLib::DBComm_i::WildManager
//
// Менеджер для поиска всех форм слова, указанного с '*'
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_WILDMANAGER_H__
#define __GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_WILDMANAGER_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/GCL/data/std_defs.h"
#include "shared/DB/DBCore/DBCore.h"
#include "garantCore/SearchAdapterLib/impl/DBComm_i/WildIterator.h"

namespace SearchAdapterLib {
namespace DBComm_i {

// Менеджер для поиска всех форм слова, указанного с '*'
class WildManager {
	SET_OBJECT_COUNTER (WildManager)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	// Wilds
	typedef std::vector < WildIterator > Wilds;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	WildManager (DBCore::IBase* base, const GCL::StrVector& request);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// получить запрос
	void get_request (std::string& out);

	// перейти к следующему
	bool next (int& set_value);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	size_t m_best_wild;

	Wilds m_wilds;
}; // class WildManager

} // namespace DBComm_i
} // namespace SearchAdapterLib


#endif //__GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_WILDMANAGER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

