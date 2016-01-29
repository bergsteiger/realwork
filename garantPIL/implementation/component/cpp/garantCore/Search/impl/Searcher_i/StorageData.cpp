////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Searcher_i/StorageData.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> garantCore::Search::Searcher_i::StorageData
//
// StorageData
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/impl/Searcher_i/StorageData.h"
// by <<uses>> dependencies
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/collection_iterator.h"

//#UC START# *5107F94B015E_CUSTOM_INCLUDES*
//#UC END# *5107F94B015E_CUSTOM_INCLUDES*

namespace Search {
namespace Searcher_i {

//#UC START# *5107F94B015E*
class RefEqual : public std::binary_function <Ref, Ref, bool> {
public:
	bool operator () (const Ref& x, const Ref& y) const {
		return (x.DocId == y.DocId && x.Sub == y.Sub);
	}
};

template <typename Element, std::ptrdiff_t page_size, class EqualPredicate>
static void sort_unique (Collection* data, EqualPredicate pred) {
	typedef fast_collection_iterator <Collection, Element, page_size> Iterator_;

	Iterator_ beg (data, 0);
	Iterator_ end (data, data->ItemCount);

	std::sort (beg, end);
	data->Cut (std::distance (beg, std::unique (beg, end, pred)));
}
//#UC END# *5107F94B015E*

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// фабрика для коллекции заданного типа
SortedCollection* StorageData::make (long type) {
	//#UC START# *51093A790069*
	if (type == SDT_DOCS) {
		return new DocCollection;
	} else if (type == SDT_REFS) {
		return new RefCollection;
	} else if (type == SDT_CORRREFS) {
		return new CorrRefCollection;
	} else if (type == SDT_REFWEIGHTS) {
		return new RefwWeightCollection;
	}

	GDS_ASSERT (0);
	return 0;
	//#UC END# *51093A790069*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

StorageData::StorageData (SearchBase* base)
//#UC START# *51092FB10222_BASE_INIT*
	: m_base (base)
//#UC END# *51092FB10222_BASE_INIT*
{
	//#UC START# *51092FB10222_BODY*
	//#UC END# *51092FB10222_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// результат
SortedCollection* StorageData::_retn () {
	//#UC START# *510939B90052*
	if (m_data.is_nil () == false) {
		if (m_data->Tag () == OT_DOCCOLLECTION) {
			sort_unique <long, DOC_PAGE_SIZE> (m_data.inout (), std::equal_to <long> ());
		} else if (m_data->Tag () == OT_REFCOLLECTION) {
			sort_unique <Ref, REF_PAGE_SIZE> (m_data.inout (), RefEqual ());
		} else {
			GDS_ASSERT (0);
		}
	}

	return m_data._retn ();
	//#UC END# *510939B90052*
}

// добавить
void StorageData::add (const char* name, const char* from, const char* to) {
	//#UC START# *51093FB50079*
	GDS_ASSERT (m_base);

	Index* index = m_base->FindIndex (name);

	GDS_ASSERT (index);

	for (BTIterator it (index, from); !it.End (); ++it) {
		if (to == 0 || it <= to) {
			this->add (index, it.Key ());
		} else {
			break;
		}
	}
	//#UC END# *51093FB50079*
}

// добавить
void StorageData::add (Index* index, const void* key) {
	//#UC START# *5304C91002CF*
	IndexRecordData* rd = index->recordData (key, 0);

	GDS_ASSERT (rd);

	if (rd) {
		Stream* str = new Stream (index->streams, rd, index->ImmDataSize, index->roundv, 0);

		if (str) {
			if (m_data.is_nil ()) {
				m_data = StorageData::make (GetDataType (index));
			}

			size_t item_size, len = str->Length ();

			if (m_data->Tag () == OT_DOCCOLLECTION) {
				item_size = sizeof (long);
			} else if (m_data->Tag () == OT_REFCOLLECTION) {
				item_size = sizeof (Ref);
			} else {
				return;
			}

			Core::Aptr <char, Core::ArrayDeleteDestructor <char> > buf = new char [len + 1];
			str->Read (buf.inout (), len);
			index->Close (str);

			for (const char* ptr = buf.ptr (); (size_t) (ptr - buf.ptr ()) < len; ptr += item_size) {
				m_data->Add (ptr);
			}
		}
	}
	//#UC END# *5304C91002CF*
}

// данные
SortedCollection* StorageData::get (const char* name, const char* val) {
	//#UC START# *51093DDF0142*
	GDS_ASSERT (m_base);

	if (name [0] == '!') {
		return m_base->get_virtualindex_data (name, val);
	} else if (name [0] == '?') {
		return m_base->get_complexindex_data (name, val);
	} else {
		Index* index = m_base->FindIndex (name);

		GDS_ASSERT (index);

		Stream* str = index->Index::OpenN (val, 0);

		if (str) {
			Core::Aptr <SortedCollection> ret = StorageData::make (GetDataType (name));
			ret->Get (str);
			index->Close (str);
			return ret._retn ();
		}
	}

	GDS_ASSERT (0);
	return 0;
	//#UC END# *51093DDF0142*
}

} // namespace Searcher_i
} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

