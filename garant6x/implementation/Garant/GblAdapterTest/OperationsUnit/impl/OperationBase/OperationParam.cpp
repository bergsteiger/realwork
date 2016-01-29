////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationParam.cpp"
// C++ implementation files (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::OperationsUnit::OperationBase::OperationParam
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/sys/Logs.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/impl/OperationBase/OperationParam.h"
#include "garant6x/implementation/Garant/GblAdapterTest/OperationsUnit/OperationInterfaces/OperationInterfacesFactories.h"

//#UC START# *445B082B0222_CUSTOM_INCLUDES*
//#UC END# *445B082B0222_CUSTOM_INCLUDES*

namespace OperationsUnit {
namespace OperationBase {

//#UC START# *445B082B0222*
//#UC END# *445B082B0222*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

OperationParam::OperationParam ()
//#UC START# *445B082B0222_BASE_INIT*
//#UC END# *445B082B0222_BASE_INIT*
{
	//#UC START# *445B082B0222_BODY*
	//#UC END# *445B082B0222_BODY*
}



OperationParam::~OperationParam () {
	//#UC START# *445B082B0222_DESTR_BODY*
	//#UC END# *445B082B0222_DESTR_BODY*
}	


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from IOperationParam
const GblAdapter::IAuthorization* OperationParam::authorization () const {
	//#UC START# *4461C46C0148_445B082B0222_GET*
	return m_authorization.in ();
	//#UC END# *4461C46C0148_445B082B0222_GET*
}
void OperationParam::authorization (GblAdapter::IAuthorization* authorization) {
	//#UC START# *4461C46C0148_445B082B0222_SET*
	m_authorization = authorization;
	//#UC END# *4461C46C0148_445B082B0222_SET*
}

// implemented method from IOperationParam
const GblAdapter::ICommon* OperationParam::common_interface () const {
	//#UC START# *4461C4730177_445B082B0222_GET*
	return m_common_interface.in ();
	//#UC END# *4461C4730177_445B082B0222_GET*
}
void OperationParam::common_interface (GblAdapter::ICommon* common_interface) {
	//#UC START# *4461C4730177_445B082B0222_SET*
	m_common_interface = common_interface;
	//#UC END# *4461C4730177_445B082B0222_SET*
}

// implemented method from IOperationParam
const GblAdapter::IDocument* OperationParam::document () const {
	//#UC START# *4461C471030D_445B082B0222_GET*
	return m_document.in ();
	//#UC END# *4461C471030D_445B082B0222_GET*
}
void OperationParam::document (GblAdapter::IDocument* document) {
	//#UC START# *4461C471030D_445B082B0222_SET*
	m_document = document;
	//#UC END# *4461C471030D_445B082B0222_SET*
}

// implemented method from IOperationParam
long OperationParam::document_in_list () const {
	//#UC START# *4461CB6301A5_445B082B0222_GET*
	assert (0);
	long ret;
	return ret;
	//#UC END# *4461CB6301A5_445B082B0222_GET*
}
void OperationParam::document_in_list (long document_in_list) {
	//#UC START# *4461CB6301A5_445B082B0222_SET*
	assert (0);
	//#UC END# *4461CB6301A5_445B082B0222_SET*
}

// implemented method from IOperationParam
const GblAdapter::IDynList* OperationParam::list () const {
	//#UC START# *4461C46E0251_445B082B0222_GET*
	return m_list.in ();
	//#UC END# *4461C46E0251_445B082B0222_GET*
}
void OperationParam::list (GblAdapter::IDynList* list) {
	//#UC START# *4461C46E0251_445B082B0222_SET*
	m_list = list;
	//#UC END# *4461C46E0251_445B082B0222_SET*
}

// implemented method from IOperationParam
long OperationParam::max_operation_timeout () const {
	//#UC START# *4461CB7F01D4_445B082B0222_GET*
	return m_max_operation_timeout;
	//#UC END# *4461CB7F01D4_445B082B0222_GET*
}
void OperationParam::max_operation_timeout (long max_operation_timeout) {
	//#UC START# *4461CB7F01D4_445B082B0222_SET*
	m_max_operation_timeout = max_operation_timeout;
	//#UC END# *4461CB7F01D4_445B082B0222_SET*
}

// implemented method from IOperationParam
long OperationParam::min_operation_timeout () const {
	//#UC START# *4461CB690148_445B082B0222_GET*
	return m_min_operation_timeout;
	//#UC END# *4461CB690148_445B082B0222_GET*
}
void OperationParam::min_operation_timeout (long min_operation_timeout) {
	//#UC START# *4461CB690148_445B082B0222_SET*
	m_min_operation_timeout = min_operation_timeout;
	//#UC END# *4461CB690148_445B082B0222_SET*
}

// implemented method from IOperationParam
bool OperationParam::need_operation_sleep () const {
	//#UC START# *4461CE3D01F4_445B082B0222_GET*
	return m_need_operation_sleep;
	//#UC END# *4461CE3D01F4_445B082B0222_GET*
}
void OperationParam::need_operation_sleep (bool need_operation_sleep) {
	//#UC START# *4461CE3D01F4_445B082B0222_SET*
	m_need_operation_sleep = need_operation_sleep;
	//#UC END# *4461CE3D01F4_445B082B0222_SET*
}

// implemented method from IOperationParam
void OperationParam::reset_field () {
	//#UC START# *445B16F70000_445B082B0222*
	m_list = 0;
	m_document = 0;
	m_common_interface = 0;
	m_authorization = 0;
	//#UC END# *445B16F70000_445B082B0222*
}

// implemented method from IOperationParam
const char* OperationParam::user_login () const {
	//#UC START# *4461C4EB01B5_445B082B0222_GET*
	return m_user_login.c_str ();
	//#UC END# *4461C4EB01B5_445B082B0222_GET*
}
void OperationParam::user_login (const char* user_login) {
	//#UC START# *4461C4EB01B5_445B082B0222_SET*
	m_user_login = user_login;
	//#UC END# *4461C4EB01B5_445B082B0222_SET*
}

// implemented method from IOperationParam
const char* OperationParam::user_password () const {
	//#UC START# *4461C4F9009C_445B082B0222_GET*
	return m_user_password.c_str ();
	//#UC END# *4461C4F9009C_445B082B0222_GET*
}
void OperationParam::user_password (const char* user_password) {
	//#UC START# *4461C4F9009C_445B082B0222_SET*
	m_user_password = user_password;
	//#UC END# *4461C4F9009C_445B082B0222_SET*
}
} // namespace OperationBase
} // namespace OperationsUnit

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////