////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/Helpers/LayoutHelper.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::Helpers::LayoutHelper
//
// вспомогательный класс для контроля расположения и размеров контрола
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_HELPERS_LAYOUTHELPER_H__
#define __SHARED_WINGUI_HELPERS_LAYOUTHELPER_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include "shared/WinGUI/Helpers/LayoutInfo.h"

namespace WinGUI {

// вспомогательный класс для контроля расположения и размеров контрола
class LayoutHelper {
	SET_OBJECT_COUNTER (LayoutHelper)

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// алгоритмы располжения
	enum LayoutStyles {
		DEFAULT_LAYOUT // алгоритм по умолчанию
		, CENTERED_LAYOUT // элементы распологаются по центру
	};

	// набор контролов
	typedef std::map < HWND, Core::Box<LayoutInfo> > Controls;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	// конструктор
	LayoutHelper ();

public:
	virtual ~LayoutHelper ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// добавялет в список все дочерние контролы, связанного окно
	virtual bool add_child_controls ();

	// добавляет ctrl в список объектов
	virtual bool add_control (CWnd& ctrl);

	// добавялет ctrl в список контролов info - информация о расположении
	virtual bool add_control_info (CWnd& ctrl, const LayoutInfo& info);

	// присоединяет окно
	virtual void attach_wnd (CWnd& wnd);

	// отцепляет окно
	virtual void detach_wnd ();

	// получение информации о расположении связанной с контролом
	virtual bool get_layout_info (CWnd& ctrl, LayoutInfo& info) const;

	// выполняет перерасчет размеров
	virtual void layout_controls ();

	// пересчет размеров
	virtual void on_size (unsigned int type, int cx, int cy);

	// удаляет ctrl из списка
	virtual bool remove_control (CWnd& ctrl);

private:
	// применят соотношение размеров
	virtual void apply_aspect_ratio (const LayoutInfo& info, int& width, int& height);

	// применяет ограничения центрирования по x
	virtual void apply_centering_constraint_x (const LayoutInfo& info, double scaleX, int& x, int width);

	// применяет ограчения центрирования по Y
	virtual void apply_centering_constraint_y (const LayoutInfo& info, double scaleY, int& y, int height);

	// применить ограничения по X
	virtual void apply_constraint_x (const LayoutInfo& info, int cx, double scaleX, int& x, int& width);

	// применить ограничения по Y
	virtual void apply_constraint_y (const LayoutInfo& info, int cy, double scaleY, int& y, int& height);

	// запускает алгоритм центровки для определения расположения элементов окна при ресайзе
	virtual void perfom_centered_layout (int cx, int cy);

	// запускает алгоритм по умолчанию для определения расположения элементов окна при ресайзе
	virtual void perfom_default_layout (int cx, int cy);

	// алгоритм
	virtual void perfom_layout (int cx, int cy);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// связанное окно
	CWnd* m_attach_wnd;

	Controls m_controls;

	// алгоритм
	LayoutStyles m_layout_style;

	// минимальный размер клиентской обалсти
	CSize m_minimum_size;

	// предыдущая высота окна
	int m_prev_wnd_height;

	// предыдущая ширина окна
	int m_prev_wnd_width;

	// виртуальный размер клиентской области окна, используемой для расчета
	CSize m_reference_size;

	// Шаг, определяет размер при изменении на который выолняется пересчет размеров. Используется для,
	// того чтобы постоянно не пересчитывать размеры при ресайзе окна
	int m_step_size;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	int get_prev_wnd_height () const;

	void set_prev_wnd_height (int prev_wnd_height);

	int get_step_size () const;

	void set_step_size (int step_size);
}; // class LayoutHelper

} // namespace WinGUI


#endif //__SHARED_WINGUI_HELPERS_LAYOUTHELPER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

