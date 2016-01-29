////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/InternetSupport/InternetSupport.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::InternetSupport
//
// �����������, ��������� ����� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_H__
#define __GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

class InternetSupport;
typedef ::Core::Var<InternetSupport> InternetSupport_var;
typedef ::Core::Var<const InternetSupport> InternetSupport_cvar;
// ��������� ������ ������������� ����� internet
class InternetSupport
	: virtual public ::Core::IObject
{
public:
	// ��������� �� ������ �������� ������� ���������� (��� �������������� ������)
	virtual bool revision_check_enabled () const = 0;

	// �������� URL ��� ��������� ���������
	virtual GCI::IO::String* get_url_for_document (unsigned long doc_id, unsigned long para_id) const = 0;

	// �������� �� ��������-�����.
	virtual bool is_internet_agent_enabled () const = 0;

	// �������� URL ��� �������� ������
	virtual GCI::IO::String* get_url_for_internet_version () const = 0;

	// ����� �� ���������� ������ �� ���������� ������ ��������
	virtual bool show_warning () const = 0;
};

/// factory interface for InternetSupport
class InternetSupportFactory {
public:
	// �������
	static InternetSupport* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class DecisionsArchiveSupport;
typedef ::Core::Var<DecisionsArchiveSupport> DecisionsArchiveSupport_var;
typedef ::Core::Var<const DecisionsArchiveSupport> DecisionsArchiveSupport_cvar;
// ��������� ������� � ������� �������� �������
class DecisionsArchiveSupport
	: virtual public ::Core::IObject
{
public:
	// �������� ������ ��� �������� �� ����� �������� �������
	virtual GCI::IO::String* get_archive_url () const = 0;

	// ����� �������� ������� ��������
	virtual bool archive_available () const = 0;
};

/// factory interface for DecisionsArchiveSupport
class DecisionsArchiveSupportFactory {
public:
	static DecisionsArchiveSupport* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::InternetSupport> {
	typedef GblAdapterLib::InternetSupportFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::DecisionsArchiveSupport> {
	typedef GblAdapterLib::DecisionsArchiveSupportFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_INTERNETSUPPORT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
