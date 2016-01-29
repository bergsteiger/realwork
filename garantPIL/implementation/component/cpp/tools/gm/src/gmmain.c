#include "shared/Core/fix/mpcxc.h"
#include <stdlib.h>
#include <stdio.h>

#include <string.h>
//#include <alloca.h>

//#include "osdep.h"

//#include "gdbapi.h"
#include "gm.h"
#include "vscreen.h"
#include "../../../libs/mrglib/src/log.h"
#include "ready.h"

extern int merge_bases(base_st *ptarget, base_st *psrc, int count, int use_progress);
extern int make_aux(index_st *ptarget, iter_st *spit, int count, int use_progress);
extern int merge_doc_index(index_st *ptarget, iter_st *spit, int count, int use_progress);
extern int merge_hindex(index_st *ptarget, iter_st *spit, int count, int progress);
extern int merge_index(char *iname, base_st *pbtarget, base_st *pbsrc, int count);

void close_bases(base_st *pbases, int count);
static int build_aux(base_st *ptgt, base_st *psrc, int count, int progress);
static int check_segments(base_st *psrc, int count);
static void report_error(void);

#if defined(__DOS32__) || defined(__WIN32__)
#include <fcntl.h>
#include <sys/stat.h>
#endif

#include <errno.h>

#ifdef __CYGWIN32__
extern int _fmode;
#endif

#define MSG_SCREEN  0
#define MSG_VERSION 1
#define MSG_CHECK   2
#define MSG_NDT     3
#define MSG_INDEXES 4
#define MSG_AUX     5
#define MSG_SUCCESS 6

/* End of dual languages support... */

char ErrorFormat0[]= "\nOpen FAILED on input file from Source base \"%s\".";
char ErrorFormat1[]= "\nSource base \"%s\" is NOT ready to merge with others.";


static char *gm_indexes[] = {
	"Tag.str", "SubName.str", "CalIn.str", "CalAb.str", "CalCh.str", "Territory", "Adopted", "PublishedIn", "Type", "Kind", "Date", "Number", "Status", "Status_ex",
	"KeyWord", "RCode", "Respondent", "Correspondent", "RDate",
#ifdef MULTI_INDEX_STREAM_FILE
  #ifndef PTRS_IN_META
	"Context.str",
  #endif
#else
	"Context",
#endif
	"VAnonced", "VIncluded", "VChanged", "VAbolished", "VLControl", "DocKind", "Class",
#ifdef	VERSION56
  #ifndef PTRS_IN_META
	"Control", "Class6",
  #endif
	"NewCorr",
#endif
#ifdef	VERSION62
	"AnnoUser", "AnnoOrganization", "AnnoTax", "AnnoInterest", "AnnoKind", "AnnoDate", "ServiceInfo",
#endif
	"Segment", "SortDate", "Category", "Blob", "KindCorr",

	"PhFirm", "PhCountry", "RegDate", "AnnulDate", "TradeName", "LekForm",
	"IntName", "PhGroup", "PhEffect", "Chapter", "Atc", "RegStatus", "Mkb",
	"Active"
};

#ifdef INSTLL_CIB
	#include "PL_Proto.h"
	extern void pl_GetLoginFromBase(char **, char *, int);
#endif

extern void set_base_State(base_st *, int);

#ifdef PTRS_IN_META
	extern int init_MetaFile(int threadMode, void *ThreadCntxt, base_st *psrc, int count);
	extern int done_MetaFile(base_st *psrc, int count);
	#include "../../../tools/gctools/src/MyPipe.h"
#endif

int gmmain(int threadMode, void *ThreadCntxt)
{
	base_st *ptarget, *psources;
	int i, ok, newSB= 0;
	//unsigned short tmpBlockSize;
	FILE *rf;
	char *s, *msgUp= "SubFile size < 1Mb";
	long	lTomPerBytes= 0l;

#ifndef PTRS_IN_META
	gb_enable_log(1);
#else
	index_st pinFirst;
#endif
	if(gs_source_count < 2)
		return 0;

#if defined(__DOS32__) || defined(__WIN32__)
	_fmode = ACE_OS_O_BINARY;
#endif
#ifdef PTRS_IN_META
	if(!threadMode){
		ptarget= (base_st *)(((LPTHREAD_CNTX)ThreadCntxt)->PGCParameters);
		if(ptarget->key.name){
			psources= ptarget;
			ptarget -= gs_source_count + 1;
			if(ptarget->str.fat){
				// проход писателя в трубу str - хранилища //
				ptarget= (base_st *)(ptarget->str.fat);
				threadMode= 2;
			}else{
				// проход читателя в трубу str - хранилища //
				merge_bases(ptarget, psources, gs_source_count, 0);
				{
					base_st trgFirst;
					bzero((caddr_t)(&pinFirst), sizeof(index_st));
					bzero((caddr_t)(&trgFirst), sizeof(trgFirst));
					trgFirst.pSubToms= ptarget->pSubToms;
					trgFirst.str.hits= ptarget->str.hits;
					ptarget->str.fat= (fat_rec_type *)&trgFirst;
					trgFirst.str.fat= (fat_rec_type *)ptarget;
					create_indexEx(&trgFirst, "Attribs", (&pinFirst), ThreadCntxt);
				}
				return 1;
			}
		}else{
			// проход писателя в трубу 8tr - хранилища //
			psources= ptarget+1;
		}
	}else{
			// проход читателя в трубу 8tr - хранилища //
#endif
		ptarget = (base_st *)calloc(gs_source_count + 1
#ifdef PTRS_IN_META
														+ gs_source_count
#endif
																			, sizeof(base_st));
	////
	psources = ptarget+1;
	if(*gs_target_name == '{' && (s = strchr(gs_target_name, '}'))){
		lTomPerBytes= atol(gs_target_name+1);
		gs_target_name= s+1;
	}
	if(lTomPerBytes != 0l && lTomPerBytes < 1024 ){
		flog("Can't create base %s.\n", gs_target_name);
		flog("System message: %s\n", msgUp);
		printf("Error: %s\n", msgUp);
		return 0;
	}
	if(!create_base(gs_target_name, ptarget)) {
		flog("Can't create base %s.\n", gs_target_name);
		flog("System message: %s\n", strerror(errno));
		report_error();
		free(ptarget);
		unlink_base(gs_target_name);
		return 0;
	}
	if(lTomPerBytes != 0l){
		ptarget->key.pfhdr->TomPerPages=
			lTomPerBytes * 1024 / ptarget->key.pfhdr->page_size;
		ptarget->key.PrmExt.maxFile_per_bytes=
			ptarget->key.pfhdr->TomPerPages * ptarget->key.pfhdr->page_size;

		ptarget->ndt.pfhdr->TomPerPages=
			lTomPerBytes * 1024 / ptarget->ndt.pfhdr->page_size;
		ptarget->ndt.PrmExt.maxFile_per_bytes=
			ptarget->ndt.pfhdr->TomPerPages * ptarget->ndt.pfhdr->page_size;

		ptarget->str.pgfile.pfhdr->TomPerPages=
			lTomPerBytes * 1024 / ptarget->str.pgfile.pfhdr->page_size;
		ptarget->str.pgfile.PrmExt.maxFile_per_bytes=
			ptarget->str.pgfile.pfhdr->TomPerPages * ptarget->str.pgfile.pfhdr->page_size;
	}
	for(i=0; i<gs_source_count; i++) {
		if(!open_base(gs_source_name[i], psources+i, OBSC_SEQSP | OBSC_SMALL)) {
			report_error();
			flog(ErrorFormat0, gs_source_name[i]);
			close_bases(ptarget, i+1);
			free(ptarget);
			unlink_base(gs_target_name);
			return 0;
		}
		/*if(!i && get_info(((pgfile_st *)(&psources[i].str)), ID_BLOCK_SIZE, &tmpBlockSize)){
			newSB= tmpBlockSize;
		}else if((!newSB && get_info(((pgfile_st *)(&psources[i].str)), ID_BLOCK_SIZE, &tmpBlockSize)) ||
	(newSB && (!get_info(((pgfile_st *)(&psources[i].str)), ID_BLOCK_SIZE, &tmpBlockSize) || newSB != tmpBlockSize))){
				report_error();
			flog(ErrorFormat0, gs_source_name[i]);
			close_bases(ptarget, i+1);
			free(ptarget);
			unlink_base(gs_target_name);
			return 0;
		}*/
/*#ifndef _DEBUG
		{
			char *msg;
			u_int32_t status;
			if((status = get_ready(psources+i))) {
				report_error();
				flog(ErrorFormat1, gs_source_name[i]);
				flog("\nAt least the following programs must be applied to the base %s:", gs_source_name[i]);
				s = msg = missing_process_description(status);
				do {
					flog("\t%s\n", s);
					s += strlen(s) + 1;
				} while (*s);
				close_bases(ptarget, i+1);
				free(ptarget);
				unlink_base(gs_target_name);
				return 0;
			}
		}
#endif*/
#ifdef MULTI_INDEX_STREAM_FILE
		psources[i].pNextSubToms=
			psources[i].pSubToms= (SubTom_st *)calloc(
					sizeof(gm_indexes)/sizeof(*gm_indexes)+2,
					sizeof(SubTom_st));
#endif
	}
#ifndef PTRS_IN_META
  #ifdef INSTLL_CIB
	pl_GetLoginFromBase( (char**)&ptarget->pNextSubToms,
							((pgfile_st *)&ptarget->ndt)->PrmExt.pHeader,
							1 << ((pgfile_st *)&ptarget->ndt)->pgpow);
	pl_GetLoginFromBase( (char**)&ptarget->pSubToms,
							((pgfile_st *)&psources->ndt)->PrmExt.pHeader,
							1 << ((pgfile_st *)&psources->ndt)->pgpow);
	memcpy(	ptarget->pNextSubToms, ptarget->pSubToms,
			LOGIN_SIZE_PER_BYTES + 1 + SIZE_CRYPTO_KYE_PER_DWORD * sizeof(DWORD));
  #endif
	ptarget->pNextSubToms=
		ptarget->pSubToms= calloc(	sizeof(gm_indexes)/sizeof(*gm_indexes)+2,
									sizeof(SubTom_st));
#endif
	// check bases for ability to be merged (classificator version, ???)
	if(!threadMode) set_message(MSG_CHECK);
	if(!check_segments(psources, gs_source_count)) {
		close_bases(ptarget, gs_source_count);
		free(ptarget);
		unlink_base(gs_target_name);
		return 0;
	}
#ifdef PTRS_IN_META
	////
	{
			psources += gs_source_count;
			for(i=0; i<gs_source_count; i++){
				open_base(gs_source_name[i], psources+i, OBSC_SEQSP | OBSC_SMALL);
				psources[i].pNextSubToms=
					psources[i].pSubToms= (SubTom_st *)calloc(
							sizeof(gm_indexes)/sizeof(*gm_indexes)+2,
							sizeof(SubTom_st));
			}
			bzero((caddr_t)(&pinFirst), sizeof(index_st));
			create_indexEx(ptarget, "Attrs.str", (&pinFirst), ThreadCntxt);
			set_base_State(ptarget, gs_source_count+1);
			if(gs_result_file) {
				rf = mpcxc_fopen(gs_result_file, "w");
				fprintf(rf, "0\n");
				fclose(rf);
			}
			set_message(MSG_SUCCESS);
		}
		return 0;
	}
	if(init_MetaFile(threadMode, ThreadCntxt, psources, gs_source_count) != gs_source_count)
	{
		free(ptarget);
		unlink_base(gs_target_name);
		return 0;
	}
	if(!threadMode)
#endif
	{
		inc_progress();
		inc_progress();
		set_message(MSG_NDT);
	}
#ifdef PTRS_IN_META
	if(!merge_bases(ptarget, psources, gs_source_count, ptarget != psources-1 ? 0 : 95))
	{
		close_bases(ptarget, gs_source_count+1);
		report_error();
		free(ptarget);
		unlink_base(gs_target_name);
		return 0;
	}
	if(threadMode){
		if(threadMode == 2){
			i= 4;
		}else
			i= sizeof(gm_indexes)/sizeof(*gm_indexes);
	}else{
#else
	{
		if(!merge_bases(ptarget, psources, gs_source_count, 44)) {
			close_bases(ptarget, gs_source_count+1);
			report_error();
			free(ptarget);
			unlink_base(gs_target_name);
			return 0;
		}
#endif
		i= 0;
		set_message(MSG_INDEXES);
	}
	for(; i<sizeof(gm_indexes)/sizeof(*gm_indexes); i++) { // Debug : i<23 in release!
		flog("attempt to make \"%s\"\n", gm_indexes[i] );
		ok = merge_index(gm_indexes[i], ptarget, psources, gs_source_count);
		if(!ok) {
			close_bases(ptarget, gs_source_count+1);
			report_error();
			free(ptarget);
			unlink_base(gs_target_name);
			return 0;
		}
#ifdef PTRS_IN_META
		if(i == 3 && !threadMode)
			i= sizeof(gm_indexes)/sizeof(*gm_indexes);
#endif
	}
#ifdef PTRS_IN_META
	if(threadMode)
		;
	else
#endif
	{
		set_message(MSG_AUX);
		inc_progress();
		/*if(newSB)
			set_info(((pgfile_st *)(&ptarget->str)), ID_BLOCK_SIZE, &newSB, sizeof(tmpBlockSize));*/

		if(!build_aux(ptarget, psources, gs_source_count, 1)) {
			close_bases(ptarget, gs_source_count+1);
			report_error();
			free(ptarget);
			unlink_base(gs_target_name);
			return 0;
		}
	}
#ifdef PTRS_IN_META
	done_MetaFile(psources, gs_source_count);
#else
	set_base_State(ptarget, gs_source_count+1);
	if(gs_result_file) {
		rf = mpcxc_fopen(gs_result_file, "w");
		fprintf(rf, "0\n");
		fclose(rf);
	}
	set_message(MSG_SUCCESS);
#endif
	return 1;
}

void close_bases(base_st *pbases, int count)
{
	int i =0;
	while(i<count){
		close_base(pbases+i++);
	}
}

static void report_error(void)
{
	FILE *rf;
	int err;
	char *msg;

	if(!gs_result_file) return;
	msg = (char *)alloca(1024);
	err = gb_last_error();
	rf = mpcxc_fopen(gs_result_file, "w");
	fprintf(rf, "Error %d : %s\n", err, gb_err_msg(err, msg, 1024));
	fclose(rf);
}

static int build_aux(base_st *ptgt, base_st *psrc, int count, int progress)
{
	iter_st *pit;
	index_st *pin, *spin;
	int i, j, res;
	
	pit = (iter_st *)alloca(count*sizeof(iter_st));
	bzero((caddr_t)pit, count*sizeof(iter_st));
	pin = (index_st *)calloc((count+1), sizeof(index_st));
	spin = pin+1;
	if(!create_index(ptgt,
#ifdef MULTI_INDEX_STREAM_FILE
							"Aux.str"
#else
							"Aux"
#endif
							, pin)) {
		free(pin);
		return 0;
	}
	for(i=0; i<count; i++) {
		if(!open_index(psrc+i,
#ifdef MULTI_INDEX_STREAM_FILE
							"Aux.str"
#else
							"Aux"
#endif
								, spin+i,1))
			for(j=0; j<=i; j++) close_index(pin+j);
		init_iter(spin+i, pit+i);
	}
	for(i=0; i<count; i++)
		init_iter(spin+i, pit+i);
	res = make_aux(pin, pit, count, progress);
	for(j=0; j<=count; j++) close_index(pin+j);
	free(pin);
	return res;
}

static int check_segments(base_st *psrc, int count)
{
	index_st *pin;
	iter_st *pit;
	char stamp[8], stamp0[8], zerostamp[8], msg_[]="Error: Missing classificator version in base %s\n";
	u_int32_t clas;
	stream_st dstr;
	int nok, i, slabel=1, j, segCount= 0, AllocsegCount= 2l; 

	u_int16_t *pAllSegmentNumbers= 0;

	if((pAllSegmentNumbers=
			(u_int16_t *)malloc(sizeof(u_int16_t)*AllocsegCount))
								== 0)
	{
		puts(flog("Error: Not memory !!!\n"));
		return 0;
	}

	nok = 0;
	bzero(zerostamp, sizeof(zerostamp));
	bzero((caddr_t)&dstr, sizeof(dstr));
	if(gs_options & 1) {
		if(!get_info(&(psrc->key), "HSTS", stamp0)) {
			puts(flog("Missing sync label in base %s\n", gs_source_name[0]));
			slabel=0;
		}
		else {
			if(!memcmp(stamp0, zerostamp, 8)) {
				puts(flog("Zero sync label in base %s\n", gs_source_name[0]));
				return 0;
			}
		}
		for(i=1; i<count && !nok; i++) {
			if(!get_info(&(psrc[i].key), "HSTS", stamp)) {
				puts(flog("Missing sync label in base %s\n", gs_source_name[i]));
				if(slabel) return 0;
				else continue;
			}
			else {
				if(!memcmp(stamp0, zerostamp, 8)) {
					puts(flog("Zero sync label in base %s\n", gs_source_name[0]));
					return 0;
				}
				if (!slabel) {
					puts(flog("Sync label found only in base %s\n", gs_source_name[i]));
					return 0;
				}
			}
			nok = memcmp(stamp0, stamp, 8);
			if(nok) {
				puts(flog("Different sync label in base %s\n", gs_source_name[i]));
				return 0;
			}
		}
	}
	pin = (index_st *)alloca(sizeof(index_st));
	pit = (iter_st *)alloca(sizeof(iter_st));
	bzero((caddr_t)pin, sizeof(index_st));
	bzero((caddr_t)pit, sizeof(iter_st));

	open_index(psrc,
#ifdef MULTI_INDEX_STREAM_FILE
			"Aux.str"
#else
			"Aux"
#endif
			, pin, 1);

	init_iter(pin, pit);
	if(locate_key(pit, "Here")) {
		puts(flog(msg_, gs_source_name[i]));
		release_iter(pit);
		close_index(pin);
		free(pAllSegmentNumbers);
		return 0;
	}
	load_stream(pit, &dstr);
	j= (int)(dstr.ref.size >> 1);
	if(segCount + j > AllocsegCount){
		u_int16_t *pAllocTemp;
		AllocsegCount += j << 2;
		if((pAllocTemp=
				(u_int16_t *)malloc(sizeof(u_int16_t)*AllocsegCount))
									== 0)
		{
			puts(flog("Error: Not memory !!!\n"));
			release_iter(pit);
			close_index(pin);
			free(pAllSegmentNumbers);
			return 0;
		}
		memcpy(pAllocTemp, pAllSegmentNumbers,
						sizeof(u_int16_t)*segCount);
		free(pAllSegmentNumbers);
		pAllSegmentNumbers= pAllocTemp;
	}
	memcpy(pAllSegmentNumbers+segCount, dstr.data,
					sizeof(u_int16_t)*j);
	segCount += j;
	release_stream(&dstr);
	release_iter(pit);

	init_iter(pin, pit);
	if(locate_key(pit, "Clas")) {
		puts(flog(msg_, gs_source_name[0]));
		release_iter(pit);
		close_index(pin);
		free(pAllSegmentNumbers);
		return 0;
	}
	load_stream(pit, &dstr);
	memcpy(&clas, dstr.data, 4);
	release_stream(&dstr);
	release_iter(pit);

	close_index(pin);

	for(i=1; i<count && !nok; i++) {
		open_index(psrc+i,
#ifdef MULTI_INDEX_STREAM_FILE
			"Aux.str"
#else
			"Aux"
#endif
			, pin, 1);

		init_iter(pin, pit);
		if(locate_key(pit, "Here")) {
			puts(flog(msg_, gs_source_name[i]));
			release_iter(pit);
			close_index(pin);
			free(pAllSegmentNumbers);
			return 0;
		}
		load_stream(pit, &dstr);
		j= (int)(dstr.ref.size >> 1);
		if(segCount + j > AllocsegCount){
			u_int16_t *pAllocTemp;
			AllocsegCount += j << 2;
			if((pAllocTemp=
					(u_int16_t *)malloc(sizeof(u_int16_t)*AllocsegCount))
										== 0)
			{
				puts(flog("Error: Not memory !!!\n"));
				release_iter(pit);
				close_index(pin);
				free(pAllSegmentNumbers);
				return 0;
			}
			memcpy(pAllocTemp, pAllSegmentNumbers,
							sizeof(u_int16_t)*segCount);
			free(pAllSegmentNumbers);
			pAllSegmentNumbers= pAllocTemp;
		}
#ifdef VERSION62
		{
			int zz= j;
			while(zz--){
				if(((short*)dstr.data)[zz] == 236){
					j--;
					memcpy((short*)dstr.data + zz, (short*)dstr.data + zz + 1,
							(j - zz) * sizeof(short));
					break;
				}
			}
		}
#endif
		memcpy(pAllSegmentNumbers+segCount, dstr.data,
						sizeof(u_int16_t)*j);
		segCount += j;
		release_stream(&dstr);
		release_iter(pit);

		init_iter(pin, pit);
		if(locate_key(pit, "Clas")) {
			puts(flog(msg_, gs_source_name[i]));
			release_iter(pit);
			close_index(pin);
			free(pAllSegmentNumbers);
			return 0;
		}
		load_stream(pit, &dstr);
		nok = memcmp(&clas, dstr.data, 4);
		release_stream(&dstr);
		release_iter(pit);

		close_index(pin);
	}
	if(nok)
		puts(flog("Different classificator version in base %s\n", gs_source_name[i-1]));

	/*
	for(i= segCount -1, j= 0; i; j=0, i--){
		while (pAllSegmentNumbers[j] != pAllSegmentNumbers[i] && j < i)
			j++;
		if (j != i){
			puts(flog("Error: Cant merge overlaped Complect's\n"));
			free(pAllSegmentNumbers);
			return 0;
		}
	}
	*/
	free(pAllSegmentNumbers);
	return !nok;
}
