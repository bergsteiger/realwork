////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/AdditionalPart.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Grammar::Class>> MDProcess::MDAFormat::AdditionalPartDef::AdditionalPart
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "boost/algorithm/string/join.hpp"
#include "antlr/ANTLRException.hpp"
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPart.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPartParser.hpp"
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPartLexer.hpp"

namespace MDAFormat {
namespace AdditionalPartDef {

AdditionalPart::AdditionalPart (const char* source_file)
	: m_filename (source_file), m_input_stream (new std::ifstream (source_file))
{
}

AdditionalPart::AdditionalPart (std::istream* source_stream)
	: m_input_stream (source_stream)
{
}

Core::Box<RootPackage> AdditionalPart::root_package () /*antrl::ANTRLException*/ {
	AdditionalPartLexer lexer (*m_input_stream.ptr ());
	lexer.setFilename (m_filename);
	
	AdditionalPartParser parser (lexer);
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
} // namespace AdditionalPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
