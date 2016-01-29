////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddClass.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddClass
//
// %S%f_add_class(<GUID нового элемента>,<стереотип>,<имя класса>,<имя переменной>) - создает новый
// элемент - класс с заданным именем и стереотипом, сохраняет его в переменной и добавляет как
// ребенка к текущему элементу
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddClass.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/RoseClassImpl.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractClassDumper.h"
#include "boost/lexical_cast.hpp"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumpFactory.h"
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AddClass::AddClass ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2DFE10037F_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2DFE10037F_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2DFE10037F_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2DFE10037F_BODY*
}

AddClass::~AddClass () {
	//#UC START# *4A2DFE10037F_DESTR_BODY*
	//#UC END# *4A2DFE10037F_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string AddClass::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4A2DFE10037F*
	if (params.size () < 4) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 4, params.size ());
	}
	const RoseAbstractDumper* rad = dynamic_cast<const RoseAbstractDumper*> (self);
	if (rad) {
		std::string guid_suffix = TemplatePainter::resolve_exp (params[0], painter);
		std::string guid (this->make_uid (rad, "", guid_suffix));

		std::string stereotype = TemplatePainter::resolve_exp (params[1], painter);
		std::string name = TemplatePainter::resolve_exp (params[2], painter);		
		std::string var_id = TemplatePainter::resolve_exp (params[3], painter);
		
		ATL::CComObject<RoseInternal::RoseClassImpl>* obj;
		ATL::CComObject<RoseInternal::RoseClassImpl>::CreateInstance (&obj);
		IRoseClassPtr cls = obj;

		IRoseItemPtr item = rad->rose_element ();
		if (item) {			
			obj->set_unique_id (guid);
			obj->set_stereotype (stereotype);
			obj->set_name (name);			
			obj->set_context (item);
			
			Core::Aptr<RoseAbstractDumpFactory> df = new RoseAbstractDumpFactory;
			RoseAbstractDumper::set_dumper_factory (df.in());

			RoseAbstractDumper* new_cls = df->create_by_stereotype (rad, cls);
			cls = 0;
			if (new_cls) {
				painter->invalidate_dumpers_list (SX_3_CONTENTS, rad);
				painter->invalidate_dumpers_list (SX_3_ALL_CONTENTS, rad);

				RoseAbstractDumper::add_virtual_dumper (new_cls, painter->get_main_scope ());
				new_cls->link_all_suppliers ();
				TemplatePainter::set_var_dumper (var_id, new_cls);
				rad->set_var_dumper (guid_suffix, new_cls);
			} else {
				throw Base::FatalError ("Creation virtual Class failed");
			}
		}
	}

	return std::string ();
	//#UC END# *4A2DFD7B0291_4A2DFE10037F*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

