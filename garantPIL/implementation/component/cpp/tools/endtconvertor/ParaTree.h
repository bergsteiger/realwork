
#ifndef __PARA_TREE_H
#define __PARA_TREE_H

#include <map>

#include "common/components/rtl/Garant/EVD/EeGenerator_i.h"

#include "garantPIL/implementation/component/cpp/libs/endt/EndtWriter.h"
#include "garantPIL/implementation/component/cpp/libs/endt/Defines.h"

#include "IndexData.h"
#include "common.h"

namespace EndtConvertor {

	class MedTopics {
	public:
		MedTopics () {
		}

		virtual ~MedTopics () {
		}

		bool load (Base* base) {
			GUARD (m_mutex);

			if (m_data.is_nil ()) {
				m_data = base->inpharm_medtopics ();
			}

			return (m_data.is_nil () == false && m_data->ItemCount);
		}

		bool is_medtopics (DocCollection& collection) {
			if (collection.ItemCount) {
				return (collection.IsSect (m_data.in ()) != 0);
			}
			return false;
		}

	private:
		Core::Mutex m_mutex;
		Core::Aptr <DocCollection> m_data;
	};

	typedef ACE_Singleton <MedTopics, ACE_SYNCH_RECURSIVE_MUTEX> MedTopicsSingleton;

	/////////////////////////////////////////////////////////////////////////////////////////////

	class TopicData {
	public:
		TopicData () : m_status (0), m_sub (0), m_object_id (0), m_class_id (EndtTools::CI_TOPIC) {
		}

	public:
		void set_address (Base* base, long doc_id, Ref* pRef);
		void add_address (evd::IeeGenerator* generator, long doc_id);

		inline void set_data (unsigned long class_id, unsigned long object_id, unsigned long sub) {
			m_sub = sub;
			m_class_id = class_id;
			m_object_id = object_id;
		}

		inline unsigned long get_object_id () const {
			return m_object_id;
		}

	private:
		void add_redactions (evd::IeeGenerator* generator, long doc_id);

	private:
		short m_status;

		unsigned long m_sub;
		unsigned long m_class_id;
		unsigned long m_object_id;
	};

	/////////////////////////////////////////////////////////////////////////////////////////////

	struct Position {
		long start;
		long finish;

		Position () : start (-1), finish (-1) {
		}

		inline bool is_valid () const { 
			return (start >= 0 && start <= finish); 
		}

		inline unsigned get_length () const { 
			return (start > finish)? 0 : finish - start + 1;
		}
	};

	typedef std::vector <Position> Positions;

	/////////////////////////////////////////////////////////////////////////////////////////////

	class Para;

	class TreeNode {
	public:
		enum NodeType { 
			nt_Empty
			, nt_Normal
			, nt_Header
			, nt_Comment
			, nt_NoPrint
			, nt_NoActive
			, nt_LegalComment
			, nt_Link
			, nt_LinkContinue 
			, nt_LegalContent
			, nt_NotApplied
			, nt_Formula
			, nt_Picture
			, nt_DecorStyle
		};

	public:
		TreeNode (Para* master, NodeType type);

		virtual ~TreeNode ();

	public:
		void add_child (TreeNode* child);
		void add_text (const char* text);

		void generate_style (
			evd::IeeGenerator* generator
			, EndtTools::EndtWriter& writer
			, std::string& str
			, std::string& part
		);

		std::string generate (
			evd::IeeGenerator* generator
			, EndtTools::EndtWriter& writer
			, const ParaHeights& para_heights
		);

		inline TreeNode* parent () const { 
			return m_parent; 
		}

		inline unsigned get_length () const { 
			return m_position.get_length (); 
		}

		inline const Position& get_position () const { 
			return m_position; 
		}

		inline NodeType get_type () const { 
			return m_type; 
		}

		inline void set_start (long value) { 
			if (value > 0) {
				m_position.start = value; 
			} else if (value == 0) {
				m_position.start = 1;
			}
		}

		inline void set_finish (long value) { 
			if (value > 0) {
				m_position.finish = value; 
			} else if (value == 0) {
				m_position.finish = 1;
			}
		}

	protected:
		void normalize (const Positions& positions);

	protected:
		struct node_t {
			node_t* m_next;
			TreeNode* m_child;
			std::string m_text_after;

			node_t () : m_next (0), m_child (0) {
			}
		};

		Para* m_master;
		TreeNode* m_parent;

		NodeType m_type;
		Position m_position;
		std::string m_text_before;

		node_t m_children;
	};

	class Normal
		: public TreeNode {
	public:
		Normal (Para* master) : TreeNode (master, nt_Normal) { 
		}
	};

	class Header
		: public TreeNode {
	public:
		Header (Para* master) : TreeNode (master, nt_Header) { 
		}
	};

	class DecorStyle
		: public TreeNode {
	public:
		DecorStyle (Para* master) : TreeNode (master, nt_DecorStyle) {}

	public:
		inline void set_decor (std::string value) { 
			m_decor = value; 
		}
		inline std::string get_decor () { 
			return m_decor;
		}

	private:
		std::string m_decor;
	};

	class Comment
		: public TreeNode {
	public:
		Comment (Para* master) : TreeNode (master, nt_Comment) { 
		}
	};

	class NoPrint
		: public TreeNode {
	public:
		NoPrint (Para* master) : TreeNode (master, nt_NoPrint) { 
		}
	};

	class NoActive
		: public TreeNode {
	public:
		NoActive (Para* master) : TreeNode (master, nt_NoActive) { 
		}
	};

	class LegalComment 
		: public TreeNode {
	public:
		LegalComment (Para* master) : TreeNode (master, nt_LegalComment) { 
		}
	};

	class LegalContent 
		: public TreeNode {
	public:
		LegalContent (Para* master) : TreeNode (master, nt_LegalContent) {
		}
	};

	class LinkCont 
		: public TreeNode {
	public:
		LinkCont (Para* master) : TreeNode (master, nt_LinkContinue) { 
		}
	};

	class NotApplied 
		: public TreeNode {
	public:
		NotApplied (Para* master) : TreeNode (master, nt_NotApplied) {
		}
	};

	class Formula
		: public TreeNode {
	public:
		Formula (Para* master) : TreeNode (master, nt_Formula) {
		}
	};

	class Picture
		: public TreeNode {
	public:
		Picture (Para* master) : TreeNode (master, nt_Picture) {
		}
	};

	class Link 
		: public TreeNode {
	public:
		Link (Para* master) 
			: TreeNode (master, nt_Link)
			, m_is_picture (false)
			, m_obj_id (0)
			, m_obj_type (0) 
			, m_ref_type (0)
			, m_ref_count (0) {
		}

	public:
		void make (Base* base, const char* buf, short& pos, size_t count, long doc_id);

		inline void set_display_picture (bool value) { 
			m_is_picture = value; 
		}

		inline long get_obj_id () const { 
			return m_obj_id; 
		}

		inline bool is_display_picture () const { 
			return m_is_picture; 
		}

		inline bool is_picture () const {	
			return m_obj_type == EOT_PIC 
				|| m_obj_type == EOT_PNG 
				|| m_obj_type == EOT_JPG 
				|| m_obj_type == EOT_GIF; 
		}

	public:
		std::string m_name;
		TopicData m_data;

	private:
		bool m_is_picture;

		long m_obj_id;
		char m_ref_type;

		unsigned long m_obj_type;
		unsigned short m_ref_count;
	};

	/////////////////////////////////////////////////////////////////////////////////////////////

	typedef std::vector <Para> ParaArray;

	class Para {
	public:
		Para ();
		~Para ();

	public:
		inline Para& operator = (const Para& copy) {
			m_is_legal_comment = copy.m_is_legal_comment;
			m_has_legal_content = copy.m_has_legal_content;
			m_style = copy.m_style;
			m_para_style = copy.m_para_style;
			return *this;
		}

		void reset ();
		void make_style (evd::IeeGenerator* generator, TreeNode* node, const Position& pos);

		void build_tree (
			Base* base
			, Document* doc
			, const Para& prev
			, unsigned num
			, bool& is_chain
			, bool has_sub
			, bool inherit_prev
		);

		void generate (
			evd::IeeGenerator* generator
			, EndtTools::EndtWriter& writer
			, bool is_clear_pseudo
			, const ParaHeights& para_heights
		);

		bool is_show_picture (const char* buf);
		bool is_paragraph_style (TreeNode* node, unsigned seg_len);

		inline void set_style (const TreeNode::NodeType& type);

		inline bool need_normalize () const {
			return m_obj_seg_positions.empty () == false;
		}

		inline bool has_legal_bmp () const { 
			return (m_has_bmp && m_is_legal_comment); 
		}

		inline unsigned get_doc () const { 
			return m_doc; 
		}

		inline const Positions& get_obj_seg_positions () const {
			return m_obj_seg_positions;
		}

		inline bool is_nsr_char (char ch) {
			bool ret = false;

			switch (ch) {
				case AT_SEL1:
				case AT_SEL2:
				case AT_SEL3:
				case AT_XREF:
				case AT_PRINT:
				case AT_SEL6:
				case AT_FUT:
				case AT_FORMULA:
				case AT_EMBEDDEDPIC:
				case AT_MARKEDTEXT:
					ret = true;
					break;
				case '\t':
					ret = (m_style == PS_SIDEBYSIDE);
					break;
			}

			return ret;
		}

	private:
		template <typename T>
		void make_node (TreeNode*& node, bool& is_finish, long pos = -1) {
			if (is_finish) {
				node->set_finish (pos);
				this->go_up (node);
			} else {
				this->add_node <T> (node, pos);
			}

			is_finish = !is_finish;
		}

		template <typename T>
		void add_node (TreeNode*& node, long pos = -1) {
			T* new_node = new T (this);

			if (m_root == 0) {
				m_root = new_node;
			} else if (!node) {
				m_root->add_child (new_node);
			} else {
				node->add_child (new_node);
			}

			node = new_node;

			if (pos >= 0) {
				node->set_start (pos + 1);
			}
		}

		void generate_segment (evd::IeeGenerator* generator, const TreeNode::NodeType& type, const Position& pos);
		void generate_style_1 (evd::IeeGenerator* generator, EndtTools::EndtWriter& writer);
		void generate_style_2 (evd::IeeGenerator* generator, EndtTools::EndtWriter& writer);

		void set_table_para (char ch, unsigned index, unsigned& count, unsigned& col);

		inline void go_up (TreeNode*& node) { 
			node = node->parent (); 
		}

		inline bool is_legal () const { 
			return (m_is_legal_comment && m_has_legal_content); 
		}

		inline bool is_normal_ANSI () const {
			return (!m_leftmargin && !m_rightmargin && m_redline == 5);
		}

		inline bool is_article_header () const {
			return (m_leftmargin >= 15 && m_leftmargin <= 19 && !m_rightmargin && m_redline == 5);
		}

		inline bool is_normal_note () const {
			return (m_leftmargin == 1 && !m_rightmargin && m_redline == 1);
		}

		inline bool is_dict_entry () const {
			return (!m_leftmargin && m_rightmargin == 1 && !m_redline);
		}

		inline bool is_pseudo () const { 
			return (
				m_para_style == st_PseudoComment 
				|| m_para_style == st_PseudoContent
				|| m_para_style == st_PseudoVersionComment
			); 
		}

		inline bool is_garant_comment () const {
			return (m_style != PS_VERSION && (m_para_style == st_PseudoComment || m_is_legal_comment));
		}

		inline bool is_version_comment () const {
			return (m_style == PS_VERSION || m_para_style == st_PseudoVersionComment);
		}

	private:
		enum Styles { 
			st_Empty
			, st_Header
			, st_Comment
			, st_LegalComment
			, st_LegalContent
			, st_PseudoComment
			, st_PseudoContent
			, st_NoPrint
			, st_NoActive
			, st_NotApplied
			, st_PseudoVersionComment
			, st_DecorStyle
		};

	private:
		Positions m_obj_seg_positions;

		bool m_has_bmp;
		bool m_has_pseudo_graph;
		bool m_has_legal_content;
		bool m_has_comment_handle;
		bool m_is_legal_comment;
		bool m_is_comment_in_chain;

		char m_style;
		unsigned m_doc;
		unsigned m_para;
		unsigned m_para_len;
		unsigned m_first_empty;
		unsigned char m_redline;
		unsigned char m_leftmargin;
		unsigned char m_rightmargin;

		TreeNode* m_root;
		Styles m_para_style;

	public:
		std::vector<long> marked_positions;
	};

} // namespace

#endif // __PARA_TREE_H
