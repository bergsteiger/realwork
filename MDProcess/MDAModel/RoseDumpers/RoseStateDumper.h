////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseStateDumper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseStateDumper
//
// ������ ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSESTATEDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSESTATEDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"

//#UC START# *465E55270157_CUSTOM_INCLUDES*
//#UC END# *465E55270157_CUSTOM_INCLUDES*


// ������ ���������
class RoseStateDumper;
typedef Core::Var<RoseStateDumper> RoseStateDumper_var;
typedef Core::Var<const RoseStateDumper> RoseStateDumper_cvar;

class RoseStateDumper :
	public RoseAbstractDumper
{
	SET_OBJECT_COUNTER (RoseStateDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// init ctor
	RoseStateDumper (const RoseAbstractDumper* parent, IRoseStatePtr state);

public:
	virtual ~RoseStateDumper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ���������� ������ - State
	virtual IRoseStatePtr state () const;


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
	// ��� ��������
	virtual const std::string get_class_kind_str () const;


//#UC START# *465E55270157*	
//#UC END# *465E55270157*
}; // class RoseStateDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSESTATEDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

