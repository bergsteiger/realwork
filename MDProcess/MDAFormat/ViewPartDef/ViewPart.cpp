////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ViewPartDef/ViewPart.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Grammar::Class>> MDProcess::MDAFormat::ViewPartDef::ViewPart
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "boost/algorithm/string/join.hpp"
#include "antlr/ANTLRException.hpp"
#include "MDProcess/MDAFormat/ViewPartDef/ViewPart.h"
#include "MDProcess/MDAFormat/ViewPartDef/ViewPartParser.hpp"
#include "MDProcess/MDAFormat/ViewPartDef/ViewPartLexer.hpp"

namespace MDAFormat {
namespace ViewPartDef {

ViewPart::ViewPart (const char* source_file)
	: m_filename (source_file), m_input_stream (new std::ifstream (source_file))
{
}

ViewPart::ViewPart (std::istream* source_stream)
	: m_input_stream (source_stream)
{
}

Core::Box<RootPackage> ViewPart::root_package () /*antrl::ANTRLException*/ {
	ViewPartLexer lexer (*m_input_stream.ptr ());
	lexer.setFilename (m_filename);
	
	ViewPartParser parser (lexer);
	parser.setFilename (m_filename);
	
	Core::Box<RootPackage> res;
	try {
		res = parser.root_package ();
	} catch (antlr::RecognitionException& ex) {
		if (parser.has_stack_error ()) {
			std::string full_message = ex.getMessage ();
			full_message += ", additional info:\n";
			full_message += boost::algorithm::join (parser.get_error_stack (), ", ");
			
			throw antlr::RecognitionException (full_message, ex.getFilename (), ex.getLine (), ex.getColumn ());
		}
		throw ex;
	}
	
	return res;
}
} // namespace ViewPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
