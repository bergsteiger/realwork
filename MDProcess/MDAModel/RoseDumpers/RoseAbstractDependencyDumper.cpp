////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractDependencyDumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractDependencyDumper
//
// Дампер для розовских связей зависимости
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDependencyDumper.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *4571DFE7035B_CUSTOM_INCLUDES*
//#UC END# *4571DFE7035B_CUSTOM_INCLUDES*


//#UC START# *4571DFE7035B*
RoseAbstractDependencyDumper::RoseAbstractDependencyDumper (const RoseAbstractDumper* parent, IRoseItemPtr attr, const AbstractDumperBase::StereotypeID& st) 
	: RoseAbstractElementDumper (parent, attr, st) 
{	
}

IRoseClassDependencyPtr RoseAbstractDependencyDumper::dep () const {
	return (IRoseClassDependencyPtr)this->rose_element();
}

IRoseClassPtr RoseAbstractDependencyDumper::parent_cls () const {
	const RoseAbstractDumper* parent_ptr = dynamic_cast<const RoseAbstractDumper*> (this->parent());
	return (IRoseClassPtr)parent_ptr->rose_element();
}

//#UC END# *4571DFE7035B*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseAbstractDependencyDumper::~RoseAbstractDependencyDumper () {
	//#UC START# *4571DFE7035B_DESTR_BODY*
	//#UC END# *4571DFE7035B_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// возвращает класс
const std::string RoseAbstractDependencyDumper::get_model_class_str () const {
	//#UC START# *465EA35D005D_4571DFE7035B*
	return "Dependency";
	//#UC END# *465EA35D005D_4571DFE7035B*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from ObjectTreeResolver
// связывает с элементом всех supplier
void RoseAbstractDependencyDumper::link_suppliers () {
	//#UC START# *465E57F1029F_4571DFE7035B*
	RoseAbstractDumper::link_suppliers ();
	IRoseItemPtr sup = this->dep()->GetSupplier();
	if (sup != 0) {	
		this->add_supplier (RoseAbstractDumper::find_in_tree(sup), ST_IGNORED, ST_USER_DEF_TARGET );
	}
	//#UC END# *465E57F1029F_4571DFE7035B*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

