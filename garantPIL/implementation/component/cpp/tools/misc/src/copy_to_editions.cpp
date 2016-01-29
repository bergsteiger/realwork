#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <vector>

#include "SearchB.h"

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

std::vector<std::string> filenames;

#define	MAX_THREADS	16
struct thread_data_struct {
	std::map<u_int64_t, std::deque<std::string> > map_sub_commands;
	std::map<long,long> map_preveditions, map_nexteditions;
	std::set<long> editions, topics;
	volatile int done;
};
thread_data_struct thread_data [MAX_THREADS];

std::vector<std::string>::const_iterator filename_it;
ACE_Recursive_Thread_Mutex filename_it_mutex;

char*	get_filename (bool next)
{
	RWRITE_GUARD (filename_it_mutex) {
		if (filename_it == filenames.end ())
			return 0;
		char *result = strdup (filename_it->c_str ());
		if (next)
			filename_it++;
		return result;
	}
}

void	read_file (int* thread_id)
{
	int this_thread_id = *thread_id;

	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	thread_data_ptr->done = false;

	char buffer [4 * 1024];
	for (;;) {
		char* filename = get_filename (true);
		if (!filename)
			break;

		FILE *in = fopen (filename, "rt");
		if (!in)
			continue;

		printf ("%s \r", filename);

		long id = 0, sub = -1;
		bool b_edition = false;
		u_int64_t ref64;

		while (!feof (in)) {
			fgets (buffer, sizeof (buffer), in);
			if (strstr (buffer, "!TOPIC ") == buffer) {
				id = atol (buffer + 7);
				thread_data_ptr->topics.insert (id);
				b_edition = false;
				sub = 0;
				ref64 = ((u_int64_t)id) << 32;
			} else if (strstr (buffer, "!ANNOTOPIC ") == buffer || strstr (buffer, "!FLASHTOPIC ") == buffer || strstr (buffer, "!OBJTOPIC ") == buffer) {
				id = sub = 0;
				b_edition = false;
			} else if (strstr (buffer, "!SUB ") == buffer) {
				sub = atol (buffer + 5);
				ref64 = (((u_int64_t)id) << 32) + sub;
			} else if (strstr (buffer, "!BLOCK ") == buffer) {
				sub = atol (buffer + 7);
				ref64 = (((u_int64_t)id) << 32) + sub;
			} else if (strstr (buffer, "!EDITION") == buffer) {
				b_edition = true;
				thread_data_ptr->editions.insert (id);
			} else if (strstr (buffer, "!VERLINK ") == buffer) {
				long verlink = atol (buffer + 9);
				thread_data_ptr->map_preveditions.insert (std::map<long,long>::value_type (id, verlink));
				thread_data_ptr->map_nexteditions.insert (std::map<long,long>::value_type (verlink, id));
			} else if (strstr (buffer, "!STYLE ") == buffer) {
				sub = -1;
			} else if (!b_edition && buffer [0] == '!' && sub != -1) {
				char* commands [] = {"!TYPE ", "!CLASS "};
				for (int i = 0; i < 2; i++) {
					if (strstr (buffer, commands [i]) == buffer) {
						std::map<u_int64_t,std::deque<std::string> >::iterator map_it = thread_data_ptr->map_sub_commands.find (ref64);
						if (map_it == thread_data_ptr->map_sub_commands.end ()) {
							std::deque<std::string> to_insert;
							to_insert.push_back (buffer);
							thread_data_ptr->map_sub_commands.insert (std::map<u_int64_t,std::deque<std::string> >::value_type (ref64, to_insert));
						} else {
							map_it->second.push_back (buffer);
						}
						break;
					}
				}
			}
		}
		fclose (in);
	}
	thread_data_ptr->done = true;
}

std::map<u_int64_t, std::deque<std::string> > map_sub_commands;
std::map<long,long> map_preveditions, map_nexteditions, map_edition_doc;
std::set<long> editions, topics;

void	convert_file (int* thread_id)
{
	int this_thread_id = *thread_id;

	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	thread_data_ptr->done = false;

	char buffer [4 * 1024];
	for (;;) {
		char* filename = get_filename (true);
		if (!filename)
			break;

		FILE *in = fopen (filename, "rt");
		if (!in)
			continue;

		filename [strlen (filename) - 1] = 0;
		FILE *out = fopen (filename, "wt");
		if (!out) {
			fclose (in);
			continue;
		}

		long id = 0, sub = -1;
		bool b_edition = false;
		u_int64_t ref64, lastref64 = 0;

		while (!feof (in)) {
			fgets (buffer, sizeof (buffer), in);

			bool b_write = true;
			if (strstr (buffer, "!TOPIC ") == buffer) {
				id = atol (buffer + 7);
				b_edition = std::find (editions.begin (), editions.end (), id) != editions.end ();
				sub = 0;
			} else if (strstr (buffer, "!SUB ") == buffer) {
				sub = atol (buffer + 5);
				ref64 = (((u_int64_t)id) << 32) + sub;
			} else if (strstr (buffer, "!BLOCK ") == buffer) {
				sub = atol (buffer + 7);
				ref64 = (((u_int64_t)id) << 32) + sub;
			} else if (b_edition && buffer [0] == '!' && sub != -1) {
				char* commands [] = {"!TYPE ", "!CLASS "};
				for (int i = 0; i < 2; i++) {
					if (strstr (buffer, commands [i]) == buffer) {
						b_write = false;
						if (lastref64 != ref64) {
							lastref64 = ref64;
							long actual = map_edition_doc.find (id)->second;
							u_int64_t actualref64 = (((u_int64_t) actual) << 32) + sub;
							//char qqq [1024];
							//sprintf (qqq, ";copy class/type from %ld.%ld\n", actual, sub);
							//fputs (qqq, out);
							std::map<u_int64_t, std::deque<std::string> >::const_iterator commands_it = map_sub_commands.find (actualref64);
							if (commands_it != map_sub_commands.end ()) {
								for (std::deque<std::string>::const_iterator it = commands_it->second.begin (); it != commands_it->second.end (); it++)
									fputs (it->c_str (), out);
							}
						}
						break;
					}
				}
			}
			if (b_write)
				fputs (buffer, out);
		}
		fclose (out);
		fclose (in);

		printf ("%s \r", filename);
	}

	thread_data_ptr->done = true;
}

int main_logic ( int argc, char *argv[] )
{
	FILE *all_files = fopen (argv [1], "rt");
	if (!all_files)
		return -1;

	while (!feof (all_files)) {
		char filename [MAX_PATH];
		fgets (filename, sizeof (filename), all_files);
		if (filename [strlen (filename) - 1] == 10)
			filename [strlen (filename) - 1] = 0;
		filenames.push_back (filename);
	}
	fclose (all_files);
	printf ("%ld files to proceed\n", filenames.size ());

	int threads_count = 1;
	if (argv [2]) {
		threads_count = atol (argv [2]);
		if (threads_count > MAX_THREADS)
			threads_count = MAX_THREADS;
	}

	filename_it = filenames.begin ();
	int thread_id, ok_threads = 0;
	for (thread_id = 0; thread_id < threads_count; thread_id++) {
		ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
		inst->spawn ((ACE_THR_FUNC)read_file, &thread_id, THR_DETACHED);
		ok_threads++;
		ACE_OS::sleep (1);
	}

	long last_time = time (0);
	for (;;) {
		char* filename = get_filename (false);
		if (filename)
			last_time = time (0);
		else {
			int dones = 0;
			for (thread_id = 0; thread_id < threads_count; thread_id++)
				if (thread_data [thread_id].done)
					dones++;
			if (dones == ok_threads)
				break;
			else if (time (0) - last_time > 4)
				break;
		}
		ACE_OS::sleep (5);
	}

	for (thread_id = 0; thread_id < threads_count; thread_id++) {
		map_sub_commands.insert (thread_data [thread_id].map_sub_commands.begin (), thread_data [thread_id].map_sub_commands.end ());
		topics.insert (thread_data [thread_id].topics.begin (), thread_data [thread_id].topics.end ());
		editions.insert (thread_data [thread_id].editions.begin (), thread_data [thread_id].editions.end ());
		map_preveditions.insert (thread_data [thread_id].map_preveditions.begin (), thread_data [thread_id].map_preveditions.end ());
		map_nexteditions.insert (thread_data [thread_id].map_nexteditions.begin (), thread_data [thread_id].map_nexteditions.end ());
	}

	std::vector<long> real_topics (topics.size ());
	real_topics.resize (std::set_difference (topics.begin (), topics.end (), editions.begin (), editions.end (), real_topics.begin ()) - real_topics.begin());
	
	printf ("\ntopics: %ld\nreal_topics: %ld\neditions: %ld\nblocks: %ld\n", topics.size (), real_topics.size (), editions.size (), map_sub_commands.size ());

	//сделать мапу редакция-документ
	std::map<long,long>::const_iterator map_it;
	for (map_it = map_preveditions.begin (); map_it != map_preveditions.end (); map_it++) {
		long id1 = map_it->first, id2 = map_it->second;
		if (std::find (real_topics.begin (), real_topics.end (), id1) != real_topics.end ()) {
			map_edition_doc.insert (std::map<long,long>::value_type (id2, id1));
		} else if (std::find (real_topics.begin (), real_topics.end (), id2) != real_topics.end ()) {
			map_edition_doc.insert (std::map<long,long>::value_type (id1, id2));
		}
	}
	for (map_it = map_edition_doc.begin (); map_it != map_edition_doc.end (); map_it++) {
		long doc = map_it->second, prev_id = doc;
		
		std::map<long,long>::const_iterator prev_it = map_preveditions.find (prev_id);
		while (prev_it != map_preveditions.end ()) {
			prev_id = prev_it->second;
			map_edition_doc.insert (std::map<long,long>::value_type (prev_id, doc));
			prev_it = map_preveditions.find (prev_id);
		}

		std::map<long,long>::const_iterator next_it = map_nexteditions.find (doc);
		while (next_it != map_nexteditions.end ()) {
			long next_id = next_it->second;
			map_edition_doc.insert (std::map<long,long>::value_type (next_id, doc));
			next_it = map_nexteditions.find (next_id);
		}
	}

	filename_it = filenames.begin ();
	for (ok_threads = thread_id = 0; thread_id < threads_count; thread_id++) {
		ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
		inst->spawn ((ACE_THR_FUNC)convert_file, &thread_id, THR_DETACHED);
		ok_threads++;
		ACE_OS::sleep (1);
	}

	last_time = time (0);
	for (;;) {
		char* filename = get_filename (false);
		if (filename)
			last_time = time (0);
		else {
			int dones = 0;
			for (thread_id = 0; thread_id < threads_count; thread_id++)
				if (thread_data [thread_id].done)
					dones++;
			if (dones == ok_threads)
				break;
			else if (time (0) - last_time > 4)
				break;
		}
		ACE_OS::sleep (5);
	}

	return 0;
}
