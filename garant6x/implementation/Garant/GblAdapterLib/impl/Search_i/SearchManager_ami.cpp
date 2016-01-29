#include "garant6x/implementation/Garant/GblAdapterLib/impl/Search_i/SearchManager_ami.h"

namespace GblAdapterLib {

SearchManager_ami::SearchManager_ami (
	ProgressIndicator* progress_indicator
	, ProgressIndicatorServantBase* progress_indicator_servant
	) : m_progress_indicator (ProgressIndicator::_duplicate (progress_indicator))
	, m_progress_indicator_servant (progress_indicator_servant) {
}

SearchManager_ami::~SearchManager_ami (void) {
}

SearchProgressIndicator::ProgressIndicatorForSearch* SearchManager_ami::get_progress_indicator () {
	return dynamic_cast<SearchProgressIndicator::ProgressIndicatorForSearch*> (Core::IObject::_duplicate (m_progress_indicator.ptr ()));
}


void SearchManager_ami::search (GblPilotQueryDef::SearchEntity_ptr ami_return_val) {
	try {
		SearchProgressIndicator::ProgressIndicatorForSearch_var qepi (this->get_progress_indicator ());
		GDS_ASSERT (qepi.ptr());
		m_progress_indicator_servant->set_current (
			m_progress_indicator_servant->max_progress_count (), ami_return_val->document_count ()
		);
		GUARD (m_progress_indicator_servant->get_synch ());
		m_progress_indicator_servant->set_finish();
		SearchEntity_var out_entity = SearchEntityFactory::make (ami_return_val);
		qepi->finish_process (out_entity.in ());
	} catch (...) {
		LOG_UEX (("%s - something wrong with GUI progress indictor", GDS_CURRENT_FUNCTION));
		GDS_ASSERT (false);
		SearchProgressIndicator::ProgressIndicatorForSearch_var qepi (this->get_progress_indicator ());
		GDS_ASSERT (qepi.ptr());
		qepi->finish_process (0);
	}
}

void SearchManager_ami::search_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder) {
	SearchProgressIndicator::ProgressIndicatorForSearch_var qepi (this->get_progress_indicator ());
	GDS_ASSERT (qepi.ptr ());
	qepi->finish_process (0);
}

void SearchManager_ami::get_query_form (GTree::Tree_ptr ami_return_val)  {
}

void SearchManager_ami::get_query_form_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder) {
}

void SearchManager_ami::get_evd_query_form (const GCD::SeqOctet& ami_return_val) {
}

void SearchManager_ami::get_evd_query_form_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder) {
}

void SearchManager_ami::get_json_query_form (const GblPilot::JSONData& ami_return_val) {
}

void SearchManager_ami::get_json_query_form_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder) {
}

void SearchManager_ami::get_index_tree (GTree::Tree_ptr ami_return_val) {
}

void SearchManager_ami::get_index_tree_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder) {
}
	
void SearchManager_ami::get_attribute_info (const ::GblPilotQueryDef::AttributeInfo& ami_return_val) {
}
	
void SearchManager_ami::get_attribute_info_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder) {
}

void SearchManager_ami::get_attributes_info (const GblPilotQueryDef::FullAttributeInfoList& ami_return_val) {
}

void SearchManager_ami::get_attributes_info_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder) {
}
	
void SearchManager_ami::get_default_value (const GblPilotQueryDef::DefaultValueList& ami_return_val) {
}

void SearchManager_ami::get_default_value_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder) {
}

void SearchManager_ami::is_morpho_exist (::CORBA::Boolean ami_return_val) {
}

void SearchManager_ami::is_morpho_exist_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder) {
}

void SearchManager_ami::correct_context (
	const GblPilotDef::WordList& ami_return_val
	, const GblPilotDef::WordList& corrected_context
) {}

void SearchManager_ami::correct_context_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder) {
}

void SearchManager_ami::get_special_document_list (GblDocList::DocListTree_ptr) {
}

void SearchManager_ami::get_special_document_list_excep (GblPilot::AMI_SearchManagerExceptionHolder *) {
}

void SearchManager_ami::get_example_text_count (CORBA::ULong) {
}

void SearchManager_ami::get_example_text_count_excep (GblPilot::AMI_SearchManagerExceptionHolder *) {
}

void SearchManager_ami::get_example_text (const char*) {
}

void SearchManager_ami::get_example_text_excep (GblPilot::AMI_SearchManagerExceptionHolder *) {
}

void SearchManager_ami::attribute_exists (CORBA::Boolean) {
}

void SearchManager_ami::attribute_exists_excep(GblPilot::AMI_SearchManagerExceptionHolder *) {
}

void SearchManager_ami::get_all_examples (const GblPilot::ExamplesList&) {
}

void SearchManager_ami::get_all_examples_excep (GblPilot::AMI_SearchManagerExceptionHolder *) {
}

void SearchManager_ami::get_json_search_result (const GblPilot::JSONData& ami_return_val) {
}

void SearchManager_ami::get_json_search_result_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder) {
}

}; // namespace GblAdapterLib


