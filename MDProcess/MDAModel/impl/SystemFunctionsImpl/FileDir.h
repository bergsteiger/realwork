////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/FileDir.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::FileDir
// ��������� ���������� ������ �������� ��� ��������� 
//
// %f_file_dir(���� � �����) - ��������� ����� �� ���� � �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILEDIR_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILEDIR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/FilePathBase.h"

namespace SystemFunctionsImpl {

class FileDir; // self forward Var
typedef ::Core::Var<FileDir> FileDir_var;
typedef ::Core::Var<const FileDir> FileDir_cvar;

class FileDir_factory;

// %f_file_dir(���� � �����) - ��������� ����� �� ���� � �����
class FileDir:
	virtual public FilePathBase
{
	SET_OBJECT_COUNTER (FileDir)
	friend class FileDir_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FileDir ();

	virtual ~FileDir ();

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
}; // class FileDir

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILEDIR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
