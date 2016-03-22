////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/ContextSearch/MorphoBase/InvbSearcher.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::MorphoBase::InvbSearcher
//
// Поиск невидимых блочных вхождений
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MORPHOBASE_INVBSEARCHER_H__
#define __SHARED_CONTEXTSEARCH_MORPHOBASE_INVBSEARCHER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "shared/ContextSearch/Search/Search.h"
#include "shared/ContextSearch/DBComm/DBComm.h"
#include "shared/ContextSearch/Relevancy/Relevancy.h"

//#UC START# *56B48AF00107_CUSTOM_INCLUDES*
//#UC END# *56B48AF00107_CUSTOM_INCLUDES*

namespace ContextSearch {

// Поиск невидимых блочных вхождений
class InvbSearcher {
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	InvbSearcher (const Search::RequestEx& request, DBComm::IDBCommunicator* comm);

	InvbSearcher (const GCL::StrVector& request, DBComm::IDBCommunicator* comm);

	InvbSearcher (const std::string& in, bool wo_split, DBComm::IDBCommunicator* comm);

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// вхождения для заданного документа
	Relevancy::BlockEntries* get (DBComm::DocId id);

private:
	// add
	void add_span (const std::string& in, const DBComm::InvisibleDataIndex& index);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	DBComm::IDBCommunicator* m_communicator;

//#UC START# *56B48AF00107*
private:
	class Stream {
	public:
		Stream (const std::string& key, const DBComm::InvisibleDataIndex& index);

		const DBComm::Entries& get (DBComm::DocId id);

	private:
		const DBComm::Entries& get (const DBComm::InvisibleData& data, DBComm::DocId id);
		const DBComm::Entries& get (DBComm::DocId id, DBComm::Entries chain, size_t pos);

	private:
		 bool m_is_valid;

		 DBComm::Entries m_cache;

		 typedef std::vector <DBComm::InvisibleDataIndex::const_iterator> IndexIterators;

		 IndexIterators m_its;
	};

	typedef std::vector <Stream> WStreams;
	typedef std::vector <WStreams> Streams;

private:
	template <typename Type>
	void add (const Type& in, const DBComm::InvisibleDataIndex& index) {
		GCL::StrSet total (in.begin (), in.end ());

		const DBComm::Synonyms& syns = m_communicator->get_ssyns ();
		{
			for (Type::const_iterator it = in.begin (); it != in.end (); ++it) {
				DBComm::SynPair pair;
				pair.key = *it;

				DBComm::Synonyms::const_iterator _it = std::lower_bound (syns.begin (), syns.end (), pair, DBComm::SynCompare ());

				if (_it != syns.end () && _it->key == *it) {
					total.insert (_it->data.begin (), _it->data.end ());
				}
			}
		}

		m_data.push_back (WStreams ());

		for (GCL::StrSet::const_iterator it = total.begin (); it != total.end (); ++it) {
			m_data.back ().push_back (Stream (*it, index));
		}
	}

private:
	Streams m_data;

	std::vector <Relevancy::Mark> m_markup;

//#UC END# *56B48AF00107*
}; // class InvbSearcher

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MORPHOBASE_INVBSEARCHER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

