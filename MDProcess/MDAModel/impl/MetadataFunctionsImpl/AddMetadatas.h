////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/MetadataFunctionsImpl/AddMetadatas.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::MetadataFunctionsImpl::AddMetadatas
// ��������� ���������� ������ �������� ��� ��������� 
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
#ifndef __MDPROCESS_MDAMODEL_METADATAFUNCTIONSIMPL_ADDMETADATAS_H__
#define __MDPROCESS_MDAMODEL_METADATAFUNCTIONSIMPL_ADDMETADATAS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace MetadataFunctionsImpl {

class AddMetadatas; // self forward Var
typedef ::Core::Var<AddMetadatas> AddMetadatas_var;
typedef ::Core::Var<const AddMetadatas> AddMetadatas_cvar;

class AddMetadatas_factory;

// ������� ���������� ���������� � ��������, ��� ���������� ��������� ��� ���������� �����
// ��������� � ��������, ��������� � ���������.
// _add_metadatas (�������, ����� �����������, �������������� ������ � �����������). ���� ������
// � �������������� ������ � ����������� �� ������, �� ���� �������� ���������������� ���
// ����������.
class AddMetadatas:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (AddMetadatas)
	friend class AddMetadatas_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddMetadatas ();

	virtual ~AddMetadatas ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseFunctionImpl::InternalFunctionBase
	// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
	virtual const std::string execute_impl (
		const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class AddMetadatas

} // namespace MetadataFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_METADATAFUNCTIONSIMPL_ADDMETADATAS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
