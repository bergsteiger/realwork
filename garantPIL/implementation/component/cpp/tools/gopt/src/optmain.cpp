#include "shared/Core/fix/mpcxc.h"
#include <cstdio>
#include <cstdlib>
#include <cerrno>

#include <cstring>
//#include <alloca.h>

#define __OPTMAIN_C

#include "log.h"
#include "osdep.h"
#include "gopt.h"
#include "ready.h"

#include <vector>
#include <map>

int gopt_options=0;
int opt_ndt;
char *indx_file_name= 0;

static char *make_dest_name(char *destname, char *srcname, char *destpath), msgO[]= "\n\tIndex - [%s].Optimizating...";

#ifdef MULTI_INDEX_STREAM_FILE
	static char *index_namesOther[] = { "Attrs.str", "Context.str", "Aux.str" };
	static char *index_copy_namesOther[] = { "NWCntxt.str", "NFContxt.str" };
#endif
static char *index_names[] = {
	"SubName", 
#ifndef MULTI_INDEX_STREAM_FILE
	"Attrs",
#elif defined(VERSION61)
	"Attribs", 
#endif
	"Territory", "Adopted", "PublishedIn", "Type", "Kind", "Date", "Number", "Status",
	"KeyWord", "RCode", "Respondent", "Correspondent", "RDate", "Status_ex",
#ifdef	VERSION56
	"NewCorr",
	"Control",
	"Class6",
#endif
#ifdef	VERSION62
	"AnnoUser", "AnnoOrganization", "AnnoTax", "AnnoInterest", "AnnoKind", "AnnoDate", "ServiceInfo",
#endif
#ifndef MULTI_INDEX_STREAM_FILE
	"Context",
#endif
	"VAnonced", "VIncluded", "VChanged", "VAbolished", "VLControl", "DocKind", "Class",
	"Segment", "SortDate", "Category", "Blob", "KindCorr",

	"PhFirm", "PhCountry", "RegDate", "AnnulDate", "TradeName", "LekForm",
	"IntName", "PhGroup", "PhEffect", "Chapter", "Atc", "RegStatus", "Mkb",
	"Active",
#ifndef MULTI_INDEX_STREAM_FILE
	, "Aux"
#endif
};

#ifdef INSTLL_CIB
	#include "PL_Proto.h"
	extern "C" void pl_GetLoginFromBase(char **, char *, int);
	extern "C" long DefValCryptoTag;
#endif

extern "C" int known_index(const char *);

extern int BlbHandles;
extern int pBlbHandles;
extern char *pPreBuff;

#ifdef MULTI_INDEX_STREAM_FILE

extern "C" streamfile_st *create_stream_subFile(char *path, index_st *pin);
extern "C" char *GetNameForTempFile(char *pCName, int hCFile);
extern "C" void impModifyName(char *);

static index_st *create_index_local(base_st *pbase, index_st *pSIn, const char *name, index_st *pin)
{
	if(get_info(&(pbase->key), name, NULL)) return NULL;
	if(!pin) pin = (index_st *)ml_malloc(sizeof(index_st));
	bzero((caddr_t)pin, sizeof(index_st));
	pin->mode = 1;
	if(!get_index_info(name, pin)) {
		pin->hdr.strinfo.immds = 4;
		pin->hdr.strinfo.rndv = 1;
		pin->hdr.nstreams = 1;
		pin->keycmp = (cmpfunc_ft)strcmp;
		pin->hdr.keylen = 16;
		pin->reclen = 4;
		pin->reccmp = longcmp;
		pin->hdr.nstreams = 1;
	}
	if(!pbase->pNextSubToms){
		pbase->pNextSubToms=
			pbase->pSubToms= (SubTom_st *)calloc(	100, // !!! Кривой вариант только для 100 индексов
											sizeof(SubTom_st));
	}
	pin->pbase = pbase;
	{
		char	*filename = (char *)ml_malloc(1024), *pExt;
		pin->pf= (pgfile_st *)calloc(1, sizeof(pgfile_st));
		strcpy(filename, pbase->key.name);
		pExt= strrchr(filename, '.')+1;
		strcpy(pExt, name);
		pExt= strrchr(pExt, '.');
		strcpy(pExt, ".key");
		impModifyName(filename);
		create_pgfile(filename, pin->pf, pSIn->pf->pfhdr->page_size);
		if(pbase->key.pfhdr->TomPerPages >= MAX_COUNT_FILE_HANDLES){
			pin->pf->pfhdr->TomPerPages=
				pbase->key.pfhdr->TomPerPages;
			pin->pf->PrmExt.maxFile_per_bytes
				= pin->pf->pfhdr->TomPerPages * pin->pf->pfhdr->page_size;
		}
		pin->pf->PrmExt.pCrptTag= (char*)&DefValCryptoTag;
		pin->pbase->pNextSubToms->pKey= pin->pf;
		free(filename);
	}
	pin->name = strdup(name);
	pin->phdrpage = pbase->key_header;
	bzero((caddr_t) &(pin->kar), sizeof(keyarray_st));
	pin->kar.fname = GetNameForTempFile(pbase->key.name, pbase->key.hfile);
	pin->kar.hkeys= c_io_open(pin->kar.fname, ACE_OS_O_CREAT | ACE_OS_O_RDWR | ACE_OS_O_BINARY); // GARANT_GCC
	reset_key_array(&(pin->kar), pin->hdr.keylen);
	{
		char *filename = (char *)ml_malloc(1024);
		strcpy(filename, pbase->key.name);
		pin->str= create_stream_subFile(filename, pin);
		pin->str->pgfile.PrmExt.pCrptTag= (char*)&DefValCryptoTag;
		pin->pbase->pNextSubToms->pStr= pin->str;
		pin->pbase->pNextSubToms->pName= strdup(name);
		pin->pbase->pNextSubToms++;
		free(filename);
	}
	pin->hdr.order = ((pin->pf->pfhdr->page_size-6)/(pin->hdr.keylen+4)) >> 1;
	pin->hdr.root = 0;
	pin->hdr.key_count = 0;
	pin->hdr.depth = 1;
	set_info(pin->pf, name, &(pin->hdr), sizeof(bthdr_st));
	return pin;
}
#endif

extern char FormtMsg[];
extern int treecnt;

int goptmain(char **srcname, int count, char *destpath)
{
	int i, ind, err, res, newSB;
	unsigned short tmpBlockSize;
	base_st pbase[2], *psrc, *pdest;
	char *destname;
	stamp_st stamp;
	bthdr_st hdr;
	char *msg, *missing, *s, msgCD[]="Can't optimize base on CD\n", SubNms[]= "SubName.str", *pSubNms, *pnxt, *cmpIfile;
	u_int32_t status;
#ifdef MULTI_INDEX_STREAM_FILE
	index_st input, output;
#endif
	pSubNms= 0;
	create_log("gopt.log", 0);
	destname = (char *)malloc(1024);
	msg = (char *)alloca(1024);
	bzero((caddr_t)pbase, sizeof(pbase));
	psrc = pbase; pdest = psrc+1;
	res = 0;
	for(i=0; i<count; i++) {
		newSB= 0;
		printf("\n");
		printf("\nSource base [%s]\n", srcname[i]);
		if(!open_base(srcname[i], psrc, OBSC_RNDSP | OBSC_MEDIUM)) {
			printf("Can't open source base %s\n", srcname[i]);
			res--;
			err = gb_last_error();
			if(!err)
				printf("The system returned %s\n", strerror(errno));
			else
				printf("Error found: %s\n", gb_err_msg(err, msg, 1024));
			continue;
		}
		newSB= ADD_BLOCK_SIZE;
#ifdef MULTI_INDEX_STREAM_FILE
		psrc->pNextSubToms=
			psrc->pSubToms= (SubTom_st *)calloc(
					sizeof(index_names)/sizeof(*index_names),
					sizeof(SubTom_st));
#endif
		if((status = get_ready(psrc))) {
			printf("Base %s isn't ready for optimization.\n", srcname[i]);
			printf("At least the following programs must be applied to the base %s:\n", srcname[i]);
			s = missing = missing_process_description(status);
			do {
				printf("\t%s\n", s);
				s += strlen(s) + 1;
			} while(*s);
			free(missing);
			close_base(psrc);
			continue;
		}
		make_dest_name(destname, srcname[i], destpath);
		printf("Target base [%s]\n", destname);
		if(!create_base(destname, pdest)) {
			res--;
			close_base(psrc);
			printf("Can't create base %s\n", destname);
			err = gb_last_error();
			if(!err)
				printf("The system returned %s\n", strerror(errno));
			else
				printf("Error found: %s\n", gb_err_msg(err, msg, 1024));
			continue;
		}
#ifdef MULTI_INDEX_STREAM_FILE
  #ifdef INSTLL_CIB
		pl_GetLoginFromBase( (char**)&pdest->pNextSubToms,
								(char *)((pgfile_st *)&pdest->ndt)->PrmExt.pHeader,
								1 << ((pgfile_st *)&pdest->ndt)->pgpow);
		pl_GetLoginFromBase( (char**)&pdest->pSubToms,
								(char *)((pgfile_st *)&psrc->ndt)->PrmExt.pHeader,
								1 << ((pgfile_st *)&psrc->ndt)->pgpow);
		memcpy(	pdest->pNextSubToms, pdest->pSubToms,
				LOGIN_SIZE_PER_BYTES + 1 + SIZE_CRYPTO_KYE_PER_DWORD * sizeof(DWORD));
  #endif
		pdest->pNextSubToms=
			pdest->pSubToms= (SubTom_st *)calloc(
					sizeof(index_names)/sizeof(*index_names),
					sizeof(SubTom_st));
#endif
		if(psrc->key.pfhdr->TomPerPages != 0l){
			if(psrc->key.pfhdr->TomPerPages >= MAX_COUNT_FILE_HANDLES){
				pdest->key.pfhdr->TomPerPages= psrc->key.pfhdr->TomPerPages;
				pdest->key.PrmExt.maxFile_per_bytes=
					pdest->key.pfhdr->TomPerPages * pdest->key.pfhdr->page_size;
			}else{
				printf(msgCD);
				continue;
			}
		}
		if(indx_file_name){
			;// skip change dest ndt
		}else if(psrc->ndt.pfhdr->TomPerPages != 0l){
			if(psrc->ndt.pfhdr->TomPerPages >= MAX_COUNT_FILE_HANDLES){
				pdest->ndt.pfhdr->TomPerPages= psrc->ndt.pfhdr->TomPerPages;
				pdest->ndt.PrmExt.maxFile_per_bytes=
					pdest->ndt.pfhdr->TomPerPages * pdest->ndt.pfhdr->page_size;
			}else{
				printf(msgCD);
				continue;
			}
		}
		if(psrc->str.pgfile.pfhdr->TomPerPages != 0l){
			if(psrc->str.pgfile.pfhdr->TomPerPages >= MAX_COUNT_FILE_HANDLES){
				pdest->str.pgfile.pfhdr->TomPerPages= psrc->str.pgfile.pfhdr->TomPerPages;
				pdest->str.pgfile.PrmExt.maxFile_per_bytes=
					pdest->str.pgfile.pfhdr->TomPerPages * pdest->str.pgfile.pfhdr->page_size;
			}else{
				printf(msgCD);
				continue;
			}
		}
#ifndef MULTI_INDEX_STREAM_FILE
		opt_ndt = (gopt_options & GOO_NDT) && 1;
#endif
		if(get_info(&(psrc->key), index_names[0], &hdr)) {
			if(indx_file_name){
				printf(msgCD);
				continue;
			}
			ind= 0;
		}else{
			if(indx_file_name){
				ace_os_unlink(pdest->ndt.name);
				c_io_close(*psrc->ndt.postFileHandles);
				memcpy(pdest->ndt.pfhdr,psrc->ndt.pfhdr,512);
				c_io_close(*pdest->ndt.postFileHandles);
				pdest->ndt.hfile=
					*pdest->ndt.postFileHandles=
						c_io_open(		psrc->ndt.name, 
									#if defined(BRDR32) || defined(_DEBUG)
											ACE_OS_O_RDWR |
									#else
											ACE_OS_O_WRONLY |
									#endif
											ACE_OS_O_BINARY);
				if(pdest->ndt.hfile == -1){
					printf(msgCD);
					continue;
				}
				free(pdest->ndt.name);
				pdest->ndt.name= strdup(psrc->ndt.name);
				pdest->ndt.AddedPage= 1 + pdest->ndt.pfhdr->last_page;
				ind= 1;
				cmpIfile= indx_file_name;
				pnxt= strchr(indx_file_name, '&');
				if(pnxt)
					;
				else{
					pnxt= strchr(indx_file_name, 0);
				}
			}else
				ind= 1;
			pSubNms= SubNms;
		}
		for(; ind < sizeof(index_names)/sizeof(*index_names); ind++) {
			if ( get_info(&(psrc->key), index_names[ind], &hdr)) {
				if(memcmp(cmpIfile, index_names[ind], pnxt-cmpIfile)){
					printf(msgO, index_names[ind]);
					hdr.root = opt_tree(psrc, &hdr, pdest, index_names[ind]);
					set_info(&(pdest->key), get_index_name(known_index(index_names[ind])), &hdr, sizeof(bthdr_st));
				}else{
					char nm[2048];
					int ln= strlen(pbase->ndt.name);
					memcpy(nm, pbase->ndt.name, ln-3);
					memcpy(nm+ln-3,cmpIfile, pnxt-cmpIfile);
					nm[ln-3+(pnxt-cmpIfile)]= 0;
					FILE *part_file= mpcxc_fopen (nm, "rt");
					if (false/*part_file && !feof(part_file)*/) {
						/*
						char str [4096], ref_str [32];
						char *pkey= (char*)alloca(output.hdr.keylen);
						Ref mask;
						KindCorrRef towrite [512];
						std::vector<u_int64_t> masks;
						std::map<short, unsigned long> map_segment_masks;
						long prev_id = 0;

						stream_st *pdstr, pstr[2];
						stref_st *pref;

						bzero((caddr_t)pstr, sizeof(pstr));
						pdstr = pstr+1;
						pdstr->flags = SF_NOALLOC;

						printf("\n\tIndex - [%s].Importing...", index_names[ind]);
						create_index(pdest, index_names[ind], &output);
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
							sscanf (str, "%ld.%ld", pkey, pkey+4);

							masks.clear ();
							for (char* ptr = delimiter+2; *ptr; ) {
								sscanf (ptr, "%ld.%ld", &mask.DocId, &mask.Sub);
								u_int64_t to_put = (((u_int64_t)mask.DocId) << 32) + (u_int64_t)mask.Sub;
								masks.push_back (to_put);
								char* next_ptr = strchr (ptr, ' ');
								if (!next_ptr)
									break;
								ptr = next_ptr + 1;
							}

							KindCorrRef* ptr = towrite;
							long size = 0;
							for (std::vector<u_int64_t>::const_iterator it = masks.begin (); it != masks.end (); it++, ptr++, size += sizeof (*ptr)) {
								u_int64_t at_it = *it;
								ptr->seg = (short) ((at_it >> 32) & 0xFFFF);
								ptr->mask = (long) (at_it & 0xFFFFFFFF);
								ptr->reserved = 0;
							}
							create_stream(&output, pdstr);
							write_stream(pdstr, towrite, size);
							pref= (stref_st *)(pkey + (output.hdr.keylen - (sizeof(*pdstr) + output.hdr.strinfo.immds - 4)));
							attach_stream(pdstr, pref);
							close_stream(pdstr);
							add_key(&output, pkey);
						}
						pdstr->flags &= ~SF_NOALLOC;
						close_stream(pdstr);
						close_index(&output);
						treecnt++;
						printf(FormtMsg, treecnt, output.hdr.key_count, index_names[ind]);
						*/
					}else{
						printf(msgO, index_names[ind]);
						hdr.root = opt_tree(psrc, &hdr, pdest, index_names[ind]);
						set_info(&(pdest->key), get_index_name(known_index(index_names[ind])), &hdr, sizeof(bthdr_st));
					}
				}
			} else {
				create_index(pdest, index_names[ind], &output);
				c_io_close(output.kar.hkeys);
				ace_os_unlink(output.kar.fname);
			}
		}
		if(get_info(&(psrc->key), "HSTS", &stamp))
			set_info(&(pdest->key), "HSTS", &stamp, sizeof(stamp_st));
		set_base_state(pdest, get_final_mask(psrc->ready_flags));
		pdest->flags |= BF_OPTIMAL;
#ifdef MULTI_INDEX_STREAM_FILE
		if(indx_file_name)
			;// skip index_copy_namesOther
		else for(ind=0; ind < sizeof(index_copy_namesOther)/sizeof(*index_copy_namesOther); ind++) {
			if(open_index(psrc, index_copy_namesOther[ind], &input,0)) {
				char *buffP= (char*) alloca(input.str->pgfile.pfhdr->page_size);
				u_int32_t currPage= 1;
				int y= 0;
				char *filename0 = strdup(pdest->key.name);
				char *filename1 = strdup(pdest->key.name);

				strcpy(strrchr(filename0, '.'), strrchr(input.str->pgfile.name, '.'));
				strcpy(strrchr(filename1, '.'), strrchr(input.pf->name, '.'));

				output.str= (streamfile_st*)calloc(1, sizeof(streamfile_st));
				output.pf= (pgfile_st*)calloc(1, sizeof(pgfile_st));

				create_pgfile(filename0, &output.str->pgfile, input.str->pgfile.pfhdr->page_size);
				create_pgfile(filename1, output.pf, input.pf->pfhdr->page_size);
				if(pdest->key.pfhdr->TomPerPages >= MAX_COUNT_FILE_HANDLES){
					output.pf->pfhdr->TomPerPages= output.str->pgfile.pfhdr->TomPerPages=
						pdest->key.pfhdr->TomPerPages;
					output.pf->PrmExt.maxFile_per_bytes
						= output.pf->pfhdr->TomPerPages * input.pf->pfhdr->page_size;
					output.str->pgfile.PrmExt.maxFile_per_bytes
						= output.str->pgfile.pfhdr->TomPerPages * input.str->pgfile.pfhdr->page_size;
				}
#ifdef BRDR32
				*(long*)output.pf->PrmExt.pCrptTag= *(long*)output.str->pgfile.PrmExt.pCrptTag= 0l;
#elif defined(INSTLL_CIB)
				output.pf->PrmExt.pCrptTag=
					output.str->pgfile.PrmExt.pCrptTag= (char*)&DefValCryptoTag;
#endif
				printf("\nIndex - [%s].Copyng...", input.name);
				while(currPage <= input.str->pgfile.pfhdr->last_page){
					read_page(&input.str->pgfile, currPage, buffP);
					write_page(&output.str->pgfile, currPage, buffP);
					currPage++;
				}
				{
					char *in;
					in = input.str->pgfile.attr_area;
					while (*in && strcmp(ID_PACKED, in+1)) in += *in;
					memcpy(output.str->pgfile.attr_area, input.str->pgfile.attr_area, in-input.str->pgfile.attr_area);
				}
				close_pgfile(&output.str->pgfile);
				currPage= 1;
				y= 0;
				while(currPage <= input.pf->pfhdr->last_page){
					read_page(input.pf, currPage, buffP);
					write_page(output.pf, currPage, buffP);
					currPage++;
				}
				{
					char *in;
					in = input.pf->attr_area;
					while (*in && strcmp(ID_PACKED, in+1)) in += *in;
					memcpy(output.pf->attr_area, input.pf->attr_area, in-input.pf->attr_area);
				}
				close_pgfile(output.pf);
				free(filename0);
				free(filename1);
				free(output.str);
				free(output.pf);
			}
		}
		opt_ndt = (gopt_options & GOO_NDT) && 1;
		if(indx_file_name){
			;// skip index_copy_namesOther
		}else for(ind=0; ind < sizeof(index_namesOther)/sizeof(*index_namesOther); ind++) {
			open_index(psrc, index_namesOther[ind], &input,1);
			hdr= input.hdr;
			create_index_local(pdest, &input, input.name, &output);
			printf(msgO, input.name);
			hdr.root = opt_treeIndex(&input, &hdr, &output, input.name);
			set_info(output.pf, get_index_name(known_index(input.name)), &hdr, sizeof(bthdr_st));
			c_io_close(output.kar.hkeys);
			ace_os_unlink(output.kar.fname);
			free(output.kar.fname);
			if(pSubNms){
				char *NewIndex_names[] = {"CalIn.str", "CalAb.str", "CalCh.str", "Tag.str"};
				int goOptNew= 0, curNewIndex= 0;
				SubTom_st *p1ey = psrc->pSubToms;
				while (strcmp (p1ey->pName, "Attrs.str"))
					p1ey++;
				do{
					if (get_info (p1ey->pKey, pSubNms, &hdr)) {
						open_index(psrc, pSubNms, &input,1);
						if(pSubNms == SubNms){
							goOptNew++;
						}
						hdr= input.hdr;
						get_index_info(pSubNms, &output);
						output.name = strdup(pSubNms);
						output.phdrpage = pdest->key_header;
						bzero((caddr_t) &(output.kar), sizeof(keyarray_st));
						output.kar.fname = GetNameForTempFile(pbase->key.name, pbase->key.hfile);
						output.kar.hkeys= c_io_open(output.kar.fname, ACE_OS_O_CREAT | ACE_OS_O_RDWR | ACE_OS_O_BINARY); // GARANT_GCC
						reset_key_array(&(output.kar), output.hdr.keylen);
						output.hdr.order = ((output.pf->pfhdr->page_size-6)/(output.hdr.keylen+4)) >> 1;
						output.hdr.root = 0;
						output.hdr.key_count = 0;
						output.hdr.depth = 1;
						set_info(output.pf, pSubNms, &(output.hdr), sizeof(bthdr_st));
						printf(msgO, pSubNms);
						hdr.root = opt_treeIndex(&input, &hdr, &output, pSubNms);
						set_info(output.pf, get_index_name(known_index(input.name)), &hdr, sizeof(bthdr_st));
						c_io_close(output.kar.hkeys);
						ace_os_unlink(output.kar.fname);
						free(output.kar.fname);
					} else {
						create_index(pdest, pSubNms, &output);
						c_io_close(output.kar.hkeys);
						ace_os_unlink(output.kar.fname);
					}
				}while(goOptNew && curNewIndex < sizeof(NewIndex_names)/sizeof(*NewIndex_names)&& (pSubNms= NewIndex_names[curNewIndex++]));
				pSubNms= 0;
			}
		}
#endif
		if(!(gopt_options & GOO_NDT))
			strcpy(destname, pdest->ndt.name);
		close_base(pdest);
		if(!(gopt_options & GOO_NDT))
			ace_os_unlink(destname);
		close_base(psrc);
	}
	free(destname);
	if(indx_file_name) free(indx_file_name);
	if(BlbHandles != -1){
		c_io_close(BlbHandles);
		free(pPreBuff);
	}
	if(pBlbHandles != -1){
		c_io_close(pBlbHandles);
	}
	puts("\nOk.\n");
	return res;
}

static char *make_dest_name(char *destname, char *srcname, char *destpath)
{
	char *s;

	strcpy(destname, destpath);
	s = strchr(destname, '\0');
	if (*(s-1) != '/'  && *(s-1) != '\\') {
		*s = '/';
		*(s+1) = '\0';
	}
	s = strrchr(srcname, '\\');
	if(s == 0)
		s = strrchr(srcname, '/');
	if(s != 0)
		strcat(destname, s+1);
	else
		strcat(destname, srcname);
	return destname;
}
