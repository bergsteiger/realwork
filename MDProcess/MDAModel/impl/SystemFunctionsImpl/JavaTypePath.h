////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/SystemFunctionsImpl/JavaTypePath.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::SystemFunctionsImpl::JavaTypePath
// ��������� ���������� ������ �������� ��� ��������� 
//
// ���������� ������ ���� � �������� �� �������� java
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_JAVATYPEPATH_H__
#define __MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_JAVATYPEPATH_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/BaseFunctionImpl/InternalFunctionBase.h"

namespace SystemFunctionsImpl {

class JavaTypePath; // self forward Var
typedef ::Core::Var<JavaTypePath> JavaTypePath_var;
typedef ::Core::Var<const JavaTypePath> JavaTypePath_cvar;

class JavaTypePath_factory;

// ���������� ������ ���� � �������� �� �������� java
class JavaTypePath:
	virtual public BaseFunctionImpl::InternalFunctionBase
{
	SET_OBJECT_COUNTER (JavaTypePath)
	friend class JavaTypePath_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	JavaTypePath ();

	virtual ~JavaTypePath ();

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
}; // class JavaTypePath

} // namespace SystemFunctionsImpl


#endif //__MDPROCESS_MDAMODEL_SYSTEMFUNCTIONSIMPL_JAVATYPEPATH_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
