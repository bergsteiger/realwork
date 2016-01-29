////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseParameter.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseParameter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEPARAMETER_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEPARAMETER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseInternal/RoseTargetItem.h"

namespace RoseInternal {

class RoseParameter :
	virtual public RoseTargetItem
{
	SET_OBJECT_COUNTER (RoseParameter)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseParameter ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	std::string m_initial_value;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	const std::string& get_initial_value () const;

	void set_initial_value (const std::string& initial_value);


//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from RoseItem
	virtual IRoseItemPtr get_context () const;

	virtual void set_context (IRoseItemPtr context)
		/*throw (RoseItem::WrongContext)*/;

	// overloaded method from RoseItem
	virtual const std::string& get_stereotype () const;

	virtual void set_stereotype (const std::string& stereotype);

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

}; // class RoseParameter

} // namespace RoseInternal


#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEPARAMETER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

