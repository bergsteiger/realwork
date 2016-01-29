////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/ContainerOperationsImpl/ContainerTemplateOperationsImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::ContainerOperationsImpl::ContainerTemplateOperationsImpl
// ��������� ���������� ������ �������� ��� ��������� ContainerTemplateOperations
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_CONTAINERTEMPLATEOPERATIONSIMPL_H__
#define __MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_CONTAINERTEMPLATEOPERATIONSIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/ContainerOperations/ContainerOperations.h"

namespace ContainerOperationsImpl {

class ContainerTemplateOperationsImpl; // self forward Var
typedef ::Core::Var<ContainerTemplateOperationsImpl> ContainerTemplateOperationsImpl_var;
typedef ::Core::Var<const ContainerTemplateOperationsImpl> ContainerTemplateOperationsImpl_cvar;

class ContainerTemplateOperationsImpl_factory;

class ContainerTemplateOperationsImpl:
	virtual public ContainerOperations::ContainerTemplateOperations
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ContainerTemplateOperationsImpl)
	friend class ContainerTemplateOperationsImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ContainerTemplateOperationsImpl ();

	virtual ~ContainerTemplateOperationsImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ���������� ������, �� ������� � �������, ��������� ������� ������ ���� ������� � Var
	virtual const AbstractDumperBase* get_dumper_by_param (const std::string& param, TemplatePainter* painter) const;


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ContainerOperations::ContainerTemplateOperations
	// ���������� �������� � ������ unresolved_param �������� ���� ������ ��� ��������� ��������
	// (��������: S%T), ���� ������-������ � ��������
	virtual void add (
		TemplatePainter::ContainerDumper* container
		, const std::string& unresolved_param
		, TemplatePainter* painter
	) const;

	// implemented method from ContainerOperations::ContainerTemplateOperations
	// ���������� ���������� ��������� �������� � ������, unresolved_param �������� ���� ������ ���
	// ��������� �������� (��������: S%T), ���� ������-������ � ��������
	virtual const std::string count (
		const TemplatePainter::ContainerDumper* container
		, const std::string& unresolved_param
		, TemplatePainter* painter
	) const;

	// implemented method from ContainerOperations::ContainerTemplateOperations
	// ���������� true, ���� ������� ������������ � ������, ����� false, unresolved_param ��������
	// ���� ������ ��� ��������� �������� (��������: S%T), ���� ������-������ � ��������
	virtual const std::string find (
		const TemplatePainter::ContainerDumper* container
		, const std::string& unresolved_param
		, TemplatePainter* painter
	) const;

	// implemented method from ContainerOperations::ContainerTemplateOperations
	virtual void pop_first_to_var (TemplatePainter::ContainerDumper* container, const std::string& var_id) const;

	// implemented method from ContainerOperations::ContainerTemplateOperations
	virtual void pop_last_to_var (TemplatePainter::ContainerDumper* container, const std::string& var_id) const;

	// implemented method from ContainerOperations::ContainerTemplateOperations
	// ������� ������� �� ������, unresolved_param �������� ���� ������ ��� ��������� ��������
	// (��������: S%T), ���� ������-������ � ��������
	virtual void remove (
		TemplatePainter::ContainerDumper* container
		, const std::string& unresolved_param
		, TemplatePainter* painter
	) const;

	// implemented method from ContainerOperations::ContainerTemplateOperations
	virtual void sort (
		TemplatePainter::ContainerDumper* container
		, const std::string& unresolved_param
		, TemplatePainter* painter
		, const TemplatePainter::ContainerDumper* key_list
	) const;

	// implemented method from ContainerOperations::ContainerTemplateOperations
	virtual void unique (
		TemplatePainter::ContainerDumper* container
		, const std::string& command
		, TemplatePainter* painter
	) const;
}; // class ContainerTemplateOperationsImpl

} // namespace ContainerOperationsImpl


#endif //__MDPROCESS_MDAMODEL_CONTAINEROPERATIONSIMPL_CONTAINERTEMPLATEOPERATIONSIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
