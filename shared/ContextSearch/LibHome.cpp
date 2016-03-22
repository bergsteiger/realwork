////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> shared::ContextSearch
//
// Библиотека контекстного морфо-поиска
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/ContextSearch/LibHome.h"
#include "shared/ContextSearch/impl/Search_i/Algorithm_i_factory.h"
#include "shared/ContextSearch/impl/Search_i/Worker_i_factory.h"
#include "shared/ContextSearch/impl/Search_i/PartialAlgorithm_i_factory.h"
#include "shared/ContextSearch/impl/Manage_i/RequestTransformer_i_factory.h"
#include "shared/ContextSearch/impl/Manage_i/Query_i_factory.h"
#include "shared/ContextSearch/impl/Manage_i/SynManager_i_factory.h"
#include "shared/ContextSearch/impl/Manage_i/ViewAsParts_i_factory.h"
#include "shared/ContextSearch/impl/Manage_i/ViewAsSequence_i_factory.h"
#include "shared/ContextSearch/impl/Manage_i/ViewAsSimple_i_factory.h"
#include "shared/ContextSearch/impl/Relevancy_i/Algorithm_i_factory.h"
#include "shared/ContextSearch/impl/Relevancy_i/AlgorithmIdentical_i_factory.h"
#include "shared/ContextSearch/impl/Relevancy_i/AlgorithmSingle_i_factory.h"
#include "shared/ContextSearch/impl/Relevancy_i/StrongAlgorithm_i_factory.h"
#include "shared/ContextSearch/impl/Relevancy_i/SimpleAlgorithm_i_factory.h"
#include "shared/ContextSearch/impl/Relevancy_i/InvbAlgorithm_i_factory.h"

namespace ContextSearch {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *4516572402BF_ENVIRONMENTS_CONFIG*
	//#UC END# *4516572402BF_ENVIRONMENTS_CONFIG*

	{
		Search_i::Algorithm_i_factory_var fctr = new Search_i::Algorithm_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Search_i::Worker_i_factory_var fctr = new Search_i::Worker_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Search_i::PartialAlgorithm_i_factory_var fctr = new Search_i::PartialAlgorithm_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Manage_i::RequestTransformer_i_factory_var fctr = new Manage_i::RequestTransformer_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Manage_i::Query_i_factory_var fctr = new Manage_i::Query_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Manage_i::SynManager_i_factory_var fctr = new Manage_i::SynManager_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Manage_i::ViewAsParts_i_factory_var fctr = new Manage_i::ViewAsParts_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Manage_i::ViewAsSequence_i_factory_var fctr = new Manage_i::ViewAsSequence_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Manage_i::ViewAsSimple_i_factory_var fctr = new Manage_i::ViewAsSimple_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Relevancy_i::Algorithm_i_factory_var fctr = new Relevancy_i::Algorithm_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Relevancy_i::AlgorithmIdentical_i_factory_var fctr = new Relevancy_i::AlgorithmIdentical_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Relevancy_i::AlgorithmSingle_i_factory_var fctr = new Relevancy_i::AlgorithmSingle_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Relevancy_i::StrongAlgorithm_i_factory_var fctr = new Relevancy_i::StrongAlgorithm_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Relevancy_i::SimpleAlgorithm_i_factory_var fctr = new Relevancy_i::SimpleAlgorithm_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Relevancy_i::InvbAlgorithm_i_factory_var fctr = new Relevancy_i::InvbAlgorithm_i_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void LibHomeImpl::finalize () {
}
} // namespace ContextSearch

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
