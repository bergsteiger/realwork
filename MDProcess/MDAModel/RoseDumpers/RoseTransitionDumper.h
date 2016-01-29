////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseTransitionDumper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseTransitionDumper
//
// ������ ��������� ����� �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSETRANSITIONDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSETRANSITIONDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractElementDumper.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"

//#UC START# *465E55840157_CUSTOM_INCLUDES*
//#UC END# *465E55840157_CUSTOM_INCLUDES*


// ������ ��������� ����� �����������
class RoseTransitionDumper;
typedef Core::Var<RoseTransitionDumper> RoseTransitionDumper_var;
typedef Core::Var<const RoseTransitionDumper> RoseTransitionDumper_cvar;

class RoseTransitionDumper :
	public RoseAbstractElementDumper
{
	SET_OBJECT_COUNTER (RoseTransitionDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// init cotr
	RoseTransitionDumper (const RoseAbstractDumper* parent, IRoseTransitionPtr item);

public:
	virtual ~RoseTransitionDumper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ���������� ������ - �������
	virtual IRoseTransitionPtr transition () const;


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


//#UC START# *465E55840157*	
//#UC END# *465E55840157*
}; // class RoseTransitionDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSETRANSITIONDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

