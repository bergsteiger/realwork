////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/AdditionalPartDef/ObjectView.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::ObjectView
//
// ���� ��� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_OBJECTVIEW_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_OBJECTVIEW_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ViewContent.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// ���� ��� ������������
class ObjectView {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const Core::Box<ViewContent>& content () const;

	void content (const Core::Box<ViewContent>& content);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	Core::Box<ViewContent> m_content;


}; //class ObjectView

std::ostream& operator << (std::ostream& out_stream, const ObjectView& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_OBJECTVIEW_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
