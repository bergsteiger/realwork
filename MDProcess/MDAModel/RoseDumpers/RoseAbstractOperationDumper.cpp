////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractOperationDumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractOperationDumper
//
// Дампер для Розовских операций
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractOperationDumper.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *4571DF59030D_CUSTOM_INCLUDES*
//#UC END# *4571DF59030D_CUSTOM_INCLUDES*


//#UC START# *4571DF59030D*
RoseAbstractOperationDumper::RoseAbstractOperationDumper (const RoseAbstractDumper* parent, IRoseOperationPtr op, const AbstractDumperBase::StereotypeID& st )
		: RoseAbstractElementDumper (parent, op, st) 
{
	try {
		IRoseParameterCollectionPtr params = op->Parameters;
		int l;
		short params_count = params->Count;
		for (l=1; l <= params_count; l++) {		
			IRoseParameterPtr par = params->GetAt(l);
			RoseAbstractDumper::dump_factory()->create_by_stereotype (this, par);
		}
		//собираем все State-диаграммы
		IRoseStateMachineOwnerPtr state_machine_owner = op->GetStateMachineOwner ();
		if (state_machine_owner) {
			IRoseStateMachineCollectionPtr st_machines = state_machine_owner->GetStateMachines ();
			short st_machines_count = st_machines->Count;
			for (short i = 1; i <= st_machines_count; ++i) {
				RoseAbstractDumper::dump_factory()->create_by_stereotype (this, st_machines->GetAt (i));			
			}
		}
	} catch (std::exception& ex) {
		std::string str = "Exception in RoseAbstractOperationDumper ctor: ";
		str += ex.what ();
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error (str.data());
	} catch (...) {
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error ("Unknown exception in RoseAbstractOperationDumper ctor");
	}
}

IRoseOperationPtr RoseAbstractOperationDumper::op () const {
	return (IRoseOperationPtr)this->rose_element();
}

IRoseClassPtr RoseAbstractOperationDumper::parent_cls () const {
	const RoseAbstractDumper* parent_ptr = dynamic_cast<const RoseAbstractDumper*> (this->parent());
	return (IRoseClassPtr)parent_ptr->rose_element();
}

//#UC END# *4571DF59030D*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseAbstractOperationDumper::~RoseAbstractOperationDumper () {
	//#UC START# *4571DF59030D_DESTR_BODY*
	//#UC END# *4571DF59030D_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// возвращает класс
const std::string RoseAbstractOperationDumper::get_model_class_str () const {
	//#UC START# *465EA35D005D_4571DF59030D*
	return OPERATION_TYPE;
	//#UC END# *465EA35D005D_4571DF59030D*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from ObjectTreeResolver
// связывает с элементом всех supplier
void RoseAbstractOperationDumper::link_suppliers () {
	//#UC START# *465E57F1029F_4571DF59030D*
	RoseAbstractDumper::link_suppliers ();

	const RoseAbstractDumper* supl = 0;
	
	IRoseOperationPtr op = this->op ();

	IRoseClassPtr linked_cls = /*op->GetResultClass()*/0;
	if (linked_cls == 0) {
		std::string type = op->ReturnType;
		if (!type.empty ()) {
			std::string original_type = type;
			supl = this->resolve_target_type (type);
			//supl = this->resolve (type);
			if (original_type != type) {
				RoseHelper::DoActionWithLock<IRoseOperationPtr> () (
					op
					, type.c_str ()
					, &RoseHelper::write_return_type
					, GenSupport::EnvironmentFactory::get ().get_lock_strategy ()
					, true
				);
			}
			if (supl) {
				std::string resolved_guid (get_rose_element_uid(supl->rose_element ()));
				TypeLinkHelperFactory::get ().link (op, resolved_guid);
			}
		} else if (!this->is_allow_empty_target()) {
			this->write_error_log ("Не определенный тип результата операции", false);
			return;
		} else {
			supl = RoseAbstractDumper::find_in_tree((IRoseElementPtr)0);
		}
	} else {
		supl = RoseAbstractDumper::find_in_tree(linked_cls);
	}
	

	if (supl) {
		add_supplier (supl, ST_NOT_NAVIGABLE, ST_TARGET);
	}	
	//#UC END# *465E57F1029F_4571DF59030D*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

