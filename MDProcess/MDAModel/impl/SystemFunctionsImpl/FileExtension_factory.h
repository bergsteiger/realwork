////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/FileExtension_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::FileExtension
// �������� ���������� ������ ���������  ��� �������� FileExtension
//
// %f_file_extension(���� � �����) - ��������� ���������� ����� �� ���� � �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILEEXTENSION_FCTR_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILEEXTENSION_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctionsFactories.h"

namespace SystemFunctionsImpl {

/// Interface-factory implementation for FileExtension
class FileExtension_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public TemplateFunctions::InternalFunctionAbstractFactory
{
public:
	FileExtension_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const std::string key () const;

	TemplateFunctions::InternalFunction* make ();

};

typedef ::Core::Var<FileExtension_factory> FileExtension_factory_var;

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILEEXTENSION_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

