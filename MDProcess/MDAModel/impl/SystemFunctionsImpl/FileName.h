////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/FileName.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::FileName
// ��������� ���������� ������ �������� ��� ��������� 
//
// %f_file_name(���� � �����) - ��������� ��� ����� �� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILENAME_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILENAME_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/SystemFunctionsImpl/FilePathBase.h"

namespace SystemFunctionsImpl {

class FileName; // self forward Var
typedef ::Core::Var<FileName> FileName_var;
typedef ::Core::Var<const FileName> FileName_cvar;

class FileName_factory;

// %f_file_name(���� � �����) - ��������� ��� ����� �� ����
class FileName:
	virtual public FilePathBase
{
	SET_OBJECT_COUNTER (FileName)
	friend class FileName_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FileName ();

	virtual ~FileName ();

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
}; // class FileName

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_FILENAME_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
