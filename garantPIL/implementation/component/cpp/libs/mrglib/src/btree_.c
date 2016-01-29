#include "shared/Core/fix/mpcxc.h"
#include <stdio.h>
#include <stdlib.h>

#include "gdbapi.h"

static u_int16_t depth, pmax;
static u_int16_t level_keys[32];
static char **stack;
static u_int32_t cur_node, delta, enode, ekeys, lownodes;
static int32_t key_count;
static pgfile_st *pdest;
static keyarray_st *pkar;

static u_int32_t build_tree(int level)
{
  int i;
  char *pkey, *page;
  u_int32_t kfpage, page_size;
  u_int16_t count;

  kfpage = alloc_page(pdest);
  page_size = pdest->pfhdr->page_size;
  page = stack[level];
  bzero(page, page_size);
  pkey = page + 2;
  count = level_keys[level];
  if (level == depth-1) {
    if((ekeys != 0L) && (cur_node == enode)) {
      count++;
      enode += delta;
      ekeys--;
    }
    cur_node++;
    if (count == 0) return 0L;
    else {
      pkey += 4;
      for (i=0; i<count; i++) {
				key_count--;
        read_key(pkar, pkey);
        pkey += pkar->keylen+4;
      }
    }
  }
  else {
		// flog("BuildTree (%d): %ld keys to place\n", level, key_count);
    *((u_int32_t *)pkey) = build_tree(level+1);
    pkey += 4;
    for(i=0; i<count; i++ ) {
			key_count--;
      read_key(pkar, pkey);
      pkey += pkar->keylen;
			// flog("BuildTree (%d): %ld keys to place\n", level, key_count);
      *((u_int32_t *)pkey) = build_tree(level+1);
      pkey += 4;
    }
  }
  *((u_int16_t *)page) = count;
  write_page(pdest, kfpage, page);
  return kfpage;
}

static u_int32_t tree_limit(u_int16_t *levels, u_int16_t depth)
{
	u_int32_t keys, nodes;
	u_int16_t i;
	keys = *levels;
	for(nodes=1, i=1; i<depth; i++) {
		nodes *= levels[i-1] + 1;
		keys += nodes*levels[i];
	}
	lownodes = nodes;
	return keys;
}

u_int32_t build_btree(index_st *pin)
{
	u_int64_t max_swing;

	u_int32_t placed_keys, pre_placed_keys;
	u_int16_t i, page_size;
	char *pagebuf;

	pdest = pin->pf;
	page_size = pdest->pfhdr->page_size;
	if(pin->hdr.key_count == 0) {
		pin->hdr.root = alloc_page(pin->pf);
		pagebuf = (char *)ml_calloc(page_size, 1);
		write_page(pin->pf, pin->hdr.root, pagebuf); // Be sure that page filled by zero
		free(pagebuf);
		pin->hdr.order = (u_int16_t)(((page_size - 6)/((u_int32_t)pin->hdr.keylen+4)) >> 1);
		return pin->hdr.root;
	}
  pmax=(u_int16_t)((page_size - 6)/((u_int32_t)pin->hdr.keylen+4));
  depth = 1; lownodes = 1;
  level_keys[0] = (pmax-1) & 0xFFFE;
  placed_keys = tree_limit(level_keys, depth);
  while (placed_keys < pin->hdr.key_count) {
    level_keys[depth] = (pmax-1) & 0xFFFE;
    placed_keys = tree_limit(level_keys, ++depth);
  }
  pin->hdr.depth = depth;
  stack = (char **)alloca(depth*sizeof(char *));
  pin->hdr.order=pmax>>1;
  if(depth > 1) {
    while (placed_keys > pin->hdr.key_count) {
      level_keys[0]--;
      placed_keys = tree_limit(level_keys, depth);
    }
    level_keys[0]++;
    placed_keys = tree_limit(level_keys, depth);
    if (placed_keys>pin->hdr.key_count) {
		do{
		  max_swing= 0;
		  do {
			for (i=0, level_keys[depth]= 0; i<depth; i++) level_keys[i] = pin->hdr.order<<1;
			for (i=0; i<depth; i++) {
			  do {
				level_keys[i]--;
				placed_keys = tree_limit(level_keys, depth);
			  } while (placed_keys > pin->hdr.key_count && level_keys[i] > pin->hdr.order);
			  if (placed_keys < pin->hdr.key_count) {
				level_keys[i]++;
				pre_placed_keys = tree_limit(level_keys, depth);
				if (i == depth-1)
				{
					if (pre_placed_keys < pin->hdr.key_count)
					{
						placed_keys= pre_placed_keys;
					}else
						level_keys[i]--;
				}
				else
					placed_keys= pre_placed_keys;
			  }
			}
		  } while ((placed_keys > pin->hdr.key_count || level_keys[depth-1]<(pin->hdr.order+(pin->hdr.order>>1))) && pin->hdr.order-- );
		  max_swing= level_keys[0];
		  for (i=1; i<depth; i++) {
			  max_swing *= level_keys[1];
		  }
		}while(max_swing > pin->hdr.key_count && (--depth));
    }
		stack[0] = (char *)ml_malloc(((u_int32_t)depth)<<pdest->pgpow);
    for (i=1; i<depth; i++)
      stack[i] = stack[i-1]+page_size;
		if(pin->hdr.key_count-placed_keys == lownodes) {
			level_keys[depth-1]++;
			ekeys = 0;
			delta = 0;
		}
		else
    	ekeys = (pin->hdr.key_count - placed_keys) % lownodes;
    delta = (ekeys) ? (lownodes-1)/ekeys : 0;
  }
  else {
    level_keys[0] = (u_int16_t)(pin->hdr.key_count);
    lownodes = 1L;
    ekeys = 0L;
    delta = 0L;
		stack[0] = (char *)ml_malloc(page_size);
  }
  enode = 0;
  cur_node = 0;
  pkar = &(pin->kar);
	key_count = pin->hdr.key_count;
/*
	flog("Building tree for index \"%s\". %d keys to place.\n", pin->name, key_count);
	flog("BTree info: depth is %d, kpp is (", depth);
	for(i=0; i<depth; i++) flog(" %d", level_keys[i]);
	flog(" )\n");
	flog("Regularly placed %d keys, %d extra keys.\n", placed_keys, ekeys);
*/
  pin->hdr.root = build_tree(0);
/*
	flog("BTree built.\n");
	printf("Arrived in tree: %d keys", pin->hdr.key_count - key_count);
	if(key_count > 0)
		printf(", %d keys lost.\n\n",  key_count);
	else if(key_count < 0)
		printf(", %d waste keys added.\n\n", -key_count);
	else printf(".\n\n");
*/
  free(stack[0]);
  return pin->hdr.root;
}

