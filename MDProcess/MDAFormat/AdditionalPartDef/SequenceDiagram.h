////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/AdditionalPartDef/SequenceDiagram.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::AdditionalPartDef::SequenceDiagram
//
// пока нет документации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_SEQUENCEDIAGRAM_H__
#define __MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_SEQUENCEDIAGRAM_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/AdditionalPartDef/SequenceDiagramContent.h"
#include <ostream>

namespace MDAFormat {
namespace AdditionalPartDef {

// пока нет документации
class SequenceDiagram {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_name () const;

	void set_name (const std::string& name);

	const std::string& get_guid () const;

	void set_guid (const std::string& guid);

	const Core::Box<SequenceDiagramContent>& content () const;

	void content (const Core::Box<SequenceDiagramContent>& content);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	std::string m_name;

	std::string m_guid;

	Core::Box<SequenceDiagramContent> m_content;


}; //class SequenceDiagram

std::ostream& operator << (std::ostream& out_stream, const SequenceDiagram& item);
} // namespace AdditionalPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_ADDITIONALPARTDEF_SEQUENCEDIAGRAM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
