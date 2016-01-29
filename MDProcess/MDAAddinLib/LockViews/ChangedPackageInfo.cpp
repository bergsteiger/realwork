////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/LockViews/ChangedPackageInfo.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::LockViews::ChangedPackageInfo
//
// диалог для отображения изменных другим пользователем пакетов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/LockViews/ChangedPackageInfo.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupportFactories.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"

//#UC START# *4732CB080290_CUSTOM_INCLUDES*
#include <algorithm>
#include <boost/functional/hash/hash.hpp>
//#UC END# *4732CB080290_CUSTOM_INCLUDES*


//#UC START# *4732CB080290*
struct InfoPredicate {
	InfoPredicate (const ChangedPackageInfo::Info& info) 
		: m_info (info)
	{
	}

	bool operator () (const ChangedPackageInfo::Info& info) {
		return m_info.package_guid == info.package_guid;
	}
	const ChangedPackageInfo::Info& m_info;
};

void ChangedPackageInfo::on_custom_draw_list (NMHDR *pNMHDR, LRESULT *pResult) {
	
	NMLVCUSTOMDRAW* pLVCD = reinterpret_cast<NMLVCUSTOMDRAW*>(pNMHDR);

    // Take the default processing unless we set this to something else below.
    *pResult = CDRF_DODEFAULT;

    // First thing - check the draw stage. If it's the control's prepaint
    // stage, then tell Windows we want messages for every item.

    if (CDDS_PREPAINT == pLVCD->nmcd.dwDrawStage) {
        *pResult = CDRF_NOTIFYITEMDRAW;
	} else if (CDDS_ITEMPREPAINT == pLVCD->nmcd.dwDrawStage) {
        // This is the prepaint stage for an item. Here's where we set the
        // item's text color. Our return value will tell Windows to draw the
        // item itself, but it will use the new color we set here.
        // We'll cycle the colors through red, green, and light blue.
		long red_count = pLVCD->nmcd.hdr.idFrom
			== IDC_LOCKED_INFO_LIST 
			? m_new_locked
			: m_new_unlocked;
		
		if ((long)pLVCD->nmcd.dwItemSpec <= red_count) {
			 pLVCD->clrText = RGB(255,0,0);
		}
        // Tell Windows to paint the control itself.
        *pResult = CDRF_DODEFAULT;
	}
}
//#UC END# *4732CB080290*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
ChangedPackageInfo::Info::Info (
	const std::string& package_guid_
	, const std::string& user_name_
	, const std::string& time_
	, ChangeStatus status_
)
//#UC START# *4733E1300119_INIT_CTOR_BASE_INIT*
	: package_guid (package_guid_)
	, user_name (user_name_)
	, time (time_)
	, status (status_)
//#UC END# *4733E1300119_INIT_CTOR_BASE_INIT*
{
	//#UC START# *4733E1300119_INIT_CTOR*
	//#UC END# *4733E1300119_INIT_CTOR*
}
ChangedPackageInfo::Info::Info (const Info& copy) 
//#UC START# *4733E1300119_COPY_CTOR_BASE_INIT*
	: package_guid (copy.package_guid)
	, user_name (copy.user_name)
	, time (copy.time)
	, status (copy.status)
//#UC END# *4733E1300119_COPY_CTOR_BASE_INIT*
{
	//#UC START# *4733E1300119_COPY_CTOR*
	//#UC END# *4733E1300119_COPY_CTOR*
}

ChangedPackageInfo::Info& ChangedPackageInfo::Info::operator = (const Info& copy) {
	//#UC START# *4733E1300119_ASSIGN_OP*
	package_guid = copy.package_guid;
	user_name = copy.user_name;
	time = copy.time;
	status = copy.status;
	//#UC END# *4733E1300119_ASSIGN_OP*
	return *this;
}


// сообщения обрабытваемые окном
const unsigned long ChangedPackageInfo::WM_SHOW_INFO = WM_USER + 100; // показать диалог
const unsigned long ChangedPackageInfo::WM_ADD_INFO = WM_USER + 101; // сообщение о добавлении информации в диалог

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ChangedPackageInfo::ChangedPackageInfo ()
	: WinGUI::ETSLayoutDialog (ChangedPackageInfo::IDD)
//#UC START# *4732CB080290_CTOR_BASE_INIT*
	, m_new_locked (-1)
	, m_new_unlocked (-1)
	, m_is_showed (false)
//#UC END# *4732CB080290_CTOR_BASE_INIT*
{
	//#UC START# *4732CB080290_CTOR*
	m_git.CreateInstance (CLSID_StdGlobalInterfaceTable);
	//#UC END# *4732CB080290_CTOR*
}


ChangedPackageInfo::~ChangedPackageInfo () {
	//#UC START# *4732CB080290_DESTR_BODY*
	this->unregister_for_com_marshal ();
	//#UC END# *4732CB080290_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(ChangedPackageInfo, WinGUI::ETSLayoutDialog)
	ON_WM_CREATE()
	//#UC START# *4732CB080290_MESSAGE_MAP*
	ON_NOTIFY (NM_CUSTOMDRAW, IDC_LOCKED_INFO_LIST, on_custom_draw_list)
	ON_NOTIFY (NM_CUSTOMDRAW, IDC_UNLOCKED_INFO_LIST, on_custom_draw_list)
	ON_MESSAGE (WM_ADD_INFO, on_add_info)
	ON_BN_CLICKED(IDOK, on_ok)
	//#UC END# *4732CB080290_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(ChangedPackageInfo, CDialog)

void ChangedPackageInfo::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *4732CB080290_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_LOCKED_INFO_LIST, m_locked_info_list);
	DDX_Control(pDX, IDC_UNLOCKED_INFO_LIST, m_unlocked_info_list);
	//#UC END# *4732CB080290_DO_DATA_EXCHANGE*
}

BOOL ChangedPackageInfo::OnInitDialog () {
	BOOL ret = WinGUI::ETSLayoutDialog::OnInitDialog();
	try {
		//#UC START# *4732CB080290_ON_INIT_DLG*
		GUARD(m_info_mutex);
		
		m_locked_info_list.init ();
		m_unlocked_info_list.init ();

		CRect rect;
		m_unlocked_info_list.GetWindowRect (rect);
		m_unlocked_info_list.InsertColumn (0, "Пакет", LVCFMT_LEFT, (long)(rect.Width ()*0.6));
		m_unlocked_info_list.InsertColumn (1, "Пользователь", LVCFMT_RIGHT, (long)(rect.Width ()*0.15));
		m_unlocked_info_list.InsertColumn (2, "Время", LVCFMT_RIGHT, (long)(rect.Width ()*0.25));

		m_locked_info_list.GetWindowRect (rect);
		m_locked_info_list.InsertColumn (0, "Пакет", LVCFMT_LEFT, (long)(rect.Width ()*0.6));
		m_locked_info_list.InsertColumn (1, "Пользователь", LVCFMT_RIGHT, (long)(rect.Width ()*0.15));
		m_locked_info_list.InsertColumn (2, "Время", LVCFMT_RIGHT, (long)(rect.Width ()*0.25));
		
		m_locked_info_list.set_is_sorting_permited (false);
		m_unlocked_info_list.set_is_sorting_permited (false);

		for (
			VectorInfo::const_iterator it = m_locked_packages.begin ()
			; it != m_locked_packages.end ()
			; ++it
		) {			
			if (add_item_to_list (m_locked_info_list, *it)) {
				
			}			
		}
		
		for (
			VectorInfo::const_iterator it = m_unlocked_packages.begin ()
			; it != m_unlocked_packages.end ()
			; ++it
		) {
			if (add_item_to_list (m_unlocked_info_list, *it)) {
			}
		}
		//#UC END# *4732CB080290_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"ChangedPackageInfo\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int ChangedPackageInfo::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return WinGUI::ETSLayoutDialog::OnCreate (create_struct);
}

void ChangedPackageInfo::init_constraint () {
	//#UC START# *4732CB080290_CUSTOM_CONTROLS_CONSTRAINT*
	CreateRoot (VERTICAL)
	<< item (IDC_STATIC_UNLOCKED, NORESIZE )
	<< item (IDC_UNLOCKED_INFO_LIST, GREEDY)
	<< item (IDC_STATIC_LOCKED, NORESIZE )
	<< item (IDC_LOCKED_INFO_LIST, GREEDY)
	<< (pane ( HORIZONTAL, ABSOLUTE_VERT )
			<< itemGrowing (HORIZONTAL)
			<< item( IDOK, NORESIZE )
	);
	//#UC END# *4732CB080290_CUSTOM_CONTROLS_CONSTRAINT*
}


// добавляем информацию в список
void ChangedPackageInfo::add_info (const Info& info) {
	//#UC START# *4732CC7900FA*
	GUARD(m_info_mutex);
	boost::hash<std::string> hash;	
	size_t package_name_hash = hash (info.package_guid);

	switch (info.status) {
		case CT_LOCK:
			if (
				std::find_if (
					m_locked_packages.begin ()
					, m_locked_packages.end ()
					, InfoPredicate (info)
				) == m_locked_packages.end ()
			) {
				m_new_locked++;
				m_locked_packages.push_back (info);
			}
			break;

		case CT_UNLOCK:
			m_unlocked_packages.push_back (info);
			m_new_unlocked++;

			m_locked_packages.erase (
				std::remove_if (
					m_locked_packages.begin ()
					, m_locked_packages.end ()
					, InfoPredicate (info)
				)
				, m_locked_packages.end ()
			);			
			break;
	}
	if (m_is_showed == true && ::IsWindow (this->GetSafeHwnd ()) == TRUE) {
		this->PostMessage (WM_ADD_INFO, 0, reinterpret_cast<LPARAM> (new Info (info)));
	}/* else {
		switch (info.status) {
			case CT_LOCK:
				m_new_locked++;
				break;
			case CT_UNLOCK:
				m_new_unlocked++;
				break;
		}
	}*/
	//#UC END# *4732CC7900FA*
}

// метод для добавления данных в список
bool ChangedPackageInfo::add_item_to_list (RoseItemList& list, const Info& info) {
	//#UC START# *480424DD035D*
	bool res = false;
	IRoseApplicationPtr app;
	{
		GUARD(m_git_mutex);
		m_git->GetInterfaceFromGlobal (m_current_app_id, __uuidof (IRoseApplication), (void**)&app);
	}

	if (app && app->CurrentModel) {
		IRoseCategoryPtr cat = app->CurrentModel->FindCategoryWithID (info.package_guid.c_str ());
		if (cat) {
			std::string text (" ");
			text += cat->GetName ();
			text += " (";
			text += cat->GetFileName ();
			text += ")";
			GCL::StrVector list_info (3);
			list_info[0] = text;
			list_info[1] = info.user_name;
			list_info[2] = info.time;
			
			list.add_item (cat, list_info);
			/*int img_id = RoseHelper::get_image_index (cat);
			list.InsertItem (0, text.c_str (), img_id);
			list.SetItemText (0, 1, info.user_name.c_str ());
			list.SetItemText (0, 2, info.time.c_str ());
			
			boost::hash<std::string> hash;
			list.SetItemData (0, hash (info.package_guid));*/
			res = true;
		}
	}

	return res;
	//#UC END# *480424DD035D*
}

// Принудительно закрывает диалог
void ChangedPackageInfo::close () {
	//#UC START# *47AA883103A0*
	GUARD(m_info_mutex);
	if (m_is_showed == true && ::IsWindow (this->GetSafeHwnd ()) == TRUE) {
		this->SendMessage (WM_COMMAND, MAKEWPARAM (IDOK, 0), 0);
	}
	//#UC END# *47AA883103A0*
}

// добавляет информацию о пакетах
// l_param содержит указатель на структуру Info, при выходе из обработчика память по этому
// указателю следует очистить
LRESULT ChangedPackageInfo::on_add_info (WPARAM w_param, LPARAM l_param) {
	//#UC START# *476280D80223*
	Core::Aptr<Info> info = reinterpret_cast<Info*>(l_param);
	if (info.is_nil () == false) {
		switch (info->status) {
			case CT_LOCK:
				if (
					::IsWindow(m_locked_info_list)
				) {
					if (add_item_to_list (m_locked_info_list, *info.ptr ())) {
						//m_new_locked++;
					}					
				}
				break;

			case CT_UNLOCK:
				if (
					::IsWindow(m_unlocked_info_list)
				) {
					boost::hash<std::string> hash;	
					size_t package_name_hash = hash (info->package_guid);
					//CListCtrl& list = m_locked_info_list;
					for (long i = 0; i < (long)m_locked_info_list.GetItemCount (); ++i) {
						IRoseElementPtr elem = m_locked_info_list.get_item (i);
						std::string elem_guid = get_rose_element_uid(elem);
						if (elem_guid == info->package_guid) {
							m_new_locked--;
							m_locked_info_list.delete_item (i);
						}
					}
					if (add_item_to_list (m_unlocked_info_list, *info.ptr ())) {
						//m_new_unlocked++;
					}
				}
				break;
		}
	}
	return S_OK;
	//#UC END# *476280D80223*
}

// обработчик нажатия кнопки OK
void ChangedPackageInfo::on_ok () {
	//#UC START# *47330BC703B9*
	m_new_locked = -1;
	m_new_unlocked = -1;
	WinGUI::ETSLayoutDialog::OnOK ();
	//#UC END# *47330BC703B9*
}

// регистрирует интерфейс для комовского маршалинга, нужно для вывзова
// из не майн потока, в котором крутятся сообщения диалога
void ChangedPackageInfo::register_for_com_marshal (IRoseApplicationPtr app) {
	//#UC START# *480427BE0023*
	GUARD(m_git_mutex);
	m_git->RegisterInterfaceInGlobal (app.GetInterfacePtr (), __uuidof (IRoseApplication), &m_current_app_id);
	//#UC END# *480427BE0023*
}

// показать диалог
void ChangedPackageInfo::show_ () {
	//#UC START# *47330A8D031C*
	bool need_show = false;
	{
		GUARD(m_info_mutex);
		if (m_is_showed == false) {
			need_show = true;
			m_is_showed = true;
		}
	}
	if (need_show) {
		this->DoModal ();
		{
			GUARD(m_info_mutex);
			m_is_showed = false;
		}
	}
	//#UC END# *47330A8D031C*
}

// дерегестрирует интерфейс из глобальной таблицы
void ChangedPackageInfo::unregister_for_com_marshal () {
	//#UC START# *480428390312*
	GUARD(m_git_mutex);
	m_git->RevokeInterfaceFromGlobal (m_current_app_id);
	m_current_app_id = 0;
	//#UC END# *480428390312*
}
//////////////////////////////////////////////////////////////////////////////////////////
// oneway methods impl
struct ShowParams_ {
	ChangedPackageInfo* self;
	ShowParams_ (ChangedPackageInfo* self_) : self(self_) {
	}
};

void ChangedPackageInfo::thr_show_ (void* arg) {
	try {
		Core::Aptr<ShowParams_> arg_ (reinterpret_cast<ShowParams_*>(arg));
		arg_->self->show_ ();
	} catch (Core::Exception& ex) {
		LOG_SEX ((ex, "while execute ChangedPackageInfo::show oneway function"));
	} catch (...) {
		LOG_UEX (("while execute ChangedPackageInfo::show oneway function"));
	}
}

/*oneway*/ Core::ThreadHandle ChangedPackageInfo::show () {
	Core::Aptr<ShowParams_> arg = new ShowParams_ (this);
	Core::ThreadHandle ret = Core::ThreadPoolFactory::def().spawn_thread (
		reinterpret_cast<ACE_THR_FUNC> (ChangedPackageInfo::thr_show_), arg.in ()
	);
	if (ret == 0) {
		throw; //CantSpawnThread ();
	} else {
		arg.forget ();
	}
	return ret;
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

