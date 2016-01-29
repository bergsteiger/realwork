////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/RootFile/ModelRoot.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Grammar::Class>> MDProcess::MDAFormat::RootFile::ModelRoot
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "boost/algorithm/string/join.hpp"
#include "antlr/ANTLRException.hpp"
#include "MDProcess/MDAFormat/RootFile/ModelRoot.h"
#include "MDProcess/MDAFormat/RootFile/ModelRootParser.hpp"
#include "MDProcess/MDAFormat/RootFile/ModelRootLexer.hpp"

namespace MDAFormat {
namespace RootFile {

ModelRoot::ModelRoot (const char* source_file)
	: m_filename (source_file), m_input_stream (new std::ifstream (source_file))
{
}

ModelRoot::ModelRoot (std::istream* source_stream)
	: m_input_stream (source_stream)
{
}

std::vector<Core::Box<ModelPartDef::RootPackage> > ModelRoot::root () /*antrl::ANTRLException*/ {
	ModelRootLexer lexer (*m_input_stream.ptr ());
	lexer.setFilename (m_filename);
	
	ModelRootParser parser (lexer);
	parser.setFilename (m_filename);
	
	std::vector<Core::Box<ModelPartDef::RootPackage> > res;
	try {
		res = parser.root ();
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
} // namespace RootFile
} // namespace MDAFormat


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
