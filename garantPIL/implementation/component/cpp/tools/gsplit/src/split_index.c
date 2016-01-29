#include <stdlib.h>

#include <string.h>

#include "../../../libs/mrglib/src/gdbapi.h"
#include "../../../libs/mrglib/src/sets.h"

#include "toys.h"
#include "message.h"

extern int make_attrs_index(void *, index_st *pdest, int count, index_st *psrc, set_st *doclist);
extern int make_aux_index(index_st *pdest, int count, index_st *psrc, set_st *doclist);
extern int make_subname_index(void *,index_st *pdest, int count, index_st *psrc, set_st *doclist);
extern int make_kindcorr_index(void *,index_st *pdest, int count, index_st *psrc, set_st *doclist);
extern int make_blob_index(void *,index_st *pdest, int count, index_st *psrc, set_st *doclist);
extern int make_doc_index(void *,index_st *pdest, int count, index_st *psrc, set_st *doclist);
extern int make_ref_index(void *,index_st *pdest, int count, index_st *psrc, set_st *doclist);
extern int make_hindex(void *,index_st *pdest, int count, index_st *psrc, set_st *doclist);
extern int make_class_index(index_st *pdest, int count, index_st *psrc, set_st *doclist);
extern int make_base_hindex(void *,index_st *pdest, int count, index_st *psrc, set_st *doclist, set_st *link);
extern int make_linked_hindex(void *,index_st *pdest, int count, index_st *psrc, set_st *doclist, set_st *link);
extern int make_cr_index(index_st *pdest, int count, index_st *psrc, set_st *doclist);
#ifdef VERSION56
extern int make_Newcr_index(index_st *pdest, int count, index_st *psrc, set_st *doclist);
extern int make_control_index(void *,index_st *pdest, int count, index_st *psrc);
#endif

extern char * get_index_name(int);

#include <stdlib.h>
#include <stdio.h>

extern void ShowMessageFromContext(void *pCurrent, char *CurrMsg);

int number_Msg;

int make_index(	void *pCntx, char *name, base_st *targets, int count,
				base_st *psrcbase, set_st *doclist, set_st *link)
{
	index_st *pin, *ptin;
	int i, result;
	static char msg[128];
	
	pin = (index_st *)calloc(count+1, sizeof(index_st));
	ptin = pin+1;
#ifdef VERSION56
	if(!strcmp(name, "NewCorr") && !get_info(&(psrcbase->key), name, &(pin->hdr)))
		return 0;
	else
	if(!strcmp(name, "Control") && !get_info(&(psrcbase->key), name, &(pin->hdr)))
		return 0;
	else
	if(!strcmp(name, "Active") && !get_info(&(psrcbase->key), name, &(pin->hdr))) {
		for(i=0; i<count; i++) {
			create_index(targets+i, name, ptin+i);
			close_index (ptin+i);
		}
		return 0;
	}
#endif
	if(!open_index(psrcbase, name, pin, 1)) return -2;
#ifndef _USE_STDOUT 
	if ( number_Msg ) {
		strcpy(msg, get_message(MSG_INDEX));
		strcat(msg, get_message(MSG_INDEX+number_Msg));
		ShowMessageFromContext(pCntx, msg);
	}
#else
	*msg= 0;
#endif
	number_Msg++;
	for(i=0; i<count; i++){
  #ifdef PTRS_IN_META
		targets[i].str.hits= -1;
		targets[i].str.centries= -1;
  #endif
		create_index(targets+i, name, ptin+i);
		if (!strcmp(name, "Territory") || !strcmp(name, "DocKind") || !strcmp(name, "Adopted") || !strcmp(name, "Class")){
			ptin[i].hdr.keylen -= sizeof(stref_st) - 4 + ptin[i].hdr.strinfo.immds;
			ptin[i].hdr.nstreams= 1;
			ptin[i].kar.keylen= ptin[i].hdr.keylen;
		}
	}
	if(pin->hdr.key_count) {
		if(!strcmp(name, "Attrs.str"))
			result = make_attrs_index(pCntx, ptin, count, pin, doclist);
		else if(!strcmp(name, "Attribs")){
			result = make_attrs_index(pCntx, ptin, count, pin, doclist);
			for(i=0; i<count; i++){
				if(doclist[i].seg_32){
					free(doclist[i].seg_32);
					doclist[i].seg_32= 0;
				}
			}
		}else if (!strcmp(name, "Territory") || !strcmp(name, "DocKind"))
			result = make_base_hindex(pCntx, ptin, count, pin, doclist, link);
		else if (!strcmp(name, "Adopted") || !strcmp(name, "Class"))
			result = make_linked_hindex(pCntx, ptin, count, pin, doclist, link);
		else if (!strcmp(name, "Type") || !strcmp(name, "Kind") || !strcmp(name, "KeyWord") || !strcmp(name, "PublishedIn") 
#ifdef	VERSION62
		|| !strcmp(name,"AnnoUser") || !strcmp(name,"AnnoOrganization") || !strcmp(name,"AnnoTax") || !strcmp(name,"AnnoInterest") || !strcmp(name,"AnnoKind") || !strcmp(name, "ServiceInfo")
#endif
		|| !strcmp (name, "Class6") || !strcmp (name, "PhFirm") || !strcmp (name, "PhCountry") || !strcmp (name, "PhGroup") || !strcmp (name, "PhEffect") 
		|| !strcmp (name, "Chapter") || !strcmp (name, "Atc") || !strcmp (name, "RegStatus") || !strcmp (name, "LekForm") || !strcmp (name, "Mkb")
		)
			result = make_hindex(pCntx, ptin, count, pin, doclist);
		else if (!strcmp(name, "Correspondent"))
			result = make_cr_index(ptin, count, pin, doclist);
#ifdef VERSION56
		else if (!strcmp(name, "NewCorr"))
			result = make_Newcr_index(ptin, count, pin, doclist);
		else if (!strcmp(name, "Control"))
			result = make_control_index(pCntx, ptin, count, pin );
#endif
		else if (!strcmp (name, "RegDate") || !strcmp (name, "AnnulDate") || !strcmp (name, "Active"))
			result = make_ref_index (pCntx, ptin, count, pin, doclist);
		else if (!strcmp(name, "Respondent") || !strcmp(name, "SubName.str") || !strcmp(name, "SubName"))
			result = make_subname_index(pCntx, ptin, count, pin, doclist);
		else if (!strcmp(name, "KindCorr"))
			result = make_kindcorr_index(pCntx, ptin, count, pin, doclist);
		else if (!strcmp(name, "Blob"))
			result = make_blob_index(pCntx, ptin, count, pin, doclist);
		else if(!strcmp(name, "Aux")
#ifdef MULTI_INDEX_STREAM_FILE
			|| !strcmp(name, "Aux.str")
#endif
			)
			result = make_aux_index(ptin, count, pin, doclist);
		else
			result = make_doc_index(pCntx, ptin, count, pin, doclist);
	}
	else result = 0;
	close_index(pin);
	for(i=0; i<count; i++)
		close_index(ptin+i);
	hide_message();
	free(pin);
	return result;	
}

