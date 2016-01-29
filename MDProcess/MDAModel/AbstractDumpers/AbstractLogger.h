////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractLogger.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractLogger
//
// ����������� ����� ��������������� ������ ��� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTLOGGER_H__
#define __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTLOGGER_H__

#include "shared/CoreSrv/sys/std_inc.h"


// ����������� ����� ��������������� ������ ��� ������������
class AbstractLogger;
typedef Core::Var<AbstractLogger> AbstractLogger_var;
typedef Core::Var<const AbstractLogger> AbstractLogger_cvar;

class AbstractLogger :
	virtual public Core::RefCountObjectBase
{
// virtual void destructor
public:
	virtual ~AbstractLogger () {};

//////////////////////////////////////////////////////////////////////////////////////////
// abstarct methods
public:
	// ����� ��� ����������� ������
	virtual void write_error_log (const std::string& mess, bool fatal) const = 0;

	// ����������� �������������� ���������
	virtual void write_info_log (const std::string& mess) const = 0;

	// ����������� ��������������
	virtual void write_warning_log (const std::string& mess) const = 0;

}; // class AbstractLogger



#endif //__MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_ABSTRACTLOGGER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

