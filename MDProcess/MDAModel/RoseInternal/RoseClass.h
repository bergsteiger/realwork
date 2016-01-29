////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseClass.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseInternal::RoseClass
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSECLASS_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSECLASS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseInternal/RoseItem.h"

namespace RoseInternal {

class RoseClass :
	virtual public RoseItem
{
	SET_OBJECT_COUNTER (RoseClass)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	RoseClass ();

public:
	virtual ~RoseClass ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual void add_inherit_relation (IRoseInheritRelationPtr rel);

	virtual void add_realize_relation (IRoseRealizeRelationPtr rel);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	IRoseRoleCollectionPtr m_accociate_roles;

	IRoseAssociationCollectionPtr m_associations;

	IRoseAttributeCollectionPtr m_attributes;

	IRoseRichTypePtr m_class_kind;

	IRoseClassDependencyCollectionPtr m_dependecies;

	IRoseInheritRelationCollectionPtr m_inherite_relations;

	bool m_is_abstract;

	IRoseClassCollectionPtr m_nested_classes;

	IRoseOperationCollectionPtr m_operations;

	IRoseParameterCollectionPtr m_parameters;

	IRoseRealizeRelationCollectionPtr m_realize_relations;

	IRoseStateMachineOwnerPtr m_state_machine_owner;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	IRoseRoleCollectionPtr get_accociate_roles () const;

	IRoseAssociationCollectionPtr get_associations () const;

	IRoseAttributeCollectionPtr get_attributes () const;

	IRoseRichTypePtr get_class_kind () const;

	void set_class_kind (IRoseRichTypePtr class_kind);

	IRoseClassDependencyCollectionPtr get_dependecies () const;

	IRoseInheritRelationCollectionPtr get_inherite_relations () const;

	bool get_is_abstract () const;

	void set_is_abstract (bool is_abstract);

	IRoseClassCollectionPtr get_nested_classes () const;

	IRoseOperationCollectionPtr get_operations () const;

	IRoseParameterCollectionPtr get_parameters () const;

	void set_parameters (IRoseParameterCollectionPtr parameters);

	IRoseCategoryPtr get_parent_category () const;

	IRoseRealizeRelationCollectionPtr get_realize_relations () const;

	IRoseStateMachineOwnerPtr get_state_machine_owner () const;


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

}; // class RoseClass

} // namespace RoseInternal


#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSECLASS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

