#include "shared/Core/fix/mpcxc.h"
#include "shared/Core/sys/AutoInit.h"
#include "shared/Morpho/impl/Support/LibManager.h"

#include <cstdio>
#include <cstdlib>
#include "ace/OS.h"
#include <locale.h>

#include "SearchB.h"
#include "basemask.h"

#include "SplayMap.h"
#include "StorableSplaySet.h"
#include "u_int32_t.caddr_t.SplayMap.h"
#include "long.long.SplayMap.h"

extern	void	BuildPatternM (ContextPattern&, char*);

unsigned getKeyWord (char *dst, char **src, int &l)
{
	char *to = dst;
	unsigned length = l;
	int bWasWord = 0;

	while (length){
		if (IS_CTX_CHAR_NORMLS_62(*(*src))){
			*to = *(*src)++;
			to++;
			length--;
			bWasWord = 1;
		} else {
			if (bWasWord)
				break;

			(*src)++;
			length--;
		}
	}
	l = length;
	return to-dst;
}

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	Core::AutoInit init;
	Morpho::Support::LibManager::factory_registrate ();
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	if ( argc < 2 )
		return 0;

	setlocale (LC_ALL, "ru_RU.CP1251");
	StdBigBase* aBase = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	DocCollection docs;

	printf ("Calculate handmasks for ");
	{
		for (BTIterator btit (aBase->FindIndex ("Type")); !btit.End (); ++btit) {
			HIndex::HIndexKey* hkey = (HIndex::HIndexKey*) btit.Key();
			if (!hkey->level && (!strcmp (hkey->text+4, "Закон") || !strcmp (hkey->text+4, "Федеральный закон") || !strcmp (hkey->text+4, "Кодекс"))) {
				Stream* str = aBase->FindIndex ("Type")->Index::OpenN (hkey,0);
				if (str) {
					DocCollection type_docs;
					type_docs.FastLoadRefs (str);
					aBase->FindIndex ("Type")->Close (str);
					docs.Merge (type_docs);
					printf ("%ld ", docs.ItemCount);
				}
			}
		}
	}
	{
		for (BTIterator btit (aBase->FindIndex ("Adopted")); !btit.End (); ++btit) {
			HIndex::HIndexKey* hkey = (HIndex::HIndexKey*) btit.Key();
			if (hkey->level && (!strcmp (hkey->text+4, "Президент России") || !strcmp (hkey->text+4, "Правительство России"))) {
				Stream* str = aBase->FindIndex ("Adopted")->Index::OpenN (hkey,0);
				if (str) {
					DocCollection ado_docs;
					ado_docs.Get (str);
					aBase->FindIndex ("Adopted")->Close (str);
					docs.Merge (ado_docs);
					printf ("%ld ", docs.ItemCount);
				}
			}
		}
	}
	{
		Stream* str = aBase->FindIndex ("Aux")->Open (PR_COMMENTS);
		if (str) {
			char *comments_str = (char*) malloc (str->Length ());
			str->Read (comments_str , str->Length ());
			aBase->FindIndex ("Aux")->Close (str);

			for (BTIterator btit (aBase->FindIndex ("DocKind")); !btit.End (); ++btit) {
				HIndex::HIndexKey* hkey = (HIndex::HIndexKey*) btit.Key();
				if (!hkey->level && !strcmp (hkey->text, comments_str)) {
					str = aBase->FindIndex ("DocKind")->Index::OpenN (hkey,0);
					if (str) {
						DocCollection kind_docs;
						kind_docs.FastLoadRefs (str);
						aBase->FindIndex ("DocKind")->Close (str);
						docs.Merge (kind_docs);
						printf ("%ld ", docs.ItemCount);
					}
				}
			}
			free (comments_str);
		}
	}
	short moj_status = DS_MOJREG;
	Stream* str = aBase->FindIndex ("Status")->Open (&moj_status);
	if (str) {
		DocCollection status_docs;
		status_docs.Get (str);
		aBase->FindIndex ("Status")->Close (str);
		docs.Merge (status_docs);
	}
	printf ("%ld docs\n", docs.ItemCount);

	AttrIndex* attrs = (AttrIndex*) aBase->FindIndex ("Attrs");

	DBCore::IBase_var obj = DBCore::DBFactory::make (aBase);
	Morpho::Def::INormalizer_var normalizer = Morpho::Def::INormalizerFactory::make (0, obj.in ());

	AttrKey key = { ID_BORDER, IDD_KEY };
	BTIterator it (attrs); it.Set (&key);
	long count = 0;
	for ( ; ; it.next ()) {
		key = *(AttrKey*) it.Key ();
		if ( key.AttrTag != IDD_KEY )
			break;

		if (docs.IndexOf (&key.DocId) == -1)
			continue;

		Stream* str = attrs->Open (&key);
		if (str) {
			int length = str->Length ();
			char* keys = (char*) malloc (length);
			str->Read (keys, length);
			attrs->Close (str);

			int	pos = 0;
			char* ptr = keys;
			std::set<std::string> handmasks;
			while (pos < length) {
				int plus = strlen (ptr) + 1;
				char* colon = strchr (ptr, ':');
				*colon = 0;
				char *sub = strdup (ptr), *charptr = colon+1;

				std::set<std::string> words;
				std::string newkey;

				char word [128];
				int wordlen, keylength = strlen (charptr);
				while (wordlen = getKeyWord (word, &charptr, keylength)) {
					word [wordlen] = 0;

					Core::Aptr <GCL::StrSet> normas = normalizer->execute (std::string (word));

					if (normas->empty () == false) {
						const char* norm = normas->begin ()->c_str () + 1;
						if (words.find (norm) == words.end ()) {
							words.insert (norm);
							if (!newkey.size ()) {
								newkey  = sub;
								newkey += ":";
							} else {
								newkey += " ";
							}
							newkey += word;
						}
					}
				}

				if (words.size () > 3)
					handmasks.insert (newkey);
				free (sub);

				ptr += plus;
				pos += plus;
			}
			if (handmasks.size ()) {
				int put_size = 0;
				std::set<std::string>::const_iterator it;
				for (it = handmasks.begin (); it != handmasks.end (); it++)
					put_size += it->size () + 1;
				char *put_array = (char*) malloc (put_size), *key_ptr = put_array;
				for (it = handmasks.begin (); it != handmasks.end (); it++) {
					strcpy (key_ptr, it->c_str ());
					key_ptr += strlen (key_ptr) + 1;
				}
				aBase->ReplaceAttr (key.DocId, IDD_HANDMASK, put_array, put_size);
				gk_free (put_array);
			}

			free (keys);
		}
		printf ("doc %ld, count %ld\r", key.DocId, ++count);
	}
	printf ("\n");

	delete aBase;
	exit (EXIT_SUCCESS);
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
