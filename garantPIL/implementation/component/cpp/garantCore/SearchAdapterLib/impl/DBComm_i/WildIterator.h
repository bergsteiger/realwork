////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/DBComm_i/WildIterator.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::SearchAdapterLib::DBComm_i::WildIterator
//
// WildIterator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_WILDITERATOR_H__
#define __GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_WILDITERATOR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/DB/DBCore/DBCore.h"

namespace SearchAdapterLib {
namespace DBComm_i {

// WildIterator
class WildIterator {
	SET_OBJECT_COUNTER (WildIterator)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	WildIterator ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// get_count
	size_t get_count () const;

	// get_max_count
	size_t get_max_count () const;

	// init
	bool init (const std::string& mask, DBCore::IIndex* index);

	// is_best
	bool is_best () const;

	// key
	const char* key () const;

	// next
	void next ();

	// rewind
	void rewind ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	size_t m_count;

	DBCore::IBTreeIterator_var m_it;

	std::string m_mask;

	size_t m_max_count;
}; // class WildIterator

} // namespace DBComm_i
} // namespace SearchAdapterLib


#endif //__GARANTCORE_SEARCHADAPTERLIB_DBCOMM_I_WILDITERATOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

