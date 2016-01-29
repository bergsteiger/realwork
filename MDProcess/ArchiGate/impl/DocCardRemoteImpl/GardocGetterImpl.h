////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/GardocGetterImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::GardocGetterImpl
// Заголовок реализации класса серванта для интерфеса GardocGetter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_GARDOCGETTERIMPL_H__
#define __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_GARDOCGETTERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemote.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteS.h"

namespace ArchiGate {
namespace DocCardRemoteImpl {

class GardocGetterImpl; // self forward Var
typedef ::Core::Var<GardocGetterImpl> GardocGetterImpl_var;
typedef ::Core::Var<const GardocGetterImpl> GardocGetterImpl_cvar;

class GardocGetterImpl_factory;

class GardocGetterImpl:
	virtual public POA_ArchiGate::DocCardRemote::GardocGetter
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (GardocGetterImpl)
	friend class GardocGetterImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	GardocGetterImpl ();

	virtual void release () throw (CORBA::SystemException, CoreSrv::ForeignObject);

	virtual void release_i () throw (CORBA::SystemException, CoreSrv::ForeignObject);

	virtual ~GardocGetterImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DocCardRemote::GardocGetter
	virtual DocCardRemote::GardocList* gardocs_by_confluenceid_list (
		const DocCardRemote::LongList& confluenceidList
	) throw (
		CORBA::SystemException
		, DocCardRemote::IllegalStateExceptionRemote
	);

	// implemented method from DocCardRemote::GardocGetter
	virtual DocCardRemote::GardocList* gardocs_by_topic_list (
		const DocCardRemote::LongList& topicList
	) throw (
		CORBA::SystemException
		, DocCardRemote::IllegalStateExceptionRemote
	);
}; // class GardocGetterImpl

} // namespace DocCardRemoteImpl
} // namespace ArchiGate


#endif //__MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_GARDOCGETTERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
