////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseCategory.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseCategory
//
// папка
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSECATEGORY_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSECATEGORY_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseInternal/RoseItem.h"

namespace RoseInternal {

// папка
class RoseCategory :
	virtual public RoseItem
{
	SET_OBJECT_COUNTER (RoseCategory)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	RoseCategory ();

public:
	virtual ~RoseCategory ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual bool is_controlled () const;

	virtual bool is_modiable () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	IRoseCategoryCollectionPtr m_categories;

	IRoseClassDiagramCollectionPtr m_class_diagrams;

	IRoseClassCollectionPtr m_classes;

	IRoseCategoryDependencyCollectionPtr m_dependecies;

	bool m_global;

	IRoseScenarioDiagramCollectionPtr m_scenario_diagrams;

	IRoseStateMachineOwnerPtr m_state_machine_owner;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	IRoseCategoryCollectionPtr get_categories () const;

	IRoseClassDiagramCollectionPtr get_class_diagrams () const;

	IRoseClassCollectionPtr get_classes () const;

	IRoseCategoryDependencyCollectionPtr get_dependecies () const;

	bool get_global () const;

	void set_global (bool global);

	IRoseCategoryPtr get_parent_category () const;

	IRoseScenarioDiagramCollectionPtr get_scenario_diagrams () const;

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

}; // class RoseCategory

} // namespace RoseInternal


#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSECATEGORY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

