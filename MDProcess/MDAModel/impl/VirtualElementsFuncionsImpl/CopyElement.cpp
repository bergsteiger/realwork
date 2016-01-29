////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/CopyElement.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::CopyElement
//
// %S%f_copy_element(<УИД нового элемента>, <УИД или имя родителя>,<стереотип нового элемента>,<имя
// нового элемента>,<полное копирование (с детьми) или нет>,<имя перененной в которую запишется
// новый элемент>) - функция копирования элемента, если задано полное копирование - то копируются
// все дети элемента рекурсивно. Пример использования:
// {code}
// %S%f_copy_element(_COPY,,factory,new_make,true,VAR) - копиреует элемент в родителя копируемого
// элемента, с копированием всех детей
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/CopyElement.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumpFactory.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseInternal/RoseOperation.h"
#include "MDProcess/MDAModel/RoseInternal/RoseRealizeRelation.h"
#include "MDProcess/MDAModel/RoseInternal/RoseAttribute.h"
#include "MDProcess/MDAModel/RoseInternal/RoseClassDependency.h"
#include "MDProcess/MDAModel/RoseInternal/RoseInheritRelation.h"
#include "MDProcess/MDAModel/RoseInternal/RoseParameter.h"
#include "MDProcess/MDAModel/RoseInternal/RoseCategory.h"
#include "MDProcess/MDAModel/RoseInternal/RoseClass.h"
#include "MDProcess/MDAModel/AbstractDumpers/ObjectTreeResolver.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseCopyHelper.h"
#include "boost/lexical_cast.hpp"
#include "MDProcess/MDAModel/RoseInternal/RoseClassDependencyImpl.h"
#include "MDProcess/MDAModel/RoseInternal/RoseInheritRelationImpl.h"
#include "MDProcess/MDAModel/RoseInternal/RoseAttributeImpl.h"
#include "MDProcess/MDAModel/RoseInternal/RoseRealizeRelationImpl.h"
#include "MDProcess/MDAModel/RoseInternal/RoseOperationImpl.h"
#include "MDProcess/MDAModel/RoseInternal/RoseClassImpl.h"
#include "MDProcess/MDAModel/RoseInternal/RoseCategoryImpl.h"
#include "MDProcess/MDAModel/RoseInternal/RoseParameterImpl.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

CopyElement::CopyElement ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A9BB27E0085_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A9BB27E0085_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A9BB27E0085_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A9BB27E0085_BODY*
}

CopyElement::~CopyElement () {
	//#UC START# *4A9BB27E0085_DESTR_BODY*
	//#UC END# *4A9BB27E0085_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

RoseAbstractDumper* CopyElement::copy_attribute (
	const RoseAbstractDumper* elem
	, const RoseAbstractDumper* parent
	, const std::string& uid
	, const std::string& stereotype
	, const std::string& name
	, bool reqursive
	, const AbstractDumperBase* context
) const {
	//#UC START# *4A9CCCD90074*
	ATL::CComObject<RoseInternal::RoseAttributeImpl>* obj;
	ATL::CComObject<RoseInternal::RoseAttributeImpl>::CreateInstance (&obj);
	
	IRoseItemPtr parent_item = parent->rose_element ();
	IRoseItemPtr elem_item = elem->rose_element ();

	if (parent_item) {			
		obj->set_unique_id (uid);
		obj->set_stereotype (stereotype);
		obj->set_name (name);			
		obj->set_context (parent_item);
		obj->set_init_value (elem->get_initial_value_str ());
		obj->set_documentation (elem->get_documentation_str ());

		const RoseAbstractDumper* target_rad = dynamic_cast<const RoseAbstractDumper*> (elem->get_target ());
		if (target_rad) {
			obj->set_target_class (target_rad->rose_element ());
		}

		IRoseElementPtr attr = obj;
		RoseCopyHelper::copy_mda_property (elem_item, attr, false);

		IRoseClassPtr cls = obj->get_target_class ();
		if (cls) {
			TypeLinkHelperFactory::get ().link (attr, get_rose_element_uid(cls));
		}

		Core::Aptr<RoseAbstractDumpFactory> df = new RoseAbstractDumpFactory;
		RoseAbstractDumper::set_dumper_factory (df.in());

		RoseAbstractDumper* new_attr = df->create_by_stereotype (parent, attr);
		
		if (new_attr) {
			RoseAbstractDumper::add_virtual_dumper (new_attr, context);						
			if (reqursive) {
				this->copy_childs (elem, parent, new_attr);
			}

			new_attr->link_all_suppliers ();
		} else {
			throw Base::FatalError ("Creation virtual Attribute failed");
		}
		
		return new_attr;
	}

	return 0;
	//#UC END# *4A9CCCD90074*
}

// копирует папку, возвращает новый элемент
RoseAbstractDumper* CopyElement::copy_category (
	const RoseAbstractDumper* elem
	, const RoseAbstractDumper* parent
	, const std::string& uid
	, const std::string& stereotype
	, const std::string& name
	, bool reqursive
	, const AbstractDumperBase* context
) const {
	//#UC START# *4A9CCC1203DD*
	ATL::CComObject<RoseInternal::RoseCategoryImpl>* obj;
	ATL::CComObject<RoseInternal::RoseCategoryImpl>::CreateInstance (&obj);
	

	IRoseItemPtr parent_item = parent->rose_element ();
	IRoseCategoryPtr elem_cat = elem->rose_element ();

	if (parent_item) {			
		obj->set_unique_id (uid);
		obj->set_stereotype (stereotype);
		obj->set_name (name);			

		obj->set_context (parent_item);
		obj->set_documentation (elem->get_documentation_str ());
		obj->set_global (elem->is_global ());
		
		IRoseElementPtr cat = obj;
		RoseCopyHelper::copy_mda_property (elem_cat, cat, false);


		Core::Aptr<RoseAbstractDumpFactory> df = new RoseAbstractDumpFactory;
		RoseAbstractDumper::set_dumper_factory (df.in());

		RoseAbstractDumper* new_cat = df->create_by_stereotype (parent, cat);
		cat = 0;
		if (new_cat) {
			RoseAbstractDumper::add_virtual_dumper (new_cat, context);						
			if (reqursive) {
				this->copy_childs (elem, parent, new_cat);
			}

			new_cat->link_all_suppliers ();
		} else {
			throw Base::FatalError ("Creation virtual Category failed");
		}
		
		return new_cat;
	}

	return 0;
	//#UC END# *4A9CCC1203DD*
}

// копирование детей элемента (рекурсивно)
void CopyElement::copy_childs (
	const RoseAbstractDumper* elem
	, const RoseAbstractDumper* parent
	, const RoseAbstractDumper* new_elem
) const {
	//#UC START# *4A9CE85502DD*
	ObjectTreeResolver::ObjectTree::Items childs = ObjectTreeResolver::s_tree->childs (elem);
	ObjectTreeResolver::ObjectTree::Items::iterator it = childs.begin ();
	ObjectTreeResolver::ObjectTree::Items::iterator it_end = childs.end ();

	size_t counter = 0;
	for (; it != it_end; it++) {
		const RoseAbstractDumper* child = dynamic_cast<const RoseAbstractDumper*> (*(*it));
		if (child) {
			std::string child_stereotype = child->get_stereotype_str ();
			std::string child_name = child->get_name_str ();
			std::string child_uid = this->make_uid (
				new_elem
				, child->get_model_unique_id_str ()
				, boost::lexical_cast<std::string> (counter++)
			);

			this->copy_element (child, new_elem, child_uid, child_stereotype, child_name, true, new_elem);
		}
	}
	//#UC END# *4A9CE85502DD*
}

RoseAbstractDumper* CopyElement::copy_class (
	const RoseAbstractDumper* elem
	, const RoseAbstractDumper* parent
	, const std::string& uid
	, const std::string& stereotype
	, const std::string& name
	, bool reqursive
	, const AbstractDumperBase* context
) const {
	//#UC START# *4A9CCC8F017A*
	ATL::CComObject<RoseInternal::RoseClassImpl>* obj;
	ATL::CComObject<RoseInternal::RoseClassImpl>::CreateInstance (&obj);
	

	IRoseItemPtr parent_item = parent->rose_element ();
	
	if (parent_item) {			
		obj->set_unique_id (uid);
		obj->set_stereotype (stereotype);
		obj->set_name (name);			

		obj->set_context (parent_item);
		obj->set_documentation (elem->get_documentation_str ());
		
		
		IRoseElementPtr cls = obj;
		RoseCopyHelper::copy_mda_property (elem->rose_element (), cls, false);
		
		//copy Inherite & Realize relation
		Core::Aptr<AbstractDumperBase::ADList> generalizations = elem->get_generalizations ();
		
		AbstractDumperBase::ADList::const_iterator it = generalizations->begin ();
		AbstractDumperBase::ADList::const_iterator it_end = generalizations->end ();

		for (; it != it_end; ++it) {
			const RoseAbstractDumper* target_rad = dynamic_cast<const RoseAbstractDumper*> (*it);
			
			ATL::CComObject<RoseInternal::RoseInheritRelationImpl>* virtual_inherite_rel;
			virtual_inherite_rel->CreateInstance (&virtual_inherite_rel);
			
			virtual_inherite_rel->set_context (obj);
			
			std::string rel_guid (obj->get_unique_id ());
			short count = obj->get_inherite_relations ()->Count;
			
			rel_guid += std::string ("VINHERITE_REL") + boost::lexical_cast<std::string> (count + 1);
			virtual_inherite_rel->set_unique_id (rel_guid);
			virtual_inherite_rel->set_target_class (target_rad->rose_element ());

			IRoseInheritRelationPtr rel = virtual_inherite_rel;
			obj->add_inherit_relation (rel);
		}

		Core::Aptr<AbstractDumperBase::ADList> realizations = elem->get_realizations ();
		
		it = realizations->begin ();
		it_end = realizations->end ();

		for (; it != it_end; ++it) {
			const RoseAbstractDumper* target_rad = dynamic_cast<const RoseAbstractDumper*> (*it);
			
			ATL::CComObject<RoseInternal::RoseRealizeRelationImpl>* virtual_realize_rel;
			virtual_realize_rel->CreateInstance (&virtual_realize_rel);
			
			virtual_realize_rel->set_context (obj);
			
			std::string rel_guid (obj->get_unique_id ());
			short count = obj->get_realize_relations ()->Count;
			
			rel_guid += std::string ("VREALIZE_REL") + boost::lexical_cast<std::string> (count + 1);
			virtual_realize_rel->set_unique_id (rel_guid);
			virtual_realize_rel->set_target_class (target_rad->rose_element ());

			IRoseRealizeRelationPtr rel = virtual_realize_rel;
			obj->add_realize_relation (rel);
		}
		
		Core::Aptr<RoseAbstractDumpFactory> df = new RoseAbstractDumpFactory;
		RoseAbstractDumper::set_dumper_factory (df.in());

		RoseAbstractDumper* new_cls = df->create_by_stereotype (parent, cls);
		
		if (new_cls) {
			RoseAbstractDumper::add_virtual_dumper (new_cls, context);						
			if (reqursive) {
				this->copy_childs (elem, parent, new_cls);
			}

			new_cls->link_all_suppliers ();
		} else {
			throw Base::FatalError ("Creation virtual Class failed");
		}
		
		return new_cls;
	}

	return 0;
	//#UC END# *4A9CCC8F017A*
}

RoseAbstractDumper* CopyElement::copy_dependency (
	const RoseAbstractDumper* elem
	, const RoseAbstractDumper* parent
	, const std::string& uid
	, const std::string& stereotype
	, const std::string& name
	, bool reqursive
	, const AbstractDumperBase* context
) const {
	//#UC START# *4A9CCD71003E*
	const RoseAbstractDumper* target_rad = dynamic_cast<const RoseAbstractDumper*> (elem->get_target ());

	if (parent->get_model_class_str () == CLASS_TYPE) {
		IRoseItemPtr parent_item = parent->rose_element ();
		if (parent_item) {
			ATL::CComObject<RoseInternal::RoseClassDependencyImpl>* obj;
			obj->CreateInstance (&obj);

			obj->set_unique_id (uid);
			obj->set_stereotype (stereotype);
			obj->set_name (name);			

			obj->set_context (parent_item);
			obj->set_documentation (elem->get_documentation_str ());

			if (target_rad) {
				obj->set_target_class (target_rad->rose_element ());
			}

			IRoseElementPtr dep = obj;
			RoseCopyHelper::copy_mda_property (elem->rose_element (), dep, false);

			Core::Aptr<RoseAbstractDumpFactory> df = new RoseAbstractDumpFactory;
			RoseAbstractDumper::set_dumper_factory (df.in());

			RoseAbstractDumper* new_dep = df->create_by_stereotype (parent, dep);
			if (new_dep) {
				RoseAbstractDumper::add_virtual_dumper (new_dep, context);
				new_dep->link_all_suppliers ();				
			} else {
				throw Base::FatalError ("Creation virtual ClassDependency failed");
			}

			return new_dep;
		}
	} else if (!parent->is_supplier_with_stereotype (target_rad, ST_LINK_DEP)) {
		const_cast<RoseAbstractDumper*> (parent)->add_supplier (
			target_rad, ObjectTreeResolver::ST_NOT_NAVIGABLE, ST_LINK_DEP
		);

		RoseAbstractDumper::add_virtual_relation (parent, target_rad, ObjectTreeResolver::ST_NOT_NAVIGABLE, ST_LINK_DEP);
	}

	return 0;
	//#UC END# *4A9CCD71003E*
}

RoseAbstractDumper* CopyElement::copy_element (
	const RoseAbstractDumper* elem
	, const RoseAbstractDumper* parent
	, const std::string& uid
	, const std::string& stereotype
	, const std::string& name
	, bool reqursive
	, const AbstractDumperBase* context
) const {
	//#UC START# *4A9CCD540355*
	std::string self_class_type = elem->get_model_class_str ();
	
	RoseAbstractDumper* new_element = 0;
	if (self_class_type == CATEGORY_TYPE) {
		new_element = this->copy_category (elem, parent, uid, stereotype, name, reqursive, context);
	} else if (self_class_type == CLASS_TYPE) {
		new_element = this->copy_class (elem, parent, uid, stereotype, name, reqursive, context);
	} else if (self_class_type == ATTRIBUTE_TYPE) {
		new_element = this->copy_attribute (elem, parent, uid, stereotype, name, reqursive, context);
	} else if (self_class_type == OPERATION_TYPE) {
		new_element = this->copy_operation (elem, parent, uid, stereotype, name, reqursive, context);
	} else if (self_class_type == PARAMETER_TYPE) {
		new_element = this->copy_parameter (elem, parent, uid, stereotype, name, reqursive, context);
	} else if (self_class_type == CLASS_DEPENDENCY_TYPE) {
		new_element = this->copy_dependency (elem, parent, uid, stereotype, name, reqursive, context);
	} else if (self_class_type == DEPENDENCY_TYPE) {
		new_element = this->copy_dependency (elem, parent, uid, stereotype, name, reqursive, context);
	}

	if (new_element == 0) {
		throw Base::FatalError (
			std::string ("Unsupported element type: " + self_class_type)
		);
	}

	new_element->copy_temporary_properties_from (elem);

	return new_element;
	//#UC END# *4A9CCD540355*
}

RoseAbstractDumper* CopyElement::copy_operation (
	const RoseAbstractDumper* elem
	, const RoseAbstractDumper* parent
	, const std::string& uid
	, const std::string& stereotype
	, const std::string& name
	, bool reqursive
	, const AbstractDumperBase* context
) const {
	//#UC START# *4A9CCCC70086*
	ATL::CComObject<RoseInternal::RoseOperationImpl>* obj;
	ATL::CComObject<RoseInternal::RoseOperationImpl>::CreateInstance (&obj);
	
	IRoseItemPtr parent_item = parent->rose_element ();
	IRoseItemPtr elem_item = elem->rose_element ();

	if (parent_item) {			
		obj->set_unique_id (uid);
		obj->set_stereotype (stereotype);
		obj->set_name (name);

		obj->set_documentation (elem->get_documentation_str ());
		obj->set_context (parent_item);
		
		const RoseAbstractDumper* target_rad = dynamic_cast<const RoseAbstractDumper*> (elem->get_target ());
		if (target_rad) {
			obj->set_target_class (target_rad->rose_element ());
		}

		IRoseElementPtr op = obj;
		RoseCopyHelper::copy_mda_property (elem_item, op, false);

		IRoseClassPtr cls = obj->get_target_class ();
		if (cls) {
			TypeLinkHelperFactory::get ().link (op, get_rose_element_uid(cls));
		}

		Core::Aptr<RoseAbstractDumpFactory> df = new RoseAbstractDumpFactory;
		RoseAbstractDumper::set_dumper_factory (df.in());

		RoseAbstractDumper* new_op = df->create_by_stereotype (parent, op);
		
		if (new_op) {
			RoseAbstractDumper::add_virtual_dumper (new_op, context);						
			if (reqursive) {
				this->copy_childs (elem, parent, new_op);
			}

			new_op->link_all_suppliers ();
		} else {
			throw Base::FatalError ("Creation virtual Operation failed");
		}
		
		return new_op;
	}

	return 0;
	//#UC END# *4A9CCCC70086*
}

RoseAbstractDumper* CopyElement::copy_parameter (
	const RoseAbstractDumper* elem
	, const RoseAbstractDumper* parent
	, const std::string& uid
	, const std::string& stereotype
	, const std::string& name
	, bool reqursive
	, const AbstractDumperBase* context
) const {
	//#UC START# *4A9CCD460243*
	ATL::CComObject<RoseInternal::RoseParameterImpl>* obj;
	ATL::CComObject<RoseInternal::RoseParameterImpl>::CreateInstance (&obj);
	
	IRoseItemPtr parent_item = parent->rose_element ();
	IRoseItemPtr elem_item = elem->rose_element ();

	if (parent_item) {			
		obj->set_unique_id (uid);
		obj->set_stereotype (stereotype);
		obj->set_name (stereotype + " " + name);

		obj->set_initial_value (elem->get_initial_value_str ());
		obj->set_documentation (elem->get_documentation_str ());
		obj->set_context (parent_item);
		
		
		const RoseAbstractDumper* target_rad = dynamic_cast<const RoseAbstractDumper*> (elem->get_target ());
		if (target_rad) {
			obj->set_target_class (target_rad->rose_element ());
		}
		
		IRoseElementPtr param = obj;
		RoseCopyHelper::copy_mda_property (elem_item, param, false);

		IRoseClassPtr cls = obj->get_target_class ();
		if (cls) {
			TypeLinkHelperFactory::get ().link (param, get_rose_element_uid(cls));
		}

		Core::Aptr<RoseAbstractDumpFactory> df = new RoseAbstractDumpFactory;
		RoseAbstractDumper::set_dumper_factory (df.in());

		RoseAbstractDumper* new_param = df->create_by_stereotype (parent, param);
		
		if (new_param) {
			RoseAbstractDumper::add_virtual_dumper (new_param, context);						
			if (reqursive) {
				this->copy_childs (elem, parent, new_param);
			}

			new_param->link_all_suppliers ();
		} else {
			throw Base::FatalError ("Creation virtual Operation failed");
		}
		
		return new_param;
	}

	return 0;
	//#UC END# *4A9CCD460243*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string CopyElement::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4A9BB27E0085*
	if (params.size () < 6) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 6, params.size ());
	}
	
	const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*> (self);
	if (rad) {
		std::string uid = TemplatePainter::resolve_exp (params[0], painter);
		uid = this->make_uid (rad, "", uid);

		std::string parent_uid_or_name = TemplatePainter::resolve_exp (params[1], painter);
		std::string stereotype = TemplatePainter::resolve_exp (params[2], painter);
		std::string name = TemplatePainter::resolve_exp (params[3], painter);
		std::string need_full_copy = TemplatePainter::resolve_exp (params[4], painter);
		std::string var_id = TemplatePainter::resolve_exp (params[5], painter);
		
		const RoseAbstractDumper* parent = 0;
		if (!parent_uid_or_name.empty ()) {
			parent = RoseAbstractDumper::find_in_tree (parent_uid_or_name);

			if (!parent) {
				Core::Aptr<ObjectTreeResolver::OTRVector> elements = ObjectTreeResolver::find_by_name (parent_uid_or_name);

				if (elements->size () > 1) {
					throw Base::FatalError (
						std::string ("Найдено более одного элемента с именем: ")
						+ parent_uid_or_name
					);
				}
				
				if (!elements->empty ()) {
					parent = dynamic_cast<const RoseAbstractDumper*>((*elements)[0]);
				}
			}			
		} else {
			throw Base::FatalError (
				std::string ("Не задан идентификатор (или имя) родителя для копируемого элемента")
			);
		}

		if (!parent) {
			throw Base::FatalError (
				std::string ("Не удалось найти родителя для копии элемента: ")
				+ (static_cast<const Base::NamedElement*> (rad))->get_full_name ()
			);
		}		
		
		RoseAbstractDumper* new_elem = this->copy_element (
			rad, parent, uid, stereotype, name, need_full_copy == "true" ? true : false, painter->get_main_scope ()
		);

		if (new_elem) {
			painter->invalidate_dumpers_list (SX_3_CONTENTS, parent);
			painter->invalidate_dumpers_list (SX_3_ALL_CONTENTS, parent);

			TemplatePainter::set_var_dumper (var_id, new_elem);
		}
	}	
	return std::string ();
	//#UC END# *4A2DFD7B0291_4A9BB27E0085*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

