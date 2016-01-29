#include "shared/Core/fix/mpcxc.h"

#include "../../../libs/mrglib/src/gdbapi.h"
#include "../../../libs/mrglib/src/sets.h"

extern void inc_progress(void);

int release_streams(stream_st *, int);
int minkeyx(char **, int, int *, cmpfunc_ft);
stream_st *create_streams(int);
set_st *create_sets(int, cmpfunc_ft, int);

extern char *gs_target_name;
extern char *gs_dest_path;
extern char **gs_source_name;
extern char *gs_job_file;
extern char *gs_result_file;
extern char *gs_work_dir;
extern char *gs_cwd;
extern char *gs_garant_root;
extern int gs_source_count;
extern int gs_options;

