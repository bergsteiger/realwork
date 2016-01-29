////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseAttribute.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseAttribute
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEATTRIBUTE_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEATTRIBUTE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseInternal/RoseTargetItem.h"

namespace RoseInternal {

class RoseAttribute :
	virtual public RoseTargetItem
{
	SET_OBJECT_COUNTER (RoseAttribute)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	RoseAttribute ();

public:
	virtual ~RoseAttribute ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	IRoseRichTypePtr m_contaiment;

	std::string m_init_value;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	virtual IRoseRichTypePtr get_contaiment () const;

	virtual void set_contaiment (IRoseRichTypePtr contaiment);

	const std::string& get_init_value () const;

	void set_init_value (const std::string& init_value);

	IRoseClassPtr get_parent_class () const;


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

}; // class RoseAttribute

} // namespace RoseInternal


#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSEATTRIBUTE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

