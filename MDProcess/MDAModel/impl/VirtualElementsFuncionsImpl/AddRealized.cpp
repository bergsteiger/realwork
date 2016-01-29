////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddRealized.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddRealized
//
// %S%f_add_realized(<ГУИД реального элемента или просто имя>, <прозрачность - true | false>) -
// добавляет в список реализуемых элементов элемент, соответствующий гуиду, если задан не ГУИД, а
// просто имя класса - находит в дереве элемент с таким именем и добавляет его, если установлена
// прозрачность связи, то для нее не будут выполняться проверки доступности и видимость, а также,
// такая связь не будет учитываться в графе зависимости
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddRealized.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"
#include "MDProcess/MDAModel/RoseInternal/RoseRealizeRelationImpl.h"
#include "MDProcess/MDAModel/RoseInternal/RoseClass.h"
#include "boost/lexical_cast.hpp"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualFunctionsHelper.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AddRealized::AddRealized ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2DFDB80019_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2DFDB80019_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2DFDB80019_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2DFDB80019_BODY*
}

AddRealized::~AddRealized () {
	//#UC START# *4A2DFDB80019_DESTR_BODY*
	//#UC END# *4A2DFDB80019_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string AddRealized::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4A2DFDB80019*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	
	RoseAbstractDumper* rad = const_cast<RoseAbstractDumper*> (dynamic_cast<const RoseAbstractDumper*> (self));
	if (rad) {
		std::string target = TemplatePainter::resolve_exp (params[0], painter);		

		IRoseItemPtr item = rad->rose_element ();
		if (item) {
			const RoseAbstractDumper* target_rad = RoseAbstractDumper::find_in_tree (target);

			if (!target_rad) {
				target_rad = rad->resolve (target);
				if (!target_rad) {
					throw Base::FatalError (
						std::string ("Не удалось найти элемент для простановки связи реализации: ")
						+ target
					);
				}
			}
			

			RoseInternal::RoseClass* virtual_cls = item.GetInterfacePtr () 
				? dynamic_cast<RoseInternal::RoseClass*> (item.GetInterfacePtr ()) 
				: 0;
			if (virtual_cls) {
				//если элемент виртуальный - нужно добавить новую связь:
				ATL::CComObject<RoseInternal::RoseRealizeRelationImpl>* obj;
				obj->CreateInstance (&obj);
				IRoseRealizeRelationPtr rel;
				obj->QueryInterface (&rel);

				obj->set_context (item);

				std::string rel_guid (virtual_cls->get_unique_id ());
				short count = virtual_cls->get_realize_relations ()->Count;
				
				rel_guid += std::string ("VREALIZE_REL") + boost::lexical_cast<std::string> (count + 1);
				obj->set_unique_id (rel_guid);
				obj->set_target_class (target_rad->rose_element ());

				virtual_cls->add_realize_relation (rel);
			}
			
			if (!rad->is_supplier_with_stereotype (target_rad, ST_LINK_REL)) {
				bool is_transparent = false;
				if (params.size () > 1) {
					std::string transparent_flag = TemplatePainter::resolve_exp (params[1], painter);
					is_transparent = transparent_flag == "true";
				}

				rad->add_supplier_spec (
					target_rad
					, is_transparent ? ObjectTreeResolver::ST_IGNORED : ObjectTreeResolver::ST_NAVIGABLE
					, ST_LINK_REL
					, is_transparent ? false : true
					, is_transparent ? false : true
				);

				painter->invalidate_dumpers_list (SX_3_REALIZATION, rad);
				painter->invalidate_dumpers_list (SX_3_REQURSIVE_REALIZATION, rad);
				painter->invalidate_dumpers_list (SX_3_DERIVED_OVER, rad);
				painter->invalidate_dumpers_list (SX_3_DERIVED_IMPL, rad);
				painter->invalidate_dumpers_list (SX_3_NOT_IMPLEMENTED_DERIVED_ABSTRACT, rad);

				AbstractDumper::add_virtual_relation (
					rad
					, target_rad
					, is_transparent ? ObjectTreeResolver::ST_IGNORED : ObjectTreeResolver::ST_NAVIGABLE
					, ST_LINK_REL
				);

				VirtualFunctionsHelper::run_spell_with_suppliers (target_rad);
			}
		}
	}
	return std::string ();
	//#UC END# *4A2DFD7B0291_4A2DFDB80019*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

