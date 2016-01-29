////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GSI/NotifyService/NotifyService.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GSI::NotifyService
//
// ������ ��� �������� ����������� ����� ����������, ������� ����� ���� �������� �� ������ �������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GSI_NOTIFYSERVICE_H__
#define __SHARED_GSI_NOTIFYSERVICE_H__

#include "shared/CoreSrv/sys/std_inc.h"

namespace GSI {
namespace NotifyService {

class Consumer;
typedef ::Core::Var<Consumer> Consumer_var;
typedef ::Core::Var<const Consumer> Consumer_cvar;
// ��������� ���������� ���������. ��������/������� �� ��������� ����� ������ ������ ����������. �
// ������� ���������� ������� ��� ���� ����� ���������� ������ ��������������� �� ����������
// Consumer_i.
class Consumer
	: virtual public ::Core::IObject
{
public:
	// ��� ��������� ��������� ���������� ����������� ���� �����.
	virtual void fire_event (const CORBA::Any& event) = 0;
};

// � ������� ������������� ����������� ������� ��������� ������ ������������� ����������, �������
// ���������������� ����� PersonalID. ��� �� ���������� ��� �������� ���������, ����������������
// ������ ���, �� ������ ��� �������� ��� ������ ��������� ������� ���� PersonalID.
typedef long PersonalID;

// ���������� ������, ����������� �� ���� �������.
class InternalError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ �� ������������������ (�� �������)
class NotInitialized : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class Supplier;
typedef ::Core::Var<Supplier> Supplier_var;
typedef ::Core::Var<const Supplier> Supplier_cvar;
// ��������� ��� ������� ���������.
class Supplier
	: virtual public ::Core::IObject
{
public:
	// ������� ������� ���������, ������� ����� �������� ���� �����������.
	/*oneway*/ Core::ThreadHandle send_common_notify (
		const CORBA::Any& notify
	) const /*throw (
		InternalError
		, NotInitialized
	)*/;

	// ������� ������������ ���������, ������� ����� �������� ������ �����������, ������� ��� ��������
	// �� ��������� ������ �������� prs_id
	/*oneway*/ Core::ThreadHandle send_personal_notify (
		const CORBA::Any& notify
		, PersonalID prs_id
	) const /*throw (
		InternalError
		, NotInitialized
	)*/;

// oneway methods impl
private:
	static void thr_send_common_notify_ (void* arg);

	static void thr_send_personal_notify_ (void* arg);

protected:
	virtual void send_common_notify_ (const CORBA::Any& notify) const = 0;

	virtual void send_personal_notify_ (const CORBA::Any& notify, PersonalID prs_id) const = 0;
};

/// factory interface for Supplier
class SupplierFactory {
public:
	// ��������� �����
	static Supplier* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class Manager;
typedef ::Core::Var<Manager> Manager_var;
typedef ::Core::Var<const Manager> Manager_cvar;
// ������ ���������. ��������� ������������ ��������������� ����� �����������. ������� ����������
// ���������� CORBA::TAO::Real Event Service, � ���������� � ������������ ���������� �� ����������.
class Manager
	: virtual public ::Core::IObject
{
public:
	// ��������� �������
	virtual void done () /*throw (InternalError, NotInitialized)*/ = 0;

	// ������ �������
	virtual void init () /*throw (InternalError, NotInitialized)*/ = 0;
};

/// factory interface for Manager
class ManagerFactory {
public:
	// ��������� �����
	static Manager& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace NotifyService
} // namespace GSI

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GSI::NotifyService::Supplier> {
	typedef GSI::NotifyService::SupplierFactory Factory;
};
template <>
struct TypeTraits <GSI::NotifyService::Manager> {
	typedef GSI::NotifyService::ManagerFactory Factory;
};
} // namespace Core


#endif //__SHARED_GSI_NOTIFYSERVICE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
