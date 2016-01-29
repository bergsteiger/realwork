////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseEventDumper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseEventDumper
//
// ������ ��� IRoseEvent
// �������������� get_initial_value � � �������� ��������� ����������
// �������� GuardCondition � IRoseEvent
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEEVENTDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEEVENTDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"


// ������ ��� IRoseEvent
// �������������� get_initial_value � � �������� ��������� ����������
// �������� GuardCondition � IRoseEvent
class RoseEventDumper;
typedef Core::Var<RoseEventDumper> RoseEventDumper_var;
typedef Core::Var<const RoseEventDumper> RoseEventDumper_cvar;

class RoseEventDumper :
	public RoseAbstractDumper
{
	SET_OBJECT_COUNTER (RoseEventDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// �����������
	RoseEventDumper (const RoseAbstractDumper* parent, IRoseElementPtr item);

public:
	virtual ~RoseEventDumper ();


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
	// �������� �� ��������� (��� ��������� � ���������� ��������)
	virtual const std::string get_initial_value_str () const;

	// overloaded method from ObjectTreeResolver
	// ��������� � ��������� ���� supplier
	virtual void link_suppliers ();

}; // class RoseEventDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEEVENTDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

