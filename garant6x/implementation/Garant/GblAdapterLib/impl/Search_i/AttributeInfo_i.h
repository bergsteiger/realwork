////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/AttributeInfo_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::AttributeInfo_i
// Заголовок реализации класса серванта для интерфеса AttributeInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_ATTRIBUTEINFO_I_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_ATTRIBUTEINFO_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTypes_i/BaseUpdateChecker_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchDefines/SearchDefines.h"

namespace GblAdapterLib {

class AttributeInfo_i; // self forward Var
typedef ::Core::Var<AttributeInfo_i> AttributeInfo_i_var;
typedef ::Core::Var<const AttributeInfo_i> AttributeInfo_i_cvar;

class AttributeInfo_i_factory;

class AttributeInfo_i:
	virtual public AttributeInfo
	, virtual public ::Core::RefCountObjectBase
	, virtual public BaseUpdateChecker_i
{
	SET_OBJECT_COUNTER (AttributeInfo_i)
	friend class AttributeInfo_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	explicit AttributeInfo_i (AttributeTag_const tag);

	virtual ~AttributeInfo_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	virtual void fill_attribute_info (AttributeTag_const tag) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable OperationList m_available_operations;

	mutable QueryAttribute_var m_default_value;

	mutable Core::Box<bool> m_exist;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from AttributeInfo
	virtual const OperationList& get_available_operations () const;

	// implemented method from AttributeInfo
	// Получить дефолтное значение атрибута
	virtual QueryAttribute* get_default_value () const;

	// implemented method from AttributeInfo
	virtual bool get_is_exist () const;

	// implemented method from BaseUpdateChecker_i
	virtual void clear_cache ();
}; // class AttributeInfo_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_ATTRIBUTEINFO_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
