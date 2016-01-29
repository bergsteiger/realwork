////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/Folder_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Folders_i::Folder_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/Folder_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garantServer/src/Business/GblFolders/GblFoldersAdapC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersNode_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersNode_i_factory.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersManager_i.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Folders_i/FoldersManager_i_factory.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

Folder_i::Folder_i (GblFolders::Folder* folder_content, FoldersNode* folders_node)
//#UC START# *45EEE28D00BD_45EEE2B602D1_45F560B903B9_BASE_INIT*
	: m_folder (GblFolders::Folder::_duplicate (folder_content))
	, m_folders_node (FoldersNode::_duplicate (folders_node))
	, m_is_shared (-1)
	, m_is_external (-1)
//#UC END# *45EEE28D00BD_45EEE2B602D1_45F560B903B9_BASE_INIT*
{
	//#UC START# *45EEE28D00BD_45EEE2B602D1_45F560B903B9_BODY*
	try {
		if (!CORBA::is_nil (m_folder)) {
			m_id = m_folder->id ();
		} else {
			m_id = m_folders_node->get_id ();
		}
	} catch (CORBA::OBJECT_NOT_EXIST&) {
		throw CanNotFindData ();
	}
	//#UC END# *45EEE28D00BD_45EEE2B602D1_45F560B903B9_BODY*
}

Folder_i::~Folder_i () {
	//#UC START# *45F560B903B9_DESTR_BODY*
	//#UC END# *45F560B903B9_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

void Folder_i::clear_content_folder () const {
	//#UC START# *45F7F529000F*
	m_folder = GblFolders::Folder::_nil ();
	//#UC END# *45F7F529000F*
}

GblFolders::Folder* Folder_i::get_content_folder () const {
	//#UC START# *45F7F1250128*
	return GblFolders::Folder::_duplicate (m_folder.in ());
	//#UC END# *45F7F1250128*
}

// Проверяет моя или чужая папка
bool Folder_i::is_my () const {
	//#UC START# *45F565CA02CE*
	if (ApplicationHelper::instance ()->get_cached_current_user_id  () == m_folder->get_owner ()) {
		return true;
	} else {
		return false;
	}
	//#UC END# *45F565CA02CE*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from EntityBase
// Сохраняет в базе  измененное состояние объекта.
// Объеденяя с с ранее сохраненными данными
EntityStorage* Folder_i::append_to (
	EntityStorage* storage
) /*throw (
	ConstantModify
	, AccessDenied
	, Unsupported
	, CanNotSave
)*/ {
	//#UC START# *456EB3E1017A_45F560B903B9*
	throw Unsupported ();
	//#UC END# *456EB3E1017A_45F560B903B9*
}

// implemented method from EntityBase
// идентификатор
const unsigned long Folder_i::get_eid () const
	/*throw (Unsupported)*/
{
	//#UC START# *456EE084033C_45F560B903B9_GET*
	return 0; //???
	//#UC END# *456EE084033C_45F560B903B9_GET*
}

// implemented method from EntityBase
// свойство изменённости
bool Folder_i::get_is_changed () const {
	//#UC START# *456EB3E1017D_45F560B903B9_GET*
	return false;
	//#UC END# *456EB3E1017D_45F560B903B9_GET*
}

// implemented method from EntityBase
// Признак того что данный объект уже сохранен в базе данных. Для не сохраненный объекта сначало
// необходимо указать место хранения (чаще всего папки). Для не сохраненных объектов операция save
// вернет исключение.
bool Folder_i::get_is_saved () const {
	//#UC START# *456EB3E1017C_45F560B903B9_GET*
	return true;
	//#UC END# *456EB3E1017C_45F560B903B9_GET*
}

// implemented method from EntityBase
// Перезаписать сущность текущей сущностью.
EntityStorage* Folder_i::save_to (
	EntityStorage* storage
) /*throw (
	AccessDenied
	, Unsupported
	, NotSaved
	, DuplicateNode
	, CanNotSave
)*/ {
	//#UC START# *456EB3E10178_45F560B903B9*
	throw Unsupported ();
	//#UC END# *456EB3E10178_45F560B903B9*
}

// implemented method from Folder
// можно ли расшарить папку
bool Folder_i::can_share () const {
	//#UC START# *4AA5591A025F_45F560B903B9*
	GDS_ASSERT (m_folders_node->get_object_type () == FIT_FOLDER);
	const FoldersNode_i* folders_node_i = dynamic_cast <const FoldersNode_i*> (m_folders_node.in ());
	return	!folders_node_i->is_my_documents ()					// это не папка "Мои документы"
			&& folders_node_i->is_my_documents_or_lower ()      // папка живет в "Моих документах"
		    && !(m_folders_node->get_flags () & NF_IN_SHARED)   // папка не живет в другой шаренной
			&& !(m_folders_node->get_flags () & NF_HAS_SHARED); // папка не содержит других шаренных
	//#UC END# *4AA5591A025F_45F560B903B9*
}

// implemented method from Folder
// Для сетевой версии.
// Признак того что папка является внешней (т.е. не собственной а принадлежащей другому
// пользователю).
bool Folder_i::get_external () const {
	//#UC START# *45EEE28D00C0_45F560B903B9_GET*
	if (m_is_external == -1) {
		if (is_my ()) {
			m_is_external = false;
		} else {
			m_is_external = true;
		}
	}
	return m_is_external > 0;
	//#UC END# *45EEE28D00C0_45F560B903B9_GET*
}

// implemented method from Folder
// Для сетевой версии. Признак того что папка является общедоступной, т.е видимой другим
// пользователям.
// Прим. внешние папки вегда являются общедоступными.
// При попытки изменить данный признак у внешней папки генерируется исключение ConstantModify.
bool Folder_i::get_shared () const {
	//#UC START# *45EEE28D00BF_45F560B903B9_GET*
	if (m_is_shared == -1) {
		if (m_folder->get_folder_privacy_type () == GblFolders::ft_public) {
			m_is_shared = true;
		} else {
			m_is_shared = false;
		}
	}
	return m_is_shared > 0;
	//#UC END# *45EEE28D00BF_45F560B903B9_GET*
}

void Folder_i::set_shared (bool shared) {
	//#UC START# *45EEE28D00BF_45F560B903B9_SET*
	m_is_shared = shared;

	try {
		if (m_is_shared) {
			m_folder->set_folder_privacy_type (GblFolders::ft_public);
		} else {
			m_folder->set_folder_privacy_type (GblFolders::ft_private);
		}

		if (!m_folders_node.is_nil ()) {
			FoldersNode_i* folders_node_i = dynamic_cast <FoldersNode_i*> (m_folders_node.in ());
			folders_node_i->set_shared_flag (m_is_shared != 0);
		}
	} catch (GCD::AccessDenied&) {
		throw AccessDenied ();
	} catch (Containers::ContentNotFound&) {
		throw CanNotFindData ();
	}
	//#UC END# *45EEE28D00BF_45F560B903B9_SET*
}

// implemented method from NamedElement
// комментарий
const GCI::IO::String& Folder_i::get_comment () const {
	//#UC START# *456EB386034B_45F560B903B9_GET*
	if (m_comment.is_nil ()) {
		if (!CORBA::is_nil (m_folder.in ())) {
			m_comment = 
				GCI::IO::StringFactory::make (CORBA::String_var (m_folder->get_comment ()).in ());
		}
	}
	return *m_comment.ptr ();
	//#UC END# *456EB386034B_45F560B903B9_GET*
}

GCI::IO::String& Folder_i::get_comment () {
	return const_cast<GCI::IO::String&>(((const Folder_i*)this)->get_comment ());
}

void Folder_i::set_comment (GCI::IO::String* comment) {
	//#UC START# *456EB386034B_45F560B903B9_SET*
	if (!CORBA::is_nil (m_folder.in ())) {
		m_folder->set_comment (comment->get_data ());
	}
	m_comment = GCI::IO::String::_duplicate (comment);
	//#UC END# *456EB386034B_45F560B903B9_SET*
}

// implemented method from NamedElement
// имя
const GCI::IO::String& Folder_i::get_name () const {
	//#UC START# *456EB377035B_45F560B903B9_GET*
	if (m_name.is_nil ()) {
		if (!CORBA::is_nil (m_folder.in ())) {
			m_name = GCI::IO::StringFactory::make (CORBA::String_var (m_folder->get_name ()).in ());
		}
	}
	return *m_name.ptr ();
	//#UC END# *456EB377035B_45F560B903B9_GET*
}

GCI::IO::String& Folder_i::get_name () {
	return const_cast<GCI::IO::String&>(((const Folder_i*)this)->get_name ());
}

void Folder_i::set_name (GCI::IO::String* name) {
	//#UC START# *456EB377035B_45F560B903B9_SET*
	if (!CORBA::is_nil (m_folder.in ())) {
		try {
			m_folder->set_name (name->get_data ());
		} catch (Containers::DuplicateName&) {
			throw DuplicateNode ();
		} catch (...) {
			throw CanNotFindData ();
		}
	}
	m_name = GCI::IO::String::_duplicate (name);
	//#UC END# *456EB377035B_45F560B903B9_SET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

