////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseSequenceObject.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseSequenceObject
//
// ������ ��������� �������� ������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSESEQUENCEOBJECT_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSESEQUENCEOBJECT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractSequenceObject.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"

//#UC START# *4571D2F502EE_CUSTOM_INCLUDES*
//#UC END# *4571D2F502EE_CUSTOM_INCLUDES*


// ������ ��������� �������� ������� ��������
class RoseSequenceObject;
typedef Core::Var<RoseSequenceObject> RoseSequenceObject_var;
typedef Core::Var<const RoseSequenceObject> RoseSequenceObject_cvar;

class RoseSequenceObject :
	virtual public AbstractSequenceObject
{
	SET_OBJECT_COUNTER (RoseSequenceObject)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// ������� ������ �� ������ ���������������� ���-�������
	explicit RoseSequenceObject (IRoseObjectInstancePtr obj);

public:
	virtual ~RoseSequenceObject ();


//#UC START# *4571D2F502EE*
//#UC END# *4571D2F502EE*
}; // class RoseSequenceObject



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSESEQUENCEOBJECT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

