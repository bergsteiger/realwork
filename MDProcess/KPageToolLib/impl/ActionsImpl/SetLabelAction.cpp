////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/KPageToolLib/impl/ActionsImpl/SetLabelAction.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::KPageToolLib::ActionsImpl::SetLabelAction
//
// установить лэйблы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/KPageToolLib/LibHome.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/SetLabelAction.h"
// by <<uses>> dependencies
#include "MDProcess/KPageToolLib/impl/ActionsImpl/SourceFileHelper.h"

namespace KPageToolLib {
namespace ActionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetLabelAction::SetLabelAction ()
//#UC START# *48E49C08024A_48E49C5D02FE_4BF3BDC803AC_BASE_INIT*
//#UC END# *48E49C08024A_48E49C5D02FE_4BF3BDC803AC_BASE_INIT*
{
	//#UC START# *48E49C08024A_48E49C5D02FE_4BF3BDC803AC_BODY*
	//#UC END# *48E49C08024A_48E49C5D02FE_4BF3BDC803AC_BODY*
}

SetLabelAction::~SetLabelAction () {
	//#UC START# *4BF3BDC803AC_DESTR_BODY*
	//#UC END# *4BF3BDC803AC_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Actions::KPageAction
// Выполнить действие над страницей. Возвращает 0 - в случае удачи. 1 - в случае любой ошибки
// (подробности в консольном окне).
// page - собственно страница над которой нужно выполнить действие. page НЕ нужно класть в Var!
int SetLabelAction::execute (ServerGate::Contents::KPage* page) {
	//#UC START# *48E49D8D0020_4BF3BDC803AC*
	GDS_ASSERT_MSG(page != 0,("Error page can't be NULL"));

	std::string labels_string;
	int ret = SourceFileHelper::read_as_string (labels_string);
	if (ret != 0) {
		return ret;
	}

	if (labels_string.empty () == false) {
		page->set_labels (labels_string.c_str ());
	}
	return 0;
	//#UC END# *48E49D8D0020_4BF3BDC803AC*
}
} // namespace ActionsImpl
} // namespace KPageToolLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

