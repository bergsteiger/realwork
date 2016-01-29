////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/GenSupportImpl/ErrorManagerImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::ErrorManagerImpl
// Заголовок реализации класса серванта для интерфеса ErrorManager
//
// реалиазция менеджера ошибок
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_ERRORMANAGERIMPL_H__
#define __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_ERRORMANAGERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"

namespace GenSupportImpl {

class ErrorManagerImpl; // self forward Var
typedef ::Core::Var<ErrorManagerImpl> ErrorManagerImpl_var;
typedef ::Core::Var<const ErrorManagerImpl> ErrorManagerImpl_cvar;

class ErrorManagerImpl_factory;

// реалиазция менеджера ошибок
class ErrorManagerImpl:
	virtual public GenSupport::ErrorManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ErrorManagerImpl)
	friend class ErrorManagerImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ErrorManagerImpl ();

	virtual ~ErrorManagerImpl ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// список ошибок
	GenSupport::ErrorInfoList m_errors;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
private:
	virtual const GenSupport::ErrorInfoList& get_errors () const;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from GenSupport::ErrorManager
	// очищает список ошибок
	virtual void clear_errors ();

	// implemented method from GenSupport::ErrorManager
	// очищает список ошибок, которые случились в контексте какого-то элемента
	virtual void clear_only_dumper_errors ();

	// implemented method from GenSupport::ErrorManager
	// добавляет информацию о случившейся ошибке
	virtual void error (const Base::Dumper* dumper, const std::string& message, const std::string& alter_name);

	// implemented method from GenSupport::ErrorManager
	// информация о фатальной ошибке, если не отключена реакция на ошибки - выбрасывается исключение
	virtual void fatal_error (
		const Base::Dumper* dumper
		, const std::string& message
		, const std::string& alter_name
	) /*throw (
		Base::FatalError
	)*/;

	// implemented method from GenSupport::ErrorManager
	// фатальная ошибка при работе с элементом с идентификатором = uid
	virtual void fatal_error (const std::string& uid, const std::string& message, const std::string& alter_name);
}; // class ErrorManagerImpl

} // namespace GenSupportImpl


#endif //__MDPROCESS_MDAMODEL_GENSUPPORTIMPL_ERRORMANAGERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
