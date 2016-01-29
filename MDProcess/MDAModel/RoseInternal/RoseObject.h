////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseObject.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEOBJECT_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEOBJECT_H__

#include "shared/CoreSrv/sys/std_inc.h"

//#UC START# *4A2F952100C7_CUSTOM_INCLUDES*
#include "shared/Core/fix/win_afx.h"
#include "boost/function.hpp"
#include "boost/bind.hpp"
//#include "MDProcess/MDAModel/RoseInternal/DispatchHelper.h"
//#UC END# *4A2F952100C7_CUSTOM_INCLUDES*

namespace RoseInternal {

class RoseObject {
	SET_OBJECT_COUNTER (RoseObject)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseObject ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual HRESULT dispatch (
		DISPID id
		, REFIID riid
		, LCID lcid
		, WORD flags
		, DISPPARAMS* params
		, VARIANT* result
		, LPEXCEPINFO exp_info
		, PUINT arg_err
	);

	virtual const std::string identify_class ();

	// приведение
	virtual VARIANT_BOOL is_class (const std::string& class_name);


//#UC START# *4A2F952100C7*
//#UC END# *4A2F952100C7*
}; // class RoseObject

} // namespace RoseInternal


#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEOBJECT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

