////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/MDACommands/MDACmdManager.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::MDACommands::MDACmdManager
//
// менеджер MDA-команд
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/LibHome.h"
#include "MDProcess/MDAAddinLib/impl/MDACommands/MDACmdManager.h"
// by <<uses>> dependencies
#include "MDProcess/MDAAddinLib/PropertyViews/ItemPropertySheet.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/MDAAddinLib/MDAGui/GenStatistics.h"
#include "MDProcess/MDAAddinLib/CommonViews/QuestionBox.h"
#include "MDProcess/MDAAddinLib/MDAGui/ReportView.h"
#include "MDProcess/MDAAddinLib/MDAGui/GeneratorSelect.h"
#include "MDProcess/MDAAddinLib/MDAGui/StCollection.h"
#include "MDProcess/MDAAddinLib/MDAGui/UnusedUserCode.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAAddinLib/CommonViews/EnterStringDialog.h"
#include "MDProcess/MDAAddinLib/MDAGui/AdvancedSearch.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "shared/GCL/os/dir_op.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseTreeState.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseCopyHelper.h"
#include "MDProcess/MDAAddinLib/LockViews/ChangedPackageInfo.h"
#include "MDProcess/MDAModel/RoseDumpers/MDAModelParams.h"
#include "MDProcess/MDAAddinLib/Helpers/Helpers.h"
#include "boost/lexical_cast.hpp"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAAddinLib/MDAGui/GenerationErrorDialog.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"

//#UC START# *462D87C6033C_CUSTOM_INCLUDES*
#include "shared/Core/GDS/MemoryWatcher.h"
//#UC END# *462D87C6033C_CUSTOM_INCLUDES*

namespace MDACommands {

//#UC START# *462D87C6033C*
//#UC END# *462D87C6033C*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// метод создания нового элемента - поднимает диалог выбора стереотипа, создает новый элемент вы
// зависимости от выбранного стереотипа
// 
// parent - элемент-родитель, в котором будет создан новый элемент
// element_type - {"all", "Class", "Category", "Operation", "Attribute" } - тип создаваемя элемента
// (в зависимости от него будет выбран ссоответствующий radio-button в диалоге выбора стереотипа)
IRoseItemPtr MDACmdManager::create_new_element (IRoseItemPtr parent, const std::string& element_type) {
	//#UC START# *462D96FE00AB*
	if (parent == 0) {
		return NULL;
	}
	if (RoseHelper::can_modify_elem (parent) == false) {		
		MessageBox (AfxGetMainWnd ()->GetSafeHwnd (), "Невозможно создать новый элемент, т.к работаем в режиме read-only", "Ошибка при создании нового элемента", MB_ICONEXCLAMATION);		
		return NULL;
	}		
	IRoseItemPtr new_item;		

	bool need_colorize = true;	
	StCollection st (0, parent);
	st.set_selected_type (element_type);
	st.DoModal();
	GCL::StrVector parts = GCL::split_string_by_sub_string (st.get_result().data(), "::");

	if (parts.size () < 2) {			
		return NULL;
	}
	
	IRoseClassDiagramPtr diag = parent->Model->GetActiveDiagram();

	if (parts[1] == "Class") {
		if (parts.size () > 2) {
			need_colorize = false;

			IRoseClassPtr target_cls = (IRoseClassPtr)parent;
			assert (target_cls != 0);
			if (parts[2] == "Operation") {						
				new_item = target_cls->AddOperation (RoseHelper::create_unic_name(parent, "new_operation").data(), "");
				new_item->Stereotype = "<default>";
			} else if (parts[2] == "Attribute") {
				new_item = target_cls->AddAttribute (RoseHelper::create_unic_name(parent, "new_attribute").data(), "", "");
				new_item->Stereotype = "<default>";
			} else if (parts.size () > 3) {						
				if (parts[3] == "Operation") {
					std::string name = "new_";
					name += parts[2];
					name += "_op";
					GCL::replace_char(name, ' ', '_');
					new_item = target_cls->AddOperation (RoseHelper::create_unic_name(parent, name.data()).data(), "");
				} else if (parts[3] == "Attribute") {
					std::string name = "new_";
					name += parts[2];
					name += "_attr";
					GCL::replace_char(name, ' ', '_');
					new_item = target_cls->AddAttribute (RoseHelper::create_unic_name(parent, name.data()).data(), "", "");
				} else {
					assert (0);
				}
				new_item->Stereotype = parts[2].data();

			} else {
				assert (0);
			}
		} else {
			IRoseClassPtr new_class;
			if (parent->IsClass(CLASS_TYPE)) {
				std::string name = "NewNested";
				name += parts[0];
				GCL::replace_char(name, ' ', '_');
				new_class = ((IRoseClassPtr)parent)->AddNestedClass(RoseHelper::create_unic_name(parent, name.data()).data());
			} else if (parent->IsClass(CATEGORY_TYPE)) {
				std::string name = "New";
				name += parts[0];
				GCL::replace_char(name, ' ', '_');
				new_class = ((IRoseCategoryPtr)parent)->AddClass(RoseHelper::create_unic_name(parent, name.data()).data());
			}

			new_item = new_class;
			new_class->Stereotype = parts[0].data();
			
			if (diag) {
				diag->AddClass (new_class);
			}
		}
	} else if (parts[1] == "Category") {
		IRoseCategoryPtr new_cat;
		if (parent->IsClass(CLASS_TYPE)) {
			assert (0);
		} else if (parent->IsClass(CATEGORY_TYPE)) {
			std::string name = "New";
			name += parts[0];
			GCL::replace_char(name, ' ', '_');
			new_cat = ((IRoseCategoryPtr)parent)->AddCategory(RoseHelper::create_unic_name(parent, name.data()).data());
		}					
		new_item = new_cat;
		new_cat->Stereotype = parts[0].data();
		if (diag) {
			diag->AddCategory (new_cat);
		}
	}
	return new_item;
	//#UC END# *462D96FE00AB*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

MDACmdManager::MDACmdManager ()
//#UC START# *48031C2C0060_48031C62008B_462D87C6033C_BASE_INIT*
//#UC END# *48031C2C0060_48031C62008B_462D87C6033C_BASE_INIT*
{
	//#UC START# *48031C2C0060_48031C62008B_462D87C6033C_BODY*
	CoCreateInstance(
		 CLSID_CoIModelExplorer, NULL, CLSCTX_ALL, IID_IModelExplorer, (void**)&m_model_explorer
	);
	//#UC END# *48031C2C0060_48031C62008B_462D87C6033C_BODY*
}

MDACmdManager::~MDACmdManager () {
	//#UC START# *462D87C6033C_DESTR_BODY*
	m_model_explorer = 0;
	//#UC END# *462D87C6033C_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// запуск генерации элементов из списка флаг need_auto_rep указывает нужно ли запускать  построение
// автоматических отчетов или нет
void MDACmdManager::generate_impl (RoseElementVector& rose_items, bool need_auto_rep) {
	//#UC START# *4ACC68BA010C*
	class timer {
	public :
		timer (const char* msg)
			: m_msg (msg), hi_res_counter ()
		{
		}

		~timer () {
			unsigned sec = 0;
			unsigned msec = 0;
			unsigned usec = 0;
			hi_res_counter.tiks_to_time (hi_res_counter.get_count (), sec, msec, usec);

			LOG_I (("RT of \"%s\":\t%us, %ums, %uus"
				, m_msg.c_str ()
				, sec
				, msec
				, usec
			));
			
			//LOG_I (("%s: %0.5fsec", m_msg, hi_res_counter.get_seconds ()));
		}
	private:
		std::string m_msg;
		Core::GDS::HiResCounter hi_res_counter;
	};
	
	struct AutoCleaner {
		AutoCleaner () {
			GenSupport::LogManagerFactory::get ().init ();
			GenSupport::ErrorManagerFactory::get ().clear_errors ();
		}

		~AutoCleaner () {
		}
	};

	AutoCleaner auto_cleaner;

	try {
		if (!rose_items.empty ()) {
			RoseHelper::reset_template ();
			RoseHelper::load_template ();
			
			RoseAbstractDumper* ad = 0;

			bool need_rebuild_tree = false;
		
			

			do {
				if (
					AbstractDumperBase::is_has_error ()				
				) {
					RoseAbstractDumper::reset_model_tree_root ();
				}

				RoseAbstractDumper::get_model_tree_root();

				GenSupport::EnvironmentFactory::get ().set_cancel_generation (0);
				
				GenSupport::EnvironmentFactory::get ().set_lock_failed_need_ask (true);
				GenSupport::EnvironmentFactory::get ().set_lock_failed_need_fatal_error (true);
				
				if (
					AbstractDumperBase::is_has_error () 
					&& !GenSupport::EnvironmentFactory::get ().get_suppress_generation_errors ()
				) {
					MessageBox (
						AfxGetMainWnd ()->GetSafeHwnd ()
						, "Обнаружены структурные ошибки метамодели - см. лог для деталей"
						, "Ошибка"
						, MB_ICONEXCLAMATION
					);

					GenSupport::LogManagerFactory::get ().log_info("Сodogeneration breaks by matamodel errors");
					GenSupport::EnvironmentFactory::get ().set_cancel_generation (1);
					return;
				}			
				
				AbstractDumper::prepare ();

				for (
					RoseElementVector::iterator it = rose_items.begin ()
					; it != rose_items.end ()
					; ++it
				) {
					const RoseAbstractDumper* ad = RoseAbstractDumper::find_in_tree (it->element);
					if (ad) {
						ad->prepare_output_cache ();
					}						
				}

				need_rebuild_tree = RoseHelper::check_model_for_changes ();

				if (need_auto_rep && !need_rebuild_tree) {
					if (
						AbstractDumperBase::is_has_error () 
						&& !GenSupport::EnvironmentFactory::get ().get_suppress_generation_errors ()
					) {
						MessageBox (AfxGetMainWnd ()->GetSafeHwnd (), "Обнаружены структурные ошибки метамодели- см. лог для деталей", "Ошибка", MB_ICONEXCLAMATION);
						GenSupport::LogManagerFactory::get ().log_info("Сodogeneration breaks by metamodel errors");
						GenSupport::EnvironmentFactory::get ().set_cancel_generation (1);
						return;
					}
					
					// run auto reports			
					for (
						AbstractDumperBase::ReportInfos::iterator it = AbstractDumperBase::s_report_infos.begin()
						; it != AbstractDumperBase::s_report_infos.end()
						; ++it
					) {
						if (!it->second->get_auto().empty ()) {
							ReportView dlg (rose_items, it->second);
							if (dlg.DoModal() != IDOK) {
								GenSupport::EnvironmentFactory::get ().set_cancel_generation (1);
								return;
							}						
						}
					}
				}
			} while (RoseTreeState::instance ()->is_changed () == true || need_rebuild_tree);
			
			if (
				AbstractDumperBase::is_has_error () 
				&& !GenSupport::EnvironmentFactory::get ().get_suppress_generation_errors ()
			) {
				MessageBox (AfxGetMainWnd ()->GetSafeHwnd (), "Обнаружены структурные ошибки метамодели- см. лог для деталей", "Ошибка", MB_ICONEXCLAMATION);
				GenSupport::LogManagerFactory::get ().log_info("Сodogeneration breaks by matamodel errors");
				GenSupport::EnvironmentFactory::get ().set_cancel_generation (1);
				return;
			}

			RoseAbstractDumper::RADVector items;
			for (
				RoseElementVector::iterator it = rose_items.begin ()
				; it != rose_items.end ()
				; ++it
			) {
				const RoseAbstractDumper* ad = RoseAbstractDumper::find_in_tree (it->element);
				if (ad) {
					items.push_back (ad);
				}
			}

			const RoseAbstractDumper* first = *(items.begin ());
			
			GenSupport::LogManagerFactory::get ().log_info("Codogeneration starts");
			GenSupport::EnvironmentFactory::get ().set_cancel_generation (0);


			RoseAbstractDumper::s_selections_map.clear ();
			AbstractDumper::before_dump ();
			for (
				RoseAbstractDumper::RADVector::iterator it = items.begin ()
				; it != items.end ()
				; ++it
			) {
				const AbstractDumper* ad = *it;
				if (ad) {
					RoseAbstractDumper::auto_locker locker;
					{
						
						std::string mes = "Start generation from ";
						mes += ad->get_full_name ();
						mes += "...";
						ad->write_info_log (mes);
						
						timer sw (mes.c_str ());
						try {							
							ad->dump_start();
						} catch (...) {
							GenSupport::EnvironmentFactory::get ().set_cancel_generation (1);
							AbstractDumper::check_unique_outputs (ad);
							ad->push_changes ();
							AbstractDumper::reset ();
							//RoseAbstractDumper::unlock_reset();
							throw;
						}
												
						if (
							AbstractDumperBase::is_has_error () 
							&& !GenSupport::EnvironmentFactory::get ().get_suppress_generation_errors ()
						) {
							AbstractDumperBase::has_error(false);
							MessageBox (AfxGetMainWnd ()->GetSafeHwnd (), "В модели обнаружены нарушения шаблона - см. лог для деталей", "Ошибка", MB_ICONEXCLAMATION);
							GenSupport::LogManagerFactory::get ().log_info("Codogeneration breaks by template constraints");
							GenSupport::EnvironmentFactory::get ().set_cancel_generation (1);	
						}

						AbstractDumper::check_unique_outputs (ad);
						
						Core::GDS::StopWatch push_changes_sw ("push_changes");
						ad->push_changes ();
					}					
					//RoseAbstractDumper::unlock_reset();
				}
			}

			if (!GenSupport::EnvironmentFactory::get ().get_cancel_generation ()) {
				try {
					if (!GenSupport::ErrorManagerFactory::get ().get_errors ().empty ()) {
						GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
						dlg.DoModal ();
					}

					UnusedUserCode uuc;
					if (uuc.DoModal() == IDCANCEL) {
						GenSupport::EnvironmentFactory::get ().set_cancel_generation (1);
					} else {
						GenStatistics stat;
						unsigned int res = stat.DoModal();
						stat.remove_temp_files ();
						
						if (res == IDOK) {
							AbstractDumper::dump_commit (first);
							AbstractDumper::persistent_commit (stat.is_minor_changes ());
						}
					}					
				} catch (...) {
					AbstractDumper::reset ();
					throw;
				}
			}
			AbstractDumper::reset ();

			GenSupport::LogManagerFactory::get ().log_info("Codogeneration finished");
#if HAS_OBJECT_COUNTER			
			Core::GDS::ObjectCounterStatList_box stats = Core::GDS::CountHolderManager::CountHolderManagerSingleton::instance ()->get_current_statistic ();
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
			}
#endif

#if defined (_DEBUG)
			//allocation statistics
			LOG_I ((
				"Memory allocation statistic:\n"
				"'alloc' calls: %Q times.\n"
				"'realloc' calls: %Q times.\n"
				"'free' calls: %Q times.\n"
				"\r\n"
				"Allocated size: %Q bytes.\n"
				"Allocated peak size: %Q bytes.\n"
				, Core::GDS::MemoryWatcher::alloc_call_count ()
				, Core::GDS::MemoryWatcher::realloc_call_count ()
				, Core::GDS::MemoryWatcher::free_call_count ()
				, Core::GDS::MemoryWatcher::allocated_size ()
				, Core::GDS::MemoryWatcher::allocated_size_peak ()
			));
			//allocation statistics
#endif

			for (
				RoseAbstractDumper::RADVector::iterator it = items.begin ()
				; it != items.end ()
				; ++it
			) {
				IRoseElementPtr elem = (*it)->rose_element ();
				if (elem->IsClass (CATEGORY_TYPE) && !RoseHelper::is_incomplete (elem)) {
					std::string model_path = elem->Model->GetFileName ();
					const std::string path_component_to_control = MDAModelParams::get_path_component_to_control ();
					if (model_path.find (path_component_to_control) != std::string::npos) {
						GenSupport::LogManagerFactory::get ().log_info ("Start try control cat");
						bool something_controlled = control_all (elem);
						if (something_controlled == true) {
							::MessageBox (
								AfxGetMainWnd ()->GetSafeHwnd ()
								, "Некоторые пакеты были помещены в отдельные cat-ы - не забудьте поместить их в CVS"
								, "Внимание!"
								, MB_OK | MB_ICONINFORMATION
							);
						}
						GenSupport::LogManagerFactory::get ().log_info ("Finished try control cat");
					}
				}
			}
		}
	} catch (Base::FatalError& ex) {
		//RoseAbstractDumper::reset_model_tree_root ();
		RoseAbstractDumper::has_error (false);

		/*GenSupport::LogManagerFactory::get ().log_error ("Codogeneration finished by Fatal error:");
		GenSupport::LogManagerFactory::get ().log_error (ex.what ());
		MessageBox (AfxGetMainWnd ()->GetSafeHwnd (), "Генерациия завершилась ошибкой смотри лог для деталей", "Ошибка", MB_OK|MB_ICONEXCLAMATION );*/
		if (GenSupport::ErrorManagerFactory::get ().get_errors ().empty ()) {
			GenSupport::ErrorManagerFactory::get ().error (0, ex.what (), "Генерация");
			GenSupport::LogManagerFactory::get ().log_error (ex.what ());
		}

		GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
		dlg.DoModal ();

	} catch (std::exception& ex) {

		/*std::string mess ("Во время генерации кода произошло исключение: ");
		mess += ex.what ();
		MessageBox (AfxGetMainWnd ()->GetSafeHwnd (), _T (mess.c_str ()), "Ошибка", MB_OK|MB_ICONEXCLAMATION );*/

		GenSupport::ErrorManagerFactory::get ().error (0, ex.what (), "Генерация");
		GenSupport::LogManagerFactory::get ().log_error (ex.what ());

		GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
		dlg.DoModal ();
	} catch (CORBA::Exception& ex) {

		/*std::string mess ("Во время генерации кода произошло исключение:\n");
		mess += ex._info ().c_str ();
		MessageBox (AfxGetMainWnd ()->GetSafeHwnd (), _T (mess.c_str ()), "Ошибка", MB_OK|MB_ICONEXCLAMATION );*/
		GenSupport::ErrorManagerFactory::get ().error (0, ex._info ().c_str (), "Генерация");
		GenSupport::LogManagerFactory::get ().log_error (ex._info ().c_str ());

		GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
		dlg.DoModal ();
	} catch (_com_error& ex) {

		/*std::string mess ("Во время генерации кода произошло исключение: _com_error (\n");
		mess += ex.ErrorMessage ();
		mess += ")";
		MessageBox (AfxGetMainWnd ()->GetSafeHwnd (), _T (mess.c_str ()), "Ошибка", MB_OK|MB_ICONEXCLAMATION );*/
		GenSupport::ErrorManagerFactory::get ().error (0, ex.ErrorMessage (), "Генерация");
		GenSupport::LogManagerFactory::get ().log_error (ex.ErrorMessage ());

		GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
		dlg.DoModal ();
	} catch (...) {
		//MessageBox (AfxGetMainWnd ()->GetSafeHwnd (), "Во время генерации кода произошло не обработанное исключение", "Ошибка", MB_OK | MB_ICONEXCLAMATION );
		GenSupport::ErrorManagerFactory::get ().error (0, "Во время генерации кода произошло не обработанное исключение", "Генерация");
		GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
		dlg.DoModal ();
	}
	//#UC END# *4ACC68BA010C*
}

// Выводит диалог с предложением сохранить изменения модели (если изменения были)? возвращает true,
// если все успешно сохранено, false - если пользователь нажал "Отмена"
bool MDACmdManager::save_model_if_need () const {
	//#UC START# *4D3416F100EA*
	bool ok = true;

	if (RoseHelper::check_model_for_changes ()) {
		int res = QuestionBox::show (
			"Вы хотите сохранить модель перед генерацией?"
			, "Модель была изменена"
			);
		if (res == IDOK) {
			RoseHelper::rose_app()->CurrentModel->Save ();
		} else if (res == IDCANCEL) {
			ok = false;
		}
	}

	return ok;
	//#UC END# *4D3416F100EA*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Commands::CmdManager
// очищает свойства элемента, оставляя только необходимые (списки derived impl; списки исключений;
// UP, определенные в шаблоне)
void MDACmdManager::clean_properties (IRoseElementPtr elem) {
	//#UC START# *4AFBC0BA0246_462D87C6033C*
	class local_helper {
	public:
		static GCL::StrSet* collect_all_inherites_and_realized (const IRoseClassPtr& cls) {
			Core::Aptr<GCL::StrSet> result = new GCL::StrSet ();
			collect_all_inherites_and_realized (cls, *result.ptr ());

			return result.forget ();
		}

		static void collect_all_inherites_and_realized (const IRoseClassPtr& cls, GCL::StrSet& collection) {
			IRoseInheritRelationCollectionPtr inherites = cls->GetInheritRelations ();
			short inherites_count = inherites->Count;

			for (short i = 1; i <= inherites_count; ++i) {
				IRoseInheritRelationPtr inherite = inherites->GetAt (i);
				IRoseClassPtr inherite_cls = inherite->GetSupplierClass ();
				if (inherite_cls) {
					collection.insert (get_rose_element_uid(inherite_cls));
					collect_all_inherites_and_realized (inherite_cls, collection);
				}
			}

			IRoseRealizeRelationCollectionPtr realizations = cls->GetRealizeRelations ();
			short realizations_count = realizations->Count;

			for (short i = 1; i <= realizations_count; ++i) {
				IRoseRealizeRelationPtr realization = realizations->GetAt (i);
				IRoseClassPtr realization_cls = realization->GetSupplierClass ();
				if (realization_cls) {
					collection.insert (get_rose_element_uid(realization_cls));
					collect_all_inherites_and_realized (realization_cls, collection);
				}
			}
		}

		local_helper (const IRoseElementPtr& elem) 
			: m_elem (elem), m_template (0), m_user_properties (0)
		{
		}

		AbstractDumperBase::Template& get_template () {
			if (!this->m_template) {
				AbstractDumperBase::StereotypeID stereotype = RoseHelper::get_gen_stereotype(m_elem);
				this->m_template = &AbstractDumperBase::get_template (stereotype);				
			}

			return *this->m_template;
		}

		AbstractDumperBase::UserPropertyMap& get_user_properties () {
			if (m_user_properties.is_nil ()) {
				m_user_properties = new AbstractDumperBase::UserPropertyMap ();

				AbstractDumperBase::Template& tpl = this->get_template ();
				if (tpl.user_properties_group.is_nil () == false) {		
					tpl.user_properties_group->for_each (
						AbstractDumperBase::CollectUserProperty ()
						, *m_user_properties.ptr ()
					);
				}
			}
			return *m_user_properties;
		}
	private:
		IRoseElementPtr m_elem;
		AbstractDumperBase::Template* m_template;
		Core::Aptr<AbstractDumperBase::UserPropertyMap> m_user_properties;
	};

	std::string message (GDS_CURRENT_FUNCTION);
	message += " : process \"";
	message += RoseHelper::get_full_name (elem);
	message += "\"";
	GenSupport::LogManagerFactory::get ().log_info (message.c_str ());

	IRosePropertyCollectionPtr all_props = elem->GetAllProperties ();
	short all_props_count = all_props->Count;


	local_helper template_loader (elem);

	IRosePropertyCollectionPtr for_clean (__uuidof(RosePropertyCollection));

	IRoseModelPtr model = elem->Model;

	IRoseClassPtr elem_as_class;
	Core::Aptr<GCL::StrSet> all_inherites_and_realized;
	if (elem->IsClass (CLASS_TYPE)) {
		elem_as_class = elem;
		all_inherites_and_realized = local_helper::collect_all_inherites_and_realized (elem);
	}

	for (short i = 1; i <= all_props_count; ++i) {
		IRosePropertyPtr prop = all_props->GetAt (i);
		if (PropertyHelperFactory::get ().can_be_deleted (prop)) {
			prop->PutValue ("");
			for_clean->Add (prop);
		} else {
			std::string prop_name = prop->GetName ();
			std::string tool_name = prop->GetToolName ();
			if (
				prop_name == std::string (static_cast<const char*> (_bstr_t (PROP_DERIVED_IMPLEMENT)))
				|| prop_name == std::string (static_cast<const char*> (_bstr_t (PROP_DERIVED_OVERLOAD)))
			) {
				if (
					elem_as_class != 0 
					&& !all_inherites_and_realized.is_nil ()
					&& !all_inherites_and_realized->empty ()
				) {
					//если элемент в действительности не связан c элементами-родителями
					//операций/атрибутов из этих списков, то нужно их из этого списка удалить

					//TODO: переделать на использование InheritedItemHelper
					Core::Aptr<InheritedItemSet> inhertied_items = InheritedItemHelperFactory::get ().get_stored_inherited_items (
						elem, prop_name
					);

					std::string value = prop->GetValue ();
					//GCL::StrSet items;
					//GCL::split_string_by (items, value.c_str (), ',');

					//получаем классы - от которых унаследовали эти операции:
					InheritedItemSet updated_inherited_items;
					ModelSearcher* searcher = &ModelSearcherFactory::get ();
					
					for (InheritedItemSet::const_iterator it = inhertied_items->begin(); it != inhertied_items->end(); ++it) {
						std::string guid = (*it)->get_uid ();
						IRoseItemPtr item = searcher->search (guid);

						if (item) {
							if (!(*it)->get_need_collect_children ()) {
								//если это не рутовый элемент в списке DerivedImpl
								IRoseItemPtr cls = RoseHelper::get_nearest_container (RoseHelper::get_context (item));

								if (cls) {
									std::string cls_guid (get_rose_element_uid(cls));
									if (
										all_inherites_and_realized->find (cls_guid) 
											!= all_inherites_and_realized->end ()
									) {
										updated_inherited_items.insert (*it);
									}
								}
							} else if (all_inherites_and_realized->find (guid) != all_inherites_and_realized->end ()) {
								updated_inherited_items.insert (*it);
							}		
						}
					}

					std::string updated_property_value = InheritedItemHelperFactory::get ().stored_value (updated_inherited_items);

					if (updated_property_value != value) {
						prop->PutValue (updated_property_value.c_str ());
						for_clean->Add (prop);
					}
				} else {
					//если не класс или не имеет связей наследования/реализации - удаляем свойство
					prop->PutValue ("");
					for_clean->Add (prop);
				}
			} else if (tool_name == std::string (static_cast<const char*> (_bstr_t (Base::USER_PROPERTY_TOOL)))) {
				//если UP не из шаблона - нужно его удалить
				AbstractDumperBase::UserPropertyMap& props = template_loader.get_user_properties ();
				if (props.find (prop_name) == props.end ()) {
					prop->PutValue ("");
					for_clean->Add (prop);
				}
			}
		}
	}

	short for_clean_count = for_clean->Count;
	for (short i = 1; i <= for_clean_count; ++i) {
		IRosePropertyPtr prop = for_clean->GetAt (i);
		RoseHelper::write_property_with_lock (
			elem
			, static_cast<const char*> (prop->GetToolName ())
			, static_cast<const char*> (prop->GetName ())
			, static_cast<const char*> (prop->GetValue ())
			, GenSupport::LS_LOCK_ALL
			, true
			, static_cast<const char*> (prop->GetName ())
		);
	}
	//#UC END# *4AFBC0BA0246_462D87C6033C*
}

// implemented method from Commands::CmdManager
// То же, что и clean_properties, но применяется рекурсивно но всем детям элемента
void MDACmdManager::clean_properties_recursively (IRoseElementPtr elem) {
	//#UC START# *4AFBC132012E_462D87C6033C*

	this->clean_properties (elem);
	Core::Aptr<RoseElementSet> all_childs;
	if (elem->IsClass (MODEL_TYPE)) {
		all_childs = RoseHelper::get_all_childs (((IRoseModelPtr)elem)->RootCategory);
	} else {
		all_childs = RoseHelper::get_all_childs (elem);
	}

	if (!all_childs.is_nil ()) {
		for (RoseElementSet::iterator it = all_childs->begin (); it != all_childs->end (); ++it) {
			this->clean_properties (it->element);			
		}
	}
	//#UC END# *4AFBC132012E_462D87C6033C*
}

// implemented method from Commands::CmdManager
// раскраска диграммы
void MDACmdManager::colorize (IRoseDiagramPtr diag) {
	//#UC START# *48031C6B022D_462D87C6033C*
	try {
		RoseHelper::reset_template ();
		if (RoseHelper::load_template ()) {
			MDPSupport::CatLockerFacade_var clf =
				MDPSupport::CatLockerFacadeFactory::make ((IRoseElementPtr)diag);
			if (false == clf->try_change ()) {
				GenSupport::LogManagerFactory::get ().log_warning ("Can't colorize diagram, because lock failed");
				return;
			}
			RoseHelper::colorize (diag);
			clf->do_change ();
		}
	} catch (Base::FatalError&) {
		GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
		dlg.DoModal ();
	}
	//#UC END# *48031C6B022D_462D87C6033C*
}

// implemented method from Commands::CmdManager
// раскрашивает все диаграммы в cat, с учетом вложенных
void MDACmdManager::colorize_all_diagrams (IRoseCategoryPtr cat) {
	//#UC START# *48031C740232_462D87C6033C*
	try {
		RoseHelper::reset_template ();
		if (RoseHelper::load_template ()) {
			GenSupport::LogManagerFactory::get ().log_info ("Colorize all diagram started");
			IRoseClassDiagramCollectionPtr cls_diags = cat->ClassDiagrams;
			short cls_diags_count = cls_diags->Count;		
			
			if (cls_diags_count != 0) {
				MDPSupport::CatLockerFacade_var cat_clf =
					MDPSupport::CatLockerFacadeFactory::make ((IRoseCategoryPtr)cat);
				if (false == cat_clf->try_change ()) {
					GenSupport::LogManagerFactory::get ().log_warning ("Can't colorize diagram, because lock failed");
					return;
				}
				
				for (int i = 1; i <= cls_diags_count; i++) {
					IRoseClassDiagramPtr diag = cls_diags->GetAt(i);
					RoseHelper::colorize (diag);
				}
				
				cat_clf->do_change ();
			}
			
			IRoseCategoryCollectionPtr cats = cat->GetAllCategories	();
			short cats_count = cats->Count;
			for (int i = 1; i <= cats_count; i++) {
				IRoseCategoryPtr ch_cat = cats->GetAt(i);
				MDPSupport::CatLockerFacade_var ch_cat_clf =
					MDPSupport::CatLockerFacadeFactory::make ((IRoseCategoryPtr)cat);
				if (false == ch_cat_clf->try_change ()) {
					std::string mess ("Lock failed for cat: ");
					mess += (const char*)ch_cat->Name;
					GenSupport::LogManagerFactory::get ().log_error (mess.c_str ());
					continue;
				}

				IRoseClassDiagramCollectionPtr cls_diags_ch = ch_cat->ClassDiagrams;
				short cls_diags_ch_count = cls_diags->Count;
				for (int j = 1; j <= cls_diags_ch_count; j++) {
					IRoseClassDiagramPtr diag = cls_diags_ch->GetAt(j);
					this->colorize (diag);
				}

				ch_cat_clf->do_change ();
			}

			GenSupport::LogManagerFactory::get ().log_info ("Colorize all diagram finished");
		}
	} catch (Base::FatalError&) {
		GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
		dlg.DoModal ();
	}
	//#UC END# *48031C740232_462D87C6033C*
}

// implemented method from Commands::CmdManager
// "выливает" папку в отдельный кат
// возвращает true в случае успеха, иначе false
bool MDACmdManager::control (IRoseCategoryPtr cat) {
	//#UC START# *48031C76013C_462D87C6033C*
	bool res = false;
	IRoseCategoryPtr rootCat = cat->Model->GetRootCategory();
	if (
		get_rose_element_uid(cat) != get_rose_element_uid(rootCat)
		&& !cat->IsControlled () 
		&& RoseHelper::can_control (cat)
	) {
		std::string dir_path = RoseHelper::create_dir_path (cat);				
		if (GCL::create_tree_dirs (dir_path.c_str (), false)) {
			std::string full_name = dir_path 
				+ "\\" 
				+ RoseHelper::clean_wrong_sympbols (cat->Name) 
				+ ".cat";
			IRoseCategoryPtr parent = RoseHelper::get_nearest_controllable_unit (cat);
			MDPSupport::CatLockerFacade_var clf =
				MDPSupport::CatLockerFacadeFactory::make (parent);
			if (false == clf->try_change ()) {
				GenSupport::LogManagerFactory::get ().log_warning ("Can't control package, because lock failed");
				return false;
			}
			if (!cat->Control (full_name.c_str ())) {					
				std::string mess = "Can't control Category: ";
				mess += full_name;
				GenSupport::LogManagerFactory::get ().log_error (mess.c_str ());
			} else {
				res = true;
				std::string mess = "Category: ";
				mess += (const char*) cat->Name;
				mess += " was controlled to file: ";
				mess += full_name;
				GenSupport::LogManagerFactory::get ().log_info (mess.c_str ());
				//controlled_set.insert (full_name);
			}
			clf->do_change ();
		} else {
			std::string mess = "Can't create tree dirs: ";
			mess += dir_path;
			GenSupport::LogManagerFactory::get ().log_error (mess.c_str ());
		}				
	}
	return res;
	//#UC END# *48031C76013C_462D87C6033C*
}

// implemented method from Commands::CmdManager
// операция "control" применяется к cat и всем подпапкам рекурсивно
bool MDACmdManager::control_all (IRoseCategoryPtr cat) {
	//#UC START# *48031C77031C_462D87C6033C*
	bool res = control (cat);
	IRoseCategoryCollectionPtr cats = cat->GetAllCategories ();
	short cats_count = cats->Count;
	for (short i = 1; i <= cats_count; ++i) {
		IRoseCategoryPtr sub_cat = cats->GetAt (i);
		res |= control (sub_cat);
	}
	return res;
	//#UC END# *48031C77031C_462D87C6033C*
}

// implemented method from Commands::CmdManager
// выливает папку в отдельный кат, путь к кату выбирается пользователем
bool MDACmdManager::control_to_file (IRoseCategoryPtr cat) {
	//#UC START# *48031C790311_462D87C6033C*
	bool res = false;
	if (
		!cat->IsControlled () 
		&& RoseHelper::can_control (cat)
	) {
		CFileDialog f_dlg (false);
		if (f_dlg.DoModal() == IDOK) {
			std::string file_name = (LPCTSTR)f_dlg.GetPathName();
			
			IRoseCategoryPtr parent = RoseHelper::get_nearest_controllable_unit (cat);
			MDPSupport::CatLockerFacade_var clf =
				MDPSupport::CatLockerFacadeFactory::make (parent);
			if (false == clf->try_change ()) {
				GenSupport::LogManagerFactory::get ().log_warning ("Can't control package, because lock failed");
				return false;
			}
			if (!cat->Control (file_name.c_str ())) {					
				std::string mess = "Can't control Category: ";
				mess += file_name;
				GenSupport::LogManagerFactory::get ().log_error (mess.c_str ());
			} else {
				res = true;
				std::string mess = "Category: ";
				mess += (const char*) cat->Name;
				mess += " was controlled to file: ";
				mess += file_name;
				GenSupport::LogManagerFactory::get ().log_info (mess.c_str ());
			}
			clf->do_change ();
		}
	}
	return res;
	//#UC END# *48031C790311_462D87C6033C*
}

// implemented method from Commands::CmdManager
// копирует элемент item в parent
// возвращает новый элемент
IRoseElementPtr MDACmdManager::copy (IRoseElementPtr item, IRoseElementPtr parent) {
	//#UC START# *48031C7A03D7_462D87C6033C*
	MDPSupport::CatLockerFacade_var clf_item =
		MDPSupport::CatLockerFacadeFactory::make ((IRoseElementPtr)item);
	
	MDPSupport::CatLockerFacade_var clf_new_parent =
		MDPSupport::CatLockerFacadeFactory::make ((IRoseElementPtr)parent);
	if (
		false == clf_item->try_change () 
		|| false == clf_new_parent->try_change ()		
	) {
		GenSupport::LogManagerFactory::get ().log_warning ("Can't copy item, because lock failed");
		return false;
	}
	IRoseElementPtr res;
	if (item->IsClass (CLASS_TYPE)) {		
		if (parent->IsClass (CLASS_TYPE)) {
			IRoseClassPtr parent_cls = parent;
			IRoseClassCollectionPtr classes = parent_cls->GetNestedClasses ();
			short index = classes->FindFirst (item->Name);
			if (index == 0) {
				IRoseClassPtr cls = item;
				IRoseClassPtr new_cls = parent_cls->AddNestedClass (cls->Name);
				new_cls->Stereotype = cls->Stereotype;
				new_cls->Documentation = cls->Documentation;
				RoseCopyHelper::copy_mda_property (cls, (IRoseElementPtr)new_cls, false);
				res = new_cls;
			} else {
				std::string mess = "Can't copy class: ";
				mess += RoseHelper::get_full_name (item);
				mess += ", because new parent already have class with same name";
				GenSupport::LogManagerFactory::get ().log_error (mess.c_str ());
				
				res = 0;
			}
		} else if (parent->IsClass (CATEGORY_TYPE)) {
			IRoseCategoryPtr parent_cat = parent;
			IRoseClassCollectionPtr classes = parent_cat->GetClasses ();
			short index = classes->FindFirst (item->Name);
			if (index == 0) {
				IRoseClassPtr cls = item;
				IRoseClassPtr new_cls = parent_cat->AddClass (cls->Name);
				new_cls->Stereotype = cls->Stereotype;
				new_cls->Documentation = cls->Documentation;
				RoseCopyHelper::copy_mda_property (cls, (IRoseElementPtr)new_cls, false);
				res = new_cls;
			} else {
				std::string mess = "Can't copy class: ";
				mess += RoseHelper::get_full_name (item);
				mess += ", because new parent already have class with same name";
				GenSupport::LogManagerFactory::get ().log_error (mess.c_str ());
				
				res = 0;
			}
		} else {
			res = 0;
		}
	} else if (item->IsClass (CLASS_TYPE)) {
		if (parent->IsClass (CLASS_TYPE)) {
			IRoseCategoryPtr parent_cat = parent;
			IRoseCategoryCollectionPtr parent_cats = parent_cat->GetCategories ();
			short index = parent_cats->FindFirst (item->Name);
			if (index == 0) {
				IRoseCategoryPtr cat = item;
				IRoseCategoryPtr new_cat = parent_cat->AddCategory (cat->Name);
				new_cat->Stereotype = cat->Stereotype;
				new_cat->Documentation = cat->Documentation;
				RoseCopyHelper::copy_mda_property (cat, (IRoseElementPtr)new_cat, false);
				res = new_cat;
			} else {
				std::string mess = "Can't copy category: ";
				mess += RoseHelper::get_full_name (item);
				mess += ", because new parent already have category with same name";
				GenSupport::LogManagerFactory::get ().log_error (mess.c_str ());
				res = 0;
			}
			
		} else {
			res = 0;
		}
	} else if (item->IsClass (OPERATION_TYPE)) {
		if (parent->IsClass (CLASS_TYPE)) {
			IRoseClassPtr parent_cls = parent;
			IRoseOperationPtr op = item;
			IRoseOperationPtr new_op = parent_cls->AddOperation (
				op->GetName (), op->GetReturnType ()
			);
			RoseCopyHelper::copy (op, new_op, false);
			res = new_op;
		} else {
			res = 0;
		}
	} else if (item->IsClass (ATTRIBUTE_TYPE)) {
		if (parent->IsClass (CLASS_TYPE)) {
			IRoseClassPtr parent_cls = parent;
			IRoseAttributePtr attr = item;
			IRoseAttributePtr new_attr = parent_cls->AddAttribute (
				attr->GetName (), attr->GetType (), attr->GetInitValue ()
			);

			RoseCopyHelper::copy (attr, new_attr, false);
			res = new_attr;
		} else {
			res = 0;
		}
	}
	if (res) {
		clf_item->do_change ();
		clf_new_parent->do_change ();
	}
	return res;
	//#UC END# *48031C7A03D7_462D87C6033C*
}

// implemented method from Commands::CmdManager
// операция генерации выбранного элемента (elem)
// флаг need_auto_rep указывает нужно ли запускать построенеи автоматических отчетов или нет
void MDACmdManager::generate (IRoseItemPtr elem, bool need_auto_rep) {
	//#UC START# *48031C7C0377_462D87C6033C*
	if (!save_model_if_need ()) {
		return;
	}

	GenSupport::AutoErrorSuppress auto_suppresser (need_auto_rep);

	RoseElementVector rose_items;

	if (elem) {
		rose_items.push_back (RoseElementWrapper (elem));
	}

	if (rose_items.empty ()) {
		if (AbstractDumperBase::s_model_main_element) {
			const RoseAbstractDumper* main_rad = dynamic_cast<const RoseAbstractDumper*> (
				AbstractDumperBase::s_model_main_element
			);
			if (main_rad) {
				rose_items.push_back (main_rad->rose_element ());
			}
		}
	}

	if (!rose_items.empty ()) {
		GeneratorSelect ts_dlg;
		if (ts_dlg.make_choice(rose_items[0].element)) {
			this->generate_impl (rose_items, need_auto_rep);
		}
	}
	//#UC END# *48031C7C0377_462D87C6033C*
}

// implemented method from Commands::CmdManager
// операция генерации выбранного элемента (elem)  и всех зависимых от него элементов
// флаг need_auto_rep указывает нужно ли запускать построенеи автоматических отчетов или нет
void MDACmdManager::generate_with_consumers (IRoseItemPtr elem, bool need_auto_rep) {
	//#UC START# *4ACC677F0296_462D87C6033C*
	class local {
	public:
		static bool should_visit (
			const RoseAbstractDumper* rad
			, RoseAbstractDumper::UnorderedRADSet& visited
		) {
			bool res = false;
			if (rad && visited.find (rad) == visited.end ()) {
				res = true;				
			}

			return res;
		}

		static void collect_consumers (
			const RoseAbstractDumper* rad
			, RoseAbstractDumper::RADVector& consumers
			, RoseAbstractDumper::UnorderedRADSet& visited
		) {
			if (should_visit (rad, visited)) {
				visited.insert (rad);
				ObjectTreeResolver::Consumer_set consumer_infos = rad->get_consumer_infos ();
				for (
					ObjectTreeResolver::Consumer_set::const_iterator it = consumer_infos.begin ()
					; it != consumer_infos.end ()
					; ++it
				) {
					const RoseAbstractDumper* consumer = dynamic_cast<const RoseAbstractDumper*> (it->consumer);
					if (should_visit (consumer, visited)) {
						consumers.push_back (consumer);
						collect_consumers (consumer, consumers, visited);
					}
				}
			}
		}
	};
	
	if (!save_model_if_need ()) {
		return;
	}

	GenSupport::AutoErrorSuppress auto_suppresser (need_auto_rep);

	if (elem) {
		GeneratorSelect ts_dlg;
		if (ts_dlg.make_choice(elem)) {
			if (
				AbstractDumperBase::is_has_error ()				
			) {
				RoseAbstractDumper::reset_model_tree_root ();
			}

			RoseAbstractDumper::get_model_tree_root();

			RoseAbstractDumper::RADVector items;
			RoseAbstractDumper* rad = RoseAbstractDumper::find_in_tree (elem);
			if (rad) {
				items.push_back (rad);
				RoseAbstractDumper::UnorderedRADSet visited;
				local::collect_consumers (rad, items, visited);
			}

			RoseElementVector rose_items;
			for (
				RoseAbstractDumper::RADVector::const_iterator it = items.begin ()
				; it != items.end ()
				; ++it
			) {
				//добавляем элемент в результирующий список только!
				//если он не является ребенком одного из элементов
				//в списке зависимых
				bool should_add = true;
				for (
					RoseAbstractDumper::RADVector::const_iterator it2 = items.begin ()
					; it2 != items.end ()
					; ++it2
				) {
					const RoseAbstractDumper* consumer = *it2;
					const AbstractDumperBase* rad_parent = *it;
					while (rad_parent = rad_parent->parent ()) {
						if (rad_parent == consumer) {
							should_add = false;
							break;
						}
					}
				}

				if (should_add) {
					rose_items.push_back ((*it)->rose_element ());
				}
			}

			this->generate_impl (rose_items, need_auto_rep);
		}
	}
	//#UC END# *4ACC677F0296_462D87C6033C*
}

// implemented method from Commands::CmdManager
// операция "залочки" выбранного пакета
void MDACmdManager::lock (IRoseCategoryPtr cat) {
	//#UC START# *48031C7E0215_462D87C6033C*
	GDS_ASSERT(cat);
	MDPSupport::CatLocker_var cl = MDPSupport::CatLockerFactory::make (cat);
	cl->modify ();	
	//#UC END# *48031C7E0215_462D87C6033C*
}

// implemented method from Commands::CmdManager
// Пытается захватить все пакеты из переданной коллекции.
void MDACmdManager::lock (IRoseCategoryCollectionPtr cats) {
	//#UC START# *497DB2070183_462D87C6033C*
	short count = cats->Count;
	for (short i = 1; i <= count; ++i) {
		MDPSupport::CatLockerFacade_var clf_child = MDPSupport::CatLockerFacadeFactory::make (cats->GetAt (i));
		if (clf_child->can_lock ()) {
			MDPSupport::CatLocker_var cl = MDPSupport::CatLockerFactory::make (cats->GetAt (i));
			cl->modify ();
		}
	}
	//#UC END# *497DB2070183_462D87C6033C*
}

// implemented method from Commands::CmdManager
// операция создания нового атрибута для класса
IRoseAttributePtr MDACmdManager::new_attribute (IRoseClassPtr parent) {
	//#UC START# *48031C8001E0_462D87C6033C*
	GDS_ASSERT (parent);
	return (IRoseAttributePtr)this->new_element (parent, "Attribute");
	//#UC END# *48031C8001E0_462D87C6033C*
}

// implemented method from Commands::CmdManager
// операция создания нового ключа для связи (parent)
IRoseAttributePtr MDACmdManager::new_attribute_key (IRoseRolePtr parent) {
	//#UC START# *48031C8201F4_462D87C6033C*
	GDS_ASSERT (parent);
	
	MDPSupport::CatLockerFacade_var clf = 
		MDPSupport::CatLockerFacadeFactory::make ((IRoseElementPtr)parent);
	if (false == clf->try_change ()) {
		GenSupport::LogManagerFactory::get ().log_warning ("Can't create new attr key, because lock failed");
		return 0;
	}

	IRoseAttributePtr key = parent->AddKey("NewKey", "?");
	RoseHelper::set_link_type(key, "agr");
	if (this->properties (key, true, true) != RoseHelper::ER_EDIT_OK) {
		parent->DeleteKey (key);
		key = 0;
	} else {
		RoseTreeState::instance ()->set_changed (true);
		clf->do_change ();
		if (m_model_explorer) {
			IRoseApplicationPtr app = parent->Application;
			IRoseElementPtr elem = key;
			m_model_explorer->OnNewModelElement (app, elem);
		}
	}
	return key;
	//#UC END# *48031C8201F4_462D87C6033C*
}

// implemented method from Commands::CmdManager
// операция создания нового класса, вложенного в parent, где parent - класс или пакет
IRoseClassPtr MDACmdManager::new_class (IRoseItemPtr parent) {
	//#UC START# *48031C8303CD_462D87C6033C*
	GDS_ASSERT (parent);
	return (IRoseClassPtr)this->new_element (parent, "Class");
	//#UC END# *48031C8303CD_462D87C6033C*
}

// implemented method from Commands::CmdManager
// операция создания новой диаграммы классов, имя диаграммы предлагается ввести пользователю.
// 
// \parent - элемент для которого создаётся диаграмма, может быть классом, либо папкой
IRoseClassDiagramPtr MDACmdManager::new_class_diagram (IRoseItemPtr parent) {
	//#UC START# *48031C8501AC_462D87C6033C*
	GDS_ASSERT (parent);
		
	EnterStringDialog dlg;
	dlg.set_entered_string ("Main");
	if (dlg.DoModal () != IDOK) {
		return 0;
	}	
	return (IRoseClassDiagramPtr)this->new_class_diagram (parent, dlg.get_entered_string ());
	//#UC END# *48031C8501AC_462D87C6033C*
}

// implemented method from Commands::CmdManager
// операция создания новой диаграммы классов.
// 
// \parent - элемент для которого создаётся диаграмма, может быть классом, либо папкой
// 
// \name - имя диаграммы
IRoseClassDiagramPtr MDACmdManager::new_class_diagram (IRoseItemPtr parent, const std::string& name) {
	//#UC START# *48031C870123_462D87C6033C*
	IRoseCategoryPtr cat = RoseHelper::get_nearest_category (parent);
	//IRoseCategoryPtr unit = RoseHelper::get_nearest_controllable_unit (parent);
	MDPSupport::CatLockerFacade_var clf = 
		MDPSupport::CatLockerFacadeFactory::make (cat);
	if (false == clf->try_change ()) {
		GenSupport::LogManagerFactory::get ().log_warning ("Can't create new class diagram, because lock failed");
		return 0;
	}	

	IRoseClassDiagramPtr diag = cat->AddClassDiagram (name.c_str ());
	RoseTreeState::instance ()->set_changed (true);

	if (parent->IsClass (CLASS_TYPE)) {
		RoseHelper::override_property (
			diag
			, TOOL_NAME
			, RoseHelper::CLASS_DIAG_LINK_PROPERTY
			, get_rose_element_uid(parent).c_str ()
		);
	}

	if (m_model_explorer) {
		IRoseApplicationPtr app = diag->Application;
		IRoseElementPtr elem = diag;
		m_model_explorer->OnNewModelElement (app, elem);
	}
	diag->Activate ();
	clf->do_change ();
	return diag;
	//#UC END# *48031C870123_462D87C6033C*
}

// implemented method from Commands::CmdManager
// операция создания нового элемента, element_type  - тип элемента ("Class", "Category",
// "Attribute", "Operation")
IRoseElementPtr MDACmdManager::new_element (IRoseItemPtr parent, const std::string& element_type) {
	//#UC START# *48031C8A0014_462D87C6033C*
	try {
		RoseHelper::reset_template ();
		if (!RoseHelper::load_template ()) {
			return 0;
		}

		CPoint point;
		GetCursorPos (&point);
		IRoseClassDiagramPtr diag = (IRoseClassDiagramPtr)parent->Model->GetActiveDiagram();
		IRoseItemPtr new_item;
		
		bool need_colorize = true;
		
		MDPSupport::CatLockerFacade_var clf = 
			MDPSupport::CatLockerFacadeFactory::make ((IRoseElementPtr)parent);
		if (false == clf->try_change ()) {
			GenSupport::LogManagerFactory::get ().log_warning ("Can't create new element, because lock failed");
			return 0;
		}

		new_item = create_new_element (parent, element_type);
		if (new_item == 0) {
			return 0;
		}
		if (new_item->IsClass (CLASS_TYPE) || new_item->IsClass (CATEGORY_TYPE)) {		
			RoseHelper::position_in_diagram (
				diag
				, new_item
				, point.x
				, point.y
			);
		}
		
		if (this->properties (new_item, true, false) != RoseHelper::ER_EDIT_OK) {
			RoseHelper::delete_item(new_item);
			new_item = 0;
		} else {
			RoseTreeState::instance ()->set_changed (true);
			clf->do_change ();
			if (m_model_explorer) {
				IRoseApplicationPtr app = parent->Application;
				IRoseElementPtr elem = new_item;
				m_model_explorer->OnNewModelElement (app, elem);
			}
		}

		return new_item;
	} catch (Base::FatalError&) {
		GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
		dlg.DoModal ();
	}

	return 0;
	//#UC END# *48031C8A0014_462D87C6033C*
}

// implemented method from Commands::CmdManager
// операция создания новой операции для класса
IRoseOperationPtr MDACmdManager::new_operation (IRoseClassPtr parent) {
	//#UC START# *48031C8B03BB_462D87C6033C*
	GDS_ASSERT (parent);
	return (IRoseOperationPtr)this->new_element (parent, "Operation");
	//#UC END# *48031C8B03BB_462D87C6033C*
}

// implemented method from Commands::CmdManager
// операция создания нового пакета
IRoseCategoryPtr MDACmdManager::new_package (IRoseCategoryPtr parent) {
	//#UC START# *48031C8E00A1_462D87C6033C*
	GDS_ASSERT (parent);
	return (IRoseCategoryPtr)this->new_element (parent, "Category");
	//#UC END# *48031C8E00A1_462D87C6033C*
}

// implemented method from Commands::CmdManager
// создание сиквенс диграммы, parent - класс со стереотипом "UseCase"
IRoseScenarioDiagramPtr MDACmdManager::new_sequence_diagram (IRoseClassPtr parent) {
	//#UC START# *48031C8F0277_462D87C6033C*
	GDS_ASSERT (parent);
	if (parent->Stereotype == _bstr_t ("UseCase")) {
		EnterStringDialog dlg;
		dlg.set_entered_string ((const char*)parent->Name);
		if (dlg.DoModal () != IDOK) {
			return 0;
		}

		IRoseCategoryPtr cat = RoseHelper::get_parent_category (parent);
		if (cat) {
			MDPSupport::CatLockerFacade_var clf = 
				MDPSupport::CatLockerFacadeFactory::make (cat);
			if (false == clf->try_change ()) {
				GenSupport::LogManagerFactory::get ().log_warning ("Can't create new sequence diagram, because lock failed");
				return 0;
			}			
			IRoseScenarioDiagramPtr diag = cat->AddScenarioDiagram (dlg.get_entered_string ().c_str (), 1);
			
			RoseHelper::override_property(diag, TOOL_NAME, "UseCase", get_rose_element_uid(parent).c_str ());
			if (m_model_explorer) {
				IRoseApplicationPtr app = diag->Application;
				IRoseElementPtr elem = diag;
				m_model_explorer->OnNewModelElement (app, elem);
			}
			
			diag->Activate ();
			clf->do_change ();
			return diag;
		}
		return 0;
	} else {
		MessageBox (AfxGetMainWnd ()->GetSafeHwnd (), "Сиквенс диаграмму можно создавать только в usecase", "Ошибка", MB_OK);
	}
	return 0;
	//#UC END# *48031C8F0277_462D87C6033C*
}

// implemented method from Commands::CmdManager
// Добавляет диаграмму состояний к элементу (parent)m в качестве результата возвращает собственно
// диаграмму. Имя диаграммы предлагается ввести пользователю в специальном диалоге.
IRoseStateDiagramPtr MDACmdManager::new_state_diagram (IRoseItemPtr parent) {
	//#UC START# *48031C91017F_462D87C6033C*
	GDS_ASSERT (parent);
		
	EnterStringDialog dlg;
	dlg.set_entered_string ("State diagram");
	if (dlg.DoModal () != IDOK) {
		return 0;
	}	
	return this->new_state_diagram (parent, dlg.get_entered_string ());
	//#UC END# *48031C91017F_462D87C6033C*
}

// implemented method from Commands::CmdManager
// Добавляет диаграмму состояний с именем <name> к элементу (parent)m в качестве результата
// возвращает собственно диаграмму
IRoseStateDiagramPtr MDACmdManager::new_state_diagram (IRoseItemPtr parent, const std::string& name) {
	//#UC START# *48031C9400AC_462D87C6033C*
	IRoseStateDiagramPtr diag;

	IRoseStateMachineOwnerPtr owner = parent->StateMachineOwner;
	
	if (owner) {
		MDPSupport::CatLockerFacade_var clf = 
			MDPSupport::CatLockerFacadeFactory::make ((IRoseElementPtr)parent);
		if (false == clf->try_change ()) {
			GenSupport::LogManagerFactory::get ().log_warning ("Can't create new state diagram, because lock failed");
			return 0;
		}		
				
		IRoseStateMachineCollectionPtr machines = owner->StateMachines;
		IRoseStateMachinePtr machine;
		if (machines->Count > 0) {
			machine = machines->GetAt (1);
		} else {
			machine = owner->CreateStateMachine ("StateModel");
			RoseTreeState::instance ()->set_changed (true);
		}		
		if (machine) {
			diag = machine->AddStateChartDiagram (name.c_str ());
			RoseTreeState::instance ()->set_changed (true);
			if (m_model_explorer) {
				IRoseApplicationPtr app = diag->Application;
				IRoseElementPtr elem = diag;
				m_model_explorer->OnNewModelElement (app, elem);
			}
			diag->Activate ();
		}

		clf->do_change ();
	}
	return diag;
	//#UC END# *48031C9400AC_462D87C6033C*
}

// implemented method from Commands::CmdManager
// команда вызова дилога свойств элемента
// \is_new - флаг определяет является ли elem новым, если да, то поля диалога заполняются
// значениями по умолчанию
// \need_reload_template - флаг определяет нужно ли перечитывать шаблон перед показом свойств
RoseHelper::ExecResult MDACmdManager::properties (IRoseItemPtr elem, bool is_new, bool need_reload_template) {
	//#UC START# *48031C950385_462D87C6033C*
	RoseHelper::ExecResult is_ok = RoseHelper::ER_CANCEL;
	try {
		if (need_reload_template) {
			RoseHelper::reset_template ();
			RoseHelper::load_template ();
		}
	} catch (Base::FatalError&) {
		GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors (), true);
		if (dlg.DoModal () == IDOK) {
			return RoseHelper::ER_CANCEL;
		}
	}
	
	ItemPropertySheet::edit_prop (elem, is_ok, false, is_new);

	return is_ok;
	//#UC END# *48031C950385_462D87C6033C*
}

// implemented method from Commands::CmdManager
// метод перемещает в модели Розы элемент в нового родителя (new_parent), при необходимости лочит
// пакеты
// возвращает true в случае успеха
// 
// is_new - флаг сигнализирует о том, был ли в результате перемещения создан новый объект (например
// нельзя перемещать операции, атрибуты)
bool MDACmdManager::relocate (IRoseElementPtr item, IRoseElementPtr new_parent, bool& is_new) {
	//#UC START# *48031C980087_462D87C6033C*
	typedef std::map<std::string, MDPSupport::CatLockerFacade_var > CatLockerFacadeMap;

	class LockHelper {
	public:
		static bool try_change (CatLockerFacadeMap& to_lock) {
			for (
				CatLockerFacadeMap::iterator it = to_lock.begin ()
				; it != to_lock.end ()
				; ++it
			) {
				if (it->second->try_change () == false) {					
					return false;
				}
			}
			return true;
		}

		static void do_change (CatLockerFacadeMap& to_lock) {
			for (
				CatLockerFacadeMap::iterator it = to_lock.begin ()
				; it != to_lock.end ()
				; ++it
			) {
				it->second->do_change ();
			}
		}
	};
	try {
		is_new = false;
		if (item->IsClass (CLASS_DEPENDENCY_TYPE)) {
			return false;
		}
		
		CatLockerFacadeMap standart_items_to_lock;		

		standart_items_to_lock.insert (
			std::make_pair (
				get_rose_element_uid(item)
				, MDPSupport::CatLockerFacadeFactory::make ((IRoseElementPtr)item)
			)
		);
		standart_items_to_lock.insert (
			std::make_pair (
				get_rose_element_uid(new_parent)
				, MDPSupport::CatLockerFacadeFactory::make ((IRoseElementPtr)new_parent)
			)
		);
		
		if (item->IsClass (CATEGORY_TYPE)) {
			IRoseCategoryPtr item_cat_parent = ((IRoseCategoryPtr)item)->ParentCategory;
			if (item_cat_parent) {
				standart_items_to_lock.insert (
					std::make_pair (
						get_rose_element_uid(item_cat_parent)
						, MDPSupport::CatLockerFacadeFactory::make (item_cat_parent)
					)
				);
			}
		}
		
		if (item->IsClass (CLASS_TYPE)) {
			IRoseClassPtr cls = item;
			IRoseRoleCollectionPtr rl_attrs = cls->GetAssociateRoles();
			int rl_attrs_count = rl_attrs->Count;
			for (short i = 1; i <= rl_attrs_count; i++) {
				IRoseRolePtr rl_attr = rl_attrs->GetAt(i);
				if (RoseHelper::is_attribute_role (rl_attr)) {
					IRoseCategoryPtr assoc_cat = rl_attr->Association->ParentCategory;
					standart_items_to_lock.insert (
						std::make_pair (
							get_rose_element_uid(assoc_cat)
							, MDPSupport::CatLockerFacadeFactory::make (assoc_cat)
						)
					);
				}
			}
		}
		if (!LockHelper::try_change (standart_items_to_lock)) {
			GenSupport::LogManagerFactory::get ().log_warning ("Can't relocate item, because lock failed");
			return false;
		}
		bool res = false;
		bool need_standart_relocate = true;
		if (
			(
				item->IsClass (ATTRIBUTE_TYPE)
				|| item->IsClass (OPERATION_TYPE)
			) && (
				new_parent->IsClass (CLASS_TYPE)
				&& RoseHelper::is_it_implementable (item)
			)
		) {
			//атрибут или операция, которые могут быть переопределены в наследниках
			//при перемещении нужно у наследников поменять гуид...
			CatLockerFacadeMap need_to_locked;
			unsigned long cant_lock_size = 0;

			IRoseClassPtr source_cls = RoseHelper::get_context (item);
			IRoseClassCollectionPtr all_derived = RoseHelper::get_all_derived (source_cls);
			
			//std::string src_guid (get_rose_element_uid(item));
			std::string src_parent_guid (get_rose_element_uid(source_cls));

			short count = all_derived->Count;
			_bstr_t tool_name = TOOL_NAME;
			for (short i = 1; i <= count; ++i) {
				IRoseClassPtr subcls = all_derived->GetAt (i);
				bool need_override_guid = false;
				IRosePropertyCollectionPtr subcls_props = subcls->GetAllProperties ();
				short count_props = subcls_props->Count;
				
				//ещем среди свойств производного класса упоминание о ГУИД'ах
				//перемещаемого элемента и его родителя
				//и принимаем решение нужно ли переписывать их, если нужно - 
				//добавляем пакет, в котором находится производный класс в список
				//залочек
				for (short j = 1; j <= count_props; ++j) {
					IRosePropertyPtr prop = subcls_props->GetAt (j);
					if (prop->GetToolName () == tool_name) {
						std::string prop_name = prop->GetName ();
						std::string prop_value = prop->GetValue ();
						
						if (prop_name.find (src_parent_guid) != std::string::npos) {
							need_override_guid = true;
							break;
						}
					}
				}
				IRoseCategoryPtr cat = RoseHelper::get_nearest_controllable_unit (subcls);
				if (cat && need_override_guid) {
					std::string cat_uid (get_rose_element_uid(cat));
					if (need_to_locked.find (cat_uid) == need_to_locked.end ()) {				
						if (!cat->IsModifiable ()) {
							MDPSupport::CatLockerFacade_var locker = 
								MDPSupport::CatLockerFacadeFactory::make (cat);
							if (locker->can_change ()) {
								need_to_locked.insert (
									CatLockerFacadeMap::value_type (cat_uid, locker)
								);
								//need_to_locked[cat_uid] = locker;
							} else {
								cant_lock_size++;
							}
						}
					}
				}
			}
			if (need_to_locked.empty () == false) {
				std::string mess;
				if (cant_lock_size == 0) {
					mess = "Изменение связанных UC затронет ";
					mess += boost::lexical_cast<std::string> (need_to_locked.size ());
					mess += " незалоченных пакетов\n\r"\
						  "Для того, чтобы залочить пакеты нажмите - Yes\n\r"\
						  "Для того, чтобы не менять пакеты нажмите - No\n\r"\
						  "Для отмены нажмите - Cancel";			
				} else {
					mess = "Изменение связанных UC затронет ";
					mess += boost::lexical_cast<std::string> (need_to_locked.size ());
					mess += " незалоченных пакетов, ";
					mess += boost::lexical_cast<std::string> (cant_lock_size);
					mess += " из которых залочить нельзя\n\r"\
						  "Для того, чтобы залочить пакеты (которые можно) нажмите - Yes\n\r"\
						  "Для того, чтобы не менять пакеты нажмите - No\n\r"\
						  "Для отмены нажмите - Cancel";					
				}
				int res = ::AfxMessageBox (mess.c_str (), MB_YESNOCANCEL | MB_ICONEXCLAMATION | MB_APPLMODAL);
				switch (res) {
					case IDYES: {
						need_standart_relocate = false;
						if (!LockHelper::try_change (need_to_locked)) {
							GenSupport::LogManagerFactory::get ().log_warning ("Can't relocate item, because lock failed");
							return false;
						}
						
						if (RoseHelper::relocate (item, new_parent, is_new)) {
							res = true;
							RoseTreeState::instance ()->set_changed (true);
							
							LockHelper::do_change (need_to_locked);
							LockHelper::do_change (standart_items_to_lock);
						}
						break;
					}
					case IDCANCEL: {
						need_standart_relocate = false;
						break;
					}
				}
			}
		}
		if (need_standart_relocate) {
			if (RoseHelper::relocate (item, new_parent, is_new)) {
				res = true;
				RoseTreeState::instance ()->set_changed (true);
				LockHelper::do_change (standart_items_to_lock);
			}
		}
		return res;
	} catch (std::exception& ex) {
		std::string mess ("При переносе элемента произошло исключение: ");
		mess += ex.what ();
		MessageBox (AfxGetMainWnd ()->GetSafeHwnd (), _T (mess.c_str ()), "Ошибка", MB_OK|MB_ICONEXCLAMATION );
	} catch (CORBA::Exception& ex) {
		std::string mess ("При переносе элемента произошло исключение:\n");
		mess += ex._info ().c_str ();
		MessageBox (AfxGetMainWnd ()->GetSafeHwnd (), _T (mess.c_str ()), "Ошибка", MB_OK|MB_ICONEXCLAMATION );
	} catch (_com_error& ex) {
		std::string mess ("При переносе элемента произошло исключение: _com_error (\n");
		mess += ex.ErrorMessage ();
		mess += ")";
		MessageBox (AfxGetMainWnd ()->GetSafeHwnd (), _T (mess.c_str ()), "Ошибка", MB_OK|MB_ICONEXCLAMATION );
	} catch (...) {
		MessageBox (AfxGetMainWnd ()->GetSafeHwnd (), "При переносе элемента произошло не обработанное исключение", "Ошибка", MB_OK | MB_ICONEXCLAMATION );
		//RoseAbstractDumper::reset_model_tree_root ();
	}

	return false;
	//#UC END# *48031C980087_462D87C6033C*
}

// implemented method from Commands::CmdManager
// удалить элемент из модели (требуется подтверждение пользователя)
void MDACmdManager::remove (IRoseElementPtr elem) {
	//#UC START# *490AEF1D03B1_462D87C6033C*
	if (m_model_explorer) {
		m_model_explorer->remove (elem);		
	}
	//#UC END# *490AEF1D03B1_462D87C6033C*
}

// implemented method from Commands::CmdManager
// откатить изменения
void MDACmdManager::rollback (IRoseCategoryPtr cat) {
	//#UC START# *48031CA6011F_462D87C6033C*
	GDS_ASSERT(cat);
	MDPSupport::CatLocker_var cl = MDPSupport::CatLockerFactory::make (cat);
	cl->rollback ();
	//#UC END# *48031CA6011F_462D87C6033C*
}

// implemented method from Commands::CmdManager
// операция поиска внутри elem
void MDACmdManager::search (IRoseItemPtr elem) const {
	//#UC START# *48031CAE00E0_462D87C6033C*
	try {
		RoseHelper::reset_template ();
		if (RoseHelper::load_template ()) {
			RoseHelper::check_model_for_changes ();
		}
	} catch (Base::FatalError&) {
		GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors (), true);
		if (dlg.DoModal () == IDOK) {
			return;
		}
	}


	if (!elem) {
		IRoseApplicationPtr app = RoseHelper::rose_app ();
		IRoseModelPtr model = app != 0 ? app->CurrentModel : 0;
		elem = model ? model->GetRootCategory () : 0;
	}
	RoseElementVector rose_elems;
	rose_elems.push_back (RoseElementWrapper (elem));

	AdvancedSearch dlg (rose_elems);	
	dlg.DoModal ();
	//#UC END# *48031CAE00E0_462D87C6033C*
}

// implemented method from Commands::CmdManager
// Установить шаблон для модели, template_path - путь к файлу шаблона
void MDACmdManager::set_template (IRoseApplicationPtr app, const std::string& template_path) const {
	//#UC START# *486467FB0209_462D87C6033C*
	try {
		IRoseItemPtr item = app->CurrentModel->GetRootCategory ();
		bool by_parent;
		
		std::string file_name = template_path;
		
		//получаем текущий файл шаблона
		std::string cur_templ = RoseHelper::get_template_file(item, by_parent);	
		std::string template_dir = MDAModelParams::get_templates_dir();
		std::string::size_type pos = file_name.find (template_dir);

		if (pos != std::string::npos) {
			file_name = file_name.substr (pos + template_dir.length ());
		} else {
		}

		if (cur_templ != file_name) {
			//если файл шаблона другой
			std::ifstream templ_file (RoseHelper::make_template_file (file_name).c_str (), std::ios::in);
			if (templ_file.is_open ()) {
				templ_file.close ();
				RoseHelper::set_template_file(item, file_name);
				RoseHelper::reset_template ();

				if (RoseHelper::load_template () == true) {
					MessageBox (AfxGetMainWnd ()->GetSafeHwnd (), "Template changed", "OK", MB_OK);
				}
			} else {
				MessageBox (AfxGetMainWnd ()->GetSafeHwnd (), "Can't open template file", "ERROR", MB_OK);
			}
		}
	} catch (Base::FatalError&) {
		GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors ());
		dlg.DoModal ();
	}
	//#UC END# *486467FB0209_462D87C6033C*
}

// implemented method from Commands::CmdManager
// операция показа списка залоченных пакетов
void MDACmdManager::show_locked () const {
	//#UC START# *48031CAF030A_462D87C6033C*
	ChangedPackageInfo::instance ()->show ();
	//#UC END# *48031CAF030A_462D87C6033C*
}

// implemented method from Commands::CmdManager
// операция обратная выливке в отдельный кат - "засасывает" кат в файл модели (mdl) или cat родителя
void MDACmdManager::uncontrol (IRoseCategoryPtr cat) {
	//#UC START# *48031CA80039_462D87C6033C*
	if (cat->IsControlled ()) {
		IRoseCategoryPtr parent = RoseHelper::get_nearest_controllable_unit (cat->GetParentCategory ());
		MDPSupport::CatLockerFacade_var clf = 
			MDPSupport::CatLockerFacadeFactory::make (parent);
		if (false == clf->try_change ()) {
			GenSupport::LogManagerFactory::get ().log_warning ("Can't uncontrol, because lock failed");
			return;
		}
		MDPSupport::CatLockerFacade_var cat_clf = 
			MDPSupport::CatLockerFacadeFactory::make (cat);
		if (false == cat_clf->can_change ()) {
			GenSupport::LogManagerFactory::get ().log_warning ("Can't uncontrol, because lock failed");
			return;
		}
		cat->Uncontrol ();
		clf->do_change ();
	}
	//#UC END# *48031CA80039_462D87C6033C*
}

// implemented method from Commands::CmdManager
// операция uncontrol применяется к cat и всем его подпапкам рекурсивно
void MDACmdManager::uncontrol_all (IRoseCategoryPtr cat) {
	//#UC START# *48031CA90345_462D87C6033C*
	uncontrol (cat);	
	IRoseCategoryCollectionPtr cats = cat->GetAllCategories ();
	short cats_count = cats->Count;
	for (short i = 1; i <= cats_count; ++i) {
		IRoseCategoryPtr sub_cat = cats->GetAt (i);
		uncontrol (sub_cat);
	}
	//#UC END# *48031CA90345_462D87C6033C*
}

// implemented method from Commands::CmdManager
// операция "отлочки" выбранного пакета
void MDACmdManager::unlock (IRoseCategoryPtr cat) {
	//#UC START# *48031CAB0155_462D87C6033C*
	GDS_ASSERT(cat);
	MDPSupport::CatLocker_var cl = MDPSupport::CatLockerFactory::make (cat);
	cl->commit ();
	//#UC END# *48031CAB0155_462D87C6033C*
}

// implemented method from Commands::CmdManager
// пытаеться разлочить все пакеты из переданной коллекции
void MDACmdManager::unlock (IRoseCategoryCollectionPtr cats) {
	//#UC START# *497DB38602D3_462D87C6033C*
	short count = cats->Count;
	for (short i = 1; i <= count; ++i) {
		MDPSupport::CatLockerFacade_var clf_child = MDPSupport::CatLockerFacadeFactory::make (cats->GetAt (i));
		if (clf_child->can_commit ()) {
			MDPSupport::CatLocker_var cl = MDPSupport::CatLockerFactory::make (cats->GetAt (i));
			cl->commit ();
		}
	}
	//#UC END# *497DB38602D3_462D87C6033C*
}

// implemented method from Commands::CmdManager
// открывает браузер и в нем показывает соответствующую элементу страницу в К
void MDACmdManager::view_elem_in_confluence (IRoseItemPtr elem) const {
	//#UC START# *48031CB103AC_462D87C6033C*
	Helpers::KViewElementFactory::get ().view (elem);
	//#UC END# *48031CB103AC_462D87C6033C*
}

// implemented method from Commands::CmdManager
// операция построения отчета
void MDACmdManager::view_reports (IRoseItemPtr elem) const {
	//#UC START# *48031CB40105_462D87C6033C*
	try {
		RoseHelper::reset_template ();
		if (RoseHelper::load_template ()) {
			RoseHelper::check_model_for_changes ();
		}
	} catch (Base::FatalError&) {
		GenerationErrorDialog dlg (GenSupport::ErrorManagerFactory::get ().get_errors (), true);
		if (dlg.DoModal () == IDOK) {
			return;
		}
	}
	
	if (!elem) {
		IRoseApplicationPtr app = RoseHelper::rose_app ();
		IRoseModelPtr model = app != 0 ? app->CurrentModel : 0;
		elem = model ? model->GetRootCategory () : 0;
	}
	RoseElementVector rose_elems;
	rose_elems.push_back (RoseElementWrapper (elem));

	ReportView dlg (rose_elems);
	dlg.DoModal ();
	//#UC END# *48031CB40105_462D87C6033C*
}
} // namespace MDACommands

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

