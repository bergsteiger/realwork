header "pre_include_hpp" {
#include "shared/Core/sys/std_inc.h"
}

header "post_include_hpp" {
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPart.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPart.h"
#include "MDProcess/MDAFormat/ModelPartDef/RootPackage.h"
#include "MDProcess/MDAFormat/ViewPartDef/ViewPart.h"

#include <vector>
#include <map>
}
options {
	language = "Cpp";
	genHashLines=false;
	namespace = "MDAFormat::RootFile";
}

{
	void ModelRootParser::rule_begin () {
		this->reset_error_stack ();
	}
	
	void ModelRootParser::rule_end () {
		this->reset_error_stack ();
	}
}
class ModelRootParser extends Parser;
options {
	defaultErrorHandler=false;
}
{
	public:
		void rule_begin ();
		
		void rule_end ();
}
root
	returns [std::vector<Core::Box<ModelPartDef::RootPackage> > root_package_ret]
	:	model_part
		(view_part)?
		(additional_part)?

	;


model_part
	:	"model_part" "{"
		(
			path:GRAMMAR_FILE_PATH ";"
			{
				ModelPartDef::ModelPart item (path->getText ().c_str ());
				ModelPartDef::ModelPartParser::ContextSingleton::instance ()->on_new_element (item.root_package ());
			}
		)*
		"}"
	;


additional_part
	:	"additional_part" "{"
		(
			path:GRAMMAR_FILE_PATH ";"
			{
				AdditionalPartDef::AdditionalPart item (path->getText ().c_str ());
				AdditionalPartDef::AdditionalPartParser::ContextSingleton::instance ()->on_new_element (item.root_package ());
			}
		)*
		"}"
	;


view_part
	:	"view_part" "{"
		(
			path:GRAMMAR_FILE_PATH ";"
			{
				ViewPartDef::ViewPart item (path->getText ().c_str ());
				ViewPartDef::ViewPartParser::ContextSingleton::instance ()->on_new_element (item.root_package ());
			}
		)*
		"}"
	;






class ModelRootLexer extends Lexer;
options {
	k = 2;
	testLiterals = false;
	charVocabulary = '\003'..'\377'
					;
}
ALL_POST_AND_PREFIXES
	options {testLiterals=true;}
	:	("additional_part") => "additional_part"
	|("model_part") => "model_part"
	|("view_part") => "view_part"
	|"}"
	|"{"
	|";"
	;

GRAMMAR_FILE_PATH
	:	(('a'..'z')|('A'..'Z')) ':' (~(';'))*
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
