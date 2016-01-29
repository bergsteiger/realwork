#include "shared/Core/fix/mpcxc.h"
//#ifdef _DEBUG
//	#include <windows.h>
//#endif
#include <stdlib.h>
#include <stdio.h>

#include "../../../libs/mrglib/src/gdbapi.h"
#include "../../../libs/mrglib/src/sets.h"

static int seg_count;
char **segname= 0;
set_st *segset= 0;
static set_st *cset;

char *fileBuffRead= 0;

int NDT_SubFilesCount= 1;

extern char *output_path;
extern int split_bases;

extern long BlobTypesDouble[];
extern int BlobTypesDoubleCount;

int isBlobTypesDouble(long Tst, int count)
{
	while(count--)
	{
		if(BlobTypesDouble[count--] == Tst)
			return count;
	}
	return -1;
}

extern void free_my_global();

long *samedocs, samedocs_count = 0;
long *sameblobs, sameblobs_count = 0;

int get_seginfo(
#ifndef _WINDOWS
				FILE *file_in
#else
				char *pStr
#endif
				)
{
	int i, q= 0, j=0, r, alloc_count, nextW, rb= 0, tst, rr;
	long pos;
	set_st	*pre_segset;
	char	**pre_segname, *ptr;
	unsigned short RetN;

	alloc_count= ALLOC_STEP_FOR_STREAM;
	if((pre_segset = (set_st *)calloc(alloc_count,sizeof(set_st))) == 0)
		return 0;
	segset= pre_segset;
	pre_segset= 0;
	if((pre_segname = (char **)calloc(alloc_count,sizeof(char*))) == 0){
		free(segset);
		segset= 0;
		return 0;
	}
	segname= pre_segname;
	pre_segname= 0;

#ifndef _WINDOWS
	if(file_in == stdin)
#endif
	{
		int
#ifndef _WINDOWS
			ch,
#endif
			pre_size_buff= 
#ifdef BRDR32
				4096
#else
				ALLOC_STEP_FOR_STREAM
#endif
				;
		char *preBuff= (char*)malloc(pre_size_buff);
		if(preBuff == 0){
			free_my_global();
			return 0;
		}
		fileBuffRead= preBuff;
#ifndef _WINDOWS
	#if defined (__Solaris__) || defined (__Linux__) || defined (__FreeBSD__) // GARANT_FREEBSD
			printf ( "\nEnter filing for new complects ('^D' - quit from dialog):\n" );
	#else
			printf ( "\nEnter filing for new complects ('^Z' - quit from dialog):\n" );
	#endif
		for( i = 0; ((ch = getchar()) != EOF); i++ ){
			if(i == pre_size_buff){
				pre_size_buff += ALLOC_STEP_FOR_STREAM;
				if((preBuff= (char*)malloc(pre_size_buff)) == 0){
					free_my_global();
					return 0;
				}
				memcpy(preBuff, fileBuffRead, i);
				free(fileBuffRead);
				fileBuffRead= preBuff;
			}
			fileBuffRead[i] = (char)ch;
		}
#else
		i= strlen(pStr);
		memcpy(fileBuffRead, pStr, i+1);
#endif
		pos= (long)i;
	}
#ifndef _WINDOWS
	else{
		fseek(	file_in, 0l, ACE_OS_SEEK_END);	// seek to eof
		mpcxc_fgetpos(file_in, &pos);			// get file length
		fseek(  file_in, 0l, ACE_OS_SEEK_SET);	// seek to beginning

		if((fileBuffRead = (char *)calloc(1,(size_t)pos+10)) == 0){
			free_my_global();
			return 0;
		}
		i = fread(fileBuffRead, 1, (size_t)pos, file_in);
		if(!i){
			free_my_global();
			return 0;
		}
		if((fileBuffRead[i-1] != ':' && fileBuffRead[i-1] != 'T' && fileBuffRead[i-1] != 'S')
				&&
			(fileBuffRead[i-1] < '0' || fileBuffRead[i-1] > '9'))
			fileBuffRead[i-1]= '\n';
		else
			fileBuffRead[i]= '\n';
	}
#endif
	if(output_path != 0 && output_path[0] != '\0'){
		for(r =0; r < i && fileBuffRead[q] != DIRECTORIES_TERM; r++);
		if(r != i){
			free_my_global();
			return -2;
		}
	}
	seg_count = 0;
	do{
		segset[seg_count].NDTCopy= 0;
		if(fileBuffRead[q] != ';')
			while(++q < i &&
								(fileBuffRead[q] != ':' ||
									fileBuffRead[q+1] == DIRECTORIES_TERM));
		if(fileBuffRead[q] == ':'){
		  int opt;
		  char *pFnd= 0;
		  segname[seg_count]= fileBuffRead+q;
		  for(r=q+1;	r && *segname[seg_count] != '\0' &&
						*segname[seg_count] != '\n';r--, segname[seg_count]--)
				if(*segname[seg_count] == '}')
					pFnd= segname[seg_count];
		  segname[seg_count]++;
		  fileBuffRead[q]= 0;
		  opt= q;
		  while(r < opt--){
			  if(fileBuffRead[opt] == '?'){
				  fileBuffRead[opt]= 0;
				  segset[seg_count].isPacked++;
			  }else if(fileBuffRead[opt] == '*'){
				  fileBuffRead[opt]= 0;
				  segset[seg_count].isMenu++;
			  }/*else if(fileBuffRead[opt] == '#'){
				  fileBuffRead[opt]= 0;
				  segset[seg_count].NDTCopy++;
			  }*/
		  }
		  rr= 0;
		  if(*segname[seg_count] == '{'){
			  if(pFnd == 0){
				free_my_global();
				return -1;
			  }
			  segset[seg_count].iMulti= 1l;
			  if(!memcmp(segname[seg_count]+1, "Demo", 4)){
				  split_bases = true;
				  if(*(segname[seg_count]+5) == '+'){
					  segset[seg_count].isExtBlob = 1;
				  }
				  if(fileBuffRead[q+1] == '\n'){
					  strcpy(pFnd-1, pFnd+1);
					  segset[seg_count].put_first_disk= 1;
					  pFnd -=2;
					  *pFnd= '}';
					  q-=2;
				  }
				  NDT_SubFilesCount= 2;
				  if((segset[seg_count].sub_seg_set= (unsigned char*)malloc(2+0xffff*2+2+0xffff*2))
											== 0){
					free_my_global();
					return -1;
				  }
				  ((unsigned short*)segset[seg_count].sub_seg_set)[0]= 0;
				  ((unsigned short*)segset[seg_count].sub_seg_set)[0xffff]= 0;
				  if (*(segname[seg_count]+5) == ',')
  					segset[seg_count].iMulti= (long)atoi(segname[seg_count]+6);
				  segname[seg_count]= pFnd + 1;
			  }else{
				  *pFnd= '\0';
				  segset[seg_count].iMulti= (long)atoi(segname[seg_count]+1);
				  if( segset[seg_count].iMulti == 0l || segset[seg_count].iMulti < 1024){
					free_my_global();
					return -15;
				  }
				  segname[seg_count]= pFnd + 1;
				  if(*(pFnd-1) == '+')
					  segset[seg_count].isExtBlob= 1;
			  }
		  }
#ifndef _DEBUG
		  for(r= seg_count-1;	r != -1 &&
								strcmp(	segname[r], segname[seg_count]); r--);
		  if(r != -1){
			free_my_global();
			return -1;
		  }
#endif
		  if(segset[seg_count].put_first_disk){
			  rr= nextW= 2;
			  RetN= full_text_segment;
			  q++;
			  segset[seg_count].set= fileBuffRead+q;
			  q++;
		  } else if (fileBuffRead[q+1] == '+') {
			  samedocs = (long*) malloc (20000000 * sizeof (long));
			  sameblobs = (long*) malloc (2000000 * sizeof (long));
			  segset[seg_count].isDocsList= 2;
			  ptr = fileBuffRead + q + 2;
			  q += strlen (ptr);
			  while (*ptr && *ptr != '\n') {
				  if (*ptr == ' ')
					  ptr++;
				  if (*ptr == 'b') {
					  long blob_id = atol (ptr+1);
					  sameblobs [sameblobs_count++] = blob_id;
				  } else {
					  long doc_id = atol (ptr);
					  samedocs [samedocs_count++] = doc_id;
				  }
				  ptr = strchr (ptr + 1, ' ');
				  if (!ptr)
					  break;
			  }
			  segset[seg_count].sub_seg_set = malloc (2);
			  * (short*) segset[seg_count].sub_seg_set = 999;
			  segset[seg_count].set_docs = malloc (samedocs_count + 4);
			  segset[seg_count].count = samedocs_count;
		  } else if(fileBuffRead[q+1] == '#') {
			  segset[seg_count].isIgnoreHere= 1;
		  } else if(fileBuffRead[q+1] == '&'){
			  segset[seg_count].isDocsList= 1;
		  }else if(fileBuffRead[q+1] == '!'){
#ifdef BRDR32
					free_my_global();
					return -1;
/*#else
					segset[seg_count].isDocsList= 1;
					segset[seg_count].isMenu++;
					if((segset[seg_count].pSourceBase= strchr(fileBuffRead+q+1, '&')))
						q += (int)segset[seg_count].pSourceBase - (int)(fileBuffRead+q) - 1;
					segset[seg_count].pSourceBase= (void*)-1;*/

#endif
		  }
		  r=0;
		  while(1){
			while(	++q && fileBuffRead[q] != '\n' && fileBuffRead[q] != ';'
					&& (fileBuffRead[q] < '1' || fileBuffRead[q] > '9')
					&& (tst= isBlobTypesDouble(	(*(long*)(fileBuffRead+q)) << 8,
													BlobTypesDoubleCount)) == -1);

			if(fileBuffRead[q] != '\n' && fileBuffRead[q] != ';'){
				if(r == 0)
					segset[seg_count].set= fileBuffRead+q;
				if(segset[seg_count].isDocsList
					|| (	segset[seg_count].isExtBlob
								&& *(fileBuffRead+q-1) == '<'
									&& (segset[seg_count].isDocsList= -1)
										&& (rb= r))){
					if(*(fileBuffRead+q-1) == '<' || segset[seg_count].count_blob_docs){
						if(segset[seg_count].isDocsList < 1)
							*((unsigned short*)(segset[seg_count].set+r-nextW))= RetN;
						segset[seg_count].count_blob_docs++;
					}
					if(tst != -1){
						*(long*)(segset[seg_count].set+r)= BlobTypesDouble[tst];
					}else if((*(long*)(segset[seg_count].set+r)= (long)atoi(fileBuffRead+q)) == 0){
						free_my_global();
						return -4;
					}
					nextW= 4;
					if(*(long*)(segset[seg_count].set+r) > 9999999){
						q+=7;
					}else if(*(long*)(segset[seg_count].set+r) > 999999){
						q+=6;
					}else if(*(long*)(segset[seg_count].set+r) > 99999){
						q+=5;
					}else if(*(long*)(segset[seg_count].set+r) > 9999){
						q+=4;
					}else if(*(long*)(segset[seg_count].set+r) > 999){
						q+=3;
					}else if(*(long*)(segset[seg_count].set+r) > 99){
						q+=2;
					}else if(segset[seg_count].set[r] > 9){
						q++;
					}
				}else{
					nextW= 2;
					if(r != 0)
						*((unsigned short*)(segset[seg_count].set+r-nextW))= RetN;
					if((RetN= (unsigned short)(atoi(fileBuffRead+q)&0xFFFF)) == 0){
						free_my_global();
						return -4;
					}
					if(RetN > 9999){
						q+=4;
					}else if(RetN > 999){
						q+=3;
					}else if(RetN > 99){
						q+=2;
					}else if(RetN > 9){
						q++;
					}
					if(segset[seg_count].iMulti == 1l && *(fileBuffRead+q+1) == 'S'){
	((unsigned short*)segset[seg_count].sub_seg_set)[0]++;
	*((unsigned short*)segset[seg_count].sub_seg_set+(int)(((unsigned short*)segset[seg_count].sub_seg_set)[0]))
		= RetN;
					}else if(segset[seg_count].iMulti == 1l && *(fileBuffRead+q+1) == 'T'){
	((unsigned short*)segset[seg_count].sub_seg_set)[0xffff]++;
	*((unsigned short*)segset[seg_count].sub_seg_set+(int)0xffff+(int)(((unsigned short*)segset[seg_count].sub_seg_set)[0xffff]))
		= /**((unsigned short*)(segset[seg_count].set+r))*/RetN;
					}
				}
				r += nextW;
			}else{
				if(	segset[seg_count].count_blob_docs != 0)
				{
					if(rb){
						nextW= 2;
						segset[seg_count].count= rb/nextW;
						segset[seg_count].isDocsList= 0;
						r= rb;
						rb= 0;
					}else
						segset[seg_count].count= r/nextW - segset[seg_count].count_blob_docs;

					segset[seg_count].set_blob_docs
						= segset[seg_count].set + segset[seg_count].count*nextW;
				}else{
					if (!samedocs_count) {
						*((unsigned short*)(segset[seg_count].set+rr+r-nextW))= RetN;
						segset[seg_count].count= (r+rr)/nextW;
					}
				}
				if (!samedocs_count) {
					if(	segset[seg_count].sub_seg_set != 0 && !rr &&
						(((u_int32_t)(((unsigned short*)segset[seg_count].sub_seg_set)[0])
							+ (u_int32_t)(((unsigned short*)segset[seg_count].sub_seg_set)[0xffff]))
																	== segset[seg_count].count
							|| (((unsigned short*)segset[seg_count].sub_seg_set)[0] == 0
										&&
									((unsigned short*)segset[seg_count].sub_seg_set)[0xffff] != 0))){
						free_my_global();
						return -3;
					}
				}
				if (!samedocs_count) {
					if(	segset[seg_count].sub_seg_set!=0){
						if(!segset[seg_count].isDocsList		&&
							((unsigned short*)segset[seg_count].sub_seg_set)[0] == 0)
						{
							if(segset[seg_count].iMulti){
								((unsigned short*)segset[seg_count].sub_seg_set)[0]= 1;
								((unsigned short*)segset[seg_count].sub_seg_set)[1]= full_text_segment;
								segset[seg_count].put_first_disk= 2;
							}else{
								free(segset[seg_count].sub_seg_set);
								segset[seg_count].sub_seg_set= 0;
							}
						}else if(((unsigned short*)segset[seg_count].sub_seg_set)[0xffff]){
							memcpy(segset[seg_count].sub_seg_set
									+ ((int)(((unsigned short*)segset[seg_count].sub_seg_set)[0]) * 2) + 2,
										segset[seg_count].sub_seg_set + 0xffff*2 + 2,
											((unsigned short*)segset[seg_count].sub_seg_set)[0xffff] * 2);
							((unsigned short*)segset[seg_count].sub_seg_set)[0] +=
								((unsigned short*)segset[seg_count].sub_seg_set)[0xffff];
						}
					}
				}
				if(fileBuffRead[q] == ';')
					while(++q < i && fileBuffRead[q] != '\n');
				break;
			}
		  }
		  seg_count++;
		  if(seg_count == alloc_count){
			alloc_count += ALLOC_STEP_FOR_STREAM;
			if(	(pre_segset = (set_st *)calloc(alloc_count,sizeof(set_st)))
						== 0){
				q= i;
				break;
			}
			if((pre_segname = (char **)calloc(alloc_count,sizeof(char*))) == 0){
				free(pre_segset);
				q= i;
				break;
			}
			memcpy(pre_segset, segset, seg_count*sizeof(set_st));
			memcpy(pre_segname, segname, seg_count*sizeof(char*));
			free(segset);
			free(segname);
			segset= pre_segset;
			pre_segset= 0;
			segname= pre_segname;
			pre_segname= 0;
		  }
		}else
			while(++q < i && fileBuffRead[q] != '\n');
	}while(++q < i);

	cset = segset;
	for(i=0; i<seg_count; i++) {
		segset[i].dtype = DT_INT16;
		if (!samedocs_count) {
			if(segset[i].isDocsList){
				segset[i].reclen = 4;
				segset[i].rcmp = get_cmpfunc(DT_INT32);
			}else{
				segset[i].reclen = 2;
				segset[i].rcmp = get_cmpfunc(DT_INT16);
			}
			if(	segset[i].count_blob_docs != 0)
				qsort(segset[i].set_blob_docs, segset[i].count_blob_docs,
						4, get_cmpfunc(DT_INT32));
			qsort(segset[i].set, segset[i].count, segset[i].reclen, segset[i].rcmp);
			if(segset[i].sub_seg_set && ((unsigned short*)segset[i].sub_seg_set)[0] > 1){
				qsort(segset[i].sub_seg_set+2, ((unsigned short*)segset[i].sub_seg_set)[0],
						segset[i].reclen, segset[i].rcmp);
				if(((unsigned short*)segset[i].sub_seg_set)[0xffff] > 1)
					qsort((unsigned short*)segset[i].sub_seg_set+0xffff+1, ((unsigned short*)segset[i].sub_seg_set)[0xffff],
							segset[i].reclen, segset[i].rcmp);
			}
		}
	}
	return seg_count;
}




