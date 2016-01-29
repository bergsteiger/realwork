header "pre_include_hpp" {
#include "shared/Core/sys/std_inc.h"
}

header "post_include_hpp" {
#include "MDProcess/MDAFormat/ModelPartDef/Attribute.h"
#include "MDProcess/MDAFormat/ModelPartDef/AttributeContent.h"
#include "MDProcess/MDAFormat/ModelPartDef/Class.h"
#include "MDProcess/MDAFormat/ModelPartDef/ClassContent.h"
#include "MDProcess/MDAFormat/ModelPartDef/Dependency.h"
#include "MDProcess/MDAFormat/ModelPartDef/Message.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
#include "MDProcess/MDAFormat/ModelPartDef/Namespace.h"
#include "MDProcess/MDAFormat/ModelPartDef/Operation.h"
#include "MDProcess/MDAFormat/ModelPartDef/OperationArgument.h"
#include "MDProcess/MDAFormat/ModelPartDef/Package.h"
#include "MDProcess/MDAFormat/ModelPartDef/ReturnMessage.h"
#include "MDProcess/MDAFormat/ModelPartDef/RootPackage.h"
#include "MDProcess/MDAFormat/ModelPartDef/SelfMessage.h"
#include "MDProcess/MDAFormat/ModelPartDef/SequenceStartObject.h"
#include "MDProcess/MDAFormat/ModelPartDef/State.h"
#include "MDProcess/MDAFormat/ModelPartDef/StateAction.h"
#include "MDProcess/MDAFormat/ModelPartDef/Transition.h"
#include "MDProcess/MDAFormat/ModelPartDef/UserProperty.h"

#include <boost/lexical_cast.hpp>
#include <vector>
#include <map>
}
options {
	language = "Cpp";
	genHashLines=false;
	namespace = "MDAFormat::ModelPartDef";
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

	ModelPartParser::Context::Context () {
	}
	
	Core::Box<RootPackage> ModelPartParser::Context::find_context (const std::string& key) const {
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
	
	const std::vector<Core::Box<RootPackage> >& ModelPartParser::Context::get_root_level () const {
		return m_root_level;
	}
	
	void ModelPartParser::Context::add_root (const Core::Box<RootPackage>& new_root) {
		m_root_level.push_back (new_root);
	}
	
	void ModelPartParser::Context::on_namespace (const std::string& ns) {
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
	
	void ModelPartParser::Context::on_new_element (Core::Box<RootPackage>& new_element) {
		if (m_context.is_nil ()) {
			add_root (new_element);
		} else {
			
		}
	}
	
	ModelPartParser::Context::reset_context () {
		m_context = 0;
	}
	
	Core::Box<RootPackage> ModelPartParser::Context::create_new_context (const std::string& key) {
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

	void ModelPartParser::rule_begin () {
		this->reset_error_stack ();
	}
	
	void ModelPartParser::rule_end () {
		this->reset_error_stack ();
	}
}
class ModelPartParser extends Parser;
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "namepsaces"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "root"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		NamespaceList namepsaces_;

	}
	:	{rule_begin ();}
		(flag=root_package_arbitrary_group_0[root_package_ret, namepsaces_]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		root_package_group_1[root_package_ret]
		{
			root_package_ret->set_namepsaces (namepsaces_);
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
		, NamespaceList& namepsaces_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Namespace> namepsaces_item;
	}
	
	:	{rule_begin ();}
		namepsaces_item=namespace_ {type = 0; namepsaces_.push_back (namepsaces_item);}
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "stereotype"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "native"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "global"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "visibility"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 6, "nested_packages"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 7, "user_properties"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 8, "dependencies"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 9, "classes"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		PackageList nested_packages_;
		UserPropertyList user_properties_;
		DependencyList dependencies_;
		ClassList classes_;

	}
	:	{rule_begin ();}
		(flag=package_arbitrary_group_prev_1[package_ret]
		{accumulated_flag_prev_1 = check_attribute_originality (accumulated_flag_prev_1, flag, LT (1), local::get_descriptions ());}

		)*

		"package"
		package_group_0[package_ret]
		package_group_1[package_ret]
		(flag=package_arbitrary_group_2[package_ret, nested_packages_, user_properties_, dependencies_, classes_]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		"}" ";"
		{
			package_ret->set_nested_packages (nested_packages_);
			package_ret->set_user_properties (user_properties_);
			package_ret->set_dependencies (dependencies_);
			package_ret->set_classes (classes_);
		}
		{rule_end ();}
	;

package_group_0
	[Core::Box<Package>& package_ret]
	:	{rule_begin ();}
		stereotype_:SPEC_ARBITRARY_STRING1 {package_ret->set_stereotype (stereotype_->getText ());}
		{rule_end ();}
	;

package_group_1
	[Core::Box<Package>& package_ret]
	{
		std::string name_;
	}
	
	:	{rule_begin ();}
		name_=identifier {package_ret->set_name (name_);} "{"
		{rule_end ();}
	;

package_arbitrary_group_prev_1
	[Core::Box<Package>& package_ret]
	returns [unsigned long type = 0]
	{
		VisibilityType visibility_;
	}
	
	:	{rule_begin ();}
		(	"native" {type = 1 << 3; package_ret->set_native (true);}
		|	"global" {type = 1 << 4; package_ret->set_global (true);}
		|	visibility_=visibility_type {type = 1 << 5; package_ret->set_visibility (visibility_);}
		)
		{rule_end ();}
	;

package_arbitrary_group_2
	[
		Core::Box<Package>& package_ret
		, PackageList& nested_packages_
		, UserPropertyList& user_properties_
		, DependencyList& dependencies_
		, ClassList& classes_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Package> nested_packages_item;
		Core::Box<UserProperty> user_properties_item;
		Core::Box<Dependency> dependencies_item;
		Core::Box<Class> classes_item;
	}
	
	:	{rule_begin ();}
		(	(package) => nested_packages_item=package {type = 0; nested_packages_.push_back (nested_packages_item);}
		|	(user_property) => user_properties_item=user_property {type = 0; user_properties_.push_back (user_properties_item);}
		|	(dependency) => dependencies_item=dependency {type = 0; dependencies_.push_back (dependencies_item);}
		|	(class_) => classes_item=class_ {type = 0; classes_.push_back (classes_item);}
		)
		{rule_end ();}
	;



visibility_type returns [VisibilityType visibility_type_ret]
:	"public" {visibility_type_ret = VT_PUBLIC;}
	| "protected" {visibility_type_ret = VT_PROTECTED;}
	| "private" {visibility_type_ret = VT_PRIVATE;}
	| "implemented" {visibility_type_ret = VT_IMPLEMENTED;}
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

user_property_list returns [UserPropertyList user_property_list_ret]
	{
		Core::Box<UserProperty> item;
	}
	:	(item=user_property
		{
			user_property_list_ret.push_back (item);
		}
		)+
	;

user_property returns [Core::Box<UserProperty> user_property_ret]
	{
		user_property_ret = new UserProperty ();
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
		"up"
		user_property_group_0[user_property_ret]
		(flag=user_property_arbitrary_group_1[user_property_ret]
		{accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{rule_end ();}
	;

user_property_group_0
	[Core::Box<UserProperty>& user_property_ret]
	:	{rule_begin ();}
		name_:STRING {user_property_ret->set_name (name_->getText ());}
		{rule_end ();}
	;

user_property_arbitrary_group_1
	[Core::Box<UserProperty>& user_property_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		"=" value_:STRING {type = 1 << 2; user_property_ret->set_value (value_->getText ());}
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
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "stereotype"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "target_full_name"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"dependency"
		(flag=dependency_arbitrary_group_0[dependency_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		dependency_group_1[dependency_ret]
		";"
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

dependency_arbitrary_group_0
	[Core::Box<Dependency>& dependency_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		stereotype_:SPEC_ARBITRARY_STRING1 {type = 1 << 1; dependency_ret->set_stereotype (stereotype_->getText ());}
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
		unsigned long accumulated_flag_prev_2 = 0;
		unsigned long accumulated_flag_prev_1 = 0;
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "native"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "abstractiveness"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "visibility"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "stereotype"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 6, "extends_list"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 7, "implements_list"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 8, "template_params"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 9, "content"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		StringList extends_list_;
		StringList implements_list_;
		ArgumentList template_params_;

	}
	:	{rule_begin ();}
		(flag=class__arbitrary_group_prev_2[class_ret, template_params_]
		{accumulated_flag_prev_2 = check_attribute_originality (accumulated_flag_prev_2, flag, LT (1), local::get_descriptions ());}

		)*
		(flag=class__arbitrary_group_prev_1[class_ret]
		{accumulated_flag_prev_1 = check_attribute_originality (accumulated_flag_prev_1, flag, LT (1), local::get_descriptions ());}

		)*

		"class"
		class__group_0[class_ret]
		class__group_1[class_ret]
		(flag=class__arbitrary_group_2[class_ret, extends_list_, implements_list_]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		class__group_3[class_ret]
		";"
		{
			class_ret->set_extends_list (extends_list_);
			class_ret->set_implements_list (implements_list_);
			class_ret->set_template_params (template_params_);
		}
		{rule_end ();}
	;

class__group_0
	[Core::Box<Class>& class_ret]
	:	{rule_begin ();}
		stereotype_:SPEC_ARBITRARY_STRING1 {class_ret->set_stereotype (stereotype_->getText ());}
		{rule_end ();}
	;

class__group_1
	[Core::Box<Class>& class_ret]
	{
		std::string name_;
	}
	
	:	{rule_begin ();}
		name_=identifier {class_ret->set_name (name_);}
		{rule_end ();}
	;

class__group_3
	[Core::Box<Class>& class_ret]
	{
		Core::Box<ClassContent> content_;
	}
	
	:	{rule_begin ();}
		"{" content_=class_content {class_ret->set_content (*content_);} "}"
		{rule_end ();}
	;

class__arbitrary_group_prev_2
	[
		Core::Box<Class>& class_ret
		, ArgumentList& template_params_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<OperationArgument> template_params_item;
	}
	
	:	{rule_begin ();}
		"template" "<" template_params_item=operation_argument {type = 0; template_params_.push_back (template_params_item);} ("," template_params_item=operation_argument {type = 0; template_params_.push_back (template_params_item);})* ">"
		{rule_end ();}
	;

class__arbitrary_group_prev_1
	[Core::Box<Class>& class_ret]
	returns [unsigned long type = 0]
	{
		AbstractionType abstractiveness_;
		VisibilityType visibility_;
	}
	
	:	{rule_begin ();}
		(	"native" {type = 1 << 1; class_ret->set_native (true);}
		|	abstractiveness_=abstraction_type {type = 1 << 2; class_ret->set_abstractiveness (abstractiveness_);}
		|	visibility_=visibility_type {type = 1 << 3; class_ret->set_visibility (visibility_);}
		)
		{rule_end ();}
	;

class__arbitrary_group_2
	[
		Core::Box<Class>& class_ret
		, StringList& extends_list_
		, StringList& implements_list_
	]
	returns [unsigned long type = 0]
	{
		std::string extends_list_item;
		std::string implements_list_item;
	}
	
	:	{rule_begin ();}
		(	"extends" extends_list_item=identifier {type = 0; extends_list_.push_back (extends_list_item);} ("," extends_list_item=identifier {type = 0; extends_list_.push_back (extends_list_item);})*
		|	"implements" implements_list_item=identifier {type = 0; implements_list_.push_back (implements_list_item);} ("," implements_list_item=identifier {type = 0; implements_list_.push_back (implements_list_item);})*
		)
		{rule_end ();}
	;



abstraction_type returns [AbstractionType abstraction_type_ret]
:	"regular" {abstraction_type_ret = AT_REGULAR;}
	| "abstract" {abstraction_type_ret = AT_ABSTRACT;}
	| "final" {abstraction_type_ret = AT_FINAL;}
;

string_list returns [StringList string_list_ret]
	{
		std::string item;
	}
	:	(item=identifier
		{
			string_list_ret.push_back (item);
		}
		)+
	;

argument_list returns [ArgumentList argument_list_ret]
	{
		Core::Box<OperationArgument> item;
	}
	:	(item=operation_argument
		{
			argument_list_ret.push_back (item);
		}
		)+
	;

operation_argument returns [Core::Box<OperationArgument> operation_argument_ret]
	{
		operation_argument_ret = new OperationArgument ();
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "qualifier"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "target_full_name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "init_value"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		(flag=operation_argument_arbitrary_group_0[operation_argument_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		operation_argument_group_1[operation_argument_ret]
		(flag=operation_argument_arbitrary_group_2[operation_argument_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		(flag=operation_argument_arbitrary_group_3[operation_argument_ret]
		{accumulated_flag_3 = check_attribute_originality (accumulated_flag_3, flag, LT (1), local::get_descriptions ());}

		)*
		{rule_end ();}
	;

operation_argument_group_1
	[Core::Box<OperationArgument>& operation_argument_ret]
	{
		std::string name_;
	}
	
	:	{rule_begin ();}
		name_=identifier {operation_argument_ret->set_name (name_);}
		{rule_end ();}
	;

operation_argument_arbitrary_group_0
	[Core::Box<OperationArgument>& operation_argument_ret]
	returns [unsigned long type = 0]
	{
		ArgumentQualifier qualifier_;
	}
	
	:	{rule_begin ();}
		qualifier_=argument_qualifier {type = 1 << 1; operation_argument_ret->set_qualifier (qualifier_);}
		{rule_end ();}
	;

operation_argument_arbitrary_group_2
	[Core::Box<OperationArgument>& operation_argument_ret]
	returns [unsigned long type = 0]
	{
		std::string target_full_name_;
	}
	
	:	{rule_begin ();}
		":" target_full_name_=identifier {type = 1 << 3; operation_argument_ret->set_target_full_name (target_full_name_);}
		{rule_end ();}
	;

operation_argument_arbitrary_group_3
	[Core::Box<OperationArgument>& operation_argument_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		"=" init_value_:STRING {type = 1 << 4; operation_argument_ret->set_init_value (init_value_->getText ());}
		{rule_end ();}
	;



argument_qualifier returns [ArgumentQualifier argument_qualifier_ret]
:	"in" {argument_qualifier_ret = AQ_IN;}
	| "inout" {argument_qualifier_ret = AQ_INOUT;}
	| "out" {argument_qualifier_ret = AQ_OUT;}
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "operations"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "user_properties"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "nested_classes"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "dependencies"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "atttributes"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 6, "sequence_objects"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 7, "states"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		OperationList operations_;
		UserPropertyList user_properties_;
		ClassList nested_classes_;
		DependencyList dependencies_;
		AttributeList atttributes_;
		SequenceStartObjectList sequence_objects_;
		StateList states_;

	}
	:	{rule_begin ();}
		(flag=class_content_arbitrary_group_0[class_content_ret, operations_, user_properties_, nested_classes_, dependencies_, atttributes_, sequence_objects_, states_]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		{
			class_content_ret->set_operations (operations_);
			class_content_ret->set_user_properties (user_properties_);
			class_content_ret->set_nested_classes (nested_classes_);
			class_content_ret->set_dependencies (dependencies_);
			class_content_ret->set_atttributes (atttributes_);
			class_content_ret->set_sequence_objects (sequence_objects_);
			class_content_ret->set_states (states_);
		}
		{rule_end ();}
	;

class_content_arbitrary_group_0
	[
		Core::Box<ClassContent>& class_content_ret
		, OperationList& operations_
		, UserPropertyList& user_properties_
		, ClassList& nested_classes_
		, DependencyList& dependencies_
		, AttributeList& atttributes_
		, SequenceStartObjectList& sequence_objects_
		, StateList& states_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Operation> operations_item;
		Core::Box<UserProperty> user_properties_item;
		Core::Box<Class> nested_classes_item;
		Core::Box<Dependency> dependencies_item;
		Core::Box<Attribute> atttributes_item;
		Core::Box<SequenceStartObject> sequence_objects_item;
		Core::Box<State> states_item;
	}
	
	:	{rule_begin ();}
		(	(operation) => operations_item=operation {type = 0; operations_.push_back (operations_item);}
		|	(user_property) => user_properties_item=user_property {type = 0; user_properties_.push_back (user_properties_item);}
		|	(class_) => nested_classes_item=class_ {type = 0; nested_classes_.push_back (nested_classes_item);}
		|	(dependency) => dependencies_item=dependency {type = 0; dependencies_.push_back (dependencies_item);}
		|	(attribute) => atttributes_item=attribute {type = 0; atttributes_.push_back (atttributes_item);}
		|	(sequence_start_object) => sequence_objects_item=sequence_start_object {type = 0; sequence_objects_.push_back (sequence_objects_item);}
		|	(state) => states_item=state {type = 0; states_.push_back (states_item);}
		)
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
		unsigned long accumulated_flag_prev_2 = 0;
		unsigned long accumulated_flag_prev_1 = 0;
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long accumulated_flag_2 = 0;
		unsigned long accumulated_flag_3 = 0;
		unsigned long accumulated_flag_4 = 0;
		unsigned long accumulated_flag_5 = 0;
		unsigned long accumulated_flag_6 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "abstractiveness"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "visibility"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "stereotype"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "return_type"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "target_stereotype"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 6, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 7, "arguments"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 8, "exceptions"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 9, "user_properties"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		ArgumentList arguments_;
		StringList exceptions_;
		UserPropertyList user_properties_;

	}
	:	{rule_begin ();}
		(flag=operation_arbitrary_group_prev_2[operation_ret]
		{accumulated_flag_prev_2 = check_attribute_originality (accumulated_flag_prev_2, flag, LT (1), local::get_descriptions ());}

		)*
		(flag=operation_arbitrary_group_prev_1[operation_ret]
		{accumulated_flag_prev_1 = check_attribute_originality (accumulated_flag_prev_1, flag, LT (1), local::get_descriptions ());}

		)*

		"operation"
		(flag=operation_arbitrary_group_0[operation_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		operation_group_1[operation_ret]
		(flag=operation_arbitrary_group_2[operation_ret, arguments_]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		(flag=operation_arbitrary_group_3[operation_ret]
		{accumulated_flag_3 = check_attribute_originality (accumulated_flag_3, flag, LT (1), local::get_descriptions ());}

		)*
		(flag=operation_arbitrary_group_4[operation_ret]
		{accumulated_flag_4 = check_attribute_originality (accumulated_flag_4, flag, LT (1), local::get_descriptions ());}

		)*
		(flag=operation_arbitrary_group_5[operation_ret, exceptions_]
		{accumulated_flag_5 = check_attribute_originality (accumulated_flag_5, flag, LT (1), local::get_descriptions ());}

		)*
		(flag=operation_arbitrary_group_6[operation_ret, user_properties_]
		{accumulated_flag_6 = check_attribute_originality (accumulated_flag_6, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{
			operation_ret->set_arguments (arguments_);
			operation_ret->set_exceptions (exceptions_);
			operation_ret->set_user_properties (user_properties_);
		}
		{rule_end ();}
	;

operation_group_1
	[Core::Box<Operation>& operation_ret]
	{
		std::string name_;
	}
	
	:	{rule_begin ();}
		name_=identifier {operation_ret->set_name (name_);}
		{rule_end ();}
	;

operation_arbitrary_group_prev_2
	[Core::Box<Operation>& operation_ret]
	returns [unsigned long type = 0]
	{
		VisibilityType visibility_;
	}
	
	:	{rule_begin ();}
		visibility_=visibility_type {type = 1 << 2; operation_ret->set_visibility (visibility_);}
		{rule_end ();}
	;

operation_arbitrary_group_prev_1
	[Core::Box<Operation>& operation_ret]
	returns [unsigned long type = 0]
	{
		AbstractionType abstractiveness_;
	}
	
	:	{rule_begin ();}
		abstractiveness_=abstraction_type {type = 1 << 1; operation_ret->set_abstractiveness (abstractiveness_);}
		{rule_end ();}
	;

operation_arbitrary_group_0
	[Core::Box<Operation>& operation_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		stereotype_:SPEC_ARBITRARY_STRING1 {type = 1 << 3; operation_ret->set_stereotype (stereotype_->getText ());}
		{rule_end ();}
	;

operation_arbitrary_group_2
	[
		Core::Box<Operation>& operation_ret
		, ArgumentList& arguments_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<OperationArgument> arguments_item;
	}
	
	:	{rule_begin ();}
		"(" arguments_item=operation_argument {type = 0; arguments_.push_back (arguments_item);} ("," arguments_item=operation_argument {type = 0; arguments_.push_back (arguments_item);})* ")"
		{rule_end ();}
	;

operation_arbitrary_group_3
	[Core::Box<Operation>& operation_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		":" return_type_:STRING {type = 1 << 4; operation_ret->set_return_type (return_type_->getText ());}
		{rule_end ();}
	;

operation_arbitrary_group_4
	[Core::Box<Operation>& operation_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		target_stereotype_:SPEC_ARBITRARY_STRING0 {type = 1 << 5; operation_ret->set_target_stereotype (target_stereotype_->getText ());}
		{rule_end ();}
	;

operation_arbitrary_group_5
	[
		Core::Box<Operation>& operation_ret
		, StringList& exceptions_
	]
	returns [unsigned long type = 0]
	{
		std::string exceptions_item;
	}
	
	:	{rule_begin ();}
		"throws" exceptions_item=identifier {type = 0; exceptions_.push_back (exceptions_item);} ("," exceptions_item=identifier {type = 0; exceptions_.push_back (exceptions_item);})*
		{rule_end ();}
	;

operation_arbitrary_group_6
	[
		Core::Box<Operation>& operation_ret
		, UserPropertyList& user_properties_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<UserProperty> user_properties_item;
	}
	
	:	{rule_begin ();}
		"{" (user_properties_item=user_property {type = 0; user_properties_.push_back (user_properties_item);})+ "}"
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
		unsigned long accumulated_flag_prev_2 = 0;
		unsigned long accumulated_flag_0 = 0;
		unsigned long accumulated_flag_1 = 0;
		unsigned long accumulated_flag_2 = 0;
		unsigned long accumulated_flag_3 = 0;
		unsigned long accumulated_flag_4 = 0;
		unsigned long accumulated_flag_5 = 0;
		unsigned long accumulated_flag_6 = 0;
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "visibility"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "abstractiveness"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "link_type"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "stereotype"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 6, "target_type"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 7, "init_value"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 8, "target_stereotype"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 9, "set_exceptions"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 10, "get_excpetions"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 11, "content"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		StringList set_exceptions_;
		StringList get_excpetions_;

	}
	:	{rule_begin ();}
		(flag=attribute_arbitrary_group_prev_2[attribute_ret]
		{accumulated_flag_prev_2 = check_attribute_originality (accumulated_flag_prev_2, flag, LT (1), local::get_descriptions ());}

		)*

		"attribute"
		(flag=attribute_arbitrary_group_0[attribute_ret]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		(flag=attribute_arbitrary_group_1[attribute_ret]
		{accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());}

		)*
		(flag=attribute_arbitrary_group_2[attribute_ret]
		{accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());}

		)*
		(flag=attribute_arbitrary_group_3[attribute_ret]
		{accumulated_flag_3 = check_attribute_originality (accumulated_flag_3, flag, LT (1), local::get_descriptions ());}

		)*
		(flag=attribute_arbitrary_group_4[attribute_ret]
		{accumulated_flag_4 = check_attribute_originality (accumulated_flag_4, flag, LT (1), local::get_descriptions ());}

		)*
		(flag=attribute_arbitrary_group_5[attribute_ret, set_exceptions_, get_excpetions_]
		{accumulated_flag_5 = check_attribute_originality (accumulated_flag_5, flag, LT (1), local::get_descriptions ());}

		)*
		(flag=attribute_arbitrary_group_6[attribute_ret]
		{accumulated_flag_6 = check_attribute_originality (accumulated_flag_6, flag, LT (1), local::get_descriptions ());}

		)*
		";"
		{
			attribute_ret->set_set_exceptions (set_exceptions_);
			attribute_ret->set_get_excpetions (get_excpetions_);
		}
		{rule_end ();}
	;

attribute_arbitrary_group_prev_2
	[Core::Box<Attribute>& attribute_ret]
	returns [unsigned long type = 0]
	{
		VisibilityType visibility_;
		AbstractionType abstractiveness_;
		LinkType link_type_;
	}
	
	:	{rule_begin ();}
		(	visibility_=visibility_type {type = 1 << 1; attribute_ret->set_visibility (visibility_);}
		|	abstractiveness_=abstraction_type {type = 1 << 2; attribute_ret->set_abstractiveness (abstractiveness_);}
		|	link_type_=link_type {type = 1 << 3; attribute_ret->set_link_type (link_type_);}
		)
		{rule_end ();}
	;

attribute_arbitrary_group_0
	[Core::Box<Attribute>& attribute_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		stereotype_:SPEC_ARBITRARY_STRING1 {type = 1 << 4; attribute_ret->set_stereotype (stereotype_->getText ());}
		{rule_end ();}
	;

attribute_arbitrary_group_1
	[Core::Box<Attribute>& attribute_ret]
	returns [unsigned long type = 0]
	{
		std::string name_;
	}
	
	:	{rule_begin ();}
		name_=identifier {type = 1 << 5; attribute_ret->set_name (name_);}
		{rule_end ();}
	;

attribute_arbitrary_group_2
	[Core::Box<Attribute>& attribute_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		":" target_type_:STRING {type = 1 << 6; attribute_ret->set_target_type (target_type_->getText ());}
		{rule_end ();}
	;

attribute_arbitrary_group_3
	[Core::Box<Attribute>& attribute_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		"=" init_value_:STRING {type = 1 << 7; attribute_ret->set_init_value (init_value_->getText ());}
		{rule_end ();}
	;

attribute_arbitrary_group_4
	[Core::Box<Attribute>& attribute_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		target_stereotype_:SPEC_ARBITRARY_STRING0 {type = 1 << 8; attribute_ret->set_target_stereotype (target_stereotype_->getText ());}
		{rule_end ();}
	;

attribute_arbitrary_group_5
	[
		Core::Box<Attribute>& attribute_ret
		, StringList& set_exceptions_
		, StringList& get_excpetions_
	]
	returns [unsigned long type = 0]
	{
		std::string set_exceptions_item;
		std::string get_excpetions_item;
	}
	
	:	{rule_begin ();}
		(	("throws" "set" ":") => "throws" "set" ":" set_exceptions_item=identifier {type = 0; set_exceptions_.push_back (set_exceptions_item);} ("," set_exceptions_item=identifier {type = 0; set_exceptions_.push_back (set_exceptions_item);})*
		|	("throws" "get" ":") => "throws" "get" ":" get_excpetions_item=identifier {type = 0; get_excpetions_.push_back (get_excpetions_item);} ("," get_excpetions_item=identifier {type = 0; get_excpetions_.push_back (get_excpetions_item);})*
		)
		{rule_end ();}
	;

attribute_arbitrary_group_6
	[Core::Box<Attribute>& attribute_ret]
	returns [unsigned long type = 0]
	{
		Core::Box<AttributeContent> content_;
	}
	
	:	{rule_begin ();}
		content_=attribute_content {type = 1 << 11; attribute_ret->set_content (content_);}
		{rule_end ();}
	;



link_type returns [LinkType link_type_ret]
:	"agr" {link_type_ret = LT_AGREGATION;}
	| "ref" {link_type_ret = LT_REFERENCE;}
	| "lnk" {link_type_ret = LT_LINK;}
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "keys"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "user_properties"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		AttributeList keys_;
		UserPropertyList user_properties_;

	}
	:	{rule_begin ();}
		"{"
		(flag=attribute_content_arbitrary_group_0[attribute_content_ret, keys_, user_properties_]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		"}"
		{
			attribute_content_ret->set_keys (keys_);
			attribute_content_ret->set_user_properties (user_properties_);
		}
		{rule_end ();}
	;

attribute_content_arbitrary_group_0
	[
		Core::Box<AttributeContent>& attribute_content_ret
		, AttributeList& keys_
		, UserPropertyList& user_properties_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<Attribute> keys_item;
		Core::Box<UserProperty> user_properties_item;
	}
	
	:	{rule_begin ();}
		(	keys_item=attribute {type = 0; keys_.push_back (keys_item);}
		|	user_properties_item=user_property {type = 0; user_properties_.push_back (user_properties_item);}
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
		unsigned long accumulated_flag_prev_2 = 0;
		unsigned long accumulated_flag_prev_1 = 0;
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "class_name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "object_name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "self_messages"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "messages"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "return_messages"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		SelfMessageList self_messages_;
		MessageList messages_;
		ReturnMessageList return_messages_;

	}
	:	{rule_begin ();}
		sequence_start_object_group_prev_2[sequence_start_object_ret]
		(flag=sequence_start_object_arbitrary_group_prev_1[sequence_start_object_ret]
		{accumulated_flag_prev_1 = check_attribute_originality (accumulated_flag_prev_1, flag, LT (1), local::get_descriptions ());}

		)*

		"{"
		(flag=sequence_start_object_arbitrary_group_0[sequence_start_object_ret, self_messages_, messages_, return_messages_]
		{accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());}

		)*
		"}" ";"
		{
			sequence_start_object_ret->set_self_messages (self_messages_);
			sequence_start_object_ret->set_messages (messages_);
			sequence_start_object_ret->set_return_messages (return_messages_);
		}
		{rule_end ();}
	;

sequence_start_object_group_prev_2
	[Core::Box<SequenceStartObject>& sequence_start_object_ret]
	{
		std::string class_name_;
	}
	
	:	{rule_begin ();}
		class_name_=identifier {sequence_start_object_ret->set_class_name (class_name_);}
		{rule_end ();}
	;

sequence_start_object_arbitrary_group_prev_1
	[Core::Box<SequenceStartObject>& sequence_start_object_ret]
	returns [unsigned long type = 0]
	{
		std::string object_name_;
	}
	
	:	{rule_begin ();}
		"(" object_name_=identifier {type = 1 << 2; sequence_start_object_ret->set_object_name (object_name_);} ")"
		{rule_end ();}
	;

sequence_start_object_arbitrary_group_0
	[
		Core::Box<SequenceStartObject>& sequence_start_object_ret
		, SelfMessageList& self_messages_
		, MessageList& messages_
		, ReturnMessageList& return_messages_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<SelfMessage> self_messages_item;
		Core::Box<Message> messages_item;
		Core::Box<ReturnMessage> return_messages_item;
	}
	
	:	{rule_begin ();}
		(	self_messages_item=self_message {type = 0; self_messages_.push_back (self_messages_item);}
		|	messages_item=message {type = 0; messages_.push_back (messages_item);}
		|	return_messages_item=return_message {type = 0; return_messages_.push_back (return_messages_item);}
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
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"this"
		self_message_group_0[self_message_ret]
		";"
		{rule_end ();}
	;

self_message_group_0
	[Core::Box<SelfMessage>& self_message_ret]
	:	{rule_begin ();}
		"::" operation_:STRING {self_message_ret->set_operation (operation_->getText ());}
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "operation"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "self_messages"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "messages"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 6, "return_messages"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		SelfMessageList self_messages_;
		MessageList messages_;
		ReturnMessageList return_messages_;

	}
	:	{rule_begin ();}
		message_group_0[message_ret]
		(flag=message_arbitrary_group_1[message_ret]
		{accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());}

		)*
		message_group_2[message_ret]
		(flag=message_arbitrary_group_3[message_ret, self_messages_, messages_, return_messages_]
		{accumulated_flag_3 = check_attribute_originality (accumulated_flag_3, flag, LT (1), local::get_descriptions ());}

		)*
		"}" ";"
		{
			message_ret->set_self_messages (self_messages_);
			message_ret->set_messages (messages_);
			message_ret->set_return_messages (return_messages_);
		}
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
		"::" operation_:STRING {message_ret->set_operation (operation_->getText ());} "{"
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

message_arbitrary_group_3
	[
		Core::Box<Message>& message_ret
		, SelfMessageList& self_messages_
		, MessageList& messages_
		, ReturnMessageList& return_messages_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<SelfMessage> self_messages_item;
		Core::Box<Message> messages_item;
		Core::Box<ReturnMessage> return_messages_item;
	}
	
	:	{rule_begin ();}
		(	self_messages_item=self_message {type = 0; self_messages_.push_back (self_messages_item);}
		|	messages_item=message {type = 0; messages_.push_back (messages_item);}
		|	return_messages_item=return_message {type = 0; return_messages_.push_back (return_messages_item);}
		)
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
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		"return"
		return_message_group_0[return_message_ret]
		";"
		{rule_end ();}
	;

return_message_group_0
	[Core::Box<ReturnMessage>& return_message_ret]
	:	{rule_begin ();}
		result_:STRING {return_message_ret->set_result (result_->getText ());}
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
		unsigned long accumulated_flag_prev_1 = 0;
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "type"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "actions"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "transitions"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
		StateActionList actions_;
		TransitionList transitions_;

	}
	:	{rule_begin ();}
		(flag=state_arbitrary_group_prev_1[state_ret]
		{accumulated_flag_prev_1 = check_attribute_originality (accumulated_flag_prev_1, flag, LT (1), local::get_descriptions ());}

		)*

		"state"
		state_group_0[state_ret]
		(flag=state_arbitrary_group_1[state_ret, actions_, transitions_]
		{accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());}

		)*
		"}" ";"
		{
			state_ret->set_actions (actions_);
			state_ret->set_transitions (transitions_);
		}
		{rule_end ();}
	;

state_group_0
	[Core::Box<State>& state_ret]
	{
		std::string name_;
	}
	
	:	{rule_begin ();}
		name_=identifier {state_ret->set_name (name_);} "{"
		{rule_end ();}
	;

state_arbitrary_group_prev_1
	[Core::Box<State>& state_ret]
	returns [unsigned long type = 0]
	{
		StateType type_;
	}
	
	:	{rule_begin ();}
		type_=state_type {type = 1 << 1; state_ret->set_type (type_);}
		{rule_end ();}
	;

state_arbitrary_group_1
	[
		Core::Box<State>& state_ret
		, StateActionList& actions_
		, TransitionList& transitions_
	]
	returns [unsigned long type = 0]
	{
		Core::Box<StateAction> actions_item;
		Core::Box<Transition> transitions_item;
	}
	
	:	{rule_begin ();}
		(	actions_item=state_action {type = 0; actions_.push_back (actions_item);}
		|	transitions_item=transition {type = 0; transitions_.push_back (transitions_item);}
		)
		{rule_end ();}
	;



state_type returns [StateType state_type_ret]
:	"normal" {state_type_ret = ST_NORMAL;}
	| "final" {state_type_ret = ST_FINAL;}
	| "start" {state_type_ret = ST_START;}
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
		unsigned long flag = 0;
		class local {
		public:
			static const DescriptionMap& get_descriptions () {
				static local helper;
				
				return helper.get_attribute_descriptions ();
			}
		private:
			local () {
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "type"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "name"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		state_action_group_prev_1[state_action_ret]

		"action"
		state_action_group_0[state_action_ret]
		";"
		{rule_end ();}
	;

state_action_group_prev_1
	[Core::Box<StateAction>& state_action_ret]
	{
		ActionType type_;
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



action_type returns [ActionType action_type_ret]
:	"entry" {action_type_ret = AT_ENTRY;}
	| "exit" {action_type_ret = AT_EXIT;}
	| "do" {action_type_ret = AT_DO;}
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
		unsigned long accumulated_flag_prev_1 = 0;
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
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 1, "stereotype"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 2, "target_name"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 3, "condition"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 4, "guard"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 5, "action"));
				m_descriptions_map.insert (DescriptionMap::value_type (1 << 6, "event"));
				
			}
			
			const DescriptionMap& get_attribute_descriptions () {
				return m_descriptions_map;
			}
		private:
			DescriptionMap m_descriptions_map;
		};
	}
	:	{rule_begin ();}
		(flag=transition_arbitrary_group_prev_1[transition_ret]
		{accumulated_flag_prev_1 = check_attribute_originality (accumulated_flag_prev_1, flag, LT (1), local::get_descriptions ());}

		)*

		"transition" "to"
		transition_group_0[transition_ret]
		(flag=transition_arbitrary_group_1[transition_ret]
		{accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());}

		)*
		"}" ";"
		{rule_end ();}
	;

transition_group_0
	[Core::Box<Transition>& transition_ret]
	{
		std::string target_name_;
	}
	
	:	{rule_begin ();}
		target_name_=identifier {transition_ret->set_target_name (target_name_);} "{"
		{rule_end ();}
	;

transition_arbitrary_group_prev_1
	[Core::Box<Transition>& transition_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		stereotype_:SPEC_ARBITRARY_STRING1 {type = 1 << 1; transition_ret->set_stereotype (stereotype_->getText ());}
		{rule_end ();}
	;

transition_arbitrary_group_1
	[Core::Box<Transition>& transition_ret]
	returns [unsigned long type = 0]
	:	{rule_begin ();}
		(	"condition" condition_:STRING {type = 1 << 3; transition_ret->set_condition (condition_->getText ());} ";"
		|	"guard" guard_:STRING {type = 1 << 4; transition_ret->set_guard (guard_->getText ());} ";"
		|	"action" action_:STRING {type = 1 << 5; transition_ret->set_action (action_->getText ());} ";"
		|	"event" event_:STRING {type = 1 << 6; transition_ret->set_event (event_->getText ());} ";"
		)
		{rule_end ();}
	;



identifier returns [std::string ret]
	:	s:STRING {ret = s->getText ();}
		| i:IDENTIFIER {ret = i->getText ();}
	;




class ModelPartLexer extends Lexer;
options {
	k = 2;
	testLiterals = false;
	charVocabulary = '\003'..'\377'
					;
}
ALL_POST_AND_PREFIXES
	options {testLiterals=true;}
	:	"::"
	|"}"
	|"{"
	|">"
	|"="
	|"<"
	|";"
	|":"
	|","
	|")"
	|"("
	;

COMMENT
	:	//#UC START# *48A965B701C6*
		//from ANTLR examples JAVA grammar
		(
			"//" (~('\n'|'\r'))* ('\n'|'\r'('\n')?)?
			{
				{_ttype = ANTLR_USE_NAMESPACE(antlr)Token::SKIP;}
				newline();
			}
		|	"/*"
			(	/*	'\r' '\n' can be matched in one alternative or by matching
					'\r' in one iteration and '\n' in another.  I am trying to
					handle any flavor of newline that comes in, but the language
					that allows both "\r\n" and "\r" and "\n" to all be valid
					newline is ambiguous.  Consequently, the resulting grammar
					must be ambiguous.  I'm shutting this warning off.
				 */
				options {
					generateAmbigWarnings=false;
				}
			:
				{ LA(2)!='/' }? '*'
			|	'\r' '\n'		{newline();}
			|	'\r'			{newline();}
			|	'\n'			{newline();}
			|	~('*'|'\n'|'\r')
			)*
			"*/"
			{_ttype = ANTLR_USE_NAMESPACE(antlr)Token::SKIP;}
		)	
		//#UC END# *48A965B701C6*
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

SPEC_ARBITRARY_STRING1
	:	"<<"! (~('>'))+ ">>"!
	;

SPEC_ARBITRARY_STRING0
	:	"["! (~(']'))+ "]"!
	;

IDENTIFIER
	options {testLiterals=true;}
	:	('\300'..'\377'|'a'..'z'|'A'..'Z'|'_') ('\300'..'\377'|'a'..'z'|'A'..'Z'|'0'..'9'|'_')*
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
