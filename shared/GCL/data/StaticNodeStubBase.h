////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/data/StaticNodeStubBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::GCL::data::StaticNodeStubBase
//
// базовый класс для StaticNodeStub
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_DATA_STATICNODESTUBBASE_H__
#define __SHARED_GCL_DATA_STATICNODESTUBBASE_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/StaticNode.h"

//#UC START# *450136B500FA_CUSTOM_INCLUDES*
//#UC END# *450136B500FA_CUSTOM_INCLUDES*

namespace GCL {

// базовый класс для StaticNodeStub
class StaticNodeStubBase;
typedef Core::Var<StaticNodeStubBase> StaticNodeStubBase_var;
typedef Core::Var<const StaticNodeStubBase> StaticNodeStubBase_cvar;

class StaticNodeStubBase :
	virtual public StaticNode
{
	SET_OBJECT_COUNTER (StaticNodeStubBase)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~StaticNodeStubBase ();


//#UC START# *450136B500FA*
	virtual long stub_count () const = 0;
	virtual long stub_ind () const = 0;
	virtual bool has_pair () const = 0;
	virtual StaticNodeStubBase* const get_at (long ind) const = 0;

	virtual StaticNode* transform_to_real_node () = 0;
	void transform_to_real_node (
		StaticNode* real_node
		, StaticNodeStubBase* prev_sibbling_stub
		, StaticNodeStubBase* next_sibbling_stub
	) {
		if (!real_node) {
			GDS_ASSERT (real_node);
			return;
		}
		GDS_ASSERT (!m_real_node);
		/*LOG_D ((
			"transform_to_real_node (%d,%d) prev(%d,%d) next (%d,%d)"
			, this->stub_count()
			, this->stub_ind()
			, prev_sibbling_stub ? prev_sibbling_stub->stub_count() : 0
			, prev_sibbling_stub ? prev_sibbling_stub->stub_ind() : 0
			, next_sibbling_stub ? next_sibbling_stub->stub_count() : 0
			, next_sibbling_stub ? next_sibbling_stub->stub_ind() : 0
		));

		bool need_print = true;*/
		/*if (next_sibbling_stub && next_sibbling_stub->stub_count() > 0 && next_sibbling_stub->stub_ind() == 1) {
			this->print_tree();
			need_print = true;
		}*/
									
		m_real_node = StaticNode::_duplicate(real_node);
		this->correct_tree (prev_sibbling_stub, next_sibbling_stub);

		/*if (need_print) {
			LOG_D (("TREE SNAP after transform_to_real_node (...)"));
			m_real_node->print_tree();
		}*/
	}

protected:
	StaticNodeStubBase() : m_real_node(0) {
	}

	const StaticNode* child_by_index (unsigned long index) const {
		if (!m_real_node) {
			m_real_node = const_cast<StaticNodeStubBase*>(this)->transform_to_real_node ();
		}
		return m_real_node->child_by_index (index);
	}

	inline GCL::StaticNode* real_node_prev () const {
		return m_real_node->m_prev;
	}

	inline GCL::StaticNode_var& real_node_next () const {
		return m_real_node->m_next;
	}

	virtual void correct_tree (StaticNodeStubBase* prev_sibbling_stub, StaticNodeStubBase* next_sibbling_stub) = 0;

protected:
	mutable StaticNode* m_real_node;

//#UC END# *450136B500FA*
}; // class StaticNodeStubBase

} // namespace GCL


#endif //__SHARED_GCL_DATA_STATICNODESTUBBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

