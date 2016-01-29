////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/MemStream_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTypes_i::MemStream_i
// Заголовк реализации фабрик интерфеса MemoryStream для серванта MemStream_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETYPES_I_MEMSTREAM_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_BASETYPES_I_MEMSTREAM_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypesLocal/BaseTypesLocalFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseTypes_i.h"

namespace GblAdapterLib {

/// Interface-factory implementation for MemStream_i
class MemStream_i_factory: virtual public ::Core::RefCountObjectBase, virtual public MemoryStreamAbstractFactory {
public:
	MemStream_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	MemoryStream* make (const OctetSeq& data, bool with_copy);

};

typedef ::Core::Var<MemStream_i_factory> MemStream_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_BASETYPES_I_MEMSTREAM_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

