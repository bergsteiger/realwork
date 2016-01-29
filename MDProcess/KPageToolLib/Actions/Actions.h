////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/Actions/Actions.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::KPageToolLib::Actions
//
// Пакет доступных действий со страницей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_KPAGETOOLLIB_ACTIONS_H__
#define __MDPROCESS_KPAGETOOLLIB_ACTIONS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "MDProcess/ServerGate/Contents/Contents.h"

namespace KPageToolLib {
namespace Actions {

// список действий, которые можно выполнять, например из KPageTool
enum PageActionsEnum {
	PA_GET // получить текст страницы
	, PA_SET // установить текст страницы
	, PA_APPEND // добавить текст к концу текста страницы
	, PA_ATTACH // добавить новое вложение
	, PA_GET_LABEL // получить список лэйблов (через запятую, отсортированы по алфавиту)
	, PA_SET_LABEL // установить новые лэйблы (задаются одной строкой, через запятую)
};

class KPageAction;
typedef ::Core::Var<KPageAction> KPageAction_var;
typedef ::Core::Var<const KPageAction> KPageAction_cvar;
// Обёртка над KPage для выполнения комманд утилиты KPageTool.
class KPageAction
	: virtual public ::Core::IObject
{
public:
	// Выполнить действие над страницей. Возвращает 0 - в случае удачи. 1 - в случае любой ошибки
	// (подробности в консольном окне).
	// page - собственно страница над которой нужно выполнить действие. page НЕ нужно класть в Var!
	virtual int execute (ServerGate::Contents::KPage* page) = 0;
};

/// factory interface for KPageAction
class KPageActionFactory {
public:
	typedef std::vector<PageActionsEnum> KeySet;
	
	static KeySet* keys ();
public:
	// возвращает экземпляр действия
	static KPageAction& get (PageActionsEnum key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace Actions
} // namespace KPageToolLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <KPageToolLib::Actions::KPageAction> {
	typedef KPageToolLib::Actions::KPageActionFactory Factory;
};
} // namespace Core


#endif //__MDPROCESS_KPAGETOOLLIB_ACTIONS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
