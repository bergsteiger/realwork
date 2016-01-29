////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/Commands/Commands.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAAddinLib::Commands
//
// интерфейсы для обработки MDA-команд
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_COMMANDS_H__
#define __MDPROCESS_MDAADDINLIB_COMMANDS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"

namespace Commands {

class CmdManager;
typedef ::Core::Var<CmdManager> CmdManager_var;
typedef ::Core::Var<const CmdManager> CmdManager_cvar;
// интерфейс - менеджер команд
class CmdManager
	: virtual public ::Core::IObject
{
public:
	// раскраска диграммы
	virtual void colorize (IRoseDiagramPtr diag) = 0;

	// раскрашивает все диаграммы в cat, с учетом вложенных
	virtual void colorize_all_diagrams (IRoseCategoryPtr cat) = 0;

	// "выливает" папку в отдельный кат
	// возвращает true в случае успеха, иначе false
	virtual bool control (IRoseCategoryPtr cat) = 0;

	// операция "control" применяется к cat и всем подпапкам рекурсивно
	virtual bool control_all (IRoseCategoryPtr cat) = 0;

	// выливает папку в отдельный кат, путь к кату выбирается пользователем
	virtual bool control_to_file (IRoseCategoryPtr cat) = 0;

	// копирует элемент item в parent
	// возвращает новый элемент
	virtual IRoseElementPtr copy (IRoseElementPtr item, IRoseElementPtr parent) = 0;

	// операция генерации выбранного элемента (elem)
	// флаг need_auto_rep указывает нужно ли запускать построенеи автоматических отчетов или нет
	virtual void generate (IRoseItemPtr elem, bool need_auto_rep) = 0;

	// операция генерации выбранного элемента (elem)  и всех зависимых от него элементов
	// флаг need_auto_rep указывает нужно ли запускать построенеи автоматических отчетов или нет
	virtual void generate_with_consumers (IRoseItemPtr elem, bool need_auto_rep) = 0;

	// операция "залочки" выбранного пакета
	virtual void lock (IRoseCategoryPtr cat) = 0;

	// операция создания нового атрибута для класса
	virtual IRoseAttributePtr new_attribute (IRoseClassPtr parent) = 0;

	// операция создания нового ключа для связи (parent)
	virtual IRoseAttributePtr new_attribute_key (IRoseRolePtr parent) = 0;

	// операция создания нового класса, вложенного в parent, где parent - класс или пакет
	virtual IRoseClassPtr new_class (IRoseItemPtr parent) = 0;

	// операция создания новой диаграммы классов, имя диаграммы предлагается ввести пользователю.
	// 
	// \parent - элемент для которого создаётся диаграмма, может быть классом, либо папкой
	virtual IRoseClassDiagramPtr new_class_diagram (IRoseItemPtr parent) = 0;

	// операция создания новой диаграммы классов.
	// 
	// \parent - элемент для которого создаётся диаграмма, может быть классом, либо папкой
	// 
	// \name - имя диаграммы
	virtual IRoseClassDiagramPtr new_class_diagram (IRoseItemPtr parent, const std::string& name) = 0;

	// операция создания нового элемента, element_type  - тип элемента ("Class", "Category",
	// "Attribute", "Operation")
	virtual IRoseElementPtr new_element (IRoseItemPtr parent, const std::string& element_type) = 0;

	// операция создания новой операции для класса
	virtual IRoseOperationPtr new_operation (IRoseClassPtr parent) = 0;

	// операция создания нового пакета
	virtual IRoseCategoryPtr new_package (IRoseCategoryPtr parent) = 0;

	// создание сиквенс диграммы, parent - класс со стереотипом "UseCase"
	virtual IRoseScenarioDiagramPtr new_sequence_diagram (IRoseClassPtr parent) = 0;

	// Добавляет диаграмму состояний к элементу (parent)m в качестве результата возвращает собственно
	// диаграмму. Имя диаграммы предлагается ввести пользователю в специальном диалоге.
	virtual IRoseStateDiagramPtr new_state_diagram (IRoseItemPtr parent) = 0;

	// Добавляет диаграмму состояний с именем <name> к элементу (parent)m в качестве результата
	// возвращает собственно диаграмму
	virtual IRoseStateDiagramPtr new_state_diagram (IRoseItemPtr parent, const std::string& name) = 0;

	// команда вызова дилога свойств элемента
	// \is_new - флаг определяет является ли elem новым, если да, то поля диалога заполняются
	// значениями по умолчанию
	// \need_reload_template - флаг определяет нужно ли перечитывать шаблон перед показом свойств
	virtual RoseHelper::ExecResult properties (IRoseItemPtr elem, bool is_new, bool need_reload_template) = 0;

	// метод перемещает в модели Розы элемент в нового родителя (new_parent), при необходимости лочит
	// пакеты
	// возвращает true в случае успеха
	// 
	// is_new - флаг сигнализирует о том, был ли в результате перемещения создан новый объект
	// (например нельзя перемещать операции, атрибуты)
	virtual bool relocate (IRoseElementPtr item, IRoseElementPtr new_parent, bool& is_new) = 0;

	// откатить изменения
	virtual void rollback (IRoseCategoryPtr cat) = 0;

	// операция обратная выливке в отдельный кат - "засасывает" кат в файл модели (mdl) или cat
	// родителя
	virtual void uncontrol (IRoseCategoryPtr cat) = 0;

	// операция uncontrol применяется к cat и всем его подпапкам рекурсивно
	virtual void uncontrol_all (IRoseCategoryPtr cat) = 0;

	// операция "отлочки" выбранного пакета
	virtual void unlock (IRoseCategoryPtr cat) = 0;

	// операция поиска внутри elem
	virtual void search (IRoseItemPtr elem) const = 0;

	// операция показа списка залоченных пакетов
	virtual void show_locked () const = 0;

	// открывает браузер и в нем показывает соответствующую элементу страницу в К
	virtual void view_elem_in_confluence (IRoseItemPtr elem) const = 0;

	// операция построения отчета
	virtual void view_reports (IRoseItemPtr elem) const = 0;

	// Установить шаблон для модели, template_path - путь к файлу шаблона
	virtual void set_template (IRoseApplicationPtr app, const std::string& template_path) const = 0;

	// удалить элемент из модели (требуется подтверждение пользователя)
	virtual void remove (IRoseElementPtr elem) = 0;

	// Пытается захватить все пакеты из переданной коллекции.
	virtual void lock (IRoseCategoryCollectionPtr cats) = 0;

	// пытаеться разлочить все пакеты из переданной коллекции
	virtual void unlock (IRoseCategoryCollectionPtr cats) = 0;

	// очищает свойства элемента, оставляя только необходимые (списки derived impl; списки исключений;
	// UP, определенные в шаблоне)
	virtual void clean_properties (IRoseElementPtr elem) = 0;

	// То же, что и clean_properties, но применяется рекурсивно но всем детям элемента
	virtual void clean_properties_recursively (IRoseElementPtr elem) = 0;
};

/// factory interface for CmdManager
class CmdManagerFactory {
public:
	// получить менеджер команд
	static CmdManager& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class DblClickAction;
typedef ::Core::Var<DblClickAction> DblClickAction_var;
typedef ::Core::Var<const DblClickAction> DblClickAction_cvar;
// реакция на дабл-клик
class DblClickAction
	: virtual public ::Core::IObject
{
public:
	// выполняет действие
	virtual void action (IRoseElementPtr elem) = 0;
};

/// factory interface for DblClickAction
class DblClickActionFactory {
public:
	// фабрика, создаёт экземпляр интерфейса
	static DblClickAction* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace Commands

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <Commands::CmdManager> {
	typedef Commands::CmdManagerFactory Factory;
};
template <>
struct TypeTraits <Commands::DblClickAction> {
	typedef Commands::DblClickActionFactory Factory;
};
} // namespace Core


#endif //__MDPROCESS_MDAADDINLIB_COMMANDS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
