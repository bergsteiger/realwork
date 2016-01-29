////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/JournalBookmark_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::JournalBookmark_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/LibHome.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/JournalBookmark_i.h"
// by <<uses>> dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/DocumentHelper/DocumentFactoryKeyHelper.h"
#include "garantServer/src/Global/Defines/DefinesC.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ApplicationHelper/ApplicationHelper.h"

namespace GblAdapterLib {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

JournalBookmark_i::JournalBookmark_i (ObjectId doc_id, ParaId para_id)
//#UC START# *4A8A8F640192_4A8A90180004_4A8A98BC034D_BASE_INIT*
//#UC END# *4A8A8F640192_4A8A90180004_4A8A98BC034D_BASE_INIT*
{
	//#UC START# *4A8A8F640192_4A8A90180004_4A8A98BC034D_BODY*
	m_bookmark = new GblUserJournalDef::JournalBookmark ();
	m_bookmark->id = doc_id;
	m_bookmark->para = para_id;
	//#UC END# *4A8A8F640192_4A8A90180004_4A8A98BC034D_BODY*
}

JournalBookmark_i::JournalBookmark_i (GblUserJournal::JournalBookmark* journal_bookmark)
//#UC START# *4A8A8F640192_4A8A9A95009B_4A8A98BC034D_BASE_INIT*
	: m_journal_bookmark (GblUserJournal::JournalBookmark::_duplicate (journal_bookmark))
//#UC END# *4A8A8F640192_4A8A9A95009B_4A8A98BC034D_BASE_INIT*
{
	//#UC START# *4A8A8F640192_4A8A9A95009B_4A8A98BC034D_BODY*
	//#UC END# *4A8A8F640192_4A8A9A95009B_4A8A98BC034D_BODY*
}

JournalBookmark_i::~JournalBookmark_i () {
	//#UC START# *4A8A98BC034D_DESTR_BODY*
	if (!CORBA::is_nil (m_journal_bookmark.in ())) {
		ApplicationHelper::instance ()->get_cached_life_cycle_manager()->release_object (
			m_journal_bookmark.in ()
		);
	}
	//#UC END# *4A8A98BC034D_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from EntityBase
// Сохраняет в базе  измененное состояние объекта.
// Объеденяя с с ранее сохраненными данными
EntityStorage* JournalBookmark_i::append_to (
	EntityStorage* storage
) /*throw (
	ConstantModify
	, AccessDenied
	, Unsupported
	, CanNotSave
)*/ {
	//#UC START# *456EB3E1017A_4A8A98BC034D*
	throw Unsupported ();
	//#UC END# *456EB3E1017A_4A8A98BC034D*
}

// implemented method from EntityBase
// идентификатор
const unsigned long JournalBookmark_i::get_eid () const
	/*throw (Unsupported)*/
{
	//#UC START# *456EE084033C_4A8A98BC034D_GET*
	throw Unsupported ();
	//#UC END# *456EE084033C_4A8A98BC034D_GET*
}

// implemented method from EntityBase
// свойство изменённости
bool JournalBookmark_i::get_is_changed () const {
	//#UC START# *456EB3E1017D_4A8A98BC034D_GET*
	return false;
	//#UC END# *456EB3E1017D_4A8A98BC034D_GET*
}

// implemented method from EntityBase
// Признак того что данный объект уже сохранен в базе данных. Для не сохраненный объекта сначало
// необходимо указать место хранения (чаще всего папки). Для не сохраненных объектов операция save
// вернет исключение.
bool JournalBookmark_i::get_is_saved () const {
	//#UC START# *456EB3E1017C_4A8A98BC034D_GET*
	return false;
	//#UC END# *456EB3E1017C_4A8A98BC034D_GET*
}

// implemented method from EntityBase
// Перезаписать сущность текущей сущностью.
EntityStorage* JournalBookmark_i::save_to (
	EntityStorage* storage
) /*throw (
	AccessDenied
	, Unsupported
	, NotSaved
	, DuplicateNode
	, CanNotSave
)*/ {
	//#UC START# *456EB3E10178_4A8A98BC034D*
	throw Unsupported ();
	//#UC END# *456EB3E10178_4A8A98BC034D*
}

// implemented method from JournalBookmark
const Document* JournalBookmark_i::get_document () const {
	//#UC START# *4A8A8FDD0333_4A8A98BC034D_GET*
	try {
		GCD::PID pid;
		pid.m_object_id = this->get_journal_bookmark ().id;
		pid.m_class_id = Defines::CI_TOPIC;
		return DocumentFactory::make (
			pid
			, true /*may be it is redaction*/
			, 0
			, DocumentFactoryKeyHelper::PID_to_key (pid)
		);
	} catch (...) {
		throw CanNotFindData ();
	}
	//#UC END# *4A8A8FDD0333_4A8A98BC034D_GET*
}

Document* JournalBookmark_i::get_document () {
	return const_cast<Document*>(((const JournalBookmark_i*)this)->get_document ());
}

// implemented method from JournalBookmark
// Полное имя (хинт)
const GCI::IO::String* JournalBookmark_i::get_full_name () const {
	//#UC START# *4A8A8F890057_4A8A98BC034D_GET*
	GDS_ASSERT (!CORBA::is_nil (m_journal_bookmark.in ()));
	if (m_full_name.is_nil ()) {
		m_full_name = GCI::IO::StringFactory::make (CORBA::String_var (m_journal_bookmark->full_name ()).in ());
	}
	return m_full_name._sretn ();
	//#UC END# *4A8A8F890057_4A8A98BC034D_GET*
}

GCI::IO::String* JournalBookmark_i::get_full_name () {
	return const_cast<GCI::IO::String*>(((const JournalBookmark_i*)this)->get_full_name ());
}

// implemented method from JournalBookmark
// Получить  серверную журнальную закладку
const GblUserJournalDef::JournalBookmark& JournalBookmark_i::get_journal_bookmark () const {
	//#UC START# *4A8AA1170230_4A8A98BC034D*
	if (!m_bookmark.ptr ()) {
		GDS_ASSERT (!CORBA::is_nil (m_journal_bookmark.in ()));
		m_bookmark = m_journal_bookmark->get_bookmark ();
	}
	return *m_bookmark.ptr ();
	//#UC END# *4A8AA1170230_4A8A98BC034D*
}

// implemented method from JournalBookmark
// Имя
const GCI::IO::String* JournalBookmark_i::get_name () const {
	//#UC START# *4A8A8F7A0191_4A8A98BC034D_GET*
	GDS_ASSERT (!CORBA::is_nil (m_journal_bookmark.in ()));
	if (m_name.is_nil ()) {
		m_name = GCI::IO::StringFactory::make (CORBA::String_var (m_journal_bookmark->name ()).in ());
	}
	return m_name._sretn ();
	//#UC END# *4A8A8F7A0191_4A8A98BC034D_GET*
}

GCI::IO::String* JournalBookmark_i::get_name () {
	return const_cast<GCI::IO::String*>(((const JournalBookmark_i*)this)->get_name ());
}

// implemented method from JournalBookmark
const unsigned long JournalBookmark_i::get_para_id () const {
	//#UC START# *4A8A8FA300D3_4A8A98BC034D_GET*
	return this->get_journal_bookmark ().para;
	//#UC END# *4A8A8FA300D3_4A8A98BC034D_GET*
}
} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

