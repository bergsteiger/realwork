////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/GenSupportImpl/EnvironmentImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::EnvironmentImpl
// Заголовок реализации класса серванта для интерфеса Environment
//
// реализация интерфейса параметров генерации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_ENVIRONMENTIMPL_H__
#define __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_ENVIRONMENTIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"

namespace GenSupportImpl {

class EnvironmentImpl; // self forward Var
typedef ::Core::Var<EnvironmentImpl> EnvironmentImpl_var;
typedef ::Core::Var<const EnvironmentImpl> EnvironmentImpl_cvar;

class EnvironmentImpl_factory;

// реализация интерфейса параметров генерации
class EnvironmentImpl:
	virtual public GenSupport::Environment
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (EnvironmentImpl)
	friend class EnvironmentImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	EnvironmentImpl ();

	virtual ~EnvironmentImpl ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// флаг отмены генерации
	bool m_cancel_generation;

	// флаг отмены автоинкремента
	bool m_disable_auto_count;

	// флаг отмены пост-процессинга (команд, выполняемых после применения результатов генерации)
	bool m_disable_post_processing;

	// нужно ли логгировать явные вызовы spell-генератора
	bool m_enable_spell_explicit_call_logging;

	GenSupport::LockFailedOptions m_lock_failed_options;

	GenSupport::LockStrategy m_lock_strategy;

	// нужно ли перезаписать юзер код тем, что генериться с шаблона
	bool m_rewrite_user_code;

	// нужно ли ругаться при попытке вызывать функцию стереотипа на несуществующем элементе
	bool m_scold_if_call_tpl_function_on_null;

	// нужно ли подавлять ошибки, возникающие в процессе генерации
	bool m_suppress_generation_errors;

	// флаг, определяющий нужно ли подавлять использование юзер кода, записанного в модели - если флаг
	// - false - код из модели используется.
	bool m_suppress_user_code;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	virtual bool get_cancel_generation () const;

	virtual void set_cancel_generation (bool cancel_generation);

	virtual bool get_disable_auto_count () const;

	virtual void set_disable_auto_count (bool disable_auto_count);

	virtual bool get_disable_post_processing () const;

	virtual void set_disable_post_processing (bool disable_post_processing);

	virtual bool get_enable_spell_explicit_call_logging () const;

	virtual void set_enable_spell_explicit_call_logging (bool enable_spell_explicit_call_logging);

	virtual GenSupport::LockStrategy get_lock_strategy () const;

	virtual void set_lock_strategy (GenSupport::LockStrategy lock_strategy);

	virtual bool get_rewrite_user_code () const;

	virtual void set_rewrite_user_code (bool rewrite_user_code);

	virtual bool get_scold_if_call_tpl_function_on_null () const;

	virtual void set_scold_if_call_tpl_function_on_null (bool scold_if_call_tpl_function_on_null);

	virtual bool get_suppress_generation_errors () const;

	virtual void set_suppress_generation_errors (bool suppress_generation_errors);

	virtual bool get_suppress_user_code () const;

	virtual void set_suppress_user_code (bool suppress_user_code);
private:
	virtual const GenSupport::LockFailedOptions& get_lock_failed_options () const;

	virtual void set_lock_failed_options (const GenSupport::LockFailedOptions& lock_failed_options);

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from GenSupport::Environment
	virtual void set_lock_failed_need_ask (bool value);

	// implemented method from GenSupport::Environment
	virtual void set_lock_failed_need_fatal_error (bool value);
}; // class EnvironmentImpl

} // namespace GenSupportImpl


#endif //__MDPROCESS_MDAMODEL_GENSUPPORTIMPL_ENVIRONMENTIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
