////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CmdHandler.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::CmdHandler
//
// класс обработчик команд меню
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CmdHandler.h"
// by <<uses>> dependencies
#include "MDProcess/MDAAddinLib/Commands/Commands.h"
#include "MDProcess/MDAAddinLib/Commands/CommandsFactories.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/MenuFactory.h"
#include "MDProcess/MDAAddinLib/Commands/Commands.h"
#include "MDProcess/MDAAddinLib/Commands/CommandsFactories.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupportFactories.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/Settings.h"
#include "MDProcess/MDAAddinLib/MDAGui/DeleteQuestion.h"
#include "MDProcess/MDAAddinLib/Helpers/Helpers.h"
#include "MDProcess/MDAAddinLib/Helpers/HelpersFactories.h"
#include "ace/Process.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"

//#UC START# *46480B2E006D_CUSTOM_INCLUDES*
#include "shared/GCL/alg/container_op.h"
#include <boost/bind.hpp>
//#UC END# *46480B2E006D_CUSTOM_INCLUDES*


//#UC START# *46480B2E006D*
#define ON_COMMAND_RANGE1(x,handler) \
	ON_COMMAND_RANGE(x, x, handler)

BEGIN_MESSAGE_MAP(CmdHandler, CStatic)		
	ON_COMMAND_RANGE(ID_COPY_ELEMENTS_DIAG, ID_COLORIZE_DIAG, on_command_from_diag)
	ON_COMMAND_RANGE1(ID_CONTROL_ALL_DIAG, on_command_from_diag)
	ON_COMMAND_RANGE1(ID_CONTROL_FILE_DIAG, on_command_from_diag)
	ON_COMMAND_RANGE1(ID_UNCONTROL_ALL_DIAG, on_command_from_diag)
	ON_COMMAND_RANGE1(ID_UNCONTROL_DIAG, on_command_from_diag)
	ON_COMMAND_RANGE1(ID_NEW_STATEDIAGRAM_DIAG, on_command_from_diag)
	ON_COMMAND_RANGE1(ID_VIEW_ELEM_IN_CONFLUENCE_DIAG, on_command_from_diag)
	ON_COMMAND_RANGE1(ID_OPEN_DIAGRAM_DIAG, on_command_from_diag)
	ON_COMMAND_RANGE1(ID_NEW_CLASSDIAG_DIAG, on_command_from_diag)	
	ON_COMMAND_RANGE1(ID_GENERATE_NO_REP_DIAG, on_command_from_diag)
	ON_COMMAND_RANGE1(ID_GENERATION_WITH_CONSUMERS_DIAG, on_command_from_diag)
	ON_COMMAND_RANGE1(ID_GENERATION_WITH_CONSUMERS_NOREP_DIAG, on_command_from_diag)
	ON_COMMAND_RANGE1(ID_OPEN_EXTRERNAL_APP_DIAG, on_command_from_diag)
	
	ON_COMMAND_RANGE1(ID_LOCK_ALL_DIAG, on_command_from_diag)
	ON_COMMAND_RANGE1(ID_UNLOCK_ALL_DIAG, on_command_from_diag)
	
	
	ON_COMMAND_RANGE(ID_PROPERTIES_TREE, ID_COLORIZE_TREE, on_command_from_tree)
	ON_COMMAND_RANGE1(ID_VIEW_ELEM_IN_CONFLUENCE_TREE, on_command_from_tree)
	ON_COMMAND_RANGE1(ID_CONTROL_ALL_TREE, on_command_from_tree)
	ON_COMMAND_RANGE1(ID_CONTROL_FILE_TREE, on_command_from_tree)
	ON_COMMAND_RANGE1(ID_UNCONTROL_ALL_TREE, on_command_from_tree)
	ON_COMMAND_RANGE1(ID_UNCONTROL_TREE, on_command_from_tree)
	ON_COMMAND_RANGE1(ID_NEW_STATEDIAGRAM_TREE, on_command_from_tree)
	ON_COMMAND_RANGE1(ID_GENERATE_NO_REP_TREE, on_command_from_tree)
	ON_COMMAND_RANGE1(ID_GENERATION_WITH_CONSUMERS_TREE, on_command_from_tree)
	ON_COMMAND_RANGE1(ID_GENERATION_WITH_CONSUMERS_NOREP_TREE, on_command_from_tree)
	ON_COMMAND_RANGE1(ID_LOCK_ALL_TREE, on_command_from_tree)
	ON_COMMAND_RANGE1(ID_UNLOCK_ALL_TREE, on_command_from_tree)
	ON_COMMAND_RANGE1(ID_OPEN_EXTRERNAL_APP_TREE, on_command_from_tree)
	
	ON_COMMAND(ID_MODEL_SEARCH, on_search_command)

	ON_MESSAGE(WM_BROWSE_IN_DIAG, on_browse_in_diag)
	ON_MESSAGE(WM_DBL_CLICK, on_dbl_click)
	ON_MESSAGE(WM_UNDO_CHANGE_NAME, on_undo_change_name)
	ON_MESSAGE(WM_OPEN_PROPERTIES, on_open_properties)
	ON_MESSAGE(WM_CONTINUE_PROCESSING_MSG, on_continue_processing)
	ON_MESSAGE(WM_CONTEXTMENU, on_context_menu)

END_MESSAGE_MAP( )

bool CmdHandler::tool_tip_callback (PPTOOLTIP_INFO& ti) {
	class helper {
	public:
		static const std::string get_normalized_name (const IRoseElementPtr& elem, bool& foriegn_diag) {
			IRoseDiagramPtr diag = RoseHelper::rose_app ()->CurrentModel->GetActiveDiagram ();
			IRoseElementPtr diag_parent = RoseHelper::get_context (diag);
			
			IRoseItemPtr item = RoseHelper::get_nearest_container (elem);
			IRoseElementPtr item_parent = item != 0 ? RoseHelper::get_context (item) : 0;

			std::string res;
			if (
				item_parent 
				&& diag_parent 
				&& get_rose_element_uid(item_parent) == get_rose_element_uid(diag_parent)
			) {
				foriegn_diag = false;
				res = item->Name;
			} else {
				foriegn_diag = true;
				if (diag_parent && item) {
					std::string diag_parent_name = RoseHelper::get_full_name (diag_parent);
					std::string item_name = RoseHelper::get_full_name (item);
					GCL::StrVector diag_parent_vec = GCL::split_string_by_sub_string (
						diag_parent_name.c_str (), "::"
					);
					GCL::StrVector item_name_vec = GCL::split_string_by_sub_string (
						item_name.c_str (), "::"
					);
					GCL::StrVector norm_name_vec = GCL::normalize (diag_parent_vec, item_name_vec, false);
					res = GCL::join (norm_name_vec, "::");
				}
			}
			return res;
		}
		static const std::string prepare_tooltip_text (IRoseElementPtr elem, bool on_diagram) {
			IRoseElementPtr real_elem;
			if (elem->IsClass ("Association")) {
				IRoseRolePtr role = RoseHelper::get_role((IRoseAssociationPtr)elem);				
				real_elem = role;		
			} else {
				real_elem = elem;
			}

			std::string ret;
			if (real_elem) {
				std::string text ("<table><tr>");
				text += "<td><center><h3>";
				text += "<a href=\"";				
				text += Helpers::KViewElementFactory::get ().make_view_link (real_elem);
				text += "\">";
				std::string name = real_elem->Name;
				if (name.empty ()) {
					name = real_elem->IdentifyClass ();
				}
				text += name;	
				text += "</a>";
				text += "</h3></center>";
				std::string overwriten_prop = RoseHelper::get_overwriten_prop (real_elem);
				bool foreign = false;
				std::string normalized_name = on_diagram ? helper::get_normalized_name (real_elem, foreign) : "";
				if (foreign == false) {
					normalized_name.clear ();
				}
				
				bool need_underline = overwriten_prop.empty () == false || normalized_name.empty () == false;
				if (need_underline) {
					text += "<br><hr color=green>";	
				}
				if (overwriten_prop.empty () == false) {
					text += "<br>";
					text += overwriten_prop;
				}
				if (normalized_name.empty () == false) {
					text += "<br>";	
					text += "path = ";
					text += normalized_name;
				}							
				text += "</td>";
				text += "</tr></table>";
				GCL::str_replace (text, "\r\n", "<br>");
				GCL::str_replace (text, "\n", "<br>");
				ret = text;
			}			
			
			return ret;
		}
	};
	bool res = false;
	CPoint pt;
	GetCursorPos (&pt);
	IRoseApplicationPtr app = RoseHelper::rose_app ();
	try {
		if (app && app->CurrentModel) {
			IRoseDiagramPtr diag = app->CurrentModel->GetActiveDiagram ();
			bool on_diagram = false;
			IRoseElementPtr elem;
			CRect elem_bounds;
			HWND wnd = ::WindowFromPoint (pt);		
			CWnd* top_level_wnd = (wnd != 0 ? CWnd::FromHandle (wnd)->GetTopLevelParent (): 0);
			HWND top_level = (top_level_wnd != 0 ? top_level_wnd->GetSafeHwnd () : 0);
			if (wnd != 0 && (::GetForegroundWindow () == wnd || ::GetForegroundWindow () == top_level)) {
				if (		
					diag
					&& RoseHelper::is_diagram_window (wnd, diag)
				) {	
					POINT in_point = {pt.x, pt.y};
					if (RoseHelper::point_to_diagram (in_point, diag)) {		
						IRoseItemViewCollectionPtr views = diag->GetItemViews ();
						short count = views->Count;
						for (short i = 1; i <= count; ++i) {
							IRoseItemViewPtr view = views->GetAt (i);			
							if (view->PointInView ((short)in_point.x, (short)in_point.y)) {
								elem = view->GetItem ();
								int view_x = view->XPosition;
								int view_y = view->YPosition;
								int view_width = view->GetWidth ();
								int view_height = view->GetHeight ();

								POINT top_left = {view_x - view_width/2, view_y - view_height/2};
								POINT bottom_right = {view_x + view_width/2, view_y + view_height/2};
								
								elem_bounds.SetRect (top_left, bottom_right);
								
								/*HWND diag_wnd = ::WindowFromPoint (pt);
							
								if (diag_wnd != NULL) {							
									::ClientToScreen (diag_wnd, &top_left);
									::ClientToScreen (diag_wnd, &bottom_right);
									elem_bounds.SetRect (top_left, bottom_right);
								}*/
								break;
							}
						}
					}
					//
					if (elem) {			
						on_diagram = true;
					}
				} else if (m_explorer) {
					ATLControls::CTreeItem tree_item = m_explorer->hit_test (pt.x, pt.y);
					if (tree_item.IsNull () == false) {
						ModelTreeItem* model_item = reinterpret_cast<ModelTreeItem*> (tree_item.GetData ());
						elem = model_item->get_item ();
						tree_item.GetRect (&elem_bounds, true);
						//m_explorer->get_wnd_tree ().ClientToScreen (&elem_bounds);
						on_diagram = false;
					}
				}
				if (elem) {
					std::string text = helper::prepare_tooltip_text (elem, on_diagram);
					ti.sTooltip = text.c_str ();
					ti.rectBounds = elem_bounds;
					ti.nMask &= PPTOOLTIP_MASK_DIRECTION;
					ti.nMask &= PPTOOLTIP_MASK_EFFECT;
					ti.nMask &= PPTOOLTIP_MASK_COLORS;
					ti.nMask &= PPTOOLTIP_MASK_BEHAVIOUR;
					ti.nMask &= PPTOOLTIP_MASK_TRANSPARENCY;

					res = true;
				}
			}
		}
	}  catch (_com_error& ex) {
		LOG_E(("_com_error at tool_tip_callback: %s", ex.ErrorMessage ()));
	} CATCH_AND_LOG("in tooltip");
	return res;
}
//#UC END# *46480B2E006D*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// константы
const unsigned long CmdHandler::WM_SHOW_TOOL_TIP = WM_USER + 4; // сообщение для показа тултипа параметр lParam сообщение содержит true, если инадо показать тултип, false - если его надо скрыть
const unsigned long CmdHandler::WM_BROWSE_IN_DIAG = WM_USER + 3; // сообщение для показа элемента на диаграмме
const unsigned long CmdHandler::WM_CONTINUE_PROCESSING_MSG = WM_USER + 2; // идентифактор служебного сообщения - говорящего о том, что можно продолжить обрабоотку комманд
const unsigned long CmdHandler::WM_DBL_CLICK = WM_USER + 5; // дабл-клик на диаграмме
const unsigned long CmdHandler::WM_UNDO_CHANGE_NAME = WM_USER + 6; // идентификатор сообщения для отмены изменения имени, это сообщение используется для отмены изменения имени, которое может произойти из-за того, что роза посчитает, что новый префикс к вью элемента - это новой имя
const unsigned long CmdHandler::WM_OPEN_PROPERTIES = WM_USER + 7; // сообщение для открытия свойств элемента
const unsigned long CmdHandler::TOOLTIP_TIMER = 1; // идентификатор таймера, запускаемого для показа тултипа

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструктор по умолчанию
CmdHandler::CmdHandler ()
//#UC START# *4648100B036B_BASE_INIT*
: m_explorer (0)
, m_can_process_message (true)
//#UC END# *4648100B036B_BASE_INIT*
{
	//#UC START# *4648100B036B_BODY*
	//#UC END# *4648100B036B_BODY*
}

CmdHandler::~CmdHandler () {
	//#UC START# *46480B2E006D_DESTR_BODY*
	//#UC END# *46480B2E006D_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// очистка объекта
void CmdHandler::clear () {
	//#UC START# *47C4080E0398*
#ifdef _DEBUG
	LOG_D ((GDS_CURRENT_FUNCTION));
#endif
	m_element_tool_tip = 0;
	m_mouse_event_handler = 0;
	m_explorer = 0;
	//#UC END# *47C4080E0398*
}

// метод создает невидимое окно CmdHandler
void CmdHandler::create () {
	//#UC START# *464811150119*
	RECT r;
	this->Create (NULL, 0, r,AfxGetMainWnd ());
	m_element_tool_tip = new WinGUI::CPPToolTip ();
	if (m_element_tool_tip->Create (this)) {
		const unsigned long initial_delay = Settings::get_tooltip_initial_delay();
		m_element_tool_tip->SetDelayTime (PPTOOLTIP_TIME_INITIAL, initial_delay);		

		m_element_tool_tip->SetTransparency (15);
		m_element_tool_tip->SetSize(WinGUI::CPPToolTip::PPTTSZ_MARGIN_CX, 2);
		m_element_tool_tip->SetSize(WinGUI::CPPToolTip::PPTTSZ_MARGIN_CY, 2);
		
		DWORD dwBehaviour = 0;
		dwBehaviour |= PPTOOLTIP_CLOSE_LEAVEWND;
		dwBehaviour |= PPTOOLTIP_NOCLOSE_OVER;
		dwBehaviour |= PPTOOLTIP_DISABLE_AUTOPOP;
		dwBehaviour |= PPTOOLTIP_MULTIPLE_SHOW;
		m_element_tool_tip->SetBehaviour (dwBehaviour);

		m_element_tool_tip->AddDynamicTool (
			this
			, boost::bind (&CmdHandler::tool_tip_callback, this, _1)
		);
	}	
	m_mouse_event_handler = new MouseEventHandler (*this);
	//#UC END# *464811150119*
}

// функция для распределения команды.
// elem - элемент, для которого выполняется команда
// command_id  - идентификатор команды
void CmdHandler::dispatch_command (IRoseElementPtr elem, unsigned int command_id) const {
	//#UC START# *4648120B036B*
	/*if (m_commands.find (command_id) != m_commands.end ())*/ {
		IRoseDiagramPtr diag = RoseHelper::rose_app ()->CurrentModel->GetActiveDiagram ();
		IRoseElementPtr item;
		if (elem->IsClass ("Diagram")) {
			diag = (IRoseDiagramPtr)elem;
			item = RoseHelper::get_context (diag);		
		} else {
			item = elem;
		}
		switch (command_id) {
			case ID_PROPERTIES_DIAG:
			case ID_PROPERTIES_TREE: Commands::CmdManagerFactory::get ().properties (item, false, true);
				break;

			case ID_LOCK_DIAG:
			case ID_LOCK_TREE: {
					IRoseCategoryPtr cat;
					if (item->IsClass (CATEGORY_TYPE)) {
						cat = item;
					} else {
						cat = RoseHelper::get_parent_category (item);
					}
					if (RoseHelper::can_modify_elem (cat) == true) {
						Commands::CmdManagerFactory::get ().unlock (cat);
					} else {
						Commands::CmdManagerFactory::get ().lock (cat);
					}
				}
				break;

			case ID_LOCK_ALL_DIAG:
			case ID_LOCK_ALL_TREE: {
					IRoseCategoryPtr cat;
					if (item->IsClass (CATEGORY_TYPE)) {
						cat = item;
					} else {
						cat = RoseHelper::get_parent_category (item);
					}

					IRoseCategoryCollectionPtr cats = cat->GetAllCategories ();
					IRoseCategoryCollectionPtr cats_to_lock (__uuidof(RoseCategoryCollection));
					cats_to_lock->Add (cat);
					cats_to_lock->AddCollection (cats);
										
					Commands::CmdManagerFactory::get ().lock (cats_to_lock);					
				}
				break;

			case ID_UNLOCK_ALL_DIAG:
			case ID_UNLOCK_ALL_TREE: {
					IRoseCategoryPtr cat;
					if (item->IsClass (CATEGORY_TYPE)) {
						cat = item;
					} else {
						cat = RoseHelper::get_parent_category (item);
					}

					IRoseCategoryCollectionPtr cats = cat->GetAllCategories ();
					IRoseCategoryCollectionPtr cats_to_lock (__uuidof(RoseCategoryCollection));
					cats_to_lock->Add (cat);
					cats_to_lock->AddCollection (cats);
										
					Commands::CmdManagerFactory::get ().unlock (cats_to_lock);					
				}
				break;

			case ID_ROLLBACK_DIAG:
			case ID_ROLLBACK_TREE: 
				{
					IRoseCategoryPtr cat;
					if (item->IsClass (CATEGORY_TYPE)) {
						cat = item;
					} else {
						cat = RoseHelper::get_parent_category (item);
					}
					Commands::CmdManagerFactory::get ().rollback (cat);
				}
				break;

			case ID_REPORT_DIAG:
			case ID_REPORT_TREE: Commands::CmdManagerFactory::get ().view_reports (item);
				break;

			case ID_SEARCH_DIAG:
			case ID_SEARCH_TREE: Commands::CmdManagerFactory::get ().search (item);
				break;

			case ID_DELETE_DIAG:
			case ID_DELETE_TREE: 
				{
					DeleteQuestion question (elem);
					if (question.DoModal () == IDOK) {
						Commands::CmdManagerFactory::get ().remove (elem);
					}
				}
				break;
			
			case ID_NEW_CLASS_DIAG:
			case ID_NEW_CLASS_TREE: Commands::CmdManagerFactory::get ().new_class (item);
				break;

			case ID_NEW_ATTR_DIAG:
			case ID_NEW_ATTRIBUTE_TREE: Commands::CmdManagerFactory::get ().new_attribute (item);
				break;
			
			case ID_NEW_OPERATION_DIAG:
			case ID_NEW_OPERATION_TREE: Commands::CmdManagerFactory::get ().new_operation (item);
				break;

			case ID_NEW_SEQUENCEDIAG_DIAG:
			case ID_NEW_SEQUENCEDIAG_TREE: Commands::CmdManagerFactory::get ().new_sequence_diagram (item);
				break;

			case ID_NEW_ATTRKEY_DIAG:
			case ID_NEW_ATTRKEY_TREE: Commands::CmdManagerFactory::get ().new_attribute_key (item);
				break;

			case ID_NEW_CATEGORY_DIAG:
			case ID_NEW_CATEGORY_TREE: Commands::CmdManagerFactory::get ().new_package (item);
				break;

			case ID_NEW_CLASSDIAG_DIAG:
			case ID_NEW_CLASSDIAG_TREE: Commands::CmdManagerFactory::get ().new_class_diagram (item);
				break;
			
			case ID_NEW_ELEMENT_TREE:
			case ID_NEW_ELEMENT_DIAG: Commands::CmdManagerFactory::get ().new_element (item, "all");
				break;

			case ID_COLORIZE_DIAG: 
			case ID_COLORIZE_TREE: Commands::CmdManagerFactory::get ().colorize (diag);
				break;
			
			case ID_BROWSE_IN_DIAG_TREE: RoseHelper::browse_item (item);
				break;

			case ID_SHOW_IN_BROWSER: 
				{
					if (m_explorer) {						
						std::string uid = get_rose_element_uid(item);
						m_explorer->select_item (uid);
					}
				}
				break;

			case ID_GENERATE_DIAG:
			case ID_GENERATE_TREE: Commands::CmdManagerFactory::get ().generate (item, true);
				break;

			case ID_GENERATION_WITH_CONSUMERS_DIAG:
			case ID_GENERATION_WITH_CONSUMERS_TREE: Commands::CmdManagerFactory::get ().generate_with_consumers (item, true);
				break;

			case ID_GENERATION_WITH_CONSUMERS_NOREP_DIAG:
			case ID_GENERATION_WITH_CONSUMERS_NOREP_TREE: Commands::CmdManagerFactory::get ().generate_with_consumers (item, false);
				break;
			
			case ID_GENERATE_NO_REP_DIAG:
			case ID_GENERATE_NO_REP_TREE: Commands::CmdManagerFactory::get ().generate (item, false);
				break;

			case ID_RELOCATE_DIAG: {
					IRoseElementPtr new_parent = RoseHelper::get_context (diag);
					std::string caption ("Перемещение элемента ");
					caption += elem->IdentifyClass ();
					std::string text ("Вы уверены, что хотите переместить элемент:\n");
					text += RoseHelper::get_full_name (elem);
					text += "\nв ";
					text += RoseHelper::get_full_name (new_parent);
					text += "?";
					int res = const_cast<CmdHandler*>(this)->MessageBox (
						text.c_str ()
						, caption.c_str ()
						, MB_OKCANCEL | MB_ICONQUESTION | MB_TASKMODAL
					);
					if (res == IDOK) {					
						bool is_new = false;
						if (Commands::CmdManagerFactory::get ().relocate (elem, new_parent, is_new)) {
							if (is_new == false && m_explorer) {
								m_explorer->move_rose_item (elem, new_parent);
							}			
						}
					}
				}
				break;
			case ID_COPY_ELEMENTS_DIAG: {
					IRoseElementPtr new_parent = RoseHelper::get_context (diag);
					std::string caption ("Копирование элемента ");
					caption += elem->IdentifyClass ();
					std::string text ("Вы уверены, что хотите скопировать элемент:\n");
					text += RoseHelper::get_full_name (elem);
					text += "\nв ";
					text += RoseHelper::get_full_name (new_parent);
					text += "?";
					int res = ::MessageBox (
						AfxGetMainWnd ()->GetSafeHwnd (), text.c_str (), caption.c_str (), MB_OKCANCEL | MB_ICONQUESTION
					);
					if (res == IDOK) {					
						if (Commands::CmdManagerFactory::get ().copy (elem, new_parent)) {
							/*if (is_new == false && m_explorer) {
								m_explorer->move_rose_item (elem, new_parent);
							}*/			
						}
					}
				}
				break;
			case ID_VIEW_ELEM_IN_CONFLUENCE_DIAG:
			case ID_VIEW_ELEM_IN_CONFLUENCE_TREE: Commands::CmdManagerFactory::get ().view_elem_in_confluence (item);
				break;
			
			case ID_CONTROL_FILE_DIAG:
			case ID_CONTROL_FILE_TREE: {
					IRoseCategoryPtr cat = item;
					if (cat) {
						Commands::CmdManagerFactory::get ().control_to_file (cat);
					}
				}
				break;

			case ID_CONTROL_ALL_DIAG:
			case ID_CONTROL_ALL_TREE: {
					IRoseCategoryPtr cat = item;
					if (cat) {
						Commands::CmdManagerFactory::get ().control_all (cat);
					}
				}
				break;
			
			case ID_UNCONTROL_ALL_DIAG:
			case ID_UNCONTROL_ALL_TREE: {
					IRoseCategoryPtr cat = item;
					if (cat) {
						Commands::CmdManagerFactory::get ().uncontrol_all (cat);
					}
				}
				break;
			case ID_UNCONTROL_DIAG:
			case ID_UNCONTROL_TREE: {
					IRoseCategoryPtr cat = item;
					if (cat) {
						Commands::CmdManagerFactory::get ().uncontrol (cat);
					}
				}
				break;

			case ID_NEW_STATEDIAGRAM_TREE:
			case ID_NEW_STATEDIAGRAM_DIAG: Commands::CmdManagerFactory::get ().new_state_diagram (item);
				break;

			case ID_OPEN_DIAGRAM_DIAG: {
					IRoseDiagramCollectionPtr diags = RoseHelper::get_diagrams (item);
					if (diags && diags->Count > 0) {
						diags->GetAt (1)->Activate ();
					}
				}
				break;

			case ID_OPEN_EXTRERNAL_APP_DIAG:
			case ID_OPEN_EXTRERNAL_APP_TREE: {
				ACE_Process_Options opts;
				if (item->IsClass (ROSE_ITEM_TYPE)) {
					opts.command_line (
						"%s -uid %s -stereotype %s"
						, Settings::get_external_command_path ().c_str ()
						, get_rose_element_uid (item).c_str ()
						, static_cast<const char*> (((IRoseItemPtr)item)->GetStereotype ())
					);
				} else {
					opts.command_line (
						"%s -uid %s"
						, Settings::get_external_command_path ().c_str ()
						, get_rose_element_uid (item).c_str ()
					);
				}

				ACE_Process proc;
				pid_t pid = proc.spawn(opts);
				if(pid == -1) {
					std::string message ("Не удалось запустить внешнее приложение, проверьте параметр: \"");
					message += Settings::external_command_path_param_name ();
					message += "\" в реестре или ini-файле";
					

					::MessageBox (
						AfxGetMainWnd ()->GetSafeHwnd ()
						, message.c_str ()
						, "Ошибка при запуске приложения"
						, MB_OK | MB_ICONERROR
					);
				}
				break;
			}
		}
	}	
	//#UC END# *4648120B036B*
}

// вызывается при попытке перейти по ссылке из К в розу - показывает элемент на диаграмме
LRESULT CmdHandler::on_browse_in_diag (WPARAM w_param, LPARAM l_param) {
	//#UC START# *468CB057000F*
	if (m_can_process_message == true) {
		m_can_process_message = false;
		IRoseApplicationPtr app = RoseHelper::rose_app ();
		IRoseModelPtr model = app->CurrentModel;
		char* guid = (char*)l_param;
		
		IRoseItemPtr item = ModelSearcherFactory::get ().search (guid);

		delete guid;
		if (item != NULL) {
			RoseHelper::browse_item (item);
		}
		::PostMessage (m_hWnd, WM_CONTINUE_PROCESSING_MSG, 0, 0);
	}
	return S_OK;
	//#UC END# *468CB057000F*
}

// обработчик команд с диграммы
void CmdHandler::on_command_from_diag (unsigned int id) {
	//#UC START# *46481218031C*
	if (m_can_process_message == true) {
		m_can_process_message = false;
		IRoseDiagramPtr diag = RoseHelper::rose_app ()->CurrentModel->GetActiveDiagram ();
		IRoseItemCollectionPtr selections = diag->GetSelectedItems ();

		IRoseItemCollectionPtr items (__uuidof(RoseItemCollection));
		if (selections->Count > 0) {
			short selections_count = selections->Count;
			for (short i = 1; i <= selections_count; ++i) {
				IRoseItemPtr item = selections->GetAt (i);
				if (item->IsClass("Association")) {
					item = RoseHelper::get_role (item);
				}
				items->Add (item);
			}
		} else if (
			id != ID_RELOCATE_DIAG 
			&& id != ID_COPY_ELEMENTS_DIAG
			&& id != ID_DELETE_DIAG
		) {
			IRoseItemPtr item = RoseHelper::get_context (diag);
			if (item) {
				items->Add (item);
			}
		}
		if (items->Count > 0) {
			//пакетные операции не применимы при создании элемента
			if (
				id != ID_NEW_ELEMENT_DIAG				
			) {				
				short items_count = items->Count;
				for (short i = 1; i <= items_count; ++i) {
					this->dispatch_command (items->GetAt (i), id);
				}
			} else {
				this->dispatch_command (items->GetAt (1), id);
			}
		} else {
			this->dispatch_command (diag, id);
		}
		::PostMessage (m_hWnd, WM_CONTINUE_PROCESSING_MSG, 0, 0);
	}
	//#UC END# *46481218031C*
}

// обработчик команд с дерева-вью
void CmdHandler::on_command_from_tree (unsigned int id) {
	//#UC START# *46481220009C*
	if (m_can_process_message == true && m_explorer != 0) {
		m_can_process_message = false;
		ATLControls::CTreeItem selected_item = m_explorer->get_selected_item ();
		if (selected_item.IsNull ()) {
			return;
		}
		ModelTreeItem* model_item = reinterpret_cast<ModelTreeItem*> (selected_item.GetData ());
		IRoseElementPtr item = model_item->get_item ();
		switch (id) {
			case ID_EXPAND_COLLAPSE_TREE:
			case ID_EXPAND_COLLAPSE_ALL_TREE: {
				::PostMessage (*m_explorer, WM_COMMAND, MAKEWPARAM (id, 0), 0);
			}
				break;
			
			default:
				this->dispatch_command (item, id);
		}	
		::PostMessage (m_hWnd, WM_CONTINUE_PROCESSING_MSG, 0, 0);
	}	
	//#UC END# *46481220009C*
}

// обработчик сообщения WM_CONTEXT_MENU - показывает контекстное меню для диаграммы
LRESULT CmdHandler::on_context_menu (WPARAM w_param, LPARAM l_param) {
	//#UC START# *46725B37002E*
	int res = 0;
	if (m_can_process_message == true) {
		m_can_process_message = false;
		IRoseDiagramPtr diag = RoseHelper::rose_app ()->CurrentModel->GetActiveDiagram ();
		IRoseItemCollectionPtr selections = diag->GetSelectedItems ();
		IRoseElementPtr elem;
		if (selections->Count > 0) {						
			elem = selections->GetAt (1);
			if (elem->IsClass("Association")) {
				elem = RoseHelper::get_role (elem);						
			}
		}
		if (elem == 0) {
			elem = diag;
		}
		Core::Aptr<CMenu> item_menu = MenuFactory::create_menu (MenuFactory::DIAG_MENU, elem);
		if (!item_menu.is_nil ()) {				
			CPoint pos_mouse;
			GetCursorPos(&pos_mouse);			
			res = item_menu->GetSubMenu (0)->TrackPopupMenuEx (TPM_NONOTIFY | TPM_RETURNCMD, pos_mouse.x, pos_mouse.y, this, NULL);
			item_menu->DestroyMenu ();
		}
		::PostMessage (m_hWnd, WM_CONTINUE_PROCESSING_MSG, 0, 0);
	}	
	if (res != 0) {
		::PostMessage (m_hWnd, WM_COMMAND, MAKEWPARAM (res, 0), 0);		
	}
	return S_OK;
	//#UC END# *46725B37002E*
}

// обработчик пользовательского сообщения  WM_CONTINUE_PROCESSING
LRESULT CmdHandler::on_continue_processing (WPARAM w_param, LPARAM l_param) {
	//#UC START# *466402FB03A9*
	m_can_process_message = true;
	return S_OK;
	//#UC END# *466402FB03A9*
}

// обработчик дабл-клика на диаграмме
LRESULT CmdHandler::on_dbl_click (WPARAM w_param, LPARAM l_param) {
	//#UC START# *46FA6A1603B9*
	if (m_can_process_message == true) {
		m_can_process_message = false;
		IRoseDiagramPtr diag = RoseHelper::rose_app ()->CurrentModel->GetActiveDiagram ();
		IRoseItemCollectionPtr selections = diag->GetSelectedItems ();
		IRoseElementPtr elem;
		if (selections->Count > 0) {						
			elem = selections->GetAt (1);
		}
		if (elem) {
			Commands::DblClickAction_var action = Commands::DblClickActionFactory::make ();
			action->action (elem);
		}
		::PostMessage (m_hWnd, WM_CONTINUE_PROCESSING_MSG, 0, 0);
	}
	return S_OK;
	//#UC END# *46FA6A1603B9*
}

// обработчик сообщения WM_OPEN_PROPERTIES
// в параметре l_param хранится указатель на структуру с необходимыми параметрами, память,
// занимаемая этой структурой освобождается в данной функции
LRESULT CmdHandler::on_open_properties (WPARAM w_param, LPARAM l_param) {
	//#UC START# *49081A4A0252*
	if (m_can_process_message == true) {
			m_can_process_message = false;
			IRoseApplicationPtr app = RoseHelper::rose_app ();
			IRoseModelPtr model = app->CurrentModel;
			Core::Aptr<OpenPropertiesParam> param (reinterpret_cast<OpenPropertiesParam*>(l_param));
			if (!param.is_nil ()) {
				IRoseItemPtr item = ModelSearcherFactory::get ().search (param->guid);
				if (item != NULL) {
					MDPSupport::CatLockerFacade_var clf = 
					MDPSupport::CatLockerFacadeFactory::make ((IRoseElementPtr)item);
					if (clf->try_change ()) {
						RoseHelper::ExecResult is_ok = Commands::CmdManagerFactory::get ().properties (item, param->is_new, true);
						if (is_ok != RoseHelper::ER_EDIT_OK && param->is_new) {
							if (item->IsClass("Association")) {
								item = RoseHelper::get_role (item);
							}
							RoseHelper::delete_item (item);
							item = 0;
						}
						clf->do_change ();
					}
				}
			}
			::PostMessage (m_hWnd, WM_CONTINUE_PROCESSING_MSG, 0, 0);
	}
	return S_OK;
	//#UC END# *49081A4A0252*
}

// отдельный обработчик команды ID_MODEL_SEARCH - запускает поиск по модели
void CmdHandler::on_search_command () {
	//#UC START# *464811CA004E*
	if (m_can_process_message == true) {
		m_can_process_message = false;
		Commands::CmdManagerFactory::get ().search (0);
		::PostMessage (m_hWnd, WM_CONTINUE_PROCESSING_MSG, 0, 0);
	}	
	//#UC END# *464811CA004E*
}

// обработчик сообщения WM_UNDO_CHANGE_NAME
LRESULT CmdHandler::on_undo_change_name (WPARAM w_param, LPARAM l_param) {
	//#UC START# *4709D7ED02DE*
	if (m_can_process_message == true) {
			m_can_process_message = false;
			IRoseApplicationPtr app = RoseHelper::rose_app ();
			IRoseModelPtr model = app->CurrentModel;
			char* guid = (char*)l_param;
			IRoseItemPtr item = ModelSearcherFactory::get ().search (guid);
			delete [] guid;
			if (item != NULL) {
				std::string text = item->Name;
				std::string name = RoseHelper::extract_name_from_label (text);
				
				if (name == text && item->IsClass (CATEGORY_TYPE)) {
					//если у папки поменяли букву 'Я' на 'я' - нужно вернуть обратно
					name = GCL::replace_char (name, 'я', 'Я');
				}

				if (name != text) {
					item->Name = name.c_str ();			
					IRoseElementPtr elem = item;
					IRoseClassDiagramPtr diag = model->GetActiveDiagram ();
					if (diag) {
						MDPSupport::CatLockerFacade_var diag_clf = 
							MDPSupport::CatLockerFacadeFactory::make ((IRoseElementPtr)diag);
						if (true == diag_clf->try_change ()) {
							RoseHelper::colorize (diag, item);							
							diag_clf->do_change ();
						}
					}
				}
			}
			::PostMessage (m_hWnd, WM_CONTINUE_PROCESSING_MSG, 0, 0);
	}
	return S_OK;
	//#UC END# *4709D7ED02DE*
}

// устанавливает ссылку на объект-браузер
void CmdHandler::set_explorer (CModelExplorer* explorer) {
	//#UC START# *47C409F601E4*
	m_explorer = explorer;
	//#UC END# *47C409F601E4*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

