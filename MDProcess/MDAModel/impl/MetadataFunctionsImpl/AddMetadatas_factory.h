////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/MetadataFunctionsImpl/AddMetadatas_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::MetadataFunctionsImpl::AddMetadatas
// �������� ���������� ������ ���������  ��� �������� AddMetadatas
//
// ������� ���������� ���������� � ��������, ��� ���������� ��������� ��� ���������� �����
// ��������� � ��������, ��������� � ���������.
// _add_metadatas (�������, ����� �����������, �������������� ������ � �����������). ���� ������
// � �������������� ������ � ����������� �� ������, �� ���� �������� ���������������� ���
// ����������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_METADATAFUNCTIONSIMPL_ADDMETADATAS_FCTR_H__
#define __MDPROCESS_MDAMODEL_METADATAFUNCTIONSIMPL_ADDMETADATAS_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace MetadataFunctionsImpl {

/// Interface-factory implementation for AddMetadatas
class AddMetadatas_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	AddMetadatas_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<AddMetadatas_factory> AddMetadatas_factory_var;

} // namespace MetadataFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_METADATAFUNCTIONSIMPL_ADDMETADATAS_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

