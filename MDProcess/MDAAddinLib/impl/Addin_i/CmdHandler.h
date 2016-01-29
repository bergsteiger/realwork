////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CmdHandler.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::CmdHandler
//
// класс обработчик команд меню
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_CMDHANDLER_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_CMDHANDLER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CModelExplorer.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/MouseEventHandler.h"
#include "shared/WinGUI/Controls/CPPToolTip.h"

//#UC START# *46480B2E006D_CUSTOM_INCLUDES*
//#define WM_CONTINUE_PROCESSING_MSG (WM_USER + 2)
//#define WM_BROWSE_IN_DIAG (WM_CONTINUE_PROCESSING_MSG + 1)
//#define WM_SHOW_TOOL_TIP (WM_CONTINUE_PROCESSING_MSG + 3)
//#UC END# *46480B2E006D_CUSTOM_INCLUDES*


// класс обработчик команд меню
class CmdHandler :
	public CStatic
{
	SET_OBJECT_COUNTER (CmdHandler)

	// singleton declaration
	typedef ACE_Singleton <CmdHandler, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <CmdHandler, ACE_SYNCH_RECURSIVE_MUTEX>;
public:
	static CmdHandler* instance () {
		return Singleton::instance();
	}

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
public:
	// константы
	static const unsigned long WM_SHOW_TOOL_TIP; // сообщение для показа тултипа параметр lParam сообщение содержит true, если инадо показать тултип, false - если его надо скрыть
	static const unsigned long WM_BROWSE_IN_DIAG; // сообщение для показа элемента на диаграмме
	static const unsigned long WM_CONTINUE_PROCESSING_MSG; // идентифактор служебного сообщения - говорящего о том, что можно продолжить обрабоотку комманд
	static const unsigned long WM_DBL_CLICK; // дабл-клик на диаграмме
	static const unsigned long WM_UNDO_CHANGE_NAME; // идентификатор сообщения для отмены изменения имени, это сообщение используется для отмены изменения имени, которое может произойти из-за того, что роза посчитает, что новый префикс к вью элемента - это новой имя
	static const unsigned long WM_OPEN_PROPERTIES; // сообщение для открытия свойств элемента
	static const unsigned long TOOLTIP_TIMER; // идентификатор таймера, запускаемого для показа тултипа

	// структура для передачи параметров в обработчик сообщения WM_OPEN_PROPERTIES
	struct OpenPropertiesParam {
		// GUID элемента, ядл которого нужно открыть свойства
		std::string guid;
		// флаг - новый элемент или нет
		bool is_new;
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	// конструктор по умолчанию
	CmdHandler ();

	virtual ~CmdHandler ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// очистка объекта
	virtual void clear ();

	// метод создает невидимое окно CmdHandler
	virtual void create ();

	// устанавливает ссылку на объект-браузер
	virtual void set_explorer (CModelExplorer* explorer);

protected:
	// функция для распределения команды.
	// elem - элемент, для которого выполняется команда
	// command_id  - идентификатор команды
	virtual void dispatch_command (IRoseElementPtr elem, unsigned int command_id) const;

	// вызывается при попытке перейти по ссылке из К в розу - показывает элемент на диаграмме
	virtual LRESULT on_browse_in_diag (WPARAM w_param, LPARAM l_param);

	// обработчик команд с диграммы
	virtual void on_command_from_diag (unsigned int id);

	// обработчик команд с дерева-вью
	virtual void on_command_from_tree (unsigned int id);

	// обработчик сообщения WM_CONTEXT_MENU - показывает контекстное меню для диаграммы
	virtual LRESULT on_context_menu (WPARAM w_param, LPARAM l_param);

	// обработчик пользовательского сообщения  WM_CONTINUE_PROCESSING
	virtual LRESULT on_continue_processing (WPARAM w_param, LPARAM l_param);

	// отдельный обработчик команды ID_MODEL_SEARCH - запускает поиск по модели
	virtual void on_search_command ();

private:
	// обработчик дабл-клика на диаграмме
	virtual LRESULT on_dbl_click (WPARAM w_param, LPARAM l_param);

	// обработчик сообщения WM_OPEN_PROPERTIES
	// в параметре l_param хранится указатель на структуру с необходимыми параметрами, память,
	// занимаемая этой структурой освобождается в данной функции
	virtual LRESULT on_open_properties (WPARAM w_param, LPARAM l_param);

	// обработчик сообщения WM_UNDO_CHANGE_NAME
	virtual LRESULT on_undo_change_name (WPARAM w_param, LPARAM l_param);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// флаг определяет можно ли обрабатывать сообщение или его нужно пропустить
	bool m_can_process_message;

	// всплывающая подсказка для розовского элемента
	Core::Box<WinGUI::CPPToolTip> m_element_tool_tip;

	// дерево модели
	CModelExplorer* m_explorer;

	// обработчик сообщений от мыши
	MouseEventHandler_var m_mouse_event_handler;

//#UC START# *46480B2E006D*
	bool tool_tip_callback (PPTOOLTIP_INFO& ti);

public:
	void relay_event (MSG* msg) {
		if (m_element_tool_tip.is_nil () == false) {
			m_element_tool_tip->RelayEvent (msg);
		}
	}
	DECLARE_MESSAGE_MAP()
//#UC END# *46480B2E006D*
}; // class CmdHandler



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_CMDHANDLER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

