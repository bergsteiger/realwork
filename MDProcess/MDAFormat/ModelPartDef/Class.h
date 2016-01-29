////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAFormat/ModelPartDef/Class.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::MDAFormat::ModelPartDef::Class
//
// Описание класса
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAFORMAT_MODELPARTDEF_CLASS_H__
#define __MDPROCESS_MDAFORMAT_MODELPARTDEF_CLASS_H__

#include "shared/Core/sys/std_inc.h"
#include "MDProcess/MDAFormat/ModelPartDef/OperationArgument.h"
#include "MDProcess/MDAFormat/ModelPartDef/ClassContent.h"
#include "MDProcess/MDAFormat/ModelPartDef/ModelPartDef.h"
#include <ostream>

namespace MDAFormat {
namespace ModelPartDef {

// Описание класса
class Class {
	//////////////////////////////////////////////////////////////////////////////////////////
	// init ctor
public:
	Class ();

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	bool get_native () const;

	void set_native (bool native);

	const AbstractionType& get_abstractiveness () const;

	void set_abstractiveness (const AbstractionType& abstractiveness);

	const VisibilityType& get_visibility () const;

	void set_visibility (const VisibilityType& visibility);

	const std::string& get_stereotype () const;

	void set_stereotype (const std::string& stereotype);

	const std::string& get_name () const;

	void set_name (const std::string& name);

	const StringList& get_extends_list () const;

	void set_extends_list (const StringList& extends_list);

	const StringList& get_implements_list () const;

	void set_implements_list (const StringList& implements_list);

	const ArgumentList& get_template_params () const;

	void set_template_params (const ArgumentList& template_params);

	const ClassContent& get_content () const;

	void set_content (const ClassContent& content);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// прихнак нативности класса
	bool m_native;

	// абстрактность класса
	AbstractionType m_abstractiveness;

	// видимость
	VisibilityType m_visibility;

	// стереотип класса
	std::string m_stereotype;

	// имя класса
	std::string m_name;

	// список базовых классов
	StringList m_extends_list;

	StringList m_implements_list;

	// список шаблонных параметров
	ArgumentList m_template_params;

	ClassContent m_content;


}; //class Class

std::ostream& operator << (std::ostream& out_stream, const Class& item);
} // namespace ModelPartDef
} // namespace MDAFormat



#endif //__MDPROCESS_MDAFORMAT_MODELPARTDEF_CLASS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
