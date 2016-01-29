#ifndef _GBLADAPTER_SHORT_DOC_LIST_AMI_H_
#define _GBLADAPTER_SHORT_DOC_LIST_AMI_H_

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ProgressIndicatorSupport_i/ProgressIndicatorServant_i.h"
#include "garantServer/src/Business/GblPilot/GblDocList_amiS.h"

namespace GblAdapterLib {

class ShortDocList_ami :
	virtual public POA_GblDocList::AMI_ShortDocListHandler
	, virtual public TAO_RefCountServantBase {

public:
	ShortDocList_ami (
		ProgressIndicator* progress_indicator
		, ProgressIndicatorServantBase* progress_indicator_servant
	);

	virtual ~ShortDocList_ami ();

    virtual void get_full_list (::GblPilotQueryDef::SearchEntity_ptr ami_return_val);
    virtual void get_full_list_excep (GblDocList::AMI_ShortDocListExceptionHolder* excep_holder);
	virtual void get_full_list_size (CORBA::ULong ami_return_val) {}
	virtual void get_full_list_size_excep (GblDocList::AMI_ShortDocListExceptionHolder* excep_holder) {}

	virtual void timestamp_object_id (const ::TimeStampSync::TimeStampObjectID& ami_return_val) {}
	virtual void timestamp_object_id_excep (::TimeStampSync::AMI_TimeStampObjectBaseExceptionHolder* excep_holder) {}
	virtual void get_supported_layers (const ::GTree::Layers& ami_return_val) {}
	virtual void get_supported_layers_excep (::GTree::AMI_TreeExceptionHolder* excep_holder) {}
	virtual void get_server_data_version (::GTree::TreeDataVersionID ami_return_val) {}
	virtual void get_server_data_version_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void get_my_history (const char * ami_return_val) {}
	virtual void get_my_history_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void add_new_node () {}
	virtual void add_new_node_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void all_children_count (::CORBA::ULong ami_return_val) {}
	virtual void all_children_count_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void change_node () {}
	virtual void change_node_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void clone (::GTree::Tree_ptr ami_return_val,::CORBA::Boolean need_filtrate) {}
	virtual void clone_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void copy_nodes_compact (::GTree::NodeHolder_ptr ami_return_val) {}
	virtual void copy_nodes_compact_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void copy_nodes (::GTree::NodeHolder_ptr ami_return_val) {}
	virtual void copy_nodes_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void delete_nodes_compact () {}
	virtual void delete_nodes_compact_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void delete_nodes () {}
	virtual void delete_nodes_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void paste_nodes () {}
	virtual void paste_nodes_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void find_next (const ::GTree::NodePath & ami_return_val) {}
	virtual void find_next_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void get_tree_evd (::GslDataPipe::DataReading_ptr ami_return_val) {}
	virtual void get_tree_evd_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void get_tree_rtf (::GslDataPipe::DataReading_ptr ami_return_val) {}
	virtual void get_tree_rtf_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void get_view (::GTree::TreeView_ptr ami_return_val,const ::GTree::NodePath & sync_path) {}
	virtual void get_view_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void get_view_branch (const ::GTree::ViewNodeList & ami_return_val) {}
	virtual void get_view_branch_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void get_abs_index (::CORBA::ULong ami_return_val) {}
	virtual void get_abs_index_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void get_path_by_abs_index (const ::GTree::NodePath & ami_return_val) {}
	virtual void get_path_by_abs_index_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void is_current_layer (::CORBA::Boolean ami_return_val) {}
	virtual void is_current_layer_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void name_path_to_index_path (const ::GTree::NodeIndexPath & ami_return_val) {}
	virtual void name_path_to_index_path_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void open_entity (const ::GTree::NodeEntity & ami_return_val) {}
	virtual void open_entity_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void pointer_path_to_index_path (const ::GTree::NodeIndexPath & ami_return_val) {}
	virtual void pointer_path_to_index_path_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void pointer_to_index_path (const ::GTree::NodeIndexPath & ami_return_val) {}
	virtual void pointer_to_index_path_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void get_branch (const ::GTree::NodeList & ami_return_val) {}
	virtual void get_branch_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void get_branch_unicode (const ::GTree::UnicodeNodeList & ami_return_val) {}
	virtual void get_branch_unicode_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void is_compared_tree_by_name (::CORBA::Boolean ami_return_val) {}
	virtual void is_compared_tree_by_name_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void merge_trees (::GTree::Tree_ptr ami_return_val) {}
	virtual void merge_trees_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void substruct_trees (::GTree::Tree_ptr ami_return_val) {}
	virtual void substruct_trees_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void intersect_trees (::GTree::Tree_ptr ami_return_val) {}
	virtual void intersect_trees_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void create_new (::GTree::Tree_ptr ami_return_val) {}
	virtual void create_new_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void get_original_tree (::GTree::Tree_ptr ami_return_val) {}
	virtual void get_original_tree_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void find (::GTree::FindIterator_ptr ami_return_val) {}
	virtual void find_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void is_relevance_search_supported (::CORBA::Boolean ami_return_val) {}
	virtual void is_relevance_search_supported_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void is_empty (::CORBA::Boolean ami_return_val) {}
	virtual void is_empty_excep (::GTree::AMI_TreeExceptionHolder * excep_holder) {}
	virtual void get_reference_count (::CORBA::ULong ami_return_val) {}
	virtual void get_reference_count_excep (::GCD::AMI_RemoteRefCountObjectExceptionHolder * excep_holder) {}
	virtual void add_reference () {}
	virtual void add_reference_excep (::GCD::AMI_RemoteRefCountObjectExceptionHolder * excep_holder) {}
	virtual void get_name (const char * ami_return_val) {}
	virtual void get_name_excep (::GblDocList::AMI_DocListTreeExceptionHolder * excep_holder) {}
	virtual void set_name () {}
	virtual void set_name_excep (::GblDocList::AMI_DocListTreeExceptionHolder * excep_holder) {}
	virtual void get_available_sort_types (const ::GblPilotDef::SortTypeList & ami_return_val) {}
	virtual void get_available_sort_types_excep (::GblDocList::AMI_DocListTreeExceptionHolder * excep_holder) {}
	virtual void get_current_sort_type (const ::GblPilotDef::SortParams & ami_return_val) {}
	virtual void get_current_sort_type_excep (::GblDocList::AMI_DocListTreeExceptionHolder * excep_holder) {}
	virtual void add_bookmark () {}
	virtual void add_bookmark_excep (::GblDocList::AMI_DocListTreeExceptionHolder * excep_holder) {}
	virtual void save_tree_to_xml (const ::GCD::XMLText & ami_return_val) {}
	virtual void save_tree_to_xml_excep (::GblDocList::AMI_DocListTreeExceptionHolder * excep_holder) {}
	virtual void save_buffer_to_xml (const ::GCD::XMLText & ami_return_val) {}
	virtual void save_buffer_to_xml_excep (::GblDocList::AMI_DocListTreeExceptionHolder * excep_holder) {}
	virtual void get_short_name (const char * ami_return_val) {}
	virtual void get_short_name_excep (::GblDocList::AMI_DocListTreeExceptionHolder * excep_holder) {}
	virtual void get_type (::GblDocList::DocListType ami_return_val) {}
	virtual void get_type_excep (::GblDocList::AMI_DocListTreeExceptionHolder * excep_holder) {}
	virtual void get_is_short (CORBA::Boolean ami_return_val) {}
	virtual void get_is_short_excep (::GblDocList::AMI_DocListTreeExceptionHolder * excep_holder) {}
	virtual void get_is_snippet (CORBA::Boolean ami_return_val) {}
	virtual void get_is_snippet_excep (::GblDocList::AMI_DocListTreeExceptionHolder * excep_holder) {}
	virtual void get_analysis_tree (GTree::Tree_ptr) {}
	virtual void get_analysis_tree_excep(GblDocList::AMI_DocListTreeExceptionHolder *) {}
	virtual void pointer_to_pointer_path (const GTree::NodePointerPath &) {}
	virtual void pointer_to_pointer_path_excep (GTree::AMI_TreeExceptionHolder *) {}
	virtual void pointer_to_name_path (const GTree::NodeNamePath&) {}
	virtual void pointer_to_name_path_excep (GTree::AMI_TreeExceptionHolder*) {}


private:
	SearchProgressIndicator::ProgressIndicatorForSearch* get_progress_indicator ();

private:
	ProgressIndicator_var m_progress_indicator;
	ProgressIndicatorServantBase* m_progress_indicator_servant;
};

typedef Core::Var<SearchProgressIndicator::ProgressIndicatorForSearch> ProgressIndicatorForSearch_var;

}; // namespace GblAdapterLib;


#endif // _GBLADAPTER_SHORT_DOC_LIST_AMI_H_
