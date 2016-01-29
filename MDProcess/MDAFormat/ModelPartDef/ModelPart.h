////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/ModelPart.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Grammar::Class>> MDProcess::MDAFormat::ModelPartDef::ModelPart
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_MODELPART_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_MODELPART_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/RootPackage.h"
#include <stdio.h>
#include <fstream>

namespace MDAFormat {
namespace ModelPartDef {

// пока нет документации
class ModelPart {

public:
	explicit ModelPart (const char* file_name);
	explicit ModelPart (std::istream* source_stream);

	Core::Box<RootPackage> root_package () /*antrl::ANTRLException*/;

private:
	Core::Aptr<std::istream> m_input_stream;
	std::string m_filename;
}; //class ModelPart
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_MODELPART_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
