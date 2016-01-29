#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/ShortDocList_ami.h"
namespace GblAdapterLib {

ShortDocList_ami::ShortDocList_ami (
	ProgressIndicator* progress_indicator
	, ProgressIndicatorServantBase* progress_indicator_servant
	) : m_progress_indicator (ProgressIndicator::_duplicate (progress_indicator))
	, m_progress_indicator_servant (progress_indicator_servant) {
}

ShortDocList_ami::~ShortDocList_ami (void) {
}

SearchProgressIndicator::ProgressIndicatorForSearch* ShortDocList_ami::get_progress_indicator () {
	return dynamic_cast<SearchProgressIndicator::ProgressIndicatorForSearch*> (Core::IObject::_duplicate (m_progress_indicator.ptr ()));
}


void ShortDocList_ami::get_full_list (::GblPilotQueryDef::SearchEntity_ptr ami_return_val) {
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

void ShortDocList_ami::get_full_list_excep (GblDocList::AMI_ShortDocListExceptionHolder* excep_holder) {
	SearchProgressIndicator::ProgressIndicatorForSearch_var qepi (this->get_progress_indicator ());
	GDS_ASSERT (qepi.ptr ());
	qepi->finish_process (0);
}

}; // namespace GblAdapterLib


