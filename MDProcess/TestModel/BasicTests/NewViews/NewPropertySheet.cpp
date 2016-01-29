////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/NewViews/NewPropertySheet.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<PropertySheet::Class>> TestModel::BasicTests::NewViews::NewPropertySheet
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/NewViews/NewPropertySheet.h"

namespace BasicTests {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

NewPropertySheet::NewPropertySheet ()
	: CPropertySheet ("")
//#UC START# *49AEE51701FD_CTOR_BASE_INIT*
//#UC END# *49AEE51701FD_CTOR_BASE_INIT*
{
	//#UC START# *49AEE51701FD_CTOR*
	//#UC END# *49AEE51701FD_CTOR*
}


NewPropertySheet::~NewPropertySheet () {
	//#UC START# *49AEE51701FD_DESTR_BODY*
	//#UC END# *49AEE51701FD_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(NewPropertySheet, CPropertySheet)
	//#UC START# *49AEE51701FD_MESSAGE_MAP*
	//#UC END# *49AEE51701FD_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(NewPropertySheet, CPropertySheet)

void NewPropertySheet::DoDataExchange(CDataExchange* pDX) {
	CPropertySheet::DoDataExchange(pDX);
	//#UC START# *49AEE51701FD_DO_DATA_EXCHANGE*
	//#UC END# *49AEE51701FD_DO_DATA_EXCHANGE*
}

BOOL NewPropertySheet::OnInitDialog () {
	BOOL ret = CPropertySheet::OnInitDialog();
	try {
		//#UC START# *49AEE51701FD_ON_INIT_DLG*
		//#UC END# *49AEE51701FD_ON_INIT_DLG*
	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"NewPropertySheet\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}


} // namespace BasicTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

