////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DictDocument_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DictDocument
//
// Документ - толкование толкового словаря
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DictDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DictDocument.h"

namespace GblAdapterLib {

DictDocument_factory::DictDocument_factory () {
}

void DictDocument_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocumentFactoryManager::register_factory (this, priority);
}

const FactoryKey DictDocument_factory::key () const {
	return FK_DICT_DOCUMENT;
}

Document* DictDocument_factory::make (GblPilot::Document* document) {
	//#UC START# *45EEB652019147EBBAD202AB_460A76FD02B9_IMPL*
	return new DictDocument (document);
	//#UC END# *45EEB652019147EBBAD202AB_460A76FD02B9_IMPL*
}

Document* DictDocument_factory::make (const GCD::PID& pid, bool is_edition, const char* name) {
	//#UC START# *45EEB652019147EBBAD202AB_4616303E031E_IMPL*
	return new DictDocument (pid, name);
	//#UC END# *45EEB652019147EBBAD202AB_4616303E031E_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

