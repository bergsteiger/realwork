header "pre_include_hpp" {
#include "shared/Core/sys/std_inc.h"
}

header "post_include_hpp" {
#include "MDProcess/MDAFormat/ModelPartDef/RootPackage.h"
#include "MDProcess/MDAFormat/ViewPartDef/AssociationView.h"
#include "MDProcess/MDAFormat/ViewPartDef/ClassDef.h"
#include "MDProcess/MDAFormat/ViewPartDef/ClassDiagram.h"
#include "MDProcess/MDAFormat/ViewPartDef/ClassDiagramView.h"
#include "MDProcess/MDAFormat/ViewPartDef/ClassView.h"
#include "MDProcess/MDAFormat/ViewPartDef/DependencyView.h"
#include "MDProcess/MDAFormat/ViewPartDef/InheritView.h"
#include "MDProcess/MDAFormat/ViewPartDef/MessageView.h"
#include "MDProcess/MDAFormat/ViewPartDef/NameView.h"
#include "MDProcess/MDAFormat/ViewPartDef/Namespace.h"
#include "MDProcess/MDAFormat/ViewPartDef/NoteView.h"
#include "MDProcess/MDAFormat/ViewPartDef/ObjectView.h"
#include "MDProcess/MDAFormat/ViewPartDef/PackageDef.h"
#include "MDProcess/MDAFormat/ViewPartDef/PackageView.h"
#include "MDProcess/MDAFormat/ViewPartDef/ParamView.h"
#include "MDProcess/MDAFormat/ViewPartDef/Point.h"
#include "MDProcess/MDAFormat/ViewPartDef/RealizeView.h"
#include "MDProcess/MDAFormat/ViewPartDef/ReturnMessageView.h"
#include "MDProcess/MDAFormat/ViewPartDef/RootPackage.h"
#include "MDProcess/MDAFormat/ViewPartDef/SelfMessageView.h"
#include "MDProcess/MDAFormat/ViewPartDef/SequenceDiagram.h"
#include "MDProcess/MDAFormat/ViewPartDef/SequenceDiagramView.h"
#include "MDProcess/MDAFormat/ViewPartDef/StateDiagram.h"
#include "MDProcess/MDAFormat/ViewPartDef/StateDiagramView.h"
#include "MDProcess/MDAFormat/ViewPartDef/StateView.h"
#include "MDProcess/MDAFormat/ViewPartDef/StereotypeView.h"
#include "MDProcess/MDAFormat/ViewPartDef/TransitionView.h"
#include "MDProcess/MDAFormat/ViewPartDef/ViewPartDef.h"

#include <boost/lexical_cast.hpp>
#include <vector>
#include <map>
}
options {
	language = "Cpp";
	genHashLines=false;
	namespace = "MDAFormat::ViewPartDef";
}

{
	struct RootPackageKeyComparator : public std::unary_function<Core::Box<RootPackage>, bool> {
		RootPackageKeyComparator (const std::string& key)
			: m_key (&key)
		{
		}
		
		bool operator () (const Core::Box<RootPackage>& item) {
			return item-> () == *m_key;
		}
		
		const std::string* m_key;
	};

	ViewPartParser::Context::Context () {
	}
	
	Core::Box<RootPackage> ViewPartParser::Context::find_context (const std::string& key) const {
		Core::Box<RootPackage> result;
		if (m_context.is_nil ()) {
			std::vector<Core::Box<RootPackage> >::const_iterator it = std::find_if (
				m_root_level.begin ()
				, m_root_level.end ()
				, RootPackageKeyComparator (key)
			);
			
			if (it != m_root_level.end ()) {
				result = *it;
			}
		} else {
			
			result = ContextFinder () (m_context, ns);
		
		return result;
	}
	
	const std::vector<Core::Box<RootPackage> >& ViewPartParser::Context::get_root_level () const {
		return m_root_level;
	}
	
	void ViewPartParser::Context::add_root (const Core::Box<RootPackage>& new_root) {
		m_root_level.push_back (new_root);
	}
	
	void ViewPartParser::Context::on_namespace (const std::string& ns) {
		Core::Box<RootPackage> context_for_ns = find_context (ns);
		
		if (context_for_ns.is_nil ()) {
			context_for_ns = create_new_context (ns);
			if (m_context.is_nil ()) {
				add_root (context_for_ns);
			} else {
			Core::Box<RootPackage> new_context = ContextFinder () (m_context, ns);
			if (new_context.is_nil ()) {
				new_context = create_new_context (ns);
			}
			m_context = new_context;
		}
		
		m_context = context_for_ns;
	}
	
	void ViewPartParser::Context::on_new_element (Core::Box<RootPackage>& new_element) {
		if (m_context.is_nil ()) {
			add_root (new_element);
		} else {
			
		}
	}
	
	ViewPartParser::Context::reset_context () {
		m_context = 0;
	}
	
	Core::Box<RootPackage> ViewPartParser::Context::create_new_context (const std::string& key) {
		Core::Box<RootPackage> new_context = new RootPackage ();
		new_context-> (key);
		
		return new_context;
	}

	//helper functions
	namespace {
		typedef std::vector<unsigned long> AttributeIDList;
		typedef std::map<unsigned long, std::string> DescriptionMap;
		
		const std::string get_attribute_description (
			unsigned long attr_id
			, const DescriptionMap& description_map
		) {
			std::string res;
			DescriptionMap::const_iterator it = description_map.find (attr_id);
			if (it != description_map.end ()) {
				res = it->second;
			}
			
			return res;
		}
		
		unsigned long check_attribute_originality (
			unsigned long accumulated_flag
			, unsigned long attr_id
			, const antlr::RefToken& token
			, const DescriptionMap& description_map
		) /*throw (antlr::RecognitionException)*/
		{
			if (attr_id != 0 && accumulated_flag & attr_id) { //attr_id == 0 - it is container type, no exception
				std::string mess ("Attribute \"");
				mess += get_attribute_description (attr_id, description_map);
				mess += "\" already defined";
				
				throw antlr::RecognitionException (
					mess
					, token->getFilename ()
					, token->getLine ()
					, token->getColumn ()
				);
			} else {
				accumulated_flag |= attr_id;
			}
			return accumulated_flag;
		}
		
		void check_all_necessary_parsed (
			unsigned long accumulated_flag
			, const AttributeIDList& attr_ids
			, const DescriptionMap& description_map
			, const antlr::RefToken& token
		)
			/*throw (antlr::RecognitionException)*/
		{
			AttributeIDList::const_iterator it = attr_ids.begin ();
			AttributeIDList::const_iterator it_end = attr_ids.end ();
			
			std::string error_message ("Not all necessary attributes defined: ");
			bool not_all_defined = false;
			for (; it != it_end; ++it) {
				if ((accumulated_flag & *it) == false) {
					if (not_all_defined) {
						error_message += ", ";
					}
					error_message += get_attribute_description (*it, description_map);
					not_all_defined = true;
				}
			}
			
			if (not_all_defined) {
				throw antlr::RecognitionException (
					error_message
					, token->getFilename ()
					, token->getLine ()
					, token->getColumn ()
				);
			}
		}
	} //namespace

	void ViewPartParser::rule_begin () {
		this->reset_error_stack ();
	}
	
	void ViewPartParser::rule_end () {
		this->reset_error_stack ();
	}
}
class ViewPartParser extends Parser;
options {
	defaultErrorHandler=false;
}
{
public:
	class Context {
	public:
		Core::Box<RootPackage> find_context (const std::string& key) const;
		
		const std::vector<Core::Box<RootPackage> >& get_root_level () const;
		
		void on_namespace (const std::string& ns);
		
		//call by framework, when file parsed
		void on_new_element (Core::Box<RootPackage>& new_element);
		
		//call by framework, when start parse main part
		void reset_context ();
	private:
		Context ();
		
		void add_root (const Core::Box<RootPackage>& new_root);
		
		Core::Box<RootPackage> create_new_context (const std::string& key);
		
		friend class ACE_Unmanaged_Singleton <Context, ACE_SYNCH_RECURSIVE_MUTEX>;
		friend class ACE_Singleton <Context, ACE_SYNCH_RECURSIVE_MUTEX>;
	private:
		std::vector<Core::Box<RootPackage> > m_root_level;
		Core::Box<RootPackage> m_context;
	};
	
	typedef ACE_Unmanaged_Singleton <Context, ACE_SYNCH_RECURSIVE_MUTEX> ContextSingleton;

	public:
		void rule_begin ();
		
		void rule_end ();
}


root_package returns [Core::Box<RootPackage> root_package_ret]
	{
		root_package_ret = new RootPackage ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "namespaces"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "root"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		NamespaceList namespaces_;

	}
	:	{rule_begin ();}
		(flag=root_package_arbitrary_group_0[root_package_ret, namespaces_]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		root_package_group_1[root_package_ret]
		{
			root_package_ret->set_namespaces (namespaces_);
		}
		{
			root_package_ret->set_file_name (this->getFilename ());			rule_end ();
		}
	;

root_package_group_1
	[Core::Box<RootPackage>& root_package_ret]
	{
		Core::Box<PackageDef> root_;
	}
	
	:	{rule_begin ();}
		root_=package_def {root_package_ret->set_root (*root_);}
		{rule_end ();}
	;

root_package_arbitrary_group_0
	[
		Core::Box<RootPackage>& root_package_ret
		, NamespaceList& namespaces_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Namespace> namespaces_item;
	}
	
	:	{rule_begin ();}
		namespaces_item=namespace_ {type = 0; namespaces_.push_back (namespaces_item);}
		{rule_end ();}
	;



namespace_list returns [NamespaceList namespace_list_ret]
	{
		Core::Box<Namespace> item;
	}
	:	(item=namespace_
		{
			namespace_list_ret.push_back (item);
		}
		)+
	;

namespace_ returns [Core::Box<Namespace> namespace_ret]
	{
		namespace_ret = new Namespace ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "name"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"namespace"
		namespace__group_0[namespace_ret]
		";"
		{rule_end ();}
	;

namespace__group_0
	[Core::Box<Namespace>& namespace_ret]
	{
		std::string name_;
	}
	
	:	{rule_begin ();}
		name_=identifier {namespace_ret->set_name (name_);}
		{rule_end ();}
	;



package_def returns [Core::Box<PackageDef> package_def_ret]
	{
		package_def_ret = new PackageDef ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "class_diags"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "packages"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "classes"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		ClassDiagramList class_diags_;
		PackageDefList packages_;
		ClassDefList classes_;

	}
	:	{rule_begin ();}
		"package"
		package_def_group_0[package_def_ret]
		(flag=package_def_arbitrary_group_1[package_def_ret, class_diags_, packages_, classes_]
		{accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{
			package_def_ret->set_class_diags (class_diags_);
			package_def_ret->set_packages (packages_);
			package_def_ret->set_classes (classes_);
		}
		{rule_end ();}
	;

package_def_group_0
	[Core::Box<PackageDef>& package_def_ret]
	{
		std::string name_;
	}
	
	:	{rule_begin ();}
		name_=identifier {package_def_ret->set_name (name_);} "{"
		{rule_end ();}
	;

package_def_arbitrary_group_1
	[
		Core::Box<PackageDef>& package_def_ret
		, ClassDiagramList& class_diags_
		, PackageDefList& packages_
		, ClassDefList& classes_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<ClassDiagram> class_diags_item;
		Core::Box<PackageDef> packages_item;
		Core::Box<ClassDef> classes_item;
	}
	
	:	{rule_begin ();}
		(	class_diags_item=class_diagram {type = 0; class_diags_.push_back (class_diags_item);}
		|	packages_item=package_def {type = 0; packages_.push_back (packages_item);}
		|	classes_item=class_def {type = 0; classes_.push_back (classes_item);}
		)
		{rule_end ();}
	;



class_diagram_list returns [ClassDiagramList class_diagram_list_ret]
	{
		Core::Box<ClassDiagram> item;
	}
	:	(item=class_diagram
		{
			class_diagram_list_ret.push_back (item);
		}
		)+
	;

class_diagram returns [Core::Box<ClassDiagram> class_diagram_ret]
	{
		class_diagram_ret = new ClassDiagram ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "zoom"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "class_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "package_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "note_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 6, "inherit_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 7, "realize_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 8, "association_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 9, "class_diags"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 10, "sequence_diags"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 11, "state_diags"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 12, "dependencies"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		ClassViewList class_views_;
		PackageViewList package_views_;
		NoteViewList note_views_;
		InheritViewList inherit_views_;
		RealizeViewList realize_views_;
		AssociationViewList association_views_;
		ClassDiagramViewList class_diags_;
		SequenceDiagramViewList sequence_diags_;
		StateDiagramViewList state_diags_;
		DependencyViewList dependencies_;

	}
	:	{rule_begin ();}
		"class_diagram"
		class_diagram_group_0[class_diagram_ret]
		(flag=class_diagram_arbitrary_group_1[class_diagram_ret, class_views_, package_views_, note_views_, inherit_views_, realize_views_, association_views_, class_diags_, sequence_diags_, state_diags_, dependencies_]
		{accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{
			class_diagram_ret->set_class_views (class_views_);
			class_diagram_ret->set_package_views (package_views_);
			class_diagram_ret->set_note_views (note_views_);
			class_diagram_ret->set_inherit_views (inherit_views_);
			class_diagram_ret->set_realize_views (realize_views_);
			class_diagram_ret->set_association_views (association_views_);
			class_diagram_ret->set_class_diags (class_diags_);
			class_diagram_ret->set_sequence_diags (sequence_diags_);
			class_diagram_ret->set_state_diags (state_diags_);
			class_diagram_ret->set_dependencies (dependencies_);
		}
		{rule_end ();}
	;

class_diagram_group_0
	[Core::Box<ClassDiagram>& class_diagram_ret]
	{
		std::string name_;
	}
	
	:	{rule_begin ();}
		name_=identifier {class_diagram_ret->set_name (name_);} "{"
		{rule_end ();}
	;

class_diagram_arbitrary_group_1
	[
		Core::Box<ClassDiagram>& class_diagram_ret
		, ClassViewList& class_views_
		, PackageViewList& package_views_
		, NoteViewList& note_views_
		, InheritViewList& inherit_views_
		, RealizeViewList& realize_views_
		, AssociationViewList& association_views_
		, ClassDiagramViewList& class_diags_
		, SequenceDiagramViewList& sequence_diags_
		, StateDiagramViewList& state_diags_
		, DependencyViewList& dependencies_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<ClassView> class_views_item;
		Core::Box<PackageView> package_views_item;
		Core::Box<NoteView> note_views_item;
		Core::Box<InheritView> inherit_views_item;
		Core::Box<RealizeView> realize_views_item;
		Core::Box<AssociationView> association_views_item;
		Core::Box<ClassDiagramView> class_diags_item;
		Core::Box<SequenceDiagramView> sequence_diags_item;
		Core::Box<StateDiagramView> state_diags_item;
		Core::Box<DependencyView> dependencies_item;
	}
	
	:	{rule_begin ();}
		(	"zoom" "=" zoom_:SIGNED {type = 1 << 2; class_diagram_ret->set_zoom (boost::lexical_cast<int> (zoom_->getText ()));} ";"
		|	class_views_item=class_view {type = 0; class_views_.push_back (class_views_item);}
		|	package_views_item=package_view {type = 0; package_views_.push_back (package_views_item);}
		|	note_views_item=note_view {type = 0; note_views_.push_back (note_views_item);}
		|	inherit_views_item=inherit_view {type = 0; inherit_views_.push_back (inherit_views_item);}
		|	realize_views_item=realize_view {type = 0; realize_views_.push_back (realize_views_item);}
		|	association_views_item=association_view {type = 0; association_views_.push_back (association_views_item);}
		|	class_diags_item=class_diagram_view {type = 0; class_diags_.push_back (class_diags_item);}
		|	sequence_diags_item=sequence_diagram_view {type = 0; sequence_diags_.push_back (sequence_diags_item);}
		|	state_diags_item=state_diagram_view {type = 0; state_diags_.push_back (state_diags_item);}
		|	dependencies_item=dependency_view {type = 0; dependencies_.push_back (dependencies_item);}
		)
		{rule_end ();}
	;



class_view_list returns [ClassViewList class_view_list_ret]
	{
		Core::Box<ClassView> item;
	}
	:	(item=class_view
		{
			class_view_list_ret.push_back (item);
		}
		)+
	;

class_view returns [Core::Box<ClassView> class_view_ret]
	{
		class_view_ret = new ClassView ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long accumulated_flag_2 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "number"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "center_x"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "center_y"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"class_view"
		class_view_group_0[class_view_ret]
		class_view_group_1[class_view_ret]
		(flag=class_view_group_2[class_view_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}
		)+
		{
			AttributeIDList attr_ids;
			attr_ids.push_back (1 << 3);
			attr_ids.push_back (1 << 4);
			check_all_necessary_parsed (
				accumulated_flag_2
				, attr_ids
				, local::get_descriptions ()
				, LT (1)
			);
		}
		"}"
		{rule_end ();}
	;

class_view_group_0
	[Core::Box<ClassView>& class_view_ret]
	:	{rule_begin ();}
		number_:SIGNED {class_view_ret->set_number (boost::lexical_cast<int> (number_->getText ()));}
		{rule_end ();}
	;

class_view_group_1
	[Core::Box<ClassView>& class_view_ret]
	:	{rule_begin ();}
		guid_:STRING {class_view_ret->set_guid (guid_->getText ());} "{"
		{rule_end ();}
	;

class_view_group_2
	[Core::Box<ClassView>& class_view_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		(	("center_x" "=") => "center_x" "=" center_x_:SIGNED {type = 1 << 3; class_view_ret->set_center_x (boost::lexical_cast<int> (center_x_->getText ()));} ";"
		|	("center_y" "=") => "center_y" "=" center_y_:SIGNED {type = 1 << 4; class_view_ret->set_center_y (boost::lexical_cast<int> (center_y_->getText ()));} ";"
		)
		{rule_end ();}
	;



package_view_list returns [PackageViewList package_view_list_ret]
	{
		Core::Box<PackageView> item;
	}
	:	(item=package_view
		{
			package_view_list_ret.push_back (item);
		}
		)+
	;

package_view returns [Core::Box<PackageView> package_view_ret]
	{
		package_view_ret = new PackageView ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long accumulated_flag_2 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "number"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "center_x"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "center_y"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"package_view"
		package_view_group_0[package_view_ret]
		package_view_group_1[package_view_ret]
		(flag=package_view_group_2[package_view_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}
		)+
		{
			AttributeIDList attr_ids;
			attr_ids.push_back (1 << 3);
			attr_ids.push_back (1 << 4);
			check_all_necessary_parsed (
				accumulated_flag_2
				, attr_ids
				, local::get_descriptions ()
				, LT (1)
			);
		}
		"}"
		{rule_end ();}
	;

package_view_group_0
	[Core::Box<PackageView>& package_view_ret]
	:	{rule_begin ();}
		number_:SIGNED {package_view_ret->set_number (boost::lexical_cast<int> (number_->getText ()));}
		{rule_end ();}
	;

package_view_group_1
	[Core::Box<PackageView>& package_view_ret]
	:	{rule_begin ();}
		guid_:STRING {package_view_ret->set_guid (guid_->getText ());} "{"
		{rule_end ();}
	;

package_view_group_2
	[Core::Box<PackageView>& package_view_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		(	("center_x" "=") => "center_x" "=" center_x_:SIGNED {type = 1 << 3; package_view_ret->set_center_x (boost::lexical_cast<int> (center_x_->getText ()));} ";"
		|	("center_y" "=") => "center_y" "=" center_y_:SIGNED {type = 1 << 4; package_view_ret->set_center_y (boost::lexical_cast<int> (center_y_->getText ()));} ";"
		)
		{rule_end ();}
	;



note_view_list returns [NoteViewList note_view_list_ret]
	{
		Core::Box<NoteView> item;
	}
	:	(item=note_view
		{
			note_view_list_ret.push_back (item);
		}
		)+
	;

note_view returns [Core::Box<NoteView> note_view_ret]
	{
		note_view_ret = new NoteView ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long accumulated_flag_2 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "number"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "associated_view_number"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "center_x"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "center_y"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "text"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"note_view"
		note_view_group_0[note_view_ret]
		note_view_group_1[note_view_ret]
		(flag=note_view_arbitrary_group_2[note_view_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		(flag=note_view_group_2[note_view_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}
		)+
		{
			AttributeIDList attr_ids;
			attr_ids.push_back (1 << 3);
			attr_ids.push_back (1 << 4);
			check_all_necessary_parsed (
				accumulated_flag_2
				, attr_ids
				, local::get_descriptions ()
				, LT (1)
			);
		}

		(flag=note_view_arbitrary_group_2[note_view_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{rule_end ();}
	;

note_view_group_0
	[Core::Box<NoteView>& note_view_ret]
	:	{rule_begin ();}
		number_:SIGNED {note_view_ret->set_number (boost::lexical_cast<int> (number_->getText ()));}
		{rule_end ();}
	;

note_view_group_1
	[Core::Box<NoteView>& note_view_ret]
	:	{rule_begin ();}
		associated_view_number_:SIGNED {note_view_ret->set_associated_view_number (boost::lexical_cast<int> (associated_view_number_->getText ()));} "{"
		{rule_end ();}
	;

note_view_group_2
	[Core::Box<NoteView>& note_view_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		(	("center_x" "=") => "center_x" "=" center_x_:SIGNED {type = 1 << 3; note_view_ret->set_center_x (boost::lexical_cast<int> (center_x_->getText ()));} ";"
		|	("center_y" "=") => "center_y" "=" center_y_:SIGNED {type = 1 << 4; note_view_ret->set_center_y (boost::lexical_cast<int> (center_y_->getText ()));} ";"
		)
		{rule_end ();}
	;

note_view_arbitrary_group_2
	[Core::Box<NoteView>& note_view_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		"text" "=" text_:STRING {type = 1 << 5; note_view_ret->set_text (text_->getText ());} ";"
		{rule_end ();}
	;



inherit_view_list returns [InheritViewList inherit_view_list_ret]
	{
		Core::Box<InheritView> item;
	}
	:	(item=inherit_view
		{
			inherit_view_list_ret.push_back (item);
		}
		)+
	;

inherit_view returns [Core::Box<InheritView> inherit_view_ret]
	{
		inherit_view_ret = new InheritView ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "number"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "client"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "supplier"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "points"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		PointList points_;

	}
	:	{rule_begin ();}
		"inherit_view"
		inherit_view_group_0[inherit_view_ret]
		(flag=inherit_view_group_1[inherit_view_ret, points_]
		{accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());}
		)+
		{
			AttributeIDList attr_ids;
			attr_ids.push_back (1 << 2);
			attr_ids.push_back (1 << 3);
			attr_ids.push_back (1 << 4);
			check_all_necessary_parsed (
				accumulated_flag_1
				, attr_ids
				, local::get_descriptions ()
				, LT (1)
			);
		}
		"}"
		{
			inherit_view_ret->set_points (points_);
		}
		{rule_end ();}
	;

inherit_view_group_0
	[Core::Box<InheritView>& inherit_view_ret]
	:	{rule_begin ();}
		number_:SIGNED {inherit_view_ret->set_number (boost::lexical_cast<int> (number_->getText ()));} "{"
		{rule_end ();}
	;

inherit_view_group_1
	[
		Core::Box<InheritView>& inherit_view_ret
		, PointList& points_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Point> points_item;
	}
	
	:	{rule_begin ();}
		(	"client" client_:SIGNED {type = 1 << 2; inherit_view_ret->set_client (boost::lexical_cast<int> (client_->getText ()));} ";"
		|	"supplier" supplier_:SIGNED {type = 1 << 3; inherit_view_ret->set_supplier (boost::lexical_cast<int> (supplier_->getText ()));} ";"
		|	"points" "=" points_item=point {type = 1 << 4; points_.push_back (points_item);} ("," points_item=point {type = 1 << 4; points_.push_back (points_item);})* ";"
		)
		{rule_end ();}
	;



point_list returns [PointList point_list_ret]
	{
		Core::Box<Point> item;
	}
	:	(item=point
		{
			point_list_ret.push_back (item);
		}
		)+
	;

point returns [Core::Box<Point> point_ret]
	{
		point_ret = new Point ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "x"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "y"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"("
		point_group_0[point_ret]
		point_group_1[point_ret]
		")"
		{rule_end ();}
	;

point_group_0
	[Core::Box<Point>& point_ret]
	:	{rule_begin ();}
		x_:SIGNED {point_ret->set_x (boost::lexical_cast<int> (x_->getText ()));} ","
		{rule_end ();}
	;

point_group_1
	[Core::Box<Point>& point_ret]
	:	{rule_begin ();}
		y_:SIGNED {point_ret->set_y (boost::lexical_cast<int> (y_->getText ()));}
		{rule_end ();}
	;



realize_view_list returns [RealizeViewList realize_view_list_ret]
	{
		Core::Box<RealizeView> item;
	}
	:	(item=realize_view
		{
			realize_view_list_ret.push_back (item);
		}
		)+
	;

realize_view returns [Core::Box<RealizeView> realize_view_ret]
	{
		realize_view_ret = new RealizeView ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "number"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "client"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "supplier"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "points"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		PointList points_;

	}
	:	{rule_begin ();}
		"realize_view"
		realize_view_group_0[realize_view_ret]
		(flag=realize_view_group_1[realize_view_ret, points_]
		{accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());}
		)+
		{
			AttributeIDList attr_ids;
			attr_ids.push_back (1 << 2);
			attr_ids.push_back (1 << 3);
			attr_ids.push_back (1 << 4);
			check_all_necessary_parsed (
				accumulated_flag_1
				, attr_ids
				, local::get_descriptions ()
				, LT (1)
			);
		}
		"}"
		{
			realize_view_ret->set_points (points_);
		}
		{rule_end ();}
	;

realize_view_group_0
	[Core::Box<RealizeView>& realize_view_ret]
	:	{rule_begin ();}
		number_:SIGNED {realize_view_ret->set_number (boost::lexical_cast<int> (number_->getText ()));} "{"
		{rule_end ();}
	;

realize_view_group_1
	[
		Core::Box<RealizeView>& realize_view_ret
		, PointList& points_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Point> points_item;
	}
	
	:	{rule_begin ();}
		(	"client" client_:SIGNED {type = 1 << 2; realize_view_ret->set_client (boost::lexical_cast<int> (client_->getText ()));} ";"
		|	"supplier" supplier_:SIGNED {type = 1 << 3; realize_view_ret->set_supplier (boost::lexical_cast<int> (supplier_->getText ()));} ";"
		|	"points" "=" points_item=point {type = 1 << 4; points_.push_back (points_item);} ("," points_item=point {type = 1 << 4; points_.push_back (points_item);})* ";"
		)
		{rule_end ();}
	;



association_view_list returns [AssociationViewList association_view_list_ret]
	{
		Core::Box<AssociationView> item;
	}
	:	(item=association_view
		{
			association_view_list_ret.push_back (item);
		}
		)+
	;

association_view returns [Core::Box<AssociationView> association_view_ret]
	{
		association_view_ret = new AssociationView ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long accumulated_flag_2 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "number"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "client"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "supplier"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "points"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 6, "name_view"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 7, "stereotype_view"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		PointList points_;

	}
	:	{rule_begin ();}
		"association_view"
		association_view_group_0[association_view_ret]
		association_view_group_1[association_view_ret]
		(flag=association_view_arbitrary_group_2[association_view_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		(flag=association_view_group_2[association_view_ret, points_]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}
		)+
		{
			AttributeIDList attr_ids;
			attr_ids.push_back (1 << 3);
			attr_ids.push_back (1 << 4);
			attr_ids.push_back (1 << 5);
			check_all_necessary_parsed (
				accumulated_flag_2
				, attr_ids
				, local::get_descriptions ()
				, LT (1)
			);
		}

		(flag=association_view_arbitrary_group_2[association_view_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{
			association_view_ret->set_points (points_);
		}
		{rule_end ();}
	;

association_view_group_0
	[Core::Box<AssociationView>& association_view_ret]
	:	{rule_begin ();}
		number_:SIGNED {association_view_ret->set_number (boost::lexical_cast<int> (number_->getText ()));}
		{rule_end ();}
	;

association_view_group_1
	[Core::Box<AssociationView>& association_view_ret]
	:	{rule_begin ();}
		guid_:STRING {association_view_ret->set_guid (guid_->getText ());} "{"
		{rule_end ();}
	;

association_view_group_2
	[
		Core::Box<AssociationView>& association_view_ret
		, PointList& points_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Point> points_item;
	}
	
	:	{rule_begin ();}
		(	"client" client_:SIGNED {type = 1 << 3; association_view_ret->set_client (boost::lexical_cast<int> (client_->getText ()));} ";"
		|	"supplier" supplier_:SIGNED {type = 1 << 4; association_view_ret->set_supplier (boost::lexical_cast<int> (supplier_->getText ()));} ";"
		|	"points" "=" points_item=point {type = 1 << 5; points_.push_back (points_item);} ("," points_item=point {type = 1 << 5; points_.push_back (points_item);})* ";"
		)
		{rule_end ();}
	;

association_view_arbitrary_group_2
	[Core::Box<AssociationView>& association_view_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<NameView> name_view_;
		Core::Box<StereotypeView> stereotype_view_;
	}
	
	:	{rule_begin ();}
		(	name_view_=name_view {type = 1 << 6; association_view_ret->set_name_view (name_view_);}
		|	stereotype_view_=stereotype_view {type = 1 << 7; association_view_ret->set_stereotype_view (stereotype_view_);}
		)
		{rule_end ();}
	;



name_view returns [Core::Box<NameView> name_view_ret]
	{
		name_view_ret = new NameView ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "center_x"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "center_y"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"name_view" "{"
		(flag=name_view_group_0[name_view_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}
		)+
		{
			AttributeIDList attr_ids;
			attr_ids.push_back (1 << 1);
			attr_ids.push_back (1 << 2);
			check_all_necessary_parsed (
				accumulated_flag_0
				, attr_ids
				, local::get_descriptions ()
				, LT (1)
			);
		}
		"}"
		{rule_end ();}
	;

name_view_group_0
	[Core::Box<NameView>& name_view_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		(	("center_x" "=") => "center_x" "=" center_x_:SIGNED {type = 1 << 1; name_view_ret->set_center_x (boost::lexical_cast<int> (center_x_->getText ()));} ";"
		|	("center_y" "=") => "center_y" "=" center_y_:SIGNED {type = 1 << 2; name_view_ret->set_center_y (boost::lexical_cast<int> (center_y_->getText ()));} ";"
		)
		{rule_end ();}
	;



stereotype_view returns [Core::Box<StereotypeView> stereotype_view_ret]
	{
		stereotype_view_ret = new StereotypeView ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "center_x"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "center_y"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"stereotype_view" "{"
		(flag=stereotype_view_group_0[stereotype_view_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}
		)+
		{
			AttributeIDList attr_ids;
			attr_ids.push_back (1 << 1);
			attr_ids.push_back (1 << 2);
			check_all_necessary_parsed (
				accumulated_flag_0
				, attr_ids
				, local::get_descriptions ()
				, LT (1)
			);
		}
		"}"
		{rule_end ();}
	;

stereotype_view_group_0
	[Core::Box<StereotypeView>& stereotype_view_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		(	("center_x" "=") => "center_x" "=" center_x_:SIGNED {type = 1 << 1; stereotype_view_ret->set_center_x (boost::lexical_cast<int> (center_x_->getText ()));} ";"
		|	("center_y" "=") => "center_y" "=" center_y_:SIGNED {type = 1 << 2; stereotype_view_ret->set_center_y (boost::lexical_cast<int> (center_y_->getText ()));} ";"
		)
		{rule_end ();}
	;



class_diagram_view_list returns [ClassDiagramViewList class_diagram_view_list_ret]
	{
		Core::Box<ClassDiagramView> item;
	}
	:	(item=class_diagram_view
		{
			class_diagram_view_list_ret.push_back (item);
		}
		)+
	;

class_diagram_view returns [Core::Box<ClassDiagramView> class_diagram_view_ret]
	{
		class_diagram_view_ret = new ClassDiagramView ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long accumulated_flag_2 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "number"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "center_x"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "center_y"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"class_diagram_view"
		class_diagram_view_group_0[class_diagram_view_ret]
		class_diagram_view_group_1[class_diagram_view_ret]
		(flag=class_diagram_view_group_2[class_diagram_view_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}
		)+
		{
			AttributeIDList attr_ids;
			attr_ids.push_back (1 << 3);
			attr_ids.push_back (1 << 4);
			check_all_necessary_parsed (
				accumulated_flag_2
				, attr_ids
				, local::get_descriptions ()
				, LT (1)
			);
		}
		"}"
		{rule_end ();}
	;

class_diagram_view_group_0
	[Core::Box<ClassDiagramView>& class_diagram_view_ret]
	:	{rule_begin ();}
		number_:SIGNED {class_diagram_view_ret->set_number (boost::lexical_cast<int> (number_->getText ()));}
		{rule_end ();}
	;

class_diagram_view_group_1
	[Core::Box<ClassDiagramView>& class_diagram_view_ret]
	:	{rule_begin ();}
		guid_:STRING {class_diagram_view_ret->set_guid (guid_->getText ());} "{"
		{rule_end ();}
	;

class_diagram_view_group_2
	[Core::Box<ClassDiagramView>& class_diagram_view_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		(	("center_x" "=") => "center_x" "=" center_x_:SIGNED {type = 1 << 3; class_diagram_view_ret->set_center_x (boost::lexical_cast<int> (center_x_->getText ()));} ";"
		|	("center_y" "=") => "center_y" "=" center_y_:SIGNED {type = 1 << 4; class_diagram_view_ret->set_center_y (boost::lexical_cast<int> (center_y_->getText ()));} ";"
		)
		{rule_end ();}
	;



sequence_diagram_view_list returns [SequenceDiagramViewList sequence_diagram_view_list_ret]
	{
		Core::Box<SequenceDiagramView> item;
	}
	:	(item=sequence_diagram_view
		{
			sequence_diagram_view_list_ret.push_back (item);
		}
		)+
	;

sequence_diagram_view returns [Core::Box<SequenceDiagramView> sequence_diagram_view_ret]
	{
		sequence_diagram_view_ret = new SequenceDiagramView ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long accumulated_flag_2 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "number"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "center_x"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "center_y"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"sequence_diagram_view"
		sequence_diagram_view_group_0[sequence_diagram_view_ret]
		sequence_diagram_view_group_1[sequence_diagram_view_ret]
		(flag=sequence_diagram_view_group_2[sequence_diagram_view_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}
		)+
		{
			AttributeIDList attr_ids;
			attr_ids.push_back (1 << 3);
			attr_ids.push_back (1 << 4);
			check_all_necessary_parsed (
				accumulated_flag_2
				, attr_ids
				, local::get_descriptions ()
				, LT (1)
			);
		}
		"}"
		{rule_end ();}
	;

sequence_diagram_view_group_0
	[Core::Box<SequenceDiagramView>& sequence_diagram_view_ret]
	:	{rule_begin ();}
		number_:SIGNED {sequence_diagram_view_ret->set_number (boost::lexical_cast<int> (number_->getText ()));}
		{rule_end ();}
	;

sequence_diagram_view_group_1
	[Core::Box<SequenceDiagramView>& sequence_diagram_view_ret]
	:	{rule_begin ();}
		guid_:STRING {sequence_diagram_view_ret->set_guid (guid_->getText ());} "{"
		{rule_end ();}
	;

sequence_diagram_view_group_2
	[Core::Box<SequenceDiagramView>& sequence_diagram_view_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		(	("center_x") => "center_x" center_x_:SIGNED {type = 1 << 3; sequence_diagram_view_ret->set_center_x (boost::lexical_cast<int> (center_x_->getText ()));} ";"
		|	("center_y") => "center_y" center_y_:SIGNED {type = 1 << 4; sequence_diagram_view_ret->set_center_y (boost::lexical_cast<int> (center_y_->getText ()));} ";"
		)
		{rule_end ();}
	;



state_diagram_view_list returns [StateDiagramViewList state_diagram_view_list_ret]
	{
		Core::Box<StateDiagramView> item;
	}
	:	(item=state_diagram_view
		{
			state_diagram_view_list_ret.push_back (item);
		}
		)+
	;

state_diagram_view returns [Core::Box<StateDiagramView> state_diagram_view_ret]
	{
		state_diagram_view_ret = new StateDiagramView ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long accumulated_flag_2 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "number"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "center_x"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "center_y"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"state_diagram_view"
		state_diagram_view_group_0[state_diagram_view_ret]
		state_diagram_view_group_1[state_diagram_view_ret]
		(flag=state_diagram_view_group_2[state_diagram_view_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}
		)+
		{
			AttributeIDList attr_ids;
			attr_ids.push_back (1 << 3);
			attr_ids.push_back (1 << 4);
			check_all_necessary_parsed (
				accumulated_flag_2
				, attr_ids
				, local::get_descriptions ()
				, LT (1)
			);
		}
		"}"
		{rule_end ();}
	;

state_diagram_view_group_0
	[Core::Box<StateDiagramView>& state_diagram_view_ret]
	:	{rule_begin ();}
		number_:SIGNED {state_diagram_view_ret->set_number (boost::lexical_cast<int> (number_->getText ()));}
		{rule_end ();}
	;

state_diagram_view_group_1
	[Core::Box<StateDiagramView>& state_diagram_view_ret]
	:	{rule_begin ();}
		guid_:STRING {state_diagram_view_ret->set_guid (guid_->getText ());} "{"
		{rule_end ();}
	;

state_diagram_view_group_2
	[Core::Box<StateDiagramView>& state_diagram_view_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		(	("center_x" "=") => "center_x" "=" center_x_:SIGNED {type = 1 << 3; state_diagram_view_ret->set_center_x (boost::lexical_cast<int> (center_x_->getText ()));} ";"
		|	("center_y" "=") => "center_y" "=" center_y_:SIGNED {type = 1 << 4; state_diagram_view_ret->set_center_y (boost::lexical_cast<int> (center_y_->getText ()));} ";"
		)
		{rule_end ();}
	;



dependency_view_list returns [DependencyViewList dependency_view_list_ret]
	{
		Core::Box<DependencyView> item;
	}
	:	(item=dependency_view
		{
			dependency_view_list_ret.push_back (item);
		}
		)+
	;

dependency_view returns [Core::Box<DependencyView> dependency_view_ret]
	{
		dependency_view_ret = new DependencyView ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long accumulated_flag_2 = 0;
		unsigned long accumulated_flag_3 = 0;
		unsigned long accumulated_flag_4 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "number"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "client"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "supplier"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "points"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 6, "stereotype_view"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		PointList points_;

	}
	:	{rule_begin ();}
		"dependency_view"
		dependency_view_group_0[dependency_view_ret]
		dependency_view_group_1[dependency_view_ret]
		dependency_view_group_2[dependency_view_ret]
		dependency_view_group_3[dependency_view_ret]
		(flag=dependency_view_arbitrary_group_4[dependency_view_ret]
		{accumulated_flag_4 = check_attribute_originality (accumulated_flag_4, flag, LT (1), local::get_descriptions ());}

		)*
		dependency_view_group_4[dependency_view_ret, points_]

		(flag=dependency_view_arbitrary_group_4[dependency_view_ret]
		{accumulated_flag_4 = check_attribute_originality (accumulated_flag_4, flag, LT (1), local::get_descriptions ());}

		)*
		"}" ";"
		{
			dependency_view_ret->set_points (points_);
		}
		{rule_end ();}
	;

dependency_view_group_0
	[Core::Box<DependencyView>& dependency_view_ret]
	:	{rule_begin ();}
		number_:SIGNED {dependency_view_ret->set_number (boost::lexical_cast<int> (number_->getText ()));}
		{rule_end ();}
	;

dependency_view_group_1
	[Core::Box<DependencyView>& dependency_view_ret]
	:	{rule_begin ();}
		guid_:STRING {dependency_view_ret->set_guid (guid_->getText ());} "{"
		{rule_end ();}
	;

dependency_view_group_2
	[Core::Box<DependencyView>& dependency_view_ret]
	:	{rule_begin ();}
		client_:SIGNED {dependency_view_ret->set_client (boost::lexical_cast<int> (client_->getText ()));} ";"
		{rule_end ();}
	;

dependency_view_group_3
	[Core::Box<DependencyView>& dependency_view_ret]
	:	{rule_begin ();}
		supplier_:SIGNED {dependency_view_ret->set_supplier (boost::lexical_cast<int> (supplier_->getText ()));} ";"
		{rule_end ();}
	;

dependency_view_group_4
	[
		Core::Box<DependencyView>& dependency_view_ret
		, PointList& points_
	]
	{
		Core::Box<Point> points_item;
	}
	
	:	{rule_begin ();}
		"points" "=" points_item=point {points_.push_back (points_item);} ("," points_item=point {points_.push_back (points_item);})* ";"
		{rule_end ();}
	;

dependency_view_arbitrary_group_4
	[Core::Box<DependencyView>& dependency_view_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<StereotypeView> stereotype_view_;
	}
	
	:	{rule_begin ();}
		stereotype_view_=stereotype_view {type = 1 << 6; dependency_view_ret->set_stereotype_view (stereotype_view_);}
		{rule_end ();}
	;



package_def_list returns [PackageDefList package_def_list_ret]
	{
		Core::Box<PackageDef> item;
	}
	:	(item=package_def
		{
			package_def_list_ret.push_back (item);
		}
		)+
	;

class_def_list returns [ClassDefList class_def_list_ret]
	{
		Core::Box<ClassDef> item;
	}
	:	(item=class_def
		{
			class_def_list_ret.push_back (item);
		}
		)+
	;

class_def returns [Core::Box<ClassDef> class_def_ret]
	{
		class_def_ret = new ClassDef ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "classes"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "class_diags"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "sequence_diags"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "state_diags"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		ClassDefList classes_;
		ClassDiagramList class_diags_;
		SequenceDiagramList sequence_diags_;
		StateDiagramList state_diags_;

	}
	:	{rule_begin ();}
		"class"
		class_def_group_0[class_def_ret]
		(flag=class_def_arbitrary_group_1[class_def_ret, classes_, class_diags_, sequence_diags_, state_diags_]
		{accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{
			class_def_ret->set_classes (classes_);
			class_def_ret->set_class_diags (class_diags_);
			class_def_ret->set_sequence_diags (sequence_diags_);
			class_def_ret->set_state_diags (state_diags_);
		}
		{rule_end ();}
	;

class_def_group_0
	[Core::Box<ClassDef>& class_def_ret]
	{
		std::string name_;
	}
	
	:	{rule_begin ();}
		name_=identifier {class_def_ret->set_name (name_);} "{"
		{rule_end ();}
	;

class_def_arbitrary_group_1
	[
		Core::Box<ClassDef>& class_def_ret
		, ClassDefList& classes_
		, ClassDiagramList& class_diags_
		, SequenceDiagramList& sequence_diags_
		, StateDiagramList& state_diags_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<ClassDef> classes_item;
		Core::Box<ClassDiagram> class_diags_item;
		Core::Box<SequenceDiagram> sequence_diags_item;
		Core::Box<StateDiagram> state_diags_item;
	}
	
	:	{rule_begin ();}
		(	classes_item=class_def {type = 0; classes_.push_back (classes_item);}
		|	class_diags_item=class_diagram {type = 0; class_diags_.push_back (class_diags_item);}
		|	sequence_diags_item=sequence_diagram {type = 0; sequence_diags_.push_back (sequence_diags_item);}
		|	state_diags_item=state_diagram {type = 0; state_diags_.push_back (state_diags_item);}
		)
		{rule_end ();}
	;



sequence_diagram_list returns [SequenceDiagramList sequence_diagram_list_ret]
	{
		Core::Box<SequenceDiagram> item;
	}
	:	(item=sequence_diagram
		{
			sequence_diagram_list_ret.push_back (item);
		}
		)+
	;

sequence_diagram returns [Core::Box<SequenceDiagram> sequence_diagram_ret]
	{
		sequence_diagram_ret = new SequenceDiagram ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "zoom"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "object_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "message_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "self_message_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 6, "return_message_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 7, "note_views"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		ObjectViewList object_views_;
		MessageViewList message_views_;
		SelfMessageViewList self_message_views_;
		ReturnMessageViewList return_message_views_;
		NoteViewList note_views_;

	}
	:	{rule_begin ();}
		"sequence_diagram"
		sequence_diagram_group_0[sequence_diagram_ret]
		(flag=sequence_diagram_arbitrary_group_1[sequence_diagram_ret, object_views_, message_views_, self_message_views_, return_message_views_, note_views_]
		{accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{
			sequence_diagram_ret->set_object_views (object_views_);
			sequence_diagram_ret->set_message_views (message_views_);
			sequence_diagram_ret->set_self_message_views (self_message_views_);
			sequence_diagram_ret->set_return_message_views (return_message_views_);
			sequence_diagram_ret->set_note_views (note_views_);
		}
		{rule_end ();}
	;

sequence_diagram_group_0
	[Core::Box<SequenceDiagram>& sequence_diagram_ret]
	{
		std::string name_;
	}
	
	:	{rule_begin ();}
		name_=identifier {sequence_diagram_ret->set_name (name_);} "{"
		{rule_end ();}
	;

sequence_diagram_arbitrary_group_1
	[
		Core::Box<SequenceDiagram>& sequence_diagram_ret
		, ObjectViewList& object_views_
		, MessageViewList& message_views_
		, SelfMessageViewList& self_message_views_
		, ReturnMessageViewList& return_message_views_
		, NoteViewList& note_views_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<ObjectView> object_views_item;
		Core::Box<MessageView> message_views_item;
		Core::Box<SelfMessageView> self_message_views_item;
		Core::Box<ReturnMessageView> return_message_views_item;
		Core::Box<NoteView> note_views_item;
	}
	
	:	{rule_begin ();}
		(	"zoom" "=" zoom_:SIGNED {type = 1 << 2; sequence_diagram_ret->set_zoom (boost::lexical_cast<int> (zoom_->getText ()));} ";"
		|	object_views_item=object_view {type = 0; object_views_.push_back (object_views_item);}
		|	message_views_item=message_view {type = 0; message_views_.push_back (message_views_item);}
		|	self_message_views_item=self_message_view {type = 0; self_message_views_.push_back (self_message_views_item);}
		|	return_message_views_item=return_message_view {type = 0; return_message_views_.push_back (return_message_views_item);}
		|	note_views_item=note_view {type = 0; note_views_.push_back (note_views_item);}
		)
		{rule_end ();}
	;



object_view_list returns [ObjectViewList object_view_list_ret]
	{
		Core::Box<ObjectView> item;
	}
	:	(item=object_view
		{
			object_view_list_ret.push_back (item);
		}
		)+
	;

object_view returns [Core::Box<ObjectView> object_view_ret]
	{
		object_view_ret = new ObjectView ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long accumulated_flag_2 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "number"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "center_x"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "center_y"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "name"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"object_view"
		object_view_group_0[object_view_ret]
		object_view_group_1[object_view_ret]
		(flag=object_view_arbitrary_group_2[object_view_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		(flag=object_view_group_2[object_view_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}
		)+
		{
			AttributeIDList attr_ids;
			attr_ids.push_back (1 << 3);
			attr_ids.push_back (1 << 4);
			check_all_necessary_parsed (
				accumulated_flag_2
				, attr_ids
				, local::get_descriptions ()
				, LT (1)
			);
		}

		(flag=object_view_arbitrary_group_2[object_view_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{rule_end ();}
	;

object_view_group_0
	[Core::Box<ObjectView>& object_view_ret]
	:	{rule_begin ();}
		number_:SIGNED {object_view_ret->set_number (boost::lexical_cast<int> (number_->getText ()));}
		{rule_end ();}
	;

object_view_group_1
	[Core::Box<ObjectView>& object_view_ret]
	:	{rule_begin ();}
		guid_:STRING {object_view_ret->set_guid (guid_->getText ());} "{"
		{rule_end ();}
	;

object_view_group_2
	[Core::Box<ObjectView>& object_view_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		(	("center_x" "=") => "center_x" "=" center_x_:SIGNED {type = 1 << 3; object_view_ret->set_center_x (boost::lexical_cast<int> (center_x_->getText ()));} ";"
		|	("center_y" "=") => "center_y" "=" center_y_:SIGNED {type = 1 << 4; object_view_ret->set_center_y (boost::lexical_cast<int> (center_y_->getText ()));} ";"
		)
		{rule_end ();}
	;

object_view_arbitrary_group_2
	[Core::Box<ObjectView>& object_view_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		"name" "=" name_:STRING {type = 1 << 5; object_view_ret->set_name (name_->getText ());} ";"
		{rule_end ();}
	;



message_view_list returns [MessageViewList message_view_list_ret]
	{
		Core::Box<MessageView> item;
	}
	:	(item=message_view
		{
			message_view_list_ret.push_back (item);
		}
		)+
	;

message_view returns [Core::Box<MessageView> message_view_ret]
	{
		message_view_ret = new MessageView ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long accumulated_flag_2 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "number"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "client"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "supplier"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "start_y"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"message_view"
		message_view_group_0[message_view_ret]
		message_view_group_1[message_view_ret]
		(flag=message_view_group_2[message_view_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}
		)+
		{
			AttributeIDList attr_ids;
			attr_ids.push_back (1 << 3);
			attr_ids.push_back (1 << 4);
			attr_ids.push_back (1 << 5);
			check_all_necessary_parsed (
				accumulated_flag_2
				, attr_ids
				, local::get_descriptions ()
				, LT (1)
			);
		}
		"}"
		{rule_end ();}
	;

message_view_group_0
	[Core::Box<MessageView>& message_view_ret]
	:	{rule_begin ();}
		number_:SIGNED {message_view_ret->set_number (boost::lexical_cast<int> (number_->getText ()));}
		{rule_end ();}
	;

message_view_group_1
	[Core::Box<MessageView>& message_view_ret]
	:	{rule_begin ();}
		guid_:STRING {message_view_ret->set_guid (guid_->getText ());} "{"
		{rule_end ();}
	;

message_view_group_2
	[Core::Box<MessageView>& message_view_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		(	"client" client_:SIGNED {type = 1 << 3; message_view_ret->set_client (boost::lexical_cast<int> (client_->getText ()));} ";"
		|	"supplier" supplier_:SIGNED {type = 1 << 4; message_view_ret->set_supplier (boost::lexical_cast<int> (supplier_->getText ()));} ";"
		|	"start_y" "=" start_y_:SIGNED {type = 1 << 5; message_view_ret->set_start_y (boost::lexical_cast<int> (start_y_->getText ()));} ";"
		)
		{rule_end ();}
	;



self_message_view_list returns [SelfMessageViewList self_message_view_list_ret]
	{
		Core::Box<SelfMessageView> item;
	}
	:	(item=self_message_view
		{
			self_message_view_list_ret.push_back (item);
		}
		)+
	;

self_message_view returns [Core::Box<SelfMessageView> self_message_view_ret]
	{
		self_message_view_ret = new SelfMessageView ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long accumulated_flag_2 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "number"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "start_y"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"self_message_view"
		self_message_view_group_0[self_message_view_ret]
		self_message_view_group_1[self_message_view_ret]
		self_message_view_group_2[self_message_view_ret]
		"}"
		{rule_end ();}
	;

self_message_view_group_0
	[Core::Box<SelfMessageView>& self_message_view_ret]
	:	{rule_begin ();}
		number_:SIGNED {self_message_view_ret->set_number (boost::lexical_cast<int> (number_->getText ()));}
		{rule_end ();}
	;

self_message_view_group_1
	[Core::Box<SelfMessageView>& self_message_view_ret]
	:	{rule_begin ();}
		guid_:STRING {self_message_view_ret->set_guid (guid_->getText ());} "{"
		{rule_end ();}
	;

self_message_view_group_2
	[Core::Box<SelfMessageView>& self_message_view_ret]
	:	{rule_begin ();}
		"start_y" "=" start_y_:SIGNED {self_message_view_ret->set_start_y (boost::lexical_cast<int> (start_y_->getText ()));} ";"
		{rule_end ();}
	;



return_message_view_list returns [ReturnMessageViewList return_message_view_list_ret]
	{
		Core::Box<ReturnMessageView> item;
	}
	:	(item=return_message_view
		{
			return_message_view_list_ret.push_back (item);
		}
		)+
	;

return_message_view returns [Core::Box<ReturnMessageView> return_message_view_ret]
	{
		return_message_view_ret = new ReturnMessageView ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long accumulated_flag_2 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "number"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "client"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "supplier"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "start_y"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"return_message_view"
		return_message_view_group_0[return_message_view_ret]
		return_message_view_group_1[return_message_view_ret]
		(flag=return_message_view_group_2[return_message_view_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}
		)+
		{
			AttributeIDList attr_ids;
			attr_ids.push_back (1 << 3);
			attr_ids.push_back (1 << 4);
			attr_ids.push_back (1 << 5);
			check_all_necessary_parsed (
				accumulated_flag_2
				, attr_ids
				, local::get_descriptions ()
				, LT (1)
			);
		}
		"}"
		{rule_end ();}
	;

return_message_view_group_0
	[Core::Box<ReturnMessageView>& return_message_view_ret]
	:	{rule_begin ();}
		number_:SIGNED {return_message_view_ret->set_number (boost::lexical_cast<int> (number_->getText ()));}
		{rule_end ();}
	;

return_message_view_group_1
	[Core::Box<ReturnMessageView>& return_message_view_ret]
	:	{rule_begin ();}
		guid_:STRING {return_message_view_ret->set_guid (guid_->getText ());} "{"
		{rule_end ();}
	;

return_message_view_group_2
	[Core::Box<ReturnMessageView>& return_message_view_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		(	"client" client_:SIGNED {type = 1 << 3; return_message_view_ret->set_client (boost::lexical_cast<int> (client_->getText ()));} ";"
		|	"supplier" supplier_:SIGNED {type = 1 << 4; return_message_view_ret->set_supplier (boost::lexical_cast<int> (supplier_->getText ()));} ";"
		|	"start_y" "=" start_y_:SIGNED {type = 1 << 5; return_message_view_ret->set_start_y (boost::lexical_cast<int> (start_y_->getText ()));} ";"
		)
		{rule_end ();}
	;



state_diagram_list returns [StateDiagramList state_diagram_list_ret]
	{
		Core::Box<StateDiagram> item;
	}
	:	(item=state_diagram
		{
			state_diagram_list_ret.push_back (item);
		}
		)+
	;

state_diagram returns [Core::Box<StateDiagram> state_diagram_ret]
	{
		state_diagram_ret = new StateDiagram ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "state_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "transition_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "note_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "zoom"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		StateViewList state_views_;
		TransitionViewList transition_views_;
		NoteViewList note_views_;

	}
	:	{rule_begin ();}
		"state_diagram"
		state_diagram_group_0[state_diagram_ret]
		(flag=state_diagram_arbitrary_group_1[state_diagram_ret, state_views_, transition_views_, note_views_]
		{accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{
			state_diagram_ret->set_state_views (state_views_);
			state_diagram_ret->set_transition_views (transition_views_);
			state_diagram_ret->set_note_views (note_views_);
		}
		{rule_end ();}
	;

state_diagram_group_0
	[Core::Box<StateDiagram>& state_diagram_ret]
	:	{rule_begin ();}
		name_:STRING {state_diagram_ret->set_name (name_->getText ());} "{"
		{rule_end ();}
	;

state_diagram_arbitrary_group_1
	[
		Core::Box<StateDiagram>& state_diagram_ret
		, StateViewList& state_views_
		, TransitionViewList& transition_views_
		, NoteViewList& note_views_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<StateView> state_views_item;
		Core::Box<TransitionView> transition_views_item;
		Core::Box<NoteView> note_views_item;
	}
	
	:	{rule_begin ();}
		(	state_views_item=state_view {type = 0; state_views_.push_back (state_views_item);}
		|	transition_views_item=transition_view {type = 0; transition_views_.push_back (transition_views_item);}
		|	note_views_item=note_view {type = 0; note_views_.push_back (note_views_item);}
		|	"zoom" "=" zoom_:SIGNED {type = 1 << 5; state_diagram_ret->set_zoom (boost::lexical_cast<int> (zoom_->getText ()));} ";"
		)
		{rule_end ();}
	;



state_view_list returns [StateViewList state_view_list_ret]
	{
		Core::Box<StateView> item;
	}
	:	(item=state_view
		{
			state_view_list_ret.push_back (item);
		}
		)+
	;

state_view returns [Core::Box<StateView> state_view_ret]
	{
		state_view_ret = new StateView ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long accumulated_flag_2 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "number"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "center_x"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "center_y"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"state_view"
		state_view_group_0[state_view_ret]
		state_view_group_1[state_view_ret]
		(flag=state_view_group_2[state_view_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}
		)+
		{
			AttributeIDList attr_ids;
			attr_ids.push_back (1 << 3);
			attr_ids.push_back (1 << 4);
			check_all_necessary_parsed (
				accumulated_flag_2
				, attr_ids
				, local::get_descriptions ()
				, LT (1)
			);
		}
		"}"
		{rule_end ();}
	;

state_view_group_0
	[Core::Box<StateView>& state_view_ret]
	:	{rule_begin ();}
		number_:SIGNED {state_view_ret->set_number (boost::lexical_cast<int> (number_->getText ()));}
		{rule_end ();}
	;

state_view_group_1
	[Core::Box<StateView>& state_view_ret]
	:	{rule_begin ();}
		guid_:STRING {state_view_ret->set_guid (guid_->getText ());} "{"
		{rule_end ();}
	;

state_view_group_2
	[Core::Box<StateView>& state_view_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		(	("center_x" "=") => "center_x" "=" center_x_:SIGNED {type = 1 << 3; state_view_ret->set_center_x (boost::lexical_cast<int> (center_x_->getText ()));} ";"
		|	("center_y" "=") => "center_y" "=" center_y_:SIGNED {type = 1 << 4; state_view_ret->set_center_y (boost::lexical_cast<int> (center_y_->getText ()));} ";"
		)
		{rule_end ();}
	;



transition_view_list returns [TransitionViewList transition_view_list_ret]
	{
		Core::Box<TransitionView> item;
	}
	:	(item=transition_view
		{
			transition_view_list_ret.push_back (item);
		}
		)+
	;

transition_view returns [Core::Box<TransitionView> transition_view_ret]
	{
		transition_view_ret = new TransitionView ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long accumulated_flag_2 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "number"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "client"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "supplier"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "points"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 6, "param_view"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 7, "stereotype_view"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		PointList points_;

	}
	:	{rule_begin ();}
		"transition_view"
		transition_view_group_0[transition_view_ret]
		transition_view_group_1[transition_view_ret]
		(flag=transition_view_arbitrary_group_2[transition_view_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		(flag=transition_view_group_2[transition_view_ret, points_]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}
		)+
		{
			AttributeIDList attr_ids;
			attr_ids.push_back (1 << 3);
			attr_ids.push_back (1 << 4);
			attr_ids.push_back (1 << 5);
			check_all_necessary_parsed (
				accumulated_flag_2
				, attr_ids
				, local::get_descriptions ()
				, LT (1)
			);
		}

		(flag=transition_view_arbitrary_group_2[transition_view_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{
			transition_view_ret->set_points (points_);
		}
		{rule_end ();}
	;

transition_view_group_0
	[Core::Box<TransitionView>& transition_view_ret]
	:	{rule_begin ();}
		number_:SIGNED {transition_view_ret->set_number (boost::lexical_cast<int> (number_->getText ()));}
		{rule_end ();}
	;

transition_view_group_1
	[Core::Box<TransitionView>& transition_view_ret]
	:	{rule_begin ();}
		guid_:STRING {transition_view_ret->set_guid (guid_->getText ());} "{"
		{rule_end ();}
	;

transition_view_group_2
	[
		Core::Box<TransitionView>& transition_view_ret
		, PointList& points_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Point> points_item;
	}
	
	:	{rule_begin ();}
		(	"client" client_:SIGNED {type = 1 << 3; transition_view_ret->set_client (boost::lexical_cast<int> (client_->getText ()));} ";"
		|	"supplier" supplier_:SIGNED {type = 1 << 4; transition_view_ret->set_supplier (boost::lexical_cast<int> (supplier_->getText ()));} ";"
		|	"points" "=" points_item=point {type = 1 << 5; points_.push_back (points_item);} ("," points_item=point {type = 1 << 5; points_.push_back (points_item);})* ";"
		)
		{rule_end ();}
	;

transition_view_arbitrary_group_2
	[Core::Box<TransitionView>& transition_view_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<ParamView> param_view_;
		Core::Box<StereotypeView> stereotype_view_;
	}
	
	:	{rule_begin ();}
		(	param_view_=param_view {type = 1 << 6; transition_view_ret->set_param_view (param_view_);}
		|	stereotype_view_=stereotype_view {type = 1 << 7; transition_view_ret->set_stereotype_view (stereotype_view_);}
		)
		{rule_end ();}
	;



param_view returns [Core::Box<ParamView> param_view_ret]
	{
		param_view_ret = new ParamView ();
		unsigned long accumulated_flag_1 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "center_x"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "center_y"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"param_view" "{"
		(flag=param_view_group_1[param_view_ret]
		{accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());}
		)+
		{
			AttributeIDList attr_ids;
			attr_ids.push_back (1 << 1);
			attr_ids.push_back (1 << 2);
			check_all_necessary_parsed (
				accumulated_flag_1
				, attr_ids
				, local::get_descriptions ()
				, LT (1)
			);
		}
		"}"
		{rule_end ();}
	;

param_view_group_1
	[Core::Box<ParamView>& param_view_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		(	("center_x" "=") => "center_x" "=" center_x_:SIGNED {type = 1 << 1; param_view_ret->set_center_x (boost::lexical_cast<int> (center_x_->getText ()));} ";"
		|	("center_y" "=") => "center_y" "=" center_y_:SIGNED {type = 1 << 2; param_view_ret->set_center_y (boost::lexical_cast<int> (center_y_->getText ()));} ";"
		)
		{rule_end ();}
	;



identifier returns [std::string ret]
	:	s:STRING {ret = s->getText ();}
		| i:IDENTIFIER {ret = i->getText ();}
	;




class ViewPartLexer extends Lexer;
options {
	k = 2;
	testLiterals = false;
	charVocabulary = '\003'..'\377'
					;
}
ALL_POST_AND_PREFIXES
	options {testLiterals=true;}
	:	"}"
	|"{"
	|"="
	|";"
	|","
	|")"
	|"("
	;

STRING
	:	'"'! (ESC|'"' '"'|~'"')* '"'!
	;

protected
ESC	:	'\\'
		(	'n'
		|	'r'
		|	't'
		|	'b'
		|	'f'
		|	'w'
		|	'a'
		|	'"'
		|	'\''
		|	'\\'
		|	('0'..'3')
			(
				options {
					warnWhenFollowAmbig = false;
				}
			:
	('0'..'9')
				(
					options {
						warnWhenFollowAmbig = false;
					}
				:
	'0'..'9'
				)?
			)?
		|	('4'..'7')
			(
				options {
					warnWhenFollowAmbig = false;
				}
			:
	('0'..'9')
			)?
		|	'u' XDIGIT XDIGIT XDIGIT XDIGIT
		)
	;

protected
XDIGIT :
		'0' .. '9'
	|	'a' .. 'f'
	|	'A' .. 'F'
	;

IDENTIFIER
	options {testLiterals=true;}
	:	('\300'..'\377'|'a'..'z'|'A'..'Z'|'_') ('\300'..'\377'|'a'..'z'|'A'..'Z'|'0'..'9'|'_')*
	;

SIGNED
	: ('+'|'-')?('0'..'9')+
	;


WS_
	:	(	' '
	|	'\t'
	|	'\f'
	// handle newlines
	|	(	'\r' '\n'  // Evil DOS
		|	'\r'        // Macintosh
		|	'\n'        // Unix (the right way)
		)
		{ newline(); }
	)
	{_ttype = ANTLR_USE_NAMESPACE(antlr)Token::SKIP;}
	;
