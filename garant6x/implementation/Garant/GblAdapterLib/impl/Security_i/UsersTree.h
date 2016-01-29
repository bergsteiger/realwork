////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UsersTree.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::Security_i::UsersTree
//
// Дерево  пользователей
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERSTREE_H__
#define __GARANT6X_GBLADAPTERLIB_SECURITY_I_USERSTREE_H__

#include "shared/CoreSrv/sys/std_inc.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNodeDelegate_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/Tree.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNode_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Security_i/UserNodeDelegate.h"

namespace GblAdapterLib {

// Дерево  пользователей
class UsersTree;
typedef Core::Var<UsersTree> UsersTree_var;
typedef Core::Var<const UsersTree> UsersTree_cvar;

class UsersTree :
	virtual public Tree<UserNode_i, UserNodeDelegate>
{
	SET_OBJECT_COUNTER (UsersTree)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit UsersTree (GTree::Tree* tree);

public:
	virtual ~UsersTree ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual void register_listener (UserProfile* profile);

}; // class UsersTree

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_SECURITY_I_USERSTREE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

