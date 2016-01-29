////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseOperation.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEOPERATION_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEOPERATION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseInternal/RoseTargetItem.h"

namespace RoseInternal {

class RoseOperation :
	virtual public RoseTargetItem
{
	SET_OBJECT_COUNTER (RoseOperation)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	RoseOperation ();

public:
	virtual ~RoseOperation ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// добавляет параметр в коллекцию
	virtual void add_parameter (IRoseParameterPtr param);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	IRoseParameterCollectionPtr m_parameters;

	IRoseStateMachineOwnerPtr m_state_machine_owner;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	IRoseParameterCollectionPtr get_parameters () const;

	void set_parameters (IRoseParameterCollectionPtr parameters);

	IRoseClassPtr get_parent_class () const;

	IRoseStateMachineOwnerPtr get_state_machine_owner () const;


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

}; // class RoseOperation

} // namespace RoseInternal


#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

