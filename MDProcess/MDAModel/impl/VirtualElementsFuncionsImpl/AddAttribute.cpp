////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddAttribute.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddAttribute
//
// %S%f_add_attribute(<GUID нового элемента>, <стереотип>,<сигнатура атрибута>,<имя переменной>) -
// аналогично _add_operation, но создается новый атрибут, значение по-умолчанию может быть задано
// ГУИДом реального элемента либо просто строкой (аналогично типу).
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddAttribute.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/RoseAttributeImpl.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumpFactory.h"
#include "boost/lexical_cast.hpp"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/Parsers/Parsers.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualFunctionsHelper.h"
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AddAttribute::AddAttribute ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2DFF9E0013_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2DFF9E0013_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2DFF9E0013_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2DFF9E0013_BODY*
}

AddAttribute::~AddAttribute () {
	//#UC START# *4A2DFF9E0013_DESTR_BODY*
	//#UC END# *4A2DFF9E0013_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string AddAttribute::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4A2DFF9E0013*
	if (params.size () < 4) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 4, params.size ());
	}
	const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*> (self);
	if (rad) {
		std::string guid_suffix = TemplatePainter::resolve_exp (params[0], painter);
		std::string guid (this->make_uid (rad, "", guid_suffix));

		std::string stereotype = TemplatePainter::resolve_exp (params[1], painter);
		std::string signature = TemplatePainter::resolve_exp (params[2], painter);		
		std::string var_id = TemplatePainter::resolve_exp (params[3], painter);

		ATL::CComObject<RoseInternal::RoseAttributeImpl>* obj;
		obj->CreateInstance (&obj);
		IRoseAttributePtr attr;
		obj->QueryInterface (&attr);

		IRoseItemPtr item = rad->rose_element ();
		if (item) {
			obj->set_unique_id (guid);
			obj->set_context (item);
			obj->set_stereotype (stereotype);

			try {
				Core::Aptr<Parsers::AttributeData> data = Parsers::AttributeParserFactory::get ().parse (signature);
								
				obj->set_name (data->name);
				obj->set_init_value (data->init_value);
				RoseAbstractDumper* target_rad = RoseAbstractDumper::find_in_tree (data->type);
				if (target_rad) {
					obj->set_target_class (target_rad->rose_element ());
				} else {
					obj->set_target (data->type);
				}

				IRoseClassPtr cls = obj->get_target_class ();
				if (cls) {
					TypeLinkHelperFactory::get ().link (attr, get_rose_element_uid (cls));
				}
			} catch (Parsers::ParseError& ex) {
				throw Base::FatalError (ex.what ());
			}			

			RoseHelper::set_default_abstraction_type (attr);

			Core::Aptr<RoseAbstractDumpFactory> df = new RoseAbstractDumpFactory;
			RoseAbstractDumper::set_dumper_factory (df.in());

			RoseAbstractDumper* new_attr = df->create_by_stereotype (rad, attr);
			if (new_attr) {
				painter->invalidate_dumpers_list (SX_3_CONTENTS, rad);
				painter->invalidate_dumpers_list (SX_3_ALL_CONTENTS, rad);

				RoseAbstractDumper::add_virtual_dumper (new_attr, painter->get_main_scope ());
				new_attr->link_all_suppliers ();				

				std::string link_type = new_attr->get_link_type_str ();
				if (link_type == "agr" || link_type == "ref") {
					const AbstractDumper* target = dynamic_cast<const AbstractDumper*> (new_attr->get_target ());
					if (target) {
						VirtualFunctionsHelper::run_spell_with_suppliers (target);
					}
				}

				TemplatePainter::set_var_dumper (var_id, new_attr);
				rad->set_var_dumper (guid_suffix, new_attr);
			} else {
				throw Base::FatalError ("Creation virtual Attribute failed");
			}
		}
	}

	return std::string ();
	//#UC END# *4A2DFD7B0291_4A2DFF9E0013*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

