////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/Contents.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::PropertyViews::Contents
//
// дилог, показывающий содержмое элемента -  атрибуты элемента, операции и т.д
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/PropertyViews/Contents.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAAddinLib/PropertyViews/ItemPropertySheet.h"

//#UC START# *4573E7D70290_CUSTOM_INCLUDES*
//#UC END# *4573E7D70290_CUSTOM_INCLUDES*


//#UC START# *4573E7D70290*
void Contents::fill_dlg () {
	m_contents_list.DeleteAllItems();
	IRoseRolePtr rol = (IRoseRolePtr)m_item;
	if (rol) {
		IRoseAttributeCollectionPtr keys = rol->Keys;
		for (int i = 1; i < keys->Count + 1; i++) {		
			IRoseAttributePtr key = keys->GetAt(i);
			m_contents_list.InsertItem (i-1, (const char*)key->Name);		
			m_contents_list.SetItemText (i-1, 1, (const char*)key->Type);

			std::string str;
			std::string lt = RoseHelper::get_link_type(key).data();
			if (lt == "lnk") {
				str = "Link";
			} else if (lt == "agr") {
				str = "Agrigation";
			} if (lt == "ref") {
				str = "Reference";
			}
			m_contents_list.SetItemText (i-1, 2, str.data());
		}
	
		if (m_contents_list.GetItemCount() > 0) {
			m_contents_list.SetSelectionMark (0);
			m_contents_list.SetItemState (0, LVIS_SELECTED, LVIS_SELECTED);
			m_contents_list.EnsureVisible(0, false);
		}
	}
}

void Contents::OnBnClickedOk() {
	OnOK();
}

void Contents::OnBnClickedButton2() {
	int selection = m_contents_list.GetSelectionMark();
	if (selection >= 0) {
		IRoseRolePtr rol = (IRoseRolePtr)m_item;
		IRoseAttributeCollectionPtr keys = rol->Keys;
		IRoseAttributePtr key = keys->GetAt(selection + 1);

		rol->DeleteKey (key);	
	}

	this->fill_dlg ();
}

void Contents::OnBnClickedButton1() {
	IRoseRolePtr rol = (IRoseRolePtr)m_item;
	IRoseAttributePtr key;
	if (rol) {
		key = rol->AddKey("NewKey", "?");
		RoseHelper::set_link_type(key, "agr");
	} else {
		return;
	}

	this->fill_dlg ();
}

void Contents::OnNMDblclkList1(NMHDR *pNMHDR, LRESULT *pResult)
{
	int selection = m_contents_list.GetSelectionMark();
	if (selection >= 0) {
		IRoseRolePtr rol = (IRoseRolePtr)m_item;
		IRoseAttributeCollectionPtr keys = rol->Keys;
		IRoseAttributePtr key = keys->GetAt(selection + 1);

		if (ItemPropertySheet::execute(key, false, false)) {
			this->fill_dlg ();
		}
	}

	*pResult = 0;
}
//#UC END# *4573E7D70290*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Contents::Contents (IRoseItemPtr item) : CDialog (Contents::IDD)
//#UC START# *458E8EF10141_BASE_INIT*
	, m_item (item)
//#UC END# *458E8EF10141_BASE_INIT*
{
	//#UC START# *458E8EF10141_BODY*
	//#UC END# *458E8EF10141_BODY*
}

Contents::~Contents () {
	//#UC START# *4573E7D70290_DESTR_BODY*
	//#UC END# *4573E7D70290_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(Contents, CDialog)
	//#UC START# *4573E7D70290_MESSAGE_MAP*
	ON_BN_CLICKED(IDOK, OnBnClickedOk)
	ON_BN_CLICKED(IDC_BUTTON2, OnBnClickedButton2)
	ON_BN_CLICKED(IDC_BUTTON1, OnBnClickedButton1)
	ON_NOTIFY(NM_DBLCLK, IDC_LIST1, OnNMDblclkList1)
	//#UC END# *4573E7D70290_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(Contents, CDialog)

void Contents::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *4573E7D70290_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_LIST1, m_contents_list);
	//#UC END# *4573E7D70290_DO_DATA_EXCHANGE*
}

BOOL Contents::OnInitDialog () {
	BOOL ret = CDialog::OnInitDialog();
	try {
		//#UC START# *4573E7D70290_ON_INIT_DLG*
		m_contents_list.InsertColumn (0, "Name", LVCFMT_LEFT, 90 );
		m_contents_list.InsertColumn (1, "Type", LVCFMT_LEFT, 90 );
		m_contents_list.InsertColumn (2, "Link type", LVCFMT_LEFT, 90 );

		this->fill_dlg();
		//#UC END# *4573E7D70290_ON_INIT_DLG*
	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"Contents\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

