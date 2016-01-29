////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/RoseDumpers/ModelStamp.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::ModelStamp
//
// ����� ������ ����, ���������� ���������� ���������� �� ������ � ������� ��������� ����������
// ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_MODELSTAMP_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_MODELSTAMP_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"


// ����� ������ ����, ���������� ���������� ���������� �� ������ � ������� ��������� ����������
// ������
class ModelStamp {
	SET_OBJECT_COUNTER (ModelStamp)

	// singleton declaration
	typedef ACE_Singleton <ModelStamp, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <ModelStamp, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static ModelStamp* instance () {
		return Singleton::instance();
	}
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~ModelStamp ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ������������� ������ ����� � ���������� ��� � ����������, � ������ �� ����������� ����������
	// true, ����� - false
	virtual bool is_stamp_changed ();

private:
	// ������ ������
	virtual void build_stamp ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ������� ����������� �����
	std::string m_current_stamp;

	// ���������� �����
	std::string m_previous_stamp;
}; // class ModelStamp



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_MODELSTAMP_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

