#include "shared/Core/fix/mpcxc.h"

#include "gardefs.h"
#include "garutils.h"
#include "stdbase.h"

#include <stack>

int main_logic ( int argc, char *argv[] );

int main ( int argc, char *argv[] ) {
	int res = mpcxc_run_main_stack_size (main_logic, argc, argv, MPCXC_STACK_SIZE);
	return res;
}

std::vector<long> blocks_to_proceed [2];
std::map<long,long> block_beginpara [2], block_endpara [2];

Base *base;

std::map<long, long> map_edition_doc;
std::set<long> docs;
std::map<long, std::set<long> > map_doc_editions;

void	process_block (long block, long levels, std::map<long,std::vector<long> > &block_children, std::map<long,long> &block_levels, std::set<long> &visible_blocks)
{
	if (levels)
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

	long subs_count;
	SubDescEx *org_subs = (SubDescEx*) base->LoadAttr (doc_id, IDD_SUBS_EX, subs_count);
	subs_count /= sizeof (SubDescEx);

	SubDescEx* subs = org_subs;
	long i, block = 0, level = 0;
	std::stack<long> blocks;
	std::map<long,long> block_parentblock;
	std::map<long,long> block_level; //какой уровень вложенности у этого блока
	std::map<long,std::set<long> > level_blocks;
	blocks.push (block);
	for (i = 0; i < subs_count; i++, subs++) {
		unsigned short flags = subs->Flags;
		if (flags == SUBDESCEX_BLOCK) {
			level++;
			long new_block = subs->Sub;
			block_parentblock.insert (std::map<long,long>::value_type (new_block, block));
			block_level.insert (std::map<long,long>::value_type (new_block, level));
			block_beginpara [offset].insert (std::map<long,long>::value_type (new_block, subs->Para));
			block = new_block;

			std::map<long,std::set<long> >::iterator it = level_blocks.find (level);
			if (it == level_blocks.end ()) {
				std::set<long> new_blocks;
				new_blocks.insert (block);
				level_blocks.insert (std::map<long, std::set<long> >::value_type (level, new_blocks));
			} else {
				it->second.insert (block);
			}

			blocks.push (block);
		} else
		if (flags == SUBDESCEX_BLOCKEND) {
			block_endpara [offset].insert (std::map<long,long>::value_type (subs->Sub, subs->Para));
			level--;
			blocks.pop ();
			block = blocks.top ();
		}
	}
	free (org_subs);

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
	long contents_count;
	long levels0 = 0;
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

void	check_doc (long doc, long prev, bool prev_edition)
{
	if (!doc)
		return;

	smart_getblocks (prev, 0);
	smart_getblocks (doc,  1);
	for (std::vector<long>::const_iterator it = blocks_to_proceed [1].begin (); it != blocks_to_proceed [1].end (); it++) {
		long block = *it;
		if (block_beginpara [0].find (block) == block_beginpara [0].end ()) {
			printf ("%ld and %ld, block %ld\n", prev, doc, block);
			break;
		}
	}

	DocInfo docinfo;
	base->FindDocInfo (doc, docinfo);
	check_doc (prev_edition ? docinfo.prevEdition : docinfo.nextEdition, doc, prev_edition);
}

void	LoadEdis ()
{
	Stream *str = base->FindIndex ("Aux")->Open ("Edis");
	if (!str) {
		if (!base->FindIndex ("Aux")->Open ("Info")) {
			printf ( "run gl first!\n");
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
	}
}

int main_logic ( int argc, char *argv[] )
{
	base = new YBase (argv [1], ACE_OS_O_RDONLY);
	LoadEdis ();

	for (std::set<long>::const_iterator it = docs.begin (); it != docs.end (); it++) {
		long doc = *it;
		DocInfo docinfo;
		if (base->FindDocInfo (doc, docinfo) == sizeof (docinfo)) {
			if (docinfo.prevEdition) {
				long size, *para_ids = (long*) base->LoadAttrEx (doc, IDD2_PARAIDS, size);
				check_doc (docinfo.prevEdition, doc, true);
			}
			if (docinfo.nextEdition) {
				long size, *para_ids = (long*) base->LoadAttrEx (doc, IDD2_PARAIDS, size);
				check_doc (docinfo.nextEdition, doc, false);
			}
		}
	}

	delete base;
	return 0;
}
