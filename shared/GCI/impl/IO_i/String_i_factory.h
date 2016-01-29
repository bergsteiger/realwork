////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCI/impl/IO_i/String_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::IO_i::String_i
// Заголовк реализации фабрик интерфеса String для серванта String_i
//
// Реализация интерфейса строки.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_IO_I_STRING_I_FCTR_H__
#define __SHARED_GCI_IO_I_STRING_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCI/IO/IOFactories.h"

namespace GCI {
namespace IO_i {

/// Interface-factory implementation for String_i
class String_i_factory: virtual public ::Core::RefCountObjectBase, virtual public IO::StringAbstractFactory {
public:
	String_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	IO::String* make (const char* str);

	IO::String* create (const char* str, short code_page);

	IO::String* take (char* str, short code_page);

	IO::String* alloc (unsigned long maximum);

};

typedef ::Core::Var<String_i_factory> String_i_factory_var;

} // namespace IO_i
} // namespace GCI


#endif //__SHARED_GCI_IO_I_STRING_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

