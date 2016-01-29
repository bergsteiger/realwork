////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Core/Root/Root.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Core::Root
//
// ����� ����������� ��������� GCM2 (�� ������� �����)
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_ROOT_H__
#define __SHARED_CORE_ROOT_H__

#include "shared/Core/sys/core_std_inc.h"
#include "shared/Core/mt/mt.h"

namespace Core {
namespace Root {

// �������������� �������� ������� �����������
enum ExecutorStatus {
	ES_ERROR // ������ ��� ���������� �����������
	, ES_EXIT_REQUESTED // ������������ ���������� ��������� � ������������� ��������� �������
	, ES_FINISHED // ���������� ����������� ������� ���������
	, ES_EXECUTABLE // ����������� ����� � ������� ��� ��� ������� � ��������� � ������
	, ES_IDLE // ����������� �������� ������ � ��������� � ��������� ��������.
};

// �������� ��������� ������������� ���������� (������������ ������ ��� �� ���������� ��������)
class InvalidParams : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class LibHome;
typedef ::Core::Var<LibHome> LibHome_var;
typedef ::Core::Var<const LibHome> LibHome_cvar;
// ��� ��������� - �������� ������ ������������� � ����������. ��������� ��� ����� ����������,
// ��������� �� ������������� � ���������������. ����������� �� ������� ���������. ��� ����������
// ���������� ������ ���������, �� ������ ������������ ����� ������������.
class LibHome
	: virtual public ::Core::IObject
{
public:
	// ������� �������������� ������ ���� ������������ ����������
	virtual ExecutorStatus get_executors_status () const = 0;

	// ����������� ���������� � ������
	virtual void exit_request () = 0;
};

// ��������� ������ ������������� ��������� ��������� (�������� ���������� ������� � �������
// ��������)
class HomeManagerInitError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class ThreadInitializer;
typedef ::Core::Var<ThreadInitializer> ThreadInitializer_var;
typedef ::Core::Var<const ThreadInitializer> ThreadInitializer_cvar;
// Callback ��������� ��� ���������������� �������������\����������� ����������� � ������� �������
class ThreadInitializer
	: virtual public ::Core::IObject
{
public:
	// ���������� ��� ���������� ������
	virtual void thread_finalize () = 0;

	// ���������� ��� �������� ������
	virtual void thread_init () = 0;
};

class Executor;
typedef ::Core::Var<Executor> Executor_var;
typedef ::Core::Var<const Executor> Executor_cvar;
// �������-�����. ���������� ����� ��������, ������� ����� ������������� � ���������� ���������� ��
// ���������� ����� �������� ������������� ����������.
class Executor
	: virtual public ::Core::IObject
{
public:
	// ������� ������ �����������
	virtual ExecutorStatus get_current_status () const = 0;

	// ����� ���������� ������ ������ �����������, ���������� �����������
	/*oneway*/ Core::ThreadHandle execute ();

// oneway methods impl
private:
	static void thr_execute_ (void* arg);

protected:
	virtual void execute_ () = 0;
};

#pragma pack (push, 1)

// ������ � ����������� � ������� ������������
struct Info {
	// ��� ������ debug\release
	bool debug;
	// ���� �� ������������� CORBA (�������� c TAO)
	bool use_corba;
	// �������� �� ���������� ������ �������� �������� (�� ����������� COS)
	bool server_side;
};

#pragma pack (pop)

class Configuration;
typedef ::Core::Var<Configuration> Configuration_var;
typedef ::Core::Var<const Configuration> Configuration_cvar;
// ��������� ��� ������� � ������� ������������ ����������� ������. ������ ������������ ��
// ����������� ���������� ������ � �� ���������� ������������� ����������
class Configuration
	: virtual public ::Core::IObject
{
public:
	// ������ ������������
	virtual const Info& get_info () const = 0;
};

/// factory interface for Configuration
class ConfigurationFactory {
public:
	// ���������� ��������� ����������
	static const Configuration& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ��� ������������ ��������� ��� ����������� ������ ���������, ����������� ���� ���������.
typedef unsigned short FactoryPriority;

// Method is generated but not implemented
class MDAGenNotImplemented : public ::Core::Exception {
public:
	MDAGenNotImplemented (const std::string& method);

	virtual ~MDAGenNotImplemented () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// ���������� ��� ������
	std::string m_method;
};

// ������ ���������� ��������� � ������� ��������� ������
class FactoryEx : public ::Core::Exception {
};

// Class attributes accessed by cached functiuon was not initialized
class CachedAttrUninitialized : public ::Core::Exception {
public:
	CachedAttrUninitialized (const std::string& attr_name);

	virtual ~CachedAttrUninitialized () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// ��� ��������
	std::string m_attr_name;
};

// No one servant was registers in factory
class NoActiveFactory : public FactoryEx {
public:
	NoActiveFactory (const std::string& factory_name);

	virtual ~NoActiveFactory () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// ��� �������
	std::string m_factory_name;
};

// Just one servant can registers in one factory
class DuplicatedFactoryKey : public FactoryEx {
public:
	DuplicatedFactoryKey (const std::string& factory_name, const std::string& key_name);

	virtual ~DuplicatedFactoryKey () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// ��� �������
	std::string m_factory_name;
	// ���� �������
	std::string m_key_name;
};

// No one servant was registers in factory
class UnknownFactoryKey : public FactoryEx {
public:
	UnknownFactoryKey (const std::string& factory_name, const std::string& key_name);

	virtual ~UnknownFactoryKey () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// ��� �������
	std::string m_factory_name;
	// ���� �������
	std::string m_key_name;
};

class LibHomeManager;
typedef ::Core::Var<LibHomeManager> LibHomeManager_var;
typedef ::Core::Var<const LibHomeManager> LibHomeManager_cvar;
// �������� ����������� �����.
class LibHomeManager
	: virtual public ::Core::IObject
{
public:
	// ������ ��������� �� ����������. �������������� ��� ��������� � ��������� �� ������������.
	virtual void execute () /*throw (InvalidParams, HomeManagerInitError)*/ = 0;

	// ���� ���������� ���� ������������ (� �� �������� �������), ���������� 0, ���� ������ ����
	// ��������� ��� ������ (�� ���� �� ������������ �� �������� ������ ES_ERROR)
	virtual int wait_all () const = 0;

	// ������������ ��������� � ���������
	virtual void registrate_lib_home (LibHome* lib) = 0;

	// ������������� ������ ���������� � ����������� ��� ������� ������� (����������� �������
	// ������������������ ��������� �������������� � �������, �������� �� �����������!)
	virtual void finalize () = 0;

	// ������������ ���������������� ������������� ������
	virtual void registrate_thread_initializer (ThreadInitializer* ti) = 0;

	// ��������� ������������� �������� ������ ����������� ������� ������������������ ���������������
	virtual void init_thread () const = 0;

	// ��������� ��-������������� �������� ������ ����������� ������� ������������������
	// ���������������
	virtual void finalize_thread () const = 0;

	// ������� �������� ���������� ��� ���� ������������������ ����� ���������
	virtual void print_usage () const = 0;

	// ��� ������� ������������������� ���� ���������� ��������� �������� ����������, ���������� true,
	// ���� ��� �������� ������ �������.
	virtual bool check_params () const = 0;
};

/// factory interface for LibHomeManager
class LibHomeManagerFactory {
public:
	// ���������� ���������� ��������� ���������
	static LibHomeManager& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// �������������� ������ ������� � ���
class WrongVersion : public ::Core::Exception {
public:
	WrongVersion (unsigned long client_version, unsigned long dll_version);

	virtual ~WrongVersion () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// ������ �������
	unsigned long m_client_version;
	// ������ ���
	unsigned long m_dll_version;
};

// C������� ������� �� ���������� �������� ����������-������ ������� ����������.
class ImpossibleConversion : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ �������� ������������ ��� "������������" �������� ������. ��������� ��� ������ ���������
// � ��������� ������, ������� ��� ��� ���������.
class FactoryManagerWasDestroyed : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ��������� ��� ������� ������� ������������� ����� �� ���������� �������
class ConstViolation : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

} // namespace Root
} // namespace Core

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <Core::Root::Configuration> {
	typedef Core::Root::ConfigurationFactory Factory;
};
template <>
struct TypeTraits <Core::Root::LibHomeManager> {
	typedef Core::Root::LibHomeManagerFactory Factory;
};
} // namespace Core


#endif //__SHARED_CORE_ROOT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
