////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOperation_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddOperation
// �������� ���������� ������ ���������  ��� �������� AddOperation
//
// 1. %S%f_add_operation(<GUID ������ ��������>,<���������>, <��� ��������>,<��� ����������>,<���
// ����������>) - ������� ����� ������� - �������� � �������� ������ � �����������, ��������� ��� �
// ���������� � ��������� ��� ������� � �������� ��������, ��� �������� �������� ���� ������
// ������������� ��������, ���� ������ ������ ���� - � ���� ������ � ������ ����� �������� �������
// � ����� ������.
// 2. %S%f_add_operation(<GUID ������ ��������>, <���������>,<��� �������� � ���������� �
// �����������>,<��� ����������>) - ������� ����� ������� - �������� ��� �������� ��� ����������, �
// ����� ��������� �������� ������ ����������, � �������: <��� ��������> (<������������ ���������>
// <��� ���������> : <��� ��������� (GUID ��� ������) = <�������� �� ��������� (GUID ���
// ������)>>):<GUID ��� ��� ������������ ���������>
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDOPERATION_FCTR_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDOPERATION_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImpl.h"

namespace VirtualElementsFuncionsImpl {

/// Interface-factory implementation for AddOperation
class AddOperation_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalStereotypeFunctionAbstractFactory
{
public:
	AddOperation_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalStereotypeFunction* make ();

};

typedef ::Core::Var<AddOperation_factory> AddOperation_factory_var;

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDOPERATION_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

