////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseClassDependency.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseClassDependency
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSECLASSDEPENDENCY_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSECLASSDEPENDENCY_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RoseClassRelation.h"

namespace RoseInternal {

class RoseClassDependency :
	virtual public RoseClassRelation
{
	SET_OBJECT_COUNTER (RoseClassDependency)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseClassDependency ();



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from RoseItem
	virtual IRoseItemPtr get_context () const;

	virtual void set_context (IRoseItemPtr context)
		/*throw (RoseItem::WrongContext)*/;

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

}; // class RoseClassDependency

} // namespace RoseInternal


#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSECLASSDEPENDENCY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

