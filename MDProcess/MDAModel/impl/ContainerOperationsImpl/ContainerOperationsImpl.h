////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/ContainerOperationsImpl/ContainerOperationsImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Impl::Category>> MDProcess::MDAModel::ContainerOperationsImpl
//
// ����� �������� ��� ������ �� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_H__
#define __MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctions.h"
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"

//forward decl
class AbstractDumperBase;
class TemplatePainter;

namespace ContainerOperationsImpl {

// ������� ������������ ��� �������� ������ ��������� �� ���������� ���������� � ���� ���������
// ������� �������, ��� ��������� ������������ �������� "������".
struct LessByTemplateCommand : public std::binary_function<AbstractDumperBase, AbstractDumperBase, bool> {
	bool operator () (const AbstractDumperBase* first_param_, const AbstractDumperBase* second_param_) const;

	LessByTemplateCommand (const std::string& command_, const TemplatePainter* painter_);

private:
	// �������� �������
	std::string command;
	// ������������ ������ ��� ���������� �������
	const TemplatePainter* painter;
};

// ������� ������������ ��� �������� ������ ��������� �� ���������� ���������� � ���� ���������
// ������� �������, ��� ��������� ������������ �������� "������".
struct EqualByTemplateCommand : public std::binary_function<AbstractDumperBase, AbstractDumperBase, bool> {
	bool operator () (const AbstractDumperBase* first_param_, const AbstractDumperBase* second_param_) const;

	EqualByTemplateCommand (const std::string& command_, const TemplatePainter* painter_);

private:
	std::string command;
	// ������������ ������ ��� ���������� �������
	const TemplatePainter* painter;
};

} //namespace ContainerOperationsImpl


#endif //__MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

