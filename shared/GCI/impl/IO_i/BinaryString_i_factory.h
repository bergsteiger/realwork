////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/IO_i/BinaryString_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::IO_i::BinaryString_i
// Заголовк реализации фабрик интерфеса BinaryString для серванта BinaryString_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_IO_I_BINARYSTRING_I_FCTR_H__
#define __SHARED_GCI_IO_I_BINARYSTRING_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/IO/IOFactories.h"

namespace GCI {
namespace IO_i {

/// Interface-factory implementation for BinaryString_i
class BinaryString_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public IO::BinaryStringAbstractFactory
{
public:
	BinaryString_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	IO::BinaryString* make (const void* buffer, size_t size);

};

typedef ::Core::Var<BinaryString_i_factory> BinaryString_i_factory_var;

} // namespace IO_i
} // namespace GCI


#endif //__SHARED_GCI_IO_I_BINARYSTRING_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

