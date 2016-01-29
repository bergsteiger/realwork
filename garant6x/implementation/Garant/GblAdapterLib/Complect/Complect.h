////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/Complect/Complect.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Complect
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_COMPLECT_H__
#define __GARANT6X_GBLADAPTERLIB_COMPLECT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchDefines/SearchDefines.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

enum ComplectType {
	CT_INTERNAL
	, CT_LOCAL
	, CT_NET_ONE_USER
	, CT_NET_MANY_USERS
};

class ComplectInfoNode;
typedef ::Core::Var<ComplectInfoNode> ComplectInfoNode_var;
typedef ::Core::Var<const ComplectInfoNode> ComplectInfoNode_cvar;
// Нода информации о комплекте
class ComplectInfoNode
	: virtual public NodeBase
{
public:
	virtual const GCI::IO::String* get_info () const = 0;
	virtual GCI::IO::String* get_info () = 0;
};

/// factory interface for ComplectInfoNode
class ComplectInfoNodeFactory {
public:
	static ComplectInfoNode* make (FakeFacetForFactory* owner_tree, const GTree::Node& snode)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

struct VisualRepresentation {
	GCI::IO::String_var name;
	char percent;
};

#pragma pack (pop)

typedef std::vector < VisualRepresentation > VisualRepresentationList;

class ComplectInfo;
typedef ::Core::Var<ComplectInfo> ComplectInfo_var;
typedef ::Core::Var<const ComplectInfo> ComplectInfo_cvar;
// Интерфейс получение информации о текущем комплекте баз.
class ComplectInfo
	: virtual public ::Core::IObject
{
public:
	virtual ComplectType get_type () const = 0;

	virtual const GCI::IO::String* get_owner  () const = 0;
	virtual GCI::IO::String* get_owner  () = 0;

	virtual const GCI::IO::String* get_dealer_info () const = 0;
	virtual GCI::IO::String* get_dealer_info () = 0;

	virtual const GCI::IO::String* get_old_base_warning () const = 0;
	virtual GCI::IO::String* get_old_base_warning () = 0;

	virtual const NodeBase* get_info  () const
		/*throw (CanNotFindData)*/ = 0;
	virtual NodeBase* get_info  ()
		/*throw (CanNotFindData)*/ = 0;

	virtual const GCI::IO::String* get_unexist_doc_message () const = 0;
	virtual GCI::IO::String* get_unexist_doc_message () = 0;

	virtual VisualRepresentationList* get_visual_representation_data () const = 0;
};

/// factory interface for ComplectInfo
class ComplectInfoFactory {
public:
	static ComplectInfo* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::ComplectInfoNode> {
	typedef GblAdapterLib::ComplectInfoNodeFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::ComplectInfo> {
	typedef GblAdapterLib::ComplectInfoFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_COMPLECT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
