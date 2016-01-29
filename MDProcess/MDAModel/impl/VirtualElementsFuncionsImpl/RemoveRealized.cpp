////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveRealized.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::RemoveRealized
//
// %S%f_remove_realized(<УИД элемента>) - функция удаления связи реализации между текущим элементом
// и элементом, заданным УИД'ом. Если не удалось найти элемент с заданным УИД'ом или с этим
// элементом нет связи реализации - генерируется исключение
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/RemoveRealized.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumper.h"
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RemoveRealized::RemoveRealized ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4AEEAAE90100_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4AEEAAE90100_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4AEEAAE90100_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4AEEAAE90100_BODY*
}

RemoveRealized::~RemoveRealized () {
	//#UC START# *4AEEAAE90100_DESTR_BODY*
	//#UC END# *4AEEAAE90100_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string RemoveRealized::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4AEEAAE90100*
	if (params.size () < 1) {
		throw TemplateFunctions::BadParams (GDS_CURRENT_FUNCTION, 1, params.size ());
	}
	
	RoseAbstractDumper* source = const_cast<RoseAbstractDumper*> (dynamic_cast<const RoseAbstractDumper*> (self));
	IRoseClassPtr cls = source->rose_element ();
	if (source && cls) {
		std::string uid = TemplatePainter::resolve_exp(params[0], painter);
		RoseAbstractDumper* target = RoseAbstractDumper::find_in_tree (uid);
		if (target) {
			//тут намеренно используем модель, а не дерево генерации, т.к
			//виртуальные связи наследования и реализации все равно должны были быть добавлены
			//в модель для корректной работы
			IRoseRealizeRelationCollectionPtr realizations = cls->GetRealizeRelations ();
			short realizations_count = realizations->Count;

			IRoseRealizeRelationPtr founded_rel;
			for (short i = 0; i < realizations_count; ++i) {
				IRoseRealizeRelationPtr rel = realizations->GetAt (i);
				
				IRoseItemPtr supplier = rel->GetSupplier ();
				std::string supplier_guid (get_rose_element_uid(supplier));
				if (supplier_guid == uid) {
					founded_rel = rel;
					break;
				}
			}
			
			if (founded_rel) {
				if (IsVirtualFactory::get ().execute (cls)) {
					cls->DeleteRealizeRel (founded_rel);
				}

				source->remove_supplier (target, ObjectTreeResolver::ST_NAVIGABLE, ST_LINK_REL);
				painter->invalidate_dumpers_list (SX_3_REALIZATION, source);
				painter->invalidate_dumpers_list (SX_3_REQURSIVE_REALIZATION, source);
				painter->invalidate_dumpers_list (SX_3_DERIVED_OVER, source);
				painter->invalidate_dumpers_list (SX_3_DERIVED_IMPL, source);
				painter->invalidate_dumpers_list (SX_3_NOT_IMPLEMENTED_DERIVED_ABSTRACT, source);
			} else {
				throw Base::FatalError (
					"Не удалось найти связь наследования между элементом \""
					+ (static_cast<const Base::NamedElement*> (source))->get_full_name ()
					+ "\" и \""
					+ (static_cast<const Base::NamedElement*> (target))->get_full_name ()
				);
			}			
		} else {
			throw Base::FatalError ("Не удалось найти элемент с идентификатором: " + uid);
		}
	}

	return std::string ();
	//#UC END# *4A2DFD7B0291_4AEEAAE90100*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

