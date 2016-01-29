////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/ArchiAdapterLib/Gardocs/Gardocs.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::ArchiAdapterLib::Gardocs
//
// Gardoc
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIADAPTERLIB_GARDOCS_H__
#define __MDPROCESS_ARCHIADAPTERLIB_GARDOCS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "shared/GCI/IO/IO.h"

namespace ArchiAdapterLib {
namespace Gardocs {

// ������ �����
typedef std::vector < GCI::IO::String_var > StringList;

// ��� ������
enum ImageType {
	giZIP
	, giTIF
	, giDOC
	, giRTF
	, giNSR
};

#pragma pack (push, 1)

// �����
struct Image {
	// ������
	GCI::IO::Stream_var data;
	// ��� ������
	ImageType type;
	// �������� ���������� ������������
	GCI::IO::String_var src_title;
	// ����� �������� � ��������� ������������
	GCI::IO::String_var src_page;
	// ����� ��������� ������������
	GCI::IO::String_var src_number;
	// ���� ��������� ������������ (������)
	GCI::IO::DateTimeBox src_date_start;
	// ���� ��������� ������������ (������)
	GCI::IO::DateTimeBox src_date_end;
	// ������ ���������������� �����, ������������� ��������, ����� ����� �������� ��� �����������
	// ����� �������� ���-�� �������������. ��� �� ��������.
	StringList labels;
};

#pragma pack (pop)

// ������� ������, ���������� ��������� ����� ����� ������
class CommunicationFailure : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������
typedef std::vector < Image > ImageList;

enum GardocStatus {
	gsNEW
	, gsUPDATED
};

enum GarDocType {
	gtDoc
	, gtRelated
};

enum GarDocUrgency {
	guInVersion // � ������
	, guQuickly // �������
	, guOrdinary // �������
	, guUnknown // ����������
};

#pragma pack (push, 1)

// �������� ��������
struct Gardoc {
	// ��� (������, ������������ � �.�)
	GCI::IO::String_var type;
	// �����
	GCI::IO::String_var number;
	// ���� ���������
	GCI::IO::DateTimeBox date;
	// ������ ������� ��������������� ������, ����������� ��������
	StringList ogv_list;
	// ��������
	GCI::IO::String_var title;
	// ����� ����������� � ��
	GCI::IO::String_var mu_number;
	// ���� ����������� � ��
	GCI::IO::DateTimeBox mu_date;
	// ����� (��������), ������������� � ����������� ����, ��������: GAR, LAN �.�.
	StringList blocks;
	// ����� ������
	long long topic;
	// �����������, ������ ����� ����� ����� ������� ��� ���� ���������, ������ ���-�� ������������ �
	// �����������
	GCI::IO::String_var comment;
	// ����� � zip-�, �������� ��� �����-������ ������� ���������, ������� ���� � �
	ImageList images;
	// ����� ������� � �, ������� ����� �������� DPOUVS-
	long long confluence_id;
	GCI::IO::DateTimeBox timestamp;
	GardocStatus state;
	// ���� �������� �������, �� ����� ���������� ����� �������, ���� ���, �� �����
	GCI::IO::String_var text;
	// ����� �������
	long long related;
	// ��� ���������
	GarDocType gardoc_type;
	// ���������
	GarDocUrgency urgency;
	// ������, ��� ���� �������� �� ����, ����� ��� ����������� ��������� ����� ����������
	bool is_internet;
};

#pragma pack (pop)

#pragma pack (push, 1)

// ArchiEvent
struct ArchiEvent {
	// ���
	GCI::IO::String_var type;
	Gardoc doc;
};

#pragma pack (pop)

// GardocList
typedef std::vector < Gardoc > GardocList;

class Searcher;
typedef ::Core::Var<Searcher> Searcher_var;
typedef ::Core::Var<const Searcher> Searcher_cvar;
// Searcher
class Searcher
	: virtual public ::Core::IObject
{
public:
	// ���������� ������ ����� ����������, ������������������ � � ����� date (date - ����� �
	// ������������� ����� 1 ������ 1970 ����, �.�. �����������)
	virtual GardocList* get_recently_created_since (
		const GCI::IO::DateTimeBox& date
		, const char* partnerId
	) const /*throw (
		CommunicationFailure
	)*/ = 0;

	virtual GardocList* get_top_created_since (
		const GCI::IO::DateTimeBox& date
		, long count
	) const /*throw (
		CommunicationFailure
	)*/ = 0;

	virtual GardocList* get_notop_created_since (
		const GCI::IO::DateTimeBox& date
		, long count
	) const /*throw (
		CommunicationFailure
	)*/ = 0;
};

/// factory interface for Searcher
class SearcherFactory {
public:
	// ������ ���������� ���� � ��� �� ���������
	static Searcher& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ArchiEventsListener;
typedef ::Core::Var<ArchiEventsListener> ArchiEventsListener_var;
typedef ::Core::Var<const ArchiEventsListener> ArchiEventsListener_cvar;
// ArchiEventsListener
class ArchiEventsListener
	: virtual public ::Core::IObject
{
public:
	// ���������������� � � ����������� �������
	virtual void on_event (const ArchiEvent& event) const /*throw (CommunicationFailure)*/ = 0;
};

/// factory interface for ArchiEventsListener
class ArchiEventsListenerFactory {
public:
	static ArchiEventsListener& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class Searcher2;
typedef ::Core::Var<Searcher2> Searcher2_var;
typedef ::Core::Var<const Searcher2> Searcher2_cvar;
class Searcher2
	: virtual public ::Core::IObject
{
public:
	virtual GardocList* get_top_created_since (
		const GCI::IO::DateTimeBox& date
		, long count
		, const char* partnerId
	) const /*throw (
		CommunicationFailure
	)*/ = 0;

	virtual GardocList* get_notop_created_since (
		const GCI::IO::DateTimeBox& date
		, long count
		, const char* partnerId
	) const /*throw (
		CommunicationFailure
	)*/ = 0;
};

/// factory interface for Searcher2
class Searcher2Factory {
public:
	static Searcher2* get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class Utils;
typedef ::Core::Var<Utils> Utils_var;
typedef ::Core::Var<const Utils> Utils_cvar;
class Utils
	: virtual public ::Core::IObject
{
public:
	// ����������� ������ ������� ����������� � ��� ��� �� ������� �������� ��� ��������� � ���������
	// ���� � ���������� Searcher2::get_xxxx, � ����� ���������� ������ (�������� ��������� ��
	// ��������). ���� �����, ������� ������ ������ ������� ������, �� ��������� ����� ��������
	// ��������� �������� �����. ������� ������� ������������ � ������, ���� ��� ��
	// Searcher2::get_xxxx �� �������� �� ���� ��������, ������� update_old_last_created_time �
	// ��������� ��������� � ����.
	// ������ ����� �������� �� �������� ������� 30-�� ����� � ��������� ���������� �������. ����
	// ������������ ����� ������ �������� ���������, �� ������ �������� time.
	virtual GCI::IO::DateTimeBox* update_old_last_created_time (
		const GCI::IO::DateTimeBox& date
	) const /*throw (
		CommunicationFailure
	)*/ = 0;
};

/// factory interface for Utils
class UtilsFactory {
public:
	static Utils* get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

typedef std::vector < long long > LongList;

class GardocGetter;
typedef ::Core::Var<GardocGetter> GardocGetter_var;
typedef ::Core::Var<const GardocGetter> GardocGetter_cvar;
class GardocGetter
	: virtual public ::Core::IObject
{
public:
	virtual GardocList* gardocs_by_topic_list (const LongList& topicList) const /*throw (CommunicationFailure)*/ = 0;

	virtual GardocList* gardocs_by_confluenceid_list (
		const LongList& confluenceidList
	) const /*throw (
		CommunicationFailure
	)*/ = 0;
};

/// factory interface for GardocGetter
class GardocGetterFactory {
public:
	static GardocGetter* get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace Gardocs
} // namespace ArchiAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <ArchiAdapterLib::Gardocs::Searcher> {
	typedef ArchiAdapterLib::Gardocs::SearcherFactory Factory;
};
template <>
struct TypeTraits <ArchiAdapterLib::Gardocs::ArchiEventsListener> {
	typedef ArchiAdapterLib::Gardocs::ArchiEventsListenerFactory Factory;
};
template <>
struct TypeTraits <ArchiAdapterLib::Gardocs::Searcher2> {
	typedef ArchiAdapterLib::Gardocs::Searcher2Factory Factory;
};
template <>
struct TypeTraits <ArchiAdapterLib::Gardocs::Utils> {
	typedef ArchiAdapterLib::Gardocs::UtilsFactory Factory;
};
template <>
struct TypeTraits <ArchiAdapterLib::Gardocs::GardocGetter> {
	typedef ArchiAdapterLib::Gardocs::GardocGetterFactory Factory;
};
} // namespace Core


#endif //__MDPROCESS_ARCHIADAPTERLIB_GARDOCS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
