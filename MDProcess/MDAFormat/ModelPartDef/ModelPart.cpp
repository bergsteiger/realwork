////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/ModelPart.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Grammar::Class>> MDProcess::MDAFormat::ModelPartDef::ModelPart
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "boost/algorithm/string/join.hpp"
#include "antlr/ANTLRException.hpp"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPart.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartParser.hpp"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartLexer.hpp"

namespace MDAFormat {
namespace ModelPartDef {

ModelPart::ModelPart (const char* source_file)
	: m_filename (source_file), m_input_stream (new std::ifstream (source_file))
{
}

ModelPart::ModelPart (std::istream* source_stream)
	: m_input_stream (source_stream)
{
}

Core::Box<RootPackage> ModelPart::root_package () /*antrl::ANTRLException*/ {
	ModelPartLexer lexer (*m_input_stream.ptr ());
	lexer.setFilename (m_filename);
	
	ModelPartParser parser (lexer);
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
} // namespace ModelPartDef
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
