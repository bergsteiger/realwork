////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/FilePathBase.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::FilePathBase
// ��������� ���������� ������ �������� ��� ��������� 
//
// ������� ������� ��� ������ � ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILEPATHBASE_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILEPATHBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/TemplateFunctions/TemplateFunctions.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class FilePathBase; // self forward Var
typedef ::Core::Var<FilePathBase> FilePathBase_var;
typedef ::Core::Var<const FilePathBase> FilePathBase_cvar;

// ������� ������� ��� ������ � ������
class FilePathBase:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (FilePathBase)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
protected:
	// ������� ���� �����
	enum PathComponent {
		PT_DRIVE // ����
		, PT_NAME // ��� �����
		, PT_EXT // ���������� �����
		, PT_DIR // �����
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FilePathBase ();

	virtual ~FilePathBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// ���������� ���������� ���������� �������.
	const std::string execute_impl (
		const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
		, PathComponent path_component
	) const;

}; // class FilePathBase

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILEPATHBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
