////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTypes
//
// ������� ����, ������������ � ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_BASETYPES_H__
#define __GARANT6X_GBLADAPTERLIB_BASETYPES_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "garantServer/src/Business/GblPilot/GblPilotDefC.h"
#include "garantServer/src/Business/GblPilot/GblPilotQueryDefC.h"
#include "garantServer/src/Global/Core/ContainersC.h"
#include "shared/GCI/IO/IO.h"
//#UC START# *456EA56002BF_CUSTOM_INCLUDE*
#include "shared/Core/sys/IObject.h"
//#UC END# *456EA56002BF_CUSTOM_INCLUDE*

namespace GblAdapterLib {

// ������������� ������ �������
typedef unsigned long ClassId;

// ������������� ������� ������ ������
typedef unsigned long ObjectId;

#pragma pack (push, 1)

// Persistent ID, ��� ��� ������������� �������� ��������.
struct PId {
	// ������������� ������
	ClassId class_id;
	// ������������� �������
	ObjectId object_id;
};

#pragma pack (pop)

#pragma pack (push, 1)

// ����.
struct Date {
	// �����
	unsigned short day;
	// �����
	unsigned short month;
	// ���.
	unsigned short year;

	// ������� ������� ����
	Date ();

	// ������� �������� ����
	Date (unsigned short y, unsigned short m, unsigned short d);
	//#UC START# *456EA6F00109*
	inline bool operator > (const Date date) const
	{
		if (year > date.year) return true;
		if (year < date.year) return false;
		if (month > date.month) return true;
		if (month < date.month) return false;
		if (day > date.day) return true;
		if (day < date.day) return false;
		return false;
	}

	inline bool operator < (const Date date) const
	{
		if (year < date.year) return true;
		if (year > date.year) return false;
		if (month < date.month) return true;
		if (month > date.month) return false;
		if (day < date.day) return true;
		if (day > date.day) return false;
		return false;
	}

	inline bool operator == (const Date date) const 
	{
		if (day == date.day && month == date.month && year == date.year) {
			return true;
		}
		return false;
	}

	inline bool operator != (const Date date) const
	{
		if (day != date.day || month != date.month || year != date.year) {
			return true;
		}
		return false;
	}

	inline bool operator >= (const Date date) const
	{
		if (*this > date || *this == date) return true;
		return false;
	}

	inline bool operator <= (const Date date) const
	{
		if (*this < date || *this == date) return true;
		return false;
	}
	//#UC END# *456EA6F00109*
};

#pragma pack (pop)

#pragma pack (push, 1)

// �������� ��� (����������).
struct DateInterval {
	// ��������� ����
	Date start;
	// ����������� ����
	Date finish;
};

#pragma pack (pop)

#pragma pack (push, 1)

// �����
struct Time {
	// ����
	unsigned short hour;
	// ������
	unsigned short min;
	// �������
	unsigned short sec;
};

#pragma pack (pop)

#pragma pack (push, 1)

// ���� � �����
struct DateTime {
	// ����
	Date date;
	// �����
	Time time;
};

#pragma pack (pop)

// �����
enum Languages {
	LG_RUSSIAN // �������
	, LG_ENGLISH // ����������
	, LG_FRENCH // �����������
	, LG_GERMAN // ��������
	, LG_SPANISH // ���������
	, LG_ITALIAN // �����������
};

class NamedElement;
typedef ::Core::Var<NamedElement> NamedElement_var;
typedef ::Core::Var<const NamedElement> NamedElement_cvar;
// ����������� �������.
class NamedElement
	: virtual public ::Core::IObject
{
public:
	// ���
	virtual const GCI::IO::String& get_name () const = 0;
	virtual GCI::IO::String& get_name () = 0;

	virtual void set_name (GCI::IO::String* name) = 0;

	// �����������
	virtual const GCI::IO::String& get_comment () const = 0;
	virtual GCI::IO::String& get_comment () = 0;

	virtual void set_comment (GCI::IO::String* comment) = 0;
};

// ���������� ��������� ��� ������� �������� ����������� ���������.
class ConstantModify : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������������ � ������ ��������� ���� �������.
class AccessDenied : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ���������� ������������ � ������ ���� ����������� �������� �� ����� ���� ��������� �� ������, ��
// ������� �������� ����� �������������. �������� ���������� ��������� �����.
class InvalidTimeStamp : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ���� �����������
class StorageLocked : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������������ � ������ ���� ��������� �������� �� �������������� ��������.
class Unsupported : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������������ ��� ������� ���������/������������ ��������� � ������������� (�.� �� ����������� �
// ����� ��������, �������� � ������) �������
class NotSaved : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ����� ����������.
// ������������ � ������, ���� � ������������ ��� ������� � ������.
class FoldersNotAvailable : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ����������� ������ �� �������.
// ������������ � ������, ���� ������ ����������� �� �������� get_<something> �����������.
class CanNotFindData : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ��������� � ������ ���������� ���� � ������, ��� ��� ���� ����� �� ����. ��� ���� ������������
// ������������ ����� �����.
class DuplicateNode : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ ��� ������
class InvalidType : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ �� ����� ���� �������
class CanNotSave : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ ��� ������� XML
class InvalidXMLType : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ����� ���������, ������������ � GblAdapter
static const long NODE_FLAG_STORABLE_ENTITY = 1; // �����, ����������� � Node::flags. ���� BaseEntity::storable == true, �� (Node::flags AND NODE_FLAG_STORABLE_ENTITY) ���������� true
static const char* PROPERTY_PATH_DELIMITER = "/"; // ������ - ����������� ������ ����
static const unsigned long DEFAULT_PRELOAD_CACHE = 50; // ������ �� ��������� ��� ��������� ������������� ��������� ������ ���������.
static const char* LIBRARY_NAME = "GblAdapter.dll"; // �������� ����������

// �� ���������� �������������, ��� ������������ ������-������
class AllContentIsFiltered : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ����� ������� ��������
typedef short CodePage;

class EntityStorage;
typedef ::Core::Var<EntityStorage> EntityStorage_var;
typedef ::Core::Var<const EntityStorage> EntityStorage_cvar;
// ��������� ���������
class EntityStorage
	: virtual public ::Core::IObject
{
public:
	// �������� ��� �����������
	virtual Containers::ContentType get_content_type () const = 0;

	// �������� ���������
	virtual Containers::Content* get_cached_content () const = 0;
};

class EntityBase;
typedef ::Core::Var<EntityBase> EntityBase_var;
typedef ::Core::Var<const EntityBase> EntityBase_cvar;
// ������� ����������� ��������� ��� ���������. ������ ��������� ������ �������� �����������
// BaseTreeSupport::BaseEntity .
class EntityBase
	: virtual public ::Core::IObject
{
public:
	// ������� ���� ��� ������ ������ ��� �������� � ���� ������. ��� �� ����������� ������� �������
	// ���������� ������� ����� �������� (���� ����� �����). ��� �� ����������� �������� �������� save
	// ������ ����������.
	virtual bool get_is_saved () const = 0;

	// �������� �����������
	virtual bool get_is_changed () const = 0;

	// �������������
	virtual const unsigned long get_eid () const
		/*throw (Unsupported)*/ = 0;

	// ������������ �������� ������� ���������.
	virtual EntityStorage* save_to (
		EntityStorage* storage
	) /*throw (
		AccessDenied
		, Unsupported
		, NotSaved
		, DuplicateNode
		, CanNotSave
	)*/ = 0;

	// ��������� � ����  ���������� ��������� �������.
	// ��������� � � ����� ������������ �������
	virtual EntityStorage* append_to (
		EntityStorage* storage
	) /*throw (
		ConstantModify
		, AccessDenied
		, Unsupported
		, CanNotSave
	)*/ = 0;
};

// ������������ ��� �������� �� ��������� ������ � ������, ���� ��������� ���������� ������, � ���
// ���������� ������� ������������ ������.
class EmptyResult : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ ��������.
enum ItemStatus {
	IS_ABOLISHED // ������� ����
	, IS_ACTIVE // �����������
	, IS_PREACTIVE // �� ������� � ����
	, IS_UNKNOWN // �����������
};

// ��������� ���� ��������� ��������� ����.
enum NavigatorMenuItemType {
	NM_FOLDER // ������������� - �����.
	, NM_RUBRICATOR // ��������� �� ��������������.
	, NM_ATTRIBUTE_SEARCH // ����� �� ���������.
	, NM_SITUATION_SEARCH // ����� �� ��������.
	, NM_PUBLISH_SOURCE_SEARCH // ����� �� ��������� �������������.
	, NM_SINGLE_CONTEXT_SEARCH // ��������� (�������) ����� �� ���������.
	, NM_SINGLE_ATTRIBUTE_SEARCH // ��������� (�������) ����� �� ������������ ��������.
	, NM_SINGLE_DATE_NUMBER_SEARCH // ��������� (�������) ����� �� ���� � ������.
	, NM_FILTER_5X // �������� ������� �-�� ������ 5.�.
	, NM_ATTRIBUTE_SEARCH_5X // �������� ������ �� ��������� �-�� ������ 5.�.
	, NM_SITUATION_SEARCH_5X // �������� ������ �� ��������� �-�� ������ 5.�.
	, NM_UPDATE // ����������.
	, NM_CONFIGURATION_LIST // ������ ������������.
	, NM_LIST // ������.
	, NM_COMPLECT_INFO // ���������� � ���������.
	, NM_DOCUMENT // ��������
	, NM_LAW_NAVIGATOR_FOLDER // ����� "�������� ���������"
	, NM_BUSINESS_INFO_FOLDER // ����� "���������� ����������"
	, NM_SEARCH_FOLDER // ����� "�����"
	, NM_UPDATE_FOLDER // ����� "����������"
	, NM_RECENTLY_DOCUMENTS_FOLDER // ����� "��������� �������� ���������"
	, NM_EXPLANATORY_DICTIONARY // �������� �������
	, NM_NEW_DOCS // ����� ���������
	, NM_PRIME_FOLDER // ����� ���� �����
	, NM_REVIEW // ����� ���� ������ ����������������
	, NM_NEWS_LINE // �����������
	, NM_SEARCH_WITH_LAW_SUPPORT // ����� ����: ����� � �������� ����������
	, NM_LAW_SUPPORT // ����� ����: �������� ���������
	, NM_CALENDAR
	, NM_BUSINESS_REFERENCES
	, NM_HOT_INFORMATION
	, NM_CODEX // �������
	, NM_FORMS // ����� ���������
	, NM_MONITORINGS // �����������
	, NM_PHARM_SEARCH // ����� � �������
	, NM_INPHARM // ������
	, NM_PHARM_LEK // ������������� ���������
	, NM_PHARM_FIRMS // ����� �������������
	, NM_PHARM_DICT // ������� ����������� ��������
	, NM_PHARM_BASIC_SECTION // �������� ������� �����������
	, NM_TAXES_AND_FINANCE // ������ � �������
	, NM_BUSINESS_REFERENCES_FOLDER // ����� ������-�������
	, NM_LEGAL_ISSUES // ����������� �������
	, NM_HR // �������� � �����
	, NM_BUDGET_ORGS // ���. � ������������� ����������
	, NM_LAW_FOR_ALL // ����� ��� ����
	, NM_GOS_ZAKUPKI
};

// ��� ���������� ������
enum SearchResultType {
	SRT_DOCUMENT_LIST // ������ ������ ����������
	, SRT_AUTOREFERAT // ������ �����������
	, SRT_CONSULTATION // ������� ������������
};

class SearchEntity;
typedef ::Core::Var<SearchEntity> SearchEntity_var;
typedef ::Core::Var<const SearchEntity> SearchEntity_cvar;
// ��������, ������������ � ����� finish_process �� �������� ����������, ��� ��������� ������
class SearchEntity
	: virtual public ::Core::IObject
{
public:
	// ��� ���������� ������ (������, �����������, ������������)
	virtual SearchResultType get_result_type () const = 0;

	// ���������� ��������� ����������
	virtual size_t get_document_count () const = 0;

	// ���������� ���������
	virtual size_t get_entry_count () const = 0;

	// ���������� ��������
	virtual size_t get_edition_count () const = 0;
};

/// factory interface for SearchEntity
class SearchEntityFactory {
public:
	// �������
	static SearchEntity* make (
		SearchResultType result_type
		, size_t document_count
		, size_t entry_count
		, size_t edition_count
	) /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// �������
	static SearchEntity* make (GblPilotQueryDef::SearchEntity* search_entity)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ����������� ����������.
enum SortOrder {
	SO_ASCENDING // �� ����������� ��������.
	, SO_DESCENDING // �� �������� ��������.
};

// ��� ����������.
enum SortType {
	ST_PRIORITY // ���������� �� ����������� ����
	, ST_CREATE_DATE // ���������� �� ���� ��������
	, ST_LAST_EDIT_DATE // ���������� �� ���� ���������� ���������
	, ST_NOT_SORTED // �� ������������
	, ST_RELEVANCE // ���������� �� �������������
};

#pragma pack (push, 1)

// ��������� ����������.
struct SortParams {
	// ������� ����������
	SortOrder sort_order;
	// ��� �����������
	SortType sort_type;
};

#pragma pack (pop)

// ���� ������ �� ���������
enum TextSearchOptionType {
	TSO_TEXT // ����� �� ������
	, TSO_NAME // ����� �� ���������
	, TSO_PARA // ����� �� ���������
	, TSO_SENTENCE // ����� �� �����������
};

class Variant;
typedef ::Core::Var<Variant> Variant_var;
typedef ::Core::Var<const Variant> Variant_cvar;
// ��� ������ ��� �����������
class Variant
	: virtual public ::Core::IObject
{
public:
	// ������� �����
	virtual long get_long () const /*throw (InvalidType)*/ = 0;

	// ������� ������ ��������
	virtual bool get_bool () const /*throw (InvalidType)*/ = 0;

	// ������� ������
	virtual GCI::IO::String* get_string () /*throw (InvalidType)*/ = 0;

	// ������� ������
	virtual Core::IObject* get_object () /*throw (InvalidType)*/ = 0;
};

/// factory interface for Variant
class VariantFactory {
public:
	// �������
	static Variant* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// ������� ������ ������ ����
	static Variant* make_long (long value)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// ������� ������ ������ bool
	static Variant* make_bool (bool value)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// ������� ������ ������ IString
	static Variant* make_string (GCI::IO::String* value)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// ������� ������ ������ �������
	static Variant* make_object (Core::IObject* value)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ������ ������
typedef std::vector < Core::Box<Languages> > LanguagesList;

// ��������� �����
typedef std::vector < GCI::IO::String_var > StringList;

// ��������� ��������� ������ ��� ��������� � ����
class InternalDatabaseError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������������� �� �������, ������� ����� ��������� ������ � ��������� ������, �.�. ����� ������
class NoSession : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������� � ����� ������ ��� ����������, � ��� � ����� ��������� ������
class DuplicateName : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������������� ������������ ��� ������
typedef long Uid;

enum ListNodeType {
	LNT_SUB // ���
	, LNT_PARA // ��������
	, LNT_EXTERNAL_OBJECT // ������, ����������� �� ������� ����������
	, LNT_EXTERNAL_LINK
	, LNT_DOCUMENT_ABOLISHED // ���������� ���� ��������
	, LNT_DOCUMENT_ACTIVE // ��������
	, LNT_DOCUMENT_PREACTIVE // �� ���������� � ���� ��������
	, LNT_DOCUMENT_UNKNOWN // ����������� ���
	, LNT_EDITION_ABOLISHED // ���������� ���� ��������
	, LNT_EDITION_ACTIVE // ���������� ��������
	, LNT_EDITION_PREACTIVE // ��������, ������� ��� �� ���������
	, LNT_EDITION_UNKNOWN // ����������� ��� ��������
	, LNT_EDITIONS_GROUP // ���� ��������
	, LNT_BLOCK // ����
	, LNT_DRUG_ANNULED // �������� �����������
	, LNT_DRUG_NARCOTIC // ������������� ��������
	, LNT_DRUG_NONANNULED_NONNARCOTIC // ����������� ��������������� ��������
	, LNT_FORM_ANNULED // �������������� ����� ���������
	, LNT_FORM_RUSSIAN_IMPORTANT // �������������� ���������� ��������
	, LNT_FORM_NONRUSSIAN_IMPORTANT // �������������� ����������� ��������
	, LNT_FORM_RUSSIAN_NONIMPORTANT // ���������� ��������
	, LNT_FORM_NONRUSSIAN_NONIMPORTANT // ����������� ��������
	, LNT_FIRM // �����
	, LNT_AAK // �������� ���
};

// ��� ������ ����, �.�. ���� �������� � ������� ActiveX � ��� ObjectId � ������ Document
typedef ObjectId BaseTypesObjectId;

static const unsigned long long ALL_DOCUMENTS_KIND = -1;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::SearchEntity> {
	typedef GblAdapterLib::SearchEntityFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::Variant> {
	typedef GblAdapterLib::VariantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_BASETYPES_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
