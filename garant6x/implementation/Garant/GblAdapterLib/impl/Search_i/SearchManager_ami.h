#ifndef _GBLADAPTER_SEARCH_MANAGER_H_
#define _GBLADAPTER_SEARCH_MANAGER_H_

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/SearchProgressIndicator/SearchProgressIndicator.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/ProgressIndicatorSupport_i/ProgressIndicatorServant_i.h"
#include "garantServer/src/Business/GblPilot/GblPilot_amiS.h"

namespace GblAdapterLib {

class SearchManager_ami :
	virtual public POA_GblPilot::AMI_SearchManagerHandler
	, virtual public TAO_RefCountServantBase {

public:
	SearchManager_ami (
		ProgressIndicator* progress_indicator
		, ProgressIndicatorServantBase* progress_indicator_servant
	);

	virtual ~SearchManager_ami ();

	virtual void search (GblPilotQueryDef::SearchEntity_ptr ami_return_val);
	virtual void search_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder);
	virtual void get_query_form (GTree::Tree_ptr ami_return_val);
	virtual void get_query_form_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder);
	virtual void get_evd_query_form (const GCD::SeqOctet& ami_return_val);
	virtual void get_evd_query_form_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder);
    virtual void get_json_query_form (const GblPilot::JSONData& ami_return_val);
    virtual void get_json_query_form_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder);
	virtual void get_index_tree (GTree::Tree_ptr ami_return_val);
	virtual void get_index_tree_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder);
	virtual void get_attribute_info (const ::GblPilotQueryDef::AttributeInfo& ami_return_val);
	virtual void get_attribute_info_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder);
    virtual void get_attributes_info (const GblPilotQueryDef::FullAttributeInfoList& ami_return_val);
    virtual void get_attributes_info_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder);
	virtual void get_default_value (const GblPilotQueryDef::DefaultValueList& ami_return_val);
	virtual void get_default_value_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder);
	virtual void is_morpho_exist (::CORBA::Boolean ami_return_val);
	virtual void is_morpho_exist_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder);
	virtual void correct_context (
		const GblPilotDef::WordList& ami_return_val
		, const GblPilotDef::WordList& corrected_context
	);
	virtual void correct_context_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder);
	virtual void get_special_document_list (GblDocList::DocListTree_ptr);
	virtual void get_special_document_list_excep (GblPilot::AMI_SearchManagerExceptionHolder *);

	virtual void get_example_text_count (CORBA::ULong);
	virtual void get_example_text_count_excep (GblPilot::AMI_SearchManagerExceptionHolder *);
	virtual void get_example_text (const char*);
	virtual void get_example_text_excep (GblPilot::AMI_SearchManagerExceptionHolder *);
	virtual void get_all_examples (const GblPilot::ExamplesList&);
	virtual void get_all_examples_excep (GblPilot::AMI_SearchManagerExceptionHolder *);

    virtual void attribute_exists (CORBA::Boolean);
	virtual void attribute_exists_excep(GblPilot::AMI_SearchManagerExceptionHolder *);

	virtual void get_json_search_result (const GblPilot::JSONData& ami_return_val);
	virtual void get_json_search_result_excep (GblPilot::AMI_SearchManagerExceptionHolder* excep_holder);

private:
	SearchProgressIndicator::ProgressIndicatorForSearch* get_progress_indicator ();

private:
	ProgressIndicator_var m_progress_indicator;
	ProgressIndicatorServantBase* m_progress_indicator_servant;
};

typedef Core::Var<SearchProgressIndicator::ProgressIndicatorForSearch> ProgressIndicatorForSearch_var;

}; // namespace GblAdapterLib;


#endif // _GBLADAPTER_SEARCH_MANAGER_H_
