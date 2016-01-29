#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <vector>
#include <map>
#include <deque>
#include <set>
#include <list>

#include "gardefs.h"
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
	std::set<long> editions, topics, intersection;
	std::deque<std::string> errors;
	std::map<long,std::string> map_topic_nsr;
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

static const int buffer_size = 32 * 1024 * 1024;

void	read_file (int* thread_id)
{
	int this_thread_id = *thread_id;

	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	thread_data_ptr->done = false;

	char *buffer = new char [buffer_size];
	for (;;) {
		char* filename = get_filename (true);
		if (!filename)
			break;

		FILE *in = fopen (filename, "rt");
		if (!in)
			continue;

		long id = 0, sub = -1;
		bool b_edition = false, b_was_verlink = false;
		u_int64_t ref64;

		while (!feof (in)) {
			if (!fgets (buffer, buffer_size, in))
				break;
			if (strstr (buffer, "!TOPIC ") == buffer) {
				id = atol (buffer + 7);
				if (thread_data_ptr->topics.find (id) != thread_data_ptr->topics.end ()) {
					thread_data_ptr->intersection.insert (id);
					char str [1024];
					sprintf (str, "Повторяющийся номер топика: %ld (%s) (уже встречался в %s)", id, filename, thread_data_ptr->map_topic_nsr.find (id)->second.c_str ());
					thread_data_ptr->errors.push_back (str);
				} else {
					thread_data_ptr->map_topic_nsr.insert (std::map<long,std::string>::value_type (id, filename));
				}
				thread_data_ptr->topics.insert (id);
				b_edition = b_was_verlink = false;
				sub = 0;
				ref64 = ((u_int64_t)id) << 32;
			} else if (strstr (buffer, "!ANNOTOPIC ") == buffer || strstr (buffer, "!FLASHTOPIC ") == buffer || strstr (buffer, "!OBJTOPIC ") == buffer) {
				id = atol (strchr (buffer, ' '));
				if (strstr (buffer, "!ANNOTOPIC ") == buffer)
					id += ID_ANNOPLUS;
				if (thread_data_ptr->topics.find (id) != thread_data_ptr->topics.end ()) {
					thread_data_ptr->intersection.insert (id);
					char str [1024];
					sprintf (str, "Повторяющийся номер топика: %ld (%s) (уже встречался в %s)", id, filename, thread_data_ptr->map_topic_nsr.find (id)->second.c_str ());
					thread_data_ptr->errors.push_back (str);
				} else {
					thread_data_ptr->map_topic_nsr.insert (std::map<long,std::string>::value_type (id, filename));
				}
				thread_data_ptr->topics.insert (id);
				sub = 0;
				b_edition = b_was_verlink = false;
				ref64 = ((u_int64_t)id) << 32;
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
				if (b_was_verlink) {
					char str [1024];
					sprintf (str, "%s: топик %ld: повторяющаяся команда !VERLINK", filename, id);
					thread_data_ptr->errors.push_back (str);
				} else {
					b_was_verlink = true;
					long verlink = atol (buffer + 9);
					if (thread_data_ptr->map_nexteditions.find (verlink) != thread_data_ptr->map_nexteditions.end ()) {
						char str [1024];
						sprintf (str, "%s: топик %ld: на топик %d уже была verlink-ссылка из топика %ld", filename, id, verlink, thread_data_ptr->map_nexteditions.find (verlink)->second);
						thread_data_ptr->errors.push_back (str);						
					} else {
						thread_data_ptr->map_preveditions.insert (std::map<long,long>::value_type (id, verlink));
						thread_data_ptr->map_nexteditions.insert (std::map<long,long>::value_type (verlink, id));
					}
				}
			} else if (strstr (buffer, "!STYLE ") == buffer) {
				sub = -1;
			} else if (!b_edition && buffer [0] == '!' && sub != -1) {
				char* commands [] = {"!TYPE ", "!CLASS ", "!DOCKIND ", "!KIND ", "!CODE ", "!RCODE ", "!DATE ", "!RDATE ", "!SOURCE ", "!TERRITORY ", "!NORM ", "!PRIORITY ", "!SORTDATE "};
				for (int i = 0; i < sizeof (commands) / sizeof (char*); i++) {
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
	delete []buffer;
	thread_data_ptr->done = true;
}

std::map<u_int64_t, std::deque<std::string> > map_sub_commands;
std::map<long,long> map_preveditions, map_nexteditions, map_edition_doc;
std::set<long> editions, topics;
std::map<long,std::string> map_topic_nsr;

void	convert_file (int* thread_id)
{
	int this_thread_id = *thread_id;

	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	thread_data_ptr->done = false;

	char *buffer = new char [buffer_size];
	for (;;) {
		char* filename = get_filename (true);
		if (!filename)
			break;

		FILE *in = fopen (filename, "rt");
		if (!in)
			continue;

		char outname [MAX_PATH], *slash = strrchr (filename, '/');
		if (slash) {
			char shortname [MAX_PATH];
			strcpy (strrchr (strcpy (outname, filename), '/'), "/result");
			ace_os_mkdir (outname);
			strcat (outname, strcpy (shortname, slash));
		} else {
			slash = strrchr (filename, '\\');
			if (slash) {
				char shortname [MAX_PATH];
				strcpy (strrchr (strcpy (outname, filename), '\\'), "\\result");
				ace_os_mkdir (outname);
				strcat (outname, strcpy (shortname, slash));
			} else {
				ace_os_mkdir ("result");
				strcat (strcpy (outname, "result\\"), filename);
			}
		}

		FILE *out = fopen (outname, "wt");
		if (!out) {
			fclose (in);
			continue;
		}

		long id = 0, sub = -1;
		bool b_edition = false;

		while (!feof (in)) {
			if (!fgets (buffer, buffer_size, in))
				break;
			if (buffer [strlen (buffer) - 1] != 10) {
				int len = strlen (buffer);
				buffer [len] = 10;
				buffer [++len] = 0;
			}
			bool b_copy = false;
			if (strstr (buffer, "!TOPIC ") == buffer) {
				id = atol (buffer + 7);
				b_copy = b_edition = editions.find (id) != editions.end ();
				sub = 0;
			} else if (strstr (buffer, "!SUB ") == buffer) {
				sub = atol (buffer + 5);
				b_copy = b_edition;
			} else if (strstr (buffer, "!BLOCK ") == buffer) {
				sub = atol (buffer + 7);
				b_copy = b_edition;
			}
			fputs (buffer, out);
			if (b_copy && map_edition_doc.find (id) != map_edition_doc.end ()) {
				long actual = map_edition_doc.find (id)->second;
				u_int64_t actualref64 = (((u_int64_t) actual) << 32) + sub;
				std::map<u_int64_t, std::deque<std::string> >::const_iterator commands_it = map_sub_commands.find (actualref64);
				if (commands_it != map_sub_commands.end ()) {
					for (std::deque<std::string>::const_iterator it = commands_it->second.begin (); it != commands_it->second.end (); it++)
						fputs (it->c_str (), out);
				}
			}
		}
		fflush (out);
		fclose (out);
		fclose (in);
	}

	delete []buffer;
	thread_data_ptr->done = true;
}

long	find_last_edition (long edition) {
	std::set<long> queue;
	queue.insert (edition);
	long result = edition;
	std::map<long,long>::const_iterator map_it = map_nexteditions.find (edition);
	while (map_it != map_nexteditions.end ()) {
		result = map_it->second;
		if (queue.find (result) == queue.end ()) {
			queue.insert (result);
			map_it = map_nexteditions.find (result);
		} else {
			result = edition;
			break;
		}
	}		
	return result;
}

int main_logic ( int argc, char *argv[] )
{
	FILE *all_files = fopen (argv [1], "rt");
	if (!all_files)
		return -1;

	while (!feof (all_files)) {
		char filename [MAX_PATH];
		if (!fgets (filename, sizeof (filename), all_files))
			break;
		while (filename [strlen (filename) - 1] == 10)
			filename [strlen (filename) - 1] = 0;
		filenames.push_back (filename);
	}
	fclose (all_files);
	//printf ("%ld files to proceed\n", filenames.size ());

	int threads_count = 1;
	if (argv [2])
		threads_count = std::min <long> (MAX_THREADS, std::max <long> (atol (argv [2]), 1));

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

	std::set<long> bad_topics;
	std::list<std::string> errors;

	for (thread_id = 0; thread_id < threads_count; thread_id++) {
		std::set<long> intersection;
		bad_topics.insert (thread_data [thread_id].intersection.begin (), thread_data [thread_id].intersection.end ());
		std::set_intersection (topics.begin (), topics.end (), thread_data [thread_id].topics.begin (), thread_data [thread_id].topics.end (), std::inserter (intersection, intersection.begin ()));
		if (intersection.size ()) {
			bad_topics.insert (intersection.begin (), intersection.end ());
			for (std::set<long>::const_iterator it = intersection.begin (); it != intersection.end (); it++) {
				long id = *it;
				char str [1024];
				sprintf (str, "Повторяющийся номер топика: %ld (%s) (уже встречался в %s)", id, thread_data [thread_id].map_topic_nsr.find (id)->second.c_str (), map_topic_nsr.find (id)->second.c_str ());
				errors.push_back (str);
			}
		}
		topics.insert (thread_data [thread_id].topics.begin (), thread_data [thread_id].topics.end ());
		map_sub_commands.insert (thread_data [thread_id].map_sub_commands.begin (), thread_data [thread_id].map_sub_commands.end ());
		editions.insert (thread_data [thread_id].editions.begin (), thread_data [thread_id].editions.end ());

		std::set<long> set1, set2;
		for (std::map<long,long>::const_iterator map_it = map_nexteditions.begin (); map_it != map_nexteditions.end (); map_it++)
			set1.insert (map_it->first);
		for (std::map<long,long>::const_iterator map_it = thread_data [thread_id].map_nexteditions.begin (); map_it != thread_data [thread_id].map_nexteditions.end (); map_it++)
			set2.insert (map_it->first);
		std::set<long> set_int;
		std::set_intersection (set1.begin (), set1.end (), set2.begin (), set2.end (), std::inserter (set_int, set_int.begin ()));
		for (std::set<long>::const_iterator set_it = set_int.begin (); set_it != set_int.end (); set_it++) {
			//ранее были такие же verlinkи
			long topic = *set_it, was1 = map_nexteditions.find (topic)->second, was2 = thread_data [thread_id].map_nexteditions.find (topic)->second;
			char str [1024];
			sprintf (str, "%s: топик %ld: на топик %ld уже была verlink-ссылка из топика %ld", thread_data [thread_id].map_topic_nsr.find (was2)->second.c_str (), was2, topic, was1);
			errors.push_back (str);
		}

		map_preveditions.insert (thread_data [thread_id].map_preveditions.begin (), thread_data [thread_id].map_preveditions.end ());
		map_nexteditions.insert (thread_data [thread_id].map_nexteditions.begin (), thread_data [thread_id].map_nexteditions.end ());

		map_topic_nsr.insert (thread_data [thread_id].map_topic_nsr.begin (), thread_data [thread_id].map_topic_nsr.end ());
		errors.insert (errors.begin (), thread_data [thread_id].errors.begin (), thread_data [thread_id].errors.end ());

		thread_data [thread_id].topics.clear ();
		thread_data [thread_id].map_sub_commands.clear ();
		thread_data [thread_id].editions.clear ();
		thread_data [thread_id].map_preveditions.clear ();
		thread_data [thread_id].map_nexteditions.clear ();
		thread_data [thread_id].map_topic_nsr.clear ();
		thread_data [thread_id].errors.clear ();
	}

	std::set<long> real_topics;
	std::set_difference (topics.begin (), topics.end (), editions.begin (), editions.end (), inserter (real_topics, real_topics.begin ()));
	
	//printf ("\ntopics: %ld\nreal_topics: %ld\neditions: %ld\nblocks: %ld\nintersection: %ld\n", topics.size (), real_topics.size (), editions.size (), map_sub_commands.size (), bad_topics.size ());

	//сделать мапу редакция-документ
	std::map<long,long>::const_iterator map_it;
	std::set<long> topics_with_editions, last_editions, bad_editions, bad_qeueu_editions, cycle_docs;
	for (map_it = map_preveditions.begin (); map_it != map_preveditions.end (); map_it++) {
		long id1 = map_it->first, id2 = map_it->second;
		if (real_topics.find (id1) != real_topics.end ()) {
			map_edition_doc.insert (std::map<long,long>::value_type (id2, id1));
			topics_with_editions.insert (id1);
		} else if (real_topics.find (id2) != real_topics.end ()) {
			map_edition_doc.insert (std::map<long,long>::value_type (id1, id2));
			topics_with_editions.insert (id2);
		}
	}
	for (map_it = map_edition_doc.begin (); map_it != map_edition_doc.end (); map_it++) {
		long doc = map_it->second, prev_id = doc;
		std::set<long> queue;
		queue.insert (doc);
		bool b_bad_queue = false;
		std::map<long,long>::const_iterator prev_it = map_preveditions.find (prev_id);
		while (prev_it != map_preveditions.end ()) {
			prev_id = prev_it->second;

			std::set<long>::const_iterator is_doc_it = real_topics.find (prev_id);
			b_bad_queue |= is_doc_it != real_topics.end () && *is_doc_it != doc;

			if (queue.find (prev_id) == queue.end ()) {
				queue.insert (prev_id);
				map_edition_doc.insert (std::map<long,long>::value_type (prev_id, doc));
				prev_it = map_preveditions.find (prev_id);
			} else {
				//цикл
				cycle_docs.insert (doc);
				long bad = *queue.begin ();
				if (bad_editions.find (bad) == bad_editions.end ()) {
					bad_editions.insert (bad);
					char str [1024];
					sprintf (str, "Цепочка редакций, в которой есть топик %ld(%s) имеет зацикленные участки", bad, map_topic_nsr.find (bad)->second.c_str ());
					errors.push_back (str);
				}
				break;
			}
		}

		std::map<long,long>::const_iterator next_it = map_nexteditions.find (doc);
		while (next_it != map_nexteditions.end ()) {
			long next_id = next_it->second;

			std::set<long>::const_iterator is_doc_it = real_topics.find (next_id);
			b_bad_queue |= is_doc_it != real_topics.end () && *is_doc_it != doc;

			if (queue.find (next_id) == queue.end ()) {
				queue.insert (next_id);
				map_edition_doc.insert (std::map<long,long>::value_type (next_id, doc));
				next_it = map_nexteditions.find (next_id);
			} else {
				//цикл
				cycle_docs.insert (doc);
				long bad = *queue.begin ();
				if (bad_editions.find (bad) == bad_editions.end ()) {
					bad_editions.insert (bad);
					char str [1024];
					sprintf (str, "Цепочка редакций, в которой есть топик %ld(%s) имеет зацикленные участки", bad, map_topic_nsr.find (bad)->second.c_str ());
					errors.push_back (str);
				}
				break;
			}
		}

		if (b_bad_queue) {
			long last_edition = find_last_edition (doc);
			if (bad_qeueu_editions.find (last_edition) == bad_qeueu_editions.end ()) {
				bad_qeueu_editions.insert (last_edition);
				char str [1024];
				sprintf (str, "В цепочке редакций (%ld(%s) - ее самая поздняя редакция) есть не меньше 2-х топиков без !EDITION", last_edition, map_topic_nsr.find (last_edition)->second.c_str ());
				errors.push_back (str);
			}
		}
	}

	//проверяем, есть ли в цепочке DOCи
	for (std::set<long>::const_iterator it = editions.begin (); it != editions.end (); it++) {
		long edition = *it;
		if (map_edition_doc.find (edition) != map_edition_doc.end ())
			continue;
		bad_editions.insert (edition);
		edition = find_last_edition (edition);
		if (last_editions.find (edition) == last_editions.end ()) {
			last_editions.insert (edition);
			char str [1024];
			sprintf (str, "В цепочке редакций (%ld(%s) - ее самая последняя редакция) у всех без исключения топиков есть !EDITION", edition, map_topic_nsr.find (edition)->second.c_str (), map_topic_nsr.find (edition)->second.c_str ());
			errors.push_back (str);
		}
	}

	//проверяем, не указывает ли VERLINK в пустоту
	for (std::map<long,long>::const_iterator map_it = map_preveditions.begin (); map_it != map_preveditions.end (); map_it++) {
		long topic = map_it->first, verlink = map_it->second;
		if (topics.find (verlink) == topics.end ()) {
			bad_editions.insert (verlink);
			char str [1024];
			sprintf (str, "Топика %ld не существует, хотя на него указывает verlink из топика %ld(%s)", verlink, topic, map_topic_nsr.find (topic)->second.c_str ());
			errors.push_back (str);
		}
	}

	FILE *errors_file = fopen ("queuedit.err", "wt");
	if (errors_file) {
		for (std::list<std::string>::const_iterator it = errors.begin (); it != errors.end (); it++)
			fprintf (errors_file, "%s\n", it->c_str ());
		fclose (errors_file);
	}

	FILE *queue_file = fopen ("queuedit.res", "wt");
	if (queue_file) {
		for (std::set<long>::const_iterator it = topics_with_editions.begin (); it != topics_with_editions.end (); it++) {
			long doc = *it, last_edition = find_last_edition (doc), count = 0;
			if (cycle_docs.find (doc) != cycle_docs.end ())
				continue;

			while (true) {
				if (count)
					fprintf (queue_file, " - ");
				if (last_edition == doc)
					fprintf (queue_file, "(%ld)", last_edition);
				else
					fprintf (queue_file, "%ld", last_edition);
				count++;
				map_it = map_preveditions.find (last_edition);
				if (map_it == map_preveditions.end ())
					break;
				last_edition = map_it->second;
			}
			fprintf (queue_file, "\n");
		}
		fclose (queue_file);
	}

	if (errors.size () == 0 || (argc == 3 && !stricmp (argv [2], "s")) || (argc == 4 && !stricmp (argv [3], "s"))) {
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
	}

	return 0;
}
