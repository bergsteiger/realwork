////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/Variant_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTypes_i::Variant_i
// Заголовок реализации класса серванта для интерфеса Variant
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETYPES_I_VARIANT_I_H__
#define __GARANT6X_GBLADAPTERLIB_BASETYPES_I_VARIANT_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseTypes_i.h"

//#UC START# *456EEB6E00EA_CUSTOM_INCLUDES*
//#UC END# *456EEB6E00EA_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class Variant_i; // self forward Var
typedef ::Core::Var<Variant_i> Variant_i_var;
typedef ::Core::Var<const Variant_i> Variant_i_cvar;

class Variant_i_factory;

class Variant_i:
	virtual public Variant
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Variant_i)
	friend class Variant_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Variant_i ();

	Variant_i (long value);

	Variant_i (bool value);

	Variant_i (GCI::IO::String* value);

	Variant_i (Core::IObject* value);

	virtual ~Variant_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	bool m_bool;

	long m_long;

	Core::IObject_var m_object;

	GCI::IO::String_var m_string;

	VariantType m_type;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Variant
	// вернуть булево значение
	virtual bool get_bool () const /*throw (InvalidType)*/;

	// implemented method from Variant
	// вернуть целое
	virtual long get_long () const /*throw (InvalidType)*/;

	// implemented method from Variant
	// вернуть объект
	virtual Core::IObject* get_object () /*throw (InvalidType)*/;

	// implemented method from Variant
	// вернуть строку
	virtual GCI::IO::String* get_string () /*throw (InvalidType)*/;

//#UC START# *456EEB6E00EA*
//#UC END# *456EEB6E00EA*
}; // class Variant_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_BASETYPES_I_VARIANT_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
