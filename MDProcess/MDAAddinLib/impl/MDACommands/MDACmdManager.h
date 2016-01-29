////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/MDACommands/MDACmdManager.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::MDACommands::MDACmdManager
// Заголовок реализации класса серванта для интерфеса CmdManager
//
// менеджер MDA-команд
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_MDACOMMANDS_MDACMDMANAGER_H__
#define __MDPROCESS_MDAADDINLIB_MDACOMMANDS_MDACMDMANAGER_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAAddinLib/Commands/Commands.h"

//#UC START# *462D87C6033C_CUSTOM_INCLUDES*
#include "MDProcess/MDAAddinLib/Addin/Addin_i.h"
//#UC END# *462D87C6033C_CUSTOM_INCLUDES*

namespace MDACommands {

class MDACmdManager; // self forward Var
typedef ::Core::Var<MDACmdManager> MDACmdManager_var;
typedef ::Core::Var<const MDACmdManager> MDACmdManager_cvar;

class MDACmdManager_factory;

// менеджер MDA-команд
class MDACmdManager:
	virtual public Commands::CmdManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (MDACmdManager)
	friend class MDACmdManager_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
public:
	// метод создания нового элемента - поднимает диалог выбора стереотипа, создает новый элемент вы
	// зависимости от выбранного стереотипа
	// 
	// parent - элемент-родитель, в котором будет создан новый элемент
	// element_type - {"all", "Class", "Category", "Operation", "Attribute" } - тип создаваемя
	// элемента (в зависимости от него будет выбран ссоответствующий radio-button в диалоге выбора
	// стереотипа)
	static IRoseItemPtr create_new_element (IRoseItemPtr parent, const std::string& element_type);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	MDACmdManager ();

	virtual ~MDACmdManager ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// запуск генерации элементов из списка флаг need_auto_rep указывает нужно ли запускать
	// построение автоматических отчетов или нет
	virtual void generate_impl (RoseElementVector& rose_items, bool need_auto_rep);

	// Выводит диалог с предложением сохранить изменения модели (если изменения были)? возвращает
	// true, если все успешно сохранено, false - если пользователь нажал "Отмена"
	virtual bool save_model_if_need () const;


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Commands::CmdManager
	// очищает свойства элемента, оставляя только необходимые (списки derived impl; списки исключений;
	// UP, определенные в шаблоне)
	virtual void clean_properties (IRoseElementPtr elem);

	// implemented method from Commands::CmdManager
	// То же, что и clean_properties, но применяется рекурсивно но всем детям элемента
	virtual void clean_properties_recursively (IRoseElementPtr elem);

	// implemented method from Commands::CmdManager
	// раскраска диграммы
	virtual void colorize (IRoseDiagramPtr diag);

	// implemented method from Commands::CmdManager
	// раскрашивает все диаграммы в cat, с учетом вложенных
	virtual void colorize_all_diagrams (IRoseCategoryPtr cat);

	// implemented method from Commands::CmdManager
	// "выливает" папку в отдельный кат
	// возвращает true в случае успеха, иначе false
	virtual bool control (IRoseCategoryPtr cat);

	// implemented method from Commands::CmdManager
	// операция "control" применяется к cat и всем подпапкам рекурсивно
	virtual bool control_all (IRoseCategoryPtr cat);

	// implemented method from Commands::CmdManager
	// выливает папку в отдельный кат, путь к кату выбирается пользователем
	virtual bool control_to_file (IRoseCategoryPtr cat);

	// implemented method from Commands::CmdManager
	// копирует элемент item в parent
	// возвращает новый элемент
	virtual IRoseElementPtr copy (IRoseElementPtr item, IRoseElementPtr parent);

	// implemented method from Commands::CmdManager
	// операция генерации выбранного элемента (elem)
	// флаг need_auto_rep указывает нужно ли запускать построенеи автоматических отчетов или нет
	virtual void generate (IRoseItemPtr elem, bool need_auto_rep);

	// implemented method from Commands::CmdManager
	// операция генерации выбранного элемента (elem)  и всех зависимых от него элементов
	// флаг need_auto_rep указывает нужно ли запускать построенеи автоматических отчетов или нет
	virtual void generate_with_consumers (IRoseItemPtr elem, bool need_auto_rep);

	// implemented method from Commands::CmdManager
	// операция "залочки" выбранного пакета
	virtual void lock (IRoseCategoryPtr cat);

	// implemented method from Commands::CmdManager
	// Пытается захватить все пакеты из переданной коллекции.
	virtual void lock (IRoseCategoryCollectionPtr cats);

	// implemented method from Commands::CmdManager
	// операция создания нового атрибута для класса
	virtual IRoseAttributePtr new_attribute (IRoseClassPtr parent);

	// implemented method from Commands::CmdManager
	// операция создания нового ключа для связи (parent)
	virtual IRoseAttributePtr new_attribute_key (IRoseRolePtr parent);

	// implemented method from Commands::CmdManager
	// операция создания нового класса, вложенного в parent, где parent - класс или пакет
	virtual IRoseClassPtr new_class (IRoseItemPtr parent);

	// implemented method from Commands::CmdManager
	// операция создания новой диаграммы классов, имя диаграммы предлагается ввести пользователю.
	// 
	// \parent - элемент для которого создаётся диаграмма, может быть классом, либо папкой
	virtual IRoseClassDiagramPtr new_class_diagram (IRoseItemPtr parent);

	// implemented method from Commands::CmdManager
	// операция создания новой диаграммы классов.
	// 
	// \parent - элемент для которого создаётся диаграмма, может быть классом, либо папкой
	// 
	// \name - имя диаграммы
	virtual IRoseClassDiagramPtr new_class_diagram (IRoseItemPtr parent, const std::string& name);

	// implemented method from Commands::CmdManager
	// операция создания нового элемента, element_type  - тип элемента ("Class", "Category",
	// "Attribute", "Operation")
	virtual IRoseElementPtr new_element (IRoseItemPtr parent, const std::string& element_type);

	// implemented method from Commands::CmdManager
	// операция создания новой операции для класса
	virtual IRoseOperationPtr new_operation (IRoseClassPtr parent);

	// implemented method from Commands::CmdManager
	// операция создания нового пакета
	virtual IRoseCategoryPtr new_package (IRoseCategoryPtr parent);

	// implemented method from Commands::CmdManager
	// создание сиквенс диграммы, parent - класс со стереотипом "UseCase"
	virtual IRoseScenarioDiagramPtr new_sequence_diagram (IRoseClassPtr parent);

	// implemented method from Commands::CmdManager
	// Добавляет диаграмму состояний к элементу (parent)m в качестве результата возвращает собственно
	// диаграмму. Имя диаграммы предлагается ввести пользователю в специальном диалоге.
	virtual IRoseStateDiagramPtr new_state_diagram (IRoseItemPtr parent);

	// implemented method from Commands::CmdManager
	// Добавляет диаграмму состояний с именем <name> к элементу (parent)m в качестве результата
	// возвращает собственно диаграмму
	virtual IRoseStateDiagramPtr new_state_diagram (IRoseItemPtr parent, const std::string& name);

	// implemented method from Commands::CmdManager
	// команда вызова дилога свойств элемента
	// \is_new - флаг определяет является ли elem новым, если да, то поля диалога заполняются
	// значениями по умолчанию
	// \need_reload_template - флаг определяет нужно ли перечитывать шаблон перед показом свойств
	virtual RoseHelper::ExecResult properties (IRoseItemPtr elem, bool is_new, bool need_reload_template);

	// implemented method from Commands::CmdManager
	// метод перемещает в модели Розы элемент в нового родителя (new_parent), при необходимости лочит
	// пакеты
	// возвращает true в случае успеха
	// 
	// is_new - флаг сигнализирует о том, был ли в результате перемещения создан новый объект
	// (например нельзя перемещать операции, атрибуты)
	virtual bool relocate (IRoseElementPtr item, IRoseElementPtr new_parent, bool& is_new);

	// implemented method from Commands::CmdManager
	// удалить элемент из модели (требуется подтверждение пользователя)
	virtual void remove (IRoseElementPtr elem);

	// implemented method from Commands::CmdManager
	// откатить изменения
	virtual void rollback (IRoseCategoryPtr cat);

	// implemented method from Commands::CmdManager
	// операция поиска внутри elem
	virtual void search (IRoseItemPtr elem) const;

	// implemented method from Commands::CmdManager
	// Установить шаблон для модели, template_path - путь к файлу шаблона
	virtual void set_template (IRoseApplicationPtr app, const std::string& template_path) const;

	// implemented method from Commands::CmdManager
	// операция показа списка залоченных пакетов
	virtual void show_locked () const;

	// implemented method from Commands::CmdManager
	// операция обратная выливке в отдельный кат - "засасывает" кат в файл модели (mdl) или cat
	// родителя
	virtual void uncontrol (IRoseCategoryPtr cat);

	// implemented method from Commands::CmdManager
	// операция uncontrol применяется к cat и всем его подпапкам рекурсивно
	virtual void uncontrol_all (IRoseCategoryPtr cat);

	// implemented method from Commands::CmdManager
	// операция "отлочки" выбранного пакета
	virtual void unlock (IRoseCategoryPtr cat);

	// implemented method from Commands::CmdManager
	// пытаеться разлочить все пакеты из переданной коллекции
	virtual void unlock (IRoseCategoryCollectionPtr cats);

	// implemented method from Commands::CmdManager
	// открывает браузер и в нем показывает соответствующую элементу страницу в К
	virtual void view_elem_in_confluence (IRoseItemPtr elem) const;

	// implemented method from Commands::CmdManager
	// операция построения отчета
	virtual void view_reports (IRoseItemPtr elem) const;

//#UC START# *462D87C6033C*
	void clear () {
		m_model_explorer = 0;
	}
	typedef ATL::CComPtr<IModelExplorer> IModelExplorerPtr;
	IModelExplorerPtr m_model_explorer;
//#UC END# *462D87C6033C*
}; // class MDACmdManager

} // namespace MDACommands


#endif //__MDPROCESS_MDAADDINLIB_MDACOMMANDS_MDACMDMANAGER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
