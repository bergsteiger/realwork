////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddDependency_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddDependency
// �������� ���������� ������ ��������� AddDependencyLocal ��� �������� AddDependency
//
// 1. %S%f_add_dependency(<UID ������ ��������>,<���� �����>,<���������>,<��� �����>,<���
// ����������>) - ������� ����� ����� ����� ������� � ��������� � ����� �����, ���� ����� ����
// ������ ����� ��������� �������� ���� ������ ������ - ������ ������ ������������ ��� �����������
// ����� ����� ��������
// 2. %S%f_add_dependency(<���� �����>) - ������� ����� ����� ����� ������� � ��������� � �����
// �����, ���� ����� ���� ������ ����� ��������� �������� ���� ������ ������ - ������ ������
// ������������ ��� ����������� ����� ����� �������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDDEPENDENCY_FCTR_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDDEPENDENCY_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImplFactories.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImpl.h"

namespace VirtualElementsFuncionsImpl {

/// Interface-factory implementation for AddDependency
class AddDependency_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public AddDependencyLocalAbstractFactory
{
public:
	AddDependency_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	AddDependencyLocal* get ();

	TemplateFunctions::InternalStereotypeFunction* make ();

};

typedef ::Core::Var<AddDependency_factory> AddDependency_factory_var;

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDDEPENDENCY_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

