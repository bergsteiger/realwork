////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase_TransactionContainer.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractDumperBase::TransactionContainer
//
// класс для работы с объектами, открывающими транзакции
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"

class AbstractDumperBase;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AbstractDumperBase::TransactionContainer::~TransactionContainer () {
	//#UC START# *469067F300CB_DESTR_BODY*
	this->close_all ();
	//#UC END# *469067F300CB_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавить источник генерации
void AbstractDumperBase::TransactionContainer::add_source (const GenSourceInfo& source) {
	//#UC START# *4690685C03D8*
	m_sources.insert (source);
	//#UC END# *4690685C03D8*
}

// закрывает транзакции на всех объектах
void AbstractDumperBase::TransactionContainer::close_all () {
	//#UC START# *469068D9001F*
	ServerGate::GenerationContents::PageList pages;
	for (
		GenSourceInfoSet::iterator it = m_sources.begin ()
		; it != m_sources.end ()
		; ++it
	) {
		if (it->source.d_() == AbstractDumperBase::GST_WIKI) {
			if (it->source.wiki_page () != 0) {
				pages.length (pages.length () + 1);
				pages[pages.length () - 1] = ServerGate::GenerationContents::Page::_duplicate (
					it->source.wiki_page ()->get_delegate ()
				);
				it->source.wiki_page ()->reset ();
			}
		}
	}
	try {
		if (pages.length () > 0) {
			LOG_I (("GenerationManager->rollback_all (%d)", pages.length ()));
			ServerGate::GenerationContents::GenerationManagerFactory::get ().rollback_all (pages);
		}
	} catch (...) {
	}

	m_sources.clear ();
	//#UC END# *469068D9001F*
}

// удалить источник
void AbstractDumperBase::TransactionContainer::remove_source (const GenSourceInfo& source) {
	//#UC START# *469068A5000F*
	m_sources.erase (source);
	//#UC END# *469068A5000F*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

