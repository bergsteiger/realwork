////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/ClassDiagram.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::ClassDiagram
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_CLASSDIAGRAM_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_CLASSDIAGRAM_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/ClassDiagramContent.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// пока нет документации
class ClassDiagram {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_name () const;

	void set_name (const std::string& name);

	const std::string& get_guid () const;

	void set_guid (const std::string& guid);

	const Core::Box<ClassDiagramContent>& content () const;

	void content (const Core::Box<ClassDiagramContent>& content);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// имя диаграммы
	std::string m_name;

	std::string m_guid;

	Core::Box<ClassDiagramContent> m_content;


}; //class ClassDiagram

std::ostream& operator << (std::ostream& out_stream, const ClassDiagram& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_CLASSDIAGRAM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
