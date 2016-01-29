////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/WindowsHookImpl/WindowsHookImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::MDAAddinLib::WindowsHookImpl
//
// пакет с определениями хуков
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_WINDOWSHOOKIMPL_H__
#define __MDPROCESS_MDAADDINLIB_WINDOWSHOOKIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <set>
#include "shared/Core/data/unsorted_containers.h"


namespace WindowsHookImpl {

// множество поддерживаемых хуков
typedef std::set < HHOOK > HookSet;

class IHookHandler;
typedef ::Core::Var<IHookHandler> IHookHandler_var;
typedef ::Core::Var<const IHookHandler> IHookHandler_cvar;
// фасет описывающий действия, которые должен реализовывать обработчик хука
class IHookHandler
	: virtual public ::Core::IObject
{
public:
	// обработчик сообщение, до их передачи в окннную процедуру
	virtual LRESULT call_wnd_proc (int code, WPARAM wParam, LPARAM lParam) = 0;

	// обработчик сообщений, помещаемых в очередь
	virtual LRESULT get_message_proc (int code, WPARAM wParam, LPARAM lParam) = 0;

	// функция обработчик сообщений от клавиатуры
	virtual LRESULT keyboard_proc (int code, WPARAM wParam, LPARAM lParam) = 0;

	// функция обработчик WH_MSGFILTER
	virtual LRESULT message_proc (int code, WPARAM wParam, LPARAM lParam) = 0;

	// функция обработчик сообщений от мыши
	virtual LRESULT mouse_proc (int code, WPARAM wParam, LPARAM lParam) = 0;
};

// множество обработчиков
typedef boost::unordered_set <IHookHandler*> HandlerSet;

} //namespace WindowsHookImpl


#endif //__MDPROCESS_MDAADDINLIB_WINDOWSHOOKIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

