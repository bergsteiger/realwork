////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractOperationDumper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractOperationDumper
//
// ������ ��� ��������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTOPERATIONDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTOPERATIONDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractElementDumper.h"

//#UC START# *4571DF59030D_CUSTOM_INCLUDES*
//#UC END# *4571DF59030D_CUSTOM_INCLUDES*


// ������ ��� ��������� ��������
class RoseAbstractOperationDumper;
typedef Core::Var<RoseAbstractOperationDumper> RoseAbstractOperationDumper_var;
typedef Core::Var<const RoseAbstractOperationDumper> RoseAbstractOperationDumper_cvar;

class RoseAbstractOperationDumper :
	public RoseAbstractElementDumper
{
	SET_OBJECT_COUNTER (RoseAbstractOperationDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseAbstractOperationDumper ();


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from AbstractDumperBase
	// ���������� �����
	virtual const std::string get_model_class_str () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from ObjectTreeResolver
	// ��������� � ��������� ���� supplier
	virtual void link_suppliers ();


//#UC START# *4571DF59030D*
public:
	RoseAbstractOperationDumper (const RoseAbstractDumper* parent, IRoseOperationPtr op, const AbstractDumperBase::StereotypeID& st);
	
protected:	
	IRoseOperationPtr op () const;
	IRoseClassPtr parent_cls () const;
	
//#UC END# *4571DF59030D*
}; // class RoseAbstractOperationDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTOPERATIONDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

