#include "shared/Core/fix/mpcxc.h"
#include <stddef.h>
#include <errno.h>
#include <stdio.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>

#include <unistd.h>
#include <strings.h>

#include "gdbapi.h"
#include "log.h"
#include "ready.h"

#define KNOWN_INDEX_COUNT 71

extern char *hs_logfile;
char **hs_bases, **hs_targets;

stamp_st timestamp;

int sync_indexes(index_st *pind, int count, index_st *poutind);

static char *_synced_indexes [] = { 
#ifdef	VERSION62
	"PhFirm", "PhCountry", "LekForm", "PhGroup", 
	"PhEffect", "Chapter", "Atc", "RegStatus", "Mkb",
#endif
	"Territory", "Adopted", "Type", "Kind", "KeyWord", "DocKind", "Class", "PublishedIn",
#ifdef	VERSION56
	"Class6",
#endif
#ifdef	VERSION62
	"AnnoUser", "AnnoOrganization", "AnnoTax", "AnnoInterest", "AnnoKind", "ServiceInfo",
#endif

	0
};
	
static int check_sync(const char *);
static int open_indexes(index_st *pind, const char *iname, pgfile_st *pf, int count);
static int create_indexes(index_st *pind, const char *name, pgfile_st *pf, int count);
static int move_trees(index_st *pind, pgfile_st *pf, int count);
static int move_node(pgfile_st *pinpf, pgfile_st *poutpf, u_int32_t root, u_int16_t keylen);

int hisync(base_st *pinpB, pgfile_st *poutpf, int *pCount)
{
	int i, ind;
	index_st *pinind, *poutind;
	stamp_st stamp;
	u_int32_t ready[2];

	pgfile_st *pinpf= poutpf - *pCount;

	gb_enable_log();
	pinind = (index_st *)ml_malloc((*pCount<<1)*sizeof(index_st));
	bzero((char *)pinind, (*pCount<<1)*sizeof(index_st));
	poutind = pinind+ *pCount;
	makestamp(&stamp);

	printf("Processing index 0 of %d.\r", KNOWN_INDEX_COUNT);
	fflush(stdout);
	for (i=0; i< (*pCount<<1); i++){
		pinind[i].pbase= pinpB+i;
	}
#ifndef MULTI_INDEX_STREAM_FILE
	open_indexes(pinind, get_index_name(0), pinpf, *pCount);
	for (i=0; i< *pCount; i++)
		if((pinind+i)->hdr.key_count == 0){
			flog("Not find keys in \"%s\"! this base - ignore. \n", (pinpf+i)->name);
			(*pCount)--;
			if(*pCount == 1){
				close_index(pinind); close_index(poutind);
				close_pgfile(pinpf); close_pgfile(poutpf);
				ace_os_unlink(poutpf->name);
				close_index(pinind+1); close_index(poutind+1);
				close_pgfile(pinpf+1); close_pgfile(poutpf+1);
				ace_os_unlink((poutpf+1)->name);
				free(pinind);
				(*pCount)--;
				printf("\rError !... see log.                                \n");
				return 0;
			}
			close_index(pinind+i); close_index(poutind+i);

			memcpy(pinind+i, pinind+i+1, (*pCount-i) * sizeof(index_st));
			memcpy(poutind+i, poutind+i+1, (*pCount-i) * sizeof(index_st));

			close_pgfile(pinpf+i); close_pgfile(poutpf+i);
			ace_os_unlink((poutpf+i)->name);
			memcpy(pinpf+i, pinpf+i+1, (*pCount-i) * sizeof(pgfile_st));
			memcpy(poutpf+i, poutpf+i+1, (*pCount-i) * sizeof(pgfile_st));

			memcpy(hs_bases+i, hs_bases+i+1, (*pCount-i) * sizeof(void*));
			memcpy(hs_targets+i, hs_targets+i+1, (*pCount-i) * sizeof(void*));

			i--;
		}

	if(check_sync(pinind->name)) {
		create_indexes(poutind, pinind->name, poutpf, *pCount);
		flog("Sync index \"%s\"... \n", pinind->name);
		sync_indexes(pinind, *pCount, poutind);
		// printf("Building index trees... \n");
		for (i=0; i< *pCount; i++)
			close_index(poutind+i);
		m_log("Done.\n\n");
	}
	else {
		move_trees(pinind, poutpf, *pCount);
	}
	for (i=0; i< *pCount; i++)
		close_index(pinind+i);
	printf("                            \r");
	fflush(stdout);
#endif
	for (ind= 1; ind<KNOWN_INDEX_COUNT; ind++) {
#ifdef MULTI_INDEX_STREAM_FILE
		if(strrchr(get_index_name(ind), '.'))
			continue;
#endif
		printf("Processing index %d of %d.\r", ind, KNOWN_INDEX_COUNT);
		fflush(stdout);
		open_indexes(pinind, get_index_name(ind), pinpf, *pCount);
		if(check_sync(pinind->name)) {
			create_indexes(poutind, pinind->name, poutpf, *pCount);
			flog("Sync index \"%s\"... \n", pinind->name);
			sync_indexes(pinind, *pCount, poutind);
			// printf("Building index trees... \n");
			for (i=0; i< *pCount; i++)
				close_index(poutind+i);
			m_log("Done.\n\n");
		}
		else {
			move_trees(pinind, poutpf, *pCount);
		}
		for (i=0; i< *pCount; i++)
			close_index(pinind+i);
		printf("                            \r");
		fflush(stdout);
	}
	free(pinind);
	for(i=0; i< *pCount; i++) {
		set_info(poutpf+i, "HSTS", &stamp, 8);
		get_info(pinpf+i, "Ready", ready);
		ready[0] = get_final_mask(ready[0]);
		set_info(poutpf+i, "Ready", ready, 8);
	}
	printf("\nDone.\n");
	return 1;
}

static int open_indexes(index_st *pind, const char *name, pgfile_st *pf, int count)
{
	int i, j;

	for (i=0; i<count; i++) {
		if (!open_index_hack(pf+i, name, pind+i)) {
			for (j=0; j<i; j++) close_index(pind+j);
			return 0;
		}
	}
	return 1;
}

static int create_indexes(index_st *pind, const char *name, pgfile_st *pf, int count)
{
	int i, j;

	for (i=0; i<count; i++) {
		if (!create_index_hack(pf+i, name, pind+i)) {
			for (j=0; j<i; j++) close_index(pind+j);
			return 0;
		}
	}
	return 1;
}

static int move_trees(index_st *pind, pgfile_st *pf, int count)
{
	bthdr_st hdr;
	int i;

	for (i=0; i<count; i++) {
		if(hs_logfile)
			flog("Moving index \"%s\" tree to \"%s\"\n", pind[i].name, pf[i].name);
		memcpy(&hdr, &(pind[i].hdr), sizeof(bthdr_st));
		if (hdr.key_count) {
			hdr.root = move_node(pind[i].pf, pf+i, hdr.root, hdr.keylen);
		}
		else {
			hdr.root = alloc_page(pf+i);
		}
		set_info(pf+i, pind[i].name, &hdr, sizeof(bthdr_st));
	}
	return 1;
}

static int move_node(pgfile_st *pinpf, pgfile_st *poutpf, u_int32_t root, u_int16_t keylen)
{
	u_int32_t outpage, *ref;
	u_int16_t rec_count, j;
	char *page_buf, *r;
	int pgsize;

	outpage = alloc_page(poutpf);
	pgsize = 1 << pinpf->pgpow;
	page_buf = (char *)malloc(pgsize);
	read_page(pinpf, root, page_buf);
	rec_count = *((u_int16_t *)page_buf);
	r = page_buf+2;
	for (j=0; j<=rec_count; j++, r+=keylen+4) {
		ref = (u_int32_t *)r;
		if (*ref) *ref = move_node(pinpf, poutpf, *ref, keylen);
	}
	write_page(poutpf, outpage, page_buf);
	free(page_buf);
	return outpage;
}

static int check_sync(const char *name)
{
	int i;

	for (i=0; _synced_indexes[i]; i++)
		if (!strcmp(name, _synced_indexes[i])) return 1;
	return 0;
}



