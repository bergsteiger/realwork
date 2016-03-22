////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/KeysFactory.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::MorphoBase::KeysFactory
//
// Фабрика ключей для хранилища
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MORPHOBASE_KEYSFACTORY_H__
#define __SHARED_CONTEXTSEARCH_MORPHOBASE_KEYSFACTORY_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"

//#UC START# *565C3ADC00FD_CUSTOM_INCLUDES*
//#UC END# *565C3ADC00FD_CUSTOM_INCLUDES*

namespace ContextSearch {

// Фабрика ключей для хранилища
class KeysFactory {
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// добавить варианты леммы
	static GCL::StrVector* correct (const std::string& in);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit KeysFactory (DBComm::IDBCommunicator* comm);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// определение идентичных
	void get_identical (const Search::PhraseEx& request, Relevancy::Positions& out);

	// определение идентичных
	void get_identical (const std::string& request, Relevancy::Positions& out);

	// создать
	GCL::StrSet* make (const GCL::StrSet& in);

	// создать
	GCL::StrSet* make_for_word (const std::string& word);

private:
	// добавить ключ для заданной леммы
	void add (const std::string& word, GCL::StrSet& out);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	DBComm::IDBCommunicator* m_communicator;

//#UC START# *565C3ADC00FD*
//#UC END# *565C3ADC00FD*
}; // class KeysFactory

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MORPHOBASE_KEYSFACTORY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

