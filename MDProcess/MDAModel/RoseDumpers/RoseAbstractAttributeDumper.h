////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractAttributeDumper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractAttributeDumper
//
// ������ ��� ��������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTATTRIBUTEDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTATTRIBUTEDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractElementDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseInitialValue.h"

//#UC START# *4571DF1E00CB_CUSTOM_INCLUDES*
//#UC END# *4571DF1E00CB_CUSTOM_INCLUDES*


// ������ ��� ��������� ���������
class RoseAbstractAttributeDumper;
typedef Core::Var<RoseAbstractAttributeDumper> RoseAbstractAttributeDumper_var;
typedef Core::Var<const RoseAbstractAttributeDumper> RoseAbstractAttributeDumper_cvar;

class RoseAbstractAttributeDumper :
	public RoseAbstractElementDumper
{
	SET_OBJECT_COUNTER (RoseAbstractAttributeDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseAbstractAttributeDumper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// �������� ��-���������
	RoseInitialValue_var m_init_value;

	// ��� ����� �� ��������
	mutable std::string m_link_type;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	const std::string& get_link_type () const;

	void set_link_type (const std::string& link_type) const;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from AbstractDumperBase
	// ���������� �����
	virtual const std::string get_model_class_str () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from AbstractDumperBase
	// ���������� ������ ��� ������ �������� ��-���������
	virtual AbstractDumperBase* get_initial_value () const;

	// overloaded method from AbstractDumperBase
	// �������� �� ��������� (��� ��������� � ���������� ��������)
	virtual const std::string get_initial_value_str () const;

	// overloaded method from AbstractDumperBase
	// agr/lnk/ref - ��� ����� ���������, �� ������ � ��������� (Var ��� Box), �� ���������
	virtual const std::string get_link_type_str () const;

	// overloaded method from AbstractDumperBase
	// ���������� ��������� ��������
	virtual const std::string get_stereotype_str () const;

	// overloaded method from ObjectTreeResolver
	// ��������� � ��������� ���� supplier
	virtual void link_suppliers ();

	// overloaded method from RoseAbstractDumper
	// ����� ����������, ����� ����� ��������, �������������� �� ������� �������� ���������
	virtual void update_cached_attrs () const;


//#UC START# *4571DF1E00CB*
public:
	RoseAbstractAttributeDumper (const RoseAbstractDumper* parent, IRoseItemPtr attr, const AbstractDumperBase::StereotypeID& st );

protected:
	bool m_is_rl_attr;
	
	IRoseAttributePtr attr () const;
	IRoseRolePtr rl_attr () const;
	IRoseClassPtr parent_cls () const;
//#UC END# *4571DF1E00CB*
}; // class RoseAbstractAttributeDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTATTRIBUTEDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

