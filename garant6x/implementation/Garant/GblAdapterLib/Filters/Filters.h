////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/Filters/Filters.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Filters
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_FILTERS_H__
#define __GARANT6X_GBLADAPTERLIB_FILTERS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/StartLocal/StartLocal.h"
#include "garantServer/src/Business/GblFilters/GblFiltersC.h"
#include "garantServer/src/Business/GblPilot/GblPilotQueryDefC.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

class FilterFromQuery;
typedef ::Core::Var<FilterFromQuery> FilterFromQuery_var;
typedef ::Core::Var<const FilterFromQuery> FilterFromQuery_cvar;
class FilterFromQuery
	: virtual public StartLocal::BaseUpdateChecker
{
public:
	virtual const GCI::IO::String* get_name () const = 0;
	virtual GCI::IO::String* get_name () = 0;

	virtual void set_name (GCI::IO::String* name) = 0;

	// ���� ������ query Search::Query, ������� �� � ��������, �� ������ ���������� ������ �����������
	// ������, ������� �������� ����� ���������
	virtual const EntityBase* get_query () const = 0;
	virtual EntityBase* get_query () = 0;

	virtual const bool get_changeable () const = 0;

	virtual const bool get_permanent () const = 0;

	virtual void set_permanent (bool permanent) = 0;

	// ������������� ����� ��������, ����� ���������������� ������������� ������� (�274848126)
	virtual const unsigned long get_id () const = 0;

	virtual const unsigned long get_flags () const = 0;

	// ������� ������ ����� ����, ��� �� ���������� ��������������
	virtual void mark_to_erase () = 0;

	// ���������� true, ���� ������������ � ���������� ������� ���������
	virtual bool is_same (const FilterFromQuery* other) const = 0;

	virtual const GblPilotQueryDef::Query& get_server_query () const = 0;

	virtual void save_to_server (const GblPilotQueryDef::Query& query) = 0;

	// ��������� �������� � �������
	virtual bool check () = 0;

	virtual bool marked_to_erase () const = 0;

	// ������� �� ������
	virtual bool is_used () const = 0;
};

/// factory interface for FilterFromQuery
class FilterFromQueryFactory {
public:
	static FilterFromQuery* make (const GblFilters::Filter& filter)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// �� ��� �������� ���������� ������� ������������ �� ����
class NotAllAttributesRestored : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ��������� ��������.
typedef std::vector < FilterFromQuery_var > FiltersFromQuery;

class Filterable;
typedef ::Core::Var<Filterable> Filterable_var;
typedef ::Core::Var<const Filterable> Filterable_cvar;
// ��������� �������������. ������ �������������� ���������, ��������� ������������� ������
// ��������. ������ ������������ ��� �������.
class Filterable
	: virtual public ::Core::IObject
{
public:
	virtual const FiltersFromQuery& get_active_filters () const = 0;

	// ��������� INode (�� ������ �����) ��� ������.
	// ���� auto_refresh = true (�������� �� ���������), ��
	// �������� �������� � �������������� �������.
	virtual void add_filter (
		FilterFromQuery* filter
		, bool auto_refresh
	) /*throw (
		AllContentIsFiltered
		, NotAllAttributesRestored
	)*/ = 0;

	// ��������� ����� �������� � ������������� �� �����������. ��� ���� ��� ����� ���� �������
	// �����������, ���� (� ������, ���� ��� ��������� �������������) ������� �����������.
	// 
	// ���� ����������, ��� �� ������� ��� ������ ��� ���������� ������, �.�. ������ ��� �������� ���
	// (��. �244711732), ����� CanNotFindData.
	virtual void apply_filters (const FiltersFromQuery& filters) /*throw (CanNotFindData, AllContentIsFiltered)*/ = 0;

	// ������� ��� �������. � ���������� �������� ������ ��������� � ���������, �������������
	// ���������� ��������
	virtual void clear_filters () /*throw (CanNotFindData)*/ = 0;

	// ������� ������ �� ������ �������� �������� �������. ���� auto_refresh = true (�������� ��
	// ���������), �� �������� �������� � �������������� �������.
	virtual void delete_filter (
		const FilterFromQuery* filter
		, bool auto_refresh
	) /*throw (
		CanNotFindData
		, AllContentIsFiltered
	)*/ = 0;

	virtual bool get_has_active_filters () const = 0;

	virtual void refresh_filters () /*throw (CanNotFindData, AllContentIsFiltered)*/ = 0;
};

class FilterNotifier;
typedef ::Core::Var<FilterNotifier> FilterNotifier_var;
typedef ::Core::Var<const FilterNotifier> FilterNotifier_cvar;
class FilterNotifier
	: virtual public ::Core::IObject
{
public:
	virtual void filter_name_changed () const = 0;

	virtual void filter_permanence_changed () const = 0;

	virtual void filters_changed () const = 0;
};

class FiltersManager;
typedef ::Core::Var<FiltersManager> FiltersManager_var;
typedef ::Core::Var<const FiltersManager> FiltersManager_cvar;
class FiltersManager
	: virtual public ::Core::IObject
{
public:
	// �������� ������ �������� ��� �������� ����������
	virtual FiltersFromQuery* get_legal_filters () const = 0;

	virtual FiltersFromQuery* get_pharm_filters () const = 0;

	// ������� ����� ������
	virtual void create_filter (const EntityBase* query, const GCI::IO::String* name) = 0;

	virtual void set_legal_notifier (FilterNotifier* notifier) = 0;

	virtual void set_pharm_notifier (FilterNotifier* notifier) = 0;

	virtual void filter_name_changed (bool pharm) const = 0;

	virtual void filter_permanence_changed (bool pharm) const = 0;

	virtual void filter_removed (bool pharm) const = 0;

	virtual void clear_cache (bool pharm) = 0;
};

/// factory interface for FiltersManager
class FiltersManagerFactory {
public:
	static FiltersManager* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class FiltersUsageCounter;
typedef ::Core::Var<FiltersUsageCounter> FiltersUsageCounter_var;
typedef ::Core::Var<const FiltersUsageCounter> FiltersUsageCounter_cvar;
// ��������� ���� ������� ������������� �������� � ��������� ������� ������ ��������������
class FiltersUsageCounter
	: virtual public ::Core::IObject
{
public:
	virtual void add (const FilterFromQuery* filter) = 0;

	virtual void remove (const FilterFromQuery* filter) = 0;

	virtual void mark_to_erase (const FilterFromQuery* filter) = 0;

	virtual bool marked_to_erase (const FilterFromQuery* filter) const = 0;

	virtual bool is_used (const FilterFromQuery* filter) const = 0;
};

/// factory interface for FiltersUsageCounter
class FiltersUsageCounterFactory {
public:
	static FiltersUsageCounter* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::FilterFromQuery> {
	typedef GblAdapterLib::FilterFromQueryFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::FiltersManager> {
	typedef GblAdapterLib::FiltersManagerFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::FiltersUsageCounter> {
	typedef GblAdapterLib::FiltersUsageCounterFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_FILTERS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
