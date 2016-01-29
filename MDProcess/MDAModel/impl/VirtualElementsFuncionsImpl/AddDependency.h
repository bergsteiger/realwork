////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddDependency.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddDependency
// ��������� ���������� ������ �������� ��� ��������� AddDependencyLocal
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
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDDEPENDENCY_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDDEPENDENCY_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractClassDumper.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImpl.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class AddDependency; // self forward Var
typedef ::Core::Var<AddDependency> AddDependency_var;
typedef ::Core::Var<const AddDependency> AddDependency_cvar;

class AddDependency_factory;

// 1. %S%f_add_dependency(<UID ������ ��������>,<���� �����>,<���������>,<��� �����>,<���
// ����������>) - ������� ����� ����� ����� ������� � ��������� � ����� �����, ���� ����� ����
// ������ ����� ��������� �������� ���� ������ ������ - ������ ������ ������������ ��� �����������
// ����� ����� ��������
// 2. %S%f_add_dependency(<���� �����>) - ������� ����� ����� ����� ������� � ��������� � �����
// �����, ���� ����� ���� ������ ����� ��������� �������� ���� ������ ������ - ������ ������
// ������������ ��� ����������� ����� ����� �������.
class AddDependency:
	virtual public AddDependencyLocal
	, virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (AddDependency)
	friend class AddDependency_factory; // self factory
protected:
	// factories id
	struct FactoriesID {
		class Make {}; // TemplateFunctions::BaseFunction::make
		class Get {}; // VirtualElementsFuncionsImpl::AddDependencyLocal::get
	};
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddDependency (const FactoriesID::Get& factory_id);

	AddDependency (const FactoriesID::Make& factory_id);

	virtual ~AddDependency ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ������� ����� ����������� ����� ��������
	virtual void create_dep_for_class (
		const RoseAbstractClassDumper* source
		, const RoseAbstractClassDumper* target
		, const std::string& guid_suffix
		, const std::string& name
		, const std::string& stereotype
		, const std::string& var_id
		, const AbstractDumperBase* context
	) const;


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from AddDependencyLocal
	// ������� ����������� ����� ���������� (�� ��������)
	virtual void create_dep_for_others (const AbstractDumper* source, const AbstractDumper* target) const;

	// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
	// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
	virtual const std::string execute_impl (
		const AbstractDumperBase* self
		, const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class AddDependency

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDDEPENDENCY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
