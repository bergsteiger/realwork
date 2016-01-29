////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseClassDependency.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseClassDependency
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RoseClassDependency.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/RoseInternal/DispatchHelper.h"

namespace RoseInternal {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseClassDependency::~RoseClassDependency () {
	//#UC START# *4A35E4740398_DESTR_BODY*
	//#UC END# *4A35E4740398_DESTR_BODY*
}



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

// overloaded method from RoseItem
IRoseItemPtr RoseClassDependency::get_context () const {
	//#UC START# *4A30A6480352_4A35E4740398_GET*
	return RoseTargetItem::get_context ();
	//#UC END# *4A30A6480352_4A35E4740398_GET*
}

void RoseClassDependency::set_context (IRoseItemPtr context)
	/*throw (RoseItem::WrongContext)*/
{
	//#UC START# *4A30A6480352_4A35E4740398_SET*
	if (!context->IsClass (CLASS_TYPE)) {
		throw RoseItem::WrongContext ();
	}
	RoseTargetItem::set_context (context);
	//#UC END# *4A30A6480352_4A35E4740398_SET*
}

// overloaded method from RoseObject
HRESULT RoseClassDependency::dispatch (
	DISPID id
	, REFIID riid
	, LCID lcid
	, WORD flags
	, DISPPARAMS* params
	, VARIANT* result
	, LPEXCEPINFO exp_info
	, PUINT arg_err
) {
	//#UC START# *4A2FA53702AA_4A35E4740398*
	return RoseClassRelation::dispatch (id, riid, lcid, flags, params, result, exp_info, arg_err);
	//#UC END# *4A2FA53702AA_4A35E4740398*
}

// overloaded method from RoseObject
const std::string RoseClassDependency::identify_class () {
	//#UC START# *4A2F96770397_4A35E4740398*
	return CLASS_DEPENDENCY_TYPE;
	//#UC END# *4A2F96770397_4A35E4740398*
}

// overloaded method from RoseObject
// приведение
VARIANT_BOOL RoseClassDependency::is_class (const std::string& class_name) {
	//#UC START# *4A2F954B0069_4A35E4740398*
	return class_name == CLASS_DEPENDENCY_TYPE ? VARIANT_TRUE : RoseTargetItem::is_class (class_name);
	//#UC END# *4A2F954B0069_4A35E4740398*
}

} // namespace RoseInternal

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

