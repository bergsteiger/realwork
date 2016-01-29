////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseStateMachineDumper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseStateMachineDumper
//
// ������ ��� IRoseStateMachine
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSESTATEMACHINEDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSESTATEMACHINEDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"


// ������ ��� IRoseStateMachine
class RoseStateMachineDumper;
typedef Core::Var<RoseStateMachineDumper> RoseStateMachineDumper_var;
typedef Core::Var<const RoseStateMachineDumper> RoseStateMachineDumper_cvar;

class RoseStateMachineDumper :
	public RoseAbstractDumper
{
	SET_OBJECT_COUNTER (RoseStateMachineDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// �����������
	RoseStateMachineDumper (const RoseAbstractDumper* parent, IRoseElementPtr item);

public:
	virtual ~RoseStateMachineDumper ();


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from AbstractDumperBase
	// ���������� �����
	virtual const std::string get_model_class_str () const;
}; // class RoseStateMachineDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSESTATEMACHINEDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

