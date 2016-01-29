////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryHelper
// Заголовок реализации класса серванта для интерфеса Query
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYHELPER_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYHELPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchDefines/SearchDefines.h"

//#UC START# *4CAC44820175_CUSTOM_INCLUDES*
//#UC END# *4CAC44820175_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class QueryHelper; // self forward Var
typedef ::Core::Var<QueryHelper> QueryHelper_var;
typedef ::Core::Var<const QueryHelper> QueryHelper_cvar;

class QueryHelper:
	virtual public Query
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (QueryHelper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	QueryHelper (QueryType type);

	virtual ~QueryHelper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// возвращает 0, если атрибут не найден
	virtual QueryAttribute* find_attribute (AttributeTag_const tag, QueryTagType type);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable QueryType m_type;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
protected:
	virtual QueryType get_type () const;

	virtual void set_type (QueryType type) const;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Query
	virtual QueryAttributeList* attributes_by_tag (AttributeTag_const tag);

	// implemented method from Query
	virtual GblPilotQueryDef::Query* build_query ();

	// implemented method from Query
	virtual void clear ();

	// implemented method from Query
	virtual QueryContextAttribute* get_context_attribute (AttributeTag_const tag);

	// implemented method from Query
	virtual QueryDateAttribute* get_date_attribute (AttributeTag_const tag);

	// implemented method from Query
	virtual QueryNodeAttribute* get_node_attribute (AttributeTag_const tag);

	// implemented method from Query
	virtual QueryPhoneNumberAttribute* get_phone_number_attribute (AttributeTag_const tag);

//#UC START# *4CAC44820175*
protected:
	virtual void check_saved_query () = 0;

	void unpack_context (AttributeTag tag, const GblPilotQueryDef::QueryAttributeValueList& server_attributes);
	void unpack_date (AttributeTag tag, const GblPilotQueryDef::QueryAttributeValueList& server_attributes);
	void unpack_node (AttributeTag tag, const GblPilotQueryDef::QueryAttributeValueList& server_attributes);
	void unpack_phone_number (AttributeTag tag, const GblPilotQueryDef::QueryAttributeValueList& server_attributes);

	void pack_context (QueryAttribute* adapter_attribute, GblPilotQueryDef::QueryAttributeValueList& server_list);
	void pack_date (QueryAttribute* adapter_attribute, GblPilotQueryDef::QueryAttributeValueList& server_list);
	void pack_node (QueryAttribute* adapter_attribute, GblPilotQueryDef::QueryAttributeValueList& server_list);
	void pack_phone_number (QueryAttribute* adapter_attribute, GblPilotQueryDef::QueryAttributeValueList& server_list);

	template <typename T, typename T_i>
	T* get_attribute (AttributeTag_const tag, QueryTagType type) {
		if (QueryAttribute* attribute = this->find_attribute (tag, type)) {
			return dynamic_cast <T*> (attribute);
		} else {
			T* ptr = T_i::make (tag);
			m_attributes.push_back (ptr);
			return Core::IObject::_duplicate (ptr);
		}
	}

protected:
	QueryAttributeList m_attributes;
//#UC END# *4CAC44820175*
}; // class QueryHelper

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
