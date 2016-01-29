#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>

#include "ace/OS.h"

#include "shared/ContextSearch/Common/Constants.h"
#include "garantCore/DBExt/Readers/StreamReader.h"
#include "garantCore/DBExt/Readers/PositionsReader.h"

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"
#include "recode.h"

#include "SplayMap.h"
#include "SplaySet.h"
#include "StorableSplaySet.h"
#include "u_int32_t.caddr_t.SplayMap.h"
#include "basemask.h"
#include "long.long.SplayMap.h"

#include <utility>
#include <math.h>

Base* aBase = 0;

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	return mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE * 2);
}

typedef std::deque<u_int64_t> lemmacounts_packed;
std::map<long,lemmacounts_packed> *doc_lemmas_counts_packed = new std::map<long,lemmacounts_packed>;
std::map<long,long> gd;
std::map< long,std::deque<long> > *map_docs_resps = new std::map< long,std::deque<long> >;
std::map< long,std::deque<u_int64_t> > *map_refs_resps = new std::map< long,std::deque<u_int64_t> >;
std::map<long, long> doc_words; //��������.������� � ��� ����
std::set<long> lemmas_to_skip; //��� ����� �� ����� ��������������� ��� ��������� �����
std::map<long, double> lemma_idf;
std::map<long,double> tfidf;
std::deque<std::string> lemmas;
long	W = 0;
std::set<long>	year_docs;

double	calculate_w_link (long doc_id_i, long doc_id_j)
{
	double w_link = 0.0;
	if (gd.find (doc_id_i) != gd.end ()) {
		long gdi = gd.find (doc_id_i)->second;
		if (gd.find (doc_id_j) != gd.end ()) {
			long gdj = gd.find (doc_id_j)->second;
			std::map< long,std::deque<long> >::const_iterator map_docs_resps_i, map_docs_resps_j;
			std::map< long,std::deque<u_int64_t> >::const_iterator map_refs_resps_i, map_refs_resps_j;

			map_docs_resps_i = map_docs_resps->find (doc_id_i);
			map_docs_resps_j = map_docs_resps->find (doc_id_j);
			map_refs_resps_i = map_refs_resps->find (doc_id_i);
			map_refs_resps_j = map_refs_resps->find (doc_id_j);

			//���� ���������� ����� ����� ������ � ���������� i � j
			std::deque<long>::const_iterator doc_resps_iter_i = map_docs_resps_i->second.begin(), doc_resps_iter_j = map_docs_resps_j->second.begin ();
			std::deque<long>::const_iterator doc_resps_last_i = map_docs_resps_i->second.end(),   doc_resps_last_j = map_docs_resps_j->second.end ();

			long c1ij = 0;
			while (doc_resps_iter_i != doc_resps_last_i && doc_resps_iter_j != doc_resps_last_j ) {
				if (*doc_resps_iter_i == *doc_resps_iter_j) {
					c1ij++;
					doc_resps_iter_i++;
					doc_resps_iter_j++;
				} else
				if (*doc_resps_iter_i < *doc_resps_iter_j)
					doc_resps_iter_i++;
				else
					doc_resps_iter_j++;
			}

			std::deque<u_int64_t>::const_iterator refs_resps_iter_i = map_refs_resps_i->second.begin(), refs_resps_iter_j = map_refs_resps_j->second.begin ();
			std::deque<u_int64_t>::const_iterator refs_resps_last_i = map_refs_resps_i->second.end(),   refs_resps_last_j = map_refs_resps_j->second.end ();

			long c2ij = 0;
			while (refs_resps_iter_i != refs_resps_last_i && refs_resps_iter_j != refs_resps_last_j ) {
				if (*refs_resps_iter_i == *refs_resps_iter_j) {
					c2ij++;
					refs_resps_iter_i++;
					refs_resps_iter_j++;
				} else
				if (*refs_resps_iter_i < *refs_resps_iter_j)
					refs_resps_iter_i++;
				else
					refs_resps_iter_j++;
			}

			w_link = (double) ((c1ij + 3*c2ij)) / (4*sqrt ((double) (gdi*gdj)));
		}
	}
	return w_link;
}

double	calculate_w_lem (long doc_id_i, long doc_id_j, long Wi)
{
	long Wj = doc_words.find (doc_id_j)->second;
	//printf ("\ncalulate w_lem for doc %ld (%ld words) and doc %ld (%ld words), tfidf_i: %f, tfidf_j: %f\n", doc_id_i, Wi, doc_id_j, Wj, tfidf.find (doc_id_i)->second, tfidf.find (doc_id_j)->second);

	//��������� ����� �����
	std::map<long, lemmacounts_packed>::const_iterator doc_i = doc_lemmas_counts_packed->find (doc_id_i);
	std::map<long, lemmacounts_packed>::const_iterator doc_j = doc_lemmas_counts_packed->find (doc_id_j);
	lemmacounts_packed::const_iterator lemmas_in_i = doc_i->second.begin (), lemmas_in_j = doc_j->second.begin ();
	std::deque<long> common_lemmas, common_lemmas_count;

	long lemma_i = (long)(*lemmas_in_i >> 32), lemma_j = (long)(*lemmas_in_j >> 32);
	lemmacounts_packed::const_iterator doc_i_end = doc_i->second.end ();
	lemmacounts_packed::const_iterator doc_j_end = doc_j->second.end ();

	double sum = 0.0;
	for (;;){
		if (lemma_i == lemma_j) {
			long Nwi = (long)(*lemmas_in_i & 0xffffffff);
			long Nwj = (long)(*lemmas_in_j & 0xffffffff);
			if (lemmas_to_skip.find (lemma_i) == lemmas_to_skip.end ()) {
				double tf_i = Nwi / (Nwi + 0.5 + 1.5 * (Wi / W));
				double tf_j = Nwj / (Nwj + 0.5 + 1.5 * (Wj / W));
				double idf = lemma_idf.find (lemma_i)->second;
				sum += (0.4+0.6*tf_i*idf)*(0.4+0.6*tf_j*idf);
				//printf ("lemma %s, sum now: %f\n", lemmas.at (lemma_i).c_str (), sum);
			}

			lemmas_in_i++;
			lemmas_in_j++;
			if (lemmas_in_i == doc_i_end || lemmas_in_j == doc_j_end)
				break;
			lemma_i = (long)(*lemmas_in_i >> 32);
			lemma_j = (long)(*lemmas_in_j >> 32);
		} else if (lemma_i < lemma_j) {
			lemmas_in_i++;
			if (lemmas_in_i == doc_i_end)
				break;
			lemma_i = (long)(*lemmas_in_i >> 32);
		} else {
			lemmas_in_j++;
			if (lemmas_in_j == doc_j_end)
				break;
			lemma_j = (long)(*lemmas_in_j >> 32);
		}
	}
	//printf ("final: w_lem = %f\n", sum / (tfidf.find (doc_id_i)->second * tfidf.find (doc_id_j)->second));
	return (sum / (tfidf.find (doc_id_i)->second * tfidf.find (doc_id_j)->second));
}

template <typename T>
class IndexDataLoader {
public:
	IndexDataLoader (const bool is_array = true) : m_is_array (is_array) {
	}

	T* load (YBase* base, const long doc_id, const int tag, long& count) {
		Core::Aptr <T> ret;
		count = 0;

		if (tag == IDD2_PARAIDS) {
			ret = (T*)base->LoadAttrEx (doc_id, tag, count);
		} else {
			ret = (T*)base->LoadAttr (doc_id, tag, count);
		}

		if (ret.ptr ()) {
			if (m_is_array) {
				count = count / sizeof (T);
			}
		} else {
			count = 0;
		}

		return ret._retn ();
	}
private:
	bool m_is_array;
};

#define	MAX_THREADS	16
typedef std::deque<long> docs_vector;

struct thread_data_struct {
	long from;
	long to;
	std::map<long, std::deque<DocRele> > samedocs_map;
	volatile int done;
};

thread_data_struct thread_data [MAX_THREADS], thread_data_2 [MAX_THREADS];

DocCollection *alldocs, *new_docs = 0, *old_docs = 0;
std::set<long> part_documents;
std::map<long,long> part_documents_from, part_documents_to;
long	C;

void	calculate_samedocs (int* thread_id)
{
	int this_thread_id = *thread_id;
	long calculated = 0, skipped = 0;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	long prev_percent = -1, pos = 0, max_C = thread_data_ptr->to - thread_data_ptr->from;
	for (int i = thread_data_ptr->from; i < thread_data_ptr->to; i++, pos++) {
		if ((pos * 100) / max_C != prev_percent) {
			prev_percent = (pos * 100) / max_C;
			printf ("%ld.%ld%% ", this_thread_id, prev_percent); fflush (stdout);
		}
		//printf ("\rcalc: %ld, skip: %ld ", calculated, skipped);
		long doc_id_i = (*alldocs)[i];

		if (doc_words.find (doc_id_i) == doc_words.end ())
			continue;

		if (year_docs.size () && year_docs.find (doc_id_i) == year_docs.end ()) {
			skipped++;
			continue;
		}

		//ACE_hrtime_t m_start_count = Core::GDS::HiResCounterSingl::instance()->get_count ();

		calculated++;

		long Wi = doc_words.find (doc_id_i)->second;

		std::set<short> cos_set;
		std::map<short, docs_vector> map_cos;

		for (int j = 0; j < C; j++ ) {
			long doc_id_j = (*alldocs)[j];
			
			if (doc_id_i == doc_id_j || doc_words.find (doc_id_j) == doc_words.end ())
				continue;

			double w_lem = calculate_w_lem (doc_id_i, doc_id_j, Wi);
			double w_link = calculate_w_link (doc_id_i, doc_id_j);
			double cos = ( w_lem + 0.3 * w_link ) / 1.3;

			short long_cos = (short)(cos * 10000);
			cos_set.insert (long_cos);
			std::map<short,docs_vector>::iterator map_cos_iter = map_cos.insert (std::map<short,docs_vector>::value_type (long_cos,docs_vector ())).first;
			map_cos_iter->second.push_back (doc_id_j);
		}

		std::deque<DocRele> same_docs;
		for (std::set<short>::reverse_iterator cos_set_it = cos_set.rbegin (); cos_set_it != cos_set.rend (); cos_set_it++) {
			short long_cos = *cos_set_it;
			if (long_cos < 2900 || same_docs.size () == 30)
				break;
			if (long_cos) {
				std::map<short,docs_vector>::iterator map_cos_iter = map_cos.find (long_cos);
				for (docs_vector::const_iterator docs_iter = map_cos_iter->second.begin (); docs_iter != map_cos_iter->second.end (); docs_iter++) {
					DocRele doc_rele = {*docs_iter, long_cos};
					same_docs.push_back (doc_rele);
					if (same_docs.size () == 30)
						break;
				}
			}
		}
		if (same_docs.size ())
			thread_data_ptr->samedocs_map.insert (std::map<long,std::deque<DocRele> >::value_type (doc_id_i, same_docs));

		/*
		unsigned sec;
		unsigned msec;
		unsigned usec;
		Core::GDS::HiResCounterSingl::instance()->tiks_to_time(Core::GDS::HiResCounterSingl::instance()->get_count () - m_start_count, sec, msec, usec);
		if (this_thread_id == 0)
			printf ("%ld.%ld.%ld ", sec, msec, usec);
		*/
	}
	thread_data_ptr->done = 1;
}

void	calculate_samedocs_new (int* thread_id)
{
	int this_thread_id = *thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	long prev_percent = -1, pos = 0, max_C = thread_data_ptr->to - thread_data_ptr->from;
	for (int i = thread_data_ptr->from; i < thread_data_ptr->to; i++, pos++) {
		if ((pos * 100) / max_C != prev_percent) {
			prev_percent = (pos * 100) / max_C;
			printf ("%ld.%ld%% ", this_thread_id, prev_percent); fflush (stdout);
		}
		long doc_id_i = (*new_docs)[i];

		if (doc_words.find (doc_id_i) == doc_words.end ())
			continue;

		long Wi = doc_words.find (doc_id_i)->second;

		std::set<short> cos_set;
		std::map<short, docs_vector> map_cos;

		for (int j = 0; j < C; j++ ) {
			long doc_id_j = (*alldocs)[j];

			if (doc_id_i == doc_id_j || doc_words.find (doc_id_j) == doc_words.end ())
				continue;

			double w_lem = calculate_w_lem (doc_id_i, doc_id_j, Wi);
			double w_link = calculate_w_link (doc_id_i, doc_id_j);
			double cos = ( w_lem + 0.3 * w_link ) / 1.3;

			short long_cos = (short)(cos * 10000);
			cos_set.insert (long_cos);
			std::map<short,docs_vector>::iterator map_cos_iter = map_cos.insert (std::map<short,docs_vector>::value_type (long_cos,docs_vector ())).first;
			map_cos_iter->second.push_back (doc_id_j);
		}

		std::deque<DocRele> same_docs;
		for (std::set<short>::reverse_iterator cos_set_it = cos_set.rbegin (); cos_set_it != cos_set.rend (); cos_set_it++) {
			short long_cos = *cos_set_it;
			if (long_cos < 2900/* || same_docs.size () == 30*/)
				break;
			if (long_cos) {
				std::map<short,docs_vector>::iterator map_cos_iter = map_cos.find (long_cos);
				for (docs_vector::const_iterator docs_iter = map_cos_iter->second.begin (); docs_iter != map_cos_iter->second.end (); docs_iter++) {
					DocRele doc_rele = {*docs_iter, long_cos};
					same_docs.push_back (doc_rele);
					/*
					if (same_docs.size () == 30)
						break;
					*/
				}
			}
		}
		if (same_docs.size ())
			thread_data_ptr->samedocs_map.insert (std::map<long,std::deque<DocRele> >::value_type (doc_id_i, same_docs));
	}
	thread_data_ptr->done = 1;
}

ACE_Recursive_Thread_Mutex new_doc_mutex;
long new_doc_it = 0;
long	get_new_doc (bool next)
{
	RWRITE_GUARD (new_doc_mutex) {
		if (new_doc_it == new_docs->ItemCount)
			return 0;
		long result = (*new_docs) [new_doc_it];
		if (next)
			new_doc_it++;
		return result;
	}
}

void	calculate_samedocs_new_78 (int* thread_id)
{
	int this_thread_id = *thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	long prev_percent = -1, pos = 0, max_C = thread_data_ptr->to - thread_data_ptr->from;
	for (;;) {
		long doc_id_i = get_new_doc (true);
		if (!doc_id_i) {
			printf ("thread %ld finished\n", this_thread_id); fflush (stdout);
			break;
		}

		if (doc_words.find (doc_id_i) == doc_words.end ())
			continue;

		long Wi = doc_words.find (doc_id_i)->second;

		std::set<short> cos_set;
		std::map<short, docs_vector> map_cos;

		for (int j = 0; j < C; j++ ) {
			long doc_id_j = (*alldocs)[j];

			if (doc_id_i == doc_id_j || doc_words.find (doc_id_j) == doc_words.end ())
				continue;

			double w_lem = calculate_w_lem (doc_id_i, doc_id_j, Wi);
			double w_link = calculate_w_link (doc_id_i, doc_id_j);
			double cos = ( w_lem + 0.3 * w_link ) / 1.3;

			short long_cos = (short)(cos * 10000);
			cos_set.insert (long_cos);
			std::map<short,docs_vector>::iterator map_cos_iter = map_cos.insert (std::map<short,docs_vector>::value_type (long_cos,docs_vector ())).first;
			map_cos_iter->second.push_back (doc_id_j);
		}

		std::deque<DocRele> same_docs;
		for (std::set<short>::reverse_iterator cos_set_it = cos_set.rbegin (); cos_set_it != cos_set.rend (); cos_set_it++) {
			short long_cos = *cos_set_it;
			if (long_cos < 2900/* || same_docs.size () == 30*/)
				break;
			if (long_cos) {
				std::map<short,docs_vector>::iterator map_cos_iter = map_cos.find (long_cos);
				for (docs_vector::const_iterator docs_iter = map_cos_iter->second.begin (); docs_iter != map_cos_iter->second.end (); docs_iter++) {
					DocRele doc_rele = {*docs_iter, long_cos};
					same_docs.push_back (doc_rele);
					/*
					if (same_docs.size () == 30)
						break;
					*/
				}
			}
		}
		if (same_docs.size ())
			thread_data_ptr->samedocs_map.insert (std::map<long,std::deque<DocRele> >::value_type (doc_id_i, same_docs));
	}
	thread_data_ptr->done = 1;
}


void	calculate_samedocs_old (int* thread_id)
{
	int this_thread_id = *thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data_2 [this_thread_id]);
	long prev_percent = 0, pos = 0, max_C = thread_data_ptr->to - thread_data_ptr->from;
	for (int i = thread_data_ptr->from; i < thread_data_ptr->to; i++, pos++) {
		if ((pos * 100) / max_C != prev_percent) {
			prev_percent = (pos * 100) / max_C;
			printf ("%ld.%ld%% ", this_thread_id, prev_percent); fflush (stdout);
		}
		long doc_id_i = (*old_docs)[i];

		if (doc_words.find (doc_id_i) == doc_words.end ())
			continue;

		long Wi = doc_words.find (doc_id_i)->second;

		std::set<short> cos_set;
		std::map<short, docs_vector> map_cos;

		for (int j = 0; j < new_docs->ItemCount; j++ ) {
			long doc_id_j = (*new_docs)[j];

			if (doc_id_i == doc_id_j || doc_words.find (doc_id_j) == doc_words.end ())
				continue;

			double w_lem = calculate_w_lem (doc_id_i, doc_id_j, Wi);
			double w_link = calculate_w_link (doc_id_i, doc_id_j);
			double cos = ( w_lem + 0.3 * w_link ) / 1.3;
			short long_cos = (short)(cos * 10000);
			cos_set.insert (long_cos);
			std::map<short,docs_vector>::iterator map_cos_iter = map_cos.insert (std::map<short,docs_vector>::value_type (long_cos,docs_vector ())).first;
			map_cos_iter->second.push_back (doc_id_j);
		}

		std::deque<DocRele> same_docs;
		for (std::set<short>::reverse_iterator cos_set_it = cos_set.rbegin (); cos_set_it != cos_set.rend (); cos_set_it++) {
			short long_cos = *cos_set_it;
			if (long_cos < 2900 || same_docs.size () == 30)
				break;
			if (long_cos) {
				std::map<short,docs_vector>::iterator map_cos_iter = map_cos.find (long_cos);
				for (docs_vector::const_iterator docs_iter = map_cos_iter->second.begin (); docs_iter != map_cos_iter->second.end (); docs_iter++) {
					DocRele doc_rele = {*docs_iter, long_cos};
					same_docs.push_back (doc_rele);
					if (same_docs.size () == 30)
						break;
				}
			}
		}
		if (same_docs.size ())
			thread_data_ptr->samedocs_map.insert (std::map<long,std::deque<DocRele> >::value_type (doc_id_i, same_docs));
		else {
			DocRele doc_rele = {0,0};
			same_docs.push_back (doc_rele);
			thread_data_ptr->samedocs_map.insert (std::map<long,std::deque<DocRele> >::value_type (doc_id_i, same_docs));
		}
	}
	thread_data_ptr->done = 1;
}

extern	void	BuildPatternM (ContextPattern&, char*);

char*	findkey_woprefix (Index* index, char* _key)
{
	char *key = strdup (_key), *token = strtok (key, "\\"), *result = (char*) malloc (1024);
	result [0] = 0;
	long par_id = 0, next_id;
	while (token) {
		bool found = false;
		for (BTIterator it(index); !it.End () && !found; ++it) {
			HIndex::HIndexKey* key = (HIndex::HIndexKey*) it.Key ();
			if (key->parent == par_id && !strcmp (key->text + 4, token)) {
				found = true;
				next_id = key->id;
				if (strlen (result))
					strcat (result, "\\");
				strcat (result, key->text);
			}
		}
		if (!found)
			return 0;
		par_id = next_id;
		token = strtok (0, "\\");
	}
	return result;
}

void get_alldocs (int run_mode, bool show_errors, bool use_turbo)
{
	part_documents.clear ();
	part_documents_from.clear ();
	part_documents_to.clear ();
	switch (run_mode) {
		case 1:
			{
			alldocs = new DocCollection ();

			DocCollection letter_docs;
			long comments_id = 0, count = 0;
			BTIterator *btit;
			for (btit = new BTIterator (aBase->FindIndex ("Type")); !btit->End () && count < 2; ++(*btit)) {
				HIndex::HIndexKey* hkey = (HIndex::HIndexKey*) btit->Key();
				if (hkey->level==0 && !strcmp (hkey->text+4, "�����������")) {
					comments_id = hkey->id;
					count++;
				}
				if (hkey->level==0 && !strcmp (hkey->text+4, "������")) {
					Stream* str = aBase->FindIndex ("Type")->Index::OpenN (hkey,0);
					if (str) {
						letter_docs.FastLoadRefs (str);
						aBase->FindIndex ("Type")->Close (str);
					}
					count++;
				}
			}
			delete btit;
			for (btit = new BTIterator (aBase->FindIndex ("Type")); !btit->End (); ++(*btit)) {
				HIndex::HIndexKey* hkey = (HIndex::HIndexKey*) btit->Key();
				if (hkey->level==1 && hkey->parent == comments_id && !strcmp (hkey->text+4, "������-�����")) {
					Stream* str = aBase->FindIndex ("Type")->Index::OpenN (hkey,0);
					if (str) {						
						alldocs->FastLoadRefs (str);
						aBase->FindIndex ("Type")->Close (str);
						break;
					}
				}
			}
			delete btit;
			for (btit = new BTIterator (aBase->FindIndex ("Type")); !btit->End (); ++(*btit)) {
				HIndex::HIndexKey* hkey = (HIndex::HIndexKey*) btit->Key();
				if (hkey->level==1 && hkey->parent == comments_id && (!strcmp (hkey->text+4, "������") || !strcmp (hkey->text+4, "�����"))) {
					Stream* str = aBase->FindIndex ("Type")->Index::OpenN (hkey,0);
					if (str) {
						DocCollection minus_docs;
						minus_docs.FastLoadRefs (str);
						aBase->FindIndex ("Type")->Close (str);
						alldocs->Minus (minus_docs);
					}
				}
			}
			delete btit;

			char *adopteds[] = {
				"����������� ������������ � ���������\\������� ������ (������������ ����� � ����������� �������� ��)",
				"����������� ������������ � ���������\\������� (����������� ������ �� ����� � ���������)",
				"��������������� �����\\���������� ���� ������",
				"��������������� �����\\��� �� (���� ����������� ����������� ���������� ���������)",
				"������ ������ �. ������\\��������� ��� �� �. ������",
				"������ ������ �. ������\\��������� ��� �� �. ������ � ���������� �������",
				"������ ������ ���������� �������\\��������� ��� �� �� (��������� ����������� ����� �� �� ���������� �������)",
				"������ ������ ���������� �������\\��-���� ��� �� (�� ���������� ��������� ������������ ��������� ��� ��)",
				"������ ������ �. �����-����������\\��������� ��� �� �. �����-����������",
				"������ ������ ���������� ����������\\��-�� ��� �� �� ��",
				"������ ������ �������� �������\\�� �������� ������������ ��������� ���",
				"������ ������ ������������� �������\\��������� ��� �� ������������� �������",
				"������ ������ ����������� �������\\����������� ������������ ��������� ��� ��",
				"������ ������ ������������� �������\\������������� ������������ ��������� ���",
				"������ ������ ����������� ����\\������ ������ ���������� �������\\���������� ������������ ��������� ��� ��",
				"����������� ������������ � ���������\\������ ������ (������������ �������� ��)",
				"����������� ������������ � ���������\\��� ������ (����������� ��������� ������)",
				"������ ������ ���������� ����������\\��������� ��� ������ �� ���������� ������ �.������� ��",
				"������ ������ ���������� ����������\\����������� ��������� ��� �� N 8 �� ��",
				"������ ������ ��������� ����������\\���������� ��� �� �� ��������� ����������",
				"������ ������ �������������� ����\\���������� ��� �� �� �������������� ����",
				"������ ������ ������������� �������\\���������� ��� �� �� ������������� ������� � ��������� ����������� ������",
				"������ ������ ������������ �������\\���������� ��� ������ �� ������������ �������",
				"������ ������ ������������� �������\\���������� ��� ������ �� ������������� �������",
				"������ ������ ��������������� �������\\���������� ��� �� ��������������� �������",
				"������ ������ ����������� �������\\���������� ��� �� ����������� �������",
				"������ ������ ����������� �������\\���������� ��� �� �� ����������� �������",
				"������ ������ ������������� �������\\���������� ��� ������ �� ������������� �������",
				"������ ������ ������ �������\\���������� ��� �� ������ �������",
				"������ ������ ���������� �������\\���������� ��� �� �� ���������� �������",
				"������ ������ ���������� �������\\��� ������ (����������� ��������� ������) �� ���������� �������",
				"������ ������ ������� �������\\���������� ��� �� ������� �������",
				"������ ������ �������� �������\\����������� ��������� ��� ������ �� ���������� ������������������ �������� �������",
				"������ ������ �������� �������\\���������� ��� ������ �� �������� �������",
				"������ ������ ��������� �������\\���������� ��� �� �� ��������� �������",
				"������ ������ ����������� �������\\���������� ��� �� �� ����������� �������",
				"������ ������ ����������� �������\\���������� ��� ������ �� ����������� �������",
				"������ ������ �����-��������� ����������� ������\\���������� ��� �� ����",
				"������ ������ ���������� �������\\��������������� ������ ����������� ������� �������������� ������\\���������� ��� (����������� ��������� ������) �� �� ���������� �������",
				"������ ������ ���������� ����� ��\\��������������� ������ ����������� ������� �������������� ������\\���������� ��� (����������� ��������� ������) �� �� ���������� ����� ��",
				"������ ������ ����������� ����\\������ ������ ���������� �������\\���������� ��� ������ �� ���������� ������� � ���������� ��",
				"������ ������ ������������ �������\\������������ � ��������� ������������ �������\\���������� ��� �� �� ������������ �������",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\�. ���������\\��������� ��� �� �� �. ���������",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\�. ���������\\��������� ��� �� �� ���������� ������ �. ���������",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\�. ��������������\\��������� ��� �� �� �. ��������������",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\�. �������\\����������� ��������� ��� �� N 1 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\�. �����\\����������� ��������� ��� �� N 4 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\�. �������\\����������� ��������� ��� �� N 8 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\���������� �����\\����������� ��������� ��� �� N 1 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\���������� �����\\����������� ��������� ��� �� N 3 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\����������� �����\\����������� ��������� ��� �� N 2 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\���������� �����\\����������� ��������� ��� �� N 3 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\����������� �����\\����������� ��������� ��� �� N 3 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\��������� �����\\����������� ��������� ��� �� N 4 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\���������� �����\\����������� ��������� ��� �� N 7 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\������������� �����\\����������� ��������� ��� �� N 2 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\��������������� �����\\����������� ��������� ��� �� N 7 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\��������������� �����\\����������� ��������� ��� �� N 6 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\���������-��������� �����\\����������� ��������� ��� �� N 5 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\����������� �����\\����������� ��������� ��� �� N 6 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\�������� �����\\����������� ��������� ��� �� N 8 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\��������� �����\\����������� ��������� ��� �� N 7 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\���������� �����\\����������� ��������� ��� �� N 7 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\������������ �����\\����������� ��������� ��� �� N 5 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\������������ �����\\����������� ��������� ��� �� N 2 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\������������ �����\\����������� ��������� ��� �� N 8 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\��������� �����\\����������� ��������� ��� �� N 6 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\���������� �����\\����������� ��������� ��� �� N 2 �� ��",
				"������ ������ ��������� ����������\\������ ������ ������� � ������� ��������� ����������\\����������� �����\\����������� ��������� ��� �� N 4 �� ��",
				"������ ������ ��������������� ����\\������ ������ ������� � ������� KMB\\�. ���������\\��������� ��� �� �� �. ����������",
				"������ ������ ������������� �������\\������ ������ ������� � ������� ������������� �������\\�. �����������\\��������� ��� ������ �� �. �����������",
				"������ ������ ������������� �������\\������ ������ ������� � ������� ������������� �������\\�. �����������\\����������� ��������� ��� ������ N 7 �� ������������� ������� � ��������� ��",
				"������ ������ ������������� �������\\������ ������ ������� � ������� ������������� �������\\�. ����������\\����������� ��������� ��� ������ N 3 �� ������������� ������� � ��������� ��",
				"������ ������ ������������� �������\\������ ������ ������� � ������� ������������� �������\\�. ������������\\��������� ��� ������ �� �. �������������",
				"������ ������ ���������� �������\\���������� ����������� ��������� ������ �� ���������� �������",
				"������ ������ ���������� �������\\������ ������ ������� � ������� ���������� �������\\�. �������\\��������� ��� ������ �� �. �������",
				"������ ������ ���������� �������\\������ ������ ������� � ������� ���������� �������\\�. ����������\\��������� ��� ������ �� �. �����������",
				"������ ������ ���������� �������\\������ ������ ������� � ������� ���������� �������\\�. ��������\\��������� ��� ������ �� �. ���������",
				"������ ������ ���������� �������\\������ ������ ������� � ������� ���������� �������\\���������� �����\\��������� ��� ������ �� ����������� ������",
				"������ ������ ���������� �������\\������ �������������� ������ ���������� �������\\������������ � ��������� ���������� �������\\���������� ��� ������ �� ���������� �������",
				"������ ������ ��������� �������\\������ ������ ������� � ������� ��������� ���.\\�.������\\��������� ��� ������ �� ������������ ������ �.�. ������",
				"������ ������ ��������� �������\\������ ������ ������� � ������� ��������� ���.\\�.��������\\����������� ��������� ��� ������ N 2 �� ��������� �������",
				"������ ������ �����-����������� ����������� ������\\������ ������ ������� � ������� �����-����������� ����������� ������\\����� ������\\��������� ��� ������ �� �.�������"
			};

			{
			Index* index = aBase->FindIndex ("Category");
			char* key = "�����";
			Stream* str = index->Open (key);
			if (str) {
				DocCollection category_docs;
				category_docs.Get (str);
				index->Close (str);
				letter_docs.Intersect (category_docs);
			}
			}

			{
			DocCollection adopted_docs;
			Index* index = aBase->FindIndex ("Adopted");
			for (long i = 0; i < sizeof (adopteds) / sizeof (char*); i++) {
				char* key = findkey_woprefix (index, adopteds [i]);
				if (!key) {
					if (show_errors) printf ("ERROR: bad key %s\n", adopteds [i]);
				} else {
					Stream* str = index->Open (key);
					if (str) {
						DocCollection ado_docs;
						ado_docs.Get (str);
						index->Close (str);
						adopted_docs.Merge (ado_docs);
					}
					gk_free (key);
				}
			}
			letter_docs.Intersect (adopted_docs);

			if (use_turbo) {
				Index *swords_index = aBase->FindIndex ("SWords");			
				for (int i = 0; i < letter_docs.ItemCount; i++) {
					long doc_id = letter_docs [i];
					part_documents.insert (doc_id);

					Document* doc = aBase->GetDoc (doc_id);
					long para1 = -1, para2 = -1;
					bool b_found_text = false;
					for (int para = 0; para < doc->Stat.ParaCount && (para1 == -1 || para2 == -1); para++) {
						long flags = doc->EVDFlags (doc->GetPara (para));
						if (flags & ENDT_SBS) {
							if (para2 == -1)
								para2 = para;
						}
						else
						if (flags & ENDT_HEADER) {
							if (para1 == -1)
								para1 = para;
						}
						else
						if (para1 != -1 && !b_found_text) {
							b_found_text = true;
							para1 = para;
						}
					}
					if (para1 == -1)
						para1 = 0;
					if (para2 == -1)
						para2 = doc->Stat.ParaCount-1;
					delete doc;
					Stream *str = swords_index->Open (&doc_id);
					if (str) {
						char* swords = (char*) malloc (str->Length ()+4);
						str->Read (swords, str->Length ());
						swords_index->Close (str);
						long from = ((*(long*) (swords + 3*para1)) & 0xFFFFFF) + 1, to = ((*(long*) (swords + 3*para2)) & 0xFFFFFF) + 1;
						part_documents_to.insert (std::map<long,long>::value_type (doc_id, to));
						gk_free (swords);
					}
				}
			}
			alldocs->Merge (letter_docs);
			}

			}

			break;

		case 2:
			{
			alldocs = new DocCollection;
			Index *types_index = aBase->FindIndex ("Type"), *adopted_index = aBase->FindIndex ("Adopted"), *swords_index = aBase->FindIndex ("SWords");
			BTIterator *btit;
			DocCollection part1, part2, part3, part4, part5, part6;
			for (btit = new BTIterator (types_index); !btit->End (); ++(*btit)) {
				HIndex::HIndexKey *key = (HIndex::HIndexKey*) btit->Key ();
				if (!key->level) {
					Stream* str = types_index->Index::OpenN (key, 0);
					if (!strcmp (key->text+4, "�������������")) {
						part1.FastLoadRefs (str);
						part2.Merge (part1);
					}
					if (!strcmp (key->text+4, "�������"))
						part3.FastLoadRefs (str);
					if (!strcmp (key->text+4, "�������") || !strcmp (key->text+4, "�����������") || !strcmp (key->text+4, "�������������") || !strcmp (key->text+4, "��������")) {
						str->Seek (0);
						DocCollection part;
						part.FastLoadRefs (str);
						part4.Merge (part);
					}
					if (!strcmp (key->text+4, "�������������") || !strcmp (key->text+4, "�����������")) {
						str->Seek (0);
						part6.FastLoadRefs (str);
					}
					/*
					if (!strcmp (key->text+4, "�������������") || !strcmp (key->text+4, "�����������")) {
						str->Seek (0);
						DocCollection part;
						part.FastLoadRefs (str);
						part6.Merge (part);
					}
					if (!strcmp (key->text+4, "�������������") || !strcmp (key->text+4, "�������")) {
						str->Seek (0);
						DocCollection part;
						part.FastLoadRefs (str);
						part5.Merge (part);
					}
					*/
					types_index->Close (str);
				}
			}
			delete btit;
			DocCollection a_part4, a_part5, a_part6;
			bool a_part3 = false, a_part2 = false, a_part1 = false;
			for (btit = new BTIterator (adopted_index); !btit->End (); ++(*btit)) {
				HIndex::HIndexKey *key = (HIndex::HIndexKey*) btit->Key ();
				Stream* str = adopted_index->Index::OpenN (key, 0);
				DocCollection adopteds;
				adopteds.Get (str);
				adopted_index->Close (str);
				if (!strcmp (key->text+4, "����������� ����������� ���� �������")) {
					part1.Intersect (adopteds);
					a_part1 = true;
				}
				if (!strcmp (key->text+4, "��������� ��� ��")) {
					part2.Intersect (adopteds);
					a_part2 = true;
				}
				if (!strcmp (key->text+4, "������ ����������� ��� ������ (��� ��)")) {
					part3.Intersect (adopteds);
					a_part3 = true;
				}
				if (!strcmp (key->text+4, "��������� ���������� ���� ������") || !strcmp (key->text+4, "������������ �������� ���������� ���� ������") || !strcmp (key->text+4, "������� �������� ���������� ���� ������") || !strcmp (key->text+4, "�������� �������� �� ����������� ����� ���������� ���� ������") || !strcmp (key->text+4, "�������� �������� �� ��������� ����� ���������� ���� ������") || !strcmp (key->text+4, "���� ����� ����������"))
					a_part4.Merge (adopteds);
				if (!strcmp (key->text+4, "����������� ���� ��������� ���������� ���������") || !strcmp (key->text+4, "����������� ������������� ����"))
					a_part5.Merge (adopteds);
				if (!strcmp (key->text+4, "��������������� ��� ������ (�� ��)") || !strcmp (key->text+4, "��������������� � �������� ���� ��������� ��"))
					a_part6.Merge (adopteds);
			}
			if (!a_part1) part1.FreeAll ();
			if (!a_part2) part2.FreeAll ();
			if (!a_part3) part3.FreeAll ();
			part4.Intersect (a_part4);
			part5.Intersect (a_part5);
			part6.Intersect (a_part6);

			delete btit;
			long i;
			for (i = 0; i < part1.ItemCount; i++)
				part_documents.insert (part1 [i]);
			
			/*
			DocCollection name_docs;
			char doc_name [DOC_NAME_SIZE];
			ContextPattern pattern;
			for (i = 0; i < part2.ItemCount; i++) {
				long id = part2 [i];
				aBase->FindDocName (id, doc_name);
				BuildPatternM (pattern, doc_name);
				bool contains = false;
				for (int j = 0; j < pattern.WordCount - 3 && !contains; j++)
					if (!strcmp (pattern.Word [j], "�������") && !strcmp (pattern.Word [j+1], "�������") && !strcmp (pattern.Word [j+2], "������������") && !strcmp (pattern.Word [j+3], "����")) {
						contains = true;
						name_docs.Collection::Add (&id);
					}
			}
			part2.Minus (name_docs);
			*/
			for (i = 0; i < part2.ItemCount; i++)
				part_documents.insert (part2 [i]);

			alldocs->Merge (part1);
			alldocs->Merge (part2);
			alldocs->Merge (part3);
			alldocs->Merge (part4);
			alldocs->Merge (part5);
			alldocs->Merge (part6);

			//��������� part_documents
			DocCollection bad_docs;
			for (std::set<long>::const_iterator it = part_documents.begin (); it != part_documents.end (); it++) {
				long id = *it, sub_count, para1 = -1, para2 = -1;
				SubDescEx *subs_ex = (SubDescEx*) aBase->LoadAttr (id, IDD_SUBS_EX, sub_count), *saved_subs_ex = subs_ex;
				sub_count /= sizeof (SubDescEx);
				if (sub_count) {
					for (i = 0; i < sub_count && (para1 == -1 || para2 == -1); i++, subs_ex++) {
						if ((subs_ex->Flags == SUBDESCEX_SUB || subs_ex->Flags == SUBDESCEX_BLOCK) && (subs_ex->Sub == 20005))
							para1 = subs_ex->Para;
						else
						if ((subs_ex->Flags == SUBDESCEX_SUB || subs_ex->Flags == SUBDESCEX_BLOCK) && (subs_ex->Sub == 30005))
							para2 = subs_ex->Para;
					}
					gk_free (saved_subs_ex);
				} else {
					SubDesc *subs = (SubDesc*) aBase->LoadAttr (id, IDD_SUBS, sub_count), *saved_subs = subs;
					sub_count /= sizeof (SubDesc);
					for (i = 0; i < sub_count && (para1 == -1 || para2 == -1); i++, subs++) {
						if (subs->Sub == 20005)
							para1 = subs->Para;
						else
						if (subs->Sub == 30005)
							para2 = subs->Para;
					}
					gk_free (saved_subs);
				}

				if (para2 == -1) {
					DocInfo docinfo;
					aBase->FindDocInfo (id, docinfo);
					para2 = docinfo.ParaCount - 1;
				}
				if (para1 == -1/* || para2 == -1*/) {
					if (show_errors)
						printf ("� ��������� %ld ��� 20005 ��� 30005 ����\n", id);
					bad_docs.Collection::Add (&id);
				} else {
					//��������� ����, � ������ �� ����� ����� ������ �������
					if (use_turbo) {
						Stream *str = swords_index->Open (&id);
						if (str) {
							char* swords = (char*) malloc (str->Length ()+4);
							str->Read (swords, str->Length ());
							swords_index->Close (str);
							long from = ((*(long*) (swords + 3*para1)) & 0xFFFFFF) + 1, to = ((*(long*) (swords + 3*para2)) & 0xFFFFFF) + 1;
							gk_free (swords);
							part_documents_from.insert (std::map<long,long>::value_type (id, from));
							part_documents_to.insert (std::map<long,long>::value_type (id, to));
						} else {
							bad_docs.Collection::Add (&id);
						}
					}
				}
			}
			alldocs->Minus (bad_docs);
			}

			break;

		case 3:
			{
			alldocs = new DocCollection;
			Index *types_index = aBase->FindIndex ("Type"), *adopted_index = aBase->FindIndex ("Adopted");
			BTIterator *btit;
			DocCollection part5;
			for (btit = new BTIterator (types_index); !btit->End (); ++(*btit)) {
				HIndex::HIndexKey *key = (HIndex::HIndexKey*) btit->Key ();
				if (!key->level) {
					Stream* str = types_index->Index::OpenN (key, 0);
					if (!strcmp (key->text+4, "�������������") || !strcmp (key->text+4, "�������")) {
						str->Seek (0);
						DocCollection part;
						part.FastLoadRefs (str);
						part5.Merge (part);
					}
					types_index->Close (str);
				}
			}
			delete btit;

			DocCollection a_part5;
			for (btit = new BTIterator (adopted_index); !btit->End (); ++(*btit)) {
				HIndex::HIndexKey *key = (HIndex::HIndexKey*) btit->Key ();
				if (!strcmp (key->text+4, "����������� ������������� ����")) {
					Stream* str = adopted_index->Index::OpenN (key, 0);
					a_part5.Get (str);
					adopted_index->Close (str);
				}
			}
			delete btit;
			part5.Intersect (a_part5);

			alldocs->Merge (part5);
			}

			break;
	}

	if (alldocs && alldocs->ItemCount) {
		DocCollection fresh_docs;
		date date_1_1_2011;
		date_1_1_2011.da_day = 1;
		date_1_1_2011.da_mon = 1;
		date_1_1_2011.da_year = 2011;

		Index* dates_index   = aBase->FindIndex ("Date");
		for (BTIterator it (dates_index, &date_1_1_2011); !it.End (); ++it) {
			date _date = *((date*) it.Key ());
			Stream *str = dates_index->Open (it.Key ());
			if (str) {
				DocCollection dates_docs;
				dates_docs.Get (str);
				dates_index->Close (str);
				fresh_docs.Merge (dates_docs);
			}
		}
		alldocs->Intersect (fresh_docs);
	}
}

void localrev_adddays (revision& theRev, const int days) 
{ 
	time_t atime; 
	struct tm atm; 
	struct tm *ptm; 
	memset( &atm, 0, sizeof( atm )); 
	atm.tm_year = theRev.RevisionDate.da_year - 1900; 
	atm.tm_mday = theRev.RevisionDate.da_day; 
	atm.tm_mon  = theRev.RevisionDate.da_mon - 1; 
	atime = mktime( &atm ); 
	atime += (long)days * 24l * 3600l; 
	ptm   = localtime( &atime ); 
	theRev.RevisionDate.da_year = ptm -> tm_year + 1900; 
	theRev.RevisionDate.da_day = ptm -> tm_mday; 
	theRev.RevisionDate.da_mon = ptm -> tm_mon + 1;	 
} 

int main_logic ( int argc, char *argv[] )
{
	if (argc < 3)
		exit (EXIT_FAILURE);

	int run_mode = 0;
	bool b_print_topics = false;
	bool b_merge = false;
	if (!stricmp (argv [1], "QA"))
		run_mode = 1;
	else
	if (!stricmp (argv [1], "Court"))
		run_mode = 2;
	else
	if (!stricmp (argv [1], "Apell"))
		run_mode = 3;
	else
	if (!stricmp (argv [1], "QA-read")) {
		run_mode = 1;
		b_print_topics = true;
	} else
	if (!stricmp (argv [1], "Court-read")) {
		run_mode = 2;
		b_print_topics = true;
	} else
	if (!stricmp (argv [1], "Apell-read")) {
		run_mode = 3;
		b_print_topics = true;
	} else
	if (!stricmp (argv [1], "QA-merge")) {
		run_mode = 1;
		b_merge = true;
	} else
	if (!stricmp (argv [1], "Court-merge")) {
		run_mode = 2;
		b_merge = true;
	} else
	if (!stricmp (argv [1], "Apell-merge")) {
		run_mode = 3;
		b_merge = true;
	} else
		exit (EXIT_FAILURE);

	bool two_bases = argc > 3 && !atol (argv [3]);
	aBase = new YBase (argv [2], ACE_OS_O_RDONLY);
	aBase->IsOk ();

	std::set<long> fresh_set;

	if (b_print_topics) {
		get_alldocs (run_mode, false, false);
		DocCollection *all_docs = aBase->AllDocs ();
		alldocs->Intersect (*all_docs);
		delete all_docs;

		{
		DocCollection fresh_docs;
		date date_1_1_2011;
		date_1_1_2011.da_day = 1;
		date_1_1_2011.da_mon = 1;
		date_1_1_2011.da_year = 2011;

		Index* dates_index   = aBase->FindIndex ("Date");
		for (BTIterator it (dates_index, &date_1_1_2011); !it.End (); ++it) {
			date _date = *((date*) it.Key ());
			Stream *str = dates_index->Open (it.Key ());
			if (str) {
				DocCollection dates_docs;
				dates_docs.Get (str);
				dates_index->Close (str);
				fresh_docs.Merge (dates_docs);
			}
		}
		for (int i = 0; i < fresh_docs.ItemCount; i++)
			fresh_set.insert (fresh_docs [i]);
		}

#ifndef	WIN64
		delete aBase;
#endif
		
		for (int i = 0; i < alldocs->ItemCount; i++) {
			long id = (*alldocs)[i];
			if (fresh_set.find (id) != fresh_set.end ())
				printf ("%ld\n", id);
		}
		exit (EXIT_SUCCESS);
	}

	get_alldocs (run_mode, !two_bases, b_merge ? false : true);
	if (!two_bases && !alldocs->ItemCount)
		exit (EXIT_FAILURE);

	{
	DocCollection *all_docs = aBase->AllDocs ();
	alldocs->Intersect (*all_docs);
	delete all_docs;
	}

	Base* old_base = 0;
	if (two_bases) {
		//������ ���� - ������, ������ ���� - �����
		old_base = aBase;
		old_docs = new DocCollection (*alldocs);
		if (!stricmp (argv [3], "read")) {
			char part_file_name [32], str_to_write [32];
			sprintf (part_file_name, "samedocs_%s.next_week", argv [1]);
			FILE *part_file = mpcxc_fopen (part_file_name, "w" );

			IndexLoader old_loader (old_base);
			for (int i = 0; i < old_docs->ItemCount; i++) {
				long doc_id_i = (*old_docs)[i], old_same_docs_count;
				INDEX_DATA (DocRele) old_same_docs = old_loader.load <DocRele> (doc_id_i, IDD_SAMEDOCS, old_same_docs_count, true);
				if (old_same_docs.ptr ()) {
					sprintf (str_to_write, "%ld: ", doc_id_i);
					fputs (str_to_write, part_file);
					DocRele* old_same_docs_ptr = old_same_docs.ptr ();
					for (int docs = 0; docs < old_same_docs_count; docs++, old_same_docs_ptr++ ) {
						sprintf (str_to_write, "%ld.%ld ", old_same_docs_ptr->DocId, old_same_docs_ptr->Rele);
						fputs (str_to_write, part_file);
					}
					sprintf (str_to_write, "\n");
					fputs (str_to_write, part_file);
				}
			}
			fclose (part_file);
			delete old_base;
			exit (EXIT_SUCCESS);
		}

		aBase = new YBase (argv [3], ACE_OS_O_RDONLY);
		aBase->IsOk ();
		delete alldocs;
		get_alldocs (run_mode, true, true);

		{
		DocCollection fresh_docs;
		date date_1_1_2011;
		date_1_1_2011.da_day = 1;
		date_1_1_2011.da_mon = 1;
		date_1_1_2011.da_year = 2011;

		Index* dates_index   = aBase->FindIndex ("Date");
		for (BTIterator it (dates_index, &date_1_1_2011); !it.End (); ++it) {
			date _date = *((date*) it.Key ());
			Stream *str = dates_index->Open (it.Key ());
			if (str) {
				DocCollection dates_docs;
				dates_docs.Get (str);
				dates_index->Close (str);
				fresh_docs.Merge (dates_docs);
			}
		}
		for (int i = 0; i < fresh_docs.ItemCount; i++)
			fresh_set.insert (fresh_docs [i]);
		}

		{
			DocCollection* all_docs = aBase->AllDocs ();
			alldocs->Intersect (*all_docs);
			delete all_docs;
		}

		new_docs = new DocCollection (*alldocs);
		new_docs->Minus (*old_docs);
		printf ("old_docs: %ld, new_docs: %ld, all_docs: %ld\n", old_docs->ItemCount, new_docs->ItemCount, alldocs->ItemCount);
	} else {
		printf ("all_docs: %ld\n", alldocs->ItemCount);
	}

	DocCollection *all_docs = aBase->AllDocs ();

	if (two_bases && argc == 5 && !stricmp (argv [4], "vincluded")) {
		printf ("change VINCLUDED\n");
		delete aBase;
		aBase = new StdBigBase (argv [3], ACE_OS_O_RDWR);
		Index *attrs = aBase->FindIndex ("Attrs"), *dates = aBase->FindIndex ("VIncluded");
		AttrKey included_key = {0, IDD_VINCLUDED};
		date	included_date;

		char part_file_name [32], str_to_write [32];
		sprintf (part_file_name, "vincluded_%s.lst", argv [1]);
		FILE *part_file = mpcxc_fopen (part_file_name, "w" );

		for (int i = 0; i < new_docs->ItemCount; i++) {
			long doc_id_i = (*new_docs)[i];
			included_key.DocId = doc_id_i;
			Stream *str = attrs->Open (&included_key);
			if (str) {
				sprintf (str_to_write, "%ld\n", doc_id_i);
				fputs (str_to_write, part_file);
				str->Read (&included_date, sizeof (date));
				attrs->Close (str);
				revision rev;
				gk_bzero (&rev, sizeof (rev));
				rev.RevisionDate = included_date;
				localrev_adddays (rev, -(8*7));
				aBase->ReplaceAttr (doc_id_i, IDD_VINCLUDED, &rev.RevisionDate, sizeof (date));
				str = dates->Index::OpenN (&included_date, 0);
				if (str) {
					DocCollection docs;
					docs.Get (str);
					long item = docs.IndexOf (&doc_id_i);
					if (item != -1) {
						docs.atDelete (item);
						str->Seek (0);
						docs.Put (str);
						str->Trunc ();
					}
					dates->Close (str);
					if (!docs.ItemCount)
						dates->Delete (&included_date);
				}
				str = dates->Index::OpenN (&rev.RevisionDate, 0);
				if (str) {
					DocCollection docs;
					docs.Get (str);
					docs.Insert (&doc_id_i);
					str->Seek (0);
					docs.Put (str);
					str->Trunc ();
					dates->Close (str);
				}
			}
		}
		fclose (part_file);
		delete aBase;
		exit (EXIT_SUCCESS);
	}

	if (b_merge) {
		typedef std::vector<u_int64_t> map_doc_cos;
		std::map<long,map_doc_cos*> map_doc_sames;

		FILE* out_file = mpcxc_fopen (argv [argc-1], "w");
		char str_to_write [32];

		std::set<long> new_docs;

		char* str = new char [64 * 1048576];
		printf ("read files step 1");
		std::map<long,long> map_doc_count;
		for (int afile = 4; afile < argc - 1; afile++) {
			FILE* part_file = mpcxc_fopen (argv [afile], "rt");
			if (part_file) {
				char ref_str [32];
				while (!feof (part_file)) {
					if (!fgets (str, 64 * 1048576, part_file))
						break;

					int length = strlen (str);
					while (length && (str [length-1] == 10 || str [length-1] == 13))
						str [--length] = 0;
					if (!length)
						continue;

					char* delimiter = strchr (str, ':');
					strncpy (ref_str, str, delimiter - str);
					ref_str [delimiter - str] = 0;
					long id = atol (str), size = 0;

					new_docs.insert (id);

					for (char* ptr = delimiter+2; *ptr; ) {
						Ref same_ref;
						same_ref.DocId = atol (ptr);
						same_ref.Sub = atol (strchr (ptr, '.') + 1);

						std::map<long,long>::iterator map_it = map_doc_count.find (same_ref.DocId);
						if (map_it == map_doc_count.end ()) {
							map_doc_count.insert (std::map<long,long>::value_type (same_ref.DocId, 1));
						} else {
							map_it->second++;
						}

						char* next_ptr = strchr (ptr, ' ');
						if (!next_ptr)
							break;
						ptr = next_ptr + 1;
					}
				}
			}
			fclose (part_file);
		}

		for (std::map<long,long>::const_iterator map_it = map_doc_count.begin (); map_it != map_doc_count.end (); map_it++) {
			map_doc_cos *empty = new map_doc_cos;
			empty->reserve (map_it->second);
			map_doc_sames.insert (std::map<long,map_doc_cos*>::value_type (map_it->first, empty));
		}

		printf ("read files step 2");
		for (int afile = 4; afile < argc - 1; afile++) {
			FILE* part_file = mpcxc_fopen (argv [afile], "rt");
			if (part_file) {
				char ref_str [32];
				while (!feof (part_file)) {
					if (!fgets (str, 64 * 1048576, part_file))
						break;

					int length = strlen (str);
					while (length && (str [length-1] == 10 || str [length-1] == 13))
						str [--length] = 0;
					if (!length)
						continue;

					char* delimiter = strchr (str, ':');
					strncpy (ref_str, str, delimiter - str);
					ref_str [delimiter - str] = 0;
					long id = atol (str), size = 0;

					if (fresh_set.find (id) == fresh_set.end ())
						continue;

					sprintf (str_to_write, "%ld: ", id);
					fputs (str_to_write, out_file);
					for (char* ptr = delimiter+2; *ptr; ) {
						Ref same_ref;
						same_ref.DocId = atol (ptr);
						same_ref.Sub = atol (strchr (ptr, '.') + 1);
						if (same_ref.Sub >= 2900 && size < 100) {
							if (fresh_set.find (same_ref.DocId) != fresh_set.end ()) {
								sprintf (str_to_write, "%ld.%ld ", same_ref.DocId, same_ref.Sub);
								fputs (str_to_write, out_file);
								size++;
							}
						}

						u_int64_t to_insert = (((u_int64_t) id) << 32) + same_ref.Sub;
						std::map<long,map_doc_cos*>::iterator map_it = map_doc_sames.find (same_ref.DocId);
						if (map_it != map_doc_sames.end ())
							map_it->second->push_back (to_insert);

						char* next_ptr = strchr (ptr, ' ');
						if (!next_ptr)
							break;
						ptr = next_ptr + 1;
					}

					sprintf (str_to_write, "\n");
					fputs (str_to_write, out_file);

				}
				fclose (part_file);
			}
		}
		printf ("done\n");

		IndexLoader old_loader (old_base);
		for (long i = 0; i < old_docs->ItemCount; i++) {
			long doc_id_i = (*old_docs) [i];
			if (alldocs->IndexOf (&doc_id_i) == -1 || all_docs->IndexOf (&doc_id_i) == -1)
				continue;

			if (new_docs.find (doc_id_i) != new_docs.end ())
				continue;

			if (fresh_set.find (doc_id_i) == fresh_set.end ())
				continue;

			std::set<short> cos_set;
			std::map<short, docs_vector> map_cos;
			std::set<long> _same_docs;

			long old_same_docs_count;
			INDEX_DATA (DocRele) old_same_docs = old_loader.load <DocRele> (doc_id_i, IDD_SAMEDOCS, old_same_docs_count, true);
			if (old_same_docs.ptr ()) {
				DocRele* old_same_docs_ptr = old_same_docs.ptr ();
				for (int docs = 0; docs < old_same_docs_count; docs++, old_same_docs_ptr++ ) {
					long id = old_same_docs_ptr->DocId;
					if (all_docs->IndexOf (&id) == -1 || alldocs->IndexOf (&id) == -1 || _same_docs.find (id) != _same_docs.end () || fresh_set.find (id) == fresh_set.end ())
						continue;
					_same_docs.insert (id);
					short long_cos = old_same_docs_ptr->Rele;
					cos_set.insert (long_cos);
					std::map<short,docs_vector>::iterator map_cos_iter = map_cos.insert (std::map<short,docs_vector>::value_type (long_cos,docs_vector ())).first;
					map_cos_iter->second.push_back (id);
				}
			}

			std::map<long,map_doc_cos*>::iterator same_docs_iter = map_doc_sames.find (doc_id_i);
			if (same_docs_iter != map_doc_sames.end ()) {
				std::stable_sort (same_docs_iter->second->begin (), same_docs_iter->second->end ());
				for (map_doc_cos::const_iterator it = same_docs_iter->second->begin (); it != same_docs_iter->second->end (); it++) {
					//long doc_id_j = it->first;
					long doc_id_j = (long)(*it >> 32);
					if (_same_docs.find (doc_id_j) != _same_docs.end () || fresh_set.find (doc_id_j) == fresh_set.end ())
						continue;

					//short long_cos = it->second;
					short long_cos = (short)(*it & 0xFFFF);
					cos_set.insert (long_cos);
					std::map<short,docs_vector>::iterator map_cos_iter = map_cos.insert (std::map<short,docs_vector>::value_type (long_cos,docs_vector ())).first;
					map_cos_iter->second.push_back (doc_id_j);
				}
			}

			std::deque<DocRele> same_docs;
			for (std::set<short>::reverse_iterator cos_set_it = cos_set.rbegin (); cos_set_it != cos_set.rend (); cos_set_it++) {
				short long_cos = *cos_set_it;
				if (long_cos < 2900 || same_docs.size () == 100)
					break;
				std::map<short,docs_vector>::iterator map_cos_iter = map_cos.find (long_cos);
				for (docs_vector::const_iterator docs_iter = map_cos_iter->second.begin (); docs_iter != map_cos_iter->second.end (); docs_iter++) {
					DocRele doc_rele = {*docs_iter, long_cos};
					same_docs.push_back (doc_rele);
					if (same_docs.size () == 100)
						break;
				}
			}

			if (same_docs.size ()) {
				sprintf (str_to_write, "%ld: ", doc_id_i);
				fputs (str_to_write, out_file);
				for (std::deque<DocRele>::const_iterator same_docs_iter = same_docs.begin (); same_docs_iter != same_docs.end (); same_docs_iter++) {
					sprintf (str_to_write, "%ld.%ld ", same_docs_iter->DocId, same_docs_iter->Rele);
					fputs (str_to_write, out_file);
				}
				sprintf (str_to_write, "\n");
				fputs (str_to_write, out_file);
			}
		}

		fclose (out_file);

		exit (EXIT_SUCCESS);
	}

	Index* index = aBase->FindIndex ("NWCntxt");
	std::map<long, long> lemma_in_docs; //�����.� �������� ���������� �����������
	long lemma = 0;

	std::set<std::string> skip_lemmas;
#ifndef	_DEBUG
	if (run_mode == 1) {
		skip_lemmas.insert ("�");		skip_lemmas.insert ("�");		skip_lemmas.insert ("�");		skip_lemmas.insert ("�");
		skip_lemmas.insert ("�");		skip_lemmas.insert ("�");		skip_lemmas.insert ("�");		skip_lemmas.insert ("�");
		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");
		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");
		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");
		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");
		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("���������������");		skip_lemmas.insert ("���������������");
		skip_lemmas.insert ("���������������");		skip_lemmas.insert ("���������������");		skip_lemmas.insert ("����������������");
	} else if (run_mode == 3) {
		skip_lemmas.insert ("�");		skip_lemmas.insert ("�");		skip_lemmas.insert ("�");		skip_lemmas.insert ("�");
		skip_lemmas.insert ("�");		skip_lemmas.insert ("�");		skip_lemmas.insert ("�");		skip_lemmas.insert ("�");
		skip_lemmas.insert ("�");		skip_lemmas.insert ("�");		skip_lemmas.insert ("�");		skip_lemmas.insert ("�");
		skip_lemmas.insert ("�");		skip_lemmas.insert ("�");		skip_lemmas.insert ("�");		skip_lemmas.insert ("��");
		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");
		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");
		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");
		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");
		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");
		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");
		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");
		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");
		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");
		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");
		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("��������������");		skip_lemmas.insert ("��������������");
		skip_lemmas.insert ("��������������");		skip_lemmas.insert ("��������������");		skip_lemmas.insert ("��������������");		skip_lemmas.insert ("��������������");
		skip_lemmas.insert ("��������������");		skip_lemmas.insert ("��������������");		skip_lemmas.insert ("��������������");		skip_lemmas.insert ("��������������");
		skip_lemmas.insert ("��������������");		skip_lemmas.insert ("��������������");		skip_lemmas.insert ("���������������");		skip_lemmas.insert ("���������������");
		skip_lemmas.insert ("���������������");		skip_lemmas.insert ("���������������");		skip_lemmas.insert ("���������������");		skip_lemmas.insert ("���������������");
		skip_lemmas.insert ("���������������");		skip_lemmas.insert ("���������������");		skip_lemmas.insert ("���������������");		skip_lemmas.insert ("���������������");
		skip_lemmas.insert ("���������������");		skip_lemmas.insert ("���������������");		skip_lemmas.insert ("����������������");		skip_lemmas.insert ("����������������");
		skip_lemmas.insert ("����������������");		skip_lemmas.insert ("����������������");		skip_lemmas.insert ("����������������");		skip_lemmas.insert ("�����������������");
		skip_lemmas.insert ("��������������������");		skip_lemmas.insert ("��������������������");
	} if (run_mode == 2) {
		skip_lemmas.insert ("�");		skip_lemmas.insert ("�");
		skip_lemmas.insert ("�");		skip_lemmas.insert ("�");
		skip_lemmas.insert ("�");		skip_lemmas.insert ("�");
		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");
		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");
		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("�������������");
		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");
		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");
		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");
		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");
		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");
		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("��������������");
		skip_lemmas.insert ("��������������");		skip_lemmas.insert ("��������������");
		skip_lemmas.insert ("��������������");		skip_lemmas.insert ("��������������");
		skip_lemmas.insert ("��������������");		skip_lemmas.insert ("��������������");
		skip_lemmas.insert ("��������������");		skip_lemmas.insert ("���������������");
		skip_lemmas.insert ("���������������");		skip_lemmas.insert ("���������������");
		skip_lemmas.insert ("���������������");		skip_lemmas.insert ("���������������");
		skip_lemmas.insert ("���������������");		skip_lemmas.insert ("���������������");
		skip_lemmas.insert ("������������������");

		skip_lemmas.insert ("�");	skip_lemmas.insert ("�");	skip_lemmas.insert ("�");	skip_lemmas.insert ("�");
		skip_lemmas.insert ("�");	skip_lemmas.insert ("�");	skip_lemmas.insert ("�");	skip_lemmas.insert ("�");
		skip_lemmas.insert ("�");	skip_lemmas.insert ("�");	skip_lemmas.insert ("��");	skip_lemmas.insert ("��");
		skip_lemmas.insert ("��");	skip_lemmas.insert ("��");	skip_lemmas.insert ("��");	skip_lemmas.insert ("��");
		skip_lemmas.insert ("��");	skip_lemmas.insert ("��");	skip_lemmas.insert ("��");	skip_lemmas.insert ("��");
		skip_lemmas.insert ("��");	skip_lemmas.insert ("��");	skip_lemmas.insert ("��");	skip_lemmas.insert ("��");
		skip_lemmas.insert ("��");	skip_lemmas.insert ("��");	skip_lemmas.insert ("��");	skip_lemmas.insert ("��");
		skip_lemmas.insert ("��");	skip_lemmas.insert ("��");	skip_lemmas.insert ("���");	skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");	skip_lemmas.insert ("���");	skip_lemmas.insert ("���");	skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");	skip_lemmas.insert ("���");	skip_lemmas.insert ("���");	skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");	skip_lemmas.insert ("���");	skip_lemmas.insert ("���");	skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");	skip_lemmas.insert ("���");	skip_lemmas.insert ("���");	skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");	skip_lemmas.insert ("���");	skip_lemmas.insert ("���");	skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");	skip_lemmas.insert ("���");	skip_lemmas.insert ("���");	skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");	skip_lemmas.insert ("���");	skip_lemmas.insert ("���");	skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");	skip_lemmas.insert ("���");	skip_lemmas.insert ("���");	skip_lemmas.insert ("���");
		skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");	skip_lemmas.insert ("����");
		skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");	skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");	skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");	skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");	skip_lemmas.insert ("��������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("���������");	skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");	skip_lemmas.insert ("����������");
		skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");	skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");	skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");	skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");
		skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");
		skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");
		skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");
		skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");
		skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");
		skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");
		skip_lemmas.insert ("�������������");	skip_lemmas.insert ("�������������");	skip_lemmas.insert ("��������������");	skip_lemmas.insert ("��������������");
		skip_lemmas.insert ("��������������");	skip_lemmas.insert ("��������������");	skip_lemmas.insert ("��������������");	skip_lemmas.insert ("��������������");
		skip_lemmas.insert ("��������������");	skip_lemmas.insert ("��������������");	skip_lemmas.insert ("��������������");	skip_lemmas.insert ("��������������");
		skip_lemmas.insert ("��������������");	skip_lemmas.insert ("��������������");	skip_lemmas.insert ("��������������");	skip_lemmas.insert ("��������������");
		skip_lemmas.insert ("��������������");	skip_lemmas.insert ("��������������");	skip_lemmas.insert ("���������������");	skip_lemmas.insert ("���������������");
		skip_lemmas.insert ("���������������");	skip_lemmas.insert ("���������������");	skip_lemmas.insert ("���������������");	skip_lemmas.insert ("���������������");
		skip_lemmas.insert ("���������������");	skip_lemmas.insert ("���������������");	skip_lemmas.insert ("���������������");	skip_lemmas.insert ("���������������");
		skip_lemmas.insert ("���������������");	skip_lemmas.insert ("���������������");	skip_lemmas.insert ("����������������");			skip_lemmas.insert ("����������������");
		skip_lemmas.insert ("����������������");	skip_lemmas.insert ("����������������");	skip_lemmas.insert ("����������������");	skip_lemmas.insert ("�����������������");
		skip_lemmas.insert ("�������������������");	skip_lemmas.insert ("������");				skip_lemmas.insert ("���");					skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");				skip_lemmas.insert ("������");				skip_lemmas.insert ("�������");				skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");			skip_lemmas.insert ("���������");			skip_lemmas.insert ("���������");			skip_lemmas.insert ("���������");
		skip_lemmas.insert ("����������");			skip_lemmas.insert ("����������");			skip_lemmas.insert ("�����������");			skip_lemmas.insert ("�������������");

		skip_lemmas.insert ("�");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");
		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");		skip_lemmas.insert ("��");
		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");
		skip_lemmas.insert ("���");		skip_lemmas.insert ("���");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");
		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");
		skip_lemmas.insert ("�����");		skip_lemmas.insert ("�����");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");
		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");
		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("�������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");		skip_lemmas.insert ("��������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");		skip_lemmas.insert ("���������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");		skip_lemmas.insert ("����������");
		skip_lemmas.insert ("����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("�����������");
		skip_lemmas.insert ("�����������");		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");		skip_lemmas.insert ("������������");
		skip_lemmas.insert ("������������");		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");
		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");
		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("�������������");		skip_lemmas.insert ("��������������");
		skip_lemmas.insert ("��������������");		skip_lemmas.insert ("��������������");		skip_lemmas.insert ("��������������");		skip_lemmas.insert ("��������������");
		skip_lemmas.insert ("��������������");		skip_lemmas.insert ("��������������");		skip_lemmas.insert ("���������������");		skip_lemmas.insert ("���������������");
		skip_lemmas.insert ("���������������");		skip_lemmas.insert ("���������������");		skip_lemmas.insert ("���������������");		skip_lemmas.insert ("���������������");
		skip_lemmas.insert ("����������������");		skip_lemmas.insert ("����������������");		skip_lemmas.insert ("����������������");		skip_lemmas.insert ("�����������������");
		skip_lemmas.insert ("������������������");		skip_lemmas.insert ("��������������������");		skip_lemmas.insert ("��������������������");
	}
#endif

	std::set<std::string> remain_lemmas;

#ifndef	_DEBUG
	//������ �� 23 ������� 2011�.
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("����");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("����");
	remain_lemmas.insert ("����");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("��������������");
	remain_lemmas.insert ("����");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("����");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("��������������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("����");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("���������������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("����������������");
	remain_lemmas.insert ("��������������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("������������������");
	remain_lemmas.insert ("����������������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("���");
	remain_lemmas.insert ("��������������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("��������������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("��������������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("����");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("���������������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("���������������");
	remain_lemmas.insert ("����������������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("���");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("������������������");
	remain_lemmas.insert ("����������������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("��������������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("���������������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("����������������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("��������������");
	remain_lemmas.insert ("�����������������");
	remain_lemmas.insert ("���������������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("��");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("����");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("����");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("��������������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("����");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("���������������");
	remain_lemmas.insert ("�������������������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("��������������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("��������������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("���������������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("���������������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("���������������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("��������������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("����");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("����");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("����");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("����");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("��������������");
	remain_lemmas.insert ("��������������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("������");
	remain_lemmas.insert ("����");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("����");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("��������������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("�����������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("���������");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("����");
	remain_lemmas.insert ("���");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("�����");
	remain_lemmas.insert ("��������");
	remain_lemmas.insert ("�������������");
	remain_lemmas.insert ("����������");
	remain_lemmas.insert ("������������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("�������");
	remain_lemmas.insert ("����");
#endif

	for (std::set<std::string>::const_iterator it = remain_lemmas.begin (); it != remain_lemmas.end (); it++)
		skip_lemmas.erase (*it);

	if (!two_bases && argc == 7) {
		long year = atol (argv [6]);
		for (int i = 0; i < alldocs->ItemCount; i++) {
			long doc_id_i = (*alldocs)[i];
			DocInfo docinfo;
			aBase->FindDocInfo (doc_id_i, docinfo);
			if (docinfo.FirstDate.da_year == year)
				year_docs.insert (doc_id_i);
		}
		printf ("year %ld docs: %ld\n", year, year_docs.size ());
	}

	bool b_calc = (two_bases && new_docs->ItemCount) || !two_bases;
	int i;
	if (b_calc) {
		for (BTIterator btit (index); !btit.End (); ++btit) {
			const char* key = (const char*)btit.Key ();
			if (key[0] & 0x80)
				break;
			if (skip_lemmas.find (key+1) != skip_lemmas.end ())
				continue;
			Stream *str0 = index->Open (key), *str1 = index->OpenN (key, 1), *str2 = index->OpenN (key, 2);
			char *qqq = strdup (key+1);
			Recoding (cd_win, cd_dos, qqq);
			printf ("%s\r", qqq); fflush (stdout);
			free (qqq);
			if (str0) {
				lemmas.push_back (key+1);

				DBCore::IDataStream_var pos_reader = new DBExt::PositionsReader (str2, -1, DBExt::Def::dt_Text, str1->Length () > 32, 0);
				DBCore::IRefStream_var str_reader = new DBExt::StreamReader (str0, 0);

				DBCore::Ref_ ref = {0,0,0};
				DBCore::ExtrPair extr;

				long docs = 0;

				while (str_reader->get_next (ref, 0)) {
					long id = ref.doc_id, from, to;
					if (alldocs->IndexOf (&id) == -1 || all_docs->IndexOf (&id) == -1)
						continue;

					bool b_part_document = part_documents.find (id) != part_documents.end ();
					if (b_part_document) {
						from = part_documents_from.find (id)->second;
						to = part_documents_to.find (id)->second; 
					}

					DBCore::ULongVector positions;
					pos_reader->get (positions, ref, extr);
					long count_in_doc = 0;
					for (DBCore::ULongVector::const_iterator pos_it = positions.begin (); pos_it != positions.end (); pos_it++) {
						long pos = *pos_it;
						if ((pos & ContextSearch::POS_INVISIBLE_BLOCK) == ContextSearch::POS_INVISIBLE_BLOCK)
							continue;
						if ((pos & ContextSearch::POS_INVISIBLE) == ContextSearch::POS_INVISIBLE)
							continue;
						pos &= ContextSearch::POS_TEXT;
						if (b_part_document && (pos < from || pos >= to))
							continue;
						count_in_doc++;
					}
					docs++;
					std::map<long, lemmacounts_packed>::iterator it = doc_lemmas_counts_packed->find (id);
					if (it == doc_lemmas_counts_packed->end ())
						it = doc_lemmas_counts_packed->insert (std::map<long,lemmacounts_packed>::value_type (id, lemmacounts_packed ())).first;
					u_int64_t put = ((u_int64_t)lemma << 32) + count_in_doc;
					it->second.push_back (put);
				}

				if (docs)
					lemma_in_docs.insert (std::map<long,long>::value_type (lemma, docs));

				index->Close (str2);
				index->Close (str1);
				index->Close (str0);
				
				lemma++;
			}
		}
		printf ("\n");

		for (std::map<long,long>::const_iterator lemma_in_docs_it = lemma_in_docs.begin (); lemma_in_docs_it != lemma_in_docs.end (); lemma_in_docs_it++) {
			if (lemma_in_docs_it->second > 40000) {
				long lemma = lemma_in_docs_it->first;
				std::string lemma_str = lemmas.at (lemma);
				if (remain_lemmas.find (lemma_str) == remain_lemmas.end ()) {
					lemmas_to_skip.insert (lemma);
					printf ("��������� %s\n", lemma_str.c_str ());
					fflush (stdout);
				}
			}
		}

		for (std::map<long, lemmacounts_packed>::const_iterator doc_lemmas_counts_it = doc_lemmas_counts_packed->begin (); doc_lemmas_counts_it != doc_lemmas_counts_packed->end (); doc_lemmas_counts_it++) {
			long doc_id = doc_lemmas_counts_it->first;
			std::map<long,long>::iterator doc_words_it = doc_words.insert (std::map<long,long>::value_type (doc_id, 0)).first;
			lemmacounts_packed::const_iterator it = doc_lemmas_counts_it->second.begin ();
			if (it != doc_lemmas_counts_it->second.end ()) for (it++; it != doc_lemmas_counts_it->second.end (); it++)
				doc_words_it->second++;
		}

		C = alldocs->ItemCount;
		double log_C_plus_1 = log (C+1.0);
		for (std::map<long,long>::const_iterator doc_words_it = doc_words.begin (); doc_words_it != doc_words.end (); doc_words_it++) {
			long doc_id = doc_words_it->first, plus_w = doc_words_it->second;
			W += plus_w;
		}
		W /= C;
		printf ("W = %ld\n", W);
		W = 380; //������

		for (std::map<long,long>::const_iterator lemmas_in_docs_it = lemma_in_docs.begin (); lemmas_in_docs_it != lemma_in_docs.end (); lemmas_in_docs_it++ ) {
			long lemma = lemmas_in_docs_it->first;
			if (lemmas_to_skip.find (lemma) == lemmas_to_skip.end ()) {
				long Cw = lemmas_in_docs_it->second;
				//double idf = log((C+0.5)/Cw)/log_C_plus_1;
				double idf = 1 - 0.16 * log ((double)Cw); //������
				lemma_idf.insert (std::map<long,double>::value_type (lemma, idf));
			}
		}
		printf ("idf calculated\n");

		IndexLoader loader (aBase);

		std::map<u_int64_t, long> refs;
		for (i = 0; i < C; i++) {
			long id = (*alldocs)[i];

			long gdi;
			INDEX_DATA (RespRef) doc_i_refs = loader.load <RespRef> (id, IDD_REFS, gdi, true);
			if (doc_i_refs.ptr ()) {
				RespRef* refs_ptr = doc_i_refs.ptr ();
				for (int ref = 0; ref < gdi; ref++, refs_ptr++ ) {
					u_int64_t aref = (((u_int64_t)refs_ptr->DocId) << 32) + refs_ptr->Sub;
					std::map<u_int64_t,long>::iterator it = refs.find (aref);
					if (it==refs.end ())
						refs.insert (std::map<u_int64_t,long>::value_type (aref, 1));
					else
						it->second++;					
				}
			}
		}

		for (i = 0; i < C; i++) {
			long id = (*alldocs)[i];
			if (doc_words.find (id) == doc_words.end ())
				continue;
			long Wi = doc_words.find (id)->second;
			std::map<long, lemmacounts_packed>::const_iterator doc_i = doc_lemmas_counts_packed->find (id);
			double sum = 0.0;
			for (lemmacounts_packed::const_iterator lemmas_in_i = doc_i->second.begin (); lemmas_in_i != doc_i->second.end (); lemmas_in_i++) {
				u_int64_t at_it = *lemmas_in_i;
				long lemma = (long) (at_it >> 32);
				if (lemmas_to_skip.find (lemma) == lemmas_to_skip.end ()) {
					long Nwi = (long)(at_it & 0xffffffff);
					double tf = Nwi / (Nwi + 0.5 + 1.5 * (Wi / W));
					double idf = lemma_idf.find (lemma)->second;
					double tfidf = 0.4+0.6*tf*idf;
					sum += tfidf*tfidf;
				}
			}
			tfidf.insert (std::map<long,double>::value_type (id,sqrt (sum)));

			//��������� ������
			long refs_in_i = 0, gdi;
			INDEX_DATA (RespRef) doc_i_refs = loader.load <RespRef> (id, IDD_REFS, gdi, true);
			std::deque<long> doc_resps_in;
			std::deque<u_int64_t> refs_resps_in;
			if (doc_i_refs.ptr ()) {
				RespRef* refs_ptr = doc_i_refs.ptr ();
				for (int ref = 0; ref < gdi; ref++, refs_ptr++ ) {
					long ref_doc = refs_ptr->DocId;
					if (ref_doc == 12127526 || ref_doc == 3961642 || ref_doc == 10100950)
						continue;
					long ref_sub = refs_ptr->Sub;
					if ( !ref_sub && (ref_doc == 10164072 || ref_doc == 10900200))
						continue;
					u_int64_t aref = (((u_int64_t)ref_doc) << 32) + ref_sub;
					if (refs.find (aref)->second < 10000) {
						refs_in_i++;
						refs_resps_in.push_back (aref);
						doc_resps_in.push_back (ref_doc);
					}
				}
			}

			if (refs_in_i) {
				std::sort (doc_resps_in.begin (), doc_resps_in.end ());
				std::sort (refs_resps_in.begin (), refs_resps_in.end ());
				gd.insert (std::map<long,long>::value_type (id,gdi));
				map_docs_resps->insert (std::map< long,std::deque<long> >::value_type (id, doc_resps_in));
				map_refs_resps->insert (std::map< long,std::deque<u_int64_t> >::value_type (id, refs_resps_in));
			}
		}
		printf ("tfidf calculated\n");
		
	} else {
		printf ("No new docs, skip reading data from indexes\n");
	}

#ifndef	WIN64
	delete aBase;
#endif
	aBase = 0;

	if (two_bases) {
		int threads_count = 1;
		if (argv [4]) {
			threads_count = atol (argv [4]);
			if (threads_count > MAX_THREADS)
				threads_count = MAX_THREADS;
		}

		bool multy_part_work = false;
		long total_parts = 1, from_part = 0, dones = 0;
		if (argc > 6) {
			multy_part_work = true;
			total_parts = atol (argv [5]);
			from_part = atol (argv [6]);
		} else {
			multy_part_work = true;
			total_parts = threads_count;
		}
		long step = new_docs->ItemCount / total_parts, pos = 0, thread_id = 0, from = from_part * step, to = from + threads_count * step;
		if (from_part + threads_count == total_parts) {
			to = new_docs->ItemCount;
			step += total_parts;
		}

		//������� ��������� ��� ����� ����������
		//long step = new_docs->ItemCount / threads_count, pos = 0, thread_id;
		for (thread_id = 0; thread_id < threads_count; thread_id++) {
			thread_data [thread_id].from = from;
			thread_data [thread_id].to   = to;
			thread_data [thread_id].done = 0;
		}
		for (thread_id = 0, i = from; i < to; i++, pos++) if (pos == step) {
			thread_data [thread_id].to = i;
			thread_data [++thread_id].from = i;
			pos = 0;
		}

		if (b_calc) {
			printf ("Calculate samedocs for new docs\n");
			long ok_threads = 0;
			for (thread_id = 0; thread_id < threads_count; thread_id++) {
				ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
				inst->spawn ((ACE_THR_FUNC)calculate_samedocs_new_78, &thread_id, THR_DETACHED);
				ok_threads++;
				ACE_OS::sleep (1);
			}
			for (;;) {
				long id = get_new_doc (false);
				if (id) {
					printf ("threads checked, %ld%%\n", (new_doc_it * 100) / new_docs->ItemCount);
					ACE_OS::sleep (10);
				} else {
					int dones = 0;
					for (thread_id = 0; thread_id < threads_count; thread_id++)
						if (thread_data [thread_id].done)
							dones++;
					if (dones == ok_threads)
						break;
					else
						ACE_OS::sleep (10);
				}
			}
			printf ("\ndelete threads"); fflush (stdout);
		}

		//������ ��� ������
		step = old_docs->ItemCount / total_parts, pos = 0, from = from_part * step, to = from + threads_count * step;
		if (from_part + threads_count == total_parts) {
			to = old_docs->ItemCount;
			step += total_parts;
		}
		//step = old_docs->ItemCount / threads_count, pos = 0;

		for (thread_id = 0; thread_id < threads_count; thread_id++) {
			thread_data_2 [thread_id].from = from;
			thread_data_2 [thread_id].to   = to;
			thread_data_2 [thread_id].done = 0;
		}
		for (thread_id = 0, i = from; i < to; i++, pos++) if (pos == step) {
			thread_data_2 [thread_id].to = i;
			thread_data_2 [++thread_id].from = i;
			pos = 0;
		}

		printf ("\nWriting samedocs. Please wait...\n");
		char part_file_name [32], str_to_write [32];
		if (multy_part_work)
			sprintf (part_file_name, "samedocs_%s_part%ld.next_week", argv [1], from_part);
		else
			sprintf (part_file_name, "samedocs_%s.next_week", argv [1]);
		FILE *part_file = mpcxc_fopen (part_file_name, "w" );

		for (thread_id = 0; thread_id < threads_count; thread_id++) {
			for (std::map<long, std::deque<DocRele> >::const_iterator it = thread_data [thread_id].samedocs_map.begin (); it != thread_data [thread_id].samedocs_map.end (); it++) {
				long doc_id_i = it->first, to_put_size = sizeof (DocRele) * it->second.size ();
				if (alldocs->IndexOf (&doc_id_i) == -1 || all_docs->IndexOf (&doc_id_i) == -1)
					continue;
				sprintf (str_to_write, "%ld: ", doc_id_i);
				fputs (str_to_write, part_file);
				bool b_writed = false;
				std::deque<DocRele>::const_iterator same_docs_iter;
				for (same_docs_iter = it->second.begin (); same_docs_iter != it->second.end (); same_docs_iter++) {
					long doc_id_iter = same_docs_iter->DocId;
					if (alldocs->IndexOf (&doc_id_iter) == -1 || all_docs->IndexOf (&doc_id_iter) == -1)
						continue;
					b_writed = true;
					sprintf (str_to_write, "%ld.%ld ", doc_id_iter, same_docs_iter->Rele);
					fputs (str_to_write, part_file);
				}
				if (!b_writed) {
					sprintf (str_to_write, "%ld.%ld ", it->second.begin ()->DocId, it->second.begin ()->Rele);
					fputs (str_to_write, part_file);
				}
				sprintf (str_to_write, "\n");
				fputs (str_to_write, part_file);
			}
		}

		fclose (part_file);
	} else {
		int threads_count = 1;
		if (argv [3]) {
			threads_count = atol (argv [3]);
			if (threads_count > MAX_THREADS)
				threads_count = MAX_THREADS;
		}

		bool multy_part_work = false;
		long total_parts = 1, from_part = 0;
		if (argc > 5) {
			multy_part_work = true;
			total_parts = atol (argv [4]);
			from_part = atol (argv [5]);
		}

		long step = alldocs->ItemCount / total_parts, pos = 0, thread_id = 0, from = from_part * step, to = from + threads_count * step;
		for (thread_id = 0; thread_id < threads_count; thread_id++) {
			thread_data [thread_id].from = from;
			thread_data [thread_id].to   = to;
			thread_data [thread_id].done = 0;
		}
		for (thread_id = 0, i = from; i < to; i++, pos++)
			if (pos == step) {
				thread_data [thread_id].to = i;
				thread_data [++thread_id].from = i;
				pos = 0;
			}
		for (thread_id = 0; thread_id < threads_count; thread_id++) {
			ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
			inst->spawn ((ACE_THR_FUNC)calculate_samedocs, &thread_id, THR_DETACHED);
			ACE_OS::sleep (1);
		}
		int dones; do {
			dones = 0;
			for (thread_id = 0; thread_id < threads_count; thread_id++)
				dones += thread_data [thread_id].done;
			ACE_OS::sleep (5);
		} while (dones < threads_count);
		printf ("\nWriting samedocs. Please wait...\n");
		if (aBase)
			delete aBase;
		FILE *part_file;
		char str_to_write [32];
		if (multy_part_work) {
			char part_file_name [32];
			sprintf (part_file_name, "samedocs_%s_%ld.part", argv [1], from_part);
			part_file = mpcxc_fopen (part_file_name, "w" );
			aBase = 0;
		} else {
			aBase = new StdBigBase (argv [2], ACE_OS_O_RDWR);
		}
		for (thread_id = 0; thread_id < threads_count; thread_id++) {
			for (std::map<long, std::deque<DocRele> >::const_iterator it = thread_data [thread_id].samedocs_map.begin (); it != thread_data [thread_id].samedocs_map.end (); it++) {
				long doc_id_i = it->first;
				if (multy_part_work) {
					sprintf (str_to_write, "%ld: ", doc_id_i);
					fputs (str_to_write, part_file);
					for (std::deque<DocRele>::const_iterator same_docs_iter = it->second.begin (); same_docs_iter != it->second.end (); same_docs_iter++) {
						sprintf (str_to_write, "%ld.%ld ", same_docs_iter->DocId, same_docs_iter->Rele);
						fputs (str_to_write, part_file);
					}
					sprintf (str_to_write, "\n");
					fputs (str_to_write, part_file);
				} else {
					long to_put_size = sizeof (DocRele) * it->second.size ();
					DocRele *to_put = (DocRele*) malloc (to_put_size), *to_put_ptr = to_put;
					printf ("same docs for %ld: ", doc_id_i);
					for (std::deque<DocRele>::const_iterator same_docs_iter = it->second.begin (); same_docs_iter != it->second.end (); same_docs_iter++, to_put_ptr++) {
						to_put_ptr->DocId = same_docs_iter->DocId;
						to_put_ptr->Rele  = same_docs_iter->Rele;
						printf ("%ld ",same_docs_iter->DocId);
					}
					printf ("\n"); fflush (stdout);
					aBase->ReplaceAttr (doc_id_i, IDD_SAMEDOCS, to_put, to_put_size);
					free (to_put);
				}
			}
		}
		if (multy_part_work)
			fclose (part_file);
	}

#ifndef	WIN64
	if (old_base)
		delete old_base;
	if (aBase)
		delete aBase;
#endif

	return 0;
}

int MemoryError ( )
{
	printf ( "Memory error" );
	exit (EXIT_FAILURE);
	return 0;
}

void cdecl OkBox ( char *s1, char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);

}

void cdecl OkBox ( const char *s1, const char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}
