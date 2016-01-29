////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garantPIL/implementation/component/cpp/garantCore/Search/impl/Searcher_i/SearchHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<UtilityClass::Class>> garantCore::Search::Searcher_i::SearchHelper
//
// Помощник
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "garantCore/Search/impl/Searcher_i/SearchHelper.h"
// by <<uses>> dependencies
#include "garantCore/Search/Cache/AttrCache.h"
#include "boost/lexical_cast.hpp"
#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"
#include "garantCore/Search/Utils/Interpreter.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/collection_iterator.h"

namespace Search {
namespace Searcher_i {

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// проверка на валидность
bool SearchHelper::check_query (SearchBase* base, const std::string& in) {
	//#UC START# *556DA61901B7*
	if (in.empty ()) {
		return false;
	}

	AttrCache* cache = AttrCache::instance ();

	Core::Aptr <QueriesTags> tags = Interpreter::execute (in);

	if (tags->empty ()) {
		return false;
	}

	GDS_ASSERT (base);
	GDS_ASSERT (tags.is_nil () == false);

	for (QueriesTags::const_iterator it = tags->begin (); it != tags->end (); ++it) {
		if (it->key == BOOL_TYPE) {
			if (SearchHelper::check_query (base, it->val) == false) {
				return false;
			}
		} else if (it->key == BODY_TYPE || it->key == TITLE_TYPE) {
			continue;
		} else if (cache->get_type (it->key) == AttrCache::at_String && strchr (it->val.c_str (), '*')) {
			continue;
		} else {
			Index* index = base->FindIndex (it->key.c_str ());

			if (index == 0) {
				return false;
			}

			if (cache->get_type (it->key) == AttrCache::at_Date) {
				std::string val = it->val;
				val.erase (std::remove (val.begin (), val.end (), ' '), val.end ());

				std::vector <std::string> parts;
				boost::split (parts, val, boost::is_any_of (";"));

				Core::Aptr <char, Core::ArrayDeleteDestructor <char> > from, to;

				if (parts.size () == 2) {
					from = SearchHelper::make_date_key (parts [0]);
					to = SearchHelper::make_date_key (parts [1]);
				}

				if (from.is_nil () && to.is_nil ()) {
					return false;
				}
			} else {
				Core::Aptr <char, Core::ArrayDeleteDestructor <char> > key = SearchHelper::make_key (base, *it);

				if (key.is_nil ()) {
					return false;
				}

				Stream* str = index->Index::OpenN (key.in (), 0);

				if (str) {
					index->Close (str);
				} else {
					return false;
				}
			}
		}
	}

	return true;
	//#UC END# *556DA61901B7*
}

// копирование коллекции
SortedCollection* SearchHelper::copy_collection (const SortedCollection* in) {
	//#UC START# *50EFE77500AF*
	if (in && in->ItemCount) {
		if (in->Tag () == OT_DOCCOLLECTION) {
			return new DocCollection (*(dynamic_cast <const DocCollection*> (in)));
		} else if (in->Tag () == OT_CORRREFS_COLLECTION) {
			return new CorrRefCollection (*(dynamic_cast <const CorrRefCollection*> (in)));
		} else if (in->Tag () == OT_PARASCOLLECTION) {
			return new ParasCollection (*(dynamic_cast <const ParasCollection*> (in)));
		} else if (in->Tag () == OT_REFCOLLECTION) {
			return new RefCollection (*(dynamic_cast <const RefCollection*> (in)));
		} else if (in->Tag () == OT_RELECOLLECTION) {
			Core::Aptr <DocCollection> ret = new DocCollection;

			for (long i = 0; i < in->PageCount; ++i) {
				RefwRele* ptr = (RefwRele*) in->Pages [i];

				for (long j = 0; j < in->Count [i]; ++j) {
					ret->Add (ptr [j].DocId);
				}
			}

			typedef fast_collection_iterator <SortedCollection, long, DOC_PAGE_SIZE> Iterator;
			std::sort (Iterator (ret.in (), 0), Iterator (ret.in (), ret->ItemCount));
			return ret._retn ();
		} else if (in->Tag () == OT_RELESUBCOLLECTION) {
			Core::Aptr <SortedCollection> ret = new RefCollection;

			for (int i = 0; i < in->ItemCount; ++i) {
				RefwRele* ati = (RefwRele*) in->GetItem (i);
				Ref sub = {ati->DocId, ati->Word};
				ret->Add (&sub);
			}
			return ret._retn ();
		} else {
			GDS_ASSERT (0);
		}
	}

	return 0;
	//#UC END# *50EFE77500AF*
}

// приоритет
short SearchHelper::get_data_priority (short type) {
	//#UC START# *55E5B33002D7*
	switch (type) {
		case OT_RELECOLLECTION:
			return 7;
		case OT_RELESUBCOLLECTION:
			return 6;
		case OT_CORRREFS_COLLECTION:
			return 5;
		case OT_PARASCOLLECTION:
			return 4;
		case OT_REFCOLLECTION:
			return 3;
		case OT_DOCCOLLECTION:
			return 2;
		case OT_REFWEIGHTCOLLECTION:
			return 1;
	}

	GDS_ASSERT (0);
	return 0;
	//#UC END# *55E5B33002D7*
}

// фабрика ключей для хранилища
char* SearchHelper::make_date_key (const std::string& str) {
	//#UC START# *516C14A003D2*
	Core::Aptr <char, Core::ArrayDeleteDestructor <char> > ret;

	if (str.empty () == false) {
		std::vector <std::string> parts;
		boost::split (parts, str, boost::is_any_of ("./-"));

		if (parts.size () == 3) {
			::date d;

			d.da_day  = (unsigned char) (boost::lexical_cast <unsigned short> (parts [0]));
			d.da_mon  = (unsigned char) (boost::lexical_cast <unsigned short> (parts [1]));
			d.da_year = boost::lexical_cast <unsigned short> (parts [2]);

			ret = new char [sizeof (::date)];
			ACE_OS::memcpy (ret.inout (), &d, sizeof (::date));
		} else {
			GDS_ASSERT (0);
		}
	}

	return ret._retn ();
	//#UC END# *516C14A003D2*
}

// фабрика ключей для хранилища
char* SearchHelper::make_key (SearchBase* base, const QueryTag& tag) {
	//#UC START# *516C10A100A1*
	Core::Aptr <char, Core::ArrayDeleteDestructor <char> > ret;

	AttrCache::AttributeType type = AttrCache::instance ()->get_type (tag.key);

	if (type == AttrCache::at_String || tag.key [0] == '!' || tag.key [0] == '?') {
		ret = new char [tag.val.size () + 1];
		ACE_OS::memcpy (ret.inout (), tag.val.c_str (), tag.val.size () + 1);
	} else if (type == AttrCache::at_Integer) {
		int val  = boost::lexical_cast <int> (tag.val);
		ret = new char [sizeof (val)];
		ACE_OS::memcpy (ret.inout (), &val, sizeof (val));
	} else {
		Index* index = base->FindIndex (tag.key.c_str ());
		HIndex* hindex = (HIndex*) index;

		std::vector <std::string> parts;
		boost::split (parts, tag.val, boost::is_any_of ("\\"));

		size_t i = 0, parent = 0;

		unsigned short prefix_len = (tag.key == "KeyWord")? 0 : 4;

		for (BTIterator it (hindex); !it.End (); ++it) {
			HIndex::HIndexKey* key = (HIndex::HIndexKey*) it.Key ();

			if (i == key->level && parent == key->parent && parts [i].compare (key->text + prefix_len) == 0) {
				++i;
				if (i == parts.size ()) {
					ret = new char [index->KeyLength];
					ACE_OS::memcpy (ret.inout (), key, index->KeyLength);
					break;
				}
				parent = key->id;
			}
		}
	}

	return ret._retn ();
	//#UC END# *516C10A100A1*
}

// трансформация
SortedCollection* SearchHelper::transform_for_title_search (SortedCollection* in, const SortedCollection* list) {
	//#UC START# *5314ACDF0087*
	if (list->Tag () == OT_REFCOLLECTION || list->Tag () == OT_PARASCOLLECTION) {
		//пересечь, оставляя из list вхождения, а из in релевантность
		Core::Aptr <SortedCollection> ret = (list->Tag () == OT_REFCOLLECTION)? new RefwReleSubCollection () : new ParaswReleCollection ();

		long pos1 = 0, pos2 = 0;

		while (pos1 < in->ItemCount && pos2 < list->ItemCount) {
			RefwRele* at1 = (RefwRele*) in->GetItem (pos1);
			Ref* at2 = (Ref*) list->GetItem (pos2);

			if (at1->DocId == at2->DocId) {
				RefwRele add = {at1->DocId, at2->Sub, at1->Rele};

				if (list->Tag () == OT_PARASCOLLECTION || !(at2->Sub & INHERITED_BLOCK)) {
					ret->Collection::Add (&add);
				}

				pos2++;

				while (pos2 < list->ItemCount) {
					at2 = (Ref*) list->GetItem (pos2);

					if (at2->DocId == at1->DocId) {
						if (list->Tag () == OT_PARASCOLLECTION || !(at2->Sub & INHERITED_BLOCK)) {
							add.Word = at2->Sub;
							ret->Collection::Add (&add);
						}
						pos2++;
					} else {
						break;
					}
				}
				pos1++;
			} else if (at1->DocId < at2->DocId) {
				pos1++;
			} else {
				pos2++;
			}
		}

		return ret._retn ();
	} 

	return in;
	//#UC END# *5314ACDF0087*
}

} // namespace Searcher_i
} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

