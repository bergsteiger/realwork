////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/RootFile/ModelRoot.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Grammar::Class>> MDProcess::MDAFormat::RootFile::ModelRoot
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ROOTFILE_MODELROOT_H__
#define __MDPROCESS_MDAFORMAT_ROOTFILE_MODELROOT_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/AdditionalPart.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPart.h"
#include "MDProcess/MDAFormat/ModelPartDef/RootPackage.h"
#include "MDProcess/MDAFormat/ViewPartDef/ViewPart.h"
#include <stdio.h>
#include <fstream>

namespace MDAFormat {
namespace RootFile {

// пока нет документации
class ModelRoot {

public:
	explicit ModelRoot (const char* file_name);
	explicit ModelRoot (std::istream* source_stream);

	std::vector<Core::Box<ModelPartDef::RootPackage> > root () /*antrl::ANTRLException*/;

private:
	Core::Aptr<std::istream> m_input_stream;
	std::string m_filename;
}; //class ModelRoot
} // namespace RootFile
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ROOTFILE_MODELROOT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
