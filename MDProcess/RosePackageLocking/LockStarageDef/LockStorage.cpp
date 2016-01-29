////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/LockStarageDef/LockStorage.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Grammar::Class>> MDProcess::RosePackageLocking::LockStarageDef::LockStorage
//
// хранилище информации о захваченных пакетах
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "boost/algorithm/string/join.hpp"
#include "antlr/ANTLRException.hpp"
#include "MDProcess/RosePackageLocking/LockStarageDef/LockStorage.h"
#include "MDProcess/RosePackageLocking/LockStarageDef/LockStorageParser.hpp"
#include "MDProcess/RosePackageLocking/LockStarageDef/LockStorageLexer.hpp"

namespace RosePackageLocking {
namespace LockStarageDef {

LockStorage::LockStorage (const char* source_file)
	: m_filename (source_file), m_input_stream (new std::ifstream (source_file))
{
}

LockStorage::LockStorage (std::istream* source_stream)
	: m_input_stream (source_stream)
{
}

PackageInfoList LockStorage::packages () /*antrl::ANTRLException*/ {
	LockStorageLexer lexer (*m_input_stream.ptr ());
	lexer.setFilename (m_filename);
	
	LockStorageParser parser (lexer);
	parser.setFilename (m_filename);
	
	PackageInfoList res;
	try {
		res = parser.packages ();
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
} // namespace LockStarageDef
} // namespace RosePackageLocking


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
