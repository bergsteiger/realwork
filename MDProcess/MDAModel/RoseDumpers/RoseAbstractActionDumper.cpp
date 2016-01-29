////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractActionDumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractActionDumper
//
// дампер розовских Action
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractActionDumper.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *465FB9A903D8_CUSTOM_INCLUDES*
//#UC END# *465FB9A903D8_CUSTOM_INCLUDES*


//#UC START# *465FB9A903D8*
//#UC END# *465FB9A903D8*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// init ctor
RoseAbstractActionDumper::RoseAbstractActionDumper (
	const RoseAbstractDumper* parent
	, IRoseActionPtr action
	, const AbstractDumperBase::StereotypeID& st
)
//#UC START# *465FBA12031C_BASE_INIT*
: RoseAbstractElementDumper (parent, action, st) 
//#UC END# *465FBA12031C_BASE_INIT*
{
	//#UC START# *465FBA12031C_BODY*
	try {
		IRoseItemPtr par = action->GetContext ();
		if (par->IsClass ("State")) {
			IRoseStatePtr parent_state = par;
			IRoseActionCollectionPtr do_actions = parent_state->GetDoActions ();
			if (do_actions->Exists (action)) {
				m_action_type = "do";
			} else {
				IRoseActionCollectionPtr entry_actions = parent_state->GetEntryActions ();
				if (entry_actions->Exists (action)) {
					m_action_type = "entry";				
				} else {
					IRoseActionCollectionPtr exit_actions = parent_state->GetExitActions ();
					if (exit_actions->Exists (action)) {
						m_action_type = "exit";					
					}
				}
			}
		} else if (par->IsClass ("Transition")) {
			IRoseTransitionPtr transition = par;
			IRoseActionPtr send_action = transition->GetSendAction ();
			if (get_rose_element_uid(send_action) == get_rose_element_uid(action)) {
				m_action_type = "send";			
			} else {
				IRoseActionPtr trigger_action = transition->GetTriggerAction ();
				if (get_rose_element_uid(trigger_action) == get_rose_element_uid(action)) {
					m_action_type = "trigger";				
				}
			}
		}
	} catch (std::exception& ex) {
		std::string str = "Exception in RoseAbstractElementDumper ctor: ";
		str += ex.what ();
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error (str.data());
	} catch (...) {
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error ("Unknown exception in RoseAbstractElementDumper ctor");
	}
	//#UC END# *465FBA12031C_BODY*
}

RoseAbstractActionDumper::~RoseAbstractActionDumper () {
	//#UC START# *465FB9A903D8_DESTR_BODY*
	//#UC END# *465FB9A903D8_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// возвращает класс
const std::string RoseAbstractActionDumper::get_model_class_str () const {
	//#UC START# *465EA35D005D_465FB9A903D8*
	return (const char*)this->rose_element ()->IdentifyClass ();
	//#UC END# *465EA35D005D_465FB9A903D8*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from AbstractDumperBase
// вид элемента
const std::string RoseAbstractActionDumper::get_class_kind_str () const {
	//#UC START# *465FE63402FD_465FB9A903D8*
	return m_action_type;
	//#UC END# *465FE63402FD_465FB9A903D8*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

