////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/StateDiagram.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::StateDiagram
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_STATEDIAGRAM_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_STATEDIAGRAM_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/StateDiagramContent.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// пока нет документации
class StateDiagram {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_name () const;

	void set_name (const std::string& name);

	const std::string& get_guid () const;

	void set_guid (const std::string& guid);

	const Core::Box<StateDiagramContent>& content () const;

	void content (const Core::Box<StateDiagramContent>& content);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	std::string m_name;

	std::string m_guid;

	Core::Box<StateDiagramContent> m_content;


}; //class StateDiagram

std::ostream& operator << (std::ostream& out_stream, const StateDiagram& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_STATEDIAGRAM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
