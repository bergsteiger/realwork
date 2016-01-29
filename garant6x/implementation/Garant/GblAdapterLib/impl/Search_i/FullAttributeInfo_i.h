////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/FullAttributeInfo_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::FullAttributeInfo_i
// Заголовок реализации класса серванта для интерфеса FullAttributeInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_FULLATTRIBUTEINFO_I_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_FULLATTRIBUTEINFO_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"

namespace GblAdapterLib {

class FullAttributeInfo_i; // self forward Var
typedef ::Core::Var<FullAttributeInfo_i> FullAttributeInfo_i_var;
typedef ::Core::Var<const FullAttributeInfo_i> FullAttributeInfo_i_cvar;

class FullAttributeInfo_i_factory;

class FullAttributeInfo_i:
	virtual public FullAttributeInfo
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (FullAttributeInfo_i)
	friend class FullAttributeInfo_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FullAttributeInfo_i (const GblPilotQueryDef::FullAttributeInfo& full_info);

	virtual ~FullAttributeInfo_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	OperationList m_available_operations;

	mutable QueryAttribute_var m_default_value;

	std::string m_tag;

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

	// implemented method from FullAttributeInfo
	virtual const GCI::IO::String* get_tag () const;
	virtual GCI::IO::String* get_tag ();
}; // class FullAttributeInfo_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_FULLATTRIBUTEINFO_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
