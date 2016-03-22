#include "shared/Core/fix/mpcxc.h"
#include <stdlib.h>
#include <stdio.h>

#include <string.h>
//#include <alloca.h>

#include "../../../libs/mrglib/src/gdbapi.h"
#include "../../../libs/mrglib/src/sets.h"
#include "../../../libs/mrglib/src/log.h"

#include "toys.h"

#include "progress.h"

extern set_st *segset;
extern samedocs_count;

int make_aux_index(index_st *pdest, int count, index_st *psrc, set_st *doclist)
{
	iter_st *pit;
	stream_st pistr[2], *postr;
	int i, j, bicount;
	stref_st *pstref;
	char *pkey;
	baseinfo_st *pbi;
	int kpp, proceed;

	proceed = psrc->hdr.key_count;
	kpp = get_index_weight(psrc->name);
	kpp = (kpp) ? proceed / kpp : proceed+1;
	proceed = 0;
	flog("Processing index: \"%s\"...\t", psrc->name);
	bzero((caddr_t)pistr, sizeof(pistr));
	postr = pistr+1;
	postr->flags |= SF_NOALLOC;
	pit = (iter_st *)alloca(sizeof(iter_st));
	init_iter(psrc, pit);
	for(pkey=first_key(pit); pkey; pkey=next_key(pit)) {
		if (!strcmp (pkey, "Edis") || !strcmp (pkey, "Inf7") || !strcmp (pkey, "InfP") || !strcmp (pkey, "InfL") || !strcmp (pkey, AUX_NUMBERS) || !strcmp (pkey, AUX_NUMBERS_RCODE) || !strcmp (pkey, AUX_RELEVANCY_CALCULATED_CHANGES))
			continue;
		pstref = get_stref(pit, 0); // (stref_st *)(pkey + pit->ref_offs);
		if(!strcmp(pkey, "Here")) {
			for(i=0; i<count; i++) {
				create_stream(pdest+i, postr);
				if (samedocs_count) {
					short seg = 999;
					write_stream(postr, &seg, sizeof (seg));
				} else {
					if(segset[i].isDocsList){
						if(segset[i].pSourceBase){
							write_stream(postr,
								(char*)segset[i].pSourceBaseHere+
									*(long*)segset[i].pSourceBaseHere+sizeof(long)
									+sizeof(*segset[i].pSourceBaseHere),
											*(short*)((char*)segset[i].pSourceBaseHere+
									*(long*)segset[i].pSourceBaseHere+sizeof(long)));
							free(segset[i].pSourceBaseHere);
						}else
							write_stream(postr, segset[i].set+sizeof(int), *(int*)segset[i].set <<1);
						free(segset[i].set);
					}else
						write_stream(postr, segset[i].set, segset[i].count<<1);
				}

				attach_stream(postr, pstref);
				close_stream(postr);
				add_key(pdest+i, pkey);
			}
		}
		else if(!strcmp(pkey, "Base")) {
			load_stream(pit, pistr);
			bicount = pistr->ref.size / sizeof(baseinfo_st);
			pbi = (baseinfo_st *)pistr->data;
			if(!(pbi->BaseId)) { 
				pbi++;
				bicount--;
			}
			for(i=0; i<count; i++) {
			  if(!segset[i].pSourceBase)
				create_stream(pdest+i, postr);
				if(segset[i].pSourceBase){
					baseinfo_st *pbiNew=
						(baseinfo_st *)((char*)segset[i].pSourceBaseHere+sizeof(long));
					long countNew= *(u_int32_t*)segset[i].pSourceBaseHere
										/ sizeof(baseinfo_st);
					for(j=0; j<countNew; j++) {
						memcpy(	&(pbiNew[j].LastUpdate.RevisionDate),
								&(pbi->LastUpdate.RevisionDate),
								sizeof(date_st));
					}
					write_stream(postr, pbiNew, countNew*sizeof(baseinfo_st));
				}else
					write_stream(postr, pbi, bicount*sizeof(baseinfo_st));
				attach_stream(postr, pstref);
				close_stream(postr);
				add_key(pdest+i, pkey);
			}
			release_stream(pistr);
		} else if (pkey [0] == '-' || pkey [0] == '|') {
			if (!samedocs_count) {
				short seg = (short)(0x7fff && atol (pkey + 1));
				load_stream(pit, pistr);
				pstref = get_stref(pit, 0);
				for (i=0; i<count; i++) {
					if (bsearch (&seg, segset[i].set, segset[i].count, sizeof (short), shrtcmp)) {
						move_stream(pistr, pdest[i].str, pstref);
						add_key(pdest+i, pkey);
					}
				}
				release_stream(pistr);
			}
		} else {
			load_stream(pit, pistr);
			pstref = get_stref(pit, 0); // (stref_st *)(pkey+pit->ref_offs);
			for(i=0; i<count; i++) {
				move_stream(pistr, pdest[i].str, pstref);
				add_key(pdest+i, pkey);
			}
			release_stream(pistr);
		}
	}
	postr->flags &= ~SF_NOALLOC;
	close_stream(postr);
	flog("Done.\n");
	return 0;
}

