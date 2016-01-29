header "pre_include_hpp" {
#include "shared/Core/sys/std_inc.h"
}

header "post_include_hpp" {
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPartDef.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AssociationView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Attribute.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AttributeContent.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Class.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ClassContent.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ClassDiagram.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ClassDiagramContent.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ClassDiagramView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ClassView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Dependency.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/InheriteView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Message.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/MessageContent.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/MessageView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Namespace.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/NoteView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ObjectView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Operation.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/OperationContent.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Package.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/PackageContent.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ParamView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Parameter.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ParameterContent.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Property.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/RealizeView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ReturnMessage.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ReturnMessageView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/RootPackage.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/SelfMessage.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/SelfMessageView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/SequenceDiagram.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/SequenceDiagramContent.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/SequenceDiagramView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/SequenceStartObject.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/State.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/StateAction.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/StateContent.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/StateDiagram.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/StateDiagramContent.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/StateDiagramView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/StateView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/StereotypeView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/Transition.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/TransitionContent.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/TransitionParamBase.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/TransitionView.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/TransitionViewContent.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ViewContent.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
#include "MDProcess/MDAFormat/ModelPartDef/RootPackage.h"

#include <boost/lexical_cast.hpp>
#include <vector>
#include <map>
}
options {
	language = "Cpp";
	genHashLines=false;
	namespace = "MDAFormat::AdditionalPartDef";
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

	AdditionalPartParser::Context::Context () {
	}
	
	Core::Box<RootPackage> AdditionalPartParser::Context::find_context (const std::string& key) const {
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
	
	const std::vector<Core::Box<RootPackage> >& AdditionalPartParser::Context::get_root_level () const {
		return m_root_level;
	}
	
	void AdditionalPartParser::Context::add_root (const Core::Box<RootPackage>& new_root) {
		m_root_level.push_back (new_root);
	}
	
	void AdditionalPartParser::Context::on_namespace (const std::string& ns) {
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
	
	void AdditionalPartParser::Context::on_new_element (Core::Box<RootPackage>& new_element) {
		if (m_context.is_nil ()) {
			add_root (new_element);
		} else {
			
		}
	}
	
	AdditionalPartParser::Context::reset_context () {
		m_context = 0;
	}
	
	Core::Box<RootPackage> AdditionalPartParser::Context::create_new_context (const std::string& key) {
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

	void AdditionalPartParser::rule_begin () {
		this->reset_error_stack ();
	}
	
	void AdditionalPartParser::rule_end () {
		this->reset_error_stack ();
	}
}
class AdditionalPartParser extends Parser;
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
		Core::Box<Package> root_;
	}
	
	:	{rule_begin ();}
		root_=package {root_package_ret->set_root (*root_);}
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



package returns [Core::Box<Package> package_ret]
	{
		package_ret = new Package ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "content"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"package"
		package_group_0[package_ret]
		package_group_1[package_ret]
		(flag=package_arbitrary_group_2[package_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

package_group_0
	[Core::Box<Package>& package_ret]
	{
		std::string name_;
	}
	
	:	{rule_begin ();}
		name_=identifier {package_ret->set_name (name_);}
		{rule_end ();}
	;

package_group_1
	[Core::Box<Package>& package_ret]
	:	{rule_begin ();}
		"=>" guid_:STRING {package_ret->set_guid (guid_->getText ());}
		{rule_end ();}
	;

package_arbitrary_group_2
	[Core::Box<Package>& package_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<PackageContent> content_;
	}
	
	:	{rule_begin ();}
		content_=package_content {type = 1 << 3; package_ret->set_content (content_);}
		{rule_end ();}
	;



package_content returns [Core::Box<PackageContent> package_content_ret]
	{
		package_content_ret = new PackageContent ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "properties"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "dependecies"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "sequence_diags"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "state_diags"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "class_diags"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 6, "classes"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 7, "packages"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		PropertyList properties_;
		DependencyList dependecies_;
		SequenceDiagramList sequence_diags_;
		StateDiagramList state_diags_;
		ClassDiagramList class_diags_;
		ClassList classes_;
		PackageList packages_;

	}
	:	{rule_begin ();}
		"{"
		(flag=package_content_arbitrary_group_0[package_content_ret, properties_, dependecies_, sequence_diags_, state_diags_, class_diags_, classes_, packages_]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{
			package_content_ret->set_properties (properties_);
			package_content_ret->set_dependecies (dependecies_);
			package_content_ret->set_sequence_diags (sequence_diags_);
			package_content_ret->set_state_diags (state_diags_);
			package_content_ret->set_class_diags (class_diags_);
			package_content_ret->set_classes (classes_);
			package_content_ret->set_packages (packages_);
		}
		{rule_end ();}
	;

package_content_arbitrary_group_0
	[
		Core::Box<PackageContent>& package_content_ret
		, PropertyList& properties_
		, DependencyList& dependecies_
		, SequenceDiagramList& sequence_diags_
		, StateDiagramList& state_diags_
		, ClassDiagramList& class_diags_
		, ClassList& classes_
		, PackageList& packages_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Property> properties_item;
		Core::Box<Dependency> dependecies_item;
		Core::Box<SequenceDiagram> sequence_diags_item;
		Core::Box<StateDiagram> state_diags_item;
		Core::Box<ClassDiagram> class_diags_item;
		Core::Box<Class> classes_item;
		Core::Box<Package> packages_item;
	}
	
	:	{rule_begin ();}
		(	properties_item=property {type = 0; properties_.push_back (properties_item);}
		|	dependecies_item=dependency {type = 0; dependecies_.push_back (dependecies_item);}
		|	sequence_diags_item=sequence_diagram {type = 0; sequence_diags_.push_back (sequence_diags_item);}
		|	state_diags_item=state_diagram {type = 0; state_diags_.push_back (state_diags_item);}
		|	class_diags_item=class_diagram {type = 0; class_diags_.push_back (class_diags_item);}
		|	classes_item=class_ {type = 0; classes_.push_back (classes_item);}
		|	packages_item=package {type = 0; packages_.push_back (packages_item);}
		)
		{rule_end ();}
	;



property_list returns [PropertyList property_list_ret]
	{
		Core::Box<Property> item;
	}
	:	(item=property
		{
			property_list_ret.push_back (item);
		}
		)+
	;

property returns [Core::Box<Property> property_ret]
	{
		property_ret = new Property ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "value"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"property"
		property_group_0[property_ret]
		(flag=property_arbitrary_group_1[property_ret]
		{accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

property_group_0
	[Core::Box<Property>& property_ret]
	:	{rule_begin ();}
		name_:STRING {property_ret->set_name (name_->getText ());}
		{rule_end ();}
	;

property_arbitrary_group_1
	[Core::Box<Property>& property_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		"=" value_:STRING {type = 1 << 2; property_ret->set_value (value_->getText ());}
		{rule_end ();}
	;



dependency_list returns [DependencyList dependency_list_ret]
	{
		Core::Box<Dependency> item;
	}
	:	(item=dependency
		{
			dependency_list_ret.push_back (item);
		}
		)+
	;

dependency returns [Core::Box<Dependency> dependency_ret]
	{
		dependency_ret = new Dependency ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long accumulated_flag_2 = 0;
		unsigned long accumulated_flag_3 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "properties"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "stereotype"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "target_full_name"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		PropertyList properties_;

	}
	:	{rule_begin ();}
		"dependency"
		(flag=dependency_arbitrary_group_0[dependency_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		dependency_group_1[dependency_ret]
		dependency_group_2[dependency_ret]
		(flag=dependency_arbitrary_group_3[dependency_ret, properties_]
		{accumulated_flag_3 = check_attribute_originality (accumulated_flag_3, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{
			dependency_ret->set_properties (properties_);
		}
		{rule_end ();}
	;

dependency_group_1
	[Core::Box<Dependency>& dependency_ret]
	{
		std::string target_full_name_;
	}
	
	:	{rule_begin ();}
		target_full_name_=identifier {dependency_ret->set_target_full_name (target_full_name_);}
		{rule_end ();}
	;

dependency_group_2
	[Core::Box<Dependency>& dependency_ret]
	:	{rule_begin ();}
		"=>" guid_:STRING {dependency_ret->set_guid (guid_->getText ());}
		{rule_end ();}
	;

dependency_arbitrary_group_0
	[Core::Box<Dependency>& dependency_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		stereotype_:SPEC_ARBITRARY_STRING0 {type = 1 << 3; dependency_ret->set_stereotype (stereotype_->getText ());}
		{rule_end ();}
	;

dependency_arbitrary_group_3
	[
		Core::Box<Dependency>& dependency_ret
		, PropertyList& properties_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Property> properties_item;
	}
	
	:	{rule_begin ();}
		"{" (properties_item=property {type = 0; properties_.push_back (properties_item);})+ "}"
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "content"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"sequence_diagram"
		sequence_diagram_group_0[sequence_diagram_ret]
		sequence_diagram_group_1[sequence_diagram_ret]
		(flag=sequence_diagram_arbitrary_group_2[sequence_diagram_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

sequence_diagram_group_0
	[Core::Box<SequenceDiagram>& sequence_diagram_ret]
	{
		std::string name_;
	}
	
	:	{rule_begin ();}
		name_=identifier {sequence_diagram_ret->set_name (name_);}
		{rule_end ();}
	;

sequence_diagram_group_1
	[Core::Box<SequenceDiagram>& sequence_diagram_ret]
	:	{rule_begin ();}
		"=>" guid_:STRING {sequence_diagram_ret->set_guid (guid_->getText ());}
		{rule_end ();}
	;

sequence_diagram_arbitrary_group_2
	[Core::Box<SequenceDiagram>& sequence_diagram_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<SequenceDiagramContent> content_;
	}
	
	:	{rule_begin ();}
		content_=sequence_diagram_content {type = 1 << 3; sequence_diagram_ret->set_content (content_);}
		{rule_end ();}
	;



sequence_diagram_content returns [Core::Box<SequenceDiagramContent> sequence_diagram_content_ret]
	{
		sequence_diagram_content_ret = new SequenceDiagramContent ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "object_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "message_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "self_message_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "return_message_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "properties"));
				
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
		PropertyList properties_;

	}
	:	{rule_begin ();}
		"{"
		(flag=sequence_diagram_content_arbitrary_group_0[sequence_diagram_content_ret, object_views_, message_views_, self_message_views_, return_message_views_, properties_]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{
			sequence_diagram_content_ret->set_object_views (object_views_);
			sequence_diagram_content_ret->set_message_views (message_views_);
			sequence_diagram_content_ret->set_self_message_views (self_message_views_);
			sequence_diagram_content_ret->set_return_message_views (return_message_views_);
			sequence_diagram_content_ret->set_properties (properties_);
		}
		{rule_end ();}
	;

sequence_diagram_content_arbitrary_group_0
	[
		Core::Box<SequenceDiagramContent>& sequence_diagram_content_ret
		, ObjectViewList& object_views_
		, MessageViewList& message_views_
		, SelfMessageViewList& self_message_views_
		, ReturnMessageViewList& return_message_views_
		, PropertyList& properties_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<ObjectView> object_views_item;
		Core::Box<MessageView> message_views_item;
		Core::Box<SelfMessageView> self_message_views_item;
		Core::Box<ReturnMessageView> return_message_views_item;
		Core::Box<Property> properties_item;
	}
	
	:	{rule_begin ();}
		(	(object_view) => object_views_item=object_view {type = 0; object_views_.push_back (object_views_item);}
		|	(message_view) => message_views_item=message_view {type = 0; message_views_.push_back (message_views_item);}
		|	(self_message_view) => self_message_views_item=self_message_view {type = 0; self_message_views_.push_back (self_message_views_item);}
		|	(return_message_view) => return_message_views_item=return_message_view {type = 0; return_message_views_.push_back (return_message_views_item);}
		|	(property) => properties_item=property {type = 0; properties_.push_back (properties_item);}
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
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "content"));
				
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
		(flag=object_view_arbitrary_group_0[object_view_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

object_view_arbitrary_group_0
	[Core::Box<ObjectView>& object_view_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<ViewContent> content_;
	}
	
	:	{rule_begin ();}
		content_=view_content {type = 1 << 1; object_view_ret->set_content (content_);}
		{rule_end ();}
	;



view_content returns [Core::Box<ViewContent> view_content_ret]
	{
		view_content_ret = new ViewContent ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "properties"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		PropertyList properties_;

	}
	:	{rule_begin ();}
		view_content_group_0[view_content_ret]
		view_content_group_1[view_content_ret]
		(flag=view_content_arbitrary_group_2[view_content_ret, properties_]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		{
			view_content_ret->set_properties (properties_);
		}
		{rule_end ();}
	;

view_content_group_0
	[Core::Box<ViewContent>& view_content_ret]
	:	{rule_begin ();}
		number_:UNSIGNED {view_content_ret->set_number (boost::lexical_cast<unsigned int> (number_->getText ()));}
		{rule_end ();}
	;

view_content_group_1
	[Core::Box<ViewContent>& view_content_ret]
	:	{rule_begin ();}
		"=>" guid_:STRING {view_content_ret->set_guid (guid_->getText ());}
		{rule_end ();}
	;

view_content_arbitrary_group_2
	[
		Core::Box<ViewContent>& view_content_ret
		, PropertyList& properties_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Property> properties_item;
	}
	
	:	{rule_begin ();}
		"{" (properties_item=property {type = 0; properties_.push_back (properties_item);})+ "}"
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
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "content"));
				
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
		(flag=message_view_arbitrary_group_0[message_view_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

message_view_arbitrary_group_0
	[Core::Box<MessageView>& message_view_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<ViewContent> content_;
	}
	
	:	{rule_begin ();}
		content_=view_content {type = 1 << 1; message_view_ret->set_content (content_);}
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
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "content"));
				
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
		(flag=self_message_view_arbitrary_group_0[self_message_view_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

self_message_view_arbitrary_group_0
	[Core::Box<SelfMessageView>& self_message_view_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<ViewContent> content_;
	}
	
	:	{rule_begin ();}
		content_=view_content {type = 1 << 1; self_message_view_ret->set_content (content_);}
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
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "content"));
				
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
		(flag=return_message_view_arbitrary_group_0[return_message_view_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

return_message_view_arbitrary_group_0
	[Core::Box<ReturnMessageView>& return_message_view_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<ViewContent> content_;
	}
	
	:	{rule_begin ();}
		content_=view_content {type = 1 << 1; return_message_view_ret->set_content (content_);}
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "content"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"state_diagram"
		state_diagram_group_0[state_diagram_ret]
		state_diagram_group_1[state_diagram_ret]
		(flag=state_diagram_arbitrary_group_2[state_diagram_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

state_diagram_group_0
	[Core::Box<StateDiagram>& state_diagram_ret]
	{
		std::string name_;
	}
	
	:	{rule_begin ();}
		name_=identifier {state_diagram_ret->set_name (name_);}
		{rule_end ();}
	;

state_diagram_group_1
	[Core::Box<StateDiagram>& state_diagram_ret]
	:	{rule_begin ();}
		"=>" guid_:STRING {state_diagram_ret->set_guid (guid_->getText ());}
		{rule_end ();}
	;

state_diagram_arbitrary_group_2
	[Core::Box<StateDiagram>& state_diagram_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<StateDiagramContent> content_;
	}
	
	:	{rule_begin ();}
		content_=state_diagram_content {type = 1 << 3; state_diagram_ret->set_content (content_);}
		{rule_end ();}
	;



state_diagram_content returns [Core::Box<StateDiagramContent> state_diagram_content_ret]
	{
		state_diagram_content_ret = new StateDiagramContent ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "transition_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "state_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "note_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "properties"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		TransitionViewList transition_views_;
		StateViewList state_views_;
		NoteViewList note_views_;
		PropertyList properties_;

	}
	:	{rule_begin ();}
		"{"
		(flag=state_diagram_content_arbitrary_group_0[state_diagram_content_ret, transition_views_, state_views_, note_views_, properties_]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{
			state_diagram_content_ret->set_transition_views (transition_views_);
			state_diagram_content_ret->set_state_views (state_views_);
			state_diagram_content_ret->set_note_views (note_views_);
			state_diagram_content_ret->set_properties (properties_);
		}
		{rule_end ();}
	;

state_diagram_content_arbitrary_group_0
	[
		Core::Box<StateDiagramContent>& state_diagram_content_ret
		, TransitionViewList& transition_views_
		, StateViewList& state_views_
		, NoteViewList& note_views_
		, PropertyList& properties_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<TransitionView> transition_views_item;
		Core::Box<StateView> state_views_item;
		Core::Box<NoteView> note_views_item;
		Core::Box<Property> properties_item;
	}
	
	:	{rule_begin ();}
		(	(transition_view) => transition_views_item=transition_view {type = 0; transition_views_.push_back (transition_views_item);}
		|	(state_view) => state_views_item=state_view {type = 0; state_views_.push_back (state_views_item);}
		|	(note_view) => note_views_item=note_view {type = 0; note_views_.push_back (note_views_item);}
		|	(property) => properties_item=property {type = 0; properties_.push_back (properties_item);}
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "content"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"transition_view"
		transition_view_group_0[transition_view_ret]
		(flag=transition_view_arbitrary_group_1[transition_view_ret]
		{accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());}

		)*
		transition_view_group_1[transition_view_ret]

		(flag=transition_view_arbitrary_group_1[transition_view_ret]
		{accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

transition_view_group_0
	[Core::Box<TransitionView>& transition_view_ret]
	:	{rule_begin ();}
		number_:UNSIGNED {transition_view_ret->set_number (boost::lexical_cast<unsigned int> (number_->getText ()));}
		{rule_end ();}
	;

transition_view_group_1
	[Core::Box<TransitionView>& transition_view_ret]
	:	{rule_begin ();}
		"=>" guid_:STRING {transition_view_ret->set_guid (guid_->getText ());}
		{rule_end ();}
	;

transition_view_arbitrary_group_1
	[Core::Box<TransitionView>& transition_view_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<TransitionViewContent> content_;
	}
	
	:	{rule_begin ();}
		content_=transition_view_content {type = 1 << 3; transition_view_ret->set_content (content_);}
		{rule_end ();}
	;



transition_view_content returns [Core::Box<TransitionViewContent> transition_view_content_ret]
	{
		transition_view_content_ret = new TransitionViewContent ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "properties"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "param_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "stereotype_views"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		PropertyList properties_;
		ParamViewList param_views_;
		StereotypeViewList stereotype_views_;

	}
	:	{rule_begin ();}
		"{"
		(flag=transition_view_content_arbitrary_group_0[transition_view_content_ret, properties_, param_views_, stereotype_views_]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{
			transition_view_content_ret->set_properties (properties_);
			transition_view_content_ret->set_param_views (param_views_);
			transition_view_content_ret->set_stereotype_views (stereotype_views_);
		}
		{rule_end ();}
	;

transition_view_content_arbitrary_group_0
	[
		Core::Box<TransitionViewContent>& transition_view_content_ret
		, PropertyList& properties_
		, ParamViewList& param_views_
		, StereotypeViewList& stereotype_views_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Property> properties_item;
		Core::Box<ParamView> param_views_item;
		Core::Box<StereotypeView> stereotype_views_item;
	}
	
	:	{rule_begin ();}
		(	(property) => properties_item=property {type = 0; properties_.push_back (properties_item);}
		|	(param_view) => param_views_item=param_view {type = 0; param_views_.push_back (param_views_item);}
		|	(stereotype_view) => stereotype_views_item=stereotype_view {type = 0; stereotype_views_.push_back (stereotype_views_item);}
		)
		{rule_end ();}
	;



param_view_list returns [ParamViewList param_view_list_ret]
	{
		Core::Box<ParamView> item;
	}
	:	(item=param_view
		{
			param_view_list_ret.push_back (item);
		}
		)+
	;

param_view returns [Core::Box<ParamView> param_view_ret]
	{
		param_view_ret = new ParamView ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "content"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"param_view"
		(flag=param_view_arbitrary_group_0[param_view_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

param_view_arbitrary_group_0
	[Core::Box<ParamView>& param_view_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<ViewContent> content_;
	}
	
	:	{rule_begin ();}
		content_=view_content {type = 1 << 1; param_view_ret->set_content (content_);}
		{rule_end ();}
	;



stereotype_view_list returns [StereotypeViewList stereotype_view_list_ret]
	{
		Core::Box<StereotypeView> item;
	}
	:	(item=stereotype_view
		{
			stereotype_view_list_ret.push_back (item);
		}
		)+
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "content"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"stereotype_view"
		(flag=stereotype_view_arbitrary_group_0[stereotype_view_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

stereotype_view_arbitrary_group_0
	[Core::Box<StereotypeView>& stereotype_view_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<ViewContent> content_;
	}
	
	:	{rule_begin ();}
		content_=view_content {type = 1 << 1; stereotype_view_ret->set_content (content_);}
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
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "content"));
				
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
		(flag=state_view_arbitrary_group_0[state_view_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

state_view_arbitrary_group_0
	[Core::Box<StateView>& state_view_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<ViewContent> content_;
	}
	
	:	{rule_begin ();}
		content_=view_content {type = 1 << 1; state_view_ret->set_content (content_);}
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
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "conent"));
				
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
		(flag=note_view_arbitrary_group_0[note_view_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

note_view_arbitrary_group_0
	[Core::Box<NoteView>& note_view_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<ViewContent> conent_;
	}
	
	:	{rule_begin ();}
		conent_=view_content {type = 1 << 1; note_view_ret->set_conent (conent_);}
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "content"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"class_diagram"
		class_diagram_group_0[class_diagram_ret]
		class_diagram_group_1[class_diagram_ret]
		(flag=class_diagram_arbitrary_group_2[class_diagram_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

class_diagram_group_0
	[Core::Box<ClassDiagram>& class_diagram_ret]
	{
		std::string name_;
	}
	
	:	{rule_begin ();}
		name_=identifier {class_diagram_ret->set_name (name_);}
		{rule_end ();}
	;

class_diagram_group_1
	[Core::Box<ClassDiagram>& class_diagram_ret]
	{
		std::string guid_;
	}
	
	:	{rule_begin ();}
		"=>" guid_=identifier {class_diagram_ret->set_guid (guid_);}
		{rule_end ();}
	;

class_diagram_arbitrary_group_2
	[Core::Box<ClassDiagram>& class_diagram_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<ClassDiagramContent> content_;
	}
	
	:	{rule_begin ();}
		content_=class_diagram_content {type = 1 << 3; class_diagram_ret->set_content (content_);}
		{rule_end ();}
	;



class_diagram_content returns [Core::Box<ClassDiagramContent> class_diagram_content_ret]
	{
		class_diagram_content_ret = new ClassDiagramContent ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "class_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "inherite_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "realize_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "association_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "note_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 6, "properties"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 7, "class_diagram_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 8, "sequence_diagram_views"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 9, "state_diagram_views"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		ClassViewList class_views_;
		InheriteViewList inherite_views_;
		RealizeViewList realize_views_;
		AssociationViewList association_views_;
		NoteViewList note_views_;
		PropertyList properties_;
		ClassDiagramViewList class_diagram_views_;
		SequenceDiagramViewList sequence_diagram_views_;
		StateDiagramViewList state_diagram_views_;

	}
	:	{rule_begin ();}
		"{"
		(flag=class_diagram_content_arbitrary_group_0[class_diagram_content_ret, class_views_, inherite_views_, realize_views_, association_views_, note_views_, properties_, class_diagram_views_, sequence_diagram_views_, state_diagram_views_]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{
			class_diagram_content_ret->set_class_views (class_views_);
			class_diagram_content_ret->set_inherite_views (inherite_views_);
			class_diagram_content_ret->set_realize_views (realize_views_);
			class_diagram_content_ret->set_association_views (association_views_);
			class_diagram_content_ret->set_note_views (note_views_);
			class_diagram_content_ret->set_properties (properties_);
			class_diagram_content_ret->set_class_diagram_views (class_diagram_views_);
			class_diagram_content_ret->set_sequence_diagram_views (sequence_diagram_views_);
			class_diagram_content_ret->set_state_diagram_views (state_diagram_views_);
		}
		{rule_end ();}
	;

class_diagram_content_arbitrary_group_0
	[
		Core::Box<ClassDiagramContent>& class_diagram_content_ret
		, ClassViewList& class_views_
		, InheriteViewList& inherite_views_
		, RealizeViewList& realize_views_
		, AssociationViewList& association_views_
		, NoteViewList& note_views_
		, PropertyList& properties_
		, ClassDiagramViewList& class_diagram_views_
		, SequenceDiagramViewList& sequence_diagram_views_
		, StateDiagramViewList& state_diagram_views_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<ClassView> class_views_item;
		Core::Box<InheriteView> inherite_views_item;
		Core::Box<RealizeView> realize_views_item;
		Core::Box<AssociationView> association_views_item;
		Core::Box<NoteView> note_views_item;
		Core::Box<Property> properties_item;
		Core::Box<ClassDiagramView> class_diagram_views_item;
		Core::Box<SequenceDiagramView> sequence_diagram_views_item;
		Core::Box<StateDiagramView> state_diagram_views_item;
	}
	
	:	{rule_begin ();}
		(	(class_view) => class_views_item=class_view {type = 0; class_views_.push_back (class_views_item);}
		|	(inherite_view) => inherite_views_item=inherite_view {type = 0; inherite_views_.push_back (inherite_views_item);}
		|	(realize_view) => realize_views_item=realize_view {type = 0; realize_views_.push_back (realize_views_item);}
		|	(association_view) => association_views_item=association_view {type = 0; association_views_.push_back (association_views_item);}
		|	(note_view) => note_views_item=note_view {type = 0; note_views_.push_back (note_views_item);}
		|	(property) => properties_item=property {type = 0; properties_.push_back (properties_item);}
		|	(class_diagram_view) => class_diagram_views_item=class_diagram_view {type = 0; class_diagram_views_.push_back (class_diagram_views_item);}
		|	(sequence_diagram_view) => sequence_diagram_views_item=sequence_diagram_view {type = 0; sequence_diagram_views_.push_back (sequence_diagram_views_item);}
		|	(state_diagram_view) => state_diagram_views_item=state_diagram_view {type = 0; state_diagram_views_.push_back (state_diagram_views_item);}
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "conent"));
				
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
		(flag=class_view_arbitrary_group_2[class_view_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

class_view_arbitrary_group_2
	[Core::Box<ClassView>& class_view_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<ViewContent> conent_;
	}
	
	:	{rule_begin ();}
		conent_=view_content {type = 1 << 1; class_view_ret->set_conent (conent_);}
		{rule_end ();}
	;



inherite_view_list returns [InheriteViewList inherite_view_list_ret]
	{
		Core::Box<InheriteView> item;
	}
	:	(item=inherite_view
		{
			inherite_view_list_ret.push_back (item);
		}
		)+
	;

inherite_view returns [Core::Box<InheriteView> inherite_view_ret]
	{
		inherite_view_ret = new InheriteView ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "conent"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"inherite_view"
		(flag=inherite_view_arbitrary_group_0[inherite_view_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

inherite_view_arbitrary_group_0
	[Core::Box<InheriteView>& inherite_view_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<ViewContent> conent_;
	}
	
	:	{rule_begin ();}
		conent_=view_content {type = 1 << 1; inherite_view_ret->set_conent (conent_);}
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
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "conent"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"realize_view"
		(flag=realize_view_arbitrary_group_0[realize_view_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

realize_view_arbitrary_group_0
	[Core::Box<RealizeView>& realize_view_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<ViewContent> conent_;
	}
	
	:	{rule_begin ();}
		conent_=view_content {type = 1 << 1; realize_view_ret->set_conent (conent_);}
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
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "conent"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"association_view"
		(flag=association_view_arbitrary_group_0[association_view_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

association_view_arbitrary_group_0
	[Core::Box<AssociationView>& association_view_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<ViewContent> conent_;
	}
	
	:	{rule_begin ();}
		conent_=view_content {type = 1 << 1; association_view_ret->set_conent (conent_);}
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
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "conent"));
				
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
		(flag=class_diagram_view_arbitrary_group_0[class_diagram_view_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

class_diagram_view_arbitrary_group_0
	[Core::Box<ClassDiagramView>& class_diagram_view_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<ViewContent> conent_;
	}
	
	:	{rule_begin ();}
		conent_=view_content {type = 1 << 1; class_diagram_view_ret->set_conent (conent_);}
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
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "conent"));
				
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
		(flag=sequence_diagram_view_arbitrary_group_0[sequence_diagram_view_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

sequence_diagram_view_arbitrary_group_0
	[Core::Box<SequenceDiagramView>& sequence_diagram_view_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<ViewContent> conent_;
	}
	
	:	{rule_begin ();}
		conent_=view_content {type = 1 << 1; sequence_diagram_view_ret->set_conent (conent_);}
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
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "conent"));
				
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
		(flag=state_diagram_view_arbitrary_group_0[state_diagram_view_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

state_diagram_view_arbitrary_group_0
	[Core::Box<StateDiagramView>& state_diagram_view_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<ViewContent> conent_;
	}
	
	:	{rule_begin ();}
		conent_=view_content {type = 1 << 1; state_diagram_view_ret->set_conent (conent_);}
		{rule_end ();}
	;



class_list returns [ClassList class_list_ret]
	{
		Core::Box<Class> item;
	}
	:	(item=class_
		{
			class_list_ret.push_back (item);
		}
		)+
	;

class_ returns [Core::Box<Class> class_ret]
	{
		class_ret = new Class ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "content"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"class"
		class__group_0[class_ret]
		class__group_1[class_ret]
		(flag=class__arbitrary_group_2[class_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

class__group_0
	[Core::Box<Class>& class_ret]
	{
		std::string name_;
	}
	
	:	{rule_begin ();}
		name_=identifier {class_ret->set_name (name_);}
		{rule_end ();}
	;

class__group_1
	[Core::Box<Class>& class_ret]
	:	{rule_begin ();}
		"=>" guid_:STRING {class_ret->set_guid (guid_->getText ());}
		{rule_end ();}
	;

class__arbitrary_group_2
	[Core::Box<Class>& class_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<ClassContent> content_;
	}
	
	:	{rule_begin ();}
		content_=class_content {type = 1 << 3; class_ret->set_content (content_);}
		{rule_end ();}
	;



class_content returns [Core::Box<ClassContent> class_content_ret]
	{
		class_content_ret = new ClassContent ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "properties"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "dependecies"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "sequence_diags"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "sequence_start_objects"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "state_diags"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 6, "class_diags"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 7, "operations"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 8, "template_params"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 9, "attributres"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 10, "nested_classes"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 11, "states"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		PropertyList properties_;
		DependencyList dependecies_;
		SequenceDiagramList sequence_diags_;
		SequenceStartObjectList sequence_start_objects_;
		StateDiagramList state_diags_;
		ClassDiagramList class_diags_;
		OperationList operations_;
		ParameterList template_params_;
		AttributeList attributres_;
		ClassList nested_classes_;
		StateList states_;

	}
	:	{rule_begin ();}
		"{"
		(flag=class_content_arbitrary_group_0[class_content_ret, properties_, dependecies_, sequence_diags_, sequence_start_objects_, state_diags_, class_diags_, operations_, template_params_, attributres_, nested_classes_, states_]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{
			class_content_ret->set_properties (properties_);
			class_content_ret->set_dependecies (dependecies_);
			class_content_ret->set_sequence_diags (sequence_diags_);
			class_content_ret->set_sequence_start_objects (sequence_start_objects_);
			class_content_ret->set_state_diags (state_diags_);
			class_content_ret->set_class_diags (class_diags_);
			class_content_ret->set_operations (operations_);
			class_content_ret->set_template_params (template_params_);
			class_content_ret->set_attributres (attributres_);
			class_content_ret->set_nested_classes (nested_classes_);
			class_content_ret->set_states (states_);
		}
		{rule_end ();}
	;

class_content_arbitrary_group_0
	[
		Core::Box<ClassContent>& class_content_ret
		, PropertyList& properties_
		, DependencyList& dependecies_
		, SequenceDiagramList& sequence_diags_
		, SequenceStartObjectList& sequence_start_objects_
		, StateDiagramList& state_diags_
		, ClassDiagramList& class_diags_
		, OperationList& operations_
		, ParameterList& template_params_
		, AttributeList& attributres_
		, ClassList& nested_classes_
		, StateList& states_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Property> properties_item;
		Core::Box<Dependency> dependecies_item;
		Core::Box<SequenceDiagram> sequence_diags_item;
		Core::Box<SequenceStartObject> sequence_start_objects_item;
		Core::Box<StateDiagram> state_diags_item;
		Core::Box<ClassDiagram> class_diags_item;
		Core::Box<Operation> operations_item;
		Core::Box<Parameter> template_params_item;
		Core::Box<Attribute> attributres_item;
		Core::Box<Class> nested_classes_item;
		Core::Box<State> states_item;
	}
	
	:	{rule_begin ();}
		(	properties_item=property {type = 0; properties_.push_back (properties_item);}
		|	dependecies_item=dependency {type = 0; dependecies_.push_back (dependecies_item);}
		|	sequence_diags_item=sequence_diagram {type = 0; sequence_diags_.push_back (sequence_diags_item);}
		|	sequence_start_objects_item=sequence_start_object {type = 0; sequence_start_objects_.push_back (sequence_start_objects_item);}
		|	state_diags_item=state_diagram {type = 0; state_diags_.push_back (state_diags_item);}
		|	class_diags_item=class_diagram {type = 0; class_diags_.push_back (class_diags_item);}
		|	operations_item=operation {type = 0; operations_.push_back (operations_item);}
		|	template_params_item=parameter {type = 0; template_params_.push_back (template_params_item);}
		|	attributres_item=attribute {type = 0; attributres_.push_back (attributres_item);}
		|	nested_classes_item=class_ {type = 0; nested_classes_.push_back (nested_classes_item);}
		|	states_item=state {type = 0; states_.push_back (states_item);}
		)
		{rule_end ();}
	;



sequence_start_object_list returns [SequenceStartObjectList sequence_start_object_list_ret]
	{
		Core::Box<SequenceStartObject> item;
	}
	:	(item=sequence_start_object
		{
			sequence_start_object_list_ret.push_back (item);
		}
		)+
	;

sequence_start_object returns [Core::Box<SequenceStartObject> sequence_start_object_ret]
	{
		sequence_start_object_ret = new SequenceStartObject ();
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long accumulated_flag_2 = 0;
		unsigned long accumulated_flag_3 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "class_name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "object_name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "content"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"sequence"
		sequence_start_object_group_0[sequence_start_object_ret]
		(flag=sequence_start_object_arbitrary_group_1[sequence_start_object_ret]
		{accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());}

		)*
		sequence_start_object_group_2[sequence_start_object_ret]
		(flag=sequence_start_object_arbitrary_group_3[sequence_start_object_ret]
		{accumulated_flag_3 = check_attribute_originality (accumulated_flag_3, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

sequence_start_object_group_0
	[Core::Box<SequenceStartObject>& sequence_start_object_ret]
	{
		std::string class_name_;
	}
	
	:	{rule_begin ();}
		class_name_=identifier {sequence_start_object_ret->set_class_name (class_name_);}
		{rule_end ();}
	;

sequence_start_object_group_2
	[Core::Box<SequenceStartObject>& sequence_start_object_ret]
	:	{rule_begin ();}
		"=>" guid_:STRING {sequence_start_object_ret->set_guid (guid_->getText ());}
		{rule_end ();}
	;

sequence_start_object_arbitrary_group_1
	[Core::Box<SequenceStartObject>& sequence_start_object_ret]
	returns [unsigned long type = 0]
	{
		std::string object_name_;
	}
	
	:	{rule_begin ();}
		"(" object_name_=identifier {type = 1 << 2; sequence_start_object_ret->set_object_name (object_name_);} ")"
		{rule_end ();}
	;

sequence_start_object_arbitrary_group_3
	[Core::Box<SequenceStartObject>& sequence_start_object_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<MessageContent> content_;
	}
	
	:	{rule_begin ();}
		content_=message_content {type = 1 << 4; sequence_start_object_ret->set_content (content_);}
		{rule_end ();}
	;



message_content returns [Core::Box<MessageContent> message_content_ret]
	{
		message_content_ret = new MessageContent ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "self_messages"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "return_messages"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "messages"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		SelfMessageList self_messages_;
		ReturnMessageList return_messages_;
		MessageList messages_;

	}
	:	{rule_begin ();}
		"{"
		(flag=message_content_arbitrary_group_0[message_content_ret, self_messages_, return_messages_, messages_]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{
			message_content_ret->set_self_messages (self_messages_);
			message_content_ret->set_return_messages (return_messages_);
			message_content_ret->set_messages (messages_);
		}
		{rule_end ();}
	;

message_content_arbitrary_group_0
	[
		Core::Box<MessageContent>& message_content_ret
		, SelfMessageList& self_messages_
		, ReturnMessageList& return_messages_
		, MessageList& messages_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<SelfMessage> self_messages_item;
		Core::Box<ReturnMessage> return_messages_item;
		Core::Box<Message> messages_item;
	}
	
	:	{rule_begin ();}
		(	self_messages_item=self_message {type = 0; self_messages_.push_back (self_messages_item);}
		|	return_messages_item=return_message {type = 0; return_messages_.push_back (return_messages_item);}
		|	messages_item=message {type = 0; messages_.push_back (messages_item);}
		)
		{rule_end ();}
	;



self_message_list returns [SelfMessageList self_message_list_ret]
	{
		Core::Box<SelfMessage> item;
	}
	:	(item=self_message
		{
			self_message_list_ret.push_back (item);
		}
		)+
	;

self_message returns [Core::Box<SelfMessage> self_message_ret]
	{
		self_message_ret = new SelfMessage ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "operation"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "properties"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		PropertyList properties_;

	}
	:	{rule_begin ();}
		"this"
		self_message_group_0[self_message_ret]
		self_message_group_1[self_message_ret]
		(flag=self_message_arbitrary_group_2[self_message_ret, properties_]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{
			self_message_ret->set_properties (properties_);
		}
		{rule_end ();}
	;

self_message_group_0
	[Core::Box<SelfMessage>& self_message_ret]
	:	{rule_begin ();}
		"::" operation_:STRING {self_message_ret->set_operation (operation_->getText ());}
		{rule_end ();}
	;

self_message_group_1
	[Core::Box<SelfMessage>& self_message_ret]
	:	{rule_begin ();}
		"=>" guid_:STRING {self_message_ret->set_guid (guid_->getText ());}
		{rule_end ();}
	;

self_message_arbitrary_group_2
	[
		Core::Box<SelfMessage>& self_message_ret
		, PropertyList& properties_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Property> properties_item;
	}
	
	:	{rule_begin ();}
		"{" (properties_item=property {type = 0; properties_.push_back (properties_item);})+ "}"
		{rule_end ();}
	;



return_message_list returns [ReturnMessageList return_message_list_ret]
	{
		Core::Box<ReturnMessage> item;
	}
	:	(item=return_message
		{
			return_message_list_ret.push_back (item);
		}
		)+
	;

return_message returns [Core::Box<ReturnMessage> return_message_ret]
	{
		return_message_ret = new ReturnMessage ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "result"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "properties"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		PropertyList properties_;

	}
	:	{rule_begin ();}
		"return"
		return_message_group_0[return_message_ret]
		return_message_group_1[return_message_ret]
		(flag=return_message_arbitrary_group_2[return_message_ret, properties_]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{
			return_message_ret->set_properties (properties_);
		}
		{rule_end ();}
	;

return_message_group_0
	[Core::Box<ReturnMessage>& return_message_ret]
	:	{rule_begin ();}
		result_:STRING {return_message_ret->set_result (result_->getText ());}
		{rule_end ();}
	;

return_message_group_1
	[Core::Box<ReturnMessage>& return_message_ret]
	:	{rule_begin ();}
		"=>" guid_:STRING {return_message_ret->set_guid (guid_->getText ());}
		{rule_end ();}
	;

return_message_arbitrary_group_2
	[
		Core::Box<ReturnMessage>& return_message_ret
		, PropertyList& properties_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Property> properties_item;
	}
	
	:	{rule_begin ();}
		"{" (properties_item=property {type = 0; properties_.push_back (properties_item);})+ "}"
		{rule_end ();}
	;



message_list returns [MessageList message_list_ret]
	{
		Core::Box<Message> item;
	}
	:	(item=message
		{
			message_list_ret.push_back (item);
		}
		)+
	;

message returns [Core::Box<Message> message_ret]
	{
		message_ret = new Message ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "class_name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "object_name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "operation"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "content"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		message_group_0[message_ret]
		(flag=message_arbitrary_group_1[message_ret]
		{accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());}

		)*
		message_group_2[message_ret]
		message_group_3[message_ret]
		(flag=message_arbitrary_group_4[message_ret]
		{accumulated_flag_4 = check_attribute_originality (accumulated_flag_4, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

message_group_0
	[Core::Box<Message>& message_ret]
	{
		std::string class_name_;
	}
	
	:	{rule_begin ();}
		class_name_=identifier {message_ret->set_class_name (class_name_);}
		{rule_end ();}
	;

message_group_2
	[Core::Box<Message>& message_ret]
	:	{rule_begin ();}
		"::" operation_:STRING {message_ret->set_operation (operation_->getText ());}
		{rule_end ();}
	;

message_group_3
	[Core::Box<Message>& message_ret]
	:	{rule_begin ();}
		"=>" guid_:STRING {message_ret->set_guid (guid_->getText ());}
		{rule_end ();}
	;

message_arbitrary_group_1
	[Core::Box<Message>& message_ret]
	returns [unsigned long type = 0]
	{
		std::string object_name_;
	}
	
	:	{rule_begin ();}
		"(" object_name_=identifier {type = 1 << 2; message_ret->set_object_name (object_name_);} ")"
		{rule_end ();}
	;

message_arbitrary_group_4
	[Core::Box<Message>& message_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<MessageContent> content_;
	}
	
	:	{rule_begin ();}
		content_=message_content {type = 1 << 5; message_ret->set_content (content_);}
		{rule_end ();}
	;



operation_list returns [OperationList operation_list_ret]
	{
		Core::Box<Operation> item;
	}
	:	(item=operation
		{
			operation_list_ret.push_back (item);
		}
		)+
	;

operation returns [Core::Box<Operation> operation_ret]
	{
		operation_ret = new Operation ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "content"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"operation"
		operation_group_0[operation_ret]
		operation_group_1[operation_ret]
		(flag=operation_arbitrary_group_2[operation_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

operation_group_0
	[Core::Box<Operation>& operation_ret]
	{
		std::string name_;
	}
	
	:	{rule_begin ();}
		name_=identifier {operation_ret->set_name (name_);}
		{rule_end ();}
	;

operation_group_1
	[Core::Box<Operation>& operation_ret]
	:	{rule_begin ();}
		"=>" guid_:STRING {operation_ret->set_guid (guid_->getText ());}
		{rule_end ();}
	;

operation_arbitrary_group_2
	[Core::Box<Operation>& operation_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<OperationContent> content_;
	}
	
	:	{rule_begin ();}
		content_=operation_content {type = 1 << 3; operation_ret->set_content (content_);}
		{rule_end ();}
	;



operation_content returns [Core::Box<OperationContent> operation_content_ret]
	{
		operation_content_ret = new OperationContent ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "properties"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "parameters"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		PropertyList properties_;
		ParameterList parameters_;

	}
	:	{rule_begin ();}
		"{"
		(flag=operation_content_arbitrary_group_0[operation_content_ret, properties_, parameters_]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{
			operation_content_ret->set_properties (properties_);
			operation_content_ret->set_parameters (parameters_);
		}
		{rule_end ();}
	;

operation_content_arbitrary_group_0
	[
		Core::Box<OperationContent>& operation_content_ret
		, PropertyList& properties_
		, ParameterList& parameters_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Property> properties_item;
		Core::Box<Parameter> parameters_item;
	}
	
	:	{rule_begin ();}
		(	properties_item=property {type = 0; properties_.push_back (properties_item);}
		|	parameters_item=parameter {type = 0; parameters_.push_back (parameters_item);}
		)
		{rule_end ();}
	;



parameter_list returns [ParameterList parameter_list_ret]
	{
		Core::Box<Parameter> item;
	}
	:	(item=parameter
		{
			parameter_list_ret.push_back (item);
		}
		)+
	;

parameter returns [Core::Box<Parameter> parameter_ret]
	{
		parameter_ret = new Parameter ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "content"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"parameter"
		parameter_group_0[parameter_ret]
		parameter_group_1[parameter_ret]
		(flag=parameter_arbitrary_group_2[parameter_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

parameter_group_0
	[Core::Box<Parameter>& parameter_ret]
	{
		std::string name_;
	}
	
	:	{rule_begin ();}
		name_=identifier {parameter_ret->set_name (name_);}
		{rule_end ();}
	;

parameter_group_1
	[Core::Box<Parameter>& parameter_ret]
	:	{rule_begin ();}
		"=>" guid_:STRING {parameter_ret->set_guid (guid_->getText ());}
		{rule_end ();}
	;

parameter_arbitrary_group_2
	[Core::Box<Parameter>& parameter_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<ParameterContent> content_;
	}
	
	:	{rule_begin ();}
		content_=parameter_content {type = 1 << 3; parameter_ret->set_content (content_);}
		{rule_end ();}
	;



parameter_content returns [Core::Box<ParameterContent> parameter_content_ret]
	{
		parameter_content_ret = new ParameterContent ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "properties"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		PropertyList properties_;

	}
	:	{rule_begin ();}
		"{"
		(flag=parameter_content_arbitrary_group_0[parameter_content_ret, properties_]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{
			parameter_content_ret->set_properties (properties_);
		}
		{rule_end ();}
	;

parameter_content_arbitrary_group_0
	[
		Core::Box<ParameterContent>& parameter_content_ret
		, PropertyList& properties_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Property> properties_item;
	}
	
	:	{rule_begin ();}
		properties_item=property {type = 0; properties_.push_back (properties_item);}
		{rule_end ();}
	;



attribute_list returns [AttributeList attribute_list_ret]
	{
		Core::Box<Attribute> item;
	}
	:	(item=attribute
		{
			attribute_list_ret.push_back (item);
		}
		)+
	;

attribute returns [Core::Box<Attribute> attribute_ret]
	{
		attribute_ret = new Attribute ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "content"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"attribute"
		attribute_group_0[attribute_ret]
		attribute_group_1[attribute_ret]
		(flag=attribute_arbitrary_group_2[attribute_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

attribute_group_0
	[Core::Box<Attribute>& attribute_ret]
	{
		std::string name_;
	}
	
	:	{rule_begin ();}
		name_=identifier {attribute_ret->set_name (name_);}
		{rule_end ();}
	;

attribute_group_1
	[Core::Box<Attribute>& attribute_ret]
	:	{rule_begin ();}
		"=>" guid_:STRING {attribute_ret->set_guid (guid_->getText ());}
		{rule_end ();}
	;

attribute_arbitrary_group_2
	[Core::Box<Attribute>& attribute_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<AttributeContent> content_;
	}
	
	:	{rule_begin ();}
		content_=attribute_content {type = 1 << 3; attribute_ret->set_content (content_);}
		{rule_end ();}
	;



attribute_content returns [Core::Box<AttributeContent> attribute_content_ret]
	{
		attribute_content_ret = new AttributeContent ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "attributes"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "properties"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		AttributeList attributes_;
		PropertyList properties_;

	}
	:	{rule_begin ();}
		"{"
		(flag=attribute_content_arbitrary_group_0[attribute_content_ret, attributes_, properties_]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{
			attribute_content_ret->set_attributes (attributes_);
			attribute_content_ret->set_properties (properties_);
		}
		{rule_end ();}
	;

attribute_content_arbitrary_group_0
	[
		Core::Box<AttributeContent>& attribute_content_ret
		, AttributeList& attributes_
		, PropertyList& properties_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Attribute> attributes_item;
		Core::Box<Property> properties_item;
	}
	
	:	{rule_begin ();}
		(	attributes_item=attribute {type = 0; attributes_.push_back (attributes_item);}
		|	properties_item=property {type = 0; properties_.push_back (properties_item);}
		)
		{rule_end ();}
	;



state_list returns [StateList state_list_ret]
	{
		Core::Box<State> item;
	}
	:	(item=state
		{
			state_list_ret.push_back (item);
		}
		)+
	;

state returns [Core::Box<State> state_ret]
	{
		state_ret = new State ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "content"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"state"
		state_group_0[state_ret]
		state_group_1[state_ret]
		(flag=state_arbitrary_group_2[state_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

state_group_0
	[Core::Box<State>& state_ret]
	{
		std::string name_;
	}
	
	:	{rule_begin ();}
		name_=identifier {state_ret->set_name (name_);}
		{rule_end ();}
	;

state_group_1
	[Core::Box<State>& state_ret]
	:	{rule_begin ();}
		"=>" guid_:STRING {state_ret->set_guid (guid_->getText ());}
		{rule_end ();}
	;

state_arbitrary_group_2
	[Core::Box<State>& state_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<StateContent> content_;
	}
	
	:	{rule_begin ();}
		"{" content_=state_content {type = 1 << 3; state_ret->set_content (content_);} "}"
		{rule_end ();}
	;



state_content returns [Core::Box<StateContent> state_content_ret]
	{
		state_content_ret = new StateContent ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "properties"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "transitions"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "actions"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		PropertyList properties_;
		TransitionList transitions_;
		StateActionList actions_;

	}
	:	{rule_begin ();}
		(flag=state_content_arbitrary_group_0[state_content_ret, properties_, transitions_, actions_]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		{
			state_content_ret->set_properties (properties_);
			state_content_ret->set_transitions (transitions_);
			state_content_ret->set_actions (actions_);
		}
		{rule_end ();}
	;

state_content_arbitrary_group_0
	[
		Core::Box<StateContent>& state_content_ret
		, PropertyList& properties_
		, TransitionList& transitions_
		, StateActionList& actions_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Property> properties_item;
		Core::Box<Transition> transitions_item;
		Core::Box<StateAction> actions_item;
	}
	
	:	{rule_begin ();}
		(	properties_item=property {type = 0; properties_.push_back (properties_item);}
		|	transitions_item=transition {type = 0; transitions_.push_back (transitions_item);}
		|	actions_item=state_action {type = 0; actions_.push_back (actions_item);}
		)
		{rule_end ();}
	;



transition_list returns [TransitionList transition_list_ret]
	{
		Core::Box<Transition> item;
	}
	:	(item=transition
		{
			transition_list_ret.push_back (item);
		}
		)+
	;

transition returns [Core::Box<Transition> transition_ret]
	{
		transition_ret = new Transition ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "target_state_name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "content"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"transition" "to"
		transition_group_0[transition_ret]
		transition_group_1[transition_ret]
		(flag=transition_arbitrary_group_2[transition_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

transition_group_0
	[Core::Box<Transition>& transition_ret]
	{
		std::string target_state_name_;
	}
	
	:	{rule_begin ();}
		target_state_name_=identifier {transition_ret->set_target_state_name (target_state_name_);}
		{rule_end ();}
	;

transition_group_1
	[Core::Box<Transition>& transition_ret]
	:	{rule_begin ();}
		"=>" guid_:STRING {transition_ret->set_guid (guid_->getText ());}
		{rule_end ();}
	;

transition_arbitrary_group_2
	[Core::Box<Transition>& transition_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<TransitionContent> content_;
	}
	
	:	{rule_begin ();}
		content_=transition_content {type = 1 << 3; transition_ret->set_content (content_);}
		{rule_end ();}
	;



transition_content returns [Core::Box<TransitionContent> transition_content_ret]
	{
		transition_content_ret = new TransitionContent ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "condition"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "action"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "guard"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "event"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"{"
		(flag=transition_content_arbitrary_group_0[transition_content_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{rule_end ();}
	;

transition_content_arbitrary_group_0
	[Core::Box<TransitionContent>& transition_content_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<TransitionParamBase> condition_;
		Core::Box<TransitionParamBase> action_;
		Core::Box<TransitionParamBase> guard_;
		Core::Box<TransitionParamBase> event_;
	}
	
	:	{rule_begin ();}
		(	"condition" condition_=transition_param_base {type = 1 << 1; transition_content_ret->set_condition (condition_);} ";"
		|	"action" action_=transition_param_base {type = 1 << 2; transition_content_ret->set_action (action_);} ";"
		|	"guard" guard_=transition_param_base {type = 1 << 3; transition_content_ret->set_guard (guard_);} ";"
		|	"event" event_=transition_param_base {type = 1 << 4; transition_content_ret->set_event (event_);} ";"
		)
		{rule_end ();}
	;



transition_param_base returns [Core::Box<TransitionParamBase> transition_param_base_ret]
	{
		transition_param_base_ret = new TransitionParamBase ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		transition_param_base_group_0[transition_param_base_ret]
		transition_param_base_group_1[transition_param_base_ret]
		{rule_end ();}
	;

transition_param_base_group_0
	[Core::Box<TransitionParamBase>& transition_param_base_ret]
	:	{rule_begin ();}
		name_:STRING {transition_param_base_ret->set_name (name_->getText ());}
		{rule_end ();}
	;

transition_param_base_group_1
	[Core::Box<TransitionParamBase>& transition_param_base_ret]
	:	{rule_begin ();}
		"=>" guid_:STRING {transition_param_base_ret->set_guid (guid_->getText ());}
		{rule_end ();}
	;



state_action_list returns [StateActionList state_action_list_ret]
	{
		Core::Box<StateAction> item;
	}
	:	(item=state_action
		{
			state_action_list_ret.push_back (item);
		}
		)+
	;

state_action returns [Core::Box<StateAction> state_action_ret]
	{
		state_action_ret = new StateAction ();
		unsigned long accumulated_flag_prev_1 = 0;
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "guid"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "properties"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "type"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		PropertyList properties_;

	}
	:	{rule_begin ();}
		state_action_group_prev_1[state_action_ret]

		"action"
		state_action_group_0[state_action_ret]
		state_action_group_1[state_action_ret]
		(flag=state_action_arbitrary_group_2[state_action_ret, properties_]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{
			state_action_ret->set_properties (properties_);
		}
		{rule_end ();}
	;

state_action_group_prev_1
	[Core::Box<StateAction>& state_action_ret]
	{
		ModelPartDef::ActionType type_;
	}
	
	:	{rule_begin ();}
		type_=action_type {state_action_ret->set_type (type_);}
		{rule_end ();}
	;

state_action_group_0
	[Core::Box<StateAction>& state_action_ret]
	:	{rule_begin ();}
		name_:STRING {state_action_ret->set_name (name_->getText ());}
		{rule_end ();}
	;

state_action_group_1
	[Core::Box<StateAction>& state_action_ret]
	:	{rule_begin ();}
		guid_:STRING {state_action_ret->set_guid (guid_->getText ());}
		{rule_end ();}
	;

state_action_arbitrary_group_2
	[
		Core::Box<StateAction>& state_action_ret
		, PropertyList& properties_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Property> properties_item;
	}
	
	:	{rule_begin ();}
		"{" (properties_item=property {type = 0; properties_.push_back (properties_item);})+ "}"
		{rule_end ();}
	;



action_type returns [ModelPartDef::ActionType action_type_ret]
:	"entry" {action_type_ret = ModelPartDef::AT_ENTRY;}
	| "exit" {action_type_ret = ModelPartDef::AT_EXIT;}
	| "do" {action_type_ret = ModelPartDef::AT_DO;}
;

package_list returns [PackageList package_list_ret]
	{
		Core::Box<Package> item;
	}
	:	(item=package
		{
			package_list_ret.push_back (item);
		}
		)+
	;

identifier returns [std::string ret]
	:	s:STRING {ret = s->getText ();}
		| i:IDENTIFIER {ret = i->getText ();}
	;




class AdditionalPartLexer extends Lexer;
options {
	k = 2;
	testLiterals = false;
	charVocabulary = '\003'..'\377'
					;
}
ALL_POST_AND_PREFIXES
	options {testLiterals=true;}
	:	"=>"
	|"::"
	|"}"
	|"{"
	|"="
	|";"
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

SPEC_ARBITRARY_STRING0
	:	"<<"! (~('>'))+ ">>"!
	;

IDENTIFIER
	options {testLiterals=true;}
	:	('\300'..'\377'|'a'..'z'|'A'..'Z'|'_') ('\300'..'\377'|'a'..'z'|'A'..'Z'|'0'..'9'|'_')*
	;

UNSIGNED
	: ('0'..'9')+
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
