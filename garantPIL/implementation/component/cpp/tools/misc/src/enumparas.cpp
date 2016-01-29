#include "shared/Core/fix/mpcxc.h"

#include <cstdio>
#include <cstdlib>
#include <sys/types.h>
#include <algorithm>

#define	MULTITHREAD

#include "osdep.h"
#include "stdbase.h"
#include "garver.h"
#include "gardefs.h"
#include "basemask.h"
#include <ctime>

#include <set>
#include <stack>

#include "advlog.h"

Base *base, *oldbase;

std::map<long, long> map_edition_doc;
std::set<long> docs;
std::map<long, std::set<long> > map_doc_editions;
std::map<long, long> map_doc_paraid;

std::set<long> docs_for_smart; //документы, для которых надо будет пустить smartenumnextdoc
std::set<long>::iterator docs_for_smart_it;

Core::Mutex smart_mutex;

#define	MAX_THREADS	12

struct thread_data_struct {
	int done, run;
};

thread_data_struct thread_data [MAX_THREADS];
int thread_ids [MAX_THREADS];

void	LoadEdis ()
{
	Stream *str = base->FindIndex ("Aux")->Open ("Edis");
	if (!str) {
		if (!base->FindIndex ("Aux")->Open ("InfL")) {
			mpcxc_printfwin ( "run gl first!\n");
			exit (EXIT_FAILURE);
		}
	} else {
		long size = str->Length (), *data = (long*) malloc (size), *ptr = data;
		str->Read (data, size);
		base->FindIndex ("Aux")->Close (str);
		size >>= 3;
		for (int i = 0; i < size; i++) {
			long edition = *ptr;
			ptr++;
			long doc = *ptr;
			docs.insert (doc);
			ptr++;

			map_edition_doc.insert (std::map<long,long>::value_type (edition, doc));
			if (map_edition_doc.find (doc) == map_edition_doc.end ())
				map_edition_doc.insert (std::map<long,long>::value_type (doc, doc));

			std::map<long, std::set<long> >::iterator it = map_doc_editions.find (doc);
			if (it == map_doc_editions.end ()) {
				std::set<long> editions;
				editions.insert (edition);
				editions.insert (doc);
				map_doc_editions.insert (std::map<long, std::set<long> >::value_type (doc, editions));
			} else {
				it->second.insert (edition);
			}
		}
		free (data);
	}
}

void	set_paraid_for (long doc_id, long paraid) {
	if (map_edition_doc.find (doc_id) == map_edition_doc.end ()) {
		std::map<long,long>::iterator id_it = map_doc_paraid.find (doc_id);
		if (id_it == map_doc_paraid.end ())
			map_doc_paraid.insert (std::map<long,long>::value_type (doc_id, paraid));
		else
			id_it->second = paraid;
	} else {
		long doc = map_edition_doc.find (doc_id)->second;
		std::map<long, std::set<long> >::iterator map_it = map_doc_editions.find (doc);
		for (std::set<long>::iterator it = map_it->second.begin (); it != map_it->second.end (); it++) {
			long doc_id = *it;
			std::map<long,long>::iterator id_it = map_doc_paraid.find (doc_id);
			if (id_it == map_doc_paraid.end ())
				map_doc_paraid.insert (std::map<long,long>::value_type (doc_id, paraid));
			else
				id_it->second = paraid;
		}
	}
}

long	get_paraid_for (long doc_id)
{
	return map_doc_paraid.find (doc_id)->second;
}

int	lcs_length( unsigned char* A, unsigned char* B )
{
	int m = strlen( (char*)A );
	int n = strlen( (char*)B );
	int size = std::max( m, n ) + 1; // GARANT_STL

	int* X = new int[ size ];
	int* Y = new int[ size ];

	for ( int i = m; i >= 0; i-- ) {
		for ( int j = n; j >= 0; j-- ) {
			if ( A[ i ] == '\0' || B[ j ] == '\0' )
				X[ j ] = 0;
			else
			if( A[ i+1 ] == B[ j+1 ] )
				X[ j ] = 1 + Y[ j+1 ];
			else
				X[ j ] = std::max( Y[ j ], X[ j+1 ] );
		}
		memcpy( Y, X, size * sizeof(int) );
	}
	int areturn = X[ 0 ];
	delete [] X;
	delete [] Y;
	return areturn;

	/*
	int* L = new int[ m, n ];
	for ( int i = m; i >= 0; i--)
	    for ( int j = n; j >= 0; j--) {
			if (A[i] == '\0' || B[j] == '\0') L[i,j] = 0;
			else if (A[i+1] == B[j+1]) L[i,j] = 1 + L[i+1, j+1];
			else L[i,j] = intmax( L[i+1, j], L[i, j+1] );
		}
	return L[0,0];
	*/

}

#define MYCHAR_BIT 8
#define UINT_BIT (sizeof (unsigned) * MYCHAR_BIT)
#define ROL(v, n) ((v) << (n) | (v) >> (UINT_BIT - (n)))
#define HASH(h, c) ((c) + ROL (h, 7))

#define	HOLE	50
#define	BREAK	30

void	EnumNextDoc (long docId, long prevId, long* paraIds, Base* whereprev, Base* whereprev2, bool prev_edition = false)
{
	if (!docId) {
		delete [] paraIds;
		return;
	}

	Document* doc  = base->GetDoc (docId);
	if (!doc || !doc->IsOk ()) {
		delete [] paraIds;
		return;
	}
	bool b_isedition = doc->Stat.Status & DS_EDITION;

	long para_id = get_paraid_for (docId);

	//mpcxc_printfwin ("Processing topics %ld and %ld\r", docId, prevId);

	int	paraCount0 = doc->Stat.ParaCount;
	long* newParaIds = new long [paraCount0];
	unsigned char**	lines0 = new unsigned char* [paraCount0];
	int*	lines0len = new int [paraCount0];
	unsigned int*	hash0 = new unsigned int [paraCount0];

	int*	lenstr = lines0len;
	unsigned int*	hash = hash0;
	int I, pics_count = 0;
	for ( I = 0; I < paraCount0; I++, lenstr++, hash++ ) {
		newParaIds [I] = 0;

		char* aPara = doc->GetPara (I);
		bool is_comment = false;
		int aSize;
		if (doc->Stat.Status & DS_EVD) {
			is_comment = doc->EVDFlags (aPara) & (ENDT_COMMENTS | ENDT_VERSION_COMMENTS);
			aSize = doc->EVDTextSize (aPara);
			aPara = doc->EVDParaText (aPara);
		} else {
			aSize = TextSize (aPara);
			aPara = ParaText (aPara);
			char cParaStyle = ParaStyle (aPara);
			is_comment = ParaIsComment (aPara, cParaStyle, aSize);
		}

		lines0 [I] = new unsigned char [aSize + 10];
		unsigned char *to = lines0 [I], *savedto = to, *from = (unsigned char*) aPara;
		unsigned int h = 0;
		if ( aSize ) {
			newParaIds[ I ] = /*++para_id |*/ ( is_comment ? 0x40000000 : 0 );
			char	attr = 0;
			while (aSize--) {
				if ( *from > 31 ) {
					h = HASH( h, *to++ = *from++ );
				} else if (*from == 9) {
					h = HASH( h, *to++ = ' '), from++;
				} else if (*from == 19) {
					h = HASH (h, *to++ = '*'), from++;
					while (*from != 19) {
						if (*from == 4) {
							attr ^= *from++;
							if ( !attr ) {
								short count = *(short*)( ++from );
								if ( !count ) count = 1;
								int skip = 2 + count * sizeof( Ref );
								from += skip;
								--aSize -= skip;
								if (aSize < 0) {
									printf ("fatal error in document %ld, para %ld\n", docId, I);
									exit (EXIT_SUCCESS);
								}
							}
						} else {
							from++, aSize--;
						}
					}
					from++, aSize--;
				} else if ( *from == 4 ) {
					attr ^= *from++;
					if ( !attr ) {
						short count = *(short*)( ++from );
						if ( !count ) count = 1;
						int skip = 2 + count * sizeof( Ref );
						from += skip;
						--aSize -= skip;
					}
				} else {
					from++;
				}
			}

			if ( h == 0 )
				h = 0xBADF00D + I;

			if ( to == savedto ) {
				h = 0xDEADDEAD + I;
				*to++ = '?'; 
			}
		}

		*to = 0;
		char *tofind = "‘¬. Ја дЁзҐбЄЁ© ®ЎкҐЄв ";
		char *tofind2 = "‘¬. Ја дЁзҐбЄ®Ґ Ё§®Ўа ¦Ґ­ЁҐ ";
		if (!strcmp ((char*)savedto, tofind) || !strcmp ((char*)savedto, tofind2)) {
			to = savedto;
			*to++ = '?'; 
			h = 0xDEADF00D + pics_count;
			pics_count++;
		} else {
			char *_to_ = strstr ((char*)savedto, tofind);
			int len;
			if (_to_)
				len = strlen (tofind);
			else {
				_to_ = strstr ((char*)savedto, tofind2);
				len = strlen (tofind2);
			}
			if (_to_) {
				//strcpy (_to_, _to_ + len);
				memcpy (_to_, _to_ + len, strlen (_to_ + len) + 1);
				to -= len;
				bool b_onlyspaces = true;
				unsigned char* q;
				for (q = savedto; q < to && b_onlyspaces; q++)
					if (*q && *q != ' ')
						b_onlyspaces = false;
				if (b_onlyspaces) {
					to = savedto;
					*to++ = '?'; 
					h = 0xDEADF00D + pics_count;
					pics_count++;
				} else {
					h = 0;
					for (q = savedto; q < to; q++)
						h = HASH (h, *q);
				}
			}
		}

		*to = 0;
		*lenstr = to - savedto;
		*hash = h;

	#ifdef	_DEBUG
		Recoding (cd_dos, cd_win, (char*)savedto);
	#endif
	}
	delete doc;

	if ( !whereprev ) whereprev = base;
	doc = whereprev->GetDoc( prevId );
	int paraCount1 = doc->Stat.ParaCount;
	unsigned char**	lines1 = new unsigned char*[ paraCount1 ];
	int*	lines1len = new int[ paraCount1 ];
	unsigned int*	hash1 = new unsigned int[ paraCount1 ];

	lenstr = lines1len;
	hash = hash1;
	for ( I = 0, pics_count = 0; I < paraCount1; I++, lenstr++, hash++ ) {
		unsigned int h = 0;
		char* aPara = doc->GetPara( I );
		int aSize;
		unsigned char* from;

		if (doc->Stat.Status & DS_EVD) {
			from = (unsigned char*) doc->EVDParaText (aPara);
			aSize= doc->EVDTextSize (aPara);
		} else {
			aSize = TextSize( aPara );
			from = (unsigned char*) ParaText( aPara );
		}

		lines1 [I] = new unsigned char [aSize + 10];
		unsigned char *to = lines1 [I], *savedto = to;

		char	attr = 0;
		if ( aSize ) {
			while ( aSize-- ) {
				if ( *from > 31 ) {
					h = HASH( h, *to++ = *from++ );
				} else if (*from == 9) {
					h = HASH( h, *to++ = ' '), from++;
				} else if (*from == 19) {
					h = HASH (h, *to++ = '*'), from++;
					while (*from != 19) from++, aSize--;
					from++, aSize--;
				} else if ( *from == 4 ) {
					attr ^= *from++;
					if ( !attr ) {
						short count = *(short*)( ++from );
						if ( !count ) count = 1;
						int skip = 2 + count * sizeof( Ref );
						from += skip;
						--aSize -= skip;
					}
				} else {
					from++;
				}
			}
			if ( h == 0 )
				h = 0xBADF00D + I;
			if ( to == savedto ) {
				h = 0xDEADDEAD + I;
				*to++ = '?'; 
			}
		} else {
			if (doc->EVDFlags (aPara) & ENDT_HAS_BMP) {
				*to++ = '?';
				h = 0xDEADF00D + pics_count;
				pics_count++;
			} else if (paraCount0 == paraCount1 && lines0len[I] == 1 && lines0[I][0] == '?') {
				*to++ = '?';
				h = 0xDEADDEAD + I;
			}
		}
		*to = 0;
		*lenstr = to - savedto;
		*hash = h;
	#ifdef	_DEBUG
		Recoding (cd_dos, cd_win, (char*)savedto);
	#endif
	}
	delete doc;

	int lastGood = 0;
	for ( I = 0; I < paraCount0; I++ ) if ( lines0len[ I ] ) {
		bool found = false;

		for ( int J = lastGood; J < paraCount1; J++ )
			if ( hash0[ I ] == hash1[ J ] ) {
				newParaIds[ I ] = (paraIds[ J ] > 0 ? paraIds[ J ] : ++para_id);
				hash0[ I ] = hash1[ J ] = 0;				
				lastGood = J+1;
				found = true;
				break;
			}

		if ( !found )
			for ( int J = lastGood - 1; J >= 0; J-- )
				if ( hash0[ I ] == hash1[ J ] ) {
					newParaIds[ I ] = ( paraIds[ J ] > 0 ? paraIds [J] : ++para_id);
					hash0[ I ] = hash1[ J ] = 0;
					lastGood = J+1;
					found = true;
					break;
				}
	}

	int start = time(0);

	int *tocheck = new int[ paraCount1 ], *ptr = tocheck, tochecks = 0;
	for ( I = 0; I < paraCount1; I++ ) {
		if ( hash1[ I ] ) {
			*ptr++ = I;
			tochecks++;
		}
	}

	if (docId == prevId && b_isedition && map_edition_doc.find (docId) != map_edition_doc.end ()) {
		if (tochecks)
			docs_for_smart.insert (map_edition_doc.find (docId)->second);
		else {
			bool difs = false;
			long size1, size2;
			void* data1 = base->LoadAttr (docId, IDD_CONTENTS, size1);
			void* data2 = whereprev->LoadAttr (docId, IDD_CONTENTS, size2);
			if (size1 != size2 || memcmp (data1, data2, size1)) {
				difs = true;
			}
			if (data1) gk_free (data1);
			if (data2) gk_free (data2);

			if (!difs) {
				data1 = base->LoadAttr (docId, IDD_SUBS, size1);
				data2 = whereprev->LoadAttr (docId, IDD_SUBS, size2);
				if (size1 != size2 || memcmp (data1, data2, size1)) {
					difs = true;
				}
				if (data1) gk_free (data1);
				if (data2) gk_free (data2);
			}

			if (difs) {
				docs_for_smart.insert (map_edition_doc.find (docId)->second);
			}
		}
	}

	lastGood = 0;
	bool	skipped = false;
	for ( I = 0; I < paraCount0; I++ ) if ( hash0[ I ] ) {
		bool found = false;
		int	checked = 0;
		for ( int J = lastGood; J < tochecks && ( ( lastGood && checked <= HOLE ) || !lastGood ); ) {
			int real = tocheck[ J ];
			if ( std::max( lines0len[ I ], lines1len[ real ] ) - std::min( lines0len[ I ], lines1len[ real ] ) < 2 ) {
				checked++;
				if ( lcs_length( lines0[ I ], lines1[ real ] ) * 100 / lines0len[ I ] > 95 ) {
					newParaIds[ I ] = (paraIds[ real ] > 0 ? paraIds[ real ] : ++para_id);
					hash0[ I ] = 0;
					lastGood = J;
					found = true;
					memmove( &tocheck[ J ], &tocheck[ J + 1 ], ( tochecks - J - 1 ) * sizeof( int ));
					tochecks--;
					break;
				} else
					J++;
			}
			else
				J++;
		}

		if ( !found ) {
			checked = 0;
			for ( int J = lastGood - 1; J >= 0 && ( ( lastGood && checked <= HOLE ) || !lastGood ); ) {
				int real = tocheck[ J ];
				if ( std::max( lines0len[ I ], lines1len[ real ] ) - std::min( lines0len[ I ], lines1len[ real ] ) < 2 ) {
					checked++;
					if ( lcs_length( lines0[ I ], lines1[ real ] ) * 100 / lines0len[ I ] > 95 ) {
						newParaIds[ I ] = (paraIds[ real ] > 0 ? paraIds[ real ] : ++para_id);
						hash0[ I ] = 0;
						lastGood = J;
						found = true;
						memmove( &tocheck[ J ], &tocheck[ J + 1 ], ( tochecks - J - 1 ) * sizeof( int ));
						tochecks--;
						break;
					} else
						J--;
				}
				else
					J--;
			}
		}

		if ( !found )
			lastGood = 0;

		if ( time( 0 ) - start > BREAK ) {
			skipped = true;
			printf ("time out for doc %ld, para_id is %ld\n", docId, para_id);
			break;
		}
	}

	//у оставшихся новых параграфов надо перенумеровать параграфы
	//у неименившихся параграфов номер из прошлого документа, а у необработанных - левые.
	for (I = 0; I < paraCount0; I++)
		if (hash0 [I])
			newParaIds [I] = ++para_id + (newParaIds [I] & 0x40000000);
	delete [] tocheck;

	for (I = 0; I < paraCount0; I++)
		para_id = std::max <long> (newParaIds [I] & 0x3FFFFFFF, para_id);

	for ( I = 0; I < paraCount0; I++ )
		delete lines0[ I ];
	delete [] lines0;
	for ( I = 0; I < paraCount1; I++ )
		delete lines1[ I ];
	delete [] lines1;

	delete [] lines0len;
	delete [] lines1len;
	delete [] hash0;
	delete [] hash1;

	delete [] paraIds;

	base->ReplaceAttrEx (docId, IDD2_PARAIDS, newParaIds, sizeof (para_id) * paraCount0);
	set_paraid_for (docId, para_id);

	DocInfo docinfo;
	base->FindDocInfo (docId, docinfo);
	if (whereprev2)
		EnumNextDoc (prev_edition ? docinfo.prevEdition : docinfo.nextEdition, docId, newParaIds, whereprev2, whereprev2, prev_edition);
	else {
		delete [] newParaIds;
		return;
	}
}

std::vector<long> blocks_to_proceed [2];
std::map<long,long> block_beginpara [2], block_endpara [2];

void	process_block (long block, long levels, std::map<long,std::vector<long> > &block_children, std::map<long,long> &block_levels, std::set<long> &visible_blocks)
{
	visible_blocks.insert (block);

	std::map<long,std::vector<long> >::const_iterator map_it = block_children.find (block);
	if (map_it == block_children.end ())
		return ;
	for (std::vector<long>::const_iterator it = map_it->second.begin (); it != map_it->second.end (); it++) {
		block = *it;
		std::map<long,long>::const_iterator level_it = block_levels.find (block);
		if (level_it == block_levels.end ()) {
			if (levels)
				process_block (block, levels - 1, block_children, block_levels, visible_blocks);
		} else {
			if (level_it->second)
				process_block (block, level_it->second, block_children, block_levels, visible_blocks);
		}
	}
}

void	smart_getblocks (long doc_id, long offset)
{
	blocks_to_proceed [offset].clear ();
	block_beginpara [offset].clear ();
	block_endpara [offset].clear ();

	long structs_count;
	DocStruct *org_structs = (DocStruct*) base->LoadAttr (doc_id, IDD_DOCSTRUCT, structs_count), *structs = org_structs;
	structs_count /= sizeof (DocStruct);

	std::map<long,long> position_parentblock;
	long i, block = 0, level = 0;
	for (i = 0; i < structs_count; i++)
		position_parentblock.insert (std::map<long,long>::value_type (i, 0)); //у всех родителем является блок 0
	std::stack<long> blocks;
	std::map<long,long> block_parentblock;
	std::map<long,long> block_level; //какой уровень вложенности у этого блока
	std::map<long,std::set<long> > level_blocks;
	blocks.push (block/*0*/);
	for (i = 0; i < structs_count; i++, structs++) {
		short evd_type = (short) ((structs->m_para_list_type >> 24) & 0xFF);
		if (evd_type == SUBDESCEX_BLOCK) {
			long new_block = structs->m_para_list_id;
			level = (structs->m_id >> 24) & 0xFF;

			for (long j = structs->m_first_child; j <= structs->m_last_child; j++)
				position_parentblock.find (j)->second = new_block; //выставляем, у каких записей парентом является этот блок

			block_level.insert (std::map<long,long>::value_type (new_block, level));
			block_beginpara [offset].insert (std::map<long,long>::value_type (new_block, structs->m_start_para));
			block_endpara   [offset].insert (std::map<long,long>::value_type (new_block, structs->m_end_para+1));
			block_parentblock.insert (std::map<long,long>::value_type (new_block, position_parentblock.find (i)->second));

			std::map<long,std::set<long> >::iterator it = level_blocks.find (level);
			if (it == level_blocks.end ()) {
				std::set<long> new_blocks;
				new_blocks.insert (new_block);
				level_blocks.insert (std::map<long, std::set<long> >::value_type (level, new_blocks));
			} else {
				it->second.insert (new_block);
			}
		}
	}
	gk_free (org_structs);

	//итого, есть мапа (для каждого блока), какой блок является его парентом
	//теперь надо сделать мапу "наоборот" - какие дети у блока (один уровень?)
	std::map<long,std::vector<long> > block_children;
	for (std::map<long,long>::const_iterator it = block_parentblock.begin (); it != block_parentblock.end (); it++) {
		long parent = it->second, child = it->first;
		std::map<long,std::vector<long> >::iterator i = block_children.find (parent);
		if (i == block_children.end ()) {
			std::vector<long> children;
			children.push_back (child);
			block_children.insert (std::map<long,std::vector<long> >::value_type (parent, children));
		} else {
			i->second.push_back (child);
		}
	}

	std::map<long,long> block_levels;
	long contents_count, levels0 = 0;
	ContentsStruct *contents = (ContentsStruct*) base->LoadAttr (doc_id, IDD_CONTENTS, contents_count), *cont_ptr = contents;
	contents_count /= sizeof (ContentsStruct);
	for (i = 0; i < contents_count; i++, cont_ptr++) {
		long block = cont_ptr->Sub;
		if (block == 0)
			levels0 = cont_ptr->Size;
		if (block_children.find (block) != block_children.end ())
			block_levels.insert (std::map<long,long>::value_type (block, cont_ptr->Size));
	}
	free (contents);

	//надо составить список блоков, уровень которых попадает в оглавление
	//std::map<long,std::set<long> > level_blocks;
	std::map<long,std::set<long> >::const_iterator map_level_blocks_it = level_blocks.find (1);
	std::set<long> visible_blocks;
	if (map_level_blocks_it != level_blocks.end ()) {
		for (std::set<long>::const_iterator it = map_level_blocks_it->second.begin (); it != map_level_blocks_it->second.end (); it++) {
			long block = *it, levels = levels0;
			std::map<long,long>::const_iterator cont_it = block_levels.find (block);
			if (cont_it != block_levels.end ())
				levels = cont_it->second;

			if (levels)
				process_block (block, levels, block_children, block_levels, visible_blocks);
		}
	}

	for (std::map<long,std::set<long> >::reverse_iterator map_it = level_blocks.rbegin (); map_it != level_blocks.rend (); map_it++) {
		for (std::set<long>::const_iterator block_it = map_it->second.begin (); block_it != map_it->second.end (); block_it++) {
			long block = *block_it;
			if (visible_blocks.find (block) != visible_blocks.end ()) {
				blocks_to_proceed [offset].push_back (block);
			}
		}
	}
}

typedef	struct	{
	long docId;
	long prevId;
	long *paraIds;
	std::set<long> *processed_ids;
	bool prev_edition;		
} smartenumnextdoc_params;

void	SmartEnumNextDoc (/*long docId, long prevId, long* paraIds, std::set<long> &processed_ids, bool prev_edition*/smartenumnextdoc_params &params)
{
	long docId = params.docId, prevId = params.prevId, *paraIds = params.paraIds;
	bool prev_edition = params.prev_edition;
	std::set<long> *processed_ids = params.processed_ids;

	//prevId - это как раз документ, уже обсчитанный
	//docId - для которого надо считать (newParaIds)
	if (!docId) {
		delete [] paraIds;
		return;
	}

	if (processed_ids->find (docId) != processed_ids->end ()) {
		//printf ("skip (already processed) %ld\n", docId);
		delete [] paraIds;
		return ;
	}

	std::vector<long> this_blocks_to_proceed [2];
	std::map<long,long> this_block_beginpara [2], this_block_endpara [2];

	int paraCount0, paraCount1, *lines0len, *lines1len;
	unsigned int *hash0, *hash1, *hash;
	long* newParaIds, para_id;
	unsigned char **lines0, **lines1;
	{
#ifdef	MULTITHREAD
		GUARD (smart_mutex);
#endif
		Document *doc = base->GetDoc (docId);
		if (!doc || !doc->IsOk ()) {
			delete [] paraIds;
			return;
		}
		para_id = get_paraid_for (docId);

		//printf ("SmartProcessing topics %ld and %ld\r", docId, prevId); fflush (stdout);

		paraCount0 = doc->Stat.ParaCount;
		newParaIds = new long[ paraCount0 ];
		lines0 = new unsigned char*[ paraCount0 ];
		lines0len = new int[ paraCount0 ];
		hash0 = new unsigned int[ paraCount0 ];

		int* lenstr = lines0len;
		hash = hash0;
		int I;
		for (I = 0; I < paraCount0; I++, lenstr++, hash++ ) {
			newParaIds [I] = 0;

			char* aPara = doc->GetPara( I );
			bool is_comment = false;
			int aSize;
			if (doc->Stat.Status & DS_EVD) {
				is_comment = doc->EVDFlags (aPara) & (ENDT_COMMENTS | ENDT_VERSION_COMMENTS);
				aSize = doc->EVDTextSize (aPara);
				aPara = doc->EVDParaText (aPara);
			} else {
				aSize = TextSize (aPara);
				aPara = ParaText (aPara);
				char cParaStyle = ParaStyle (aPara);
				is_comment = ParaIsComment (aPara, cParaStyle, aSize);
			}

			unsigned char* to = ( lines0[ I ] = new unsigned char[ aSize + 1 ] );
			unsigned char* savedto = to;
			unsigned char* from = (unsigned char*) aPara;
			unsigned int h = 0;
			if ( aSize ) {
				newParaIds[ I ] = ++para_id | ( is_comment ? 0x40000000 : 0 );
				char	attr = 0;
				while ( aSize-- ) {
					if ( *from > 31 ) {
						h = HASH( h, *to++ = *from++ );
					} else if (*from == 9) {
						h = HASH( h, *to++ = ' '), from++;
					} else if ( *from == 4 ) {
						attr ^= *from++;
						if ( !attr ) {
							short count = *(short*)( ++from );
							if ( !count ) count = 1;
							int skip = 2 + count * sizeof( Ref );
							from += skip;
							--aSize -= skip;
						}
					} else {
						from++;
					}
				}

				if ( h == 0 )
					h = 0xBADF00D + I;

				if ( to == savedto ) {
					h = 0xDEADDEAD + I;
					*to++ = '?'; 
				}
			}

			*to = 0;
			*lenstr = to - savedto;
	#ifdef	_DEBUG
			//Recoding (cd_dos, cd_win, (char*)savedto);
	#endif
			*hash = h;
		}
		delete doc;

		doc = base->GetDoc( prevId );
		paraCount1 = doc->Stat.ParaCount;
		lines1 = new unsigned char*[ paraCount1 ];
		lines1len = new int[ paraCount1 ];
		hash1 = new unsigned int[ paraCount1 ];

		lenstr = lines1len;
		hash = hash1;
		for ( I = 0; I < paraCount1; I++, lenstr++, hash++ ) {
			unsigned int h = 0;
			char* aPara = doc->GetPara( I );
			int aSize;
			unsigned char* from;

			if (doc->Stat.Status & DS_EVD) {
				from = (unsigned char*) doc->EVDParaText (aPara);
				aSize= doc->EVDTextSize (aPara);
			} else {
				aSize = TextSize( aPara );
				from = (unsigned char*) ParaText( aPara );
			}

			unsigned char* to = ( lines1[ I ] = new unsigned char[ aSize + 1 ] );
			unsigned char* savedto = to;

			char	attr = 0;
			if ( aSize ) {
				while ( aSize-- ) {
					if ( *from > 31 ) {
						h = HASH( h, *to++ = *from++ );
					} else if (*from == 9) {
						h = HASH( h, *to++ = ' '), from++;
					} else if ( *from == 4 ) {
						attr ^= *from++;
						if ( !attr ) {
							short count = *(short*)( ++from );
							if ( !count ) count = 1;
							int skip = 2 + count * sizeof( Ref );
							from += skip;
							--aSize -= skip;
						}
					} else {
						from++;
					}
				}
				if ( h == 0 )
					h = 0xBADF00D + I;
				if ( to == savedto ) {
					h = 0xDEADDEAD + I;
					*to++ = '?'; 
				}
			}
			*to = 0;
			*lenstr = to - savedto;
	#ifdef	_DEBUG
			//Recoding (cd_dos, cd_win, (char*)savedto);
	#endif
			*hash = h;
		}
		delete doc;

		smart_getblocks (docId, 0); //который надо нумеровать
		smart_getblocks (prevId,1); //который уже пронумерован

#ifdef	MULTITHREAD
		this_blocks_to_proceed [0] = blocks_to_proceed [0];
		this_blocks_to_proceed [1] = blocks_to_proceed [1];
		this_block_beginpara [0] = block_beginpara [0];
		this_block_beginpara [1] = block_beginpara [1];
		this_block_endpara [0] = block_endpara [0];
		this_block_endpara [1] = block_endpara [1];
#endif
	}

#ifdef	MULTITHREAD
	for (std::vector<long>::const_iterator it = this_blocks_to_proceed [1].begin (); it != this_blocks_to_proceed [1].end (); it++) {
		long block = *it;
		if (this_block_beginpara [0].find (block) == this_block_beginpara [0].end ()) {
			//в старой редакции нет такого блока, надо нумеровать параграфы по-своему
			/*
			long from_para_0 = std::min <long> (this_block_beginpara [0].find (block)->second, paraCount0);
			long to_para_0 = std::min <long> (this_block_endpara [0].find (block)->second, paraCount0); 
			for (int i = from_para_0; i < to_para_0; i++) if (lines0len [i]) {
				newParaIds [i] = ++para_id + (newParaIds [i] & 0x40000000);
				hash0 [i] = lines0len [i] = 0;
			}
			*/
		} else {
			//в старой редакции тоже есть такой блок
			long from_para_1 = std::min <long> (this_block_beginpara [1].find (block)->second, paraCount1); 
			long from_para_0 = std::min <long> (this_block_beginpara [0].find (block)->second, paraCount0);
			long to_para_1 = std::min <long> (this_block_endpara [1].find (block)->second, paraCount1); 
			long to_para_0 = std::min <long> (this_block_endpara [0].find (block)->second, paraCount0); 
#else
	for (std::vector<long>::const_iterator it = blocks_to_proceed [1].begin (); it != blocks_to_proceed [1].end (); it++) {
		long block = *it;
		if (block_beginpara [0].find (block) == block_beginpara [0].end ()) {
			//в старой редакции нет такого блока, надо нумеровать параграфы по-своему
			/*
			long from_para_0 = std::min <long> (block_beginpara [0].find (block)->second, paraCount0);
			long to_para_0 = std::min <long> (block_endpara [0].find (block)->second, paraCount0); 
			for (int i = from_para_0; i < to_para_0; i++) if (lines0len [i]) {
				newParaIds [i] = ++para_id + (newParaIds [i] & 0x40000000);
				hash0 [i] = lines0len [i] = 0;
			}
			*/
		} else {
			//в старой редакции тоже есть такой блок
			long from_para_1 = std::min <long> (block_beginpara [1].find (block)->second, paraCount1); 
			long from_para_0 = std::min <long> (block_beginpara [0].find (block)->second, paraCount0);
			long to_para_1 = std::min <long> (block_endpara [1].find (block)->second, paraCount1); 
			long to_para_0 = std::min <long> (block_endpara [0].find (block)->second, paraCount0); 
#endif

			//шаг1 найти абсолютно одинаковые
			for (int i = from_para_0; i < to_para_0; i++) if (lines0len [i]) {
				for (int j = from_para_1; j < to_para_1; j++) {
					if (hash0 [i] == hash1 [j]) {
						newParaIds [i] = paraIds [j];
						lines0len [i] = lines1len [j] = 0; //длины обнулили
						hash0 [i] = hash1 [j] = 0;
						break;
					}
				}
			}

			//шаг2 среди оставшихся (есть отличия) надо найти пары максимально похожих
			for (int i = from_para_0; i < to_para_0; i++) {
				long len0 = lines0len [i];
				if (len0) {
					//есть параграф, ненулевой длины; абсолютно равных по тексту нет.
					long best_para = -1, max_perc = 0; //степень похожести

					//будем рассматривать не более 30 параграфов "вверх-вниз"
					int j = from_para_1 + i - from_para_0;
					if (j >= to_para_1)
						j = from_para_1;
					long count = 0;
					for (; j > from_para_1 && count < 15; j--) {
						if (lines1len [j])
							count++;
					}
					count = 0;
					for (; j < to_para_1 && count < 30; j++) {
						long len1 = lines1len [j];
						if (len1) {
							count++;
							bool b_short_para = len0 < 140 && len1 < 140;
							long new_perc1 = (lcs_length (lines0 [i], lines1 [j]) * 100) / lines0len [i];
							long new_perc0 = (lcs_length (lines0 [i], lines1 [j]) * 100) / lines1len [j];
							if (new_perc1 > max_perc && ((new_perc1 > 75 && new_perc0 > 75 && b_short_para) || (new_perc0 > 50 && new_perc1 > 50 && !b_short_para))) {
								max_perc = new_perc1;
								best_para = j;
							}
						}
					}
					if (best_para != -1) {
						newParaIds [i] = paraIds [best_para];
						hash0 [i] = hash1 [best_para] = 0;
						lines0len [i] = lines1len [best_para] = 0; //длины обнулили
					} else {
						//параграф ни на какой не похож
						newParaIds [i] = ++para_id + (newParaIds [i] & 0x40000000);
						hash0 [i] = lines0len [i] = 0;
					}
				}
			}

			//шаг 3
			//надо исключить параграфы блока из дальнейших сравниваний
			for (int j = from_para_1; j < to_para_1; j++) {
				hash1 [j] = lines1len [j] = 0;
			}
		}
	}

	//осталось какое-то количество ненумерованных параграфов. По-старому?
	{
	int lastGood = 0, I;
	for ( I = 0; I < paraCount0; I++ ) if ( lines0len[ I ] ) {
		bool found = false;

		for ( int J = lastGood; J < paraCount1; J++ )
			if ( hash0[ I ] == hash1[ J ] ) {
				newParaIds[ I ] = paraIds[ J ];
				hash0[ I ] = hash1[ J ] = 0;				
				lastGood = J+1;
				found = true;
				break;
			}

		if ( !found )
			for ( int J = lastGood - 1; J >= 0; J-- )
				if ( hash0[ I ] == hash1[ J ] ) {
					newParaIds[ I ] = paraIds[ J ];
					hash0[ I ] = hash1[ J ] = 0;
					lastGood = J+1;
					found = true;
					break;
				}
	}

	int start = time(0);

	int* tocheck = new int[ paraCount1 ];
	int* ptr = tocheck; int tochecks = 0;
	for ( I = 0; I < paraCount1; I++ ) {
		if ( hash1[ I ] ) {
			*ptr++ = I;
			tochecks++;
		}
	}

	lastGood = 0;
	bool	skipped = false;
	for ( I = 0; I < paraCount0; I++ ) if ( hash0[ I ] ) {
		bool found = false;
		int	checked = 0;
		for ( int J = lastGood; J < tochecks && ( ( lastGood && checked <= HOLE ) || !lastGood ); ) {
			int real = tocheck[ J ];
			if ( std::max( lines0len[ I ], lines1len[ real ] ) - std::min( lines0len[ I ], lines1len[ real ] ) < (I + real < 20 ? 30 : 2)) {
				checked++;
				if ( lcs_length( lines0[ I ], lines1[ real ] ) * 100 / lines0len[ I ] > (I + real < 20 ? 75 : 95)) {
					newParaIds[ I ] = paraIds[ real ];
					hash0[ I ] = 0;
					lastGood = J;
					found = true;
					memmove( &tocheck[ J ], &tocheck[ J + 1 ], ( tochecks - J - 1 ) * sizeof( int ));
					tochecks--;
					break;
				} else
					J++;
			}
			else
				J++;
		}

		if ( !found ) {
			checked = 0;
			for ( int J = lastGood - 1; J >= 0 && ( ( lastGood && checked <= HOLE ) || !lastGood ); ) {
				int real = tocheck[ J ];
				if ( std::max( lines0len[ I ], lines1len[ real ] ) - std::min( lines0len[ I ], lines1len[ real ] ) < (I + real < 20 ? 30 : 2)) {
					checked++;
					if ( lcs_length( lines0[ I ], lines1[ real ] ) * 100 / lines0len[ I ] > (I + real < 20 ? 75 : 95)) {
						newParaIds[ I ] = paraIds[ real ];
						hash0[ I ] = 0;
						lastGood = J;
						found = true;
						memmove( &tocheck[ J ], &tocheck[ J + 1 ], ( tochecks - J - 1 ) * sizeof( int ));
						tochecks--;
						break;
					} else
						J--;
				}
				else
					J--;
			}
		}

		if ( !found )
			lastGood = 0;

		if ( time( 0 ) - start > BREAK ) {
			skipped = true;
			printf ("time out for doc %ld, para_id is %ld\n", docId, para_id);
			break;
		}
	}

	//у оставшихся новых параграфов надо перенумеровать параграфы
	//у неименившихся параграфов номер из прошлого документа, а у необработанных - левые.
	for (I = 0; I < paraCount0; I++)
		if (hash0 [I])
			newParaIds [I] = ++para_id + (newParaIds [I] & 0x40000000);
	delete [] tocheck;
	}

	int I;
	for ( I = 0; I < paraCount0; I++ )
		/*if ( lines0len[ I ] )*/ delete lines0[ I ];
	delete lines0;
	for ( I = 0; I < paraCount1; I++ )
		/*if ( lines1len[ I ] )*/ delete lines1[ I ];
	delete [] lines1;

	delete [] lines0len;
	delete [] lines1len;
	delete [] hash0;
	delete [] hash1;

	delete [] paraIds;

	DocInfo docinfo;
	{
#ifdef	MULTITHREAD
		GUARD (smart_mutex);
#endif
		base->ReplaceAttrEx (docId, IDD2_PARAIDS, newParaIds, sizeof (para_id) * paraCount0);
		set_paraid_for (docId, para_id);

		base->FindDocInfo (docId, docinfo);
	}
	processed_ids->insert (docId);
	params.docId = prev_edition ? docinfo.prevEdition : docinfo.nextEdition;
	params.prevId = docId;
	params.paraIds = newParaIds;
	SmartEnumNextDoc (/*prev_edition ? docinfo.prevEdition : docinfo.nextEdition, docId, newParaIds, processed_ids, prev_edition*/params);
}

void	thread_smartenumnextdoc (int* thread_id)
{
	int this_thread_id = *thread_id;
	thread_data_struct* thread_data_ptr = & (thread_data [this_thread_id]);
	thread_data_ptr->run = 0;

	DocInfo docinfo;

	while (true) {
		long doc = 0;
		{
		GUARD (smart_mutex);
		if (docs_for_smart_it != docs_for_smart.end ()) {
			doc = *docs_for_smart_it;
			docs_for_smart_it++;
			if (base->FindDocInfo (doc, docinfo) != sizeof (docinfo))
				continue;
		}
		}
		if (!doc)
			break;

		std::set<long> processed_ids;
		smartenumnextdoc_params params;
		params.processed_ids = &processed_ids;

		//надо docinfo.LastParaId прописать в мапу
		std::map<long,std::set<long> >::const_iterator map_it = map_doc_editions.find (doc);
		std::set<long>::const_iterator it;
		if (map_it != map_doc_editions.end ()) {
			GUARD (smart_mutex);
			for (it = map_it->second.begin (); it != map_it->second.end (); it++)
				map_doc_paraid.insert (std::map<long,long>::value_type (*it, docinfo.lastParaID));
		}

		if (docinfo.prevEdition) {
			params.prev_edition = true;
			long size, *para_ids;
			{
			GUARD (smart_mutex);
			para_ids = (long*) base->LoadAttrEx (doc, IDD2_PARAIDS, size);
			}
			params.docId = docinfo.prevEdition;
			params.prevId = doc;
			params.paraIds = para_ids;
			SmartEnumNextDoc (params/*docinfo.prevEdition, doc, para_ids, processed_ids, true*/);
		}
		if (docinfo.nextEdition) {
			params.prev_edition = false;
			long size, *para_ids;
			{
			GUARD (smart_mutex)
			para_ids = (long*) base->LoadAttrEx (doc, IDD2_PARAIDS, size);
			}
			params.docId = docinfo.nextEdition;
			params.prevId = doc;
			params.paraIds = para_ids;
			SmartEnumNextDoc (params/*docinfo.nextEdition, doc, para_ids, processed_ids, false*/);
		}

		if (map_it != map_doc_editions.end ()) {
			GUARD (smart_mutex);
			for (it = map_it->second.begin (); it != map_it->second.end (); it++) {
				long doc_id = *it;
				base->FindDocInfo (doc_id, docinfo);
				docinfo.lastParaID = get_paraid_for (doc_id);
				base->ReplaceAttr (doc_id, IDD_INFO, &docinfo, sizeof (docinfo));
			}
		}
	}

	thread_data_ptr->done = 1;
}

void	EnumDoc (long docId, bool enumNext)
{
	Document *aDoc = base->GetDoc (docId);
	if ( !aDoc )
		return;

	//mpcxc_printfwin ("Processing topic %ld                \r", docId );

	long	aParaID = get_paraid_for (docId);
	long*	aParaIDs = new long [aDoc->Stat.ParaCount];

	for (long J = 0; J < aDoc->Stat.ParaCount; J++) {
		aParaIDs [J] = 0;
		char* aPara = aDoc->GetPara( J );
		if  (!aPara)
			continue;

		bool is_comment = false;
		int	aTextSize;
		if (aDoc->Stat.Status & DS_EVD) {
			is_comment = aDoc->EVDFlags (aPara) & (ENDT_COMMENTS | ENDT_VERSION_COMMENTS);
			aTextSize = aDoc->EVDTextSize (aPara);
			aPara = aDoc->EVDParaText (aPara);
		} else {
			aTextSize = TextSize( aPara );
			aPara = ParaText( aPara );
			char cParaStyle = ParaStyle( aPara );
			is_comment = ParaIsComment( aPara, cParaStyle, aTextSize );
		}

		if (!aTextSize)
			continue;

		aParaIDs[ J ] = ++aParaID | ( is_comment ? 0x40000000 : 0 );
	}

	base->ReplaceAttrEx (docId, IDD2_PARAIDS, aParaIDs, sizeof (aParaID) * aDoc->Stat.ParaCount);

	set_paraid_for (docId, aParaID);
	DocInfo docinfo;
	base->FindDocInfo (docId, docinfo);
	delete aDoc;

	if (enumNext)
		EnumNextDoc (docinfo.nextEdition, docId, aParaIDs, base, base);
	else {
		delete aParaIDs;
	}
}

bool	OnlyOldDocs( DocInfo docInfo, long docId )
{
	std::set<long> processed;
	long prevEdition = docInfo.prevEdition;
	while ( prevEdition ) {
		if ( processed.find( prevEdition ) != processed.end())
			break;
		processed.insert( prevEdition );

		DocInfo prevdocInfo;
		if ( base->FindDocInfo( prevEdition, prevdocInfo ) == sizeof( DocInfo )) {
			if ( !oldbase->FindDoc( prevEdition ))
				return false;
			prevEdition = prevdocInfo.prevEdition;
		}
		else
			break;
	}
	long nextEdition = docInfo.nextEdition;
	while ( nextEdition ) {
		if ( processed.find( nextEdition ) != processed.end())
			break;
		processed.insert( nextEdition );

		DocInfo nextdocInfo;
		if ( base->FindDocInfo( nextEdition, nextdocInfo ) == sizeof( DocInfo )) {
			if ( !oldbase->FindDoc( nextEdition ))
				return false;
			nextEdition = nextdocInfo.nextEdition;
		}
		else
			break;
	}
	return true;
}

bool	OnlyNewDocs( DocInfo docInfo, long docId )
{
	std::set<long> processed;
	long prevEdition = docInfo.prevEdition;
	while ( prevEdition ) {
		if ( processed.find( prevEdition ) != processed.end())
			break;
		processed.insert( prevEdition );

		DocInfo prevdocInfo;
		if ( base->FindDocInfo( prevEdition, prevdocInfo ) == sizeof( DocInfo )) {
			if ( oldbase->FindDoc( prevEdition ))
				return false;
			prevEdition = prevdocInfo.prevEdition;
		}
		else
			break;
	}
	long nextEdition = docInfo.nextEdition;
	while ( nextEdition ) {
		if ( processed.find( nextEdition ) != processed.end())
			break;
		processed.insert( nextEdition );

		DocInfo nextdocInfo;
		if ( base->FindDocInfo( nextEdition, nextdocInfo ) == sizeof( DocInfo )) {
			if ( oldbase->FindDoc( nextEdition ))
				return false;
			nextEdition = nextdocInfo.nextEdition;
		}
		else
			break;
	}
	return true;
}

long	FindFirstEdition( DocInfo docInfo, long docId )
{
	if ( !docInfo.prevEdition )
		return docId;

	long goodId = docId, prevEdition = docInfo.prevEdition;
	std::set<long> processed;

	while (true) {
		if (prevEdition && processed.find (prevEdition) != processed.end ())
			return goodId;

		if ( !prevEdition || base->FindDocInfo( prevEdition, docInfo ) != sizeof( DocInfo ))
			return goodId;

		processed.insert (prevEdition);
		goodId = prevEdition;
		prevEdition = docInfo.prevEdition;
	}
}

int main_logic ( int argc, char *argv[] );

LONG WINAPI UEF(_EXCEPTION_POINTERS *ExceptionInfo)
{
	std::cout << "Unhandle exception" << std::endl;
	exit (EXIT_FAILURE);
}

int main ( int argc, char *argv[] ) {
	SetUnhandledExceptionFilter (UEF);
	//int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	//return res;
	return main_logic (argc, argv);
}

int main_logic ( int argc, char *argv[] )
{
	//mpcxc_printfwin("%ld\n", lcs_length( "nematode knowledge", "emptybottle" ));

	if ( argc < 2 ) {
		mpcxc_printfwin("Usage:\n" );
		mpcxc_printfwin("    enumparas base_name\n" );
		mpcxc_printfwin("  or\n" );
		mpcxc_printfwin("    enumparas old_base_name new_base_name\n" );

		return 1;
	}

	if (!strcmp (argv [1], "-setlastparaid")) {
		base = new StdBigBase (argv [2], ACE_OS_O_RDWR);
		long doc_id = atol (argv [3]);
		set_paraid_for (doc_id, atol (argv [4]));
		DocInfo docinfo;
		base->FindDocInfo (doc_id, docinfo);
		EnumDoc (doc_id, false);

		docinfo.lastParaID = get_paraid_for (doc_id);
		base->ReplaceAttr (doc_id, IDD_INFO, &docinfo, sizeof (docinfo));

		delete base;
		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [1], "-fixids")) {
		base = new StdBigBase (argv [2], ACE_OS_O_RDWR);
		LoadEdis ();

		std::set<long> bad_docs;

		for (std::set<long>::const_iterator it = docs.begin (); it != docs.end (); it++) {
			long doc_id = *it;

			long size, *data = (long*) base->LoadAttrEx (doc_id, IDD2_PARAIDS, size), *ptr = data, saved_size;
			size /= sizeof (long), saved_size = size;
			std::set<long> ids, bad_ids;
			bool b_dup = false;
			for (; size; ptr++, size--) {
				if (*ptr) {
					if (ids.find (*ptr) == ids.end ())
						ids.insert (*ptr);
					else {
						b_dup = true;
						bad_ids.insert (*ptr);
					}
				}
			}
			if (b_dup) {
				bad_docs.insert (doc_id);
				printf ("%ld\n", doc_id);
				DocInfo docinfo;
				base->FindDocInfo (doc_id, docinfo);
				long paraid = docinfo.lastParaID;

				ptr = data + saved_size - 1;
				while (ptr != data) {
					if (bad_ids.find (*ptr) != bad_ids.end ()) {
						bad_ids.erase (bad_ids.find (*ptr));
						*ptr = ++paraid;
					}
					ptr--;
				}
				set_paraid_for (doc_id, paraid);
				docinfo.lastParaID = paraid;
				base->ReplaceAttrEx (doc_id, IDD2_PARAIDS, data, saved_size << 2);
				base->ReplaceAttr (doc_id, IDD_INFO, &docinfo, sizeof (docinfo));

				std::map<long,std::set<long> >::const_iterator map_it = map_doc_editions.find (doc_id);
				for (std::set<long>::const_iterator edi_it = map_it->second.begin (); edi_it != map_it->second.end (); edi_it++) {
					long id = *edi_it;
					base->FindDocInfo (id, docinfo);
					docinfo.lastParaID = get_paraid_for (id);
					base->ReplaceAttr (id, IDD_INFO, &docinfo, sizeof (docinfo));
				}
			}
			gk_free (data);
		}

		delete base;
		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [1], "-fixdups")) {
		base = new StdBigBase (argv [2], ACE_OS_O_RDWR);
		LoadEdis ();

		FILE *topics = fopen (argv [3], "rt");
		std::set<long> docs_to_fix;
		while (!feof (topics)) {
			char str [256];
			if ( !fgets (str, sizeof (str), topics))
				break;

			int length = strlen (str);
			while (length && (str [length-1] == 10 || str [length-1] == 13))
				str [--length] = 0;
			if (!length)
				continue;

			long doc = atol (str);
			docs_to_fix.insert (doc);
		}
		fclose (topics);

		for (std::set<long>::const_iterator it = docs_to_fix.begin (); it != docs_to_fix.end (); it++) {
			long doc_id = *it, size, *data = (long*) base->LoadAttrEx (doc_id, IDD2_PARAIDS, size), *ptr = data, paraid;
			DocInfo docinfo;
			if (base->FindDocInfo (doc_id, docinfo) == sizeof (DocInfo)) {
			if (!(docinfo.Status & DS_EDITION)) {
				//printf ("%ld\r", doc_id);
				paraid = docinfo.lastParaID;
				size >>= 2;
				std::set<long> uids;
				for (int i = 0; i < size; i++, ptr++) {
					if (*ptr == 0)
						continue;
					if (*ptr < 0)
						*ptr = ++paraid;
					if (uids.find (*ptr) == uids.end ()) {
						uids.insert (*ptr);
					} else {
						*ptr = ++paraid;
					}
				}

				set_paraid_for (doc_id, paraid);
				docinfo.lastParaID = paraid;
				base->ReplaceAttrEx (doc_id, IDD2_PARAIDS, data, size << 2);
				base->ReplaceAttr (doc_id, IDD_INFO, &docinfo, sizeof (docinfo));

				std::map<long,std::set<long> >::const_iterator map_it = map_doc_editions.find (doc_id);
				if (map_it != map_doc_editions.end ()) for (std::set<long>::const_iterator edi_it = map_it->second.begin (); edi_it != map_it->second.end (); edi_it++) {
					long id = *edi_it;
					base->FindDocInfo (id, docinfo);
					docinfo.lastParaID = get_paraid_for (id);
					base->ReplaceAttr (id, IDD_INFO, &docinfo, sizeof (docinfo));
				}
			}
			gk_free (data);
			}
		}
		//printf ("\n");

		delete base;
		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [1], "-fix")) {
		base = new YBase (argv [2], ACE_OS_O_RDONLY);
		base->IsOk ();
		LoadEdis ();
		DocCollection *alldocs = base->AllTopics ();

		long i;
		for (i = 0; i < alldocs->ItemCount; i++) {
			long doc_id = (*alldocs)[i], max_id = 0;
			DocInfo docinfo;
			base->FindDocInfo (doc_id, docinfo);
			if (docinfo.Status & DS_EDITION)
				continue;

			//printf ("%ld\r", doc_id);

			if (docinfo.lastParaID > 0)
				max_id = std::max (max_id, docinfo.lastParaID);

			long size, *data = (long*) base->LoadAttrEx (doc_id, IDD2_PARAIDS, size), *ptr = data;
			for (long i = 0; i < size / sizeof (long); i++, ptr++)
				if (*ptr > 0)
					max_id = std::max (max_id, (*ptr & 0x3FFFFFFF) + 1);
			gk_free (data);

			if (docs.find (doc_id) != docs.end ()) {
				std::set<long> *edis = &map_doc_editions.find (doc_id)->second;
				for (std::set<long>::const_iterator it2 = edis->begin (); it2 != edis->end (); it2++) {
					long ed_doc_id = *it2;
					base->FindDocInfo (ed_doc_id, docinfo);
					if (docinfo.lastParaID > 0)
						max_id = std::max (max_id, docinfo.lastParaID);

					long size, *data = (long*) base->LoadAttrEx (ed_doc_id, IDD2_PARAIDS, size), *ptr = data;
					for (long i = 0; i < size / sizeof (long); i++, ptr++)
						if (*ptr > 0)
							max_id = std::max (max_id, (*ptr & 0x3FFFFFFF) + 1);
					gk_free (data);
				}
			}
			set_paraid_for (doc_id, max_id);
		}
		delete base;
		//printf ("\n");

		base = new StdBigBase (argv [2], ACE_OS_O_RDWR);
		for (i = 0; i < alldocs->ItemCount; i++) {
			long doc = (*alldocs) [i];
			long para_id = get_paraid_for (doc);
			DocInfo docinfo;
			base->FindDocInfo (doc, docinfo);
			if (docinfo.lastParaID != para_id) {
				docinfo.lastParaID = para_id;
				base->ReplaceAttr (doc, IDD_INFO, &docinfo, sizeof (docinfo));
			}
		}
		delete base;
		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [1], "-smartcorrect")) {
		base = new YBase (argv [2], ACE_OS_O_RDONLY);
		base->IsOk ();
		LoadEdis ();
		delete base;

		base = new StdBigBase (argv [2], ACE_OS_O_RDWR);
		if (!stricmp (argv [3], "all")) {
			long doc = *docs.begin ();

			std::set<long> processed_ids;
			smartenumnextdoc_params params;
			params.processed_ids = &processed_ids;

			std::set<long>::const_iterator it = docs.find (doc);
			for (; it != docs.end (); it++) {
				doc = *it;
				DocInfo docinfo;
				if (base->FindDocInfo (doc, docinfo) == sizeof (docinfo)) {
					//надо docinfo.LastParaId прописать в мапу
					std::map<long,std::set<long> >::const_iterator map_it = map_doc_editions.find (doc);
					std::set<long>::const_iterator it;
					for (it = map_it->second.begin (); it != map_it->second.end (); it++)
						map_doc_paraid.insert (std::map<long,long>::value_type (*it, docinfo.lastParaID));

					if (docinfo.prevEdition) {
						long size, *para_ids = (long*) base->LoadAttrEx (doc, IDD2_PARAIDS, size);
						params.docId = docinfo.prevEdition;
						params.prevId = doc;
						params.paraIds = para_ids;
						params.prev_edition = true;
						SmartEnumNextDoc (params);
					}
					if (docinfo.nextEdition) {
						long size, *para_ids = (long*) base->LoadAttrEx (doc, IDD2_PARAIDS, size);
						params.docId = docinfo.nextEdition;
						params.prevId = doc;
						params.paraIds = para_ids;
						params.prev_edition = false;
						SmartEnumNextDoc (params);
					}
					
					for (it = map_it->second.begin (); it != map_it->second.end (); it++) {
						long doc_id = *it;
						base->FindDocInfo (doc_id, docinfo);
						docinfo.lastParaID = get_paraid_for (doc_id);
						base->ReplaceAttr (doc_id, IDD_INFO, &docinfo, sizeof (docinfo));
					}
				}
			}
		} else {
			FILE *topics = fopen (argv [3], "rt");
			std::set<long> processed_docs;
			while (!feof (topics)) {
				char str [256];
				if ( !fgets (str, sizeof (str), topics))
					break;

				int length = strlen (str);
				while (length && (str [length-1] == 10 || str [length-1] == 13))
					str [--length] = 0;
				if (!length)
					continue;

				long doc = atol (str);
				DocInfo docinfo;
				if (base->FindDocInfo (doc, docinfo) == sizeof (docinfo)) {
					if (docinfo.Status & DS_EDITION) {
						if (map_edition_doc.find (doc) != map_edition_doc.end ()) {
							doc = map_edition_doc.find (doc)->second;
							base->FindDocInfo (doc, docinfo);
						} else
							doc = 0;
					}

					if (doc && processed_docs.find (doc) == processed_docs.end ()) {
						processed_docs.insert (doc);

						std::set<long> processed_ids;
						smartenumnextdoc_params params;
						params.processed_ids = &processed_ids;

						std::map<long,std::set<long> >::const_iterator map_it = map_doc_editions.find (doc);
						if (map_it != map_doc_editions.end ()) {
							std::set<long>::const_iterator it;
							for (it = map_it->second.begin (); it != map_it->second.end (); it++)
								map_doc_paraid.insert (std::map<long,long>::value_type (*it, docinfo.lastParaID));

							if (docinfo.prevEdition) {
								long size, *para_ids = (long*) base->LoadAttrEx (doc, IDD2_PARAIDS, size);
								params.docId = docinfo.prevEdition;
								params.prevId = doc;
								params.paraIds = para_ids;
								params.prev_edition = true;
								SmartEnumNextDoc (params);
							}
							if (docinfo.nextEdition) {
								long size, *para_ids = (long*) base->LoadAttrEx (doc, IDD2_PARAIDS, size);
								params.docId = docinfo.nextEdition;
								params.prevId = doc;
								params.paraIds = para_ids;
								params.prev_edition = false;
								SmartEnumNextDoc (params);
							}
							
							for (it = map_it->second.begin (); it != map_it->second.end (); it++) {
								long doc_id = *it;
								base->FindDocInfo (doc_id, docinfo);
								docinfo.lastParaID = get_paraid_for (doc_id);
								base->ReplaceAttr (doc_id, IDD_INFO, &docinfo, sizeof (docinfo));
							}
						}
					}
				}
			}
			fclose (topics);
		}
		delete base;

		exit (EXIT_SUCCESS);
	}

	if (!strcmp (argv [1], "-correct")) {
		base = new YBase (argv [2], ACE_OS_O_RDONLY);
		base->IsOk ();
		LoadEdis ();

		if (argc == 3) {
			for (std::set<long>::const_iterator it = docs.begin (); it != docs.end (); it++) {
				long doc_id = *it;
				std::set<long> *edis = &map_doc_editions.find (doc_id)->second;
				long max_id = 0;
				for (std::set<long>::const_iterator it2 = edis->begin (); it2 != edis->end (); it2++) {
					doc_id = *it2;
					DocInfo docinfo;
					base->FindDocInfo (doc_id, docinfo);
					max_id = std::max (max_id, docinfo.lastParaID);
				}
				set_paraid_for (*it, max_id);
			}
			DocCollection *alldocs = base->AllTopics ();

			delete base;
			base = new StdBigBase (argv [2], ACE_OS_O_RDWR);
			for (long i = 0; i < alldocs->ItemCount; i++) {
				long doc = (*alldocs) [i];
				long para_id = get_paraid_for (doc);
				DocInfo docinfo;
				base->FindDocInfo (doc, docinfo);
				if (docinfo.lastParaID != para_id) {
					docinfo.lastParaID = para_id;
					base->ReplaceAttr (doc, IDD_INFO, &docinfo, sizeof (docinfo));
				}
			}
		} else {
			//прочитать из файла номера топиков, и перенумеровать редакции, им соответствующие
			delete base;
			base = new StdBigBase (argv [2], ACE_OS_O_RDWR);

			if (!stricmp (argv [3], "all")) {
				for (std::set<long>::const_iterator it = docs.begin (); it != docs.end (); it++) {
					long doc = *it;
					DocInfo docinfo;
					if (base->FindDocInfo (doc, docinfo) == sizeof (docinfo)) {
						//надо docinfo.LastParaId прописать в мапу
						std::map<long,std::set<long> >::const_iterator map_it = map_doc_editions.find (doc);
						std::set<long>::const_iterator it;
						for (it = map_it->second.begin (); it != map_it->second.end (); it++)
							map_doc_paraid.insert (std::map<long,long>::value_type (*it, docinfo.lastParaID));

						if (docinfo.prevEdition) {
							long size, *para_ids = (long*) base->LoadAttrEx (doc, IDD2_PARAIDS, size);
							EnumNextDoc (docinfo.prevEdition, doc, para_ids, base, base, true);
						}
						if (docinfo.nextEdition) {
							long size, *para_ids = (long*) base->LoadAttrEx (doc, IDD2_PARAIDS, size);
							EnumNextDoc (docinfo.nextEdition, doc, para_ids, base, base, false);
						}
						
						for (it = map_it->second.begin (); it != map_it->second.end (); it++) {
							long doc_id = *it;
							base->FindDocInfo (doc_id, docinfo);
							docinfo.lastParaID = get_paraid_for (doc_id);
							base->ReplaceAttr (doc_id, IDD_INFO, &docinfo, sizeof (docinfo));
						}
					}
				}
			} else {
				FILE *topics = fopen (argv [3], "rt");
				while (!feof (topics)) {
					char str [256];
					if ( !fgets (str, sizeof (str), topics))
						break;

					int length = strlen (str);
					if (length) {
						if (str [length-1] == 10)
							str [--length] = 0;
						if (length && str [length-1] == 13)
							str [--length] = 0;
					} 
					if (!length)
						continue;

					long doc = atol (str);
					DocInfo docinfo;
					if (base->FindDocInfo (doc, docinfo) == sizeof (docinfo)) {
						//надо docinfo.LastParaId прописать в мапу
						std::map<long,std::set<long> >::const_iterator map_it = map_doc_editions.find (doc);
						std::set<long>::const_iterator it;
						for (it = map_it->second.begin (); it != map_it->second.end (); it++)
							map_doc_paraid.insert (std::map<long,long>::value_type (*it, docinfo.lastParaID));

						if (docinfo.prevEdition) {
							long size, *para_ids = (long*) base->LoadAttrEx (doc, IDD2_PARAIDS, size);
							EnumNextDoc (docinfo.prevEdition, doc, para_ids, base, base, true);
						}
						if (docinfo.nextEdition) {
							long size, *para_ids = (long*) base->LoadAttrEx (doc, IDD2_PARAIDS, size);
							EnumNextDoc (docinfo.nextEdition, doc, para_ids, base, base, false);
						}
						
						for (it = map_it->second.begin (); it != map_it->second.end (); it++) {
							long doc_id = *it;
							base->FindDocInfo (doc_id, docinfo);
							docinfo.lastParaID = get_paraid_for (doc_id);
							base->ReplaceAttr (doc_id, IDD_INFO, &docinfo, sizeof (docinfo));
						}
					}
				}
				fclose (topics);
			}
		}

		delete base;
		exit (EXIT_SUCCESS);
	}

	if (argc == 2) {
		base = new YBase (argv[1], ACE_OS_O_RDONLY);
		if (!base || !base->IsOk ())	{
			mpcxc_printfwin ( "seems like base '%s' does not exist or not ok.\n", argv[1] );
			return EXIT_FAILURE;
		}

		/*{
		DocCollection* allDocs = base->AllDocs();
		if ( !allDocs->ItemCount ) {
			delete allDocs;
			allDocs = base->AllTopics();
		}
		
		int version = 5;
		if ( allDocs->ItemCount ) {
			int item = 0;
			long docId = (*allDocs)[item];

			while ( item < allDocs->ItemCount && ( docId == 100100 || ( docId >= BIG_INFO_DOC && docId < BIG_INFO_DOC + BIG_INFO_COUNT )))
				docId = (*allDocs)[++item];
			
			DocInfo docInfo;
			base->FindDocInfo( docId, docInfo );
			if ( docInfo.Status & DS_EVD )
				version = 6;
		}

		if ( version == 6 ) {
			mpcxc_printfwin ( "\nБаза %s в формате F1: перенумерация параграфов невозможна.\n", argv[1] );
			exit ( EXIT_FAILURE );
		}
		}*/

		LoadEdis ();
		delete base;

		base = new StdBigBase (argv[1], ACE_OS_O_RDWR);
		DocCollection *allDocs = base->AllTopics (ID_BORDER);
		std::set<long> docs_to_recalc, docs_with_iddparaids;

		int i;
		for (i = 0; i < allDocs->ItemCount; i++)
			map_doc_paraid.insert (std::map<long,long>::value_type ((*allDocs) [i], 0));

		for (i = 0; i < allDocs->ItemCount; i++) {
			long doc_id = (*allDocs) [i];

			if (doc_id >= BIG_INFO_DOC && doc_id < BIG_INFO_DOC + BIG_INFO_COUNT)
				continue;

			docs_with_iddparaids.insert (doc_id);

			DocInfo docinfo;
			base->FindDocInfo (doc_id, docinfo);
			DocInfo prev_docinfo;
			if (!docinfo.prevEdition || !base->FindDocInfo (docinfo.prevEdition, prev_docinfo))
				EnumDoc (doc_id, true);
		}
		for (std::map<long,long>::const_iterator it = map_doc_paraid.begin (); it != map_doc_paraid.end (); it++) {
			long doc_id = it->first, para_id = it->second;
			DocInfo docinfo;
			if (base->FindDocInfo (doc_id, docinfo) == sizeof (DocInfo)) {
				docinfo.lastParaID = para_id;
				base->ReplaceAttr (doc_id, IDD_INFO, &docinfo, sizeof (docinfo));
			}
		}
		printf ("remove garbage\n");
		AttrIndex *attribs = (AttrIndex*) base->FindIndex("Attribs");
		for (i = 0; i < allDocs->ItemCount; i++) {
			long docId = (*allDocs) [i];
			if (docs_with_iddparaids.find (docId) == docs_with_iddparaids.end ())
				attribs->Del (docId, IDD2_PARAIDS);
		}

		//mpcxc_printfwin ("\n");

		base->SetReady (TID_ENUMPARAS);
		delete base;
	} else {
		//прочитать Edis
		base = new YBase (argv [2], ACE_OS_O_RDONLY);
		base->IsOk ();
		LoadEdis ();
		delete base;

		oldbase = new YBase (argv [1], ACE_OS_O_RDONLY);
		oldbase->IsOk ();
		base = new StdBigBase (argv [2], ACE_OS_O_RDWR);

		/*{
		DocCollection* allDocs = base->AllDocs();
		if ( !allDocs->ItemCount ) {
			delete allDocs;
			allDocs = base->AllTopics();
		}
		
		int version = 5;
		if ( allDocs->ItemCount ) {
			int item = 0;
			long docId = (*allDocs)[item];

			while ( item < allDocs->ItemCount && ( docId == 100100 || ( docId >= BIG_INFO_DOC && docId < BIG_INFO_DOC + BIG_INFO_COUNT )))
				docId = (*allDocs)[++item];
			
			DocInfo docInfo;
			base->FindDocInfo( docId, docInfo );
			if ( docInfo.Status & DS_EVD )
				version = 6;
		}

		if ( version == 6 ) {
			mpcxc_printfwin ( "\nБаза %s в формате F1: перенумерация параграфов невозможна.\n", argv[2] );
			exit ( EXIT_FAILURE );
		}
		}*/

		/*{
		DocCollection* allDocs = oldbase->AllDocs();
		if ( !allDocs->ItemCount ) {
			delete allDocs;
			allDocs = oldbase->AllTopics();
		}
		
		int version = 5;
		if ( allDocs->ItemCount ) {
			int item = 0;
			long docId = (*allDocs)[item];

			while ( item < allDocs->ItemCount && ( docId == 100100 || ( docId >= BIG_INFO_DOC && docId < BIG_INFO_DOC + BIG_INFO_COUNT )))
				docId = (*allDocs)[++item];
			
			DocInfo docInfo;
			oldbase->FindDocInfo( docId, docInfo );
			if ( docInfo.Status & DS_EVD )
				version = 6;
		}

		if ( version == 6 ) {
			mpcxc_printfwin ( "\nБаза %s в формате F1: перенумерация параграфов невозможна.\n", argv[1] );
			exit ( EXIT_FAILURE );
		}
		}*/
		
		DocCollection *newdocs = base->AllTopics (ID_BORDER);
		std::set<long> docs_to_recalc, docs_with_iddparaids;

		long i;
		//надо из старой базы прочитать lastParaId для всех топиков новой базы
		for (i = 0; i < newdocs->ItemCount; i++ ) {
			long doc_id = (*newdocs) [i];
			DocInfo docinfo;
			if (oldbase->FindDocInfo (doc_id, docinfo) == sizeof (DocInfo)) {
				if (0 == docinfo.lastParaID) {
					long size, *data = (long*) oldbase->LoadAttrEx (doc_id, IDD2_PARAIDS, size), *ptr = data;
					for (long i = 0; i < size / sizeof (long); i++, ptr++)
						if (*ptr > 0)
							docinfo.lastParaID = std::max (docinfo.lastParaID, (*ptr & 0x3FFFFFFF) + 1);
					gk_free (data);

					long doc = 0;
					if (docinfo.Status & DS_EDITION) {
						doc = map_edition_doc.find (doc_id)->second;
					} else {
						doc = doc_id;
					}
					std::map<long, std::set<long> >::const_iterator map_it = map_doc_editions.find (doc);
					if (map_it != map_doc_editions.end ()) {
						for (std::set<long>::const_iterator it = map_it->second.begin (); it != map_it->second.end (); it++) {
							long id = *it;
							if (map_doc_paraid.find (id) != map_doc_paraid.end ())
								docinfo.lastParaID = std::max (docinfo.lastParaID, map_doc_paraid.find (id)->second);
						}
					}
					//printf ("replace lastParaId for %ld by %ld\r", doc_id, docinfo.lastParaID); fflush (stdout);
					docs_to_recalc.insert (doc_id);
				}
				map_doc_paraid.insert (std::map<long,long>::value_type (doc_id, docinfo.lastParaID));
			} else {
				map_doc_paraid.insert (std::map<long,long>::value_type (doc_id, 0));
			}
		}

		Stream* str = oldbase->FindIndex ("Aux")->Open (AUX_VERSION);
		if (str) {
			long version = GKDB_BASE_VERSION;
			str->Read (&version, sizeof (version));
			oldbase->FindIndex ("Aux")->Close (str);
			if (version == 702000) {
				//выправить номера
				for (std::set<long>::const_iterator it = docs.begin (); it != docs.end (); it++) {
					long doc_id = *it;
					std::set<long> *edis = &map_doc_editions.find (doc_id)->second;
					long max_id = 0;
					for (std::set<long>::const_iterator it2 = edis->begin (); it2 != edis->end (); it2++) {
						doc_id = *it2;
						DocInfo docinfo;
						if (oldbase->FindDocInfo (doc_id, docinfo) == sizeof (docinfo))
							max_id = std::max (max_id, docinfo.lastParaID);

						long size, *data = (long*) oldbase->LoadAttrEx (doc_id, IDD2_PARAIDS, size), *ptr = data;
						for (long i = 0; i < size / sizeof (long); i++, ptr++)
							if (*ptr > 0)
								max_id = std::max (max_id, (*ptr & 0x3FFFFFFF) + 1);
						gk_free (data);
					}
					set_paraid_for (*it, max_id);
				}
			}
		}

		for (std::set<long>::const_iterator it = docs.begin (); it != docs.end (); it++) {
			long doc_id = *it;
			set_paraid_for (doc_id, map_doc_paraid.find (doc_id)->second);
		}

		DocCollection firsts;
		for (i = 0; i < newdocs->ItemCount; i++) {
			long docId = (*newdocs) [i];
			if (docId >= BIG_INFO_DOC && docId < BIG_INFO_DOC + BIG_INFO_COUNT)
				continue;

			//mpcxc_printfwin("Processing topic %ld                     \r", docId );

			DocInfo docInfo, olddocInfo;
			base->FindDocInfo (docId, docInfo);
			docs_with_iddparaids.insert (docId);
			if ( oldbase->FindDocInfo (docId, olddocInfo) == sizeof (DocInfo)) {
				//в старой базе есть такой документ
				if (false/*!memcmp (&docInfo.Revision, &olddocInfo.Revision, sizeof (revision)) && docs_to_recalc.find (docId) == docs_to_recalc.end ()*/) {
					//документ не изменился, перенести IDD_PARAIDS из старой базы в новую
					long size, *aParaIDs = (long*) oldbase->LoadAttrEx (docId, IDD2_PARAIDS, size), para_id = get_paraid_for (docId);
					if (olddocInfo.ParaCount > size >> 2) {
						aParaIDs = (long*) realloc (aParaIDs, docInfo.ParaCount * sizeof (long));
						for (int j = size >> 2; j < docInfo.ParaCount; j++)
							aParaIDs [j] = ++para_id;
					}
					for (int j = 0; j < size >> 2; j++)
						if (aParaIDs [j] < 0 || ((aParaIDs [j] > para_id) && !(aParaIDs [j] & 0x40000000)))
							aParaIDs [j] = ++para_id;
					base->ReplaceAttrEx (docId,IDD2_PARAIDS,aParaIDs,size);
					set_paraid_for (docId, para_id);
					docInfo.lastParaID = para_id;
					base->ReplaceAttr (docId, IDD_INFO, &docInfo, sizeof (docInfo));
					free (aParaIDs);
				} else {
					//документ изменился
					if (!docInfo.prevEdition && !docInfo.nextEdition) {
						//просто изменившийся документ, без редакций
						//надо построить разницу между ним и им же в прошлой базе
						long size, *aParaIDs = (long*)oldbase->LoadAttrEx (docId,IDD2_PARAIDS,size), para_id = get_paraid_for (docId);
						if (olddocInfo.ParaCount > size >> 2) {
							aParaIDs = (long*) realloc (aParaIDs, docInfo.ParaCount * sizeof (long));
							for (int j = size >> 2; j < docInfo.ParaCount; j++)
								aParaIDs [j] = ++para_id;
						}
						for (int j = 0; j < size >> 2; j++)
							if (aParaIDs [j] < 0 || ((aParaIDs [j] > para_id) && !(aParaIDs [j] & 0x40000000)))
								aParaIDs [j] = ++para_id;
						set_paraid_for (docId, para_id);
						EnumNextDoc (docId, docId, aParaIDs, oldbase, 0);
					} else {
						//изменился документ с редакциями
						//если в цепочке не появилось новых документов, то просто перенумеровать
						if ( OnlyOldDocs( docInfo, docId )) {
							long size, *aParaIDs = (long*)oldbase->LoadAttrEx(docId,IDD2_PARAIDS,size ), para_id = get_paraid_for (docId);
							if (olddocInfo.ParaCount > size >> 2) {
								aParaIDs = (long*) realloc (aParaIDs, docInfo.ParaCount * sizeof (long));
								for (int j = size >> 2; j < docInfo.ParaCount; j++)
									aParaIDs [j] = ++para_id;
							}
							for (int j = 0; j < size >> 2; j++)
								if (aParaIDs [j] < 0 || ((aParaIDs [j] > para_id) && !(aParaIDs [j] & 0x40000000)))
									aParaIDs [j] = ++para_id;
							set_paraid_for (docId, para_id);
							EnumNextDoc (docId, docId, aParaIDs, oldbase, 0);
						} else {
							firsts.Add( FindFirstEdition( docInfo, docId ));
							//mpcxc_printfwin(", изменился, есть новые в цепочке\n" );
						}
						if ((olddocInfo.prevEdition != docInfo.prevEdition) || (olddocInfo.nextEdition != docInfo.nextEdition)) {
							//изменилась цепочка редакций, надо пройти smartEnumDосом
							if (docInfo.Status & DS_DOC)
								docs_for_smart.insert (docId);
							continue;
						}
					}
				}
			} else {
				//новый документ
				if ( docInfo.Status & DS_EDITION ) {
					//новый документ - редакция
					if ( OnlyNewDocs( docInfo, docId )) {
						DocInfo tempInfo;
						if ( !docInfo.prevEdition || ( docInfo.prevEdition && !base->FindDocInfo( docInfo.prevEdition, tempInfo )))
							EnumDoc( docId, true );
					} else {
						firsts.Add( FindFirstEdition( docInfo, docId ));
						//mpcxc_printfwin(", новая редакция, в цепочке есть старые топики\n" );
					}
				} else {
					if (docInfo.prevEdition || docInfo.nextEdition) {
						DocInfo tempInfo;
						if ( !OnlyNewDocs( docInfo, docId ) || ( docInfo.prevEdition && !base->FindDocInfo( docInfo.prevEdition, tempInfo ))) {
							//mpcxc_printfwin(", новый документ, в цепочке есть старые топики\n" );
							firsts.Add( FindFirstEdition( docInfo, docId ));
						}
						docs_for_smart.insert (docId);
					} else {
						EnumDoc( docId, true );
					}
				}
			}
		}

		//mpcxc_printfwin("\n" );

		for (i = 0; i < firsts.ItemCount; i++) {
			long docId = firsts [i];

			//mpcxc_printfwin("Postprocessing topic %ld                   \r", docId );

			std::set<long> processed;
			while ( docId ) {
				//если в старой базе есть такой топик, 
				//	то: перенумеровать относительно него, 
				//	иначе: относительно прошлой в новой базе

				DocInfo docInfo;
				if ( !base->FindDocInfo( docId, docInfo ))
					break;

				if (processed.find (docId) != processed.end ())
					break;

				processed.insert (docId);

				DocInfo prevdocInfo;
				if ( oldbase->FindDocInfo( docId, prevdocInfo ) == sizeof( DocInfo )) {
					long size, *aParaIDs = (long*)oldbase->LoadAttrEx (docId,IDD2_PARAIDS,size);
					EnumNextDoc (docId, docId, aParaIDs, oldbase, 0);
				} else {
					long prevdocId = docInfo.prevEdition;
					if ( prevdocId && base->FindDocInfo( prevdocId, prevdocInfo ) == sizeof( DocInfo )) {
						long size, *aParaIDs = (long*)base->LoadAttrEx (prevdocId,IDD2_PARAIDS,size);
						if ( aParaIDs )
							EnumNextDoc (docId, prevdocId, aParaIDs, base, 0);
						else
							EnumDoc (docId, false);
					} else {
						long next_docid = docInfo.nextEdition;
						DocInfo next_docinfo;
						if (next_docid && oldbase->FindDocInfo (next_docid, next_docinfo) == sizeof (DocInfo)) {
							long size, *aParaIDs = (long*)oldbase->LoadAttrEx (next_docid, IDD2_PARAIDS, size);
							EnumNextDoc (docId, next_docid, aParaIDs, oldbase, 0, false);
						} else {
							EnumDoc (docId, false);
						}
					}
				}

				docId = docInfo.nextEdition;
			}
		}

		//mpcxc_printfwin("\n" ); fflush (stdout);
		for (i = 0; i < newdocs->ItemCount; i++) {
			long docId = (*newdocs) [i];
			bool bad = false;
			AttrKey key = { docId, IDD2_PARAIDS };
			long size = 0;
			void* paraids = base->LoadAttrEx( docId, IDD2_PARAIDS, size );
			if ( !paraids ) bad = true;

			if ( bad ) {
				//mpcxc_printfwin("Postprocessing bad topic %ld\r", docId ); fflush (stdout);
				EnumDoc (docId, false);
			}
			else
				gk_free (paraids);
		}

		fflush (stdout);
		for (std::set<long>::const_iterator it = docs_to_recalc.begin (); it != docs_to_recalc.end (); it++) {
			long doc_id = *it, size, *data = (long*) base->LoadAttrEx (doc_id, IDD2_PARAIDS, size), *ptr = data, paraid;
			DocInfo docinfo;
			if (base->FindDocInfo (doc_id, docinfo) == sizeof (DocInfo)) {
			if (!(docinfo.Status & DS_EDITION)) {
				//printf ("fixdups for %ld\r", doc_id); fflush (stdout);
				paraid = get_paraid_for (doc_id);
				size >>= 2;
				std::set<long> uids;
				for (int i = 0; i < size; i++, ptr++) {
					if (*ptr == 0)
						continue;
					if (*ptr < 0)
						*ptr = ++paraid;
					if (uids.find (*ptr) == uids.end ()) {
						uids.insert (*ptr);
					} else {
						*ptr = ++paraid;
					}
				}

				set_paraid_for (doc_id, paraid);
				docinfo.lastParaID = paraid;
				base->ReplaceAttrEx (doc_id, IDD2_PARAIDS, data, size << 2);
				base->ReplaceAttr (doc_id, IDD_INFO, &docinfo, sizeof (docinfo));

				std::map<long,std::set<long> >::const_iterator map_it = map_doc_editions.find (doc_id);
				if (map_it != map_doc_editions.end ()) for (std::set<long>::const_iterator edi_it = map_it->second.begin (); edi_it != map_it->second.end (); edi_it++) {
					long id = *edi_it;
					base->FindDocInfo (id, docinfo);
					docinfo.lastParaID = get_paraid_for (id);
					base->ReplaceAttr (id, IDD_INFO, &docinfo, sizeof (docinfo));
				}
			} else {
				//printf ("fixdups insert smartdoc for %ld\r", doc_id); fflush (stdout);
				docs_for_smart.insert (map_edition_doc.find (doc_id)->second);
			}
			gk_free (data);
			}
		}
		//printf ("\n");

	#ifdef	MULTITHREAD
		//многопоточность
		docs_for_smart_it = docs_for_smart.begin ();
		int threads_count = argv [3] ? std::min <long> (atol (argv [3]), MAX_THREADS) : 4, thread_id;
		for (thread_id = 0; thread_id < threads_count; thread_id++) {
			thread_data [thread_id].run  = 0;
			thread_data [thread_id].done = 0;
		}
		for (thread_id = 0; thread_id < threads_count; thread_id++) {
			ACE_Thread_Manager* inst = ACE_Thread_Manager::instance ();
			inst->spawn ((ACE_THR_FUNC)thread_smartenumnextdoc, &thread_id, THR_DETACHED);
			ACE_OS::sleep (2);
		}
		int dones; do {
			dones = 0;
			for (thread_id = 0; thread_id < threads_count; thread_id++)
				dones += thread_data [thread_id].done;
			ACE_OS::sleep (10);
		} while (dones < threads_count);
	#else
		for (std::set<long>::const_iterator it = docs_for_smart.begin (); it != docs_for_smart.end (); it++) {
			long doc = *it;
			DocInfo docinfo;
			if (base->FindDocInfo (doc, docinfo) == sizeof (docinfo)) {
				std::set<long> processed_ids;
				smartenumnextdoc_params params;
				params.processed_ids = &processed_ids;

				//надо docinfo.LastParaId прописать в мапу
				std::map<long,std::set<long> >::const_iterator map_it = map_doc_editions.find (doc);
				std::set<long>::const_iterator it;
				for (it = map_it->second.begin (); it != map_it->second.end (); it++)
					map_doc_paraid.insert (std::map<long,long>::value_type (*it, docinfo.lastParaID));

				if (docinfo.prevEdition) {
					long size, *para_ids = (long*) base->LoadAttrEx (doc, IDD2_PARAIDS, size);
					params.docId = docinfo.prevEdition;
					params.prevId = doc;
					params.paraIds = para_ids;
					params.prev_edition = true;
					SmartEnumNextDoc (params/*docinfo.prevEdition, doc, para_ids, processed_ids, true*/);
				}
				if (docinfo.nextEdition) {
					long size, *para_ids = (long*) base->LoadAttrEx (doc, IDD2_PARAIDS, size);
					params.docId = docinfo.nextEdition;
					params.prevId = doc;
					params.paraIds = para_ids;
					params.prev_edition = false;
					SmartEnumNextDoc (params/*docinfo.nextEdition, doc, para_ids, processed_ids, false*/);
				}

				for (it = map_it->second.begin (); it != map_it->second.end (); it++) {
					long doc_id = *it;
					base->FindDocInfo (doc_id, docinfo);
					docinfo.lastParaID = get_paraid_for (doc_id);
					base->ReplaceAttr (doc_id, IDD_INFO, &docinfo, sizeof (docinfo));
				}
			}
		}
	#endif

		for (std::map<long,long>::const_iterator it = map_doc_paraid.begin (); it != map_doc_paraid.end (); it++) {
			long doc_id = it->first, para_id = it->second;
			//printf ("for %ld lastParaId is %ld\r", doc_id, para_id);
			DocInfo docinfo;
			if (base->FindDocInfo (doc_id, docinfo) == sizeof (DocInfo)) {
				docinfo.lastParaID = para_id;
				base->ReplaceAttr (doc_id, IDD_INFO, &docinfo, sizeof (docinfo));
			}
		}

		printf ("remove garbage\n");
		AttrIndex *attribs = (AttrIndex*) base->FindIndex("Attribs");
		for (i = 0; i < newdocs->ItemCount; i++) {
			long docId = (*newdocs) [i];
			if (docs_with_iddparaids.find (docId) == docs_with_iddparaids.end ())
				attribs->Del (docId, IDD2_PARAIDS);
		}
		delete newdocs;

		//mpcxc_printfwin("\n" );
		base->SetReady (TID_ENUMPARAS);
		delete base;
		delete oldbase;
	}

	return 0;
}

int MemoryError ( )
{
	printf ( "Memory error" );
	exit (EXIT_FAILURE);
	return 0;
}

void cdecl OkBox ( char *s1, char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}

void cdecl OkBox ( const char *s1, const char *s2, ... )
{
	printf ( "OkBox:\n%s\n%s", s1, s2 );
	exit (EXIT_FAILURE);
}
