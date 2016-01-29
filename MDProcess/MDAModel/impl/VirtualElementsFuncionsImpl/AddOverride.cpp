////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOverride.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddOverride
//
// %S%f_add_override(<GUID операции>) - добавляет операцию заданную GUID'ом в список
// переопределяемых операции (%O), при этом операция должна принадлежать одному из базовых
// элементов.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOverride.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"

namespace VirtualElementsFuncionsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AddOverride::AddOverride ()
//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2E01050245_BASE_INIT*
: OverrideImplementBase (std::string (_bstr_t (PROP_DERIVED_OVERLOAD)), SX_3_DERIVED_OVER)
//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2E01050245_BASE_INIT*
{
	//#UC START# *4A2CBB5C0268_4A2CBBD20008_4A2E01050245_BODY*
	//#UC END# *4A2CBB5C0268_4A2CBBD20008_4A2E01050245_BODY*
}

AddOverride::~AddOverride () {
	//#UC START# *4A2E01050245_DESTR_BODY*
	//#UC END# *4A2E01050245_DESTR_BODY*
}


} // namespace VirtualElementsFuncionsImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

