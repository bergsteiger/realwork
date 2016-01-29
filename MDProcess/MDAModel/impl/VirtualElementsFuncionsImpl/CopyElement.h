////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/CopyElement.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::CopyElement
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_copy_element(<��� ������ ��������>, <��� ��� ��� ��������>,<��������� ������ ��������>,<���
// ������ ��������>,<������ ����������� (� ������) ��� ���>,<��� ���������� � ������� ���������
// ����� �������>) - ������� ����������� ��������, ���� ������ ������ ����������� - �� ����������
// ��� ���� �������� ����������. ������ �������������:
// {code}
// %S%f_copy_element(_COPY,,factory,new_make,true,VAR) - ��������� ������� � �������� �����������
// ��������, � ������������ ���� �����
// {code}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_COPYELEMENT_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_COPYELEMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class CopyElement; // self forward Var
typedef ::Core::Var<CopyElement> CopyElement_var;
typedef ::Core::Var<const CopyElement> CopyElement_cvar;

class CopyElement_factory;

// %S%f_copy_element(<��� ������ ��������>, <��� ��� ��� ��������>,<��������� ������ ��������>,<���
// ������ ��������>,<������ ����������� (� ������) ��� ���>,<��� ���������� � ������� ���������
// ����� �������>) - ������� ����������� ��������, ���� ������ ������ ����������� - �� ����������
// ��� ���� �������� ����������. ������ �������������:
// {code}
// %S%f_copy_element(_COPY,,factory,new_make,true,VAR) - ��������� ������� � �������� �����������
// ��������, � ������������ ���� �����
// {code}
class CopyElement:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (CopyElement)
	friend class CopyElement_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CopyElement ();

	virtual ~CopyElement ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	virtual RoseAbstractDumper* copy_attribute (
		const RoseAbstractDumper* elem
		, const RoseAbstractDumper* parent
		, const std::string& uid
		, const std::string& stereotype
		, const std::string& name
		, bool reqursive
		, const AbstractDumperBase* context
	) const;

	// �������� �����, ���������� ����� �������
	virtual RoseAbstractDumper* copy_category (
		const RoseAbstractDumper* elem
		, const RoseAbstractDumper* parent
		, const std::string& uid
		, const std::string& stereotype
		, const std::string& name
		, bool reqursive
		, const AbstractDumperBase* context
	) const;

	// ����������� ����� �������� (����������)
	virtual void copy_childs (
		const RoseAbstractDumper* elem
		, const RoseAbstractDumper* parent
		, const RoseAbstractDumper* new_elem
	) const;

	virtual RoseAbstractDumper* copy_class (
		const RoseAbstractDumper* elem
		, const RoseAbstractDumper* parent
		, const std::string& uid
		, const std::string& stereotype
		, const std::string& name
		, bool reqursive
		, const AbstractDumperBase* context
	) const;

	virtual RoseAbstractDumper* copy_dependency (
		const RoseAbstractDumper* elem
		, const RoseAbstractDumper* parent
		, const std::string& uid
		, const std::string& stereotype
		, const std::string& name
		, bool reqursive
		, const AbstractDumperBase* context
	) const;

	virtual RoseAbstractDumper* copy_element (
		const RoseAbstractDumper* elem
		, const RoseAbstractDumper* parent
		, const std::string& uid
		, const std::string& stereotype
		, const std::string& name
		, bool reqursive
		, const AbstractDumperBase* context
	) const;

	virtual RoseAbstractDumper* copy_operation (
		const RoseAbstractDumper* elem
		, const RoseAbstractDumper* parent
		, const std::string& uid
		, const std::string& stereotype
		, const std::string& name
		, bool reqursive
		, const AbstractDumperBase* context
	) const;

	virtual RoseAbstractDumper* copy_parameter (
		const RoseAbstractDumper* elem
		, const RoseAbstractDumper* parent
		, const std::string& uid
		, const std::string& stereotype
		, const std::string& name
		, bool reqursive
		, const AbstractDumperBase* context
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
}; // class CopyElement

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_COPYELEMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
