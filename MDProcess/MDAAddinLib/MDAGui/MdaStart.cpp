////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/MdaStart.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::MdaStart
//
// диалог показывает сразу после запуска розы позволяет открыть модели из Recent списка, либо
// создать новую модель на основе шаблона
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/MDAGui/MdaStart.h"
// by <<uses>> dependencies
#include "boost/lexical_cast.hpp"

//#UC START# *457415F60222_CUSTOM_INCLUDES*
#include "shared/GCL/str/str_op.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
//#UC END# *457415F60222_CUSTOM_INCLUDES*


//#UC START# *457415F60222*
struct MdaData {
	std::string template_model;
	std::string template_file;
};

typedef std::map<std::string, MdaData> MdaTemplates;

MdaTemplates get_mda_templates () {
	MdaTemplates ret;
	ret ["Garant Common Template"].template_model = "W:\\shared\\support\\mdagen\\template_models\\garant_common_template.mdl";
	ret ["Garant Common Template"].template_file = "W:\\shared\\support\\mdagen\\templates\\garant_common_template.tpl";
	ret ["Garant Common Template (with \"shared\" only for non CORBA project)"].template_model = "W:\\shared\\support\\mdagen\\template_models\\garant_common_template_with_no_server_shared.mdl";
	ret ["Garant Common Template (with \"shared\" only for non CORBA project)"].template_file = "W:\\shared\\support\\mdagen\\templates\\garant_common_template.tpl";
	ret ["Garant Common Template (with \"shared\" for CORBA project)"].template_model = "W:\\shared\\support\\mdagen\\template_models\\garant_common_template_with_server_shared.mdl";
	ret ["Garant Common Template (with \"shared\" for CORBA project)"].template_file = "W:\\shared\\support\\mdagen\\templates\\garant_common_template.tpl";
	ret ["Garant Common Template (with maximum \"shared\" project)"].template_model = "W:\\shared\\support\\mdagen\\template_models\\garant_common_template_with_maximum_shared.mdl";
	ret ["Garant Common Template (with maximum \"shared\" project)"].template_file = "W:\\shared\\support\\mdagen\\templates\\garant_common_template.tpl";
	return ret;
}

void MdaStart::OnBnClickedOk()
{
	int sel = m_rml_box.get_selected_item ();
	if (sel != -1) {
		CString res = m_rml_box.GetItemText (sel, 0);
		m_result.file_name = (const char*) res;
		m_result.file_type = RFT_MRU;
		OnOK();
		return;
	} 

	sel = m_mda_box.get_selected_item ();
	if (sel != -1) {
		CString res = m_mda_box.GetItemText (sel, 0);
		MdaTemplates mda_tpl = get_mda_templates();		
		
		RoseAbstractDumper::FileDesc fd;
		
		m_result.file_name = mda_tpl[(const char*)res].template_model;
		m_result.file_type = RFT_MDA_TPL;
		
		OnOK();
		
		return;
	}	
}

void MdaStart::OnDblClick(NMHDR* pNMHDR, LRESULT* pResult) {
	this->OnBnClickedOk ();
	*pResult = 0;
}

void MdaStart::OnBnClickedButton1() {
	std::string REGISTRY_KEY_PATH = "SOFTWARE\\Garant\\MDAGenerator";
	std::string REGISTRY_OPTION_NAME = "RML";	
	Core::RegistryHelper::set_option_value (
		Core::RegistryHelper::KEY_CURRENT_USER
		, REGISTRY_KEY_PATH
		, REGISTRY_OPTION_NAME
		, ""
	);
	m_rml_box.DeleteAllItems ();
}
//#UC END# *457415F60222*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MdaStart::MdaStart ()
	: WinGUI::ETSLayoutDialog (MdaStart::IDD)
//#UC START# *457415F60222_CTOR_BASE_INIT*
//#UC END# *457415F60222_CTOR_BASE_INIT*
{
	//#UC START# *457415F60222_CTOR*
	//#UC END# *457415F60222_CTOR*
}


MdaStart::~MdaStart () {
	//#UC START# *457415F60222_DESTR_BODY*
	//#UC END# *457415F60222_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(MdaStart, WinGUI::ETSLayoutDialog)
	ON_WM_CREATE()
	//#UC START# *457415F60222_MESSAGE_MAP*
	ON_NOTIFY (NM_DBLCLK, IDC_RML, OnDblClick)
	ON_NOTIFY (NM_DBLCLK, IDC_MDA, OnDblClick)
	ON_BN_CLICKED(IDOK, OnBnClickedOk)	
	ON_BN_CLICKED(IDC_BUTTON1, OnBnClickedButton1)
	//#UC END# *457415F60222_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(MdaStart, CDialog)

void MdaStart::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *457415F60222_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_RML, m_rml_box);
	DDX_Control(pDX, IDC_MDA, m_mda_box);
	//#UC END# *457415F60222_DO_DATA_EXCHANGE*
}

BOOL MdaStart::OnInitDialog () {
	BOOL ret = WinGUI::ETSLayoutDialog::OnInitDialog();
	try {
		//#UC START# *457415F60222_ON_INIT_DLG*
		m_rml_box.InsertColumn (0, "", LVCFMT_LEFT);
		m_mda_box.InsertColumn (0, "", LVCFMT_LEFT);

		std::string REGISTRY_KEY_PATH = "SOFTWARE\\Garant\\MDAGenerator";
		std::string REGISTRY_OPTION_NAME = "RML";	
		
		std::string resent_models = Core::RegistryHelper::get_option_value (
			Core::RegistryHelper::KEY_CURRENT_USER
			, REGISTRY_KEY_PATH
			, REGISTRY_OPTION_NAME
			, "@new@"
		);

		GCL::StrVector rml;

		if (resent_models == "@new@") {
			for (int i = 1; i <= 4; i++) {
				std::string buf ("File");
				buf += boost::lexical_cast<std::string> (i);
				
				std::string rose_rfl = Core::RegistryHelper::get_option_value (
					Core::RegistryHelper::KEY_CURRENT_USER
					, "SOFTWARE\\Rational Software\\Rose\\Recent File List"
					, buf.c_str ()
					, ""
				);
				if (rose_rfl != "") {
					rml.push_back (rose_rfl);
				}

				resent_models = GCL::join (rml, ",");

				Core::RegistryHelper::set_option_value (
					Core::RegistryHelper::KEY_CURRENT_USER
					, REGISTRY_KEY_PATH
					, REGISTRY_OPTION_NAME
					, resent_models
				);
			}
		} else {
			rml = GCL::split_string_by(resent_models.data(), ',');		
		}
		
		for (GCL::StrVector::iterator it = rml.begin(); it != rml.end(); it++) {
			m_rml_box.add_item (*it);
		}

		{
			MdaTemplates mda_tpl = get_mda_templates();
			for (MdaTemplates::iterator it = mda_tpl.begin(); it != mda_tpl.end(); it++) {
				m_mda_box.add_item (it->first);
			}
		}
		//#UC END# *457415F60222_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"MdaStart\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int MdaStart::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return WinGUI::ETSLayoutDialog::OnCreate (create_struct);
}

void MdaStart::init_constraint () {
	//#UC START# *457415F60222_CUSTOM_CONTROLS_CONSTRAINT*
	CreateRoot(VERTICAL)
		<<	(pane ( HORIZONTAL, ABSOLUTE_VERT )
				<< item ( IDC_STATIC1, NORESIZE )
				<< itemGrowing (HORIZONTAL)
				<< item ( IDC_BUTTON1, NORESIZE )
		)
		<< item ( IDC_RML, GREEDY )
		<< item ( IDC_STATIC2, NORESIZE )
		<< item ( IDC_MDA, GREEDY )		
		<<	(pane ( HORIZONTAL, ABSOLUTE_VERT )
				<< itemGrowing (HORIZONTAL)
				<< item( IDOK, NORESIZE )
				<< item( IDCANCEL, NORESIZE )
		);	
	//#UC END# *457415F60222_CUSTOM_CONTROLS_CONSTRAINT*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

