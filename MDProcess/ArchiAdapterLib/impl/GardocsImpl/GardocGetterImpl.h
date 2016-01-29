////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/GardocGetterImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::GardocGetterImpl
// Заголовок реализации класса серванта для интерфеса GardocGetter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_GARDOCGETTERIMPL_H__
#define __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_GARDOCGETTERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/Gardocs/Gardocs.h"

namespace ArchiAdapterLib {
namespace GardocsImpl {

class GardocGetterImpl; // self forward Var
typedef ::Core::Var<GardocGetterImpl> GardocGetterImpl_var;
typedef ::Core::Var<const GardocGetterImpl> GardocGetterImpl_cvar;

class GardocGetterImpl_factory;

class GardocGetterImpl:
	virtual public Gardocs::GardocGetter
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (GardocGetterImpl)
	friend class GardocGetterImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	GardocGetterImpl ();

	virtual ~GardocGetterImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Gardocs::GardocGetter
	virtual Gardocs::GardocList* gardocs_by_confluenceid_list (
		const Gardocs::LongList& confluenceidList
	) const /*throw (
		Gardocs::CommunicationFailure
	)*/;

	// implemented method from Gardocs::GardocGetter
	virtual Gardocs::GardocList* gardocs_by_topic_list (
		const Gardocs::LongList& topicList
	) const /*throw (
		Gardocs::CommunicationFailure
	)*/;
}; // class GardocGetterImpl

} // namespace GardocsImpl
} // namespace ArchiAdapterLib


#endif //__MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_GARDOCGETTERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
