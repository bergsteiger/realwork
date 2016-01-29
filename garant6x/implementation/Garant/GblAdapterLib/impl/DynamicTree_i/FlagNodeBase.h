////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FlagNodeBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::FlagNodeBase
//
// нода с флагами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_FLAGNODEBASE_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_FLAGNODEBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCL/data/StaticNode.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DynamicTree_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTreeDefines/DynamicTreeDefines.h"

//#UC START# *45F52C0602BF_CUSTOM_INCLUDES*
//#UC END# *45F52C0602BF_CUSTOM_INCLUDES*

namespace GblAdapterLib {

// нода с флагами
class FlagNodeBase;
typedef Core::Var<FlagNodeBase> FlagNodeBase_var;
typedef Core::Var<const FlagNodeBase> FlagNodeBase_cvar;

class FlagNodeBase :
	virtual public GCL::StaticNode
{
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FlagNodeBase ();

public:
	virtual ~FlagNodeBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// // TODO: hide in cache
	virtual size_t all_visible_children_count () const;

	virtual FlagMask get_flags () const;

	virtual GCL::StaticNode* get_my_parent () const;

	virtual FlagNodeBase* get_node_by_visible_index (VisibleIndex index);

	virtual bool has_flag (FlagMask flag) const;

	virtual bool is_visible () const;

	virtual void make_visible ();

	virtual FlagNodeBase* next_one_level (long& shift_counter, GCL::StaticNode_var& for_constructed) const;

	virtual FlagNodeBase* next_visible (
		long& shift_counter
		, GCL::StaticNode_var& for_constructed
		, bool skip_stub = false
	) const;

	virtual FlagNodeBase* next_with_flag (FlagMask flag, bool skip_stub = false) const;

	virtual FlagNodeBase* plane_next (
		long& shift_counter
		, GCL::StaticNode_var& for_constructed
		, bool skip_stub = false
	) const;

	virtual FlagNodeBase* plane_next_back (
		long& shift_counter
		, GCL::StaticNode_var& for_constructed
		, bool skip_stub = false
	) const;

	virtual FlagNodeBase* prev_one_level (long& shift_counter, GCL::StaticNode_var& for_constructed) const;

	virtual FlagNodeBase* prev_visible (
		long& shift_counter
		, GCL::StaticNode_var& for_constructed
		, bool skip_stub = false
	) const;

	virtual FlagNodeBase* prev_visible_stop (
		long& shift_counter
		, GCL::StaticNode_var& for_constructed
		, bool skip_stub = false
	);

	virtual bool set_flag (FlagMask flag, bool value, bool with_notify);

	virtual void set_my_parent (GCL::StaticNode* parent);


//////////////////////////////////////////////////////////////////////////////////////////
// abstarct methods
public:
	// возвращает количество взведённых (изменённых?) флагов.
	virtual size_t internal_set_all_flag (FlagMask flag, bool value, bool children_only) = 0;

	virtual size_t internal_set_all_flag_except_first_children_of_root_children (
		FlagMask flag
		, bool value
		, bool children_only
	) = 0;

	virtual void set_all_flag (FlagMask flag, bool value, bool with_notify) = 0;

	virtual void set_all_flag_except_first_children_of_root_children (FlagMask flag, bool value, bool with_notify) = 0;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	FlagMask m_flags;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	virtual void set_flags (FlagMask flags);

//#UC START# *45F52C0602BF*
	const unsigned short* idptr () const {
		return &m_flags;
	}
//#UC END# *45F52C0602BF*
}; // class FlagNodeBase

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_FLAGNODEBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

