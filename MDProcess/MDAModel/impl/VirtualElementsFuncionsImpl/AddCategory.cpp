////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddCategory.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddCategory
//
// %S%f_add_category(«UID»,«стереотип»,«имя»,«переменная») - добавляет папку к текущему элементу и
// записывает её в переменную. Пример использования:
// {code}
// %S%f_add_category(_UID_SUFFIX,Test,Unit,CAT)  - создается папка со стереотипом Unit, именем Test
// {code}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddCategory.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/RoseCategoryImpl.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumpFactory.h"
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AddCategory::AddCategory ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A9388FA0110_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A9388FA0110_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A9388FA0110_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A9388FA0110_BODY*
}

AddCategory::~AddCategory () {
	//#UC START# *4A9388FA0110_DESTR_BODY*
	//#UC END# *4A9388FA0110_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string AddCategory::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4A9388FA0110*
	if (params.size () < 4) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 4, params.size ());
	}
	const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*> (self);
	if (rad) {
		if (rad->get_model_class_str () != CATEGORY_TYPE) {
			throw Base::FatalError ("Папку можно создавать только внутри другой папки");
		}

		std::string guid_suffix = TemplatePainter::resolve_exp (params[0], painter);
		std::string guid (this->make_uid (rad, "", guid_suffix));

		std::string stereotype = TemplatePainter::resolve_exp (params[1], painter);
		std::string name = TemplatePainter::resolve_exp (params[2], painter);		
		std::string var_id = TemplatePainter::resolve_exp (params[3], painter);
		
		ATL::CComObject<RoseInternal::RoseCategoryImpl>* obj;
		ATL::CComObject<RoseInternal::RoseCategoryImpl>::CreateInstance (&obj);
		IRoseCategoryPtr cat = obj;

		IRoseItemPtr item = rad->rose_element ();
		if (item) {			
			obj->set_unique_id (guid);
			obj->set_stereotype (stereotype);
			obj->set_name (name);			
			obj->set_context (item);
			
			Core::Aptr<RoseAbstractDumpFactory> df = new RoseAbstractDumpFactory;
			RoseAbstractDumper::set_dumper_factory (df.in());

			RoseAbstractDumper* new_cat = df->create_by_stereotype (rad, cat);
			cat = 0;
			if (new_cat) {
				painter->invalidate_dumpers_list (SX_3_CONTENTS, rad);
				painter->invalidate_dumpers_list (SX_3_ALL_CONTENTS, rad);

				RoseAbstractDumper::add_virtual_dumper (new_cat, painter->get_main_scope ());
				new_cat->link_all_suppliers ();
				TemplatePainter::set_var_dumper (var_id, new_cat);
				rad->set_var_dumper (guid_suffix, new_cat);
			} else {
				throw Base::FatalError ("Creation virtual Category failed");
			}
		}
	}

	return std::string ();
	//#UC END# *4A2DFD7B0291_4A9388FA0110*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

