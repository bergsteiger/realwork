////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/GenSupportImpl/EnvironmentImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::EnvironmentImpl
//
// реализация интерфейса параметров генерации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/GenSupportImpl/EnvironmentImpl.h"

namespace GenSupportImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

EnvironmentImpl::EnvironmentImpl () : m_cancel_generation (false), m_disable_auto_count (false), m_disable_post_processing (false), m_enable_spell_explicit_call_logging (false), m_rewrite_user_code (false), m_scold_if_call_tpl_function_on_null (false), m_suppress_user_code (false), m_lock_strategy (GenSupport::LS_NO_LOCK), m_suppress_generation_errors (false)
//#UC START# *47D77554027C_4BDFE4B50242_4BDFE19C0232_BASE_INIT*
//#UC END# *47D77554027C_4BDFE4B50242_4BDFE19C0232_BASE_INIT*
{
	//#UC START# *47D77554027C_4BDFE4B50242_4BDFE19C0232_BODY*
	//#UC END# *47D77554027C_4BDFE4B50242_4BDFE19C0232_BODY*
}

EnvironmentImpl::~EnvironmentImpl () {
	//#UC START# *4BDFE19C0232_DESTR_BODY*
	//#UC END# *4BDFE19C0232_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

bool EnvironmentImpl::get_cancel_generation () const {
	//#UC START# *4BDFE1D600CB_GET_ACCESSOR*
	return m_cancel_generation;
	//#UC END# *4BDFE1D600CB_GET_ACCESSOR*
}

void EnvironmentImpl::set_cancel_generation (bool cancel_generation) {
	//#UC START# *4BDFE1D600CB_SET_ACCESSOR*
	m_cancel_generation = cancel_generation;
	//#UC END# *4BDFE1D600CB_SET_ACCESSOR*
}

bool EnvironmentImpl::get_disable_auto_count () const {
	//#UC START# *4BDFE1F802DE_GET_ACCESSOR*
	return m_disable_auto_count;
	//#UC END# *4BDFE1F802DE_GET_ACCESSOR*
}

void EnvironmentImpl::set_disable_auto_count (bool disable_auto_count) {
	//#UC START# *4BDFE1F802DE_SET_ACCESSOR*
	m_disable_auto_count = disable_auto_count;
	//#UC END# *4BDFE1F802DE_SET_ACCESSOR*
}

bool EnvironmentImpl::get_disable_post_processing () const {
	//#UC START# *4BDFE1FC003E_GET_ACCESSOR*
	return m_disable_post_processing;
	//#UC END# *4BDFE1FC003E_GET_ACCESSOR*
}

void EnvironmentImpl::set_disable_post_processing (bool disable_post_processing) {
	//#UC START# *4BDFE1FC003E_SET_ACCESSOR*
	m_disable_post_processing = disable_post_processing;
	//#UC END# *4BDFE1FC003E_SET_ACCESSOR*
}

bool EnvironmentImpl::get_enable_spell_explicit_call_logging () const {
	//#UC START# *4BDFE1FF00EA_GET_ACCESSOR*
	return m_enable_spell_explicit_call_logging;
	//#UC END# *4BDFE1FF00EA_GET_ACCESSOR*
}

void EnvironmentImpl::set_enable_spell_explicit_call_logging (bool enable_spell_explicit_call_logging) {
	//#UC START# *4BDFE1FF00EA_SET_ACCESSOR*
	m_enable_spell_explicit_call_logging = enable_spell_explicit_call_logging;
	//#UC END# *4BDFE1FF00EA_SET_ACCESSOR*
}

GenSupport::LockStrategy EnvironmentImpl::get_lock_strategy () const {
	//#UC START# *4BDFE36A002E_GET_ACCESSOR*
	return m_lock_strategy;
	//#UC END# *4BDFE36A002E_GET_ACCESSOR*
}

void EnvironmentImpl::set_lock_strategy (GenSupport::LockStrategy lock_strategy) {
	//#UC START# *4BDFE36A002E_SET_ACCESSOR*
	m_lock_strategy = lock_strategy;
	//#UC END# *4BDFE36A002E_SET_ACCESSOR*
}

bool EnvironmentImpl::get_rewrite_user_code () const {
	//#UC START# *4BDFE2020167_GET_ACCESSOR*
	return m_rewrite_user_code;
	//#UC END# *4BDFE2020167_GET_ACCESSOR*
}

void EnvironmentImpl::set_rewrite_user_code (bool rewrite_user_code) {
	//#UC START# *4BDFE2020167_SET_ACCESSOR*
	m_rewrite_user_code = rewrite_user_code;
	//#UC END# *4BDFE2020167_SET_ACCESSOR*
}

bool EnvironmentImpl::get_scold_if_call_tpl_function_on_null () const {
	//#UC START# *4BDFE2050138_GET_ACCESSOR*
	return m_scold_if_call_tpl_function_on_null;
	//#UC END# *4BDFE2050138_GET_ACCESSOR*
}

void EnvironmentImpl::set_scold_if_call_tpl_function_on_null (bool scold_if_call_tpl_function_on_null) {
	//#UC START# *4BDFE2050138_SET_ACCESSOR*
	m_scold_if_call_tpl_function_on_null = scold_if_call_tpl_function_on_null;
	//#UC END# *4BDFE2050138_SET_ACCESSOR*
}

bool EnvironmentImpl::get_suppress_generation_errors () const {
	//#UC START# *4BDFE6120109_GET_ACCESSOR*
	return m_suppress_generation_errors;
	//#UC END# *4BDFE6120109_GET_ACCESSOR*
}

void EnvironmentImpl::set_suppress_generation_errors (bool suppress_generation_errors) {
	//#UC START# *4BDFE6120109_SET_ACCESSOR*
	m_suppress_generation_errors = suppress_generation_errors;
	//#UC END# *4BDFE6120109_SET_ACCESSOR*
}

bool EnvironmentImpl::get_suppress_user_code () const {
	//#UC START# *4BDFE2080242_GET_ACCESSOR*
	return m_suppress_user_code;
	//#UC END# *4BDFE2080242_GET_ACCESSOR*
}

void EnvironmentImpl::set_suppress_user_code (bool suppress_user_code) {
	//#UC START# *4BDFE2080242_SET_ACCESSOR*
	m_suppress_user_code = suppress_user_code;
	//#UC END# *4BDFE2080242_SET_ACCESSOR*
}

const GenSupport::LockFailedOptions& EnvironmentImpl::get_lock_failed_options () const {
	//#UC START# *4BDFE37D02EE_GET_ACCESSOR*
	return m_lock_failed_options;
	//#UC END# *4BDFE37D02EE_GET_ACCESSOR*
}

void EnvironmentImpl::set_lock_failed_options (const GenSupport::LockFailedOptions& lock_failed_options) {
	//#UC START# *4BDFE37D02EE_SET_ACCESSOR*
	m_lock_failed_options = lock_failed_options;
	//#UC END# *4BDFE37D02EE_SET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from GenSupport::Environment
void EnvironmentImpl::set_lock_failed_need_ask (bool value) {
	//#UC START# *4BDFF3EC003E_4BDFE19C0232*
	m_lock_failed_options.need_ask = value;
	//#UC END# *4BDFF3EC003E_4BDFE19C0232*
}

// implemented method from GenSupport::Environment
void EnvironmentImpl::set_lock_failed_need_fatal_error (bool value) {
	//#UC START# *4BDFF406029F_4BDFE19C0232*
	m_lock_failed_options.need_fatal_error = value;
	//#UC END# *4BDFF406029F_4BDFE19C0232*
}
} // namespace GenSupportImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

