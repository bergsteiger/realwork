////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/ModelPartDef/RootPackage.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::RootPackage
//
// ������� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_ROOTPACKAGE_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_ROOTPACKAGE_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/Namespace.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
#include "MDProcess/MDAFormat/ModelPartDef/Package.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// ������� �����
class RootPackage {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const NamespaceList& get_namepsaces () const;

	void set_namepsaces (const NamespaceList& namepsaces);

	const Package& get_root () const;

	void set_root (const Package& root);

	const std::string& get_file_name () const;

	void set_file_name (const std::string& file_name);
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// ������ �����������
	NamespaceList m_namepsaces;

	// ������� �����
	Package m_root;

	std::string m_file_name; //������ ���������� - �� ������ ����� ��� �������� �������

}; //class RootPackage

std::ostream& operator << (std::ostream& out_stream, const RootPackage& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_ROOTPACKAGE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
