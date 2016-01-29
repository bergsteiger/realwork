////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseInheritRelation.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseInheritRelation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEINHERITRELATION_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEINHERITRELATION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RoseClassRelation.h"

namespace RoseInternal {

class RoseInheritRelation :
	virtual public RoseClassRelation
{
	SET_OBJECT_COUNTER (RoseInheritRelation)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseInheritRelation ();



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from RoseObject
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

	// overloaded method from RoseObject
	virtual const std::string identify_class ();

	// overloaded method from RoseObject
	// приведение
	virtual VARIANT_BOOL is_class (const std::string& class_name);

}; // class RoseInheritRelation

} // namespace RoseInternal


#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEINHERITRELATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

