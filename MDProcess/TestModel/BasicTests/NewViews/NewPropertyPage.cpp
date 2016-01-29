////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/TestModel/BasicTests/NewViews/NewPropertyPage.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<PropertyPage::Class>> TestModel::BasicTests::NewViews::NewPropertyPage
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "TestModel/BasicTests/NewViews/NewPropertyPage.h"

namespace BasicTests {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

NewPropertyPage::NewPropertyPage ()
	: CPropertyPage (NewPropertyPage::IDD)
//#UC START# *49AEE5110370_CTOR_BASE_INIT*
//#UC END# *49AEE5110370_CTOR_BASE_INIT*
{
	//#UC START# *49AEE5110370_CTOR*
	//#UC END# *49AEE5110370_CTOR*
}


NewPropertyPage::~NewPropertyPage () {
	//#UC START# *49AEE5110370_DESTR_BODY*
	//#UC END# *49AEE5110370_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(NewPropertyPage, CPropertyPage)
	//#UC START# *49AEE5110370_MESSAGE_MAP*
	//#UC END# *49AEE5110370_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNCREATE(NewPropertyPage, CPropertyPage)

void NewPropertyPage::DoDataExchange(CDataExchange* pDX) {
	CPropertyPage::DoDataExchange(pDX);
	//#UC START# *49AEE5110370_DO_DATA_EXCHANGE*
	//#UC END# *49AEE5110370_DO_DATA_EXCHANGE*
}

BOOL NewPropertyPage::OnInitDialog () {
	BOOL ret = CPropertyPage::OnInitDialog();
	try {
		//#UC START# *49AEE5110370_ON_INIT_DLG*
		//#UC END# *49AEE5110370_ON_INIT_DLG*
	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"NewPropertyPage\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}


} // namespace BasicTests

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

