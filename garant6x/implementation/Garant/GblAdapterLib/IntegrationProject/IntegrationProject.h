////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/IntegrationProject/IntegrationProject.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::IntegrationProject
//
// ����� ��� ������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_INTEGRATIONPROJECT_H__
#define __GARANT6X_GBLADAPTERLIB_INTEGRATIONPROJECT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

// ��� �������
enum IntegrationType {
	IT_LISTENTRYINFO // ��������
	, IT_LIST // ������
	, IT_QUERY // ������
};

// � ���� ������������ ������ ��� ���������� �������
class CantCreateObject : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class Integration;
typedef ::Core::Var<Integration> Integration_var;
typedef ::Core::Var<const Integration> Integration_cvar;
// ��������� ��� ������ � �������� ����������
class Integration
	: virtual public ::Core::IObject
{
public:
	// �������� �� � ������ ����������� ��� ������� ������������
	virtual const bool get_integration_enabled () const = 0;

	// ���������� ������������� ��������.
	virtual GCI::IO::String* get_integration_complect_id () const /*throw (CanNotFindData)*/ = 0;

	// ����� ���������� ������ �� ��������� xml-�
	virtual IntegrationType get_object_by_xml (
		const char* xml
		, Core::IObject*& result
	) const /*throw (
		CanNotFindData
		, InvalidXMLType
		, CantCreateObject
	)*/ = 0;
};

/// factory interface for Integration
class IntegrationFactory {
public:
	// �������
	static Integration* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::Integration> {
	typedef GblAdapterLib::IntegrationFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_INTEGRATIONPROJECT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
