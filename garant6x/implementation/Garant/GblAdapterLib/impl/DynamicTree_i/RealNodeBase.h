////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::RealNodeBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_REALNODEBASE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_REALNODEBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "shared/GCL/data/StaticNode.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garantServer/src/Global/Core/GTreeC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DefaultNodeBase.h"

//#UC START# *45F7D8410157_CUSTOM_INCLUDES*
#define LOCAL_TRANSACTION NodeChangeTransactionHolder local_transaction_ (this);
//#UC END# *45F7D8410157_CUSTOM_INCLUDES*

// forward decls for defined friends
namespace GblAdapterLib {
	class DelegateNodeBase;
} // namespace GblAdapterLib

namespace GblAdapterLib {
	class TreeBase;
} // namespace GblAdapterLib


namespace GblAdapterLib {

class RealNodeBase;
typedef Core::Var<RealNodeBase> RealNodeBase_var;
typedef Core::Var<const RealNodeBase> RealNodeBase_cvar;

class RealNodeBase :
	virtual public DefaultNodeBase
{
	friend class DelegateNodeBase; // defined friend
	friend class TreeBase; // defined friend

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	class NodeChangeTransaction {
		SET_OBJECT_COUNTER (NodeChangeTransaction)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		explicit NodeChangeTransaction (RealNodeBase* node);

	public:
		virtual ~NodeChangeTransaction ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self methods
	public:
		virtual void close ();

		virtual void open ();

		virtual void set_entity (const GTree::NodeEntity& entity);

		virtual void set_name (const char* name);

		virtual const GTree::NodeValueData& set_value ();

		virtual const GTree::ChangeNodeData& transaction_data () const;

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		unsigned long m_nested_count;

		RealNodeBase* m_node;

		GTree::ChangeNodeData m_transaction_data;
	}; // class NodeChangeTransaction

	class NodeChangeTransactionHolder {
		SET_OBJECT_COUNTER (NodeChangeTransactionHolder)
	//////////////////////////////////////////////////////////////////////////////////////////
	// constructors and destructor
public:
		explicit NodeChangeTransactionHolder (RealNodeBase* node);

	public:
		virtual ~NodeChangeTransactionHolder ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
	private:
		NodeChangeTransaction* m_transaction;
	}; // class NodeChangeTransactionHolder

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	RealNodeBase (TreeBase* owner_tree, const GTree::Node& snode);

protected:
	RealNodeBase ();

public:
	virtual ~RealNodeBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual void apply_transaction ();

	virtual void change_node_entity (const GTree::NodeEntity& entity);

	virtual void change_node_value (const GTree::NodeValueData& value);

	virtual void commit_and_remove_transaction ();

	virtual void delete_current_transaction ();

	virtual void draw_node (unsigned int level, unsigned int index) const;

	virtual void fill_entity (const GTree::NodeEntity& entity);

	virtual void fill_value (GTree::NodeValueData& value);

	virtual NodeChangeTransaction* get_current_transaction ();

	virtual void init (TreeBase* owner_tree);

	virtual void init_inserted (TreeBase* owner, const GTree::CreateData& data);

	virtual bool is_equal (const GCL::StaticNode* e);

	virtual void paste_node (GTree::PositionType ptype, DefaultNodeBase* node);

	virtual void paste_nodes (GTree::PositionType ptype, GTree::NodeHolder* holder) const;

	virtual void reset (const TreeBase* owner_tree);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	Core::Box<NodeChangeTransaction> m_current_transaction;

	GCI::IO::String_var m_name;

	GTree::NodePointer m_server_point;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
protected:
	virtual const GCI::IO::String* get_name () const;

	virtual void set_name (GCI::IO::String* name);

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

//#UC START# *45F7D8410157*
//#UC END# *45F7D8410157*
}; // class RealNodeBase

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_REALNODEBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

