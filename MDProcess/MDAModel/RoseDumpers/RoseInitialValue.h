////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseInitialValue.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseInitialValue
//
// ������ ���������� ��������� �������� (������������ ��� ������ ��������� �������� ��������� �
// ���������� ��������)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEINITIALVALUE_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEINITIALVALUE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractSingleDumperBase.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"

//#UC START# *473D50220261_CUSTOM_INCLUDES*
//#UC END# *473D50220261_CUSTOM_INCLUDES*


// ������ ���������� ��������� �������� (������������ ��� ������ ��������� �������� ��������� �
// ���������� ��������)
class RoseInitialValue;
typedef Core::Var<RoseInitialValue> RoseInitialValue_var;
typedef Core::Var<const RoseInitialValue> RoseInitialValue_cvar;

class RoseInitialValue :
	virtual public AbstractSingleDumperBase
{
	SET_OBJECT_COUNTER (RoseInitialValue)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// parent - �������� ��������-�������� ��-���������
	explicit RoseInitialValue (RoseAbstractDumper* parent);

public:
	virtual ~RoseInitialValue ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ����������� ���������� �������� ��-��������� � ���������� �����. ��� ������������ �� ����������
	// ���������: ���� ������, ��������������� �������� ��-��������� �������� � �������: [VALUE], ��
	// �� ������ ������ ������� � ������ VALUE, � � ��� ����������� �������� �������� - �������� ��
	// ��������� (��� ���������� ���������� �� �����������), ��� ��������-��-��������� ���������������
	// ������ ���� �������� VALUE, � �������� �������� ��-��������� ��������������� ������: VALUE.
	// ���� �� ������ ������ ����, �� ��� ��������-����������� ��������������� ������ ����
	// ������������� ��������.
	// � �������� value - ������������ ������ �������� �� ���������.
	virtual void link (std::string& value);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// �������� ��-���������
	std::string m_init_value;

	// �������� �������� ��-���������, ����� ���� ���� �������, ���� ��������-��������
	RoseAbstractDumper* m_parent;

	// ��� �������� �� ���������, ����� ���� ������
	AbstractDumperBase* m_type;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from AbstractDumperBase
	// ���������� ���
	virtual const std::string get_name_str () const;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from AbstractDumperBase
	// ���������� �����
	virtual const std::string get_model_class_str () const;

	// overloaded method from AbstractDumperBase
	// ���������� ����
	virtual AbstractDumperBase* get_target () const;


//#UC START# *473D50220261*
	bool operator == (const AbstractDumperBase& c) const;
//#UC END# *473D50220261*
}; // class RoseInitialValue



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEINITIALVALUE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

