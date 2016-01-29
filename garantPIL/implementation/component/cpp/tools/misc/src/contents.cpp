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
	std::set<long> editions, topics, intersection;
	std::deque<std::string> errors;
	std::map<long,std::string> map_topic_nsr;
	std::map<long,std::string> map_topic_name;
	std::map<long,long> map_topic_line;
	std::map<long,long> map_topic_related;
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

		long id = 0, line = 0;

		while (!feof (in)) {
			if (!fgets (buffer, buffer_size, in))
				break;
			if (strstr (buffer, "!TOPIC ") == buffer) {
				char* name = buffer + 7;
				id = atol (name);
				if (thread_data_ptr->topics.find (id) != thread_data_ptr->topics.end ()) {
					thread_data_ptr->intersection.insert (id);
					char str [1024];
					sprintf (str, "Повторяющийся номер топика: %ld (%s) (уже встречался в %s)", id, filename, thread_data_ptr->map_topic_nsr.find (id)->second.c_str ());
					thread_data_ptr->errors.push_back (str);
				} else {
					thread_data_ptr->map_topic_nsr.insert (std::map<long,std::string>::value_type (id, filename));
					while ((*name >= '0' && *name <= '9') || *name == ' ') name++;
					char* lf = strchr (name, 10); if (lf) *lf = 0;
					thread_data_ptr->map_topic_name.insert (std::map<long,std::string>::value_type (id, *name ? name : ""));
					thread_data_ptr->map_topic_line.insert (std::map<long,long>::value_type (id, line));
				}
				thread_data_ptr->topics.insert (id);
			} else if (strstr (buffer, "!ANNOTOPIC ") == buffer || strstr (buffer, "!FLASHTOPIC ") == buffer || strstr (buffer, "!OBJTOPIC ") == buffer) {
				char *name = strchr (buffer, ' ') + 1;
				id = atol (name);
				if (strstr (buffer, "!ANNOTOPIC ") == buffer)
					id += ID_ANNOPLUS;
				if (thread_data_ptr->topics.find (id) != thread_data_ptr->topics.end ()) {
					thread_data_ptr->intersection.insert (id);
					char str [1024];
					sprintf (str, "Повторяющийся номер топика: %ld (%s) (уже встречался в %s)", id, filename, thread_data_ptr->map_topic_nsr.find (id)->second.c_str ());
					thread_data_ptr->errors.push_back (str);
				} else {
					thread_data_ptr->map_topic_nsr.insert (std::map<long,std::string>::value_type (id, filename));
					while ((*name >= '0' && *name <= '9') || *name == ' ') name++;
					char* lf = strchr (name, 10); if (lf) *lf = 0;
					thread_data_ptr->map_topic_name.insert (std::map<long,std::string>::value_type (id, *name ? name : ""));
					thread_data_ptr->map_topic_line.insert (std::map<long,long>::value_type (id, line));
				}
				thread_data_ptr->topics.insert (id);
			} else if (strstr (buffer, "!RELATED ") == buffer) {
				long related = atol (buffer + 9);
				thread_data_ptr->map_topic_related.insert (std::map<long,long>::value_type (id, related));
			}
			line++;
		}
		fclose (in);
	}
	delete []buffer;
	thread_data_ptr->done = true;
}

std::set<long> topics;
std::map<long,std::string> map_topic_nsr, map_topic_name;
std::map<long,long> map_topic_line;
std::map<long,long> map_topic_related;

char*	KillSlashes (char *resultPath, char *srcPath)
{
	int	aSlashCount = 0;
	int	aPathPtr    = 0;
	for (unsigned I = 0; I <= strlen (srcPath); I++) {
		char aChar = srcPath[ I ];
		if (aChar == '\\') aSlashCount++; else aSlashCount = 0;
		if (aSlashCount < 2 || I < 2) resultPath [aPathPtr++] = aChar;
	}
	return resultPath;
}

char*	GoodPath (char* path)
{
	char *from = path, *to = path;
	while (*from) {
		while (*from == '\"') from++;
		*to++ = *from++;
	}
	*to = 0;
	return path;
}

char*	MakePath (char *path, char *dir, char *file)
{
	char	*aResult = new char [strlen (dir) + strlen (file) + 2];
	strcat (strcat (strcpy (aResult, dir), "\\" ), file);
	KillSlashes (path, aResult);
	GoodPath (path);
	delete aResult;
	return path;
}

int main_logic ( int argc, char *argv[] )
{
	FILE *all_files = fopen (argv [2], "rt");
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
	if (argv [1])
		threads_count = std::min <long> (MAX_THREADS, std::max <long> (atol (argv [1]), 1));

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

		map_topic_nsr.insert (thread_data [thread_id].map_topic_nsr.begin (), thread_data [thread_id].map_topic_nsr.end ());
		map_topic_name.insert (thread_data [thread_id].map_topic_name.begin (), thread_data [thread_id].map_topic_name.end ());
		map_topic_line.insert (thread_data [thread_id].map_topic_line.begin (), thread_data [thread_id].map_topic_line.end ());
		errors.insert (errors.begin (), thread_data [thread_id].errors.begin (), thread_data [thread_id].errors.end ());

		map_topic_related.insert (thread_data [thread_id].map_topic_related.begin (), thread_data [thread_id].map_topic_related.end ());

		thread_data [thread_id].topics.clear ();
		thread_data [thread_id].editions.clear ();
		thread_data [thread_id].map_topic_nsr.clear ();
		thread_data [thread_id].map_topic_line.clear ();
		thread_data [thread_id].map_topic_related.clear ();
		thread_data [thread_id].errors.clear ();
	}

	FILE *errors_file = fopen ("contents.err", "wt");
	if (errors_file) {
		for (std::list<std::string>::const_iterator it = errors.begin (); it != errors.end (); it++)
			fprintf (errors_file, "%s\n", it->c_str ());
		fclose (errors_file);
	}

	FILE *contentsres_file = fopen ("contents.res", "wt");
	if (contentsres_file) {
		for (std::set<long>::const_iterator topic_it = topics.begin (); topic_it != topics.end (); topic_it++) {
			long id = *topic_it;
			fprintf (contentsres_file, "%ldі%sі%ldі%s\n", id, map_topic_nsr.find (id)->second.c_str (), map_topic_line.find (id)->second, map_topic_name.find (id)->second.c_str ());
		}
		fclose (contentsres_file);
	}

	FILE *contres_file = fopen ("cont.res", "wt");
	if (contres_file) {
		for (std::set<long>::const_iterator topic_it = topics.begin (); topic_it != topics.end (); topic_it++) {
			long id = *topic_it;
			fprintf (contres_file, "%ldі%s\n", id, map_topic_nsr.find (id)->second.c_str ());
		}
		fclose (contres_file);
	}

	if (argv [3]) {
		char *buffer = new char [buffer_size];

		//прочитать ТВСы
		char *exts[] = {"*.ref", "*.txt"};
		for (int ext = 0; ext < sizeof (exts) / sizeof (char*); ext++) {
			char	mask [MAX_PATH], tvs_file [MAX_PATH];
			MakePath (mask, argv [3], exts [ext]);

			WIN32_FIND_DATA	find_data;
			HANDLE	find_result = FindFirstFile (mask, &find_data);
			while (find_result != INVALID_HANDLE_VALUE) {
				if ((find_data.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) == 0) {
					MakePath (tvs_file, argv [3], find_data.cFileName);
					FILE *in = fopen (tvs_file, "rt");
					if (!in)
						continue;

					std::set<long> tvs_topics;
					std::map<long,std::string> map_tvstopic_name;
					while (!feof (in)) {
						if (!fgets (buffer, buffer_size, in))
							break;

						if (*buffer >= '0' && *buffer <= '9') {
							long id = atol (buffer) - ID_BORDER;
							tvs_topics.insert (id);
							map_tvstopic_name.insert (std::map<long,std::string>::value_type (id, find_data.cFileName));
						}
					}
					fclose (in);

					std::set<long> intersection;
					std::set_intersection (topics.begin (), topics.end (), tvs_topics.begin (), tvs_topics.end (), std::inserter (intersection, intersection.begin ()));

					topics.insert (tvs_topics.begin (), tvs_topics.end ());
					map_topic_name.insert (map_tvstopic_name.begin (), map_tvstopic_name.end ());

					if (intersection.size ()) {
						for (std::set<long>::const_iterator it = intersection.begin (); it != intersection.end (); it++) {
							long id = *it;
							char str [1024];
							sprintf (str, "Повторяющийся номер топика: %ld (%s) (уже встречался в %s)", id, find_data.cFileName, map_topic_nsr.find (id)->second.c_str ());
							errors.push_back (str);
						}
					}
				}

				if (!FindNextFile (find_result, &find_data))
					break;
			}
			FindClose (find_result);
		}

		delete [] buffer;

		FILE *errors_file = fopen ("cont_all.err", "wt");
		if (errors_file) {
			for (std::list<std::string>::const_iterator it = errors.begin (); it != errors.end (); it++)
				fprintf (errors_file, "%s\n", it->c_str ());
			fclose (errors_file);
		}
	}

	FILE *relatedstop_file = fopen ("relateds.top", "wt");
	if (relatedstop_file) {
		for (std::map<long,long>::const_iterator it = map_topic_related.begin (); it != map_topic_related.end (); it++)
			fprintf (relatedstop_file, "%ld\t%ld\n", it->first, it->second);
		fclose (relatedstop_file);
	}	

	return 0;
}
