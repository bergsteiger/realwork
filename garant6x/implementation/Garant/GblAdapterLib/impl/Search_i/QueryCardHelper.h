////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/QueryCardHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Search_i::QueryCardHelper
// Заголовок реализации класса серванта для интерфеса QueryCardInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYCARDHELPER_H__
#define __GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYCARDHELPER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garantServer/src/Business/GblPilot/GblPilotQueryDefC.h"

namespace GblAdapterLib {

class QueryCardHelper; // self forward Var
typedef ::Core::Var<QueryCardHelper> QueryCardHelper_var;
typedef ::Core::Var<const QueryCardHelper> QueryCardHelper_cvar;

class QueryCardHelper:
	virtual public QueryCardInfo
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (QueryCardHelper)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	QueryCardHelper ();

	virtual ~QueryCardHelper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	virtual GCI::IO::Stream* get_evd_card (GblPilotQueryDef::QueryType type) const;

	virtual AttributeList* get_exist_attrs (GblPilotQueryDef::QueryType type) const;

}; // class QueryCardHelper

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SEARCH_I_QUERYCARDHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
