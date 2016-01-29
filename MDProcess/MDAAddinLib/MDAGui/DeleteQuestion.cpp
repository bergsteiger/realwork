////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/MDAGui/DeleteQuestion.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::MDAGui::DeleteQuestion
//
// дилог-вопрос об удалении элемента
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/MDAGui/DeleteQuestion.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// элемент, подлежащий удалению.
DeleteQuestion::DeleteQuestion (IRoseElementPtr elem) : WinGUI::ETSLayoutDialog (DeleteQuestion::IDD)
//#UC START# *490AFFED03DE_BASE_INIT*
	, m_elem (elem)
//#UC END# *490AFFED03DE_BASE_INIT*
{
	//#UC START# *490AFFED03DE_BODY*
	//#UC END# *490AFFED03DE_BODY*
}

DeleteQuestion::~DeleteQuestion () {
	//#UC START# *490AFE1C0135_DESTR_BODY*
	//#UC END# *490AFE1C0135_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(DeleteQuestion, WinGUI::ETSLayoutDialog)
	ON_WM_CREATE()
	//#UC START# *490AFE1C0135_MESSAGE_MAP*
	//#UC END# *490AFE1C0135_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(DeleteQuestion, CDialog)

void DeleteQuestion::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *490AFE1C0135_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_ADDITIONAL_LIST, m_additional);
	//#UC END# *490AFE1C0135_DO_DATA_EXCHANGE*
}

BOOL DeleteQuestion::OnInitDialog () {
	BOOL ret = WinGUI::ETSLayoutDialog::OnInitDialog();
	try {
		//#UC START# *490AFE1C0135_ON_INIT_DLG*
		std::string caption ("Удаление элемента ");
		caption += m_elem->IdentifyClass ();
		
		this->SetWindowText (caption.c_str ());
		CWnd* message_wnd = this->GetDlgItem (IDC_MESSAGE);
		if (message_wnd) {
			std::string text ("Вы уверены, что хотите удалить элемент ");
			text += RoseHelper::get_full_name (m_elem);
			text += "?";
			message_wnd->SetWindowText (text.c_str ());

			// определяем текущий шрифт списка 
			CFont* font = message_wnd->GetFont(); 

			// создаем контекст для измерения ширины строк 
			CClientDC dc (this); 
			font = dc.SelectObject(font);
			
			SIZE size = dc.GetTextExtent(text.c_str (), text.size ());
			CRect wnd_rect;
			message_wnd->GetWindowRect (&wnd_rect);
			if (wnd_rect.Width () < size.cx) {
				UINT flags = SWP_NOZORDER | SWP_NOACTIVATE;
				message_wnd->SetWindowPos(
					0
					, wnd_rect.left
					, wnd_rect.top
					, size.cx
					, wnd_rect.Height ()
					, flags
				);
			}
			//message_wnd
		}

		this->fill_additional ();
		//#UC END# *490AFE1C0135_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"DeleteQuestion\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int DeleteQuestion::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return WinGUI::ETSLayoutDialog::OnCreate (create_struct);
}

void DeleteQuestion::init_constraint () {
	//#UC START# *490AFE1C0135_CUSTOM_CONTROLS_CONSTRAINT*
	
	CPane buttons = pane (HORIZONTAL, ABSOLUTE_VERT)
		<< itemGrowing (HORIZONTAL)
		<< item (IDOK, NORESIZE)
		<< item (IDCANCEL, NORESIZE);
	
	if (m_additional.GetItemCount () > 0) {
		CPane additional = pane( VERTICAL )
			<< item (IDC_ADDITIONAL_MESS, ABSOLUTE_VERT)
			<< item (IDC_ADDITIONAL_LIST, GREEDY);

		CreateRoot (VERTICAL)
			<< item (IDC_MESSAGE, ABSOLUTE_VERT)
			<< itemFixed (VERTICAL, 5)
			<< additional
			<< buttons;
	} else {
		CreateRoot (VERTICAL)
			<< item (IDC_MESSAGE, ABSOLUTE_VERT)
			<< itemFixed (VERTICAL, 5)
			<< buttons;
	}
	
	//#UC END# *490AFE1C0135_CUSTOM_CONTROLS_CONSTRAINT*
}


// заполнит список дополнительных элементов.
void DeleteQuestion::fill_additional () {
	//#UC START# *490B002B00D1*	
	//заполняем список	

	IRoseCategoryPtr elem_cat = RoseHelper::get_parent_category (m_elem);
	std::string elem_cat_guid = get_rose_element_uid(elem_cat);

	IRoseItemCollectionPtr clients = RoseHelper::get_clients (m_elem);
	RoseElementSet from_other_packs;
	
	short clients_count = clients->Count;
	for (short i = 1; i <= clients_count; ++i) {
		IRoseItemPtr it = clients->GetAt (i);
		IRoseCategoryPtr it_cat = RoseHelper::get_parent_category (it);
		if (get_rose_element_uid(it_cat) != elem_cat_guid) {
			from_other_packs.insert (RoseElementWrapper (it));
		}
	}
	if (!from_other_packs.empty ()) {				
		CWnd* add_msg_wnd = this->GetDlgItem (IDC_ADDITIONAL_MESS);
		if (add_msg_wnd) {
			add_msg_wnd->SetWindowText ("Дополнительно будут удалены связи из других пакетов:");
		}
		
		m_additional.init ();
		CRect rect;
		m_additional.GetWindowRect (rect);
		m_additional.InsertColumn (0, "Имя", LVCFMT_LEFT, static_cast<long>(rect.Width ()*0.20));
		m_additional.InsertColumn (1, "Тип элемента", LVCFMT_RIGHT, static_cast<long>(rect.Width ()*0.30));		
		m_additional.InsertColumn (2, "Клиент", LVCFMT_RIGHT, static_cast<long>(rect.Width ()*0.50));		

		GCL::StrVector info;
		RoseElementSet::const_iterator it = from_other_packs.begin ();
		RoseElementSet::const_iterator it_end = from_other_packs.end ();

		for (; it != it_end; ++it) {
			info.clear ();
			IRoseElementPtr elem = it->element;
			if (!elem->IsClass ("Diagram")) {
				if (elem->IsClass("Association")) {
					elem = RoseHelper::get_role ((IRoseAssociationPtr)elem);
				}

				info.push_back (static_cast<const char*> (elem->GetName ()));
				if (elem->IsClass ("Role")) {
					info.push_back (ATTRIBUTE_TYPE);
				} else {
					info.push_back (static_cast<const char*> (elem->IdentifyClass ()));
				}				

				std::string client_name;
				if (elem->IsClass ("Relation")) {
					IRoseElementPtr parent = RoseHelper::get_context (elem);
					if (parent) {
						client_name = static_cast<const char*> (parent->GetName ());
					}
				}

				info.push_back (client_name);
				m_additional.add_item (elem, info);
			}
		}

		RoseItemList::SortParam param;
		param.primary_column_id = 1;
		param.secondary_column_id = 0;		
		m_additional.sort (param);

	} else {
		CWnd* add_msg_wnd = this->GetDlgItem (IDC_ADDITIONAL_MESS);
		if (add_msg_wnd) {
			add_msg_wnd->ShowWindow (SW_HIDE);
		}
		m_additional.ShowWindow (SW_HIDE);
	}	
	//#UC END# *490B002B00D1*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

