////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryPhoneNumberAttribute_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryPhoneNumberAttribute_i
// Заголовок реализации класса серванта для интерфеса QueryPhoneNumberAttribute
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYPHONENUMBERATTRIBUTE_I_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYPHONENUMBERATTRIBUTE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryAttribute_i.h"

namespace GblAdapterLib {

class QueryPhoneNumberAttribute_i; // self forward Var
typedef ::Core::Var<QueryPhoneNumberAttribute_i> QueryPhoneNumberAttribute_i_var;
typedef ::Core::Var<const QueryPhoneNumberAttribute_i> QueryPhoneNumberAttribute_i_cvar;

class QueryPhoneNumberAttribute_i_factory;

class QueryPhoneNumberAttribute_i:
	virtual public QueryPhoneNumberAttribute
	, virtual public QueryAttribute_i
{
	SET_OBJECT_COUNTER (QueryPhoneNumberAttribute_i)
	friend class QueryPhoneNumberAttribute_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	QueryPhoneNumberAttribute_i (AttributeTag_const attribute_tag);

	virtual ~QueryPhoneNumberAttribute_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable GCI::IO::String_var m_city_code;

	mutable GCI::IO::String_var m_phone_number;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from QueryAttribute
	virtual void clear ();

	// implemented method from QueryPhoneNumberAttribute
	virtual const GCI::IO::String& get_city_code () const;
	virtual GCI::IO::String& get_city_code ();

	virtual void set_city_code (GCI::IO::String* city_code);

	// implemented method from QueryPhoneNumberAttribute
	virtual const GCI::IO::String& get_phone_number () const;
	virtual GCI::IO::String& get_phone_number ();

	virtual void set_phone_number (GCI::IO::String* phone_number);
}; // class QueryPhoneNumberAttribute_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYPHONENUMBERATTRIBUTE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
