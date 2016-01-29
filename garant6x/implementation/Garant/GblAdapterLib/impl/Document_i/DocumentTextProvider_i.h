////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentTextProvider_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DocumentTextProvider_i
// Заголовок реализации класса серванта для интерфеса DocumentTextProvider
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTTEXTPROVIDER_I_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTTEXTPROVIDER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"

//#UC START# *4C5ADDD20234_CUSTOM_INCLUDES*
#include <map>
#include "shared/GCL/data/StaticNode.h"

namespace GblAdapterLib {

const char LF_HAS_COMMENTS  = 0x01;
const char LF_HAS_BOOKMARKS = 0x02;

class ServerTextProviderFacade : virtual public Core::RefCountObjectBase {
public:
	virtual GblPilot::DocItemList* get_range (CORBA::ULong id, CORBA::ULong from, CORBA::ULong count) = 0;
	virtual GblPilot::BranchList* get_all_branches () = 0;
	virtual GTree::NodeIndexPath* find_para (CORBA::ULong id) = 0;
	virtual	GTree::NodeIndexPath* find_block_or_sub (CORBA::ULong id) = 0;
	virtual GblPilot::ContextList* find_contexts (const char* words, CORBA::Long from_id) = 0;
	virtual void set_comment (CORBA::ULong para_id, const GCD::SeqOctet & comment) = 0;
	virtual void remove_comment (CORBA::ULong para_id) = 0;
	virtual GblPilot::TechCommentList* tech_comments () = 0;
	virtual GTree::Tree* get_prefix_tree_by_block (ExternalID id) = 0;
	virtual GblPilot::BlockInfoList* get_info_for_all_blocks () = 0;
};

typedef Core::Var<ServerTextProviderFacade> ServerTextProviderFacade_var;


class DocItem : public Core::RefCountObjectBase {
public:	
	DocItem (const GblPilot::DocItem& sit);
	EVDType type () const;
	LayerID layer () const;
	ExternalID id () const;
	const EVDStream* style () const;
	virtual void kill_style ();
	
	virtual char flags () const = 0;
	
	virtual void set_comment_flag ();
	virtual void reset_comment_flag ();	
	
	virtual const GCI::IO::String* text () const;
	virtual void kill_text ();
	virtual size_t children_count () const = 0;
	virtual size_t all_leaf_children_count () const = 0;
	virtual const std::vector <unsigned long>* sub_list () const;
	
private:
	EVDType m_type;
	LayerID m_layer;
	ExternalID m_id;
	EVDStream_var m_evd_style;
	GCI::IO::String_var m_text;
};

typedef Core::Var <DocItem> DocItem_var;

class LayerItem : public DocItem {
public:
	LayerItem (const GblPilot::DocItem& sit);

protected:
	virtual char flags () const;

	virtual size_t children_count () const;
	virtual size_t all_leaf_children_count () const;
	
private:
	size_t m_children_count;
	size_t m_all_leaf_children_count;
};

class LeafItem : public DocItem {
public:
	LeafItem (const GblPilot::DocItem& sit);

protected:
	virtual char flags () const;
	virtual size_t children_count () const;
	virtual size_t all_leaf_children_count () const;

	virtual void set_comment_flag ();
	virtual void reset_comment_flag ();	

private:
	char m_flags;
};

class LeafItemWithSubs : public LeafItem {
public:
	LeafItemWithSubs (const GblPilot::DocItem& sit);

protected:
	virtual const std::vector <unsigned long>* sub_list () const;

private:
	 std::vector <unsigned long> m_sub_list;
};

} // namespace GblAdapterLib 
//#UC END# *4C5ADDD20234_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class DocumentTextProvider_i; // self forward Var
typedef ::Core::Var<DocumentTextProvider_i> DocumentTextProvider_i_var;
typedef ::Core::Var<const DocumentTextProvider_i> DocumentTextProvider_i_cvar;

class DocumentTextProvider_i:
	virtual public DocumentTextProvider
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (DocumentTextProvider_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DocumentTextProvider_i (GblPilot::Document* server_doc, const GblPilot::HighlightHandle& handle, bool all_at_once);

	DocumentTextProvider_i (GblPilot::Document* server_doc, unsigned long handle, bool all_at_once);

	virtual ~DocumentTextProvider_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DocumentTextProvider
	virtual unsigned long all_leaf_para_count (LayerID layer_id) /*throw (InvalidLayerID)*/;

	// implemented method from DocumentTextProvider
	virtual unsigned long children_count (LayerID layer_id) /*throw (InvalidLayerID)*/;

	// implemented method from DocumentTextProvider
	virtual const NodeIndexPath& find_block_or_sub (ExternalID id) /*throw (CanNotFindData)*/;

	// implemented method from DocumentTextProvider
	virtual FoundContext* find_context (const GCI::IO::String* context, ExternalID from_id) /*throw (CanNotFindData)*/;

	// implemented method from DocumentTextProvider
	virtual NodeIndexPath* find_para (ExternalID id) /*throw (CanNotFindData)*/;

	// implemented method from DocumentTextProvider
	virtual const BookmarkList& get_child_bookmarks (const EntryPoint& id) /*throw (EmptyResult, InvalidEntryPoint)*/;

	// implemented method from DocumentTextProvider
	virtual const EVDStream* get_child_comment (const EntryPoint& id) /*throw (InvalidEntryPoint)*/;

	// implemented method from DocumentTextProvider
	virtual ExternalID get_child_external_id (const EntryPoint& id) /*throw (InvalidEntryPoint)*/;

	// implemented method from DocumentTextProvider
	virtual LayerID get_child_layer_id (const EntryPoint& id) /*throw (InvalidEntryPoint)*/;

	// implemented method from DocumentTextProvider
	virtual GCI::IO::String* get_child_tech_comment (const EntryPoint& id) /*throw (InvalidEntryPoint)*/;

	// implemented method from DocumentTextProvider
	virtual EVDType get_child_type (const EntryPoint& id) /*throw (InvalidEntryPoint)*/;

	// implemented method from DocumentTextProvider
	virtual NodeBase* get_prefix_tree (ExternalID id);

	// implemented method from DocumentTextProvider
	virtual const SubList& get_sub_list (const EntryPoint& id);

	// implemented method from DocumentTextProvider
	// Если есть похожие к sub вернет true, иначе false.
	virtual bool has_same (ExternalID id);

	// implemented method from DocumentTextProvider
	virtual void remove_child_comment (const EntryPoint& id);

	// implemented method from DocumentTextProvider
	virtual void set_child_comment (const EntryPoint& id, const EVDStream* comment) /*throw (InvalidEntryPoint)*/;

	// implemented method from DocumentTextProvider
	// Нужно ли показывать иконку для блока на сабпанели
	virtual bool show_sub_panel_icon (ExternalID id);

//#UC START# *4C5ADDD20234*
private:
	typedef std::map <EntryPoint, DocItem_var> ItemMap;
	typedef std::map <EntryPoint, EVDStream_var> CommentMap;
	typedef std::map <EntryPoint, BookmarkList> BookmarkMap;
	typedef std::map <long, GCI::IO::String_var> TechCommentsMap;

	typedef std::map <LayerID, ItemMap::iterator> LayerMap;

	struct ExternalIDCmp : public std::binary_function <
		std::pair <ExternalID, LayerID>
		, std::pair <ExternalID, LayerID>
		, bool
	> {
		bool operator () (const std::pair <ExternalID, LayerID>& x, const std::pair <ExternalID, LayerID>& y) const {
			return x.first < y.first;
		} 
	};

	typedef std::map<ExternalID, NodeIndexPath> BlockOrSubPathCache;

protected:
	DocItem& get_item (const EntryPoint& id);
	const DocItem& get_item (LayerID layer_id);

	void kill_text (const EntryPoint& id);
	void kill_style (const EntryPoint& id);

private:
	DocItem& load_item (const EntryPoint& id);
	void load_all_branches ();
	void make_item (const EntryPoint& id, const GblPilot::DocItem& sit);
	
	void load_tech_comments_if_empty ();
	
	void dump (const EntryPoint& id, int level = 0);
	void dump_server_tree ();
	void dump_entry_point (const EntryPoint& id, int level);
	void test_find_context (const char* text, ExternalID from_id);
	
private:
	ItemMap m_items;
	LayerMap m_layers;

	CommentMap m_comments;
	BookmarkMap m_bookmarks;
	 
	ServerTextProviderFacade_var m_facade;
	const static std::vector <unsigned long> s_empty_sub_list;
	TechCommentsMap m_tech_comments;
	bool m_tech_comments_loaded;
	
	BlockOrSubPathCache m_block_or_sub_cache;

// кеш деревьев типизации СКРов
private:
	typedef std::map <unsigned long, GCL::StaticNode_var> CorrespondentTreeCache;
	CorrespondentTreeCache m_tree_cache;

// кеш масок kind'ов для всех блоков и сабов документа
private:
	struct BlockInfoLess : public std::binary_function <const GblPilot::BlockInfo&, const GblPilot::BlockInfo&, bool> {
			bool operator () (const GblPilot::BlockInfo& item, CORBA::ULong block) const {
				return item.block < block;
			}

			bool operator () (CORBA::ULong block, const GblPilot::BlockInfo& item) const {
				return item.block < block;
			}

			bool operator () (const GblPilot::BlockInfo& left, const GblPilot::BlockInfo&  right) const {
				return left.block < right.block;
			}
	};
	bool m_cache_loaded;
	GblPilot::BlockInfoList_var m_cache;
	const GblPilot::BlockInfo* get_block_info_by_id (ExternalID id);
//#UC END# *4C5ADDD20234*
}; // class DocumentTextProvider_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCUMENTTEXTPROVIDER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
