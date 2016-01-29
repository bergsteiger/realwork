////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractParameterDumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractParameterDumper
//
// Дампер для Розовских параметров операций
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractParameterDumper.h"
// by <<uses>> dependencies
#include "shared/GCL/str/str_op.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractClassDumper.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *4571DF8401B5_CUSTOM_INCLUDES*
//#UC END# *4571DF8401B5_CUSTOM_INCLUDES*


//#UC START# *4571DF8401B5*
RoseAbstractParameterDumper::RoseAbstractParameterDumper (const RoseAbstractDumper* parent, IRoseParameterPtr attr, const AbstractDumperBase::StereotypeID& st) 
	: RoseAbstractElementDumper (parent, attr, st) , m_init_value (0)
{
}

IRoseParameterPtr RoseAbstractParameterDumper::par () const {
	return (IRoseParameterPtr)this->rose_element();
}

IRoseClassPtr RoseAbstractParameterDumper::parent_cls () const {
	const AbstractDumperBase* parent_ptr = this->parent();
	return dynamic_cast<const RoseAbstractClassDumper*> (parent_ptr->parent())->cls();	
}

IRoseOperationPtr RoseAbstractParameterDumper::parent_op () const {
	const RoseAbstractDumper* parent_ptr = dynamic_cast<const RoseAbstractDumper*> (this->parent());
	return (IRoseOperationPtr)parent_ptr->rose_element();
}
//#UC END# *4571DF8401B5*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseAbstractParameterDumper::~RoseAbstractParameterDumper () {
	//#UC START# *4571DF8401B5_DESTR_BODY*
	//#UC END# *4571DF8401B5_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// возвращает класс
const std::string RoseAbstractParameterDumper::get_model_class_str () const {
	//#UC START# *465EA35D005D_4571DF8401B5*
	return PARAMETER_TYPE;
	//#UC END# *465EA35D005D_4571DF8401B5*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from AbstractDumperBase
// возвращает дампер для вывода значения по-умолчанию
AbstractDumperBase* RoseAbstractParameterDumper::get_initial_value () const {
	//#UC START# *473D7883037A_4571DF8401B5*
	return const_cast<RoseInitialValue*> (m_init_value.ptr ());
	//#UC END# *473D7883037A_4571DF8401B5*
}

// overloaded method from AbstractDumperBase
// значение по умолчанию (для атрибутов и аргументов операции)
const std::string RoseAbstractParameterDumper::get_initial_value_str () const {
	//#UC START# *4666BA9F03D8_4571DF8401B5*
	return (const char*)par()->InitValue;
	//#UC END# *4666BA9F03D8_4571DF8401B5*
}

// overloaded method from AbstractDumperBase
// возвращает имя
const std::string RoseAbstractParameterDumper::get_name_str () const {
	//#UC START# *466554D9006D_4571DF8401B5*
	GCL::StrVector names = GCL::split_string_by (RoseAbstractElementDumper::get_name_str().c_str(), ' ');
	
	if (names.size () == 1) {
		return names[0];
	} else {
		return names[1];
	}
	//#UC END# *466554D9006D_4571DF8401B5*
}

// overloaded method from AbstractDumperBase
// возвращает стереотип элемента
const std::string RoseAbstractParameterDumper::get_stereotype_str () const {
	//#UC START# *465FE0B403D8_4571DF8401B5*
	GCL::StrVector names = GCL::split_string_by (RoseAbstractElementDumper::get_name_str().c_str(), ' ');
	if (names.size () == 1) {
		return "in";
	} else {
		return names[0];
	}
	//#UC END# *465FE0B403D8_4571DF8401B5*
}

// overloaded method from ObjectTreeResolver
// связывает с элементом всех supplier
void RoseAbstractParameterDumper::link_suppliers () {
	//#UC START# *465E57F1029F_4571DF8401B5*
	RoseAbstractDumper::link_suppliers ();

	const RoseAbstractDumper* supl = 0;
	
	IRoseParameterPtr par = this->par ();
	IRoseElementPtr context = RoseHelper::get_context (par);
	if (context && context->IsClass(CLASS_TYPE)) {
		supl = this;
	} else {
		IRoseClassPtr linked_cls = /*par->GetTypeClass()*/0;

		if (linked_cls == 0) {
			std::string type = par->Type;
			if (!type.empty ()) {
				std::string original_type = type;
				supl = this->resolve_target_type (type);
				//supl = this->resolve (type);
				if (original_type != type) {
					RoseHelper::DoActionWithLock<IRoseParameterPtr> () (
						par
						, type.c_str ()
						, &RoseHelper::write_type
						, GenSupport::EnvironmentFactory::get ().get_lock_strategy ()
						, true
					);
				}
				if (supl) {
					std::string resolved_guid (get_rose_element_uid(supl->rose_element ()));
					TypeLinkHelperFactory::get ().link (par, resolved_guid);
				}
			} else if (!this->is_allow_empty_target()) {
				this->write_error_log ("Не определенный тип параметра", false);
			} else {
				supl = RoseAbstractDumper::find_in_tree((IRoseElementPtr)0);
			}
		} else {
			supl = RoseAbstractDumper::find_in_tree(linked_cls);
		}
	}

	this->add_supplier (supl, ST_NOT_NAVIGABLE, ST_TARGET);

	//добавляем значение по-умолчанию
	std::string init_value_type;
	std::string init_value_arg;
	std::string init_str = this->get_initial_value_str ();

	m_init_value = new RoseInitialValue (this);

	std::string original_init_str = init_str;
	m_init_value->link (init_str);

	if (original_init_str != init_str) {
		if (init_str.empty () == false) {
			RoseHelper::DoActionWithLock<IRoseParameterPtr> () (
				par
				, init_str.c_str ()
				, &RoseHelper::write_init_value
				, GenSupport::EnvironmentFactory::get ().get_lock_strategy ()
				, true
			);
		}
	}	
	//#UC END# *465E57F1029F_4571DF8401B5*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

