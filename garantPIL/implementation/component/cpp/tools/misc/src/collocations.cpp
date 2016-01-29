#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include "ace/OS.h"

#include "osdep.h"
#include "gardefs.h"
#include "stdbase.h"
#include "btiter.h"
#include "SearchB.h"

#include "SplayMap.h"
#include "SplaySet.h"
#include "StorableSplaySet.h"
#include "u_int32_t.caddr_t.SplayMap.h"
#include "basemask.h"
#include "long.long.SplayMap.h"

#include <utility>
#include <math.h>
#include "shared/ContextSearch/Common/Constants.h"
#include "shared/ContextSearch/Search/Search.h"
#include "garantPIL/implementation/component/cpp/tools/CSAdapter/StreamReader.h"

SearchBase* aBase = 0;

extern	void	BuildPatternMN (ContextPattern&, char*);

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	if (argc < 2)
		return 0;

	SearchBase *base = new SearchBase (argv [1]);
	base->IsOk ();
	base->check_version ();
	delete base->AllDocs ();

	std::set<std::string> stops, stopfirsts;
	if (argv [2]) {
		FILE *stop_file = fopen (argv[2], "rt");
		while (!feof (stop_file)) {
			char str [256];
			if (!fgets (str, sizeof (str), stop_file))
				break;

			char *s = strchr (str, '\n');
			if (s) *s = '\0';
			stops.insert (str);
		}
		fclose (stop_file);
	}
	
	if (argv [3]) {
		FILE *stopfirst_file = fopen (argv[3], "rt");
		while (!feof (stopfirst_file)) {
			char str [256];
			if (!fgets (str, sizeof (str), stopfirst_file))
				break;

			char *s = strchr (str, '\n');
			if (s) *s = '\0';
			stopfirsts.insert (str);
		}
		fclose (stopfirst_file);
	}

	std::set<std::string> lastlemmas;
	if (argv [4]) {
		FILE *lastlemmas_file = fopen (argv[4], "rt");
		while (!feof (lastlemmas_file)) {
			char str [256];
			if (!fgets (str, sizeof (str), lastlemmas_file))
				break;

			char *s = strchr (str, '\n');
			if (s) *s = '\0';
			lastlemmas.insert (str);
		}
		fclose (lastlemmas_file);
	}

	std::set<long> docs;
	if (argv [5]) {
		FILE *docs_file = fopen (argv[5], "rt");
		while (!feof (docs_file)) {
			char str [256];
			if (!fgets (str, sizeof (str), docs_file))
				break;

			char *s = strchr (str, '\n');
			if (s) *s = '\0';
			docs.insert (atol (str));
		}
		fclose (docs_file);
	} else {
		DocCollection *_docs = base->AllDocs ();
		for (int i = 0; i < _docs->ItemCount; i++)
			docs.insert ((*_docs)[i]);
	}

	std::set<std::string> result;
	std::vector<std::string> lemmas;
	std::map<u_int64_t,std::string> pos_lemma;
	std::set<u_int64_t> positions;
	std::map<std::string, long> lemma_counts;
	Index *index = base->FindIndex ("NWCntxt");
	for (BTIterator btit (index); !btit.End (); ++btit) {
		const char* key = (const char*)btit.Key ();
		Stream *str0 = index->Open (key), *str2 = index->OpenN (key, 2);
		if (str0) {
			std::string lemma (key+1);
			if (stops.find (lemma) != stops.end ())
				continue;

			if (key[0] & 0x80)
				lemma += "*";
			lemmas.push_back (lemma);
			long count = 0;

			ContextSearchAdapter::PositionsReader pos_reader (str2, -1, ContextSearch::Morpho::SP_TEXT);
			ContextSearchAdapter::StreamReader str_reader (str0);

			ContextSearch::DBComm::Ref ref = {0,0};
			while (str_reader.get_next (ref)) {
				long doc_id = ref.doc_id;
				ContextSearch::Relevancy::Positions rel_positions;
				pos_reader.get_data (rel_positions, ref, ContextSearch::Morpho::PositionsType::dt_Text);
				if (docs.find (doc_id) == docs.end ())
					continue;

				for (ContextSearch::Relevancy::Positions::const_iterator pos_it = rel_positions.begin (); pos_it != rel_positions.end (); pos_it++) {
					long pos = *pos_it;
					if (pos & ContextSearch::POS_HANDMASK)
						continue;
					pos &= ContextSearch::POS_TEXT;

					u_int64_t pos64 = ((u_int64_t) doc_id << 32) + pos;

					if (positions.find (pos64) == positions.end ()) {
						pos_lemma.insert (std::map<u_int64_t,std::string>::value_type (pos64, lemma));
						positions.insert (pos64);
						count++;
					}
				}
			}

			if (count)
				lemma_counts.insert (std::map<std::string,long>::value_type (lemma, count));
			index->Close (str2);
			index->Close (str0);
		}
	}

	std::map<long, std::vector<std::string> > count_lemmas;
	{
		for (std::map<std::string, long>::const_iterator it = lemma_counts.begin (); it != lemma_counts.end (); it++) {
			long count = it->second;
			if (count_lemmas.find (count) == count_lemmas.end ()) {
				std::vector<std::string> strings;
				strings.push_back (it->first);
				count_lemmas.insert (std::map<long, std::vector<std::string> >::value_type (count, strings));
			} else {
				count_lemmas.find (count)->second.push_back (it->first);
			}
		}
		for (std::map<long, std::vector<std::string> >::reverse_iterator it = count_lemmas.rbegin (); it != count_lemmas.rend (); it++) {
			for (std::vector<std::string>::const_iterator str_it = it->second.begin (); str_it != it->second.end (); str_it++)
				printf ("%s: %ld\n", str_it->c_str (), it->first);
		}
		printf ("\n");
	}

	std::map<std::string, long> pairs_counts;
	for (std::set<u_int64_t>::const_iterator it = positions.begin (); it != positions.end (); it++) {
		std::string pair = pos_lemma.find (*it)->second;
		long doc_id = (long) (*it >> 32);
		std::set<u_int64_t>::const_iterator pair_it = it;
		pair_it++;
		for (int i = 0; i < 5 && pair_it != positions.end (); i++, pair_it++) {
			if (*pair_it >> 32 != doc_id)
				continue;
			if (*pair_it - *it != i+1)
				continue;
			pair += " ";
			pair += pos_lemma.find (*pair_it)->second;
			std::map<std::string, long>::iterator map_it = pairs_counts.find (pair);
			if (map_it == pairs_counts.end ()) {
				pairs_counts.insert (std::map<std::string, long>::value_type (pair, 1));
			} else {
				map_it->second++;
			}			
		}
	}

	std::map<std::string, double> pair_MI;
	std::map<std::string, double> pairs_MI;

	std::set<std::string> pairs;
	double N = positions.size ();
	long pair = 0;
	printf ("Двойки\n");
	for (std::map<std::string, long>::const_iterator map_it = pairs_counts.begin (); map_it != pairs_counts.end (); map_it++, pair++) {
		ContextPattern pattern;
		BuildPatternMN (pattern, (char*) map_it->first.c_str ());
		if (pattern.WordCount == 2) {
			double fX  = lemma_counts.find (pattern.Word [0])->second;
			double fY  = lemma_counts.find (pattern.Word [1])->second;
			double fXY = map_it->second;
			if (fXY == 1 || stopfirsts.find (pattern.Word [0]) != stopfirsts.end ())
				continue;
			double MI = log ( (N * fXY) / (fX * fY)) / log (2.0);
			if (MI < 3.0)
				continue;
			pair_MI.insert (std::map<std::string, double>::value_type (map_it->first, MI));
			pairs_MI.insert (std::map<std::string, double>::value_type (map_it->first, MI));
			pairs.insert (map_it->first);
		}
	}

	std::map<double, std::vector<std::string> > MI_pairs;
	for (std::map<std::string, double>::const_iterator map_it = pair_MI.begin (); map_it != pair_MI.end (); map_it++) {
		std::map<double, std::vector<std::string> >::iterator new_it = MI_pairs.find (map_it->second);
		if (new_it == MI_pairs.end ()) {
			std::vector<std::string> strings;
			strings.push_back (map_it->first);
			MI_pairs.insert (std::map<double, std::vector<std::string> >::value_type (map_it->second, strings));
		} else {
			new_it->second.push_back (map_it->first);
		}
	}

	for (std::map<double, std::vector<std::string> >::reverse_iterator it = MI_pairs.rbegin (); it != MI_pairs.rend (); it++)
		for (std::vector<std::string>::const_iterator str_it = it->second.begin (); str_it != it->second.end (); str_it++)
			printf ("%f: %s - %ld\n", it->first, str_it->c_str (), pairs_counts.find (*str_it)->second);
	printf ("\n");

	//тройки
	std::map<std::string, std::vector<std::string> > pair_triads;
	std::set<std::string> triads;
	pair_MI.clear ();
	for (std::map<std::string, long>::const_iterator map_it = pairs_counts.begin (); map_it != pairs_counts.end (); map_it++, pair++) {
		ContextPattern pattern;
		BuildPatternMN (pattern, (char*) map_it->first.c_str ());
		if (pattern.WordCount == 3) {
			std::string left_pair = pattern.Word [0];
			left_pair += " ";
			left_pair += pattern.Word [1];

			if (pairs.find (left_pair) == pairs.end ())
				continue; //рассматриваем только тройки, у которых левая пара - двойка из этапа 1

			double fX  = pairs_counts.find (left_pair.c_str ())->second;
			double fY  = lemma_counts.find (pattern.Word [2])->second;
			double fXY = map_it->second;

			if (fXY == 1)
				continue;

			double MI = log ( (N * fXY) / (fX * fY) ) / log (2.0);
			if (MI < 3.5)
				continue;

			pair_MI.insert (std::map<std::string, double>::value_type (map_it->first, MI));
			std::map<std::string, std::vector<std::string> >::iterator it = pair_triads.find (left_pair);
			if (it == pair_triads.end ()) {
				std::vector<std::string> triads;
				triads.push_back (map_it->first);
				pair_triads.insert (std::map<std::string, std::vector<std::string> >::value_type (left_pair, triads));
			} else {
				it->second.push_back (map_it->first);
			}
			triads.insert (map_it->first);
		}
	}

	std::map<double, std::vector<std::string> > MI_triads;
	for (std::map<std::string, double>::const_iterator map_it = pair_MI.begin (); map_it != pair_MI.end (); map_it++) {
		std::map<double, std::vector<std::string> >::iterator new_it = MI_triads.find (map_it->second);
		if (new_it == MI_triads.end ()) {
			std::vector<std::string> strings;
			strings.push_back (map_it->first);
			MI_triads.insert (std::map<double, std::vector<std::string> >::value_type (map_it->second, strings));
		} else {
			new_it->second.push_back (map_it->first);
		}
	}

	for (std::map<double, std::vector<std::string> >::reverse_iterator it = MI_triads.rbegin (); it != MI_triads.rend (); it++)
		for (std::vector<std::string>::const_iterator str_it = it->second.begin (); str_it != it->second.end (); str_it++)
			printf ("%f: %s - %ld\n", it->first, str_it->c_str (), pairs_counts.find (*str_it)->second);
	printf ("\n");

	//просеивание двоек
	printf ("Просеивание двоек\n");
	std::map<std::string, double> pair_Kx;
	for (std::map<std::string, std::vector<std::string> >::const_iterator map_it = pair_triads.begin (); map_it != pair_triads.end (); map_it++) {
		double sum = 0, fX = pairs_counts.find (map_it->first)->second;
		for (std::vector<std::string>::const_iterator it = map_it->second.begin (); it != map_it->second.end (); it++) {
			std::string triad = *it;
			double fXZ = pairs_counts.find (triad)->second;
			sum += fXZ;
		}
		double Kx = sum / fX;
		pair_Kx.insert (std::map<std::string, double>::value_type (map_it->first, Kx));
	}

	for (std::map<double, std::vector<std::string> >::reverse_iterator it = MI_pairs.rbegin (); it != MI_pairs.rend (); it++)
		for (std::vector<std::string>::const_iterator str_it = it->second.begin (); str_it != it->second.end (); str_it++) {
			std::map<std::string, double>::const_iterator Kx_it = pair_Kx.find (str_it->c_str ());
			double Kx = 0.0;
			if (Kx_it != pair_Kx.end ()) {
				Kx = Kx_it->second;
				if (Kx > 0.75)
					continue;
			}
			printf ("MI: %f, Kx: %f, %s - %ld\n", it->first, Kx, str_it->c_str (), pairs_counts.find (*str_it)->second);
			char str [128];
			sprintf (str, "%s, f=%ld, MI=%f, Kx=%f", str_it->c_str (), pairs_counts.find (str_it->c_str ())->second, it->first, Kx);
			result.insert (str);
		}	
	printf ("\n");

	//четверки
	std::map<std::string, std::vector<std::string> > triad_quarts;
	pair_MI.clear ();
	std::set<std::string> quarts;
	printf ("Четверки\n");
	for (std::map<std::string, long>::const_iterator map_it = pairs_counts.begin (); map_it != pairs_counts.end (); map_it++, pair++) {
		ContextPattern pattern;
		BuildPatternMN (pattern, (char*) map_it->first.c_str ());
		if (pattern.WordCount == 4) {
			double fXY = map_it->second;
			if (fXY == 1)
				continue;

			std::string left_triad = pattern.Word [0];
			left_triad += " ";
			left_triad += pattern.Word [1];
			left_triad += " ";
			left_triad += pattern.Word [2];

			if (triads.find (left_triad) == triads.end ())
				continue; //рассматриваем только тройки, у которых левая пара - двойка из этапа 1

			double fX = pairs_counts.find (left_triad.c_str ())->second;
			double fY = lemma_counts.find (pattern.Word [3])->second;

			double MI = log ((N * fXY) / (fX * fY)) / log (2.0);
			if (MI < 3.5)
				continue;
			pair_MI.insert (std::map<std::string, double>::value_type (map_it->first, MI));

			std::map<std::string, std::vector<std::string> >::iterator it = triad_quarts.find (left_triad);
			if (it == triad_quarts.end ()) {
				std::vector<std::string> quarts;
				quarts.push_back (map_it->first);
				triad_quarts.insert (std::map<std::string, std::vector<std::string> >::value_type (left_triad, quarts));
			} else {
				it->second.push_back (map_it->first);
			}
			quarts.insert (map_it->first);
		}
	}

	std::map<double, std::vector<std::string> > MI_quarts;
	for (std::map<std::string, double>::const_iterator map_it = pair_MI.begin (); map_it != pair_MI.end (); map_it++) {
		std::map<double, std::vector<std::string> >::iterator new_it = MI_quarts.find (map_it->second);
		if (new_it == MI_quarts.end ()) {
			std::vector<std::string> strings;
			strings.push_back (map_it->first);
			MI_quarts.insert (std::map<double, std::vector<std::string> >::value_type (map_it->second, strings));
		} else {
			new_it->second.push_back (map_it->first);
		}
	}

	for (std::map<double, std::vector<std::string> >::reverse_iterator it = MI_quarts.rbegin (); it != MI_quarts.rend (); it++)
		for (std::vector<std::string>::const_iterator str_it = it->second.begin (); str_it != it->second.end (); str_it++)
			printf ("%f: %s - %ld\n", it->first, str_it->c_str (), pairs_counts.find (*str_it)->second);
	printf ("\n");

	//просеивание троек
	printf ("Просеивание троек\n");
	pair_Kx.clear ();
	for (std::map<std::string, std::vector<std::string> >::const_iterator map_it = triad_quarts.begin (); map_it != triad_quarts.end (); map_it++) {
		double sum = 0, fX = pairs_counts.find (map_it->first)->second;
		for (std::vector<std::string>::const_iterator it = map_it->second.begin (); it != map_it->second.end (); it++) {
			std::string quart = *it;
			double fXZ = pairs_counts.find (quart)->second;
			sum += fXZ;
		}
		double Kx = sum / fX;
		pair_Kx.insert (std::map<std::string, double>::value_type (map_it->first, Kx));
	}

	for (std::map<double, std::vector<std::string> >::reverse_iterator it = MI_triads.rbegin (); it != MI_triads.rend (); it++)
		for (std::vector<std::string>::const_iterator str_it = it->second.begin (); str_it != it->second.end (); str_it++) {
			std::map<std::string, double>::const_iterator Kx_it = pair_Kx.find (str_it->c_str ());
			double Kx = 0.0;
			if (Kx_it != pair_Kx.end ()) {
				Kx = Kx_it->second;
				if (Kx > 0.75)
					continue;
			}
			printf ("MI: %f, Kx: %f, %s - %ld\n", it->first, Kx, str_it->c_str (), pairs_counts.find (*str_it)->second);
			char str [128];
			sprintf (str, "%s, f=%ld, MI=%f, Kx=%f", str_it->c_str (), pairs_counts.find (str_it->c_str ())->second, it->first, Kx);
			result.insert (str);
		}	
	printf ("\n");

	//пятерки
	std::map<std::string, std::vector<std::string> > quart_quints;
	pair_MI.clear ();
	printf ("Пятерки\n");
	for (std::map<std::string, long>::const_iterator map_it = pairs_counts.begin (); map_it != pairs_counts.end (); map_it++, pair++) {
		ContextPattern pattern;
		BuildPatternMN (pattern, (char*) map_it->first.c_str ());
		if (pattern.WordCount == 5) {
			double fXY = map_it->second;
			if (fXY == 1)
				continue;

			std::string left_quart = pattern.Word [0];
			left_quart += " ";
			left_quart += pattern.Word [1];
			left_quart += " ";
			left_quart += pattern.Word [2];
			left_quart += " ";
			left_quart += pattern.Word [3];

			if (quarts.find (left_quart) == quarts.end ())
				continue;

			double fX = pairs_counts.find (left_quart.c_str ())->second;
			double fY = lemma_counts.find (pattern.Word [4])->second;

			double MI = log ((N * fXY) / (fX * fY)) / log (2.0);
			if (MI < 3.5)
				continue;
			pair_MI.insert (std::map<std::string, double>::value_type (map_it->first, MI));

			std::map<std::string, std::vector<std::string> >::iterator it = quart_quints.find (left_quart);
			if (it == quart_quints.end ()) {
				std::vector<std::string> quints;
				quints.push_back (map_it->first);
				quart_quints.insert (std::map<std::string, std::vector<std::string> >::value_type (left_quart, quints));
			} else {
				it->second.push_back (map_it->first);
			}
		}
	}

	std::map<double, std::vector<std::string> > MI_quints;
	for (std::map<std::string, double>::const_iterator map_it = pair_MI.begin (); map_it != pair_MI.end (); map_it++) {
		std::map<double, std::vector<std::string> >::iterator new_it = MI_quints.find (map_it->second);
		if (new_it == MI_quints.end ()) {
			std::vector<std::string> strings;
			strings.push_back (map_it->first);
			MI_quints.insert (std::map<double, std::vector<std::string> >::value_type (map_it->second, strings));
		} else {
			new_it->second.push_back (map_it->first);
		}
	}

	for (std::map<double, std::vector<std::string> >::reverse_iterator it = MI_quints.rbegin (); it != MI_quints.rend (); it++)
		for (std::vector<std::string>::const_iterator str_it = it->second.begin (); str_it != it->second.end (); str_it++) {
			printf ("%f: %s - %ld\n", it->first, str_it->c_str (), pairs_counts.find (*str_it)->second);
			char str [128];
			ContextPattern pattern;
			BuildPatternMN (pattern, (char*) str_it->c_str ());
			if (lastlemmas.find (pattern.Word [4]) != lastlemmas.end ()) {
				sprintf (str, "%s, f=%ld, MI=%f", str_it->c_str (), pairs_counts.find (str_it->c_str ())->second, it->first);
				result.insert (str);
			}
		}
	printf ("\n");

	//просеивание четверок
	printf ("Просеивание четверок\n");
	pair_Kx.clear ();
	for (std::map<std::string, std::vector<std::string> >::const_iterator map_it = quart_quints.begin (); map_it != quart_quints.end (); map_it++) {
		double sum = 0, fX = pairs_counts.find (map_it->first)->second;
		for (std::vector<std::string>::const_iterator it = map_it->second.begin (); it != map_it->second.end (); it++) {
			std::string quint = *it;
			double fXZ = pairs_counts.find (quint)->second;
			sum += fXZ;
		}
		double Kx = sum / fX;
		pair_Kx.insert (std::map<std::string, double>::value_type (map_it->first, Kx));
	}

	for (std::map<double, std::vector<std::string> >::reverse_iterator it = MI_quarts.rbegin (); it != MI_quarts.rend (); it++)
		for (std::vector<std::string>::const_iterator str_it = it->second.begin (); str_it != it->second.end (); str_it++) {
			std::map<std::string, double>::const_iterator Kx_it = pair_Kx.find (str_it->c_str ());
			double Kx = 0.0;
			if (Kx_it != pair_Kx.end ()) {
				Kx = Kx_it->second;
				if (Kx > 0.75)
					continue;
			}
			printf ("MI: %f, Kx: %f, %s - %ld\n", it->first, Kx, str_it->c_str (), pairs_counts.find (*str_it)->second);
			char str [128];
			sprintf (str, "%s, f=%ld, MI=%f, Kx=%f", str_it->c_str (), pairs_counts.find (str_it->c_str ())->second, it->first, Kx);
			result.insert (str);
		}	
	printf ("\n");

	printf ("Итоговый результат\n");
	for (std::set<std::string>::const_iterator it = result.begin (); it != result.end (); it++) 
		printf ("%s\n", it->c_str ());
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
