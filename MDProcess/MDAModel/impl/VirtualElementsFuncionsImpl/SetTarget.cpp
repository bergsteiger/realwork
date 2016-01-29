////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetTarget.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetTarget
//
// Установить элементу (операции, параметру, атрибуту)  новый тип
// %S%f_set_target(<УИД/имя элемента или пусто (в случае void)>)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetTarget.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseInternal/RoseTargetItem.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

SetTarget::SetTarget ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4AE6E99C03B2_BASE_INIT*
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4AE6E99C03B2_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4AE6E99C03B2_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4AE6E99C03B2_BODY*
}

SetTarget::~SetTarget () {
	//#UC START# *4AE6E99C03B2_DESTR_BODY*
	//#UC END# *4AE6E99C03B2_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
// Собственно реализации встроенной функции. Каждый конкретный сервант реализует это метод
const std::string SetTarget::execute_impl (
	const AbstractDumperBase* self
	, const TemplateFunctions::FunctionParams& params
	, TemplatePainter* painter
) const /*throw (
	TemplateFunctions::BadParams
)*/ {
	//#UC START# *4A2DFD7B0291_4AE6E99C03B2*
	RoseAbstractDumper* rad = const_cast<RoseAbstractDumper*> (dynamic_cast<const RoseAbstractDumper*> (self));
	if (rad) {
		IRoseElementPtr item = rad->rose_element ();
		if (item) {
			std::string new_type_guid;
			if (params.size () > 0) {
				new_type_guid = TemplatePainter::resolve_exp (params[0], painter);
			}
			
			const RoseAbstractDumper* target_rad = RoseAbstractDumper::find_in_tree (new_type_guid);
			if (!target_rad) {
				target_rad = rad->resolve (new_type_guid);
			}

			if (!target_rad) {
				throw Base::FatalError (
					std::string("Не могу найти связанный тип \"") 
					+ new_type_guid
					+ std::string ("\" в области видимости")
				);
			}

			AbstractDumperBase* old_target = rad->get_target ();
			AbstractDumper* old_target_ad = old_target != 0 ? dynamic_cast<AbstractDumper*> (old_target) : 0;
			
			ObjectTreeResolver::SupplierType type = ObjectTreeResolver::ST_NOT_NAVIGABLE;
			std::string link_type = rad->get_link_type_str ();
			if (link_type == "agr" || link_type == "ref") {
				type = ObjectTreeResolver::ST_NAVIGABLE;
			}

			if (old_target_ad) {
				rad->remove_supplier (old_target_ad, type, ST_TARGET);

				if (!IsVirtualFactory::get ().execute (rad->rose_element ())) {
					//ДЛЯ НЕВИРТУАЛЬНЫХ ЭЛЕМЕНТОВ НУЖНО ПЕРЕД НАЧАЛОМ 
					//СЛЕДУЮЩЕГО ЗАПУСКА SPELL'а ВОССТАНАВЛИВАТЬ ЭТУ СВЯЗЬ!!!!

					bool has_rel_for_restore = false;
					const AbstractDumper::RelationsSet& rels = AbstractDumper::get_relations_for_restore();
					for (
						AbstractDumper::RelationsSet::const_iterator it = rels.begin ()
						; it != rels.end () && !has_rel_for_restore
						; ++it
					) {
						if (it->source == rad && it->stereotype == ST_TARGET) {
							has_rel_for_restore = true;
						}
					}
					
					if (!has_rel_for_restore) {
						//если еще не было информации для восстановления связи для таргета - добавляем
						//проверка нужно, для случая, когда несколько раз позвали set_target - 
						//в этом случае нужно добавить только одну связь для восстановления
						AbstractDumper::add_relation_for_restore (
							rad
							, old_target_ad
							, type
							, ST_TARGET
						);
					}
				}
			}

			rad->add_supplier (
				target_rad
				, type
				, ST_TARGET
			);

			AbstractDumper::add_virtual_relation (
				rad
				, target_rad
				, type
				, ST_TARGET
			);
		}
	}
	return std::string ();
	//#UC END# *4A2DFD7B0291_4AE6E99C03B2*
}
} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

