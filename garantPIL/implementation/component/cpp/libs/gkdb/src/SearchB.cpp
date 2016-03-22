#include "ace/ACE.h"

#include <limits>

#include "shared/GCL/str/str_conv.h"
#include "shared/GCL/alg/set_operations.h"
#include "shared/Morpho/Facade/Cache.h"

#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"
#include "boost/algorithm/string/trim.hpp"
#include "boost/assign/std/set.hpp"
#include "boost/lexical_cast.hpp"
#include "boost/smart_ptr/scoped_array.hpp"
#include "boost/unordered_set.hpp"
#include "boost/bind.hpp"

#include "garantPIL/implementation/component/cpp/libs/endt/Defines.h"
#include "garantPIL/implementation/component/cpp/tools/CSAdapter/AdapterLoader.h"

#include "pack.h"
#include "recode.h"

#include "DBComm.h"
#include "SearchB.h"
#include "BaseCache.h"
#include "VirtualIndexesCache.h"
#include "ContextPartsHelper.h"

#ifndef	MIN_MEM_CONTEXT
#include "ROCBase.h"
#endif

//////////////////////////////////////////////////////////////////////////////////////////
namespace Morpho {
	static Def::ICache* get_cache (Base* base) {
		DBCore::IBase_var _base = DBCore::DBFactory::make (base);
		return get_cache (_base.in ());
	}
}

struct SearchHelper {
	static char* make_date_key (const std::string& str) {
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
	}

	static void convert (const SortedCollection* in, SortedCollection* out) {
		long *ids = (long*) malloc (sizeof (long) * in->ItemCount), *atids = ids;
		long i;
		for (i = 0; i < in->PageCount; i++) {
			RefwRele* ptr = (RefwRele*) in->Pages [i];
			for (long j = 0; j < in->Count [i]; j++) {
				*atids++ = ptr [j].DocId;
			}
		}
		std::sort (ids, atids);
		atids = ids;
		for (i = 0; i < in->ItemCount; i++) {
			out->Collection::Add (atids++);
		}
		free (ids);
	}

	static SortedCollection* make (SortedCollection* in) {
		GDS_ASSERT (0);
		return 0;
	}
};

int CompReq (IndexReq* r1, IndexReq* r2) {
	short op1 = r1->SearchOp & SM_MRGOPS;
	short op2 = r2->SearchOp & SM_MRGOPS;

	if ((r1->SearchOp & SM_VALOPS) == SV_INIT) op1 = SV_INIT;
	if ((r2->SearchOp & SM_VALOPS) == SV_INIT) op2 = SV_INIT;

	if (op1 == op2) {
		if (!strcmp (r1->Name, r2->Name) && !strcmp (r1->Name, "Status_ex")) {
			if (r1->ItemCount == 2 && r1->ItemSize == 2 && (*(short*)(sizeof (IndexReq) + (char*)r1) + *(short*)(2 + sizeof (IndexReq) + (char*)r1) == (DS_ALLOWED|DS_NOTALLOWED)))
				return -1;
			if (r2->ItemCount == 2 && r2->ItemSize == 2 && (*(short*)(sizeof (IndexReq) + (char*)r2) + *(short*)(2 + sizeof (IndexReq) + (char*)r2) == (DS_ALLOWED|DS_NOTALLOWED)))
				return 1;
		} else if (GetDataType (r1->Name) == GetDataType (r2->Name)) {
			if (!strcmp (r1->Name, r2->Name)) {
				return 0;
			} else {
				if (!strcmp (r1->Name, "Class")) return -1;
				if (!strcmp (r2->Name, "Class")) return 1;
				if (!strcmp (r1->Name, "Mkb")) return 1;
				if (!strcmp (r2->Name, "Mkb")) return -1;
			}
		} else {
			if (GetDataType (r1->Name) == SDT_REFS) return -1;
			if (GetDataType (r2->Name) == SDT_REFS) return 1;
			if (GetDataType (r1->Name) == SDT_DOCS) return -1;
			if (GetDataType (r2->Name) == SDT_DOCS) return 1;
		}
	} else {
		if (op1 == SV_INIT) return -1;
		if (op2 == SV_INIT) return 1;
		if (op1 == SO_OR) return -1;
		if (op2 == SO_OR) return 1;
		if (op1 == SO_AND) return -1;
		if (op2 == SO_AND) return 1;
		if (op1 == SO_MINUS) return -1;
		if (op2 == SO_MINUS) return 1;
		if (op1 == SO_SMARTMINUS) return -1;
		if (op2 == SO_SMARTMINUS) return 1;
	}

	return 0;
}

static void SortRequest (int reqCount, IndexReq* req []) {
	for (int i = 0; i < reqCount-1; i++) {
		for (int k = i; k >= 0; k--) {
			if (CompReq (req [k], req [k + 1]) > 0) {
				IndexReq* tmp = req [k];
				req [k] = req [k + 1];
				req [k + 1] = tmp;
			} else break;
		}
	}
}

//////////////////////////////////////////////////////////////////////////////////////////

ACE_Recursive_Thread_Mutex readshortattributes_mutex;

std::map <std::string, std::map <std::string, std::string> > map_index_oldkeynewkey;
std::map <std::string, std::map <std::string, HIndex::HIndexKey*> > map_indexname_mapfullkey_hindexkey;

//////////////////////////////////////////////////////////////////////////////////////////

SearchBase::SearchBase (const char* name, int mode)
	: YBase (name, mode)
	, m_is_morpho_exist (false)
	, language_tag (-1)
	, typing_errors_ptr (0)
	, good_words_ptr (0) {
}

SearchBase::~SearchBase () {
	if (new_docBuf) {
		free (new_docBuf);
		new_docBuf = 0;
	}
}

bool SearchBase::check_version () {
	bool res = false;

	try {
		res = IsMultiThreadsR ();
	} catch (...) {
		return false;
	}

	long version = 0;

	Index* index = FindIndex ("Aux");

	Stream* str = index->Open (AUX_VERSION);

	if (str) {
		if (str->Length () == sizeof (version)) {
			str->Read (&version, sizeof (version));
		}
		index->Close (str);
	}

	if (version != GKDB_BASE_VERSION) {
		return false;
	}

	BaseCache::instance ()->init_protected_para (this);
	ContextPartsHelper::init (this);

	IndexInfo info;

	if (!keyFile->GetAttr ("Kind", &info, sizeof (info)))
		return false;

	if (res) {
		if(!IsOkWithoutText () || (subNames = FindIndex ("SubName")) == 0)
			return false;
		if (index->IsExist ("InfP"))
			return false;
		if (index->IsExist ("sUpd"))
			return false;
	} 

	return is_morpho_exist ();
}

Index* SearchBase::FindIndex (const char* name) {
	if (ContextPartsHelper::is_parts ()) {
		ContextPartsHelper::PartInfo res = ContextPartsHelper::get_info (name);

		long part = boost::get <0> (res);

		if (part != -1) {
			BasePool::iterator it = m_pool.find (part);

			if (it == m_pool.end ()) {
				GUARD (m_mutex);

#ifndef	MIN_MEM_CONTEXT
				it = m_pool.insert (part, new CachedBaseRO (boost::get <2> (res).c_str ())).first;
#else
				it = m_pool.insert (part, new YBase (boost::get <2> (res).c_str (), ACE_OS_O_RDONLY)).first;
#endif
			} 

			return it->second->Base::FindIndex (boost::get <1> (res).c_str ());
		}
	}

	return Base::FindIndex (name);
}

bool SearchBase::is_morpho_exist () {
	if (IsOk () && m_is_morpho_exist == false) {
		m_is_morpho_exist = (FindIndex ("NFContxt.str") != 0 && FindIndex ("NWCntxt.str") != 0);
	}
	return m_is_morpho_exist;
}

long SearchBase::get_hot_info_topic () {
	long result = 0;

	Stream *str = FindIndex ("Aux")->Open (AUX_HOTINFOTOPIC);
	if (str) {
		str->Read (&result, sizeof (result));
		FindIndex ("Aux")->Close (str);
	}

	return result;
}

//////////////////////////////////////////////////////////////////////////////////////////

struct SwordsHelper {
	typedef Core::Aptr <char, Core::ArrayDeleteDestructor <char> > Data;

	static char* get (Base* base, long id, long& sz) {
		return base->get_swords_data (ContextPartsHelper::get_swords_index_name (id), id, sz);
	}
};

long SearchBase::get_para_by_word (long doc_id, long word, bool need_para_id) {
	long ret = 0;

	GDS_ASSERT (doc_id > 0 && word >= 0);

	try {
		long word_pos = word & ContextSearch::POS_TEXT;

		if (word_pos >= ContextSearch::DOC_BEGIN_WORD) {
			long size = 0;

			SwordsHelper::Data buf = SwordsHelper::get (this, doc_id, size);

			long i = 0, count = (long) (size / 3), flag = word & ContextSearch::POS_FLAGS;

			for (const char* ptr = buf.in (); i < count; ++i, ptr += 3) {
				if (((*(long*) ptr) & 0xffffff) >= word_pos) {
					if (flag == ContextSearch::POS_INVISIBLE_BLOCK || flag == ContextSearch::POS_INVISIBLE) {
						ret = i;
					} else if (i > 0) {
						ret = i - 1;
					}
					break;
				} else if (count == i + 1) {
					ret = i;
				}
			}
		}

		GDS_ASSERT (ret >= 0);

		// если нужно, возвращаем id параграфа, а не его порядковый номер
		if (need_para_id) {
			long count;
			INDEX_DATA (long) data = IndexLoader (this).load <long> (doc_id, IDD2_PARAIDS, count, true);

			GDS_ASSERT (data.is_nil () == false);

			// [$217680096] - если id найденного параграфa ноль, то ищем не нулевой из следующих
			for (; ret < count && (data.ptr ()) [ret] == 0; ++ret);
			ret = ret < count ? (data.ptr ()) [ret] : 0;
		}
	} catch (...) {
		LOG_UEX ((GDS_CURRENT_FUNCTION));
	}

	return ret;
}

long SearchBase::find_paras_with_word (long doc_id, long word) {
	return get_para_by_word (doc_id, word, false);
}

void SearchBase::get_para_pair (long doc_id, long word, long& para, long& pos) {
	para = 0, pos = 0;

	long word_pos = word & ContextSearch::POS_TEXT;

	try {
		if (word_pos >= ContextSearch::DOC_BEGIN_WORD) {
			long size = 0;

			SwordsHelper::Data buf = SwordsHelper::get (this, doc_id, size);

			long i = 0, count = (long) (size / 3), flag = word & ContextSearch::POS_FLAGS;

			const char* ptr = buf.in ();

			for (; i < count; ++i, ptr += 3) {
				if (((*(long*) ptr) & 0xffffff) >= word_pos) {
					if (flag == ContextSearch::POS_INVISIBLE_BLOCK || flag == ContextSearch::POS_INVISIBLE) {
						para = i;
					} else if (i > 0) {
						para = i - 1;
					}
					break;
				} else if (count == i + 1) {
					para = i;
				}
			}

			ptr = buf.in ();
			pos = ((*(long*) (ptr + 3 * para)) & 0xFFFFFF) + 1;
			pos = std::max <long> (word_pos - pos, 0);
		}
	} catch (...) {
		LOG_UEX ((GDS_CURRENT_FUNCTION));
	}
}

// получить параграфы и слова в них (для подстветки в тексте)
WordsParas* SearchBase::get_paras_and_words (long id, const std::vector <unsigned long>& words) {
	Core::Aptr <WordsParas> ret = new WordsParas ();

	long size = 0;

	SwordsHelper::Data buf = SwordsHelper::get (this, id, size);

	if (size) {
		const char* ptr = buf.in ();

		long i = 0, count = (long) (size / 3), prev_word = *ptr & 0xffffff;

		for (std::vector <unsigned long>::const_iterator it = words.begin (); it != words.end (); ++it) {
			long cur = *it & ContextSearch::POS_TEXT;
			long flag = *it & ContextSearch::POS_FLAGS;

			for (; i < count; ++i, ptr += 3) {
				long item = (*(long*) ptr) & 0xffffff;

				if (item >= cur) {
					if (flag == ContextSearch::POS_INVISIBLE_BLOCK || flag == ContextSearch::POS_INVISIBLE) {
						ret->paras.push_back (i);
						ret->words.push_back (-1);
					} else if (i > 0) {
						ret->paras.push_back (i - 1);
						ret->words.push_back (cur - 1 - prev_word);
					}
					break;
				} else if (count == i + 1) {
					ret->paras.push_back (i);
					ret->words.push_back (cur - 1 - item);
					break;
				}

				prev_word = item;
			}
		}
	}

	return ret._retn ();
}

//////////////////////////////////////////////////////////////////////////////////////////

RefwReleCollection* SearchBase::context_search (
	int req_count
	, IndexReq** req
	, SortedCollection* col
	, short bInpharm
	, short removeEditions
) {
	bool b63Text = false;

	ContextSearch::Defs::Request item;
	ContextSearch::Defs::Requests requests;

	for (int i = 0; i < req_count; ++i) {
		if (stricmp (req [i]->Name, "Morpho")) {
			continue;
		}

		char* from = (char*) req [i] + sizeof (IndexReq);
		GDS_ASSERT (from);

		GCL::StrVector reqs;
		boost::split (reqs, from, boost::is_any_of (";"));

		item.btext = ((req [i]->SearchOp & SM_VALOPS) != SV_MTITLES);

		if ((req [i]->SearchOp & SM_VALOPS) == SV_MBODIES) {
			b63Text = true;
		}

		for (GCL::StrVector::const_iterator it = reqs.begin (); it != reqs.end (); ++it) {
			item.context = *it;
			GCL::to_upper (item.context);
			requests.push_back (item);
		}
	}

	GDS_ASSERT (requests.empty () == false);

	Core::Aptr <RefwReleCollection> ret;

	DBCore::IBase_var _base = DBCore::DBFactory::make (this);

	SearchAdapterLib::Adapter::ISearcher_var searcher = SearchAdapter::instance ()->get (_base.in (), CONTEXT_INDEX_NAME);
	SearchAdapterLib::Adapter::IDocuments_var res = searcher->get_documents (requests, ContextSearch::Defs::SearchInfo ());

	if (res.is_nil () == false) {
		ret = new RefwReleCollection ();

		RefwRele at;

		const ContextSearch::Defs::RelevancyDocuments& data = res->data ();

		ContextSearch::Defs::RelevancyDocuments::const_iterator it = data.begin (), it_end = data.end ();

		for (; it != it_end; ++it) {
			at.DocId = (long) it->doc_id;
			at.Rele	= (short) (it->info.relevancy_value & 0xFFFF);
			at.Word = (long) it->info.position;

			ret->Collection::Add (&at);
		}
	}

	if (ret.ptr () && ret->ItemCount) {
		if (col) {
			if (col->Tag () == OT_REFCOLLECTION || col->Tag () == OT_PARASCOLLECTION) {
				//из найденной по морфологии коллекции надо оставить только те элементы, которые были к этому времени найдены другими поисками
				if (b63Text) {
					//если искали в тексте, то надо перевести в DocCollection. Иначе - можно оставить вхождения
					DocCollection docs;
					long prevDocId = 0;
					for (int i = 0; i < col->PageCount; i++) {
						Ref* ptr = (Ref*) col->Pages [i];
						for (int j = 0; j < col->Count [i]; j++) {
							if (ptr [j].DocId != prevDocId) {
								prevDocId = ptr [j].DocId;
								docs.Collection::Add (&prevDocId);
							}
						}
					}
					ret->Intersect (docs);
				} else {
					//пересечь, оставляя из col вхождения, а из ret - релевантность
					RefwReleSubCollection* pNewList = col->Tag () == OT_REFCOLLECTION ? new RefwReleSubCollection () : new ParaswReleCollection ();
					long pos1 = 0, pos2 = 0;
					while (pos1 < ret->ItemCount && pos2 < col->ItemCount) {
						RefwRele* at1 = (RefwRele*) ret->GetItem (pos1);
						Ref* at2 = (Ref*) col->GetItem (pos2);
						if (at1->DocId == at2->DocId) {
							RefwRele add = {at1->DocId, at2->Sub, at1->Rele};
							if (!(at2->Sub & INHERITED_BLOCK))
								pNewList->Collection::Add (&add);
							pos2++;
							while (pos2 < col->ItemCount) {
								at2 = (Ref*) col->GetItem (pos2);
								if (at2->DocId == at1->DocId) {
									if (!(at2->Sub & INHERITED_BLOCK)) {
										add.Word = at2->Sub;
										pNewList->Collection::Add (&add);
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
					ret = col->Tag () == OT_REFCOLLECTION ? new RefwReleSubCollection () : new ParaswReleCollection ();
					ret->Move (*pNewList);
					delete pNewList;
				}
			} else if (col->Tag () == OT_RELECOLLECTION) {
				DocCollection docs;
				SearchHelper::convert (col, &docs);
				ret->Intersect (docs);
			} else if (col->Tag () == OT_DOCCOLLECTION) {
				ret->Intersect (*col);
			}
		} 

		if (bInpharm) {
			GDS_ASSERT (0);
		} else {
			if (removeEditions) {
				ret->Intersect (const_cast <DocCollection&> (AllDocsCache::instance ()->get_all_docs (this)));
			}
			DocCollection* allMDocs = AllMDocs ();
			if (allMDocs) {
				ret->Minus (*allMDocs);
				delete allMDocs;
			}
		}
	}

	return ret._retn ();
}

SearchResult* SearchBase::Search (
	int reqCount
	, IndexReq* req []
	, SortedCollection* init
	, short initOp
	, short bInpharm
	, short removeEditions
	, short removeWoAnnos
	, bool show_short_list
	, bool b_use_extended_search
) {
#ifdef _DEBUG
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);
#endif

	heap ();

	SortedCollection* pFindColl = 0;    // for storing all finded data
	IndexReq* initReq = 0;              // for init requst if needed
	IndexReq* smartminus_req = 0;

	// copy requsts list for sorting, we don't want modify params
	Core::Aptr <IndexReq*, BufDestructor> sortReq ((IndexReq**) ACE_OS::malloc (sizeof (IndexReq*) * (reqCount + 1)));

	ACE_OS::memcpy (sortReq.inout (), req, sizeof (IndexReq*) * reqCount);

	if (init) {
		// add init requst for requests list
		initReq = (IndexReq *) ACE_OS::malloc (sizeof (IndexReq));
		ACE_OS::strcpy (initReq->Name, "init request");
		initReq->ItemSize = 0;
		initReq->ItemCount = 0;
		initReq->SearchOp = SV_INIT | (initOp & SM_MRGOPS);

		sortReq.ptr () [reqCount++] = initReq;
	}

	// Sorting requests list
	// all requst's operations combined into form:
	//      ((or1 OR or2 OR...)AND and1 AND...)AND init ANDNOT minus1 ANDNOT... PHRASAL
	// for "or","intersect","minus" first come Refs, then Docs indices
	SortRequest (reqCount, sortReq.inout ());

	int i, phrasal_count = 0, iComplete = 0;

	for (i = 0; i < reqCount; ++i) {
		if (!stricmp (sortReq.ptr () [i]->Name, "Morpho")) {
			++phrasal_count;
		}
	}

	GDS_ASSERT (phrasal_count < 3);

	bool b_smartwork = (reqCount == 2 && !strcmp (sortReq.ptr ()[0]->Name, "Kind") && phrasal_count && !init);

	for (i = 0; i < reqCount; ++i) {
		if ((sortReq.ptr () [i]->SearchOp & SM_MRGOPS) == SO_SMARTMINUS) {
			smartminus_req = sortReq.ptr () [i];
			continue;
		}

		if (!stricmp (sortReq.ptr () [i]->Name, "Morpho") || b_smartwork) {
			continue;
		}

		SortedCollection* pList = 0;

		switch (sortReq.ptr () [i]->SearchOp & SM_VALOPS) {
		case SV_INIT :
			// Use init coll for perform selected init operation
			// If init exist we must return init col as result, therefore
			// point temp coll (pList) for stored coll (pFindColl)
			// intersect then point pFindColl for init coll.
			// After that makes all search operations as usual
			pList = pFindColl;
			pFindColl = init;
			break;

			default:
			{
			Index* ind = 0;
			if (strcmp (sortReq.ptr () [i]->Name, "CalAll")) {
				ind = FindIndex (sortReq.ptr () [i]->Name);
				if (ind == 0) continue;
				switch (GetDataType (ind)) {
					case SDT_DOCS:
						pList = new DocCollection;
						break;
					case SDT_REFS:
						pList = new RefCollection;
						break;
					case SDT_REFRELES:
						pList = new RefwReleCollection;
						break;
					case SDT_REFWEIGHTS:
						pList = new RefwWeightCollection;
						break;
					default:
						OkBox ("Collection Work Fault", "Unknown StreamDataType for Base::FindList method");
						continue;
				}
			} else {
				pList = new DocCollection;
			}

			sortReq.ptr () [i]->SearchOp |= OF_FIRSTTIME;

			switch (sortReq.ptr () [i]->SearchOp & SM_VALOPS) {
			case SV_LIST:
				FindList (*sortReq.ptr () [i], *pList, sortReq.ptr () [i]->SearchOp);
				break;
			case SV_RANGE:
				FindRange (ind, *sortReq. ptr () [i], *pList);
				break;
			case SV_LE:
				FindLE (ind, *sortReq. ptr () [i], *pList);
				break;
			case SV_GE:
				FindGE (ind, *sortReq.ptr () [i], *pList);
				break;          
			default :
				OkBox ("Base Search Fault", "Unknown value operation (%d)", sortReq. ptr () [i]->SearchOp & SM_VALOPS);
			}
			} 
			break;
		}

		switch (sortReq.ptr () [i]->SearchOp & SM_MRGOPS) {
		case SO_OR :
			if (!pFindColl) {
				// swap them, pFindColl become pList's type
				pFindColl = pList;
				pList = 0;
			} else { // OR them into pFindColl
				if (pFindColl == init) {
					if (init->Tag () == OT_DOCCOLLECTION) {
						pFindColl = new DocCollection;
					} else {
						pFindColl = new RefCollection;
					}
					pFindColl->Merge (*init);
				}
				pFindColl->Merge (*pList);
			}
			break;
		case SO_AND :
			if (!pFindColl) { 
				// swap them, pFindColl become pList's type
				pFindColl = pList;
				pList = 0;
			} else if (pList) { // AND them into pFindColl
				if (pList->Tag () == OT_REFCOLLECTION && pList->Tag () != pFindColl->Tag ()) {
					// while change operation type, pFindColl intersect pList
					// may be has different type, if pList is Refs - swap them

					if (pFindColl != init) {
						// do it only if pFindColl is not init collection
						SortedCollection* tmp = pList;
						pList = pFindColl;
						pFindColl = tmp;
					} else if (init->Tag () == OT_PARASCOLLECTION) {
						pFindColl = new ParasCollection ();
						pFindColl->Merge (*init);

						DocCollection *docs = new DocCollection ();
						docs->Merge (*pList);
						delete pList;
						pList = docs;
					}
				}

				if (pFindColl == init) {
					pFindColl = SearchHelper::make (init);
				}

				pFindColl->m_bCompType = COMP_PLUS;
				pFindColl->Intersect (*pList);
				pFindColl->m_bCompType = COMP_STD;

				if (!pFindColl->ItemCount) {
					phrasal_count = 0;
					i = reqCount;
				}
			}
			break;
		case SO_MINUS :
			if (!pFindColl)
				pFindColl = bInpharm ? inpharm_medtopics () : AllDocs ();

			// check whether we've already got empty list
			// we can't check it early becouse init operation may be OR
			// intersect we must return init collection if it exist, so we can break
			// only after SV_INIT processing
			// but actually... i'm so lazy to do it :)
			if (!pFindColl->ItemCount) {
				phrasal_count = 0;
				i = reqCount;
				break;
			}

			if (pFindColl == init) {
				if (init->Tag() == OT_DOCCOLLECTION)
					pFindColl = new DocCollection;
				else
					pFindColl = new RefCollection;
				pFindColl->Merge (*init);
			}

			pFindColl->m_bCompType = COMP_MINUS; // use zero Sub as '*'
			pFindColl->Minus (*pList);
			pFindColl->m_bCompType = COMP_STD;
			break;
		default :
			OkBox ( "Base Search Fault", "Unknown merging operation (%d)", sortReq. ptr () [i] -> SearchOp & SM_MRGOPS );
		}

		if (pList) delete pList;
	}

	/////////////////////////////////////////////////////////////////////////////////////
	// Контекстный поиск 

	try {
		if (phrasal_count) {
			Core::Aptr <RefwReleCollection> res = this->context_search (
				reqCount
				, sortReq.in ()
				, pFindColl
				, bInpharm
				, removeEditions
			);

			if (pFindColl != init) {
				delete pFindColl;
			}

			pFindColl = res._retn ();
		}
	} catch (SearchAdapterLib::CanceledByUser&) {
		iComplete = 1;
	} catch (...) {
		LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
	}

	if (pFindColl == 0 || (pFindColl == init && smartminus_req == 0)) {
		pFindColl = new RefwReleCollection ();
	}

	/////////////////////////////////////////////////////////////////////////////////////

	if (smartminus_req) {
		GDS_ASSERT (0);
	}

	if (initReq) free (initReq);

	heap ();

#ifdef BLOCKSINHERIT
	if (pFindColl && pFindColl->Tag () == OT_REFCOLLECTION) {
		((RefCollection*) pFindColl)->InheritPress ();
	}
#endif

	if (pFindColl && pFindColl->Tag () != OT_RELECOLLECTION) {
		if (bInpharm) {
			DocCollection* allMDocs = inpharm_medtopics ();
			if (allMDocs) {
				pFindColl->Intersect (*allMDocs);
				delete allMDocs;
			}
		} else {
			if (removeEditions) {
				pFindColl->Intersect (const_cast <DocCollection&> (AllDocsCache::instance ()->get_all_docs (this)));
			}

			if (removeWoAnnos) {
				Stream* str = FindIndex("Aux")->Open("WAno");
				if ( str ) {
					DocCollection withAnnos;
					withAnnos.Get(str);
					FindIndex("Aux")->Close(str);
					pFindColl->Intersect( withAnnos );
					if ( pFindColl->Tag() == OT_REFCOLLECTION && pFindColl->ItemCount ) {
						DocCollection onlyDocs;
						long prevId = 0;
						for ( long l = 0; l < pFindColl->ItemCount; l++ ) {
							Ref aRef = *(Ref*)(*pFindColl)[ l ];
							if ( aRef.DocId != prevId ) {
								prevId = aRef.DocId;
								onlyDocs.Collection::Add( &prevId );
							}
						}
						delete pFindColl;
						pFindColl = new DocCollection();
						pFindColl->Move( onlyDocs );
					}
				}
			}
		}
	}

	bool b_list_is_cut = false;
	long fulllist_itemcount = (pFindColl ? pFindColl->ItemCount : 0);
	long short_list_size = BaseCache::instance ()->get_short_list_size (this);

	if (show_short_list && pFindColl && pFindColl->Tag () == OT_RELECOLLECTION) {
		GDS_ASSERT (0);
	}

	SearchResult* result = new SearchResult;
	result->list = pFindColl;
	result->list_is_cut = b_list_is_cut;
	result->fulllist_itemcount = fulllist_itemcount;
	result->search_interrupted = iComplete != 0;
	return result;
}

long SearchBase :: find_block_with_uniquepara (long doc_id, long para)
{
	long count, new_para = 0;
	INDEX_DATA (long) data = IndexLoader (this).load <long> (doc_id, IDD2_PARAIDS, count, true);
	GDS_ASSERT (data.is_nil () == false);

	for (long i = 0; i < count; i++)
		if ((data.ptr ()) [i] == para) {
			new_para = i;
			break;
		}

	return find_block_with_para (doc_id, new_para);
}

long SearchBase :: find_block_with_para (long doc_id, long para)
{
	IndexLoader loader (this);
	long structs_count, i = 0, best_sub = 0;
	INDEX_DATA (DocStruct) structs = loader.load <DocStruct> (doc_id, IDD_DOCSTRUCT, structs_count);
	DocStruct *ptr;
	for (ptr = structs.ptr (), i = 0; i < structs_count; i++, ptr++) {
		short evd_type = (short) ((ptr->m_para_list_type >> 24) & 0xFF);
		if ((evd_type == SUBDESCEX_BLOCK) && (para >= (long)ptr->m_start_para) && (para <= (long)ptr->m_end_para))
			best_sub = ptr->m_para_list_id;
	}
	return best_sub;
}

long SearchBase :: find_block_with_word (long doc_id, long word) {
	return find_block_with_para (doc_id, find_paras_with_word (doc_id, word));
}

int SearchBase::FindList (IndexReq& req, SortedCollection& list, short searchOp)
{
	char gk_huge* ptr = sizeof (IndexReq) + (char*) &req;
	bool b_check_minus = !strcmp (req.Name, "Class") || !strcmp (req.Name, "Type") || !strcmp (req.Name, "Kind") || !strcmp (req.Name, "Adopted") || !strcmp (req.Name, "Territory"), bContext = !strcmp( req.Name, "Context" );
	Index* ind = FindIndex( req.Name );
	long level0_keys = 0;
	for ( int j = 0; j < req.ItemCount; j++ ) {
#if TOTAL_HEAPCHECK == 1
		heap();
#endif
		if (bContext) {
			for (int i = 0; ptr [i]; i++)
				if (ptr [i] == 'Ё')
					ptr [i] = 'Е';
		}

		if ( req.ItemSize == 0 && strchr ( ptr, '*' ) != 0 ) {
			if (!AddKeyPatternList (req, ptr, list))
				break;
		} else {
			if (!AddKeyList (ind, req, ptr, list)) {
				/*
				bool b_break = true;
				if (!strcmp (ind->Name, "Number")) {					
					char *mod_req = new char [sizeof (IndexReq) + ind->KeyLength], *mod_ptr = mod_req + sizeof (IndexReq);
					IndexReq *mod_indexreq = (IndexReq*)mod_req;
					memcpy (mod_req, (char*) &req, sizeof (IndexReq) + ind->KeyLength);
					strcpy (mod_ptr, ptr);
					if (strlen (mod_ptr) > 3 &&
						(mod_ptr [0] == 'А' && atol (mod_ptr + 1) > 0 && atol (mod_ptr + 1) < 83) || 
						(mod_ptr [0] == 'Ф' && atol (mod_ptr + 1) > 0 && atol (mod_ptr + 1) < 11) ||
						(mod_ptr [2] == 'А' && mod_ptr [3] == 'П' && (((mod_ptr [0] == '0' || mod_ptr [0] == '1') && mod_ptr [1] >= '0' && mod_ptr [1] <= '9') || (mod_ptr [0] == '2' && mod_ptr [1] == '0'))) ||
						(mod_ptr [0] == 'В' && mod_ptr [1] == 'А' && mod_ptr [2] == 'С')
						) {
						char* slash_pos = strchr (mod_ptr, '/');
						if (slash_pos) {
							slash_pos++;
							char* minus_pos = strchr (slash_pos, '-');
							if (minus_pos) {
								*minus_pos = '\0';
								if (AddKeyList (ind, *mod_indexreq, mod_ptr, list))
									b_break = false;
								else if (atol (slash_pos)) {
									bool b_add = true;
									if (strlen (slash_pos) == 4) {
										strcpy (slash_pos, slash_pos + 2);
									} else if (strlen (slash_pos) == 2) {
										slash_pos [2] = slash_pos [0];
										slash_pos [3] = slash_pos [1];
										slash_pos [4] = 0;
										slash_pos [0] = '2';
										slash_pos [1] = '0';
									} else {
										b_add = false;
									}			
									if (b_add && AddKeyList (ind, *mod_indexreq, mod_ptr, list))
										b_break = false;
								}
							}
						}
					}
					delete []mod_req;
				}
				if (b_break)
					break;
				*/
				break;
			}
			if (b_check_minus) {
				HIndex::HIndexKey* key = (HIndex::HIndexKey*) ptr;
				if (key->level == 0)
					level0_keys++;
			}
		}

		ptr  += req.ItemSize > 0 ? req.ItemSize : strlen ( ptr ) + 1;
		if ( ( req.SearchOp & SO_AND ) && list.ItemCount < 1 )
			break;
	}

	if (b_check_minus && ((searchOp & SM_MRGOPS) == SO_MINUS)) {
		long count0_keys = 0;
		for (BTIterator it (ind); !it.End (); ++it) {
			HIndex::HIndexKey* key = (HIndex::HIndexKey*) it.Key ();
			if (key->level)
				break;
			count0_keys++;
		}
		if (count0_keys == level0_keys) {
			list.FreeAll ();
			list.Merge (const_cast <DocCollection&> (AllDocsCache::instance ()->get_all_docs (this)));
		}
	}

#if TOTAL_HEAPCHECK == 1
	heap();
#endif
	return 1;
}

int SearchBase::FindRange (Index* ind, IndexReq& req, SortedCollection& list)
{
	char* From = sizeof (IndexReq ) + (char*) &req;
	char* To   = From + (req.ItemSize > 0 ? req.ItemSize : strlen (From) + 1);

	if (!strcmp (req.Name, "CalAll")) {
		char* names [] = {"CalIn", "CalAb", "CalCh"};
		for (int i = 0; i < 3; i++) {
			ind = FindIndex (names [i]);
			for (BTIterator it (ind, From); !it.End () && it <= To; ++it)
				AddKeyList (ind, req, it.Key (), list);
		}
	} else {
		for (BTIterator it (ind, From); !it.End () && it <= To; ++it)
			if (!AddKeyList (ind, req, it.Key (), list))
				break;
			else
			if ((req.SearchOp & SO_AND) && list.ItemCount < 1)
				break;
	#if TOTAL_HEAPCHECK == 1
		heap ();
	#endif
	}
	return 1;
}

int SearchBase::FindLE (Index* ind, IndexReq& req, SortedCollection& list)
{
	char* To = sizeof (IndexReq) + (char*) &req;

	if (!strcmp (req.Name, "CalAll")) {
		char* names [] = {"CalIn", "CalAb", "CalCh"};
		for (int i = 0; i < 3; i++) {
			ind = FindIndex (names [i]);
			for (BTIterator it (ind); !it.End () && it <= To; ++it)
				AddKeyList (ind, req, it.Key (), list);
		}
	} else {
		for (BTIterator it (ind); !it.End () && it <= To; ++it)
			if (!AddKeyList (ind, req, it.Key (), list))
				break;
			else
			if ((req.SearchOp & SO_AND) && list.ItemCount < 1)
				break;
	#if TOTAL_HEAPCHECK == 1
		heap ();
	#endif
	}
	return 1;
}

int SearchBase::FindGE (Index* ind, IndexReq& req, SortedCollection& list)
{
	char* From = sizeof (IndexReq) + (char*) &req;

	if (!strcmp (req.Name, "CalAll")) {
		char* names [] = {"CalIn", "CalAb", "CalCh"};
		for (int i = 0; i < 3; i++) {
			ind = FindIndex (names [i]);
			for (BTIterator it (ind, From); !it.End (); ++it)
				AddKeyList (ind, req, it.Key (), list);
		}
	} else {
		for (BTIterator it (ind, From); !it.End (); ++it)
			if (!AddKeyList (ind, req, it.Key (), list))
				break;
			else
			if ((req.SearchOp & SO_AND) && list.ItemCount < 1)
				break;
	#if TOTAL_HEAPCHECK == 1
		heap ();
	#endif
	}
	return 1;
}

int SearchBase::AddKeyPatternList (IndexReq& req, char* ptn, SortedCollection& list)
{
	if ( list.Tag () == OT_REFCOLLECTION ) {
		OkBox ( "Collection Work Fault", "Not yet implemented for RefCollection" );
		return 0;
	}
	if ( list.Tag () != OT_DOCCOLLECTION ) {
		OkBox ( "Error", "Unknown data type" );
		return 0;
	}
#if TOTAL_HEAPCHECK == 1
	heap();
#endif
	char          buf1 [64];
	char          buf2 [64];
	int       saveOp = req.SearchOp;
	DocCollection col;
	int       res = 1;

	req.SearchOp = OF_FIRSTTIME | SO_OR;
	* strchr ( strcpy ( buf1, ptn ), '*' ) = '\0';
	strcpy ( strchr ( WinStrUpr( strcpy ( buf2, ptn )), '*' ), "\xFF" );
	WinStrUpr( buf1 );

	Index* ind = FindIndex ( req.Name );
	
	for ( BTIterator it ( ind, buf1 ); !it.End() && it <= buf2; ++it ) {
		if ( !AddKeyListEx ( ind, req, ind->recordData(it.Key(),0), col ) )
			break;
	}
#if TOTAL_HEAPCHECK == 1
	heap();
#endif
	req.SearchOp = saveOp & ~OF_FIRSTTIME;
	if ( saveOp & OF_FIRSTTIME )
		list.Move ( col );
	else
	if ( saveOp & SO_KEYS_AND )
		list.Intersect ( col );
	else
		res = list.Merge ( col );
#if TOTAL_HEAPCHECK == 1
	heap();
#endif
	return res;
}

//
// adds list of documents corresponding to a given key to list, merging it with spec. operation
// if a list of refs is associated with a key it will be converted to list of docs
//

int SearchBase :: AddKeyList ( Index *ind, IndexReq& req, BTKEY key, SortedCollection& list)
{
#if TOTAL_HEAPCHECK == 1
		heap();
#endif
	Stream *str = 0;
	if ( req.ItemSize == ind->KeyLength ) {
#if TOTAL_HEAPCHECK == 1
		heap();
#endif
		str = ind -> Index::OpenN ( key, 0 );
#if TOTAL_HEAPCHECK == 1
		heap();
#endif
	} else {
#if TOTAL_HEAPCHECK == 1
		heap();
#endif
		str = ind -> Open ( key );
#if TOTAL_HEAPCHECK == 1
		heap();
#endif
	}
#if TOTAL_HEAPCHECK == 1
		heap();
#endif
	int res=1;
	if(str){
		res= AddKeyListEx(ind, req, str->GetRec(), list);
		ind -> Close ( str );
	}else
		return AddKeyListEx(ind, req, 0, list);
	return res;
}

int SearchBase :: AddKeyListEx ( Index * ind, IndexReq& req, IndexRecordData *pTmp, SortedCollection& list)
{
	SortedCollection * col;
#if TOTAL_HEAPCHECK == 1
	heap();
#endif
	long dtype = GetDataType ( ind );
	if (dtype == SDT_DOCS) col = new DocCollection ();
	else if (dtype == SDT_REFS) col = new RefCollection ();
	else if (dtype == SDT_REFWEIGHTS) col = new RefwWeightCollection ();
	else {
		OkBox ( "Collection Work Fault", "Unknown collection type" );
		return 0;
		}
	if ( !col ) {
		MemoryError  ();
		return 0;
	}
	if ( col->Tag() != list.Tag() ) {
		OkBox ( "Error", "Operation with different collection's type, not yet supported" );
		delete col;
		return 0;
	}
#if TOTAL_HEAPCHECK == 1
	heap();
#endif
	int res=1;
	Stream * str = 0;
	if(pTmp){
#if TOTAL_HEAPCHECK == 1
		heap();
#endif
		str = new Stream(ind->streams, pTmp, ind->ImmDataSize, ind->roundv, 0);
#if TOTAL_HEAPCHECK == 1
		heap();
#endif
	}
	if ( str ) {
		res = col -> Get ( str );
		ind -> Close ( str );
	}
#if TOTAL_HEAPCHECK == 1
	heap();
#endif
	if ( res ) {
		if ( req.SearchOp & OF_FIRSTTIME ) {
			list.Move ( * col );
		}
		else if ( req.SearchOp & SO_KEYS_AND ) {
			list.m_bCompType = COMP_PLUS; // use zero Sub as '*'
			list.Intersect ( * col );                           
			list.m_bCompType = COMP_STD;
		} else {
			res = list.Merge ( * col );
		}
	}
#if TOTAL_HEAPCHECK == 1
	heap();
#endif
	delete col;
#if TOTAL_HEAPCHECK == 1
	heap();
#endif
	req.SearchOp &= ~OF_FIRSTTIME;
	return res;
}

RefwReleCollection*	SearchBase::found_samedocs (long docid)
{
	RefwReleCollection* result = new RefwReleCollection ();
	IndexLoader loader (this);
	long same_docs_size;
	INDEX_DATA (DocRele) same_docs = loader.load <DocRele> (docid, IDD_SAMEDOCS, same_docs_size, true);
	if (same_docs.ptr ()) {
		DocRele *same_docs_ptr = same_docs.ptr ();
		for (int i = 0; i < same_docs_size; i++, same_docs_ptr++) {
			RefwRele to_insert = {same_docs_ptr->DocId, ContextSearch::DOC_BEGIN_WORD+1, same_docs_ptr->Rele};
			result->Insert (&to_insert);
		}
	}

	return result;
}

const char* mm_delimiters = "-_/.,";
const char* mmex_delimiters = "<,~`;:[{}]'>./\\";

bool str_contains_digits (const char* in)
{
	char* ptr = (char*) in;
	if (*ptr == ' ') ptr++;
	while (*ptr && *ptr != ' ') {
		if (*ptr >= '0' && *ptr <= '9')
			return true;
		ptr++;
	}
	return false;
}

bool SearchBase::word_check_mistake (const char* word, std::string& corrected_word) {
	if (/*(!check_short_words && strlen (word) < 4) ||*/ strchr (word, '!') || strchr (word, '*') || str_contains_digits (word)) {
		corrected_word = word;
		return true;
	}

	BaseCache* cache = BaseCache::instance ();

	const TypingErrors& typing_errors = cache->get_typing_errors (this);

	StrStrMap::const_iterator map_it = typing_errors.find (word);

	if (map_it != typing_errors.end ()) {
		corrected_word = map_it->second;
		return true;
	}

	const GCL::StrSet& good_words = cache->get_good_words (this);

	if (good_words.find (word) != good_words.end ()) {
		corrected_word = word;
		return true;
	}

	Morpho::Def::INormalizer_var normalizer = Morpho::Factory::make (Morpho::get_cache (this));

	bool b_normal_word = true;

	ContextPattern ptn;
	BuildPatternM (ptn, (char*) word);

	for (int words = 0; words < ptn.WordCount; ++words) {
		Core::Aptr <GCL::StrSet> res = normalizer->execute (std::string (ptn.Word [words]), true);

		for (GCL::StrSet::const_iterator it = res->begin (); it != res->end (); ++it) {
			if (it->at (0) & 0x80) {
				b_normal_word = false;
			}
		}
	}

	if (b_normal_word) {
		corrected_word = word;
		return true;
	}

	return false;
}

void SearchBase::load_typing_errors () {
	const TypingErrors& typing_errors = BaseCache::instance ()->get_typing_errors (this);
	const GCL::StrSet& good_words = BaseCache::instance ()->get_good_words (this);

	typing_errors_ptr = const_cast <TypingErrors*> (&typing_errors);
	good_words_ptr = const_cast <GCL::StrSet*> (&good_words);
}

void BuildPatternMM_mistakes (ContextPattern& ptn, char * str, bool upper = true)
{
	ptn.WordCount = 0;
	int i = 0;
	bool b_minus = true, b_digits = false, b_lastblank = true;
	for (unsigned char *s = (unsigned char*) str; *s != '\0' && ptn.WordCount < 255 && i < 1000; s++)
		if (IS_CTX_CHAR_NORMLS_62( *s ) || strchr ("№!*<,`;:[{}]'>.()/\\", *s)) {
			if (b_lastblank)
				ptn.Word [ptn.WordCount++] = &ptn.buf[ i ];

			ptn.buf[i] = *s;
			if ( ptn.buf[i] == 'Ё' )
				ptn.buf[i] = 'Е';
			i++;
			b_lastblank = false;
		} else {
			ptn.buf [i++] = '\0';
			b_digits = false;
			b_lastblank = true;
		}

	ptn.buf [i] = '\0';
	ptn.Word [ptn.WordCount] = &ptn.buf [i++];
	for ( i = 0; i < ptn.WordCount; i++ ) {
		if (upper) WinStrUpr( ptn.Word[ i ] );
		char *ptr = ptn.Word [i], *begin = ptr;
		while (*ptr && ptr - begin < 30) ptr++;
		*ptr = '\0';
	}
}

void SearchBase::correct_single_word (const char* in, std::string& result, bool& b_wastransliteration, bool& b_onlylatin)
{
	b_onlylatin = false;
	result.clear ();
	char* up_in = WinStrUpr (strdup (in));
	std::string corrected_word;

	unsigned char atl0 = *in, at0 = *up_in;
	bool b_uppercase = false;
	if ((atl0 == at0) && ((at0 > 64 && at0 < 91) || (at0 > 191 && at0 < 224)))
		b_uppercase = true;
	
	if (word_check_mistake (up_in, corrected_word)) {
		result = corrected_word;
		gk_free (up_in);
		return ;
	}

	if (b_uppercase) {
		result = in;
		gk_free (up_in);
		return ;
	}

	//перестановки
	if (strlen (in) > 5 && (strcspn (in, mmex_delimiters) == strlen (in))) {
		size_t chars;
		bool b_found = false;
		for (chars = 0; chars < strlen (up_in) - 1;) {
			char saved_char = up_in [chars];
			up_in [chars] = up_in [chars+1];
			up_in [++chars] = saved_char;
			b_found = word_check_mistake (up_in, corrected_word);
			up_in [chars] = up_in [chars-1];
			up_in [chars-1] = saved_char;
			if (b_found) {
				result = corrected_word;
				gk_free (up_in);
				return;
			}
		}
	}

	bool only_latin = true;
	char* ptr = up_in;
	while (*ptr && only_latin) {
		char from[] = "F<,DULT`;:PBQRKVYJGHCNEA[{WXIOMS}]'>.Z";
		char to[]   = "АББВГДЕЁЖЖЗИЙКЛМНОПРСТУФХХЦЧШЩЬЫЪЪЭЮЮЯ";
		char* at = strchr (from, *ptr);
		if (at)
			*ptr = to [at - from];
		else {
			WinStrUpr (strcpy (up_in, in));
			only_latin = false;
		}
		ptr++;
	}

	if (only_latin && !b_wastransliteration && strlen (in) < 4) {
		b_onlylatin = true;
		result = in;
		gk_free (up_in);
		return;
	}
	if (only_latin && (strlen (up_in) > 2 || b_wastransliteration) && word_check_mistake (up_in, corrected_word)) {
		b_wastransliteration = true;
		result = corrected_word;
		gk_free (up_in);
		return;
	}

	if (only_latin) {
		b_onlylatin = true;
		result = in;
	} else if (strcspn (up_in, mmex_delimiters) == strlen (up_in) && strcspn (up_in, "()@#$%^&") == strlen (up_in)) {
		const MorphoHashes& morpho_hashes = BaseCache::instance ()->get_morpho_hashes (this);

		GCL::StrVector leve_corrects;
		unsigned long my_hash = hash_str (up_in);
		std::map <unsigned long, GCL::StrVector>::const_iterator it;
		for (it = morpho_hashes.begin (); it != morpho_hashes.end (); it++) {
			unsigned long hash = it->first, nonmismatch_bits = 0, mask = 1;
			for (int i = 0; i < 32 && nonmismatch_bits < 3; i++, mask <<= 1)
				if ((my_hash & mask) != (hash & mask))
					nonmismatch_bits++;
			if (nonmismatch_bits < 3)
				for (GCL::StrVector::const_iterator str_it = it->second.begin (); str_it != it->second.end (); str_it++)
					if (leve_dist (up_in, (char*) str_it->c_str ()) < 2)
						leve_corrects.push_back (*str_it);
		}
		if (leve_corrects.size () == 1) {
			result = leve_corrects.at (0);
		} else {
			GCL::StrSet norms;

			Morpho::Def::INormalizer_var normalizer = Morpho::Factory::make (Morpho::get_cache (this));

			for (GCL::StrVector::const_iterator it = leve_corrects.begin (); it != leve_corrects.end (); it++) {
				Core::Aptr <GCL::StrSet> res = normalizer->execute (*it, true);
				for (GCL::StrSet::const_iterator _it = res->begin (); _it != res->end (); ++_it)
					norms.insert (_it->c_str () + 1);
			}

			if (norms.size () == 1)
				result = *norms.begin ();
		}
	}

	gk_free (up_in);
	return ;
}

void SearchBase::check_mistakes (const char* in, StrStrMap& corrects) {
	corrects.clear ();

	ContextPattern pattern_m;
	BuildPatternMM_mistakes (pattern_m, (char*) in, false);

	if (!pattern_m.WordCount) {
		corrects.insert (StrStrMap::value_type (in, in));
		return ;
	}

	bool b_wastransliteration = false;
	GCL::StrSet latins, bads;
	for (int i = 0; i < pattern_m.WordCount; i++) {
		//берем длинное слово, и нарезаем его на короткие
		ContextPattern small_pattern;
		BuildPatternM (small_pattern, pattern_m.Word [i], false);

		//теперь надо исходное слово попытаться исправить, и все нарезанные
		std::string word;
		std::vector<std::string> words;
		bool b_onlylatin = false;
		correct_single_word (pattern_m.Word [i], word, b_wastransliteration, b_onlylatin);
		for (int j = 0; j < small_pattern.WordCount; j++) {
			std::string small_word;
			bool b_smallonlylatin = false;
			correct_single_word (small_pattern.Word [j], small_word, b_wastransliteration, b_smallonlylatin);
			if (small_word.size ()) words.push_back (small_word);
		}

		if (word.size ()) {
			//длинное слово нормальное
			corrects.insert (StrStrMap::value_type (pattern_m.Word [i], word));
			if (b_onlylatin) latins.insert (pattern_m.Word [i]);
		} else if (words.size () == small_pattern.WordCount) {
			//все короткие нормальные
			word.clear ();
			BuildPatternM (small_pattern, pattern_m.Word [i]);
			char* up_word = WinStrUpr (strdup (pattern_m.Word [i])), *ptr = up_word;
			for (int j = 0; j < small_pattern.WordCount; j++) {
				if (strstr (ptr, small_pattern.Word [j])) {
					while (strstr (ptr, small_pattern.Word [j]) != ptr) {
						word += *ptr;
						ptr++;
					}
				}
				word += words.at (j).c_str ();
				ptr += strlen (small_pattern.Word [j]);
				if (j < small_pattern.WordCount - 1) {
					while (strstr (ptr, small_pattern.Word [j + 1]) != ptr) {
						word += *ptr;
						ptr++;
					}
				} else while (*ptr) {
					word += *ptr;
					ptr++;
				}
			}
			gk_free (up_word);
			corrects.insert (StrStrMap::value_type (pattern_m.Word [i], word));
		} else {
			bads.insert (pattern_m.Word [i]);
		}
	}
	if (latins.size () && b_wastransliteration) {
		for (GCL::StrSet::const_iterator it = latins.begin (); it != latins.end (); it++) {
			std::string word;
			bool b_onlylatin = false;
			correct_single_word (it->c_str (), word, b_wastransliteration, b_onlylatin);
			if (word.size ()) {
				corrects.find (it->c_str ())->second = word;
				GCL::StrSet::iterator bad_it = bads.find (*it);
				if (bad_it != bads.end ())
					bads.erase (bad_it);
			}
		}
	}

	//еще в bads могут быть короткие слова
	for (GCL::StrSet::const_iterator it = bads.begin (); it != bads.end (); it++) {
		if (it->size () < 4)
			corrects.insert (StrStrMap::value_type (*it, *it));
	}

	return ;
}

void	SearchBase::correct_mistakes (const GCL::StrVector &in, GCL::StrVector& out, GCL::StrVector& cant, bool b_inpharm)
{
	GCL::StrVector::const_iterator it;
	std::string str_in, str_out;
	for (it= in.begin (); it != in.end (); it++) {
		if (str_in.size ())
			str_in += '|';
		for (std::string::const_iterator char_it = it->begin (); char_it != it->end (); ++char_it)
			if (*char_it != '|')
				str_in += *char_it;
	}
	correct_mistakes (str_in.c_str (), str_out, cant, b_inpharm, '|');
	while (str_out.size ()) {
		size_t dot_pos = str_out.find_first_of ('|');
		if (dot_pos == std::string::npos) {
			out.push_back (str_out);
			str_out = "";
		} else {
			std::string small_in;
			small_in.assign (str_out.c_str (), 0, dot_pos);
			out.push_back (small_in);
			str_out.erase (0, dot_pos+1);
		}
	}
	while (out.size () < in.size ())
		out.push_back ("");
}

bool SearchBase::is_present (const GCL::StrSet& keys) {
	bool ret = false;

	GCL::StrVector names;
	ContextPartsHelper::get_context_parts_names (names, false);

	GCL::StrSet::const_iterator it, it_end = keys.end ();

	for (GCL::StrVector::const_iterator _it = names.begin (); _it != names.end () && ret == false; ++_it) {
		Index* index = this->FindIndex (_it->c_str ());

		if (index->KeyCount > 0) {
			for (it = keys.begin (); it != it_end && ret == false; ++it) {
				ret = index->IsExist (it->c_str ());
			}
		}
	}

	return ret;
}

bool SearchBase::is_present (const std::string& word, bool is_wild) {
	bool ret = false;

	GCL::StrVector names;
	ContextPartsHelper::get_form_parts_names (names, false);

	for (GCL::StrVector::const_iterator _it = names.begin (); _it != names.end () && ret == false; ++_it) {
		Index* index = this->FindIndex (_it->c_str ());

		if (index->KeyCount > 0) {
			std::string key = (*_it != SIDE_INDEX_NAME)? word : (std::string (1, 0xc0 + word.size ()) + word);

			if (is_wild) {
				BTIterator it (index);
				it.Set (key.c_str ());

				if (!it.End ()) {
					ret = (ACE_OS::memcmp (it.Key (), key.c_str (), key.size ()) == 0);
				}

			} else {
				ret = index->IsExist (key.c_str ());
			}
		}
	}

	return ret;
}

void SearchBase::get_incorrect (const std::string& str, GCL::StrSet& words) {
	GDS_ASSERT (str.empty () == false);

	char ch = *(str.rbegin ());

	if (ch == '*' || ch == '!') {
		std::string clear_word = str.substr (0, str.size () - 1);
		if (this->is_present (clear_word, ch == '*') == false) {
			words.insert (clear_word);
		}
	} else {
		Morpho::Def::INormalizer_var normalizer = Morpho::Factory::make (Morpho::get_cache (this));

		Core::Aptr <GCL::StrSet> lemms = normalizer->execute (str, true);
		if (this->is_present (*lemms) == false) {
			words.insert (str);
		}
	}
}

GCL::StrSet* SearchBase::get_incorrect_words (const char* req) {
	{
		GCL::StrVector parts;
		boost::split (parts, req, boost::is_any_of (" -"), boost::token_compress_on);

		GCL::StrSet words;

		for (GCL::StrVector::iterator it = parts.begin (); it != parts.end (); ++it) {
			std::string val = boost::trim_copy_if (*it, boost::is_punct ());

			if (val.empty () == false) {
				if (*(it->rbegin ()) == '*' || *(it->rbegin ()) == '!') {
					GCL::to_upper (*it);
				} else {
					boost::trim_right_if (*it, boost::is_punct ());
				}
				this->get_incorrect (*it, words);
			}
		}

		if (words.empty ()) {
			return 0;
		}
	}

	DBCore::IBase_var _base = DBCore::DBFactory::make (this);

	SearchAdapterLib::Adapter::IHelper_var helper = SearchAdapter::instance ()->get (_base.in ());
	SearchAdapterLib::Adapter::ISynRequest_var res = helper->synonymy (req);

	if (res.is_nil ()) {
		return 0;
	}

	Core::Aptr <GCL::StrSet> ret = new GCL::StrSet ();

	size_t count = res->size ();

	for (size_t i = 0; i < count; ++i) {
		GCL::StrSet words;

		std::for_each (res->data (i).begin (), res->data (i).end ()
			, boost::bind (&SearchBase::get_incorrect, this, _1, boost::ref (words))
		);

		if (words.empty ()) {
			break;
		} else {
			ret->insert (words.begin (), words.end ());
		}
	}

	return ret._retn ();
}

void SearchBase::correct_mistakes (const char *in, std::string &out, GCL::StrVector& cant_correct, bool b_inpharm, char delimiter)
{
	char *corrected_in = strdup (in), *minus_minus_pos = (char*) strstr (in, "--");
	if (minus_minus_pos) corrected_in [minus_minus_pos - in] = '\0';
	convert_brackets (corrected_in);

	out.clear ();
	cant_correct.clear ();
	GCL::StrSet incorrect_words, was;

	if (!b_inpharm) {
		check_base_for_language ();
		if (language_tag == 1)
			b_inpharm = true;
	}

	if (b_inpharm) {
		out = corrected_in;

		Core::Aptr <GCL::StrSet> res = this->get_incorrect_words (corrected_in);

		if (res.is_nil () == false) {
			for (GCL::StrSet::const_iterator word_it = res->begin (); word_it != res->end (); word_it++) {
				if (!std::binary_search (was.begin (), was.end (), *word_it))
					cant_correct.push_back (*word_it);
			}
		}
	} else {
		std::string local_in = corrected_in;
		long counter = 0;
		while (local_in.size ()) {
			std::string local_out, small_in;
			size_t dot_pos = local_in.find_first_of (delimiter);
			if (dot_pos == std::string::npos) {
				small_in = local_in;
				local_in = "";
			} else {
				small_in.assign (local_in.c_str (), 0, dot_pos);
				local_in.erase (0, dot_pos+1);
			}

			std::string converted_small_in;
			for (size_t i = 0; i < small_in.length (); ++i) {
				char at_i = small_in.at (i);
				if (at_i == 'Ё')
					at_i = 'Е';
				converted_small_in += at_i;
			}
			small_in = converted_small_in;

			bool valid_quote = false, was_quote = false;
			{
				char* converted_str = convert_quotes (small_in.c_str (), valid_quote, was_quote, false);
				gk_free (converted_str);
			}

			if (valid_quote && was_quote) {
				local_out.assign (small_in, 1, small_in.size () - 2);
			} else {
				StrStrMap corrects;

				ContextPattern pattern, low_pattern, pattern_m;
				BuildPatternMM_mistakes (pattern, (char*) small_in.c_str (), true);

				const TypingErrors& typing_errors = BaseCache::instance ()->get_typing_errors (this);

				std::map<long,std::string> TypE_corrects;
				std::map<long,long> TypE_lens;
				std::set<long> TypE_words;
				for (int words = pattern.WordCount; words > 1; words--) {
					for (int from_word = 0; from_word < pattern.WordCount + 1 - words; from_word++) {
						std::string phrase_to_check;
						long ok_words = 0;
						for (int i = 0; i < words; i++) {
							if (TypE_words.find (i + from_word) == TypE_words.end ())
								ok_words++;
							if (phrase_to_check.size ())
								phrase_to_check += " ";
							phrase_to_check += pattern.Word [i + from_word];
						}
						if (ok_words != words)
							continue; //какие-то слова из набираемой фразы были исправлены ранее, в более длинной фразе

						StrStrMap::const_iterator map_it = typing_errors.find (phrase_to_check);
						if (map_it != typing_errors.end ()) {
							for (int i = 0; i < words; i++)
								TypE_words.insert (i + from_word);
							TypE_corrects.insert (std::map<long,std::string>::value_type (from_word, map_it->second));
							TypE_lens.insert (std::map<long,long>::value_type (from_word, words));
						}
					}
				}
				if (TypE_corrects.size ()) {
					small_in.clear ();
					for (int i = 0; i < pattern.WordCount; ) {
						if (small_in.size ())
							small_in += " ";
						if (TypE_words.find (i) == TypE_words.end ()) {
							small_in += pattern.Word [i];
							i++;
						} else {
							if (TypE_corrects.find (i) != TypE_corrects.end () && TypE_lens.find (i) != TypE_lens.end ()) {
								small_in += TypE_corrects.find (i)->second;
								i += TypE_lens.find (i)->second;
							} else {
								small_in += pattern.Word [i];
								i++;
							}
						}
					}
				}

				//в check_mistakes проверка пословная, соответственно потом фразу нарезаем на слова, и каждое меняем на пару из corrects
				check_mistakes (small_in.c_str (), corrects);

				BuildPatternMM_mistakes (pattern, (char*) small_in.c_str (), true);
				if (!pattern.WordCount) {
					if (counter || out.size ())
						out += delimiter;
					counter++;
					continue;
				}

				BuildPatternMM_mistakes (pattern_m, (char*) small_in.c_str (), true);
				BuildPatternMM_mistakes (low_pattern, (char*) small_in.c_str (), false);

				const char* ptr = small_in.c_str ();
				unsigned char org_char, dest_char = 0;
				for (int i = 0; i < pattern.WordCount; i++) {
					char *word = pattern.Word [i], *low_word = low_pattern.Word [i];
					if (local_out.size ()) {
						char last = pattern_m.Word [i-1] [strlen (pattern_m.Word [i-1]) - 1];
						const char* pos_in_small = strstr (ptr, low_pattern.Word [i-1]);
						bool is_defis = *(pos_in_small + strlen (low_pattern.Word [i-1])) == '-';
						bool is_tilda = *(pos_in_small + strlen (low_pattern.Word [i-1])) == '~';
						ptr += strlen (low_pattern.Word [i-1]) + 1;
						if (is_defis)
							local_out += '-';
						else if (is_tilda)
							local_out += '~';
						else if (strchr (mm_delimiters, last) && strchr (mm_delimiters, dest_char)) {
							if (local_out [local_out.size () - 1] != last)
								local_out += last;
							else
								local_out += " ";
						} else
								local_out += " ";
					}
					StrStrMap::const_iterator str_it = corrects.find (low_word);
					if (str_it == corrects.end ()) {
						local_out += low_word;
						cant_correct.push_back (low_word);
					} else {
						const char* corrected_word = str_it->second.c_str ();
						size_t at_corrected = 0;
						bool b_was_low = false;
						for (unsigned int chars = 0; chars < strlen (low_word); chars++) {
							if (!corrected_word [at_corrected]) {
								local_out += ' ';
								break;
							}
							while (corrected_word [at_corrected] == ' ') {
								local_out += ' ';
								at_corrected++;
							}

							org_char = low_word [chars];
							if ((org_char >= 'A' && org_char <= 'Z') || (org_char > 191 && org_char < 224))
								dest_char = corrected_word [at_corrected++];
							else {
								dest_char = ToLowerWin (corrected_word [at_corrected++]);
								b_was_low = true;
							}
							local_out += dest_char;
						}
						for (; at_corrected < strlen (corrected_word); at_corrected++)
							local_out += b_was_low ? ToLowerWin (corrected_word [at_corrected]) : corrected_word [at_corrected];
					}
				}
				for (GCL::StrVector::const_iterator it = cant_correct.begin (); it != cant_correct.end (); it++) {
					char* at = strdup (it->c_str ());
					WinStrUpr (at);
					was.insert (at);

					ContextPattern pattern;
					BuildPatternM (pattern, at);
					for (int i = 0; i < pattern.WordCount; i++)
						was.insert (pattern.Word [i]);
					gk_free (at);
				}
			}

			Core::Aptr <GCL::StrSet> res = this->get_incorrect_words (local_out.c_str ());

			if (res.is_nil () == false) {
				incorrect_words.insert (res->begin (), res->end ());

				for (GCL::StrSet::const_iterator word_it = incorrect_words.begin (); word_it != incorrect_words.end (); word_it++) {
					if (!std::binary_search (was.begin (), was.end (), *word_it))
						cant_correct.push_back (*word_it);
				}
			}

			if (out.size () || counter)
				out += delimiter;
			if (valid_quote && was_quote) 
				local_out  = "\"" + local_out + "\"";
			out += local_out;
			counter++;
		}
	}

	gk_free (corrected_in);
	if (minus_minus_pos) out += minus_minus_pos;
}

bool SearchBase::get_external_link (long link_type, Ref ref, std::string &result)
{
	result = "";
	DocInfo docinfo;
	if (FindDocInfo (ref.DocId, docinfo) == sizeof (DocInfo)) {
		Document* doc = GetDoc (ref.DocId);
		long para;
		if (!doc->FindSub (ref.Sub, para))
			return false;
		char* str_para = doc->GetPara (para);
		if (link_type == EndtTools::CI_SCRIPT) {
			long structs_count, last_para = para;
			DocStruct *org_structs = (DocStruct*) LoadAttr (ref.DocId, IDD_DOCSTRUCT, structs_count), *structs = org_structs;
			structs_count /= sizeof (DocStruct);
			for (int i = 0; i < structs_count; i++, structs++) {
				if (structs->m_start_para < (unsigned long) para)
					continue;
				short evd_type = (short) ((structs->m_para_list_type >> 24) & 0xFF);
				if (evd_type == SUBDESCEX_BLOCK) {
					if (structs->m_para_list_id == ref.Sub) {
						last_para = structs->m_end_para + 1;
						break;
					}
				}
			}
			gk_free (org_structs);
			for (int paras = ++para; paras < last_para; paras++) {
				str_para = doc->GetPara (paras);
				int sz = doc->EVDTextSize (str_para);
				str_para = doc->EVDParaText (str_para);
				char* part = (char*) malloc (sz + 1);
				strncpy (part, str_para, sz);
				part [sz] = 0;
				Recoding (cd_dos, cd_win, part);
				if (result.size ())
					result += "\n";
				result += part;
				gk_free (part);
			}
			delete doc;
			return true;
		} else if (str_para) {
			int sz = doc->EVDTextSize (str_para);
			str_para = doc->EVDParaText (str_para);			
			if (str_para) {
				char* url = (char*) malloc (sz + 1);
				strncpy (url, str_para, sz);
				url [sz] = 0;
				Recoding (cd_dos, cd_win, url);
				if (link_type == EndtTools::CI_ENO)
					result = url + 4;
				else if (link_type == EndtTools::CI_SEARCH_QUERY) {
					result = url + 6;
				} else {
					result = url;
				}
				gk_free (url);
			}
			delete doc;
			return true;
		}
		delete doc;
	}
	return false;
}

void SearchBase::load_anno_ids () {
	if (!map_anno_id_str.size ()) {
		Stream *str = FindIndex ("Aux")->Open (AUX_ANNO_UIDS);
		if (!str) {
			map_anno_id_str.insert (std::map<long,std::string>::value_type (0,"BadKey"));
			map_anno_str_id.insert (std::map<std::string,long>::value_type ("BadKey",0));
		} else {
			long size = str->Length ();
			char* data = (char*) malloc (size), *ptr = data;
			str->Read (data, size);
			while (ptr - data < size) {
				char* pos = strchr (ptr, '|');
				if (pos) {
					long id = atol (pos+1);
					*pos = 0;
					map_anno_id_str.insert (std::map<long,std::string>::value_type (id, ptr));
					map_anno_str_id.insert (std::map<std::string,long>::value_type (ptr, id));

					std::string shortstr;
					GCL::StrVector parts;
					boost::split (parts, ptr, boost::is_any_of ("\\"));
					for (GCL::StrVector::const_iterator it = parts.begin (); it != parts.end (); it++) {
						if (shortstr.size ())
							shortstr += "\\";
						shortstr += it->c_str () + 4;
					}
					map_anno_shortstr_id.insert (std::map<std::string,long>::value_type (shortstr, id));

					*pos = '|';
				}
				ptr += strlen (ptr) + 1;
			}
			gk_free (data);
			FindIndex ("Aux")->Close (str);
		}
	}
}

void	SearchBase::load_kind_ids ()
{
	if (!map_kind_id_str.size ()) {
		Stream *str = FindIndex ("Aux")->Open (AUX_KIND_UIDS);
		if (!str) {
			map_kind_id_str.insert (std::map<long,std::string>::value_type (0,"BadKey"));
			map_kind_id_str_woprefix.insert (std::map<long,std::string>::value_type (0,"BadKey"));
			map_kind_str_id.insert (std::map<std::string,long>::value_type ("BadKey",0));
		} else {
			long size = str->Length ();
			char* data = (char*) malloc (size), *ptr = data;
			str->Read (data, size);
			while (ptr - data < size) {
				char* pos = strchr (ptr, '|');
				if (pos) {
					long id = atol (pos+1);
					*pos = 0;

					GCL::StrVector parts;
					boost::split (parts, ptr, boost::is_any_of ("\\"));
					std::string str_woprefix;
					for (GCL::StrVector::const_iterator parts_it = parts.begin (); parts_it != parts.end (); parts_it++) {
						if (str_woprefix.size ())
							str_woprefix += "\\";
						str_woprefix += parts_it->c_str () + 4;
					}
					map_kind_id_str_woprefix.insert (std::map<long,std::string>::value_type (id, str_woprefix));
					map_kind_id_str.insert (std::map<long,std::string>::value_type (id, ptr));
					map_kind_str_id.insert (std::map<std::string,long>::value_type (ptr, id));
					map_kind_strwoprefix_id.insert (std::map<std::string,long>::value_type (str_woprefix, id));
					*pos = '|';
				}
				ptr += strlen (ptr) + 1;
			}
			gk_free (data);
			FindIndex ("Aux")->Close (str);
		}
	}
}

void	SearchBase::load_kind_bp ()
{
	if (!map_bpkind_uid.size ()) {
		Stream *str = FindIndex ("Aux")->Open (AUX_KIND_BASESEARCH);
		if (!str) {
			map_bpkind_uid.insert (std::map<std::string,long>::value_type ("AllDocs", 0));
		} else {
			long size = str->Length ();
			char* data = (char*) malloc (size), *ptr = data;
			str->Read (data, size);
			while (ptr - data < size) {
				char* pos = strchr (ptr, '|');
				if (pos) {
					long uid = atol (pos+1);
					*pos = 0;
					map_bpkind_uid.insert (std::map<std::string,long>::value_type (ptr, uid));
					vector_bpkinds.push_back (ptr);
					*pos = '|';
				}
				ptr += strlen (ptr) + 1;
			}
			gk_free (data);
			FindIndex ("Aux")->Close (str);
		}
	}
}

void	SearchBase::load_kind_bits ()
{
	if (!map_kind_uid_bit.size ()) {
		Stream *str = FindIndex ("Aux")->Open (AUX_KIND_BITS);
		if (!str) {
			map_kind_uid_bit.insert (std::map<long,u_int64_t>::value_type (0,0));
			map_kind_bit_uid.insert (std::map<u_int64_t,long>::value_type (0,0));
		} else {
			long size = str->Length ();
			char* data = (char*) malloc (size), *ptr = data;
			str->Read (data, size);
			for (long count = size / (sizeof (long) + sizeof (u_int64_t)); count; count--) {
				long uid = *(long*)ptr;
				ptr += sizeof (long);
				u_int64_t bit = *(u_int64_t*)ptr;
				ptr += sizeof (u_int64_t);
				map_kind_uid_bit.insert (std::map<long,u_int64_t>::value_type (uid, bit));
				map_kind_bit_uid.insert (std::map<u_int64_t,long>::value_type (bit, uid));
			}
			gk_free (data);
			FindIndex ("Aux")->Close (str);
		}
	}
}

unsigned long SearchBase::anno_key_to_id (const char* key)
{
	load_anno_ids ();
	std::map<std::string,long>::const_iterator it = map_anno_str_id.find (key);
	if (it != map_anno_str_id.end ())
		return it->second;
	else
		return 0;
}

unsigned long SearchBase::anno_short_key_to_id (const char* key)
{
	load_anno_ids ();
	std::map<std::string,long>::const_iterator it = map_anno_shortstr_id.find (key);
	if (it != map_anno_shortstr_id.end ())
		return it->second;
	else
		return 0;
}

long SearchBase::kind_key_to_uid (const char* key)
{
	load_kind_ids ();
	std::map<std::string,long>::const_iterator it = map_kind_str_id.find (key);
	if (it != map_kind_str_id.end ())
		return it->second;
	else
		return 0;
}

long SearchBase::kind_keywoprefix_to_uid (const char* key)
{
	load_kind_ids ();
	std::map<std::string,long>::const_iterator it = map_kind_strwoprefix_id.find (key);
	if (it != map_kind_strwoprefix_id.end ())
		return it->second;
	else
		return 0;
}

long SearchBase::kind_key_to_uid (HIndex::HIndexKey* key)
{
	HIndex* kinds = (HIndex*) FindIndex ("Kind");
	char* full_name = new char [kinds->KeyLength * 5];
	long uid = kind_key_to_uid (kinds->FullName (key, full_name));
	delete []full_name;
	return uid;
}

u_int64_t SearchBase::kind_uid_to_bit (long uid)
{
	load_kind_bits ();
	std::map<long,u_int64_t>::const_iterator it = map_kind_uid_bit.find (uid);
	if (it != map_kind_uid_bit.end ())
		return it->second;
	else
		return 0;
}

long SearchBase::kind_bit_to_uid (u_int64_t bit)
{
	load_kind_bits ();
	std::map<u_int64_t,long>::const_iterator it = map_kind_bit_uid.find (bit);
	if (it != map_kind_bit_uid.end ())
		return it->second;
	else
		return 0;
}

const char* SearchBase::anno_id_to_text (unsigned long id)
{
	load_anno_ids ();
	std::map<long,std::string>::const_iterator it = map_anno_id_str.find (id);
	if (it != map_anno_id_str.end ())
		return it->second.c_str ();
	else
		return 0;
}

const char* SearchBase::kind_uid_to_text (long id)
{
	load_kind_ids ();
	std::map<long,std::string>::const_iterator it = map_kind_id_str.find (id);
	if (it != map_kind_id_str.end ())
		return it->second.c_str ();
	else
		return 0;
}

const char* SearchBase::kind_uid_to_text_woprefix (long id)
{
	load_kind_ids ();
	std::map<long,std::string>::const_iterator it = map_kind_id_str_woprefix.find (id);
	if (it != map_kind_id_str_woprefix.end ())
		return it->second.c_str ();
	else
		return 0;
}

void SearchBase::check_base_for_language () {
	if (language_tag == -1) {
		language_tag = 0;

		Stream *str = FindIndex ("Aux")->Open ("Here");
		long length = str->Length ();
		int hcount = length / sizeof (short);
		short *heres = (short*) malloc (length);
		str->Read (heres, length);
		FindIndex ("Aux")->Close (str);

		for (int i = 0; i < hcount; i++)
			if (heres[i] == 32 || (heres[i] >= 240 && heres[i] <= 255)) {
				language_tag = 1;
				break;
			}
		gk_free (heres);
	}
}

void	SearchBase::get_filtered_tree (const char* aux_source, const char* index_name, std::vector<HIndex::HIndexKey*> &keys, std::vector<bool> &is_filtered)
{
	Stream* str = FindIndex ("Aux")->Open (aux_source);
	std::map<long,long> map_id_levels;
	if (str) {
		long aux_size = str->Length ();
		TreeNodeLevel *aux_nodes = new TreeNodeLevel [aux_size / sizeof (TreeNodeLevel)], *aux_nodes_ptr = aux_nodes;
		str->Read (aux_nodes, aux_size);
		aux_size /= sizeof (TreeNodeLevel);
		FindIndex ("Aux")->Close (str);
		for (long i = 0; i < aux_size; i++, aux_nodes_ptr++)
			map_id_levels.insert (std::map<long,long>::value_type (aux_nodes_ptr->id, aux_nodes_ptr->level));
		delete[] aux_nodes;
	} else {
		return ;
	}

	HIndex *index = (HIndex*) FindIndex (index_name);
	BTIterator it (index);

	std::map<long,long> map_id_topparentid, map_id_parentid;
	std::map<long,long> map_id_level;
	std::set<long> ids;
	long found = 0, max_levels = 0;
	for (; !it.End (); ++it) {
		HIndex::HIndexKey *key = (HIndex::HIndexKey*) it.Key ();
		long id = key->id;
		std::map<long,long>::const_iterator map_it = map_id_levels.find (id);
		if (map_it != map_id_levels.end ()) {
			ids.insert (id);

			long top_parentid = key->parent ? key->parent : id;
			std::map<long,long>::iterator topparent_it = map_id_topparentid.find (top_parentid);
			if (topparent_it != map_id_topparentid.end ())
				top_parentid = topparent_it->second;
			map_id_topparentid.insert (std::map<long,long>::value_type (id, top_parentid));
			ids.insert (top_parentid);

			max_levels = std::max<long> (max_levels, map_id_levels.find (key->id)->second - 1 + key->level);

			if (++found == map_id_levels.size ())
				break;
		}
	}

	it.Set (0);
	std::set<long> final_ids; //какие элементы индекса попали в финальное дерево
	std::map<long,long> map_id_originalchcount;
	for (; !it.End (); ++it) {
		HIndex::HIndexKey *key = (HIndex::HIndexKey*) it.Key ();
		if (key->level > max_levels)
			break;

		long id = key->id, parent = key->parent, check_id = id;
		map_id_parentid.insert (std::map<long,long>::value_type (id, key->parent));		
		
		bool found = ids.find (check_id) != ids.end ();
		while (!found) {
			std::map<long,long>::const_iterator parent_it = map_id_parentid.find (check_id);
			if (parent_it == map_id_parentid.end ())
				break;
			check_id = parent_it->second;
			std::map<long,long>::const_iterator levels_it = map_id_levels.find (check_id);
			std::map<long,long>::const_iterator parentlevel_it = map_id_level.find (check_id);
			if ((levels_it != map_id_levels.end ()) && (key->level < levels_it->second + parentlevel_it->second))
				found = true;
		}

		if (found) {
			final_ids.insert (id);
			HIndex::HIndexKey* insert_key = (HIndex::HIndexKey*) malloc (index->KeyLength);
			insert_key->id = id;
			insert_key->level = key->level;
			insert_key->parent = parent;
			insert_key->chCount = 0;
			insert_key->achCount = 0;
			strcpy (insert_key->text, key->text);
			keys.push_back (insert_key);
			map_id_originalchcount.insert (std::map<long,long>::value_type (id, key->chCount));
			map_id_level.insert (std::map<long,long>::value_type (id, key->level));
		}
	}

	std::map<long,long> map_id_childrencount;
	std::vector<HIndex::HIndexKey*>::iterator keys_it;

	for (keys_it = keys.begin (); keys_it != keys.end (); keys_it++) {
		HIndex::HIndexKey *key = *keys_it;

		long id = key->id;
		if (final_ids.find (id) == final_ids.end ())
			continue;

		map_id_childrencount.insert (std::map<long,long>::value_type (id, 0));
		if (key->parent)
			map_id_childrencount.find (key->parent)->second++;
	}

	for (keys_it = keys.begin (); keys_it != keys.end (); keys_it++) {
		HIndex::HIndexKey *key = *keys_it;
		key->chCount = map_id_childrencount.find (key->id)->second;
		std::map<long,long>::const_iterator map_it = map_id_originalchcount.find (key->id);
		if (map_it != map_id_originalchcount.end () && key->chCount && key->chCount != map_it->second)
			is_filtered.push_back (true);
		else
			is_filtered.push_back (false);
	}
}

void	SearchBase::get_bpkinds (std::vector<std::string> &kinds)
{
	load_kind_bp ();
	kinds.clear ();
	for (std::vector<std::string>::const_iterator it = vector_bpkinds.begin (); it != vector_bpkinds.end (); it++) {
		long uid = bpkind_to_uid (it->c_str ());
		if (uid) {
			const char *text = kind_uid_to_text (uid);
			BTKEY key = FindIndex ("Kind")->FullKey (text);
			if (key) {
				free ((void*) key);
				kinds.push_back (it->c_str ());
			}
		}
	}
}

long	SearchBase::bpkind_to_uid (const char* kind)
{
	load_kind_bp ();
	std::map<std::string,long>::const_iterator it = map_bpkind_uid.find (kind);
	if (it == map_bpkind_uid.end ())
		return 0;
	else
		return it->second;
}

bool	compare_hstr (char* index_str, const char* user_str)
{
	char	shrinked_str [2048];

	char* toput = shrinked_str;
	*toput = 0;
	char *token = strtok (index_str, "\\");
	while (token) {
		if (toput != shrinked_str) {
			toput++;
			*toput = '\\';
			toput++;
		}
		int length = static_cast<int> (strlen (token))-4;
		memcpy (toput, token+4, length+1);
		toput += length - 1;
		token = strtok (0, "\\");
	}
	return !strcmp (shrinked_str, user_str);
}

SearchResult*	SearchBase::execute_search (std::vector<std::string> &strings)
{
	bool b_inpharm = false, b_found0 = false;
	std::vector<IndexReq*> vector_indexreqs;
	std::vector<std::string> keys;
	std::string index_name ("");
	for (std::vector<std::string>::const_iterator str_it = strings.begin (); str_it != strings.end (); str_it++) {
		if (str_it->c_str ()[0] == '[') {
			if (index_name.size ()) {
				if (!stricmp (index_name.c_str (), "TEXT")) {
					IndexReq* req = build_morpho_req (keys, SV_MBODIES);
					vector_indexreqs.push_back (req);
				} else if (!stricmp (index_name.c_str (), "NAME")) {
					IndexReq* req = build_morpho_req (keys, SV_MTITLES);
					vector_indexreqs.push_back (req);
				} else if (strcmp (index_name.c_str (), "Docs")) {
					IndexReq* req = build_req (this, index_name.c_str (), keys, b_inpharm);
					vector_indexreqs.push_back (req);
				}
			}
			keys.clear ();
			index_name.assign (*str_it, 1, str_it->size () - 2);
		} else {
			keys.push_back (*str_it);
		}
	}
	if (index_name.size ()) {
		if (!stricmp (index_name.c_str (), "TEXT")) {
			IndexReq* req = build_morpho_req (keys, SV_MBODIES);
			vector_indexreqs.push_back (req);
		} else if (!stricmp (index_name.c_str (), "NAME")) {
			IndexReq* req = build_morpho_req (keys, SV_MTITLES);
			vector_indexreqs.push_back (req);
		} else if (strcmp (index_name.c_str (), "Docs")) {
			IndexReq* req = build_req (this, index_name.c_str (), keys, b_inpharm);
			vector_indexreqs.push_back (req);
		}
	}

	SearchResult *search_result = 0;
	if (!strcmp (index_name.c_str (), "Docs")) {
		std::vector<long> docs;
		for (std::vector<std::string>::const_iterator it = keys.begin (); it != keys.end (); it++)
			docs.push_back (atol (it->c_str ()));
		std::sort (docs.begin (), docs.end ());
		search_result = new SearchResult;
		search_result->fulllist_itemcount = static_cast<long> (docs.size ());
		search_result->list_is_cut = false;
		search_result->list = new DocCollection;
		for (std::vector<long>::const_iterator docs_it = docs.begin (); docs_it != docs.end (); docs_it++) {
			long doc_id = *docs_it;
			search_result->list->Collection::Add (&doc_id);
		}
	} else {
		std::vector<IndexReq*>::iterator reqs_it;
		for (reqs_it = vector_indexreqs.begin (); reqs_it != vector_indexreqs.end (); reqs_it++)
			if (*reqs_it == 0) {
				b_found0 = true;
				break;
			}
		if (!b_found0) {
			IndexReq* reqs [64];
			int req_count = 0;
			for (reqs_it = vector_indexreqs.begin (); reqs_it != vector_indexreqs.end (); reqs_it++) {
				IndexReq* at_reqs_it = *reqs_it;
				reqs [req_count++] = at_reqs_it;
			}
			search_result = Search (req_count, reqs, 0, SO_AND, b_inpharm);
		}
		for (reqs_it = vector_indexreqs.begin (); reqs_it != vector_indexreqs.end (); reqs_it++)
			gk_free (*reqs_it);
	}

	return search_result;
}

SearchResult*	SearchBase::execute_search_from (long doc_id, long block)
{
	IndexLoader loader (this);
	long structs_count, i = 0;
	bool found = false;
	INDEX_DATA (DocStruct) structs = loader.load <DocStruct> (doc_id, IDD_DOCSTRUCT, structs_count);
	DocStruct *ptr = structs.ptr ();
	for (i = 0; i < structs_count; i++, ptr++) {
		short evd_type = (short) ((ptr->m_para_list_type >> 24) & 0xFF);
		if ((evd_type == SUBDESCEX_BLOCK) && (ptr->m_para_list_id == block)) {
			found = true;
			break;
		}
	}
	if (found) {
		Document* doc = GetDoc (doc_id);
		std::vector<std::string> strings;
		for (unsigned i = ptr->m_start_para; i <= ptr->m_end_para; i++) {
			char *para = doc->EVDParaText (doc->GetPara (i), true);
			Recoding (cd_dos, cd_win, para);
			strings.push_back (para);
		}
		delete doc;
		return execute_search (strings);
	}

	return 0;
}

std::vector<AnalysisNode> SearchBase::get_data_for_analysis_tree ()
{
	std::vector<AnalysisNode> result, unsorted_result;

	u_int64_t mask;
	Stream* str = FindIndex ("Aux")->Open (AUX_KIND_ANALYSEMASK);
	if (!str)
		return result;

	str->Read (&mask, sizeof (mask));
	FindIndex ("Aux")->Close (str);
	load_kind_bits ();

	std::set<long> leaf_uids, leafs_uids_with_parent;
	std::vector<long> folder_uids;
	std::vector<AnalysisNode> empty;

	u_int64_t power = 1;
	for (int i = 0; i < 64; i++, power <<= 1) {
		if (mask & power) {
			long uid = kind_bit_to_uid (power);
			if (uid)
				leaf_uids.insert (uid);
			}
		}

	for (std::map <u_int64_t, long>::const_iterator map_it = map_kind_bit_uid.begin (); map_it != map_kind_bit_uid.end (); map_it++) {
		if ((leaf_uids.find (map_it->second) == leaf_uids.end ()) && (map_it->first & mask))
			folder_uids.push_back (map_it->second);
	}

	for (std::vector<long>::const_iterator folders_it = folder_uids.begin (); folders_it != folder_uids.end (); folders_it++) {
		long folder_uid = *folders_it;
		u_int64_t folder_mask = kind_uid_to_bit (folder_uid);
		std::vector<AnalysisNode> leafs;

		std::set<long> leaf_prefixes;

		for (std::set<long>::const_iterator leafs_it = leaf_uids.begin (); leafs_it != leaf_uids.end (); leafs_it++) {
			long leaf_uid = *leafs_it;
			u_int64_t leaf_mask = kind_uid_to_bit (leaf_uid);
			if (folder_mask & leaf_mask) {
				const char* kind_text = kind_uid_to_text (leaf_uid);
				if (!kind_text)
					continue;
				char *name = strdup (kind_text), *slash = strchr (name, '\\');
				if (slash) {
					long prefix = atol (slash + 1);
					leaf_prefixes.insert (prefix);
				}
				free (name);
			}
		}

		for (std::set<long>::const_iterator prefix_it = leaf_prefixes.begin (); prefix_it != leaf_prefixes.end (); prefix_it++) {
			for (std::set<long>::const_iterator leafs_it = leaf_uids.begin (); leafs_it != leaf_uids.end (); leafs_it++) {
				long leaf_uid = *leafs_it;
				u_int64_t leaf_mask = kind_uid_to_bit (leaf_uid);
				if (folder_mask & leaf_mask) {
					char *name = strdup (kind_uid_to_text (leaf_uid)), *slash = strchr (name, '\\');
					if (slash) {
						if (atol (slash + 1) == *prefix_it) {
							BTKEY key = FindIndex ("Kind")->FullKey (name);
							if (key) {
								free ((void*) key);

								AnalysisNode leaf;
								leaf.name = strchr (slash, '=') + 1;
								leaf.mask = leaf_mask;
								leaf.children = empty;
								leafs.push_back (leaf);
								leafs_uids_with_parent.insert (leaf_uid);
							}
						}
					}
					free (name);
				}
			}
		}

		AnalysisNode folder;
		if (kind_uid_to_text (folder_uid)) {
			folder.name = kind_uid_to_text (folder_uid);
			folder.mask = folder_mask;
			folder.children = leafs;

			unsorted_result.push_back (folder);
		}
	}

	for (std::set<long>::const_iterator leaf_it = leaf_uids.begin (); leaf_it != leaf_uids.end (); leaf_it++) {
		long leaf_uid = *leaf_it;
		if (leafs_uids_with_parent.find (leaf_uid) == leafs_uids_with_parent.end ()) {
			if (kind_uid_to_text (leaf_uid)) {
				AnalysisNode folder;
				folder.name = kind_uid_to_text (leaf_uid);
				folder.mask = kind_uid_to_bit (leaf_uid);
				folder.children = empty;
				unsorted_result.push_back (folder);
			}
		}
	}

	std::set<long> folder_prefixes;
	for (std::vector<AnalysisNode>::const_iterator result_it = unsorted_result.begin (); result_it != unsorted_result.end (); result_it++)
		folder_prefixes.insert (atol (result_it->name.c_str ()));

	for (std::set<long>::const_iterator prefix_it = folder_prefixes.begin (); prefix_it != folder_prefixes.end (); prefix_it++) {
		for (std::vector<AnalysisNode>::const_iterator result_it = unsorted_result.begin (); result_it != unsorted_result.end (); result_it++) {
			if (*prefix_it == atol (result_it->name.c_str ())) {
				BTKEY key = FindIndex ("Kind")->FullKey (result_it->name.c_str ());
				if (key) {
					free ((void*) key);

					AnalysisNode folder;
					folder.name = result_it->name.c_str () + 4;
					folder.mask = result_it->mask;
					folder.children = result_it->children;
					result.push_back (folder);
					break;
				}
			}
		}
	}

	return result;
}

void SearchBase::load_relevancy_changes (DBCore::RelevancyTuneData& out) {
	Stream* str = FindIndex ("Aux")->Open (AUX_RELEVANCY_CHANGES);
	if (str) {
		long size = str->Length ();
		char* index_strings = new char [size], *ptr = index_strings;
		str->Read (index_strings, size);
		FindIndex ("Aux")->Close (str);

		std::vector<std::string> strings;
		for (size_t i = 0; i < (size_t) size; ) {
			strings.push_back (ptr);
			i += strlen (ptr) + 1;
			ptr += strlen (ptr) + 1;
		}
		delete [] index_strings;

		std::vector<std::string> search_request;
		for (std::vector<std::string>::const_iterator str_it = strings.begin (); str_it != strings.end (); str_it++) {
			size_t pos = str_it->find ("[Rele=");
			if (pos == std::string::npos)
				search_request.push_back (*str_it);
			else {
				SearchResult* search_result = execute_search (search_request);
				if (search_result) {
					if (search_result->list) {
						int rele = atol (str_it->c_str () + 6);
						DocCollection docs;
						docs.Merge (*search_result->list);
						delete search_result->list;
						DBCore::DocListRelevancy relevancy_data;
						relevancy_data.relevancy = rele;
						for (int page = 0; page < docs.PageCount; page++) {
							long* ptr = (long*) docs.Pages [page];
							for (int item = 0; item < docs.Count [page]; item++, ptr++)
								relevancy_data.docs.push_back (*ptr);
						}
						out.push_back (relevancy_data);
					}
					delete search_result;
				}
				search_request.clear ();
			}
		}

		std::sort (out.begin (), out.end (), std::greater <DBCore::DocListRelevancy> ());
	}
}

bool	SearchBase::is_doc_changed (long id)
{
	Index* index = FindIndex ("Attrs");
	AttrKey key = {id, IDD_CHDATE};
	bool changed = index->IsExist (&key);
	if (!changed) {
		key.AttrTag = IDD_VCHANGED;
		changed = index->IsExist (&key);
		if (!changed) {
			DocInfo info;
			if (FindDocInfo (id, info)) {
				changed = (info.prevEdition != 0);
			}
		}
	}
	return changed;
}

void	SearchBase::get_section_name (const char* section, std::string &name)
{
	bool found = false;
	Stream* str = FindIndex ("Aux")->Open (AUX_SERV);
	if (str) {
		int size = str->Length ();
		char *buffer = new char [size], *ptr = buffer;
		str->Read (buffer, size);
		FindIndex ("Aux")->Close (str);
		while (ptr - buffer < size) {
			if (!memcmp (ptr, section, strlen (section))) {
				if (strrchr (ptr, '\\'))
					ptr = strrchr (ptr, '\\');
				else
					ptr = strchr (ptr, ':');
				if (strchr (ptr, '='))
					ptr = strchr (ptr, '=');
				ptr++;				
				name = ptr;
				found = true;
				break;
			}
			ptr += strlen (ptr) + 1;
		}
		delete [] buffer;
		if (!found) {
			if (!strcmp (section, AUX_OM_CHANGESINLEGISLATION)) {
				name = "Изменения в законодательстве";
			} else if (!strcmp (section, AUX_CLASS6_TAXFINANCE)) {
				name = "Налоги, бухучет";
			} else if (!strcmp (section, AUX_CLASS6_JURISPRUDENCE)) {
				name = "Юридические вопросы";
			} else if (!strcmp (section, AUX_CLASS6_HR)) {
				name = "Кадровые вопросы";
			} else if (!strcmp (section, AUX_CLASS6_BUDGETORGS)) {
				name = "Государственный сектор";
			} else if (!strcmp (section, AUX_CLASS6_BUSINESS_REFERENCES)) {
				name = "Бизнес-справки";
			} else if (!strcmp (section, AUX_CLASS6_GOSZAKUPKI)) {
				name = "Госзакупки";
			}
		}
	}
}

std::vector<AnalysisNode> SearchBase::get_data_for_correspondent_tree (u_int64_t mask)
{
	std::vector<AnalysisNode> result, unsorted_result;

	load_kind_bits ();

	std::set<long> leaf_uids, leafs_uids_with_parent;
	std::vector<long> folder_uids;
	std::vector<AnalysisNode> empty;

	std::map<long, long> map_uid_levels;
	{
	Stream *str = FindIndex ("Aux")->Open (AUX_FILTERED_CORR);
	if (str) {
		int length = str->Length ();
		TreeNodeLevel* data = (TreeNodeLevel*) malloc (length);
		str->Read (data, length);
		FindIndex ("Aux")->Close (str);
		length /= sizeof (TreeNodeLevel);
		for (BTIterator it (FindIndex ("Kind")); !it.End (); ++it) {
			HIndex::HIndexKey* hkey = (HIndex::HIndexKey*) it.Key ();
			if (hkey->level)
				break;
			for (int i = 0; i < length; i++) {
				if (data [i].id == hkey->id) {
					long uid = kind_key_to_uid (hkey->text);
					if (uid)
						map_uid_levels.insert (std::map<long, long>::value_type (uid, data[i].level));
					break;
				}
			}
		}
		free (data);
	}
	}

	u_int64_t power = 1;
	for (int i = 0; i < 64; i++, power <<= 1) {
		if (mask & power) {
			long uid = kind_bit_to_uid (power);
			if (uid)
				leaf_uids.insert (uid);
		}
	}

	for (std::map <u_int64_t, long>::const_iterator map_it = map_kind_bit_uid.begin (); map_it != map_kind_bit_uid.end (); map_it++) {
		if ((leaf_uids.find (map_it->second) == leaf_uids.end ()) && (map_it->first & mask))
			folder_uids.push_back (map_it->second);
	}

	for (std::vector<long>::const_iterator folders_it = folder_uids.begin (); folders_it != folder_uids.end (); folders_it++) {
		long folder_uid = *folders_it;
		u_int64_t folder_mask = kind_uid_to_bit (folder_uid);

		std::vector<AnalysisNode> leafs;

		if (map_uid_levels.find (folder_uid) != map_uid_levels.end () && map_uid_levels.find (folder_uid)->second == 2) {
			std::set<long> leaf_prefixes;

			for (std::set<long>::const_iterator leafs_it = leaf_uids.begin (); leafs_it != leaf_uids.end (); leafs_it++) {
				long leaf_uid = *leafs_it;
				u_int64_t leaf_mask = kind_uid_to_bit (leaf_uid);
				if (folder_mask & leaf_mask) {
					const char* kind_text = kind_uid_to_text (leaf_uid);
					if (!kind_text)
						continue;
					char *name = strdup (kind_text), *slash = strchr (name, '\\');
					if (slash) {
						long prefix = atol (slash + 1);
						leaf_prefixes.insert (prefix);
					}
					free (name);
				}
			}

			for (std::set<long>::const_iterator prefix_it = leaf_prefixes.begin (); prefix_it != leaf_prefixes.end (); prefix_it++) {
				for (std::set<long>::const_iterator leafs_it = leaf_uids.begin (); leafs_it != leaf_uids.end (); leafs_it++) {
					long leaf_uid = *leafs_it;
					u_int64_t leaf_mask = kind_uid_to_bit (leaf_uid);
					if (folder_mask & leaf_mask) {
						char *name = strdup (kind_uid_to_text (leaf_uid)), *slash = strchr (name, '\\');
						if (slash) {
							if (atol (slash + 1) == *prefix_it) {
								BTKEY key = FindIndex ("Kind")->FullKey (name);
								if (key) {
									free ((void*) key);

									AnalysisNode leaf;
									leaf.name = strchr (slash, '=') + 1;
									leaf.mask = leaf_mask;
									leaf.children = empty;
									leafs.push_back (leaf);
									leafs_uids_with_parent.insert (leaf_uid);
								}
							}
						}
						free (name);
					}
				}
			}
		}

		AnalysisNode folder;
		if (kind_uid_to_text (folder_uid) && map_uid_levels.find (folder_uid) != map_uid_levels.end ()) {
			folder.name = kind_uid_to_text (folder_uid);
			folder.mask = folder_mask;
			folder.children = leafs;
			unsorted_result.push_back (folder);
		}
	}

	for (std::set<long>::const_iterator leaf_it = leaf_uids.begin (); leaf_it != leaf_uids.end (); leaf_it++) {
		long leaf_uid = *leaf_it;
		if (leafs_uids_with_parent.find (leaf_uid) == leafs_uids_with_parent.end ()) {
			if (kind_uid_to_text (leaf_uid)) {
				AnalysisNode folder;
				folder.name = kind_uid_to_text (leaf_uid);
				folder.mask = kind_uid_to_bit (leaf_uid);
				folder.children = empty;
				unsorted_result.push_back (folder);
			}
		}
	}

	std::set<long> folder_prefixes;
	for (std::vector<AnalysisNode>::const_iterator result_it = unsorted_result.begin (); result_it != unsorted_result.end (); result_it++)
		folder_prefixes.insert (atol (result_it->name.c_str ()));

	check_base_for_language ();

	AnalysisNode node;
	node.name = language_tag == 1 ? "All documents" : "Все документы";
	node.mask = 0xFFFFFFFFFFFFFFFF;
	node.children = empty;
	result.push_back (node);

	for (std::set<long>::const_iterator prefix_it = folder_prefixes.begin (); prefix_it != folder_prefixes.end (); prefix_it++) {
		for (std::vector<AnalysisNode>::const_iterator result_it = unsorted_result.begin (); result_it != unsorted_result.end (); result_it++) {
			if (*prefix_it == atol (result_it->name.c_str ())) {
				BTKEY key = FindIndex ("Kind")->FullKey (result_it->name.c_str ());
				if (key) {
					free ((void*) key);

					AnalysisNode folder;
					folder.name = result_it->name.c_str () + 4;
					folder.mask = result_it->mask;
					folder.children = result_it->children;
					result.push_back (folder);
					break;
				}
			}
		}
	}

	Stream* str = FindIndex ("Aux")->Open (AUX_KIND_CORRESPONDENTS);
	if (str) {		
		long count = str->Length () / sizeof (long), *first_levels = new long [count];
		str->Read (first_levels, str->Length ());
		FindIndex ("Aux")->Close (str);

		std::vector<AnalysisNode> ex_result;
		AnalysisNode node;
		for (int i = 0; i < count; i++) {
			node.children = empty;
			node.mask = kind_uid_to_bit (first_levels [i]);
			if (node.mask & mask) {
				HIndex::HIndexKey *key = (HIndex::HIndexKey*)FindIndex ("Kind")->FullKey (kind_uid_to_text (first_levels [i]));
				if (key) {
					node.name = key->text + 4;
					free ((void*) key);
					ex_result.push_back (node);
				}
			}
		}
		delete [] first_levels;
		if (ex_result.size ()) {
			node.children = result;
			node.mask = 0;
			node.name = language_tag == 1 ? "All" : "Все";
			ex_result.push_back (node);
			return ex_result;
		} else {
			return result;
		}
	} else {
		return result;
	}
}

void SearchBase::get_blocksandcrmasks_for_docandsegments (long docid, std::vector<long> &blocks, std::vector<u_int64_t> &masks, const std::vector<short> &sorted_segments) {
	Index* kindcorr_index = FindIndex ("KindCorr");

	Ref ref = {docid, 0};
	for (BTIterator it (kindcorr_index, &ref); !it.End (); ++it) {
		ref = *(Ref*) it.Key ();
		if (ref.DocId != docid || ref.Sub == INHERITED_BLOCK)
			break;

		Stream *str = kindcorr_index->Open (&ref);
		if (str) {
			long length = str->Length ();
			KindCorrRef* corrmasks = (KindCorrRef*) malloc (length), *mask = corrmasks;
			str->Read (corrmasks, length);
			kindcorr_index->Close (str);
			length /= sizeof (KindCorrRef);

			bool result = false;
			u_int64_t result_mask = 0;		
			for (long i = 0; i < length; i++, mask++) {
				if (std::binary_search (sorted_segments.begin (), sorted_segments.end (), mask->seg)) {
					result = true;
					result_mask |= mask->mask;
				}
			}

			free (corrmasks);

			if (result) {
				blocks.push_back (ref.Sub);
				masks.push_back (result_mask);
			}
		}
	}
}

bool SearchBase::get_cr_mask_for_segments (long docid, u_int64_t& result_mask, const std::set<long> &blocks, const std::vector<short> &sorted_segments) {
	bool result = false;
	result_mask = 0;
	Index* kindcorr_index = FindIndex ("KindCorr");

	const std::vector <short>& here_segs = BaseCache::instance ()->get_here_seg (this);
	const std::vector <short>& ignore_segs = BaseCache::instance ()->get_ignore_segs (this);

	bool b_check_ignoresegs = (here_segs != sorted_segments);

	std::set<long> check_blocks = blocks;
	if (!check_blocks.size ()) {
		Ref ref = {docid, INHERITED_BLOCK};
		Stream *str = kindcorr_index->Open (&ref);
		if (str) {
			long length = str->Length ();
			KindCorrRef* masks = (KindCorrRef*) malloc (length), *mask = masks;
			str->Read (masks, length);
			kindcorr_index->Close (str);
			length /= sizeof (KindCorrRef);

			for (long i = 0; i < length; i++, mask++) {
				if (b_check_ignoresegs && std::binary_search (ignore_segs.begin (), ignore_segs.end (), mask->seg))
					continue;
				if (std::binary_search (sorted_segments.begin (), sorted_segments.end (), mask->seg)) {
					result = true;
					result_mask |= mask->mask;
				}
			}

			free (masks);
		} else {
			ref.Sub = 0;
			for (BTIterator it (kindcorr_index, &ref); !it.End (); ++it) {
				ref = *(Ref*) it.Key ();
				if (ref.DocId != docid)
					break;

				Stream *str = kindcorr_index->Open (&ref);
				if (str) {
					long length = str->Length ();
					KindCorrRef* masks = (KindCorrRef*) malloc (length), *mask = masks;
					str->Read (masks, length);
					kindcorr_index->Close (str);
					length /= sizeof (KindCorrRef);

					for (long i = 0; i < length; i++, mask++) {
						if (b_check_ignoresegs && std::binary_search (ignore_segs.begin (), ignore_segs.end (), mask->seg))
							continue;
						if (std::binary_search (sorted_segments.begin (), sorted_segments.end (), mask->seg)) {
							result = true;
							result_mask |= mask->mask;
						}
					}

					free (masks);
				}
			}
		}
	} else {
		for (std::set<long>::const_iterator it = check_blocks.begin (); it != check_blocks.end (); it++) {
			Ref ref = {docid, *it};
			Stream *str = kindcorr_index->Open (&ref);
			if (str) {
				long length = str->Length ();
				KindCorrRef* masks = (KindCorrRef*) malloc (length), *mask = masks;
				str->Read (masks, length);
				kindcorr_index->Close (str);
				length /= sizeof (KindCorrRef);

				for (long i = 0; i < length; i++, mask++) {
					if (b_check_ignoresegs && std::binary_search (ignore_segs.begin (), ignore_segs.end (), mask->seg))
						continue;
					if (std::binary_search (sorted_segments.begin (), sorted_segments.end (), mask->seg)) {
						result = true;
						result_mask |= mask->mask;
					}
				}

				free (masks);
			}
		}
	}
	return result;
}

bool	SearchBase::is_encyclopedia_present (const std::vector<short> &ok_segs)
{
	Stream *str = FindIndex ("Aux")->Open (AUX_BELONGS_ENCYCLOPEDIA);
	if (!str)
		return false;

	long length = str->Length ();
	short *belongs = (short*) malloc (length);
	str->Read (belongs, length);
	FindIndex ("Aux")->Close (str);
	bool found = false;
	for (unsigned long i = 0; i < length / sizeof (short); ++i) {
		if (std::binary_search (ok_segs.begin (), ok_segs.end (), belongs [i])) {
			found = true;
			break;
		}
	}
	gk_free (belongs);
	return found;
}

bool SearchBase::is_decisionsarchive_present ()
{
	bool found = false;
	Stream* str = FindIndex ("Aux")->Open (AUX_BELONGS_DECISIONSARCHIVE);
	if (str) {
		long length = str->Length (), *belongs = (long*) malloc (length), i;
		str->Read (belongs, length);
		FindIndex ("Aux")->Close (str);
		length /= sizeof (long);

		const std::vector <short>& here_segs = BaseCache::instance ()->get_here_seg (this);

		for (i = 0; i < length && !found; i++)
			found = std::binary_search (here_segs.begin (), here_segs.end (), (short)(belongs [i] & 0xFFFF));
		gk_free (belongs);
	}
	return found;
}

ca_cache_box get_exist_docinfocache () {
	return SortAttrCache::instance ()->get_exist_docinfocache ();
}

status_cache_box get_exist_statuscache () {
	return SortAttrCache::instance ()->get_exist_statuscache ();
}

/*
Попытка сделать обратный (сегменты:ключи) индекс для Number
std::map<short,std::deque<std::string> > number_seg_keys;
for (std::set<short>::const_iterator seg_it = segs.begin (); seg_it != segs.end (); seg_it++) {
	std::map<short,std::deque<std::string> >::iterator map_it = number_seg_keys.find (*seg_it);
	if (map_it == number_seg_keys.end ()) {
		std::deque<std::string> keys;
		keys.push_back (key);
		number_seg_keys.insert (std::map<short,std::deque<std::string> >::value_type (*seg_it, keys));
	} else {
		map_it->second.push_back (key);
	}
}
*/

void	SearchBase::load_indexes_changes ()
{
	RWRITE_GUARD (readshortattributes_mutex) if (map_index_oldkeynewkey.size () == 0) {
		map_index_oldkeynewkey.insert (std::map<std::string, std::map<std::string,std::string> >::value_type ("dummy", std::map<std::string,std::string> ()));
		Stream* str = FindIndex ("Aux")->Open (AUX_INDEXES_CHANGES);
		if (str) {
			long size = str->Length ();
			char *data = new char [size], *ptr = data;
			str->Read (data, size);
			FindIndex ("Aux")->Close (str);

			while (ptr - data < size) {
				char* next = ptr + strlen (ptr) + 1;
				char* keys = strchr (ptr, ':');
				if (keys) {
					*keys++ = 0;
					char* syn = strchr (keys, '=');
					if (syn) {
						*syn++ = 0;
						std::map<std::string, std::map<std::string,std::string> >::iterator map_it = map_index_oldkeynewkey.find (ptr);
						if (map_it == map_index_oldkeynewkey.end ()) {
							std::map<std::string,std::string> syns;
							syns.insert (std::map<std::string,std::string>::value_type (keys, syn));
							map_index_oldkeynewkey.insert (std::map<std::string, std::map<std::string,std::string> >::value_type (ptr, syns));
						} else {
							map_it->second.insert (std::map<std::string,std::string>::value_type (keys, syn));
						}
					}
				}
				ptr = next;
			}
			delete [] data;
		}
	}
}

void SearchBase::get_ok_segs (const std::vector<short> &forbidden_blocks, std::set<short> &ok_segs) {
	const std::vector <short>& here_segs = BaseCache::instance ()->get_here_seg (this);

	for (std::vector<short>::const_iterator seg_it = here_segs.begin (); seg_it != here_segs.end (); seg_it++)
		if (std::find (forbidden_blocks.begin (), forbidden_blocks.end (), *seg_it) == forbidden_blocks.end ())
			ok_segs.insert (*seg_it);
}

namespace {

struct TreeNodeEx {
	TreeNodeEx (TreeNodeEx* parent, boost::string_ref name) 
		: parent (parent), name (name), children_count (0), position (parent->children_count++) {}

	TreeNodeEx (boost::string_ref name, size_t position)
		: parent (0), name (name), children_count (0), position (position) {}

	explicit TreeNodeEx (boost::string_ref name) : name (name) {
	}

	boost::string_ref name;
	TreeNodeEx* parent;
	size_t children_count;
	size_t position;
};

std::string::size_type find (boost::string_ref data, char symbol, std::string::size_type from = 0) {
	boost::string_ref for_search (data.data () + from, data.size () - from);
	std::string::size_type result = for_search.find (symbol);
	if (result != std::string::npos) {
		result += from;
	}

	return result;
}

void add_valid_keys (std::vector<boost::string_ref>& valid_keys, std::set<boost::string_ref>& folders, const boost::string_ref& full_key) {
	folders.insert (full_key);
	for (
		size_t backslash_position = full_key.find ('\\');
		backslash_position != std::string::npos;
		backslash_position = find (full_key, '\\', backslash_position + 1)
	) {
		boost::string_ref part_key (full_key.data (), backslash_position);
		if (folders.insert (part_key).second) {
			valid_keys.push_back (part_key);
		}
	}
}

void add_valid_key (std::vector<boost::string_ref>& valid_keys, const boost::string_ref& full_key) {
	valid_keys.push_back (full_key);
}

std::vector<boost::string_ref> build_valid_keys (const char* index_name, const std::vector<short>& ok_segs) {
	const virtualindex_names_container& keys_data = VirtualIndexesCache::instance ()->get_virtual_index_name_keys ();

	std::vector<boost::string_ref> valid_keys;

	std::map<boost::string_ref, key_syns>::const_iterator synindex_it = keys_data.find (index_name);
	std::set<boost::string_ref> folders;

	for (key_syns::const_iterator keys_it = synindex_it->second.begin (); keys_it != synindex_it->second.end (); keys_it++) {
		bool b_keyisvalid = false;
		for (vector_of_syns::const_iterator syns_it = keys_it->second.begin (); syns_it != keys_it->second.end () && !b_keyisvalid; syns_it++) {
			const std::vector<short>* segs = boost::get<2> (*syns_it);
			if (segs && GCL::has_intersection (ok_segs.begin (), ok_segs.end (), segs->begin (), segs->end ())) {
				b_keyisvalid = true;
			}
		}
		if (b_keyisvalid) {
			if (index_name [0] == '!') {
				add_valid_keys (valid_keys, folders, keys_it->first);
			}
			add_valid_key (valid_keys, keys_it->first);
		}
	}

	return valid_keys;
}

struct HashHelper {
	size_t operator () (const TreeNodeEx& node) const {
		std::size_t seed = 0;
		const char* first = node.name.data ();
		const char* last = first + node.name.size ();
		static const size_t step = 4;
		for(; first < last; first += step) {
			boost::hash_combine (seed, *first);
		}
		
		return seed;
	}

	bool operator () (const TreeNodeEx& lhs, const TreeNodeEx& rhs) const {
		return lhs.name == rhs.name;
	}
};

class TreeHelper {
private:
	typedef boost::unordered_set<TreeNodeEx, HashHelper, HashHelper> NodeSet;

public:
	TreeHelper (std::vector<TreeNode>& result) : m_last_found (m_node_set.end ()), m_result (result) {
		m_path.resize (MAX_TREE_LEVEL);
	}

	void add_node (const boost::string_ref& name) {
		size_t position = name.find_last_of ('\\');
		if (position != std::string::npos) {
			NodeSet::iterator it = this->get_node (boost::string_ref (name.data (), position));
			TreeNodeEx* parent = const_cast<TreeNodeEx*> (&*it);
			m_node_set.insert (TreeNodeEx (parent, name));
			size_t index = 0;
			for (TreeNodeEx* head = parent; head; head = head->parent) {
				m_path[index++] = head->position;
			}
			TreeNode* tree_node_parent = &m_result[m_path[--index]];
			while (index) {
				tree_node_parent = &tree_node_parent->children[m_path[--index]];
			}
			TreeNode node;
			node.name = boost::string_ref (name.data () + position + 1, name.size () - position - 1);
			tree_node_parent->children.push_back (node);
		} else {
			m_node_set.insert (TreeNodeEx (name, m_result.size ()));
			TreeNode node;
			node.name = name;
			m_result.push_back (node);
		}
	}

private:
	NodeSet::iterator get_node (const boost::string_ref& name) {
		if ((m_last_found == m_node_set.end ()) || (m_last_found->name != name)) {
			m_last_found = m_node_set.find (TreeNodeEx (name));
		}
		return m_last_found;
	}

	NodeSet m_node_set;
	NodeSet::iterator m_last_found;
	std::vector<TreeNode>& m_result;
	static const size_t MAX_TREE_LEVEL = 256;
	std::vector<size_t> m_path;
};

}

void SearchBase::get_tree (const char* index_name, const std::vector<short>& ok_segs, std::vector<TreeNode>& result) {
	const virtualindex_names_container& keys_data = VirtualIndexesCache::instance ()->get_virtual_index_name_keys ();

	std::map <boost::string_ref, key_syns>::const_iterator synindex_it = keys_data.find (index_name);

	if (synindex_it == keys_data.end () && strcmp (index_name, "Number"))
		return;	

	std::vector<boost::string_ref> valid_keys = build_valid_keys (index_name, ok_segs);
	TreeHelper tree_helper (result);
	for (std::vector<boost::string_ref>::iterator keys_it = valid_keys.begin (); keys_it != valid_keys.end (); ++keys_it) {
		tree_helper.add_node (*keys_it);
	}
}

struct gkdb_CorrRefSorter {
	bool operator () (const CorrRef& ref1, const CorrRef& ref2) const {
		return ref1.DocId == ref2.DocId ? ref1.RealPara < ref2.RealPara : ref1.DocId < ref2.DocId;
	}
};

struct gkdb_CorrRefUnique {
	bool operator () (const CorrRef& ref1, const CorrRef& ref2) const {
		return ref1.DocId == ref2.DocId && ref1.RealPara == ref2.RealPara;
	}
};

SortedCollection* SearchBase::get_newcorr_for (const SortedCollection *selection)
{
	SortedCollection *result = 0;
	if (selection && selection->Tag () == OT_REFCOLLECTION) {
		RefCollection* selected_blocks = (RefCollection*) selection;
		long id = (*selected_blocks) [0].DocId, i;
		std::deque<long> selection;
		for (i = 0; i < selected_blocks->ItemCount; i++)
			selection.push_back ((*selected_blocks) [i].Sub);
		std::deque<long>::const_iterator selection_it = selection.begin ();
		long sub = *selection_it;

		std::deque<CorrRef> maybe_corrs;

		static const int max_portion = sizeof (CorrRef) * 4096;
		CorrRef buffer [4096], *ptr;

		Stream *str = FindIndex ("NewCorr")->Open (&id);
		if (str) {
			long str_length = str->Length ();
			while (true) {
				long portion = std::min <long> (max_portion, str_length);
				if (portion == 0)
					break;
				portion = str->Read (buffer, portion);
				str_length -= portion;
				for (ptr = buffer, portion /= sizeof (CorrRef); portion; portion--, ptr++) {
					if (ptr->Sub < sub)
						continue;
					else if (ptr->Sub > sub) {
						while (ptr->Sub >= sub && selection_it != selection.end ()) {
							selection_it++;
							sub = *selection_it;
						}
						if (ptr->Sub > sub)
							break;
					}					
					maybe_corrs.push_back (*ptr);
				}
			}
			FindIndex ("NewCorr")->Close (str);

			std::sort (maybe_corrs.begin (), maybe_corrs.end (), gkdb_CorrRefSorter ());
			maybe_corrs.erase (std::unique (maybe_corrs.begin (), maybe_corrs.end (), gkdb_CorrRefUnique ()), maybe_corrs.end ());

			result = new CorrRefCollection;
			for (std::deque<CorrRef>::const_iterator corr_it = maybe_corrs.begin (); corr_it != maybe_corrs.end (); corr_it++) {
				CorrRef at_corr_it = *corr_it;
				result->Collection::Add (&at_corr_it);
			}
		}
	}

	return result;

}

SortedCollection* SearchBase::get_newcorr_for (const long id)
{
	SortedCollection *result = 0;

	Stream *str = FindIndex ("NewCorr")->Open (&id);
	if (str) {
		static const int max_portion = sizeof (CorrRef) * 4096;
		CorrRef buffer [4096], *ptr;

		std::deque<CorrRef> maybe_corrs;

		long str_length = str->Length ();
		while (true) {
			long portion = std::min <long> (max_portion, str_length);
			if (portion == 0)
				break;
			portion = str->Read (buffer, portion);
			str_length -= portion;
			for (ptr = buffer, portion /= sizeof (CorrRef); portion; portion--, ptr++) {
				maybe_corrs.push_back (*ptr);
			}
		}
		FindIndex ("NewCorr")->Close (str);

		std::sort (maybe_corrs.begin (), maybe_corrs.end (), gkdb_CorrRefSorter ());
		maybe_corrs.erase (std::unique (maybe_corrs.begin (), maybe_corrs.end (), gkdb_CorrRefUnique ()), maybe_corrs.end ());

		result = new CorrRefCollection;
		for (std::deque<CorrRef>::const_iterator corr_it = maybe_corrs.begin (); corr_it != maybe_corrs.end (); corr_it++) {
			CorrRef at_corr_it = *corr_it;
			result->Collection::Add (&at_corr_it);
		}
	}

	return result;
}

bool SearchBase::is_index_nonempty (const char* index_name, const std::vector<short> &ok_segs) {
	if (is_index_exist (index_name)) {
		const virtualindex_names_container& keys_data = VirtualIndexesCache::instance ()->get_virtual_index_name_keys ();

		std::map<boost::string_ref, key_syns>::const_iterator synindex_it = keys_data.find (index_name);

		if (synindex_it == keys_data.end ())
			return true;

		for (key_syns::const_iterator keys_it = synindex_it->second.begin (); keys_it != synindex_it->second.end (); keys_it++) {
			for (vector_of_syns::const_iterator syns_it = keys_it->second.begin (); syns_it != keys_it->second.end (); syns_it++) {
				const std::vector<short>* segs = boost::get<2> (*syns_it);
				if (segs && GCL::has_intersection (ok_segs.begin (), ok_segs.end (), segs->begin (), segs->end ())) {
					return true;
				}
			}
		}
	}
	
	return false;
}

std::string	SearchBase::rename_indexkey (const char* index_name, const char* key)
{
	load_indexes_changes ();
	std::string result (key);
	std::map<std::string, std::map<std::string, std::string> >::const_iterator map_it = map_index_oldkeynewkey.find (index_name);
	if (map_it != map_index_oldkeynewkey.end ()) {
		while (true) {
			std::map<std::string,std::string>::const_iterator key_it = map_it->second.find (result);
			if (key_it == map_it->second.end ())
				break;
			result = key_it->second;
		}
	}
	return result;
}

namespace {

void load_realindex (SearchBase* base, const char* index_name) {
	RWRITE_GUARD (readshortattributes_mutex) if (map_indexname_mapfullkey_hindexkey.find (index_name) == map_indexname_mapfullkey_hindexkey.end ()) {
		Index *index = base->FindIndex (index_name);
		long b_plus4 = !strcmp (index_name, "KeyWord") ? 0 : 4;
		std::map<std::string,HIndex::HIndexKey*> map_fullkey_hindexkey;
		std::map<long,std::string> map_id_name;
		for (BTIterator btit (index); !btit.End (); ++btit) {
			HIndex::HIndexKey *key = (HIndex::HIndexKey*) btit.Key ();
			std::string name;
			if (key->level) {
				name = map_id_name.find (key->parent)->second;
				name += "\\";
				name += key->text + b_plus4;
				map_id_name.insert (std::map<long,std::string>::value_type (key->id, name));
			} else {
				name = key->text + b_plus4;
				map_id_name.insert (std::map<long,std::string>::value_type (key->id, name.c_str ()));
			}
			HIndex::HIndexKey *dup = (HIndex::HIndexKey*) malloc (index->KeyLength);
			memcpy (dup, key, index->KeyLength);
			map_fullkey_hindexkey.insert (std::map<std::string,HIndex::HIndexKey*>::value_type (name, dup));
		}
		map_indexname_mapfullkey_hindexkey.insert (std::map<std::string,std::map<std::string,HIndex::HIndexKey*> >::value_type (index_name, map_fullkey_hindexkey));
	}
}

}

bool	SearchBase::is_indexkey_exists (const char* index_name, const char* key, const std::vector<short> &ok_segs)
{
	bool b_result = false;

	if (is_index_exist (index_name)) {
		const virtualindex_names_container& keys_data = VirtualIndexesCache::instance ()->get_virtual_index_name_keys ();

		std::map<boost::string_ref, key_syns>::const_iterator synindex_it = keys_data.find (index_name);

		if (synindex_it == keys_data.end ()) {
			using namespace boost::assign;
			GCL::StrSet m_date_attr, m_int_attr, m_str_attr, m_morpho_attr;

			m_date_attr += "RDate", "Date", "AnnoDate", "Active", "RegDate", "AnnulDate", "CalAll", "CalIn", "CalAb", "CalCh", "SortDate";
			m_int_attr += "Segment", "Status", "Status_ex", "NewCorr";
			m_str_attr += "Category", "Number", "RCode", "IntName", "TradeName";
			m_morpho_attr += "MorphoText", "MorphoName";

			if (std::binary_search (m_str_attr.begin (), m_str_attr.end (), index_name)) {
				b_result = FindIndex (index_name)->IsExist (key);
			} else if (std::binary_search (m_int_attr.begin (), m_int_attr.end (), index_name)) {
				int val = boost::lexical_cast <int> (key);
				b_result = FindIndex (index_name)->IsExist (&val);
			} else if (std::binary_search (m_date_attr.begin (), m_date_attr.end (), index_name)) {
				b_result = true; //? или надо проверить наличие даты
			} else if (std::binary_search (m_morpho_attr.begin (), m_morpho_attr.end (), index_name)) {
				b_result = true;
			} else {
				load_realindex (this, index_name);
				std::map<std::string,std::map<std::string,HIndex::HIndexKey*> >::const_iterator map_it = map_indexname_mapfullkey_hindexkey.find (index_name);
				if (map_it != map_indexname_mapfullkey_hindexkey.end ())
					b_result = map_it->second.find (key) != map_it->second.end ();
			}
		} else {
			for (key_syns::const_iterator keys_it = synindex_it->second.begin (); keys_it != synindex_it->second.end () && !b_result; keys_it++) {
				if (keys_it->first == key) {
					bool b_syn_found = false;
					for (vector_of_syns::const_iterator syns_it = keys_it->second.begin (); syns_it != keys_it->second.end (); syns_it++) {
						b_syn_found = true;
						const std::string& syn_index = boost::get<0> (*syns_it).to_string ();
						if (syn_index[0] == '!') {
							const std::string& syn_key = boost::get<1> (*syns_it).to_string ();
							//это папка виртуального индекса, для нее перечисляется список детей
							if (is_indexkey_exists (syn_index.c_str (), syn_key.c_str (), ok_segs)) {
								b_result = true;
								break;
							}
						} else {
							const std::vector<short>* segs = boost::get<2> (*syns_it);
							if (segs && GCL::has_intersection (ok_segs.begin (), ok_segs.end (), segs->begin (), segs->end ())) {
								b_result = true;
								break;
							}
						}
					}
				}
			}
		}
	}
	
	return b_result;
}

bool SearchBase::is_index_exist (const char* index_name) {
	if (index_name) {
		if (index_name [0] == '!') {
			const virtualindex_names_container& keys_data = VirtualIndexesCache::instance ()->get_virtual_index_name_keys ();
			return keys_data.find (index_name) != keys_data.end ();
		} else {
			using namespace boost::assign;
			GCL::StrSet known_indexes;

			known_indexes += "Attrs", "Aux", "Adopted", "PhGroup", "PhEffect", "Mkb", "Chapter", "Territory", "ServiceInfo", "Atc", "RegStatus";
			known_indexes += "LekForm", "PhFirm", "PhCountry", "Type", "Kind", "RegDate", "AnnulDate", "Active", "Date", "Number", "Status";
			known_indexes += "Status_ex", "KeyWord", "RCode", "Respondent", "Correspondent", "RDate", "VIncluded", "VChanged", "VAbolished";
			known_indexes += "Class", "DocKind", "SubName", "SortDate", "VAnonced", "VLControl", "Category", "TradeName", "IntName";
			known_indexes += "PublishedIn", "Segment", "Blob", "Control", "Class6", "NewCorr", "Attribs", "AnnoUser", "AnnoOrganization";
			known_indexes += "AnnoTax", "AnnoInterest", "AnnoKind", "AnnoDate", "KindCorr", "CalAb", "CalIn", "CalCh";
			known_indexes += "MorphoName", "MorphoText";

			return known_indexes.find (index_name) != known_indexes.end ();
		}
	} else {
		return false;
	}
}

long	SearchBase::get_filterjson_forkind (const char* kind)
{
	long result = ID_DEFAULT_FILTER;
	Stream* str = FindIndex ("Aux")->Open (AUX_FILTER_JSONS);
	if (str) {
		long size = str->Length ();
		char* data = new char [size], *ptr = data;
		str->Read (data, size);
		FindIndex ("Aux")->Close (str);
		while (ptr - data < size) {
			GCL::StrVector parts;
			boost::split (parts, ptr, boost::is_any_of ("="));
			if (parts.size () == 2 && !strcmp (parts.at (0).c_str (), kind)) {
				result = atol (parts.at (1).c_str ());
				break;
			}
			ptr += strlen (ptr) + 1;
		}
		delete []data;
	}
	return result;
}

bool SearchBase::get_changing_documents_list (long id, std::vector <std::pair <std::string, long> > &result)
{
	long size = 0;
	char* data = (char*) LoadAttr (id, IDD_CHDATE_EXEX, size);
	if (size) {
		GCL::StrVector parts;
		boost::split (parts, data, boost::is_any_of ("|"));
		gk_free (data);
		for (unsigned int i = 0; i < parts.size (); i += 2) {
			std::pair<std::string,long> apair (parts.at (i), atol (parts.at (i + 1).c_str ()));
			result.push_back (apair);
		}
	}
	return size;
}

bool SearchBase::get_changing_documents_list (long id, std::vector <std::pair <std::string, Ref> > &result)
{
	long size = 0;
	char* data = (char*) LoadAttr (id, IDD_CHDATE_EXEX, size);
	if (size) {
		GCL::StrVector parts;
		boost::split (parts, data, boost::is_any_of ("|"));
		gk_free (data);
		for (unsigned int i = 0; i < parts.size (); i += 2) {
			const char* at_i = parts.at (i+1).c_str ();
			Ref ref = {atol (at_i), 0};
			if (strchr (at_i, '.'))
				ref.Sub = atol (strchr (at_i, '.') + 1);
			std::pair<std::string,Ref> apair (parts.at (i), ref);
			result.push_back (apair);
		}
	}
	return size;
}

bool SearchBase::can_view_document (long id, const std::vector<short> &forbidden_blocks)
{
	std::set<short> ok_segs;
	get_ok_segs (forbidden_blocks, ok_segs);

	bool result = false;
	long size;
	short *data = (short*) LoadAttr (id, IDD_BASES, size), *ptr = data;
	if (size) {
		for (int i = 0; i < size / 2 && !result; i++, ptr++)
			result = ok_segs.find (*ptr) != ok_segs.end ();
		gk_free (data);
	}
	return result;
}

std::vector<AnalysisNode> SearchBase::get_data_for_list ()
{
	std::vector<AnalysisNode> result, leafs;

	Stream* str = FindIndex ("Aux")->Open (AUX_LIST_KINDS);
	if (!str)
		return result;

	long size = str->Length ();
	boost::scoped_array<char> data (new char [size]);
	char *ptr = data.get ();
	std::vector<std::string> kinds;
	str->Read (data.get (), str->Length ());
	FindIndex ("Aux")->Close (str);
	while (ptr - data.get () < size) {
		kinds.push_back (ptr);
		ptr += strlen (ptr) + 1;
	}

	load_kind_ids ();

	std::map<std::string,std::vector<std::string> > map_folder_lists;
	std::map<std::string,AnalysisNode> map_name_node;

	for (std::vector<std::string>::const_iterator kind_it = kinds.begin (); kind_it != kinds.end (); kind_it++) {
		std::string kind = *kind_it;

		std::vector<std::string> parts;
		boost::split (parts, kind, boost::is_any_of ("\\"));
		if (parts.size () == 2) {
			std::map<std::string,std::vector<std::string> >::iterator it = map_folder_lists.find (parts.at (0));
			if (it == map_folder_lists.end ()) {
				AnalysisNode folder;
				folder.name = parts.at (0);
				folder.mask = kind_uid_to_bit (map_kind_strwoprefix_id.find (folder.name)->second);
				result.push_back (folder);

				std::vector<std::string> begin;
				begin.push_back (kind);
				map_folder_lists.insert (std::map<std::string,std::vector<std::string> >::value_type (parts.at (0), begin));
			} else {
				it->second.push_back (kind);
			}
			AnalysisNode leaf;
			leaf.name = parts.at (1);
			leaf.mask = kind_uid_to_bit (map_kind_strwoprefix_id.find (kind)->second);
			map_name_node.insert (std::map<std::string,AnalysisNode>::value_type (kind, leaf));
		} else {
			map_folder_lists.insert (std::map<std::string,std::vector<std::string> >::value_type (kind, std::vector<std::string>()));
			AnalysisNode folder;
			folder.name = kind;
			folder.mask = kind_uid_to_bit (map_kind_strwoprefix_id.find (folder.name)->second);
			result.push_back (folder);
		}
	}

	for (std::vector<AnalysisNode>::iterator folder_it = result.begin (); folder_it != result.end (); folder_it++) {
		std::string folder_name = folder_it->name;
		std::map<std::string,std::vector<std::string> >::const_iterator leaf_it = map_folder_lists.find (folder_name);
		if (leaf_it != map_folder_lists.end ()) {
			for (std::vector<std::string>::const_iterator it = leaf_it->second.begin (); it != leaf_it->second.end (); it++)
				folder_it->children.push_back (map_name_node.find (it->c_str ())->second);
		}
	}

	return result;
}

SortedCollection* SearchBase::get_complexindex_data (const char* index_name, const char* key) {
	SortedCollection *result = 0;

	std::vector<std::string> pairofs;
	boost::split (pairofs, key, boost::is_any_of (":"));
	std::string index_part = pairofs.at (0);
	std::string key_part;

	if (pairofs.size () == 2) {
		key_part = pairofs[1];
	} else {
		for (unsigned int i = 1; i < pairofs.size (); i++) {
			if (key_part.size ())
				key_part += ":";
			key_part += pairofs.at (i);
		}
	}

	result = get_virtualindex_data (index_part.c_str (), key_part.c_str ());

	return result;
}

namespace {

SortedCollection* get_realindex_data (SearchBase* base, boost::string_ref index_name_ref, boost::string_ref key_ref) {
	const std::string& index_name = index_name_ref.to_string ();
	const std::string& key = key_ref.to_string ();
	Index *index = base->FindIndex (index_name.c_str ());
	SortedCollection *result;
	if (GetDataType (index) == SDT_REFS)
		result = new RefCollection ();
	else if (GetDataType (index) == SDT_REFWEIGHTS)
		result = new RefwWeightCollection ();
	else
		result = new DocCollection ();

	bool b_hindex = (index_name == "Kind") || (index_name == "Type") || (index_name == "Adopted") || (index_name == "KeyWord") || (index_name == "Territory") || (index_name == "Class") || (index_name == "ServiceInfo") || (index_name == "Atc") || (index_name == "RegStatus") || (index_name == "LekForm") || (index_name == "PhFirm") || (index_name == "PhCountry") || (index_name == "PhGroup") || (index_name == "PhEffect") || (index_name == "Mkb") || (index_name == "Chapter");
	if (b_hindex) {
		load_realindex (base, index_name.c_str ());
		std::map<std::string,std::map<std::string,HIndex::HIndexKey*> >::const_iterator map_it = map_indexname_mapfullkey_hindexkey.find (index_name);
		if (map_it != map_indexname_mapfullkey_hindexkey.end ()) {
			std::map<std::string,HIndex::HIndexKey*>::const_iterator key_it = map_it->second.find (key);
			if (key_it != map_it->second.end ()) {
				Stream *str = index->Index::OpenN (key_it->second, 0);
				if (str) {
					result->Get (str);
					index->Close (str);
				}
			}
		}
	} else if ((index_name == "Status") || (index_name == "Segment") || (index_name == "Status_ex")) {
		u_int16_t short_key = (u_int16_t) (atol (key.c_str ()) & 0xFFFF);
		Stream *str = index->Open (&short_key);
		if (str) {
			result->Get (str);
			index->Close (str);
		}
	} else if (index_name == "Tag") {
		char *charkey = (char*) key.c_str ();
		Stream *str = index->Open (charkey);
		if (str) {
			result->Get (str);
			index->Close (str);
		}
	}

	if (!result)
		result = new DocCollection ();

	return result;
}

}

SortedCollection* SearchBase::get_virtualindex_data (const char* index_name, const char* key) {
	SortedCollection *result = 0;

	const virtualindex_names_container& keys_data = VirtualIndexesCache::instance ()->get_virtual_index_name_keys ();

	virtualindex_names_container::const_iterator synindex_it = keys_data.find (index_name);

	if (synindex_it != keys_data.end ()) {
		for (key_syns::const_iterator keys_it = synindex_it->second.begin (); keys_it != synindex_it->second.end (); keys_it++) {
			if (keys_it->first == key) {
				vector_of_syns::const_iterator syns_it = keys_it->second.begin ();
				vector_of_syns::const_iterator syns_end = keys_it->second.end ();
				if (boost::get<0> (*syns_it)[0] == '!') {
					//папка виртуального индекса
					for (; syns_it != syns_end; ++syns_it) {
						const std::string& key_string = boost::get<1> (*syns_it).to_string ();
						SortedCollection *part = get_virtualindex_data (index_name, key_string.c_str ());
						if (result) {
							result->Merge (*part);
							delete part;
						} else {
							result = part;
						}
					}
				} else {
					long data_type = SDT_DOCS;
					for (; syns_it != syns_end && data_type == SDT_DOCS; ++syns_it) {
						data_type = GetDataType (boost::get<0> (*syns_it).to_string ().c_str ());
					}

					for (syns_it = keys_it->second.begin (); syns_it != syns_end; syns_it++) {
						SortedCollection *part = get_realindex_data (this, boost::get<0> (*syns_it), boost::get<1> (*syns_it));
						if (result == 0 && GetDataType (boost::get<0> (*syns_it).to_string ().c_str ()) == data_type)
							result = part;
						else {
							if (0 == result) if (data_type == SDT_DOCS) result = new DocCollection (); else result = new RefCollection ();
							result->Merge (*part);
							delete part;
						}
					}
				}
				break;
			}
		}
	}

	if (!result)
		result = new DocCollection ();

	return result;
}

SortedCollection*	SearchBase::get_realindex_doc (const std::string& index_name, const std::string& value, long doc_id)
{
	Core::Aptr <SortedCollection> ret = new RefCollection;
	Ref ref = {doc_id, 0};

	if (index_name == "SortDate") {
		ret->Insert (&ref);
	} else if (index_name == "Status") {
		DocInfo docinfo;
		if ((FindDocInfo (doc_id, docinfo) == sizeof (DocInfo)) && (docinfo.Status & atol (value.c_str ()))) {
			ret->Insert (&ref);
		}
	} else if (index_name == "Status_ex") {
		DocInfo docinfo;
		if (FindDocInfo (doc_id, docinfo) == sizeof (DocInfo)) {
			short short_value = (short) (atol (value.c_str ()) & 0xFFFF);
			bool b_issub = short_value == DS_ALLOWED || short_value == DS_NOTALLOWED || short_value == DS_LIFE || short_value == DS_NOTLIFE || short_value == DS_RECIPE || short_value == DS_UNRECIPE;
			if (b_issub) {
				long size = 0, idd_tag = 0;
				switch (short_value) {
					case DS_ALLOWED:
						idd_tag = IDD_ALLOWED;
						break;
					case DS_NOTALLOWED:
						idd_tag = IDD_NOTALLOWED;
						break;
					case DS_LIFE:
						idd_tag = IDD_LIFE;
						break;
					case DS_NOTLIFE:
						idd_tag = IDD_NOTLIFE;
						break;
					case DS_RECIPE:
						idd_tag = IDD_RECIPE;
						break;
					case DS_UNRECIPE:
						idd_tag = IDD_UNRECIPE;
						break;
				}
				if (idd_tag) {
					char *data = (char*) LoadAttr (doc_id, idd_tag, size), *ptr = data;
					while (ptr - data < size) {
						ref.Sub = *(long*) ptr;
						ret->Insert (&ref);
						ptr += sizeof (long);
					}
					gk_free (data);
				}
			} else {
				if (docinfo.Status_ex & short_value) {
					ret->Insert (&ref);
				}
			}
		}
	} else {
		bool b_hindex = index_name == "Kind" || index_name == "Class" || index_name == "KeyWord" || index_name == "PublishedIn" || index_name == "Type" || index_name == "Adopted" || index_name == "Territory" || index_name == "ServiceInfo" || index_name == "Atc" || index_name == "RegStatus" || index_name == "LekForm" || index_name == "PhFirm" || index_name == "PhCountry" || index_name == "PhGroup" || index_name == "PhEffect" || index_name == "Mkb" || index_name == "Chapter";
		bool b_strindex = !b_hindex && (index_name == "Category" || index_name == "Number" || index_name == "RCode");
		bool b_dateindex = !b_hindex && !b_strindex && (index_name == "Date" || index_name == "AnnoDate" || index_name == "RDate" || index_name == "CalIn" || index_name == "CalAb" || index_name == "CalCh" || index_name == "RegDate" || index_name == "AnnulDate");
		bool b_shortindex = !b_hindex && !b_strindex && !b_dateindex && index_name == "Segment";

		bool b_issub = index_name == "Kind" || index_name == "Class" || index_name == "KeyWord" || index_name == "Type" || index_name == "ServiceInfo";
		bool b_sortprefix = b_hindex && (index_name != "KeyWord");
		long size = 0, idd_tag = index_name == "Kind" ? IDD_KIND : (index_name == "Class" ? IDD_DIV : (index_name == "KeyWord" ? IDD_KEY : (index_name == "PublishedIn" ? IDD_PUBLISHEDIN : (index_name == "Type" ? IDD_TYPE : (index_name == "Adopted" ? IDD_SOURCE : (index_name == "Category" ? IDD_CATEGORY : (index_name == "Territory" ? IDD_TERRITORY : (index_name == "Date" ? IDD_DATE : (index_name == "Number" ? IDD_ID : (index_name == "RCode" ? IDD_RCODE : (index_name == "Date" ? IDD_DATE : (index_name == "RDate" ? IDD_RDATE : (index_name == "CalIn" ? IDD_CALIN : (index_name == "CalAb" ? IDD_CALAB : (index_name == "CalCh" ? IDD_CALCH : (index_name == "Segment" ? IDD_BASES : 0 ))))))))))))))));
		GDS_ASSERT (idd_tag);

		char *data = (char*) LoadAttr (doc_id, idd_tag, size), *ptr = data;
		if (size) {
			if (b_hindex || b_strindex) {
				std::set<long> blocks, inherited_blocks, sum;
				while (ptr - data < size) {
					char *key = ptr;
					if (b_issub) key = strchr (key, ':') + 1;

					std::string idd_key;
					if (b_hindex) {
						std::vector<std::string> parts;
						boost::split (parts, key, boost::is_any_of ("\\"));
						for (std::vector<std::string>::const_iterator it = parts.begin (); it != parts.end (); it++) {
							if (idd_key.size ())
								idd_key += "\\";
							idd_key += it->c_str () + (b_sortprefix ? 4 : 0);
						}
					} else {
						idd_key = key;
					}

					if (strstr (idd_key.c_str (), value.c_str ()) == idd_key.c_str ()) {
						if (b_issub) {
							ref.Sub = atol (ptr);
							if (ref.Sub & INHERITED_BLOCK)
								inherited_blocks.insert (ref.Sub & MINUS_INHERITED_BLOCK);
							else
								blocks.insert (ref.Sub);
						} else {
							blocks.insert (0);
							break;
						}
					}

					ptr += strlen (ptr) + 1;
				}
				sum.insert (blocks.begin (), blocks.end ());
				sum.insert (inherited_blocks.begin (), inherited_blocks.end ());
				for (std::set<long>::const_iterator it = sum.begin (); it != sum.end (); it++) {
					ref.Sub = *it;
					if (blocks.find (ref.Sub) != blocks.end ())
						ret->Collection::Add (&ref);
					if (inherited_blocks.find (ref.Sub) != inherited_blocks.end ()) {
						ref.Sub |= INHERITED_BLOCK;
						ret->Collection::Add (&ref);
					}
				}
			} else if (b_dateindex) {
				b_issub = index_name == "AnnulDate" || index_name == "RegDate";
				std::vector <std::string> parts;
				boost::split (parts, value, boost::is_any_of (";"));

				Core::Aptr <char, Core::ArrayDeleteDestructor <char> > from, to;

				if (parts.size () == 2) {
					from = SearchHelper::make_date_key (parts [0]);
					to = SearchHelper::make_date_key (parts [1]);
				}
				char *ptr = data, *fromin = from.in (), *toin = to.in ();
				if (size) {
					while (ptr - data < size) {
						if (b_issub) {
							ref.Sub = *(long*) ptr;
							ptr += sizeof (long);
						}
						bool b_add = false;
						if (toin) {
							if (fromin) {
								if (CompDates ((date*)ptr, (date*)toin) <= 0 && CompDates ((date*)ptr, (date*)fromin) >= 0)
									b_add = true;
							} else {
								if (CompDates ((date*)ptr, (date*)toin) <= 0)
									b_add = true;
							}
						} else {
							if (CompDates ((date*)fromin, (date*)ptr) <= 0)
								b_add = true;
						}
						if (b_add) {
							ret->Insert (&ref);
						}
						ptr += sizeof (date);
					}
				}
			} else if (b_shortindex) {
				short *ptr = (short*) data;
				if (size) {
					while ((char*)ptr - data < size) {
						if (*ptr == atol (value.c_str ()))
							ret->Insert (&ref);
						ptr++;
					}
				}
			}
			gk_free (data);
		}
	}

	return ret._retn ();
}

SortedCollection* SearchBase::get_virtualindex_doc (const char* index_name, const char* key, long doc_id) {
	SortedCollection *result = new RefCollection ();

	const virtualindex_names_container& keys_data = VirtualIndexesCache::instance ()->get_virtual_index_name_keys ();

	virtualindex_names_container::const_iterator synindex_it = keys_data.find (index_name);

	if (synindex_it != keys_data.end ()) {
		for (key_syns::const_iterator keys_it = synindex_it->second.begin (); keys_it != synindex_it->second.end (); keys_it++) {
			if (keys_it->first == key) {
				vector_of_syns::const_iterator syns_it = keys_it->second.begin ();
				vector_of_syns::const_iterator syns_end = keys_it->second.end ();
				if (boost::get<0> (*syns_it)[0] == '!') {
					//папка виртуального индекса
					for (; syns_it != syns_end; syns_it++) {
						const std::string& key_string = boost::get<1> (*syns_it).to_string ();
						std::auto_ptr<SortedCollection> part (get_virtualindex_doc (index_name, key_string.c_str (), doc_id));
						result->Merge (*part);
					}
				} else {
					for (; syns_it != syns_end; ++syns_it) {
						const std::string& index_string = boost::get<0> (*syns_it).to_string ();
						const std::string& key_string = boost::get<1> (*syns_it).to_string ();
						std::auto_ptr<SortedCollection> part (get_realindex_doc (index_string.c_str (), key_string.c_str (), doc_id));
						result->Merge (*part);
					}
				}
				break;
			}
		}
	}

	return result;
}


static inline bool is_good_resp_ref (
	const RespRef* refs_ptr
	, long previus_para_id
	, long corr_doc
	, const std::vector<long>& subs_in_corr_doc
) {
	if (refs_ptr->DocId != corr_doc) {
		return false;
	}

	if (previus_para_id == refs_ptr->ParaId) {
		return false;
	}

	if (subs_in_corr_doc.empty ()) {
		return true;
	}

	return std::find (subs_in_corr_doc.begin (), subs_in_corr_doc.end (), refs_ptr->Sub) != subs_in_corr_doc.end ();
}

std::vector<long>	SearchBase::get_corrs_for_doc_and_subs (long corr_doc, long for_doc, const std::vector<long>& subs_in_corr_doc) {
	std::vector<long> result;
	IndexLoader loader (this);
	long size;
	INDEX_DATA (RespRef) refs = loader.load <RespRef> (for_doc, IDD_REFS, size, true);
	if (refs.ptr ()) {
		RespRef* refs_ptr = refs.ptr ();
		long previus_para_id = 0;
		for (int ref = 0; ref < size; ref++, refs_ptr++ ) {
			if (is_good_resp_ref (refs_ptr, previus_para_id, corr_doc, subs_in_corr_doc)) {
				result.push_back (refs_ptr->ParaId);
				previus_para_id = refs_ptr->ParaId;
			}
		}
	}

	return result;
}

void	SearchBase::get_ok_docs (const std::vector<short> &forbidden_blocks, std::deque<long> &ok_docs)
{
	std::set<short> ok_segs;
	get_ok_segs (forbidden_blocks, ok_segs);
	
	Index *segments = FindIndex ("Segment");
	for (std::set<short>::const_iterator it = ok_segs.begin (); it != ok_segs.end (); it++) {
		short seg = *it;
		Stream *str = segments->Open (&seg);
		if (str) {
			long size = str->Length (), *data = new long [size], *ptr = data;
			str->Read (data, size);
			segments->Close (str);
			for (unsigned long docs = 0; docs < size / sizeof (long); docs++, ptr++)
				ok_docs.push_back (*ptr);
			delete []data;
		}
	}

	std::sort (ok_docs.begin (), ok_docs.end ());
	ok_docs.erase (std::unique (ok_docs.begin (), ok_docs.end ()), ok_docs.end ());
}

bool SearchBase::is_valid_query (const QueryData& query_data)
{
	bool b_result = true;
	const std::vector <short>& here_segs = BaseCache::instance ()->get_here_seg (this);

	for (QueryData::const_iterator qd_it = query_data.begin (); qd_it != query_data.end () && b_result; qd_it++) {
		for (KeyNames::const_iterator key_it = qd_it->second.begin (); key_it != qd_it->second.end () && b_result; key_it++) {
			b_result = is_indexkey_exists (qd_it->first.c_str (), key_it->c_str (), here_segs);
		}
	}
	return b_result;
}

std::vector<long> SearchBase::get_main_page_list ()
{
	std::vector<long> result;
	Stream *str = FindIndex ("Aux")->Open (AUX_MAIN_PAGES);
	if (str) {
		long id;
		while (str->Read (&id, sizeof (id)) == sizeof (id))
			result.push_back (id);
		FindIndex ("Aux")->Close (str);
	}
	return result;
}

bool SearchBase::FillSmallInfoDoc (long id, std::string& name, std::vector <std::string>& segment_names, bool is_russian) {
	if (id > BIG_INFO_COUNT * BIG_INFO_STEP) //документы с номерами более 100млн - отлуп
		return false;

	char *pFndPara, *pPara = 0, *pTmpTxt;
	std::auto_ptr<Document> document (find_gl_topic (id, pPara));

	if (!document.get () || pPara == 0) {
		return false;
	}

	long mid = ParaSize (pPara);
	pFndPara = ParaText (pPara);
	pPara = (char*)memchr (pFndPara, BIG_INFO_DELIMITER, (int)mid);


	if (pPara == 0 || (pTmpTxt = (char*)memchr (pPara + 1, BIG_INFO_DELIMITER, mid)) == 0) {
		return false;
	}

	*pTmpTxt = 0;
	name = std::string (pPara + 1);

	std::vector<std::string> parts;
	boost::split (parts, ++pTmpTxt, boost::is_from_range (BIG_INFO_DELIMITER, BIG_INFO_DELIMITER));
	const BaseInfo_& baseinfos = BaseCache::instance ()->get_base_info (this);
	for (std::vector<std::string>::const_iterator it = parts.begin (); it != parts.end (); it++) {
		if (it->size ()) {
			BaseInfo_::const_iterator map_it = baseinfos.find (atol (it->c_str ()));
			if (map_it != baseinfos.end ()) {
				segment_names.push_back (is_russian ? map_it->second.first : map_it->second.second);
			}
		}
	}
	return true;
}

Document*	SearchBase::find_gl_topic (long id, char* &pPara)
{
	Document *pDoc = 0;

	if (id > BIG_INFO_COUNT * BIG_INFO_STEP)
		return pDoc;

	long gl_doc = (( id - ID_BORDER ) / BIG_INFO_STEP) + BIG_INFO_DOC;
	if (!FindDoc (gl_doc))
		return pDoc;

	pDoc = GetDoc (gl_doc);
	long	lo = 0, mid, num = pDoc->Stat.ParaCount, hi = num - 1, lstId, half;
	do {
		if (half = num / 2) {
			mid = lo + (num & 1 ? half : (half - 1));
			if ((lstId = atol (ParaText (pPara = pDoc->GetPara (mid)))) == id)
				break;

			if (id < lstId) {
				hi = mid - 1;
				num = num & 1 ? half : half - 1;
			} else {
				lo = mid + 1;
				num = half;
			}
		} else if (num) {
			if (atol (ParaText (pPara = pDoc->GetPara (lo))) != id)
				pPara = 0;

			break;
		} else {
			pPara = 0;
			break;
		}
		pPara = 0;
	} while (lo <= hi);

	return pDoc;	
}

bool	SearchBase::is_doc_in_super (long id)
{
	char *pPara = 0;
	Document *pDoc = find_gl_topic (id, pPara);
	if (pDoc)
		delete pDoc;

	return (pPara == 0) ? false : true;
}

