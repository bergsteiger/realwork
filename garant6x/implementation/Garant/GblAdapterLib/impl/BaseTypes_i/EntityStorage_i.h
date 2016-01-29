////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/EntityStorage_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::BaseTypes_i::EntityStorage_i
// Заголовок реализации класса серванта для интерфеса EntityStorage
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETYPES_I_ENTITYSTORAGE_I_H__
#define __GARANT6X_GBLADAPTERLIB_BASETYPES_I_ENTITYSTORAGE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"

namespace GblAdapterLib {

class EntityStorage_i; // self forward Var
typedef ::Core::Var<EntityStorage_i> EntityStorage_i_var;
typedef ::Core::Var<const EntityStorage_i> EntityStorage_i_cvar;

class EntityStorage_i:
	virtual public EntityStorage
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (EntityStorage_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~EntityStorage_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from EntityStorage
	// получить содежимое
	virtual Containers::Content* get_cached_content () const;

	// implemented method from EntityStorage
	// получить тип содержимого
	virtual Containers::ContentType get_content_type () const;
}; // class EntityStorage_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_BASETYPES_I_ENTITYSTORAGE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
