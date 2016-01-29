////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/RefDocument_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::RefDocument
//
// Документ с http ссылками
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/RefDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/RefDocument.h"

namespace GblAdapterLib {

RefDocument_factory::RefDocument_factory () {
}

void RefDocument_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocumentFactoryManager::register_factory (this, priority);
}

const FactoryKey RefDocument_factory::key () const {
	return FK_REF;
}

Document* RefDocument_factory::make (GblPilot::Document* document) {
	//#UC START# *45EEB65201915227264A0175_460A76FD02B9_IMPL*
	return new RefDocument (document);
	//#UC END# *45EEB65201915227264A0175_460A76FD02B9_IMPL*
}

Document* RefDocument_factory::make (const GCD::PID& pid, bool is_edition, const char* name) {
	//#UC START# *45EEB65201915227264A0175_4616303E031E_IMPL*
	return new RefDocument (pid, name);
	//#UC END# *45EEB65201915227264A0175_4616303E031E_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

