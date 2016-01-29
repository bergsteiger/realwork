////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CGeneration.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<ComServant::Class>> MDProcess::MDAAddinLib::Addin_i::CGeneration
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/LibHome.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CGeneration.h"
// by <<uses>> dependencies
#include "MDProcess/MDAAddinLib/MDAGui/MdaAbout.h"
#include "MDProcess/MDAAddinLib/MDAGui/MdaStart.h"
#include "MDProcess/MDAAddinLib/MDAGui/ChoiceType.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/MDAAddinLib/Commands/Commands.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseTreeState.h"
#include "MDProcess/MDAAddinLib/LockViews/ChangedPackageInfo.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CmdHandler.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/Other.h"
#include "MDProcess/MDAModel/RoseDumpers/MDAModelParams.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/Settings.h"
#include "MDProcess/MDAAddinLib/PropertyViews/MDAGeneratorProperties.h"
#include "MDProcess/MDAAddinLib/MDAGui/GenerationErrorDialog.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"

//#UC START# *456C42C601A5_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include <algorithm>
#include <list>
#include <stack>
#include "shared/GCL/data/std_defs.h"
#include "shared/Core/os/RegistryHelper.h"
#include "shared/GCL/str/str_op.h"
#include "shared/GCL/os/dir_op.h"
#include "shared/GCL/os/FileOp.h"
#include "shared/Core/fix/Win32Exception.h"
#include "shared/GCL/data/std_defs.h"

#include <boost/lexical_cast.hpp>
#include <boost/algorithm/string.hpp>
#include "shared/WinGUI/Helpers/WindowHelper.h"
#include <boost/algorithm/string/predicate.hpp>
#include <boost/algorithm/string/classification.hpp>

#include "shared/Core/sys/MemoryManagment.h"
//#UC END# *456C42C601A5_CUSTOM_INCLUDES*


//#UC START# *456C42C601A5*
Core::Aptr<ChoiceType> g_choice_dlg;
Core::Aptr<CGeneration::MissedGenFileDlg_i> g_missed_dlg;

STDMETHODIMP CGeneration::OnViewReport(IDispatch* pRoseDisp) {	
	AFX_MANAGE_STATE(AfxGetStaticModuleState());

	try {
		IRoseApplicationPtr app = pRoseDisp;
		IRoseCategoryPtr root = app->CurrentModel->GetRootCategory ();
		Commands::CmdManagerFactory::get ().view_reports(root);
	} CATCH_AND_LOG ("in CGeneration::OnViewReport");

	return S_OK;
}

STDMETHODIMP CGeneration::OnColorizeAllDiagrams(IDispatch* pRoseDisp) {	
	AFX_MANAGE_STATE(AfxGetStaticModuleState());

	try {
		IRoseApplicationPtr app = pRoseDisp;
		IRoseCategoryPtr root = app->CurrentModel->GetRootCategory ();
		Commands::CmdManagerFactory::get ().colorize_all_diagrams (root);
	} CATCH_AND_LOG ("in CGeneration::OnColorizeAllDiagrams");
	return S_OK;
}


STDMETHODIMP CGeneration::OnMDACleanModelProperties (IDispatch* pRoseDisp) {
	AFX_MANAGE_STATE(AfxGetStaticModuleState());

	try {
		IRoseApplicationPtr app = pRoseDisp;
		IRoseElementPtr model = app->CurrentModel;
		if (model) {
			int res = ::MessageBox (0, "Вы уверены, что хотите очистить свойства модели и Main-проекта?", "Внимание!", MB_ICONEXCLAMATION | MB_YESNO);
			if (res == IDYES) {
				IRoseElementPtr main_propject = RoseHelper::get_main_model_element ();

				Commands::CmdManagerFactory::get ().clean_properties (model);
				if (main_propject) {
					Commands::CmdManagerFactory::get ().clean_properties_recursively (main_propject);
				}
				app->SaveModel (true);
				RoseAbstractDumper::reset_all ();
				::MessageBox (0, "Работа завершена, изменения сохранены", "Работа завершена", MB_ICONINFORMATION | MB_OK);
			}
		} else {
			::MessageBox (0, "Для выполнения операции необходимо открыть модель", "Ошибка", MB_ICONEXCLAMATION | MB_OK);
		}
		
	} CATCH_AND_LOG (GDS_CURRENT_FUNCTION);
	return S_OK;
}

void reinit_timestamps (IRoseApplicationPtr app) {
	int res = ::MessageBox (0, "Вы уверены, что хотите переинициализировать все таймстемпы?", "Внимание!", MB_ICONEXCLAMATION | MB_YESNO);
	if (res == IDYES) {
		Core::Aptr<RoseElementSet> all_childs = RoseHelper::get_all_childs (app->CurrentModel->RootCategory);

		ACE_UINT64 min_timestamp = 133332530LL;
		ACE_UINT64 max_timestamp = 4774336781709LL;

		//for (RoseElementSet::iterator it = all_childs->begin (); it != all_childs->end (); ++it) {
		//	IRoseElementPtr item = it->element;
		//	
		//	IRosePropertyCollectionPtr props = item->GetToolProperties (TOOL_NAME);
		//	short props_count = props->Count;
		//	
		//	for (short i = 1; i <= props_count; ++i) {
		//		IRosePropertyPtr prop = props->GetAt (i);
		//		std::string prop_name = prop->GetName ();
		//		if (prop_name.find (Base::ELEMENT_CREATION_ORDER) != std::string::npos) {
		//			std::string persistent_creation_order = static_cast<const char*> (prop->GetValue ());
		//			if (!persistent_creation_order.empty ()) {
		//				try {
		//					ACE_UINT64 stored_timestamp = boost::lexical_cast<ACE_UINT64> (persistent_creation_order);
		//					min_timestamp = std::min<ACE_UINT64> (min_timestamp, stored_timestamp);

		//					if (max_timestamp < stored_timestamp) {
		//						max_timestamp = stored_timestamp;
		//						LOG_I(("Find new max timestamp at prop: %s, timestamp = %Q", prop_name.c_str (), max_timestamp));
		//					}

		//				} catch (boost::bad_lexical_cast&) {
		//					//skip
		//				}
		//			}
		//		}
		//	}
		//}

		//ACE_UINT64 counter = 0;
		//ACE_UINT64 last_time = 0;
		//const ACE_Time_Value time = ACE_OS::gettimeofday();
		//ACE_UINT64 timestamp = 0;
		//time.to_usec (timestamp);

		//for (RoseElementSet::iterator it = all_childs->begin (); it != all_childs->end (); ++it) {
		//	IRoseElementPtr item = it->element;
		//	
		//	//timestamp += counter++;

		//	last_time = timestamp;
		//	
		//	IRosePropertyCollectionPtr props = item->GetToolProperties (TOOL_NAME);
		//	short props_count = props->Count;

		//	for (short i = 1; i <= props_count; ++i) {
		//		IRosePropertyPtr prop = props->GetAt (i);
		//		std::string prop_name = prop->GetName ();

		//		ACE_UINT64 local_timestamp = timestamp;

		//		if (prop_name.find (Base::ELEMENT_CREATION_ORDER) != std::string::npos) {
		//			std::string persistent_creation_order = static_cast<const char*> (prop->GetValue ());
		//			bool write = false;
		//			if (!persistent_creation_order.empty ()) {
		//				try {
		//					ACE_UINT64 stored_timestamp = boost::lexical_cast<ACE_UINT64> (persistent_creation_order);
		//					local_timestamp -= (max_timestamp - stored_timestamp);
		//					write = true;

		//				} catch (boost::bad_lexical_cast&) {
		//					//skip
		//				}
		//			}

		//			if (write) {
		//				RoseHelper::write_property_with_lock (
		//					item
		//					, prop_name
		//					, boost::lexical_cast<std::string> (local_timestamp)
		//					, GenSupport::LS_LOCK_ALL
		//					, true
		//					, Base::ELEMENT_CREATION_ORDER
		//				);
		//			}
		//		}
		//	}
		//}

		LOG_I (("Min timestamp: %Q, max: %Q", min_timestamp, max_timestamp));
		app->SaveModel (true);
		RoseAbstractDumper::reset_all ();
		::MessageBox (0, "Работа завершена, изменения сохранены", "Работа завершена", MB_ICONINFORMATION | MB_OK);
	}
}

void write_user_property_default_value_to_model (IRoseApplicationPtr app, const std::string& prop_name) {
	class UPCollector {
	public:
		UPCollector (const AbstractDumperBase::PropertyGroupTreeItem* root) {
			if (root) {		
				root->for_each (
					AbstractDumperBase::CollectUserProperty ()
					, m_all_props
				);
			}
		}

	public:
		AbstractDumperBase::UserPropertyMap& get_all_props () {
			return m_all_props;
		}

	private:
		AbstractDumperBase::UserPropertyMap m_all_props;
	};

	Core::Aptr<RoseElementSet> all_childs = RoseHelper::get_all_childs (app->CurrentModel->RootCategory);

	for (RoseElementSet::iterator it = all_childs->begin (); it != all_childs->end (); ++it) {
		IRoseElementPtr item = it->element;
		
		AbstractDumperBase::StereotypeID stereotype = RoseHelper::get_gen_stereotype(item);		
		const AbstractDumperBase::Template& tpl = AbstractDumperBase::get_template (stereotype);

		if (tpl.user_properties_group.is_nil () == false) {
			UPCollector collector (tpl.user_properties_group.in ());
			AbstractDumperBase::UserPropertyMap& props = collector.get_all_props ();
			AbstractDumperBase::UserPropertyMap::const_iterator it = props.find (prop_name);
			if (it != props.end ()) {
				std::string val = static_cast<const char*>(item->GetPropertyValue (Base::USER_PROPERTY_TOOL, prop_name.c_str()));
				if (val.empty ()) {
					std::string item_name = RoseHelper::get_full_name (item);
					LOG_I (("Write default property \"%s\" in element %s", prop_name.c_str (), item_name.c_str ()));
					RoseHelper::write_property_with_lock (
						item
						, Base::USER_PROPERTY_TOOL
						, prop_name
						, it->second.def_value
						, GenSupport::LS_LOCK_ALL
						, true
						, prop_name
					);
				}
			}
		}
	}
}

STDMETHODIMP CGeneration::OnMDACustomWork (IDispatch* pRoseDisp) {
	AFX_MANAGE_STATE(AfxGetStaticModuleState());
	
	ACE_UINT64 usecs = 0;
	ACE_Time_Value tv = ACE_OS::gettimeofday ();
	tv.to_usec (usecs);
	
	LOG_I(("Current time: %Q usecs", usecs));
	tv = ACE_High_Res_Timer::gettimeofday_hr ();
	usecs = 0;
	tv.to_usec (usecs);
	LOG_I(("HiRes timeer: %Q usecs", usecs));

	IRoseApplicationPtr app = pRoseDisp;
	
	//reinit_timestamps (app);
	//write_user_property_default_value_to_model (app, "<prop_name>");

	return S_OK;
}

STDMETHODIMP CGeneration::OnMDAGeneratorOptions (IDispatch* pRoseDisp) {
	AFX_MANAGE_STATE(AfxGetStaticModuleState());

	try {
		MDAGeneratorProperties prop_dlg;
		prop_dlg.DoModal ();
	} CATCH_AND_LOG (GDS_CURRENT_FUNCTION);
	return S_OK;
}

STDMETHODIMP CGeneration::OnMDASave (IDispatch* pRoseDisp) {
	try {
		IRoseApplicationPtr app = pRoseDisp;		
		
		if (Other::get_mda_save()) {
			
			LPMALLOC pMalloc = 0;
			HRESULT hr = SHGetMalloc( &pMalloc );
			if (SUCCEEDED(hr) ) {
				try {
					BROWSEINFO BrowseInfo;
					BOOL result;
					char pszPath[MAX_PATH];
					memset(pszPath, '\0', sizeof(MAX_PATH));
					memset(&BrowseInfo, '\0', sizeof(BrowseInfo));
					LPITEMIDLIST pidl = SHBrowseForFolder(&BrowseInfo);
					result = SHGetPathFromIDList(pidl, pszPath);
					pMalloc->Free(pidl);
					
					IRoseModelPtr model = app->CurrentModel;
					std::string folder (pszPath);
					
					/*ModelSaver saver (
						model
						, folder
					);
					saver.save ();*/
					
					pMalloc->Release();
				} catch (...) {					
					pMalloc->Release();
					throw;
				}
			}
		} else {
			::MessageBox (0, "Данная функция не поддерживается", "Внимание!", MB_ICONEXCLAMATION | MB_OK);
		}
	} CATCH_AND_LOG ("in CGeneration::OnMDASave");

	return S_OK;
}

STDMETHODIMP CGeneration::OnSelectTemplate(IDispatch* pRoseDisp) {	
	AFX_MANAGE_STATE(AfxGetStaticModuleState());

	try {
		IRoseApplicationPtr app = pRoseDisp;
		char szFilters[] = "MDA Template Files (*.tpl)|*.tpl|All Files (*.*)|*.*||";

		CFileDialog f_dlg (true, "tpl", "*.tpl", OFN_FILEMUSTEXIST| OFN_HIDEREADONLY, szFilters);

		if (f_dlg.DoModal() == IDOK) {
			std::string from_dlg = (const char*) f_dlg.GetPathName ();
			std::string template_dir = MDAModelParams::get_templates_dir();
			std::string::size_type pos = from_dlg.find (template_dir);
			if (pos != std::string::npos) {
				from_dlg = from_dlg.substr (pos + template_dir.length ());
				if (from_dlg.size () > 0 && from_dlg[0] != '\\') {
					from_dlg.insert (0, "\\");
				}
			} else {
			}		
			Commands::CmdManagerFactory::get ().set_template (app, from_dlg);
		}
	} CATCH_AND_LOG ("in CGeneration::OnSelectTemplate");
	return S_OK;
}

STDMETHODIMP CGeneration::OnAdvancedSearch(IDispatch* pRoseDisp) {	
	AFX_MANAGE_STATE(AfxGetStaticModuleState());

	try {
		IRoseApplicationPtr app = pRoseDisp;
		IRoseCategoryPtr root = app->CurrentModel->GetRootCategory ();
		Commands::CmdManagerFactory::get ().search(root);	
	} CATCH_AND_LOG ("in CGeneration::OnAdvancedSearch");

	return S_OK;
}


STDMETHODIMP CGeneration::OnAbout(IDispatch* pRoseDisp) {	
	AFX_MANAGE_STATE(AfxGetStaticModuleState());

	try {
		IRoseApplicationPtr app = pRoseDisp;
		MdaAbout dlg;
		dlg.DoModal ();
	} CATCH_AND_LOG ("in CGeneration::OnAbout");
	return S_OK;
}

STDMETHODIMP CGeneration::OnGenerate(IDispatch* pRoseDisp) {
	AFX_MANAGE_STATE(AfxGetStaticModuleState());

	try {
		IRoseApplicationPtr app = pRoseDisp;

		IRoseCategoryPtr root = app->CurrentModel->GetRootCategory ();
		Commands::CmdManagerFactory::get ().generate (root, true);	
	} CATCH_AND_LOG ("in CGeneration::OnGenerate");
	return S_OK;
}


STDMETHODIMP CGeneration::OnSelectedContextMenuItem(IRoseApplication *pRoseApp, const BSTR strInternalName, VARIANT_BOOL *result) {
	AFX_MANAGE_STATE(AfxGetStaticModuleState());

	try {
		IRoseApplicationPtr app = pRoseApp;

		if ( !wcscmp (strInternalName, L"Generate" )) {
			try {		
				IRoseItemCollectionPtr sel_items = app->CurrentModel->GetSelectedItems();
				Commands::CmdManagerFactory::get ().generate (sel_items->GetAt(1), true);
			} catch (...) {
				MessageBox (0, "Во время генерации кода произашло не обработанное исключение", "Ошибка", MB_OK|MB_ICONEXCLAMATION );
			}
		} else if (!wcscmp (strInternalName, L"GenerateDG")) {		
			Commands::CmdManagerFactory::get ().generate (app->CurrentModel->GetActiveDiagram()->GetParentContext(), true);
		} else if (!wcscmp (strInternalName, L"Colorize")) {
			try {		
				IRoseDiagramPtr d = app->CurrentModel->GetActiveDiagram();

				RoseHelper::reset_template ();
				if (RoseHelper::load_template ()) {
					RoseHelper::colorize (d);
				}
			} catch (Base::FatalError&) {
				GenSupport::ErrorManagerFactory::get ().error (0, "Ошибка при раскраске диаграммы", "Colorize");
				GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
				dlg.DoModal ();
			} catch (...) {
				GenSupport::ErrorManagerFactory::get ().error (0, "Неизвестная ошибка при раскраске диаграммы", "Colorize");
				GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
				dlg.DoModal ();
			}
		} else if (!wcscmp (strInternalName, L"OnViewReports")) {
			IRoseItemCollectionPtr sel_items = app->CurrentModel->GetSelectedItems();		
			if (sel_items->Count) {
				Commands::CmdManagerFactory::get ().view_reports (sel_items->GetAt(1));
			}
		} else if (!wcscmp (strInternalName, L"OnViewReportsDG")) {
			Commands::CmdManagerFactory::get ().view_reports (app->CurrentModel->GetActiveDiagram()->GetParentContext());		
		} else if (!wcscmp (strInternalName, L"OnAdvancedSearch")) {
			IRoseItemCollectionPtr sel_items = app->CurrentModel->GetSelectedItems();		
			if (sel_items->Count) {
				Commands::CmdManagerFactory::get ().search (sel_items->GetAt(1));
			}
		} else if (!wcscmp (strInternalName, L"OnAdvancedSearchDG")) {
			Commands::CmdManagerFactory::get ().search (app->CurrentModel->GetActiveDiagram()->GetParentContext());		
		} else if (!wcscmp (strInternalName, L"NewMdaElement") || !wcscmp (strInternalName, L"NewMdaElementDG")) {		
			IRoseModelPtr model = app->CurrentModel;
			IRoseItemCollectionPtr selected = model->GetSelectedItems ();
			IRoseItemPtr parent;
			if (selected->Count > 0) {
				parent = selected->GetAt (1);
			} else {
				parent = model->GetActiveDiagram ()->GetParentContext ();
			}
			std::string all ("all");
			
			Commands::CmdManagerFactory::get ().new_element (parent, all);
		} else if (!wcscmp (strInternalName, L"MDAProperty" )) {
			OnMDAProperty (pRoseApp);
		} else if (!wcscmp (strInternalName, L"Lock" )) {
			// write marshaled object reference to global variable 
			// записываем маршалированную объектную ссыпку 
			// в глобальную переменную 
			//IStream* stream_ptr;
			//HRESULT hr = CoMarshalInterThreadInterfaceInStream(__uuidof (app), app, &stream_ptr); 
			
			//g_lock_thread = (HANDLE)_beginthread (AsynchronousCalls::thread_func, 0, reinterpret_cast<IStream*> (stream_ptr));							

			IRoseItemCollectionPtr sel_items = app->CurrentModel->GetSelectedItems();
			if (1 == sel_items->Count) {
				IRoseItemPtr item = sel_items->GetAt(1);
				MDPSupport::CatLocker_var cl = MDPSupport::CatLockerFactory::make ((IRoseCategoryPtr)item);
				cl->modify ();
			}
		} else if (!wcscmp (strInternalName, L"UnLock" )) {
			IRoseItemCollectionPtr sel_items = app->CurrentModel->GetSelectedItems();
			if (1 == sel_items->Count) {
				IRoseItemPtr item = sel_items->GetAt(1);
				MDPSupport::CatLocker_var cl = MDPSupport::CatLockerFactory::make ((IRoseCategoryPtr)item);
				cl->commit ();
			}
		} else if (!wcscmp (strInternalName, L"Rollback" )) {
			IRoseItemCollectionPtr sel_items = app->CurrentModel->GetSelectedItems();
			if (1 == sel_items->Count) {
				IRoseItemPtr item = sel_items->GetAt(1);
				MDPSupport::CatLocker_var cl = MDPSupport::CatLockerFactory::make ((IRoseCategoryPtr)item);
				cl->rollback ();
			}
		} else if (!wcscmp (strInternalName, L"SyncWithServer" )) {
			MDPSupport::MDPFacadeFactory::get ().show_locked ();
		} else if (!wcscmp (strInternalName, L"LockOP" )) {
			IRoseClassDiagramPtr rcd = (IRoseClassDiagramPtr)app->CurrentModel->GetActiveDiagram();
			IRoseCategoryPtr current_cat = (IRoseCategoryPtr)rcd->GetParentContext();
			MDPSupport::CatLocker_var cl = MDPSupport::CatLockerFactory::make (current_cat);
			cl->modify ();
		} else if (!wcscmp (strInternalName, L"UnLockOP" )) {
			IRoseClassDiagramPtr rcd = (IRoseClassDiagramPtr)app->CurrentModel->GetActiveDiagram();
			IRoseCategoryPtr current_cat = (IRoseCategoryPtr)rcd->GetParentContext();
			MDPSupport::CatLocker_var cl = MDPSupport::CatLockerFactory::make (current_cat);
			cl->commit ();
		} else if (!wcscmp (strInternalName, L"RollbackOP" )) {
			IRoseClassDiagramPtr rcd = (IRoseClassDiagramPtr)app->CurrentModel->GetActiveDiagram();
			IRoseCategoryPtr current_cat = (IRoseCategoryPtr)rcd->GetParentContext();
			MDPSupport::CatLocker_var cl = MDPSupport::CatLockerFactory::make (current_cat);
			cl->rollback ();
		}
	} CATCH_AND_LOG ("in CGeneration::OnSelectedContextMenuItem");
	
	return S_OK;
}

STDMETHODIMP CGeneration::OnMDAProperty(IDispatch* pRoseDisp) {	
	AFX_MANAGE_STATE(AfxGetStaticModuleState());

	try {
		IRoseApplicationPtr app = pRoseDisp;

		IRoseItemCollectionPtr sel_items = app->CurrentModel->GetSelectedItems();

		for (int i=1; i < sel_items->Count+1; i++) {
			IRoseItemPtr item = sel_items->GetAt(i);
			VARIANT_BOOL res;
			this->OnPropertySpecOpen(app, item, &res);
		}
	} CATCH_AND_LOG ("in CGeneration::OnMDAProperty");

	return S_OK;
}

STDMETHODIMP CGeneration::OnPropertySpecOpen(IRoseApplication *pRoseApp, IRoseItem *pRoseItem, VARIANT_BOOL *result) {
    AFX_MANAGE_STATE(AfxGetStaticModuleState())	;
	
	try {
		IRoseItemPtr item = pRoseItem;
		if (Commands::CmdManagerFactory::get ().properties (item, false, true) == RoseHelper::ER_EDIT_OK) {
			*result = VARIANT_TRUE;	
		} else {
			*result = VARIANT_TRUE;
		}
	} CATCH_AND_LOG ("in CGeneration::OnPropertySpecOpen");
	return S_OK;
}

STDMETHODIMP CGeneration::OnNewModel(IRoseApplication *app) {
	AFX_MANAGE_STATE(AfxGetStaticModuleState())	;
	
	try {
		MDPSupport::MDPFacadeFactory::get ().sync (app->CurrentModel);

		MdaStart dlg;
		switch (dlg.DoModal()) {
		case IDOK:
			if (dlg.get_result().file_type == MdaStart::RFT_MRU) {
				app->OpenModel(dlg.get_result().file_name.data());			
			} else {
				app->OpenModelAsTemplate(dlg.get_result().file_name.data());			
				StartProperties start_dlg;
				
				if (start_dlg.DoModal() == IDOK) {
					IRoseCategoryPtr root = app->CurrentModel->GetRootCategory();
					std::string merged_sels = GCL::join (start_dlg.get_result().selected_gens, "|");
					RoseHelper::override_property(root, TOOL_NAME, PROP_APPLGEN, merged_sels.data());
					
					IRoseCategoryPtr my_main = root->AddCategory(start_dlg.get_result().main_name.data());
					RoseHelper::set_root_dir(my_main, start_dlg.get_result().root_dir);
					
					GenSupport::LogManagerFactory::get ().init ();
					GenSupport::ErrorManagerFactory::get ().clear_errors ();

					GenSupport::AutoErrorSuppress auto_suppresser (false);

					//find main stereotype
					try {
						RoseHelper::reset_template ();
						RoseHelper::load_template ();

						if (!GenSupport::ErrorManagerFactory::get ().get_errors ().empty ()) {
							GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
							dlg.DoModal ();
						}
					} catch (Base::FatalError&) {
						GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
						dlg.DoModal ();
					}

					std::string main_st;
					static const std::string uml_module ("UMLModule");
					for (
						AbstractDumperBase::Templates::const_iterator it = AbstractDumperBase::templates_begin ()
						; it != AbstractDumperBase::templates_end ()
						; it ++
					) {
						if (it->second.main_st) {
							std::string st = GCL::split_string_by_sub_string (it->first/*.get ()*/.data(), "::")[0];
							if (uml_module != st) {
								main_st = st;
							}
						}
					}
					
					if (main_st == "") {
						GenSupport::LogManagerFactory::get ().log_error ("ERROR: No Main stereotype defined in template");
					} else {
						my_main->Stereotype = main_st.data();
						RoseHelper::set_new_main_model_element (my_main);
					}
					
					IRoseClassDiagramCollectionPtr dgs = root->GetClassDiagrams();
					IRoseClassDiagramPtr root_diag = dgs->GetAt (1);
					root_diag->AddCategory (my_main);
					if (m_model_explorer) {
						IRoseElementPtr elem = my_main;
						m_model_explorer->OnNewModelElement (app, elem);
					}
					RoseHelper::colorize (root_diag);
				}
			}
			break;
		case IDCANCEL:
			break;
		};
		
		CWnd* main_wnd = AfxGetMainWnd ();
		HWND browser = WinGUI::find_window (NULL, "Browser", "Afx:400000:8:10005:0:0");
		if (main_wnd) { 
			if (browser == NULL ) {				
				browser = WinGUI::find_window (main_wnd->GetSafeHwnd (), "Browser", "#32770");
			}
			if (browser && ::IsWindowVisible (browser)) {	
				main_wnd->PostMessage (WM_COMMAND, MAKEWPARAM (33385, 0), 0);
			}

		}
	} CATCH_AND_LOG ("in CGeneration::OnNewModel");
	return S_OK;
}

void update_mru (const char* fn) {
	std::string REGISTRY_KEY_PATH = "SOFTWARE\\Garant\\MDAGenerator";
	std::string REGISTRY_OPTION_NAME = "RML";	
	
	std::string resent_models = Core::RegistryHelper::get_option_value (
		Core::RegistryHelper::KEY_CURRENT_USER
		, REGISTRY_KEY_PATH
		, REGISTRY_OPTION_NAME
		, ""
	);

	GCL::StrVector rml = GCL::split_string_by(resent_models.data(), ',');

	GCL::StrVector::iterator f = std::find (rml.begin(), rml.end(), fn);
	if (f != rml.begin() || rml.size() == 0) {
		if (f != rml.end()) {
			rml.erase (f);
		}
		rml.insert (rml.begin(), fn);

		resent_models = GCL::join (rml, ",");

		Core::RegistryHelper::set_option_value (
			Core::RegistryHelper::KEY_CURRENT_USER
			, REGISTRY_KEY_PATH
			, REGISTRY_OPTION_NAME
			, resent_models
		);
	}	
}

STDMETHODIMP CGeneration::OnSaveModel(IRoseApplication *app, IRoseControllableUnit *unit, BOOLEAN flag) {
	AFX_MANAGE_STATE(AfxGetStaticModuleState())	;

	try {
		_bstr_t fn = app->CurrentModel->GetFileName();

		if (fn.length() != 0) {
			update_mru ((const char*) fn);
		}
	} CATCH_AND_LOG ("in CGeneration::OnSaveModel");
	return S_OK;
}

STDMETHODIMP CGeneration::OnOpenModel(IRoseApplication *app) {
	AFX_MANAGE_STATE(AfxGetStaticModuleState());
	
	try {
		RoseTreeState::instance ()->reset ();
		
		IRoseApplicationPtr rose_app = app;
		IRoseModelPtr model = rose_app->CurrentModel;
		long dll_version = boost::lexical_cast<long> (DLL_BUILD_NUM);
		std::string model_ver_str = model->GetPropertyValue (TOOL_NAME, "MODEL_VERSION");
		bool need_write_version = false;
		long model_version = 0;
		if (model_ver_str.empty ()) {
			need_write_version = true;
		} else {
			model_version = boost::lexical_cast<long> (
				model_ver_str
			);
			need_write_version = dll_version >= model_version;
		}
		

		if (
			!need_write_version
		) {
			std::string message ("Версия модели (");
			message += boost::lexical_cast<std::string> (model_ver_str);
			message += ") старше версии длл (";
			message += boost::lexical_cast<std::string> (DLL_BUILD_NUM);
			message += ")!\nНеобходимо обновить длл!";
			::MessageBox (0, message.data (), "ERROR", MB_OK | MB_ICONEXCLAMATION);					
			rose_app->Exit ();
			return S_FALSE;
		} else {
			_bstr_t value (boost::lexical_cast<std::string> (DLL_BUILD_NUM).c_str ());
			if (
				RoseHelper::override_property (
					model, TOOL_NAME, "MODEL_VERSION", value
				)	
			) {
				rose_app->SaveModel (false);
			}
		}

		GenSupport::LogManagerFactory::get ().init ();
		GenSupport::ErrorManagerFactory::get ().clear_errors ();

		GenSupport::AutoErrorSuppress auto_suppresser (false);

		RoseHelper::reset_template ();
		try {
			if (RoseHelper::load_template ()) {
				RoseHelper::check_model_for_changes ();
				RoseHelper::colorize_all ();
			} else {		
				GenSupport::LogManagerFactory::get ().log_warning("WARNING: Can't colorize full model - no template loaded on root element");
			}

			if (!GenSupport::ErrorManagerFactory::get ().get_errors ().empty ()) {
				GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
				dlg.DoModal ();
			}
		} catch (Base::FatalError&) {
			GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
			dlg.DoModal ();
		}

		IRoseDiagramPtr curr_diag = model->GetActiveDiagram ();
		if (curr_diag) {
			HWND diag_wnd = RoseHelper::get_diag_window (curr_diag);
			if (diag_wnd) {
				ShowWindow (diag_wnd, SW_MAXIMIZE);
			}
		}
				
		if (m_model_explorer) {
			m_model_explorer->OnOpenModel (rose_app);
		}
		//sync lock status for cat-units with server
		MDPSupport::MDPFacadeFactory::get ().sync (model);
	} CATCH_AND_LOG ("in CGeneration::OnOpenModel");
	return S_OK;
}

STDMETHODIMP CGeneration::OnActivate(IRoseApplication *app) {
	AFX_MANAGE_STATE(AfxGetStaticModuleState())
	COMDllInintializator::init ();
	Core::Win32Exception::install_handler();
	Core::MemoryManagment::install_new_handler ();
	RoseHelper::set_rose_app (app);
	
	// redirect to 0, to speed up shell (delphi client) termination:
	_CrtSetReportMode (_CRT_WARN, _CRTDBG_MODE_FILE);
	_CrtSetReportFile (_CRT_WARN, 0);
	_CrtSetReportMode (_CRT_ERROR, _CRTDBG_MODE_FILE);
	_CrtSetReportFile (_CRT_ERROR, 0);
	_CrtSetReportMode (_CRT_ASSERT, _CRTDBG_MODE_FILE);
	_CrtSetReportFile (_CRT_ASSERT, 0);
	
	try {
		// Вызывается при загрузке плагина
		std::string log_file = Settings::get_log_file();
		if (log_file.empty () == false) {
			ofstream* output_stream = new ofstream ();			
			output_stream->open (log_file.data (), ios::out | ios::app);
			if (!output_stream->bad ()) {
				ACE_LOG_MSG->msg_ostream (output_stream, 1);
			} else {
				delete output_stream;
			}
			ACE_LOG_MSG->clr_flags (ACE_Log_Msg::STDERR | ACE_Log_Msg::LOGGER);
			ACE_LOG_MSG->set_flags (ACE_Log_Msg::OSTREAM);

#ifdef _DEBUG
			std::string errlog = log_file + ".err";
			ACE_OS::freopen (errlog.c_str (), "w", stderr);
#endif

		}
		
		Core::MemoryManagment::init_low_fragmentation_heap ();

		MDPSupport::MDPFacadeFactory::get ().login ();

		if (app->CurrentModel->DefaultLanguage != _bstr_t("MDA Generator")) {
			app->CurrentModel->DefaultLanguage = "MDA Generator";
		}
		
		CoCreateInstance(
			 CLSID_CoIModelExplorer, NULL, CLSCTX_ALL, IID_IModelExplorer, (void**)&m_model_explorer
		);	

		IRoseAddInCollectionPtr addins = app->AddInManager->GetAddIns();

		for (int i=1; i < addins->Count+1; i++) {
			IRoseAddInPtr addin = addins->GetAt(i);
			if (addin->Name == (_bstr_t)TOOL_NAME) {
				addin->AddContextMenuItem (rsPackage, "MDA - View reports", "OnViewReports");
				addin->AddContextMenuItem (rsDiagram, "MDA - View reports", "OnViewReportsDG");
				addin->AddContextMenuItem (rsDefault, "MDA - View reports", "OnViewReportsDG");
				addin->AddContextMenuItem (rsClass, "MDA - View reports", "OnViewReports");
							
				addin->AddContextMenuItem (rsPackage, "MDA - Advanced Search", "OnAdvancedSearch");
				addin->AddContextMenuItem (rsDiagram, "MDA - Advanced Search", "OnAdvancedSearchDG");
				addin->AddContextMenuItem (rsDefault, "MDA - Advanced Search", "OnAdvancedSearchDG");
				addin->AddContextMenuItem (rsClass, "MDA - Advanced Search", "OnAdvancedSearch");			

				addin->AddContextMenuItem (rsDiagram, "MDA - CREATE NEW ELEMENT", "NewMdaElementDG");
				addin->AddContextMenuItem (rsPackage, "MDA - CREATE NEW ELEMENT", "NewMdaElement");
				addin->AddContextMenuItem (rsClass, "MDA - CREATE NEW ELEMENT", "NewMdaElement");
				addin->AddContextMenuItem (rsDefault, "MDA - CREATE NEW ELEMENT", "NewMdaElementDG");
							
				addin->AddContextMenuItem (rsDefault, "MDA - Colorize diagram", "Colorize");
				addin->AddContextMenuItem (rsDiagram, "MDA - Colorize diagram", "Colorize");

				addin->AddContextMenuItem (rsPackage, "MDA - Generate...", "Generate");
				addin->AddContextMenuItem (rsClass, "MDA - Generate owner package...", "Generate");
				addin->AddContextMenuItem (rsDiagram, "MDA - Generate owner package...", "GenerateDG");
				addin->AddContextMenuItem (rsDefault, "MDA - Generate owner package...", "GenerateDG");

				addin->AddContextMenuItem (rsPackage, "MDA - Generator properties", "MDAProperty");

				if (MDPSupport::MDPFacadeFactory::get ().is_server_exist ()) {
					addin->AddContextMenuItem (rsPackage, "MDA - Lock", "Lock")->MenuState = rsDisabled;
					addin->AddContextMenuItem (rsPackage, "MDA - UnLock", "UnLock")->MenuState = rsDisabled;
					addin->AddContextMenuItem (rsPackage, "MDA - Rollback", "Rollback")->MenuState = rsDisabled;
					addin->AddContextMenuItem (rsClass, "MDA - Lock owner package", "LockOP")->MenuState = rsDisabled;
					addin->AddContextMenuItem (rsClass, "MDA - Unlock owner package", "UnLockOP")->MenuState = rsDisabled;
					addin->AddContextMenuItem (rsClass, "MDA - Rollback owner package", "RollbackOP")->MenuState = rsDisabled;

					addin->AddContextMenuItem (rsClass, "MDA - View locked...", "SyncWithServer");
					addin->AddContextMenuItem (rsPackage, "MDA - View locked...", "SyncWithServer");
				}
			}
		}
		
		g_choice_dlg = new ChoiceType ();
		g_missed_dlg = new CGeneration::MissedGenFileDlg_i ();
		RoseAbstractDumper::set_choice_dlg (g_choice_dlg.in ());
		RoseAbstractDumper::set_missed_gen_file_dlg (g_missed_dlg.in ());

	} CATCH_LOG_AND_DO ("while CGeneration::OnActivate", return S_FALSE;);

	return S_OK;
}

STDMETHODIMP CGeneration::OnDeactivate(IRoseApplication *app) {
	AFX_MANAGE_STATE(AfxGetStaticModuleState())
	// Вызывается при выгрузке плагина	
	try {
		ChangedPackageInfo::instance ()->close ();
		g_choice_dlg = 0;
		g_missed_dlg = 0;
		MDPSupport::MDPFacadeFactory::get ().logout ();		
		if (m_model_explorer) {
			m_model_explorer->Clear ();
			m_model_explorer = 0;
		}
		CmdHandler::instance ()->clear ();
		//Commands::CmdManagerFactory::get ().clear ();
		RoseAbstractDumper::reset_model_tree_root ();
		RoseAbstractDumper::reset_all ();
		AbstractDumperBase::clean_up ();
		RoseHelper::set_rose_app (NULL);
		
		/*Core::GDS::ObjectCounterStatList_box stats = Core::GDS::CountHolderManager::CountHolderManagerSingleton::instance ()->get_current_statistic ();
		LOG_D(("ObjectCounter DEBUG  : dump current statistics\n"));
		LOG_D(("ObjectCounter DEBUG  : object types registred = %d\n", stats->size()));
		for (Core::GDS::ObjectCounterStatList::iterator it = stats->begin(); it != stats->end(); it++) {
			if (it->active_count.value ()) {
				LOG_D ((
					"ObjectCounter DEBUG  : Typename = %s; total created = %d; active = %d\n"
					, it->object_type.data()
					, it->total_created_count.value ()
					, it->active_count.value ()
				));				
			}
		}*/
		
	} CATCH_AND_LOG ("while CGeneration::OnDeactivate");

	COMDllInintializator::done ();
	return S_OK;
}

STDMETHODIMP CGeneration::OnNewModelElement(IRoseApplication* app, IRoseItem* item) {
	AFX_MANAGE_STATE(AfxGetStaticModuleState())
	LOG_D (("New element %s\n", (const char*)item->IdentifyClass ()));
	IRoseItemPtr rose_item = item;
	try {		
		RoseTreeState::instance ()->set_changed (true);
		
		this->reset_model_stereotype (item);

		if (rose_item->IsClass("Association") || rose_item->IsClass(CLASS_DEPENDENCY_TYPE)) {
			Core::Aptr<CmdHandler::OpenPropertiesParam> param = new CmdHandler::OpenPropertiesParam ();
			param->guid = get_rose_element_uid(rose_item);
			param->is_new = true;
			CmdHandler::instance ()->PostMessage (
				CmdHandler::WM_OPEN_PROPERTIES
				, 0
				, reinterpret_cast<LPARAM> (param.forget ())
			);
		} else if (rose_item->IsClass(CLASS_TYPE) || rose_item->IsClass(CATEGORY_TYPE) || rose_item->IsClass(ATTRIBUTE_TYPE) || rose_item->IsClass(OPERATION_TYPE)) {
			
		} else if (rose_item->IsClass("InheritRelation") || rose_item->IsClass("RealizeRelation")) {
		} else if (rose_item->IsClass ("DependencyRelation")) {
			MessageBox (0, "Нельзя проводить стрелки зависимости от пакета к классу и наоборот", "Неправильно проведена стрелка", MB_ICONERROR | MB_OK);
			return S_FALSE;
		}
		
		//инициализируем время создания элемента
		RoseHelper::get_creation_timestamp (item);

		if (m_model_explorer && rose_item) {
			IRoseElementPtr elem = rose_item;
			m_model_explorer->OnNewModelElement (app, elem);
		}
	} CATCH_AND_LOG ("in CGeneration::OnNewModelElement");
	return S_OK;
}

STDMETHODIMP CGeneration::OnModifiedModelElement(IRoseApplication* app, IRoseItem* item, int reason) {
	AFX_MANAGE_STATE(AfxGetStaticModuleState());

	if (reason == 6) {
		this->OnModifiedModelElementEx (app, item, reason, VARIANT ());
	}
	return S_OK;
}

void CGeneration::reset_model_stereotype (IRoseItem* item) {
	RoseAbstractDumper* rad = RoseAbstractDumper::find_in_tree (item);
	if (rad) {
		rad->reset_model_stereotype ();
	}

	RoseHelper::reset_gen_stereotype (item);
}

STDMETHODIMP CGeneration::OnModifiedModelElementEx(IRoseApplication* app, IRoseItem* item, int reason, VARIANT var) {
	AFX_MANAGE_STATE(AfxGetStaticModuleState())
	/*
	intReason Integer value indicating what modification was made to the model element. 
	Valid values are:
	1	Name Changed
	2	Language Changed
	3	Cardinality Changed
	4	Aggregation Changed
	5	End Point Changed
	6	Type Changed
	7	Initial Value Changed
	8	Stereotype Changed
	9	Visiblity Changed
	10	Context Changed
	*/
	//LOG_D (("%s, reason %d", GDS_CURRENT_FUNCTION, reason));
	
	try {
		if (reason == 8) { //Stereotype Changed			
			RoseTreeState::instance ()->set_changed (true);
		}

		if (reason == 5) { //на диаграмме у стрелки изменился родитель или цель
			RoseTreeState::instance ()->set_changed (true);
		}
		
		if (reason == 9) {//поменялась видимость
			RoseTreeState::instance ()->set_changed (true);
		}
		
		if (reason == 6) {//поменялся тип атрибута/операции/параметра
			RoseTreeState::instance ()->set_changed (true);
		}

		if (reason == 1 && item->IsClass (CLASS_TYPE)) {
			RoseTreeState::instance ()->set_changed (true);
		}

		if (reason == 5 || reason == 10 || reason == 8) {
			//нужно сборосить кэш стереотипа для элемента и его детей
			this->reset_model_stereotype (item);
		}

		if (m_model_explorer) {
			m_model_explorer->OnModifiedModelElementEx (app, item, reason, var);
		}
	} CATCH_AND_LOG ("in CGeneration::OnModifiedModelElementEx");
	return S_OK;
}

STDMETHODIMP CGeneration::OnDeletedModelElementEx(IRoseApplication* app, IRoseItem* item, IRoseItem* par) {
	AFX_MANAGE_STATE(AfxGetStaticModuleState());

	try {
		RoseTreeState::instance ()->set_changed (true);
		IRoseElementPtr deleted_item = item;
		IRoseElementPtr parent = par;
		RoseHelper::move_generated_source_to_parent (deleted_item, parent);
		
		this->reset_model_stereotype (item);

		if (m_model_explorer) {
			m_model_explorer->OnDeletedModelElementEx (app, item, par);
		}
	} CATCH_AND_LOG ("in CGeneration::OnDeletedModelElementEx");
	return S_OK;
}

STDMETHODIMP CGeneration::OnCloseModel(IRoseApplication *app) {
	AFX_MANAGE_STATE(AfxGetStaticModuleState());

	try {
		GCL::StrSet::iterator it = 
			RoseHelper::get_changed_diags ().begin ();
		
		GCL::StrSet::iterator it_end = 
			RoseHelper::get_changed_diags ().end ();
		
		for (; it != it_end; ++it) {
			IRoseDiagramPtr item = app->CurrentModel->FindDiagramWithID (it->c_str ());
			RoseHelper::override_property (item, TOOL_NAME, RoseHelper::DIAG_CHANGE_FLAG_PROPERTY, "true");
	#ifdef _DEBUG
			std::string name = RoseHelper::get_full_name (item);
			LOG_D (("!!!Changed diagram: %s", name.data ()));
	#endif
		}
		if (RoseHelper::get_changed_diags ().empty () == false) {
			RoseHelper::get_changed_diags ().clear ();
			app->CurrentModel->Save ();
		}
		//RoseHelper::get_changed_diags ().clear ();
		
		ChangedPackageInfo::instance ()->close ();

		MDPSupport::MDPFacadeFactory::get ().unsync (app->CurrentModel);
		if (m_model_explorer) {
			m_model_explorer->Clear ();	
		}
		RoseAbstractDumper::reset_model_tree_root ();
		RoseAbstractDumper::reset_all ();
		//RoseHelper::reset_template ();
		RoseTreeState::instance ()->reset ();
	} CATCH_AND_LOG ("in CGeneration::OnCloseModel");
	return S_OK;
}

STDMETHODIMP CGeneration::OnEnableContextMenuItems(IRoseApplication* app, int item_type, VARIANT_BOOL *result) {
	try {
		if (!MDPSupport::MDPFacadeFactory::get ().is_server_exist ()) {
			return S_OK;
		}

		IRoseAddInCollectionPtr addins = app->AddInManager->GetAddIns();
		if (item_type == rsPackage || item_type == rsClass) {
			for (int i=1; i < addins->Count+1; i++) {
				IRoseAddInPtr addin = addins->GetAt(i);
				if (addin->Name == (_bstr_t)TOOL_NAME) {
					IRoseContextMenuItemCollectionPtr cmitems = addin->GetContextMenuItems (item_type);
					for (int j = 1; j < cmitems->Count+1; j++) {
						IRoseContextMenuItemPtr it = cmitems->GetAt (j);
						if (0 == wcscmp (it->InternalName, L"Lock")) {
							IRoseItemCollectionPtr sel_items = app->CurrentModel->GetSelectedItems();
							IRoseCategoryPtr cat = sel_items->GetAt (1);
							if (cat) {
								MDPSupport::CatLockerFacade_var clf = 
									MDPSupport::CatLockerFacadeFactory::make (cat);
								if (1 == sel_items->Count && clf->can_lock ()) {
									it->MenuState = rsEnabled;
								} else {
									it->MenuState = rsDisabled;
								}
							}
						} else if (!wcscmp (it->InternalName, L"LockOP" )) {
							IRoseClassDiagramPtr rcd = (IRoseClassDiagramPtr)app->CurrentModel->GetActiveDiagram();
							IRoseCategoryPtr current_cat = (IRoseCategoryPtr)rcd->GetParentContext();
							MDPSupport::CatLockerFacade_var clf = 
								MDPSupport::CatLockerFacadeFactory::make (current_cat);
							if (clf->can_lock ()) {
								it->MenuState = rsEnabled;
							} else {
								it->MenuState = rsDisabled;
							}
						} else if (0 == wcscmp (it->InternalName, L"UnLock")) {
							IRoseItemCollectionPtr sel_items = app->CurrentModel->GetSelectedItems();
							IRoseCategoryPtr cat = sel_items->GetAt (1);
							if (cat) {
								MDPSupport::CatLockerFacade_var clf = 
									MDPSupport::CatLockerFacadeFactory::make (cat);
								if (1 == sel_items->Count && clf->can_commit ()) {
									it->MenuState = rsEnabled;
								} else {
									it->MenuState = rsDisabled;
								}
							}
						} else if (!wcscmp (it->InternalName, L"UnLockOP" )) {
							IRoseClassDiagramPtr rcd = (IRoseClassDiagramPtr)app->CurrentModel->GetActiveDiagram();
							IRoseCategoryPtr current_cat = (IRoseCategoryPtr)rcd->GetParentContext();
							MDPSupport::CatLockerFacade_var clf = 
								MDPSupport::CatLockerFacadeFactory::make (current_cat);
							if (clf->can_commit ()) {
								it->MenuState = rsEnabled;
							} else {
								it->MenuState = rsDisabled;
							}
						} else if (0 == wcscmp (it->InternalName, L"Rollback")) {
							IRoseItemCollectionPtr sel_items = app->CurrentModel->GetSelectedItems();
							IRoseCategoryPtr cat = sel_items->GetAt (1);
							if (cat) {
								MDPSupport::CatLockerFacade_var clf = 
									MDPSupport::CatLockerFacadeFactory::make (cat);
								if (1 == sel_items->Count && clf->can_rollback ()) {
									it->MenuState = rsEnabled;
								} else {
									it->MenuState = rsDisabled;
								}
							}
						} else if (!wcscmp (it->InternalName, L"RollbackOP" )) {
							IRoseClassDiagramPtr rcd = (IRoseClassDiagramPtr)app->CurrentModel->GetActiveDiagram();
							IRoseCategoryPtr current_cat = (IRoseCategoryPtr)rcd->GetParentContext();
							MDPSupport::CatLockerFacade_var clf = 
								MDPSupport::CatLockerFacadeFactory::make (current_cat);
							if (clf->can_rollback ()) {
								it->MenuState = rsEnabled;
							} else {
								it->MenuState = rsDisabled;
							}
						}
					}
				}
			}
		}
	} CATCH_AND_LOG ("in CGeneration::OnEnableContextMenuItems");
	return S_OK;
}
//#UC END# *456C42C601A5*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CGeneration::~CGeneration () {
	//#UC START# *456C42C601A5_DESTR_BODY*
	//#UC END# *456C42C601A5_DESTR_BODY*
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

