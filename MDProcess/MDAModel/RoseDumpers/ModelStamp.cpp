////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/ModelStamp.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::ModelStamp
//
// штамп модели Розы, посзволяет определять изменялась ли модель с момента посленего построения
// штампа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/ModelStamp.h"
// by <<uses>> dependencies
#include <sstream>
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ModelStamp::~ModelStamp () {
	//#UC START# *46CE566700EA_DESTR_BODY*
	//#UC END# *46CE566700EA_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// расчет штампа
void ModelStamp::build_stamp () {
	//#UC START# *46CE56FA01A5*
	class local {
	public:
		
		static void fill_stamp (const IRoseClassDiagramPtr& diag, std::ostream& stamp) {
			stamp << get_rose_element_uid(diag);
			stamp << diag->ItemViews->Count > 0 ? "not empty" : "empty";
		}
		
		//собираем информацию о сиквенс-диаграме
		static void fill_stamp (IRoseScenarioDiagramPtr scen_diag, std::ostream& stamp) {
			stamp << get_rose_element_uid(scen_diag);
			IRoseInstanceViewCollectionPtr items = scen_diag->GetInstanceViews();
				
			short count = items->Count;
			for (short j = 1; j <= count; ++j) {
				IRoseObjectInstancePtr oi = items->GetAt(j)->GetInstance ();
				if (oi) {
					IRoseClassPtr cls = oi->GetClass();
					if (cls != 0) {
						std::string name = cls->Name;
						stamp << get_rose_element_uid(cls);
					}
				}
			}
			
			IRoseMessageCollectionPtr messages = scen_diag->GetMessages ();
			count = messages->Count;
			for (short j = 1; j <= count; ++j) {
				IRoseMessagePtr mess = messages->GetAt (j);
				IRoseObjectInstancePtr sender = mess->GetSenderObject ();
				if (sender) {
					stamp << get_rose_element_uid(sender);					
				}				
				stamp << "->";
				IRoseObjectInstancePtr reciver = mess->GetReceiverObject ();
				if (reciver) {
					stamp << get_rose_element_uid(reciver);					
				}
			}
		}

		//собираем информацию о диаграме состояний
		static void fill_stamp (const IRoseStateMachineOwnerPtr& state_machine_owner, std::ostream& stamp) {
			IRoseStateMachineCollectionPtr st_machines = state_machine_owner->GetStateMachines ();
			short st_machines_count = st_machines->Count;
			for (short i = 1; i <= st_machines_count; ++i) {
				IRoseStateMachinePtr st_machine = st_machines->GetAt (i);
				IRoseStateDiagramCollectionPtr state_diags = st_machine->GetAllDiagrams ();
				short state_diags_count = state_diags->Count;
				for (short j = 1; j <= state_diags_count; ++j) {
					stamp << get_rose_element_uid(state_diags->GetAt (j));
				}
				
				IRoseStateCollectionPtr states = st_machine->GetAllStates ();
				short states_count = states->Count;
				for (short j = 1; j <= states_count; ++j) {
					IRoseStatePtr state = states->GetAt (j);
					fill_stamp (state, stamp);
				}

				IRoseTransitionCollectionPtr transitions = st_machine->GetAllTransitions ();
				short transitions_count = transitions->Count;
				for (short j = 1; j <= transitions_count; ++j) {
					IRoseTransitionPtr transition = transitions->GetAt (j);
					stamp << get_rose_element_uid(transition);
					IRoseEventPtr trigger_event = transition->GetTriggerEvent ();
					if (trigger_event && (trigger_event->Name != _bstr_t ("") || trigger_event->GuardCondition != _bstr_t (""))) {
						stamp << get_rose_element_uid(trigger_event);
					}
					
					IRoseActionPtr send_action = transition->GetSendAction ();
					if (send_action && send_action->Name != _bstr_t ("")) {
						stamp << get_rose_element_uid(send_action);
					}

					IRoseActionPtr trigger_action = transition->GetTriggerAction ();
					if (trigger_action && trigger_action->Name != _bstr_t ("")) {
						stamp << get_rose_element_uid(trigger_action);			
					}
				}
			}
		}

		static void fill_stamp (const IRoseStatePtr& state, std::ostream& stamp) {
			stamp << get_rose_element_uid(state);
			
			IRoseEventCollectionPtr events = state->GetUserDefinedEvents ();
			short events_count = events->Count;

			IRoseActionCollectionPtr actions = state->GetActions ();			
			short action_count = actions->Count;
			for (short i = 1; i <= action_count; ++i) {
				IRoseActionPtr action = actions->GetAt (i);
				stamp << get_rose_element_uid(action);
				for (short j = 1; j <= events_count; ++j) {
					IRoseEventPtr user_event = events->GetAt (j);
					if (user_event && user_event->Name != _bstr_t ("")) {
						IRoseActionPtr event_action = user_event->GetAction ();
						if (
							event_action
							&& get_rose_element_uid(event_action) == get_rose_element_uid(action)
						) {
							stamp << get_rose_element_uid(user_event);
							break;
						}
					}				
				}
			}			
		}
		
		//собираем информацию о атрибуте
		static void fill_stamp (const IRoseAttributePtr& attr, std::ostream& stamp) {
			IRoseItemPtr s = attr->GetTypeClass ();
			if (s != 0) {
				stamp << get_rose_element_uid(s);
			} else {
				stamp << (const char*)attr->GetType ();
			}
			stamp << attr->InitValue;
		}
		
		//собираем информацию о параметре
		static void fill_stamp (const IRoseParameterPtr& param, std::ostream& stamp) {
			stamp << get_rose_element_uid(param);
			stamp << param->InitValue;
			IRoseClassPtr linked_cls = param->GetTypeClass();
			if (linked_cls != 0) {
				stamp << get_rose_element_uid(linked_cls);
			} else {
				stamp << static_cast<const char*> (param->Type);
			}
		}

		//собираем информацию о операции
		static void fill_stamp (const IRoseOperationPtr& operation, std::ostream& stamp) {
			IRoseClassPtr s = operation->GetResultClass ();
			if (s != 0) {
				stamp << get_rose_element_uid(s);
			} else {
				stamp << (const char*)operation->GetReturnType ();
			}
			IRoseParameterCollectionPtr params = operation->Parameters;
			short params_count = params->Count;
			for (short j = 1; j <= params_count; j++) {
				local::fill_stamp (params->GetAt(j), stamp);
			}
		}

		//собираем информацию о классе
		static void fill_stamp (const IRoseClassPtr& cls, std::ostream& stamp) {
			IRoseClassCollectionPtr clss = cls->GetNestedClasses ();
			short clss_count = clss->Count;
			for (short i = 1; i <= clss_count; i++) {
				fill_stamp (clss->GetAt(i), stamp);
			}
			
			IRoseAttributeCollectionPtr atrs = cls->GetAttributes ();
		
			short atrs_count = atrs->Count;
			for (short i = 1; i <= atrs_count; i++) {
				local::fill_stamp (atrs->GetAt(i), stamp);
			}

			IRoseOperationCollectionPtr ops = cls->GetOperations ();
			short ops_count = ops->Count;
			for (short i = 1; i <= ops_count; i++) {
				local::fill_stamp (ops->GetAt(i), stamp);				
			}

			IRoseRoleCollectionPtr rls = cls->GetRoles ();
			short rls_count = rls->Count;
			for (short i = 1; i <= rls_count; i++) {
				IRoseRolePtr role = rls->GetAt(i);

				IRoseAttributeCollectionPtr atrs = role->GetKeys ();
				short attrs_count = atrs->Count;
				for (short j = 1; j <= attrs_count; j++) {
					local::fill_stamp (atrs->GetAt(j), stamp);
				}
			}

			IRoseStateMachineOwnerPtr state_machine_owner = cls->GetStateMachineOwner ();
			if (state_machine_owner) {
				fill_stamp (state_machine_owner, stamp);
			}
		}

		//собираем информацию о папке
		static void fill_stamp (const IRoseCategoryPtr& cat, std::ostream& stamp) {
			stamp << get_rose_element_uid(cat);
			stamp << cat->Stereotype;

			IRoseCategoryCollectionPtr cats = cat->GetCategories ();

			short cats_count = cats->Count;
			for (short i = 1; i <= cats_count; i++) {
				fill_stamp (cats->GetAt(i), stamp);
			}
			
			IRoseClassCollectionPtr clss = cat->GetClasses ();
			short clss_count = clss->Count;
			for (short i = 1; i <= clss_count; i++) {
				fill_stamp (clss->GetAt(i), stamp);
			}

			IRoseCategoryDependencyCollectionPtr dps = cat->GetCategoryDependencies ();
			short dps_count = dps->Count;
			for (short i = 1; i <= dps_count; i++) {
				fill_stamp (dps->GetAt(i), stamp);				
			}

			IRoseScenarioDiagramCollectionPtr scenario_diags = cat->ScenarioDiagrams;
			short scenario_diags_count = scenario_diags->Count;
			for (short i = 1; i <= scenario_diags_count; ++i) {
				fill_stamp (scenario_diags->GetAt (i), stamp);				
			}

			IRoseStateMachineOwnerPtr state_machine_owner = cat->GetStateMachineOwner ();
			if (state_machine_owner) {
				
			}

			IRoseClassDiagramCollectionPtr class_diags = cat->ClassDiagrams;
			short class_diags_count = class_diags->Count;
			for (short i = 1; i <= class_diags_count; ++i) {
				fill_stamp (class_diags->GetAt (i), stamp);				
			}
		}

		//собираем информацию о связи между папками
		static void fill_stamp (const IRoseCategoryDependencyPtr& dep, std::ostream& stamp) {
			IRoseItemPtr s = dep->GetSupplier();
			if (s != 0) {
				stamp << get_rose_element_uid(s);
			}
		}
	};	
	IRoseModelPtr model = RoseHelper::rose_app ()->CurrentModel;
	IRoseCategoryPtr root_cat = model->RootCategory;
	std::ostringstream stamp;
	local::fill_stamp (root_cat, stamp);

	m_current_stamp = stamp.str ();
	//#UC END# *46CE56FA01A5*
}

// пересчитывает текщий штамп и сравнивает его с предыдущим, в случае их совпадаения возвращает
// true, иначе - false
bool ModelStamp::is_stamp_changed () {
	//#UC START# *46CE572F034B*
	m_previous_stamp = m_current_stamp;
	this->build_stamp ();
	bool res = m_current_stamp != m_previous_stamp;
	return res;
	//#UC END# *46CE572F034B*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

