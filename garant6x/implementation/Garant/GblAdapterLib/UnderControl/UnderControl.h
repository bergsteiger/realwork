////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/UnderControl/UnderControl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::UnderControl
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_UNDERCONTROL_H__
#define __GARANT6X_GBLADAPTERLIB_UNDERCONTROL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "ace/Task.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garantServer/src/Global/Core/gcdC.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

// ���� �������� �� ��������.
enum ControlledItemType {
	CIT_DOCUMENT // ��������
	, CIT_LIST // ������.
	, CIT_QUERY // ������.
};

// ������� �������� ������� ���������.
static const unsigned long CS_DELETED = 32; // �������� ������.
static const unsigned long CS_ACTIVE = 16; // �������� ������� � ��������
static const unsigned long CS_CHANGED = 8; // �������� �������
static const unsigned long CS_ABOLISHED = 4; // �������� ������� ����
static const unsigned long CS_REGISTERED = 2; // �������� ��������������� � ������� ��
static const unsigned long CS_NOT_REGISTERED = 1; // ��������� �������� � ����������� � ������� ��
static const unsigned long CS_NONE = 0; // �������� �� ���������

class ControlledChangeNotifier;
typedef ::Core::Var<ControlledChangeNotifier> ControlledChangeNotifier_var;
typedef ::Core::Var<const ControlledChangeNotifier> ControlledChangeNotifier_cvar;
// ��������� ������� ������ ���� ���������� �� ������� ��������, ��� ����������� �� �� ���������
// �������������� ��������.
class ControlledChangeNotifier
	: virtual public ::Core::IObject
{
public:
	// �������� � ��� ��� �������������� ������� ����������.
	virtual void fire () const = 0;
};

class Controllable;
typedef ::Core::Var<Controllable> Controllable_var;
typedef ::Core::Var<const Controllable> Controllable_cvar;
// ���������, ������� ������ ������������� �������� ������� ����� ������� "�� ��������". ����������
// ������ ���� ���������, ��� ��� �� ������ � ������� ������������ ���� ����������� �� ��������� �
// �������� ������ ����� ��������. ��� ���������������� ���� ������� ���������� ����� ����
// ������������� �������� �� �������, � ������� �������� �������������� ��� ������ � ���������
// ����������� ControlManager.
class Controllable
	: virtual public ::Core::IObject
{
public:
	// ���������� true, ���� ��������� ���������� �� ��������
	virtual const bool get_can_set_to_control () const = 0;

	// �������� ������������, ��� ������ �������� ��������� �� ��������. ��������� �������� � true
	// �������� � ���������� �������� �� ��������, � false �������������� � ������.
	virtual bool get_controlled () const = 0;

	virtual void set_controlled (bool controlled) = 0;

	// ���������� ������� �������� ������� ���������.
	virtual unsigned long get_control_status () = 0;

	// ��������� �������� �� ��������.
	virtual bool is_same_controllable (const Controllable* other) = 0;

	virtual const GCI::IO::String& get_name () const = 0;
	virtual GCI::IO::String& get_name () = 0;

	// �������� ������ �� ��������.
	virtual Core::IObject* open () = 0;

	// ���������� ������ ��������� � ����.
	virtual void reset_control_status () = 0;

	// �������� ������� �� ��������.
	virtual const GCI::IO::String& get_short_name () const = 0;
	virtual GCI::IO::String& get_short_name () = 0;

	virtual ControlledItemType get_type () const = 0;
};

// ������ �������� �����, ������� �� ��������.
typedef std::vector < Controllable_var > ControlledObjects;

// ������ �� �� ��������.
class NotUnderControl : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ ��� �� ��������.
class AlreadyControlled : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class ControlManager;
typedef ::Core::Var<ControlManager> ControlManager_var;
typedef ::Core::Var<const ControlManager> ControlManager_cvar;
// �������� �������� �� ��������.
class ControlManager
	: virtual public ::Core::IObject
{
public:
	virtual void set_controlled_change_notifier (ControlledChangeNotifier* controlled_change_notifier) = 0;

	virtual const CatalogBase* get_changed_doc () const = 0;
	virtual CatalogBase* get_changed_doc () = 0;

	// �������� ������� �������� �� ��������.
	virtual void update_status (bool force = false) = 0;

	virtual bool get_under_control_status (const GCD::PID& pid, unsigned long& status) = 0;

	virtual void add (const GCD::PID& pid) = 0;

	virtual void remove (const GCD::PID& pid) = 0;

	virtual void reset_control_status (const GCD::PID& pid) = 0;

	virtual void refresh_control_status () = 0;

	virtual ACE_THR_FUNC_RETURN do_update_status () = 0;

	virtual ControlledObjects* get_controlled_objects () const = 0;
};

/// factory interface for ControlManager
class ControlManagerFactory {
public:
	static ControlManager& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::ControlManager> {
	typedef GblAdapterLib::ControlManagerFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_UNDERCONTROL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
