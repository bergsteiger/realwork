////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveChild.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::RemoveChild
//
// %S%f_remove_child(<УИД элемента>) - функция удаления элемента из дерева генерации - ищет элемент
// с заданным УИД'ом среди детей текущего элемента (%S) если находит - удаляет элемент из дерева,
// если не находит - генерируется исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveChild.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RemoveChild::RemoveChild ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4AEEA95E027A_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4AEEA95E027A_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4AEEA95E027A_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4AEEA95E027A_BODY*
}

RemoveChild::~RemoveChild () {
	//#UC START# *4AEEA95E027A_DESTR_BODY*
	//#UC END# *4AEEA95E027A_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string RemoveChild::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4AEEA95E027A*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	
	const RoseAbstractDumper* parent = dynamic_cast<const RoseAbstractDumper*> (self);
	if (parent) {
		std::string uid = TemplatePainter::resolve_exp(params[0], painter);
		RoseAbstractDumper* child = RoseAbstractDumper::find_in_tree (uid);
		if (child) {
			if (IsVirtualFactory::get ().execute (child->rose_element ())) {
				if (child->is_child_of (parent)) {
					AbstractDumper::delete_virtual_dumper (child);
					painter->invalidate_dumpers_list (SX_3_CONTENTS, parent);
					painter->invalidate_dumpers_list (SX_3_ALL_CONTENTS, parent);
				} else {
					throw Base::FatalError (
						"Элемент \""
						+ (static_cast<const Base::NamedElement*> (child))->get_full_name ()
						+ "\" не является ребенком \""
						+ (static_cast<const Base::NamedElement*> (parent))->get_full_name ()
					);
				}
			} else {
				throw Base::FatalError ("Функция применима только к виртуальным элементам");
			}
		} else {
			throw Base::FatalError ("Не удалось найти элемент с идентификатором: " + uid);
		}
	}

	return std::string ();
	//#UC END# *4A2DFD7B0291_4AEEA95E027A*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

