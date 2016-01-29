////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/DBExt/Utility/Operations.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityClass::Class>> garantCore::DBExt::Utility::Operations
//
// Операции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANTCORE_DBEXT_UTILITY_OPERATIONS_H__
#define __GARANTCORE_DBEXT_UTILITY_OPERATIONS_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/DB/DBCore/DBCore.h"

namespace DBExt {

// Операции
class Operations {
	SET_OBJECT_COUNTER (Operations)
//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// пересечение двух векторов документов
	static DBCore::DocVector* intersect (const DBCore::DocVector& x, const DBCore::DocVector& y);

	// мердж двух векторов документов
	static DBCore::DocVector* merge (const DBCore::DocVector& x, const DBCore::DocVector& y);

	// мердж двух векторов документов с удалением повторяющихся
	static DBCore::DocVector* merge_unique (const DBCore::DocVector& x, const DBCore::DocVector& y);

	// разница между двумя векторами документов
	static void set_difference (DBCore::DocVector& x, const DBCore::DocVector& y);

}; // class Operations

} // namespace DBExt


#endif //__GARANTCORE_DBEXT_UTILITY_OPERATIONS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

