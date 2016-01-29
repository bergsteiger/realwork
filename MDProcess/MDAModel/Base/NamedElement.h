////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/Base/NamedElement.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::Base::NamedElement
//
// базовый интерфейс для именованного элемента
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_BASE_NAMEDELEMENT_H__
#define __MDPROCESS_MDAMODEL_BASE_NAMEDELEMENT_H__

#include "shared/CoreSrv/sys/std_inc.h"


// базовый интерфейс для именованного элемента
class NamedElement {
// virtual void destructor
public:
	virtual ~NamedElement () {};

//////////////////////////////////////////////////////////////////////////////////////////
// abstarct methods
public:
	// возвращает полное имя элемента
	virtual const std::string get_full_name () const = 0;

}; // class NamedElement



#endif //__MDPROCESS_MDAMODEL_BASE_NAMEDELEMENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

