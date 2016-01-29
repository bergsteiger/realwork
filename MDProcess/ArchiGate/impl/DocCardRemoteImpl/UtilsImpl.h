////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/UtilsImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::UtilsImpl
// Заголовок реализации класса серванта для интерфеса Utils
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_UTILSIMPL_H__
#define __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_UTILSIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemote.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteS.h"

namespace ArchiGate {
namespace DocCardRemoteImpl {

class UtilsImpl; // self forward Var
typedef ::Core::Var<UtilsImpl> UtilsImpl_var;
typedef ::Core::Var<const UtilsImpl> UtilsImpl_cvar;

class UtilsImpl_factory;

class UtilsImpl:
	virtual public POA_ArchiGate::DocCardRemote::Utils
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (UtilsImpl)
	friend class UtilsImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	UtilsImpl ();

	virtual void release () throw (CORBA::SystemException, CoreSrv::ForeignObject);

	virtual void release_i () throw (CORBA::SystemException, CoreSrv::ForeignObject);

	virtual ~UtilsImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DocCardRemote::Utils
	// Особенность работы сервера заключается в том что он сначало получает все документы с указанной
	// даты в реализации Searcher2::get_xxxx, а потом выкидывает лишнее (например фильтрует по
	// партнеру). Если время, которое подает клиент слишком старое, то фильрация может занимать
	// несколько десятков минут. Поэтому клиенту предлагается в случае, если ему на
	// Searcher2::get_xxxx не вернулся ни один документ, дернуть update_old_last_created_time и
	// результат запомнить у себя.
	// Сервер будет отнимать от текущего времени 30-ть минут и результат возвращать клиенту. Если
	// получившееся время старше входного параметра, то просто отдается time.
	virtual const CORBA::LongLong update_old_last_created_time (
		CORBA::LongLong date
	) throw (
		CORBA::SystemException
		, DocCardRemote::IllegalStateExceptionRemote
	);
}; // class UtilsImpl

} // namespace DocCardRemoteImpl
} // namespace ArchiGate


#endif //__MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_UTILSIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
