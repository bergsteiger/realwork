////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractElementDumper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractElementDumper
//
// ���������� ������ ��� ���� IRoseItem
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTELEMENTDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTELEMENTDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"

//#UC START# *4571D3040222_CUSTOM_INCLUDES*
//#UC END# *4571D3040222_CUSTOM_INCLUDES*


// ���������� ������ ��� ���� IRoseItem
class RoseAbstractElementDumper;
typedef Core::Var<RoseAbstractElementDumper> RoseAbstractElementDumper_var;
typedef Core::Var<const RoseAbstractElementDumper> RoseAbstractElementDumper_cvar;

class RoseAbstractElementDumper :
	public RoseAbstractDumper
{
	SET_OBJECT_COUNTER (RoseAbstractElementDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseAbstractElementDumper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// �������� ���������� ���� ��������:
	// 1. �������� �� �������� ������������� ���������� �������� - ������� ���� ������� � ������
	// 2. �������� �� �������� ��� ���������� ����, ���������� ��� ���������� ������ ����
	// (current_type)
	// 3. ���� ��������� - ������������ �������
	// 4. ���� �� ��������� - ����������� �������� ������ ���� �� �����, ���������� � ����������
	// �������� ����������� � ������
	virtual const RoseAbstractDumper* resolve_target_type (std::string& current_type);



//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from AbstractDumperBase
	// ���������� true, ���� ������� ����� "�������"
	virtual bool can_dump () const;

	// overloaded method from ObjectTreeResolver
	// ����������� �� �������� � ������� �������� (� ������� �������� �� ������) - ����� �������� ��
	// ����� �������� � ����.
	virtual bool sort_in_model_order () const;


//#UC START# *4571D3040222*
public:
	RoseAbstractElementDumper (const RoseAbstractDumper* parent, IRoseElementPtr cls, const AbstractDumperBase::StereotypeID& = AbstractDumperBase::StereotypeID (""));	
	virtual bool is_it_first (const ObjectTreeResolver* od) const;
//#UC END# *4571D3040222*
}; // class RoseAbstractElementDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTELEMENTDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

