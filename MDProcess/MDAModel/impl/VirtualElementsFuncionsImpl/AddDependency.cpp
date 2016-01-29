////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddDependency.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddDependency
//
// 1. %S%f_add_dependency(<UID нового элемента>,<цель связи>,<стереотип>,<имя связи>,<имя
// переменной>) - создает новую связь между текущим и элементом и целью связи, цель может быть
// задана УИДом реального элемента либо просто именем - данный формат используется для простановки
// связи между классами
// 2. %S%f_add_dependency(<цель связи>) - создает новую связь между текущим и элементом и целью
// связи, цель может быть задана УИДом реального элемента либо просто именем - данный формат
// используется для простановки связи между папками.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddDependency.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/RoseClassDependencyImpl.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractClassDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "boost/lexical_cast.hpp"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumpFactory.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractCategoryDumper.h"
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AddDependency::AddDependency (const FactoriesID::Get& factory_id)
//#UC START# *4B1E34DF019C_4B1E39E50301_4A2E004702C6_BASE_INIT*
//#UC END# *4B1E34DF019C_4B1E39E50301_4A2E004702C6_BASE_INIT*
{
	//#UC START# *4B1E34DF019C_4B1E39E50301_4A2E004702C6_BODY*
	//#UC END# *4B1E34DF019C_4B1E39E50301_4A2E004702C6_BODY*
}

AddDependency::AddDependency (const FactoriesID::Make& factory_id)
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2E004702C6_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2E004702C6_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2E004702C6_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2E004702C6_BODY*
}

AddDependency::~AddDependency () {
	//#UC START# *4A2E004702C6_DESTR_BODY*
	//#UC END# *4A2E004702C6_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// создает связь зависимости между классами
void AddDependency::create_dep_for_class (
	const RoseAbstractClassDumper* source
	, const RoseAbstractClassDumper* target
	, const std::string& guid_suffix
	, const std::string& name
	, const std::string& stereotype
	, const std::string& var_id
	, const AbstractDumperBase* context
) const {
	//#UC START# *4A4DE56600CA*
	std::string guid  (this->make_uid (source, "", guid_suffix));
	ATL::CComObject<RoseInternal::RoseClassDependencyImpl>* obj;
	obj->CreateInstance (&obj);
	IRoseClassDependencyPtr dep;
	obj->QueryInterface (&dep);
	
	obj->set_unique_id (guid);
	obj->set_stereotype (stereotype);
	obj->set_name (name);
	obj->set_context (source->cls ());
	obj->set_target_class (target->cls ());

	Core::Aptr<RoseAbstractDumpFactory> df = new RoseAbstractDumpFactory;
	RoseAbstractDumper::set_dumper_factory (df.in());

	RoseAbstractDumper* new_dep = df->create_by_stereotype (source, dep);
	if (new_dep) {
		
		RoseAbstractDumper::add_virtual_dumper (new_dep, context);
		new_dep->link_all_suppliers ();
		TemplatePainter::set_var_dumper (var_id, new_dep);
		source->set_var_dumper (guid_suffix, new_dep);
	} else {
		throw Base::FatalError ("Creation virtual ClassDependency failed");
	}
	
	//#UC END# *4A4DE56600CA*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from AddDependencyLocal
// создает зависимость между элементами (НЕ классами)
void AddDependency::create_dep_for_others (const AbstractDumper* source, const AbstractDumper* target) const {
	//#UC START# *4B1E3A430308_4A2E004702C6*
	
	//проверяем, что ещё нет такой связи
	if (!source->is_supplier_with_stereotype (target, ST_LINK_DEP)) {
		const_cast<AbstractDumper*> (source)->add_supplier (
			target, ObjectTreeResolver::ST_NOT_NAVIGABLE, ST_LINK_DEP
		);

		AbstractDumper::add_virtual_relation (
			source
			, target
			, ObjectTreeResolver::ST_NOT_NAVIGABLE
			, ST_LINK_DEP
		);
	}
	//#UC END# *4B1E3A430308_4A2E004702C6*
}

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string AddDependency::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4A2E004702C6*
	if (params.size () < 1 || (params.size () > 1 && params.size () < 4)) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, 5, params.size ());
	}

	std::string target;
	if (params.size () == 1) {
		target = TemplatePainter::resolve_exp (params[0], painter);
	} else {
		target = TemplatePainter::resolve_exp (params[1], painter);
	}

	const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*> (self);
	if (rad) {
		IRoseItemPtr item = rad->rose_element ();
		if (item) {			
			const RoseAbstractDumper* target_rad = RoseAbstractDumper::find_in_tree (target);
			
			bool is_class_dependecy = !(params.size () == 1);
			if (!target_rad) {
				if (is_class_dependecy) {
					target_rad = rad->resolve (target);
				} else {
					Core::Aptr<ObjectTreeResolver::OTRVector> elems = RoseAbstractDumper::find_by_name (target);
					if (elems.ptr () && !elems->empty ()) {
						if (elems->size () == 1) {
							target_rad = dynamic_cast<const RoseAbstractDumper*>((*elems)[0]);
						} else {
							throw Base::FatalError (
								std::string ("Найдено более одного элемента для простановки связи зависимости: ")
								+ target
							);
						}
					}
				}
				if (!target_rad) {
					throw Base::FatalError (
						std::string ("Не удалось найти элемент для простановки связи зависимости: ")
						+ target
					);
				}
			}
			
			if (!is_class_dependecy) { //связь между элементами, не классами!!!
				this->create_dep_for_others (rad, target_rad);
				painter->invalidate_dumpers_list (SX_3_DEPENDENCES, rad);
				painter->invalidate_dumpers_list (SX_3_REQURSIVE_DEPENDENCES, rad);
			} else {
				const RoseAbstractClassDumper* source = dynamic_cast<const RoseAbstractClassDumper*> (rad);
				const RoseAbstractClassDumper* target = dynamic_cast<const RoseAbstractClassDumper*> (target_rad);
				if (!source || !target) {
					throw Base::FatalError ("Исходный элемент и целевой должны быть классами!");
				}
				std::string guid_suffix = TemplatePainter::resolve_exp (params[0], painter);
								
				std::string stereotype = TemplatePainter::resolve_exp (params[2], painter);
				std::string name = TemplatePainter::resolve_exp (params[3], painter);
				std::string var_id = TemplatePainter::resolve_exp (params[4], painter);

				this->create_dep_for_class (source, target, guid_suffix, name, stereotype, var_id, painter->get_main_scope ());

				painter->invalidate_dumpers_list (SX_3_CONTENTS, source);
				painter->invalidate_dumpers_list (SX_3_ALL_CONTENTS, source);
			}
		}
	}

	return std::string ();
	//#UC END# *4A2DFD7B0291_4A2E004702C6*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

