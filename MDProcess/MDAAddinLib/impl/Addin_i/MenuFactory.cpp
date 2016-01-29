////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/MenuFactory.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAAddinLib::Addin_i::MenuFactory
// Файл реализации утилитного набора MenuFactory
//
// фабрика для создания меню
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/MenuFactory.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/MenuHelper.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/Settings.h"

//#UC START# *462DB25701A5_CUSTOM_INCLUDES*
#include "MDProcess/MDAGenerator/Resource.h"
//#UC END# *462DB25701A5_CUSTOM_INCLUDES*

namespace MenuFactory {

//#UC START# *462DB25701A5*
//#UC END# *462DB25701A5*

//////////////////////////////////////////////////////////////////////////////////////////
// private member declaration

// возвращает true, если нужна команда lock_all
static bool need_lock_all (IRoseElementPtr elem);

// возвращает true, если нужна команда unlock all
static bool need_unlock_all (IRoseElementPtr elem);

//////////////////////////////////////////////////////////////////////////////////////////
// public member implementation

// создает меню для элемента на диграмме
CMenu* create_diag_menu (IRoseElementPtr elem) {
	//#UC START# *462DB37B0109*
	Core::Aptr<CMenu> menu = new CMenu ();
	if (menu->LoadMenu (IDR_DIAGRAM)) {
		std::string class_type = (const char*)elem->IdentifyClass ();
		for (unsigned int i = 0; i < menu->GetMenuItemCount();) {
			CString str;
			menu->GetMenuString(i, str, MF_BYPOSITION);
			if (strcmp(str, class_type.c_str ()) != 0) {
				menu->DeleteMenu (i, MF_BYPOSITION);
			} else {
				++i;
			}
		}
		CMenu* elem_menu = MenuHelper::get_sub_menu (*menu.ptr (), class_type.c_str ());
		if (elem_menu) {			

			IRoseElementPtr item = elem;			
			if (elem->IsClass ("Diagram")) {
				item = RoseHelper::get_context (elem);
			}
			std::set<std::string> avlaible_types;
			//IRoseItemPtr item_context = RoseHelper::get_context (item);
			for (
				AbstractDumperBase::Templates::const_iterator it = AbstractDumperBase::templates_begin ()
				; it != AbstractDumperBase::templates_end ()
				; it ++
			) {				
				if (
					RoseHelper::is_it_available_by_constr (0, item, it->first)
					&& RoseHelper::is_it_available_by_type (0, item, it->first)
				) {
					std::string stereotype_str = it->first;
					avlaible_types.insert (RoseHelper::extract_stereotype (stereotype_str));
				}
			}
			if (elem->IsClass ("Diagram")) {
				if (item->IsClass (CATEGORY_TYPE)) {
					IRoseCategoryPtr r_cat = item;
					Category_var cat = CategoryFactory::make (r_cat);

					if (cat->is_controlled () == false) {
						MenuHelper::remove_menu_item (*elem_menu, ID_LOCK_DIAG);
						MenuHelper::remove_menu_item (*elem_menu, ID_ROLLBACK_DIAG);
					}

					if (cat->can_control ()) {
						if (cat->is_controlled () == false) {
							MenuHelper::remove_menu_item (*elem_menu, ID_UNCONTROL_DIAG);
							//MenuHelper::remove_menu_item (*elem_menu, ID_UNCONTROL_ALL_DIAG);
						} else {
							MenuHelper::remove_menu_item (*elem_menu, ID_CONTROL_FILE_DIAG);
							//MenuHelper::remove_menu_item (*elem_menu, ID_CONTROL_ALL_DIAG);
						}
					} else {
						MenuHelper::remove_menu_item (*elem_menu, "Units");
					}

					if (!need_lock_all (item)) {
						MenuHelper::remove_menu_item (*elem_menu, ID_LOCK_ALL_DIAG);
					}
					if (!need_unlock_all (item)) {
						MenuHelper::remove_menu_item (*elem_menu, ID_UNLOCK_ALL_DIAG);
					}
				} else {
					MenuHelper::remove_menu_item (*elem_menu, ID_LOCK_DIAG);
					MenuHelper::remove_menu_item (*elem_menu, ID_ROLLBACK_DIAG);
					MenuHelper::remove_menu_item (*elem_menu, ID_UNCONTROL_DIAG);
					MenuHelper::remove_menu_item (*elem_menu, ID_CONTROL_FILE_DIAG);
					MenuHelper::remove_menu_item (*elem_menu, "Units");
					MenuHelper::remove_menu_item (*elem_menu, ID_LOCK_ALL_DIAG);
					MenuHelper::remove_menu_item (*elem_menu, ID_UNLOCK_ALL_DIAG);
				}
								

				if (avlaible_types.find (CATEGORY_TYPE) == avlaible_types.end ()) {
					MenuHelper::remove_menu_item (*elem_menu, ID_NEW_CATEGORY_DIAG);					
				}

				if (avlaible_types.find (CLASS_TYPE) == avlaible_types.end ()) {
					MenuHelper::remove_menu_item (*elem_menu, ID_NEW_CLASS_DIAG);					
				}
			} else if (elem->IsClass (CATEGORY_TYPE)) {
				IRoseCategoryPtr r_cat = elem;
				Category_var cat = CategoryFactory::make (r_cat);

				if (cat->is_controlled () == false) {
					MenuHelper::remove_menu_item (*elem_menu, ID_LOCK_DIAG);
					MenuHelper::remove_menu_item (*elem_menu, ID_ROLLBACK_DIAG);
				}

				if (!need_lock_all (item)) {
					MenuHelper::remove_menu_item (*elem_menu, ID_LOCK_ALL_DIAG);
				}

				if (!need_unlock_all (item)) {
					MenuHelper::remove_menu_item (*elem_menu, ID_UNLOCK_ALL_DIAG);
				}
				
				if (cat->can_control ()) {
					if (cat->is_controlled () == false) {
						MenuHelper::remove_menu_item (*elem_menu, ID_UNCONTROL_DIAG);
					} else {
						MenuHelper::remove_menu_item (*elem_menu, ID_CONTROL_FILE_DIAG);
					}
				} else {
					MenuHelper::remove_menu_item (*elem_menu, "Units");
				}

				if (avlaible_types.find (CATEGORY_TYPE) == avlaible_types.end ()) {
					MenuHelper::remove_menu_item (*elem_menu, ID_NEW_CATEGORY_DIAG);					
				}

				if (avlaible_types.find (CLASS_TYPE) == avlaible_types.end ()) {
					MenuHelper::remove_menu_item (*elem_menu, ID_NEW_CLASS_DIAG);					
				}
			} else if (elem->IsClass (CLASS_TYPE)) {				
				IRoseItemPtr item = elem;

				std::string stereotype = item->Stereotype;
				if (stereotype != "UseCase") {
					MenuHelper::remove_menu_item (*elem_menu, ID_NEW_SEQUENCEDIAG_DIAG);
				}								

				if (avlaible_types.find (OPERATION_TYPE) == avlaible_types.end ()) {
					MenuHelper::remove_menu_item (*elem_menu, ID_NEW_OPERATION_DIAG);					
				}

				if (avlaible_types.find (ATTRIBUTE_TYPE) == avlaible_types.end ()) {
					MenuHelper::remove_menu_item (*elem_menu, ID_NEW_ATTR_DIAG);					
				}

				if (avlaible_types.find (CLASS_TYPE) == avlaible_types.end ()) {
					MenuHelper::remove_menu_item (*elem_menu, ID_NEW_CLASS_DIAG);
					MenuHelper::remove_menu_item (*elem_menu, ID_NEW_CLASSDIAG_DIAG);
				}

				if (avlaible_types.find ("StateMachine") == avlaible_types.end ()) {
					MenuHelper::remove_menu_item (*elem_menu, ID_NEW_STATEDIAGRAM_DIAG);					
				}
				
				IRoseDiagramCollectionPtr diags = RoseHelper::get_diagrams (elem);
				if (!diags || diags->Count == 0) {
					MenuHelper::remove_menu_item (*elem_menu, ID_OPEN_DIAGRAM_DIAG);
				}
			} else if (elem->IsClass (OPERATION_TYPE)) {
			} else if (elem->IsClass (ATTRIBUTE_TYPE)) {
			} else if (elem->IsClass (PARAMETER_TYPE)) {
			} else if (elem->IsClass ("Role")) {
				if (item->Name != _bstr_t ("")) {
					MenuHelper::remove_menu_item (*elem_menu, ID_NEW_ATTRKEY_DIAG);
				}
			} else {
			}
			
			if (RoseHelper::is_incomplete (elem) == true) {
				MenuHelper::remove_menu_item (*elem_menu, ID_GENERATE_DIAG);
				MenuHelper::remove_menu_item (*elem_menu, ID_GENERATE_NO_REP_DIAG);
			}
			
			MDPSupport::CatLockerFacade_var clf = MDPSupport::CatLockerFacadeFactory::make (elem);
			if (clf->can_change () == false) {
				MenuHelper::enable_menu_item (*elem_menu, ID_NEW_CATEGORY_DIAG, false);				
				MenuHelper::enable_menu_item (*elem_menu, ID_NEW_ATTR_DIAG, false);
				MenuHelper::enable_menu_item (*elem_menu, ID_NEW_OPERATION_DIAG, false);
				MenuHelper::enable_menu_item (*elem_menu, ID_NEW_CLASS_DIAG, false);
				MenuHelper::enable_menu_item (*elem_menu, ID_NEW_CLASSDIAG_DIAG, false);
				MenuHelper::enable_menu_item (*elem_menu, ID_NEW_SEQUENCEDIAG_DIAG, false);
				MenuHelper::enable_menu_item (*elem_menu, ID_NEW_ATTRKEY_DIAG, false);					
				MenuHelper::enable_menu_item (*elem_menu, ID_DELETE_DIAG, false);				
			}

			if (clf->can_lock () == true) {
				MenuHelper::modify_menu_item (*elem_menu, ID_LOCK_DIAG, "Lock");
				MenuHelper::remove_menu_item (*elem_menu, ID_ROLLBACK_DIAG);
			} else if (clf->can_commit () == true) {
				MenuHelper::modify_menu_item (*elem_menu, ID_LOCK_DIAG, "Unlock");
			} else {				
				MenuHelper::remove_menu_item (*elem_menu, ID_ROLLBACK_DIAG);

				const MDPSupport::CatsLockStatus& cats_status = MDPSupport::CatsContainerFactory::get ().get_cats_lock_status ();
				MDPSupport::CatsLockStatus::const_iterator it = cats_status.find (get_rose_element_uid(item));

				if (it != cats_status.end ()) {
					std::string locked_text ("Locked by " + it->second.lock_owner_name);

					MenuHelper::modify_menu_item (
						*elem_menu
						, ID_LOCK_DIAG
						, locked_text.c_str ()
					);
				}
				MenuHelper::enable_menu_item (*elem_menu, ID_LOCK_DIAG, false);
			}
			MenuHelper::clear_duplicate_separator (*elem_menu);
			return menu.forget ();
		} else {
			return 0;
		}
	} else {
		DWORD err = GetLastError ();
		LOG_E (("Can't load menu with id IDR_DIAGRAM, error code = %d", err));
		return 0;
	}	
	//#UC END# *462DB37B0109*
}

// создает меню для элемента
CMenu* create_menu (MenuType type, IRoseElementPtr elem) {
	//#UC START# *462DB33A02BF*
	CMenu* menu = 0;
	int open_external_app_id = 0;
	switch (type) {
		case TREE_MENU: {
			menu = create_tree_menu (elem);
			open_external_app_id = ID_OPEN_EXTRERNAL_APP_TREE;

			break;
		}

		case DIAG_MENU: {
			menu = create_diag_menu (elem);
			open_external_app_id = ID_OPEN_EXTRERNAL_APP_DIAG;

			break;
		}

		default:
			break;
	}

	if (menu && !Settings::get_external_command_path ().empty ()) {
		//добавляем последним пунктом меню
		CMenu* submenu = menu->GetSubMenu (0);
		submenu->AppendMenu (MF_SEPARATOR, 0, (LPCTSTR)0);
		submenu->AppendMenu (MF_STRING, open_external_app_id, "Open in external application...");

		MenuHelper::clear_duplicate_separator (*submenu);
	}

	return menu;
	//#UC END# *462DB33A02BF*
}

// создает меню для элемента дерева
CMenu* create_tree_menu (IRoseElementPtr elem) {
	//#UC START# *462DB36C01E4*
	Core::Aptr<CMenu> menu = new CMenu ();
	if (menu->LoadMenu (IDR_TREE)) {
		std::string class_type = (const char*)elem->IdentifyClass ();
		for (unsigned int i = 0; i < menu->GetMenuItemCount();) {
			CString str;
			menu->GetMenuString(i, str, MF_BYPOSITION);
			if (strcmp(str, class_type.c_str ()) != 0) {
				menu->DeleteMenu (i, MF_BYPOSITION);
			} else {
				++i;
			}
		}
		CMenu* elem_menu = MenuHelper::get_sub_menu (*menu.ptr (), class_type.data ());
		if (elem_menu) {
			IRoseItemPtr item = elem;			
			std::set<std::string> avlaible_types;
			if (item) {
				for (
					AbstractDumperBase::Templates::const_iterator it = AbstractDumperBase::templates_begin ()
					; it != AbstractDumperBase::templates_end ()
					; it ++
				) {				
					if (
						RoseHelper::is_it_available_by_constr (0, item, it->first)
						&& RoseHelper::is_it_available_by_type (0, item, it->first)
					) {
						std::string stereotype_str = it->first;
						avlaible_types.insert (RoseHelper::extract_stereotype (stereotype_str));
					}
				}
			}
			if (elem->IsClass ("Diagram")) {
				/*
				IRoseItemPtr context = RoseHelper::get_context (elem);
				if (context->IsClass ("Caetgory")) {
					IRoseCategoryPtr cat = context;
					if (cat->IsControlled () == false) {
						MenuHelper::remove_menu_item (*elem_menu, ID_LOCK_TREE);
						MenuHelper::remove_menu_item (*elem_menu, ID_ROLLBACK_TREE);					
					}
				}
				*/
			} else if (elem->IsClass (CATEGORY_TYPE)) {
				IRoseCategoryPtr r_cat = item;
				Category_var cat = CategoryFactory::make (r_cat);

				if (cat->is_controlled () == false) {
					MenuHelper::remove_menu_item (*elem_menu, ID_LOCK_TREE);
					MenuHelper::remove_menu_item (*elem_menu, ID_ROLLBACK_TREE);						
				}
				
				if (!need_lock_all (item)) {
					MenuHelper::remove_menu_item (*elem_menu, ID_LOCK_ALL_TREE);
				}

				if (!need_unlock_all (item)) {
					MenuHelper::remove_menu_item (*elem_menu, ID_UNLOCK_ALL_TREE);
				}

				if (avlaible_types.find (CATEGORY_TYPE) == avlaible_types.end ()) {
					MenuHelper::remove_menu_item (*elem_menu, ID_NEW_CATEGORY_TREE);					
				}

				if (avlaible_types.find (CLASS_TYPE) == avlaible_types.end ()) {
					MenuHelper::remove_menu_item (*elem_menu, ID_NEW_CLASS_TREE);					
				}
			} else if (elem->IsClass (CLASS_TYPE)) {				
				IRoseItemPtr item = elem;
				if (item->Stereotype != _bstr_t ("UseCase")) {
					MenuHelper::remove_menu_item (*elem_menu, ID_NEW_SEQUENCEDIAG_TREE);
				}

				if (avlaible_types.find (OPERATION_TYPE) == avlaible_types.end ()) {
					MenuHelper::remove_menu_item (*elem_menu, ID_NEW_OPERATION_TREE);					
				}

				if (avlaible_types.find (ATTRIBUTE_TYPE) == avlaible_types.end ()) {
					MenuHelper::remove_menu_item (*elem_menu, ID_NEW_ATTRIBUTE_TREE);					
				}

				if (avlaible_types.find (CLASS_TYPE) == avlaible_types.end ()) {
					MenuHelper::remove_menu_item (*elem_menu, ID_NEW_CLASS_TREE);					
				}

				if (avlaible_types.find ("StateMachine") == avlaible_types.end ()) {
					MenuHelper::remove_menu_item (*elem_menu, ID_NEW_STATEDIAGRAM_TREE);					
				}
			} else if (elem->IsClass (OPERATION_TYPE)) {
			} else if (elem->IsClass (ATTRIBUTE_TYPE)) {
			} else if (elem->IsClass (PARAMETER_TYPE)) {
			} else if (elem->IsClass ("Role")) {
				if (item->Name != _bstr_t ("")) {
					MenuHelper::remove_menu_item (*elem_menu, ID_NEW_ATTRKEY_TREE);
				}
			} else {
			}
			
			if (RoseHelper::is_incomplete (elem) == true || item->Stereotype == bstr_t("UMLModule")) {
				MenuHelper::remove_menu_item (*elem_menu, ID_GENERATE_TREE);
				MenuHelper::remove_menu_item (*elem_menu, ID_GENERATE_NO_REP_TREE);

				MenuHelper::remove_menu_item (*elem_menu, ID_GENERATION_WITH_CONSUMERS_DIAG);
				MenuHelper::remove_menu_item (*elem_menu, ID_GENERATION_WITH_CONSUMERS_TREE);

				MenuHelper::remove_menu_item (*elem_menu, ID_GENERATION_WITH_CONSUMERS_NOREP_DIAG);
				MenuHelper::remove_menu_item (*elem_menu, ID_GENERATION_WITH_CONSUMERS_NOREP_TREE);
			}

			MDPSupport::CatLockerFacade_var clf = MDPSupport::CatLockerFacadeFactory::make (elem);
			if (clf->can_change () == false) {				
				MenuHelper::enable_menu_item (*elem_menu, ID_NEW_CATEGORY_TREE, false);
				MenuHelper::enable_menu_item (*elem_menu, ID_NEW_CLASS_TREE, false);
				MenuHelper::enable_menu_item (*elem_menu, ID_NEW_CLASSDIAG_TREE, false);				
				MenuHelper::enable_menu_item (*elem_menu, ID_NEW_ATTRIBUTE_TREE, false);
				MenuHelper::enable_menu_item (*elem_menu, ID_NEW_OPERATION_TREE, false);
				MenuHelper::enable_menu_item (*elem_menu, ID_NEW_SEQUENCEDIAG_TREE, false);
				MenuHelper::enable_menu_item (*elem_menu, ID_NEW_ATTRKEY_TREE, false);				
				MenuHelper::enable_menu_item (*elem_menu, ID_DELETE_TREE, false);				
			}

			if (clf->can_lock () == true) {
				MenuHelper::modify_menu_item (*elem_menu, ID_LOCK_TREE, "Lock");
				MenuHelper::remove_menu_item (*elem_menu, ID_ROLLBACK_TREE);
			} else if (clf->can_commit () == true) {				
				MenuHelper::modify_menu_item (*elem_menu, ID_LOCK_TREE, "Unlock");
			} else {				
				MenuHelper::remove_menu_item (*elem_menu, ID_ROLLBACK_TREE);

				const MDPSupport::CatsLockStatus& cats_status = MDPSupport::CatsContainerFactory::get ().get_cats_lock_status ();
				MDPSupport::CatsLockStatus::const_iterator it = cats_status.find (get_rose_element_uid(elem));

				if (it != cats_status.end ()) {
					std::string locked_text ("Locked by " + it->second.lock_owner_name);

					MenuHelper::modify_menu_item (
						*elem_menu
						, ID_LOCK_TREE
						, locked_text.c_str ()
					);
				}

				MenuHelper::enable_menu_item (*elem_menu, ID_LOCK_TREE, false);
			}
			MenuHelper::clear_duplicate_separator (*elem_menu);
			return menu.forget ();
		} else {
			return 0;
		}
	} else {
		DWORD err = GetLastError ();
		LOG_E (("Can't load menu with id IDR_TREE, error code = %d", err));
		return 0;
	}
	//#UC END# *462DB36C01E4*
}

//////////////////////////////////////////////////////////////////////////////////////////
// private member implementation

// возвращает true, если нужна команда lock_all
bool need_lock_all (IRoseElementPtr elem) {
	//#UC START# *497EBCD20357*
	if (elem->IsClass (CATEGORY_TYPE)) {
		IRoseCategoryPtr r_cat = elem;		
		Category_var cat = CategoryFactory::make (r_cat);
		if (!cat->is_controlled () && !cat->has_controlled_child ()) {
			return false;
		}

		bool need_lock_all = false;
		IRoseCategoryCollectionPtr cats = r_cat->GetAllCategories ();
		short count = cats->Count;
		for (short i = 1; i <= count; ++i) {
			MDPSupport::CatLockerFacade_var clf_child = MDPSupport::CatLockerFacadeFactory::make (cats->GetAt (i));
			need_lock_all |= clf_child->can_lock ();
		}

		return need_lock_all;
	}
	return false;
	//#UC END# *497EBCD20357*
}

// возвращает true, если нужна команда unlock all
bool need_unlock_all (IRoseElementPtr elem) {
	//#UC START# *497EBD0003A1*
	if (elem->IsClass (CATEGORY_TYPE)) {
		IRoseCategoryPtr r_cat = elem;		
		Category_var cat = CategoryFactory::make (r_cat);
		if (!cat->is_controlled () && !cat->has_controlled_child ()) {
			return false;
		}

		bool need_unlock_all = false;
		IRoseCategoryCollectionPtr cats = r_cat->GetAllCategories ();
		short count = cats->Count;
		for (short i = 1; i <= count; ++i) {
			MDPSupport::CatLockerFacade_var clf_child = MDPSupport::CatLockerFacadeFactory::make (cats->GetAt (i));
			need_unlock_all |= clf_child->can_commit ();
		}

		return need_unlock_all;
	}
	return false;
	//#UC END# *497EBD0003A1*
}

} // namespace MenuFactory

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

