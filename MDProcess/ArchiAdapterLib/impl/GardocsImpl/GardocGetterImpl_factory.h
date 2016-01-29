////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/GardocGetterImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::GardocGetterImpl
// Заголовк реализации фабрик интерфеса GardocGetter для серванта GardocGetterImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_GARDOCGETTERIMPL_FCTR_H__
#define __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_GARDOCGETTERIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/Gardocs/GardocsFactories.h"

namespace ArchiAdapterLib {
namespace GardocsImpl {

/// Interface-factory implementation for GardocGetterImpl
class GardocGetterImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public Gardocs::GardocGetterAbstractFactory
{
public:
	GardocGetterImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Gardocs::GardocGetter* get ();

};

typedef ::Core::Var<GardocGetterImpl_factory> GardocGetterImpl_factory_var;

} // namespace GardocsImpl
} // namespace ArchiAdapterLib


#endif //__MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_GARDOCGETTERIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

