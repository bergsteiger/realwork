////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/ViewPartDef/ViewPart.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Grammar::Class>> MDProcess::MDAFormat::ViewPartDef::ViewPart
//
// ���� ��� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_VIEWPARTDEF_VIEWPART_H__
#define __MDPROCESS_MDAFORMAT_VIEWPARTDEF_VIEWPART_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ViewPartDef/RootPackage.h"
#include <stdio.h>
#include <fstream>

namespace MDAFormat {
namespace ViewPartDef {

// ���� ��� ������������
class ViewPart {

public:
	explicit ViewPart (const char* file_name);
	explicit ViewPart (std::istream* source_stream);

	Core::Box<RootPackage> root_package () /*antrl::ANTRLException*/;

private:
	Core::Aptr<std::istream> m_input_stream;
	std::string m_filename;
}; //class ViewPart
} // namespace ViewPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_VIEWPARTDEF_VIEWPART_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
