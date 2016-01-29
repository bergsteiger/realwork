////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/NormolizedDir.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::NormolizedDir
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ���������� ������� ���������� "_normolized_dir".
// _normolized_dir(�������� ���������,��������), ��������:
// %f_normolized_dir(dll.h,C)
// - ������� ���� ��������� ��� �������� ��������, ������������ ���� � ����� ��������� ��������
// ��������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_NORMOLIZEDDIR_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_NORMOLIZEDDIR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class NormolizedDir; // self forward Var
typedef ::Core::Var<NormolizedDir> NormolizedDir_var;
typedef ::Core::Var<const NormolizedDir> NormolizedDir_cvar;

class NormolizedDir_factory;

// ���������� ���������� ������� ���������� "_normolized_dir".
// _normolized_dir(�������� ���������,��������), ��������:
// %f_normolized_dir(dll.h,C)
// - ������� ���� ��������� ��� �������� ��������, ������������ ���� � ����� ��������� ��������
// ��������.
class NormolizedDir:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (NormolizedDir)
	friend class NormolizedDir_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	NormolizedDir ();

	virtual ~NormolizedDir ();

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
}; // class NormolizedDir

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_NORMOLIZEDDIR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
