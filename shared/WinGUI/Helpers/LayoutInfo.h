////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/Helpers/LayoutInfo.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::Helpers::LayoutInfo
//
// Класс для хранения информации и опций о контроле. Позволяет определять какие опции установлены,
// а какие нет.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_HELPERS_LAYOUTINFO_H__
#define __SHARED_WINGUI_HELPERS_LAYOUTINFO_H__

#include "shared/Core/sys/std_inc.h"
#include <map>

//#UC START# *4652AEFF0128_CUSTOM_INCLUDES*
//#UC END# *4652AEFF0128_CUSTOM_INCLUDES*

namespace WinGUI {

// Класс для хранения информации и опций о контроле. Позволяет определять какие опции установлены,
// а какие нет.
class LayoutInfo {
	SET_OBJECT_COUNTER (LayoutInfo)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// типы опций
	enum OptionTypes {
		OT_MIN_WIDTH // минимальная ширина
		, OT_MAX_WIDTH // максимальная ширина
		, OT_MIN_HEIGHT // минимальная высота
		, OT_MAX_HEIGHT // максимальная высота
		, OT_ASPECT_RATIO // соотношение сторон
		, OT_MIN_LEFT // минимальное значение координаты LEFT
		, OT_MAX_LEFT // максимальное значение координаты LEFT
		, OT_MIN_TOP // минимальное значение координаты TOP
		, OT_MAX_TOP // максимальное значение координаты TOP
		, OT_LEFT_OFFSET // смещение коррдинаты LEFT
		, OT_TOP_OFFSET // смещение коррдинаты TOP
		, OT_RIGHT_OFFSET // смещение коррдинаты RIGHT
		, OT_BOTTOM_OFFSET // смещение коррдинаты BOTTOM
		, OT_LEFT_ANCHOR // привязка слева
		, OT_TOP_ANCHOR // привезка сверху
		, OT_RIGHT_ANCHOR // привязка справа
		, OT_BOTTOM_ANCHOR // привязка снизу
		, OT_CENTER_XPOS // X координата центра
		, OT_CENTER_YPOS // Y координата центра
	};

	// опции
	typedef std::map < OptionTypes, int > Options;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// default конструктор
	LayoutInfo ();

public:
	virtual ~LayoutInfo ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// добавляет свойство
	virtual bool add_option (OptionTypes opt, int value);

	// возвращает знчение установленной опции
	virtual bool get_option (OptionTypes opt, int& value) const;

	// true, если такая opt  установлена, иначе false
	virtual bool has_option (OptionTypes opt) const;

	// ?????
	const CRect& reference_rect () const;

	// ?????
	CRect& reference_rect ();

	// очищает информацию о расположении
	virtual void reset ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// значения опций
	Options m_options;

	// точность используется для представления значений опций как чисел с плавающей запятой.
	// Например значение опции 1333 с точностью 3 будет интерпретированно как число 1.333
	unsigned int m_precision;

	CRect m_reference_rect;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	unsigned int get_precision () const;

	void set_precision (unsigned int precision);

//#UC START# *4652AEFF0128*
//#UC END# *4652AEFF0128*
}; // class LayoutInfo

} // namespace WinGUI


#endif //__SHARED_WINGUI_HELPERS_LAYOUTINFO_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

