#include <stdlib.h>

#include <string.h>

#include "hc_index.h"

int collect_string_keys(set_st *map, iter_st *pit, u_int32_t *levcounts)
{
	char *pkey, *keystr;
	hierkey_st *hkey;
	int level, levlen;
	u_int32_t pcount, pid;
	hkey_item *pitems, *pcur, *pitem;

	pitems = (hkey_item *)(map->set);
	pcur = pitems;
	pid = 0; level = 0;
	levlen = pit->keylen - sizeof(hierkey_st)+2;
	levlen -= (sizeof(stref_st) - 4 + pit->strinfo.immds)*pit->nstreams;
	levcounts[0] = 0;
	for(pkey=first_key(pit); pkey; pkey=next_key(pit)) {
		hkey = (hierkey_st *)pkey;
		if(level != hkey->level) {
			pcount = levcounts[level];
			if(level)
				pitems += levcounts[level-1];
			qsort(pitems, levcounts[level], sizeof(hkey_item), longcmp);
			level = hkey->level;
			levcounts[level] = 1;
		}
		else levcounts[level]++;
		//keystr = (char *)malloc(levlen*(level+1)); ///!!!
		keystr = (char *)malloc(levlen*(level+1));
		memset(keystr, 0, levlen*(level+1));
		if(level) {
			if(pid != hkey->pid) {
				pid = hkey->pid;
				pitem = (hkey_item *)bsearch(&(hkey->pid), pitems, levcounts[level-1], sizeof(hkey_item), longcmp);
			}
			strcpy(keystr, pitem->key);
			strcat(keystr, "\\");
		}
		else *keystr = '\0';
		strcat(keystr, hkey->key);
		pcur->key = keystr;
		pcur->id = hkey->id;
		pcur++;
	}
	qsort(map->set, map->count, map->reclen, longcmp);
	return level;
}

void extract_stream_data(set_st *set, stream_st *pstr)
{
	char *p;
	int i;

	if(!pstr->ref.size) {
		set->set = 0;
		set->count = 0;
		return;
	}
	//p = set->set = (char *)ml_malloc(pstr->ref.size); ///!!!
	p = set->set = (char *)malloc(pstr->ref.size);
	memset(p, 0, pstr->ref.size);
	set->count = pstr->ref.size / set->reclen;
	for(i=0; i<pstr->cblock; i++, p+=0x10000)
	{
		if(i == pstr->szBlockPointers){
			int jj;
			char **pNew=
				(char **)malloc(sizeof(char*) * (i+ALLOC_STEP_FOR_STREAM));

			if(pNew == 0){
				return;
			}
			for(jj=0; jj < i; jj++){
				pNew[jj] = pstr->ppBlock[jj];
			}
			free(pstr->ppBlock);
			pstr->ppBlock= pNew;
			for(jj=0; jj < ALLOC_STEP_FOR_STREAM; jj++){
				if((pstr->ppBlock[i+jj]= (char *)ml_malloc(0x10000))
						== 0)
					return;
			}
			pstr->szBlockPointers += ALLOC_STEP_FOR_STREAM;
		}
		memcpy(p, pstr->ppBlock[i], 0x10000);
		///!!!
		//memcpy(p, pstr->block[i], 0x10000);
	}
	if(pstr->cboffs){
		if(i == pstr->szBlockPointers){
			int jj;
			char **pNew=
				(char **)ml_malloc(sizeof(char*) * (i+ALLOC_STEP_FOR_STREAM));

			if(pNew == 0){
				return;
			}
			for(jj=0; jj < i; jj++){
				pNew[jj] = pstr->ppBlock[jj];
			}
			free(pstr->ppBlock);
			pstr->ppBlock= pNew;
			for(jj=0; jj < ALLOC_STEP_FOR_STREAM; jj++){
				if((pstr->ppBlock[i+jj]= (char *)ml_malloc(0x10000))
						== 0)
					return;
			}
			pstr->szBlockPointers += ALLOC_STEP_FOR_STREAM;
		}
		memcpy(p, pstr->ppBlock[i], pstr->cboffs);
		/// !!!
		//memcpy(p, pstr->block[i], pstr->cboffs);
	}
}

int hkeyitemstrcmp(const void *p1, const void *p2)
{
	return strcmp(((hkey_item *)p1)->key, ((hkey_item *)p2)->key);
}

void sort_string_keys_by_name(set_st *map)
{
	qsort(map->set, map->count, map->reclen, hkeyitemstrcmp);
}

void init_keys_map(set_st *map, u_int32_t key_count, u_int16_t reclen, u_int16_t count)
{
	u_int32_t len, i;
	u_int16_t j;
	hkey_item *pitem;
	set_st *pset;

	len = key_count * sizeof(hkey_item);
	//map->set = (char *)ml_malloc(len); ///!!!
	map->set = (char *)malloc(len);
	memset(map->set, 0, len);
	pitem = (hkey_item *)(map->set);
	map->reclen = sizeof(hkey_item);
	map->count = key_count;
	for(i=0; i<key_count; i++, pitem++) {
		//pset = (set_st *)ml_malloc(count*sizeof(set_st)); ///!!!
		pset = (set_st *)malloc(count*sizeof(set_st));
		memset(pset, 0, count*sizeof(set_st));
		pitem->data = pset;
		bzero(pset, count*sizeof(set_st));
		for (j=0; j<count; j++) pset[j].reclen = reclen;
	}
}

void free_keys_map(set_st *map, u_int16_t count)
{
	u_int32_t i;
	u_int16_t j;
	hkey_item *pitem;
	char *keystr;

	pitem = (hkey_item *)(map->set);
	for(i=0; i<map->count; i++, pitem++) {
		keystr = pitem->key;
		free(keystr);
		for(j=0; j<count; j++)
			if(pitem->data[j].count) free(pitem->data[j].set);
		free(pitem->data);
	}
	free(map->set);
}


