////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddOperation.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddOperation
// ��������� ���������� ������ �������� ��� ��������� 
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
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDOPERATION_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDOPERATION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class AddOperation; // self forward Var
typedef ::Core::Var<AddOperation> AddOperation_var;
typedef ::Core::Var<const AddOperation> AddOperation_cvar;

class AddOperation_factory;

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
class AddOperation:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (AddOperation)
	friend class AddOperation_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddOperation ();

	virtual ~AddOperation ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ������� ����� ������� - �������� � �������� ������ � �����������, ��������� ��� � ���������� �
	// ��������� ��� ������� � �������� ��������, ��� �������� �������� ���� ������ �������������
	// ��������, ���� ������ ������ ���� - � ���� ������ � ������ ����� �������� ������� � �����
	// ������.
	virtual const std::string create_operation (
		const RoseAbstractDumper* parent
		, const std::string& guid_suffix
		, const std::string& name
		, const std::string& stereotype
		, const std::string& result
		, const std::string& var_id
		, TemplatePainter* painter
	) const;

	// ������� ����� ������� - �������� ��� �������� ��� ����������, � ����� ��������� �������� ������
	// ����������, � �������: <��� ��������> (<������������ ���������> <��� ���������> : <���
	// ��������� (GUID ��� ������) = <�������� �� ��������� (GUID ��� ������)>>):<GUID ��� ���
	// ������������ ���������>
	virtual const std::string create_operation (
		const RoseAbstractDumper* parent
		, const std::string& guid_suffix
		, const std::string& signature
		, const std::string& stereotype
		, const std::string& var_id
		, TemplatePainter* painter
	) const;


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
	// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
	virtual const std::string execute_impl (
		const AbstractDumperBase* self
		, const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class AddOperation

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDOPERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
