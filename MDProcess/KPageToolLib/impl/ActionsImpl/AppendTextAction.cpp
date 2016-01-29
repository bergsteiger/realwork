////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/AppendTextAction.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::AppendTextAction
//
// Реализация дейсвия APPEND. Читает текст страницы из файла и дописывает его в страницу.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/LibHome.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/AppendTextAction.h"
// by <<uses>> dependencies
#include "MDProcess/KPageToolLib/impl/ActionsImpl/SourceFileHelper.h"

namespace KPageToolLib {
namespace ActionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AppendTextAction::AppendTextAction ()
//#UC START# *48E49C08024A_48E49C5D02FE_48E4A52501C9_BASE_INIT*
//#UC END# *48E49C08024A_48E49C5D02FE_48E4A52501C9_BASE_INIT*
{
	//#UC START# *48E49C08024A_48E49C5D02FE_48E4A52501C9_BODY*
	//#UC END# *48E49C08024A_48E49C5D02FE_48E4A52501C9_BODY*
}

AppendTextAction::~AppendTextAction () {
	//#UC START# *48E4A52501C9_DESTR_BODY*
	//#UC END# *48E4A52501C9_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Actions::KPageAction
// Выполнить действие над страницей. Возвращает 0 - в случае удачи. 1 - в случае любой ошибки
// (подробности в консольном окне).
// page - собственно страница над которой нужно выполнить действие. page НЕ нужно класть в Var!
int AppendTextAction::execute (ServerGate::Contents::KPage* page) {
	//#UC START# *48E49D8D0020_48E4A52501C9*
	GDS_ASSERT_MSG(page != 0,("Error page can't be NULL"));

	std::string append_text;
	int ret = SourceFileHelper::read_as_string (append_text);
	if (ret != 0) {
		return ret;
	}

	if (append_text.empty () == false) {
		page->append_wiki_text (append_text.c_str ());
	}
	return 0;
	//#UC END# *48E49D8D0020_48E4A52501C9*
}
} // namespace ActionsImpl
} // namespace KPageToolLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

