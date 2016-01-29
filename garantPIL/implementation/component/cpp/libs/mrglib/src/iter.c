#include <fcntl.h>
#include <stdlib.h>

#include "gdbapi.h"
#include "stdindex.h"

	// seeks to greater or equal //
int locate_key(iter_st *, void *);

iter_st *init_iter(index_st *pin, iter_st *pit)
{
	bthdr_st *phdr;
	
	phdr = &(pin->hdr);
  if(!pit) pit = (iter_st *)ml_malloc(sizeof(iter_st));
  pit->pf = pin->pf;
  pit->keylen = pin->hdr.keylen;
	pit->keycmp = pin->keycmp;
	pit->strinfo.immds = pin->hdr.strinfo.immds;
	pit->strinfo.rndv = pin->hdr.strinfo.rndv;
	pit->nstreams = pin->hdr.nstreams;
  pit->ref_offs = phdr->keylen - (sizeof(stref_st) + pin->hdr.strinfo.immds - 4);
	pit->reclen = pin->reclen;
	pit->reccmp = pin->reccmp;
	pit->str = pin->str;
	pit->key_count = phdr->key_count;
	pit->depth = phdr->depth;

	if (((*(pit->pf)).pfhdr) == 0)
		return 0;

	if((*((*(pit->pf)).pfhdr)).page_size == 4096)
		pit->stack = (node_st *)ml_calloc(phdr->depth+1, sizeof(node_st_x2));
	else
		pit->stack = (node_st *)ml_calloc(phdr->depth+1, sizeof(node_st));

  if(pin->hdr.key_count)
	read_page(pit->pf, phdr->root, pit->stack);
  else
	memset( pit->stack, 0, pin->pf->pfhdr->page_size );
  pit->sp = 0;
  pit->cnode = pit->stack;
	pit->key = 0;
  return pit;
}

iter_st *init_iter_from(index_st *pin, iter_st *pit, void *key_from)
{
  pit = init_iter(pin, pit);
	if(!pit) return NULL;
	locate_key(pit, key_from);
  return pit;
}

void release_iter(iter_st *pit)
{
  free(pit->stack);
	pit->stack = NULL;
	pit->sp = 0;
	pit->key = 0;
}

static node_st *push_n_read(iter_st *pit, u_int32_t child_node)
{
	node_st *pn;

	pit->sp++;
	if((*((*(pit->pf)).pfhdr)).page_size == 4096){
		pn = (node_st *)(((node_st_x2*)pit->stack) + pit->sp);
		read_page(pit->pf, child_node, pn);
	}else{
		pn = pit->stack + pit->sp;
		read_page(pit->pf, child_node, pn);
	}
	return pn;
}

void *next_key(iter_st *pit)
{
  u_int32_t child_node;

	if((*((*(pit->pf)).pfhdr)).page_size == 4096)
	{
	  node_st_x2 *pn;

	  if(pit->cnode == NULL) return NULL;
		if(!(pit->sp) && !(pit->stack->count)) return NULL;
		pn = (node_st_x2 *)pit->cnode;
	  pn->key++;
	  child_node = *((u_int32_t *)(pn->keys + (4 + pit->keylen)*pn->key - 4));
	  if(pn->key == pn->count) { // process last ref
		if (child_node) {
		  while(child_node) {
			pn = (node_st_x2 *)push_n_read(pit, child_node);
					pn->key = 0;
			child_node = pn->ref0;
		  }
		}
		else { // last ref zero : go up...
		  while (pit->sp && pn->key==pn->count) {
			pit->sp--;
			pn = ((node_st_x2*)pit->stack) + pit->sp;
		  }
		  if (pn->key==pn->count) {
			pit->cnode = NULL;
					pit->pkey = NULL;
			return NULL;
		  }
		}
	  } 
	  else { 
		while (child_node) { // process following ref
		  pn = (node_st_x2 *)push_n_read(pit, child_node);
				pn->key = 0;
		  child_node = pn->ref0;
		}
	  }
	  pit->cnode = (node_st*)pn;
	  pit->pkey = pn->keys+(pit->keylen+4)*pn->key;
	}else{
	  node_st *pn;

	  if(pit->cnode == NULL) return NULL;
		if(!(pit->sp) && !(pit->stack->count)) return NULL;
		pn = pit->cnode;
	  pn->key++;
	  child_node = *((u_int32_t *)(pn->keys + (4 + pit->keylen)*pn->key - 4));
	  if(pn->key == pn->count) { // process last ref
		if (child_node) {
		  while(child_node) {
			pn = push_n_read(pit, child_node);
					pn->key = 0;
			child_node = pn->ref0;
		  }
		}
		else { // last ref zero : go up...
		  while (pit->sp && pn->key==pn->count) {
			pit->sp--;
			if((*((*(pit->pf)).pfhdr)).page_size == 4096)
				pn = (node_st *)(((node_st_x2*)pit->stack) + pit->sp);
			else
				pn = (pit->stack+pit->sp);
		  }
		  if (pn->key==pn->count) {
			pit->cnode = NULL;
					pit->pkey = NULL;
			return NULL;
		  }
		}
	  } 
	  else { 
		while (child_node) { // process following ref
		  pn = push_n_read(pit, child_node);
				pn->key = 0;
		  child_node = pn->ref0;
		}
	  }
	  pit->cnode = pn;
	  pit->pkey = pn->keys+(pit->keylen+4)*pn->key;
	}
  return (void *)pit->pkey;
}

void *prev_key(iter_st *pit)
{
	node_st *pn;
	u_int32_t child_node;

	if(pit->cnode == NULL) return NULL;
	if(!(pit->sp) && !(pit->stack->count)) return NULL;
	pn = pit->cnode;
	child_node = *((u_int32_t *)(pn->keys + (4 + pit->keylen)*pn->key - 4));
	pn->key--;
	if(pn->key != 0xFFFF) { // process last ref
		while(child_node) {
			pn = push_n_read(pit, child_node);
			pn->key = pn->count - 1;
			child_node = *((u_int32_t *)(pn->keys+pn->count*(4 + pit->keylen)-4));
		}
	} 
	else { 
		if (child_node) {
			do {
				pn = push_n_read(pit, child_node);
				pn->key = pn->count - 1;
				child_node = *((u_int32_t *)(pn->keys+pn->count*(4 + pit->keylen)-4));
			} while (child_node); 
		}
		else { // last ref zero : go up...
			while (pit->sp && pn->key==0xFFFF) {
				pit->sp--;
				pn = pit->stack+pit->sp;
			}
			if (pn->key == 0xFFFF) {
				pit->cnode = NULL;
				pit->pkey = NULL;
				return NULL;
			}
		}
	}
	pit->cnode = pn;
	pit->pkey = pn->keys+(pit->keylen+4)*pn->key;
	return (void *)pit->pkey;
}

void *first_key(iter_st *pit)
{
  node_st *pn;

	pn=pit->stack;
	pit->sp=0;
	if((*((*(pit->pf)).pfhdr)).page_size == 4096){
		((node_st_x2 *)pn)->key = 0;
	}else{
		pn->key = 0;
	}
	while(pn->ref0) {
		pn = push_n_read(pit, pn->ref0);
		if((*((*(pit->pf)).pfhdr)).page_size == 4096){
			((node_st_x2 *)pn)->key = 0;
		}else{
			pn->key = 0;
		}
	}
	pit->cnode = pn;
	pit->pkey = (pn->count) ? pn->keys : NULL;
	return pit->pkey;
}

void *last_key(iter_st *pit)
{
	u_int32_t child_node;
	node_st *pn;

	pn = pit->stack;
	pit->sp=0;
	pn->key = pn->count - 1;
	if(!(pn->count)) {
		pit->cnode = NULL;
		pit->pkey = NULL;
		return NULL;
	}
	child_node = *((u_int32_t *)(pn->keys+pn->count*(pit->keylen+4)-4));
	while(child_node) {
		pn = push_n_read(pit, child_node);
		pn->key = pn->count - 1;
		child_node = *((u_int32_t *)(pn->keys+pn->count*(pit->keylen+4)-4));
	}
	pit->cnode = pn;
	pit->pkey = pn->keys+pn->key*(pit->keylen+4);
	return pit->pkey;
}

int locate_key(iter_st *pit, void *key_to)
{
	int match;
	u_int32_t child_node;
	char *pkey;

	if((*((*(pit->pf)).pfhdr)).page_size == 4096){
		node_st_x2 *pn;
		
		pit->sp = 0;
		pn = (node_st_x2 *)pit->stack;
		if(!(pn->count)) {
			pit->cnode = NULL;
			pit->pkey = NULL;
			return 0;
		}
		do {
			pn->key = bfindgex(key_to, pn->keys, pn->count, pit->keylen+4, pit->keycmp);
			pkey = pn->keys + pn->key*(pit->keylen+4);
			child_node = *((u_int32_t *)(pkey - 4));
			if(pn->key < pn->count) match = (*(pit->keycmp))(pkey, key_to);
			else match = -1;
			if(!match) break;
			if(child_node) pn = (node_st_x2 *)push_n_read(pit, child_node);
			else break;
		} while(1);
		if(match < 0) { // seek to the next key
			while(pit->sp && pn->key == pn->count) {
				pn = ((node_st_x2*)pit->stack) + (pit->sp-=1);
			} 
		}
		if(!(pit->sp) && pn->key == pn->count) {
			pit->cnode = NULL;
			pit->pkey = NULL;
			return 0;
		}
		pit->cnode = (node_st *)pn;
		pkey = pn->keys + pn->key*(pit->keylen+4);
		pit->key = pn->key;
		pit->pkey = pkey;
	}else{
		node_st *pn;
		
		pit->sp = 0;
		pn = pit->stack;
		if(!(pn->count)) {
			pit->cnode = NULL;
			pit->pkey = NULL;
			return 0;
		}
		do {
			pn->key = bfindgex(key_to, pn->keys, pn->count, pit->keylen+4, pit->keycmp);
			pkey = pn->keys + pn->key*(pit->keylen+4);
			child_node = *((u_int32_t *)(pkey - 4));
			if(pn->key < pn->count) match = (*(pit->keycmp))(pkey, key_to);
			else match = -1;
			if(!match) break;
			if(child_node) pn = push_n_read(pit, child_node);
			else break;
		} while(1);
		if(match < 0) { // seek to the next key
			while(pit->sp && pn->key == pn->count) {
				pn = (pit->stack+(pit->sp-=1));
			} 
		}
		if(!(pit->sp) && pn->key == pn->count) {
			pit->cnode = NULL;
			pit->pkey = NULL;
			return 0;
		}
		pit->cnode = pn;
		pkey = pn->keys + pn->key*(pit->keylen+4);
		pit->key = pn->key;
		pit->pkey = pkey;
	}
	return (*(pit->keycmp))(pkey, key_to);
}

