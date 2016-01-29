////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CModelExplorer.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ComServant::Class>> MDProcess::MDAAddinLib::Addin_i::CModelExplorer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/LibHome.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CModelExplorer.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "shared/GCL/data/StaticNodeIterator.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/TreeViewItemIterator.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/TreeViewChildIterator.h"
#include "MDProcess/MDAAddinLib/Commands/Commands.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/MenuHelper.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/MenuFactory.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CmdHandler.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseTreeState.h"
#include "MDProcess/MDAModel/RoseDumpers/ModelStamp.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/Other.h"
#include "MDProcess/MDAModel/RoseDumpers/MDAModelParams.h"
#include "MDProcess/MDAAddinLib/Helpers/Helpers.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"
#include "MDProcess/MDAAddinLib/MDAGui/GenerationErrorDialog.h"

//#UC START# *45B8B8290167_CUSTOM_INCLUDES*
#include <limits>
#include "boost/format.hpp"
#include "boost/algorithm/string/predicate.hpp"

//#UC END# *45B8B8290167_CUSTOM_INCLUDES*


//#UC START# *45B8B8290167*
//static const std::string with_stereotype = "<<%1%>>%2%";

template <class T>
struct set_image_list {	
	void operator () (T& obj, CImageList& list) {
		obj.SetImageList (list);
	}
};

template <class T>
struct set_hot_image_list {	
	void operator () (T& obj, CImageList& list) {
		obj.SetHotImageList (list);
	}
};

template <class T>
struct set_disabled_image_list {	
	void operator () (T& obj, CImageList& list) {
		obj.SetDisabledImageList (list);
	}
};
typedef set_image_list<ATLControls::CToolBarCtrl> toolbar_set_image_list;
typedef set_hot_image_list<ATLControls::CToolBarCtrl> toolbar_set_hot_image_list;
typedef set_disabled_image_list<ATLControls::CToolBarCtrl> toolbar_set_disabled_image_list;

//фнукция устанавливает TrueColor ImageList объекту obj
//для установки листа используется функтор func
//image_bitmap_id - идентификатор ресурса с картинкой
//image_width - размер по оси X одного элемента в ImageList'е
template <class T, class Function>
void set_true_color_images (T& obj, int image_bitmap_id, int image_width, Function& func) {
	CImageList image_list;
	CBitmap bitmap;
	BITMAP bmp;
	if (
		bitmap.Attach (
			LoadImage (
				AfxGetResourceHandle ()
				, MAKEINTRESOURCE(image_bitmap_id)
				, IMAGE_BITMAP
				, 0
				, 0
				, LR_DEFAULTSIZE|LR_CREATEDIBSECTION
			)
		)
		&& bitmap.GetBitmap (&bmp)
	) {
		CSize size (bmp.bmWidth, bmp.bmHeight); 
		int button_number = size.cx/image_width;
		RGBTRIPLE* rgb = (RGBTRIPLE*)(bmp.bmBits);
		COLORREF rgb_mask	= RGB (rgb[0].rgbtRed, rgb[0].rgbtGreen, rgb[0].rgbtBlue);
		if (
			image_list.Create (image_width, size.cy, ILC_COLOR24|ILC_MASK, 9, 0) == TRUE
			&& image_list.Add (&bitmap, rgb_mask) != -1
		) {
			func (obj, image_list);			
			image_list.Detach(); 
			bitmap.Detach();
		}		
	}
}
int CModelExplorer::compare_tree_item (LPARAM par1, LPARAM par2, LPARAM tree_par) {
	//#UC START# *46270CD2030D*
	int res = 0;
	ATL::CContainedWindowT<ATLControls::CTreeViewCtrlEx>* tree_wnd 
		= reinterpret_cast<ATL::CContainedWindowT<ATLControls::CTreeViewCtrlEx>*> (tree_par);
	if (tree_wnd) {
		ModelTreeItem* item1 = reinterpret_cast<ModelTreeItem*> (par1);
		ModelTreeItem* item2 = reinterpret_cast<ModelTreeItem*> (par2);		
		if (item1 && item2) {
			int image_idx1 = CModelExplorer::get_sort_order (item1->get_item ());
			int image_idx2 = CModelExplorer::get_sort_order (item2->get_item ());
			if (image_idx1 == image_idx2) {				
				std::string str1;
				if (item1->get_item_stereotype () != "") {
					str1 = "<<";
					str1 += item1->get_item_stereotype ();
					str1 += ">> ";
				}
				str1 += item1->get_item_name ();
				
				std::string str2;
				if (item2->get_item_stereotype () != "") {
					str2 = "<<";
					str2 += item2->get_item_stereotype ();
					str2 += ">> ";
				}
				str2 += item2->get_item_name ();
				res = strcmp (str1.c_str (), str2.c_str ());
			} else {
				res = image_idx1 - image_idx2;
			}			
		}
	}
	return res;
	//#UC END# *46270CD2030D*
}

// In the Create - function, we have to create the ContainedWindows via their Create - functions
HWND CModelExplorer::Create(HWND hWndParent, RECT& rcPos, LPCTSTR szWindowName, DWORD dwStyle, DWORD dwExStyle, UINT nID)
{
	m_initialized = false;
	m_dragging = false;
	m_drop_cursor = LoadCursor (NULL, IDC_ARROW);
	m_no_drop_cursor = LoadCursor (NULL, IDC_NO);
	HWND hWnd = CWindowImpl<CModelExplorer>::Create (hWndParent, rcPos, szWindowName, dwStyle, dwExStyle, nID);		

	if(hWnd != NULL) {
		//m_tree_menu = create_menu ();
		//this->SetMenu (m_tree_menu);
		m_tree_map.clear ();
		this->create_child_windows (hWnd);		
	}
	m_initialized = true;
	this->size_views ();
	::SetWindowLong(
		m_wndTree
		, GWL_STYLE
		, ::GetWindowLong (m_wndTree, GWL_STYLE) | TVS_EDITLABELS | TVS_NONEVENHEIGHT
	);

	//m_wndTree.ModifyStyle (WS_CHILD, 0);
	return hWnd;
}

// This function does nothing, if the control was instantiated and created. But some containers instantiate controls
// without creating them, and they draw them through the interface IViewObject::Draw. So this is the interisting part of the project
HRESULT CModelExplorer::OnDraw(ATL_DRAWINFO& di)
{
	RECT& rc = *(RECT*)di.prcBounds;

	// we are drawn throug IViewObject?
	if(m_hWnd == 0)
	{
		// was there a resize since the last painting?
		SIZE new_size = {abs(rc.right - rc.left), abs(rc.bottom - rc.top)};

		if((new_size.cx != m_size_bmp.cx) || (new_size.cy != m_size_bmp.cy))
		{
			m_recreate_bitmap = true;
		}

		// should we recreate the Bitmap?
		if(m_recreate_bitmap == true)
		{
			// First, create the Windows, so that they can draw themselves			
			this->create_child_windows (NULL);

			if(m_bmp != NULL)
			{
				::DeleteObject(m_bmp);
				m_bmp = NULL;
			}

			m_recreate_bitmap = false;
			m_size_bmp.cx = new_size.cx;
			m_size_bmp.cy = new_size.cy;

			// Create the Bitmap
			m_bmp = ::CreateCompatibleBitmap(di.hdcDraw, m_size_bmp.cx, m_size_bmp.cy);
			if(m_bmp == NULL) {
				m_recreate_bitmap = true;
				return S_OK;
			}

			POINT pt;
			POINT poiOffset;

			// prepare painting the NonClientArea of the TreeView
			poiOffset.x = ::GetSystemMetrics(SM_CXEDGE) + 1;
			poiOffset.y = ::GetSystemMetrics(SM_CYEDGE) + 1;

			// Select the Bitmap as a drawing >Context
			HDC h_bmp_dc = ::CreateCompatibleDC(di.hdcDraw);
			HBITMAP h_old_bmp = (HBITMAP) ::SelectObject(h_bmp_dc, m_bmp);

			// Position the Windows in the Hidden one
			m_wndTree.SetWindowPos(HWND_TOP, &rc, SWP_NOZORDER);

			::SetViewportOrgEx(h_bmp_dc, poiOffset.x, poiOffset.y, &pt);
			// force The temporary Window to Draw itself and copy it into the Bitmap
			m_wndTree.SendMessage(WM_PAINT, (WPARAM)h_bmp_dc, 0);

			::SetViewportOrgEx(h_bmp_dc, pt.x, pt.y, NULL);
			::DrawEdge(h_bmp_dc, &rc, EDGE_BUMP, BF_RECT);

			::SelectObject(h_bmp_dc, h_old_bmp);
			::DeleteDC(h_bmp_dc);
		}

		// Copy the Bitmap to the Container
		HDC h_bmp_dc = ::CreateCompatibleDC(di.hdcDraw);
		HBITMAP h_old_bmp = (HBITMAP) ::SelectObject(h_bmp_dc, m_bmp);
		
		::BitBlt(di.hdcDraw, rc.left, rc.top, m_size_bmp.cx, m_size_bmp.cy, h_bmp_dc, 0, 0, SRCCOPY);
		::SelectObject(h_bmp_dc, h_old_bmp);
		::DeleteDC(h_bmp_dc);
	}

	return S_OK;
}

STDMETHODIMP CModelExplorer::OnOpenModel (IRoseApplication* app) {
#ifndef GDS_NLOG_DEBUG
	::Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);
#endif
	this->clear ();
	this->load_tree (app->CurrentModel);
	return S_OK;
}

STDMETHODIMP CModelExplorer::OnNewModelElement (IRoseApplication* app, IRoseElement* item) {
	ModelSearcherFactory::get ().on_new_element (item);

	IRoseElementPtr parent;
	std::string parent_uid;
	if (item->IsClass ("ClassDiagram") || item->IsClass ("StateDiagram")) {
		parent = RoseHelper::get_context (item);
	} else if (item->IsClass ("ScenarioDiagram")) {
		IRoseScenarioDiagramPtr sc_diag = item;		
		std::string use_case_uid = sc_diag->GetPropertyValue (TOOL_NAME, "UseCase");
		if (use_case_uid != "") {
			parent_uid = use_case_uid;
		} else {
			parent = sc_diag->GetParentContext ();			
		}				
	} else if (item->IsClass ("Association")) {
		IRoseRolePtr role = ((IRoseAssociationPtr)item)->Role2;
		parent = role->Class;
	} else {
		parent = RoseHelper::get_context (item);
	}
	if (!item->IsClass (PARAMETER_TYPE)) {
		if (parent_uid == "") {
			parent_uid = get_rose_element_uid(parent);
		}
		ModelTreeItem_var parent_item_model = this->find_by_uid (parent_uid);
		ModelTreeItem* new_item_model = new ModelTreeItem (item);
		
		if (parent_item_model.is_nil () == true) {
			//если нету родителя у нового элемента - значит его
			//загружают из ката
			IRoseElementPtr new_parent = parent;
			this->OnNewModelElement (app, new_parent);
			
			ModelTreeItem_var parent_item_model = this->find_by_uid (parent_uid);
			parent_item_model->insert_back_child (new_item_model);
			this->add_item (new_item_model, parent_item_model.in (), true);
		} else {
			parent_item_model->insert_back_child (new_item_model);
			this->add_item (new_item_model, parent_item_model.in (), true);
			
			//if (item->IsClass (CATEGORY_TYPE)) {
			//	IRoseClassDiagramPtr diag = ((IRoseCategoryPtr)item)->AddClassDiagram ("Main");
			//	ModelTreeItem* new_diag = new ModelTreeItem (diag);
			//	new_item_model->insert_back_child (new_diag);
			//	this->add_item (new_diag, new_item_model, true);
			//}
		}
	}
	
	return S_OK;
}

STDMETHODIMP CModelExplorer::OnModifiedModelElementEx (IRoseApplication* app, IRoseItem* item, int reason, VARIANT var) {	
	/*
	1	Name Changed
	2	Language Changed
	3	Cardinality Changed
	4	Aggregation Changed
	5	End Point Changed
	6	Type Changed
	7	Initial Value Changed
	8	Stereotype Changed
	10	Context Changed
	116 Documentation Changed
	*/
	IRoseItemPtr rose_item = item;
	if (reason == 1) {
		std::string text = rose_item->Name;
		std::string name = RoseHelper::extract_name_from_label (text);
		if (name == text && rose_item->IsClass (CATEGORY_TYPE)) {
			//если у папки поменяли букву 'Я' на 'я' - нужно вернуть обратно
			name = GCL::replace_char (name, 'я', 'Я');
		}

		if (name != text) {
			std::string guid = get_rose_element_uid(rose_item);
			char* msg = new char[guid.size () + 1];
			strcpy (msg, guid.c_str ());
			CmdHandler::instance ()->PostMessage (CmdHandler::WM_UNDO_CHANGE_NAME, 0, (LPARAM)msg);
			return S_OK;
		}
	}
	if (reason == 1 || reason == 8) {
		std::string uid = get_rose_element_uid(rose_item);
		ModelTreeItem_var tree_item = find_by_uid (uid);
		if (!tree_item.is_nil ()) {
			if (!this->is_hide ()) {
				tree_item->init (rose_item);
				TreeItemMap::iterator find_it = m_tree_map.find (uid);
				if (find_it != m_tree_map.end ()) {
					std::string text;
					if (m_show_stereotypes_in_tree) {
						if (tree_item->get_item_stereotype () != "") {
							text = "<<";
							text += tree_item->get_item_stereotype ();
							text += ">> ";
						}						
						text += tree_item->get_item_name ();						
					} else {
						text = tree_item->get_item_name ();
					}
					find_it->second.SetText (text.c_str ());
					int image_idx = RoseHelper::get_image_index (item);
					find_it->second.SetImage (image_idx, image_idx);
					ATLControls::CTreeItem for_sort = find_it->second.GetParent ();
					if (for_sort.IsNull ()) {
						this->sort_tree (TVI_ROOT);
					} else {
						this->sort_tree (for_sort);
					}
				}
			}
		}	
	} else if (reason == 5) {
		if (rose_item->IsClass ("Role")) {
			//перемещаем только связи-атрибуты
			IRoseRolePtr role = rose_item;
			IRoseAssociationPtr assoc = role->Association;
			role = RoseHelper::get_role (assoc);
			IRoseElementPtr parent = RoseHelper::get_context (role);
			this->move_rose_item (role, parent);
		}		
	} else if (reason == 6) {
		if (
			rose_item->IsClass (ATTRIBUTE_TYPE)
			|| rose_item->IsClass (PARAMETER_TYPE)
			|| rose_item->IsClass (OPERATION_TYPE)
		) {
			//При изменении типа параметра, атрибута, return-type операции 
			//явно сбрасываем привязку, при следующей генерации свяжется с новым типом
			TypeLinkHelperFactory::get ().unlink (rose_item);
		}
	} else if (reason == 116) {
		//нужно обновить закэшированные значения на дампере
		RoseAbstractDumper* rad = RoseAbstractDumper::find_in_tree (rose_item);
		if (rad) {
			rad->update_cached_attrs ();
		}
	}

	return S_OK;
}

STDMETHODIMP CModelExplorer::OnDeletedModelElementEx (IRoseApplication* app, IRoseItem* item, IRoseItem* par) {
	ModelSearcherFactory::get ().on_delete_element (item);
	this->delete_item (item);
	return S_OK;
}

STDMETHODIMP CModelExplorer::Clear () {
	this->clear ();	
	return S_OK;
}

STDMETHODIMP CModelExplorer::remove (IRoseElement* elem) {
	this->delete_from_model (elem);
	return S_OK;
}
//#UC END# *45B8B8290167*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// идентификаторы таймеров
const unsigned long CModelExplorer::SCROLL_TIMER_ID = 1; // таймер для прокрутки
const unsigned long CModelExplorer::EXPAND_TIMER_ID = 2; // таймер для разворачивания дерева
const unsigned long CModelExplorer::KEYBOARD_BUFFER_TIMER_ID = 3; // таймер по, которому будет очищаться набранный в дереве текст

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// возвращает целое число, соответствующее порядку сортировки элемента
int CModelExplorer::get_sort_order (IRoseElementPtr item) {
	//#UC START# *46270CB400AB*
	int res = INT_MAX;
	if (item->IsClass (CATEGORY_TYPE)) {
		res = 0;
	} else if (item->IsClass (CLASS_TYPE)) {
		res = 10;
	} else if (item->IsClass (OPERATION_TYPE)) {
		res = 20;
	} else if (item->IsClass (ATTRIBUTE_TYPE)) {
		res = 30;
	} else if (item->IsClass ("Role") && item->Name != _bstr_t ("")) {
		res = 30;
	} else if (item->IsClass (PARAMETER_TYPE)) {
		res = 40;
	} else if (item->IsClass ("ClassDiagram")) {
		res = 50;
	} else if (item->IsClass ("ScenarioDiagram")) {
		res = 60;
	}
	return res;
	//#UC END# *46270CB400AB*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CModelExplorer::CModelExplorer ()
//#UC START# *45D2EC7A01A5_BASE_INIT*
: m_wndTree(_T("SysTreeView32"), this, 1)
//#UC END# *45D2EC7A01A5_BASE_INIT*
{
	//#UC START# *45D2EC7A01A5_BODY*
	m_bWindowOnly = TRUE;
	m_hidden_window = NULL;	
	m_initialized = false;
	m_bmp = NULL;
	m_recreate_bitmap = true;
	m_size_bmp.cx = 0;
	m_size_bmp.cy = 0;	
	m_dragging = false;
	m_show_stereotypes_in_tree = true;	

	CmdHandler::instance ()->set_explorer (this);
	CmdHandler::instance ()->create ();
	//#UC END# *45D2EC7A01A5_BODY*
}

CModelExplorer::~CModelExplorer () {
	//#UC START# *45B8B8290167_DESTR_BODY*
#ifdef _DEBUG
	LOG_D ((GDS_CURRENT_FUNCTION));
#endif
	::DeleteObject(m_bmp);
	::DestroyWindow(m_hidden_window);
	this->clear ();
	//#UC END# *45B8B8290167_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавляет элемент в дерево
// item - добавляемый розовский элемент
// parent - элемент к которому нужно добавить
// need_sort - флаг определяет нужно ли пересортировывать дерева после добавления элемента
ATLControls::CTreeItem CModelExplorer::add_item (
	const ModelTreeItem* new_item
	, const ModelTreeItem* parent
	, bool need_sort
) {
	//#UC START# *45BF264C02DE*
	ATLControls::CTreeItem ret;
	if (parent == 0) {		
	} else if (new_item) {				
		std::string item_uid = new_item->get_item_uid ();
		if (!this->is_hide ()) {
			if (m_tree_map.find (item_uid) == m_tree_map.end ()) {//элемент отсутствует в дереве
				std::string parent_uid = parent->get_item_uid ();
				TreeItemMap::iterator find_it = m_tree_map.find (parent_uid);				
				ModelTreeItem_var temp_parent = ModelTreeItem::_duplicate (const_cast<ModelTreeItem*> (parent));
				while (find_it == m_tree_map.end ()) {
					temp_parent = dynamic_cast<ModelTreeItem*> (temp_parent->parent ());
					if (temp_parent.is_nil ()) {
						break;
					}
					parent_uid = temp_parent->get_item_uid ();
					find_it = m_tree_map.find (parent_uid);
				}
				if (find_it != m_tree_map.end ()) {
					int image_index = RoseHelper::get_image_index (new_item->get_item ());
					if (image_index != -1) {
						std::string text;
						if (m_show_stereotypes_in_tree) {
							if (new_item->get_item_stereotype () != "") {
								text = "<<";
								text += new_item->get_item_stereotype ();
								text += ">> ";
							}
							text += new_item->get_item_name ();
						} else {
							text = new_item->get_item_name ();
						}
						ret = m_tree_map[new_item->get_item_uid ()] = find_it->second.AddTail (
							text.c_str ()
							, image_index
						);
						m_tree_map[new_item->get_item_uid ()].SetData ((DWORD)new_item);
						if (need_sort) {
							this->sort_tree (find_it->second);
						}
					}						
				} else {
					m_root_item = m_wndTree.GetRootItem ();
					int image_index = RoseHelper::get_image_index (new_item->get_item ());					
					if (image_index != -1) {
						std::string text;
						if (m_show_stereotypes_in_tree) {
							if (new_item->get_item_stereotype () != "") {
								text = "<<";
								text += new_item->get_item_stereotype ();
								text += ">> ";
							}
							text += new_item->get_item_name ();
						} else {
							text = new_item->get_item_name ();
						}
						ret = m_tree_map[new_item->get_item_uid ()] = m_wndTree.InsertItem (
							text.c_str ()
							, image_index
							, image_index
							, NULL
							, NULL
						);
						m_tree_map[new_item->get_item_uid ()].SetData ((DWORD)new_item);
						if (need_sort) {
							this->sort_tree (TVI_ROOT);
						}
					}
				}
			}
		}				
	}
	return ret;
	//#UC END# *45BF264C02DE*
}

// метод очищает дерево данных, дерево представления
void CModelExplorer::clear () {
	//#UC START# *45C7098B003E*
	if (!this->is_hide ()) {
		m_wndTree.DeleteAllItems ();
	}
	m_tree_map.clear ();
	GCL::StaticNodeIterator iter (m_model_tree.in ());
	for (
		ModelTreeItem_var found_node = dynamic_cast<ModelTreeItem*> (iter.get_next ())
		; !found_node.is_nil ()
		; found_node = dynamic_cast<ModelTreeItem*> (iter.get_next ())
	) {
		IRoseElementPtr elem = found_node->get_item ();
		ModelSearcherFactory::get ().on_delete_element (elem);
		found_node->set_item (0);
	}
	if (!m_model_tree.is_nil ()) {
		//m_model_tree->clear_children ();
		m_model_tree = 0;
	}		
	//#UC END# *45C7098B003E*
}

// метод копирует элемент со всем его содержимым "в нового родителя"
void CModelExplorer::copy_rose_item (IRoseElementPtr item_to_copy, IRoseElementPtr new_parent) {
	//#UC START# *45D552B80232*	
	IRoseElementPtr new_element;
	if (new_parent->IsClass (CATEGORY_TYPE)) {			
		if (item_to_copy->IsClass (CATEGORY_TYPE)) {
			IRoseCategoryPtr cat = item_to_copy;
			new_element = ((IRoseCategoryPtr)new_parent)->AddCategory (item_to_copy->GetName ());
			((IRoseCategoryPtr)new_element)->Documentation = cat->Documentation;
			((IRoseCategoryPtr)new_element)->Stereotype = cat->Stereotype;
			IRosePropertyCollectionPtr props = cat->GetAllProperties ();
			short count = props->Count;
			for (short i = 1; i < count + 1; i++) {
				IRosePropertyPtr prop = props->GetAt (i);
				RoseHelper::override_property (new_element, prop->GetToolName (), prop->GetName (), prop->GetValue ());
			}

			IRoseCategoryCollectionPtr categories = cat->Categories;
			count = categories->Count;
			for (short i = 1; i < count + 1; i++) {
				IRoseCategoryPtr item = categories->GetAt (i);
				if (item) {
					this->copy_rose_item (item, new_element);					
				}
			}

			IRoseClassCollectionPtr classes = cat->Classes;
			count = classes->Count;
			for (short i = 1; i < count + 1; i++) {
				IRoseClassPtr item = classes->GetAt (i);
				if (item) {
					this->copy_rose_item (item, new_element);
				}
			}
			
			IRoseClassDiagramCollectionPtr diagrams = cat->ClassDiagrams;
			count = diagrams->Count;
			for (short i = 1; i < count + 1; i++) {
				IRoseDiagramPtr item = diagrams->GetAt (i);
				if (item) {					
					this->copy_rose_item (item, new_element);
				}
			}
		} else if (item_to_copy->IsClass (CLASS_TYPE)) {
			IRoseClassPtr cls = item_to_copy;
			new_element = ((IRoseCategoryPtr)new_parent)->AddClass (item_to_copy->GetName ());
			((IRoseClassPtr)new_element)->Documentation = cls->Documentation;
			((IRoseClassPtr)new_element)->Stereotype = cls->Stereotype;
			IRosePropertyCollectionPtr props = cls->GetAllProperties ();
			short count = props->Count;
			for (short i = 1; i < count + 1; i++) {
				IRosePropertyPtr prop = props->GetAt (i);
				new_element->OverrideProperty (prop->GetToolName (), prop->GetName (), prop->GetValue ());
			}

			IRoseClassCollectionPtr classes = cls->GetNestedClasses ();
			count = classes->Count;
			for (short i = 1; i < count + 1; i++) {
				IRoseClassPtr item = classes->GetAt (i);
				if (item) {
					this->copy_rose_item (item, new_element);
				}
			}			
			
			IRoseOperationCollectionPtr operations = cls->Operations;
			count = operations->Count;
			for (short i = 1; i < count + 1; ++i) {
				IRoseOperationPtr item = operations->GetAt (i);
				if (item) {
					this->copy_rose_item (item, new_element);
				}
			}

			IRoseParameterCollectionPtr parameters = cls->Parameters;
			count = operations->Count;
			for (short i = 1; i < count + 1; ++i) {
				IRoseParameterPtr item = parameters->GetAt (i);
				if (item) {
					this->copy_rose_item (item, new_element);
				}
			}

			IRoseAttributeCollectionPtr attributes = cls->Attributes;
			count = attributes->Count;
			for (short i = 1; i < count + 1; ++i) {
				IRoseAttributePtr item = attributes->GetAt (i);
				if (item) {
					this->copy_rose_item (item, new_element);
				}
			}
		} else if (item_to_copy->IsClass ("ClassDiagram")) {
			IRoseClassDiagramPtr diag = item_to_copy;
			new_element = ((IRoseCategoryPtr)new_parent)->AddClassDiagram (item_to_copy->GetName ());
			((IRoseClassDiagramPtr)new_element)->Documentation = diag->Documentation;
		}
	} else if (new_parent->IsClass (CLASS_TYPE)) {
			if (item_to_copy->IsClass (CLASS_TYPE)) {
				IRoseClassPtr cls = item_to_copy;
				new_element = ((IRoseClassPtr)new_parent)->AddNestedClass (item_to_copy->GetName ());
				((IRoseClassPtr)new_element)->Documentation = cls->Documentation;
				((IRoseClassPtr)new_element)->Stereotype = cls->Stereotype;
				IRosePropertyCollectionPtr props = cls->GetAllProperties ();
				short count = props->Count;
				for (short i = 1; i < count + 1; i++) {
					IRosePropertyPtr prop = props->GetAt (i);
					RoseHelper::override_property (new_element, prop->GetToolName (), prop->GetName (), prop->GetValue ());
				}

				IRoseOperationCollectionPtr operations = cls->Operations;
				count = operations->Count;
				for (short i = 1; i < count + 1; ++i) {
					IRoseOperationPtr item = operations->GetAt (i);
					if (item) {
						this->copy_rose_item (item, new_element);
					}
				}

				IRoseParameterCollectionPtr parameters = cls->Parameters;
				count = operations->Count;
				for (short i = 1; i < count + 1; ++i) {
					IRoseParameterPtr item = parameters->GetAt (i);
					if (item) {
						this->copy_rose_item (item, new_element);
					}
				}

				IRoseAttributeCollectionPtr attributes = cls->Attributes;
				count = attributes->Count;
				for (short i = 1; i < count + 1; ++i) {
					IRoseAttributePtr item = attributes->GetAt (i);
					if (item) {
						this->copy_rose_item (item, new_element);
					}
				}
			} else if (item_to_copy->IsClass (OPERATION_TYPE)) {
				IRoseOperationPtr op = item_to_copy;
				new_element = ((IRoseClassPtr)new_parent)->AddOperation (
					op->GetName ()
					, op->GetReturnType ()
				);
				((IRoseOperationPtr)new_element)->Documentation = op->Documentation;
				((IRoseOperationPtr)new_element)->Stereotype = op->Stereotype;
				IRosePropertyCollectionPtr props = op->GetAllProperties ();
				short count = props->Count;
				for (short i = 1; i < count + 1; i++) {
					IRosePropertyPtr prop = props->GetAt (i);
					RoseHelper::override_property (new_element, prop->GetToolName (), prop->GetName (), prop->GetValue ());
				}

				IRoseParameterCollectionPtr parameters = op->Parameters;
				count = parameters->Count;
				for (short i = 1; i < count + 1; ++i) {
					IRoseParameterPtr item = parameters->GetAt (i);
					if (item) {
						this->copy_rose_item (item, new_element);
					}
				}
			} else if (item_to_copy->IsClass (ATTRIBUTE_TYPE)) {
				IRoseAttributePtr attr = item_to_copy;
				new_element = ((IRoseClassPtr)new_parent)->AddAttribute (
					attr->GetName ()
					, attr->GetType ()
					, attr->GetInitValue ()
				);
				((IRoseAttributePtr)new_element)->Documentation = attr->Documentation;
				((IRoseAttributePtr)new_element)->Stereotype = attr->Stereotype;
				IRosePropertyCollectionPtr props = attr->GetAllProperties ();
				short count = props->Count;
				for (short i = 1; i < count + 1; i++) {
					IRosePropertyPtr prop = props->GetAt (i);
					RoseHelper::override_property (new_element, prop->GetToolName (), prop->GetName (), prop->GetValue ());
				}
			} else if (item_to_copy->IsClass (PARAMETER_TYPE)) {
				IRoseParameterPtr param = item_to_copy;
				IRoseParameterCollectionPtr params = ((IRoseClassPtr)new_parent)->Parameters;
				new_element = ((IRoseClassPtr)new_parent)->AddParameter (
					param->GetName ()
					, param->GetType ()
					, param->GetInitValue ()
					, params->Count
				);
				((IRoseParameterPtr)new_element)->Documentation = param->Documentation;
				((IRoseParameterPtr)new_element)->Stereotype = param->Stereotype;
				IRosePropertyCollectionPtr props = param->GetAllProperties ();
				short count = props->Count;
				for (short i = 1; i < count + 1; i++) {
					IRosePropertyPtr prop = props->GetAt (i);
					RoseHelper::override_property (new_element, prop->GetToolName (), prop->GetName (), prop->GetValue ());
				}
			}
	} else if (new_parent->IsClass (OPERATION_TYPE)) {
			if (item_to_copy->IsClass (PARAMETER_TYPE)) {
				IRoseParameterPtr param = item_to_copy;
				IRoseParameterCollectionPtr params = ((IRoseOperationPtr)new_parent)->Parameters;
				new_element = ((IRoseOperationPtr)new_parent)->AddParameter (
					param->GetName ()
					, param->GetType ()
					, param->GetInitValue ()
					, params->Count
				);
				((IRoseParameterPtr)new_element)->Documentation = param->Documentation;
				((IRoseParameterPtr)new_element)->Stereotype = param->Stereotype;
				IRosePropertyCollectionPtr props = param->GetAllProperties ();
				short count = props->Count;
				for (short i = 1; i < count + 1; i++) {
					IRosePropertyPtr prop = props->GetAt (i);
					RoseHelper::override_property (new_element, prop->GetToolName (), prop->GetName (), prop->GetValue ());
				}
			}
	}
	//#UC END# *45D552B80232*
}

// метод для создания дочерних контролов
bool CModelExplorer::create_child_windows (HWND parent) {
	//#UC START# *45D2EAFE005D*
	// should we create our "HiddenWindow"
	HWND parent_ = parent;
	if(parent_ == 0)
	{
		create_hidden_window ();
		parent_ = m_hidden_window;
	}

	// If the Windows already exist, only set a new parent
	if(m_wndTree.m_hWnd != NULL) {
		m_wndTree.SetParent(parent_);
	}
	else {
		RECT rc = {0,0,0,0};

		// only create the window
		UINT styles = TVS_HASBUTTONS
			| TVS_HASLINES
			| TVS_LINESATROOT 
			| TVS_EDITLABELS 
			| WS_BORDER 
			| WS_TABSTOP 
			| WS_VISIBLE 
			| WS_CLIPSIBLINGS 
			| TVS_SHOWSELALWAYS
			| WS_CHILD;
		m_wndTree.Create (parent_, rc, NULL, styles,  WS_EX_CLIENTEDGE);		
	}
	
	//m_image_list = new CImageList ();
	//m_image_list->Create (RoseHelper::get_rose_image_list ());
	
	m_wndTree.SetImageList (
		RoseHelper::get_rose_image_list ()->GetSafeHandle (), TVSIL_NORMAL
	);
	m_wndTree.DeleteAllItems ();
	m_tree_map.clear ();
	load_data_tree ();

	if(m_fast_type_tip.m_hWnd != NULL) {
		::DestroyWindow(m_fast_type_tip.m_hWnd);
		m_fast_type_tip.m_hWnd = NULL;
	}
	m_fast_type_tip.Create (parent_);
	
	m_tool_info.cbSize = sizeof(TOOLINFO);
	m_tool_info.uFlags = TTF_TRACK;
	m_tool_info.hwnd = NULL;
	m_tool_info.hinst = NULL;
	m_tool_info.uId = 0;
	m_tool_info.lpszText = (LPSTR)(LPCSTR) "";		
	// ToolTip control will cover the whole window
	m_tool_info.rect.left = 0;
	m_tool_info.rect.top = 0;
	m_tool_info.rect.right = 0;
	m_tool_info.rect.bottom = 0;		
	m_fast_type_tip.AddTool (&m_tool_info);
	
	create_toolbar (parent_);
	return true;
	//#UC END# *45D2EAFE005D*
}

// метод создает невидимое окно (STATIC) на него помещаются все дочерние контролы
void CModelExplorer::create_hidden_window () {
	//#UC START# *45D2F0EB01D4*
	if(m_hidden_window == NULL)
	{
		long lStyle;

		m_hidden_window = ::CreateWindow(_T("STATIC"), _T(" "), 0, 0, 0, 0, 0, 0, 0, 0, NULL);
		
		// remove all Borders, captions and other nonsens
		lStyle = ::GetWindowLong(m_hidden_window, GWL_STYLE);
		lStyle &= ~(WS_BORDER | WS_CAPTION);
		::SetWindowLong(m_hidden_window, GWL_STYLE, lStyle);
	}
	//#UC END# *45D2F0EB01D4*
}

// создает тулбар и связанные с ним ImageList
void CModelExplorer::create_toolbar (HWND parent) {
	//#UC START# *469AFE8A02BF*
	///create toolbar
	HWND parent_ = parent;
	if(parent_ == 0)
	{
		create_hidden_window ();
		parent_ = m_hidden_window;
	}
	if (m_toolbar.m_hWnd != NULL) {
		::DestroyWindow(m_toolbar.m_hWnd);
		m_toolbar.m_hWnd = NULL;
		
	}
	if (m_toolbar_image_list.m_hImageList == NULL) {
		m_toolbar_image_list.Create (16, 16, ILC_COLOR24 | ILC_MASK, 0, 1);
	}
	m_toolbar.Create(parent_, NULL, NULL, WS_CHILD |WS_VISIBLE);
	//m_toolbar.AddStrings (_T ("Generate\0Report\0Search\0Locks\0Hide\\Show\0Reload\0"));
	//set_true_color_images (m_toolbar, IDB_STD_SMALL_COLOR, 16, toolbar_set_image_list ());
	m_toolbar.SetButtonStructSize(sizeof(TBBUTTON));
	m_toolbar.SetImageList (m_toolbar_image_list);
	m_toolbar.ModifyStyle (0, TBSTYLE_FLAT | TBSTYLE_TOOLTIPS | TBSTYLE_WRAPABLE | TBSTYLE_AUTOSIZE);
	m_toolbar.SetIndent (2);
	static const char* buttons_command [] = {
		_T ("Reload tree")
	};
	TBBUTTON tbb[8];
	::ZeroMemory(tbb, sizeof(tbb));
	
	std::string image_dir = MDAModelParams::get_image_dir();
	tbb[0].iBitmap = m_toolbar_image_list.add (image_dir + "\\tb_generate.gif"); 	
	tbb[0].idCommand = ID_MDAGEN_COMMAND; 
	tbb[0].fsState = TBSTATE_ENABLED; 
	tbb[0].fsStyle = TBSTYLE_BUTTON;
	//tbb[0].iString = tbb[0].iBitmap == -1 ? 0 : -1;

	tbb[1].iBitmap = m_toolbar_image_list.add (image_dir + "\\tb_view_reports.gif"); 
	tbb[1].idCommand = ID_MDAREP_COMMAND; 
	tbb[1].fsState = TBSTATE_ENABLED; 
	tbb[1].fsStyle = TBSTYLE_BUTTON;
	//tbb[1].iString = tbb[1].iBitmap == -1 ? 1 : -1;

	tbb[2].iBitmap = m_toolbar_image_list.add (image_dir + "\\tb_search.gif"); 
	tbb[2].idCommand = ID_MDASRCH_COMMAND; 
	tbb[2].fsState = TBSTATE_ENABLED; 
	tbb[2].fsStyle = TBSTYLE_BUTTON;
	//tbb[2].iString = tbb[2].iBitmap == -1 ? 2 : -1;

	tbb[3].iBitmap = m_toolbar_image_list.add (image_dir + "\\tb_view_locks.gif");
	tbb[3].idCommand = ID_MDA_VIEW_LOCKED_COMMAND; 
	tbb[3].fsState = TBSTATE_ENABLED; 
	tbb[3].fsStyle = TBSTYLE_BUTTON;
	//tbb[0].iString = tbb[3].iBitmap == -1 ? 3 : -1;
	
	tbb[4].iBitmap = -1; 
	tbb[4].idCommand = 0; 
	tbb[4].fsState = TBSTATE_ENABLED; 
	tbb[4].fsStyle = TBSTYLE_SEP;	
	
	std::string file = m_show_stereotypes_in_tree == true ? "\\tb_st_off.gif" : "\\tb_st_on.gif";
	tbb[5].iBitmap = m_toolbar_image_list.add (
		image_dir + file
	);
	tbb[5].idCommand = ID_MDA_SHOW_HIDE_STEREOTYPES; 
	tbb[5].fsState = TBSTATE_ENABLED; 
	tbb[5].fsStyle = TBSTYLE_BUTTON;

	tbb[6].iBitmap = m_toolbar_image_list.add (image_dir + "\\tb_show_error_list.gif");
	tbb[6].idCommand = ID_MDA_VIEW_ERRORS; 
	tbb[6].fsState = TBSTATE_ENABLED; 
	tbb[6].fsStyle = TBSTYLE_BUTTON;

	tbb[7].iBitmap = m_toolbar_image_list.add (image_dir + "\\tb_reload_tree.gif");
	tbb[7].idCommand = ID_RELOAD_TREE; 
	tbb[7].fsState = TBSTATE_ENABLED; 
	tbb[7].fsStyle = TBSTYLE_BUTTON;

	m_toolbar.AddButtons(sizeof(tbb)/sizeof(tbb[0]), tbb);

	if (m_toolbar_tip.m_hWnd != NULL) {
		::DestroyWindow(m_toolbar_tip.m_hWnd);
		m_toolbar_tip.m_hWnd = NULL;		
	}
	
	m_toolbar_tip.Create (parent_);		
	m_toolbar.SetToolTips (m_toolbar_tip);
	
	RECT temp;
	m_toolbar.GetRect(0, &temp);
	
	m_toolbar_tip.AddTool (m_toolbar, _T ("Перезагрузить дерево навигатора"), &temp, ID_RELOAD_TREE);
	m_toolbar_tip.AddTool (m_toolbar, _T ("Сгенерировать всю модель"), &temp, ID_MDAGEN_COMMAND);
	m_toolbar_tip.AddTool (m_toolbar, _T ("Построить отчет по всей модели"), &temp, ID_MDAREP_COMMAND);
	m_toolbar_tip.AddTool (m_toolbar, _T ("Осуществить поиск по всей модели"), &temp, ID_MDASRCH_COMMAND);
	m_toolbar_tip.AddTool (m_toolbar, _T ("Просмотреть список активных залочек"), &temp, ID_MDA_VIEW_LOCKED_COMMAND);	
	m_toolbar_tip.AddTool (
		m_toolbar
		, m_show_stereotypes_in_tree ==true ? _T ("Выключить показ стереотипов в дереве навигатора") : _T ("Включить показ стереотипов в дереве навигатора")
		, &temp
		, ID_MDA_SHOW_HIDE_STEREOTYPES
	);
	m_toolbar_tip.AddTool (m_toolbar, _T ("Просмотреть список ошибок"), &temp, ID_MDA_VIEW_ERRORS);

	m_toolbar_tip.Activate (true);	
	m_toolbar.ShowWindow(SW_SHOW);	
	//#UC END# *469AFE8A02BF*
}

// метод удаляет элемент с модели и, при необходимости (в некоторых случаях из розы не приходит
// нотификация об удалении элемента) из дерева браузера
void CModelExplorer::delete_from_model (IRoseElementPtr elem) {
	//#UC START# *45C752D40203*
	MDPSupport::CatLockerFacade_var clf = 
		MDPSupport::CatLockerFacadeFactory::make (elem);
	if (false == clf->try_change ()) {
		GenSupport::LogManagerFactory::get ().log_warning ("Can't delete element, because it was locked by somebody");
		return;
	}
	MDPSupport::CatLockerFacade_var parent_locker = 
		MDPSupport::CatLockerFacadeFactory::make (
			elem->IsClass (CATEGORY_TYPE) ? ((IRoseCategoryPtr)elem)->ParentCategory : 0
		);
	if (parent_locker->try_change () == false) {
		GenSupport::LogManagerFactory::get ().log_warning ("Can't delete element, because it was locked by somebody");
		return;
	}
	
	if (elem->IsClass ("Association")) {
		IRoseRolePtr role = RoseHelper::get_role (elem);
		elem = role;
	}

	{
		IRoseItemPtr item = elem;
		
		//сначала удаляем из дерева и вью, а потом из модели
		this->delete_item (elem);
		if (elem->IsClass ("State")) {
			RoseHelper::move_generated_source_to_parent (elem, RoseHelper::get_context (elem));
			IRoseStatePtr state = elem;				
			IRoseStateMachinePtr machine = state->GetContext ();
			machine->DeleteState (state);
		} else if (elem->IsClass ("Transition")) {
			RoseHelper::move_generated_source_to_parent (elem, RoseHelper::get_context (elem));
			IRoseTransitionPtr transition = elem;
			IRoseStatePtr state = transition->GetSourceState ();
			state->DeleteTransition (transition);
		} else	if (elem->IsClass ("ClassDiagram")) {
			RoseHelper::move_generated_source_to_parent (elem, RoseHelper::get_context (elem));
			IRoseClassDiagramPtr diag = elem;
			IRoseCategoryPtr current_cat = diag->GetParentContext();
			current_cat->DeleteClassDiagram (diag);					
		} else if (elem->IsClass ("ScenarioDiagram")) {
			RoseHelper::move_generated_source_to_parent (elem, RoseHelper::get_context (elem));
			IRoseScenarioDiagramPtr diag = elem;
			IRoseCategoryPtr current_cat = diag->GetParentContext();
			current_cat->DeleteScenarioDiagram (diag);					
		} else if (elem->IsClass ("StateMachine")) {
			RoseHelper::move_generated_source_to_parent (elem, RoseHelper::get_context (elem));
			IRoseStateMachinePtr state_machine = elem;
			IRoseStateMachineOwnerPtr owner = state_machine->StateMachineOwner;
			owner->DeleteStateMachine (state_machine);
		} else if (elem->IsClass ("StateDiagram")) {
			RoseHelper::move_generated_source_to_parent (elem, RoseHelper::get_context (elem));
			IRoseStateDiagramPtr state_diag = elem;
			IRoseStateMachinePtr state_machine = state_diag->Parent;
			state_machine->DeleteStateDiagram (state_diag);
		} else if (elem->IsClass ("Role")) {
			IRoseRolePtr role = elem;
			IRoseCategoryPtr assoc_parent = role->Association->ParentCategory;
			MDPSupport::CatLockerFacade_var assoc_clf = 
				MDPSupport::CatLockerFacadeFactory::make (assoc_parent);
			if (false == assoc_clf->try_change ()) {
				std::string mess ("Can't delete Association, because it parent (");
				mess += assoc_parent->GetName ();
				mess += ") was locked by somebody";
				GenSupport::LogManagerFactory::get ().log_warning (mess.c_str ());
				return;
			}			
			RoseHelper::delete_item (role);
			assoc_clf->do_change ();
		} else if (item) {
			RoseElementSet for_deleting;
			if (item->IsClass (CLASS_TYPE)) {
				IRoseClassPtr cls = item;
				//удаляем все диаграммы, связанные с классом
				IRoseDiagramCollectionPtr diags = RoseHelper::get_diagrams (cls);
				short diags_count = diags->Count;
				for (short i = 1; i <= diags_count; ++i) {
					IRoseElementPtr e = diags->GetAt (i);
					for_deleting.insert (RoseElementWrapper (e));
				}

				IRoseItemCollectionPtr clients = RoseHelper::get_clients (cls);
				short clients_count = clients->Count;
				for (short i = 1; i <= clients_count; ++i) {
					IRoseElementPtr e = clients->GetAt (i);
					for_deleting.insert (RoseElementWrapper (e));
				}
			} else if (item->IsClass (CATEGORY_TYPE)) {
				IRoseCategoryPtr cat = item;
				
				IRoseItemCollectionPtr clients = RoseHelper::get_clients (cat);
				short clients_count = clients->Count;
				for (short i = 1; i <= clients_count; ++i) {
					IRoseElementPtr e = clients->GetAt (i);
					for_deleting.insert (RoseElementWrapper (e));
				}
			}
			
			for (RoseElementSet::iterator it = for_deleting.begin (); it != for_deleting.end ();) {
				IRoseElementPtr elem_for_delete = it->element;
				for_deleting.erase (it++);
				this->delete_from_model (elem_for_delete);
			}

			RoseHelper::delete_item (item);
		}
	}
	RoseTreeState::instance ()->set_changed (true);
	parent_locker->do_change ();
	clf->do_change ();
	//#UC END# *45C752D40203*
}

// удаление элемента можели из дерева
void CModelExplorer::delete_item (IRoseElementPtr item) {
	//#UC START# *45C6F442029F*	
	std::string uid = get_rose_element_uid(item);
	if (!this->is_hide ()) {
		TreeItemMap::iterator find_it = m_tree_map.find (uid);
		if (find_it == m_tree_map.end ()) { //т.к при перемещении элемента его гуид может быть перезаписан, нужно поискать по старому гуиду
			uid = item->DeprecatedGetUniqueID();
			find_it = m_tree_map.find (uid);
		}

		if (find_it != m_tree_map.end ()) {		
			TreeViewItemIterator iter (find_it->second, true);
			for (
				ATLControls::CTreeItem tree_item = iter.get_next ()
				; !tree_item.IsNull ()
				; tree_item = iter.get_next ()
			) {
				ModelTreeItem* item = reinterpret_cast<ModelTreeItem*> (tree_item.GetData ());			
				m_tree_map.erase (item->get_item_uid ());
			}		
			
			ATLControls::CTreeItem prev = find_it->second.GetPrevVisible ();			
			find_it->second.Delete ();						
			prev.Select ();			
		}
	}
	ModelTreeItem_var deleted_node = this->find_by_uid (uid);
	if (!deleted_node.is_nil ()) {		
		deleted_node->remove_from_tree ();
	}	
	//#UC END# *45C6F442029F*
}

// метод для поиска элемента дерева по uid
ModelTreeItem* CModelExplorer::find_by_uid (const std::string& uid) {
	//#UC START# *45C710000148*
	/*if (m_model_tree.is_nil ()) {
		return 0;
	}
	if (m_model_tree->uid () == uid) {
			return m_model_tree._sretn ();
	}*/
	GCL::StaticNodeIterator iter (m_model_tree.in ());
	for (
		ModelTreeItem_var found_node = dynamic_cast<ModelTreeItem*> (iter.get_next ())
		; !found_node.is_nil ()
		; found_node = dynamic_cast<ModelTreeItem*> (iter.get_next ())
	) {		
		if (found_node->get_item_uid () == uid) {
			return found_node._sretn ();
		}
	}
	return 0;
	//#UC END# *45C710000148*
}

// решает лигитимность цели бросания, находящейся под курсором. Она возвращает пустой элемент, если
// элемент не может принять бросок, если может - возвращает сам элемент.
ATLControls::CTreeItem CModelExplorer::get_drop_target (ATLControls::CTreeItem item) {
	//#UC START# *45CC191E000F*
	ModelTreeItem* drag = reinterpret_cast<ModelTreeItem*> (m_item_drag.GetData ());
	ModelTreeItem* drop = reinterpret_cast<ModelTreeItem*> (item.GetData ());
	if (
		item.m_hTreeItem == m_item_drag.m_hTreeItem 
		|| item.m_hTreeItem == m_item_drag.GetParent().m_hTreeItem
		|| drag->can_move_to (drop) == false
	) {
 		return ATLControls::CTreeItem (NULL, &m_wndTree);
	}
 	return item;
	//#UC END# *45CC191E000F*
}

// возвращает выбранный в дереве элемент
ATLControls::CTreeItem CModelExplorer::get_selected_item () {
	//#UC START# *4648099B029F*
	ATLControls::CTreeItem res;
	if (this->is_hide () == false) {
		res = m_wndTree.GetSelectedItem ();
	}
	return res;
	//#UC END# *4648099B029F*
}

// возвращает элемент дерева, соответствущий координатам.
// \x, y - координаты
ATLControls::CTreeItem CModelExplorer::hit_test (long x, long y) {
	//#UC START# *46F73F8D031C*
	ATLControls::CTreeItem res;
	HWND wnd = ::WindowFromPoint (CPoint (x ,y));
	CRect rect;	
	TVHITTESTINFO tvht = {};  // hit test information 
	tvht.pt.x = x; 
	tvht.pt.y = y;
	if (
		wnd == m_wndTree
		&& this->is_hide () == false
	) {	
		m_wndTree.GetWindowRect (&rect);
		if (rect.PtInRect (tvht.pt)) {
			m_wndTree.ScreenToClient (&tvht.pt);
			res = m_wndTree.HitTest (&tvht);
		}
	}
	return res;
	//#UC END# *46F73F8D031C*
}

// определяет возможность drag'n'drop операции для заданного элемента
bool CModelExplorer::is_drop_source (ATLControls::CTreeItem item) {
	//#UC START# *45CC18990167*	
	return true;
	//#UC END# *45CC18990167*
}

// метод возвращает true, если окно браузера закрыто, иначе false
bool CModelExplorer::is_hide () const {
	//#UC START# *45C70FAA0119*
	return !::IsWindow (m_hWnd);
	//#UC END# *45C70FAA0119*
}

// метод загрузки данных дерева во вью
void CModelExplorer::load_data_tree () {
	//#UC START# *45C70F8D02BF*
	if (this->is_hide () == false && !m_model_tree.is_nil ()) {
		m_wndTree.SendMessage (WM_SETREDRAW, FALSE, 0L);
		/*if (!m_model_tree.is_nil ()) {
			if (!m_hide) {
				this->add_item (m_model_tree->get_item (), 0);
			}
		} else {
			return;
		}*/
		ModelSearcher& searcher = ModelSearcherFactory::get ();
		GCL::StaticNodeIterator iter (m_model_tree.in ());
		for (
			ModelTreeItem_var found_node = dynamic_cast<ModelTreeItem*> (iter.get_next ())
			; !found_node.is_nil ()
			; found_node = dynamic_cast<ModelTreeItem*> (iter.get_next ())
		) {
			/*IRoseElementPtr parent;
			IRoseItemPtr item = found_node->get_item ();
			IRoseDiagramPtr diag = found_node->get_item ();
			if (diag) {
				parent = diag->GetParentContext ();
			} else if (item) {
				parent = item->GetContext ();
				IRoseModelPtr model = parent;
				if (model) {
					parent = 0;
				}
			}*/
			IRoseElementPtr item = found_node->get_item ();
			searcher.on_new_element (item);
			ModelTreeItem_var parent = dynamic_cast<ModelTreeItem*> (found_node->parent ());		
			add_item (found_node.in (), parent.in (), false);
		}
		this->sort_tree (TVI_ROOT);
		m_wndTree.SendMessage (WM_SETREDRAW, TRUE, 0L);
		this->size_views ();
	}
	//#UC END# *45C70F8D02BF*
}

// формирование дерева бразуера по модели
void CModelExplorer::load_tree (IRoseModelPtr model) {
	//#UC START# *45BF256F004E*
	IRoseCategoryPtr root_cat = model->GetRootCategory ();
	m_model_tree = new ModelTreeItem (root_cat);
	load_data_tree ();
	//#UC END# *45BF256F004E*
}

// перемещает элемент из одной ветки в другую
void CModelExplorer::move_item (ModelTreeItem* item, ModelTreeItem* new_parent) {
	//#UC START# *462731630280*
	const std::string& uid = item->get_item_uid ();
	if (!this->is_hide ()) {			
		TreeItemMap::iterator find_it = m_tree_map.find (uid);
		if (find_it != m_tree_map.end ()) {		
			TreeViewItemIterator iter (find_it->second, true);
			for (
				ATLControls::CTreeItem tree_item = iter.get_next ()
				; !tree_item.IsNull ()
				; tree_item = iter.get_next ()
			) {
				ModelTreeItem* item = reinterpret_cast<ModelTreeItem*> (tree_item.GetData ());			
				m_tree_map.erase (item->get_item_uid ());
			}		
				find_it->second.Delete ();			
		}
	}	
	item->move_to (new_parent);	
	this->add_item (item, new_parent, true);

	ModelTreeItem_var first_child = dynamic_cast<ModelTreeItem*> (item->first_child ());
	GCL::StaticNodeIterator iter (first_child.in ());
	for (
		ModelTreeItem_var found_node = dynamic_cast<ModelTreeItem*> (iter.get_next ())
		; !found_node.is_nil ()
		; found_node = dynamic_cast<ModelTreeItem*> (iter.get_next ())
	) {
		ModelTreeItem_var parent = 	dynamic_cast<ModelTreeItem*> (found_node->parent ());
		this->add_item (found_node.in (), parent.in (), true);
	}
	//#UC END# *462731630280*
}

// перемещает элемент в нового родителя  во вью и в данных
void CModelExplorer::move_rose_item (IRoseElementPtr item, IRoseElementPtr new_parent) {
	//#UC START# *468214190261*
	std::string item_guid = get_rose_element_uid(item);
	std::string new_parent_guid = get_rose_element_uid(new_parent);
	ModelTreeItem_var model_item = this->find_by_uid (item_guid);
	ModelTreeItem_var model_new_parent = this->find_by_uid (new_parent_guid);
	if (!model_item.is_nil () && !model_new_parent.is_nil ()) {
		this->move_item (model_item.in (), model_new_parent.in ());
	}
	//#UC END# *468214190261*
}

// обработчик нотификации TVN_BEGINDRAG
LRESULT CModelExplorer::on_begin_drag (int wParam, LPNMHDR lParam, BOOL& bHandled) {
	//#UC START# *45D2ECBA001F*
	LPNMTREEVIEW lpnmtv = (LPNMTREEVIEW)lParam;
	HIMAGELIST himl;    // handle to image list     
    
	m_item_drag.m_hTreeItem = lpnmtv->itemNew.hItem;
	m_item_drag.m_pTreeView = &m_wndTree;
 	m_item_drop = NULL;
	m_wndTree.SelectItem (m_item_drag);
	if (!is_drop_source(m_item_drag)) {
 		return 0;
	}
    // Tell the tree-view control to create an image to use 
    // for dragging. 
	himl = m_wndTree.CreateDragImage (lpnmtv->itemNew.hItem);
	if (himl == 0)  {
		return 0;
	}
	// Start the drag operation. 
    ImageList_BeginDrag(himl, 0, 15, 15);	
	POINT pt = lpnmtv->ptDrag;
 	ClientToScreen( &pt );
    ImageList_DragEnter(NULL, pt.x, pt.y);  
			
    SetCapture(); 
    m_dragging = true;	
	SetTimer (SCROLL_TIMER_ID, 5, NULL);
	return 0;
	//#UC END# *45D2ECBA001F*
}

// обработчик WM_CONTEXTMENU
LRESULT CModelExplorer::on_context_menu (UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled) {
	//#UC START# *45D320B9029F*
	if (!m_dragging) {
		long x = GET_X_LPARAM(lParam); 
		long y = GET_Y_LPARAM(lParam); 
		
		POINT pt = {x, y};
		
		m_wndTree.ScreenToClient (&pt);
		TVHITTESTINFO tvht = {};  // hit test information 
		tvht.pt.x = pt.x; 
		tvht.pt.y = pt.y;
		
		ATLControls::CTreeItem selected_item = m_wndTree.HitTest (&tvht);
		if (selected_item.IsNull ()) {
			selected_item = m_wndTree.GetSelectedItem ();
		}
		if (!selected_item.IsNull ()) {
			selected_item.Select ();
			ModelTreeItem* item = reinterpret_cast<ModelTreeItem*> (selected_item.GetData ());
			IRoseElementPtr elem = item->get_item ();
			Core::Aptr<CMenu> item_menu = MenuFactory::create_menu (MenuFactory::TREE_MENU, elem);
			if (!item_menu.is_nil ()) {
				if (selected_item.HasChildren () == false) {
					MenuHelper::remove_menu_item (*item_menu.in (), ID_EXPAND_COLLAPSE_TREE);
					MenuHelper::remove_menu_item (*item_menu.in (), ID_EXPAND_COLLAPSE_ALL_TREE);
				} else {
					if ((selected_item.GetState (TVIS_EXPANDED) & TVIS_EXPANDED) != 0) {
						MenuHelper::modify_menu_item (*item_menu.in (), ID_EXPAND_COLLAPSE_TREE, "Collapse");
						MenuHelper::modify_menu_item (*item_menu.in (), ID_EXPAND_COLLAPSE_ALL_TREE, "Collapse All");
					} else {
						MenuHelper::modify_menu_item (*item_menu.in (), ID_EXPAND_COLLAPSE_TREE, "Expand");
						MenuHelper::modify_menu_item (*item_menu.in (), ID_EXPAND_COLLAPSE_ALL_TREE, "Expand All");
					}
				}
				MenuHelper::clear_duplicate_separator (*item_menu.in ());
				CPoint pos_mouse;
				GetCursorPos(&pos_mouse);
						
				int res = item_menu->GetSubMenu (0)->TrackPopupMenuEx (TPM_NONOTIFY | TPM_RETURNCMD, pos_mouse.x, pos_mouse.y, CmdHandler::instance (), NULL);
				item_menu->DestroyMenu ();
				if (res != 0) {
					CmdHandler::instance ()->PostMessage (WM_COMMAND, MAKEWPARAM (res, 0), 0);		
				}

			}
		} 	
	}
	return S_OK;
	//#UC END# *45D320B9029F*
}

// обработчик события "Копирование элемента"
LRESULT CModelExplorer::on_copy (WORD notify_code, WORD id, HWND ctrl, BOOL& handled) {
	//#UC START# *45D321350203*
	m_item_in_buffer = ATLControls::CTreeItem (m_wndTree.GetSelectedItem (), &m_wndTree);
	m_copy  = true;
	return S_OK;
	//#UC END# *45D321350203*
}

// обработчик события "Вырез элемента"
LRESULT CModelExplorer::on_cut (WORD notify_code, WORD id, HWND ctrl, BOOL& handled) {
	//#UC START# *45D321530138*
	m_item_in_buffer = ATLControls::CTreeItem (m_wndTree.GetSelectedItem (), &m_wndTree);
	m_copy  = false;
	return S_OK;
	//#UC END# *45D321530138*
}

// обрабочтик события "свернуть/развернуть" элемент дерева
LRESULT CModelExplorer::on_expand_collapse_command (WORD notify_code, WORD id, HWND ctrl, BOOL& handled) {
	//#UC START# *462F38430203*
	ATLControls::CTreeItem selected_item = m_wndTree.GetSelectedItem ();
	if (selected_item.IsNull ()) {
		selected_item = m_wndTree.GetRootItem ();
	}
	switch (id) {
		case ID_EXPAND_COLLAPSE_ALL_TREE: {
			TreeViewItemIterator iter (selected_item, true);
			for (
				ATLControls::CTreeItem next = iter.get_next ()
				; !next.IsNull ()
				; next = iter.get_next ()
			) {
				m_wndTree.Expand (next, TVE_TOGGLE);				
			}
		}
		break;
		case ID_EXPAND_COLLAPSE_TREE: {
			m_wndTree.Expand (selected_item, TVE_TOGGLE);
		}
		break;
	}
	return S_OK;
	//#UC END# *462F38430203*
}

// обработчик события "Ракрыть узел"
LRESULT CModelExplorer::on_expanded (int wParam, LPNMHDR lParam, BOOL& bHandled) {
	//#UC START# *45DC542500AB*
	LPNMTREEVIEW lpnmtv = (LPNMTREEVIEW)lParam;
	this->sort_tree (lpnmtv->itemNew.hItem);
	return S_OK;
	//#UC END# *45DC542500AB*
}

// обработчик TVN_ENDLABELEDIT
LRESULT CModelExplorer::on_label_edit (int wParam, LPNMHDR lParam, BOOL& bHandled) {
	//#UC START# *460390A700DA*
	TV_DISPINFO* ptvdi = (TV_DISPINFO* ) lParam;
	if (ptvdi->item.pszText != NULL) {
		ATLControls::CTreeItem edit_item (ptvdi->item.hItem, &m_wndTree);
		std::string new_label (ptvdi->item.pszText);
		
		ModelTreeItem* tree_item = reinterpret_cast<ModelTreeItem*> (edit_item.GetData ());
		if (tree_item->get_item_name () != new_label) {
			std::string::size_type open_fnd = new_label.find ("<<");
			std::string::size_type close_fnd = new_label.find (">> ");

			std::string new_stereotype;
			std::string new_name;
			if (
				open_fnd != std::string::npos 
				&& close_fnd != std::string::npos 
				&& (close_fnd - open_fnd) > 0
			) {
				new_stereotype = new_label.substr (open_fnd + 2, close_fnd - open_fnd - 2);
				new_name = new_label.substr (close_fnd + 3);
			} else {
				new_name = new_label;
			}
			IRoseElementPtr rose_elem = tree_item->get_item ();
			rose_elem->Name = new_name.data ();

			IRoseItemPtr item = rose_elem;
			if (item) {				
				item->Stereotype = new_stereotype.c_str ();
			}
			tree_item->init (rose_elem);
			edit_item.SetText (tree_item->get_item_name ().c_str ());
		} else {
			return S_FALSE;
		}
	}
	return S_OK;
	//#UC END# *460390A700DA*
}

// обработчик WM_LBUTTONUP
LRESULT CModelExplorer::on_lbutton_up (UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled) {
	//#UC START# *45D2EC25000F*
	class local {
	public:
		static IRoseItemViewPtr emulated_copy_past (IRoseItemPtr item, IRoseClassDiagramPtr diag) {
			GDS_ASSERT (diag);
			GDS_ASSERT (item);
			IRoseItemViewPtr res;
			IRoseItemViewCollectionPtr item_views = RoseHelper::get_views (item, diag);
			short views_count = item_views->Count;
			if (views_count > 0) {
				POINT point;
				::GetCursorPos (&point);
				HWND diag_wnd = WindowFromPoint (point);
				if (RoseHelper::is_diagram_window (diag_wnd, diag)) {
					::SetFocus (diag_wnd);
					IRoseItemViewPtr view = item_views->GetAt (1);
					//снимаем выделение с элементов диаграмммы, чтобы не скопировать
					//лишнего
					IRoseItemViewCollectionPtr diag_views = diag->GetItemViews ();
					short diag_views_count = diag_views->Count;
					for (short i = 1; i <= diag_views_count; ++i) {
						diag_views->GetAt (i)->SetSelected (VARIANT_FALSE);
					}
					view->SetSelected (VARIANT_TRUE);
					///добавляем новое вью эмулируя Copy/Past
					//::SendMessage (diag_wnd, WM_KEYDOWN, VK_CONTROL, MAKELPARAM (1, 0x1D));
					//::SendMessage (diag_wnd, WM_KEYDOWN, 'C', MAKELPARAM (1, 0x2E));
					//::SendMessage (diag_wnd, WM_KEYUP, 'C', MAKELPARAM (1, 0x2E));
					//::SendMessage (diag_wnd, WM_KEYUP, VK_CONTROL, MAKELPARAM (1, 0x1D));
					::SendMessage (diag_wnd, WM_COMMAND, 57634, 0);
					view->SetSelected (VARIANT_FALSE);
					::SendMessage (diag_wnd, WM_COMMAND, 57637, 0);
					//ищем новый вью путем вычитания из новой колекции вью, старой коллекции
					IRoseItemViewCollectionPtr new_views = RoseHelper::get_views (item, diag);
					for (short i = 1; i <= views_count; ++i) {
						IRoseItemViewPtr old_view = item_views->GetAt (i);
						if (new_views->Exists (old_view)) {
							new_views->Remove (old_view);
						}
					}
					if (new_views->Count > 0) {
						res = new_views->GetAt (1);
						res->SetSelected (VARIANT_TRUE);
					}
				}
			}
			return res;
		}
		static IRoseItemViewPtr add_view (IRoseClassPtr cls, IRoseClassDiagramPtr diag) {
			GDS_ASSERT (diag);
			GDS_ASSERT (cls);
			IRoseItemViewPtr res = 0;
			if (!(GetKeyState(VK_CONTROL) & 0x8000)) {
				res = emulated_copy_past (cls, diag);
			}
			if (res == 0) {
				diag->AddClass (cls);
				res = diag->GetViewFrom ((IRoseItemPtr)cls);
			}
			return res;
		}

		static IRoseItemViewPtr add_view (IRoseCategoryPtr cat, IRoseClassDiagramPtr diag) {
			GDS_ASSERT (diag);
			GDS_ASSERT (cat);
			IRoseItemViewPtr res = 0;
			if (!(GetKeyState(VK_CONTROL) & 0x8000)) {
				res = emulated_copy_past (cat, diag);
			}
			if (res == 0) {
				diag->AddCategory (cat);
				res = diag->GetViewFrom ((IRoseItemPtr)cat);
			}
			return res;
		}
	};
	if (m_dragging) { 
		ImageList_DragLeave (m_wndTree);
        ImageList_EndDrag(); 		
        ReleaseCapture();
		
		KillTimer (SCROLL_TIMER_ID);
		KillTimer (EXPAND_TIMER_ID);

		// Удаляем подсветку цели
 		m_wndTree.SelectDropTarget(NULL);
		SetCursor(m_drop_cursor);
		
		m_dragging = false;

		if( m_item_drag == m_item_drop) {
 			return 0;
		}		 		 		
		
		//std::string dragged_item_uid = (const char*)m_item_drag.GetData ();
		LONG yCur;
		LONG xCur;

		xCur = GET_X_LPARAM(lParam); 
		yCur = GET_Y_LPARAM(lParam); 
		
		if (m_item_drop.IsNull ()) {
			POINT point = {xCur, yCur};
			ClientToScreen (&point);
			HWND diag_wnd = WindowFromPoint (point);
			IRoseDiagramPtr diag = m_model_tree->get_item ()->Model->GetActiveDiagram ();
			if (diag) {				
				if (RoseHelper::is_diagram_window (diag_wnd, diag)) {					
					ModelTreeItem* item = reinterpret_cast<ModelTreeItem*> (m_item_drag.GetData ());
					if (item) {
						MDPSupport::CatLockerFacade_var clf = 
							MDPSupport::CatLockerFacadeFactory::make ((IRoseElementPtr)diag);
						if (false == clf->try_change ()) {
							GenSupport::LogManagerFactory::get ().log_warning ("Can't place item on diagram, because lock failed");
							return S_FALSE;
						}
						if (diag->IsClass ("ClassDiagram")) {
							IRoseClassDiagramPtr cls_diag = diag;
							IRoseElementPtr elem = item->get_item ();
							
							if (elem->IsClass (CATEGORY_TYPE)) {
								IRoseCategoryPtr added_cat = elem;
								IRoseItemViewPtr view = local::add_view (added_cat, cls_diag);
								if (view) {
									RoseHelper::position_in_diagram (cls_diag, view, point.x, point.y);
								}
								
							} else if (elem->IsClass (CLASS_TYPE)) {
								IRoseClassPtr added_cls = elem;
								IRoseItemViewPtr view = local::add_view (added_cls, cls_diag);
								if (view) {
									RoseHelper::position_in_diagram (cls_diag, view, point.x, point.y);
								}
							} else if (elem->IsClass ("Diagram")) {
								IRoseDiagramPtr added_diag = elem;
								std::string note_text (added_diag->IdentifyClass ());
								note_text += ": ";
								note_text += added_diag->GetName ();
								IRoseNoteViewPtr note = cls_diag->AddNoteView (note_text.c_str (), 2);
								if (note) {
									RoseHelper::position_in_diagram (cls_diag, (IRoseItemViewPtr)note, point.x, point.y);
									note->LinkDiagram (added_diag);
								}
							}
							RoseHelper::colorize (diag, elem);							
						} else if (diag->IsClass ("ScenarioDiagram")) {
							IRoseScenarioDiagramPtr scen_diag = diag;
							IRoseItemPtr rose_item = item->get_item ();
							if (rose_item && rose_item->IsClass (CLASS_TYPE)) {
								_bstr_t name = rose_item->GetQualifiedName ();
								IRoseObjectInstancePtr inst = scen_diag->AddInstance ("", name);
								IRoseClassPtr cls = inst->GetClass();
								std::string text;
								if (!cls) {
									text = ("Can't link diagram view with concrete element,\nplease specify ClassName in view properties");
									std::string caption ("Error while add class ");
									caption += name;
									caption += " on sequence diagram";
									MessageBox (
										text.c_str (), caption.c_str (), MB_OK | MB_ICONERROR
									);
									inst->OpenSpecification ();
								}
								if (inst->GetClass() != 0) {
									IRoseInstanceViewPtr view = scen_diag->AddInstanceView (inst, true);
									view->Invalidate ();
									RoseHelper::position_in_diagram (scen_diag, (IRoseItemViewPtr)view, point.x, point.y);
								} else {
									GenSupport::LogManagerFactory::get ().log_error (text.c_str ());
								}
							}							
						}
						clf->do_change ();
					}
				}/* else if (!IsChild(diag_wnd)) {					
					ModelTreeItem* item = reinterpret_cast<ModelTreeItem*> (m_item_drag.GetData ());
					if (item && !m_model_tree.is_nil ()) {					
						this->relocate (item->get_item (), m_model_tree->get_item ());
						this->move_item (item, m_model_tree.in ());				
					}   			
					m_item_drag.Select ();
				}*/
			}
		} else {			
			ModelTreeItem* new_parent = reinterpret_cast<ModelTreeItem*> (m_item_drop.GetData ());
			ModelTreeItem* item = reinterpret_cast<ModelTreeItem*> (m_item_drag.GetData ());
			
			if (new_parent && item) {
				IRoseElementPtr elem = item->get_item ();
				IRoseElementPtr elem_parent = new_parent->get_item ();

				if (!(GetKeyState(VK_CONTROL) & 0x8000)) {
					std::string caption ("Перемещение элемента ");
					caption += elem->IdentifyClass ();
					std::string text ("Вы уверены, что хотите переместить элемент:\n");
					text += RoseHelper::get_full_name (elem);
					text += "\nв ";
					text += RoseHelper::get_full_name (elem_parent);
					text += "?";
					int res = MessageBox (
						text.c_str (), caption.c_str (), MB_OKCANCEL | MB_ICONQUESTION
					);
					if (res == IDOK) {
						bool is_new = false;
						if (Commands::CmdManagerFactory::get ().relocate (elem, elem_parent, is_new)) {
							if (is_new == false) {
								this->move_item (item, new_parent);
							}
						} else {
							return S_FALSE;
						}
					}
				} else {
					std::string caption ("Копирование элемента ");
					caption += elem->IdentifyClass ();
					std::string text ("Вы уверены, что хотите скопировать элемент:\n");
					text += RoseHelper::get_full_name (elem);
					text += "\nв ";
					text += RoseHelper::get_full_name (elem_parent);
					text += "?";
					int res = MessageBox (
						text.c_str (), caption.c_str (), MB_OKCANCEL | MB_ICONQUESTION
					);
					if (
						res != IDOK
						|| Commands::CmdManagerFactory::get ().copy (elem, elem_parent) == 0
					) {
						return S_FALSE;
					}
				}
			}   			
			m_item_drop.Select ();
		}
    }	
    return 0; 
	//#UC END# *45D2EC25000F*
}

// обработчик сообщения WM_MOUSEMOVE
LRESULT CModelExplorer::on_mouse_move (UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled) {
	//#UC START# *45D2EBD90242*
	LONG yCur;
	LONG xCur;

	xCur = GET_X_LPARAM(lParam); 
	yCur = GET_Y_LPARAM(lParam); 

    if (m_dragging) { 
		ATLControls::CTreeItem htiTarget;  // handle to target item 
		TVHITTESTINFO tvht;  // hit test information 
		POINT pt = {xCur, yCur};
		ClientToScreen (&pt);
	
        // Drag the item to the current position of the mouse pointer. 
        ImageList_DragMove(pt.x, pt.y); 
		
		m_wndTree.ScreenToClient (&pt);
        // Find out if the pointer is on the item. If it is, 
        // highlight the item as a drop target. 
        tvht.pt.x = pt.x; 
        tvht.pt.y = pt.y;
		htiTarget = m_wndTree.HitTest (&tvht);
		CRect tree_rect;
		m_wndTree.GetClientRect (&tree_rect);
		ClientToScreen (&tree_rect);
		POINT cursor_pt;
		::GetCursorPos (&cursor_pt);
        if (!htiTarget.IsNull () && tree_rect.PtInRect (cursor_pt)) 
        { 
			ATLControls::CImageList::DragShowNolock(FALSE);
			m_item_drop = this->get_drop_target(htiTarget); 			
			m_wndTree.SelectDropTarget (m_item_drop); 
			ATLControls::CImageList::DragShowNolock(TRUE);
						
			KillTimer (EXPAND_TIMER_ID);
 			SetTimer (EXPAND_TIMER_ID, 1000, NULL);
		} else {
			m_item_drop = NULL;
		}
		if (m_item_drop) {
 			SetCursor(m_drop_cursor);
		} else {
			HWND diag_wnd = WindowFromPoint (cursor_pt);
			IRoseDiagramPtr diag =  m_model_tree->get_item ()->Model->GetActiveDiagram ();
			if (
				!RoseHelper::is_diagram_window (diag_wnd, diag)				
			) {
 				SetCursor(m_no_drop_cursor);
			} else {
				HCURSOR cursor = m_no_drop_cursor;
				ModelTreeItem* drag = reinterpret_cast<ModelTreeItem*> (m_item_drag.GetData ());
				IRoseElementPtr drag_elem = drag != 0 ? drag->get_item () : 0;
				if (
					drag_elem 
					&& ( 
						drag_elem->IsClass (ATTRIBUTE_TYPE)
						|| drag_elem->IsClass (OPERATION_TYPE)
					)
				) {
					IRoseElementPtr diag_elem = RoseHelper::get_element (diag, cursor_pt.x, cursor_pt.y);					
					if (diag_elem && diag_elem->IsClass (CLASS_TYPE)) {
						std::string diag_elem_uid = get_rose_element_uid(diag_elem);
						IRoseElementPtr drag_context = RoseHelper::get_context (drag_elem);
						std::string drag_elem_uid = drag_context != 0 ? get_rose_element_uid(drag_context) : "";
						if (diag_elem_uid != drag_elem_uid)	{
							TreeItemMap::iterator find_it = m_tree_map.find (diag_elem_uid);
							if (find_it != m_tree_map.end ()) {
								cursor = m_drop_cursor;
								m_item_drop = find_it->second;
							} 
						}
					}
				} else {
					cursor = m_drop_cursor;
				}
				SetCursor(cursor);
			}
		}
	} else {
		KillTimer (SCROLL_TIMER_ID);
		KillTimer (EXPAND_TIMER_ID);
	}
    return 0; 
	//#UC END# *45D2EBD90242*
}

// обработчик события " Вставка элемента"
LRESULT CModelExplorer::on_past (WORD notify_code, WORD id, HWND ctrl, BOOL& handled) {
	//#UC START# *45D321450232*
	if (!m_item_in_buffer.IsNull ()) {
		ModelTreeItem* new_parent = reinterpret_cast<ModelTreeItem*> (m_wndTree.GetSelectedItem ().GetData ());
		ModelTreeItem* item = reinterpret_cast<ModelTreeItem*> (m_item_in_buffer.GetData ());
			
		if (new_parent && item) {					
			if (m_copy) {
				this->copy_rose_item (item->get_item (), new_parent->get_item ());
			} else {
				bool is_new = false;
				if (Commands::CmdManagerFactory::get ().relocate (item->get_item (), new_parent->get_item (), is_new)) {
					if (is_new == false) {
						this->move_item (item, new_parent);
					}
				} else {
					return S_FALSE;
				}
			}
		}
	}
	m_item_in_buffer = NULL;
	return S_OK;
	//#UC END# *45D321450232*
}

// обработчик сообщения WM_SETFOCUS
LRESULT CModelExplorer::on_set_focus (UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled) {
	//#UC START# *45D2EBB4029F*
	LRESULT lRes = CComControl<CModelExplorer>::OnSetFocus(uMsg, wParam, lParam, bHandled);
	if (m_bInPlaceActive)
	{
		DoVerbUIActivate(&m_rcPos,  NULL);
		if(!IsChild(::GetFocus()))
			m_wndTree.SetFocus();
	}
	return lRes;
	//#UC END# *45D2EBB4029F*
}

// обрабочтик сообщения WM_SIZE
LRESULT CModelExplorer::on_size (UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled) {
	//#UC START# *45D2EB510242*
	this->size_views ();
	return S_OK;
	//#UC END# *45D2EB510242*
}

// обработчик событий, происходящий по таймеру
// wParam содержит идентификатор таймера
LRESULT CModelExplorer::on_timer (UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled) {
	//#UC START# *45D5797B0280*
	/*if (wParam != SCROLL_TIMER_ID && wParam != EXPAND_TIMER_ID) {
		return S_OK;
	}*/
	switch (wParam) {
		case SCROLL_TIMER_ID: {
			m_timer_ticks++;
			
			POINT pt;
			::GetCursorPos (&pt);
			RECT rect;
			m_wndTree.GetClientRect (&rect);
			m_wndTree.ClientToScreen (&rect);
			ImageList_DragMove (pt.x, pt.y);

			//ATLControls::CTreeItem target = m_wndTree.GetFirstVisibleItem ();
			if (pt.y < rect.top + 10 && (pt.x > rect.left && pt.x < rect.right)) {
 				// Мы должны прокручивать
 				// Делаем это медленно, если курсор около границы
 				int slowscroll = 6 - (rect.top + 10 - pt.y) / 20;
 				if (0 == (m_timer_ticks % (slowscroll > 0 ? slowscroll : 1))) {
					ImageList_DragShowNolock (FALSE);
 					m_wndTree.SendMessage (WM_VSCROLL, SB_LINEUP);

 					//m_item_drop = this->get_drop_target (target); 			
					//m_wndTree.SelectDropTarget (m_item_drop);  			
 					ImageList_DragShowNolock (TRUE);
 				}
 			} else if (pt.y > rect.bottom - 10 && (pt.x > rect.left && pt.x < rect.right)) {
 				int slowscroll = 6 - (pt.y - rect.bottom + 10 ) / 20;
 				if (0 == (m_timer_ticks % (slowscroll >0 ? slowscroll : 1))) {
 					ImageList_DragShowNolock (FALSE);
					
 					m_wndTree.SendMessage (WM_VSCROLL, SB_LINEDOWN);
 					/*int count = m_wndTree.GetVisibleCount();
					for (int i = 0; i < count; ++i) {
						target = target.GetNextVisible ();
					}
					if (!target.IsNull ()) {
						m_item_drop = this->get_drop_target (target); 			
						m_wndTree.SelectDropTarget (m_item_drop); 
					}*/	
					ImageList_DragShowNolock (TRUE);
 				}
 			}
		}
		break;

		case EXPAND_TIMER_ID: {
			ATLControls::CTreeItem float_item = m_wndTree.GetDropHilightItem ();
			if (!float_item.IsNull () && float_item == m_item_drop) {
				if (float_item.HasChildren ()) {
					float_item.Expand ();
				}
            }
		}
		break;

		case KEYBOARD_BUFFER_TIMER_ID: {			
			if (m_fast_type_tip.GetToolCount () > 0) {
				m_fast_type_tip.TrackActivate (&m_tool_info, false);
			}
			m_keyboard_buffer.erase ();			
		}
		break;		
		default: 
			break;
	}
	return S_OK;
	//#UC END# *45D5797B0280*
}

// обработчик команд тулбара
LRESULT CModelExplorer::on_toolbar_cmd (WORD notify_code, WORD id, HWND ctrl, BOOL& handled) {
	//#UC START# *468348F4001F*
	if (!m_model_tree.is_nil ()) {
		IRoseModelPtr rose_model = m_model_tree->get_item ()->Model;
		if (id == ID_RELOAD_TREE) {
			this->clear ();			
			this->load_tree (rose_model);
		} else if (id == ID_MDA_SHOW_HIDE_STEREOTYPES) {
			unsigned int button_id = m_toolbar.CommandToIndex (ID_MDA_SHOW_HIDE_STEREOTYPES);			
			std::string image_dir = MDAModelParams::get_image_dir();
			int on_index = m_toolbar_image_list.get_image_index (image_dir + "\\tb_st_on.gif");
			int off_index = m_toolbar_image_list.get_image_index (image_dir + "\\tb_st_off.gif");

			TBBUTTONINFO info = {0};
			info.cbSize = sizeof (TBBUTTONINFO);
			info.dwMask = 0x80000000 /*TBIF_BYINDEX*/ | TBIF_IMAGE;
			::SendMessage (m_toolbar, TB_GETBUTTONINFO, button_id, (LPARAM)&info);
			if (info.iImage == on_index) {
				info.iImage = off_index;
			} else if (info.iImage == off_index) {
				info.iImage = on_index;
			}
			::SendMessage (m_toolbar, TB_SETBUTTONINFO, button_id, (LPARAM)&info);			
			m_toolbar.RedrawWindow ();
			m_show_stereotypes_in_tree = !m_show_stereotypes_in_tree;
			std::string text = m_show_stereotypes_in_tree ==true ? _T ("Выключить показ стереотипов в дереве навигатора") : _T ("Включить показ стереотипов в дереве навигатора");
			m_toolbar_tip.UpdateTipText (_T (text.c_str ()), m_toolbar, ID_MDA_SHOW_HIDE_STEREOTYPES);
			
			this->update_tree_view ();
			/*m_toolbar.DeleteButton (button_id);
			TBBUTTON tb = {0};
			tb.iBitmap = m_toolbar_image_list.get_image_index (image_dir + "\\tb_st_on.gif");
			tb.idCommand = ID_MDA_SHOW_STEREOTYPES; 
			tb.fsState = TBSTATE_ENABLED; 
			tb.fsStyle = TBSTYLE_BUTTON;
			m_toolbar.InsertButton (button_id, &tb);
			if (m_show_stereotypes_in_tree == true) {
				m_show_stereotypes_in_tree = false;
				this->update_tree_view ();
			}*/
		} else {
			IRoseItemPtr item = rose_model->GetRootCategory ();			
			switch (id) {
				case ID_MDAPROP_COMMAND:
					Commands::CmdManagerFactory::get ().properties (item, false, true);
					break;

				case ID_MDAGEN_COMMAND: {						
						Commands::CmdManagerFactory::get ().generate (0, true);
					}
					break;

				case ID_MDAREP_COMMAND:
					Commands::CmdManagerFactory::get ().view_reports (item);
					break;

				case ID_MDASRCH_COMMAND:
					Commands::CmdManagerFactory::get ().search (item);
					break;

				case ID_MDA_VIEW_LOCKED_COMMAND:
					Commands::CmdManagerFactory::get ().show_locked ();
					break;
				case ID_MDA_VIEW_ERRORS:
					GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
					dlg.DoModal ();

					break;
			}
		}
	}
	return S_OK;
	//#UC END# *468348F4001F*
}

// обработчик клика в дереве
LRESULT CModelExplorer::on_tree_click (int wParam, LPNMHDR lParam, BOOL& bHandled) {
	//#UC START# *460390B1036B*
	HTREEITEM hSel = m_wndTree.GetSelectedItem();
    HTREEITEM hItem = NULL;

    CPoint p;
    ::GetCursorPos(&p);
    ::ScreenToClient(m_wndTree.m_hWnd, &p);

    UINT pFlags;
    hItem = m_wndTree.HitTest(p, &pFlags);
    if (hItem && hSel == hItem) {        
		HWND edit = m_wndTree.EditLabel (hSel);
		m_wndTree.SetFocus ();
    }
	return S_OK;
	//#UC END# *460390B1036B*
}

// обработчик дабл-клика в дереве
LRESULT CModelExplorer::on_tree_dbl_click (UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled) {
	//#UC START# *45D2ED7F008C*
	ATLControls::CTreeItem selected_item = m_wndTree.GetSelectedItem ();	
	ModelTreeItem* temp_item = reinterpret_cast<ModelTreeItem*> (selected_item.GetData ());
	if (temp_item) {
		//IRoseDiagramPtr diag = temp_item->get_item ();
		IRoseElementPtr elem = temp_item->get_item ();
		if (elem->IsClass ("Diagram")){
			IRoseDiagramPtr diag = elem;
			diag->Activate();
		} else if (elem->IsClass (ROSE_ITEM_TYPE)) {
			RoseHelper::ExecResult is_ok = Commands::CmdManagerFactory::get ().properties (elem, false, true);
		} else if (elem->IsClass ("StateMachine")) {
			IRoseStateMachinePtr state_machine = elem;
			state_machine->OpenSpecification ();
		}
	}
	m_wndTree.SelectItem (selected_item);
	m_wndTree.SetFocus();
	return 0;
	//#UC END# *45D2ED7F008C*
}

// обработчик сообщения WM_KEYUP
LRESULT CModelExplorer::on_tree_keyup (UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled) {
	//#UC START# *45D2ED4B0000*
	if (VK_DELETE == wParam && !this->is_hide ()) {
		//std::string uid = (const char*) m_wndTree.GetSelectedItem ().GetData ();
		CmdHandler::instance ()->PostMessage (WM_COMMAND, MAKEWPARAM (ID_DELETE_TREE, 0), 0);
		/*ModelTreeItem* temp_item = reinterpret_cast<ModelTreeItem*> (m_wndTree.GetSelectedItem ().GetData ());
		if (temp_item) {
			this->delete_from_model (temp_item->get_item ());
		}*/
	} else if (
		'R' == wParam 
		&& (GetKeyState(VK_CONTROL) & 0x8000)
		&& !this->is_hide ()
	) {
		::PostMessage (*this, WM_COMMAND, MAKEWPARAM(ID_RELOAD_TREE, 0), 0);
	} else if ('U' == wParam 
		&& (GetKeyState(VK_CONTROL) & 0x8000)
		&& !this->is_hide ()
	) {
		ATLControls::CTreeItem selected_item = m_wndTree.GetSelectedItem ();
		::PostMessage (*this, WM_COMMAND, MAKEWPARAM(ID_UNCONTROL_ALL_TREE, 0), 0);		
	} else {
		static const char* applied_symbols = "-_ []{}\\/|<>()=;:,.""'&^%$#@!~*";
		BYTE keyStateArr[256];
		WORD word;
		UINT scanCode = lParam;
		char symb;
		//Translate virtual key code to ascii
		GetKeyboardState(keyStateArr);
		ToAscii(wParam, scanCode, keyStateArr, &word, 0);
		symb = (char) word;
		if (
			(GetKeyState(VK_SHIFT) & 0x8000) 
			&& wParam >= 'a'
            && wParam <= 'z'
		) {
			symb += 'A'-'a';
		}

		if (
			GCL::is_alnum (symb) 
			|| GCL::contains (symb, applied_symbols)			
		) {
			
			KillTimer (KEYBOARD_BUFFER_TIMER_ID);
			SetTimer (KEYBOARD_BUFFER_TIMER_ID, 1500, NULL);
			std::string temp = m_keyboard_buffer + symb;
			if (this->select_by_name (temp)) {
				m_keyboard_buffer = temp;
				if (m_fast_type_tip.GetToolCount () > 0) {
					m_tool_info.lpszText = (LPSTR)(LPCSTR) m_keyboard_buffer.c_str ();
					m_fast_type_tip.UpdateTipText (&m_tool_info);
					ATLControls::CTreeItem selected_item = m_wndTree.GetSelectedItem ();
					if (!selected_item.IsNull ()) {
						RECT item_rect = {};
						selected_item.GetRect (&item_rect, true);
						m_wndTree.ClientToScreen (&item_rect);
						m_fast_type_tip.TrackPosition (item_rect.left, item_rect.top - 5);
						m_fast_type_tip.TrackActivate (&m_tool_info, true);
					}
				}
			}
		} else {			
			if (m_fast_type_tip.GetToolCount () > 0) {
				m_fast_type_tip.TrackActivate (&m_tool_info, false);
			}
			m_keyboard_buffer.erase ();	
		}
	}
	return 0;
	//#UC END# *45D2ED4B0000*
}

// метод ищет в дереве элемент с именем начинающимся на name и подсвечивает его
bool CModelExplorer::select_by_name (const std::string& name) {
	//#UC START# *45D5982D00FA*
	TreeViewItemIterator iter (m_wndTree.GetRootItem (), false);
	for (
		ATLControls::CTreeItem item = iter.get_next ()
		; !item.IsNull ()
		; item = iter.get_next ()
	) {
		ModelTreeItem* tree_item = reinterpret_cast<ModelTreeItem*> (item.GetData ());
		if (tree_item) {
			if (boost::algorithm::istarts_with ((const char*)tree_item->get_item ()->GetName (), name.c_str (), std::locale::classic ())) {				
				item.Select ();
				return true;
			}
		}
	}
	return false;
	//#UC END# *45D5982D00FA*
}

// ведляет элемент в дереве, uid - идентификатор элемента, который нужно выдлеить
void CModelExplorer::select_item (const std::string& uid) {
	//#UC START# *46480A0B031C*	
	TreeItemMap::iterator it = m_tree_map.find (uid);
	if (it != m_tree_map.end ()) {
		it->second.Select ();
	}
	//#UC END# *46480A0B031C*
}

// функция для пересчета размеров окна
void CModelExplorer::size_views () {
	//#UC START# *45D2EAD00157*
	if(m_initialized == true)
	{
		RECT rc;
		GetClientRect(&rc);		

		RECT toolbar_rc;
		m_toolbar.GetClientRect (&toolbar_rc);								
		if (toolbar_rc.right < rc.right) {
			toolbar_rc.right = rc.right;
			m_toolbar.SetWindowPos(HWND_TOP, &toolbar_rc, SWP_NOZORDER | SWP_DRAWFRAME);
		}
		long toolbar_h = toolbar_rc.bottom - toolbar_rc.top;
		//toolbar_rc.right = rc.right - 20;
		//toolbar_rc.left = rc.left + 20;
		toolbar_rc.top = 0;
		toolbar_rc.bottom = toolbar_h;
		
		rc.top = toolbar_h + 1;
				
		m_wndTree.SetWindowPos(HWND_TOP, &rc, SWP_NOZORDER | SWP_DRAWFRAME);
	}
	//#UC END# *45D2EAD00157*
}

// метод сортирует дерево
void CModelExplorer::sort_tree (HTREEITEM from) {
	//#UC START# *463031C9009C*
	TVSORTCB tvs;
	// Sort the tree control's items using my
	// callback procedure.
	tvs.hParent = from;
	tvs.lpfnCompare = (PFNTVCOMPARE)CModelExplorer::compare_tree_item;
	tvs.lParam = (LPARAM)&m_wndTree;
	m_wndTree.SortChildrenCB(&tvs);
	//#UC END# *463031C9009C*
}

// обновляет дерево навигатора (перечитывает текст элементов)
void CModelExplorer::update_tree_view () {
	//#UC START# *469B1EFE0196*
	GCL::StaticNodeIterator iter (m_model_tree.in ());
	for (
		ModelTreeItem_var found_node = dynamic_cast<ModelTreeItem*> (iter.get_next ())
		; !found_node.is_nil ()
		; found_node = dynamic_cast<ModelTreeItem*> (iter.get_next ())
	) {
		TreeItemMap::iterator find_it = m_tree_map.find (found_node->get_item_uid ());
		if (find_it != m_tree_map.end ()) {			
			std::string text;
			if (m_show_stereotypes_in_tree) {
				if (found_node->get_item_stereotype () != "") {
					text = "<<";
					text += found_node->get_item_stereotype ();
					text += ">> ";
				}
				text += found_node->get_item_name ();
			} else {
				text = found_node->get_item_name ();
			}
			find_it->second.SetText (text.c_str ());			
		}
	}	
	//#UC END# *469B1EFE0196*
}


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from WindowsHookImpl::IHookHandler
// функция обработчик сообщений от клавиатуры
LRESULT CModelExplorer::keyboard_proc (int code, WPARAM wParam, LPARAM lParam) {
	//#UC START# *46F9ECCE036B_45B8B8290167*
	static bool element_in_buffer = false;
	if (((lParam >> 31) & 1)) {//пришло сообщение WM_KEYUP
		return -1;
	}
	bool control_pressed = (GetKeyState (VK_CONTROL) & 0x8000);
	bool alt_pressed = (GetKeyState (VK_MENU) & 0x8000);
	bool shift_pressed = (GetKeyState (VK_SHIFT) & 0x8000);
	bool backspace_pressed = (GetKeyState (VK_BACK) & 0x8000);
	bool page_up_pressed = (GetKeyState (VK_PRIOR) & 0x8000);
	bool home_pressed = (GetKeyState (VK_HOME) & 0x8000);
	bool right_pressed = (GetKeyState (VK_RIGHT) & 0x8000);
	bool left_pressed = (GetKeyState (VK_LEFT) & 0x8000);
	
	if (VK_ESCAPE == wParam && m_dragging) {		
		ImageList_DragLeave (m_wndTree);
        ImageList_EndDrag(); 		
        ReleaseCapture();		
		// Удаляем подсветку цели
 		m_wndTree.SelectDropTarget(NULL);
		m_dragging = false;
	} else if (
		control_pressed
		&& !alt_pressed
		&& !shift_pressed
		&& !m_model_tree.is_nil ()
		&& (wParam == 'd' || wParam == 'D')
	) {
		HWND wnd = ::GetFocus();
		IRoseDiagramPtr diag = m_model_tree->get_item ()->Model->GetActiveDiagram ();
		LRESULT res (-1);
		if (
			wnd
			&& diag
			&& RoseHelper::is_diagram_window (wnd, diag)
		) {			
			IRoseItemCollectionPtr selections = diag->GetSelectedItems ();
			short count = selections->Count;
			if (count) {
				IRoseItemPtr item = selections->GetAt (1);
				if (
					!item->IsClass ("DependencyRelation") 
					&& !item->IsClass (ROSE_OBJECT_TYPE)
				) {
					CmdHandler::instance ()->PostMessage (WM_COMMAND, MAKEWPARAM (ID_DELETE_DIAG, 0), 0);
					res = 1;
				}
			}		
		}
		return res;
	} else if (
		control_pressed
		&& !alt_pressed
		&& !shift_pressed
		&& !m_model_tree.is_nil ()
		&& (wParam == 'l' || wParam == 'L')
	) {
		HWND wnd = ::GetFocus();
		IRoseClassDiagramPtr diag = m_model_tree->get_item ()->Model->GetActiveDiagram ();
		if (
			wnd
			&& diag
			&& RoseHelper::is_diagram_window (wnd, diag)
		) {
			CmdHandler::instance ()->PostMessage (WM_COMMAND, MAKEWPARAM (ID_RELOCATE_DIAG, 0), 0);
		} else {
			return -1;
		}
		return 1;
	}  else if (
		control_pressed
		&& shift_pressed
		&& !alt_pressed		
		&& !m_model_tree.is_nil ()
		&& (wParam == 'c' || wParam == 'C')
	) {
		HWND wnd = ::GetFocus();
		IRoseClassDiagramPtr diag = m_model_tree->get_item ()->Model->GetActiveDiagram ();
		if (
			wnd
			&& diag
			&& RoseHelper::is_diagram_window (wnd, diag)
		) {
			CmdHandler::instance ()->PostMessage (WM_COMMAND, MAKEWPARAM (ID_COPY_ELEMENTS_DIAG, 0), 0);		
		} else {
			return -1;
		}
		return 1;
	} else if (
		control_pressed
		&& !alt_pressed
		&& !shift_pressed
		&& !m_model_tree.is_nil ()
		&& (wParam == 'f' || wParam == 'F')
	) {				
		unsigned int id = ID_MODEL_SEARCH;
		CmdHandler::instance ()->PostMessage (WM_COMMAND, MAKEWPARAM (id, 0), 0);		
		
		return 1;
	} else if (
		control_pressed
		&& !alt_pressed
		&& !shift_pressed
		&& !m_model_tree.is_nil ()
		&& (wParam == 'g' || wParam == 'G')
	) {
		HWND wnd = ::GetFocus();		
		unsigned int id = 0;
		if (wnd == m_wndTree) {
			id = ID_GENERATE_TREE;				
		} else {
			id = ID_GENERATE_DIAG;				
		}
		CmdHandler::instance ()->PostMessage (WM_COMMAND, MAKEWPARAM (id, 0), 0);		
		return 1;
	} else if (
		control_pressed
		&& !alt_pressed
		&& !shift_pressed
		&& !m_model_tree.is_nil ()
		&& (wParam == 'n' || wParam == 'N')
	) {
		HWND wnd = ::GetFocus();		
		unsigned int id = 0;
		if (wnd == m_wndTree) {
			id = ID_NEW_ELEMENT_TREE;				
		} else {
			id = ID_NEW_ELEMENT_DIAG;				
		}
		CmdHandler::instance ()->PostMessage (WM_COMMAND, MAKEWPARAM (id, 0), 0);		
		return 1;
	} else if (
		page_up_pressed
		&& control_pressed
		&& !shift_pressed
		&& !alt_pressed
		&& !m_model_tree.is_nil ()
	) {
		HWND wnd = ::GetFocus();
		IRoseDiagramPtr diag = m_model_tree->get_item ()->Model->GetActiveDiagram ();
		if (
			wnd
			&& diag
			&& RoseHelper::is_diagram_window (wnd, diag)
		) {
			IRoseElementPtr context = RoseHelper::get_context (diag);
			if (context) {
				RoseHelper::show_item (context);
			}
		} else {
			return -1;
		}
		return 1;
	} else if (
		home_pressed
		&& control_pressed
		&& !shift_pressed
		&& !alt_pressed
		&& !m_model_tree.is_nil ()
	) {
		HWND wnd = ::GetFocus();
		IRoseClassDiagramPtr diag = m_model_tree->get_item ()->Model->GetActiveDiagram ();
		if (
			wnd
			&& diag
			&& RoseHelper::is_diagram_window (wnd, diag)
		) {
			IRoseElementPtr elem = RoseHelper::get_main_model_element ();
			if (elem) {
				if (elem->IsClass (CATEGORY_TYPE)) {
					IRoseCategoryPtr main_cat = elem;
					IRoseClassDiagramCollectionPtr cls_diags = main_cat->ClassDiagrams;
					if (cls_diags->Count > 0) {
						cls_diags->GetAt (1)->Activate ();
					}
				}
			}
		} else {
			return -1;
		}
		return 1;
	} else if (
		control_pressed
		&& right_pressed
		&& !alt_pressed
		&& !shift_pressed
		&& !m_model_tree.is_nil ()
	) {
		HWND wnd = ::GetFocus();
		IRoseDiagramPtr diag = m_model_tree->get_item ()->Model->GetActiveDiagram ();
		if (
			wnd
			&& diag
			&& RoseHelper::is_diagram_window (wnd, diag)
		) {
			IRoseElementPtr context = RoseHelper::get_context (diag);
			if (context) {
				IRoseDiagramCollectionPtr diags = RoseHelper::get_diagrams (context);
				short curr_diag_index = diags->IndexOf (diag);
				if (curr_diag_index > 0 && curr_diag_index < diags->Count) {
					IRoseDiagramPtr next_diag = diags->GetAt (curr_diag_index + 1);
					next_diag->Activate ();
				}
			}
		} else {
			return -1;
		}
		return 1;
	} else if (
		control_pressed
		&& left_pressed
		&& !alt_pressed
		&& !shift_pressed
		&& !m_model_tree.is_nil ()
	) {
		HWND wnd = ::GetFocus();
		IRoseDiagramPtr diag = m_model_tree->get_item ()->Model->GetActiveDiagram ();
		if (
			wnd
			&& diag
			&& RoseHelper::is_diagram_window (wnd, diag)
		) {
			IRoseElementPtr context = RoseHelper::get_context (diag);
			if (context) {
				IRoseDiagramCollectionPtr diags = RoseHelper::get_diagrams (context);
				short curr_diag_index = diags->IndexOf (diag);
				if (curr_diag_index > 1 && curr_diag_index <= diags->Count) {
					IRoseDiagramPtr next_diag = diags->GetAt (curr_diag_index - 1);
					next_diag->Activate ();
				}
			}
		} else {
			return -1;
		}
		return 1;
	} else if (
		control_pressed
		&& shift_pressed
		&& !left_pressed
		&& !right_pressed
		&& !alt_pressed
		&& (wParam == 'r' || wParam == 'R')
		&& !m_model_tree.is_nil ()
	) {
		bool need_relocate = Other::get_can_association_relocate();
		if (need_relocate) {			
			bool need_save = false;
			IRoseClassCollectionPtr classes = m_model_tree->get_item ()->Model->GetAllClassesEx (VARIANT_TRUE, VARIANT_TRUE);
			short count = classes->Count;
			for (short i = 1; i <= count; ++i) {
				IRoseClassPtr cls = classes->GetAt (i);
				IRoseCategoryPtr cls_cat = RoseHelper::get_nearest_category (cls);
				IRoseRoleCollectionPtr rl_attrs = cls->GetAssociateRoles();
				int rl_attrs_count = rl_attrs->Count;
				for (short i = 1; i <= rl_attrs_count; i++) {
					IRoseRolePtr rl_attr = rl_attrs->GetAt(i);
					if (rl_attr->Navigable) {
						IRoseAssociationPtr assoc = rl_attr->Association;
						IRoseCategoryPtr assoc_cat = assoc->ParentCategory;
						if (
							get_rose_element_uid(assoc_cat) != get_rose_element_uid(cls_cat)
						) {
							MDPSupport::CatLockerFacade_var cls_clf = 
								MDPSupport::CatLockerFacadeFactory::make (cls_cat);
							
							MDPSupport::CatLockerFacade_var assoc_clf = 
								MDPSupport::CatLockerFacadeFactory::make (assoc_cat);

							if (cls_clf->try_change () && assoc_clf->try_change ()) {
								cls_cat->RelocateAssociation (assoc);
								need_save = true;

								cls_clf->do_change ();
								assoc_clf->do_change ();
							}
						}
					}
				}

			}
			
			/*if (need_save) {
				rose_app->Save (VARIANT_TRUE);
			}*/
		}
	} else if (
		wParam == VK_F4
		&& !control_pressed
		&& !alt_pressed
		&& !shift_pressed
		&& !m_model_tree.is_nil ()
	) {
		HWND wnd = ::GetFocus();
		IRoseDiagramPtr diag = m_model_tree->get_item ()->Model->GetActiveDiagram ();
		LRESULT res (1); //F4 никогда не отдаём Розе
		if (
			wnd
			&& diag
			&& RoseHelper::is_diagram_window (wnd, diag)
		) {			
			IRoseItemCollectionPtr selections = diag->GetSelectedItems ();
			short count = selections->Count;
			if (count) {
				IRoseItemPtr item = selections->GetAt (1);
				if (
					!item->IsClass ("DependencyRelation") 
					&& !item->IsClass (ROSE_OBJECT_TYPE)
				) {
					CmdHandler::instance ()->PostMessage (WM_COMMAND, MAKEWPARAM (ID_PROPERTIES_DIAG, 0), 0);
					res = 1;
				}
			}		
		}
		return res;
	}
	
	return -1;
	//#UC END# *46F9ECCE036B_45B8B8290167*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

