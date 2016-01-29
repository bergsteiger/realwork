////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::DelegateNodeBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_DELEGATENODEBASE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_DELEGATENODEBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DefaultNodeBase.h"

// forward decls for defined friends
namespace GblAdapterLib {
	class DefaultNodeBase;
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class RealNodeBase;
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class TreeBase;
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class ViewBase;
} // namespace GblAdapterLib


namespace GblAdapterLib {

class DelegateNodeBase;
typedef Core::Var<DelegateNodeBase> DelegateNodeBase_var;
typedef Core::Var<const DelegateNodeBase> DelegateNodeBase_cvar;

class DelegateNodeBase :
	virtual public DefaultNodeBase
{
	friend class DefaultNodeBase; // defined friend
	friend class RealNodeBase; // defined friend
	friend class TreeBase; // defined friend
	friend class ViewBase; // defined friend
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit DelegateNodeBase (TreeBase* owner_tree);

public:
	virtual ~DelegateNodeBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual void draw_node (unsigned int level, unsigned int index) const;

protected:
	virtual RealNodeBase* cached_master_node ();

	virtual const RealNodeBase* cached_master_node () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	bool m_has_filtered_children;

	RealNodeBase_var m_master_node;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	virtual void set_master_node (RealNodeBase* master_node);
protected:
	virtual bool get_has_filtered_children () const;

	virtual void set_has_filtered_children (bool has_filtered_children);

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from DefaultNodeBase
	virtual GTree::NodePointer get_server_pointer () const;

	// implemented method from DefaultNodeBase
	virtual const char* node_name () const;
protected:

	// implemented method from DefaultNodeBase
	virtual bool apply_change_delta (GTree::ChangeDelta& delta);
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from FlagNodeBase
	virtual FlagMask get_flags () const;

	// overloaded method from FlagNodeBase
	virtual bool has_flag (FlagMask flag) const;

	// overloaded method from FlagNodeBase
	virtual void set_all_flag (FlagMask flag, bool value, bool with_notify);

	// overloaded method from FlagNodeBase
	virtual bool set_flag (FlagMask flag, bool value, bool with_notify);
protected:

	// overloaded method from DefaultNodeBase
	virtual unsigned long get_first_level_children_flag_count (FlagMask flag) const;

	// overloaded method from DefaultNodeBase
	virtual unsigned long get_flag_count (FlagMask flag) const;

	// overloaded method from DefaultNodeBase
	virtual bool has_children_flag (FlagMask flag) const;

	// overloaded method from DefaultNodeBase
	virtual bool has_parent_flag (FlagMask flag) const;

}; // class DelegateNodeBase

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_DELEGATENODEBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

