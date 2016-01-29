////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfaces.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Interface::Category>> garant6x::OperationsUnit::OperationInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_OPERATIONSUNIT_OPERATIONINTERFACES_H__
#define __GARANT6X_OPERATIONSUNIT_OPERATIONINTERFACES_H__

#include "shared/Core/sys/Exception.h"
#include "garant6x/implementation/Garant/GblAdapterTest/GblAdapter/Document/DocumentUnit.h"
#include "garant6x/implementation/Garant/GblAdapterTest/GblAdapter/DynamicDocList/DynamicDocListUnit.h"
#include "garant6x/implementation/Garant/GblAdapterTest/GblAdapter/Start/StartUnit.h"
//#UC START# *445B02A800EA_CUSTOM_INCLUDE*
//#UC END# *445B02A800EA_CUSTOM_INCLUDE*

namespace OperationsUnit {
	
namespace OperationInterfaces {

class IOperationParam
	: virtual public ::Core::IObject
{
public:
	virtual const GblAdapter::IAuthorization* authorization () const = 0;
	virtual void authorization (GblAdapter::IAuthorization* authorization) = 0;

	virtual const GblAdapter::IDynList* list () const = 0;
	virtual void list (GblAdapter::IDynList* list) = 0;

	virtual const GblAdapter::IDocument* document () const = 0;
	virtual void document (GblAdapter::IDocument* document) = 0;

	virtual const GblAdapter::ICommon* common_interface () const = 0;
	virtual void common_interface (GblAdapter::ICommon* common_interface) = 0;

	virtual const char* user_login () const = 0;
	virtual void user_login (const char* user_login) = 0;

	virtual const char* user_password () const = 0;
	virtual void user_password (const char* user_password) = 0;

	virtual long document_in_list () const = 0;
	virtual void document_in_list (long document_in_list) = 0;

	virtual long min_operation_timeout () const = 0;
	virtual void min_operation_timeout (long min_operation_timeout) = 0;

	virtual long max_operation_timeout () const = 0;
	virtual void max_operation_timeout (long max_operation_timeout) = 0;

	virtual bool need_operation_sleep () const = 0;
	virtual void need_operation_sleep (bool need_operation_sleep) = 0;

	virtual void reset_field () = 0;
};

typedef ::Core::Var<IOperationParam> IOperationParam_var;

class IAttributeManager
	: virtual public ::Core::IObject
{
public:
	virtual char* get_string (const char* key, const char* default_value = "") = 0;
	virtual long get_long (const char* key, long default_value = 0) = 0;
	virtual bool get_bool (const char* key, bool default_value = false) = 0;
	virtual bool is_exist (const char* key) = 0;
	virtual void add_string (const char* key, const char* value) = 0;
};

typedef ::Core::Var<IAttributeManager> IAttributeManager_var;

class IOperation
	: virtual public ::Core::IObject
{
public:
	virtual void execute (IOperationParam* param) = 0;
	virtual void get_attribute_manager (IAttributeManager*& attribute_manager) const = 0;
	virtual void set_attribute_manager (const IAttributeManager* attribute_manager) = 0;
	virtual void add_operation (IOperation* operation) = 0;
};

typedef ::Core::Var<IOperation> IOperation_var;

} // namespace OperationInterfaces
} // namespace OperationsUnit


#endif //__GARANT6X_OPERATIONSUNIT_OPERATIONINTERFACES_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////