////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseStateDiagramDumper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseStateDiagramDumper
//
// ������ ��������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSESTATEDIAGRAMDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSESTATEDIAGRAMDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseDiagramDumper.h"

//#UC START# *465E5060038A_CUSTOM_INCLUDES*
//#UC END# *465E5060038A_CUSTOM_INCLUDES*


// ������ ��������� ���������
class RoseStateDiagramDumper;
typedef Core::Var<RoseStateDiagramDumper> RoseStateDiagramDumper_var;
typedef Core::Var<const RoseStateDiagramDumper> RoseStateDiagramDumper_cvar;

class RoseStateDiagramDumper :
	public RoseDiagramDumper
{
	SET_OBJECT_COUNTER (RoseStateDiagramDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// init ctor
	RoseStateDiagramDumper (const RoseAbstractDumper* parent, IRoseStateDiagramPtr diag);

public:
	virtual ~RoseStateDiagramDumper ();



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from AbstractDumperBase
	// ���������� �����
	virtual const std::string get_model_class_str () const;


//#UC START# *465E5060038A*
//#UC END# *465E5060038A*
}; // class RoseStateDiagramDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSESTATEDIAGRAMDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

