#include "shared/Core/fix/mpcxc.h"
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>

#include <unistd.h>
#include <strings.h>

#include "gdbapi.h"
#include "log.h"

#include "ready.h"
#include "garver.h"
#include <sys/stat.h>

#include "platform.h"

#if defined(__GO32__) || defined(__CYGWIN32__)
extern int _fmode;
#endif

static int open_files(char **names, int count, base_st *, pgfile_st *);
static int create_files(char **names, int count, pgfile_st *, base_st *);
static void close_files(pgfile_st *, int count);

extern char **hs_bases, **hs_targets;
extern int hs_base_count;
extern void get_oldname(char *, char *, int);
extern char *GetBasedExtFileName( char *, int);

void usage(void);
int parse_cmdline(int, char **);
void post_renames(pgfile_st *);
int hisync(base_st *, pgfile_st *, int*);

#include <basemask.h>
#include <garver.h>

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

int main_logic ( int argc, char *argv[] )
{
	base_st *pinpf, *poutpf;
	pgfile_st *pinpf0, *poutpf0;
	int pre, chk;

	VER_PARAM verParam;

	verParam.exeId= TID_HISYNC;				// defines BASEMASK.H
	verParam.lDstrbtd= VC_NUMBER_GDK_DISTR;	// defines GARVER.H
	verParam.stdOut= stdout;
	verParam.pDate= __DATE__;
	verParam.pTime= __TIME__;

	if((pre=_imp_GVersion(&argc, argv, &verParam))){
		if(pre == VC_ADD_OK){
		}else{
		}
#ifdef _DEBUG
		printf("\n *** HISYNC Debug Version. For test, only... ***\n\n");
#else
		exit(0);
#endif
	}
	if (argc < 3) {
		usage();
		return 0;
	}
	if(!parse_cmdline(argc, argv)) return -2;
	printf("Working on %d bases...\n", hs_base_count);

	pinpf = (base_st *)ml_malloc((hs_base_count<<1)*sizeof(base_st));
	pinpf0 = (pgfile_st *)ml_malloc((hs_base_count<<1)*sizeof(pgfile_st));

	poutpf = pinpf+hs_base_count;
	poutpf0 = pinpf0+hs_base_count;
	if(!open_files(hs_bases, hs_base_count, pinpf, pinpf0)) return -3;
	if(!create_files(hs_targets, hs_base_count, pinpf0, pinpf)) {
		close_files(pinpf0, hs_base_count);
		return -5;
	}
#if defined(__GO32__) || defined(__CYGWIN32__)
	_fmode = ACE_OS_O_BINARY;
#endif
	pre= hs_base_count;
	hisync(pinpf, poutpf0, &hs_base_count);

	poutpf0= pinpf0+pre;
	for(pre =0; pre < hs_base_count; pre++){
		char fname0[1024], fname1[1024];
		pinpf[pre].key.PrmExt.page= pinpf[pre].key.pfhdr->last_page;
		chk= IsNextTom(&(pinpf[pre].key.PrmExt));
		while(chk > 0){
			c_io_close(pinpf[pre].key.postFileHandles[chk]);
			pinpf[pre].key.postFileHandles[chk--]= -1;
			ace_os_unlink(fname0);
		}
		c_io_close(*pinpf[pre].key.postFileHandles);
		ace_os_unlink(pinpf[pre].key.name);
		c_io_close(*poutpf[pre].ndt.postFileHandles);
		ace_os_unlink(poutpf[pre].ndt.name);
		c_io_close(*poutpf[pre].str.pgfile.postFileHandles);
		ace_os_unlink(poutpf[pre].str.pgfile.name);
		c_io_close(*pinpf[pre].ndt.postFileHandles);
		c_io_close(*pinpf[pre].str.pgfile.postFileHandles);

		strcpy(poutpf[pre].ndt.name, pinpf[pre].key.name);
		strcpy(poutpf[pre].str.pgfile.name, poutpf[pre].key.name);
		close_pgfile(&pinpf[pre].key);

		pinpf[pre].key= poutpf[pre].key;
		*pinpf[pre].str.pgfile.postFileHandles
			= c_io_open(	pinpf[pre].str.pgfile.name,
					ACE_OS_O_RDWR | ACE_OS_O_BINARY);
		*pinpf[pre].ndt.postFileHandles
			= c_io_open(	pinpf[pre].ndt.name,
					ACE_OS_O_RDWR | ACE_OS_O_BINARY);
		pinpf[pre].key.AddedPage = poutpf0[pre].AddedPage;
		pinpf[pre].key.PrmExt.page= poutpf0[pre].AddedPage-1;
		chk= IsNextTom(&(pinpf[pre].key.PrmExt));
		close_base(pinpf+pre);
		ace_os_rename(poutpf[pre].str.pgfile.name, poutpf[pre].ndt.name);
		while(chk > 0){
			strcpy(fname0, poutpf[pre].ndt.name);
			GetBasedExtFileName( fname0, chk );
			strcpy(fname1, poutpf[pre].str.pgfile.name);
			GetBasedExtFileName( fname1, chk-- );
			ace_os_rename(fname1, fname0);
		}
		// 
		poutpf[pre].ndt.hfile= *(poutpf[pre].ndt.postFileHandles)= c_io_open(pinpf[pre].ndt.name, ACE_OS_O_BINARY);
		close_pgfile(&(poutpf[pre].ndt));
		poutpf[pre].str.pgfile.hfile= *(poutpf[pre].str.pgfile.postFileHandles)= c_io_open(pinpf[pre].ndt.name, ACE_OS_O_BINARY);
		close_pgfile(&(poutpf[pre].str.pgfile));
		free(pinpf[pre].ndt.name);
	}
	free(pinpf);
	free(hs_bases);
	return 0;
}

static int open_files(char **names, int count, base_st *pBase, pgfile_st *pf)
{
	int i, ok, fh;
	char *fname, *s, *missing, fname0[1024];
	u_int32_t ready[2], mask;

	ok = 1;
	for (i=0; i<count; i++) {
		fname = names[i];
#ifdef MULTI_INDEX_STREAM_FILE
		*(s= strrchr(fname, '.')) = 0;
		if (!open_base(fname, pBase+i, ACE_OS_O_BINARY | ACE_OS_O_RDONLY)) {
			printf("Unable to open source file %s\n", fname);
			close_files(pf, i);
			ok = 0;
			break;
		}
		pBase[i].pNextSubToms=
			pBase[i].pSubToms= calloc(
					100,
					sizeof(SubTom_st));
		*(pf+i)= pBase[i].key;
		*s= '.';
#else
		if (!open_pgfile(fname, pf+i, ACE_OS_O_BINARY | ACE_OS_O_RDONLY)) {
			printf("Unable to open source file %s\n", fname);
			close_files(pf, i);
			ok = 0;
			break;
		}
#endif
		if (!get_info(pf, "Ready", ready)) {
			printf("Missing system information in source file %s\n", fname);
			close_files(pf, i);
			close_pgfile(pf+i);
			ok = 0;
			break;
		}
		if ((mask=get_ready(ready[0]))) {
			printf("Source %s isn't ready for sync process\n", fname);
			printf("At least the following utilities must be applied to the base:\n");
			s = missing = missing_process_description(mask);
			do {
				printf("%s\n", s);
				s += strlen(s) + 1;
			} while (*s);
			free(missing);
			close_files(pf, i);
			close_pgfile(pf+i);
			ok = 0;
			break;
		}
		ok= 1;
	}
	return ok;
}

static int create_files(char **names, int count, pgfile_st *nf, base_st *pBase)
{
	int i;
	pgfile_st *pf= nf + count;

	for(i=0; i<count; i++) {
#ifdef MULTI_INDEX_STREAM_FILE
		if (!create_base(names[i], pBase+count+i)) {
			close_files(pf, i);
			fprintf(stderr, "Error: Can't create file %s.", names[i]);
			return 0;
		}
		pBase[i+count].pNextSubToms=
			pBase[i+count].pSubToms= calloc(
					100,
					sizeof(SubTom_st));
		*(pf+i)= pBase[i+count].key;
		pBase[i+count].flags= 1;
#else
		if (!create_pgfile(names[i], pf+i, 2048)) {
			close_files(pf, i);
			fprintf(stderr, "Error: Can't create file %s.", names[i]);
			return 0;
		}
#endif
		if((nf+i)->pfhdr->TomPerPages != 0l){
			if((nf+i)->pfhdr->TomPerPages >= MAX_COUNT_FILE_HANDLES){
				(pf+i)->pfhdr->TomPerPages= (nf+i)->pfhdr->TomPerPages;
				(pf+i)->PrmExt.maxFile_per_bytes=
					(pf+i)->pfhdr->TomPerPages * (pf+i)->pfhdr->page_size;
			}else{
				close_files(pf, i);
				fprintf(stderr, "Error: Can't optimize base on CD %s.", names[i]);
				return 0;
			}
		}
	}
	return 1;
}

static void close_files(pgfile_st *pf, int count)
{
	int i, repeat;
	
	for (i=0; i<count; i++) {
		(pf+i)->PrmExt.page= (pf+i)->pfhdr->last_page;
		repeat= IsNextTom(&(pf+i)->PrmExt);
		close_pgfile(pf+i);
		(pf+i)->mode= repeat;
	}
}








