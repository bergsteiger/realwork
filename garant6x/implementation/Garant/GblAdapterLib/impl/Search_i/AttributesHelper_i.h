////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AttributesHelper_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::AttributesHelper_i
// Заголовок реализации класса серванта для интерфеса AttributesHelper
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_ATTRIBUTESHELPER_I_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_ATTRIBUTESHELPER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"

namespace GblAdapterLib {

class AttributesHelper_i; // self forward Var
typedef ::Core::Var<AttributesHelper_i> AttributesHelper_i_var;
typedef ::Core::Var<const AttributesHelper_i> AttributesHelper_i_cvar;

class AttributesHelper_i_factory;

class AttributesHelper_i:
	virtual public AttributesHelper
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (AttributesHelper_i)
	friend class AttributesHelper_i_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <AttributesHelper_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <AttributesHelper_i, ACE_SYNCH_RECURSIVE_MUTEX>;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AttributesHelper_i ();

	virtual ~AttributesHelper_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from AttributesHelper
	virtual bool attribute_KW_exists () const;

	// implemented method from AttributesHelper
	virtual bool attribute_publish_source_exists () const;
}; // class AttributesHelper_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_ATTRIBUTESHELPER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
