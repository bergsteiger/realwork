////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/StartLocal/StartLocal.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::StartLocal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_STARTLOCAL_H__
#define __GARANT6X_GBLADAPTERLIB_STARTLOCAL_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace GblAdapterLib {
namespace StartLocal {

class BaseUpdateChecker;
typedef ::Core::Var<BaseUpdateChecker> BaseUpdateChecker_var;
typedef ::Core::Var<const BaseUpdateChecker> BaseUpdateChecker_cvar;
// Чистилка кэша при обновлении базы.
// Класс с закешированными данными, подлежащими очистке при обновлении базы,  отнаследовать от
// BaseUpdateChecker и определить на нем метод:
// void clear_cache () const;
// Для сброса кэша при (возможном) обновлении базы вызывать "check_update_and_clear_cache"
class BaseUpdateChecker
	: virtual public ::Core::IObject
{
public:
	// метод вызывается при обновлении базы
	virtual void check_update_and_clear_cache () const = 0;
};

} // namespace StartLocal
} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_STARTLOCAL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
