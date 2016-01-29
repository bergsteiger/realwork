////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/AdditionalPartDef/AdditionalPart.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Grammar::Class>> MDProcess::MDAFormat::AdditionalPartDef::AdditionalPart
//
// ���� ��� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_ADDITIONALPART_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_ADDITIONALPART_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/RootPackage.h"
#include <stdio.h>
#include <fstream>

namespace MDAFormat {
namespace AdditionalPartDef {

// ���� ��� ������������
class AdditionalPart {

public:
	explicit AdditionalPart (const char* file_name);
	explicit AdditionalPart (std::istream* source_stream);

	Core::Box<RootPackage> root_package () /*antrl::ANTRLException*/;

private:
	Core::Aptr<std::istream> m_input_stream;
	std::string m_filename;
}; //class AdditionalPart
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_ADDITIONALPART_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
