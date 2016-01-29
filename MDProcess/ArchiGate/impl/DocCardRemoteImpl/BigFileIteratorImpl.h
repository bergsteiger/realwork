////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/BigFileIteratorImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::BigFileIteratorImpl
// Заголовок реализации класса серванта для интерфеса BigFileIterator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_BIGFILEITERATORIMPL_H__
#define __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_BIGFILEITERATORIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemote.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteS.h"

namespace ArchiGate {
namespace DocCardRemoteImpl {

class BigFileIteratorImpl; // self forward Var
typedef ::Core::Var<BigFileIteratorImpl> BigFileIteratorImpl_var;
typedef ::Core::Var<const BigFileIteratorImpl> BigFileIteratorImpl_cvar;

class BigFileIteratorImpl_factory;

class BigFileIteratorImpl:
	virtual public POA_ArchiGate::DocCardRemote::BigFileIterator
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (BigFileIteratorImpl)
	friend class BigFileIteratorImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	BigFileIteratorImpl ();

	virtual void destroy () throw (CORBA::SystemException, CoreSrv::ForeignObject);

	virtual void destroy_i () throw (CORBA::SystemException, CoreSrv::ForeignObject);

	virtual ~BigFileIteratorImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DocCardRemote::BigFileIterator
	virtual DocCardRemote::ByteBuffer* next (CORBA::LongLong chunkSizeInBytes) throw (CORBA::SystemException);
}; // class BigFileIteratorImpl

} // namespace DocCardRemoteImpl
} // namespace ArchiGate


#endif //__MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_BIGFILEITERATORIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
