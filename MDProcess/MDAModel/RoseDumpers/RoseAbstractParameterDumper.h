////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractParameterDumper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractParameterDumper
//
// ������ ��� ��������� ���������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTPARAMETERDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTPARAMETERDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractElementDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseInitialValue.h"

//#UC START# *4571DF8401B5_CUSTOM_INCLUDES*
//#UC END# *4571DF8401B5_CUSTOM_INCLUDES*


// ������ ��� ��������� ���������� ��������
class RoseAbstractParameterDumper;
typedef Core::Var<RoseAbstractParameterDumper> RoseAbstractParameterDumper_var;
typedef Core::Var<const RoseAbstractParameterDumper> RoseAbstractParameterDumper_cvar;

class RoseAbstractParameterDumper :
	public RoseAbstractElementDumper
{
	SET_OBJECT_COUNTER (RoseAbstractParameterDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseAbstractParameterDumper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// �������� ��-���������
	RoseInitialValue_var m_init_value;

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
	// ���������� ���
	virtual const std::string get_name_str () const;

	// overloaded method from AbstractDumperBase
	// ���������� ��������� ��������
	virtual const std::string get_stereotype_str () const;

	// overloaded method from ObjectTreeResolver
	// ��������� � ��������� ���� supplier
	virtual void link_suppliers ();


//#UC START# *4571DF8401B5*
public:
	RoseAbstractParameterDumper (const RoseAbstractDumper* parent, IRoseParameterPtr attr, const AbstractDumperBase::StereotypeID& st);

protected:
	IRoseClassPtr parent_cls () const;
	IRoseOperationPtr parent_op () const;
	IRoseParameterPtr par () const;
//#UC END# *4571DF8401B5*
}; // class RoseAbstractParameterDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTPARAMETERDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

