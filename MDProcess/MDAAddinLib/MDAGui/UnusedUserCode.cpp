////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/UnusedUserCode.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::UnusedUserCode
//
// Дилог показывает список изер-секций, которые "пропали" в результате перегенерации модели.
// Позволяет сохранить юзер-секцию в файл
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/MDAGui/UnusedUserCode.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
#include <fstream>
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"
#include "shared/GCL/str/str_op.h"

//#UC START# *457416890148_CUSTOM_INCLUDES*
//#UC END# *457416890148_CUSTOM_INCLUDES*


//#UC START# *457416890148*
bool has_uc_text(const std::string& uc_txt) {	
	GCL::StrVector res = GCL::split_string_by (uc_txt.c_str(), 10);
	return res.size() > 2;
/*	std::string uc_id;
	char* uc_end;
	const char* uc_begin = uc_txt.data();
	{
		char uc_id_buf [1024];
		sscanf (uc_begin + strlen (USER_CODE_ID_START), "%s", uc_id_buf);
		if (*uc_id_buf == '*') {
			char* end = GCL::find_part_end(uc_id_buf
				, uc_id_buf + strlen (uc_id_buf) - 1
				, '*'
			);
			if (end) {
				*(++end) = 0;
				uc_id = uc_id_buf;
			}
		}		
	}

	std::string uc_end_str = USER_CODE_ID_END + uc_id;
	uc_end = strstr(uc_begin, uc_end_str.c_str());
	
	AbstractDumperBase::UserCode uc (uc_begin + strlen (USER_CODE_ID_START) + uc_id.size(), uc_end);

	std::string::size_type pos;
	char wh_sp [4] = {' ', '\t', 10, 0};
	while ((pos = uc.find_first_of (wh_sp)) != std::string::npos) {
		uc.erase(pos, 1);
	}
	
	return uc.size() != 0;*/
}

void UnusedUserCode::OnSave() {
	
	Core::Aptr<CTooltipListCtrl::SelectedItems> selections = m_unused_uc.get_selected_items ();
	if (selections.ptr () != 0) {
		for (
			CTooltipListCtrl::SelectedItems::iterator it = selections->begin ()
			; it != selections->end ()
			; ++it
		) {
			this->save (*it);
		}
	}
}

void UnusedUserCode::OnSaveAll() {
	//m_unused_uc.SelItemRange(TRUE, 0, m_unused_uc.GetCount());
	//this->OnOK();
	this->save_all ();	
}

void UnusedUserCode::OnSelchangeUcList (NMHDR * pNotifyStruct, LRESULT * result) {
	LPNMITEMACTIVATE lpnmitem = (LPNMITEMACTIVATE) pNotifyStruct;
	int ind = lpnmitem->iItem;
	CString car_str = m_unused_uc.GetItemText(ind, 0);

	GCL::StrVector strs = GCL::split_string_by_sub_string ((LPCTSTR)car_str, " --> ");
	for (
		AbstractDumperBase::UserCode_map_mapGenId::const_iterator it = AbstractDumperBase::uc_begin()
		; it != AbstractDumperBase::uc_end()
		; it++
	) {
		if (it->first == strs[0]) {
			std::string::size_type pos = strs[1].find_first_of (" (");
			std::string id = strs[1].substr (0, pos);
			GCL::StrVector uc_strs = GCL::split_string_by (it->second.find(id)->second.uc.c_str(), '\n');
			char brk[3] = {13,10,0};

			std::string uc_text = GCL::join (uc_strs, brk);

			m_uc_text.SetWindowText(uc_text.c_str());
		}
	}	
}

void UnusedUserCode::Discard() {
	CDialog::OnOK();
}
//#UC END# *457416890148*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

UnusedUserCode::UnusedUserCode ()
	: WinGUI::ETSLayoutDialog (UnusedUserCode::IDD)
//#UC START# *457416890148_CTOR_BASE_INIT*
//#UC END# *457416890148_CTOR_BASE_INIT*
{
	//#UC START# *457416890148_CTOR*
	//#UC END# *457416890148_CTOR*
}


UnusedUserCode::~UnusedUserCode () {
	//#UC START# *457416890148_DESTR_BODY*
	//#UC END# *457416890148_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(UnusedUserCode, WinGUI::ETSLayoutDialog)
	ON_WM_CREATE()
	//#UC START# *457416890148_MESSAGE_MAP*	
	ON_NOTIFY(NM_CLICK, IDC_UC_LIST, OnSelchangeUcList)
//	ON_LBN_SELCHANGE(IDC_UC_LIST, OnSelchangeUcList)
	ON_BN_CLICKED(IDC_SAVE_ALL, OnSaveAll)
	ON_BN_CLICKED(IDC_SAVE, OnSave)
	ON_BN_CLICKED(IDC_BUTTON1, Discard)
	//#UC END# *457416890148_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(UnusedUserCode, CDialog)

void UnusedUserCode::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *457416890148_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_UC_TEXT, m_uc_text);
	DDX_Control(pDX, IDC_UC_LIST, m_unused_uc);
	//#UC END# *457416890148_DO_DATA_EXCHANGE*
}

BOOL UnusedUserCode::OnInitDialog () {
	BOOL ret = WinGUI::ETSLayoutDialog::OnInitDialog();
	try {
		//#UC START# *457416890148_ON_INIT_DLG*
		ret = false;
		m_unused_uc.InsertColumn (0, "", LVCFMT_LEFT);
		for (
			AbstractDumperBase::UserCode_map_mapGenId::const_iterator it = AbstractDumperBase::uc_begin()
			; it != AbstractDumperBase::uc_end()
			; it++
		) {
			for (
				AbstractDumperBase::UserCode_map::const_iterator it2 = it->second.begin()
				; it2 != it->second.end()
				; it2++
			) {
				std::string uc_id = it2->first;
				bool used = it2->second.used;
				if (!it2->second.used && has_uc_text(it2->second.uc)) {
					std::string list_str;
					list_str = it->first + " --> " + it2->first + " (" + it2->second.file_name + ")";					
					//m_unused_uc.AddString (list_str.data());
					m_unused_uc.add_item (list_str);
					ret = true;
				}
			}
		}
		if (!ret) {
			this->EndDialog(0);
		}

		//#UC END# *457416890148_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"UnusedUserCode\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int UnusedUserCode::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return WinGUI::ETSLayoutDialog::OnCreate (create_struct);
}

void UnusedUserCode::init_constraint () {
	//#UC START# *457416890148_CUSTOM_CONTROLS_CONSTRAINT*
	CreateRoot (VERTICAL)
		<< item (IDC_STATIC1, NORESIZE)
		<< item (IDC_UC_LIST, GREEDY)
		<< item (IDC_STATIC2, NORESIZE)
		<< item (IDC_UC_TEXT, GREEDY)
		<< (pane (HORIZONTAL, ABSOLUTE_VERT)
			<< item (IDC_SAVE, NORESIZE)
			<< item (IDC_SAVE_ALL, NORESIZE)
			<< itemGrowing (HORIZONTAL)
			<< item (IDC_BUTTON1, NORESIZE)
			<< item (IDCANCEL, NORESIZE)
		);
	//#UC END# *457416890148_CUSTOM_CONTROLS_CONSTRAINT*
}


// сохраняет юзер-секцию с номером index в списке в отдельный файл
void UnusedUserCode::save (int index) {
	//#UC START# *464A9AB00271*
	//#UC START# *464A96550203*
	CFileDialog f_dlg (false);
	if (f_dlg.DoModal() == IDOK) {
		std::string file_name = (LPCTSTR)f_dlg.GetPathName();
		std::ofstream file (file_name.c_str ());

		if (file) {
			CString car_str = m_unused_uc.GetItemText(index, 0);			
			this->save_uc (file, car_str);

			file.close ();
		}
	}
	//#UC END# *464A9AB00271*
}

// сохраняет все юзер секции из списка в один файл
void UnusedUserCode::save_all () {
	//#UC START# *464A96D001D4*
	CFileDialog f_dlg (false);
	if (f_dlg.DoModal() == IDOK) {
		std::string file_name = (LPCTSTR)f_dlg.GetPathName();
		std::ofstream file (file_name.c_str ());

		if (file) {

			for (int index = 0; index < m_unused_uc.GetItemCount(); ++index) {
				CString car_str = m_unused_uc.GetItemText(index, 0);

				this->save_uc (file, car_str);
			}

			file.close ();
		}
	}
	//#UC END# *464A96D001D4*
}

// записывает юзер-секцию uc в поток
void UnusedUserCode::save_uc (std::ostream& file, const char* uc) {
	//#UC START# *464A96550203*
	GCL::StrVector strs = GCL::split_string_by_sub_string (uc, " --> ");

	ModelSearcher* searcher = &ModelSearcherFactory::get ();
	for (
		AbstractDumperBase::UserCode_map_mapGenId::const_iterator it = AbstractDumperBase::uc_begin()
		; it != AbstractDumperBase::uc_end()
		; it++
	) {
		if (it->first == strs[0]) {
			std::string::size_type pos = strs[1].find_first_of (" (");
			std::string id = strs[1].substr (0, pos);

			GCL::StrVector uc_id = GCL::split_string_by_fragment (id.c_str(), '*', '*');
			std::string guid = uc_id[0];
			guid.erase (12);
			IRoseItemPtr item = searcher->search (guid);
			if (item) {
				file << "!!! ITEM: " << item->GetQualifiedName() << std::endl;						
			} else {
				file << "!!! ITEM: REMOVED (guid: " << guid << ")" << std::endl;						
			}
			file << it->second.find(id)->second.uc << std::endl << std::endl;					
		}
	}	
	//#UC END# *464A96550203*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

