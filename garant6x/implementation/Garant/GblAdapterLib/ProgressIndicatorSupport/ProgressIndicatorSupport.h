////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ProgressIndicatorSupport/ProgressIndicatorSupport.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ProgressIndicatorSupport
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PROGRESSINDICATORSUPPORT_H__
#define __GARANT6X_GBLADAPTERLIB_PROGRESSINDICATORSUPPORT_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace GblAdapterLib {

class ProgressIndicator;
typedef ::Core::Var<ProgressIndicator> ProgressIndicator_var;
typedef ::Core::Var<const ProgressIndicator> ProgressIndicator_cvar;
// Интерфейс для обратной связи при длительных операциях на сервере.
// Должен реализовываться пользователем адаптера.
class ProgressIndicator
	: virtual public ::Core::IObject
{
public:
	virtual long get_max_count () const = 0;

	// Изменение состояния длительного процесса.
	// В качестве параметра cur_count подается либо число уже обработанных элементов, принимающих
	// участие в длительном процессе, либо число <=100 (при индикации в %).
	virtual void set_current (long cur_count, long arg) const = 0;
};

class CancelLongProcess;
typedef ::Core::Var<CancelLongProcess> CancelLongProcess_var;
typedef ::Core::Var<const CancelLongProcess> CancelLongProcess_cvar;
// Интерфейс для возможности прерывания длительных операций на сервере. Используется в интерфейсе
// IProgressIndicator.
class CancelLongProcess
	: virtual public ::Core::IObject
{
public:
	// Вызывается для прерывания длительного процесса.
	virtual void cancel_process () const = 0;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PROGRESSINDICATORSUPPORT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
