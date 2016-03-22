
#ifndef __SEARCH_BASE_H
#define __SEARCH_BASE_H

#include <vector>

#include "boost/utility/string_ref.hpp"
#include <boost/ptr_container/ptr_map.hpp>

#include "SortAttrCache.h"
#include "stdbase.h"

typedef std::map <std::string, std::string> StrStrMap;

struct AnalysisNode {
	std::string name;
	u_int64_t mask;
	std::vector<AnalysisNode> children;
};

struct SearchResult {
	SortedCollection* list;
	bool list_is_cut;
	long fulllist_itemcount;
	bool search_interrupted;
};

typedef std::vector <std::string> KeyNames;
typedef std::map <std::string, KeyNames> QueryData;

struct TreeNode {
	boost::string_ref name;
	std::vector <TreeNode> children;
};

struct WordsParas {
	std::vector <long> paras;
	std::vector <long> words;
};

///////////////////////////////////////////////////////////////////////////////////////

class SearchBase : public YBase {
public:
	SearchBase (const char* name, int mode = ACE_OS_O_RDONLY);

	virtual ~SearchBase ();

public:
	virtual bool check_version ();

	virtual Index* FindIndex (const char*);

	virtual int IsOk () {
		return Base::IsOk ();
	}

public:
	SearchResult* Search (
		int ReqCount
		, IndexReq* req []
		, SortedCollection* list = 0
		, short initOp = SO_AND
		, short bInpharm = 0
		, short removeEditions = 1
		, short removeWoAnnos = 0
		, bool show_short_list = false
		, bool b_use_extended_search = true
	);

	RefwReleCollection* context_search (
		int req_count
		, IndexReq** req
		, SortedCollection* col
		, short bInpharm
		, short removeEditions
	);

	SearchResult* execute_search (std::vector<std::string> &strings);
	SearchResult* execute_search_from (long doc_id, long block);

	// найти параграф документа, в котором начинается данное слово
	long find_paras_with_word (long doc_id, long word);
	long get_para_by_word (long doc_id, long word, bool need_para_id);
	void get_para_pair (long doc_id, long word, long& para, long& pos);
	WordsParas* get_paras_and_words (long id, const std::vector <unsigned long>& words);

	void load_relevancy_changes (DBCore::RelevancyTuneData& out);

	RefwReleCollection*	found_samedocs (long);

	bool is_morpho_exist ();
	bool get_external_link (long link_type, Ref ref, std::string &result);
	bool is_doc_changed (long);

	void check_mistakes (const char*, StrStrMap&);
	void correct_mistakes (const char*, std::string&, GCL::StrVector&, bool b_inpharm = false, char delimiter = ';');
	void correct_mistakes (const GCL::StrVector &in, GCL::StrVector& out, GCL::StrVector& cant, bool b_inpharm = false);

	GCL::StrSet* get_incorrect_words (const char* req);

	long find_block_with_word (long, long);
	long find_block_with_para (long doc_id, long para);
	long find_block_with_uniquepara (long doc_id, long para);

	unsigned long anno_key_to_id (const char* key);
	unsigned long anno_short_key_to_id (const char* key);
	const char* anno_id_to_text (unsigned long id);

	long kind_keywoprefix_to_uid (const char* key);
	long kind_key_to_uid (const char* key);
	long kind_key_to_uid (HIndex::HIndexKey* key);
	const char* kind_uid_to_text (long id);
	const char* kind_uid_to_text_woprefix (long id);

	long kind_bit_to_uid (u_int64_t bit);
	u_int64_t kind_uid_to_bit (long uid);

	long bpkind_to_uid (const char* kind);
	void get_bpkinds (std::vector<std::string> &kinds);

	StrStrMap* typing_errors_ptr;
	GCL::StrSet* good_words_ptr;
	void load_typing_errors ();

	long get_hot_info_topic ();

	void get_section_name (const char* section, std::string &name);

private:
	Document* find_gl_topic (long id, char* &pFndPara);

public:
	bool is_doc_in_super (long id);
	bool FillSmallInfoDoc (long id, std::string& name, std::vector <std::string>& segment_names, bool is_russian);

protected:
	virtual	bool IsMultiThreadsR () {
		return false;
	}

private:
	int	AddKeyPatternList (IndexReq&, char*, SortedCollection& list);
	int	AddKeyList (Index*, IndexReq&, BTKEY, SortedCollection&);
	int	AddKeyListEx (Index*, IndexReq&, IndexRecordData *, SortedCollection&);

	int FindList (IndexReq&, SortedCollection&, short searchOp); // find data for all keys in list
	int	FindRange (Index*, IndexReq&, SortedCollection&); // find data for all keys between 2 items
	int	FindLE (Index*, IndexReq&, SortedCollection&); // find data for all keys <= key
	int	FindGE (Index*, IndexReq&, SortedCollection&); // find data for all keys >= key

	void load_anno_ids ();
	void load_kind_ids ();
	void load_kind_bits ();
	void load_kind_bp ();

	void check_base_for_language ();

	bool word_check_mistake (const char*, std::string&);
	void correct_single_word (const char* in, std::string& result, bool& b_wastransliteration, bool& b_onlylatin);

	void get_incorrect (const std::string& str, GCL::StrSet& words);
	bool is_present (const GCL::StrSet& keys);
	bool is_present (const std::string& word, bool is_wild);

private:
	Core::Mutex m_mutex;

	bool m_is_morpho_exist;
	long language_tag;

	typedef boost::ptr_map <long, YBase> BasePool;
	BasePool m_pool;

	std::map <long, std::string> map_anno_id_str;
	std::map <std::string, long> map_anno_str_id, map_anno_shortstr_id;
	std::map <long, std::string> map_kind_id_str;
	std::map <long, std::string> map_kind_id_str_woprefix;
	std::map <std::string, long> map_kind_str_id;
	std::map <std::string, long> map_kind_strwoprefix_id;
	std::map <long, u_int64_t> map_kind_uid_bit;
	std::map <u_int64_t, long> map_kind_bit_uid;
	std::map <std::string,long> map_bpkind_uid;
	std::vector <std::string> vector_bpkinds;

public:
	void get_filtered_tree (const char* aux_source, const char* index_name, std::vector<HIndex::HIndexKey*> &keys, std::vector<bool> &is_filtered);
	std::vector <AnalysisNode> get_data_for_analysis_tree ();
	std::vector <AnalysisNode> get_data_for_correspondent_tree (u_int64_t);
	std::vector <AnalysisNode> get_data_for_list ();

	void get_tree (const char* index_name, const std::vector<short> &ok_segs, std::vector<TreeNode>& result);
	SortedCollection* get_virtualindex_data (const char* index_name, const char* key);
	SortedCollection* get_complexindex_data (const char* index_name, const char* key);

	SortedCollection* get_virtualindex_doc (const char* index_name, const char* key, long doc_id);
	SortedCollection* get_realindex_doc (const std::string&, const std::string&, long);

	bool is_valid_query (const QueryData& query_data);
	bool is_index_exist (const char* index_name);
	bool is_index_nonempty (const char* index_name, const std::vector<short> &ok_segs);
	bool is_indexkey_exists (const char* index_name, const char* key, const std::vector<short> &ok_segs);
	std::string	rename_indexkey (const char* index_name, const char* key);

	long get_filterjson_forkind (const char* kind);

	bool can_view_document (long id, const std::vector<short> &forbidden_blocks);

	bool get_changing_documents_list (long id, std::vector <std::pair <std::string, long> > &result);
	bool get_changing_documents_list (long id, std::vector <std::pair <std::string, Ref> > &result);

	bool get_cr_mask_for_segments (long docid, u_int64_t& result_mask, const std::set<long> &blocks, const std::vector<short> &sorted_segments);
	void get_blocksandcrmasks_for_docandsegments (long docid, std::vector<long> &blocks, std::vector<u_int64_t> &masks, const std::vector<short> &sorted_segments);

	bool is_decisionsarchive_present ();
	bool is_encyclopedia_present (const std::vector<short> &ok_segs);

	SortedCollection* get_newcorr_for (const SortedCollection *selected_blocks);
	SortedCollection* get_newcorr_for (const long id);

	void load_indexes_changes ();

	std::vector<long> get_main_page_list ();
	std::vector<long> get_corrs_for_doc_and_subs (long corr_doc, long for_doc, const std::vector<long>& subs_in_corr_doc);

	void get_ok_segs (const std::vector<short> &forbidden_blocks, std::set<short> &ok_segs);
	void get_ok_docs (const std::vector<short> &forbidden_blocks, std::deque<long> &ok_docs);
};

///////////////////////////////////////////////////////////////////////////////////////

class ToolsBase : public SearchBase {
public:
	ToolsBase (const std::string& path) : SearchBase (path.c_str (), ACE_OS_O_RDONLY) {
		GDS_ASSERT (this->IsOk () && this->check_version ());
	}
};

///////////////////////////////////////////////////////////////////////////////////////

status_cache_box get_exist_statuscache ();
ca_cache_box get_exist_docinfocache ();

#endif

