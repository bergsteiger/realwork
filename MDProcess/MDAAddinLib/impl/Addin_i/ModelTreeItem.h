////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/ModelTreeItem.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAAddinLib::Addin_i::ModelTreeItem
//
// дерево с данными для браузера модели
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_MODELTREEITEM_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_MODELTREEITEM_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCL/data/StaticNode.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"

//#UC START# *45C704E301A5_CUSTOM_INCLUDES*
//#UC END# *45C704E301A5_CUSTOM_INCLUDES*


// дерево с данными для браузера модели
class ModelTreeItem;
typedef Core::Var<ModelTreeItem> ModelTreeItem_var;
typedef Core::Var<const ModelTreeItem> ModelTreeItem_cvar;

class ModelTreeItem :
	virtual public GCL::StaticNode
{
	SET_OBJECT_COUNTER (ModelTreeItem)
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// функция копирования элемента
	static ModelTreeItem* make_copy (const ModelTreeItem* source);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	explicit ModelTreeItem (IRoseElementPtr elem);

public:
	virtual ~ModelTreeItem ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// возврщает true если жлемент может быть перемещён в parent, иначе - false
	virtual bool can_move_to (const ModelTreeItem* parent) const;

	// инициализация ноды дерева
	virtual void init (IRoseElementPtr elem);

	// return true if element moved successfully, other - false
	virtual bool move_to (ModelTreeItem* parent);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// собственно элемент модели
	IRoseElementPtr m_item;

	// полное имя элемента формируется из собственно из имени элемента и его стереотипа
	std::string m_item_name;

	// стереотип элемента
	std::string m_item_stereotype;

	// uid элемента на модели
	std::string m_item_uid;

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
public:
	IRoseElementPtr get_item () const;

	void set_item (IRoseElementPtr item);

	const std::string& get_item_name () const;

	void set_item_name (const std::string& item_name);

	const std::string& get_item_stereotype () const;

	void set_item_stereotype (const std::string& item_stereotype);

	const std::string& get_item_uid () const;

	void set_item_uid (const std::string& item_uid);

//#UC START# *45C704E301A5*
//#UC END# *45C704E301A5*
}; // class ModelTreeItem



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_MODELTREEITEM_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

