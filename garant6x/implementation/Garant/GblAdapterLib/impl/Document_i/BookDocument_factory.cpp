////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/BookDocument_factory.cpp"
// генератор файлов реализации для фабрик интерфейсов (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::BookDocument
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/BookDocument_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/BookDocument.h"

namespace GblAdapterLib {

BookDocument_factory::BookDocument_factory () {
}

void BookDocument_factory::registrate_me (
	Core::Root::FactoryPriority priority
) /*throw (
	Core::Root::DuplicatedFactoryKey
)*/ {
	DocumentFactoryManager::register_factory (this, priority);
}

const FactoryKey BookDocument_factory::key () const {
	return FK_BOOK;
}

Document* BookDocument_factory::make (GblPilot::Document* document) {
	//#UC START# *45EEB652019153E9F492021F_460A76FD02B9_IMPL*
	return new BookDocument (document);
	//#UC END# *45EEB652019153E9F492021F_460A76FD02B9_IMPL*
}

Document* BookDocument_factory::make (const GCD::PID& pid, bool is_edition, const char* name) {
	//#UC START# *45EEB652019153E9F492021F_4616303E031E_IMPL*
	return new BookDocument (pid, name);
	//#UC END# *45EEB652019153E9F492021F_4616303E031E_IMPL*
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

