////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/ClassView.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::ClassView
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_CLASSVIEW_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_CLASSVIEW_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ViewContent.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// пока нет документации
class ClassView {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const Core::Box<ViewContent>& conent () const;

	void conent (const Core::Box<ViewContent>& conent);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// дополнительные свойства
	Core::Box<ViewContent> m_conent;


}; //class ClassView

std::ostream& operator << (std::ostream& out_stream, const ClassView& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_CLASSVIEW_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
