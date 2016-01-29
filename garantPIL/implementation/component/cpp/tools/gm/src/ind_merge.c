#include "shared/Core/fix/mpcxc.h"
#include <stdlib.h>

#include <string.h>
//#include <alloca.h>

#include "osdep.h"
#include "../../../libs/mrglib/src/gdbapi.h"
#include "../../../libs/mrglib/src/log.h"

extern int merge_doc_index(index_st *, iter_st *, int , int );
extern int merge_subname_index(index_st *, iter_st *, int , int );
extern int merge_blob_index(index_st *, iter_st *, int , int );
extern int merge_hindex(index_st *, iter_st *, int , int );
extern int merge_lhindex(index_st *, iter_st *, int , int );

#ifdef PTRS_IN_META
	extern int sync_indexes(index_st *pind, int count, index_st *poutind);
#endif

int merge_index(char *name, base_st *pbtarget, base_st *pbsrc, int count)
{
	index_st *pin, *psrcin;
	iter_st *spit;
	int i, started, ok;
	/**/
	
	pin = (index_st *)calloc(count+1, sizeof(index_st));
	psrcin = pin+1;
	spit = (iter_st *)alloca(count*sizeof(iter_st));
	bzero((caddr_t)spit, count*sizeof(iter_st));
	for(i=0, started=0; i<count; i++) {
		if(open_index(pbsrc+i, name, psrcin+started,1)) {
			if(psrcin[started].hdr.key_count == 0) {
				close_index(psrcin+started);
			}
			else {
				init_iter(psrcin+started, spit+started);
				started++;
			}
		}
		else { 
			for(i=0; i<started; i++) close_index(psrcin+i);
			create_index(pbtarget, name, pin);
			close_index(pin);
			return !strcmp (name, "Tag.str");
		}
	}
	create_index(pbtarget, name, pin);
	if(!started) {
		close_index(pin);
		return 1;
	}
	if(!strcmp(name, "Type") || !strcmp(name, "Kind") || !strcmp(name, "KeyWord") || !strcmp(name, "PublishedIn") || 
#ifdef	VERSION62
		!strcmp(name, "AnnoUser") || !strcmp(name, "AnnoOrganization") || !strcmp(name, "AnnoTax") || !strcmp(name, "AnnoInterest") || !strcmp(name, "AnnoKind") || !strcmp(name, "ServiceInfo") || 
#endif
		!strcmp(name, "DocKind") || !strcmp(name, "Territory")){
#ifdef PTRS_IN_META
		index_st *poutind= (index_st *)alloca(sizeof(*poutind)*count);
		int rpt= count;
		memset(poutind, 0, sizeof(*poutind)*count);
		while(rpt--){
			poutind[rpt].kar.cache= (char *)ml_malloc((poutind[rpt].hdr.keylen= psrcin[rpt].hdr.keylen)*psrcin[rpt].hdr.key_count);
		}
		sync_indexes(psrcin,count,poutind);
		rpt= count;
		while(rpt--){
			psrcin[rpt].kar= poutind[rpt].kar;
		}
#endif
		ok = merge_hindex(pin, spit, started, get_index_weight(name));
	}else if(!strcmp(name, "Class") || !strcmp(name, "Adopted")){
#ifdef PTRS_IN_META
		index_st *poutind= (index_st *)alloca(sizeof(*poutind)*count);
		int rpt= count;
		memset(poutind, 0, sizeof(*poutind)*count);
		while(rpt--){
			poutind[rpt].kar.cache= (char *)ml_malloc((poutind[rpt].hdr.keylen= psrcin[rpt].hdr.keylen)*psrcin[rpt].hdr.key_count);
		}
		sync_indexes(psrcin,count,poutind);
		rpt= count;
		while(rpt--){
			psrcin[rpt].kar= poutind[rpt].kar;
		}
#endif
		ok = merge_lhindex(pin, spit, started, get_index_weight(name));
	}else if(!strcmp(name, "SubName.str"))
		ok= merge_subname_index(pin, spit, started, get_index_weight(name));
	else if(!strcmp(name, "Blob"))
		ok = merge_blob_index(pin, spit, started, get_index_weight(name));
#ifdef	VERSION56
  #ifndef PTRS_IN_META
	else if(!strcmp(name, "Class6") || !strcmp(name, "Control") || (!strcmp(name, "Context.str")))
		ok = 0;
  #endif
#endif
	else
		ok = merge_doc_index(pin, spit, started, get_index_weight(name));
	for(i=0; i<started; i++)
		close_index(psrcin+i);
	close_index(pin);
	free(pin);
	return started;
}

