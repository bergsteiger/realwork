////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractAttributeDumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractAttributeDumper
//
// Дампер для розовских атрибутов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractAttributeDumper.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseModel/RoseModelFactories.h"
// local helpers
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"

//#UC START# *4571DF1E00CB_CUSTOM_INCLUDES*
#include "boost/function.hpp"
//#UC END# *4571DF1E00CB_CUSTOM_INCLUDES*


//#UC START# *4571DF1E00CB*
RoseAbstractAttributeDumper::RoseAbstractAttributeDumper (const RoseAbstractDumper* parent, IRoseItemPtr attr, const AbstractDumperBase::StereotypeID& st) 
	: RoseAbstractElementDumper (parent, attr, st), m_init_value (0)
{
	try {
		if (attr->IsClass (ATTRIBUTE_TYPE)) {
			m_is_rl_attr = false;
		} else if (attr->IsClass ("Role")) {
			m_is_rl_attr = true;
			IRoseAttributeCollectionPtr keys = ((IRoseRolePtr)attr)->Keys;
			for (int i = 1; i < keys->Count + 1; i++) {		
				IRoseAttributePtr key = keys->GetAt(i);
				RoseAbstractDumper::dump_factory()->create_by_stereotype (this, key);
			}
		} else {
			// shit happens
			AbstractDumperBase::has_error(true);
			GenSupport::LogManagerFactory::get ().log_error ("Unknown attribute class");
		}

		RoseAbstractAttributeDumper::update_cached_attrs ();
	} catch (std::exception& ex) {
		std::string str = "Exception in RoseAbstractAttributeDumper ctor: ";
		str += ex.what ();
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error (str.data());
	} catch (...) {
		AbstractDumperBase::has_error(true);
		GenSupport::LogManagerFactory::get ().log_error ("Unknown exception in RoseAbstractAttributeDumper ctor");
	}
}


IRoseAttributePtr RoseAbstractAttributeDumper::attr () const {
	return m_is_rl_attr ? NULL : (IRoseAttributePtr)this->rose_element();
}

IRoseRolePtr RoseAbstractAttributeDumper::rl_attr () const {
	return m_is_rl_attr ? (IRoseRolePtr)this->rose_element() : NULL;
}

IRoseClassPtr RoseAbstractAttributeDumper::parent_cls () const {
	const RoseAbstractDumper* parent_ptr = dynamic_cast<const RoseAbstractDumper*> (this->parent());
	return (IRoseClassPtr)parent_ptr->rose_element();
}
//#UC END# *4571DF1E00CB*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseAbstractAttributeDumper::~RoseAbstractAttributeDumper () {
	//#UC START# *4571DF1E00CB_DESTR_BODY*
	//#UC END# *4571DF1E00CB_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const std::string& RoseAbstractAttributeDumper::get_link_type () const {
	//#UC START# *4B98C30E0085_GET_ACCESSOR*
	return m_link_type;
	//#UC END# *4B98C30E0085_GET_ACCESSOR*
}

void RoseAbstractAttributeDumper::set_link_type (const std::string& link_type) const {
	//#UC START# *4B98C30E0085_SET_ACCESSOR*
	m_link_type = link_type;
	//#UC END# *4B98C30E0085_SET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AbstractDumperBase
// возвращает класс
const std::string RoseAbstractAttributeDumper::get_model_class_str () const {
	//#UC START# *465EA35D005D_4571DF1E00CB*
	return ATTRIBUTE_TYPE;
	//#UC END# *465EA35D005D_4571DF1E00CB*
}
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from AbstractDumperBase
// возвращает дампер для вывода значения по-умолчанию
AbstractDumperBase* RoseAbstractAttributeDumper::get_initial_value () const {
	//#UC START# *473D7883037A_4571DF1E00CB*
	return const_cast<RoseInitialValue*> (m_init_value.ptr ());
	//#UC END# *473D7883037A_4571DF1E00CB*
}

// overloaded method from AbstractDumperBase
// значение по умолчанию (для атрибутов и аргументов операции)
const std::string RoseAbstractAttributeDumper::get_initial_value_str () const {
	//#UC START# *4666BA9F03D8_4571DF1E00CB*
	std::string ret;
	if (!m_is_rl_attr) {
		ret = static_cast<const char*> (attr ()->InitValue);
	}

	return ret;
	//#UC END# *4666BA9F03D8_4571DF1E00CB*
}

// overloaded method from AbstractDumperBase
// agr/lnk/ref - тип связи Агрегация, По Ссылке с счетчиком (Var или Box), По Указателю
const std::string RoseAbstractAttributeDumper::get_link_type_str () const {
	//#UC START# *4666BBD903B9_4571DF1E00CB*
	return get_link_type ();
	//#UC END# *4666BBD903B9_4571DF1E00CB*
}

// overloaded method from AbstractDumperBase
// возвращает стереотип элемента
const std::string RoseAbstractAttributeDumper::get_stereotype_str () const {
	//#UC START# *465FE0B403D8_4571DF1E00CB*
	if (m_is_rl_attr) {
		return (char*) this->rl_attr()->Stereotype;
	} else {
		return (char*) this->attr()->Stereotype;
	}
	//#UC END# *465FE0B403D8_4571DF1E00CB*
}

// overloaded method from ObjectTreeResolver
// связывает с элементом всех supplier
void RoseAbstractAttributeDumper::link_suppliers () {
	//#UC START# *465E57F1029F_4571DF1E00CB*
	RoseAbstractDumper::link_suppliers ();
	
	const RoseAbstractDumper* supl = 0;
	if (m_is_rl_attr) {
		supl = RoseAbstractDumper::find_in_tree(this->rl_attr()->GetClass());		
	} else {
		IRoseAttributePtr attr = this->attr();
		IRoseClassPtr linked_cls = /*attr->GetTypeClass()*/0;
		if (linked_cls == 0) {
			if (attr->GetType () != _bstr_t ("")) {
				std::string type = attr->Type;
				std::string original_type = type;
				
				supl = this->resolve_target_type (type);
				//supl = this->resolve (type);
				if (original_type != type) {
					RoseHelper::DoActionWithLock<IRoseAttributePtr> () (
						attr
						, type.c_str ()
						, &RoseHelper::write_type
						, GenSupport::EnvironmentFactory::get ().get_lock_strategy ()
						, true
					);
				}
				if (supl) {
					std::string resolved_guid = get_rose_element_uid(supl->rose_element ());
					TypeLinkHelperFactory::get ().link (attr, resolved_guid);
				}
			} else if (!this->is_allow_empty_target()) {
				this->write_error_log ("Не определенный тип атрибута", false);
			} else {
				supl = RoseAbstractDumper::find_in_tree((IRoseElementPtr)0);
			}
		} else {
			supl = RoseAbstractDumper::find_in_tree(linked_cls);
		}
	}
	if (supl) {
		std::string link_type = this->get_link_type_str ();
		if (link_type == "agr" || link_type == "ref") {
			this->add_supplier (supl, ST_NAVIGABLE, ST_TARGET);
		} else {
			this->add_supplier (supl, ST_NOT_NAVIGABLE, ST_TARGET);
		}
	}
	//добавляем значение по-умолчанию
	std::string init_value_type;
	std::string init_value_arg;
	std::string init_str = this->get_initial_value_str ();
	
	m_init_value = new RoseInitialValue (this);

	std::string original_init_str = init_str;
	m_init_value->link (init_str);

	if (original_init_str != init_str && !m_is_rl_attr) {
		if (init_str.empty () == false) {
			RoseHelper::DoActionWithLock<IRoseAttributePtr> () (
				attr ()
				, init_str.c_str ()
				, &RoseHelper::write_init_value
				, GenSupport::EnvironmentFactory::get ().get_lock_strategy ()
				, true
			);
		}
	}
	//#UC END# *465E57F1029F_4571DF1E00CB*
}

// overloaded method from RoseAbstractDumper
// метод вызывается, когда нужно обновить, закэшированные на дампере значения атрибутов
void RoseAbstractAttributeDumper::update_cached_attrs () const {
	//#UC START# *4B98C3A50072_4571DF1E00CB*
	this->set_link_type (RoseHelper::get_link_type(this->rose_element()));
	RoseAbstractDumper::update_cached_attrs ();
	//#UC END# *4B98C3A50072_4571DF1E00CB*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

