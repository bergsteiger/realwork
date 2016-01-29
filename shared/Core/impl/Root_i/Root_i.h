////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/impl/Root_i/Root_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> shared::Core::Root_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_ROOT_I_H__
#define __SHARED_CORE_ROOT_I_H__

#include "ace/ACE.h"
#include "shared/Core/Root/Root.h"
#include "shared/Core/Params/Params.h"


namespace Core {
namespace Root_i {

class LibHomeLocal;
typedef ::Core::Var<LibHomeLocal> LibHomeLocal_var;
typedef ::Core::Var<const LibHomeLocal> LibHomeLocal_cvar;
// локальный интерфейс, введён для дополнительных ответственностей, доступных только реализации
// фреймворка.
class LibHomeLocal
	: virtual public Root::LibHome
{
public:
	// вызвается фремворком для запсука всех исполнителей связанных с библиотекой
	virtual void execute () /*throw (Root::InvalidParams, Root::HomeManagerInitError)*/ = 0;

	// вызывается фреймворком для освобождения всех ресурсов билиотеки и выполнения де-
	// инициализационных действий, перед удалением билиотеки
	virtual void finalize () = 0;

	// вызывается фремфорком для инициализаци библиотекти
	virtual void initialize () = 0;

	// проверяет параметры библиотеки (наличие обязательных параметров)
	virtual bool check_params () const = 0;

	// выводит описание параметров библиотеки в стандартный поток
	virtual void print_usage () const = 0;

	// вызываетяс фреймворком для регистрации фабрик всех сервантов содержащихся в билиотеке
	virtual void registrate_all_factories () const = 0;
};

} //namespace Root_i
} // namespace Core


#endif //__SHARED_CORE_ROOT_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

