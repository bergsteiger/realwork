////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/DiagramColorizer.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::RoseDumpers::DiagramColorizer
//
// расскрасщик диаграмм
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_DIAGRAMCOLORIZER_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_DIAGRAMCOLORIZER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"


// расскрасщик диаграмм
class DiagramColorizer {
	SET_OBJECT_COUNTER (DiagramColorizer)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// guid элемента -> связання с элементом нота
	typedef std::map < std::string, IRoseNoteViewPtr > NoteMap;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// конструтор.
	// \diag - диаграмма, которую нужно расскрасить
	explicit DiagramColorizer (IRoseDiagramPtr diag);

public:
	virtual ~DiagramColorizer ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// раскашиваем один элемент на диаграмме
	// \elem - элемент, который нужно расскрасить
	virtual void colorize (IRoseElementPtr elem);

	// расскрашиваем всю диаграмму
	virtual void colorize ();

private:
	// раскраска вью конкретного элемента на диаграмме
	virtual void colorize_i (IRoseItemViewPtr view);

	// алгоритм расскраски вью элемента, если у него есть переопределённые свойства
	virtual void colorize_overwritten_prop (IRoseItemViewPtr view);

	// инициализирует мапы Нот
	virtual void init_notes ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// расскрашиваемая диаграмма
	IRoseDiagramPtr m_diag;

	// родитель диаграммы (класс или пакет)
	IRoseElementPtr m_diag_parent;

	// мапа Нот, расположенных непосредственно на вью элемента (обычно в них написана видимость
	// элемента)
	NoteMap m_note_map;

	// мапа Нот с дополнительной информацией
	NoteMap m_up_note_map;
}; // class DiagramColorizer



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_DIAGRAMCOLORIZER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

