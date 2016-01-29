////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/AdditionalPartDef/TransitionView.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::TransitionView
//
// ���� ��� ������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_TRANSITIONVIEW_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_TRANSITIONVIEW_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/TransitionViewContent.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// ���� ��� ������������
class TransitionView {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	unsigned int get_number () const;

	void set_number (unsigned int number);

	const std::string& get_guid () const;

	void set_guid (const std::string& guid);

	const Core::Box<TransitionViewContent>& content () const;

	void content (const Core::Box<TransitionViewContent>& content);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	unsigned int m_number;

	std::string m_guid;

	Core::Box<TransitionViewContent> m_content;


}; //class TransitionView

std::ostream& operator << (std::ostream& out_stream, const TransitionView& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_TRANSITIONVIEW_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
