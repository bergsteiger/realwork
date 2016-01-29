////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractCategoryDumper.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractCategoryDumper
//
// ������ ��� ��������� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTCATEGORYDUMPER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTCATEGORYDUMPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"

//#UC START# *4571DD1A009C_CUSTOM_INCLUDES*
//#UC END# *4571DD1A009C_CUSTOM_INCLUDES*


// ������ ��� ��������� �����
class RoseAbstractCategoryDumper;
typedef Core::Var<RoseAbstractCategoryDumper> RoseAbstractCategoryDumper_var;
typedef Core::Var<const RoseAbstractCategoryDumper> RoseAbstractCategoryDumper_cvar;

class RoseAbstractCategoryDumper :
	public RoseAbstractDumper
{
	SET_OBJECT_COUNTER (RoseAbstractCategoryDumper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseAbstractCategoryDumper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ���� "���������" ������������
	mutable bool m_is_global_locally;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	bool get_is_global_locally () const;

	void set_is_global_locally (bool is_global_locally) const;

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

	// overloaded method from RoseAbstractDumper
	// ����� ����������, ����� ����� ��������, �������������� �� ������� �������� ���������
	virtual void update_cached_attrs () const;
private:

	// overloaded method from ObjectTreeResolver
	// C������� ��������� ������������ - ���� � ������ ���������� ����� ��������, �� ���������, ����
	// ������� - ������� �������� �������� �� ���� � ��� ����� �������� �������� �������, �.� ��� ���-
	// �� ����� ���� ��������� ����� � ��� �������
	virtual bool is_global_locally () const;


//#UC START# *4571DD1A009C*
public:	
	RoseAbstractCategoryDumper (const RoseAbstractDumper* parent, IRoseCategoryPtr cat);	
	IRoseCategoryPtr cat() const;
	virtual bool is_global() const;

protected:
	// ����������� ������ ���� include ����� � ��������� ����� ������������ � ������� IDL-����
	//virtual void collect_include (GCL::StrSet& col);
	bool data;
	
//#UC END# *4571DD1A009C*
}; // class RoseAbstractCategoryDumper



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTCATEGORYDUMPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

