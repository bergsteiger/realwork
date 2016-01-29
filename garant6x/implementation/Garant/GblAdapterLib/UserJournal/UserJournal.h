////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/UserJournal/UserJournal.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::UserJournal
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_USERJOURNAL_H__
#define __GARANT6X_GBLADAPTERLIB_USERJOURNAL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/Document.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Search/Search.h"
#include "garantServer/src/Business/GblUserJournal/GblUserJournalC.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

// ���� ��������� ������� ������
enum JournalObjectType {
	JOT_BOOKMARK // ��������
	, JOT_QUERY // ������
	, JOT_FOLDER // �����
};

enum BookmarkJournalType {
	BJT_BOOKMARK // ��������
	, BJT_PHARM_BOOKMARK // �������� �������
};

class UserJournal;
typedef ::Core::Var<UserJournal> UserJournal_var;
typedef ::Core::Var<const UserJournal> UserJournal_cvar;
// ��������� ������� ������
class UserJournal
	: virtual public ::Core::IObject
{
public:
	// ��������� ������ � ������ ������
	virtual void save (const Core::IObject* obj, JournalObjectType object_type) const = 0;

	// ������� ������ �� ������� ������
	virtual void remove (const NodeBase* obj) const = 0;

	// �������� ������ ������ (���������� ������ remove (��� ������ ������� ������)
	virtual void clear () const = 0;

	// �������� ������ ������� ������
	virtual NodeBase* get_user_jornal_tree () const = 0;

	// ������ �������� ��������� ����
	virtual JournalBookmarkList* get_bookmark_history (
		BookmarkJournalType type
		, long max_count
	) const /*throw (
		CanNotFindData
	)*/ = 0;

	// ������� ������ �������� ��������� ���� �� �������
	virtual QueryList* get_query_history (QueryType query_type, long max_count) const /*throw (CanNotFindData)*/ = 0;
};

/// factory interface for UserJournal
class UserJournalFactory {
public:
	static UserJournal* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::UserJournal> {
	typedef GblAdapterLib::UserJournalFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_USERJOURNAL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
