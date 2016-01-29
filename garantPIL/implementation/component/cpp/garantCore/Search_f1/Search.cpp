
#include <strstream>

#include "boost/algorithm/string/classification.hpp"
#include "boost/algorithm/string/split.hpp"
#include "boost/lexical_cast.hpp"

#include "shared/GCL/str/str_conv.h"

#include "garantCore/Search/Facade/Facade.h"
#include "garantCore/Search/Utils/Interpreter.h"
#include "garantCore/Search/impl/Searcher_i/SearchHelper.h"
#include "garantCore/Search/impl/Filters_i/Filters.h"
#include "garantCore/Search_f1/Search.h"

#include "garantPIL/implementation/component/cpp/libs/gkdb/src/collection_iterator.h"
#include "garantPIL/implementation/component/cpp/libs/gkdb/src/BaseCache.h"

namespace Search {

class Registrator_f1 {
	friend class ACE_Singleton <Registrator_f1, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static void execute () {
		ACE_Singleton <Registrator_f1, ACE_SYNCH_RECURSIVE_MUTEX>::instance ();
	}

protected:
	Registrator_f1 () {
		register_key_base ("AllowedSeg", (CallBackBase) &get_allowed_docs);
		register_key_base ("Aux", (CallBackBase) &get_aux);
		register_key_base ("AllDocs", (CallBackBase) &get_all_docs);
	}

private:
	static SortedCollection* get_all_docs (SearchBase* base, const std::string& str) {
		if (str == "Med") {
			return base->inpharm_medtopics ();
		}
		return base->AllDocs ();
	}

	static SortedCollection* get_allowed_docs (SearchBase* base, const std::string& str) {
		std::vector <std::string> parts;
		boost::split (parts, str, boost::is_any_of (","));

		std::vector <short> segments;

		for (std::vector <std::string>::const_iterator it = parts.begin (); it != parts.end (); ++it) {
			if (it->empty () == false) {
				segments.push_back (boost::lexical_cast <short> (*it));
			}
		}

		Index* index = base->FindIndex ("Segment");

		std::vector <long> tmp;
		{
			const std::vector <short>& here_segs = BaseCache::instance ()->get_here_seg (base);
			const std::vector <short>& ignore_segs = BaseCache::instance ()->get_ignore_segs (base);

			const DocDataMap& map_doc_edis = BaseCache::instance ()->get_map_doc_edis (base);

			for (std::vector <short>::const_iterator it = here_segs.begin (); it != here_segs.end (); ++it) {
				short seg = *it;

				bool is_ignore = std::binary_search (ignore_segs.begin (), ignore_segs.end (), seg);

				if (!std::binary_search (segments.begin (), segments.end (), seg) && !is_ignore) {
					Stream* str = index->Open (&seg);

					if (str) {
						size_t count = (size_t) str->Length () / sizeof (long);

						Core::Aptr <long, Core::ArrayDeleteDestructor <long> > buf =  new long [count + 1];
						str->Read (buf.inout (), str->Length ());
						tmp.insert (tmp.end (), buf.ptr (), buf.ptr () + count);
						index->Close (str);

						for (size_t i = 0; i < count; i++) {
							long doc_id = (buf.in ()) [i];

							std::map <long, std::set <long> >::const_iterator map_it = map_doc_edis.find (doc_id);

							if (map_it != map_doc_edis.end ()) {
								for (std::set <long>::const_iterator edis_it = map_it->second.begin (); edis_it != map_it->second.end (); edis_it++) {
									tmp.push_back (*edis_it);
								}
							}
						}
					}
				} 
			}
		}

		std::sort (tmp.begin (), tmp.end ());
		tmp.erase (std::unique (tmp.begin (), tmp.end ()), tmp.end ());

		Core::Aptr <DocCollection> ret = new DocCollection ();

		for (std::vector <long>::const_iterator it = tmp.begin (); it != tmp.end (); ++it) {
			ret->Collection::Add (&(*it));
		}

		return ret._retn ();
	}

	static SortedCollection* get_aux (SearchBase* base, const std::string& str) {
		Core::Aptr <DocCollection> ret = new DocCollection ();

		Index* index = base->FindIndex ("Aux");

		Stream* store = index->Open (str.c_str ());

		if (store) {
			ret->Get (store);
			index->Close (store);
		}

		return ret._retn ();
	}
};

//////////////////////////////////////////////////////////////////////////////////////////

static bool has_context (const std::string& str) {
	return (str.find (BODY_TYPE) != std::string::npos || str.find (TITLE_TYPE) != std::string::npos);
}

static SortedCollection* transform_to_doc_collection (SortedCollection* in) {
	Core::Aptr <DocCollection> ret = new DocCollection ();

	long prev_id = 0;

	for (long i = 0; i < in->ItemCount; ++i) {
		Ref* item = (Ref*) in->GetItem (i);

		if (item->DocId != prev_id) {
			prev_id = item->DocId;
			ret->Collection::Add (&prev_id);
		}
	}

	return ret._retn ();
}

static RefwReleCollection* find_in_cache_ (SearchBase* base, const std::string& req, const Segments& segments) {
	const RequestCacheOffset& cache_offset = BaseCache::instance ()->get_request_cache_offset (base);

	std::string context = req;
	GCL::to_upper (context);

	RequestCacheOffset::const_iterator it = cache_offset.find (context);

	if (it != cache_offset.end ()) {
		Core::Aptr <RefwReleCollection> ret = new RefwReleCollection ();

		std::set <long> inserted_docs;
		std::vector <long>::const_iterator ofs_it = it->second.begin ();

		Index* index = base->FindIndex ("Aux");

		const std::vector <short>& segs = BaseCache::instance ()->get_here_seg (base);

		for (std::vector<short>::const_iterator seg_it = segs.begin (); seg_it != segs.end (); ++seg_it, ++ofs_it) {
			if (std::binary_search (segments.begin (), segments.end (), *seg_it)) {
				continue;
			}

			if (*ofs_it != -1) {
				char name [5];
				sprintf (name, "|%03d", *seg_it);
				Stream *str = index->Open (name);
				if (str) {
					str->Seek (*ofs_it);
					long count, i;
					str->Read (&count, sizeof (long));
					for (i = 0; i < count; i++) {
						RefwRele rele;
						str->Read (&rele, sizeof (RefwRele));
						if (inserted_docs.find (rele.DocId) == inserted_docs.end ()) {
							ret->Collection::Add (&rele);
							inserted_docs.insert (rele.DocId);
						}
					}
					index->Close (str);
				}
			}
		}

		if (ret->ItemCount) {
			typedef fast_collection_iterator <SortedCollection, RefwRele, REL_COL_PAGE_SIZE> Iterator;

			long short_list_size = BaseCache::instance ()->get_short_list_size (base);

			if (short_list_size < ret->ItemCount) {
				std::partial_sort (
					Iterator (ret.in (), 0)
					, Iterator (ret.in (), short_list_size)
					, Iterator (ret.in (), ret->ItemCount)
					, CompareByRel ()
				);
			} else {
				std::sort (Iterator (ret.in (), 0), Iterator (ret.in (), ret->ItemCount), CompareByRel ());
			}

			return ret._retn ();
		}
	}

	return 0;
}

static SearchResult* find_in_cache (SearchBase* base, const std::string& str, const Segments& segments) {
	Core::Aptr <QueriesTags> tags = Interpreter::execute_ext (str);

	if (tags->size () == 2) {
		QueryTag& ctx_tag = tags->front ();
		QueryTag& tag = tags->back ();

		if (ctx_tag.key == BODY_TYPE && tag.key == "Status" && tag.val == "2048" && tag.op == so_NOT) {
			Core::Aptr <SortedCollection> res = find_in_cache_ (base, ctx_tag.val, segments);

			if (res.is_nil () == false) {
				long short_size = BaseCache::instance ()->get_short_list_size (base);

				Core::Aptr <SearchResult> ret = new SearchResult ();
				ret->is_cut = (res->ItemCount >= short_size);
				ret->full_size = res->ItemCount;
				res->Cut (short_size);
				ret->list = res._retn ();
				return ret._retn ();
			}
		}
	}

	return 0;
}

SearchResult* execute (
	SearchBase* base
	, const std::string& str
	, const Segments& segments
	, const SortedCollection* init
	, bool show_short_list
	, bool remove_wo_annos
) {
	Registrator_f1::execute ();

	std::string query = str;

	if (segments.empty () == false) {
		std::strstream s;
		std::copy (segments.begin (), segments.end (), std::ostream_iterator <short> (s, ","));
		std::string seg_str (s.str (), s.pcount () - 1);
		query += " & AllowedSeg (" + seg_str + ")";
		s.freeze (false);
	}

	const DocCollection& data = AllDocsCache::instance ()->get_med_docs (base);

	if (has_context (str) == false) {
		if (data.ItemCount) {
			query += " ~ AllDocs (Med)";
		}
		if (remove_wo_annos) {
			query += " & Aux (WAno)";
		}
	} else {
		GDS_ASSERT (remove_wo_annos == false);

		if (show_short_list && init == 0) {
			Core::Aptr <SearchResult> ret = find_in_cache (base, str, segments);

			if (ret.is_nil () == false) {
				return ret._retn ();
			}
		}
	}

	BooleanFilter filter;
	filter << Filter (const_cast <DocCollection*> (&data), so_NOT);

	SearchProp prop;
	prop.init = init;
	prop.filter = filter.in ();

	if (show_short_list) {
		prop.max_res_size = BaseCache::instance ()->get_short_list_size (base);
	}

	ISearcher_var searcher = Factory::make_searcher (base);

	Core::Aptr <SearchResult> ret = searcher->execute (query, prop);

	if (remove_wo_annos) {
		if (ret->list.is_nil () == false && ret->list->Tag () == OT_REFCOLLECTION && ret->list->ItemCount) {
			ret->list = transform_to_doc_collection (ret->list.in ());
		}
	}

	return ret._retn ();
}

SearchResult* execute_pharm (
	SearchBase* base
	, const std::string& str
	, const Segments& segments
	, const SortedCollection* init
	, bool show_short_list
) {
	if (segments.find (INPHARM_SEGMENT) != segments.end ()) {
		return new SearchResult ();
	}

	Registrator_f1::execute ();

	SearchProp prop;
	prop.init = init;

	if (show_short_list) {
		prop.max_res_size = BaseCache::instance ()->get_short_list_size (base);
	}

	std::string query = str;
	query += " & BOOL (| Status_ex (128) | Status_ex (2048))";

	ISearcher_var searcher = Factory::make_searcher (base);
	return searcher->execute (query, prop);
}

bool check_query (SearchBase* base, const std::string& str) {
	try {
		return Searcher_i::SearchHelper::check_query (base, str);
	} catch (...) {
		LOG_UEX ((GDS_CURRENT_FUNCTION));
	}
	return false;
}

} // namespace Search

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////