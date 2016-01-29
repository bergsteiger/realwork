////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/Prime_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Prime_i::Prime_i
// Заголовок реализации класса серванта для интерфеса Prime
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PRIME_I_PRIME_I_H__
#define __GARANT6X_GBLADAPTERLIB_PRIME_I_PRIME_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garantServer/src/Business/GblFolders/GblFoldersAdapC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Prime/Prime.h"

namespace GblAdapterLib {

class Prime_i; // self forward Var
typedef ::Core::Var<Prime_i> Prime_i_var;
typedef ::Core::Var<const Prime_i> Prime_i_cvar;

class Prime_i_factory;

class Prime_i:
	virtual public Prime
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Prime_i)
	friend class Prime_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Prime_i (PrimeKey key, const char* name, GblFoldersAdap::SavedQueryData query);

	virtual ~Prime_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	virtual void save ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	PrimeKey m_key;

	GCI::IO::String_var m_name;

	GblFoldersAdap::SavedQueryData m_query;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Prime
	virtual PrimeKey get_id () const;

	// implemented method from Prime
	virtual const GCI::IO::String& get_name () const;
	virtual GCI::IO::String& get_name ();

	virtual void set_name (GCI::IO::String* name);

	// implemented method from Prime
	virtual const Query* get_query () const;
	virtual Query* get_query ();

	virtual void set_query (Query* query);
}; // class Prime_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PRIME_I_PRIME_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
