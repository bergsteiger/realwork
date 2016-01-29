////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualFunctionsHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::VirtualFunctionsHelper
//
// набор вспомогательных функций
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualFunctionsHelper.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/AbstractDumpers/ObjectTreeResolver.h"
// by <<friend>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
// local helpers
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualFunctionsHelper.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// запускает генерацию spell'а для элемента, предварительно вызывая spell на элементах, кот которых
// он "жестко" зависит
void VirtualFunctionsHelper::run_spell_with_suppliers (const AbstractDumper* elem) {
	//#UC START# *4B34BCC7018D*
	ObjectTreeResolver::OTRVector suppliers;
	elem->collect_suppliers_by_type_recursive (ObjectTreeResolver::ST_NAVIGABLE, suppliers);
	
	std::string tmp_map = AbstractDumperBase::s_current_map;
	AbstractDumperBase::s_current_map = AbstractDumperBase::SPELL_GENERATOR_ID;

	for (
		ObjectTreeResolver::OTRVector::reverse_iterator it = suppliers.rbegin ()
		; it != suppliers.rend ()
		; ++it
	) {
		const AbstractDumperBase* adb = dynamic_cast<const AbstractDumperBase*> (*it);
		GDS_ASSERT(adb);
		adb->dump ();
	}
	
	elem->dump ();

	AbstractDumperBase::s_current_map = tmp_map;
	//#UC END# *4B34BCC7018D*
}

} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

