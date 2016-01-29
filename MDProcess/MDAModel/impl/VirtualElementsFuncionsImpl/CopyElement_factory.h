////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/CopyElement_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::CopyElement
// �������� ���������� ������ ���������  ��� �������� CopyElement
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
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_COPYELEMENT_FCTR_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_COPYELEMENT_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFuncionsImpl.h"

namespace VirtualElementsFuncionsImpl {

/// Interface-factory implementation for CopyElement
class CopyElement_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalStereotypeFunctionAbstractFactory
{
public:
	CopyElement_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalStereotypeFunction* make ();

};

typedef ::Core::Var<CopyElement_factory> CopyElement_factory_var;

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_COPYELEMENT_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

