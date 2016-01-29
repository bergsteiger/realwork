////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/GetTextAction.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::GetTextAction
//
// Реализация дейсвия GET. Читает текст страницы К и записывает его в файл.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/LibHome.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/GetTextAction.h"
// by <<uses>> dependencies
#include "MDProcess/KPageToolLib/impl/ActionsImpl/SourceFileHelper.h"

namespace KPageToolLib {
namespace ActionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

GetTextAction::GetTextAction ()
//#UC START# *48E49C08024A_48E49C5D02FE_48E49C9802F4_BASE_INIT*
//#UC END# *48E49C08024A_48E49C5D02FE_48E49C9802F4_BASE_INIT*
{
	//#UC START# *48E49C08024A_48E49C5D02FE_48E49C9802F4_BODY*
	//#UC END# *48E49C08024A_48E49C5D02FE_48E49C9802F4_BODY*
}

GetTextAction::~GetTextAction () {
	//#UC START# *48E49C9802F4_DESTR_BODY*
	//#UC END# *48E49C9802F4_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Actions::KPageAction
// Выполнить действие над страницей. Возвращает 0 - в случае удачи. 1 - в случае любой ошибки
// (подробности в консольном окне).
// page - собственно страница над которой нужно выполнить действие. page НЕ нужно класть в Var!
int GetTextAction::execute (ServerGate::Contents::KPage* page) {
	//#UC START# *48E49D8D0020_48E49C9802F4*
	GDS_ASSERT_MSG(page != 0,("Error page can't be NULL"));
	CORBA::String_var page_text = page->get_wiki_text ();
	if (page_text.in ()) {
		int ret = SourceFileHelper::write (page_text.in ());
		if (ret != 0) {
			return ret;
		}
	}
	return 0;
	//#UC END# *48E49D8D0020_48E49C9802F4*
}
} // namespace ActionsImpl
} // namespace KPageToolLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

