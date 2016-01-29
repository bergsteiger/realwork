////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/SetTextAction.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::SetTextAction
//
// Реализация дейсвия SET. Читает текст страницы из файла и записывает его в страницу.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/LibHome.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/SetTextAction.h"
// by <<uses>> dependencies
#include "MDProcess/KPageToolLib/impl/ActionsImpl/SourceFileHelper.h"
#include "MDProcess/KPageToolLib/Settings.h"

namespace KPageToolLib {
namespace ActionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetTextAction::SetTextAction ()
//#UC START# *48E49C08024A_48E49C5D02FE_48E49D140243_BASE_INIT*
//#UC END# *48E49C08024A_48E49C5D02FE_48E49D140243_BASE_INIT*
{
	//#UC START# *48E49C08024A_48E49C5D02FE_48E49D140243_BODY*
	//#UC END# *48E49C08024A_48E49C5D02FE_48E49D140243_BODY*
}

SetTextAction::~SetTextAction () {
	//#UC START# *48E49D140243_DESTR_BODY*
	//#UC END# *48E49D140243_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Actions::KPageAction
// Выполнить действие над страницей. Возвращает 0 - в случае удачи. 1 - в случае любой ошибки
// (подробности в консольном окне).
// page - собственно страница над которой нужно выполнить действие. page НЕ нужно класть в Var!
int SetTextAction::execute (ServerGate::Contents::KPage* page) {
	//#UC START# *48E49D8D0020_48E49D140243*
	GDS_ASSERT_MSG(page != 0,("Error page can't be NULL"));

	std::string page_text;
	int ret = SourceFileHelper::read_as_string (page_text);
	if (ret != 0) {
		return ret;
	}

	if (page_text.empty () == false) {
		page->set_wiki_text (page_text.c_str ());
		page->simulate_viewpage_action (Settings::get_password ().c_str ());
	}
	return 0;
	//#UC END# *48E49D8D0020_48E49D140243*
}
} // namespace ActionsImpl
} // namespace KPageToolLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

