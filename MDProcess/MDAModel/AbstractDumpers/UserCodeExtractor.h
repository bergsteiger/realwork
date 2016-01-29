////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/AbstractDumpers/UserCodeExtractor.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::UserCodeExtractor
//
// ����� ��� �������� �������� � "������������" �� ���� ����-������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_USERCODEEXTRACTOR_H__
#define __MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_USERCODEEXTRACTOR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "boost/function.hpp"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"


// ����� ��� �������� �������� � "������������" �� ���� ����-������
class UserCodeExtractor {
	SET_OBJECT_COUNTER (UserCodeExtractor)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// callback ������� ���������� �������� ��� ����������� ���� ������
	typedef boost::function<void (const std::string&, const AbstractDumperBase::UserCode&, const std::string&)> Callback;

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// ������ callback
	static void empty_callback (const std::string& uc_id, const AbstractDumperBase::UserCode& uc_content, const std::string& gen_id);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~UserCodeExtractor ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ������ �������� ��������, ���������� true, ���� ���� ������� ���� ���� ����- ������, ����� false
	virtual bool process (
		const std::string& content
		, const AbstractDumperBase::TemplateBody& tp
		, const std::string& element_uid
		, const Callback& callback
	) /*throw (
		TemplatePainter::TemplateBadSyntax
	)*/;

}; // class UserCodeExtractor



#endif //__MDPROCESS_MDAMODEL_ABSTRACTDUMPERS_USERCODEEXTRACTOR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

