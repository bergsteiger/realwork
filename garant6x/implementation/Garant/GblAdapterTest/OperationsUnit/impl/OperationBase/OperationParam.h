////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationParam.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::OperationBase::OperationParam
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_OPERATIONBASE_OPERATIONPARAM_H__
#define __GARANT6X_OPERATIONSUNIT_OPERATIONBASE_OPERATIONPARAM_H__

#include "shared/Core/GDS/ObjectCounter.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfaces.h"
#include "garant6x/implementation/Garant/GblAdapterTest/GblAdapter/Document/DocumentUnit.h"
#include "garant6x/implementation/Garant/GblAdapterTest/GblAdapter/DynamicDocList/DynamicDocListUnit.h"
#include "garant6x/implementation/Garant/GblAdapterTest/GblAdapter/Start/StartUnit.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B082B0222_CUSTOM_INCLUDES*
#include <string>
//#UC END# *445B082B0222_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace OperationBase {

class OperationParam; // self forward Var
typedef ::Core::Var<OperationParam> OperationParam_var;

class OperationParam:
	virtual public OperationInterfaces::IOperationParam
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (OperationParam)
	friend class OperationInterfaces::IOperationParamFactory;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	
	OperationParam ();
	virtual ~OperationParam ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	long m_document_in_list;

	long m_min_operation_timeout;

	long m_max_operation_timeout;

	bool m_need_operation_sleep;

	::Core::Var<GblAdapter::ICommon> m_common_interface;

	::Core::Var<GblAdapter::IDocument> m_document;

	::Core::Var<GblAdapter::IDynList> m_list;

	::Core::Var<GblAdapter::IAuthorization> m_authorization;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from IOperationParam
	virtual const GblAdapter::IAuthorization* authorization () const;
	virtual void authorization (GblAdapter::IAuthorization* authorization);

	// implemented method from IOperationParam
	virtual const GblAdapter::ICommon* common_interface () const;
	virtual void common_interface (GblAdapter::ICommon* common_interface);

	// implemented method from IOperationParam
	virtual const GblAdapter::IDocument* document () const;
	virtual void document (GblAdapter::IDocument* document);

	// implemented method from IOperationParam
	virtual long document_in_list () const;
	virtual void document_in_list (long document_in_list);

	// implemented method from IOperationParam
	virtual const GblAdapter::IDynList* list () const;
	virtual void list (GblAdapter::IDynList* list);

	// implemented method from IOperationParam
	virtual long max_operation_timeout () const;
	virtual void max_operation_timeout (long max_operation_timeout);

	// implemented method from IOperationParam
	virtual long min_operation_timeout () const;
	virtual void min_operation_timeout (long min_operation_timeout);

	// implemented method from IOperationParam
	virtual bool need_operation_sleep () const;
	virtual void need_operation_sleep (bool need_operation_sleep);

	// implemented method from IOperationParam
	virtual void reset_field ();

	// implemented method from IOperationParam
	virtual const char* user_login () const;
	virtual void user_login (const char* user_login);

	// implemented method from IOperationParam
	virtual const char* user_password () const;
	virtual void user_password (const char* user_password);

//#UC START# *445B082B0222*
private:
	std::string m_user_login;
	std::string m_user_password;
//#UC END# *445B082B0222*
}; // class OperationParam

} // namespace OperationBase
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_OPERATIONBASE_OPERATIONPARAM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////