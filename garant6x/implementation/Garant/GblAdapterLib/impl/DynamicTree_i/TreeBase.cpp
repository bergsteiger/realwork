////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::DynamicTree_i::TreeBase
//
// адаптерное дерево
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/TreeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ViewBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DefaultNodeBase.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ContextFilter_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ContextFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/ListSortTypeTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/SortOrderTranslator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/QueryFilter_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/QueryFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CountryFilter_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CountryFilter_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/Security.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Security/SecurityFactories.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Convertors/ServerAdapterConverters.h"
// by <<friend>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/RealNodeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DelegateNodeBase.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/DefaultNodeBase.h"

//#UC START# *45F554750213_CUSTOM_INCLUDES*
// гнусный хак см. NodeNotifierHack
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree_tie.h"
//#include "garant6x/implementation/Garant/GblAdapterLib/impl/DocTree_i/DocTagView.h"
//#UC END# *45F554750213_CUSTOM_INCLUDES*

namespace GblAdapterLib {

//#UC START# *45F554750213*
	// Класс-хак, который держит оболочечный инетрфейс, не увеличивая на нём счётчик ссылок.
	// Нужен из-за циклической зависимости:
	// RealNodeBase держит TreeBase
	// TreeBase держит NodeNotifier
	// NodeNotifier держит RealNodeBase
	class NodeNotifierHack : public NodeNotifier_callback_tie {
	public:
		NodeNotifierHack (NodeNotifier_callback_tie* tie) {
			m_impl = tie->m_impl;
		}

		~NodeNotifierHack () {}

		unsigned long release () const {
			long const counter = --m_counter;

			if (counter == 0) {
				delete this;
			}
			return counter;
		}
	};
//#UC END# *45F554750213*

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation

const char* TreeBase::InvalidOwnerTree::uid () const /*throw ()*/ {
	return "43B22366-293E-4ABD-992F-965CECEFED76";
}

const char* TreeBase::InvalidOwnerTree::what () const throw () {
	//#UC START# *45F55A3802BF_WHAT_IMPL*
	return "InvalidOwnerTree ()";
	//#UC END# *45F55A3802BF_WHAT_IMPL*
}




const char* TreeBase::EmptyBranch::uid () const /*throw ()*/ {
	return "E4DDC874-00AD-4BCE-A380-AA5400930E46";
}

const char* TreeBase::EmptyBranch::what () const throw () {
	//#UC START# *45F55A6A0138_WHAT_IMPL*
	return "EmptyBranch ()";
	//#UC END# *45F55A6A0138_WHAT_IMPL*
}



//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

TreeBase::TreeBase (bool active_changeable)
//#UC START# *45F56FDC0271_BASE_INIT*
	: m_load_block_half_size (30)
	, m_load_in_one_direction (false)
	, m_selected_count (0)
	, m_root(0)
	, m_changed_layer(false)
	, m_server_data_version (0) 
	, m_active_changeble (active_changeable) 
	, m_is_changed (false)
	, m_all_expanded (false)
#ifdef _USE_FIRST_DROP_SELECTION_HACK
	, m_first_drop_selection (true)
#endif
//#UC END# *45F56FDC0271_BASE_INIT*
{
	//#UC START# *45F56FDC0271_BODY*
	//#UC END# *45F56FDC0271_BODY*
}

TreeBase::TreeBase ()
//#UC START# *46011A0C0109_BASE_INIT*
	: m_load_block_half_size (30)
	, m_load_in_one_direction (false)
	, m_selected_count (0)
	, m_root(0)
	, m_changed_layer(false)
	, m_server_data_version (0) 
	, m_active_changeble (false) 
	, m_is_changed (false)
	, m_all_expanded (false)												
#ifdef _USE_FIRST_DROP_SELECTION_HACK
	, m_first_drop_selection (true)
#endif
//#UC END# *46011A0C0109_BASE_INIT*
{
	//#UC START# *46011A0C0109_BODY*
	//#UC END# *46011A0C0109_BODY*
}

TreeBase::~TreeBase () {
	//#UC START# *45F554750213_DESTR_BODY*
	//#UC END# *45F554750213_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void TreeBase::adapter_filters_to_server (FilterList& adap, GTree::Query& serv) const {
	//#UC START# *46011A8101C5*
	for (size_t i = 0; i < adap.size (); i++) {
		// name filter
		if (ContextFilter* nf = dynamic_cast<ContextFilter*> (adap[i].ptr ())) {
			GCI::IO::String& s = nf->get_context ();
			if (s.get_length ()) {
				GTree::NameFilter* s_nf = new OBV_GTree::NameFilter ();
				s_nf->name_context (s.get_data ());
				s_nf->area (ServerAdapterConverters::adapter_to_server (nf->get_area ()));
				s_nf->order (ServerAdapterConverters::adapter_to_server (nf->get_order ()));
				s_nf->place (ServerAdapterConverters::adapter_to_server (nf->get_place ()));
				serv.length (serv.length () + 1);
				serv[serv.length () - 1] = s_nf;
			}
			continue;
		}
		
		// layer filter
		if (LayerFilter* lf = dynamic_cast<LayerFilter*>(adap[i].ptr ())) {
			GTree::LayerFilter* s_lf = new OBV_GTree::LayerFilter ();
			s_lf->layer (static_cast<unsigned char>(lf->get_layer()));
			serv.length(serv.length()+1);
			serv[serv.length()-1] = s_lf;
			continue;
		}		

		// trim filter
		if (TrimFilter* tf = dynamic_cast<TrimFilter*>(adap[i].ptr ())) {
			continue;
		}		

		// trim leaf filter
		if (TrimLeafFilter* tlf = dynamic_cast<TrimLeafFilter*>(adap[i].ptr ())) {
			continue;
		}		


		// sort filter
		if (SortFilter* sf = dynamic_cast<SortFilter*>(adap[i].ptr ())) {
			GTree::SortFilter* root_s_sf = new OBV_GTree::SortFilter ();
			GTree::SortFilter* s_sf = root_s_sf;
			while (sf) {
				s_sf->type (ListSortTypeTranslatorSingleton::instance ()->get (sf->get_type ()));
				s_sf->order (SortOrderTranslatorSingleton::instance ()->get (sf->get_order ()));
				const SortFilter* sub_filter = sf->get_sub_filter ();
				if (sub_filter) {
					s_sf->sub_filter (new OBV_GTree::SortFilter ());
					s_sf = s_sf->sub_filter ();
				} else {
					break;
				}
			}
			serv.length (serv.length() + 1);
			serv[serv.length()-1] = root_s_sf;
			continue;
		}
		
		// user tree filter
		if (UserFilter* uf = dynamic_cast<UserFilter*>(adap[i].ptr ())) {
			GslUserManager::UserFilter* s_uf = new OBV_GslUserManager::UserFilter ();
			s_uf->flags (uf->get_flags ());

			GCD::Uid uid = 0xFFFFFFFF;
			if (uf->get_flags () & (UFF_USER_NOT_CURRENT | UFF_CHAT_CONTACT_LIST_USERS)) {
				try {
					uid = ApplicationHelper::instance ()->get_cached_user_manager ()->get_current_user_id ();
					GDS_ASSERT (uid && "using adapter without session");
				} catch (CORBA::SystemException&) {					
				}
			}
			s_uf->current_uid (uid);
			s_uf->group_id (uf->get_group_uid ());

			serv.length (serv.length() + 1);
			serv[serv.length()-1] = s_uf;
			continue;
		}

		if (DocNodeFilter* dnf = dynamic_cast<DocNodeFilter*>(adap[i].ptr ())) {
			GblPilot::DocNodeFindFilter* s_dnf = new OBV_GblPilot::DocNodeFindFilter ();
			s_dnf->id (dnf->get_id ());
			s_dnf->type (static_cast <GblPilot::DocNodeType>(dnf->get_type ()));
			s_dnf->inheritable (dnf->get_inheritable ());
			serv.length (serv.length () + 1);
			serv [serv.length() - 1] = s_dnf;
			continue;
		}
		
		// query filter
		if (QueryFilter* qf = dynamic_cast<QueryFilter*> (adap[i].ptr ())) {
			GblPilotQueryDef::QueryFilter* value = new OBV_GblPilotQueryDef::QueryFilter ();
			value->filter_list (qf->query_list ());
			serv.length (serv.length () + 1);
			serv [serv.length() - 1] = value;
			continue;
		}

		// country filter
		if (CountryFilter* cf = dynamic_cast<CountryFilter*> (adap[i].ptr ())) {
			GblPilot::CountryFilter* value = new OBV_GblPilot::CountryFilter ();
			const DefaultNodeBase* country = dynamic_cast<const DefaultNodeBase*>(cf->get_country ());
			if (country) {
				GTree::NodePath_var path = country->get_server_path();
				value->country (path.in ());
				serv.length (serv.length () + 1);
				serv [serv.length() - 1] = value;
			}
			continue;
		}

		// filter for leaf cutting
		if (CutToLeafCountFilter* cf = dynamic_cast<CutToLeafCountFilter*> (adap[i].ptr ())) {
			GblPilotQueryDef::CutToLeafCountFilter* value = new OBV_GblPilotQueryDef::CutToLeafCountFilter ();
			value->leaf_count (cf->get_leaf_count ());
			serv.length (serv.length () + 1);
			serv [serv.length() - 1] = value;
			continue;
		}

		// filter for variants in basic search
		if (VariantsForDocFilter* dvf = dynamic_cast<VariantsForDocFilter*> (adap[i].ptr ())) {
			GblPilotQueryDef::DocIdVariantsFilter* value = new OBV_GblPilotQueryDef::DocIdVariantsFilter ();
			value->doc_id (dvf->get_doc_id () ? dvf->get_doc_id () + GblPilotDef::GEMMOROI_IZ_ZA_100000 : 0);
			serv.length (serv.length () + 1);
			serv [serv.length() - 1] = value;
			continue;
		}

		// nonsearchable blocks filter
		if (BlocksFilter* bf = dynamic_cast<BlocksFilter*> (adap[i].ptr ())) {
			GblPilotQueryDef::BlocksFilter* value = new OBV_GblPilotQueryDef::BlocksFilter ();
			serv.length (serv.length () + 1);
			serv [serv.length() - 1] = value;
			continue;
		}

		// inpharm block filter
		if (InpharmFilter* bf = dynamic_cast<InpharmFilter*> (adap[i].ptr ())) {
			GblPilotQueryDef::InpharmFilter* value = new OBV_GblPilotQueryDef::InpharmFilter ();
			serv.length (serv.length () + 1);
			serv [serv.length() - 1] = value;
			continue;
		}
	}	
	//#UC END# *46011A8101C5*
}

void TreeBase::add_notifier (GCL::StaticNode* root, NodeNotifier* notifier) {
	//#UC START# *46011F130203*
	//SLOG_SHIFT
	//SLOG_D (("%s [0x%X]: (0x%X) on node [0x%X]", GDS_CURRENT_FUNCTION, this, notifier, root));

	GDS_ASSERT (notifier);
	GDS_ASSERT (m_notifiers.find (notifier->get_id ()) == m_notifiers.end ());

	//SLOG_D (("%s [%d]: m_counter_deltas.clear()", GDS_CURRENT_FUNCTION, this));
	m_counter_deltas.clear (); //reset all initial counter deltas
	
	unsigned long visible_count;
	
	if (notifier->is_one_level ()) {		
		visible_count = dynamic_cast<FlagNodeBase*>(root)->children_count();
		//SLOG_D (("TreeBase[0x%X]::add_notifier: root->children_count () = %d", this, visible_count));					
	} else {
		if (dynamic_cast<FlagNodeBase*>(root)->has_flag (FM_OPEN)) {
			visible_count = dynamic_cast<FlagNodeBase*>(root)->all_visible_children_count();
			//SLOG_D (("%s [0x%X]: root->all_visible_children_count () = %d", GDS_CURRENT_FUNCTION, this, visible_count));
		} else {
			visible_count = 0;
			//SLOG_D (("%s [0x%X]: skip - root closed", GDS_CURRENT_FUNCTION, this));
		}
	}	

	if (notifier->is_root_visible ()) {
		visible_count++;
	}
		
	//SLOG_D (("%s [0x%X]: [0x%X]->change_children_count(0, %d)", GDS_CURRENT_FUNCTION, this, notifier, visible_count));
	notifier->change_children_count (0, visible_count, NodeIndexPath (), 0);
	GDS_ASSERT (dynamic_cast<NodeNotifier_callback_tie*> (notifier));
	m_notifiers[notifier->get_id ()] = new NodeNotifierHack (dynamic_cast<NodeNotifier_callback_tie*> (notifier));
	//#UC END# *46011F130203*
}

void TreeBase::add_to_loaded (RealNodeBase* node) {
	//#UC START# *460127420261*
	assert (node);
	m_nodes [node->get_server_pointer()] = node;
	//#UC END# *460127420261*
}

// [timestamp_sync]
void TreeBase::apply_delta_postprocess (GTree::Delta& fake) {
	//#UC START# *4601391C032C*
	this->set_changed (true);
	//#UC END# *4601391C032C*
}

void TreeBase::apply_flags (const FlagNodeBase* from, FlagNodeBase* to, FlagMask shared_mask) const {
	//#UC START# *460124430251*
	for (NodeFlagMap::const_iterator it = m_flags_map.begin(); it != m_flags_map.end(); it++) {
		if ((from->get_flags() & it->first) == it->first) {
			if (shared_mask & it->first) {
				//to->set_flag (it->first, true, false);
				to->set_flags (it->first);
			}
		}
	}
	//#UC END# *460124430251*
}

void TreeBase::apply_server_tree (GTree::Tree* server_tree) {
	//#UC START# *4601257D0148*
	if (m_server_tree.ptr() && m_active_changeble) {
		this->unregister_object ();
	}

	m_server_tree = GTree::Tree::_duplicate(server_tree);
	
	if (m_active_changeble) {
		::TimeStampSync::TimeStampObjectID id = m_server_tree->timestamp_object_id ();
		this->register_object (id);
	}
	//#UC END# *4601257D0148*
}

void TreeBase::bidir_calc_from_position (
	long offset
	, GTree::NodePointer child_point
	, GCL::StaticNodeStubBase* current_stub
	, long& from
	, unsigned long& in_block_position
) {
	//#UC START# *4601193400EA*
	if (offset >= 0) {
		if (offset > this->get_load_block_half_size ()) {
			from = offset - this->get_load_block_half_size ();
			in_block_position = this->get_load_block_half_size ();
			if (child_point == GTree::FIRST_CHILD_POINT && current_stub && current_stub->stub_count() < 0) {
				in_block_position--; //first
			}
		} else {
			if (child_point == GTree::FIRST_CHILD_POINT) {
				from = 0;				
				in_block_position = offset;

				if (current_stub && current_stub->stub_count() < 0) {
					in_block_position--; //second
				}
			} else {
				from = 1;
				GDS_ASSERT (offset != 0);
				in_block_position = offset - 1;

				if (current_stub && current_stub->stub_count() < 0) {
					//LOG_D (("not correct???"));
				}
			}
		}
	} else {
		//if (child_point == GTree::FIRST_CHILD_POINT) // - !!!!
			
		if (-offset > this->get_load_block_half_size ()) {
			from = offset + this->get_load_block_half_size ();
			in_block_position = -static_cast<long>(this->get_load_block_half_size ());
		} else {
			from = offset;
			in_block_position = offset;
		}
	} 
	//#UC END# *4601193400EA*
}

GCL::StaticNode* TreeBase::build_node (const GTree::Node& snode, FlagNodeBase* current_stub, long master_index) {
	//#UC START# *46012315033C*
	//SLOG_SHIFT

	NodeMap::iterator f = m_nodes.find (snode.pointer);
	if (f != m_nodes.end()) {
		return GCL::StaticNode::_duplicate (f->second);
	}
	
	DefaultNodeBase_var ret = this->alloc_new_node (snode);
	
	if (current_stub) { // setup parent
		DefaultNodeBase* stub_parent = dynamic_cast<DefaultNodeBase*>(current_stub->get_my_parent());
		GDS_ASSERT (stub_parent);
		
		if (stub_parent->owner_tree () != this) { // build for foreign delegate node
			DelegateNodeBase* nd = dynamic_cast<DelegateNodeBase*>(stub_parent);
			GDS_ASSERT (nd);
			dynamic_cast<FlagNodeBase*>(ret.ptr())->set_my_parent (nd->cached_master_node ());

			{ // if we have stubs with flag
				// find our master stub					
				
				FlagNodeStub* master_stub = nd->cached_master_node ()->find_stub_for_index (master_index);
				if (!master_stub) {
					return 0;
				}
				short master_flags = master_stub->get_flags ();

				if (master_index) {
					GCL::StaticNodeStubBase_var new_stub = master_stub->get_at(master_index);
					new_stub->transform_to_real_node(ret.ptr (), 0, 0);
				} else {
					GCL::StaticNodeStubBase* stub = master_stub;
					stub->transform_to_real_node(ret.ptr (), 0, 0);
				}
				
				// copy (or apply?) flags from stub to new node
				ret->set_flags (master_flags);
			}
		} else {
			dynamic_cast<FlagNodeBase*>(ret.ptr())->set_my_parent (stub_parent);
			
			this->apply_flags (
				dynamic_cast<FlagNodeBase*>(current_stub)
				, ret.ptr ()
				, snode.master_children_count ? FM_SHARED_ALL : FM_SHARED_ALL & ~FM_OPEN // suppres OPEN flag for leaf
			);
		}
	}

	if (snode.master_children_count) {
		//SLOG_D (("%s [%d] [%d,%d]: insert stubs children (%d)", GDS_CURRENT_FUNCTION, this, (StaticNode*)ret, ret->get_server_pointer(), snode.master_children_count));
		if (m_all_expanded) {
			current_stub->has_flag (FM_SELECTION)
				? FlagNodeStub::make_as_back_child (ret.ptr (), snode.master_children_count, this, FlagMaskStubPostProcess (FM_SELECTION, true))
				:	FlagNodeStub::make_as_back_child (ret.ptr (), snode.master_children_count, this, GCL::NullStubPostProcess ())
			;
			ret->set_flag (FM_OPEN, true, true);
		} else {
			FlagNodeStub::make_as_back_child (ret.ptr (), snode.master_children_count, this, GCL::NullStubPostProcess ());
		}
	}

	this->add_to_loaded (dynamic_cast<RealNodeBase*>(ret.ptr()));
	return ret._retn();
	//#UC END# *46012315033C*
}

void TreeBase::cache_finded_node (const DefaultNodeBase* parent, long index, GCL::StaticNode* node) const {
	//#UC START# *4601246F032C*
	if (node) {
		// [dolgop] видимо до модификации деревьев не могло быть такого, что
		// в адаптерном дереве идёт несколько стабов подряд. Однако сейчас такое вполне
		// возможно (см. http://mdp.garant.ru/x/IzzABQ)
		//FlagNodeStub* ret = dynamic_cast<FlagNodeStub*>(node);
		//GDS_ASSERT (!ret);
		if (index && !dynamic_cast<FlagNodeStub*>(node)) {
			FindedData& fd = m_finded_node [parent];
			fd.index = index;
			fd.node = node;
		}
	}
	//#UC END# *4601246F032C*
}

void TreeBase::calc_from_position (
	long offset
	, GTree::NodePointer child_point
	, GCL::StaticNodeStubBase* current_stub
	, long& from
	, unsigned long& in_block_position
) {
	//#UC START# *460118B20109*
	if (this->is_load_in_one_direction ()) {
		this->onedir_calc_from_position (offset, child_point, current_stub, from, in_block_position);
	} else {
		this->bidir_calc_from_position (offset, child_point, current_stub, from, in_block_position);
	}
	//#UC END# *460118B20109*
}

void TreeBase::change_children_count (
	VisibleIndex index
	, long delta
	, NodeIndexPath& index_path
	, IndexInParent child_index
) {
	//#UC START# *460124F5001F*
	//SLOG_SHIFT
	if (!delta && index != VI_ALL_CHILDREN) {
		return;
	}

	for (NotifierSet::iterator not_it = m_notifiers.begin(); not_it != m_notifiers.end(); not_it++) {
		if (!not_it->second->is_one_level()) { //- looks not good...
			//SLOG_D (("%s [0x%X]: [0x%X]->change_children_count(%d, %d)"
			//	, GDS_CURRENT_FUNCTION
			//	, this
			//	, not_it->second.ptr ()
			//	, index
			//	, delta
			//));
			not_it->second->change_children_count (index, delta, index_path, child_index);
		}		
	}
	//#UC END# *460124F5001F*
}

void TreeBase::changed () const {
	//#UC START# *4601255202FD*
	//SLOG_SHIFT
	for (NotifierSet::const_iterator not_it = m_notifiers.begin(); not_it != m_notifiers.end(); not_it++) {
		if (!not_it->second->is_one_level ()) { //- looks not good...
			//SLOG_D (("%s [%d]: %d->changed()", GDS_CURRENT_FUNCTION, this, *not_it));
			not_it->second->changed ();
		}		
	}
	//#UC END# *4601255202FD*
}

bool TreeBase::changed_layer (bool new_val) const {
	//#UC START# *46012801002E*
	bool ret = m_changed_layer;
	m_changed_layer = new_val;
	return ret;
	//#UC END# *46012801002E*
}

void TreeBase::changing () const {
	//#UC START# *4601254A0186*
	//SLOG_SHIFT
	for (NotifierSet::const_iterator not_it = m_notifiers.begin(); not_it != m_notifiers.end(); not_it++) {
		if (!not_it->second->is_one_level ()) { //- looks not good...
			//SLOG_D (("%s [%d]: %d->changing()", GDS_CURRENT_FUNCTION, this, *not_it));
			not_it->second->changing ();
		}		
	}
	//#UC END# *4601254A0186*
}

void TreeBase::clear () {
	//#UC START# *460127F2000F*
	//SLOG_SHIFT
	this->m_server_data_version = 0;

	unsigned long root_ch_count = m_root->children_count();

	m_root->clear_children();
	m_nodes.clear();
	m_finded_node.clear();
	m_selected_count = 0;
	m_last_select.clear();
	m_flags_map.clear();

	//SLOG_D (("%s [%d] [%d,%d]: insert stubs children (%d)", GDS_CURRENT_FUNCTION, this, (StaticNode*)m_root, 0, root_ch_count));
	FlagNodeStub::make_as_back_child (m_root, root_ch_count, this, GCL::NullStubPostProcess ());
	m_nodes[GTree::ROOT_POINT] = dynamic_cast<DefaultNodeBase*>(m_root);
	//LOG_D (("%s [%d]::clear - end", GDS_CURRENT_FUNCTION, this));
	//#UC END# *460127F2000F*
}

GCL::StaticNode* TreeBase::create_view (
	const GCL::StaticNode* root
	, const GTree::Query& filter
	, FlagMask shared_flags
	, GTree::NodePointer sync_node
	, VisibleIndex& sync_index
	, unsigned int levels
	, bool unfiltered
	, bool auto_open
	, bool truncate_this_view
) {
	//#UC START# *46011FD501A5*
	GDS_ASSERT (root->is_root ());

	GTree::NodePath_var sync_path;
	GTree::Tree_var new_tree;
	
	if (unfiltered || (truncate_this_view && !filter.length ())) {
	
		new_tree = GTree::Tree::_duplicate (m_server_tree);
		GTree::TreeView_var tree_view = GTree::TreeView::_narrow (new_tree);
		if (tree_view) {
			ApplicationHelper::instance ()->get_cached_life_cycle_manager ()->duplicate_object (tree_view.in ());
		} else {
			// на случай, если это не view в деструкторе ViewBase есть заточка [xxx]
		}
		
	} else if (!filter.length ()) {

		if (this->master_tree()->changed_layer (false)) {
			const TreeBase* master_tree = this->master_tree();
			const_cast<TreeBase*>(master_tree)->clear();
		}

		return this->master_tree()->root ();
		
	} else {

		const DefaultNodeBase* node_base_root = dynamic_cast<const DefaultNodeBase*> (root);
		GDS_ASSERT (node_base_root);

		GTree::NodePointer point = node_base_root->get_server_pointer();	
		new_tree = m_server_tree->get_view (point, filter, sync_node, truncate_this_view, sync_path.out());
	}

	if (CORBA::is_nil(new_tree)) {
		return 0;
	}
	
	ViewBase* new_view = this->alloc_new_view ();	
	new_view->init (shared_flags, levels, auto_open, this->master_tree (), new_tree.in ());

	bool need_clean = false;
	{
		for (unsigned i = 0; i < filter.length (); i++) {
			if (GTree::LayerFilter::_downcast(filter[i])) {
				need_clean = true;
				break;
			}
		}
	}
	if (need_clean) {
		const TreeBase* master_tree = this->master_tree();
		const_cast<TreeBase*>(master_tree)->clear();
		const_cast<TreeBase*>(master_tree)->changed_layer(true);
	}

	FlagNodeBase_var ret = dynamic_cast<FlagNodeBase*>(new_view->root());

	sync_index = 0;

	if (!unfiltered && auto_open) {
		for (
			FlagNodeBase_var first_filtered = ret
			; !first_filtered.is_nil()
			; first_filtered = DefaultNodeBase::get_real_interface(first_filtered->first_child()), sync_index++
		) {		
			if (!first_filtered->has_flag(FM_OPEN)) {
				break;
			}		
		}
	}

// This code must set sync_index in correct value,
// but now there are problems with stub nodes
// (visible index is not corrected when stub node extracted).
#if 0
	GTree::NodeIndexPath index_path = sync_path->index_path ();
	// DEBUG INFO - must be deleted
	for (unsigned int i = 0; i < index_path.length (); i++) {
		LOG_D (("Returned value %d: %d", i, index_path[i]));
	}
	if (index_path.length ()) {
		DefaultNodeBase* nb = dynamic_cast<DefaultNodeBase*> (ret.in ());
		if (nb) {
			sync_index = nb->get_visible_delta (sync_path);
			LOG_D (("sync_index = %d", sync_index));
		}
	}
#endif
	//ret->find_node_by_path(sync_path)
	
	return ret._retn();
	//#UC END# *46011FD501A5*
}

void TreeBase::dump_flags_map (const char* context) const {
	//#UC START# *4601281502FD*
	SLOG_D (("%s BEGIN: [%s]", GDS_CURRENT_FUNCTION, context));
	for (NodeFlagMap::const_iterator it = m_flags_map.begin (); it != m_flags_map.end (); ++it) {
		SLOG_D (("\t: FALGMASK:[%d]", it->first));
		for (CountMap::const_iterator cf = it->second.begin (); cf != it->second.end (); ++cf) {
			GCL::StaticNode* dummy = const_cast <GCL::StaticNode*> (cf->first);
			GTree::NodePointer pointer = dynamic_cast<const DefaultNodeBase*> (dummy)->get_server_pointer ();
			SLOG_D (("\t: [%03d]:[%010d]", cf->second, pointer));
		}
	}
	SLOG_D (("%s   END: [%s]", GDS_CURRENT_FUNCTION, context));
	//#UC END# *4601281502FD*
}

void TreeBase::expand_all (bool expand) {
	//#UC START# *460127560261*
	m_all_expanded = expand;
	int dummy = 0;
	m_root->for_each (NodeExpander (m_all_expanded, this->is_root_visible ()), dummy);
	this->flush_counter_delta();
	//#UC END# *460127560261*
}

GTree::FindIterator* TreeBase::find (const GTree::NodePosition& find_from, FilterList& filter) const {
	//#UC START# *460121EC029F*
	this->master_tree ()->pre_find (filter);

	GTree::Query query;
	this->adapter_filters_to_server (filter, query);

	try {
		return m_server_tree->find (find_from, query);
	} catch (GTree::InvalidPointer&) {
		GDS_ASSERT (false); //looks like bug in server side
		return 0;
	}
	//#UC END# *460121EC029F*
}

GCL::StaticNode* TreeBase::find_cached_node (const DefaultNodeBase* parent, long& index) const {
	//#UC START# *460124AA0271*
	FindedNodes::const_iterator f = m_finded_node.find (parent);

	if (f != m_finded_node.end() && abs (f->second.index - index) < index) {
		index -= f->second.index;
		return f->second.node;
	} else {
		return const_cast<GCL::StaticNode*> (parent->m_first_child.ptr ());
	}
	//#UC END# *460124AA0271*
}

void TreeBase::flush_counter_delta () {
	//#UC START# *46011C9A0157*
	if (!m_counter_deltas.size()) {
		return;
	}

	typedef std::map<VisibleIndex, long> DeltaByIndex;
	DeltaByIndex delta_by_index;

	//SLOG_SHIFT
	
	for (CounterDeltaMap::iterator it = m_counter_deltas.begin(); it != m_counter_deltas.end(); it++) {
		VisibleIndex vind = it->first->get_visible_index ();
		delta_by_index [vind] = it->second;

		//SLOG_D (("%s [%d]: convert node to index [%d,%d]->%d"
		//	, GDS_CURRENT_FUNCTION
		//	, this
		//	, (GCL::StaticNode*)it->first
		//	, it->first->get_server_pointer ()
		//	, vind
		//));
	}

	//SLOG_D (("%s [%d]: m_counter_deltas.clear()", GDS_CURRENT_FUNCTION, this));
	m_counter_deltas.clear();

	for (DeltaByIndex::iterator it2 = delta_by_index.begin(); it2 != delta_by_index.end(); it2++) {
		this->change_children_count (it2->first, it2->second, NodeIndexPath (), 0);
	}

	this->invalidate(NodeIndexPath ());
	
	return;	
	//#UC END# *46011C9A0157*
}

unsigned long TreeBase::get_all_flags_count (const FlagNodeBase* node, FlagMask flag) const {
	//#UC START# *46011D4001A5*
	unsigned long ret = this->get_children_flags_count (node, flag);

	if (node->has_flag (flag)) {
		ret++;
	}

	return ret;
	//#UC END# *46011D4001A5*
}

GTree::Layers* TreeBase::get_available_layers () const {
	//#UC START# *460124CD03C8*
	return m_server_tree->supported_layers();
	//#UC END# *460124CD03C8*
}

GTree::Tree* TreeBase::get_cached_server_tree () const {
	//#UC START# *46012710030D*
	return m_server_tree.ptr ();
	//#UC END# *46012710030D*
}

unsigned long TreeBase::get_children_flags_count (const FlagNodeBase* node, FlagMask flag) const {
	//#UC START# *46011D100242*
	NodeFlagMap::const_iterator f = m_flags_map.find(flag);
	if (f != m_flags_map.end()) {
		CountMap::const_iterator cf = f->second.find(node);
		if (cf != f->second.end()) {
			return cf->second;
		} 		
	}
	return 0;
	//#UC END# *46011D100242*
}

GTree::NodePath* TreeBase::get_first_fit (const GCL::StaticNode* from_node, FilterList& filter) const {
	//#UC START# *460121C103B9*
	this->master_tree ()->pre_find (filter);

	GTree::Query query;
	this->adapter_filters_to_server (filter, query);

	GTree::NodeSelector sel;

	const DefaultNodeBase* from_child = dynamic_cast<const DefaultNodeBase*> (from_node);
	if (from_child) {
		sel.child_pointer = from_child->get_server_pointer ();
	} else {
		sel.child_pointer = GTree::ROOT_POINT;
	}
	
	/*const NodeBase* from_parent = 0;
	if (from_child) {
		from_parent = dynamic_cast<const NodeBase*> (from_child->get_parent ());
	}
	if (from_parent) {
		sel.parent_pointer = from_parent->get_server_pointer ();
	} else {*/
		sel.parent_pointer = GTree::ROOT_POINT;
	//}

	try {
		return m_server_tree->find_next (sel, query);
	} catch (GTree::InvalidPointer&) {
		GDS_ASSERT (false); //looks like bug in server side
		return 0;
	}
	//#UC END# *460121C103B9*
}

DefaultNodeBase* TreeBase::get_last_selected (FlagMask flag) const {
	//#UC START# *46011CB9002E*
	LastSelectMap::const_iterator f = m_last_select.find (flag);
	if (f != m_last_select.end()) {
		return f->second;
	} else {
		return 0;
	}
	//#UC END# *46011CB9002E*
}

long TreeBase::get_load_block_half_size () const {
	//#UC START# *4601194C037A*
	return m_load_block_half_size;
	//#UC END# *4601194C037A*
}

FlagMask TreeBase::get_shared_mode () const {
	//#UC START# *4601240A033C*
	return 0;
	//#UC END# *4601240A033C*
}

void TreeBase::invalidate (const NodeIndexPath& index_path) const {
	//#UC START# *4601253B0261*
	//SLOG_SHIFT
	for (NotifierSet::const_iterator not_it = m_notifiers.begin(); not_it != m_notifiers.end(); not_it++) {
		if (!not_it->second->is_one_level ()) { //- looks not good...
			//SLOG_D (("%s [%X]: invalidate()", GDS_CURRENT_FUNCTION, this));
			not_it->second->invalidate (index_path);
		}		
	}
	//#UC END# *4601253B0261*
}

void TreeBase::invalidate_finded_node (const DefaultNodeBase* parent) const {
	//#UC START# *46012495038A*
	m_finded_node.erase (parent);
	//#UC END# *46012495038A*
}

bool TreeBase::is_all_expanded () const {
	//#UC START# *460127560148*
	return m_all_expanded;
	//#UC END# *460127560148*
}

bool TreeBase::is_load_in_one_direction () const {
	//#UC START# *4601197B01F4*
	return m_load_in_one_direction;
	//#UC END# *4601197B01F4*
}

bool TreeBase::is_loaded_node (GTree::NodePointer node_pointer) const {
	//#UC START# *46011A2B0203*
	return m_nodes.find(node_pointer) != m_nodes.end();
	//#UC END# *46011A2B0203*
}

bool TreeBase::is_mode (FlagMask shared_flags) const {
	//#UC START# *4601221600DA*
	return false;
	//#UC END# *4601221600DA*
}

bool TreeBase::is_relevance_search_supported () const {
	//#UC START# *4601213B0000*
	return false;
	//#UC END# *4601213B0000*
}

bool TreeBase::is_root_nil () const {
	//#UC START# *460139FF0128*
	return m_root == 0;
	//#UC END# *460139FF0128*
}

bool TreeBase::is_root_visible () const {
	//#UC START# *46012775000F*
	// В принципе оболочка может установить в дерево несколько нотифаеров,
	// сейчас спрашиваем показывается руут или нет у первого попавшегося.
	NotifierSet::const_iterator notifier = m_notifiers.begin();
	GDS_ASSERT (notifier != m_notifiers.end ());
	return notifier->second->is_root_visible ();
	//#UC END# *46012775000F*
}

// прогружает дерево целиком. см. http://mdp.garant.ru/pages/viewpage.action?pageId=17334971
void TreeBase::load_all_tree () const {
	//#UC START# *466956AA02DE*
	size_t block_size = this->get_load_block_half_size ();
	GCL::StaticNode_var root = this->root ();
	this->load_children (root.ptr ());
	const_cast<TreeBase*> (this)->set_load_block_half_size (block_size);
	//#UC END# *466956AA02DE*
}

void TreeBase::load_children (const GCL::StaticNode* parent) const {
	//#UC START# *466957D20290*
	Core::Var<const GCL::StaticNode> first_child = parent->first_child ();

	for (const GCL::StaticNode* it = first_child.ptr (); it; GCL::StaticNode::shift_next (it)) {
		const GCL::StaticNodeStubBase* it_stub = dynamic_cast<const GCL::StaticNodeStubBase*> (it);
		if (it_stub) {
			it = this->load_stub_node (const_cast <GCL::StaticNodeStubBase*> (it_stub));
		}
		this->load_children (it);
	}
	//#UC END# *466957D20290*
}

GCL::StaticNode* TreeBase::load_nodes_from_server (
	GTree::NodePointer parent_point
	, GTree::NodePointer child_point
	, long from
	, unsigned long in_block_position
	, GCL::StaticNodeStubBase* current_stub
) /*throw (
	InvalidOwnerTree
)*/ {
	//#UC START# *46012392006D*
	GTree::NodeList_var nl;
	{
		//Core::GDS::StopWatchEx sw (this->get_tree_name (), "TreeBase::get_branch for %s", this->get_tree_name ());
		GTree::NodeSelector sel;
		sel.parent_pointer = parent_point;
		sel.child_pointer = child_point;
		nl = m_server_tree->get_branch (sel, from, this->get_load_block_half_size () << 1);
	}
	
	GDS_ASSERT (nl.ptr ());
	
	//SLOG_SHIFT
	//SLOG_D (("m_server_tree->get_branch (parent_point=%d, child_point=%d, from=%d, count=%d", parent_point, child_point, from, this->get_load_block_half_size ()*2));
	//SLOG_D (("buffer is: 0=%d, in_block_position-1=%d, in_block_position=%d, in_block_position+1=%d", (*nl)[0].pointer, in_block_position > 0 ? (*nl) [in_block_position - 1].pointer : -1, (*nl)[in_block_position].pointer, in_block_position < nl->length () - 1 ? (*nl)[in_block_position+1].pointer : -1));
	//SLOG_D (("in_block_position=%d", in_block_position));

	if (current_stub) {
		// transform prev
		GCL::StaticNodeStubBase* stub_to_correct = current_stub;
		GCL::StaticNode_var sn_stub = current_stub->prev();
		GCL::StaticNodeStubBase* stub = dynamic_cast<GCL::StaticNodeStubBase*> (sn_stub.ptr());
		GCL::StaticNode_var real_node;

		unsigned i = 0; // GARANT_FORSCOPING
		for (i = 0; i < in_block_position && stub; i++) {
			//LOG_D ((
			//	"call transform_to_real_node for prev (ind in buf=%d, ponter=%d)"
			//	, in_block_position - i - 1
			//	, (*nl)[in_block_position - i - 1].pointer
			//));

			real_node = this->build_node (
				(*nl)[in_block_position - i - 1]
				, dynamic_cast<FlagNodeBase*>(current_stub)
				, -1
			);
			stub->transform_to_real_node (
				real_node.in()
				, 0
				, stub_to_correct				
			);

			stub_to_correct = 0;
			sn_stub = stub->prev();			
			stub = dynamic_cast<GCL::StaticNodeStubBase*> (sn_stub.ptr());
		}

		// transform next
		stub_to_correct = current_stub;
		sn_stub = current_stub->next();
		stub = dynamic_cast<GCL::StaticNodeStubBase*> (sn_stub.ptr());
		for (i = in_block_position + 1; i < nl->length() && stub; i++) {
			real_node = this->build_node (
				(*nl)[i]
				, dynamic_cast<FlagNodeBase*>(current_stub)
				, -1
			);
			stub->transform_to_real_node(
				real_node.in()
				, stub_to_correct
				, 0				
			);
			stub_to_correct = 0;
			sn_stub = stub->next();
			stub = dynamic_cast<GCL::StaticNodeStubBase*> (sn_stub.ptr());
		}
	}
	
	GDS_ASSERT (in_block_position < nl->length ());
	
	return this->build_node (
		(*nl)[in_block_position]
		, dynamic_cast<FlagNodeBase*>(current_stub)
		, -1
	);	
	//#UC END# *46012392006D*
}

const GCL::StaticNode* TreeBase::load_stub_node (GCL::StaticNodeStubBase* node) const {
	//#UC START# *4755759F0391*
	// прогружаем всех детей из заглушки
	size_t block_size = this->get_load_block_half_size ();
	size_t stub_count = node->stub_count ();
	if ((stub_count >> 1) + 1 > block_size) {
		const_cast<TreeBase*> (this)->set_load_block_half_size ((stub_count >> 1) + 1);
	}
	return node->transform_to_real_node ();
	//#UC END# *4755759F0391*
}

const TreeBase* TreeBase::master_tree () const {
	//#UC START# *46012787038A*
	return this;
	//#UC END# *46012787038A*
}

GTree::NodeIndexPath* TreeBase::name_path_to_index_path (const GTree::NodeNamePath& name_path) const {
	//#UC START# *46011E200290*
	return this->m_server_tree->name_path_to_index_path (name_path);
	//#UC END# *46011E200290*
}

void TreeBase::onedir_calc_from_position (
	long offset
	, GTree::NodePointer child_point
	, GCL::StaticNodeStubBase* current_stub
	, long& from
	, unsigned long& in_block_position
) {
	//#UC START# *4601190F032C*
	if (offset >= 0) {
		if (child_point == GTree::FIRST_CHILD_POINT) {
			from = 0;				
			in_block_position = offset;
			if (current_stub && current_stub->stub_count() < 0) {
				in_block_position--; //second
			}
		} else {
			from = offset;
			in_block_position = 0;
			if (child_point == GTree::FIRST_CHILD_POINT && current_stub && current_stub->stub_count() < 0) {
				in_block_position--; //first
			}
		}
	} else {
		from = offset;
		in_block_position = 0;
	} 
	//#UC END# *4601190F032C*
}

GTree::NodeIndexPath* TreeBase::pointer_path_to_index_path (const GTree::NodePointerPath& pointer_path) const {
	//#UC START# *46011D5D00EA*
	return this->m_server_tree->pointer_path_to_index_path (pointer_path);
	//#UC END# *46011D5D00EA*
}

GTree::NodeIndexPath* TreeBase::pointer_to_index_path (GTree::NodePointer pointer) const {
	//#UC START# *46011DEE0148*
	return this->m_server_tree->pointer_to_index_path (pointer);	
	//#UC END# *46011DEE0148*
}

void TreeBase::pre_find (FilterList& filters) const {
	//#UC START# *460120C9005D*
	//#UC END# *460120C9005D*
}

void TreeBase::remove_notifier (GCL::StaticNode* root, NodeNotifier* notifier) {
	//#UC START# *46011F2C005D*
	GDS_ASSERT (notifier);
	NotifierSet::iterator it = m_notifiers.find (notifier->get_id ());
	GDS_ASSERT (it != m_notifiers.end ());

	//SLOG_SHIFT
	//SLOG_D (("%s [%d]: (%d) from node [%d]", GDS_CURRENT_FUNCTION, this, n, root));
	m_notifiers.erase (it);
	//#UC END# *46011F2C005D*
}

void TreeBase::reset_by_root (unsigned long new_root_ch_count) {
	//#UC START# *4601287803D8*
	this->m_server_data_version = 0;
	m_root->clear_children();
	m_nodes.clear();
	m_finded_node.clear();
	m_selected_count = 0;
	m_last_select.clear();
	m_flags_map.clear();

	if (new_root_ch_count) {
		FlagNodeStub::make_as_back_child (m_root, new_root_ch_count, this, GCL::NullStubPostProcess ());
	}
	m_nodes[GTree::ROOT_POINT] = dynamic_cast<DefaultNodeBase*>(m_root);
	//#UC END# *4601287803D8*
}

void TreeBase::reset_by_server_tree (GTree::Tree* new_tree) {
	//#UC START# *4601284400DA*
	this->m_server_data_version = 0;
	m_root->clear_children();
	m_nodes.clear();
	m_finded_node.clear();
	m_selected_count = 0;
	m_last_select.clear();
	m_flags_map.clear();
	m_root = 0;

	this->apply_server_tree(new_tree);
	//#UC END# *4601284400DA*
}

void TreeBase::reset_children_count () {
	//#UC START# *46CD73470203*
	GUARD (*this->get_change_mutex());

	NotifierSet tmp = m_notifiers; // in reset_children_count we get callback in remove_notifier

	for (NotifierSet::const_iterator not_it = tmp.begin(); not_it != tmp.end(); not_it++) {
		//LOG_D (("%s [%X]: (%d)", GDS_CURRENT_FUNCTION, this, *not_it));
		not_it->second->reset_children_count ();		
	}	
	//#UC END# *46CD73470203*
}

GCL::StaticNode* TreeBase::root () const {
	//#UC START# *46011CA602DE*
	if (!m_root) {
		m_root = const_cast<TreeBase*>(this)->make_real_node (0, 0, 0, 0);
		
		dynamic_cast<DefaultNodeBase*>(m_root)->set_flag (FM_OPEN, true, false);
		return m_root;
	} else {
		return Core::IObject::_duplicate (m_root);
	}
	//#UC END# *46011CA602DE*
}

// used by RealNodeRoot::delete_obj ONLY
void TreeBase::root_is_dead () {
	//#UC START# *46013A110290*

	{
		// наличие вложенной области видимости НЕОБХОДИМО см. далее
		GUARD (*this->get_change_mutex ());
		m_root = 0;
	}

	// ses: здесь для отрегистрации самое правильное место
	// во-первых, потому-что кто регистрирует (в данном случае TreeBase), тот и отрегистрирует.
	// во-вторых, нельзя что бы отрегистрация жила в ActiveChangeable::delete_obj,
	// потому-что может возникнуть проезд по памяти (подробнее см. логи пьюрифая из CQ: 23132)
	// в-третьих, если отрегистрация будет до гуарда (вверху), то будет дедлок в конструкторе гуарда,
	// т.к. во время обработки дельты апдейт мъютекс захватывается и если до его релиза выполнится unregister_object
	// - релиз на апдейт мьютексе никогда не вполнится - получим дедлок в гуарде.
	// в-четвертых, занести под гуард (вверху) unregister_object то же нельзя - получим деадлок,
	// т.к. отрегистрация юзает мьютекс, который используется при обработке дельты, ПОД под апдейт мьютексом
	// - т.е. в другом порядке чем здесь.

	this->unregister_object ();
	//#UC END# *46013A110290*
}

void TreeBase::safety_remove () {
	//#UC START# *460127F90186*
	GUARD (*this->get_change_mutex());
/*
	http://mdp.garant.ru/pages/viewpage.action?pageId=294601729&focusedCommentId=296095011#comment-296095011
	NotifierSet tmp = m_notifiers; // in reset_children_count we get callback in remove_notifier

	for (NotifierSet::const_iterator not_it = tmp.begin(); not_it != tmp.end(); not_it++) {
		//LOG_D (("%s [%X]: (%d)", GDS_CURRENT_FUNCTION, this, *not_it));
		not_it->second->reset_children_count ();		
	}	
*/
	for (NodeMap::iterator it = m_nodes.begin(); it != m_nodes.end(); it++) {
		it->second->set_owner_tree (0);
	}	
	this->m_server_data_version = 0;

	//#UC END# *460127F90186*
}

GTree::TreeDataVersionID TreeBase::server_data_version () const {
	//#UC START# *46011E5F031C*
	if (this->m_server_data_version == 0) {
		this->m_server_data_version = this->m_server_tree->server_data_version ();
	}
	return this->m_server_data_version;
	//#UC END# *46011E5F031C*
}

void TreeBase::set_changed (bool state) {
	//#UC START# *46012899005D*
	m_is_changed = state;
	//#UC END# *46012899005D*
}

void TreeBase::set_load_block_half_size (long new_size) {
	//#UC START# *4601195B02AF*
	m_load_block_half_size = new_size;
	//#UC END# *4601195B02AF*
}

void TreeBase::set_load_in_one_direction (bool yes) {
	//#UC START# *460119830119*
	m_load_in_one_direction = yes;
	//#UC END# *460119830119*
}

void TreeBase::update_counters (const FlagNodeBase* node, FlagMask flag, bool value) {
	//#UC START# *46011CE503A9*
	unsigned long delta_count;

	const DefaultNodeBase* nb_node = dynamic_cast<const DefaultNodeBase*>(node);
	if (value) {
		if (nb_node) {
			m_last_select[flag] = const_cast<DefaultNodeBase*>(nb_node);
		}
	}

	if (!nb_node) {
		const GCL::StaticNodeStubBase* snsb = dynamic_cast<const GCL::StaticNodeStubBase*>(node);			
		if (snsb->stub_count() < 0) {
			delta_count = 1;
		} else {
			delta_count = snsb->stub_count();
		}
	} else {
		delta_count = 1;
	}

	DefaultNodeBase_cvar node_parent (dynamic_cast<const DefaultNodeBase*>(node->parent ()));
	if (!node_parent.ptr ()) {
		// add flag to map
		m_flags_map[flag];
	}

	//SLOG_D ((
	//	"%s for[%d,%d](flag=%d, value=%d), delta=%d"
	//	, GDS_CURRENT_FUNCTION
	//	, (GCL::StaticNode*)node
	//	, nb_node ? nb_node->get_server_pointer() : -1
	//	, flag
	//	, value
	//	, delta_count
	//));
	for (
		DefaultNodeBase_var parent (dynamic_cast<DefaultNodeBase*>(const_cast<GblAdapterLib::FlagNodeBase*> (node)->parent ()))
		; parent.ptr () && delta_count
		; parent = dynamic_cast<DefaultNodeBase*>(parent->parent ())
	) {
		if (value) {
			//LOG_D (("update flag: %d parent %d (%d+%d)", flag, parent, m_flags_map[flag][parent.ptr ()], delta_count));
			if ((m_flags_map[flag][parent.ptr ()] += delta_count) == delta_count) {
				parent->set_children_flag (flag, true);
			}
		} else if (m_flags_map[flag].find (parent.ptr ()) != m_flags_map[flag].end ()) {
			//LOG_D (("update flag: %d parent %d (%d-%d)", flag, parent, m_flags_map[flag][parent.ptr ()], delta_count));
			GDS_ASSERT (m_flags_map[flag][parent.ptr ()] >= delta_count);
			if ((m_flags_map[flag][parent.ptr ()] -= delta_count) == 0) {
				parent->set_children_flag (flag, false);
				m_flags_map[flag].erase (parent.ptr ());
			}
		}
	}

	if (flag == FM_OPEN && delta_count) {
		delta_count = node->all_visible_children_count();

		GDS_ASSERT (nb_node);

		if (delta_count) {
			//SLOG_SHIFT
			//VisibleIndex vind = nb_node->get_visible_index ();
			//SLOG_D (("%s ([%d], %d, %d)", GDS_CURRENT_FUNCTION, nb_node->get_server_pointer(), vind, (value ? delta_count : -(int)delta_count)));
			
			if (value) {
				if (nb_node->is_visible()) {
					m_counter_deltas [const_cast<DefaultNodeBase*>(nb_node)] += delta_count;
					//SLOG_D (("%s: m_counter_deltas [%d] += %d", GDS_CURRENT_FUNCTION, nb_node, delta_count));
				}
			} else {
				if (!nb_node->is_visible()) {
					// при сворачивании изменяем дельту, только если родитель открыт
					Core::Var<const GCL::StaticNode> parent_sn = nb_node->parent ();
					if (!parent_sn.is_nil ()) {
						const FlagNodeBase* parent_fnb = dynamic_cast<const FlagNodeBase*> (parent_sn.ptr ());
						if (parent_fnb->has_flag (FM_OPEN)) {
							m_counter_deltas [const_cast<DefaultNodeBase*>(nb_node)] -= delta_count;
						}
					}
					
				}
			}
		}
	}
	//#UC END# *46011CE503A9*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const TreeBase::NodeFlagMap& TreeBase::get_flags_map () const {
	//#UC START# *46013B1601E4_GET_ACCESSOR*
	return m_flags_map;
	//#UC END# *46013B1601E4_GET_ACCESSOR*
}

bool TreeBase::get_is_changed () const {
	//#UC START# *46013B4B0251_GET_ACCESSOR*
	return m_is_changed;
	//#UC END# *46013B4B0251_GET_ACCESSOR*
}

GTree::Tree* TreeBase::get_server_tree () const {
	//#UC START# *46013AE00271_GET_ACCESSOR*
	return GTree::Tree::_duplicate (m_server_tree.in ());
	//#UC END# *46013AE00271_GET_ACCESSOR*
}



bool TreeBase::get_active_changeble () const {
	//#UC START# *46013A67007D_GET_ACCESSOR*
	return m_active_changeble;
	//#UC END# *46013A67007D_GET_ACCESSOR*
}

void TreeBase::set_active_changeble (bool active_changeble) {
	//#UC START# *46013A67007D_SET_ACCESSOR*
	m_active_changeble = active_changeble;
	//#UC END# *46013A67007D_SET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ActiveChangeable
void TreeBase::acquire_update_mutex () {
	//#UC START# *4601162A008C_45F554750213*
	this->get_change_mutex ()->acquire ();
	//#UC END# *4601162A008C_45F554750213*
}

// implemented method from ActiveChangeable
void TreeBase::release_update_mutex () {
	//#UC START# *460116360399_45F554750213*
	this->get_change_mutex ()->release ();
	//#UC END# *460116360399_45F554750213*
}

// implemented method from ActiveChangeable
void TreeBase::update_cache (const CORBA::Any& hint) {
	//#UC START# *460115F6007D_45F554750213*
	class AutoChanging {
	public:
		AutoChanging (TreeBase* tree) : m_tree(tree) {
			m_tree->changing();
		}

		~AutoChanging () {
			m_tree->changed();
		}

	private:
		TreeBase* m_tree;
	};

	//SLOG_SHIFT
	//SLOG_D (("%s... try to lock change_mutex", GDS_CURRENT_FUNCTION));
	GUARD (*this->get_change_mutex());	
	//SLOG_D (("%s... lock change_mutex - OK", GDS_CURRENT_FUNCTION));

	{
		if (this->is_root_nil ()) {
			return; // nothing to change
		}
		
		AutoChanging ac (this);

		GCL::StaticNode_var root = this->root ();

		GTree::ChangeDelta* chg_delta;
		if (hint >>= chg_delta) {
			//GCL::StaticNode::s_need_print = true;			
			//root.ptr()->print_tree();
			if (dynamic_cast<DefaultNodeBase*> (root.ptr())->apply_change_delta (*chg_delta)) {
				this->apply_delta_postprocess (*chg_delta);
			}
			//root.ptr()->print_tree();			
			//SLOG_D (("%s... UNLOCK change_mutex", GDS_CURRENT_FUNCTION));			
			return;
		} 

		GTree::InsertDelta* insert_delta;
		if (hint >>= insert_delta) {
			if (dynamic_cast<DefaultNodeBase*> (root.ptr())->apply_insert_delta (*insert_delta)) {
				this->apply_delta_postprocess (*insert_delta);
			}
			return;
		}

		GTree::DeleteDelta* delete_delta;
		if (hint >>= delete_delta) {
			if (dynamic_cast<DefaultNodeBase*> (root.ptr())->apply_delete_delta (*delete_delta)) {
				this->apply_delta_postprocess (*delete_delta);
			}
			return;
		}

		GTree::ResetDelta* reset_delta;
		if (hint >>= reset_delta) {
			dynamic_cast<DefaultNodeBase*> (root.ptr())->apply_reset_delta (*reset_delta);
			return;
		}
	}

	GDS_ASSERT (false);

	/*
	SLOG_SHIFT
	GTree::InsertDelta* delta;
	bool unpaked = *hint >>= delta;
	GDS_ASSERT (unpaked);
	GTree::DeltaRootDataList list = delta->data ();
	SLOG_D (("INSERT DELTA DUMP:"));
	for (size_t i = 0; i < list.length (); ++i) {
		SLOG_SHIFT
		SLOG_D (("DeltaRootData item: [%d]", i));
		GTree::DeltaRootData root_data = list [i];
		
		SLOG_D (("DeltaRootData::parent index node path:"));
		for (size_t ii = 0; ii < root_data.parent.length (); ++ii) {
			SLOG_SHIFT
			SLOG_D (("[%d]", root_data.parent[ii]));
		}
		
		SLOG_D (("DeltaRootData::inplace_data:"));
		for (size_t j = 0; j < root_data.changed_nodes.length (); ++j) {
			SLOG_SHIFT
			GTree::DeltaInplaceData inplace_data = root_data.changed_nodes [j];
			SLOG_D (("left_child_index: [%d]", inplace_data.left_child_index));
			SLOG_D (("count           : [%d]", inplace_data.count));
		}
	}*/
	//#UC END# *460115F6007D_45F554750213*
}

// implemented method from GCL::StaticNodeMng
// создать ноду
GCL::StaticNode* TreeBase::make_real_node (
	const GCL::StaticNode* parent
	, const GCL::StaticNode* prev
	, long offset
	, GCL::StaticNodeStubBase* current_stub
) {
	//#UC START# *4614ACDC008C_45F554750213*
	GTree::NodePointer parent_point = GTree::ROOT_PARENT_POINT;
	GTree::NodePointer child_point = GTree::FIRST_CHILD_POINT;

	if (prev) {
		const DefaultNodeBase* node_prev = dynamic_cast<const DefaultNodeBase*> (prev);
		GDS_ASSERT (node_prev);
		
		child_point = node_prev->get_server_pointer();
	} 
	if (parent) {
		const DefaultNodeBase* node_par = dynamic_cast<const DefaultNodeBase*> (parent);
		GDS_ASSERT (node_par);
		
		parent_point = node_par->get_server_pointer();
	}

	//SLOG_SHIFT
	//SLOG_D (("\nMAKE_REAL_NODE (par=%d, ch=%d, offset=%d, stub_count=%d, ind=%d)\n", parent_point, child_point, offset, current_stub ? current_stub->stub_count() : 0, current_stub ? current_stub->stub_ind() : 0));

	/*if (current_stub && current_stub->stub_count() < 0 && child_point == 0 && offset > this->get_load_block_half_size ()) {
		LOG_D (("catch one"));
	}*/

	long from = 0;
	unsigned long in_block_position = 0;
	this->calc_from_position (offset, child_point, current_stub, from, in_block_position);

	return this->load_nodes_from_server (parent_point, child_point, from, in_block_position, current_stub);
	//#UC END# *4614ACDC008C_45F554750213*
}

// implemented method from GCL::StaticNodeMng
// функция вызывается перед удалением?
void TreeBase::pre_remove (const GCL::StaticNode* node, unsigned int count) {
	//#UC START# *4614AD470109_45F554750213*
	const FlagNodeBase* flag_node = dynamic_cast<const FlagNodeBase*> (node);
	for (NodeFlagMap::iterator it = m_flags_map.begin(); it != m_flags_map.end(); it++) {
		unsigned removed_count = 0;

		if (flag_node->has_flag (it->first)) {
			const GCL::StaticNodeStubBase* stub = dynamic_cast<const GCL::StaticNodeStubBase*> (node);
			if (stub && 1 < stub->stub_count ()) {
				unsigned long stubs_removed = 0;
				if (stub->has_pair ()) {
					if (static_cast<unsigned long> (stub->stub_count ()) < count) {
						removed_count += stub->stub_count () + 1;
					} else {
						if (static_cast<unsigned long> (stub->stub_count ()) == count) {
							removed_count += stub->stub_count ();
						} else {
							removed_count += count;
						}
					}
				} else {
					if (static_cast<unsigned long> (stub->stub_count ()) < count) {
						removed_count += stub->stub_count ();
					} else {
						removed_count += count;
					}
				}
			} else {
				removed_count++;
			}
		}

		CountMap::iterator f = it->second.find (flag_node);

		if (f != it->second.end ()) {
			removed_count += f->second;
			it->second.erase (f);
		}

		DefaultNodeBase_var parent = const_cast<DefaultNodeBase*> (dynamic_cast<const DefaultNodeBase*>(flag_node->parent ()));
		for (; parent.ptr (); parent = dynamic_cast<DefaultNodeBase*> (parent->parent ())) {
			CountMap::iterator f = it->second.find (parent.in ());
			
			if (f != it->second.end ()) {
				f->second -= removed_count;
				if (f->second == 0) {
					parent->set_children_flag (it->first, false);
					it->second.erase (f);
				}
			} else {
				break;
			}
		}
	}

	const DefaultNodeBase* node_base = dynamic_cast<const DefaultNodeBase*> (node);
	if (node_base) {
		m_nodes.erase (node_base->get_server_pointer ());
		LastSelectMap::iterator lsm_it = m_last_select.find (flag_node->get_flags ());
		if (lsm_it != m_last_select.end () && (lsm_it->second == node_base)) {
			m_last_select[flag_node->get_flags ()] = 0;
		}
	}
	//#UC END# *4614AD470109_45F554750213*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

