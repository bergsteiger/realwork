////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersNode_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Folders_i::FoldersNode_i
// Заголовок реализации класса серванта для интерфеса FoldersNode
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDERSNODE_I_H__
#define __GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDERSNODE_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/data/UnsortedTypeConverter.h"
#include "shared/GCI/IO/IO.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersManager_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garantServer/src/Global/Core/ContainersC.h"
#include "garantServer/src/Business/GblFolders/GblFoldersC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/BaseTreeSupport_i/StaticNode_i.h"

//#UC START# *457050AC03A9_CUSTOM_INCLUDES*
//#UC END# *457050AC03A9_CUSTOM_INCLUDES*

// forward decls for defined friends
namespace GblAdapterLib {
	class FoldersManager_i;
} // namespace GblAdapterLib


namespace GblAdapterLib {

class FoldersNode_i; // self forward Var
typedef ::Core::Var<FoldersNode_i> FoldersNode_i_var;
typedef ::Core::Var<const FoldersNode_i> FoldersNode_i_cvar;

class FoldersNode_i_factory;

class FoldersNode_i:
	virtual public FoldersNode
	, virtual public StaticNode_i
{
	SET_OBJECT_COUNTER (FoldersNode_i)
	friend class FoldersNode_i_factory; // self factory
	friend class FoldersManager_i; // defined friend

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
public:
	static const unsigned long MAX_TREE_DEPTH;


	class ContentTypeConvertor : 
		public Core::UnsortedTypeConverter<Containers::ContentType, FoldersItemType> {
		protected:
			void fill_array () {
				//#UC START# *461B7E39003E_FILL_ARRAY_IMPLEMENTATION*
				this->add (Defines::CT_DOC_BOOKMARK, FIT_BOOKMARK);
				this->add (Defines::CT_FOLDER, FIT_FOLDER);
				this->add (Defines::CT_SAVED_LIST, FIT_LIST);
				this->add (Defines::CT_CONSULTATION, FIT_CONSULTATION);
				this->add (Defines::CT_SAVED_QUERY, FIT_QUERY);
				this->add (Defines::CT_SAVED_PHARM_LIST, FIT_PHARM_LIST);
				this->add (Defines::CT_PHARM_BOOKMARK, FIT_PHARM_BOOKMARK);
				this->add (Defines::CT_HISTORY, FIT_OLD_HISTORY);
				//#UC END# *461B7E39003E_FILL_ARRAY_IMPLEMENTATION*
			}
	}; // class ContentTypeConvertor

	typedef ACE_Singleton<ContentTypeConvertor, ACE_SYNCH_NULL_MUTEX> ContentTypeConvertorSingleton;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FoldersNode_i (Containers::Content* content, Folders* folders);

	virtual ~FoldersNode_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	// Рекурсивный поиск ребенка по идентификатору
	virtual FoldersNode* find_node_by_id (FolderId id) const;

	virtual GCD::PID get_document_pid () const;

	virtual GblFolders::Folder* get_folder ();

	// проверка или папка "Мои документы"
	virtual bool is_my_documents () const;

	// папка "Мои документы" или ее содержимое
	virtual bool is_my_documents_or_lower () const;

	// Прогрузить детей, рекурсивно
	virtual void load_children ();

	virtual void recalc_consultations_flag ();

	virtual void recalc_external_flag ();

	// Обновить флаг flag2
	// Вызывается рекурсивно от родителя передачей кумулятивного флага from_node
	// Возвращает true если хотя бы один из детенышей имеет флаг flag1
	virtual bool recalc_node_flags (bool from_node, unsigned long flag1, unsigned long flag2);

	// Обновить флаги NF_HAS_SHARED, NF_IN_SHARED
	// Вызывается рекурсивно от родителя передачей кумулятивного флага from_shared
	// Возвращает true если хотя бы один из детенышей имеет флаг NS_SHARED
	virtual bool recalc_shared_flags (bool from_shared);

	virtual void recursive_recalc_consultations_flag ();

	virtual void set_shared_flag (bool is_shared);

	// Обновить кэш всех детей
	virtual void update_children ();

	// Обновить содержимое этого узла
	virtual void update_content ();

private:
	// Является ли контент ноды закладкой
	virtual bool is_bookmark () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GCI::IO::String_var m_caption;

	mutable Containers::Content_var m_content;

	Containers::ContentType m_content_type;

	Date m_creation_date;

	mutable unsigned long m_flags;

	GblFolders::FolderElement_var m_folder_element;

	FoldersManager_i* m_folders_manager;

	GCI::IO::String_var m_hint;

	mutable Containers::ContentID m_id;

	mutable Query_var m_iquery;

	mutable GCI::IO::String_var m_m_short_doc_name;

	mutable Core::Box<GCD::PID> m_pid;

	mutable GCI::IO::String_var m_short_doc_name;

	mutable FoldersItemType m_type;

	mutable unsigned long m_under_control_status;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Controllable
	// Возвращает true, если разрешена постановка на контроль
	virtual const bool get_can_set_to_control () const;

	// implemented method from Controllable
	// свойство определяющее, что данная сущность находится на контроле. Установка свойства в true
	// приводит к добавлению сущности на контроль, в false соответственно к снятию.
	virtual bool get_controlled () const;

	virtual void set_controlled (bool controlled);

	// implemented method from Controllable
	// Возврящает текущее значение статуса изменений.
	virtual unsigned long get_control_status ();

	// implemented method from Controllable
	// Сравнение объектов на контроле.
	virtual bool is_same_controllable (const Controllable* other);

	// implemented method from Controllable
	virtual const GCI::IO::String& get_name () const;
	virtual GCI::IO::String& get_name ();

	// implemented method from Controllable
	// Сбрасывает статус изменений в ноль.
	virtual void reset_control_status ();

	// implemented method from Controllable
	// Название объекта на контроле.
	virtual const GCI::IO::String& get_short_name () const;
	virtual GCI::IO::String& get_short_name ();

	// implemented method from Controllable
	virtual ControlledItemType get_type () const;

	// implemented method from EntityStorage
	// получить содежимое
	virtual Containers::Content* get_cached_content () const;

	// implemented method from EntityStorage
	// получить тип содержимого
	virtual Containers::ContentType get_content_type () const;

	// implemented method from FoldersNode
	// указывает можно ли в ноду загрузить данные из xml.
	virtual bool can_load_from_xml () const;

	// implemented method from FoldersNode
	// Указывает может ли консультация быть сохранена в xml.
	virtual bool can_save_consultation_to_xml () const;

	// implemented method from FoldersNode
	// может ли нода быть сохранена для библиотеки интеграции
	virtual bool can_save_to_integration_xml () const;

	// implemented method from FoldersNode
	// указывает может ли нода быть сохранена в xml.
	virtual bool can_save_to_xml () const;

	// implemented method from FoldersNode
	// Дата создания
	virtual const Date get_creation_date () const;

	// implemented method from FoldersNode
	virtual GCD::PID get_pid () const;

	// implemented method from FoldersNode
	// Сонтент айди
	virtual const FolderId get_id () const;

	// implemented method from FoldersNode
	// загружает информацию из xml в папку (пустую, нерасшаренную).
	virtual void load_from_xml (const char* xml_file_path) const /*throw (AccessDenied, InvalidEntityType)*/;

	// implemented method from FoldersNode
	// Сохраняет информацию о сущности, представляемой папочной нодой консультации в xml.
	virtual void save_consultation_to_xml (const char* xml_file_path) const;

	// implemented method from FoldersNode
	// сохранить ноду для библиотеки интеграции
	virtual GCI::IO::String* save_to_integration_xml () const /*throw (InvalidEntityType)*/;

	// implemented method from FoldersNode
	virtual void save_to_xml (const char* xml_file_path) const /*throw (AccessDenied, InvalidEntityType)*/;

	// implemented method from Node
	// Добавляет сущность как ребенка к указанной ноде, возвращает новую созданную ноду. Если
	// список/дерево созданно как константное (неизменяемое) то генерится исключение ConstantModify.
	// Если нода не может содержать детей возвращается исключение InvalidContainer
	virtual Node* add_child_node (
		const Core::IObject* entity
	) const /*throw (
		ConstantModify
		, AccessDenied
		, Unsupported
		, DuplicateNode
		, InvalidEntityType
	)*/;

	// implemented method from Node
	// Добавляет сущность как "соседа" справа к указанной ноде, возвращает новую созданную ноду. Если
	// список/дерево созданно как константное (неизменяемое) то генерится исключение ConstantModify
	virtual Node* add_sibling_node (
		const Core::IObject* entity
	) const /*throw (
		ConstantModify
		, Unsupported
		, DuplicateNode
	)*/;

	// implemented method from Node
	// название
	virtual const GCI::IO::String& get_caption () const;
	virtual GCI::IO::String& get_caption ();

	virtual void set_caption (GCI::IO::String* caption)
		/*throw (ConstantModify, AccessDenied)*/;

	// implemented method from Node
	// Поле для передачи дополнительной винарной информации о статусе элемента.
	virtual long get_flags () const;

	// implemented method from Node
	// информация о ноде
	virtual const GCI::IO::String& get_hint () const;
	virtual GCI::IO::String& get_hint ();

	virtual void set_hint (GCI::IO::String* hint)
		/*throw (ConstantModify, AccessDenied)*/;

	// implemented method from Node
	// Возвращает интерфейс для работы с конкретным элементом (сущностью) системы.
	virtual Core::IObject* open () /*throw (CanNotFindData, NotEntityElement)*/;
//////////////////////////////////////////////////////////////////////////////////////////
// overloaded base methods

protected:

	// overloaded method from Node
	// можно ли скопировать ноду
	virtual bool can_copy () const;

	// overloaded method from Node
	// можно ли вставить ноду
	virtual bool can_insert (Node* source) const;

	// overloaded method from Node
	// можно ли модифицировать ноду
	virtual bool can_modify () const;

	// overloaded method from Node
	// можно ли переместить ноду
	virtual bool can_move () const;

	// overloaded method from Node
	// Сопирует текущую ноду и оекурсивно все ее содержимое, в указанный узел, делая ее его ребенком.
	// Если узел не может пнринять ноду (т.е. вставить ее в себя), то генерируется исключение
	// InvalidContainer. Если операция копирования узлов не доступна, генерируется исключение
	// CopyDisabled
	virtual void copy_to_location (Node* destination) /*throw (CopyDisabled, InvalidContainer)*/;

	// overloaded method from Node
	// Удаляет указанные узел из списка/дерева.
	// Если указан элемент, имеющий вложенные элементы, то они тоже удаляются. Если список/дерево
	// созданно как константное (неизменяемое) то генерится исключение ConstantModify
	virtual void delete_node () /*throw (ConstantModify, AccessDenied, EmptyResult)*/;

	// overloaded method from Node
	// Сравнивает текущий элемент с элементом, поданным в параметре node.
	// Возвращает true в случае совпадения.
	virtual bool is_same_node (const Node* node) const;

	// overloaded method from Node
	// Переносит текущую ноду в указанный узел, делая ее его ребенком. Если узел не может пнринять
	// ноду (т.е. вставить ее в себя), то генерируется исключение InvalidContainer. Если операция
	// перемещения узлов не доступна, генерируется исключение MoveDisabled
	virtual void move_to_location (Node* destination) /*throw (InvalidContainer, MoveDisabled)*/;

	// overloaded method from Node
	// тип сущности, представляемой нодой
	virtual EntityType get_object_type () const
		/*throw (Unsupported)*/;

	// overloaded method from Node
	// перезаписать дочернюю ноду
	virtual Node* override_child_node (
		const Core::IObject* entity
	) const /*throw (
		ConstantModify
		, AccessDenied
		, Unsupported
		, DuplicateNode
		, InvalidEntityType
	)*/;


//#UC START# *457050AC03A9*
//#UC END# *457050AC03A9*
}; // class FoldersNode_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDERSNODE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
