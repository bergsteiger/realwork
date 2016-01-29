/* $ANTLR 2.7.7 (20060930): "ModelPart.cpp.g" -> "ModelPartParser.cpp"$ */
#include "ModelPartParser.hpp"
#include <antlr/NoViableAltException.hpp>
#include <antlr/SemanticException.hpp>
#include <antlr/ASTFactory.hpp>
ANTLR_BEGIN_NAMESPACE(MDAFormat)
ANTLR_BEGIN_NAMESPACE(ModelPartDef)

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

ModelPartParser::ModelPartParser(ANTLR_USE_NAMESPACE(antlr)TokenBuffer& tokenBuf, int k)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(tokenBuf,k)
{
}

ModelPartParser::ModelPartParser(ANTLR_USE_NAMESPACE(antlr)TokenBuffer& tokenBuf)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(tokenBuf,1)
{
}

ModelPartParser::ModelPartParser(ANTLR_USE_NAMESPACE(antlr)TokenStream& lexer, int k)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(lexer,k)
{
}

ModelPartParser::ModelPartParser(ANTLR_USE_NAMESPACE(antlr)TokenStream& lexer)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(lexer,1)
{
}

ModelPartParser::ModelPartParser(const ANTLR_USE_NAMESPACE(antlr)ParserSharedInputState& state)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(state,1)
{
}

Core::Box<RootPackage>  ModelPartParser::root_package() {
	Core::Box<RootPackage> root_package_ret;
	
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == LITERAL_namespace)) {
			flag=root_package_arbitrary_group_0(*root_package_ret, namepsaces_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop3;
		}
		
	}
	_loop3:;
	} // ( ... )*
	root_package_group_1(*root_package_ret);
	if ( inputState->guessing==0 ) {
		
					root_package_ret->namepsaces (namepsaces_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return root_package_ret;
}

unsigned long  ModelPartParser::root_package_arbitrary_group_0(
	
		RootPackage& root_package_ret
		, NamespaceList& namepsaces_
	
) {
	unsigned long type;
	
			Core::Box<Namespace> namepsaces_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	namepsaces_item=namespace_();
	if ( inputState->guessing==0 ) {
		type = 0; namepsaces_.push_back (namepsaces_item);
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

void ModelPartParser::root_package_group_1(
	RootPackage& root_package_ret
) {
	
			Core::Box<Package> root_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	root_=package();
	if ( inputState->guessing==0 ) {
		root_package_ret.root (*root_);
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

Core::Box<Package>  ModelPartParser::package() {
	Core::Box<Package> package_ret;
	
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{ // ( ... )*
	for (;;) {
		if (((LA(1) >= LITERAL_native && LA(1) <= LITERAL_implemented))) {
			flag=package_arbitrary_group_prev_1(*package_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_prev_1 = check_attribute_originality (accumulated_flag_prev_1, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop13;
		}
		
	}
	_loop13:;
	} // ( ... )*
	match(LITERAL_package);
	package_group_0(*package_ret);
	package_group_1(*package_ret);
	{ // ( ... )*
	for (;;) {
		if ((_tokenSet_0.member(LA(1)))) {
			flag=package_arbitrary_group_2(*package_ret, nested_packages_, user_properties_, dependencies_, classes_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop15;
		}
		
	}
	_loop15:;
	} // ( ... )*
	match(7);
	match(5);
	if ( inputState->guessing==0 ) {
		
					package_ret->nested_packages (nested_packages_);
					package_ret->user_properties (user_properties_);
					package_ret->dependencies (dependencies_);
					package_ret->classes (classes_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return package_ret;
}

Core::Box<Namespace>  ModelPartParser::namespace_() {
	Core::Box<Namespace> namespace_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_namespace);
	namespace__group_0(*namespace_ret);
	match(5);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return namespace_ret;
}

NamespaceList  ModelPartParser::namespace_list() {
	NamespaceList namespace_list_ret;
	
			Core::Box<Namespace> item;
		
	
	{ // ( ... )+
	int _cnt8=0;
	for (;;) {
		if ((LA(1) == LITERAL_namespace)) {
			item=namespace_();
			if ( inputState->guessing==0 ) {
				
							namespace_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt8>=1 ) { goto _loop8; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt8++;
	}
	_loop8:;
	}  // ( ... )+
	return namespace_list_ret;
}

void ModelPartParser::namespace__group_0(
	Namespace& namespace_ret
) {
	
			std::string name_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	name_=identifier();
	if ( inputState->guessing==0 ) {
		namespace_ret.name (name_);
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

std::string  ModelPartParser::identifier() {
	std::string ret;
	ANTLR_USE_NAMESPACE(antlr)RefToken  s = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  i = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	switch ( LA(1)) {
	case STRING:
	{
		s = LT(1);
		match(STRING);
		if ( inputState->guessing==0 ) {
			ret = s->getText ();
		}
		break;
	}
	case IDENTIFIER:
	{
		i = LT(1);
		match(IDENTIFIER);
		if ( inputState->guessing==0 ) {
			ret = i->getText ();
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	return ret;
}

unsigned long  ModelPartParser::package_arbitrary_group_prev_1(
	Package& package_ret
) {
	unsigned long type;
	
			VisibilityType visibility_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_native:
	{
		match(LITERAL_native);
		if ( inputState->guessing==0 ) {
			type = 1 << 3; package_ret.native (true);
		}
		break;
	}
	case LITERAL_global:
	{
		match(LITERAL_global);
		if ( inputState->guessing==0 ) {
			type = 1 << 4; package_ret.global (true);
		}
		break;
	}
	case LITERAL_public:
	case LITERAL_protected:
	case LITERAL_private:
	case LITERAL_implemented:
	{
		visibility_=visibility_type();
		if ( inputState->guessing==0 ) {
			type = 1 << 5; package_ret.visibility (visibility_);
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

void ModelPartParser::package_group_0(
	Package& package_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  stereotype_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	stereotype_ = LT(1);
	match(SPEC_ARBITRARY_STRING1);
	if ( inputState->guessing==0 ) {
		package_ret.stereotype (stereotype_->getText ());
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ModelPartParser::package_group_1(
	Package& package_ret
) {
	
			std::string name_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	name_=identifier();
	if ( inputState->guessing==0 ) {
		package_ret.name (name_);
	}
	match(9);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ModelPartParser::package_arbitrary_group_2(
	
		Package& package_ret
		, PackageList& nested_packages_
		, UserPropertyList& user_properties_
		, DependencyList& dependencies_
		, ClassList& classes_
	
) {
	unsigned long type;
	
			Core::Box<Package> nested_packages_item;
			Core::Box<UserProperty> user_properties_item;
			Core::Box<Dependency> dependencies_item;
			Core::Box<Class> classes_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_up:
	{
		user_properties_item=user_property();
		if ( inputState->guessing==0 ) {
			type = 0; user_properties_.push_back (user_properties_item);
		}
		break;
	}
	case LITERAL_dependency:
	{
		dependencies_item=dependency();
		if ( inputState->guessing==0 ) {
			type = 0; dependencies_.push_back (dependencies_item);
		}
		break;
	}
	default:
		bool synPredMatched23 = false;
		if (((_tokenSet_1.member(LA(1))))) {
			int _m23 = mark();
			synPredMatched23 = true;
			inputState->guessing++;
			try {
				{
				package();
				}
			}
			catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
				synPredMatched23 = false;
			}
			rewind(_m23);
			inputState->guessing--;
		}
		if ( synPredMatched23 ) {
			nested_packages_item=package();
			if ( inputState->guessing==0 ) {
				type = 0; nested_packages_.push_back (nested_packages_item);
			}
		}
		else {
			bool synPredMatched29 = false;
			if (((_tokenSet_2.member(LA(1))))) {
				int _m29 = mark();
				synPredMatched29 = true;
				inputState->guessing++;
				try {
					{
					class_();
					}
				}
				catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
					synPredMatched29 = false;
				}
				rewind(_m29);
				inputState->guessing--;
			}
			if ( synPredMatched29 ) {
				classes_item=class_();
				if ( inputState->guessing==0 ) {
					type = 0; classes_.push_back (classes_item);
				}
			}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}}
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

VisibilityType  ModelPartParser::visibility_type() {
	VisibilityType visibility_type_ret;
	
	switch ( LA(1)) {
	case LITERAL_public:
	{
		match(LITERAL_public);
		if ( inputState->guessing==0 ) {
			visibility_type_ret = VT_PUBLIC;
		}
		break;
	}
	case LITERAL_protected:
	{
		match(LITERAL_protected);
		if ( inputState->guessing==0 ) {
			visibility_type_ret = VT_PROTECTED;
		}
		break;
	}
	case LITERAL_private:
	{
		match(LITERAL_private);
		if ( inputState->guessing==0 ) {
			visibility_type_ret = VT_PRIVATE;
		}
		break;
	}
	case LITERAL_implemented:
	{
		match(LITERAL_implemented);
		if ( inputState->guessing==0 ) {
			visibility_type_ret = VT_IMPLEMENTED;
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	return visibility_type_ret;
}

Core::Box<UserProperty>  ModelPartParser::user_property() {
	Core::Box<UserProperty> user_property_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_up);
	user_property_group_0(*user_property_ret);
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == 18)) {
			flag=user_property_arbitrary_group_1(*user_property_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop39;
		}
		
	}
	_loop39:;
	} // ( ... )*
	match(5);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return user_property_ret;
}

Core::Box<Dependency>  ModelPartParser::dependency() {
	Core::Box<Dependency> dependency_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_dependency);
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == SPEC_ARBITRARY_STRING1)) {
			flag=dependency_arbitrary_group_0(*dependency_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop47;
		}
		
	}
	_loop47:;
	} // ( ... )*
	dependency_group_1(*dependency_ret);
	match(5);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return dependency_ret;
}

Core::Box<Class>  ModelPartParser::class_() {
	Core::Box<Class> class_ret;
	
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == LITERAL_template)) {
			flag=class__arbitrary_group_prev_2(*class_ret, template_params_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_prev_2 = check_attribute_originality (accumulated_flag_prev_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop55;
		}
		
	}
	_loop55:;
	} // ( ... )*
	{ // ( ... )*
	for (;;) {
		if ((_tokenSet_3.member(LA(1)))) {
			flag=class__arbitrary_group_prev_1(*class_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_prev_1 = check_attribute_originality (accumulated_flag_prev_1, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop57;
		}
		
	}
	_loop57:;
	} // ( ... )*
	match(LITERAL_class);
	class__group_0(*class_ret);
	class__group_1(*class_ret);
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == LITERAL_extends || LA(1) == LITERAL_implements)) {
			flag=class__arbitrary_group_2(*class_ret, extends_list_, implements_list_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop59;
		}
		
	}
	_loop59:;
	} // ( ... )*
	class__group_3(*class_ret);
	match(5);
	if ( inputState->guessing==0 ) {
		
					class_ret->extends_list (extends_list_);
					class_ret->implements_list (implements_list_);
					class_ret->template_params (template_params_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return class_ret;
}

PackageList  ModelPartParser::package_list() {
	PackageList package_list_ret;
	
			Core::Box<Package> item;
		
	
	{ // ( ... )+
	int _cnt33=0;
	for (;;) {
		if ((_tokenSet_1.member(LA(1)))) {
			item=package();
			if ( inputState->guessing==0 ) {
				
							package_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt33>=1 ) { goto _loop33; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt33++;
	}
	_loop33:;
	}  // ( ... )+
	return package_list_ret;
}

UserPropertyList  ModelPartParser::user_property_list() {
	UserPropertyList user_property_list_ret;
	
			Core::Box<UserProperty> item;
		
	
	{ // ( ... )+
	int _cnt36=0;
	for (;;) {
		if ((LA(1) == LITERAL_up)) {
			item=user_property();
			if ( inputState->guessing==0 ) {
				
							user_property_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt36>=1 ) { goto _loop36; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt36++;
	}
	_loop36:;
	}  // ( ... )+
	return user_property_list_ret;
}

void ModelPartParser::user_property_group_0(
	UserProperty& user_property_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  name_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	name_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		user_property_ret.name (name_->getText ());
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ModelPartParser::user_property_arbitrary_group_1(
	UserProperty& user_property_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  value_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(18);
	value_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		type = 1 << 2; user_property_ret.value (value_->getText ());
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

DependencyList  ModelPartParser::dependency_list() {
	DependencyList dependency_list_ret;
	
			Core::Box<Dependency> item;
		
	
	{ // ( ... )+
	int _cnt44=0;
	for (;;) {
		if ((LA(1) == LITERAL_dependency)) {
			item=dependency();
			if ( inputState->guessing==0 ) {
				
							dependency_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt44>=1 ) { goto _loop44; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt44++;
	}
	_loop44:;
	}  // ( ... )+
	return dependency_list_ret;
}

unsigned long  ModelPartParser::dependency_arbitrary_group_0(
	Dependency& dependency_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  stereotype_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	stereotype_ = LT(1);
	match(SPEC_ARBITRARY_STRING1);
	if ( inputState->guessing==0 ) {
		type = 1 << 1; dependency_ret.stereotype (stereotype_->getText ());
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

void ModelPartParser::dependency_group_1(
	Dependency& dependency_ret
) {
	
			std::string target_full_name_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	target_full_name_=identifier();
	if ( inputState->guessing==0 ) {
		dependency_ret.target_full_name (target_full_name_);
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

ClassList  ModelPartParser::class_list() {
	ClassList class_list_ret;
	
			Core::Box<Class> item;
		
	
	{ // ( ... )+
	int _cnt52=0;
	for (;;) {
		if ((_tokenSet_2.member(LA(1)))) {
			item=class_();
			if ( inputState->guessing==0 ) {
				
							class_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt52>=1 ) { goto _loop52; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt52++;
	}
	_loop52:;
	}  // ( ... )+
	return class_list_ret;
}

unsigned long  ModelPartParser::class__arbitrary_group_prev_2(
	
		Class& class_ret
		, ArgumentList& template_params_
	
) {
	unsigned long type;
	
			Core::Box<OperationArgument> template_params_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_template);
	match(22);
	template_params_item=operation_argument();
	if ( inputState->guessing==0 ) {
		type = 0; template_params_.push_back (template_params_item);
	}
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == 23)) {
			match(23);
			template_params_item=operation_argument();
			if ( inputState->guessing==0 ) {
				type = 0; template_params_.push_back (template_params_item);
			}
		}
		else {
			goto _loop65;
		}
		
	}
	_loop65:;
	} // ( ... )*
	match(24);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

unsigned long  ModelPartParser::class__arbitrary_group_prev_1(
	Class& class_ret
) {
	unsigned long type;
	
			AbstractionType abstractiveness_;
			VisibilityType visibility_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_native:
	{
		match(LITERAL_native);
		if ( inputState->guessing==0 ) {
			type = 1 << 1; class_ret.native (true);
		}
		break;
	}
	case LITERAL_regular:
	case LITERAL_abstract:
	case LITERAL_final:
	{
		abstractiveness_=abstraction_type();
		if ( inputState->guessing==0 ) {
			type = 1 << 2; class_ret.abstractiveness (abstractiveness_);
		}
		break;
	}
	case LITERAL_public:
	case LITERAL_protected:
	case LITERAL_private:
	case LITERAL_implemented:
	{
		visibility_=visibility_type();
		if ( inputState->guessing==0 ) {
			type = 1 << 3; class_ret.visibility (visibility_);
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

void ModelPartParser::class__group_0(
	Class& class_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  stereotype_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	stereotype_ = LT(1);
	match(SPEC_ARBITRARY_STRING1);
	if ( inputState->guessing==0 ) {
		class_ret.stereotype (stereotype_->getText ());
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ModelPartParser::class__group_1(
	Class& class_ret
) {
	
			std::string name_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	name_=identifier();
	if ( inputState->guessing==0 ) {
		class_ret.name (name_);
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ModelPartParser::class__arbitrary_group_2(
	
		Class& class_ret
		, StringList& extends_list_
		, StringList& implements_list_
	
) {
	unsigned long type;
	
			std::string extends_list_item;
			std::string implements_list_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_extends:
	{
		match(LITERAL_extends);
		extends_list_item=identifier();
		if ( inputState->guessing==0 ) {
			type = 0; extends_list_.push_back (extends_list_item);
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == 23)) {
				match(23);
				extends_list_item=identifier();
				if ( inputState->guessing==0 ) {
					type = 0; extends_list_.push_back (extends_list_item);
				}
			}
			else {
				goto _loop71;
			}
			
		}
		_loop71:;
		} // ( ... )*
		break;
	}
	case LITERAL_implements:
	{
		match(LITERAL_implements);
		implements_list_item=identifier();
		if ( inputState->guessing==0 ) {
			type = 0; implements_list_.push_back (implements_list_item);
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == 23)) {
				match(23);
				implements_list_item=identifier();
				if ( inputState->guessing==0 ) {
					type = 0; implements_list_.push_back (implements_list_item);
				}
			}
			else {
				goto _loop73;
			}
			
		}
		_loop73:;
		} // ( ... )*
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

void ModelPartParser::class__group_3(
	Class& class_ret
) {
	
			Core::Box<ClassContent> content_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(9);
	content_=class_content();
	if ( inputState->guessing==0 ) {
		class_ret.content (*content_);
	}
	match(7);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

Core::Box<ClassContent>  ModelPartParser::class_content() {
	Core::Box<ClassContent> class_content_ret;
	
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{ // ( ... )*
	for (;;) {
		if ((_tokenSet_4.member(LA(1)))) {
			flag=class_content_arbitrary_group_0(*class_content_ret, operations_, user_properties_, nested_classes_, dependencies_, atttributes_, sequence_objects_, states_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop95;
		}
		
	}
	_loop95:;
	} // ( ... )*
	if ( inputState->guessing==0 ) {
		
					class_content_ret->operations (operations_);
					class_content_ret->user_properties (user_properties_);
					class_content_ret->nested_classes (nested_classes_);
					class_content_ret->dependencies (dependencies_);
					class_content_ret->atttributes (atttributes_);
					class_content_ret->sequence_objects (sequence_objects_);
					class_content_ret->states (states_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return class_content_ret;
}

Core::Box<OperationArgument>  ModelPartParser::operation_argument() {
	Core::Box<OperationArgument> operation_argument_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{ // ( ... )*
	for (;;) {
		if (((LA(1) >= LITERAL_in && LA(1) <= LITERAL_out))) {
			flag=operation_argument_arbitrary_group_0(*operation_argument_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop83;
		}
		
	}
	_loop83:;
	} // ( ... )*
	operation_argument_group_1(*operation_argument_ret);
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == 30)) {
			flag=operation_argument_arbitrary_group_2(*operation_argument_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop85;
		}
		
	}
	_loop85:;
	} // ( ... )*
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == 18)) {
			flag=operation_argument_arbitrary_group_3(*operation_argument_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_3 = check_attribute_originality (accumulated_flag_3, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop87;
		}
		
	}
	_loop87:;
	} // ( ... )*
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return operation_argument_ret;
}

AbstractionType  ModelPartParser::abstraction_type() {
	AbstractionType abstraction_type_ret;
	
	switch ( LA(1)) {
	case LITERAL_regular:
	{
		match(LITERAL_regular);
		if ( inputState->guessing==0 ) {
			abstraction_type_ret = AT_REGULAR;
		}
		break;
	}
	case LITERAL_abstract:
	{
		match(LITERAL_abstract);
		if ( inputState->guessing==0 ) {
			abstraction_type_ret = AT_ABSTRACT;
		}
		break;
	}
	case LITERAL_final:
	{
		match(LITERAL_final);
		if ( inputState->guessing==0 ) {
			abstraction_type_ret = AT_FINAL;
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	return abstraction_type_ret;
}

StringList  ModelPartParser::string_list() {
	StringList string_list_ret;
	
			std::string item;
		
	
	{ // ( ... )+
	int _cnt77=0;
	for (;;) {
		if ((LA(1) == STRING || LA(1) == IDENTIFIER)) {
			item=identifier();
			if ( inputState->guessing==0 ) {
				
							string_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt77>=1 ) { goto _loop77; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt77++;
	}
	_loop77:;
	}  // ( ... )+
	return string_list_ret;
}

ArgumentList  ModelPartParser::argument_list() {
	ArgumentList argument_list_ret;
	
			Core::Box<OperationArgument> item;
		
	
	{ // ( ... )+
	int _cnt80=0;
	for (;;) {
		if ((_tokenSet_5.member(LA(1)))) {
			item=operation_argument();
			if ( inputState->guessing==0 ) {
				
							argument_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt80>=1 ) { goto _loop80; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt80++;
	}
	_loop80:;
	}  // ( ... )+
	return argument_list_ret;
}

unsigned long  ModelPartParser::operation_argument_arbitrary_group_0(
	OperationArgument& operation_argument_ret
) {
	unsigned long type;
	
			ArgumentQualifier qualifier_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	qualifier_=argument_qualifier();
	if ( inputState->guessing==0 ) {
		type = 1 << 1; operation_argument_ret.qualifier (qualifier_);
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

void ModelPartParser::operation_argument_group_1(
	OperationArgument& operation_argument_ret
) {
	
			std::string name_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	name_=identifier();
	if ( inputState->guessing==0 ) {
		operation_argument_ret.name (name_);
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ModelPartParser::operation_argument_arbitrary_group_2(
	OperationArgument& operation_argument_ret
) {
	unsigned long type;
	
			std::string target_full_name_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(30);
	target_full_name_=identifier();
	if ( inputState->guessing==0 ) {
		type = 1 << 3; operation_argument_ret.target_full_name (target_full_name_);
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

unsigned long  ModelPartParser::operation_argument_arbitrary_group_3(
	OperationArgument& operation_argument_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  init_value_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(18);
	init_value_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		type = 1 << 4; operation_argument_ret.init_value (init_value_->getText ());
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

ArgumentQualifier  ModelPartParser::argument_qualifier() {
	ArgumentQualifier argument_qualifier_ret;
	
	switch ( LA(1)) {
	case LITERAL_in:
	{
		match(LITERAL_in);
		if ( inputState->guessing==0 ) {
			argument_qualifier_ret = AQ_IN;
		}
		break;
	}
	case LITERAL_inout:
	{
		match(LITERAL_inout);
		if ( inputState->guessing==0 ) {
			argument_qualifier_ret = AQ_INOUT;
		}
		break;
	}
	case LITERAL_out:
	{
		match(LITERAL_out);
		if ( inputState->guessing==0 ) {
			argument_qualifier_ret = AQ_OUT;
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	return argument_qualifier_ret;
}

unsigned long  ModelPartParser::class_content_arbitrary_group_0(
	
		ClassContent& class_content_ret
		, OperationList& operations_
		, UserPropertyList& user_properties_
		, ClassList& nested_classes_
		, DependencyList& dependencies_
		, AttributeList& atttributes_
		, SequenceStartObjectList& sequence_objects_
		, StateList& states_
	
) {
	unsigned long type;
	
			Core::Box<Operation> operations_item;
			Core::Box<UserProperty> user_properties_item;
			Core::Box<Class> nested_classes_item;
			Core::Box<Dependency> dependencies_item;
			Core::Box<Attribute> atttributes_item;
			Core::Box<SequenceStartObject> sequence_objects_item;
			Core::Box<State> states_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_up:
	{
		user_properties_item=user_property();
		if ( inputState->guessing==0 ) {
			type = 0; user_properties_.push_back (user_properties_item);
		}
		break;
	}
	case LITERAL_dependency:
	{
		dependencies_item=dependency();
		if ( inputState->guessing==0 ) {
			type = 0; dependencies_.push_back (dependencies_item);
		}
		break;
	}
	case STRING:
	case IDENTIFIER:
	{
		sequence_objects_item=sequence_start_object();
		if ( inputState->guessing==0 ) {
			type = 0; sequence_objects_.push_back (sequence_objects_item);
		}
		break;
	}
	default:
		bool synPredMatched99 = false;
		if (((_tokenSet_6.member(LA(1))))) {
			int _m99 = mark();
			synPredMatched99 = true;
			inputState->guessing++;
			try {
				{
				operation();
				}
			}
			catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
				synPredMatched99 = false;
			}
			rewind(_m99);
			inputState->guessing--;
		}
		if ( synPredMatched99 ) {
			operations_item=operation();
			if ( inputState->guessing==0 ) {
				type = 0; operations_.push_back (operations_item);
			}
		}
		else {
			bool synPredMatched103 = false;
			if (((_tokenSet_2.member(LA(1))))) {
				int _m103 = mark();
				synPredMatched103 = true;
				inputState->guessing++;
				try {
					{
					class_();
					}
				}
				catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
					synPredMatched103 = false;
				}
				rewind(_m103);
				inputState->guessing--;
			}
			if ( synPredMatched103 ) {
				nested_classes_item=class_();
				if ( inputState->guessing==0 ) {
					type = 0; nested_classes_.push_back (nested_classes_item);
				}
			}
			else {
				bool synPredMatched107 = false;
				if (((_tokenSet_7.member(LA(1))))) {
					int _m107 = mark();
					synPredMatched107 = true;
					inputState->guessing++;
					try {
						{
						attribute();
						}
					}
					catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
						synPredMatched107 = false;
					}
					rewind(_m107);
					inputState->guessing--;
				}
				if ( synPredMatched107 ) {
					atttributes_item=attribute();
					if ( inputState->guessing==0 ) {
						type = 0; atttributes_.push_back (atttributes_item);
					}
				}
				else {
					bool synPredMatched111 = false;
					if (((_tokenSet_8.member(LA(1))))) {
						int _m111 = mark();
						synPredMatched111 = true;
						inputState->guessing++;
						try {
							{
							state();
							}
						}
						catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
							synPredMatched111 = false;
						}
						rewind(_m111);
						inputState->guessing--;
					}
					if ( synPredMatched111 ) {
						states_item=state();
						if ( inputState->guessing==0 ) {
							type = 0; states_.push_back (states_item);
						}
					}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}}}}
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

Core::Box<Operation>  ModelPartParser::operation() {
	Core::Box<Operation> operation_ret;
	
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{ // ( ... )*
	for (;;) {
		if (((LA(1) >= LITERAL_public && LA(1) <= LITERAL_implemented))) {
			flag=operation_arbitrary_group_prev_2(*operation_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_prev_2 = check_attribute_originality (accumulated_flag_prev_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop117;
		}
		
	}
	_loop117:;
	} // ( ... )*
	{ // ( ... )*
	for (;;) {
		if (((LA(1) >= LITERAL_regular && LA(1) <= LITERAL_final))) {
			flag=operation_arbitrary_group_prev_1(*operation_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_prev_1 = check_attribute_originality (accumulated_flag_prev_1, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop119;
		}
		
	}
	_loop119:;
	} // ( ... )*
	match(LITERAL_operation);
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == SPEC_ARBITRARY_STRING1)) {
			flag=operation_arbitrary_group_0(*operation_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop121;
		}
		
	}
	_loop121:;
	} // ( ... )*
	operation_group_1(*operation_ret);
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == 35)) {
			flag=operation_arbitrary_group_2(*operation_ret, arguments_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop123;
		}
		
	}
	_loop123:;
	} // ( ... )*
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == 30)) {
			flag=operation_arbitrary_group_3(*operation_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_3 = check_attribute_originality (accumulated_flag_3, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop125;
		}
		
	}
	_loop125:;
	} // ( ... )*
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == SPEC_ARBITRARY_STRING0)) {
			flag=operation_arbitrary_group_4(*operation_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_4 = check_attribute_originality (accumulated_flag_4, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop127;
		}
		
	}
	_loop127:;
	} // ( ... )*
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == LITERAL_throws)) {
			flag=operation_arbitrary_group_5(*operation_ret, exceptions_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_5 = check_attribute_originality (accumulated_flag_5, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop129;
		}
		
	}
	_loop129:;
	} // ( ... )*
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == 9)) {
			flag=operation_arbitrary_group_6(*operation_ret, user_properties_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_6 = check_attribute_originality (accumulated_flag_6, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop131;
		}
		
	}
	_loop131:;
	} // ( ... )*
	match(5);
	if ( inputState->guessing==0 ) {
		
					operation_ret->arguments (arguments_);
					operation_ret->exceptions (exceptions_);
					operation_ret->user_properties (user_properties_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return operation_ret;
}

Core::Box<Attribute>  ModelPartParser::attribute() {
	Core::Box<Attribute> attribute_ret;
	
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{ // ( ... )*
	for (;;) {
		if ((_tokenSet_9.member(LA(1)))) {
			flag=attribute_arbitrary_group_prev_2(*attribute_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_prev_2 = check_attribute_originality (accumulated_flag_prev_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop152;
		}
		
	}
	_loop152:;
	} // ( ... )*
	match(LITERAL_attribute);
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == SPEC_ARBITRARY_STRING1)) {
			flag=attribute_arbitrary_group_0(*attribute_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop154;
		}
		
	}
	_loop154:;
	} // ( ... )*
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == STRING || LA(1) == IDENTIFIER)) {
			flag=attribute_arbitrary_group_1(*attribute_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop156;
		}
		
	}
	_loop156:;
	} // ( ... )*
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == 30)) {
			flag=attribute_arbitrary_group_2(*attribute_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop158;
		}
		
	}
	_loop158:;
	} // ( ... )*
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == 18)) {
			flag=attribute_arbitrary_group_3(*attribute_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_3 = check_attribute_originality (accumulated_flag_3, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop160;
		}
		
	}
	_loop160:;
	} // ( ... )*
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == SPEC_ARBITRARY_STRING0)) {
			flag=attribute_arbitrary_group_4(*attribute_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_4 = check_attribute_originality (accumulated_flag_4, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop162;
		}
		
	}
	_loop162:;
	} // ( ... )*
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == LITERAL_throws)) {
			flag=attribute_arbitrary_group_5(*attribute_ret, set_exceptions_, get_excpetions_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_5 = check_attribute_originality (accumulated_flag_5, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop164;
		}
		
	}
	_loop164:;
	} // ( ... )*
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == 9)) {
			flag=attribute_arbitrary_group_6(*attribute_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_6 = check_attribute_originality (accumulated_flag_6, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop166;
		}
		
	}
	_loop166:;
	} // ( ... )*
	match(5);
	if ( inputState->guessing==0 ) {
		
					attribute_ret->set_exceptions (set_exceptions_);
					attribute_ret->get_excpetions (get_excpetions_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return attribute_ret;
}

Core::Box<SequenceStartObject>  ModelPartParser::sequence_start_object() {
	Core::Box<SequenceStartObject> sequence_start_object_ret;
	
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	sequence_start_object_group_prev_2(*sequence_start_object_ret);
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == 35)) {
			flag=sequence_start_object_arbitrary_group_prev_1(*sequence_start_object_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_prev_1 = check_attribute_originality (accumulated_flag_prev_1, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop196;
		}
		
	}
	_loop196:;
	} // ( ... )*
	match(9);
	{ // ( ... )*
	for (;;) {
		if ((_tokenSet_10.member(LA(1)))) {
			flag=sequence_start_object_arbitrary_group_0(*sequence_start_object_ret, self_messages_, messages_, return_messages_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop198;
		}
		
	}
	_loop198:;
	} // ( ... )*
	match(7);
	match(5);
	if ( inputState->guessing==0 ) {
		
					sequence_start_object_ret->self_messages (self_messages_);
					sequence_start_object_ret->messages (messages_);
					sequence_start_object_ret->return_messages (return_messages_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return sequence_start_object_ret;
}

Core::Box<State>  ModelPartParser::state() {
	Core::Box<State> state_ret;
	
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == LITERAL_final || LA(1) == LITERAL_normal || LA(1) == LITERAL_start)) {
			flag=state_arbitrary_group_prev_1(*state_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_prev_1 = check_attribute_originality (accumulated_flag_prev_1, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop231;
		}
		
	}
	_loop231:;
	} // ( ... )*
	match(LITERAL_state);
	state_group_0(*state_ret);
	{ // ( ... )*
	for (;;) {
		if ((_tokenSet_11.member(LA(1)))) {
			flag=state_arbitrary_group_1(*state_ret, actions_, transitions_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop233;
		}
		
	}
	_loop233:;
	} // ( ... )*
	match(7);
	match(5);
	if ( inputState->guessing==0 ) {
		
					state_ret->actions (actions_);
					state_ret->transitions (transitions_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return state_ret;
}

OperationList  ModelPartParser::operation_list() {
	OperationList operation_list_ret;
	
			Core::Box<Operation> item;
		
	
	{ // ( ... )+
	int _cnt114=0;
	for (;;) {
		if ((_tokenSet_6.member(LA(1)))) {
			item=operation();
			if ( inputState->guessing==0 ) {
				
							operation_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt114>=1 ) { goto _loop114; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt114++;
	}
	_loop114:;
	}  // ( ... )+
	return operation_list_ret;
}

unsigned long  ModelPartParser::operation_arbitrary_group_prev_2(
	Operation& operation_ret
) {
	unsigned long type;
	
			VisibilityType visibility_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	visibility_=visibility_type();
	if ( inputState->guessing==0 ) {
		type = 1 << 2; operation_ret.visibility (visibility_);
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

unsigned long  ModelPartParser::operation_arbitrary_group_prev_1(
	Operation& operation_ret
) {
	unsigned long type;
	
			AbstractionType abstractiveness_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	abstractiveness_=abstraction_type();
	if ( inputState->guessing==0 ) {
		type = 1 << 1; operation_ret.abstractiveness (abstractiveness_);
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

unsigned long  ModelPartParser::operation_arbitrary_group_0(
	Operation& operation_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  stereotype_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	stereotype_ = LT(1);
	match(SPEC_ARBITRARY_STRING1);
	if ( inputState->guessing==0 ) {
		type = 1 << 3; operation_ret.stereotype (stereotype_->getText ());
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

void ModelPartParser::operation_group_1(
	Operation& operation_ret
) {
	
			std::string name_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	name_=identifier();
	if ( inputState->guessing==0 ) {
		operation_ret.name (name_);
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ModelPartParser::operation_arbitrary_group_2(
	
		Operation& operation_ret
		, ArgumentList& arguments_
	
) {
	unsigned long type;
	
			Core::Box<OperationArgument> arguments_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(35);
	arguments_item=operation_argument();
	if ( inputState->guessing==0 ) {
		type = 0; arguments_.push_back (arguments_item);
	}
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == 23)) {
			match(23);
			arguments_item=operation_argument();
			if ( inputState->guessing==0 ) {
				type = 0; arguments_.push_back (arguments_item);
			}
		}
		else {
			goto _loop138;
		}
		
	}
	_loop138:;
	} // ( ... )*
	match(36);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

unsigned long  ModelPartParser::operation_arbitrary_group_3(
	Operation& operation_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  return_type_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(30);
	return_type_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		type = 1 << 4; operation_ret.return_type (return_type_->getText ());
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

unsigned long  ModelPartParser::operation_arbitrary_group_4(
	Operation& operation_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  target_stereotype_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	target_stereotype_ = LT(1);
	match(SPEC_ARBITRARY_STRING0);
	if ( inputState->guessing==0 ) {
		type = 1 << 5; operation_ret.target_stereotype (target_stereotype_->getText ());
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

unsigned long  ModelPartParser::operation_arbitrary_group_5(
	
		Operation& operation_ret
		, StringList& exceptions_
	
) {
	unsigned long type;
	
			std::string exceptions_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_throws);
	exceptions_item=identifier();
	if ( inputState->guessing==0 ) {
		type = 0; exceptions_.push_back (exceptions_item);
	}
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == 23)) {
			match(23);
			exceptions_item=identifier();
			if ( inputState->guessing==0 ) {
				type = 0; exceptions_.push_back (exceptions_item);
			}
		}
		else {
			goto _loop143;
		}
		
	}
	_loop143:;
	} // ( ... )*
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

unsigned long  ModelPartParser::operation_arbitrary_group_6(
	
		Operation& operation_ret
		, UserPropertyList& user_properties_
	
) {
	unsigned long type;
	
			Core::Box<UserProperty> user_properties_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(9);
	{ // ( ... )+
	int _cnt146=0;
	for (;;) {
		if ((LA(1) == LITERAL_up)) {
			user_properties_item=user_property();
			if ( inputState->guessing==0 ) {
				type = 0; user_properties_.push_back (user_properties_item);
			}
		}
		else {
			if ( _cnt146>=1 ) { goto _loop146; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt146++;
	}
	_loop146:;
	}  // ( ... )+
	match(7);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

AttributeList  ModelPartParser::attribute_list() {
	AttributeList attribute_list_ret;
	
			Core::Box<Attribute> item;
		
	
	{ // ( ... )+
	int _cnt149=0;
	for (;;) {
		if ((_tokenSet_7.member(LA(1)))) {
			item=attribute();
			if ( inputState->guessing==0 ) {
				
							attribute_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt149>=1 ) { goto _loop149; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt149++;
	}
	_loop149:;
	}  // ( ... )+
	return attribute_list_ret;
}

unsigned long  ModelPartParser::attribute_arbitrary_group_prev_2(
	Attribute& attribute_ret
) {
	unsigned long type;
	
			VisibilityType visibility_;
			AbstractionType abstractiveness_;
			LinkType link_type_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_public:
	case LITERAL_protected:
	case LITERAL_private:
	case LITERAL_implemented:
	{
		visibility_=visibility_type();
		if ( inputState->guessing==0 ) {
			type = 1 << 1; attribute_ret.visibility (visibility_);
		}
		break;
	}
	case LITERAL_regular:
	case LITERAL_abstract:
	case LITERAL_final:
	{
		abstractiveness_=abstraction_type();
		if ( inputState->guessing==0 ) {
			type = 1 << 2; attribute_ret.abstractiveness (abstractiveness_);
		}
		break;
	}
	case LITERAL_agr:
	case LITERAL_ref:
	case LITERAL_lnk:
	{
		link_type_=link_type();
		if ( inputState->guessing==0 ) {
			type = 1 << 3; attribute_ret.link_type (link_type_);
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

unsigned long  ModelPartParser::attribute_arbitrary_group_0(
	Attribute& attribute_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  stereotype_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	stereotype_ = LT(1);
	match(SPEC_ARBITRARY_STRING1);
	if ( inputState->guessing==0 ) {
		type = 1 << 4; attribute_ret.stereotype (stereotype_->getText ());
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

unsigned long  ModelPartParser::attribute_arbitrary_group_1(
	Attribute& attribute_ret
) {
	unsigned long type;
	
			std::string name_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	name_=identifier();
	if ( inputState->guessing==0 ) {
		type = 1 << 5; attribute_ret.name (name_);
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

unsigned long  ModelPartParser::attribute_arbitrary_group_2(
	Attribute& attribute_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  target_type_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(30);
	target_type_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		type = 1 << 6; attribute_ret.target_type (target_type_->getText ());
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

unsigned long  ModelPartParser::attribute_arbitrary_group_3(
	Attribute& attribute_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  init_value_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(18);
	init_value_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		type = 1 << 7; attribute_ret.init_value (init_value_->getText ());
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

unsigned long  ModelPartParser::attribute_arbitrary_group_4(
	Attribute& attribute_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  target_stereotype_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	target_stereotype_ = LT(1);
	match(SPEC_ARBITRARY_STRING0);
	if ( inputState->guessing==0 ) {
		type = 1 << 8; attribute_ret.target_stereotype (target_stereotype_->getText ());
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

unsigned long  ModelPartParser::attribute_arbitrary_group_5(
	
		Attribute& attribute_ret
		, StringList& set_exceptions_
		, StringList& get_excpetions_
	
) {
	unsigned long type;
	
			std::string set_exceptions_item;
			std::string get_excpetions_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	bool synPredMatched177 = false;
	if (((LA(1) == LITERAL_throws))) {
		int _m177 = mark();
		synPredMatched177 = true;
		inputState->guessing++;
		try {
			{
			match(LITERAL_throws);
			match(LITERAL_set);
			match(30);
			}
		}
		catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
			synPredMatched177 = false;
		}
		rewind(_m177);
		inputState->guessing--;
	}
	if ( synPredMatched177 ) {
		match(LITERAL_throws);
		match(LITERAL_set);
		match(30);
		set_exceptions_item=identifier();
		if ( inputState->guessing==0 ) {
			type = 0; set_exceptions_.push_back (set_exceptions_item);
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == 23)) {
				match(23);
				set_exceptions_item=identifier();
				if ( inputState->guessing==0 ) {
					type = 0; set_exceptions_.push_back (set_exceptions_item);
				}
			}
			else {
				goto _loop179;
			}
			
		}
		_loop179:;
		} // ( ... )*
	}
	else {
		bool synPredMatched181 = false;
		if (((LA(1) == LITERAL_throws))) {
			int _m181 = mark();
			synPredMatched181 = true;
			inputState->guessing++;
			try {
				{
				match(LITERAL_throws);
				match(LITERAL_get);
				match(30);
				}
			}
			catch (ANTLR_USE_NAMESPACE(antlr)RecognitionException& pe) {
				synPredMatched181 = false;
			}
			rewind(_m181);
			inputState->guessing--;
		}
		if ( synPredMatched181 ) {
			match(LITERAL_throws);
			match(LITERAL_get);
			match(30);
			get_excpetions_item=identifier();
			if ( inputState->guessing==0 ) {
				type = 0; get_excpetions_.push_back (get_excpetions_item);
			}
			{ // ( ... )*
			for (;;) {
				if ((LA(1) == 23)) {
					match(23);
					get_excpetions_item=identifier();
					if ( inputState->guessing==0 ) {
						type = 0; get_excpetions_.push_back (get_excpetions_item);
					}
				}
				else {
					goto _loop183;
				}
				
			}
			_loop183:;
			} // ( ... )*
		}
	else {
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

unsigned long  ModelPartParser::attribute_arbitrary_group_6(
	Attribute& attribute_ret
) {
	unsigned long type;
	
			Core::Box<AttributeContent> content_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	content_=attribute_content();
	if ( inputState->guessing==0 ) {
		type = 1 << 11; attribute_ret.content (content_);
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

LinkType  ModelPartParser::link_type() {
	LinkType link_type_ret;
	
	switch ( LA(1)) {
	case LITERAL_agr:
	{
		match(LITERAL_agr);
		if ( inputState->guessing==0 ) {
			link_type_ret = LT_AGREGATION;
		}
		break;
	}
	case LITERAL_ref:
	{
		match(LITERAL_ref);
		if ( inputState->guessing==0 ) {
			link_type_ret = LT_REFERENCE;
		}
		break;
	}
	case LITERAL_lnk:
	{
		match(LITERAL_lnk);
		if ( inputState->guessing==0 ) {
			link_type_ret = LT_LINK;
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	return link_type_ret;
}

Core::Box<AttributeContent>  ModelPartParser::attribute_content() {
	Core::Box<AttributeContent> attribute_content_ret;
	
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(9);
	{ // ( ... )*
	for (;;) {
		if ((_tokenSet_12.member(LA(1)))) {
			flag=attribute_content_arbitrary_group_0(*attribute_content_ret, keys_, user_properties_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop188;
		}
		
	}
	_loop188:;
	} // ( ... )*
	match(7);
	if ( inputState->guessing==0 ) {
		
					attribute_content_ret->keys (keys_);
					attribute_content_ret->user_properties (user_properties_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return attribute_content_ret;
}

unsigned long  ModelPartParser::attribute_content_arbitrary_group_0(
	
		AttributeContent& attribute_content_ret
		, AttributeList& keys_
		, UserPropertyList& user_properties_
	
) {
	unsigned long type;
	
			Core::Box<Attribute> keys_item;
			Core::Box<UserProperty> user_properties_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_public:
	case LITERAL_protected:
	case LITERAL_private:
	case LITERAL_implemented:
	case LITERAL_regular:
	case LITERAL_abstract:
	case LITERAL_final:
	case LITERAL_attribute:
	case LITERAL_agr:
	case LITERAL_ref:
	case LITERAL_lnk:
	{
		keys_item=attribute();
		if ( inputState->guessing==0 ) {
			type = 0; keys_.push_back (keys_item);
		}
		break;
	}
	case LITERAL_up:
	{
		user_properties_item=user_property();
		if ( inputState->guessing==0 ) {
			type = 0; user_properties_.push_back (user_properties_item);
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

SequenceStartObjectList  ModelPartParser::sequence_start_object_list() {
	SequenceStartObjectList sequence_start_object_list_ret;
	
			Core::Box<SequenceStartObject> item;
		
	
	{ // ( ... )+
	int _cnt193=0;
	for (;;) {
		if ((LA(1) == STRING || LA(1) == IDENTIFIER)) {
			item=sequence_start_object();
			if ( inputState->guessing==0 ) {
				
							sequence_start_object_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt193>=1 ) { goto _loop193; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt193++;
	}
	_loop193:;
	}  // ( ... )+
	return sequence_start_object_list_ret;
}

void ModelPartParser::sequence_start_object_group_prev_2(
	SequenceStartObject& sequence_start_object_ret
) {
	
			std::string class_name_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	class_name_=identifier();
	if ( inputState->guessing==0 ) {
		sequence_start_object_ret.class_name (class_name_);
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ModelPartParser::sequence_start_object_arbitrary_group_prev_1(
	SequenceStartObject& sequence_start_object_ret
) {
	unsigned long type;
	
			std::string object_name_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(35);
	object_name_=identifier();
	if ( inputState->guessing==0 ) {
		type = 1 << 2; sequence_start_object_ret.object_name (object_name_);
	}
	match(36);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

unsigned long  ModelPartParser::sequence_start_object_arbitrary_group_0(
	
		SequenceStartObject& sequence_start_object_ret
		, SelfMessageList& self_messages_
		, MessageList& messages_
		, ReturnMessageList& return_messages_
	
) {
	unsigned long type;
	
			Core::Box<SelfMessage> self_messages_item;
			Core::Box<Message> messages_item;
			Core::Box<ReturnMessage> return_messages_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_this:
	{
		self_messages_item=self_message();
		if ( inputState->guessing==0 ) {
			type = 0; self_messages_.push_back (self_messages_item);
		}
		break;
	}
	case STRING:
	case IDENTIFIER:
	{
		messages_item=message();
		if ( inputState->guessing==0 ) {
			type = 0; messages_.push_back (messages_item);
		}
		break;
	}
	case LITERAL_return:
	{
		return_messages_item=return_message();
		if ( inputState->guessing==0 ) {
			type = 0; return_messages_.push_back (return_messages_item);
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

Core::Box<SelfMessage>  ModelPartParser::self_message() {
	Core::Box<SelfMessage> self_message_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_this);
	self_message_group_0(*self_message_ret);
	match(5);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return self_message_ret;
}

Core::Box<Message>  ModelPartParser::message() {
	Core::Box<Message> message_ret;
	
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	message_group_0(*message_ret);
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == 35)) {
			flag=message_arbitrary_group_1(*message_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop213;
		}
		
	}
	_loop213:;
	} // ( ... )*
	message_group_2(*message_ret);
	{ // ( ... )*
	for (;;) {
		if ((_tokenSet_10.member(LA(1)))) {
			flag=message_arbitrary_group_3(*message_ret, self_messages_, messages_, return_messages_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_3 = check_attribute_originality (accumulated_flag_3, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop215;
		}
		
	}
	_loop215:;
	} // ( ... )*
	match(7);
	match(5);
	if ( inputState->guessing==0 ) {
		
					message_ret->self_messages (self_messages_);
					message_ret->messages (messages_);
					message_ret->return_messages (return_messages_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return message_ret;
}

Core::Box<ReturnMessage>  ModelPartParser::return_message() {
	Core::Box<ReturnMessage> return_message_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_return);
	return_message_group_0(*return_message_ret);
	match(5);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return return_message_ret;
}

SelfMessageList  ModelPartParser::self_message_list() {
	SelfMessageList self_message_list_ret;
	
			Core::Box<SelfMessage> item;
		
	
	{ // ( ... )+
	int _cnt205=0;
	for (;;) {
		if ((LA(1) == LITERAL_this)) {
			item=self_message();
			if ( inputState->guessing==0 ) {
				
							self_message_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt205>=1 ) { goto _loop205; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt205++;
	}
	_loop205:;
	}  // ( ... )+
	return self_message_list_ret;
}

void ModelPartParser::self_message_group_0(
	SelfMessage& self_message_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  operation_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(46);
	operation_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		self_message_ret.operation (operation_->getText ());
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

MessageList  ModelPartParser::message_list() {
	MessageList message_list_ret;
	
			Core::Box<Message> item;
		
	
	{ // ( ... )+
	int _cnt210=0;
	for (;;) {
		if ((LA(1) == STRING || LA(1) == IDENTIFIER)) {
			item=message();
			if ( inputState->guessing==0 ) {
				
							message_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt210>=1 ) { goto _loop210; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt210++;
	}
	_loop210:;
	}  // ( ... )+
	return message_list_ret;
}

void ModelPartParser::message_group_0(
	Message& message_ret
) {
	
			std::string class_name_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	class_name_=identifier();
	if ( inputState->guessing==0 ) {
		message_ret.class_name (class_name_);
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ModelPartParser::message_arbitrary_group_1(
	Message& message_ret
) {
	unsigned long type;
	
			std::string object_name_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(35);
	object_name_=identifier();
	if ( inputState->guessing==0 ) {
		type = 1 << 2; message_ret.object_name (object_name_);
	}
	match(36);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

void ModelPartParser::message_group_2(
	Message& message_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  operation_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(46);
	operation_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		message_ret.operation (operation_->getText ());
	}
	match(9);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ModelPartParser::message_arbitrary_group_3(
	
		Message& message_ret
		, SelfMessageList& self_messages_
		, MessageList& messages_
		, ReturnMessageList& return_messages_
	
) {
	unsigned long type;
	
			Core::Box<SelfMessage> self_messages_item;
			Core::Box<Message> messages_item;
			Core::Box<ReturnMessage> return_messages_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_this:
	{
		self_messages_item=self_message();
		if ( inputState->guessing==0 ) {
			type = 0; self_messages_.push_back (self_messages_item);
		}
		break;
	}
	case STRING:
	case IDENTIFIER:
	{
		messages_item=message();
		if ( inputState->guessing==0 ) {
			type = 0; messages_.push_back (messages_item);
		}
		break;
	}
	case LITERAL_return:
	{
		return_messages_item=return_message();
		if ( inputState->guessing==0 ) {
			type = 0; return_messages_.push_back (return_messages_item);
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

ReturnMessageList  ModelPartParser::return_message_list() {
	ReturnMessageList return_message_list_ret;
	
			Core::Box<ReturnMessage> item;
		
	
	{ // ( ... )+
	int _cnt223=0;
	for (;;) {
		if ((LA(1) == LITERAL_return)) {
			item=return_message();
			if ( inputState->guessing==0 ) {
				
							return_message_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt223>=1 ) { goto _loop223; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt223++;
	}
	_loop223:;
	}  // ( ... )+
	return return_message_list_ret;
}

void ModelPartParser::return_message_group_0(
	ReturnMessage& return_message_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  result_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	result_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		return_message_ret.result (result_->getText ());
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

StateList  ModelPartParser::state_list() {
	StateList state_list_ret;
	
			Core::Box<State> item;
		
	
	{ // ( ... )+
	int _cnt228=0;
	for (;;) {
		if ((_tokenSet_8.member(LA(1)))) {
			item=state();
			if ( inputState->guessing==0 ) {
				
							state_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt228>=1 ) { goto _loop228; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt228++;
	}
	_loop228:;
	}  // ( ... )+
	return state_list_ret;
}

unsigned long  ModelPartParser::state_arbitrary_group_prev_1(
	State& state_ret
) {
	unsigned long type;
	
			StateType type_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	type_=state_type();
	if ( inputState->guessing==0 ) {
		type = 1 << 1; state_ret.type (type_);
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

void ModelPartParser::state_group_0(
	State& state_ret
) {
	
			std::string name_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	name_=identifier();
	if ( inputState->guessing==0 ) {
		state_ret.name (name_);
	}
	match(9);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ModelPartParser::state_arbitrary_group_1(
	
		State& state_ret
		, StateActionList& actions_
		, TransitionList& transitions_
	
) {
	unsigned long type;
	
			Core::Box<StateAction> actions_item;
			Core::Box<Transition> transitions_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_entry:
	case LITERAL_exit:
	case LITERAL_do:
	{
		actions_item=state_action();
		if ( inputState->guessing==0 ) {
			type = 0; actions_.push_back (actions_item);
		}
		break;
	}
	case SPEC_ARBITRARY_STRING1:
	case LITERAL_transition:
	{
		transitions_item=transition();
		if ( inputState->guessing==0 ) {
			type = 0; transitions_.push_back (transitions_item);
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

StateType  ModelPartParser::state_type() {
	StateType state_type_ret;
	
	switch ( LA(1)) {
	case LITERAL_normal:
	{
		match(LITERAL_normal);
		if ( inputState->guessing==0 ) {
			state_type_ret = ST_NORMAL;
		}
		break;
	}
	case LITERAL_final:
	{
		match(LITERAL_final);
		if ( inputState->guessing==0 ) {
			state_type_ret = ST_FINAL;
		}
		break;
	}
	case LITERAL_start:
	{
		match(LITERAL_start);
		if ( inputState->guessing==0 ) {
			state_type_ret = ST_START;
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	return state_type_ret;
}

Core::Box<StateAction>  ModelPartParser::state_action() {
	Core::Box<StateAction> state_action_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	state_action_group_prev_1(*state_action_ret);
	match(LITERAL_action);
	state_action_group_0(*state_action_ret);
	match(5);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return state_action_ret;
}

Core::Box<Transition>  ModelPartParser::transition() {
	Core::Box<Transition> transition_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == SPEC_ARBITRARY_STRING1)) {
			flag=transition_arbitrary_group_prev_1(*transition_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_prev_1 = check_attribute_originality (accumulated_flag_prev_1, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop251;
		}
		
	}
	_loop251:;
	} // ( ... )*
	match(LITERAL_transition);
	match(LITERAL_to);
	transition_group_0(*transition_ret);
	{ // ( ... )*
	for (;;) {
		if ((_tokenSet_13.member(LA(1)))) {
			flag=transition_arbitrary_group_1(*transition_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop253;
		}
		
	}
	_loop253:;
	} // ( ... )*
	match(7);
	match(5);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return transition_ret;
}

StateActionList  ModelPartParser::state_action_list() {
	StateActionList state_action_list_ret;
	
			Core::Box<StateAction> item;
		
	
	{ // ( ... )+
	int _cnt241=0;
	for (;;) {
		if (((LA(1) >= LITERAL_entry && LA(1) <= LITERAL_do))) {
			item=state_action();
			if ( inputState->guessing==0 ) {
				
							state_action_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt241>=1 ) { goto _loop241; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt241++;
	}
	_loop241:;
	}  // ( ... )+
	return state_action_list_ret;
}

void ModelPartParser::state_action_group_prev_1(
	StateAction& state_action_ret
) {
	
			ActionType type_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	type_=action_type();
	if ( inputState->guessing==0 ) {
		state_action_ret.type (type_);
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ModelPartParser::state_action_group_0(
	StateAction& state_action_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  name_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	name_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		state_action_ret.name (name_->getText ());
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

ActionType  ModelPartParser::action_type() {
	ActionType action_type_ret;
	
	switch ( LA(1)) {
	case LITERAL_entry:
	{
		match(LITERAL_entry);
		if ( inputState->guessing==0 ) {
			action_type_ret = AT_ENTRY;
		}
		break;
	}
	case LITERAL_exit:
	{
		match(LITERAL_exit);
		if ( inputState->guessing==0 ) {
			action_type_ret = AT_EXIT;
		}
		break;
	}
	case LITERAL_do:
	{
		match(LITERAL_do);
		if ( inputState->guessing==0 ) {
			action_type_ret = AT_DO;
		}
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	return action_type_ret;
}

TransitionList  ModelPartParser::transition_list() {
	TransitionList transition_list_ret;
	
			Core::Box<Transition> item;
		
	
	{ // ( ... )+
	int _cnt248=0;
	for (;;) {
		if ((LA(1) == SPEC_ARBITRARY_STRING1 || LA(1) == LITERAL_transition)) {
			item=transition();
			if ( inputState->guessing==0 ) {
				
							transition_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt248>=1 ) { goto _loop248; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt248++;
	}
	_loop248:;
	}  // ( ... )+
	return transition_list_ret;
}

unsigned long  ModelPartParser::transition_arbitrary_group_prev_1(
	Transition& transition_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  stereotype_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	stereotype_ = LT(1);
	match(SPEC_ARBITRARY_STRING1);
	if ( inputState->guessing==0 ) {
		type = 1 << 1; transition_ret.stereotype (stereotype_->getText ());
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

void ModelPartParser::transition_group_0(
	Transition& transition_ret
) {
	
			std::string target_name_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	target_name_=identifier();
	if ( inputState->guessing==0 ) {
		transition_ret.target_name (target_name_);
	}
	match(9);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ModelPartParser::transition_arbitrary_group_1(
	Transition& transition_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  condition_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  guard_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  action_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  event_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_condition:
	{
		match(LITERAL_condition);
		condition_ = LT(1);
		match(STRING);
		if ( inputState->guessing==0 ) {
			type = 1 << 3; transition_ret.condition (condition_->getText ());
		}
		match(5);
		break;
	}
	case LITERAL_guard:
	{
		match(LITERAL_guard);
		guard_ = LT(1);
		match(STRING);
		if ( inputState->guessing==0 ) {
			type = 1 << 4; transition_ret.guard (guard_->getText ());
		}
		match(5);
		break;
	}
	case LITERAL_action:
	{
		match(LITERAL_action);
		action_ = LT(1);
		match(STRING);
		if ( inputState->guessing==0 ) {
			type = 1 << 5; transition_ret.action (action_->getText ());
		}
		match(5);
		break;
	}
	case LITERAL_event:
	{
		match(LITERAL_event);
		event_ = LT(1);
		match(STRING);
		if ( inputState->guessing==0 ) {
			type = 1 << 6; transition_ret.event (event_->getText ());
		}
		match(5);
		break;
	}
	default:
	{
		throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());
	}
	}
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

void ModelPartParser::initializeASTFactory( ANTLR_USE_NAMESPACE(antlr)ASTFactory& )
{
}
const char* ModelPartParser::tokenNames[] = {
	"<0>",
	"EOF",
	"<2>",
	"NULL_TREE_LOOKAHEAD",
	"\"namespace\"",
	"\";\"",
	"\"package\"",
	"\"}\"",
	"SPEC_ARBITRARY_STRING1",
	"\"{\"",
	"\"native\"",
	"\"global\"",
	"\"public\"",
	"\"protected\"",
	"\"private\"",
	"\"implemented\"",
	"\"up\"",
	"STRING",
	"\"=\"",
	"\"dependency\"",
	"\"class\"",
	"\"template\"",
	"\"<\"",
	"\",\"",
	"\">\"",
	"\"extends\"",
	"\"implements\"",
	"\"regular\"",
	"\"abstract\"",
	"\"final\"",
	"\":\"",
	"\"in\"",
	"\"inout\"",
	"\"out\"",
	"\"operation\"",
	"\"(\"",
	"\")\"",
	"SPEC_ARBITRARY_STRING0",
	"\"throws\"",
	"\"attribute\"",
	"\"set\"",
	"\"get\"",
	"\"agr\"",
	"\"ref\"",
	"\"lnk\"",
	"\"this\"",
	"\"::\"",
	"\"return\"",
	"\"state\"",
	"\"normal\"",
	"\"start\"",
	"\"action\"",
	"\"entry\"",
	"\"exit\"",
	"\"do\"",
	"\"transition\"",
	"\"to\"",
	"\"condition\"",
	"\"guard\"",
	"\"event\"",
	"IDENTIFIER",
	"ALL_POST_AND_PREFIXES",
	"COMMENT",
	"ESC",
	"XDIGIT",
	"WS_",
	0
};

const unsigned long ModelPartParser::_tokenSet_0_data_[] = { 943324224UL, 0UL, 0UL, 0UL };
// "package" "native" "global" "public" "protected" "private" "implemented" 
// "up" "dependency" "class" "template" "regular" "abstract" "final" 
const ANTLR_USE_NAMESPACE(antlr)BitSet ModelPartParser::_tokenSet_0(_tokenSet_0_data_,4);
const unsigned long ModelPartParser::_tokenSet_1_data_[] = { 64576UL, 0UL, 0UL, 0UL };
// "package" "native" "global" "public" "protected" "private" "implemented" 
const ANTLR_USE_NAMESPACE(antlr)BitSet ModelPartParser::_tokenSet_1(_tokenSet_1_data_,4);
const unsigned long ModelPartParser::_tokenSet_2_data_[] = { 942732288UL, 0UL, 0UL, 0UL };
// "native" "public" "protected" "private" "implemented" "class" "template" 
// "regular" "abstract" "final" 
const ANTLR_USE_NAMESPACE(antlr)BitSet ModelPartParser::_tokenSet_2(_tokenSet_2_data_,4);
const unsigned long ModelPartParser::_tokenSet_3_data_[] = { 939586560UL, 0UL, 0UL, 0UL };
// "native" "public" "protected" "private" "implemented" "regular" "abstract" 
// "final" 
const ANTLR_USE_NAMESPACE(antlr)BitSet ModelPartParser::_tokenSet_3(_tokenSet_3_data_,4);
const unsigned long ModelPartParser::_tokenSet_4_data_[] = { 943453184UL, 268901508UL, 0UL, 0UL };
// "native" "public" "protected" "private" "implemented" "up" STRING "dependency" 
// "class" "template" "regular" "abstract" "final" "operation" "attribute" 
// "agr" "ref" "lnk" "state" "normal" "start" IDENTIFIER 
const ANTLR_USE_NAMESPACE(antlr)BitSet ModelPartParser::_tokenSet_4(_tokenSet_4_data_,4);
const unsigned long ModelPartParser::_tokenSet_5_data_[] = { 2147614720UL, 268435459UL, 0UL, 0UL };
// STRING "in" "inout" "out" IDENTIFIER 
const ANTLR_USE_NAMESPACE(antlr)BitSet ModelPartParser::_tokenSet_5(_tokenSet_5_data_,4);
const unsigned long ModelPartParser::_tokenSet_6_data_[] = { 939585536UL, 4UL, 0UL, 0UL };
// "public" "protected" "private" "implemented" "regular" "abstract" "final" 
// "operation" 
const ANTLR_USE_NAMESPACE(antlr)BitSet ModelPartParser::_tokenSet_6(_tokenSet_6_data_,4);
const unsigned long ModelPartParser::_tokenSet_7_data_[] = { 939585536UL, 7296UL, 0UL, 0UL };
// "public" "protected" "private" "implemented" "regular" "abstract" "final" 
// "attribute" "agr" "ref" "lnk" 
const ANTLR_USE_NAMESPACE(antlr)BitSet ModelPartParser::_tokenSet_7(_tokenSet_7_data_,4);
const unsigned long ModelPartParser::_tokenSet_8_data_[] = { 536870912UL, 458752UL, 0UL, 0UL };
// "final" "state" "normal" "start" 
const ANTLR_USE_NAMESPACE(antlr)BitSet ModelPartParser::_tokenSet_8(_tokenSet_8_data_,4);
const unsigned long ModelPartParser::_tokenSet_9_data_[] = { 939585536UL, 7168UL, 0UL, 0UL };
// "public" "protected" "private" "implemented" "regular" "abstract" "final" 
// "agr" "ref" "lnk" 
const ANTLR_USE_NAMESPACE(antlr)BitSet ModelPartParser::_tokenSet_9(_tokenSet_9_data_,4);
const unsigned long ModelPartParser::_tokenSet_10_data_[] = { 131072UL, 268476416UL, 0UL, 0UL };
// STRING "this" "return" IDENTIFIER 
const ANTLR_USE_NAMESPACE(antlr)BitSet ModelPartParser::_tokenSet_10(_tokenSet_10_data_,4);
const unsigned long ModelPartParser::_tokenSet_11_data_[] = { 256UL, 15728640UL, 0UL, 0UL };
// SPEC_ARBITRARY_STRING1 "entry" "exit" "do" "transition" 
const ANTLR_USE_NAMESPACE(antlr)BitSet ModelPartParser::_tokenSet_11(_tokenSet_11_data_,4);
const unsigned long ModelPartParser::_tokenSet_12_data_[] = { 939651072UL, 7296UL, 0UL, 0UL };
// "public" "protected" "private" "implemented" "up" "regular" "abstract" 
// "final" "attribute" "agr" "ref" "lnk" 
const ANTLR_USE_NAMESPACE(antlr)BitSet ModelPartParser::_tokenSet_12(_tokenSet_12_data_,4);
const unsigned long ModelPartParser::_tokenSet_13_data_[] = { 0UL, 235405312UL, 0UL, 0UL };
// "action" "condition" "guard" "event" 
const ANTLR_USE_NAMESPACE(antlr)BitSet ModelPartParser::_tokenSet_13(_tokenSet_13_data_,4);


ANTLR_END_NAMESPACE
ANTLR_END_NAMESPACE
