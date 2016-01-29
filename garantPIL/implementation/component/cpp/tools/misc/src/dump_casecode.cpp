#include "ace/ACE.h"
#include "shared/Core/fix/mpcxc.h"

#include "recode.h"
#include "gardefs.h"
#include "garutils.h"
#include "stdbase.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	return main_logic (argc, argv);
}

char shrinked_str [2048];
char*	remove_trash (char* index_str, bool sub = false)
{
	char *toput = shrinked_str, *str = index_str;
	*toput = 0;
	if (sub) str = strchr (str, ':') + 1;
	char *token = strtok (str, "\\");
	while (token) {
		if (toput != shrinked_str) {
			toput++;
			*toput = '\\';
			toput++;
		}
		int length = strlen (token)-4;
		memcpy (toput, token+4, length+1);
		toput += length - 1;
		token = strtok (0, "\\");
	}
	Recoding (cd_win, cd_dos, shrinked_str);
	return shrinked_str;
}

int main_logic ( int argc, char *argv[] )
{
	{
		YBase *base = new YBase (argv [1], ACE_OS_O_RDONLY);
		base->IsOk ();
		char* belongs_strings[256] = {"", "GAR", "CUS", "BAN", "LAN", "REA", "FOR", "GBH", "CRI", "NAL", "PRA", "RUS", "PRI", "ARB", "ARH", "COM", "PRO", "MED", "STR", "FASMO", "BER", "MSP", "ARM", "REM", "MLA", "MME", "NTSS", "MGSN", "SCHEME", "SNAL", "BBB", "ENG", "ENN", "BUS_LAW", "BUS_L_S", "GMM", "ETKS", "ANONS", "GARW", "DEMO", "SPB", "KNG", "NNGARANT", "BASHK", "KAZAN", "UDM", "KURSK", "VOLG", "KURGAN", "PERM", "ROSTOV", "SARAT", "SVR", "TAMB", "TMN", "TVER", "SAMARA", "CHEL", "OMSK", "MRD", "ASTRA", "CHUV", "ULN", "RAZ", "KUBAN", "KRSK", "IRKUT", "NSK", "KEM", "ALT", "TOMSK", "PENZA", "FASCEO", "FASSZO", "FASSKO", "VRN", "KALUGA", "MRE", "ARN_NAL", "KHA", "VLD", "MRL", "OMA", "NOV", "PSK", "VLG", "MRK", "PENSUD", "KIR", "OPPD", "PRM", "HMS", "AGP", "ALTAI", "INPHARM", "SVN", "SVA", "NNPRA", "NNARH", "GAZ", "FASURO", "KRL", "FASDVO", "DZR", "BRN", "ARJ", "SARTAX", "ARR", "SVV", "SVS", "AMR", "FORTV", "RSL", "AVG", "KMK", "USTORDA", "CASB", "SVO", "CHP", "CHA", "MUNALT", "HBK", "SML", "OSB", "FASZPS", "KGA", "KAM", "ASL", "TER", "KMW", "FASVV", "BELGOROD", "DGT", "SAH", "FASVSO", "MGD", "STV", "OMP", "OMX", "SUR", "FASPVL", "KOMI", "ORB", "KPK", "CHT", "YNAO", "VRPR", "IVAN", "OREL", "MRD_NAL", "TAT_NAL", "NSK_NAL", "CHEL_NAL", "HMS_NAL", "TUVA", "MOS_OBL", "SPB_PRA", "UDM_NAL", "AST_NAL", "CHEL_MUN", "CHUV_V", "CHUV_S", "BURYATIA", "LIPETSK", "AGINSK", "KALUG_MO", "SVP", "RYBINSK", "OSN", "PSK_NAL", "RAZ_NAL", "MOS", "EAO", "ARNN", "XMAO_ARH", "PERM_ARH", "NAO", "XMAO_MUN", "PK2", "CHECHNYA", "TULA", "KAB_BAL", "PK8", "KUB_NAL", "NIZHNEVA", "BASH_NAL", "ADYGEYA", "ROST_NAL", "KOSTROMA", "TAIMYR", "CHUKOT", "KORYAK", "CHERKES", "SOCHI", "SAHALIN", "ALANIA", "MOS_NAL", "AZERB", "LEGACY", "PNE", "TECH", "WWW", "BUH", "SAR_ARH", "AMUR_ARH", "UDM_ARH", "BER_SEC", "MB", "USN", "F1PRE", "BANKRT", "PRIMEB", "PRIMES", "SHH", "SNH", "INGUSH", "BDRK", "KRK", "OPP", "BUDG", "SNA", "LIBRARY", "PRI_RUS", "TAX", "MEDIC", "BARK", "BARK_V", "KMB", "BORK", "BBYU", "KADR", "KORN", "ONLINE", "PK4", "PK6", "KZ", "TURBO", "ENO", "COMJUR", "SUD_NAL", "EFE", "EGE", "ETE", "EAE", "EBE", "EME", "ECE", "ESE", "ERE", "ENE", "EOE", "EPE", "EQE", "EDE", "EHE", "EIE"};

		IndexLoader loader (base);
		DocCollection* alldocs = base->AllTopics (ID_BORDER);
		for (int i = 0; i < alldocs->ItemCount; i++) {
			long doc_id = (*alldocs) [i];

			long size;
			char *idd_casecode = (char*) base->LoadAttr (doc_id, IDD_CASECODE, size), *ptr = idd_casecode;
			if (!size)
				continue;
			gk_free (idd_casecode);

			DocInfo docinfo;
			base->FindDocInfo (doc_id, docinfo);
			Recoding (cd_win, cd_dos, docinfo.Title);
			printf ("!TOPIC %ld %s\n", doc_id - ID_BORDER, docinfo.Title);

			printf ("!BELONGS ");
			long belongs_count;
			INDEX_DATA (short) belongs = loader.load <short> (doc_id, IDD_BASES, belongs_count, true);
			if (belongs.ptr ()) {
				short* belongs_ptr = belongs.ptr ();
				for (int belong = 0; belong < belongs_count; belongs_ptr++, belong++) {
					if (*belongs_ptr > 255)
						continue;
					printf ("%s", belongs_strings [*belongs_ptr]);
					if (belong < belongs_count - 1)
						printf ("\\");
					else
						printf ("\n");
				}
			}

			long types_size;
			char *types = (char*) base->LoadAttr (doc_id, IDD_TYPE, types_size), *types_ptr = types;
			if (types_size) {
				while (types_ptr - types_size != types) {
					int len = strlen (types_ptr) + 1;
					printf ("!TYPE %s\n", remove_trash (types_ptr, true));
					types_ptr += len;
				}
				gk_free (types);
			}

			long sources_size;
			char *sources = (char*) base->LoadAttr (doc_id, IDD_SOURCE, sources_size), *sources_ptr = sources;
			if (sources_size) {
				while (sources_ptr - sources_size != sources) {
					int len = strlen (sources_ptr) + 1;
					printf ("!SOURCE %s\n", remove_trash (sources_ptr));
					sources_ptr += len;
				}
				gk_free (sources);
			}

			{
			long size;
			date *idd_date = (date*) base->LoadAttr (doc_id, IDD_DATE, size), *ptrd = idd_date;
			std::set<std::string> vanonceds;
			for (int i = 0; i < size; ptrd++, i+=sizeof (date))
				printf ("!DATE %02ld/%02ld/%02ld\n", (long) ptrd->da_day, (long) ptrd->da_mon, (long) ptrd->da_year);
			gk_free (idd_date);
			}

			std::set<std::string> casecodes_set, codes_set;

			long casecodes_size;
			char *casecodes = (char*) base->LoadAttr (doc_id, IDD_CASECODE, casecodes_size), *casecodes_ptr = casecodes;
			if (casecodes_size) {
				while (casecodes_ptr - casecodes_size != casecodes) {
					int len = strlen (casecodes_ptr) + 1;
					Recoding (cd_win, cd_dos, casecodes_ptr);
					printf ("!CASECODE %s\n", casecodes_ptr);
					casecodes_set.insert (casecodes_ptr);
					casecodes_ptr += len;
				}
				gk_free (casecodes);
			}

			long codes_size;
			char *codes = (char*) base->LoadAttr (doc_id, IDD_ID, codes_size), *codes_ptr = codes;
			if (codes_size) {
				while (codes_ptr - codes_size != codes) {
					int len = strlen (codes_ptr) + 1;
					Recoding (cd_win, cd_dos, codes_ptr);
					codes_set.insert (codes_ptr);
					codes_ptr += len;
				}
				gk_free (codes);
			}
			for (std::set<std::string>::const_iterator it = codes_set.begin (); it != codes_set.end (); it++) {
				if (codes_set.size () == 1 || (casecodes_set.find (*it) == casecodes_set.end ()))
					printf ("!CODE %s\n", it->c_str ());
			}
			printf ("\n");
		}
		delete base;

		return 0;
		exit (EXIT_SUCCESS);
	}
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
