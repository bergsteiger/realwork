////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ActualAnalyticsContentsDocument_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::ActualAnalyticsContentsDocument
//
// ААК-содержание
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ActualAnalyticsContentsDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/ActualAnalyticsContentsDocument.h"

namespace GblAdapterLib {

ActualAnalyticsContentsDocument_factory::ActualAnalyticsContentsDocument_factory () {
}

void ActualAnalyticsContentsDocument_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocumentFactoryManager::register_factory (this, priority);
}

const FactoryKey ActualAnalyticsContentsDocument_factory::key () const {
	return FK_ACTUAL_ANALYTICS_CONTENTS_DOCUMENT;
}

Document* ActualAnalyticsContentsDocument_factory::make (GblPilot::Document* document) {
	//#UC START# *45EEB65201914FE8619103CE_460A76FD02B9_IMPL*
	return new ActualAnalyticsContentsDocument (document);
	//#UC END# *45EEB65201914FE8619103CE_460A76FD02B9_IMPL*
}

Document* ActualAnalyticsContentsDocument_factory::make (const GCD::PID& pid, bool is_edition, const char* name) {
	//#UC START# *45EEB65201914FE8619103CE_4616303E031E_IMPL*
	return new ActualAnalyticsContentsDocument (pid, name);
	//#UC END# *45EEB65201914FE8619103CE_4616303E031E_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

