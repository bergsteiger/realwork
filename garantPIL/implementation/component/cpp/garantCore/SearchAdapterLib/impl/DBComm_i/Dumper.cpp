////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/SearchAdapterLib/impl/DBComm_i/Dumper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::SearchAdapterLib::DBComm_i::Dumper
//
// Дампер
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/SearchAdapterLib/impl/DBComm_i/Dumper.h"

//#UC START# *4ED6475702A1_CUSTOM_INCLUDES*
//#UC END# *4ED6475702A1_CUSTOM_INCLUDES*

namespace SearchAdapterLib {
namespace DBComm_i {

//#UC START# *4ED6475702A1*
using namespace ContextSearch;

Dumper::Dumper (const char* file_name) {
	ofs.open (file_name, std::ios_base::trunc);
}

Dumper::~Dumper () {
	ofs.close ();
}

void Dumper::out (const Relevancy::Fragments& data) {
	for (Relevancy::Fragments::const_iterator it = data.begin (); it != data.end () ; ++it) {
		ofs << "r:" << it->info.relevancy_value << ",\tp:" << it->info.position << ",\t\t{";
		std::copy (it->data.begin (), it->data.end (), std::ostream_iterator <size_t> (ofs, " "));
		ofs << '}' << std::endl;
	}
	ofs << std::endl;
}

void Dumper::out (const DBCore::DocVector& data) {
	std::copy (data.begin (), data.end (), std::ostream_iterator <DBCore::DocId> (ofs, "\n"));
}

void Dumper::out (const DBCore::RelTuneData& data) {
	for (DBCore::RelTuneData::const_iterator it = data.begin (); it != data.end (); ++it) {
		ofs << it->id << " : " << it->rel << std::endl;
	}
}

void Dumper::out (const Morpho::Def::StrStrMap& map) {
	for (Morpho::Def::StrStrMap::const_iterator it = map.begin (); it != map.end (); ++it) {
		ofs << it->first << ": " << it->second << std::endl;
	}
}

void Dumper::out (const DBCore::PSDTemplates& data) {
	for (DBCore::PSDTemplates::const_iterator it = data.begin (); it != data.end (); ++it) {
		std::copy (it->begin (), it->end (), std::ostream_iterator <short> (ofs, " "));
		ofs << std::endl;
	}
}

void Dumper::out (const DBComm::StrPairVector& data) {
	for (DBComm::StrPairVector::const_iterator it = data.begin (); it != data.end (); ++it) {
		ofs << it->first << " : " << it->second << std::endl;
	}
}

void Dumper::out (const DBComm::Synonyms& data) {
	for (DBComm::Synonyms::const_iterator it = data.begin (); it != data.end (); ++it) {
		ofs << it->key << ": {" ;
		std::copy (it->data.begin (), it->data.end (), std::ostream_iterator <std::string> (ofs, ", "));
		ofs << "}\n";
	}
}

void Dumper::out (const DBComm::InvisibleDataIndex& data) {
	for (DBComm::InvisibleDataIndex::const_iterator it = data.begin (); it != data.end (); ++it) {
		ofs << it->key << std::endl;

		GDS_ASSERT (it->ids.size () == it->data.size ());

		size_t sz = it->ids.size ();

		for (size_t i = 0; i < sz; ++i) {
			ofs << "  " << it->ids.at (i) << ": ";

			const DBComm::Entries& entries = it->data.at (i);

			for (DBComm::Entries::const_iterator _it = entries.begin (); _it != entries.end (); ++_it) {
				ofs << _it->pos << '.' << _it->len << '.' << _it->rel << "  ";
			}

			ofs << std::endl;
		}

		ofs << std::endl;
	}
}

void Dumper::out (const Defs::InvisibleBlocks& map) {
	Defs::InvisibleData::const_iterator _it;

	for (Defs::InvisibleBlocks::const_iterator it = map.begin (); it != map.end (); ++it) {
		ofs << it->first << " : " ;
		for (_it = it->second.begin (); _it != it->second.end (); ++_it) {
			ofs << _it->first << ":" << _it->second.length << ":" << (short) _it->second.relevancy << " ";
		}
		ofs << std::endl;
	}
}

void Dumper::out (const Defs::InvisibleRel& map) {
	Defs::PositionsRel::const_iterator _it;

	for (Defs::InvisibleRel::const_iterator it = map.begin (); it != map.end (); ++it) {
		ofs << it->first << " : " ;
		for (_it = it->second.begin (); _it != it->second.end (); ++_it) {
			ofs << _it->pos << ":" << (short) _it->rel << " ";
		}
		ofs << std::endl;
	}
}

void Dumper::out (const GCL::StrVector& vect, bool is_format) {
	for (GCL::StrVector::const_iterator it = vect.begin (); it != vect.end (); ++it) {
		if (is_format) {
			if (it == vect.begin ()) {
				continue;
			} else if ((it - 1)->empty ()) {
				if (it - 1 != vect.begin ()) {
					ofs << std::endl;
				}
				ofs << *it << ":   ";
				continue;
			} 
		} 
		ofs << *it << " ";
	}
}

void Dumper::out (const GCL::StrVector& data) {
	ofs << std::endl;
	std::copy (data.begin (), data.end (), std::ostream_iterator <std::string> (ofs, "\n"));
	ofs << std::endl;
}
//#UC END# *4ED6475702A1*

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor


} // namespace DBComm_i
} // namespace SearchAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

