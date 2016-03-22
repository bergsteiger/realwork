#include "shared/Core/fix/mpcxc.h"

#include "shared/Core/sys/AutoInit.h"
#include "shared/Morpho/Facade/Factory.h"
#include "shared/ContextSearch/Common/Constants.h"

#include <cstdio>
#include <cstdlib>
#include "ace/OS.h"

#include "garantPIL/implementation/component/cpp/libs/gkdb/src/DBComm.h"

#include "garutils.h"
#include "stdbase.h"
#include "recode.h"
#include <locale.h>

#include "StorableSplaySet.h"
#include "pack.h"

#include "boost/algorithm/string/split.hpp"
#include "boost/algorithm/string/classification.hpp"

#include "SearchB.h"
#include "ContextPartsHelper.h"

YBase* aBase;

char*	keys[]    = { "Adopted", "Type", "Example", "Codex", "Types", "Belongs", "Rel+", "IgnoreBelongs", "ServiceInfo", "IgnoreGLBelongs", "Prefix", "Exclude", "TypingErrors", "ExcludeRF", "Variants", "MVariants", "HASH", "Laws", "GoodWords", "AnnoIds", "Info", "SimpleSyns", "Exclude3", "Exclude8", "StopLemms", "MPrefixes", "Endings", "SupportWords", "FAdo", "FPre", "FKnd", "FCor", "FCla", "SynDates", "FPub", "FILF", "Izms", "Rel8", "Rel4", "RelY", "PSA", "Kindgctx", "Kindsub", "KindIds", "KindBits", "FPJU", "FPHR", "FPBO", "FPPH", "KindBP", "Docs", "Prak", "Comm", "Form", "Proj", "Inte", "RelChanges", "IgnoreK3Belongs", "AcTr", "KindCorr", "DecisionsArchive", "Hard", "Filters", "ListKinds", "TopLemms", "IndexesChanges", "ImportantAnnos", "NotNormalize", "NormalizerExclude", "BelongsEncyclopedia", "SegmentIndexes", "PercNames", "PhrasalNormalizer", "ImportantAnnos1", "ImportantAnnos2", "sUpd", "sDel", "Bigrams", "BasesList", "MistakesMorpho", "MorphoSyns", "NameSearch", "MainPages", "ListKindsSorted" };
char*	auxkeys[] = { AUX_SYN_ADOPTED, AUX_SYN_TYPE, AUX_SYN_EXAMPLE, AUX_SYN_CODEXES, AUX_SYN_TYPES, AUX_BELONGS, AUX_RELE_PLUS, AUX_IGNORE_BELONGS, AUX_SERV, AUX_IGNORE_GL_BELONGS, AUX_PREFIXES, AUX_EXCLUDE_WORDS, AUX_TYPING_ERRORS, AUX_EXCLUDE_RF, AUX_CONTEXT_EVARIANTS, AUX_CONTEXT_MVARIANTS, AUX_MORPHO_HASHES, AUX_RELEF_LAWS, AUX_ERRORS_GOODWORDS, AUX_ANNO_UIDS, AUX_INFO, AUX_SIMPLE_SYNS, AUX_EXCLUDE_WORDS_3, AUX_EXCLUDE_WORDS_8, AUX_STOP_LEMMS, AUX_MPREFIXES, AUX_ENDINGS, AUX_SUPPORT_WORDS, AUX_fAdo, AUX_fPre, AUX_fKnd, AUX_fCor, AUX_fCla, AUX_SYN_DATES, AUX_fPub, AUX_fILF, AUX_RELE_IZM, AUX_RELE_PLUS8, AUX_RELE_PLUS4, AUX_RELE_Y, AUX_PartsSpeechAnalyzer, AUX_KIND_GCTX, AUX_KIND_BLOCK, AUX_KIND_UIDS, AUX_KIND_BITS, AUX_fPJU, AUX_fPHR, AUX_fPBO, AUX_fPPH, AUX_KIND_BASESEARCH, PR_DOCS, PR_PRACTICE, PR_COMMENTS, PR_FORMS, PR_PROJECTS, PR_INTERS, AUX_RELEVANCY_CHANGES, AUX_IGNORE_K3_BELONGS, PR_ACCOUNTING_TRANSACTION, AUX_KIND_CORRESPONDENTS, AUX_BELONGS_DECISIONSARCHIVE, AUX_HARD, AUX_FILTER_JSONS, AUX_LIST_KINDS, AUX_TOP_LEMMS, AUX_INDEXES_CHANGES, AUX_IMPORTANT_ANNOS, AUX_NOT_NORMALIZE, AUX_NORMALIZER_EXCLUDE, AUX_BELONGS_ENCYCLOPEDIA, AUX_SEGMENT_INDEXES, AUX_PERC, AUX_PHRASAL_NORMALIZER, AUX_IMPORTANT_ANNOS_1, AUX_IMPORTANT_ANNOS_2, "sUpd", "sDel", AUX_BIGRAMS, AUX_BASES_LIST, AUX_MISTAKES_MORPHO, AUX_MORPHO_SYNS, AUX_NAME_SEARCH, AUX_MAIN_PAGES, AUX_LIST_KINDS_SORTED };

std::deque<std::string> file_strings;
void	read_packed_file (const char* filename, bool b_recode = true, bool b_skipemptylines = true)
{
	char str [4096];
	FILE* file = mpcxc_fopen (filename, "rb");
	if (file) {
		char header [4];
		fread (header, sizeof (header), 1, file);
		if (header [0] == 'P' && header [1] == 'K' && header [2] == 3 && header [3] == 4) {
			long packed_size, size;
			fread (&packed_size, sizeof (packed_size), 1, file);
			fread (&size, sizeof (size), 1, file);
			char* packed_buffer = new char [packed_size];
			fread (packed_buffer, packed_size, 1, file);
			fclose (file);
			char *unpacked_buffer = new char [size], *ptr = unpacked_buffer;
			G_UNZIP (packed_buffer, packed_size, unpacked_buffer, size);
			delete [] packed_buffer;
			char str [4096];
			while (ptr - unpacked_buffer < size) {
				char* deli = strchr (ptr, '|');
				if (deli) {
					gk_bzero (str, sizeof (str));
					strncpy (str, ptr, deli - ptr);
					if (b_recode) Recoding (cd_dos,cd_win,str);
					ptr = deli + 1;
					file_strings.push_back (str);
				} else {
					break;
				}
			}
			delete [] unpacked_buffer;
		} else {
			fclose (file);
			file = mpcxc_fopen (filename, "rt");
			if (file) {
				while (!feof (file)) {
					if (!fgets (str, sizeof (str), file))
						break;

					int length = strlen (str);
					while (length && (str [length-1] == 10 || str [length-1] == 13))
						str [--length] = 0;
					if (!length && b_skipemptylines)
						continue;

					if (b_recode) Recoding(cd_dos,cd_win,str);
					file_strings.push_back (str);
				}
				fclose (file);
			}
		}
	}
}

const char*	AuxKey( const char* key )
{
	for (int i = 0; i < sizeof (auxkeys) / sizeof (char*); i++)
		if (!stricmp (key, keys [i]))
			return auxkeys [i];
	return 0;
}

unsigned getMyWord (char *dst, char **src, int &l)
{
	char *to = dst;
	unsigned length = l;
	int bWasWord = 0;

	while(length){
		if( IS_CTX_CHAR_NORMLS_62(*(*src))){
			*to = *(*src)++;
			to++;
			length--;
			bWasWord = 1;
		} else {
			if( bWasWord )
				break;

			(*src)++;
			length--;
		}
	}
	l = length;
	return to-dst;
}

void	syncrypt (char* ptr)
{
	const	char	*from = "јЅ¬√ƒ≈®∆«»… ЋћЌќѕ–—“”‘’÷„Ўў№џЏЁёя";
	const	char	*to   = "#gvnrc$kzh%iyl&maopf(sjt)uedqwx+b";
	while (*ptr) {
		const char*	at = strchr (from, *ptr);
		if (at) {
			int offset = at - from;
			*ptr = *(to + offset);
		}
		ptr++;
	}
}

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

int	this_comp_sames (const void *p1, const void* p2)
{
	SameRele *r1 = (SameRele*) p1, *r2 = (SameRele*) p2;
	int s = r1->Sub - r2->Sub;
	if (s) return s;
	s = r2->Rele - r1->Rele;
	if (s) return s;
	s = r1->ref.DocId - r2->ref.DocId;
	if (s) return s;
	return r1->ref.Sub - r2->ref.Sub;
}

int main (int argc, char* argv[]) {
	SetUnhandledExceptionFilter (UEF);

	Core::AutoInit init;

	setlocale (LC_ALL, "ru_RU.CP1251");
	if (argc == 1)
		exit (EXIT_FAILURE);

	if (argc == 4 && !stricmp (argv [3], "Arbs"))
		return (EXIT_SUCCESS);

	if (argc < 4 || !stricmp (argv [2], "LargeDocs")) {
		if (!stricmp (argv [2], "tatar")) {
			aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
			Index *aux_index = aBase->FindIndex ("Aux");
			aux_index->Delete (AUX_CODEPAGE);
			Stream *str = aux_index->Open (AUX_CODEPAGE, 1);
			long codepage = CP_TATAR;
			str->Write (&codepage, sizeof (codepage));
			aux_index->Close (str);
			delete aBase;

			exit (EXIT_SUCCESS);
		}

		if (!strcmp (argv [2], "ClearKindCorr")) {
			aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
			aBase->FindIndex ("KindCorr")->KeyCount = 0;
			delete aBase;
			exit (EXIT_SUCCESS);
		}

		if (!strcmp (argv [2], "BaseInfo")) {
			aBase = new YBase (argv [1], ACE_OS_O_RDONLY);
			aBase->IsOk ();
			Stream *str = aBase->FindIndex("Aux")->Open ("Base");
			std::set<std::string> names;
			if (str) {
				long size = str->Length ();
				BaseInfo *data = (BaseInfo*) malloc (size);
				int n = str -> Read (data, size) / sizeof (BaseInfo);
				aBase->FindIndex ("Aux")->Close (str);
				delete aBase;
				for (int i = 0; i < n; i++) {
					if (!data [i].BaseId)
						continue;
					char id [16];
					sprintf (id, "%04d:", data [i].BaseId);
					std::string name (id);
					name += data [i].Name;
					name += '|';
					name += data [i].NameEng;
					names.insert (name);
				}
				free (data);
			}
			if (names.size ()) {
				long size = 0;
				std::set<std::string>::const_iterator it;
				for (it = names.begin (); it != names.end (); it++)
					size += it->size () + 1;
				char *data = (char*) malloc (size), *ptr = data;
				for (it = names.begin (); it != names.end (); it++) {
					strcpy (ptr, it->c_str ());
					ptr += strlen (ptr) + 1;
				}

				aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
				Index *aux_index = aBase->FindIndex ("Aux");
				aux_index->Delete (AUX_BASENAMES);
				Stream *str = aux_index->Open (AUX_BASENAMES, 1);
				str->Write (data, size);
				aux_index->Close (str);
				delete aBase;				
			}
			exit (EXIT_SUCCESS);
		}
		if (!strcmp (argv [2], "LargeDocs")) {
			long size = 1024*1024;
			if (argv [3]) size = atol (argv [3]);

			aBase = new YBase (argv [1], ACE_OS_O_RDONLY);
			aBase->IsOk ();
			DocCollection docs;

			AttrKey attrkey = {ID_BORDER, IDD_INFO};
			for (BTIterator it (aBase->FindIndex ("Attrs"), &attrkey); !it.End (); ++it) {
				AttrKey *key = (AttrKey*) it.Key ();
				if (key->AttrTag != IDD_INFO)
					break;
				DocInfo docinfo;
				aBase->FindDocInfo (key->DocId, docinfo);
				if ((docinfo.Status & DS_EVD) && (docinfo.Size >= size))
					docs.Collection::Add (&key->DocId);
			}
			delete aBase;

			aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
			Index *aux_index = aBase->FindIndex ("Aux");
			aux_index->Delete (AUX_LARGE_DOCS);
			if (docs.ItemCount) {
				Stream *str = aux_index->Open (AUX_LARGE_DOCS, 1);
				docs.Put (str);
				aux_index->Close (str);
			}
			delete aBase;				
			exit (EXIT_SUCCESS);
		}
		if (!strcmp (argv [2], "HASH")) {
			aBase = new SearchBase (argv [1]);
			aBase->IsOk ();
			aBase->check_version ();

			std::map<std::string, unsigned long> map_string_hash;
			if (ContextPartsHelper::is_parts ()) {
				GCL::StrVector names;
				ContextPartsHelper::get_context_parts_names (names, false);
				for (GCL::StrVector::const_iterator _it = names.begin (); _it != names.end (); ++_it) {
					Index* index = aBase->FindIndex (_it->c_str ());
					for (BTIterator btit (index); !btit.End (); ++btit) {
						char* key = ((char*) btit.Key ());
						if (*key & 0x80)
							break;
						Stream* str = index->OpenN (key, 1);
						if (str) {
							long size = str->Length ();
							char *data = (char*) malloc (size), *ptr = data+1;
							str->Read (data, size);
							index->Close (str);
							size /= 32;
							for (int i = 0; i < size; i++, ptr += 32) {
								unsigned long hash = hash_str (ptr);
								if (map_string_hash.find (ptr) == map_string_hash.end ())
									map_string_hash.insert (std::map<std::string,unsigned long>::value_type (ptr, hash));
							}
							gk_free (data);
						}
					}
				}
			} else {
				Index* index = aBase->FindIndex ("NWCntxt");
				for (BTIterator btit (index); !btit.End (); ++btit) {
					char* key = ((char*) btit.Key ());
					if (*key & 0x80)
						break;
					Stream* str = index->OpenN (key, 1);
					if (str) {
						long size = str->Length ();
						char *data = (char*) malloc (size), *ptr = data+1;
						str->Read (data, size);
						index->Close (str);
						size /= 32;
						for (int i = 0; i < size; i++, ptr += 32) {
							unsigned long hash = hash_str (ptr);
							map_string_hash.insert (std::map<std::string,unsigned long>::value_type (ptr, hash));
						}
						gk_free (data);
					}
				}
			}
			delete aBase;
			long size = 0;
			std::map<std::string, unsigned long>::const_iterator it;
			for (it = map_string_hash.begin (); it != map_string_hash.end (); it++)
				size += it->first.size () + sizeof (unsigned long) + 1;
			char *data = (char*) malloc (size), *ptr = data;
			for (it = map_string_hash.begin (); it != map_string_hash.end (); it++) {
				strcpy (ptr, it->first.c_str ());
				ptr += it->first.size () + 1;
				memcpy (ptr, &it->second, sizeof (unsigned long));
				ptr += sizeof (unsigned long);
			}
			aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
			Index *aux_index = aBase->FindIndex ("Aux");
			aux_index->Delete (AUX_MORPHO_HASHES);
			Stream *str = aux_index->Open (AUX_MORPHO_HASHES, 1);
			str->Write (data, size);
			aux_index->Close (str);
			delete aBase;

			exit (EXIT_SUCCESS);
		} else {
			exit (EXIT_SUCCESS);
		}
	}

	if (!strcmp (argv [2], "PackedNewCorr")) {
		long packed = atol (argv [3]);
		aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		Index *aux_index = aBase->FindIndex ("Aux");
		aux_index->Delete (AUX_PACKED_NEWCORR);
		Stream *str = aux_index->Open (AUX_PACKED_NEWCORR, 1);
		if (str) {
			str->Write (&packed, sizeof (packed));
			aux_index->Close (str);
		}
		delete aBase;

		exit (EXIT_SUCCESS);
	}

	if (!strncmp (argv [2], "Prt", 3)) {
		read_packed_file (argv [3], false, false);
		std::vector<long> docs;
		for (std::deque<std::string>::const_iterator str_it = file_strings.begin (); str_it != file_strings.end (); str_it++) {
			if (0 == str_it->size ())
				break;
			docs.push_back (atol (str_it->c_str ()));
		}
		if (docs.size ()) {
			aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
			Stream *str = aBase->FindIndex ("Aux")->Open (argv [2], 1);
			if (str) {
				str->Write (&docs [0], docs.size () * sizeof (long));
				aBase->FindIndex ("Aux")->Close (str);
			}
			delete aBase;
		}
		exit (EXIT_SUCCESS);
	}
	
	if (!strcmp (argv [2], "Parts")) {
		long parts = atol (argv [3]);
		aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		Index *aux_index = aBase->FindIndex ("Aux");
		aux_index->Delete (AUX_PARTS);
		Stream *str = aux_index->Open (AUX_PARTS, 1);
		if (str) {
			str->Write (&parts, sizeof (parts));
			aux_index->Close (str);
		}
		delete aBase;

	}

	if (!stricmp (argv [2], "Protection")) {
		char* code = new char [std::max<long> (48, strlen (argv [3]) + 1)];
		gk_bzero (code, 48);
		strcpy (code, argv [3]);

		aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		Index *aux_index = aBase->FindIndex ("Aux");

		for (int i = 0; i < 48 / 4; i++) {
			char key [5];
			sprintf (key, "PRO%X", i);
			Stream* str = aux_index->Open (key, 1);
			if (str) {
				str->Write (code + i * 4, 4);
				aux_index->Close (str);
			}
		}

		delete aBase;
		exit (EXIT_SUCCESS);
	}

	if (!stricmp (argv [2], "Percents")) {
		aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		Index *aux_index = aBase->FindIndex ("Aux");

		long count = atol (argv [3]), i;
		for (i = 0; i < count; i++) {
			char key [5];
			sprintf (key, "%%%%%%%X", i);
			Stream* str = aux_index->Open (key, 1);
			if (str) {
				long perc = 0;
				str->Write (&perc, sizeof (perc));
				aux_index->Close (str);
			}
		}

		delete aBase;
		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [2], "TmOn")) {
		long days = atol (argv [3]);
		aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		Index *aux_index = aBase->FindIndex ("Aux");
		aux_index->Delete (AUX_TIME_ONLINECHECKING);
		Stream *str = aux_index->Open (AUX_TIME_ONLINECHECKING, 1);
		if (str) {
			str->Write (&days, sizeof (days));
			aux_index->Close (str);
		}
		delete aBase;

		exit (EXIT_SUCCESS);
	}

	if (!stricmp (argv [2], "TMWR")) {
		long days = atol (argv [3]);
		aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		Index *aux_index = aBase->FindIndex ("Aux");
		aux_index->Delete ("TMWR");
		Stream *str = aux_index->Open ("TMWR", 1);
		if (str) {
			str->Write (&days, sizeof (days));
			aux_index->Close (str);
		}
		delete aBase;

		exit (EXIT_SUCCESS);
	}

	if (!stricmp (argv [2], "VIP")) {
		aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		long vip = atol (argv [3]);
		Index *aux_index = aBase->FindIndex ("Aux");
		aux_index->Delete (AUX_VIP);
		Stream *str = aux_index->Open (AUX_VIP, 1);
		if (str) {
			str->Write (&vip, sizeof (vip));
			aux_index->Close (str);
		}
		delete aBase;

		exit (EXIT_SUCCESS);
	}
	if (!strcmp (argv [2], "Version")) {
		long version = atol (argv [3]);
		aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		Index *aux_index = aBase->FindIndex ("Aux");
		aux_index->Delete (AUX_VERSION);
		Stream *str = aux_index->Open (AUX_VERSION, 1);
		if (str) {
			str->Write (&version, sizeof (version));
			aux_index->Close (str);
		}
		delete aBase;

		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [2], "InternetBase")) {
		long version = atol (argv [3]);
		aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		Index *aux_index = aBase->FindIndex ("Aux");
		if (version) {
			Stream *str = aux_index->Open (AUX_INTERNET_BASE, 1);
			if (str) {
				str->Write (&version, sizeof (version));
				aux_index->Close (str);
			}
		} else {
			aux_index->Delete (AUX_INTERNET_BASE);
		}
		delete aBase;

		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [2], "AnalyseMask")) {
		u_int64_t mask = _atoi64 (argv [3]);
		aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		Index *aux_index = aBase->FindIndex ("Aux");
		aux_index->Delete (AUX_KIND_ANALYSEMASK);
		Stream *str = aux_index->Open (AUX_KIND_ANALYSEMASK, 1);
		if (str) {
			str->Write (&mask, sizeof (mask));
			aux_index->Close (str);
		}
		delete aBase;

		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [3], "Indexes")) {
		read_packed_file (argv [2], false, false);
		file_strings.push_back ("");

		YBase *base = new YBase (argv [1], ACE_OS_O_RDONLY);
		base->IsOk ();
		const char *hindex_names [] = {"Type", "Adopted", "Class", "Territory", "Kind", "KeyWord", "PublishedIn", "ServiceInfo", "LekForm", "Chapter", "PhFirm", "PhCountry", "RegStatus", "PhGroup", "Atc", "Mkb"};
		for (int index = 0; index < sizeof (hindex_names) / sizeof (char*); index++) {
			std::map<long,std::string> map_id_name;
			const char* index_name = hindex_names [index];
			std::string add_string ("[");
			add_string += index_name;
			add_string += "]";
			file_strings.push_back (add_string);

			printf ("Processing index %s\n", index_name);
			HIndex *hindex = (HIndex*) base->FindIndex (index_name);
			long b_plus4 = !strcmp (index_name, "KeyWord") ? 0 : 4;

			std::map<long,long> map_id_parentid;
			for (BTIterator btit (hindex); !btit.End (); ++btit) {
				HIndex::HIndexKey *key = (HIndex::HIndexKey*) btit.Key ();
				map_id_parentid.insert (std::map<long,long>::value_type (key->id, key->parent));
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
				add_string = name;
				add_string += "=";
				add_string += index_name;
				add_string += ":";
				add_string += name;
				file_strings.push_back (add_string);
			}
			file_strings.push_back ("");
		}
		const char *index_names [] = {"Category", "AnnoDate", "Tag", "IntName", "TradeName", "RCode"};
		for (int index = 0; index < sizeof (index_names) / sizeof (char*); index++) {
			const char* index_name = index_names [index];
			std::string add_string ("[");
			add_string += index_name;
			add_string += "]";
			file_strings.push_back (add_string);

			printf ("Processing index %s\n", index_name);
			for (BTIterator btit (base->FindIndex (index_name)); !btit.End (); ++btit) {
				std::string name;
				if (!strcmp (index_name, "AnnoDate")) {
					char str [16];
					date adate = *(date*) btit.Key ();
					sprintf (str, "%02ld/%02ld/%04ld", adate.da_day, adate.da_mon, adate.da_year);
					name = str;
				} else {
					char *key = (char*) btit.Key ();
					if (strchr (key, '\\'))
						continue;
					name = key;
				}
				add_string = name;
				add_string += "=";
				add_string += index_name;
				add_string += ":";
				add_string += name;
				file_strings.push_back (add_string);
			}
			file_strings.push_back ("");
		}

		delete base;

		base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		Stream *str = base->FindIndex ("Aux")->Open (AUX_INDEXES_SYNS, 1);
		if (str) {
			for (std::deque<std::string>::const_iterator str_it = file_strings.begin (); str_it != file_strings.end (); str_it++)
				str->Write (str_it->c_str (), str_it->size () + 1);
			str->Trunc ();
			base->FindIndex ("Aux")->Close (str);
		}
		delete base;

		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [3], "Tags")) {
		read_packed_file (argv [2]);
		if (file_strings.size ()) {
			YBase *base = new YBase (argv [1], ACE_OS_O_RDONLY);
			base->IsOk ();
			DocCollection *alltopics = base->AllTopics (ID_BORDER);
			delete base;

			std::map<std::string,RefwWeightCollection*> map_tag_refs;
			std::map<long, std::deque<std::string> > map_doc_tags;
			for (std::deque<std::string>::const_iterator it = file_strings.begin (); it != file_strings.end (); it++) {
				char str [2048];
				strcpy (str, it->c_str ());

				char *tag = strchr (str, ';');
				if (!tag)
					continue;
				char *weight = strrchr (str, ';');
				if (weight == tag)
					continue;

				*tag++ = 0;
				*weight++ = 0;

				RefwWeight ref;
				sscanf (str, "%ld.%ld", &ref.DocId, &ref.Sub);
				if (alltopics->IndexOf (&ref.DocId) == -1)
					continue;

				ref.Weight = atol (weight);

				std::map<std::string,RefwWeightCollection*>::iterator map_it = map_tag_refs.find (tag);
				if (map_it == map_tag_refs.end ()) {
					RefwWeightCollection *refs = new RefwWeightCollection;
					refs->Add (&ref);
					map_tag_refs.insert (std::map<std::string,RefwWeightCollection*>::value_type (tag, refs));
				} else {
					map_it->second->Insert (&ref);
				}

				std::string str_tag;
				str_tag += strchr (str, '.') + 1;
				str_tag += ":";
				str_tag += tag;
				str_tag += ":";
				str_tag += weight;
				std::map<long, std::deque<std::string> >::iterator doc_it = map_doc_tags.find (ref.DocId);
				if (doc_it == map_doc_tags.end ()) {
					std::deque<std::string> tags;
					tags.push_back (str_tag);
					map_doc_tags.insert (std::map<long, std::deque<std::string> >::value_type (ref.DocId, tags));
				} else {
					doc_it->second.push_back (str_tag);
				}				
			}

			base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
			base->IsOk ();
			Index *index = base->FindIndex ("Tag.str");
			for (std::map<std::string,RefwWeightCollection*>::iterator map_it = map_tag_refs.begin (); map_it != map_tag_refs.end (); map_it++) {
				char key [TAG_KEY_SIZE];
				strcpy (key, (char*) map_it->first.c_str ());
				Stream *str = index->Open (key, 1);
				if (str) {
					map_it->second->Put (str);
					str->Trunc ();
					index->Close (str);
				}
			}
			for (std::map<long, std::deque<std::string> >::iterator doc_it = map_doc_tags.begin (); doc_it != map_doc_tags.end (); doc_it++) {
				long id = doc_it->first;
				DocInfo docinfo;
				if (base->FindDocInfo (id, docinfo) != sizeof (docinfo))
					continue;
				long size = 0;
				std::deque<std::string>::const_iterator tag_it;
				for (tag_it = doc_it->second.begin (); tag_it != doc_it->second.end (); tag_it++)
					size += tag_it->size () + 1;
				char *data = new char [size], *ptr = data;
				for (std::deque<std::string>::const_iterator tag_it = doc_it->second.begin (); tag_it != doc_it->second.end (); tag_it++, ptr += strlen (ptr) + 1) 
					strcpy (ptr, tag_it->c_str ());
				base->ReplaceAttr (id, IDD_TAG, data, size);
				delete [] data;
			}

			delete base;
		}
		exit (EXIT_SUCCESS);
	}
	
	if (!strcmp (argv [3], "Sames")) {
		read_packed_file (argv [2]);
		if (file_strings.size ()) {
			struct samerele {
				Ref ref;	
				short Rele;
			}__PACKED__;
			std::map<long, std::map <long, std::vector <samerele> > > map_doc_sames;
			for (std::deque<std::string>::const_iterator it = file_strings.begin (); it != file_strings.end (); it++) {
				char str [2048];
				strcpy (str, it->c_str ());
				Ref to_ref, same_ref;
				long rele;
				sscanf (str, "%ld.%ld;%ld.%ld;%ld", &to_ref.DocId, &to_ref.Sub, &same_ref.DocId, &same_ref.Sub, &rele);
				if (to_ref.Sub == 0)
					continue;

				samerele same_rele = {same_ref, (short)(rele & 0xFFFF)};
				if (map_doc_sames.find (to_ref.DocId) == map_doc_sames.end ()) {
					std::vector<samerele> vector_to_insert;
					vector_to_insert.push_back (same_rele);
					std::map<long, std::vector <samerele> > map_to_insert;
					map_to_insert.insert (std::map<long, std::vector<samerele> >::value_type (to_ref.Sub, vector_to_insert));
					map_doc_sames.insert (std::map<long, std::map <long, std::vector<samerele> > >::value_type (to_ref.DocId, map_to_insert));
				} else {
					std::map<long, std::map <long, std::vector< samerele> > >::iterator map_it = map_doc_sames.find (to_ref.DocId);
					if (map_it->second.find (to_ref.Sub) == map_it->second.end ()) {
						std::vector<samerele> vector_to_insert;
						vector_to_insert.push_back (same_rele);
						map_it->second.insert (std::map <long, std::vector< samerele> >::value_type (to_ref.Sub, vector_to_insert));
					} else {
						map_it->second.find (to_ref.Sub)->second.push_back (same_rele);
					}
				}
			}

			StdBigBase* base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
			for (std::map<long, std::map <long, std::vector<samerele> > >::const_iterator doc_it = map_doc_sames.begin (); doc_it != map_doc_sames.end (); doc_it++) {
				long id = doc_it->first;
				DocInfo docinfo;
				if (base->FindDocAttr (id, IDD_INFO, &docinfo, sizeof (docinfo)) != sizeof (docinfo))
					continue;
				base->DelAttr (id, IDD_SAMES);
				for (std::map <long, std::vector<samerele> >::const_iterator sub_it = doc_it->second.begin (); sub_it != doc_it->second.end (); sub_it++) {
					long i = 0, count = sub_it->second.size ();
					SameRele *sames = new SameRele [count], *ptr = sames;
					for (std::vector<samerele>::const_iterator same_it = sub_it->second.begin (); same_it != sub_it->second.end (); same_it++, ptr++) {
						ptr->Sub = sub_it->first;
						ptr->ref = same_it->ref;
						ptr->Rele = same_it->Rele;
					}
					qsort (sames, count, sizeof (SameRele), this_comp_sames);
					std::map<long, std::set<long> > was;
					for (ptr = sames, i = 0; i < count; i++, ptr++) {
						std::map<long, std::set<long> >::iterator map_it = was.find (ptr->Sub);
						if (map_it == was.end () || map_it->second.find (ptr->ref.DocId) == map_it->second.end ()) {
							base->PutAttr (id, IDD_SAMES, ptr, sizeof (SameRele));
							if (map_it == was.end ()) {
								std::set<long> toinsert;
								toinsert.insert (ptr->ref.DocId);
								was.insert (std::map<long, std::set<long> >::value_type (ptr->Sub, toinsert));
							} else {
								map_it->second.insert (ptr->ref.DocId);
							}
						}
					}
					delete []sames;
				}
			}
			delete base;
		}

		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [3], "Informers")) {
		read_packed_file (argv [2]);

		if (file_strings.size ()) {
			std::map<std::string, std::vector<std::string> > map_informer_reference;
			std::map<std::string, std::vector<Ref> > map_informer_Ref;

			for (std::deque<std::string>::const_iterator it = file_strings.begin (); it != file_strings.end (); it++) {
				char str [2048];
				strcpy (str, it->c_str ());

				if (!strchr (str, ';') || strchr (str, ';') == strrchr (str, ';')) {
					printf ("error in string %s\n", str);
					continue;
				}

				char *left_delimiter = strchr (str, ';'), *right_delimiter = strrchr (str, ';');
				if (left_delimiter && right_delimiter) {
					*left_delimiter = 0; left_delimiter++;
					*right_delimiter = 0; right_delimiter++;
					Ref ref = {atol (right_delimiter), 0};
					if (strchr (right_delimiter, '.'))
						ref.Sub = atol (strchr (right_delimiter, '.')+1);

					if (map_informer_reference.find (str) == map_informer_reference.end ()) {
						std::vector<std::string> vector_string;
						vector_string.push_back (left_delimiter);
						map_informer_reference.insert (std::map<std::string,std::vector<std::string> >::value_type (str, vector_string));

						std::vector<Ref> vector_ref;
						vector_ref.push_back (ref);
						map_informer_Ref.insert (std::map<std::string,std::vector<Ref> >::value_type (str, vector_ref));
					} else {
						std::map<std::string, std::vector<std::string> >::iterator map_informer_reference_it = map_informer_reference.find (str);
						bool found = false;
						for (std::vector<std::string>::const_iterator str_it = map_informer_reference_it->second.begin (); str_it != map_informer_reference_it->second.end () && !found; str_it++)
							found = (*str_it == left_delimiter);
						if (found) {
							printf ("error, duplicated %s:%ld.%ld\n", left_delimiter, ref.DocId, ref.Sub);
						} else {
							map_informer_reference_it->second.push_back (left_delimiter);
							std::map<std::string, std::vector<Ref> >::iterator map_informer_Ref_it = map_informer_Ref.find (str);
							map_informer_Ref_it->second.push_back (ref);
						}
					}
				}
			}

			StdBigBase* base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
			Stream* str = base->FindIndex ("Aux")->Open (AUX_INFORMERS, 1);
			if (str) {
				std::map<std::string,std::vector<std::string> >::const_iterator map_informer_reference_it = map_informer_reference.begin ();
				std::map<std::string,std::vector<Ref> >::const_iterator map_informer_Ref_it = map_informer_Ref.begin ();
				for (; map_informer_reference_it != map_informer_reference.end (); map_informer_reference_it++, map_informer_Ref_it++) {
					std::vector<std::string>::const_iterator str_it = map_informer_reference_it->second.begin ();
					std::vector<Ref>::const_iterator ref_it = map_informer_Ref_it->second.begin ();
					for (; str_it != map_informer_reference_it->second.end (); str_it++, ref_it++) {
						str->Write (map_informer_reference_it->first.c_str (), map_informer_reference_it->first.size () + 1);
						str->Write (str_it->c_str (), str_it->size () + 1);
						str->Write (&(*ref_it), sizeof (Ref));
					}
				}
				str->Trunc ();
				base->FindIndex ("Aux")->Close (str);
			}

			delete base;
		}
		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [3], "InformersEx")) {
		read_packed_file (argv [2]);
		if (file_strings.size ()) {
			std::map<std::string, std::vector<std::string> > map_informer_reference;
			std::map<std::string, std::vector< std::pair <Ref, long> > > map_informer_Ref;

			for (std::deque<std::string>::const_iterator it = file_strings.begin (); it != file_strings.end (); it++) {
				char str [2048];
				strcpy (str, it->c_str ());

				if (!strchr (str, ';') || strchr (str, ';') == strrchr (str, ';')) {
					printf ("error in string %s\n", str);
					continue;
				}

				char *left_delimiter = strchr (str, ';'), *right_delimiter = 0;
				if (left_delimiter) {
					right_delimiter = strchr (left_delimiter + 1, ';');
					if (right_delimiter) {
						*left_delimiter = 0; left_delimiter++;
						*right_delimiter = 0; right_delimiter++;
						Ref ref = {atol (right_delimiter), 0};
						if (strchr (right_delimiter, '.'))
							ref.Sub = atol (strchr (right_delimiter, '.')+1);
						long rele = 10;
						if (strchr (right_delimiter, ';'))
							rele = atol (strchr (right_delimiter, ';') + 1);

						std::pair<Ref,long> ref_rele (ref,rele);

						if (map_informer_reference.find (str) == map_informer_reference.end ()) {
							std::vector<std::string> vector_string;
							vector_string.push_back (left_delimiter);
							map_informer_reference.insert (std::map<std::string,std::vector<std::string> >::value_type (str, vector_string));

							std::vector<std::pair<Ref,long> > vector_ref_rele;
							vector_ref_rele.push_back (ref_rele);
							map_informer_Ref.insert (std::map<std::string,std::vector<std::pair<Ref, long> > >::value_type (str, vector_ref_rele));
						} else {
							std::map<std::string, std::vector<std::string> >::iterator map_informer_reference_it = map_informer_reference.find (str);
							bool found = false;
							for (std::vector<std::string>::const_iterator str_it = map_informer_reference_it->second.begin (); str_it != map_informer_reference_it->second.end () && !found; str_it++)
								found = (*str_it == left_delimiter);
							if (found) {
								printf ("error, duplicated %s:%ld.%ld\n", left_delimiter, ref.DocId, ref.Sub);
							} else {
								map_informer_reference_it->second.push_back (left_delimiter);
								std::map<std::string, std::vector<std::pair<Ref,long> > >::iterator map_informer_Ref_it = map_informer_Ref.find (str);
								map_informer_Ref_it->second.push_back (ref_rele);
							}
						}
					}
				}
			}

			StdBigBase* base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
			Stream* str = base->FindIndex ("Aux")->Open (AUX_INFORMERS_EX, 1);
			if (str) {
				std::map<std::string,std::vector<std::string> >::const_iterator map_informer_reference_it = map_informer_reference.begin ();
				std::map<std::string,std::vector<std::pair<Ref,long> > >::const_iterator map_informer_Ref_it = map_informer_Ref.begin ();
				for (; map_informer_reference_it != map_informer_reference.end (); map_informer_reference_it++, map_informer_Ref_it++) {
					std::vector<std::string>::const_iterator str_it = map_informer_reference_it->second.begin ();
					std::vector<std::pair<Ref,long> >::const_iterator ref_it = map_informer_Ref_it->second.begin ();
					for (; str_it != map_informer_reference_it->second.end (); str_it++, ref_it++) {
						str->Write (map_informer_reference_it->first.c_str (), map_informer_reference_it->first.size () + 1);
						str->Write (str_it->c_str (), str_it->size () + 1);
						str->Write (&(ref_it->first), sizeof (Ref));
						str->Write (&(ref_it->second), sizeof (long));
					}
				}
				str->Trunc ();
				base->FindIndex ("Aux")->Close (str);
			}

			delete base;
		}
		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [3], "Syns")) {
		char str [4096];
		read_packed_file (argv [2]);

		if (file_strings.size ()) {
			std::map<std::string, std::vector<std::string> > map_syn_syns;
			for (std::deque<std::string>::const_iterator it = file_strings.begin (); it != file_strings.end (); it++) {
				strcpy (str, it->c_str ());
				char *left_delimiter = strchr (str, ';');
				if (left_delimiter) {
					*left_delimiter = 0; left_delimiter++;

					std::map<std::string, std::vector<std::string> >::iterator map_it = map_syn_syns.find (str);
					if (map_it == map_syn_syns.end ()) {
						std::vector<std::string> vector_string;
						map_syn_syns.insert (std::map<std::string,std::vector<std::string> >::value_type (str, vector_string));
						map_it = map_syn_syns.find (str);
					}
					//посместить в map_it->second строки
					std::vector<std::string> parts;
					boost::split (parts, left_delimiter, boost::is_any_of (";,"));
					for (int i = 0; i < parts.size (); i++) {
						if (parts.at (i).size ())
							map_it->second.push_back (parts.at (i));
					}
				}
			}

			StdBigBase* base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
			Stream* str = base->FindIndex ("Aux")->Open (AUX_SYNS, 1);
			if (str) {
				for (std::map<std::string,std::vector<std::string> >::const_iterator map_it = map_syn_syns.begin (); map_it != map_syn_syns.end (); map_it++) {
					str->Write (map_it->first.c_str (), map_it->first.size () + 1);
					long count = map_it->second.size ();
					str->Write (&count, sizeof (count));
					for (std::vector<std::string>::const_iterator str_it = map_it->second.begin (); str_it != map_it->second.end (); str_it++)
						str->Write (str_it->c_str (), str_it->size () + 1);
				}
				str->Trunc ();
				base->FindIndex ("Aux")->Close (str);
			}
			delete base;
		}
		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [3], "Morpho")) {
		char str [4096];
		read_packed_file (argv [2]);

		if (file_strings.size ()) {
			std::map<std::string, std::vector<std::string> > map_syn_syns;
			for (std::deque<std::string>::const_iterator it = file_strings.begin (); it != file_strings.end (); it++) {
				strcpy (str, it->c_str ());

				int length = strlen (str);
				while (length && (str [length-1] == 10 || str [length-1] == 13))
					str [--length] = 0;
				if (!length)
					continue;

				char *left_delimiter = strchr (str, ';');
				if (left_delimiter) {
					*left_delimiter = 0; left_delimiter++;
					/*
					for (int i = 0; i < strlen (str); i++)
						if (str [i] == '-')
							str [i] = ' ';
					*/

					std::map<std::string, std::vector<std::string> >::iterator map_it = map_syn_syns.find (str);
					if (map_it == map_syn_syns.end ()) {
						std::vector<std::string> vector_string;
						map_syn_syns.insert (std::map<std::string,std::vector<std::string> >::value_type (str, vector_string));
						map_it = map_syn_syns.find (str);
					}
					//посместить в map_it->second строки
					std::vector<std::string> parts;
					boost::split (parts, left_delimiter, boost::is_any_of (";,"));
					for (int i = 0; i < parts.size (); i++) {
						if (parts.at (i).size ())
							map_it->second.push_back (parts.at (i));
					}
				}
			}

			StdBigBase* base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
			Stream* str = base->FindIndex ("Aux")->Open (AUX_SYN_MORPHO, 1);
			if (str) {
				for (std::map<std::string,std::vector<std::string> >::const_iterator map_it = map_syn_syns.begin (); map_it != map_syn_syns.end (); map_it++) {
					str->Write (map_it->first.c_str (), map_it->first.size () + 1);
					long count = map_it->second.size ();
					str->Write (&count, sizeof (count));
					for (std::vector<std::string>::const_iterator str_it = map_it->second.begin (); str_it != map_it->second.end (); str_it++)
						str->Write (str_it->c_str (), str_it->size () + 1);
				}
				str->Trunc ();
				base->FindIndex ("Aux")->Close (str);
			}
			delete base;
		}
		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [3], "MorphoPattern")) {
		char str [4096];
		read_packed_file (argv [2]);

		if (file_strings.size ()) {
			std::map<std::string, std::vector<std::string> > map_syn_syns;
			for (std::deque<std::string>::const_iterator it = file_strings.begin (); it != file_strings.end (); it++) {
				strcpy (str, it->c_str ());
				WinStrUpr (str);

				int length = strlen (str);
				while (length && (str [length-1] == 10 || str [length-1] == 13))
					str [--length] = 0;
				if (!length)
					continue;

				char *left_delimiter = strchr (str, ';');
				if (left_delimiter) {
					*left_delimiter = 0; left_delimiter++;
					/*
					for (int i = 0; i < strlen (str); i++)
						if (str [i] == '-')
							str [i] = ' ';
					*/

					std::map<std::string, std::vector<std::string> >::iterator map_it = map_syn_syns.find (str);
					if (map_it == map_syn_syns.end ()) {
						std::vector<std::string> vector_string;
						map_syn_syns.insert (std::map<std::string,std::vector<std::string> >::value_type (str, vector_string));
						map_it = map_syn_syns.find (str);
					}
					//посместить в map_it->second строки
					while (*left_delimiter) {
						char* next_delimiter = strchr (left_delimiter, ';');
						if (next_delimiter)
							*next_delimiter = 0;
						map_it->second.push_back (left_delimiter);
						if (!next_delimiter)
							break;
						left_delimiter = next_delimiter + 1;
					}
				}
			}

			StdBigBase* base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
			Stream* str = base->FindIndex ("Aux")->Open (AUX_SYN_MORPHO_PATTERN, 1);
			if (str) {
				for (std::map<std::string,std::vector<std::string> >::const_iterator map_it = map_syn_syns.begin (); map_it != map_syn_syns.end (); map_it++) {
					str->Write (map_it->first.c_str (), map_it->first.size () + 1);
					long count = map_it->second.size ();
					str->Write (&count, sizeof (count));
					for (std::vector<std::string>::const_iterator str_it = map_it->second.begin (); str_it != map_it->second.end (); str_it++)
						str->Write (str_it->c_str (), str_it->size () + 1);
				}
				str->Trunc ();
				base->FindIndex ("Aux")->Close (str);
			}
			delete base;
		}
		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [3], "BlockInvisibleText")) {
		FILE* file = mpcxc_fopen (argv [2], "rt");
		if (file) {
			char str [1024];
			std::map<u_int64_t, std::vector<std::string> > map_ref_texts;
			while (!feof (file)) {
				if (!fgets (str, sizeof (str), file))
					break;

				int length = strlen (str);
				while (length && (str [length-1] == 10 || str [length-1] == 13))
					str [--length] = 0;
				if (!length)
					continue;

				Recoding(cd_dos,cd_win,str);
				char* semi = strchr (str, ':');
				if (semi) {
					*semi = 0;
					semi++;
					if (!strchr (semi, ':'))
						strcat (semi, ":0");
					long doc, sub;
					sscanf (str, "%ld.%ld", &doc, &sub);
					u_int64_t ref = (((u_int64_t) doc) << 32) + sub;
					std::map<u_int64_t, std::vector<std::string> >::iterator it = map_ref_texts.find (ref);
					if (it == map_ref_texts.end ()) {
						std::vector<std::string> texts;
						texts.push_back (semi);
						map_ref_texts.insert (std::map<u_int64_t, std::vector<std::string> >::value_type (ref, texts));
					} else {
						it->second.push_back (semi);
					}
				}
			}
			fclose (file);

			StdBigBase* base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
			base->open_saw_bases (ACE_OS_O_RDWR);
			std::set<long> delattrs;
			long prev_doc = 0;
			std::set<long> blocks;
			for (std::map<u_int64_t, std::vector<std::string> >::const_iterator map_it = map_ref_texts.begin (); map_it != map_ref_texts.end (); map_it++) {
				long doc = (long)((map_it->first >> 32) & 0xFFFFFFFF), block = (long) (map_it->first & 0xFFFFFFFF);
				if (prev_doc != doc) {
					prev_doc = doc;
					blocks.clear ();
					long structs_count;
					DocStruct *org_structs = (DocStruct*) base->LoadAttr (doc, IDD_DOCSTRUCT, structs_count), *structs = org_structs;					
					structs_count /= sizeof (DocStruct);
					if (structs_count == 0) {
						//§Ѓ™гђ•≠в† ≠•в Ґ °†І•
					} else {
						blocks.insert (0);
						for (long i = 0; i < structs_count; i++, structs++) {
							short evd_type = (short) ((structs->m_para_list_type >> 24) & 0xFF);
							if (evd_type == SUBDESCEX_BLOCK)
								blocks.insert (structs->m_para_list_id);
						}
					}
					gk_free (org_structs);
				}
				if (delattrs.find (doc) == delattrs.end ()) {
					base->DelAttr (doc, IDD_HANDHANDMASK);
					delattrs.insert (doc);
				}
				if (blocks.find (block) != blocks.end ()) 
					for (std::vector<std::string>::const_iterator it = map_it->second.begin (); it != map_it->second.end (); it++) {
						char to_write [1024];
						sprintf (to_write, "%ld:%s", block, it->c_str ());
						base->PutAttr (doc, IDD_HANDHANDMASK, to_write, strlen (to_write) + 1);
					}
				else
					printf ("not found block %ld in doc %ld\n", block, doc);
			}
			base->close_saw_bases ();
			delete base;
		}
		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [3], "RegularInvisibleText")) {
		FILE* file = mpcxc_fopen (argv [2], "rt");
		if (file) {
			char str [1024];
			std::map<u_int64_t, std::vector<std::string> > map_ref_texts;
			while (!feof (file)) {
				if (!fgets (str, sizeof (str), file))
					break;

				int length = strlen (str);
				while (length && (str [length-1] == 10 || str [length-1] == 13))
					str [--length] = 0;
				if (!length)
					continue;

				Recoding(cd_dos,cd_win,str);

				char* semi = strchr (str, ':');
				if (semi) {
					*semi = 0;
					semi++;
					if (!strchr (semi, ':'))
						strcat (semi, ":0");
					long doc, sub;
					sscanf (str, "%ld.%ld", &doc, &sub);
					u_int64_t ref = (((u_int64_t) doc) << 32) + sub;
					std::map<u_int64_t, std::vector<std::string> >::iterator it = map_ref_texts.find (ref);
					if (it == map_ref_texts.end ()) {
						std::vector<std::string> texts;
						texts.push_back (semi);
						map_ref_texts.insert (std::map<u_int64_t, std::vector<std::string> >::value_type (ref, texts));
					} else {
						it->second.push_back (semi);
					}
				}
			}
			fclose (file);

			StdBigBase* base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
			base->open_saw_bases (ACE_OS_O_RDWR);

			std::set<long> delattrs;
			long prev_doc = 0;
			StorableSplaySet<SubDesc> blocks;
			for (std::map<u_int64_t, std::vector<std::string> >::const_iterator map_it = map_ref_texts.begin (); map_it != map_ref_texts.end (); map_it++) {
				long doc = (long)((map_it->first >> 32) & 0xFFFFFFFF), sub = (long) (map_it->first & 0xFFFFFFFF);
				if (prev_doc != doc) {
					prev_doc = doc;
					blocks.clear ();
					base->LoadAttr (doc, IDD_SUBS, blocks);
					DocInfo docinfo;
					if (base->FindDocInfo (doc, docinfo)) {
						SubDesc zero_block = {0,0};
						blocks.add (zero_block);
					}
				}
				if (delattrs.find (doc) == delattrs.end ()) {
					base->DelAttr (doc, IDD_HANDMASK);
					delattrs.insert (doc);
				}
				bool found = false;
				for (Point p = blocks.first(); p && !found; blocks.next (p))
					found = blocks(p).Sub == sub;
				if (found)
					for (std::vector<std::string>::const_iterator it = map_it->second.begin (); it != map_it->second.end (); it++) {
						char to_write [1024];
						sprintf (to_write, "%ld:%s", sub, it->c_str ());
						base->PutAttr (doc, IDD_HANDMASK, to_write, strlen (to_write) + 1);
					}
				else
					printf ("not found sub/block %ld in doc %ld\n", sub, doc);
			}
			base->close_saw_bases ();
			delete base;
		}
		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [3], "CalcSearchResults")) {
		StdBigBase* base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		FILE* file = mpcxc_fopen (argv [2], "rt");
		if (file) {
			long seg = 0;
			char request [256], str [4096];
			std::map<std::string, long> map_request_size;
			std::map<std::string, long*> map_request_data;
			while (!feof (file)) {
				if (!fgets (str, sizeof (str), file))
					break;

				int length = strlen (str);
				while (length && (str [length-1] == 10 || str [length-1] == 13))
					str [--length] = 0;
				if (!length)
					continue;

				if (str [0] == '|') {
					if (seg) {
						char str_offsets_name [5], str_results_name [5];
						sprintf (str_offsets_name, "-%03d", seg);
						sprintf (str_results_name, "|%03d", seg);

						Stream *str_offsets = base->FindIndex ("Aux")->Open (str_offsets_name, 1);
						Stream *str_results = base->FindIndex ("Aux")->Open (str_results_name, 1);

						std::map<std::string, long>::const_iterator size_it = map_request_size.begin ();
						std::map<std::string, long*>::const_iterator data_it = map_request_data.begin ();
						for (; size_it != map_request_size.end (); size_it++, data_it++) {
							std::string request_str = size_it->first;
							long size = size_it->second, request_str_size = request_str.size () + 1, str_results_pos = str_results->Tell ();
							str_offsets->Write (&request_str_size, sizeof (long));
							str_offsets->Write (request_str.c_str (), request_str_size);
							str_offsets->Write (&str_results_pos, sizeof (long));

							long* data = data_it->second;
							str_results->Write (data, size);
							delete data;
						}
						str_offsets->Trunc ();
						str_results->Trunc ();
						base->FindIndex ("Aux")->Close (str_offsets);
						base->FindIndex ("Aux")->Close (str_results);

						map_request_size.clear ();
						map_request_data.clear ();
					}
					seg = atol (str+1);
					if (seg == 0)
						break;
				} else {
					char* delimiter = strchr (str, '|');
					*delimiter = 0;
					strcpy (request, str);
					delimiter++;
					long count = atol (delimiter);
					delimiter = strchr (delimiter, ':') + 1;
					long size = count * sizeof (RefwRele) + sizeof (long);
					char* data = new char [size], *ptr = data;
					*(long*) ptr = count;
					ptr += sizeof (long);
					for (int i = 0; i < count; i++) {
						long doc, rele, word;
						sscanf (delimiter, " %ld.%ld.%ld", &doc, &rele, &word);
						delimiter = strchr (delimiter + 1, ' ');
						RefwRele refwrele = {doc,word,(short)(rele & 0xFFFF)};
						memcpy (ptr, &refwrele, sizeof (RefwRele));
						ptr += sizeof (RefwRele);
					}
					map_request_size.insert (std::map<std::string, long>::value_type (request, size));
					map_request_data.insert (std::map<std::string, long*>::value_type (request, (long*)data));
				}
			}
			fclose (file);
		}
		delete base;
		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [2], "ShortListSize")) {
		long listsize = atol (argv [3]);
		aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		Index *aux_index = aBase->FindIndex ("Aux");
		aux_index->Delete (AUX_SHORTLISTSIZE);
		Stream *str = aux_index->Open (AUX_SHORTLISTSIZE, 1);
		if (str) {
			str->Write (&listsize, sizeof (listsize));
			aux_index->Close (str);
		}
		delete aBase;

		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [2], "HotInfoTopic")) {
		long hot_info_topic = atol (argv [3]) + ID_BORDER;
		aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		Index *aux_index = aBase->FindIndex ("Aux");
		aux_index->Delete (AUX_HOTINFOTOPIC);
		Stream *str = aux_index->Open (AUX_HOTINFOTOPIC, 1);
		if (str) {
			str->Write (&hot_info_topic, sizeof (hot_info_topic));
			aux_index->Close (str);
		}
		delete aBase;

		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [2], "HotInfoDoc")) {
		long hot_info_topic = atol (argv [3]);
		aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		Index *aux_index = aBase->FindIndex ("Aux");
		aux_index->Delete (AUX_HOTINFOTOPIC);
		Stream *str = aux_index->Open (AUX_HOTINFOTOPIC, 1);
		if (str) {
			str->Write (&hot_info_topic, sizeof (hot_info_topic));
			aux_index->Close (str);
		}
		delete aBase;

		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [3], "gctxparalens")) {
		FILE* part_file = mpcxc_fopen (argv [2], "rt");
		StdBigBase *base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		char str [32768];
		if (part_file) while (!feof (part_file)) {
			if (!fgets (str, sizeof (str), part_file))
				break;

			int length = strlen (str);
			while (length && (str [length-1] == 10 || str [length-1] == 13))
				str [--length] = 0;
			if (!length)
				continue;

			long doc_id = atol (str);
			std::vector<long> longs;
			for (char* ptr = strchr (str, ':') + 2; ptr; ) {
				longs.push_back (atol (ptr));
				ptr = strchr (ptr, ' ');
				if (ptr)
					ptr++;
			}
			long* data = new long [longs.size ()], *dataptr = data;
			for (std::vector<long>::const_iterator it = longs.begin (); it != longs.end (); it++, dataptr++)
				*dataptr = *it;
			base->ReplaceAttr (doc_id, IDD_PARAGCTXLENS, data, longs.size () * sizeof (long));
			delete data;
		}
		delete base;

		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [3], "invisiblelens")) {
		FILE* part_file = mpcxc_fopen (argv [2], "rt");
		StdBigBase *base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		char *str = new char [1024*1024];
		if (part_file) while (!feof (part_file)) {
			if (!fgets (str, 1024*1024, part_file))
				break;

			int length = strlen (str);
			while (length && (str [length-1] == 10 || str [length-1] == 13))
				str [--length] = 0;
			if (!length)
				continue;

			long doc_id = atol (str);
			std::vector<long> longs;
			for (char* ptr = strchr (str, ':') + 2; ptr; ) {
				longs.push_back (atol (ptr));
				ptr = strchr (ptr, ':') + 1;
				longs.push_back (atol (ptr) & ContextSearch::POS_TEXT);
				ptr = strchr (ptr, ':') + 1;
				longs.push_back (atol (ptr));
				ptr = strchr (ptr, ' ');
				if (ptr)
					ptr++;
			}
			long* data = new long [longs.size ()], *dataptr = data;
			for (std::vector<long>::const_iterator it = longs.begin (); it != longs.end (); it++, dataptr++)
				*dataptr = *it;
			base->ReplaceAttr (doc_id, IDD_INVISIBLELENS, data, longs.size () * sizeof (long));
			delete data;
		}
		delete [] str;
		delete base;

		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [3], "invisiblereles")) {
		FILE* part_file = mpcxc_fopen (argv [2], "rt");
		StdBigBase *base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		char *str = new char [32*1024*1024];
		if (part_file) while (!feof (part_file)) {
			if (!fgets (str, 32*1024*1024, part_file))
				break;

			int length = strlen (str);
			while (length && (str [length-1] == 10 || str [length-1] == 13))
				str [--length] = 0;
			if (!length)
				continue;

			long doc_id = atol (str);
			std::vector<long> longs;
			for (char* ptr = strchr (str, ':') + 2; ptr; ) {
				longs.push_back (atol (ptr) & ContextSearch::POS_TEXT);
				ptr = strchr (ptr, ':') + 1;
				longs.push_back (atol (ptr));
				ptr = strchr (ptr, ' ');
				if (ptr)
					ptr++;
			}
			long* data = new long [longs.size ()], *dataptr = data;
			for (std::vector<long>::const_iterator it = longs.begin (); it != longs.end (); it++, dataptr++)
				*dataptr = *it;
			base->ReplaceAttr (doc_id, IDD_INVISIBLERELES, data, longs.size () * sizeof (long));
			delete data;
		}
		delete [] str;
		delete base;

		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [3], "invisibleblockslens")) {
		FILE* part_file = mpcxc_fopen (argv [2], "rt");
		StdBigBase *base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		char *str = new char [32*1024*1024];
		if (part_file) while (!feof (part_file)) {
			if (!fgets (str, 32*1024*1024, part_file))
				break;

			int length = strlen (str);
			while (length && (str [length-1] == 10 || str [length-1] == 13))
				str [--length] = 0;
			if (!length)
				continue;

			long doc_id = atol (str), strings_size = 0;
			std::vector<long> longs;
			std::vector<std::string> strings;
			for (char* ptr = strchr (str, ':') + 2; ptr; ) {
				longs.push_back (atol (ptr));
				ptr = strchr (ptr, ':') + 1;
				std::string word (ptr, strchr (ptr, ':') - ptr);
				strings.push_back (word);
				strings_size += word.size () + 1;
				ptr = strchr (ptr, ':') + 1;
				longs.push_back (atol (ptr) & ContextSearch::POS_TEXT);
				ptr = strchr (ptr, ':') + 1;
				longs.push_back (atol (ptr));
				ptr = strchr (ptr, ' ');
				if (ptr)
					ptr++;
			}
			long total_size = longs.size () * sizeof (long) + strings_size, *data = new long [total_size], *dataptr = data;
			std::vector<std::string>::const_iterator word_ptr = strings.begin ();
			for (std::vector<long>::const_iterator it = longs.begin (); it != longs.end (); word_ptr++) {
				*dataptr++ = *it++;
				char* ptr = (char*) dataptr;
				unsigned char size = (unsigned char) (word_ptr->size () & 0xFF);
				*ptr++ = size;
				memcpy (ptr, word_ptr->c_str (), size);
				ptr += size;
				dataptr = (long*) ptr;
				*dataptr++ = *it++;
				*dataptr++ = *it++;
			}
			base->ReplaceAttr (doc_id, IDD_INVISIBLEBLOCKSLENS, data, total_size);
			delete data;
		}
		delete [] str;
		delete base;

		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [3], "CorrespondentWeight")) {
		read_packed_file (argv [2]);
		RefCollection refs;
		for (std::deque<std::string>::const_iterator filestr_it = file_strings.begin (); filestr_it != file_strings.end (); filestr_it++) {
			char str [128];
			strcpy (str, filestr_it->c_str ());
			char *deli = strchr (str, ';');
			if (!deli)
				continue;
			Ref ref = {atol (str), atol (deli + 1)};
			refs.Add (ref);
		}
		StdBigBase *base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		Stream *str = base->FindIndex ("Aux")->Open (AUX_CORR_WEIGHT, 1);
		if (str) {
			refs.Put (str);
			str->Trunc ();
			base->FindIndex ("Aux")->Close (str);
		} else {
			exit (EXIT_FAILURE);
		}
		delete base;

		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [3], "CorrespondentPairSubWeight")) {
		aBase = new YBase (argv [1], ACE_OS_O_RDONLY);
		aBase->IsOk ();

		read_packed_file (argv [2]);
		std::map<u_int64_t, std::map<u_int64_t, short> > map_ref_corrs;
		for (std::deque<std::string>::const_iterator filestr_it = file_strings.begin (); filestr_it != file_strings.end (); filestr_it++) {
			char str [128];
			strcpy (str, filestr_it->c_str ());
			//10108000.159;55070976.159;2000
			char *deli1 = strchr (str, ';'), *deli2 = deli1 ? strchr (deli1 + 1, ';') : 0;
			if (!deli2)
				continue;
			*deli1++ = 0;
			*deli2++ = 0;
			short weight = (short)(atol (deli2) & 0x7FFF);
			char *dot = strchr (str, '.');
			long to_doc = atol (str);
			u_int64_t key = (((u_int64_t)to_doc) << 32) + (dot ? atol (++dot) : 0);
			dot = strchr (deli1, '.');
			long doc = atol (deli1), sub_block = dot ? atol (++dot) : 0;

			long aIDscount, *aIDs = (long*) aBase->LoadAttrEx (doc, IDD2_PARAIDS, aIDscount), para;
			bool b_ok = false;

			if (aIDscount == 0)
				continue;

			long resps_size = 0;			
			RespRef *resps = (RespRef*) aBase->LoadAttr (doc, IDD_REFS, resps_size);
			if (resps_size) resps_size /= sizeof (RespRef);
			
			//надо перевести sub_block в параграф
			bool b_block = false;
			long structs_count = 0;
			DocStruct *org_structs = (DocStruct*) aBase->LoadAttr (doc, IDD_DOCSTRUCT, structs_count), *structs = org_structs;					
			for (long i = 0; i < structs_count / sizeof (DocStruct) && !b_ok; i++, structs++) {
				short evd_type = (short) ((structs->m_para_list_type >> 24) & 0xFF);
				if (evd_type == SUBDESCEX_BLOCK) {
					long block = structs->m_para_list_id, found = 0;
					if (block == sub_block) {
						b_block = true;

						//найти первый непустой параграф
						Document* document = aBase->GetDoc (doc);
						para = structs->m_start_para;
						for (; para <= structs->m_end_para && para < document->Stat.ParaCount; para++) {
							if (found = document->EVDTextSize (document->GetPara (para)))
								break;
						}
						delete document;

						if (found) {
							para = aIDs [para];
							//есть ли в параграфе ссылка
							for (RespRef *ptr = resps; ptr - resps < resps_size; ptr++) {
								if (ptr->ParaId > para)
									break;
								if (para == ptr->ParaId) {
									if (ptr->DocId == to_doc) {
										b_ok = true;
										break;
									}
								}
							}
						}
					}
				}
			}
			gk_free (org_structs);

			if (!b_block) {
				long subs_size;
				SubDesc *subs_ptr = (SubDesc*) aBase->LoadAttr (doc, IDD_SUBS, subs_size), *s_ptr = subs_ptr;
				for (int sub = 0; sub < subs_size / sizeof (SubDesc); sub++, s_ptr++) {
					long asub = s_ptr->Sub;
					if (asub == sub_block && !(asub & INHERITED_BLOCK)) {
						para = aIDs [s_ptr->Para];

						//есть ли в параграфе ссылка
						for (RespRef *ptr = resps; ptr - resps < resps_size; ptr++) {
							if (ptr->ParaId > para)
								break;
							if (para == ptr->ParaId) {
								if (ptr->DocId == to_doc) {
									b_ok = true;
									break;
								}
							}
						}
						break;
					}
				}
				gk_free (subs_ptr);
			}

			gk_free (aIDs);
			if (!b_ok) //неправильна€ ссылка
				continue;

			u_int64_t add = (((u_int64_t)doc) << 32) + para/*sub_block*/;
			std::map<u_int64_t, std::map<u_int64_t, short> >::iterator map_it = map_ref_corrs.find (key);
			if (map_it == map_ref_corrs.end ()) {
				std::map<u_int64_t, short> to_add;
				to_add.insert (std::map<u_int64_t, short>::value_type (add, weight));
				map_ref_corrs.insert (std::map<u_int64_t, std::map<u_int64_t, short> >::value_type (key, to_add));
			} else {
				std::map<u_int64_t,short>::iterator corr_it = map_it->second.find (add);
				if (corr_it != map_it->second.end ()) {
					corr_it->second = std::max <short> (weight, corr_it->second);
				} else {
					map_it->second.insert (std::map<u_int64_t,short>::value_type (add, weight));
				}
			}
		}
		std::map<u_int64_t, std::map<u_int64_t, short> > new_map_ref_corrs;
		for (std::map<u_int64_t, std::map<u_int64_t,short> >::const_iterator map_it = map_ref_corrs.begin (); map_it != map_ref_corrs.end (); map_it++) {
			std::map<long, std::pair<short, long> > doc_rele_sub_map;
			for (std::map<u_int64_t,short>::const_iterator it = map_it->second.begin (); it != map_it->second.end (); it++) {
				long doc = (long)(it->first >> 32);
				std::map<long, std::pair<short, long> >::iterator best_it = doc_rele_sub_map.find (doc);
				std::pair<short, long> best_pair (it->second, (long)(it->first & 0xFFFFFFFF));
				if (best_it == doc_rele_sub_map.end ()) {
					doc_rele_sub_map.insert (std::map<long, std::pair<short, long> >::value_type (doc, best_pair));
				} else if (best_pair.first > best_it->second.first) {
					best_it->second = best_pair;
				}
			}
			for (std::map<long, std::pair<short, long> >::const_iterator doc_it = doc_rele_sub_map.begin (); doc_it != doc_rele_sub_map.end (); doc_it++) {
				long corr_doc = doc_it->first;
				long corr_sub = doc_it->second.second;
				u_int64_t corr = (((u_int64_t)doc_it->first) << 32) + doc_it->second.second;
				
				std::map<u_int64_t, std::map<u_int64_t,short> >::iterator new_map_it = new_map_ref_corrs.find (map_it->first);
				if (new_map_it == new_map_ref_corrs.end ()) {
					std::map<u_int64_t, short> to_add;
					to_add.insert (std::map<u_int64_t, short>::value_type (corr, doc_it->second.first));
					new_map_ref_corrs.insert (std::map<u_int64_t, std::map<u_int64_t, short> >::value_type (map_it->first, to_add));
				} else {
					new_map_it->second.insert (std::map<u_int64_t, short>::value_type (corr, doc_it->second.first));
				}
			}
		}
		new_map_ref_corrs.swap (map_ref_corrs);
		delete aBase;

		StdBigBase *base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		Stream *str = base->FindIndex ("Aux")->Open (AUX_CORR_PAIR_SUB_WEIGHT, 1);
		if (str) {
			for (std::map<u_int64_t, std::map<u_int64_t,short> >::const_iterator map_it = map_ref_corrs.begin (); map_it != map_ref_corrs.end (); map_it++) {
				u_int64_t key = map_it->first;
				Ref ref = {(long)(key >> 32), (long)(key & 0xFFFFFFFF)};
				str->Write (&ref, sizeof (ref));

				long count = map_it->second.size ();
				str->Write (&count, sizeof (count));
				for (std::map<u_int64_t,short>::const_iterator it = map_it->second.begin (); it != map_it->second.end (); it++) {
					Ref ref = {(long)(it->first >> 32), (long)(it->first & 0xFFFFFFFF)};
					str->Write (&ref, sizeof (ref));
					short weight = it->second;
					str->Write (&weight, sizeof (weight));
				}
			}
			str->Trunc ();
			base->FindIndex ("Aux")->Close (str);
		} else {
			exit (EXIT_FAILURE);
		}
		delete base;

		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [3], "CorrespondentPairWeight")) {
		read_packed_file (argv [2]);
		std::map<u_int64_t, std::set<u_int64_t> > map_ref_corrs;
		for (std::deque<std::string>::const_iterator filestr_it = file_strings.begin (); filestr_it != file_strings.end (); filestr_it++) {
			char str [128];
			strcpy (str, filestr_it->c_str ());
			char *deli1 = strchr (str, ';'), *deli2 = strrchr (str, ';'), *dot = strchr (str, '.');
			if (deli1 == deli2 || !deli2)
				continue;
			u_int64_t key = (((u_int64_t)atol (str)) << 32) + (dot ? atol (dot + 1) : 0);
			u_int64_t add = (((u_int64_t)atol (deli1 + 1)) << 32) + atol (deli2 + 1);
			if (map_ref_corrs.find (key) == map_ref_corrs.end ()) {
				std::set<u_int64_t> to_add;
				to_add.insert (add);
				map_ref_corrs.insert (std::map<u_int64_t, std::set<u_int64_t> >::value_type (key, to_add));
			} else {
				map_ref_corrs.find (key)->second.insert (add);
			}
		}
		StdBigBase *base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		Stream *str = base->FindIndex ("Aux")->Open (AUX_CORR_PAIR_WEIGHT, 1);
		if (str) {
			for (std::map<u_int64_t, std::set<u_int64_t> >::const_iterator map_it = map_ref_corrs.begin (); map_it != map_ref_corrs.end (); map_it++) {
				u_int64_t key = map_it->first;
				Ref ref = {(long)(key >> 32), (long)(key & 0xFFFFFFFF)};
				str->Write (&ref, sizeof (ref));
				long count = map_it->second.size ();
				str->Write (&count, sizeof (count));
				for (std::set<u_int64_t>::const_iterator it = map_it->second.begin (); it != map_it->second.end (); it++) {
					Ref ref = {(long)(*it >> 32), (long)(*it & 0xFFFFFFFF)};
					str->Write (&ref, sizeof (ref));
				}
			}
			str->Trunc ();
			base->FindIndex ("Aux")->Close (str);
		} else {
			exit (EXIT_FAILURE);
		}
		delete base;

		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [3], "CorrespondentPairDocWeight")) {
		read_packed_file (argv [2]);
		std::map<long, std::set<u_int64_t> > map_ref_corrs;
		for (std::deque<std::string>::const_iterator filestr_it = file_strings.begin (); filestr_it != file_strings.end (); filestr_it++) {
			char str [128];
			strcpy (str, filestr_it->c_str ());
			char *deli1 = strchr (str, ';'), *deli2 = strrchr (str, ';');
			if (deli1 == deli2 || !deli2)
				continue;
			long key = atol (str);
			u_int64_t add = (((u_int64_t)atol (deli1 + 1)) << 32) + atol (deli2 + 1);
			if (map_ref_corrs.find (key) == map_ref_corrs.end ()) {
				std::set<u_int64_t> to_add;
				to_add.insert (add);
				map_ref_corrs.insert (std::map<long, std::set<u_int64_t> >::value_type (key, to_add));
			} else {
				map_ref_corrs.find (key)->second.insert (add);
			}
		}
		StdBigBase *base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		Stream *str = base->FindIndex ("Aux")->Open (AUX_CORR_PAIR_DOC_WEIGHT, 1);
		if (str) {
			for (std::map<long, std::set<u_int64_t> >::const_iterator map_it = map_ref_corrs.begin (); map_it != map_ref_corrs.end (); map_it++) {
				long key = map_it->first;
				str->Write (&key, sizeof (key));
				long count = map_it->second.size ();
				str->Write (&count, sizeof (count));
				for (std::set<u_int64_t>::const_iterator it = map_it->second.begin (); it != map_it->second.end (); it++) {
					Ref ref = {(long)(*it >> 32), (long)(*it & 0xFFFFFFFF)};
					str->Write (&ref, sizeof (ref));
				}
			}
			str->Trunc ();
			base->FindIndex ("Aux")->Close (str);
		} else {
			exit (EXIT_FAILURE);
		}
		delete base;

		exit (EXIT_SUCCESS);
	}

	if (!AuxKey (argv [3]))
		exit (EXIT_FAILURE);

	if (!stricmp (AuxKey (argv [3]), AUX_MORPHO_SYNS)) {
		aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		aBase->FindIndex ("Aux")->Delete (AUX_MORPHO_SYNS);
		delete aBase;
	}

	aBase = new YBase (argv [1], ACE_OS_O_RDONLY);
	aBase->IsOk ();

	std::vector<std::string> strings;
	std::map< std::string,GCL::StrSet > syns;
	std::map< std::string,GCL::StrSet >::iterator iter;
	std::vector<std::map< std::string,GCL::StrSet >::iterator> iters;
	std::map<long,long> sortedbelongs_originalbelongs;
	std::set<long> presented_ids, laws_plus;
	std::vector<long> longs;
	std::vector<short> shorts;
	std::vector<u_int64_t> longs64;
	std::map<std::string, std::string> typing_errors;
	std::map<std::string, std::set<std::string> > map_string_strings;
	std::map<std::string, std::set<long> > variants_map;
	std::map<std::string, std::string> map_variant_synvariant;
	std::vector<std::string> variants_vector;

	read_packed_file (argv [2], false);
	long count = 0;

	DBCore::IBase_var obj = DBCore::DBFactory::make (aBase);
	Morpho::Def::ICache_var cache = Morpho::Factory::make ();
	cache->load (obj.in ());

	Morpho::Def::INormalizer_var normalizer = Morpho::Factory::make (cache.in ());

	for (std::deque<std::string>::const_iterator filestr_it = file_strings.begin (); filestr_it != file_strings.end (); filestr_it++) {
		char adopted [4096];
		strcpy (adopted, filestr_it->c_str ());
		if (adopted [0] == ';')
			continue;
		int length = filestr_it->size ();

		if (!stricmp (AuxKey (argv [3]), AUX_IGNORE_BELONGS) || !stricmp (AuxKey (argv [3]), AUX_IGNORE_K3_BELONGS) || !stricmp (AuxKey (argv [3]), AUX_IGNORE_GL_BELONGS)) {
			long belongs = atol (adopted);
			if (belongs)
				presented_ids.insert (belongs);
			continue;
		} else
		if (!stricmp (AuxKey (argv [3]), AUX_MAIN_PAGES) || !stricmp (AuxKey (argv [3]), AUX_RELEF_LAWS) || !stricmp (AuxKey (argv [3]), AUX_RELE_IZM) || !stricmp (AuxKey (argv [3]), AUX_RELE_PLUS8) || !stricmp (AuxKey (argv [3]), AUX_RELE_PLUS4)) {
			long doc_id = atol (adopted);
			if (doc_id) laws_plus.insert (doc_id);
			continue;
		} else
		if (!stricmp (AuxKey (argv [3]), AUX_IMPORTANT_ANNOS) || !stricmp (AuxKey (argv [3]), AUX_IMPORTANT_ANNOS_2)) {
			long doc_id = atol (adopted) + ID_BORDER;
			if (doc_id) laws_plus.insert (doc_id);
			continue;
		} else
		if (!stricmp (AuxKey (argv [3]), AUX_BELONGS_ENCYCLOPEDIA)) {
			short belongs = (short) (atol (adopted) & 0xFFFF);
			shorts.push_back (belongs);
			continue;
		} else
		if (!stricmp (AuxKey (argv [3]), AUX_IMPORTANT_ANNOS_1)) {
			long id = atol (adopted);
			if (id) longs.push_back (id + ID_BORDER);
			continue;
		} else
		if (!stricmp (argv [3], "sUpd") || !stricmp (argv [3], "sDel")) {
			long id = atol (adopted);
			if (id) longs.push_back (id);
		} else
		if (!stricmp (AuxKey (argv [3]), AUX_RELE_Y)) {
			long y = atol (adopted), len = atol (strchr (adopted, ':') + 1);
			longs.push_back (y);
			longs.push_back (len);
			continue;
		} else
		if (!stricmp (AuxKey (argv [3]), AUX_KIND_BITS)) {
			long uid = atol (adopted);
			u_int64_t mask = _atoi64 (strchr (adopted, ':') + 1);
			longs.push_back (uid);
			longs64.push_back (mask);
			continue;
		} else
		if (!stricmp (AuxKey (argv [3]), AUX_BELONGS)) {
			long belongs = atol (adopted);
			if (belongs) {
				count++;
				sortedbelongs_originalbelongs.insert (std::map<long,long>::value_type (count, belongs));
				if (presented_ids.find (belongs) != presented_ids.end ()) {
					printf ("ќЎ»Ѕ ј. Cегмент %ld указан два раза.\n", belongs);
					exit (EXIT_FAILURE);
				}
				presented_ids.insert (belongs);
			}
			continue;
		}

		Recoding (cd_dos,cd_win,adopted);

		if (!stricmp (AuxKey (argv [3]), AUX_MISTAKES_MORPHO)) {
			WinStrUpr (adopted);
			char *deli = strchr (adopted, ':');
			if (!deli) {
				deli = strchr (adopted, ';');
				if (!deli)
					continue;
			}

			*deli++ = 0;
			GCL::StrVector parts;
			boost::split (parts, deli, boost::is_any_of (",;"));

			//Core::Aptr <GCL::StrSet> res = normalizer->execute (adopted, true);
			for (GCL::StrVector::const_iterator it = parts.begin (); it != parts.end (); it++)
				typing_errors.insert (std::map<std::string,std::string>::value_type (*it, adopted/*res->begin()->c_str () + 1*/));

			continue;
		}

		if (!stricmp (AuxKey (argv [3]), AUX_MORPHO_SYNS)) {
			WinStrUpr (adopted);
			char *deli = strchr (adopted, ':');
			if (!deli) {
				deli = strchr (adopted, ';');
				if (!deli)
					continue;
			}

			*deli++ = 0;
			GCL::StrVector parts;
			boost::split (parts, deli, boost::is_any_of (",;"));

			Core::Aptr <GCL::StrSet> res = normalizer->execute (adopted, true);
			for (GCL::StrSet::const_iterator it0 = res->begin (); it0 != res->end (); it0++) {
				for (GCL::StrVector::const_iterator it = parts.begin (); it != parts.end (); it++) {
					Core::Aptr <GCL::StrSet> res2 = normalizer->execute (*it, true);
					for (GCL::StrSet::const_iterator it2 = res2->begin (); it2 != res2->end (); it2++) {
						typing_errors.insert (std::map<std::string,std::string>::value_type (it2->c_str () + 1, it0->c_str () + 1));
					}
				}
			}

			continue;
		}

		if (!stricmp (AuxKey (argv [3]), AUX_SYN_DATES)) {
			char *token = strtok (adopted, ";");
			std::string first (token);
			GCL::StrSet second;
			while (token) {
				second.insert (token);
				token = strtok (0, ";");
			}
			syns.insert (std::map< std::string,GCL::StrSet >::value_type (first, second));
			continue;
		}
		if (!stricmp (AuxKey (argv [3]), AUX_CONTEXT_EVARIANTS)) {
			char *semipos = strchr (adopted, ':'), *word;
			if (!semipos)
				continue;
			int length = semipos - adopted;
			word = new char [length + 1];
			strncpy (word, adopted, length );
			word [length] = '\0';

			std::set<long> docs;
			char *token = strtok (semipos+1, ",");
			while (token) {
				long id = atol (token);
				docs.insert (id);
				token = strtok (0, ",");
			}
			if (docs.size () == 1 && *docs.begin () == 0)
				docs.clear ();

			variants_map.insert (std::map<std::string,std::set<long> >::value_type (word, docs));
			variants_vector.push_back (word);
			continue;
		}
		if (!stricmp (AuxKey (argv [3]), AUX_CONTEXT_MVARIANTS)) {
			char *semipos = strchr (adopted, ':'), *word;
			if (!semipos)
				continue;
			int length = semipos - adopted;
			word = new char [length + 1];
			strncpy (word, adopted, length );
			word [length] = '\0';

			semipos++;
			char *semipos2 = strchr (semipos, ':'), *synword;
			if (!semipos)
				continue;
			int synlength = semipos2 - semipos;
			synword = new char [synlength+1];
			strncpy (synword, semipos, synlength);
			synword [synlength] = '\0';

			std::set<long> docs;
			char *token = strtok (semipos2+1, ",");
			while (token) {
				long id = atol (token);
				docs.insert (id);
				token = strtok (0, ",");
			}
			if (docs.size () == 1 && *docs.begin () == 0)
				docs.clear ();

			variants_map.insert (std::map<std::string,std::set<long> >::value_type (word, docs));
			map_variant_synvariant.insert (std::map<std::string,std::string>::value_type (word, synword));
			variants_vector.push_back (word);

			continue;
		}
		if (!stricmp (AuxKey (argv [3]), AUX_SUPPORT_WORDS)) {
			WinStrUpr (adopted);
			ContextPattern pattern;
			BuildPatternM (pattern, adopted);
			GCL::StrSet words;
			for (int i = 1; i < pattern.WordCount; i++)
				words.insert (pattern.Word [i]);
			syns.insert (std::map<std::string, GCL::StrSet>::value_type (pattern.Word [0], words));
			continue;
		}

		if (!stricmp (AuxKey (argv [3]), AUX_SIMPLE_SYNS)) {
			ContextPattern pattern;
			BuildPatternM (pattern, adopted);
			if (pattern.WordCount == 2) {
				char forma [128], norma [128];
				{
					Core::Aptr <GCL::StrSet> res = normalizer->execute (std::string (pattern.Word [0]), true);
					strcpy (norma, res->begin ()->c_str ());
				} {
					Core::Aptr <GCL::StrSet> res = normalizer->execute (std::string (pattern.Word [1]), true);
					strcpy (forma, res->begin ()->c_str ());
				}

				iter = syns.insert (std::map <std::string, GCL::StrSet >::value_type (norma, GCL::StrSet())).first;
				iter->second.insert (forma);
			}

			continue;
		}

		if (!stricmp (AuxKey (argv [3]), AUX_TYPING_ERRORS) || !strcmp (AuxKey (argv [3]), AUX_ENDINGS) || !strcmp (AuxKey (argv [3]), AUX_SEGMENT_INDEXES)) {
			if (strcmp (AuxKey (argv [3]), AUX_SEGMENT_INDEXES))
				WinStrUpr (adopted);
			char* del_pos = strstr (adopted, " - ");
			if (del_pos) {
				char *left = (char*) malloc (del_pos - adopted + 1);
				gk_bzero (left, del_pos - adopted + 1);
				strncpy (left, adopted, del_pos - adopted);
				typing_errors.insert (std::map<std::string,std::string>::value_type (left, del_pos+3));
				gk_free (left);
			} else {
				ContextPattern pattern;
				BuildPatternM (pattern, adopted);
				typing_errors.insert (std::map<std::string,std::string>::value_type (pattern.Word [0], pattern.Word [1]));
			}
			continue;
		}

		if (!stricmp (AuxKey (argv [3]), AUX_BIGRAMS)) {
			char *right = strchr (adopted, '-');

			WinStrUpr (adopted);
			while (strchr (adopted, ' '))
				*strchr (adopted, ' ') = '|';

			*right = 0;
			right++;

			std::map<std::string, std::set<std::string> >::iterator maps_it = map_string_strings.find (right);
			if (maps_it == map_string_strings.end ()) {
				std::set<std::string> stringss;
				stringss.insert (adopted);
				map_string_strings.insert (std::map<std::string,std::set<std::string> >::value_type (right, stringss));
			} else {
				maps_it->second.insert (adopted);
			}
			
			continue;
		}

		if (!stricmp (AuxKey (argv [3]), AUX_NORMALIZER_EXCLUDE)) {
			WinStrUpr (adopted);
			char* del_pos = strchr (adopted, ';');
			std::string lefts, rights;
			if (del_pos) {
				*del_pos++ = 0;
				lefts = adopted;
				rights = del_pos;
			} else {
				ContextPattern pattern;
				BuildPatternM (pattern, adopted);
				lefts = pattern.Word [0];
				rights = pattern.Word [1];
			}
			std::map<std::string, std::set<std::string> >::iterator maps_it = map_string_strings.find (lefts);
			if (maps_it == map_string_strings.end ()) {
				std::set<std::string> stringss;
				stringss.insert (rights);
				map_string_strings.insert (std::map<std::string,std::set<std::string> >::value_type (lefts, stringss));
			} else {
				maps_it->second.insert (rights);
			}
			continue;
		}

		if (!strcmp (AuxKey (argv [3]), PR_DOCS) || !strcmp (AuxKey (argv [3]), PR_COMMENTS) || !strcmp (AuxKey (argv [3]), PR_FORMS) || !strcmp (AuxKey (argv [3]), PR_PROJECTS) || !strcmp (AuxKey (argv [3]), PR_PRACTICE) || !strcmp (AuxKey (argv [3]), PR_INTERS) || !strcmp (AuxKey (argv [3]), PR_ACCOUNTING_TRANSACTION)) {
			longs64.push_back (_atoi64 (adopted));
		}
		
		if (!stricmp (AuxKey (argv [3]), AUX_KIND_CORRESPONDENTS) || !stricmp (AuxKey (argv [3]), AUX_BELONGS_DECISIONSARCHIVE)) {
			longs.push_back (atol (adopted));
			continue;
		}

		if (!stricmp (AuxKey (argv [3]), AUX_SYN_EXAMPLE) || !stricmp (AuxKey (argv [3]), AUX_RELE_PLUS) || !stricmp (AuxKey (argv [3]), AUX_SERV) || 
			!stricmp (AuxKey (argv [3]), AUX_PREFIXES) || !stricmp (AuxKey (argv [3]), AUX_EXCLUDE_WORDS) || !stricmp (AuxKey (argv [3]), AUX_EXCLUDE_WORDS_3) || 
			!stricmp (AuxKey (argv [3]), AUX_EXCLUDE_WORDS_8) || !strcmp (AuxKey (argv [3]), AUX_EXCLUDE_RF) || !strcmp (AuxKey (argv [3]), AUX_ERRORS_GOODWORDS) || !strcmp (AuxKey (argv [3]), AUX_NOT_NORMALIZE) || !strcmp (AuxKey (argv [3]), AUX_PHRASAL_NORMALIZER) || 
			!strcmp (AuxKey (argv [3]), AUX_ANNO_UIDS) || !strcmp (AuxKey (argv [3]), AUX_KIND_BASESEARCH) || !strcmp (AuxKey (argv [3]), AUX_KIND_UIDS) || !strcmp (AuxKey (argv [3]), AUX_INFO) || !strcmp (AuxKey (argv [3]), AUX_STOP_LEMMS) || 
			!strcmp (AuxKey (argv [3]), AUX_PartsSpeechAnalyzer) || !strcmp (AuxKey (argv [3]), AUX_KIND_GCTX) || !strcmp (AuxKey (argv [3]), AUX_KIND_BLOCK) || 
			!strcmp (AuxKey (argv [3]), AUX_MPREFIXES) || !strcmp (AuxKey (argv [3]), AUX_fPre) || !strcmp (AuxKey (argv [3]), AUX_fKnd) || !strcmp (AuxKey (argv [3]), AUX_fCor) || !strcmp (AuxKey (argv [3]), AUX_fCla) || !strcmp (AuxKey (argv [3]), AUX_fAdo) || !strcmp (AuxKey (argv [3]), AUX_fPub) || !strcmp (AuxKey (argv [3]), AUX_fILF) || !strcmp (AuxKey (argv [3]), AUX_fPJU) || !strcmp (AuxKey (argv [3]), AUX_fPHR) || !strcmp (AuxKey (argv [3]), AUX_fPBO) ||  !strcmp (AuxKey (argv [3]), AUX_fPPH) ||
			!strcmp (AuxKey (argv [3]), AUX_RELEVANCY_CHANGES) || !strcmp (AuxKey (argv [3]), AUX_HARD) || !strcmp (AuxKey (argv [3]), AUX_FILTER_JSONS) || !strcmp (AuxKey (argv [3]), AUX_LIST_KINDS) || !strcmp (AuxKey (argv [3]), AUX_LIST_KINDS_SORTED) || !strcmp (AuxKey (argv [3]), AUX_TOP_LEMMS) || !strcmp (AuxKey (argv [3]), AUX_INDEXES_CHANGES) || !strcmp (AuxKey (argv [3]), AUX_PERC) || !strcmp (AuxKey (argv [3]), AUX_BASES_LIST) ||
			!strcmp (AuxKey (argv [3]), AUX_NAME_SEARCH)) {

			if (!strcmp (AuxKey (argv [3]), AUX_EXCLUDE_WORDS) || !strcmp (AuxKey (argv [3]), AUX_EXCLUDE_RF) || !strcmp (AuxKey (argv [3]), AUX_ERRORS_GOODWORDS) || !strcmp (AuxKey (argv [3]), AUX_NOT_NORMALIZE) || !strcmp (AuxKey (argv [3]), AUX_EXCLUDE_WORDS_3) || !strcmp (AuxKey (argv [3]), AUX_EXCLUDE_WORDS_8) || !strcmp (AuxKey (argv [3]), AUX_RELEVANCY_CHANGES) || !strcmp (AuxKey (argv [3]), AUX_TOP_LEMMS) || !strcmp (AuxKey (argv [3]), AUX_INDEXES_CHANGES)  || !strcmp (AuxKey (argv [3]), AUX_PHRASAL_NORMALIZER) )
				while (strlen (adopted) && adopted [strlen (adopted) - 1] == ' ')
					adopted [strlen (adopted) - 1] = '\0';
			if (!strcmp (AuxKey (argv [3]), AUX_EXCLUDE_RF) || !strcmp (AuxKey (argv [3]), AUX_ERRORS_GOODWORDS) || !strcmp (AuxKey (argv [3]), AUX_NOT_NORMALIZE) || !strcmp (AuxKey (argv [3]), AUX_STOP_LEMMS) || !strcmp (AuxKey (argv [3]), AUX_MPREFIXES) || !strcmp (AuxKey (argv [3]), AUX_HARD) || !strcmp (AuxKey (argv [3]), AUX_PHRASAL_NORMALIZER) || !strcmp (AuxKey (argv [3]), AUX_NAME_SEARCH))
				WinStrUpr (adopted);
			if (strlen (adopted))
				strings.push_back (adopted);
			continue;
		}

		if (!stricmp (AuxKey (argv [3]), AUX_SYN_TYPE)) {
			char* syn = adopted;
			while ( *syn && ( *syn == ' ' || *syn == 9 ))
				syn++;
			for (;;) {
				int len = strlen (syn);
				if (len && syn [len-1] == ' ')
					syn [len-1] = 0;
				else
					break;
			}

			if (adopted [0] == ' ' || adopted [0] == 9) {
				iter->second.insert (syn);
			} else {
				iter = syns.insert (std::map< std::string, GCL::StrSet >::value_type (syn, GCL::StrSet ())).first;
			}

			continue;
		}

		if (!stricmp (AuxKey (argv [3]), AUX_SYN_TYPES) || !stricmp (AuxKey (argv [3]), AUX_SYN_ADOPTED)) {
			char* syn = adopted;
			while ( *syn && ( *syn == ' ' || *syn == 9 ))
				syn++;
			for (;;) {
				int len = strlen (syn);
				if (len && syn [len-1] == ' ')
					syn [len-1] = 0;
				else
					break;
			}

			if (adopted [0] == ' ' || adopted [0] == 9) {
				iter->second.insert (syn);
			} else {
				int	str_len = strlen (syn);
				char* ptr = syn;
				std::string type;
				while (*ptr) {
					char	word [128];
					unsigned wordlen = getMyWord (word, &ptr, str_len);
					if (!wordlen)
						break;
					word [wordlen] = 0;
					WinStrUpr (word);

					Core::Aptr <GCL::StrSet> res = normalizer->execute (std::string (word), false);

					if (type.size ())
						type += " ";

					type += *(res->begin ());
				}

				iter = syns.insert (std::map< std::string, GCL::StrSet >::value_type (type.c_str (), GCL::StrSet ())).first;
			}

			continue;
		}

		GCL::StrVector norm_strs;
		bool	exclam = false, stability = false, frame = false, oneway = false;

		if ( !stricmp( AuxKey( argv[3] ), AUX_SYN_MORPHO ) || !stricmp( AuxKey (argv [3]), AUX_SYN_CODEXES)) {
			char* syn = adopted;
			while ( *syn && ( *syn == ' ' || *syn == 9 ))
				syn++;

			while (syn[0] == '!' || syn[0] == '-' || syn [0] == '~' || syn [0] == '>') {
				if (syn[0] == '!') {
					exclam = true;
					syn++;
				} else if (syn[0] == '-') {
					stability = true;
					syn++;
				} else if (syn [0] == '~') {
					frame = true;
					syn++;
				} else if (syn [0] == '>') {
					oneway = true;
					syn++;
				}
			}

			int	str_len = strlen( syn );
			char* ptr = syn;
			while (*ptr) {
				char	word [128];
				bool b_minus = !stricmp( AuxKey( argv[3] ), AUX_SYN_MORPHO ) && norm_strs.size () && (ptr != syn) && (*(ptr-1) == '-');
				unsigned wordlen = getMyWord (word, &ptr, str_len);
				if (!wordlen)
					break;
				word [wordlen] = 0;
				WinStrUpr (word);

				if (*ptr && *ptr == '!') {
					ptr++;
					str_len--;
					strcat (word, "!");

					if ( norm_strs.size ()) {
						GCL::StrVector new_strs;
						GCL::StrVector::const_iterator it = norm_strs.begin ();
						for ( ; it != norm_strs.end (); it++ ) {
							std::string atit = *it;
							atit += b_minus ? "-" : " ";
							atit += word;
							new_strs.push_back (atit);
						}
						norm_strs.assign (new_strs.begin (), new_strs.end ());
					} else {
						norm_strs.push_back (word);
					}
				} else {
					Core::Aptr <GCL::StrSet> res = normalizer->execute (std::string (word), true);
					GCL::StrSet::const_iterator _it, it_end = res->end ();

					if (norm_strs.size ()) {
						GCL::StrVector new_strs;
						GCL::StrVector::const_iterator it = norm_strs.begin();
						for ( ; it != norm_strs.end(); it++ ) {
							for (_it = res->begin (); _it != it_end; ++_it) {
								std::string atit = *it;
								atit += b_minus ? "-" : " ";
								const char* norma = _it->c_str ();
								if (!stricmp( AuxKey( argv[3] ), AUX_SYN_CODEXES)) {
									if ( *norma & 0x80 )
										atit += word;
									else
										atit += norma+1;
									new_strs.push_back( atit );
								} else {
									if (*norma & 0x80)
										atit += word;
									else
										atit += norma+1;
									new_strs.push_back (atit);
								}
							}
						}
						norm_strs.assign (new_strs.begin (), new_strs.end ());
					} else {
						for (_it = res->begin (); _it != it_end; ++_it) {
							const char* norma = _it->c_str ();
							if (!stricmp (AuxKey (argv [3]), AUX_SYN_CODEXES)) {
								if ( *norma & 0x80 )
									norm_strs.push_back( word );
								else
									norm_strs.push_back( norma+1 );
							} else {
								if (*norma & 0x80) {
									norm_strs.push_back (word);
								} else {
									norm_strs.push_back (norma+1);
								}
							}
						}
					}
				}

				if ( *ptr ) {
					ptr++;
					str_len--;
				}
			}
		}

		if ( adopted[ 0 ] != ' ' && adopted[ 0 ] != 9 ) {
			if ( !stricmp (AuxKey (argv [3]), AUX_SYN_MORPHO)) {
				iters.clear ();
				for ( GCL::StrVector::const_iterator it = norm_strs.begin(); it != norm_strs.end(); it++ ) {
					iter = syns.insert( std::map< std::string, GCL::StrSet >::value_type( *it, GCL::StrSet() )).first;
					for ( GCL::StrVector::const_iterator it2 = norm_strs.begin(); it2 != norm_strs.end(); it2++ )
						iter->second.insert( *it2 );
					iters.push_back (iter);
				}
			} else if (!stricmp( AuxKey( argv[3] ), AUX_SYN_CODEXES)) {
				iter = syns.insert( std::map< std::string, GCL::StrSet >::value_type( *norm_strs.begin(), GCL::StrSet() )).first;
				iter->second.insert( *norm_strs.begin() );
			} else {
				iter = syns.insert( std::map< std::string, GCL::StrSet >::value_type( adopted, GCL::StrSet() )).first;
				iter->second.insert( adopted );
			}
		} else {
			if (!stricmp (AuxKey (argv [3]), AUX_SYN_MORPHO)) {
				for ( GCL::StrVector::const_iterator it = norm_strs.begin(); it != norm_strs.end(); it++ ) {
					if ( exclam || stability || frame) {
						std::string toadd;
						if ( exclam ) toadd += "!";
						if ( stability ) toadd += "-";
						if (frame) toadd += "~";
						toadd += *it;

						if (oneway) {
							for (std::vector<std::map< std::string,GCL::StrSet >::iterator> ::iterator initers = iters.begin (); initers != iters.end (); initers++)
								(*initers)->second.erase ((*initers)->second.begin ());
						}
						for (std::vector<std::map< std::string,GCL::StrSet >::iterator>::iterator initers = iters.begin (); initers != iters.end (); initers++)
							(*initers)->second.insert( toadd );
					} else {
						if (oneway) {
							for (std::vector<std::map< std::string,GCL::StrSet >::iterator> ::iterator initers = iters.begin (); initers != iters.end (); initers++)
								(*initers)->second.erase ((*initers)->second.begin ());
						}
						for (std::vector<std::map< std::string,GCL::StrSet >::iterator> ::iterator initers = iters.begin (); initers != iters.end (); initers++)
							(*initers)->second.insert( *it );
					}
				}
			} else if (!stricmp( AuxKey( argv[3] ), AUX_SYN_CODEXES)) {
				for ( GCL::StrVector::const_iterator it = norm_strs.begin(); it != norm_strs.end(); it++ ) {
					if ( exclam || stability) {
						std::string toadd;
						if ( exclam ) toadd += "!";
						if ( stability ) toadd += "-";
						toadd += *it;
						iter->second.insert( toadd );
					} else {
						iter->second.insert( *it );
					}
				}
			} else {
				char* syn = adopted;
				while( *syn && ( *syn == ' ' || *syn == 9 ))
					syn++;
				if ( *syn ) {
					iter->second.insert( syn );
				}
			}
		}
	}
	if (!stricmp (argv [3], "sUpd") || !stricmp (argv [3], "sDel")) {
		longs.push_back (0x7FFFFFFC);
	}
	delete aBase;

	long size = 0;
	char *data = 0, *ptr;
	if (!stricmp (AuxKey (argv [3]), AUX_CONTEXT_EVARIANTS)) {
		std::map<std::string,std::set<long> >::const_iterator it;
		for (it = variants_map.begin (); it != variants_map.end (); it++)
			size += it->first.size () + 1 + sizeof (long) + it->second.size () * sizeof (long);
		data = (char*) malloc (size);
		ptr = data;
		std::set<std::string> processed_strs;
		for (std::vector<std::string>::const_iterator str_it = variants_vector.begin (); str_it != variants_vector.end (); str_it++) {
			if (processed_strs.find (str_it->c_str ()) == processed_strs.end ()) {
				processed_strs.insert (str_it->c_str ());
				it = variants_map.find (str_it->c_str ());
				if (it != variants_map.end ()) {
					strcpy (ptr, it->first.c_str ());
					ptr += it->first.size () + 1;
					*(long*) ptr = it->second.size ();
					ptr += sizeof (size);
					for (std::set<long>::const_iterator it2 = it->second.begin (); it2 != it->second.end (); it2++) {
						*(long*)ptr = *it2;
						ptr += sizeof (long);
					}
				} else {
					printf ("! %s\n", str_it->c_str ());
				}
			} else {
				printf ("!! %s\n", str_it->c_str ());
			}
		}
	} else if (!stricmp (AuxKey (argv [3]), AUX_CONTEXT_MVARIANTS)) {
		std::map<std::string,std::set<long> >::const_iterator it;
		std::map<std::string,std::string>::const_iterator syn_it = map_variant_synvariant.begin ();
		for (it = variants_map.begin (); it != variants_map.end (); it++, syn_it++)
			size += it->first.size () + 1 + syn_it->second.size () + 1 + sizeof (long) + it->second.size () * sizeof (long);
		data = (char*) malloc (size);
		ptr = data;
		std::set<std::string> processed_strs;
		for (std::vector<std::string>::const_iterator str_it = variants_vector.begin (); str_it != variants_vector.end (); str_it++) {
			if (processed_strs.find (str_it->c_str ()) == processed_strs.end ()) {
				processed_strs.insert (str_it->c_str ());
				it = variants_map.find (*str_it);
				syn_it = map_variant_synvariant.find (*str_it);
				if (it != variants_map.end () && syn_it != map_variant_synvariant.end ()) {
					strcpy (ptr, it->first.c_str ());
					ptr += it->first.size () + 1;

					strcpy (ptr, syn_it->second.c_str ());
					ptr += strlen (ptr) + 1;

					*(long*) ptr = it->second.size ();
					ptr += sizeof (size);
					for (std::set<long>::const_iterator it2 = it->second.begin (); it2 != it->second.end (); it2++) {
						*(long*)ptr = *it2;
						ptr += sizeof (long);
					}
				} else {
					printf ("! %s\n", str_it->c_str ());
				}
			} else {
				printf ("!! %s\n", str_it->c_str ());
			}
		}
		size = ptr - data;
	} else if (!strcmp (AuxKey (argv [3]), AUX_BIGRAMS)) {
		std::map<std::string,std::set<std::string> >::const_iterator map_it;
		for (map_it = map_string_strings.begin (); map_it != map_string_strings.end (); map_it++) {
			size += map_it->first.size () + 1 + sizeof (long);
			for (std::set<std::string>::const_iterator set_it = map_it->second.begin (); set_it != map_it->second.end (); set_it++)
				size += set_it->size () + 1;
		}
		data = (char*) malloc (size);
		ptr = data;
		for (map_it = map_string_strings.begin (); map_it != map_string_strings.end (); map_it++) {
			strcpy (ptr, map_it->first.c_str ());
			ptr += map_it->first.size () + 1;
			long count = map_it->second.size ();
			memcpy (ptr, &count, sizeof (long));
			ptr += sizeof (long);
			for (std::set<std::string>::const_iterator set_it = map_it->second.begin (); set_it != map_it->second.end (); set_it++) {
				strcpy (ptr, set_it->c_str ());
				ptr += set_it->size () + 1;
			}
		}
	} else if (!strcmp (AuxKey (argv [3]), AUX_NORMALIZER_EXCLUDE)) {
		std::map<std::string,std::set<std::string> >::const_iterator map_it;
		for (map_it = map_string_strings.begin (); map_it != map_string_strings.end (); map_it++) {
			for (std::set<std::string>::const_iterator set_it = map_it->second.begin (); set_it != map_it->second.end (); set_it++)
				size += map_it->first.size () + 2 + set_it->size ();
		}
		data = (char*) malloc (size);
		ptr = data;
		for (map_it = map_string_strings.begin (); map_it != map_string_strings.end (); map_it++) {
			for (std::set<std::string>::const_iterator set_it = map_it->second.begin (); set_it != map_it->second.end (); set_it++) {
				strcpy (ptr, map_it->first.c_str ());
				ptr += map_it->first.size () + 1;
				strcpy (ptr, set_it->c_str ());
				ptr += set_it->size () + 1;
			}
		}
	} else if (!stricmp (AuxKey (argv [3]), AUX_TYPING_ERRORS) || !strcmp (AuxKey (argv [3]), AUX_ENDINGS) || !strcmp (AuxKey (argv [3]), AUX_SEGMENT_INDEXES) || !strcmp (AuxKey (argv [3]), AUX_MISTAKES_MORPHO) || !strcmp (AuxKey (argv [3]), AUX_MORPHO_SYNS)) {
		std::map<std::string,std::string>::const_iterator it;
		for (it = typing_errors.begin (); it != typing_errors.end (); it++)
			size += it->first.size () + it->second.size () + 2;
		data = (char*) malloc (size);
		ptr = data;
		for (it = typing_errors.begin (); it != typing_errors.end (); it++) {
			strcpy (ptr, it->first.c_str ());
			ptr += it->first.size () + 1;
			strcpy (ptr, it->second.c_str ());
			ptr += it->second.size () + 1;
		}
	} else if (!stricmp (AuxKey (argv [3]), AUX_MAIN_PAGES) || !stricmp (AuxKey (argv [3]), AUX_RELEF_LAWS) || !stricmp (AuxKey (argv [3]), AUX_RELE_IZM) || !stricmp (AuxKey (argv [3]), AUX_RELE_PLUS8) || !stricmp (AuxKey (argv [3]), AUX_RELE_PLUS4) || !stricmp (AuxKey (argv [3]), AUX_IMPORTANT_ANNOS) || !stricmp (AuxKey (argv [3]), AUX_IMPORTANT_ANNOS_2)) {
		std::set<long>::const_iterator it;
		for (it = laws_plus.begin (); it != laws_plus.end (); it++)
			size += sizeof (long);
		data = (char*) malloc (size);
		long *ptr = (long*) data;
		for (it = laws_plus.begin (); it != laws_plus.end (); it++, ptr++)
			*ptr = *it;
	} else if (!stricmp (AuxKey (argv [3]), AUX_RELE_Y) || !strcmp (AuxKey (argv [3]), AUX_KIND_CORRESPONDENTS) || !stricmp (AuxKey (argv [3]), AUX_BELONGS_DECISIONSARCHIVE) || !stricmp (AuxKey (argv [3]), AUX_IMPORTANT_ANNOS_1) || !stricmp (argv [3], "sUpd") || !stricmp (argv [3], "sDel")) {
		std::vector<long>::const_iterator it;
		for (it = longs.begin (); it != longs.end (); it++)
			size += sizeof (long);
		data = (char*) malloc (size);
		long *ptr = (long*) data;
		for (it = longs.begin (); it != longs.end (); it++, ptr++)
			*ptr = *it;
	} else if (!stricmp (AuxKey (argv [3]), AUX_BELONGS_ENCYCLOPEDIA)) {
		std::vector<short>::const_iterator it;
		for (it = shorts.begin (); it != shorts.end (); it++)
			size += sizeof (short);
		data = (char*) malloc (size);
		short *ptr = (short*) data;
		for (it = shorts.begin (); it != shorts.end (); it++, ptr++)
			*ptr = *it;
	} else if (!strcmp (AuxKey (argv [3]), PR_DOCS) || !strcmp (AuxKey (argv [3]), PR_COMMENTS) || !strcmp (AuxKey (argv [3]), PR_FORMS) || !strcmp (AuxKey (argv [3]), PR_PROJECTS) || !strcmp (AuxKey (argv [3]), PR_PRACTICE) || !strcmp (AuxKey (argv [3]), PR_INTERS) || !strcmp (AuxKey (argv [3]), PR_ACCOUNTING_TRANSACTION)) {
		std::vector<u_int64_t>::const_iterator it;
		for (it = longs64.begin (); it != longs64.end (); it++)
			size += sizeof (u_int64_t);
		data = (char*) malloc (size);
		u_int64_t *ptr = (u_int64_t*) data;
		for (it = longs64.begin (); it != longs64.end (); it++, ptr++)
			*ptr = *it;
	} else if (!stricmp (AuxKey (argv [3]), AUX_KIND_BITS)) {
		size = longs.size () * sizeof (long) + longs64.size () * sizeof (u_int64_t);
		data = (char*) malloc (size);
		char *ptr = (char*) data;

		std::vector<long>::const_iterator long_it = longs.begin ();
		std::vector<u_int64_t>::const_iterator long64_it = longs64.begin ();
		for (; long_it != longs.end (); long_it++, long64_it++) {
			long at_long_it = *long_it;
			memcpy (ptr, &at_long_it, sizeof (long));
			ptr += sizeof (long);
			u_int64_t at_long64_it = *long64_it;
			memcpy (ptr, &at_long64_it, sizeof (u_int64_t));
			ptr += sizeof (u_int64_t);
		}
	} else if (!stricmp (AuxKey (argv [3]), AUX_IGNORE_BELONGS) || !stricmp (AuxKey (argv [3]), AUX_IGNORE_K3_BELONGS) || !stricmp (AuxKey (argv [3]), AUX_IGNORE_GL_BELONGS)) {
		std::set<long>::const_iterator it;
		for (it = presented_ids.begin (); it != presented_ids.end (); it++) {
			char dummy_string [16];
			sprintf (dummy_string, "%ld", *it);
			size += strlen (dummy_string)+1;
		}
		data = (char*) malloc (size), ptr = data;
		for (it = presented_ids.begin (); it != presented_ids.end (); it++) {
			sprintf (ptr, "%ld", *it);
			ptr += strlen (ptr)+1;
		}
	} else if (!stricmp (AuxKey (argv [3]), AUX_BELONGS)) {
		std::map<long,long>::const_iterator it;
		std::map<long,long> originalbelongs_sortedbelongs;
		for (it = sortedbelongs_originalbelongs.begin (); it != sortedbelongs_originalbelongs.end (); it++)
			originalbelongs_sortedbelongs.insert (std::map<long,long>::value_type (it->second, it->first));
		for (int i = 1; i < 256; i++)
			if (presented_ids.find (i) == presented_ids.end ())
				originalbelongs_sortedbelongs.insert (std::map<long,long>::value_type (i, originalbelongs_sortedbelongs.size ()+1));

		for (it = originalbelongs_sortedbelongs.begin (); it != originalbelongs_sortedbelongs.end (); it++) {
			char dummy_string [16];
			sprintf (dummy_string, "%ld", it->first);
			size += strlen (dummy_string)+1;
			sprintf (dummy_string, "%ld", it->second);
			size += strlen (dummy_string)+1;
		}
		data = (char*) malloc (size), ptr = data;
		for (it = originalbelongs_sortedbelongs.begin (); it != originalbelongs_sortedbelongs.end (); it++) {
			sprintf (ptr, "%ld", it->first);
			ptr += strlen (ptr)+1;
			sprintf (ptr, "%ld", it->second);
			ptr += strlen (ptr)+1;
		}
	} else if (!stricmp (AuxKey (argv [3]), AUX_PREFIXES)) {
		aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
		if (aBase->IsPacked ()) {
			printf ("Error, base is packed.\n" );
			delete aBase;
			return -1;
		}
		Index* auxInd = aBase->FindIndex ("Aux");
		for (std::vector<std::string>::const_iterator it = strings.begin (); it != strings.end (); it++) {
			char *at_it = strdup (it->c_str ()), *dots = strchr (at_it, ':');
			int len = strlen (at_it);
			char *key = (char*) malloc (dots-at_it+1);
			strncpy (key, at_it, dots-at_it);
			key [dots-at_it] = '\0';
			char *value = (char*) malloc (at_it+len-dots);
			strncpy (value, dots+1, at_it+len-dots);
			value [at_it+len-dots-1] = '\0';
			gk_free (at_it);

			Stream* str = auxInd->Open (key, 1);
			str->Write (value, strlen (value)+1);
			auxInd->Close (str);
			gk_free (value);
			gk_free (key);
		}
		delete aBase;
		return 0;
	} else if (!strcmp (AuxKey (argv [3]), AUX_ERRORS_GOODWORDS) || !strcmp (AuxKey (argv [3]), AUX_NOT_NORMALIZE) || !strcmp (AuxKey (argv [3]), AUX_STOP_LEMMS) || !strcmp (AuxKey (argv [3]), AUX_MPREFIXES) || !strcmp (AuxKey (argv [3]), AUX_PHRASAL_NORMALIZER) || 
		!strcmp (AuxKey (argv [3]), AUX_PartsSpeechAnalyzer) || !strcmp (AuxKey (argv [3]), AUX_KIND_GCTX) || !strcmp (AuxKey (argv [3]), AUX_KIND_BLOCK) || !strcmp (AuxKey (argv [3]), AUX_HARD) || !strcmp (AuxKey (argv [3]), AUX_FILTER_JSONS) || !strcmp (AuxKey (argv [3]), AUX_NAME_SEARCH)) {
		std::set<std::string> strings_set;
		strings_set.insert (strings.begin (), strings.end ());
		std::set<std::string>::const_iterator siter;
		for (siter = strings_set.begin(); siter != strings_set.end(); siter++ ) {
			size += siter->size () + 1;
		}
		data = (char*) malloc (size), ptr = data;
		for (siter = strings_set.begin (); siter != strings_set.end (); siter++) {
			strcpy (ptr, siter->c_str ());
			ptr += siter->size() + 1;
		}
	} else if (!stricmp (AuxKey (argv [3]), AUX_SYN_EXAMPLE) || !stricmp (AuxKey (argv [3]), AUX_EXCLUDE_WORDS) || !stricmp (AuxKey (argv [3]), AUX_EXCLUDE_WORDS_3 ) || !stricmp (AuxKey (argv [3]), AUX_EXCLUDE_WORDS_8) || !stricmp (AuxKey (argv [3]), AUX_RELE_PLUS) || !stricmp (AuxKey (argv [3]), AUX_SERV) || !stricmp (AuxKey (argv [3]), AUX_EXCLUDE_RF) || !strcmp (AuxKey (argv [3]), AUX_ANNO_UIDS) || !strcmp (AuxKey (argv [3]), AUX_KIND_BASESEARCH) || !strcmp (AuxKey (argv [3]), AUX_KIND_UIDS) || !strcmp (AuxKey (argv [3]), AUX_INFO) || !strcmp (AuxKey (argv [3]), AUX_fCor) || !strcmp (AuxKey (argv [3]), AUX_fKnd) || !strcmp (AuxKey (argv [3]), AUX_fPre) || !strcmp (AuxKey (argv [3]), AUX_fCla) || !strcmp (AuxKey (argv [3]), AUX_fAdo) || !strcmp (AuxKey (argv [3]), AUX_fPub) || !strcmp (AuxKey (argv [3]), AUX_fILF)|| !strcmp (AuxKey (argv [3]), AUX_fPJU)|| !strcmp (AuxKey (argv [3]), AUX_fPHR) || !strcmp (AuxKey (argv [3]), AUX_fPBO) || !strcmp (AuxKey (argv [3]), AUX_fPPH) || !strcmp (AuxKey (argv [3]), AUX_RELEVANCY_CHANGES) || !strcmp (AuxKey (argv [3]), AUX_LIST_KINDS) || !strcmp (AuxKey (argv [3]), AUX_LIST_KINDS_SORTED) || !strcmp (AuxKey (argv [3]), AUX_TOP_LEMMS) || !strcmp (AuxKey (argv [3]), AUX_INDEXES_CHANGES) || !strcmp (AuxKey (argv [3]), AUX_PERC) || !strcmp (AuxKey (argv [3]), AUX_BASES_LIST)) {
		std::vector<std::string>::const_iterator siter;
		for (siter = strings.begin(); siter != strings.end(); siter++ ) {
			size += siter->size () + 1;
		}
		data = (char*) malloc (size), ptr = data;
		for (siter = strings.begin (); siter != strings.end (); siter++) {
			strcpy (ptr, siter->c_str ());
			ptr += siter->size() + 1;
		}
	} else if (!stricmp (AuxKey (argv [3]), AUX_SYN_CODEXES)) {
		for ( iter = syns.begin(); iter != syns.end(); iter++ )
			for ( GCL::StrSet::iterator it2 = iter->second.begin(); it2 != iter->second.end(); it2++ )
				size += (*it2).size() + iter->first.size() + 2;
		data = (char*) malloc (size), ptr = data;
		for ( iter = syns.begin(); iter != syns.end(); iter++ ) {
			GCL::StrSet::iterator it2 = iter->second.begin();
			for ( ; it2 != iter->second.end(); it2++ ) {
				strcpy (ptr, (*it2).c_str());
				ptr += (*it2).size() + 1;
				strcpy (ptr, iter->first.c_str());
				ptr += iter->first.size() + 1;
			}
		}
	} else if (!stricmp (AuxKey (argv [3]), AUX_SYN_TYPES) || !stricmp (AuxKey (argv [3]), AUX_SYN_ADOPTED)) {
		char atol_s [16];
		for ( iter = syns.begin(); iter != syns.end(); iter++ ) {
			size += iter->first.size() + 1;
			sprintf (atol_s, "%ld", iter->second.size ());
			size += strlen (atol_s) + 1;
			for ( GCL::StrSet::iterator it2 = iter->second.begin(); it2 != iter->second.end(); it2++ )
				size += (*it2).size() + 1;
		}
		data = (char*) malloc (size), ptr = data;
		for ( iter = syns.begin(); iter != syns.end(); iter++ ) {
			strcpy (ptr, iter->first.c_str());
			ptr += iter->first.size() + 1;
			sprintf (atol_s, "%ld", iter->second.size ());
			strcpy (ptr, atol_s);
			ptr += strlen (atol_s) + 1;
			for ( GCL::StrSet::iterator it2 = iter->second.begin(); it2 != iter->second.end(); it2++ ) {
				strcpy (ptr, (*it2).c_str());
				ptr += (*it2).size() + 1;
			}
		}
	} else {
		for ( iter = syns.begin(); iter != syns.end(); iter++ ) {
			size += iter->first.size() + 1;
			size += sizeof( long );
			GCL::StrSet::iterator it2 = iter->second.begin();
			for ( ; it2 != iter->second.end(); it2++ ) {
				size += (*it2).size() + 1;
			}
		}
		data = (char*) malloc( size ), ptr = data;
		for ( iter = syns.begin(); iter != syns.end(); iter++ ) {
			strcpy( ptr, iter->first.c_str());
			if (stricmp (AuxKey (argv [3]), AUX_SYN_TYPE) && stricmp (AuxKey (argv [3]), AUX_SIMPLE_SYNS) && stricmp (AuxKey (argv [3]), AUX_SUPPORT_WORDS) && stricmp (AuxKey (argv [3]), AUX_SYN_DATES))
				syncrypt (ptr);

			ptr += iter->first.size() + 1;
			*(long*)ptr = iter->second.size();
			GCL::StrSet::iterator it2 = iter->second.begin();
			ptr += sizeof( long );
			for ( ; it2 != iter->second.end(); it2++ ) {
				strcpy( ptr, (*it2).c_str());
				if (stricmp (AuxKey (argv [3]), AUX_SYN_TYPE) && stricmp (AuxKey (argv [3]), AUX_SIMPLE_SYNS) && stricmp (AuxKey (argv [3]), AUX_SUPPORT_WORDS) && stricmp (AuxKey (argv [3]), AUX_SYN_DATES))
					syncrypt (ptr);
				ptr += (*it2).size() + 1;
			}
		}
	}

	aBase = new StdBigBase( argv[ 1 ], ACE_OS_O_RDWR );
	if (aBase->IsPacked ()) {
		printf ("Error, base is packed.\n" );
		delete aBase;
		return -1;
	}

	Index* auxInd = aBase->FindIndex( "Aux" );
	if (strcmp (AuxKey (argv [3]), AUX_INFO))
		auxInd->Delete (AuxKey (argv [3]));
	Stream* str = auxInd->Open (AuxKey (argv [3]), 1);
	if (str) {
		if (!strcmp (AuxKey (argv [3]), AUX_INFO))
			str->Seek (str->Length ());
		str->Write (data, size);
		auxInd->Close (str);
	}
	free (data);
	delete aBase;

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
