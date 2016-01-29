////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/NormolizedPath.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::NormolizedPath
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� "_normolized_path".
// _normolized_path(�������� ���������,��������), ��������:
// %f_normolized_path(dll.h,C)
// - ������� ���� � ��� ����� ��������� ��� �������� ��������, ������������ ���� � ����� ���������
// �������� ��������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_NORMOLIZEDPATH_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_NORMOLIZEDPATH_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class NormolizedPath; // self forward Var
typedef ::Core::Var<NormolizedPath> NormolizedPath_var;
typedef ::Core::Var<const NormolizedPath> NormolizedPath_cvar;

class NormolizedPath_factory;

// ���������� ���������� ������� ���������� "_normolized_path".
// _normolized_path(�������� ���������,��������), ��������:
// %f_normolized_path(dll.h,C)
// - ������� ���� � ��� ����� ��������� ��� �������� ��������, ������������ ���� � ����� ���������
// �������� ��������.
class NormolizedPath:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (NormolizedPath)
	friend class NormolizedPath_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	NormolizedPath ();

	virtual ~NormolizedPath ();

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
}; // class NormolizedPath

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_NORMOLIZEDPATH_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
