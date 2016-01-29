////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/SelfMessageView.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::SelfMessageView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_SELFMESSAGEVIEW_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_SELFMESSAGEVIEW_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ViewContent.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// пока нет документации
class SelfMessageView {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const Core::Box<ViewContent>& content () const;

	void content (const Core::Box<ViewContent>& content);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	Core::Box<ViewContent> m_content;


}; //class SelfMessageView

std::ostream& operator << (std::ostream& out_stream, const SelfMessageView& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_SELFMESSAGEVIEW_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
