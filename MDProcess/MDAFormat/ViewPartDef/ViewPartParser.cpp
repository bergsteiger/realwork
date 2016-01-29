/* $ANTLR 2.7.7 (20060930): "ViewPart.cpp.g" -> "ViewPartParser.cpp"$ */
#include "ViewPartParser.hpp"
#include <antlr/NoViableAltException.hpp>
#include <antlr/SemanticException.hpp>
#include <antlr/ASTFactory.hpp>
ANTLR_BEGIN_NAMESPACE(MDAFormat)
ANTLR_BEGIN_NAMESPACE(ViewPartDef)

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

ViewPartParser::ViewPartParser(ANTLR_USE_NAMESPACE(antlr)TokenBuffer& tokenBuf, int k)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(tokenBuf,k)
{
}

ViewPartParser::ViewPartParser(ANTLR_USE_NAMESPACE(antlr)TokenBuffer& tokenBuf)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(tokenBuf,1)
{
}

ViewPartParser::ViewPartParser(ANTLR_USE_NAMESPACE(antlr)TokenStream& lexer, int k)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(lexer,k)
{
}

ViewPartParser::ViewPartParser(ANTLR_USE_NAMESPACE(antlr)TokenStream& lexer)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(lexer,1)
{
}

ViewPartParser::ViewPartParser(const ANTLR_USE_NAMESPACE(antlr)ParserSharedInputState& state)
: ANTLR_USE_NAMESPACE(antlr)LLkParser(state,1)
{
}

Core::Box<RootPackage>  ViewPartParser::root_package() {
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == LITERAL_namespace)) {
			flag=root_package_arbitrary_group_0(*root_package_ret, namespaces_);
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
		
					root_package_ret->namespaces (namespaces_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return root_package_ret;
}

unsigned long  ViewPartParser::root_package_arbitrary_group_0(
	
		RootPackage& root_package_ret
		, NamespaceList& namespaces_
	
) {
	unsigned long type;
	
			Core::Box<Namespace> namespaces_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	namespaces_item=namespace_();
	if ( inputState->guessing==0 ) {
		type = 0; namespaces_.push_back (namespaces_item);
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

void ViewPartParser::root_package_group_1(
	RootPackage& root_package_ret
) {
	
			Core::Box<PackageDef> root_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	root_=package_def();
	if ( inputState->guessing==0 ) {
		root_package_ret.root (*root_);
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

Core::Box<PackageDef>  ViewPartParser::package_def() {
	Core::Box<PackageDef> package_def_ret;
	
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_package);
	package_def_group_0(*package_def_ret);
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == LITERAL_package || LA(1) == LITERAL_class_diagram || LA(1) == LITERAL_class)) {
			flag=package_def_arbitrary_group_1(*package_def_ret, class_diags_, packages_, classes_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop13;
		}
		
	}
	_loop13:;
	} // ( ... )*
	match(7);
	if ( inputState->guessing==0 ) {
		
					package_def_ret->class_diags (class_diags_);
					package_def_ret->packages (packages_);
					package_def_ret->classes (classes_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return package_def_ret;
}

Core::Box<Namespace>  ViewPartParser::namespace_() {
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

NamespaceList  ViewPartParser::namespace_list() {
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

void ViewPartParser::namespace__group_0(
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

std::string  ViewPartParser::identifier() {
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

void ViewPartParser::package_def_group_0(
	PackageDef& package_def_ret
) {
	
			std::string name_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	name_=identifier();
	if ( inputState->guessing==0 ) {
		package_def_ret.name (name_);
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ViewPartParser::package_def_arbitrary_group_1(
	
		PackageDef& package_def_ret
		, ClassDiagramList& class_diags_
		, PackageDefList& packages_
		, ClassDefList& classes_
	
) {
	unsigned long type;
	
			Core::Box<ClassDiagram> class_diags_item;
			Core::Box<PackageDef> packages_item;
			Core::Box<ClassDef> classes_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_class_diagram:
	{
		class_diags_item=class_diagram();
		if ( inputState->guessing==0 ) {
			type = 0; class_diags_.push_back (class_diags_item);
		}
		break;
	}
	case LITERAL_package:
	{
		packages_item=package_def();
		if ( inputState->guessing==0 ) {
			type = 0; packages_.push_back (packages_item);
		}
		break;
	}
	case LITERAL_class:
	{
		classes_item=class_def();
		if ( inputState->guessing==0 ) {
			type = 0; classes_.push_back (classes_item);
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

Core::Box<ClassDiagram>  ViewPartParser::class_diagram() {
	Core::Box<ClassDiagram> class_diagram_ret;
	
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_class_diagram);
	class_diagram_group_0(*class_diagram_ret);
	{ // ( ... )*
	for (;;) {
		if ((_tokenSet_0.member(LA(1)))) {
			flag=class_diagram_arbitrary_group_1(*class_diagram_ret, class_views_, package_views_, note_views_, inherit_views_, realize_views_, association_views_, class_diags_, sequence_diags_, state_diags_, dependencies_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop22;
		}
		
	}
	_loop22:;
	} // ( ... )*
	match(7);
	if ( inputState->guessing==0 ) {
		
					class_diagram_ret->class_views (class_views_);
					class_diagram_ret->package_views (package_views_);
					class_diagram_ret->note_views (note_views_);
					class_diagram_ret->inherit_views (inherit_views_);
					class_diagram_ret->realize_views (realize_views_);
					class_diagram_ret->association_views (association_views_);
					class_diagram_ret->class_diags (class_diags_);
					class_diagram_ret->sequence_diags (sequence_diags_);
					class_diagram_ret->state_diags (state_diags_);
					class_diagram_ret->dependencies (dependencies_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return class_diagram_ret;
}

Core::Box<ClassDef>  ViewPartParser::class_def() {
	Core::Box<ClassDef> class_def_ret;
	
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_class);
	class_def_group_0(*class_def_ret);
	{ // ( ... )*
	for (;;) {
		if ((_tokenSet_1.member(LA(1)))) {
			flag=class_def_arbitrary_group_1(*class_def_ret, classes_, class_diags_, sequence_diags_, state_diags_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop203;
		}
		
	}
	_loop203:;
	} // ( ... )*
	match(7);
	if ( inputState->guessing==0 ) {
		
					class_def_ret->classes (classes_);
					class_def_ret->class_diags (class_diags_);
					class_def_ret->sequence_diags (sequence_diags_);
					class_def_ret->state_diags (state_diags_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return class_def_ret;
}

ClassDiagramList  ViewPartParser::class_diagram_list() {
	ClassDiagramList class_diagram_list_ret;
	
			Core::Box<ClassDiagram> item;
		
	
	{ // ( ... )+
	int _cnt19=0;
	for (;;) {
		if ((LA(1) == LITERAL_class_diagram)) {
			item=class_diagram();
			if ( inputState->guessing==0 ) {
				
							class_diagram_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt19>=1 ) { goto _loop19; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt19++;
	}
	_loop19:;
	}  // ( ... )+
	return class_diagram_list_ret;
}

void ViewPartParser::class_diagram_group_0(
	ClassDiagram& class_diagram_ret
) {
	
			std::string name_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	name_=identifier();
	if ( inputState->guessing==0 ) {
		class_diagram_ret.name (name_);
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ViewPartParser::class_diagram_arbitrary_group_1(
	
		ClassDiagram& class_diagram_ret
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
	
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  zoom_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_zoom:
	{
		match(LITERAL_zoom);
		match(11);
		zoom_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 2; class_diagram_ret.zoom (boost::lexical_cast<int> (zoom_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_class_view:
	{
		class_views_item=class_view();
		if ( inputState->guessing==0 ) {
			type = 0; class_views_.push_back (class_views_item);
		}
		break;
	}
	case LITERAL_package_view:
	{
		package_views_item=package_view();
		if ( inputState->guessing==0 ) {
			type = 0; package_views_.push_back (package_views_item);
		}
		break;
	}
	case LITERAL_note_view:
	{
		note_views_item=note_view();
		if ( inputState->guessing==0 ) {
			type = 0; note_views_.push_back (note_views_item);
		}
		break;
	}
	case LITERAL_inherit_view:
	{
		inherit_views_item=inherit_view();
		if ( inputState->guessing==0 ) {
			type = 0; inherit_views_.push_back (inherit_views_item);
		}
		break;
	}
	case LITERAL_realize_view:
	{
		realize_views_item=realize_view();
		if ( inputState->guessing==0 ) {
			type = 0; realize_views_.push_back (realize_views_item);
		}
		break;
	}
	case LITERAL_association_view:
	{
		association_views_item=association_view();
		if ( inputState->guessing==0 ) {
			type = 0; association_views_.push_back (association_views_item);
		}
		break;
	}
	case LITERAL_class_diagram_view:
	{
		class_diags_item=class_diagram_view();
		if ( inputState->guessing==0 ) {
			type = 0; class_diags_.push_back (class_diags_item);
		}
		break;
	}
	case LITERAL_sequence_diagram_view:
	{
		sequence_diags_item=sequence_diagram_view();
		if ( inputState->guessing==0 ) {
			type = 0; sequence_diags_.push_back (sequence_diags_item);
		}
		break;
	}
	case LITERAL_state_diagram_view:
	{
		state_diags_item=state_diagram_view();
		if ( inputState->guessing==0 ) {
			type = 0; state_diags_.push_back (state_diags_item);
		}
		break;
	}
	case LITERAL_dependency_view:
	{
		dependencies_item=dependency_view();
		if ( inputState->guessing==0 ) {
			type = 0; dependencies_.push_back (dependencies_item);
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

Core::Box<ClassView>  ViewPartParser::class_view() {
	Core::Box<ClassView> class_view_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_class_view);
	class_view_group_0(*class_view_ret);
	class_view_group_1(*class_view_ret);
	{ // ( ... )+
	int _cnt31=0;
	for (;;) {
		if ((LA(1) == LITERAL_center_x || LA(1) == LITERAL_center_y)) {
			flag=class_view_group_2(*class_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			if ( _cnt31>=1 ) { goto _loop31; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt31++;
	}
	_loop31:;
	}  // ( ... )+
	if ( inputState->guessing==0 ) {
		
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
	match(7);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return class_view_ret;
}

Core::Box<PackageView>  ViewPartParser::package_view() {
	Core::Box<PackageView> package_view_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_package_view);
	package_view_group_0(*package_view_ret);
	package_view_group_1(*package_view_ret);
	{ // ( ... )+
	int _cnt45=0;
	for (;;) {
		if ((LA(1) == LITERAL_center_x || LA(1) == LITERAL_center_y)) {
			flag=package_view_group_2(*package_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			if ( _cnt45>=1 ) { goto _loop45; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt45++;
	}
	_loop45:;
	}  // ( ... )+
	if ( inputState->guessing==0 ) {
		
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
	match(7);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return package_view_ret;
}

Core::Box<NoteView>  ViewPartParser::note_view() {
	Core::Box<NoteView> note_view_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_note_view);
	note_view_group_0(*note_view_ret);
	note_view_group_1(*note_view_ret);
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == LITERAL_text)) {
			flag=note_view_arbitrary_group_2(*note_view_ret);
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
	{ // ( ... )+
	int _cnt61=0;
	for (;;) {
		if ((LA(1) == LITERAL_center_x || LA(1) == LITERAL_center_y)) {
			flag=note_view_group_2(*note_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			if ( _cnt61>=1 ) { goto _loop61; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt61++;
	}
	_loop61:;
	}  // ( ... )+
	if ( inputState->guessing==0 ) {
		
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
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == LITERAL_text)) {
			flag=note_view_arbitrary_group_2(*note_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop63;
		}
		
	}
	_loop63:;
	} // ( ... )*
	match(7);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return note_view_ret;
}

Core::Box<InheritView>  ViewPartParser::inherit_view() {
	Core::Box<InheritView> inherit_view_ret;
	
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_inherit_view);
	inherit_view_group_0(*inherit_view_ret);
	{ // ( ... )+
	int _cnt78=0;
	for (;;) {
		if (((LA(1) >= LITERAL_client && LA(1) <= LITERAL_points))) {
			flag=inherit_view_group_1(*inherit_view_ret, points_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			if ( _cnt78>=1 ) { goto _loop78; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt78++;
	}
	_loop78:;
	}  // ( ... )+
	if ( inputState->guessing==0 ) {
		
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
	match(7);
	if ( inputState->guessing==0 ) {
		
					inherit_view_ret->points (points_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return inherit_view_ret;
}

Core::Box<RealizeView>  ViewPartParser::realize_view() {
	Core::Box<RealizeView> realize_view_ret;
	
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_realize_view);
	realize_view_group_0(*realize_view_ret);
	{ // ( ... )+
	int _cnt95=0;
	for (;;) {
		if (((LA(1) >= LITERAL_client && LA(1) <= LITERAL_points))) {
			flag=realize_view_group_1(*realize_view_ret, points_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			if ( _cnt95>=1 ) { goto _loop95; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt95++;
	}
	_loop95:;
	}  // ( ... )+
	if ( inputState->guessing==0 ) {
		
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
	match(7);
	if ( inputState->guessing==0 ) {
		
					realize_view_ret->points (points_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return realize_view_ret;
}

Core::Box<AssociationView>  ViewPartParser::association_view() {
	Core::Box<AssociationView> association_view_ret;
	
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_association_view);
	association_view_group_0(*association_view_ret);
	association_view_group_1(*association_view_ret);
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == LITERAL_name_view || LA(1) == LITERAL_stereotype_view)) {
			flag=association_view_arbitrary_group_2(*association_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop106;
		}
		
	}
	_loop106:;
	} // ( ... )*
	{ // ( ... )+
	int _cnt108=0;
	for (;;) {
		if (((LA(1) >= LITERAL_client && LA(1) <= LITERAL_points))) {
			flag=association_view_group_2(*association_view_ret, points_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			if ( _cnt108>=1 ) { goto _loop108; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt108++;
	}
	_loop108:;
	}  // ( ... )+
	if ( inputState->guessing==0 ) {
		
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
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == LITERAL_name_view || LA(1) == LITERAL_stereotype_view)) {
			flag=association_view_arbitrary_group_2(*association_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop110;
		}
		
	}
	_loop110:;
	} // ( ... )*
	match(7);
	if ( inputState->guessing==0 ) {
		
					association_view_ret->points (points_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return association_view_ret;
}

Core::Box<ClassDiagramView>  ViewPartParser::class_diagram_view() {
	Core::Box<ClassDiagramView> class_diagram_view_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_class_diagram_view);
	class_diagram_view_group_0(*class_diagram_view_ret);
	class_diagram_view_group_1(*class_diagram_view_ret);
	{ // ( ... )+
	int _cnt142=0;
	for (;;) {
		if ((LA(1) == LITERAL_center_x || LA(1) == LITERAL_center_y)) {
			flag=class_diagram_view_group_2(*class_diagram_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			if ( _cnt142>=1 ) { goto _loop142; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt142++;
	}
	_loop142:;
	}  // ( ... )+
	if ( inputState->guessing==0 ) {
		
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
	match(7);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return class_diagram_view_ret;
}

Core::Box<SequenceDiagramView>  ViewPartParser::sequence_diagram_view() {
	Core::Box<SequenceDiagramView> sequence_diagram_view_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_sequence_diagram_view);
	sequence_diagram_view_group_0(*sequence_diagram_view_ret);
	sequence_diagram_view_group_1(*sequence_diagram_view_ret);
	{ // ( ... )+
	int _cnt156=0;
	for (;;) {
		if ((LA(1) == LITERAL_center_x || LA(1) == LITERAL_center_y)) {
			flag=sequence_diagram_view_group_2(*sequence_diagram_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			if ( _cnt156>=1 ) { goto _loop156; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt156++;
	}
	_loop156:;
	}  // ( ... )+
	if ( inputState->guessing==0 ) {
		
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
	match(7);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return sequence_diagram_view_ret;
}

Core::Box<StateDiagramView>  ViewPartParser::state_diagram_view() {
	Core::Box<StateDiagramView> state_diagram_view_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_state_diagram_view);
	state_diagram_view_group_0(*state_diagram_view_ret);
	state_diagram_view_group_1(*state_diagram_view_ret);
	{ // ( ... )+
	int _cnt170=0;
	for (;;) {
		if ((LA(1) == LITERAL_center_x || LA(1) == LITERAL_center_y)) {
			flag=state_diagram_view_group_2(*state_diagram_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			if ( _cnt170>=1 ) { goto _loop170; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt170++;
	}
	_loop170:;
	}  // ( ... )+
	if ( inputState->guessing==0 ) {
		
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
	match(7);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return state_diagram_view_ret;
}

Core::Box<DependencyView>  ViewPartParser::dependency_view() {
	Core::Box<DependencyView> dependency_view_ret;
	
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_dependency_view);
	dependency_view_group_0(*dependency_view_ret);
	dependency_view_group_1(*dependency_view_ret);
	dependency_view_group_2(*dependency_view_ret);
	dependency_view_group_3(*dependency_view_ret);
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == LITERAL_stereotype_view)) {
			flag=dependency_view_arbitrary_group_4(*dependency_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_4 = check_attribute_originality (accumulated_flag_4, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop184;
		}
		
	}
	_loop184:;
	} // ( ... )*
	dependency_view_group_4(*dependency_view_ret, points_);
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == LITERAL_stereotype_view)) {
			flag=dependency_view_arbitrary_group_4(*dependency_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_4 = check_attribute_originality (accumulated_flag_4, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop186;
		}
		
	}
	_loop186:;
	} // ( ... )*
	match(7);
	match(5);
	if ( inputState->guessing==0 ) {
		
					dependency_view_ret->points (points_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return dependency_view_ret;
}

ClassViewList  ViewPartParser::class_view_list() {
	ClassViewList class_view_list_ret;
	
			Core::Box<ClassView> item;
		
	
	{ // ( ... )+
	int _cnt28=0;
	for (;;) {
		if ((LA(1) == LITERAL_class_view)) {
			item=class_view();
			if ( inputState->guessing==0 ) {
				
							class_view_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt28>=1 ) { goto _loop28; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt28++;
	}
	_loop28:;
	}  // ( ... )+
	return class_view_list_ret;
}

void ViewPartParser::class_view_group_0(
	ClassView& class_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  number_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	number_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		class_view_ret.number (boost::lexical_cast<int> (number_->getText ()));
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ViewPartParser::class_view_group_1(
	ClassView& class_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  guid_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	guid_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		class_view_ret.guid (guid_->getText ());
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ViewPartParser::class_view_group_2(
	ClassView& class_view_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_x_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_y_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_center_x:
	{
		match(LITERAL_center_x);
		match(11);
		center_x_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 3; class_view_ret.center_x (boost::lexical_cast<int> (center_x_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_center_y:
	{
		match(LITERAL_center_y);
		match(11);
		center_y_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 4; class_view_ret.center_y (boost::lexical_cast<int> (center_y_->getText ()));
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

PackageViewList  ViewPartParser::package_view_list() {
	PackageViewList package_view_list_ret;
	
			Core::Box<PackageView> item;
		
	
	{ // ( ... )+
	int _cnt42=0;
	for (;;) {
		if ((LA(1) == LITERAL_package_view)) {
			item=package_view();
			if ( inputState->guessing==0 ) {
				
							package_view_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt42>=1 ) { goto _loop42; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt42++;
	}
	_loop42:;
	}  // ( ... )+
	return package_view_list_ret;
}

void ViewPartParser::package_view_group_0(
	PackageView& package_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  number_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	number_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		package_view_ret.number (boost::lexical_cast<int> (number_->getText ()));
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ViewPartParser::package_view_group_1(
	PackageView& package_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  guid_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	guid_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		package_view_ret.guid (guid_->getText ());
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ViewPartParser::package_view_group_2(
	PackageView& package_view_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_x_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_y_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_center_x:
	{
		match(LITERAL_center_x);
		match(11);
		center_x_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 3; package_view_ret.center_x (boost::lexical_cast<int> (center_x_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_center_y:
	{
		match(LITERAL_center_y);
		match(11);
		center_y_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 4; package_view_ret.center_y (boost::lexical_cast<int> (center_y_->getText ()));
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

NoteViewList  ViewPartParser::note_view_list() {
	NoteViewList note_view_list_ret;
	
			Core::Box<NoteView> item;
		
	
	{ // ( ... )+
	int _cnt56=0;
	for (;;) {
		if ((LA(1) == LITERAL_note_view)) {
			item=note_view();
			if ( inputState->guessing==0 ) {
				
							note_view_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt56>=1 ) { goto _loop56; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt56++;
	}
	_loop56:;
	}  // ( ... )+
	return note_view_list_ret;
}

void ViewPartParser::note_view_group_0(
	NoteView& note_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  number_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	number_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		note_view_ret.number (boost::lexical_cast<int> (number_->getText ()));
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ViewPartParser::note_view_group_1(
	NoteView& note_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  associated_view_number_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	associated_view_number_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		note_view_ret.associated_view_number (boost::lexical_cast<int> (associated_view_number_->getText ()));
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ViewPartParser::note_view_arbitrary_group_2(
	NoteView& note_view_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  text_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_text);
	match(11);
	text_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		type = 1 << 5; note_view_ret.text (text_->getText ());
	}
	match(5);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

unsigned long  ViewPartParser::note_view_group_2(
	NoteView& note_view_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_x_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_y_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_center_x:
	{
		match(LITERAL_center_x);
		match(11);
		center_x_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 3; note_view_ret.center_x (boost::lexical_cast<int> (center_x_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_center_y:
	{
		match(LITERAL_center_y);
		match(11);
		center_y_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 4; note_view_ret.center_y (boost::lexical_cast<int> (center_y_->getText ()));
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

InheritViewList  ViewPartParser::inherit_view_list() {
	InheritViewList inherit_view_list_ret;
	
			Core::Box<InheritView> item;
		
	
	{ // ( ... )+
	int _cnt75=0;
	for (;;) {
		if ((LA(1) == LITERAL_inherit_view)) {
			item=inherit_view();
			if ( inputState->guessing==0 ) {
				
							inherit_view_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt75>=1 ) { goto _loop75; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt75++;
	}
	_loop75:;
	}  // ( ... )+
	return inherit_view_list_ret;
}

void ViewPartParser::inherit_view_group_0(
	InheritView& inherit_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  number_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	number_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		inherit_view_ret.number (boost::lexical_cast<int> (number_->getText ()));
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ViewPartParser::inherit_view_group_1(
	
		InheritView& inherit_view_ret
		, PointList& points_
	
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  client_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  supplier_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
			Core::Box<Point> points_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_client:
	{
		match(LITERAL_client);
		client_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 2; inherit_view_ret.client (boost::lexical_cast<int> (client_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_supplier:
	{
		match(LITERAL_supplier);
		supplier_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 3; inherit_view_ret.supplier (boost::lexical_cast<int> (supplier_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_points:
	{
		match(LITERAL_points);
		match(11);
		points_item=point();
		if ( inputState->guessing==0 ) {
			type = 1 << 4; points_.push_back (points_item);
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == 24)) {
				match(24);
				points_item=point();
				if ( inputState->guessing==0 ) {
					type = 1 << 4; points_.push_back (points_item);
				}
			}
			else {
				goto _loop83;
			}
			
		}
		_loop83:;
		} // ( ... )*
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

Core::Box<Point>  ViewPartParser::point() {
	Core::Box<Point> point_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(25);
	point_group_0(*point_ret);
	point_group_1(*point_ret);
	match(26);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return point_ret;
}

PointList  ViewPartParser::point_list() {
	PointList point_list_ret;
	
			Core::Box<Point> item;
		
	
	{ // ( ... )+
	int _cnt86=0;
	for (;;) {
		if ((LA(1) == 25)) {
			item=point();
			if ( inputState->guessing==0 ) {
				
							point_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt86>=1 ) { goto _loop86; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt86++;
	}
	_loop86:;
	}  // ( ... )+
	return point_list_ret;
}

void ViewPartParser::point_group_0(
	Point& point_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  x_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	x_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		point_ret.x (boost::lexical_cast<int> (x_->getText ()));
	}
	match(24);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ViewPartParser::point_group_1(
	Point& point_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  y_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	y_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		point_ret.y (boost::lexical_cast<int> (y_->getText ()));
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

RealizeViewList  ViewPartParser::realize_view_list() {
	RealizeViewList realize_view_list_ret;
	
			Core::Box<RealizeView> item;
		
	
	{ // ( ... )+
	int _cnt92=0;
	for (;;) {
		if ((LA(1) == LITERAL_realize_view)) {
			item=realize_view();
			if ( inputState->guessing==0 ) {
				
							realize_view_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt92>=1 ) { goto _loop92; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt92++;
	}
	_loop92:;
	}  // ( ... )+
	return realize_view_list_ret;
}

void ViewPartParser::realize_view_group_0(
	RealizeView& realize_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  number_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	number_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		realize_view_ret.number (boost::lexical_cast<int> (number_->getText ()));
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ViewPartParser::realize_view_group_1(
	
		RealizeView& realize_view_ret
		, PointList& points_
	
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  client_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  supplier_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
			Core::Box<Point> points_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_client:
	{
		match(LITERAL_client);
		client_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 2; realize_view_ret.client (boost::lexical_cast<int> (client_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_supplier:
	{
		match(LITERAL_supplier);
		supplier_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 3; realize_view_ret.supplier (boost::lexical_cast<int> (supplier_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_points:
	{
		match(LITERAL_points);
		match(11);
		points_item=point();
		if ( inputState->guessing==0 ) {
			type = 1 << 4; points_.push_back (points_item);
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == 24)) {
				match(24);
				points_item=point();
				if ( inputState->guessing==0 ) {
					type = 1 << 4; points_.push_back (points_item);
				}
			}
			else {
				goto _loop100;
			}
			
		}
		_loop100:;
		} // ( ... )*
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

AssociationViewList  ViewPartParser::association_view_list() {
	AssociationViewList association_view_list_ret;
	
			Core::Box<AssociationView> item;
		
	
	{ // ( ... )+
	int _cnt103=0;
	for (;;) {
		if ((LA(1) == LITERAL_association_view)) {
			item=association_view();
			if ( inputState->guessing==0 ) {
				
							association_view_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt103>=1 ) { goto _loop103; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt103++;
	}
	_loop103:;
	}  // ( ... )+
	return association_view_list_ret;
}

void ViewPartParser::association_view_group_0(
	AssociationView& association_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  number_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	number_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		association_view_ret.number (boost::lexical_cast<int> (number_->getText ()));
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ViewPartParser::association_view_group_1(
	AssociationView& association_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  guid_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	guid_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		association_view_ret.guid (guid_->getText ());
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ViewPartParser::association_view_arbitrary_group_2(
	AssociationView& association_view_ret
) {
	unsigned long type;
	
			Core::Box<NameView> name_view_;
			Core::Box<StereotypeView> stereotype_view_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_name_view:
	{
		name_view_=name_view();
		if ( inputState->guessing==0 ) {
			type = 1 << 6; association_view_ret.name_view (name_view_);
		}
		break;
	}
	case LITERAL_stereotype_view:
	{
		stereotype_view_=stereotype_view();
		if ( inputState->guessing==0 ) {
			type = 1 << 7; association_view_ret.stereotype_view (stereotype_view_);
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

unsigned long  ViewPartParser::association_view_group_2(
	
		AssociationView& association_view_ret
		, PointList& points_
	
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  client_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  supplier_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
			Core::Box<Point> points_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_client:
	{
		match(LITERAL_client);
		client_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 3; association_view_ret.client (boost::lexical_cast<int> (client_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_supplier:
	{
		match(LITERAL_supplier);
		supplier_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 4; association_view_ret.supplier (boost::lexical_cast<int> (supplier_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_points:
	{
		match(LITERAL_points);
		match(11);
		points_item=point();
		if ( inputState->guessing==0 ) {
			type = 1 << 5; points_.push_back (points_item);
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == 24)) {
				match(24);
				points_item=point();
				if ( inputState->guessing==0 ) {
					type = 1 << 5; points_.push_back (points_item);
				}
			}
			else {
				goto _loop116;
			}
			
		}
		_loop116:;
		} // ( ... )*
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

Core::Box<NameView>  ViewPartParser::name_view() {
	Core::Box<NameView> name_view_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_name_view);
	match(8);
	{ // ( ... )+
	int _cnt121=0;
	for (;;) {
		if ((LA(1) == LITERAL_center_x || LA(1) == LITERAL_center_y)) {
			flag=name_view_group_0(*name_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			if ( _cnt121>=1 ) { goto _loop121; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt121++;
	}
	_loop121:;
	}  // ( ... )+
	if ( inputState->guessing==0 ) {
		
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
	match(7);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return name_view_ret;
}

Core::Box<StereotypeView>  ViewPartParser::stereotype_view() {
	Core::Box<StereotypeView> stereotype_view_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_stereotype_view);
	match(8);
	{ // ( ... )+
	int _cnt130=0;
	for (;;) {
		if ((LA(1) == LITERAL_center_x || LA(1) == LITERAL_center_y)) {
			flag=stereotype_view_group_0(*stereotype_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_0 = check_attribute_originality (accumulated_flag_0, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			if ( _cnt130>=1 ) { goto _loop130; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt130++;
	}
	_loop130:;
	}  // ( ... )+
	if ( inputState->guessing==0 ) {
		
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
	match(7);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return stereotype_view_ret;
}

unsigned long  ViewPartParser::name_view_group_0(
	NameView& name_view_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_x_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_y_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_center_x:
	{
		match(LITERAL_center_x);
		match(11);
		center_x_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 1; name_view_ret.center_x (boost::lexical_cast<int> (center_x_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_center_y:
	{
		match(LITERAL_center_y);
		match(11);
		center_y_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 2; name_view_ret.center_y (boost::lexical_cast<int> (center_y_->getText ()));
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

unsigned long  ViewPartParser::stereotype_view_group_0(
	StereotypeView& stereotype_view_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_x_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_y_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_center_x:
	{
		match(LITERAL_center_x);
		match(11);
		center_x_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 1; stereotype_view_ret.center_x (boost::lexical_cast<int> (center_x_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_center_y:
	{
		match(LITERAL_center_y);
		match(11);
		center_y_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 2; stereotype_view_ret.center_y (boost::lexical_cast<int> (center_y_->getText ()));
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

ClassDiagramViewList  ViewPartParser::class_diagram_view_list() {
	ClassDiagramViewList class_diagram_view_list_ret;
	
			Core::Box<ClassDiagramView> item;
		
	
	{ // ( ... )+
	int _cnt139=0;
	for (;;) {
		if ((LA(1) == LITERAL_class_diagram_view)) {
			item=class_diagram_view();
			if ( inputState->guessing==0 ) {
				
							class_diagram_view_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt139>=1 ) { goto _loop139; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt139++;
	}
	_loop139:;
	}  // ( ... )+
	return class_diagram_view_list_ret;
}

void ViewPartParser::class_diagram_view_group_0(
	ClassDiagramView& class_diagram_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  number_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	number_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		class_diagram_view_ret.number (boost::lexical_cast<int> (number_->getText ()));
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ViewPartParser::class_diagram_view_group_1(
	ClassDiagramView& class_diagram_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  guid_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	guid_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		class_diagram_view_ret.guid (guid_->getText ());
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ViewPartParser::class_diagram_view_group_2(
	ClassDiagramView& class_diagram_view_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_x_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_y_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_center_x:
	{
		match(LITERAL_center_x);
		match(11);
		center_x_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 3; class_diagram_view_ret.center_x (boost::lexical_cast<int> (center_x_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_center_y:
	{
		match(LITERAL_center_y);
		match(11);
		center_y_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 4; class_diagram_view_ret.center_y (boost::lexical_cast<int> (center_y_->getText ()));
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

SequenceDiagramViewList  ViewPartParser::sequence_diagram_view_list() {
	SequenceDiagramViewList sequence_diagram_view_list_ret;
	
			Core::Box<SequenceDiagramView> item;
		
	
	{ // ( ... )+
	int _cnt153=0;
	for (;;) {
		if ((LA(1) == LITERAL_sequence_diagram_view)) {
			item=sequence_diagram_view();
			if ( inputState->guessing==0 ) {
				
							sequence_diagram_view_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt153>=1 ) { goto _loop153; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt153++;
	}
	_loop153:;
	}  // ( ... )+
	return sequence_diagram_view_list_ret;
}

void ViewPartParser::sequence_diagram_view_group_0(
	SequenceDiagramView& sequence_diagram_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  number_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	number_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		sequence_diagram_view_ret.number (boost::lexical_cast<int> (number_->getText ()));
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ViewPartParser::sequence_diagram_view_group_1(
	SequenceDiagramView& sequence_diagram_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  guid_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	guid_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		sequence_diagram_view_ret.guid (guid_->getText ());
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ViewPartParser::sequence_diagram_view_group_2(
	SequenceDiagramView& sequence_diagram_view_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_x_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_y_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_center_x:
	{
		match(LITERAL_center_x);
		center_x_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 3; sequence_diagram_view_ret.center_x (boost::lexical_cast<int> (center_x_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_center_y:
	{
		match(LITERAL_center_y);
		center_y_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 4; sequence_diagram_view_ret.center_y (boost::lexical_cast<int> (center_y_->getText ()));
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

StateDiagramViewList  ViewPartParser::state_diagram_view_list() {
	StateDiagramViewList state_diagram_view_list_ret;
	
			Core::Box<StateDiagramView> item;
		
	
	{ // ( ... )+
	int _cnt167=0;
	for (;;) {
		if ((LA(1) == LITERAL_state_diagram_view)) {
			item=state_diagram_view();
			if ( inputState->guessing==0 ) {
				
							state_diagram_view_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt167>=1 ) { goto _loop167; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt167++;
	}
	_loop167:;
	}  // ( ... )+
	return state_diagram_view_list_ret;
}

void ViewPartParser::state_diagram_view_group_0(
	StateDiagramView& state_diagram_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  number_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	number_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		state_diagram_view_ret.number (boost::lexical_cast<int> (number_->getText ()));
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ViewPartParser::state_diagram_view_group_1(
	StateDiagramView& state_diagram_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  guid_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	guid_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		state_diagram_view_ret.guid (guid_->getText ());
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ViewPartParser::state_diagram_view_group_2(
	StateDiagramView& state_diagram_view_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_x_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_y_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_center_x:
	{
		match(LITERAL_center_x);
		match(11);
		center_x_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 3; state_diagram_view_ret.center_x (boost::lexical_cast<int> (center_x_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_center_y:
	{
		match(LITERAL_center_y);
		match(11);
		center_y_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 4; state_diagram_view_ret.center_y (boost::lexical_cast<int> (center_y_->getText ()));
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

DependencyViewList  ViewPartParser::dependency_view_list() {
	DependencyViewList dependency_view_list_ret;
	
			Core::Box<DependencyView> item;
		
	
	{ // ( ... )+
	int _cnt181=0;
	for (;;) {
		if ((LA(1) == LITERAL_dependency_view)) {
			item=dependency_view();
			if ( inputState->guessing==0 ) {
				
							dependency_view_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt181>=1 ) { goto _loop181; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt181++;
	}
	_loop181:;
	}  // ( ... )+
	return dependency_view_list_ret;
}

void ViewPartParser::dependency_view_group_0(
	DependencyView& dependency_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  number_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	number_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		dependency_view_ret.number (boost::lexical_cast<int> (number_->getText ()));
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ViewPartParser::dependency_view_group_1(
	DependencyView& dependency_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  guid_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	guid_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		dependency_view_ret.guid (guid_->getText ());
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ViewPartParser::dependency_view_group_2(
	DependencyView& dependency_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  client_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	client_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		dependency_view_ret.client (boost::lexical_cast<int> (client_->getText ()));
	}
	match(5);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ViewPartParser::dependency_view_group_3(
	DependencyView& dependency_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  supplier_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	supplier_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		dependency_view_ret.supplier (boost::lexical_cast<int> (supplier_->getText ()));
	}
	match(5);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ViewPartParser::dependency_view_arbitrary_group_4(
	DependencyView& dependency_view_ret
) {
	unsigned long type;
	
			Core::Box<StereotypeView> stereotype_view_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	stereotype_view_=stereotype_view();
	if ( inputState->guessing==0 ) {
		type = 1 << 6; dependency_view_ret.stereotype_view (stereotype_view_);
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

void ViewPartParser::dependency_view_group_4(
	
		DependencyView& dependency_view_ret
		, PointList& points_
	
) {
	
			Core::Box<Point> points_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_points);
	match(11);
	points_item=point();
	if ( inputState->guessing==0 ) {
		points_.push_back (points_item);
	}
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == 24)) {
			match(24);
			points_item=point();
			if ( inputState->guessing==0 ) {
				points_.push_back (points_item);
			}
		}
		else {
			goto _loop193;
		}
		
	}
	_loop193:;
	} // ( ... )*
	match(5);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

PackageDefList  ViewPartParser::package_def_list() {
	PackageDefList package_def_list_ret;
	
			Core::Box<PackageDef> item;
		
	
	{ // ( ... )+
	int _cnt197=0;
	for (;;) {
		if ((LA(1) == LITERAL_package)) {
			item=package_def();
			if ( inputState->guessing==0 ) {
				
							package_def_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt197>=1 ) { goto _loop197; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt197++;
	}
	_loop197:;
	}  // ( ... )+
	return package_def_list_ret;
}

ClassDefList  ViewPartParser::class_def_list() {
	ClassDefList class_def_list_ret;
	
			Core::Box<ClassDef> item;
		
	
	{ // ( ... )+
	int _cnt200=0;
	for (;;) {
		if ((LA(1) == LITERAL_class)) {
			item=class_def();
			if ( inputState->guessing==0 ) {
				
							class_def_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt200>=1 ) { goto _loop200; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt200++;
	}
	_loop200:;
	}  // ( ... )+
	return class_def_list_ret;
}

void ViewPartParser::class_def_group_0(
	ClassDef& class_def_ret
) {
	
			std::string name_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	name_=identifier();
	if ( inputState->guessing==0 ) {
		class_def_ret.name (name_);
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ViewPartParser::class_def_arbitrary_group_1(
	
		ClassDef& class_def_ret
		, ClassDefList& classes_
		, ClassDiagramList& class_diags_
		, SequenceDiagramList& sequence_diags_
		, StateDiagramList& state_diags_
	
) {
	unsigned long type;
	
			Core::Box<ClassDef> classes_item;
			Core::Box<ClassDiagram> class_diags_item;
			Core::Box<SequenceDiagram> sequence_diags_item;
			Core::Box<StateDiagram> state_diags_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_class:
	{
		classes_item=class_def();
		if ( inputState->guessing==0 ) {
			type = 0; classes_.push_back (classes_item);
		}
		break;
	}
	case LITERAL_class_diagram:
	{
		class_diags_item=class_diagram();
		if ( inputState->guessing==0 ) {
			type = 0; class_diags_.push_back (class_diags_item);
		}
		break;
	}
	case LITERAL_sequence_diagram:
	{
		sequence_diags_item=sequence_diagram();
		if ( inputState->guessing==0 ) {
			type = 0; sequence_diags_.push_back (sequence_diags_item);
		}
		break;
	}
	case LITERAL_state_diagram:
	{
		state_diags_item=state_diagram();
		if ( inputState->guessing==0 ) {
			type = 0; state_diags_.push_back (state_diags_item);
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

Core::Box<SequenceDiagram>  ViewPartParser::sequence_diagram() {
	Core::Box<SequenceDiagram> sequence_diagram_ret;
	
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_sequence_diagram);
	sequence_diagram_group_0(*sequence_diagram_ret);
	{ // ( ... )*
	for (;;) {
		if ((_tokenSet_2.member(LA(1)))) {
			flag=sequence_diagram_arbitrary_group_1(*sequence_diagram_ret, object_views_, message_views_, self_message_views_, return_message_views_, note_views_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop212;
		}
		
	}
	_loop212:;
	} // ( ... )*
	match(7);
	if ( inputState->guessing==0 ) {
		
					sequence_diagram_ret->object_views (object_views_);
					sequence_diagram_ret->message_views (message_views_);
					sequence_diagram_ret->self_message_views (self_message_views_);
					sequence_diagram_ret->return_message_views (return_message_views_);
					sequence_diagram_ret->note_views (note_views_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return sequence_diagram_ret;
}

Core::Box<StateDiagram>  ViewPartParser::state_diagram() {
	Core::Box<StateDiagram> state_diagram_ret;
	
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_state_diagram);
	state_diagram_group_0(*state_diagram_ret);
	{ // ( ... )*
	for (;;) {
		if ((_tokenSet_3.member(LA(1)))) {
			flag=state_diagram_arbitrary_group_1(*state_diagram_ret, state_views_, transition_views_, note_views_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop267;
		}
		
	}
	_loop267:;
	} // ( ... )*
	match(7);
	if ( inputState->guessing==0 ) {
		
					state_diagram_ret->state_views (state_views_);
					state_diagram_ret->transition_views (transition_views_);
					state_diagram_ret->note_views (note_views_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return state_diagram_ret;
}

SequenceDiagramList  ViewPartParser::sequence_diagram_list() {
	SequenceDiagramList sequence_diagram_list_ret;
	
			Core::Box<SequenceDiagram> item;
		
	
	{ // ( ... )+
	int _cnt209=0;
	for (;;) {
		if ((LA(1) == LITERAL_sequence_diagram)) {
			item=sequence_diagram();
			if ( inputState->guessing==0 ) {
				
							sequence_diagram_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt209>=1 ) { goto _loop209; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt209++;
	}
	_loop209:;
	}  // ( ... )+
	return sequence_diagram_list_ret;
}

void ViewPartParser::sequence_diagram_group_0(
	SequenceDiagram& sequence_diagram_ret
) {
	
			std::string name_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	name_=identifier();
	if ( inputState->guessing==0 ) {
		sequence_diagram_ret.name (name_);
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ViewPartParser::sequence_diagram_arbitrary_group_1(
	
		SequenceDiagram& sequence_diagram_ret
		, ObjectViewList& object_views_
		, MessageViewList& message_views_
		, SelfMessageViewList& self_message_views_
		, ReturnMessageViewList& return_message_views_
		, NoteViewList& note_views_
	
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  zoom_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
			Core::Box<ObjectView> object_views_item;
			Core::Box<MessageView> message_views_item;
			Core::Box<SelfMessageView> self_message_views_item;
			Core::Box<ReturnMessageView> return_message_views_item;
			Core::Box<NoteView> note_views_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_zoom:
	{
		match(LITERAL_zoom);
		match(11);
		zoom_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 2; sequence_diagram_ret.zoom (boost::lexical_cast<int> (zoom_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_object_view:
	{
		object_views_item=object_view();
		if ( inputState->guessing==0 ) {
			type = 0; object_views_.push_back (object_views_item);
		}
		break;
	}
	case LITERAL_message_view:
	{
		message_views_item=message_view();
		if ( inputState->guessing==0 ) {
			type = 0; message_views_.push_back (message_views_item);
		}
		break;
	}
	case LITERAL_self_message_view:
	{
		self_message_views_item=self_message_view();
		if ( inputState->guessing==0 ) {
			type = 0; self_message_views_.push_back (self_message_views_item);
		}
		break;
	}
	case LITERAL_return_message_view:
	{
		return_message_views_item=return_message_view();
		if ( inputState->guessing==0 ) {
			type = 0; return_message_views_.push_back (return_message_views_item);
		}
		break;
	}
	case LITERAL_note_view:
	{
		note_views_item=note_view();
		if ( inputState->guessing==0 ) {
			type = 0; note_views_.push_back (note_views_item);
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

Core::Box<ObjectView>  ViewPartParser::object_view() {
	Core::Box<ObjectView> object_view_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_object_view);
	object_view_group_0(*object_view_ret);
	object_view_group_1(*object_view_ret);
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == LITERAL_name)) {
			flag=object_view_arbitrary_group_2(*object_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop221;
		}
		
	}
	_loop221:;
	} // ( ... )*
	{ // ( ... )+
	int _cnt223=0;
	for (;;) {
		if ((LA(1) == LITERAL_center_x || LA(1) == LITERAL_center_y)) {
			flag=object_view_group_2(*object_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			if ( _cnt223>=1 ) { goto _loop223; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt223++;
	}
	_loop223:;
	}  // ( ... )+
	if ( inputState->guessing==0 ) {
		
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
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == LITERAL_name)) {
			flag=object_view_arbitrary_group_2(*object_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop225;
		}
		
	}
	_loop225:;
	} // ( ... )*
	match(7);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return object_view_ret;
}

Core::Box<MessageView>  ViewPartParser::message_view() {
	Core::Box<MessageView> message_view_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_message_view);
	message_view_group_0(*message_view_ret);
	message_view_group_1(*message_view_ret);
	{ // ( ... )+
	int _cnt240=0;
	for (;;) {
		if ((LA(1) == LITERAL_client || LA(1) == LITERAL_supplier || LA(1) == LITERAL_start_y)) {
			flag=message_view_group_2(*message_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			if ( _cnt240>=1 ) { goto _loop240; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt240++;
	}
	_loop240:;
	}  // ( ... )+
	if ( inputState->guessing==0 ) {
		
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
	match(7);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return message_view_ret;
}

Core::Box<SelfMessageView>  ViewPartParser::self_message_view() {
	Core::Box<SelfMessageView> self_message_view_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_self_message_view);
	self_message_view_group_0(*self_message_view_ret);
	self_message_view_group_1(*self_message_view_ret);
	self_message_view_group_2(*self_message_view_ret);
	match(7);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return self_message_view_ret;
}

Core::Box<ReturnMessageView>  ViewPartParser::return_message_view() {
	Core::Box<ReturnMessageView> return_message_view_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_return_message_view);
	return_message_view_group_0(*return_message_view_ret);
	return_message_view_group_1(*return_message_view_ret);
	{ // ( ... )+
	int _cnt257=0;
	for (;;) {
		if ((LA(1) == LITERAL_client || LA(1) == LITERAL_supplier || LA(1) == LITERAL_start_y)) {
			flag=return_message_view_group_2(*return_message_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			if ( _cnt257>=1 ) { goto _loop257; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt257++;
	}
	_loop257:;
	}  // ( ... )+
	if ( inputState->guessing==0 ) {
		
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
	match(7);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return return_message_view_ret;
}

ObjectViewList  ViewPartParser::object_view_list() {
	ObjectViewList object_view_list_ret;
	
			Core::Box<ObjectView> item;
		
	
	{ // ( ... )+
	int _cnt218=0;
	for (;;) {
		if ((LA(1) == LITERAL_object_view)) {
			item=object_view();
			if ( inputState->guessing==0 ) {
				
							object_view_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt218>=1 ) { goto _loop218; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt218++;
	}
	_loop218:;
	}  // ( ... )+
	return object_view_list_ret;
}

void ViewPartParser::object_view_group_0(
	ObjectView& object_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  number_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	number_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		object_view_ret.number (boost::lexical_cast<int> (number_->getText ()));
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ViewPartParser::object_view_group_1(
	ObjectView& object_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  guid_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	guid_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		object_view_ret.guid (guid_->getText ());
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ViewPartParser::object_view_arbitrary_group_2(
	ObjectView& object_view_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  name_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_name);
	match(11);
	name_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		type = 1 << 5; object_view_ret.name (name_->getText ());
	}
	match(5);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return type;
}

unsigned long  ViewPartParser::object_view_group_2(
	ObjectView& object_view_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_x_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_y_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_center_x:
	{
		match(LITERAL_center_x);
		match(11);
		center_x_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 3; object_view_ret.center_x (boost::lexical_cast<int> (center_x_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_center_y:
	{
		match(LITERAL_center_y);
		match(11);
		center_y_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 4; object_view_ret.center_y (boost::lexical_cast<int> (center_y_->getText ()));
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

MessageViewList  ViewPartParser::message_view_list() {
	MessageViewList message_view_list_ret;
	
			Core::Box<MessageView> item;
		
	
	{ // ( ... )+
	int _cnt237=0;
	for (;;) {
		if ((LA(1) == LITERAL_message_view)) {
			item=message_view();
			if ( inputState->guessing==0 ) {
				
							message_view_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt237>=1 ) { goto _loop237; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt237++;
	}
	_loop237:;
	}  // ( ... )+
	return message_view_list_ret;
}

void ViewPartParser::message_view_group_0(
	MessageView& message_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  number_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	number_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		message_view_ret.number (boost::lexical_cast<int> (number_->getText ()));
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ViewPartParser::message_view_group_1(
	MessageView& message_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  guid_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	guid_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		message_view_ret.guid (guid_->getText ());
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ViewPartParser::message_view_group_2(
	MessageView& message_view_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  client_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  supplier_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  start_y_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_client:
	{
		match(LITERAL_client);
		client_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 3; message_view_ret.client (boost::lexical_cast<int> (client_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_supplier:
	{
		match(LITERAL_supplier);
		supplier_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 4; message_view_ret.supplier (boost::lexical_cast<int> (supplier_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_start_y:
	{
		match(LITERAL_start_y);
		match(11);
		start_y_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 5; message_view_ret.start_y (boost::lexical_cast<int> (start_y_->getText ()));
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

SelfMessageViewList  ViewPartParser::self_message_view_list() {
	SelfMessageViewList self_message_view_list_ret;
	
			Core::Box<SelfMessageView> item;
		
	
	{ // ( ... )+
	int _cnt247=0;
	for (;;) {
		if ((LA(1) == LITERAL_self_message_view)) {
			item=self_message_view();
			if ( inputState->guessing==0 ) {
				
							self_message_view_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt247>=1 ) { goto _loop247; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt247++;
	}
	_loop247:;
	}  // ( ... )+
	return self_message_view_list_ret;
}

void ViewPartParser::self_message_view_group_0(
	SelfMessageView& self_message_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  number_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	number_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		self_message_view_ret.number (boost::lexical_cast<int> (number_->getText ()));
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ViewPartParser::self_message_view_group_1(
	SelfMessageView& self_message_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  guid_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	guid_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		self_message_view_ret.guid (guid_->getText ());
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ViewPartParser::self_message_view_group_2(
	SelfMessageView& self_message_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  start_y_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_start_y);
	match(11);
	start_y_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		self_message_view_ret.start_y (boost::lexical_cast<int> (start_y_->getText ()));
	}
	match(5);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

ReturnMessageViewList  ViewPartParser::return_message_view_list() {
	ReturnMessageViewList return_message_view_list_ret;
	
			Core::Box<ReturnMessageView> item;
		
	
	{ // ( ... )+
	int _cnt254=0;
	for (;;) {
		if ((LA(1) == LITERAL_return_message_view)) {
			item=return_message_view();
			if ( inputState->guessing==0 ) {
				
							return_message_view_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt254>=1 ) { goto _loop254; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt254++;
	}
	_loop254:;
	}  // ( ... )+
	return return_message_view_list_ret;
}

void ViewPartParser::return_message_view_group_0(
	ReturnMessageView& return_message_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  number_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	number_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		return_message_view_ret.number (boost::lexical_cast<int> (number_->getText ()));
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ViewPartParser::return_message_view_group_1(
	ReturnMessageView& return_message_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  guid_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	guid_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		return_message_view_ret.guid (guid_->getText ());
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ViewPartParser::return_message_view_group_2(
	ReturnMessageView& return_message_view_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  client_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  supplier_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  start_y_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_client:
	{
		match(LITERAL_client);
		client_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 3; return_message_view_ret.client (boost::lexical_cast<int> (client_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_supplier:
	{
		match(LITERAL_supplier);
		supplier_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 4; return_message_view_ret.supplier (boost::lexical_cast<int> (supplier_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_start_y:
	{
		match(LITERAL_start_y);
		match(11);
		start_y_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 5; return_message_view_ret.start_y (boost::lexical_cast<int> (start_y_->getText ()));
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

StateDiagramList  ViewPartParser::state_diagram_list() {
	StateDiagramList state_diagram_list_ret;
	
			Core::Box<StateDiagram> item;
		
	
	{ // ( ... )+
	int _cnt264=0;
	for (;;) {
		if ((LA(1) == LITERAL_state_diagram)) {
			item=state_diagram();
			if ( inputState->guessing==0 ) {
				
							state_diagram_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt264>=1 ) { goto _loop264; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt264++;
	}
	_loop264:;
	}  // ( ... )+
	return state_diagram_list_ret;
}

void ViewPartParser::state_diagram_group_0(
	StateDiagram& state_diagram_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  name_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	name_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		state_diagram_ret.name (name_->getText ());
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ViewPartParser::state_diagram_arbitrary_group_1(
	
		StateDiagram& state_diagram_ret
		, StateViewList& state_views_
		, TransitionViewList& transition_views_
		, NoteViewList& note_views_
	
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  zoom_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
			Core::Box<StateView> state_views_item;
			Core::Box<TransitionView> transition_views_item;
			Core::Box<NoteView> note_views_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_state_view:
	{
		state_views_item=state_view();
		if ( inputState->guessing==0 ) {
			type = 0; state_views_.push_back (state_views_item);
		}
		break;
	}
	case LITERAL_transition_view:
	{
		transition_views_item=transition_view();
		if ( inputState->guessing==0 ) {
			type = 0; transition_views_.push_back (transition_views_item);
		}
		break;
	}
	case LITERAL_note_view:
	{
		note_views_item=note_view();
		if ( inputState->guessing==0 ) {
			type = 0; note_views_.push_back (note_views_item);
		}
		break;
	}
	case LITERAL_zoom:
	{
		match(LITERAL_zoom);
		match(11);
		zoom_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 5; state_diagram_ret.zoom (boost::lexical_cast<int> (zoom_->getText ()));
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

Core::Box<StateView>  ViewPartParser::state_view() {
	Core::Box<StateView> state_view_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_state_view);
	state_view_group_0(*state_view_ret);
	state_view_group_1(*state_view_ret);
	{ // ( ... )+
	int _cnt276=0;
	for (;;) {
		if ((LA(1) == LITERAL_center_x || LA(1) == LITERAL_center_y)) {
			flag=state_view_group_2(*state_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			if ( _cnt276>=1 ) { goto _loop276; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt276++;
	}
	_loop276:;
	}  // ( ... )+
	if ( inputState->guessing==0 ) {
		
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
	match(7);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return state_view_ret;
}

Core::Box<TransitionView>  ViewPartParser::transition_view() {
	Core::Box<TransitionView> transition_view_ret;
	
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
	
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_transition_view);
	transition_view_group_0(*transition_view_ret);
	transition_view_group_1(*transition_view_ret);
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == LITERAL_stereotype_view || LA(1) == LITERAL_param_view)) {
			flag=transition_view_arbitrary_group_2(*transition_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop290;
		}
		
	}
	_loop290:;
	} // ( ... )*
	{ // ( ... )+
	int _cnt292=0;
	for (;;) {
		if (((LA(1) >= LITERAL_client && LA(1) <= LITERAL_points))) {
			flag=transition_view_group_2(*transition_view_ret, points_);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			if ( _cnt292>=1 ) { goto _loop292; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt292++;
	}
	_loop292:;
	}  // ( ... )+
	if ( inputState->guessing==0 ) {
		
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
	{ // ( ... )*
	for (;;) {
		if ((LA(1) == LITERAL_stereotype_view || LA(1) == LITERAL_param_view)) {
			flag=transition_view_arbitrary_group_2(*transition_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_2 = check_attribute_originality (accumulated_flag_2, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			goto _loop294;
		}
		
	}
	_loop294:;
	} // ( ... )*
	match(7);
	if ( inputState->guessing==0 ) {
		
					transition_view_ret->points (points_);
				
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return transition_view_ret;
}

StateViewList  ViewPartParser::state_view_list() {
	StateViewList state_view_list_ret;
	
			Core::Box<StateView> item;
		
	
	{ // ( ... )+
	int _cnt273=0;
	for (;;) {
		if ((LA(1) == LITERAL_state_view)) {
			item=state_view();
			if ( inputState->guessing==0 ) {
				
							state_view_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt273>=1 ) { goto _loop273; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt273++;
	}
	_loop273:;
	}  // ( ... )+
	return state_view_list_ret;
}

void ViewPartParser::state_view_group_0(
	StateView& state_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  number_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	number_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		state_view_ret.number (boost::lexical_cast<int> (number_->getText ()));
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ViewPartParser::state_view_group_1(
	StateView& state_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  guid_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	guid_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		state_view_ret.guid (guid_->getText ());
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ViewPartParser::state_view_group_2(
	StateView& state_view_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_x_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_y_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_center_x:
	{
		match(LITERAL_center_x);
		match(11);
		center_x_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 3; state_view_ret.center_x (boost::lexical_cast<int> (center_x_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_center_y:
	{
		match(LITERAL_center_y);
		match(11);
		center_y_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 4; state_view_ret.center_y (boost::lexical_cast<int> (center_y_->getText ()));
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

TransitionViewList  ViewPartParser::transition_view_list() {
	TransitionViewList transition_view_list_ret;
	
			Core::Box<TransitionView> item;
		
	
	{ // ( ... )+
	int _cnt287=0;
	for (;;) {
		if ((LA(1) == LITERAL_transition_view)) {
			item=transition_view();
			if ( inputState->guessing==0 ) {
				
							transition_view_list_ret.push_back (item);
						
			}
		}
		else {
			if ( _cnt287>=1 ) { goto _loop287; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt287++;
	}
	_loop287:;
	}  // ( ... )+
	return transition_view_list_ret;
}

void ViewPartParser::transition_view_group_0(
	TransitionView& transition_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  number_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	number_ = LT(1);
	match(SIGNED);
	if ( inputState->guessing==0 ) {
		transition_view_ret.number (boost::lexical_cast<int> (number_->getText ()));
	}
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

void ViewPartParser::transition_view_group_1(
	TransitionView& transition_view_ret
) {
	ANTLR_USE_NAMESPACE(antlr)RefToken  guid_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	guid_ = LT(1);
	match(STRING);
	if ( inputState->guessing==0 ) {
		transition_view_ret.guid (guid_->getText ());
	}
	match(8);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
}

unsigned long  ViewPartParser::transition_view_arbitrary_group_2(
	TransitionView& transition_view_ret
) {
	unsigned long type;
	
			Core::Box<ParamView> param_view_;
			Core::Box<StereotypeView> stereotype_view_;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_param_view:
	{
		param_view_=param_view();
		if ( inputState->guessing==0 ) {
			type = 1 << 6; transition_view_ret.param_view (param_view_);
		}
		break;
	}
	case LITERAL_stereotype_view:
	{
		stereotype_view_=stereotype_view();
		if ( inputState->guessing==0 ) {
			type = 1 << 7; transition_view_ret.stereotype_view (stereotype_view_);
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

unsigned long  ViewPartParser::transition_view_group_2(
	
		TransitionView& transition_view_ret
		, PointList& points_
	
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  client_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  supplier_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
			Core::Box<Point> points_item;
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_client:
	{
		match(LITERAL_client);
		client_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 3; transition_view_ret.client (boost::lexical_cast<int> (client_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_supplier:
	{
		match(LITERAL_supplier);
		supplier_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 4; transition_view_ret.supplier (boost::lexical_cast<int> (supplier_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_points:
	{
		match(LITERAL_points);
		match(11);
		points_item=point();
		if ( inputState->guessing==0 ) {
			type = 1 << 5; points_.push_back (points_item);
		}
		{ // ( ... )*
		for (;;) {
			if ((LA(1) == 24)) {
				match(24);
				points_item=point();
				if ( inputState->guessing==0 ) {
					type = 1 << 5; points_.push_back (points_item);
				}
			}
			else {
				goto _loop300;
			}
			
		}
		_loop300:;
		} // ( ... )*
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

Core::Box<ParamView>  ViewPartParser::param_view() {
	Core::Box<ParamView> param_view_ret;
	
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
		
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	match(LITERAL_param_view);
	match(8);
	{ // ( ... )+
	int _cnt305=0;
	for (;;) {
		if ((LA(1) == LITERAL_center_x || LA(1) == LITERAL_center_y)) {
			flag=param_view_group_1(*param_view_ret);
			if ( inputState->guessing==0 ) {
				accumulated_flag_1 = check_attribute_originality (accumulated_flag_1, flag, LT (1), local::get_descriptions ());
			}
		}
		else {
			if ( _cnt305>=1 ) { goto _loop305; } else {throw ANTLR_USE_NAMESPACE(antlr)NoViableAltException(LT(1), getFilename());}
		}
		
		_cnt305++;
	}
	_loop305:;
	}  // ( ... )+
	if ( inputState->guessing==0 ) {
		
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
	match(7);
	if ( inputState->guessing==0 ) {
		rule_end ();
	}
	return param_view_ret;
}

unsigned long  ViewPartParser::param_view_group_1(
	ParamView& param_view_ret
) {
	unsigned long type;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_x_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	ANTLR_USE_NAMESPACE(antlr)RefToken  center_y_ = ANTLR_USE_NAMESPACE(antlr)nullToken;
	
	if ( inputState->guessing==0 ) {
		rule_begin ();
	}
	{
	switch ( LA(1)) {
	case LITERAL_center_x:
	{
		match(LITERAL_center_x);
		match(11);
		center_x_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 1; param_view_ret.center_x (boost::lexical_cast<int> (center_x_->getText ()));
		}
		match(5);
		break;
	}
	case LITERAL_center_y:
	{
		match(LITERAL_center_y);
		match(11);
		center_y_ = LT(1);
		match(SIGNED);
		if ( inputState->guessing==0 ) {
			type = 1 << 2; param_view_ret.center_y (boost::lexical_cast<int> (center_y_->getText ()));
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

void ViewPartParser::initializeASTFactory( ANTLR_USE_NAMESPACE(antlr)ASTFactory& )
{
}
const char* ViewPartParser::tokenNames[] = {
	"<0>",
	"EOF",
	"<2>",
	"NULL_TREE_LOOKAHEAD",
	"\"namespace\"",
	"\";\"",
	"\"package\"",
	"\"}\"",
	"\"{\"",
	"\"class_diagram\"",
	"\"zoom\"",
	"\"=\"",
	"SIGNED",
	"\"class_view\"",
	"STRING",
	"\"center_x\"",
	"\"center_y\"",
	"\"package_view\"",
	"\"note_view\"",
	"\"text\"",
	"\"inherit_view\"",
	"\"client\"",
	"\"supplier\"",
	"\"points\"",
	"\",\"",
	"\"(\"",
	"\")\"",
	"\"realize_view\"",
	"\"association_view\"",
	"\"name_view\"",
	"\"stereotype_view\"",
	"\"class_diagram_view\"",
	"\"sequence_diagram_view\"",
	"\"state_diagram_view\"",
	"\"dependency_view\"",
	"\"class\"",
	"\"sequence_diagram\"",
	"\"object_view\"",
	"\"name\"",
	"\"message_view\"",
	"\"start_y\"",
	"\"self_message_view\"",
	"\"return_message_view\"",
	"\"state_diagram\"",
	"\"state_view\"",
	"\"transition_view\"",
	"\"param_view\"",
	"IDENTIFIER",
	"ALL_POST_AND_PREFIXES",
	"ESC",
	"XDIGIT",
	"WS_",
	0
};

const unsigned long ViewPartParser::_tokenSet_0_data_[] = { 2551587840UL, 7UL, 0UL, 0UL };
// "zoom" "class_view" "package_view" "note_view" "inherit_view" "realize_view" 
// "association_view" "class_diagram_view" "sequence_diagram_view" "state_diagram_view" 
// "dependency_view" 
const ANTLR_USE_NAMESPACE(antlr)BitSet ViewPartParser::_tokenSet_0(_tokenSet_0_data_,4);
const unsigned long ViewPartParser::_tokenSet_1_data_[] = { 512UL, 2072UL, 0UL, 0UL };
// "class_diagram" "class" "sequence_diagram" "state_diagram" 
const ANTLR_USE_NAMESPACE(antlr)BitSet ViewPartParser::_tokenSet_1(_tokenSet_1_data_,4);
const unsigned long ViewPartParser::_tokenSet_2_data_[] = { 263168UL, 1696UL, 0UL, 0UL };
// "zoom" "note_view" "object_view" "message_view" "self_message_view" 
// "return_message_view" 
const ANTLR_USE_NAMESPACE(antlr)BitSet ViewPartParser::_tokenSet_2(_tokenSet_2_data_,4);
const unsigned long ViewPartParser::_tokenSet_3_data_[] = { 263168UL, 12288UL, 0UL, 0UL };
// "zoom" "note_view" "state_view" "transition_view" 
const ANTLR_USE_NAMESPACE(antlr)BitSet ViewPartParser::_tokenSet_3(_tokenSet_3_data_,4);


ANTLR_END_NAMESPACE
ANTLR_END_NAMESPACE
