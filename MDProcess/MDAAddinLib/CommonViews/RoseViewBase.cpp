////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/CommonViews/RoseViewBase.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::CommonViews::RoseViewBase
//
// базовый класс для всех элементов управления, отображающих розовские элементы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/CommonViews/RoseViewBase.h"
// by <<uses>> dependencies
#include "boost/functional/hash/hash.hpp"
#include "MDProcess/MDAAddinLib/Commands/Commands.h"
#include "MDProcess/MDAAddinLib/Commands/CommandsFactories.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupport.h"
#include "MDProcess/MDAModel/MDPSupport/MDPSupportFactories.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"


//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation
// идентификаторы команд контекстного меню
const unsigned int RoseViewBase::PROPERTIES_CMD = 1; // команда "Свойства элемента"
const unsigned int RoseViewBase::LOCK_CMD = 2; // Команда "Залочить"
const unsigned int RoseViewBase::UNLOCK_CMD = 3; // команда "Разлочить"
const unsigned int RoseViewBase::BWOSE_CMD = 4; // Команда "Показать на диаграмме"

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

RoseViewBase::~RoseViewBase () {
	//#UC START# *49815763027A_DESTR_BODY*
	//#UC END# *49815763027A_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// Метод деинициализации - вызывается при уничтожении конкретного элемента управления
void RoseViewBase::fini () {
	//#UC START# *498159BA03D0*
	//при уничтожении контрола очищаем мапу объектов - это нужно т.к контрол может крутится в 
	//потоке и розовские объекты, которыми он оперирует могли быть получены из глобальной таблицы 
	//COM-объектов, и если их не почистить, то при выходе из приложения повисаем...

	m_items.clear ();
	//#UC END# *498159BA03D0*
}

// возвращает розовский элемент по его гуиду
IRoseElementPtr RoseViewBase::get_item_by_guid (size_t guid) const {
	//#UC START# *49815AF20233*
	UIDtoItemMap::const_iterator it = m_items.find (guid);
	if (it != m_items.end ()) {
		return it->second.element;
	}
	return 0;
	//#UC END# *49815AF20233*
}

// формирует внутренний гуид элемента
size_t RoseViewBase::make_guid (IRoseElementPtr elem) const {
	//#UC START# *498164A5005F*
	return boost::hash<std::string> ().operator () (get_rose_element_uid(elem));
	//#UC END# *498164A5005F*
}

// обрабочтик команд контекстного меню, id - идентификатор команды, elem - элемент на котором было
// вызвано контекстно меню
void RoseViewBase::on_command (unsigned int id, IRoseElementPtr elem) {
	//#UC START# *49815AC700AF*
	switch (id) {
		case PROPERTIES_CMD: {
				RoseHelper::ExecResult is_ok = Commands::CmdManagerFactory::get ().properties (elem, false, true);
				if (is_ok == RoseHelper::ER_DELETE) {
					this->delete_item_from_view (this->make_guid (elem));		
				}
			}
			break;
		case LOCK_CMD:
			Commands::CmdManagerFactory::get ().lock ((IRoseCategoryPtr)elem);					
			break;
		case UNLOCK_CMD:
			Commands::CmdManagerFactory::get ().unlock ((IRoseCategoryPtr)elem);
			break;
		case BWOSE_CMD:
			RoseHelper::browse_item (elem);
			break;
		default:
			break;
	}	
	//#UC END# *49815AC700AF*
}

// вызывается при удалении элемента из контроля
void RoseViewBase::on_delete_item (size_t guid) {
	//#UC START# *4981594A02AB*
	m_items.erase (guid);
	//#UC END# *4981594A02AB*
}

// Должен вызываться при добавлении нового элемента в список, возвращает внутренний идентификатор
// элемента, этот идентификатор должен быть сопоставлен с элементом отображения, например с
// элементом списка или дерева.
size_t RoseViewBase::on_new_item (IRoseElementPtr elem) {
	//#UC START# *498158640223*
	size_t guid_hash = make_guid (elem);
	UIDtoItemMap::iterator it = m_items.find (guid_hash);
	if (it == m_items.end ()) {
		m_items.insert (
			UIDtoItemMap::value_type (guid_hash, RoseElementWrapper (elem))
		);
	}

	return guid_hash;
	//#UC END# *498158640223*
}

// отображает контекстное меню для переданного элемента
void RoseViewBase::show_context_menu (IRoseElementPtr elem, const CPoint& pos, CWnd& wnd) {
	//#UC START# *49815A8D011A*
	if (
		elem
		&& (
			elem->IsClass (ATTRIBUTE_TYPE)
			|| elem->IsClass (OPERATION_TYPE)
			|| elem->IsClass ("Role")
			|| elem->IsClass (CLASS_TYPE)
			|| elem->IsClass (CATEGORY_TYPE)
			|| elem->IsClass ("InheritRelation")
			|| elem->IsClass ("RealizeRelation")
			|| elem->IsClass (CLASS_DEPENDENCY_TYPE)
			|| elem->IsClass ("CategoryDependency")
		)
	) {		
		MDPSupport::CatLockerFacade_var clf = MDPSupport::CatLockerFacadeFactory::make (elem);
		CMenu menu;
		if (menu.CreatePopupMenu ()) {
			bool need_separator = false;
			if (
				elem->IsClass (ATTRIBUTE_TYPE)
				|| elem->IsClass (OPERATION_TYPE)
				|| elem->IsClass ("Role")
				|| elem->IsClass (CLASS_TYPE)
				|| elem->IsClass (CATEGORY_TYPE)
			) {
				need_separator = true;
				menu.AppendMenu(MF_STRING, PROPERTIES_CMD, static_cast<LPCTSTR> ("Open properties..."));
			}
			if (elem->IsClass (CATEGORY_TYPE)) {
				if (clf->can_lock () == true) {
					need_separator = true;
					menu.AppendMenu(MF_STRING, LOCK_CMD, static_cast<LPCTSTR> ("Lock"));				
				} else {
					if (clf->can_commit () == true) {
						need_separator = true;
						menu.AppendMenu(MF_STRING, UNLOCK_CMD, static_cast<LPCTSTR> ("UnLock"));
					}
				}
			}
			if (
				elem->IsClass (CATEGORY_TYPE)
				|| elem->IsClass (ROSE_ITEM_TYPE)
			) {
				if (need_separator) {
					menu.AppendMenu(MF_SEPARATOR);
				}
				menu.AppendMenu(MF_STRING, BWOSE_CMD, static_cast<LPCTSTR> ("Browse"));
			}
			int res = menu.TrackPopupMenuEx (TPM_NONOTIFY | TPM_RETURNCMD, pos.x, pos.y, &wnd, NULL);			
			if (res != 0) {
				this->on_command (res, elem);
			}
		}
	}
	//#UC END# *49815A8D011A*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

