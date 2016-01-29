////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CModelExplorer.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ComServant::Class>> MDProcess::MDAAddinLib::Addin_i::CModelExplorer
// Заголовок реализации класса серванта для интерфеса IModelExplorer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_CMODELEXPLORER_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_CMODELEXPLORER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include "shared/Core/fix/win_afx.h"	
#include "MDProcess/MDAAddinLib/LibHome.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAAddinLib/MDAGui/ATLControls.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/ModelTreeItem.h"
#include "shared/WinGUI/Controls/CImageListEx.h"
#include "MDProcess/MDAAddinLib/impl/WindowsHookImpl/HookHandlerBase.h"
//#UC START# *45B8B8290167_PRE_CUSTOM_INCLUDES*
//#UC END# *45B8B8290167_PRE_CUSTOM_INCLUDES*
#include "MDProcess/MDAAddinLib/Addin/Addin_i.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *45B8B8290167_CUSTOM_INCLUDES*
#include "shared/GCL/data/StaticNode.h"

#include "afxwin.h"
#include "afxcmn.h"

#include <atlctl.h>
//#UC END# *45B8B8290167_CUSTOM_INCLUDES*



class ATL_NO_VTABLE CModelExplorer:
	public ATL::CComObjectRootEx<ATL::CComSingleThreadModel>
	, public ATL::CComCoClass<CModelExplorer, &CLSID_CoIModelExplorer>
	, public ISupportErrorInfo
	, public ATL::IDispatchImpl<IModelExplorer, &IID_IModelExplorer, &LIBID_AddinLib>
	, public ATL::CComControl<CModelExplorer>		
	, public ATL::ISpecifyPropertyPagesImpl<CModelExplorer>
	, public ATL::IPersistStreamInitImpl<CModelExplorer>
	, public ATL::IOleControlImpl<CModelExplorer>
	, public ATL::IOleObjectImpl<CModelExplorer>
	, public ATL::IOleInPlaceActiveObjectImpl<CModelExplorer>
	, public ATL::IViewObjectExImpl<CModelExplorer>
	, public ATL::IOleInPlaceObjectWindowlessImpl<CModelExplorer>
	, public ATL::IProvideClassInfo2Impl<&CLSID_CoIModelExplorer, NULL>		
	, public ATL::IObjectSafetyImpl<CModelExplorer, INTERFACESAFE_FOR_UNTRUSTED_CALLER>
	, virtual public WindowsHookImpl::HookHandlerBase
{
	SET_OBJECT_COUNTER (CModelExplorer)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// мапа uid->элемент дерева
	typedef std::map < std::string, ATLControls::CTreeItem > TreeItemMap;

	// идентификаторы таймеров
	static const unsigned long SCROLL_TIMER_ID; // таймер для прокрутки
	static const unsigned long EXPAND_TIMER_ID; // таймер для разворачивания дерева
	static const unsigned long KEYBOARD_BUFFER_TIMER_ID; // таймер по, которому будет очищаться набранный в дереве текст

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// возвращает целое число, соответствующее порядку сортировки элемента
	static int get_sort_order (IRoseElementPtr item);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:

	CModelExplorer ();

	virtual ~CModelExplorer ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// метод удаляет элемент с модели и, при необходимости (в некоторых случаях из розы не приходит
	// нотификация об удалении элемента) из дерева браузера
	virtual void delete_from_model (IRoseElementPtr elem);

	// возвращает выбранный в дереве элемент
	virtual ATLControls::CTreeItem get_selected_item ();

	// возвращает элемент дерева, соответствущий координатам.
	// \x, y - координаты
	virtual ATLControls::CTreeItem hit_test (long x, long y);

	// формирование дерева бразуера по модели
	virtual void load_tree (IRoseModelPtr model);

	// перемещает элемент из одной ветки в другую
	virtual void move_item (ModelTreeItem* item, ModelTreeItem* new_parent);

	// перемещает элемент в нового родителя  во вью и в данных
	virtual void move_rose_item (IRoseElementPtr item, IRoseElementPtr new_parent);

	// обработчик команд тулбара
	virtual LRESULT on_toolbar_cmd (WORD notify_code, WORD id, HWND ctrl, BOOL& handled);

	// ведляет элемент в дереве, uid - идентификатор элемента, который нужно выдлеить
	virtual void select_item (const std::string& uid);

protected:
	// добавляет элемент в дерево
	// item - добавляемый розовский элемент
	// parent - элемент к которому нужно добавить
	// need_sort - флаг определяет нужно ли пересортировывать дерева после добавления элемента
	virtual ATLControls::CTreeItem add_item (const ModelTreeItem* new_item, const ModelTreeItem* parent, bool need_sort);

private:
	// метод очищает дерево данных, дерево представления
	virtual void clear ();

	// метод копирует элемент со всем его содержимым "в нового родителя"
	virtual void copy_rose_item (IRoseElementPtr item_to_copy, IRoseElementPtr new_parent);

	// метод для создания дочерних контролов
	virtual bool create_child_windows (HWND parent);

	// метод создает невидимое окно (STATIC) на него помещаются все дочерние контролы
	virtual void create_hidden_window ();

	// создает тулбар и связанные с ним ImageList
	virtual void create_toolbar (HWND parent);

	// удаление элемента можели из дерева
	virtual void delete_item (IRoseElementPtr item);

	// метод для поиска элемента дерева по uid
	virtual ModelTreeItem* find_by_uid (const std::string& uid);

	// решает лигитимность цели бросания, находящейся под курсором. Она возвращает пустой элемент,
	// если элемент не может принять бросок, если может - возвращает сам элемент.
	virtual ATLControls::CTreeItem get_drop_target (ATLControls::CTreeItem item);

	// определяет возможность drag'n'drop операции для заданного элемента
	virtual bool is_drop_source (ATLControls::CTreeItem item);

	// метод возвращает true, если окно браузера закрыто, иначе false
	virtual bool is_hide () const;

	// метод загрузки данных дерева во вью
	virtual void load_data_tree ();

	// обработчик нотификации TVN_BEGINDRAG
	virtual LRESULT on_begin_drag (int wParam, LPNMHDR lParam, BOOL& bHandled);

	// обработчик WM_CONTEXTMENU
	virtual LRESULT on_context_menu (UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled);

	// обработчик события "Копирование элемента"
	virtual LRESULT on_copy (WORD notify_code, WORD id, HWND ctrl, BOOL& handled);

	// обработчик события "Вырез элемента"
	virtual LRESULT on_cut (WORD notify_code, WORD id, HWND ctrl, BOOL& handled);

	// обрабочтик события "свернуть/развернуть" элемент дерева
	virtual LRESULT on_expand_collapse_command (WORD notify_code, WORD id, HWND ctrl, BOOL& handled);

	// обработчик события "Ракрыть узел"
	virtual LRESULT on_expanded (int wParam, LPNMHDR lParam, BOOL& bHandled);

	// обработчик TVN_ENDLABELEDIT
	virtual LRESULT on_label_edit (int wParam, LPNMHDR lParam, BOOL& bHandled);

	// обработчик WM_LBUTTONUP
	virtual LRESULT on_lbutton_up (UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled);

	// обработчик сообщения WM_MOUSEMOVE
	virtual LRESULT on_mouse_move (UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled);

	// обработчик события " Вставка элемента"
	virtual LRESULT on_past (WORD notify_code, WORD id, HWND ctrl, BOOL& handled);

	// обработчик сообщения WM_SETFOCUS
	virtual LRESULT on_set_focus (UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled);

	// обрабочтик сообщения WM_SIZE
	virtual LRESULT on_size (UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled);

	// обработчик событий, происходящий по таймеру
	// wParam содержит идентификатор таймера
	virtual LRESULT on_timer (UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled);

	// обработчик клика в дереве
	virtual LRESULT on_tree_click (int wParam, LPNMHDR lParam, BOOL& bHandled);

	// обработчик дабл-клика в дереве
	virtual LRESULT on_tree_dbl_click (UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled);

	// обработчик сообщения WM_KEYUP
	virtual LRESULT on_tree_keyup (UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled);

	// метод ищет в дереве элемент с именем начинающимся на name и подсвечивает его
	virtual bool select_by_name (const std::string& name);

	// функция для пересчета размеров окна
	virtual void size_views ();

	// метод сортирует дерево
	virtual void sort_tree (HTREEITEM from);

	// обновляет дерево навигатора (перечитывает текст элементов)
	virtual void update_tree_view ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// handle of the Bitmap used for faster painting
	HBITMAP m_bmp;

	// true - выделенный элемент подлежит копированию
	// false - выделенный элемент подлежит "вырезанию"
	bool m_copy;

	// флаг определяет перетаскивается ли элемент
	bool m_dragging;

	// курсор, который показывается на элементе кторый может быть целью "бросания"
	HCURSOR m_drop_cursor;

	// всплывающее окно при быстром наборе в дереве
	ATLControls::CToolTipCtrl m_fast_type_tip;

	// handle of the "HiddenWindow"
	HWND m_hidden_window;

	// Indicates, that the Childwindows are created, so we can size them
	bool m_initialized;

	// перетаскиваемый элемент
	ATLControls::CTreeItem m_item_drag;

	// элемент куда перетаскивают
	ATLControls::CTreeItem m_item_drop;

	// элемент жерева помещённый в буфер (с помощью операций Copy или Cut)
	ATLControls::CTreeItem m_item_in_buffer;

	// буфер символов, набранных с клавиатуры
	std::string m_keyboard_buffer;

	// дерево данных
	ModelTreeItem_var m_model_tree;

	// курсор, который показывается на элементе кторый НЕ может быть целью "бросания"
	HCURSOR m_no_drop_cursor;

	// indicates, wether the bitmap must be recreated or not
	bool m_recreate_bitmap;

	ATLControls::CTreeItem m_root_item;

	// показывать или нет стереотипы в дереве навигатора
	bool m_show_stereotypes_in_tree;

	// size of the actual bitmap
	SIZE m_size_bmp;

	unsigned long m_timer_ticks;

	// содержимое всплывающей подсказки при быстром наборе в дереве
	TOOLINFO m_tool_info;

	ATLControls::CToolBarCtrl m_toolbar;

	// ImageList для тулбара
	WinGUI::CImageListEx m_toolbar_image_list;

	// подсказки для тулбара
	ATLControls::CToolTipCtrl m_toolbar_tip;

	TreeItemMap m_tree_map;


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from WindowsHookImpl::IHookHandler
	// функция обработчик сообщений от клавиатуры
	virtual LRESULT keyboard_proc (int code, WPARAM wParam, LPARAM lParam);

//////////////////////////////////////////////////////////////////////////////////////////
// ComServant declaration
public:
	//#UC START# *45B8B8290167REGISTRY_RESOURCEID*
	DECLARE_REGISTRY_RESOURCEID(IDR_GENERATION)
	//#UC END# *45B8B8290167REGISTRY_RESOURCEID*
	DECLARE_PROTECT_FINAL_CONSTRUCT()
	
	BEGIN_COM_MAP(CModelExplorer)
		COM_INTERFACE_ENTRY(IModelExplorer)
		COM_INTERFACE_ENTRY(IDispatch)
		COM_INTERFACE_ENTRY(ISupportErrorInfo)
		COM_INTERFACE_ENTRY(IViewObject)
		COM_INTERFACE_ENTRY(IViewObject2)
		COM_INTERFACE_ENTRY(IViewObjectEx)
		COM_INTERFACE_ENTRY(ISpecifyPropertyPages)
		COM_INTERFACE_ENTRY2(IOleWindow, IOleInPlaceObjectWindowless)
		COM_INTERFACE_ENTRY(IOleInPlaceObject)
		COM_INTERFACE_ENTRY(IOleInPlaceObjectWindowless)
		COM_INTERFACE_ENTRY(IOleInPlaceActiveObject)
		COM_INTERFACE_ENTRY(IOleControl)
		COM_INTERFACE_ENTRY(IOleObject)
		COM_INTERFACE_ENTRY(IPersistStreamInit)
		COM_INTERFACE_ENTRY2(IPersist, IPersistStreamInit)
		COM_INTERFACE_ENTRY(IProvideClassInfo)
		COM_INTERFACE_ENTRY(IProvideClassInfo2)
		COM_INTERFACE_ENTRY(IObjectSafety)
		
	END_COM_MAP()
	
	BEGIN_PROP_MAP(CModelExplorer)
		PROP_DATA_ENTRY("_cx", m_sizeExtent.cx, VT_UI4)
		PROP_DATA_ENTRY("_cy", m_sizeExtent.cy, VT_UI4)
	END_PROP_MAP()
	
	BEGIN_MSG_MAP(CModelExplorer)
		//#UC START# *45B8B8290167MSG_MAP*
		CHAIN_MSG_MAP(CComControl<CModelExplorer>)
		MESSAGE_HANDLER(WM_SIZE, on_size)	
		MESSAGE_HANDLER(WM_SETFOCUS, on_set_focus)		
		MESSAGE_HANDLER(WM_MOUSEMOVE, on_mouse_move)	
		MESSAGE_HANDLER(WM_LBUTTONUP, on_lbutton_up)	
		MESSAGE_HANDLER(WM_CONTEXTMENU, on_context_menu)
		MESSAGE_HANDLER(WM_TIMER, on_timer)		
		
		NOTIFY_CODE_HANDLER(TVN_BEGINDRAG, on_begin_drag)
		NOTIFY_CODE_HANDLER(TVN_ENDLABELEDIT, on_label_edit)		
		NOTIFY_CODE_HANDLER (TVN_ITEMEXPANDED, on_expanded)
		
		COMMAND_ID_HANDLER (ID_EXPAND_COLLAPSE_TREE, on_expand_collapse_command);
		COMMAND_ID_HANDLER (ID_EXPAND_COLLAPSE_ALL_TREE, on_expand_collapse_command);

		COMMAND_ID_HANDLER (ID_RELOAD_TREE, on_toolbar_cmd);
		COMMAND_ID_HANDLER (ID_MDA_SHOW_HIDE_STEREOTYPES, on_toolbar_cmd);		
		COMMAND_ID_HANDLER (ID_MDAGEN_COMMAND, on_toolbar_cmd);
		COMMAND_ID_HANDLER (ID_MDAREP_COMMAND, on_toolbar_cmd);
		COMMAND_ID_HANDLER (ID_MDASRCH_COMMAND, on_toolbar_cmd);
		COMMAND_ID_HANDLER (ID_MDA_VIEW_LOCKED_COMMAND, on_toolbar_cmd);
		COMMAND_ID_HANDLER (ID_MDA_VIEW_ERRORS, on_toolbar_cmd);
		
	ALT_MSG_MAP(1)	
		MESSAGE_HANDLER(WM_KEYUP, on_tree_keyup)
		MESSAGE_HANDLER(WM_LBUTTONDBLCLK, on_tree_dbl_click)
		//#UC END# *45B8B8290167MSG_MAP*
	END_MSG_MAP()
	
	// ISupportsErrorInfo
	STDMETHOD(InterfaceSupportsErrorInfo)(REFIID riid) {
		return S_FALSE;
	}

//#UC START# *45B8B8290167*
public:

DECLARE_CLASSFACTORY_SINGLETON(CModelExplorer)

DECLARE_OLEMISC_STATUS(OLEMISC_RECOMPOSEONRESIZE | 
	OLEMISC_CANTLINKINSIDE | 
	OLEMISC_INSIDEOUT | 
	OLEMISC_ACTIVATEWHENVISIBLE | 
	OLEMISC_SETCLIENTSITEFIRST
)

private:	
	ATL::CContainedWindowT<ATLControls::CTreeViewCtrlEx> m_wndTree;		// window - object		
	//Core::Aptr<CImageList> m_image_list;

public:
	HRESULT OnDraw(ATL_DRAWINFO& di);
	
	virtual HWND Create(HWND hWndParent, RECT& rcPos, LPCTSTR szWindowName = NULL,
						DWORD dwStyle = WS_CHILD | WS_VISIBLE, DWORD dwExStyle = 0,
						UINT nID = 0);	
	
	static int CALLBACK compare_tree_item (LPARAM par1, LPARAM par2, LPARAM tree_par);

	LRESULT on_update_name (const UINT uMsg, const WPARAM wParam, const LPARAM lParam, BOOL bHandled);	
//IModelExplorer
public:
	STDMETHOD(OnOpenModel)(IRoseApplication* app);
	STDMETHOD(OnNewModelElement)(IRoseApplication* app, IRoseElement* item);
	STDMETHOD(OnModifiedModelElementEx)(IRoseApplication* app, IRoseItem* item, int reason, VARIANT var);
	STDMETHOD(OnDeletedModelElementEx)(IRoseApplication* app, IRoseItem* item, IRoseItem* par);
	STDMETHOD(Clear)();
	STDMETHOD(remove)(IRoseElement* elem);
//#UC END# *45B8B8290167*
}; // class CModelExplorer



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_CMODELEXPLORER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
