////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractDumpFactory.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractDumpFactory
//
// Фабрика для создания конкретного дампера на основе IRoseItem
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumpFactory.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractAttributeDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractCategoryDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractClassDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractOperationDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractParameterDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDependencyDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseStateDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseTransitionDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractActionDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseStateMachineDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseEventDumper.h"
#include "MDProcess/MDAModel/AbstractDumpers/GenerationParams.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *4571DD4D0399_CUSTOM_INCLUDES*
//#UC END# *4571DD4D0399_CUSTOM_INCLUDES*


//#UC START# *4571DD4D0399*
//#UC END# *4571DD4D0399*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseAbstractDumpFactory::~RoseAbstractDumpFactory () {
	//#UC START# *4571DD4D0399_DESTR_BODY*
	//#UC END# *4571DD4D0399_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from RoseAbstractDumper::DumpersFactory
// проверяет правильность указания стереотип, возвращает true, если все хорошо, иначе false
bool RoseAbstractDumpFactory::check_stereotype (IRoseElementPtr elem) const {
	//#UC START# *4AC35322012B_4571DD4D0399*
	if (!AbstractDumperBase::has_template(AbstractDumperBase::StereotypeID (RoseHelper::create_gen_stereotype (elem)))) {		
		if (
			!elem->IsClass (PARAMETER_TYPE) 
			&& !(
				elem->IsClass(CATEGORY_TYPE) 
				&& ((IRoseItemPtr)RoseHelper::get_context (elem))->Stereotype == _bstr_t("")
			)
		) {
			return false;
		}
	}

	return true;
	//#UC END# *4AC35322012B_4571DD4D0399*
}

// implemented method from RoseAbstractDumper::DumpersFactory
// создает дампер как рутовый элемент
RoseAbstractDumper* RoseAbstractDumpFactory::create_by_root (IRoseItemPtr cls) {
	//#UC START# *4575AFA90396_4571DD4D0399*
	GenSupport::EnvironmentFactory::get ().set_lock_failed_need_ask (true);
	GenSupport::EnvironmentFactory::get ().set_lock_failed_need_fatal_error (true);
	
	//при построении дерева генерации выставляем стратегию залочки
	GenSupport::EnvironmentFactory::get ().set_lock_strategy (
		static_cast<GenSupport::LockStrategy> (
			GenerationParams::get_lock_strategy ()
		)
	);
	
	if (cls->IsClass (CATEGORY_TYPE)) {
		RoseAbstractDumper* ret = 0;
		{
			Core::GDS::StopWatch sw ("create_by_root");
			ret = new RoseAbstractCategoryDumper (0, (IRoseCategoryPtr)cls);
		}
		{
		
			Core::GDS::StopWatch sw ("link_all_suppliers");

			ret->link_all_suppliers();
		}
		return ret;
	} else {
		GDS_ASSERT_MSG(0, ("Can't create root from non Category item"))
		return 0;
	}
	//#UC END# *4575AFA90396_4571DD4D0399*
}

// implemented method from RoseAbstractDumper::DumpersFactory
// создать дампер на основе родителя и розовского элмента
RoseAbstractDumper* RoseAbstractDumpFactory::create_by_stereotype (
	const RoseAbstractDumper* parent
	, IRoseElementPtr cls
) {
	//#UC START# *4575AA4602EA_4571DD4D0399*
	RoseAbstractDumper* ret = NULL;

	AbstractDumperBase::StereotypeID stereotype = RoseHelper::get_gen_stereotype(cls);

	if (!AbstractDumperBase::get_template(stereotype).skiped_item) {
		try {			
			if (cls->IsClass (CATEGORY_TYPE)) {
				ret = new RoseAbstractCategoryDumper (parent, (IRoseCategoryPtr)cls);
			}

			if (cls->IsClass (CLASS_TYPE)) {
				ret = new RoseAbstractClassDumper (parent, (IRoseClassPtr)cls);
			} 

			if (cls->IsClass (ATTRIBUTE_TYPE) || cls->IsClass ("Role"))  {				
				ret = new RoseAbstractAttributeDumper (parent, cls, stereotype);
			} 
			
			if (cls->IsClass (OPERATION_TYPE)) {
				ret = new RoseAbstractOperationDumper (parent, (IRoseOperationPtr)cls, stereotype);
			} 

			if (cls->IsClass (PARAMETER_TYPE)) {
				ret = new RoseAbstractParameterDumper (parent, (IRoseParameterPtr)cls, stereotype);
			}

			if ( cls->IsClass (CLASS_DEPENDENCY_TYPE) ) {
				ret = new RoseAbstractDependencyDumper (parent, (IRoseClassDependencyPtr)cls, stereotype);
			}

			if ( cls->IsClass ("State") ) {
				ret = new RoseStateDumper (parent, (IRoseStatePtr)cls);
			}

			if ( cls->IsClass ("Transition") ) {
				if (RoseHelper::get_full_name(cls) == "Logical View::MDProcess::DocCardChange::Entities::UVSStateMachine::StateModel::") {
					int i = 0;
					i++;
				}
				ret = new RoseTransitionDumper (parent, (IRoseTransitionPtr)cls);
			}

			if (cls->IsClass ("Action")) {
				ret = new RoseAbstractActionDumper (parent, (IRoseActionPtr)cls, stereotype);
			}

			if (cls->IsClass ("StateMachine")) {
				ret = new RoseStateMachineDumper (parent, cls);
			}

			// check stereotype for existing
			if (!this->check_stereotype (cls)) {
				std::string str ("Unknown stereotype <<");
				str += cls->IsClass (ROSE_ITEM_TYPE) ? (const char*)((IRoseItemPtr)cls)->GetStereotype() : "";
				str += ">>";

				ret->write_error_log (str, false);
			}
		} catch (ObjectTreeResolver::ObjectTree::AlreadyInTree& ) {
			std::string str ("Duplicated model id (");
			str += get_rose_element_uid(cls);
			str += ") for element ";
			str += RoseHelper::get_full_name (cls);
			str += " - check model integrity";
			
			AbstractDumperBase::has_error(true);
			
			GenSupport::ErrorManagerFactory::get ().error (RoseAbstractDumper::find_in_tree (get_rose_element_uid(cls)), str, "Построение дерева");
			GenSupport::LogManagerFactory::get ().log_error(str.data());
			ret = 0;
		}
	}

	return ret;
	//#UC END# *4575AA4602EA_4571DD4D0399*
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

