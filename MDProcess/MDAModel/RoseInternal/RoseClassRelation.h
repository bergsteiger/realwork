////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseClassRelation.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseClassRelation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSECLASSRELATION_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSECLASSRELATION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseInternal/RoseTargetItem.h"

namespace RoseInternal {

class RoseClassRelation :
	virtual public RoseTargetItem
{
	SET_OBJECT_COUNTER (RoseClassRelation)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseClassRelation ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual IRoseClassPtr get_context_class () const;

	virtual IRoseClassPtr get_supplier_class () const;

	virtual bool has_client () const;

	virtual bool has_supplier () const;



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

}; // class RoseClassRelation

} // namespace RoseInternal


#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSECLASSRELATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

