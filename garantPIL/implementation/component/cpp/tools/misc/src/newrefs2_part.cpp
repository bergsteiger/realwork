#include "shared/Core/fix/mpcxc.h"
#include "ace/OS.h"
#include "stdbase.h"

#include <deque>

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	if (argc < 3)
		return 0;

	char str [4096 * 1024], ref_str [64];
	KindCorrRef towrite [1024];
	gk_bzero (towrite, sizeof (towrite));

	Ref ref;
	typedef std::pair<short,u_int64_t> pair_seg_mask64;
	std::deque<pair_seg_mask64> masks;

	long prev_id = 0;

	if (!strcmp (argv [1], "-add")) {
		std::map<short, u_int64_t> map_segment_masks;

		FILE* part_file = mpcxc_fopen (argv [2], "rt");
		long blocks = 0;
		while (!feof (part_file)) {
			if (!fgets (str, sizeof (str), part_file)) {
				break;
			}

			int length = strlen (str);
			while (length && (str [length-1] == 10 || str [length-1] == 13))
				str [--length] = 0;
			if (!length)
				continue;

			char* delimiter = strchr (str, ':');
			strncpy (ref_str, str, delimiter - str);
			ref_str [delimiter - str] = 0;
			ref.DocId = atol (str);
			ref.Sub = atol (strchr (str, '.') + 1);

			if (ref.DocId != prev_id) {
				if (prev_id) {
					if (blocks > 50) {
						printf ("%ld.%ld:", prev_id, INHERITED_BLOCK);
						for (std::map<short,u_int64_t>::const_iterator it = map_segment_masks.begin (); it != map_segment_masks.end (); it++) {
							printf (" %ld.%llu", it->first, it->second);
						}
						printf ("\n");
					}
					map_segment_masks.clear ();
				}
				prev_id = ref.DocId;
				blocks = 0;
			}
			blocks++;
			printf ("%s\n", str);

			masks.clear ();
			for (char* ptr = delimiter+2; *ptr; ) {
				long seg = atol (ptr);
				u_int64_t mask64 = _atoi64 (strchr (ptr, '.') + 1);
				pair_seg_mask64 seg_mask64 ((short)(seg & 0xFFFF), mask64);
				masks.push_back (seg_mask64);
				char* next_ptr = strchr (ptr, ' ');
				if (!next_ptr)
					break;
				ptr = next_ptr + 1;
			}

			KindCorrRef* ptr = towrite;
			long size = 0;
			for (std::deque<pair_seg_mask64>::const_iterator it = masks.begin (); it != masks.end (); it++, ptr++, size += sizeof (*ptr)) {
				ptr->seg = it->first;
				ptr->mask = it->second;

				std::map<short,u_int64_t>::iterator map_it = map_segment_masks.find (ptr->seg);
				if (map_it == map_segment_masks.end ())
					map_segment_masks.insert (std::map<short,u_int64_t>::value_type (ptr->seg, ptr->mask));
				else
					map_it->second |= ptr->mask;
			}
		}
		if (map_segment_masks.size ()) {
			if (blocks > 50) {
				printf ("%ld.%ld:", prev_id, INHERITED_BLOCK);
				for (std::map<short,u_int64_t>::const_iterator it = map_segment_masks.begin (); it != map_segment_masks.end (); it++) {
					printf (" %ld.%llu", it->first, it->second);
				}
				printf ("\n");
			}
		}
		fclose (part_file);
		exit (EXIT_SUCCESS);
	}

	Base* base = new StdBigBase (argv [1], ACE_OS_O_RDWR);
	Index* kindcorr_index = base->FindIndex ("KindCorr");

	std::deque<u_int64_t> old_kindcorr_keys, new_kindcorr_keys;
	for (BTIterator it (base->FindIndex ("KindCorr")); !it.End (); ++it) {
		Ref at_ref = *(Ref*)it.Key ();
		u_int64_t ref64 = (((u_int64_t) at_ref.DocId) << 32) + at_ref.Sub;
		old_kindcorr_keys.push_back (ref64);
	}
		
	for (int i = 2; i < argc; i++) {
		FILE* part_file = mpcxc_fopen (argv [i], "rt");
		if (part_file) {
			while (!feof (part_file)) {
				if (!fgets (str, sizeof (str), part_file))
					break;

				int length = strlen (str);
				while (length && (str [length-1] == 10 || str [length-1] == 13))
					str [--length] = 0;
				if (!length)
					continue;

				char* delimiter = strchr (str, ':');
				strncpy (ref_str, str, delimiter - str);
				ref_str [delimiter - str] = 0;
				ref.DocId = atol (str);
				ref.Sub = atol (strchr (str, '.') + 1);

				if (ref.Sub == INHERITED_BLOCK && ( ref.DocId % 10 == 0))
					printf ("%ld\r", ref.DocId);

				masks.clear ();
				for (char* ptr = delimiter+2; *ptr; ) {
					long seg = atol (ptr);
					u_int64_t mask64 = _atoi64 (strchr (ptr, '.') + 1);
					pair_seg_mask64 seg_mask64 ((short)(seg & 0xFFFF), mask64);
					masks.push_back (seg_mask64);
					char* next_ptr = strchr (ptr, ' ');
					if (!next_ptr)
						break;
					ptr = next_ptr + 1;
				}

				KindCorrRef* ptr = towrite;
				long size = 0;
				for (std::deque<pair_seg_mask64>::const_iterator it = masks.begin (); it != masks.end (); it++, ptr++, size += sizeof (*ptr)) {
					pair_seg_mask64 seg_mask64 = *it;
					ptr->seg = seg_mask64.first;
					ptr->mask = seg_mask64.second;
				}

				Stream *str = kindcorr_index->Open (&ref, 1);
				if (str) {
					if (size != str->Length ()) {
						str->Write (towrite, size);
						str->Trunc ();
					} else {
						void* old_data = malloc (size);
						str->Read (old_data, size);
						if (memcmp (old_data, towrite, size)) {
							str->Seek (0);
							str->Write (towrite, size);
						}
						free (old_data);
					}
					kindcorr_index->Close (str);
					u_int64_t ref64 = (((u_int64_t) ref.DocId) << 32) + ref.Sub;
					new_kindcorr_keys.push_back (ref64);
				}
			}
			fclose (part_file);
		}
	}

	printf ("\n");
	std::deque <u_int64_t> keys_to_delete;
	std::set_difference  (old_kindcorr_keys.begin (), old_kindcorr_keys.end (), new_kindcorr_keys.begin (), new_kindcorr_keys.end (), std::back_inserter (keys_to_delete));
	for (std::deque<u_int64_t>::const_iterator it = keys_to_delete.begin (); it != keys_to_delete.end (); it++) {
		u_int64_t ref64 = *it;
		Ref at_ref = {(long)((ref64 >> 32) & 0xFFFFFFFF), (long)(ref64 & 0xFFFFFFFF)};
		printf ("delete data for %ld.%ld\n", at_ref.DocId, at_ref.Sub);
		kindcorr_index->Delete (&at_ref);
	}

	delete base;

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
