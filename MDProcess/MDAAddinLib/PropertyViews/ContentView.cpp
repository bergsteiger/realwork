////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/PropertyViews/ContentView.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Dialog::Class>> MDProcess::MDAAddinLib::PropertyViews::ContentView
//
// Диалог для отображения детей элемента
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/PropertyViews/ContentView.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *47E884C00139_CUSTOM_INCLUDES*
//#UC END# *47E884C00139_CUSTOM_INCLUDES*


//#UC START# *47E884C00139*
//#UC END# *47E884C00139*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// контсруктор
ContentView::ContentView (IRoseElementPtr self) : WinGUI::ETSLayoutDialog (ContentView::IDD)
//#UC START# *47E8853A00B9_BASE_INIT*
	, m_self (self)
//#UC END# *47E8853A00B9_BASE_INIT*
{
	//#UC START# *47E8853A00B9_BODY*
	//#UC END# *47E8853A00B9_BODY*
}

ContentView::~ContentView () {
	//#UC START# *47E884C00139_DESTR_BODY*
	//#UC END# *47E884C00139_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation
BEGIN_MESSAGE_MAP(ContentView, WinGUI::ETSLayoutDialog)
	ON_WM_CREATE()
	//#UC START# *47E884C00139_MESSAGE_MAP*
	ON_BN_CLICKED(IDC_BROWSE, on_browse)	
	//#UC END# *47E884C00139_MESSAGE_MAP*
END_MESSAGE_MAP()

IMPLEMENT_DYNAMIC(ContentView, CDialog)

void ContentView::DoDataExchange(CDataExchange* pDX) {
	CDialog::DoDataExchange(pDX);
	//#UC START# *47E884C00139_DO_DATA_EXCHANGE*
	DDX_Control(pDX, IDC_CHILDS_LIST, m_childs_list);
	//#UC END# *47E884C00139_DO_DATA_EXCHANGE*
}

BOOL ContentView::OnInitDialog () {
	BOOL ret = WinGUI::ETSLayoutDialog::OnInitDialog();
	try {
		//#UC START# *47E884C00139_ON_INIT_DLG*
		m_childs_list.init ();
		CRect rect;
		m_childs_list.GetWindowRect (rect);
		m_childs_list.InsertColumn (0, "Имя", LVCFMT_LEFT, static_cast<long>(rect.Width ()*0.45));
		m_childs_list.InsertColumn (1, "Тип элемента", LVCFMT_RIGHT, static_cast<long>(rect.Width ()*0.25));		
		m_childs_list.InsertColumn (2, "Стереотип", LVCFMT_RIGHT, static_cast<long>(rect.Width ()*0.25));		
		fill_childs_list ();
		
		RoseItemList::SortParam param;
		param.primary_column_id = 1;
		param.secondary_column_id = 0;		
		m_childs_list.sort (param);
		//#UC END# *47E884C00139_ON_INIT_DLG*

		this->init_constraint ();
		UpdateLayout ();

	} catch (...) {
		::MessageBox (
			0
			, "В процессе инициализации диалога \"ContentView\" произошло неизвестное исключение"
			, "Ошибка"
			, MB_ICONEXCLAMATION
		);
		this->EndDialog (IDCANCEL);
	}
	return ret;
}

int ContentView::OnCreate(LPCREATESTRUCT create_struct) {
	this->ModifyStyle (DS_MODALFRAME, WS_THICKFRAME);
	
	return WinGUI::ETSLayoutDialog::OnCreate (create_struct);
}

void ContentView::init_constraint () {
	//#UC START# *47E884C00139_CUSTOM_CONTROLS_CONSTRAINT*
	CreateRoot (VERTICAL)
	<< item (IDC_CHILDS_LIST, GREEDY)
	<< (pane ( HORIZONTAL, ABSOLUTE_VERT )
			<< item( IDC_BROWSE, NORESIZE )
			<< itemGrowing (HORIZONTAL)
			<< item( IDOK, NORESIZE )
	);
	//#UC END# *47E884C00139_CUSTOM_CONTROLS_CONSTRAINT*
}


// заполняет список детей
void ContentView::fill_childs_list () {
	//#UC START# *47E886870033*
	Core::Aptr<RoseElementSet> childs = RoseHelper::get_childs (m_self);
	
	RoseElementSet::iterator it = childs->begin ();
	RoseElementSet::iterator it_end = childs->end ();
	
	GCL::StrVector info;
	for (; it != it_end; ++it) {
		info.clear ();
		if (!it->element->IsClass ("Diagram")) {
			info.push_back (static_cast<const char*> (it->element->GetName ()));
			if (it->element->IsClass ("Role")) {
				info.push_back (ATTRIBUTE_TYPE);
			} else {
				info.push_back (static_cast<const char*> (it->element->IdentifyClass ()));
			}
			if (it->element->IsClass (ROSE_ITEM_TYPE)) {
				IRoseItemPtr item = it->element;
				info.push_back (static_cast<const char*> (item->GetStereotype ()));				
			} else {
				info.push_back ("");
			}
			m_childs_list.add_item (it->element, info);
		}
	}	
	//#UC END# *47E886870033*
}

// обработчик нажати на кнопку "Browse" - показывает выбранный в списке элемент на диаграмме
void ContentView::on_browse () {
	//#UC START# *47E88A480194*
	POSITION pos = m_childs_list.GetFirstSelectedItemPosition();
	if (pos != NULL) {
	   int nItem = m_childs_list.GetNextSelectedItem(pos);
	   IRoseElementPtr elem = m_childs_list.get_item (nItem);
	   if (elem) {
		   RoseHelper::browse_item (elem);
	   }
	}
	//#UC END# *47E88A480194*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

