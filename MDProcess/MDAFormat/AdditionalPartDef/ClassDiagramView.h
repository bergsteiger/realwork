////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/AdditionalPartDef/ClassDiagramView.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::ClassDiagramView
//
// ���� ��� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_CLASSDIAGRAMVIEW_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_CLASSDIAGRAMVIEW_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ViewContent.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// ���� ��� ������������
class ClassDiagramView {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const Core::Box<ViewContent>& conent () const;

	void conent (const Core::Box<ViewContent>& conent);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	Core::Box<ViewContent> m_conent;


}; //class ClassDiagramView

std::ostream& operator << (std::ostream& out_stream, const ClassDiagramView& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_CLASSDIAGRAMVIEW_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
