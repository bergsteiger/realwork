////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseStateDumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseStateDumper
//
// дампер состояний
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseStateDumper.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseEventDumper.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *465E55270157_CUSTOM_INCLUDES*
//#UC END# *465E55270157_CUSTOM_INCLUDES*


//#UC START# *465E55270157*
//#UC END# *465E55270157*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// init ctor
RoseStateDumper::RoseStateDumper (const RoseAbstractDumper* parent, IRoseStatePtr state)
//#UC START# *465E55B1009C_BASE_INIT*
: RoseAbstractDumper (parent, state, AbstractDumperBase::EMPTY_STEREOTYPE_ID)
//#UC END# *465E55B1009C_BASE_INIT*
{
	//#UC START# *465E55B1009C_BODY*
	try {
		IRoseTransitionCollectionPtr transitions = state->GetTransitions ();
		short transitions_count = transitions->Count;
		for (short i = 1; i <= transitions_count; ++i) {
			IRoseTransitionPtr transition = transitions->GetAt (i);
			RoseAbstractDumper::dump_factory()->create_by_stereotype (this, transition);
			//RoseAbstractDumper* new_transition = new RoseTransitionDumper (*this, transition);
		}
		
		IRoseStateMachineCollectionPtr st_machines = state->GetStateMachines ();
		short st_machines_count = st_machines->Count;
		for (short i = 1; i <= st_machines_count; ++i) {
			RoseAbstractDumper::dump_factory()->create_by_stereotype (this, st_machines->GetAt (i));
		}	
		
		IRoseEventCollectionPtr events = state->GetUserDefinedEvents ();

		IRoseActionCollectionPtr actions = state->GetActions ();
		short events_count = events->Count;
		short action_count = actions->Count;
		for (short i = 1; i <= action_count; ++i) {
			IRoseActionPtr action = actions->GetAt (i);
			if (action->Name != _bstr_t ("")) {
				//если имя не пустое - добавялем в дереве, иначе нет смысла
				RoseAbstractDumper* rad_action = RoseAbstractDumper::dump_factory()->create_by_stereotype (this, action);
				if (rad_action) {			
					for (short j = 1; j <= events_count; ++j) {
						IRoseEventPtr user_event = events->GetAt (j);
						if (user_event && user_event->Name != _bstr_t ("")) {
							IRoseActionPtr event_action = user_event->GetAction ();
							if (
								event_action
								&& get_rose_element_uid(event_action) == get_rose_element_uid(action)
							) {
								RoseEventDumper* red = new RoseEventDumper (rad_action, user_event);
								//RoseAbstractDumper::dump_factory()->create_by_stereotype (*rad_action, user_event);
								break;
							}
						}				
					}
				}
			}
		}		
	} catch (std::exception& ex) {
		std::string str = "Exception in RoseStateDumper ctor: ";
		str += ex.what ();
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error (str.data());
	} catch (...) {
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error ("Unknown exception in RoseStateDumper ctor");
	}
	//#UC END# *465E55B1009C_BODY*
}

RoseStateDumper::~RoseStateDumper () {
	//#UC START# *465E55270157_DESTR_BODY*
	//#UC END# *465E55270157_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// возвращает объект - State
IRoseStatePtr RoseStateDumper::state () const {
	//#UC START# *465E737601E4*
	return (IRoseStatePtr)this->rose_element ();
	//#UC END# *465E737601E4*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// возвращает класс
const std::string RoseStateDumper::get_model_class_str () const {
	//#UC START# *465EA35D005D_465E55270157*
	return "State";
	//#UC END# *465EA35D005D_465E55270157*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from AbstractDumperBase
// вид элемента
const std::string RoseStateDumper::get_class_kind_str () const {
	//#UC START# *465FE63402FD_465E55270157*
	std::string type = (const char*)state ()->StateKind->GetName ();
	return type;
	//#UC END# *465FE63402FD_465E55270157*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

