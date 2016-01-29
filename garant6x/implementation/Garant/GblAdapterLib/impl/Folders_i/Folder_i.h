////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/Folder_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Folders_i::Folder_i
// Заголовок реализации класса серванта для интерфеса Folder
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDER_I_H__
#define __GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Folders/Folders.h"
#include "garantServer/src/Global/Core/ContainersC.h"
#include "garantServer/src/Business/GblFolders/GblFoldersC.h"

namespace GblAdapterLib {

class Folder_i; // self forward Var
typedef ::Core::Var<Folder_i> Folder_i_var;
typedef ::Core::Var<const Folder_i> Folder_i_cvar;

class Folder_i_factory;

class Folder_i:
	virtual public Folder
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Folder_i)
	friend class Folder_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Folder_i (GblFolders::Folder* folder_content, FoldersNode* folders_node);

	virtual ~Folder_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
public:
	virtual void clear_content_folder () const;

	virtual GblFolders::Folder* get_content_folder () const;

private:
	// Проверяет моя или чужая папка
	virtual bool is_my () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	mutable GCI::IO::String_var m_comment;

	mutable GblFolders::Folder_var m_folder;

	FoldersNode_var m_folders_node;

	Containers::ContentID m_id;

	// Чужая ли это папка
	mutable char m_is_external;

	// Расшарена ли папка
	mutable char m_is_shared;

	mutable GCI::IO::String_var m_name;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from EntityBase
	// Сохраняет в базе  измененное состояние объекта.
	// Объеденяя с с ранее сохраненными данными
	virtual EntityStorage* append_to (
		EntityStorage* storage
	) /*throw (
		ConstantModify
		, AccessDenied
		, Unsupported
		, CanNotSave
	)*/;

	// implemented method from EntityBase
	// идентификатор
	virtual const unsigned long get_eid () const
		/*throw (Unsupported)*/;

	// implemented method from EntityBase
	// свойство изменённости
	virtual bool get_is_changed () const;

	// implemented method from EntityBase
	// Признак того что данный объект уже сохранен в базе данных. Для не сохраненный объекта сначало
	// необходимо указать место хранения (чаще всего папки). Для не сохраненных объектов операция save
	// вернет исключение.
	virtual bool get_is_saved () const;

	// implemented method from EntityBase
	// Перезаписать сущность текущей сущностью.
	virtual EntityStorage* save_to (
		EntityStorage* storage
	) /*throw (
		AccessDenied
		, Unsupported
		, NotSaved
		, DuplicateNode
		, CanNotSave
	)*/;

	// implemented method from Folder
	// можно ли расшарить папку
	virtual bool can_share () const;

	// implemented method from Folder
	// Для сетевой версии.
	// Признак того что папка является внешней (т.е. не собственной а принадлежащей другому
	// пользователю).
	virtual bool get_external () const;

	// implemented method from Folder
	// Для сетевой версии. Признак того что папка является общедоступной, т.е видимой другим
	// пользователям.
	// Прим. внешние папки вегда являются общедоступными.
	// При попытки изменить данный признак у внешней папки генерируется исключение ConstantModify.
	virtual bool get_shared () const;

	virtual void set_shared (bool shared);

	// implemented method from NamedElement
	// комментарий
	virtual const GCI::IO::String& get_comment () const;
	virtual GCI::IO::String& get_comment ();

	virtual void set_comment (GCI::IO::String* comment);

	// implemented method from NamedElement
	// имя
	virtual const GCI::IO::String& get_name () const;
	virtual GCI::IO::String& get_name ();

	virtual void set_name (GCI::IO::String* name);
}; // class Folder_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_FOLDERS_I_FOLDER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
