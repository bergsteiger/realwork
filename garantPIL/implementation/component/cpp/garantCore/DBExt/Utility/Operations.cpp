////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Utility/Operations.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> garantCore::DBExt::Utility::Operations
//
// Операции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/DBExt/Utility/Operations.h"
// by <<uses>> dependencies
#include <algorithm>
#include <iterator>

namespace DBExt {

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// пересечение двух векторов документов
DBCore::DocVector* Operations::intersect (const DBCore::DocVector& x, const DBCore::DocVector& y) {
	//#UC START# *4EB7D82C0384*
	Core::Aptr <DBCore::DocVector> ret = new DBCore::DocVector (std::min (x.size (), y.size ()));
	ret->erase (std::set_intersection (x.begin (), x.end (), y.begin (), y.end (), ret->begin ()), ret->end ());
	return ret._retn ();
	//#UC END# *4EB7D82C0384*
}

// мердж двух векторов документов
DBCore::DocVector* Operations::merge (const DBCore::DocVector& x, const DBCore::DocVector& y) {
	//#UC START# *4EB7D85E0130*
	Core::Aptr <DBCore::DocVector> ret = new DBCore::DocVector (x.size () + y.size ());
	std::merge (x.begin (), x.end (), y.begin (), y.end (), ret->begin ());
	return ret._retn ();
	//#UC END# *4EB7D85E0130*
}

// мердж двух векторов документов с удалением повторяющихся
DBCore::DocVector* Operations::merge_unique (const DBCore::DocVector& x, const DBCore::DocVector& y) {
	//#UC START# *4EB7D8CD02FB*
	Core::Aptr <DBCore::DocVector> ret = merge (x, y);
	ret->erase (std::unique (ret->begin (), ret->end ()), ret->end ());
	return ret._retn ();
	//#UC END# *4EB7D8CD02FB*
}

// разница между двумя векторами документов
void Operations::set_difference (DBCore::DocVector& x, const DBCore::DocVector& y) {
	//#UC START# *4EB7D9110386*
	DBCore::DocVector res;
	std::set_difference  (x.begin (), x.end (), y.begin (), y.end (), std::back_inserter (res));
	x.assign (res.begin (), res.end ());
	//#UC END# *4EB7D9110386*
}

} // namespace DBExt

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

