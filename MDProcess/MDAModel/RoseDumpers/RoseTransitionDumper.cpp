////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseTransitionDumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseTransitionDumper
//
// дампер переходов между состояниями
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseTransitionDumper.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseEventDumper.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *465E55840157_CUSTOM_INCLUDES*
//#UC END# *465E55840157_CUSTOM_INCLUDES*


//#UC START# *465E55840157*
//#UC END# *465E55840157*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// init cotr
RoseTransitionDumper::RoseTransitionDumper (const RoseAbstractDumper* parent, IRoseTransitionPtr item)
//#UC START# *465E562F01A5_BASE_INIT*
: RoseAbstractElementDumper (parent, item) 
//#UC END# *465E562F01A5_BASE_INIT*
{
	//#UC START# *465E562F01A5_BODY*
	try {
		IRoseActionPtr send_action = item->GetSendAction ();
		if (send_action && send_action->Name != _bstr_t ("")) {
			RoseAbstractDumper::dump_factory()->create_by_stereotype (this, send_action);
		}
		IRoseActionPtr trigger_action = item->GetTriggerAction ();
		if (trigger_action && trigger_action->Name != _bstr_t ("")) {
			RoseAbstractDumper::dump_factory()->create_by_stereotype (this, trigger_action);			
		}

		IRoseEventPtr trigger_event = item->GetTriggerEvent ();
		if (trigger_event && (trigger_event->Name != _bstr_t ("") || trigger_event->GuardCondition != _bstr_t (""))) {
			RoseEventDumper* red = new RoseEventDumper (this, trigger_event);
			//RoseAbstractDumper::dump_factory()->create_by_stereotype (*this, trigger_event);
		}
	} catch (std::exception& ex) {
		std::string str = "Exception in RoseTransitionDumper ctor: ";
		str += ex.what ();
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error (str.data());
	} catch (...) {
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error ("Unknown exception in RoseTransitionDumper ctor");
	}
	//#UC END# *465E562F01A5_BODY*
}

RoseTransitionDumper::~RoseTransitionDumper () {
	//#UC START# *465E55840157_DESTR_BODY*
	//#UC END# *465E55840157_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// возвращает объект - переход
IRoseTransitionPtr RoseTransitionDumper::transition () const {
	//#UC START# *465E571200AB*
	return (IRoseTransitionPtr)this->rose_element();
	//#UC END# *465E571200AB*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// возвращает класс
const std::string RoseTransitionDumper::get_model_class_str () const {
	//#UC START# *465EA35D005D_465E55840157*
	return "Transition";
	//#UC END# *465EA35D005D_465E55840157*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from AbstractDumperBase
// значение по умолчанию (для атрибутов и аргументов операции)
const std::string RoseTransitionDumper::get_initial_value_str () const {
	//#UC START# *4666BA9F03D8_465E55840157*
	std::string cond;
	IRoseTransitionPtr transition = this->rose_element ();
	if (transition) {
		IRoseEventPtr rose_event = transition ->GetTriggerEvent ();	
		if (rose_event) {
			cond = rose_event->Arguments;
		}
	}
	return cond;
	//#UC END# *4666BA9F03D8_465E55840157*
}

// overloaded method from ObjectTreeResolver
// связывает с элементом всех supplier
void RoseTransitionDumper::link_suppliers () {
	//#UC START# *465E57F1029F_465E55840157*
	RoseAbstractDumper::link_suppliers ();
	IRoseItemPtr sup = this->transition()->GetTargetState ();
	if (sup != 0) {	
		this->add_supplier (RoseAbstractDumper::find_in_tree(sup), ST_IGNORED, ST_USER_DEF_TARGET );
	}
	//#UC END# *465E57F1029F_465E55840157*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

