////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/CommonViews/RoseViewBase.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::CommonViews::RoseViewBase
//
// базовый класс для всех элементов управления, отображающих розовские элементы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_COMMONVIEWS_ROSEVIEWBASE_H__
#define __MDPROCESS_MDAADDINLIB_COMMONVIEWS_ROSEVIEWBASE_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"


// базовый класс для всех элементов управления, отображающих розовские элементы
class RoseViewBase {

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// идентификаторы команд контекстного меню
	static const unsigned int PROPERTIES_CMD; // команда "Свойства элемента"
	static const unsigned int LOCK_CMD; // Команда "Залочить"
	static const unsigned int UNLOCK_CMD; // команда "Разлочить"
	static const unsigned int BWOSE_CMD; // Команда "Показать на диаграмме"

	// Мапа - uid->элемент. В качестве uid'а используется хэш гуид'а элемента с модели
	typedef std::map < unsigned long, RoseElementWrapper > UIDtoItemMap;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	virtual ~RoseViewBase ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// Метод деинициализации - вызывается при уничтожении конкретного элемента управления
	void fini ();

	// возвращает розовский элемент по его гуиду
	virtual IRoseElementPtr get_item_by_guid (size_t guid) const;

	// вызывается при удалении элемента из контроля
	virtual void on_delete_item (size_t guid);

	// Должен вызываться при добавлении нового элемента в список, возвращает внутренний идентификатор
	// элемента, этот идентификатор должен быть сопоставлен с элементом отображения, например с
	// элементом списка или дерева.
	virtual size_t on_new_item (IRoseElementPtr elem);

	// отображает контекстное меню для переданного элемента
	virtual void show_context_menu (IRoseElementPtr elem, const CPoint& pos, CWnd& wnd);

private:
	// формирует внутренний гуид элемента
	virtual size_t make_guid (IRoseElementPtr elem) const;

	// обрабочтик команд контекстного меню, id - идентификатор команды, elem - элемент на котором было
	// вызвано контекстно меню
	virtual void on_command (unsigned int id, IRoseElementPtr elem);


//////////////////////////////////////////////////////////////////////////////////////////
// abstarct methods
public:
	// Метод инициализации - вызывается при отображении конкртеного элемента управления
	virtual void init () = 0;

protected:
	// удаление элемента из вью
	virtual void delete_item_from_view (size_t guid) = 0;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// элемент отображаемых в контроле
	UIDtoItemMap m_items;
}; // class RoseViewBase



#endif //__MDPROCESS_MDAADDINLIB_COMMONVIEWS_ROSEVIEWBASE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

