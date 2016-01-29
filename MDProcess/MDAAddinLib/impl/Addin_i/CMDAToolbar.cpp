////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CMDAToolbar.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<ComServant::Class>> MDProcess::MDAAddinLib::Addin_i::CMDAToolbar
//
// реализация интерйеса IMDAToolbar
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/LibHome.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CMDAToolbar.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/ATLControls.h"
#include "MDProcess/MDAAddinLib/MDACommands/MDACmdManager.h"

//#UC START# *45B5C72202AF_CUSTOM_INCLUDES*
//#UC END# *45B5C72202AF_CUSTOM_INCLUDES*


//#UC START# *45B5C72202AF*
//#UC END# *45B5C72202AF*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CMDAToolbar::~CMDAToolbar () {
	//#UC START# *45B5C72202AF_DESTR_BODY*
	//#UC END# *45B5C72202AF_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// функция скрывает заголовок контейнера
void CMDAToolbar::hide_container_caption () {
	//#UC START# *45B5DB9F002E*
	this->GetParent ().GetParent ().ModifyStyle (WS_CAPTION,  WS_CHILD | WS_VISIBLE | WS_CLIPCHILDREN | WS_CLIPSIBLINGS);
	this->GetParent ().GetParent ().ModifyStyle (WS_TILED , 0);
	this->GetParent ().GetParent ().ModifyStyle (WS_TILEDWINDOW , 0);
	this->GetParent ().GetParent ().ModifyStyle (WS_THICKFRAME , 0); 
	m_container_caption_show = false;
	//#UC END# *45B5DB9F002E*
}

// обработчик события WM_CREATE
LRESULT CMDAToolbar::on_create (UINT u_msg, WPARAM w_param, LPARAM l_param, BOOL& handled) {
	//#UC START# *45B5D9EB03B9*
	ATL::AtlAxWinInit();		
	DefWindowProc();		

	hide_container_caption ();
	m_toolbar.Create(m_hWnd, NULL, NULL, WS_CHILD |WS_VISIBLE);
	m_toolbar.SetButtonStructSize(sizeof(TBBUTTON));
	m_toolbar.LoadStdImages(IDB_STD_SMALL_COLOR);
	m_toolbar.ModifyStyle (0, TBSTYLE_FLAT | TBSTYLE_TOOLTIPS | TBSTYLE_WRAPABLE | TBSTYLE_AUTOSIZE);
	
	static const char* buttons_command [] = {
		_T ("Свойства элемента")
		, _T ("Запустить генерацию")
		, _T ("Построение отчета")
		, _T ("Поиск")
		, _T ("Список залочек")
	};
	TBBUTTON tbb[5];
	::ZeroMemory(tbb, sizeof(tbb));
	tbb[0].iBitmap = STD_PROPERTIES; 
	tbb[0].idCommand = ID_MDAPROP_COMMAND; 
	tbb[0].fsState = TBSTATE_ENABLED; 
	tbb[0].fsStyle = BTNS_BUTTON;

	tbb[1].iBitmap = STD_PRINT; 
	tbb[1].idCommand = ID_MDAGEN_COMMAND; 
	tbb[1].fsState = TBSTATE_ENABLED; 
	tbb[1].fsStyle = TBSTYLE_BUTTON;

	tbb[2].iBitmap = STD_HELP; 
	tbb[2].idCommand = ID_MDAREP_COMMAND; 
	tbb[2].fsState = TBSTATE_ENABLED; 
	tbb[2].fsStyle = TBSTYLE_BUTTON;

	tbb[3].iBitmap = STD_FIND; 
	tbb[3].idCommand = ID_MDASRCH_COMMAND; 
	tbb[3].fsState = TBSTATE_ENABLED; 
	tbb[3].fsStyle = TBSTYLE_BUTTON;

	tbb[4].iBitmap = STD_PRINTPRE; 
	tbb[4].idCommand = ID_MDA_VIEW_LOCKED_COMMAND; 
	tbb[4].fsState = TBSTATE_ENABLED; 
	tbb[4].fsStyle = TBSTYLE_BUTTON;

	m_toolbar.AddButtons(5, tbb);	
	m_tooltip.Create (m_hWnd);
	m_toolbar.SetToolTips (m_tooltip);
	//m_tooltip.AddTool (m_hWnd, _T ("Test tooltip"));

	for (int i = 0; i < sizeof(buttons_command)/sizeof(buttons_command[0]); i++) {
		RECT temp;
		m_toolbar.GetRect(i, &temp);
		m_tooltip.AddTool (m_toolbar, buttons_command[i], &temp, i + ID_MDAPROP_COMMAND);
	}
	
	m_tooltip.Activate (true);	
	m_toolbar.ShowWindow(SW_SHOW);	
	return 0;
	//#UC END# *45B5D9EB03B9*
}

// обработчик события WM_LBUTTONDBLCLK
LRESULT CMDAToolbar::on_dbl_click (UINT u_msg, WPARAM w_param, LPARAM l_param, BOOL& handled) {
	//#UC START# *45B5DCB3001F*
	if (m_container_caption_show) {
		hide_container_caption ();
	} else {
		show_container_caption ();
	}			
	return 1;
	//#UC END# *45B5DCB3001F*
}

// обработчик нажатия кнопки тулбара: вызывает дилог генерации выделенного
// элемента на модели (если выделенного элемента нет - генерация
// запускается для рута)
LRESULT CMDAToolbar::on_mda_generate (WORD notify_code, WORD id, HWND ctrl, BOOL& handled) {
	//#UC START# *45B5DB4302FD*
	IRoseApplicationPtr rose_app = RoseHelper::rose_app ();
	if (rose_app) {		
		try {		
			IRoseItemCollectionPtr sel_items = rose_app->CurrentModel->GetSelectedItems();
			IRoseItemPtr item;			
			if (sel_items->Count) {
				item = sel_items->GetAt (1);
			} else {
				item = rose_app->CurrentModel->GetRootCategory ();
			}
			MDACmdManager::instance ()->generate (item);
		} catch (...) {
			::MessageBox (0, "Во время генерации кода произашло не обработанное исключение", "Ошибка", MB_OK|MB_ICONEXCLAMATION );
		}

	}
	return 1;
	//#UC END# *45B5DB4302FD*
}

// обработчик нажатия кнопки тулбара: вызывает дилог свойств выделенного
// элемента на модели (если выделенного элемента нет - свойства показываются
// для рута)
LRESULT CMDAToolbar::on_mda_property (WORD notify_code, WORD id, HWND ctrl, BOOL& handled) {
	//#UC START# *45B5DA9F031C*
	IRoseApplicationPtr rose_app = RoseHelper::rose_app ();
	if (rose_app) {		

		IRoseItemCollectionPtr sel_items = rose_app->CurrentModel->GetSelectedItems();
		IRoseItemPtr item;		
		if (sel_items->Count) {
			item = sel_items->GetAt (1);
		} else {
			item = rose_app->CurrentModel->GetRootCategory ();
		}
		MDACmdManager::instance ()->properties (item, false);

	}
	return 1;
	//#UC END# *45B5DA9F031C*
}

// обработчик нажатия кнопки тулбара: вызывает дилог построения отчета
// выделенного элемента на модели (если выделенного элемента нет
// - отчет строится для рута)
LRESULT CMDAToolbar::on_mda_report (WORD notify_code, WORD id, HWND ctrl, BOOL& handled) {
	//#UC START# *45B5DB58029F*
	IRoseApplicationPtr rose_app = RoseHelper::rose_app ();
	if (rose_app) {
		IRoseItemCollectionPtr sel_items = rose_app->CurrentModel->GetSelectedItems();
		IRoseItemPtr item;		
		if (sel_items->Count) {
			item = sel_items->GetAt (1);
		} else {
			item = rose_app->CurrentModel->GetRootCategory ();
		}
		MDACmdManager::instance ()->view_reports (item);
	}
	return 1;
	//#UC END# *45B5DB58029F*
}

// обработчик нажатия кнопки тулбара: вызывает дилог поиска выделенного
// элемента на модели (если выделенного элемента нет - поиск для
// рута)
LRESULT CMDAToolbar::on_mda_search (WORD notify_code, WORD id, HWND ctrl, BOOL& handled) {
	//#UC START# *45B5DB6B004E*
	IRoseApplicationPtr rose_app = RoseHelper::rose_app ();
	if (rose_app) {
		IRoseItemCollectionPtr sel_items = rose_app->CurrentModel->GetSelectedItems();
		IRoseItemPtr item;		
		if (sel_items->Count) {
			item = sel_items->GetAt (1);
		} else {
			item = rose_app->CurrentModel->GetRootCategory ();
		}
		MDACmdManager::instance ()->search (item);
	}
	return 1;
	//#UC END# *45B5DB6B004E*
}

// обработчик команды ID_MDA_VIEW_LOCKED_COMMAND
LRESULT CMDAToolbar::on_view_locked (WORD notify_code, WORD id, HWND ctrl, BOOL& handled) {
	//#UC START# *4638611302DE*
	MDACmdManager::instance ()->show_locked ();
	return S_OK;
	//#UC END# *4638611302DE*
}

// функция показывает заголовок контейнера
void CMDAToolbar::show_container_caption () {
	//#UC START# *45B5DBC301B5*
	this->GetParent ().GetParent ().ModifyStyle (0, WS_CAPTION | WS_CHILD | WS_VISIBLE | WS_CLIPCHILDREN | WS_CLIPSIBLINGS | WS_TILED | WS_TILEDWINDOW);			
	this->GetParent ().GetParent ().ModifyStyle (WS_THICKFRAME , 0); 
	m_container_caption_show = true;
	//#UC END# *45B5DBC301B5*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

