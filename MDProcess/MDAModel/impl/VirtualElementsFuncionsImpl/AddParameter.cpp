////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddParameter.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddParameter
//
// %S%f_add_parameter(<GUID нового элемента>, ,<стереотип>,<сигнатура параметра>,<имя переменной>) -
// аналогично _add_attribute, но создается новый параметр .
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddParameter.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/RoseParameterImpl.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractClassDumper.h"
#include "boost/lexical_cast.hpp"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumpFactory.h"
#include "MDProcess/MDAModel/Parsers/Parsers.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AddParameter::AddParameter ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2DFFC20242_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2DFFC20242_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2DFFC20242_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2DFFC20242_BODY*
}

AddParameter::~AddParameter () {
	//#UC START# *4A2DFFC20242_DESTR_BODY*
	//#UC END# *4A2DFFC20242_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string AddParameter::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4A2DFFC20242*
	static unsigned long s_virtual_param_count = 0;
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

		ATL::CComObject<RoseInternal::RoseParameterImpl>* obj;
		obj->CreateInstance (&obj);
		IRoseParameterPtr par;
		obj->QueryInterface (&par);

		IRoseItemPtr item = rad->rose_element ();
		if (item) {			
			obj->set_unique_id (guid);
			obj->set_context (item);
			
			try {
				Core::Aptr<Parsers::AttributeData> data = Parsers::AttributeParserFactory::get ().parse (signature);
								
				obj->set_name (data->name);
				obj->set_initial_value (data->init_value);
				RoseAbstractDumper* target_rad = RoseAbstractDumper::find_in_tree (data->type);
				if (target_rad) {
					obj->set_target_class (target_rad->rose_element ());
				} else {
					obj->set_target (data->type);
				}
				
				IRoseClassPtr cls = obj->get_target_class ();
				if (cls) {
					TypeLinkHelperFactory::get ().link (par, get_rose_element_uid (cls));
				}

			} catch (Parsers::ParseError& ex) {
				throw Base::FatalError (ex.what ());
			}
			
			
			Core::Aptr<RoseAbstractDumpFactory> df = new RoseAbstractDumpFactory;
			RoseAbstractDumper::set_dumper_factory (df.in());

			RoseAbstractDumper* new_par = df->create_by_stereotype (rad, par);
			if (new_par) {
				painter->invalidate_dumpers_list (SX_3_CONTENTS, rad);
				painter->invalidate_dumpers_list (SX_3_ALL_CONTENTS, rad);

				RoseAbstractDumper::add_virtual_dumper (new_par, painter->get_main_scope ());
				new_par->link_all_suppliers ();
				TemplatePainter::set_var_dumper (var_id, new_par);
				rad->set_var_dumper (guid_suffix, new_par);
			} else {
				throw Base::FatalError ("Creation virtual Parameter failed");
			}
		}
	}

	return std::string ();
	//#UC END# *4A2DFD7B0291_4A2DFFC20242*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

