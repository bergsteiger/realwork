////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/UtilsImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::UtilsImpl
// Заголовк реализации фабрик интерфеса Utils для серванта UtilsImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_UTILSIMPL_FCTR_H__
#define __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_UTILSIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/Gardocs/GardocsFactories.h"

namespace ArchiAdapterLib {
namespace GardocsImpl {

/// Interface-factory implementation for UtilsImpl
class UtilsImpl_factory: virtual public ::Core::RefCountObjectBase, virtual public Gardocs::UtilsAbstractFactory {
public:
	UtilsImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Gardocs::Utils* get ();

};

typedef ::Core::Var<UtilsImpl_factory> UtilsImpl_factory_var;

} // namespace GardocsImpl
} // namespace ArchiAdapterLib


#endif //__MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_UTILSIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

