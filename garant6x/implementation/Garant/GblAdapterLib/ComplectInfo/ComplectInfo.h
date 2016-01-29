////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ComplectInfo/ComplectInfo.h"
// C++ header files (.h)
// Generated from UML model, root element: <<Interface::Category>> garant6x::GblAdapterLib::ComplectInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_COMPLECTINFO_H__
#define __GARANT6X_GBLADAPTERLIB_COMPLECTINFO_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"

namespace GblAdapterLib {

enum ComplectType {
	CT_INTERNAL
	, CT_LOCAL
	, CT_NET_ONE_USER
	, CT_NET_MANY_USERS
};

// Нода информации о комплекте
class ComplectInfoNode
	: virtual public void
	, virtual public NodeBase
{
public:
	// Данные ноды
	virtual const wchar*& get_info () const = 0;
};

typedef ::Core::Var<ComplectInfoNode> ComplectInfoNode_var;
typedef ::Core::Var<const ComplectInfoNode> ComplectInfoNode_cvar;

// Интерфейс получение информации о текущем комплекте баз.
class ComplectInfo
	: virtual public ::Core::IObject
{
public:
	virtual const char* get_unexist_doc_message () const = 0;

	virtual ComplectType get_type () const = 0;

	virtual const char* get_owner () const = 0;

	virtual const char* get_dealer_info () const = 0;

	virtual const char* get_old_base_warning () const = 0;

	virtual const NodeBase* get_info () const = 0;
	virtual NodeBase* get_info () = 0;

	virtual StringList* get_missing_blocks_by_type (const NodeBase* category) const = 0;
};

typedef ::Core::Var<ComplectInfo> ComplectInfo_var;
typedef ::Core::Var<const ComplectInfo> ComplectInfo_cvar;

/// factory interface for ComplectInfo
class ComplectInfoFactory {
public:
	static ComplectInfo* make ()
		/*throw (Core::Root::NoActiveFactory)*/;
};

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_COMPLECTINFO_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
