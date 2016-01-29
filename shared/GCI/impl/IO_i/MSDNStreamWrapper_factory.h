////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/IO_i/MSDNStreamWrapper_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::IO_i::MSDNStreamWrapper
// Заголовк реализации фабрик интерфеса Stream для серванта MSDNStreamWrapper
//
// обёртка вокруг msdn-овского стрима
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_IO_I_MSDNSTREAMWRAPPER_FCTR_H__
#define __SHARED_GCI_IO_I_MSDNSTREAMWRAPPER_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/IO/IOFactories.h"

namespace GCI {
namespace IO_i {

/// Interface-factory implementation for MSDNStreamWrapper
class MSDNStreamWrapper_factory: virtual public ::Core::RefCountObjectBase, virtual public IO::StreamAbstractFactory {
public:
	MSDNStreamWrapper_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	IO::Stream* make ();

	IO::Stream* make (const char* path);

};

typedef ::Core::Var<MSDNStreamWrapper_factory> MSDNStreamWrapper_factory_var;

} // namespace IO_i
} // namespace GCI


#endif //__SHARED_GCI_IO_I_MSDNSTREAMWRAPPER_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

