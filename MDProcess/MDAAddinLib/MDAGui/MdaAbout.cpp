////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/MdaAbout.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::MdaAbout
//
// About-диалог
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/MDAGui/MdaAbout.h"

//#UC START# *458E706E0066_CUSTOM_INCLUDES*
//#UC END# *458E706E0066_CUSTOM_INCLUDES*


//#UC START# *458E706E0066*
//#UC END# *458E706E0066*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MdaAbout::MdaAbout ()
	: CDialog (MdaAbout::IDD)
//#UC START# *458E706E0066_CTOR_BASE_INIT*
//#UC END# *458E706E0066_CTOR_BASE_INIT*
{
	//#UC START# *458E706E0066_CTOR*
	//#UC END# *458E706E0066_CTOR*
}


MdaAbout::~MdaAbout () {
	//#UC START# *458E706E0066_DESTR_BODY*
	//#UC END# *458E706E0066_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(MdaAbout, CDialog)
	//#UC START# *458E706E0066_MESSAGE_MAP*
	//#UC END# *458E706E0066_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(MdaAbout, CDialog)

void MdaAbout::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *458E706E0066_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_VERSION, m_version);
	DDX_Control(pDX, IDC_BUILD, m_build);
	DDX_Control(pDX, IDC_TARGET, m_target);
	DDX_Control(pDX, IDC_SERVER, m_server);
	//#UC END# *458E706E0066_DO_DATA_EXCHANGE*
}

BOOL MdaAbout::OnInitDialog () {
	BOOL ret = CDialog::OnInitDialog();
	try {
		//#UC START# *458E706E0066_ON_INIT_DLG*
		m_version.SetWindowText (DLL_VERSION);
		char buf[32];
		m_build.SetWindowText (itoa(DLL_BUILD_NUM, buf, 10));
		
		const Core::Root::Info& info = Core::Root::ConfigurationFactory::get().get_info();
		m_target.SetWindowText (info.debug ? "DEBUG" : "RELEASE");
		m_server.SetWindowText (info.use_corba ? "CORBA" : "NONE");
		//#UC END# *458E706E0066_ON_INIT_DLG*
	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"MdaAbout\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

