////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FlagNodeStub.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::FlagNodeStub
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_FLAGNODESTUB_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_FLAGNODESTUB_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCL/data/StaticNode.h"
#include "shared/GCL/data/StaticNodeStub.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FlagNodeBase.h"

//#UC START# *45F6CDFF01C5_CUSTOM_INCLUDES*
namespace GblAdapterLib {
	class FlagNodeStub;
}

namespace Core {
template<>
struct PoolObjectTraits<GblAdapterLib::FlagNodeStub> {
	typedef Core::NewDeletePolicy<GblAdapterLib::FlagNodeStub> CreationDestructionPolicy;
};
}
//#UC END# *45F6CDFF01C5_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class FlagNodeStub;
typedef Core::Var<FlagNodeStub> FlagNodeStub_var;
typedef Core::Var<const FlagNodeStub> FlagNodeStub_cvar;

class FlagNodeStub :
	virtual public GCL::StaticNodeStub<FlagNodeStub>
	, virtual public FlagNodeBase
{
	SET_OBJECT_COUNTER (FlagNodeStub)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	FlagNodeStub ();

public:
	~FlagNodeStub ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	GCL::StaticNode* remove_me_and_siblings (unsigned long& count);


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
public:

	// implemented method from FlagNodeBase
	// возвращает количество взведённых (изменённых?) флагов.
	size_t internal_set_all_flag (FlagMask flag, bool value, bool children_only);

	// implemented method from FlagNodeBase
	size_t internal_set_all_flag_except_first_children_of_root_children (FlagMask flag, bool value, bool children_only);

	// implemented method from FlagNodeBase
	void set_all_flag (FlagMask flag, bool value, bool with_notify);

	// implemented method from FlagNodeBase
	void set_all_flag_except_first_children_of_root_children (FlagMask flag, bool value, bool with_notify);
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods
public:

	// overloaded method from FlagNodeBase
	FlagNodeBase* next_one_level (long& shift_counter, GCL::StaticNode_var& for_constructed) const;

	// overloaded method from FlagNodeBase
	FlagNodeBase* next_visible (long& shift_counter, GCL::StaticNode_var& for_constructed, bool skip_stub = false) const;

	// overloaded method from FlagNodeBase
	FlagNodeBase* plane_next (long& shift_counter, GCL::StaticNode_var& for_constructed, bool skip_stub = false) const;

	// overloaded method from FlagNodeBase
	FlagNodeBase* plane_next_back (
		long& shift_counter
		, GCL::StaticNode_var& for_constructed
		, bool skip_stub = false
	) const;

	// overloaded method from FlagNodeBase
	FlagNodeBase* prev_one_level (long& shift_counter, GCL::StaticNode_var& for_constructed) const;

	// overloaded method from FlagNodeBase
	FlagNodeBase* prev_visible (long& shift_counter, GCL::StaticNode_var& for_constructed, bool skip_stub = false) const;

	// overloaded method from FlagNodeBase
	FlagNodeBase* prev_visible_stop (long& shift_counter, GCL::StaticNode_var& for_constructed, bool skip_stub = false);

	// overloaded method from FlagNodeBase
	bool set_flag (FlagMask flag, bool value, bool with_notify);


//#UC START# *45F6CDFF01C5*
public:
	virtual void init (const SharedData_box& data, long ind, const StaticNode* master);
	
	virtual void draw_node (unsigned level, unsigned index) const {
		char buf [1024];
		
		unsigned i=0;
		for(; i < level; i++) {
			sprintf (buf+i, "\t");
		}
		sprintf (buf+i, "%d: FlagNodeStub[0x%X] - (%d, %d), flags: %d", index, this->idptr (), m_data->stub_count, m_ind, this->get_flags ());
		LOG_D ((buf));	
	}

//#UC END# *45F6CDFF01C5*
}; // class FlagNodeStub

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_FLAGNODESTUB_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

