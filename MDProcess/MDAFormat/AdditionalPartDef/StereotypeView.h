////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/AdditionalPartDef/StereotypeView.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::StereotypeView
//
// ���� ��� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_STEREOTYPEVIEW_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_STEREOTYPEVIEW_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ViewContent.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// ���� ��� ������������
class StereotypeView {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const Core::Box<ViewContent>& content () const;

	void content (const Core::Box<ViewContent>& content);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	Core::Box<ViewContent> m_content;


}; //class StereotypeView

std::ostream& operator << (std::ostream& out_stream, const StereotypeView& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_STEREOTYPEVIEW_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
