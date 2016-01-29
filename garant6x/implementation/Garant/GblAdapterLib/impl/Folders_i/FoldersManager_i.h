////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersManager_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Folders_i::FoldersManager_i
// Заголовок реализации класса серванта для интерфеса Folders
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDERSMANAGER_I_H__
#define __GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDERSMANAGER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/Folders_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTreeSupport_i/StaticNode_i.h"

namespace GblAdapterLib {

class FoldersManager_i; // self forward Var
typedef ::Core::Var<FoldersManager_i> FoldersManager_i_var;
typedef ::Core::Var<const FoldersManager_i> FoldersManager_i_cvar;

class FoldersManager_i_factory;

class FoldersManager_i:
	virtual public Folders
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (FoldersManager_i)
	friend class FoldersManager_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FoldersManager_i ();

	virtual ~FoldersManager_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual void recalc_node_flags ();

	virtual void recalc_shared_flags ();

protected:
	virtual void pick_up_nodes (Node* node, unsigned long flags, NodeVector& nodes) const;

	virtual void refresh ();

	virtual void set_root (StaticNode_i* root);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable Node_var m_root;

	// Объект синхронизации создания папочного рута
	mutable Core::Mutex m_root_mutex;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseCatalog
	// наложенный фильтр
	virtual const EntityType get_filter () const;

	virtual void set_filter (EntityType filter);

	// implemented method from BaseCatalog
	// Найти узел по его элементу.
	virtual Node* find (const Core::IObject* entity) const;

	// implemented method from BaseCatalog
	// Поиск контекста среди элементов списка.
	virtual Node* find_context (
		const char* mask
		, const SearchMode& mode
		, const Node* cur_item
		, ContextSearchResult*& result
	) const;

	// implemented method from BaseCatalog
	// сбрасывает все установленные фильтры по типам
	virtual void reset_type_filter () const;

	// implemented method from BaseCatalog
	// корень дерева
	virtual const Node* get_root () const;
	virtual Node* get_root ();

	// implemented method from Folders
	// Фабрика узлов, возвращает новый созданный экземпляр BaseEntity типа Folder.
	virtual Folder* create_folder () const;

	// implemented method from Folders
	// Найти узел папки по его идентификатору. Если не найден то CanNotFindData.
	virtual FoldersNode* find_folder_node (FolderId id) const;
}; // class FoldersManager_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDERSMANAGER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
