////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/RoseAbstractDumpFactory.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::RoseAbstractDumpFactory
//
// ������� ��� �������� ����������� ������� �� ������ IRoseItem
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTDUMPFACTORY_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTDUMPFACTORY_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"

//#UC START# *4571DD4D0399_CUSTOM_INCLUDES*
//#UC END# *4571DD4D0399_CUSTOM_INCLUDES*


// ������� ��� �������� ����������� ������� �� ������ IRoseItem
class RoseAbstractDumpFactory :
	virtual public RoseAbstractDumper::DumpersFactory
{
	SET_OBJECT_COUNTER (RoseAbstractDumpFactory)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseAbstractDumpFactory ();


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

		// implemented method from RoseAbstractDumper::DumpersFactory
		// ��������� ������������ �������� ���������, ���������� true, ���� ��� ������, ����� false
		virtual bool check_stereotype (IRoseElementPtr elem) const;

		// implemented method from RoseAbstractDumper::DumpersFactory
		// ������� ������ ��� ������� �������
		virtual RoseAbstractDumper* create_by_root (IRoseItemPtr cls);

		// implemented method from RoseAbstractDumper::DumpersFactory
		// ������� ������ �� ������ �������� � ���������� �������
		virtual RoseAbstractDumper* create_by_stereotype (const RoseAbstractDumper* parent, IRoseElementPtr cls);

//#UC START# *4571DD4D0399*
//#UC END# *4571DD4D0399*
}; // class RoseAbstractDumpFactory



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_ROSEABSTRACTDUMPFACTORY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

