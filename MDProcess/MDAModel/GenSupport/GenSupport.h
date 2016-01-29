////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/GenSupport/GenSupport.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::MDAModel::GenSupport
//
// ��������������� ���������� ��� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_GENSUPPORT_H__
#define __MDPROCESS_MDAMODEL_GENSUPPORT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "MDProcess/MDAModel/Base/Base.h"
#include "MDProcess/ServerGate/GenerationContents/GenerationContents.h"
#include "shared/WinGUI/Controls/Controls.h"

namespace GenSupport {

class GenerationNotStarted : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ��������� ���� �������� �������������
class GenerationCanceled : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class GenerationAlreadyStarted : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class ProgessIndicatorService;
typedef ::Core::Var<ProgessIndicatorService> ProgessIndicatorService_var;
typedef ::Core::Var<const ProgessIndicatorService> ProgessIndicatorService_cvar;
// ��������� ��� ������������ ��������, ��������� ��������� ������ ������� ���������� �������
// ���������� ������������ ��������
class ProgessIndicatorService
	: virtual public WinGUI::ProgressIndicatorDelegate
{
public:
	// ������ ��������� - ���������� �������� ���������
	virtual void start () /*throw (GenerationAlreadyStarted)*/ = 0;

	// ������� ���������� ���������
	virtual void end () /*throw (GenerationNotStarted)*/ = 0;

	// ��������� ��� ���������. ���� �� ��� ������� start, �� �������� ���
	virtual void step () = 0;

	// ���������� ���, �������� ��������� ����������� ���. ���� �� ��� ������� start, �� �������� ���
	virtual void step (const std::string& message) = 0;

	// ���������� true, ���� �������� �������, �� ��� �� ��������
	virtual bool is_started () const = 0;

	// ��������� ���������� � �������� ����������
	virtual void update_message (const std::string& mess) = 0;
};

/// factory interface for ProgessIndicatorService
class ProgessIndicatorServiceFactory {
public:
	// ���������� ������������ ���������
	static ProgessIndicatorService& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class PageProxy;
typedef ::Core::Var<PageProxy> PageProxy_var;
typedef ::Core::Var<const PageProxy> PageProxy_cvar;
// ������ ��� ����������� ��������
class PageProxy
	: virtual public ::Core::IObject
{
public:
	// ������������ ����� ������ �������� (��� UC). ��������� ������� ������� ������� �����
	// ����������� ������ ��� �������� commit.  ��� ������ �������� ������������ ������ ����������
	// ���� ������ �� ����� ������, ��� ������������� � ��������� ������. ������� ������������ ������
	// �������� � ����������
	virtual const std::string& get_generated_text () const = 0;

	virtual void set_generated_text (const std::string& generated_text)
		/*throw (ServerGate::GenerationContents::TransactionConflict, ServerGate::GenerationContents::ReadOnlyContent)*/ = 0;

	// ������������ ������� ����� �������
	virtual const std::string& get_labels () const = 0;

	virtual void set_labels (const std::string& labels)
		/*throw (ServerGate::GenerationContents::TransactionConflict, ServerGate::GenerationContents::ReadOnlyContent)*/ = 0;

	// r/o ��������� �������� �� �� ������������� ���������
	virtual ServerGate::GenerationContents::Page* get_page_before_changes () const = 0;

	virtual const std::string& get_guid () const = 0;

	virtual const std::string& get_path () const = 0;

	virtual void set_path (const std::string& path) = 0;

	// ���������� ������, ��� ������� ������� �������
	virtual ServerGate::GenerationContents::Page* get_delegate () const = 0;

	// ��������� ��������� � �����
	virtual void add_diagram (
		const char* name
		, const ServerGate::GenerationContents::Diagram& d
	) /*throw (
		ServerGate::GenerationContents::TransactionConflict
		, ServerGate::GenerationContents::ReadOnlyContent
	)*/ = 0;

	// ��������� ��� �������� �������� �������� ���������
	virtual void add_property_map (
		const ServerGate::GenerationContents::PropertyMapEntryList& map
	) /*throw (
		ServerGate::GenerationContents::TransactionConflict
		, ServerGate::GenerationContents::ReadOnlyContent
		, ServerGate::GenerationContents::ContentUpdateError
		, ServerGate::GenerationContents::PathNotValid
	)*/ = 0;

	// �������� �������� �� ��������. �������� �������� ���������� ��� �������
	virtual void mark_for_remove () /*throw (ServerGate::GenerationContents::TransactionConflict, ServerGate::GenerationContents::ReadOnlyContent)*/ = 0;

	// ���������� ����������� ����� ��� ���� ������� �������� ��������� (����� ��� ����, ����� ������,
	// ��� �������� ��� ����� ������� ���������� � ������� ���������)
	virtual long long get_all_property_cheksum () const = 0;

	// �� ����� ��������� ���������� �� ���
	virtual char* get_diagram_hash (
		const char* name
	) const /*throw (
		ServerGate::GenerationContents::ReadOnlyContent
	)*/ = 0;

	// ���������� ��� ���� �������� ���� ��������
	virtual bool is_modified () const /*throw (ServerGate::GenerationContents::ReadOnlyContent)*/ = 0;

	// ���������� ��� ���� �������� �����
	virtual bool is_new_page () const /*throw (ServerGate::GenerationContents::ReadOnlyContent)*/ = 0;

	virtual void rollback_all_changes () /*throw (ServerGate::GenerationContents::ReadOnlyContent)*/ = 0;

	// ���������� ��� ���� ������
	virtual void reset () = 0;
};

/// factory interface for PageProxy
class PageProxyFactory {
public:
	// ���������� ��������� ��������
	static PageProxy& get (ServerGate::GenerationContents::ModelElementId_const page_guid)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class LogManager;
typedef ::Core::Var<LogManager> LogManager_var;
typedef ::Core::Var<const LogManager> LogManager_cvar;
// �������� ���������� ������������
class LogManager
	: virtual public ::Core::IObject
{
public:
	// ������������ ������
	virtual void log_error (const std::string& message) const = 0;

	// ������������ ��������������
	virtual void log_warning (const std::string& message) const = 0;

	// ������������ ��������������� ���������
	virtual void log_info (const std::string& message) const = 0;

	// ������������� ���������, ����� ���������� ��������� ���
	virtual void init () const = 0;
};

/// factory interface for LogManager
class LogManagerFactory {
public:
	// ���������� ��������� ���������
	static LogManager& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// ���������� �� ������
struct ErrorInfo {
	// ����� ������
	std::string message;
	// ������������� ��� (���� �� ������ ������)
	std::string alternative_name;
	// ������, � ��������� �������� ��������� ������ (����� ���� 0)
	const Base::Dumper* dumper;
};

#pragma pack (pop)

// ������ ������
typedef std::vector < ErrorInfo > ErrorInfoList;

class ErrorManager;
typedef ::Core::Var<ErrorManager> ErrorManager_var;
typedef ::Core::Var<const ErrorManager> ErrorManager_cvar;
// ��������� ������������ ���������� �������� ������������ � �������� ���������, ���������� ������
// � �.�. ��� ���������� ������ ������������� ������, �� ������ ������������� ������� ����������.
// ��� ������ ������ ���� ���������, ����� ������ ���������� ��� �� ������������ ��������. ����
// ����� ������������� ������ �� �������, �� ��� ������������� ��������� ������ �������������
// ���������� FatalError
class ErrorManager
	: virtual public ::Core::IObject
{
public:
	// ���������� ������ ������
	virtual const ErrorInfoList& get_errors () const = 0;

	// ��������� ���������� � ����������� ������
	virtual void error (const Base::Dumper* dumper, const std::string& message, const std::string& alter_name) = 0;

	// ���������� � ��������� ������, ���� �� ��������� ������� �� ������ - ������������� ����������
	virtual void fatal_error (
		const Base::Dumper* dumper
		, const std::string& message
		, const std::string& alter_name
	) /*throw (
		Base::FatalError
	)*/ = 0;

	// ������� ������ ������
	virtual void clear_errors () = 0;

	// ��������� ������ ��� ������ � ��������� � ��������������� = uid
	virtual void fatal_error (const std::string& uid, const std::string& message, const std::string& alter_name) = 0;

	// ������� ������ ������, ������� ��������� � ��������� ������-�� ��������
	virtual void clear_only_dumper_errors () = 0;
};

/// factory interface for ErrorManager
class ErrorManagerFactory {
public:
	// �������
	static ErrorManager& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// �������� ���������� ������� ��������� ��� ���������
enum LockStrategy {
	LS_LOCK_ALL // ������ ��, ���� ����� - ��� ������������ �����, ����� �������� �������� � ������ ��� ������ ���������� (���������, �����������).
	, LS_ASK // �����������, ���� ��� �� ������� - ��� ������������� �������� ���-�� � ������ �, ���� ��� �� ������� �������������, ������������ ����� � �������� "�������� ����� ��� ���"
	, LS_NO_LOCK // ������ �� ������
};

#pragma pack (push, 1)

// ��������� ���������, ������������ � ������ ������������� �������� ������������ ��������
struct LockFailedOptions {
	// ����� �� ������� ������ � ����������� ������
	bool need_ask;
	// ����� �� ����������� ����������
	bool need_fatal_error;
	LockFailedOptions () : need_ask(true), need_fatal_error(true) {
		//#UC START# *48F337A901FD_DEF_INIT_CTOR*
			//#UC END# *48F337A901FD_DEF_INIT_CTOR**cpp*
	}
};

#pragma pack (pop)

class Environment;
typedef ::Core::Var<Environment> Environment_var;
typedef ::Core::Var<const Environment> Environment_cvar;
// ��������� ��������� - ��������� ������������ ��� ��������� ���������� ��������� (���������
// �������, � ����� ��� ������ ���������)
class Environment
	: virtual public ::Core::IObject
{
public:
	// ����, ������������ ����� �� ��������� ������������� ���� ����, ����������� � ������ - ���� ����
	// - false - ��� �� ������ ������������.
	virtual bool get_suppress_user_code () const = 0;

	virtual void set_suppress_user_code (bool suppress_user_code) = 0;

	// ����� �� ������������ ���� ��� ���, ��� ���������� � �������
	virtual bool get_rewrite_user_code () const = 0;

	virtual void set_rewrite_user_code (bool rewrite_user_code) = 0;

	// ���� ������ ��������������
	virtual bool get_disable_auto_count () const = 0;

	virtual void set_disable_auto_count (bool disable_auto_count) = 0;

	// ���� ������ ����-����������� (������, ����������� ����� ���������� ����������� ���������)
	virtual bool get_disable_post_processing () const = 0;

	virtual void set_disable_post_processing (bool disable_post_processing) = 0;

	// ���� ������ ���������
	virtual bool get_cancel_generation () const = 0;

	virtual void set_cancel_generation (bool cancel_generation) = 0;

	// ����� �� ����������� ����� ������ spell-����������
	virtual bool get_enable_spell_explicit_call_logging () const = 0;

	virtual void set_enable_spell_explicit_call_logging (bool enable_spell_explicit_call_logging) = 0;

	// ����� �� �������� ��� ������� �������� ������� ���������� �� �������������� ��������
	virtual bool get_scold_if_call_tpl_function_on_null () const = 0;

	virtual void set_scold_if_call_tpl_function_on_null (bool scold_if_call_tpl_function_on_null) = 0;

	// ����� �� ��������� ������, ����������� � �������� ���������
	virtual bool get_suppress_generation_errors () const = 0;

	virtual void set_suppress_generation_errors (bool suppress_generation_errors) = 0;

	// ��������� ��������� ������� (��-��������� LS_NO_LOCK)
	virtual LockStrategy get_lock_strategy () const = 0;

	virtual void set_lock_strategy (LockStrategy lock_strategy) = 0;

	// ��������� ��������� ��� ������������� �������� ������������ ���������
	virtual const LockFailedOptions& get_lock_failed_options () const = 0;

	virtual void set_lock_failed_options (const LockFailedOptions& lock_failed_options) = 0;

	virtual void set_lock_failed_need_ask (bool value) = 0;

	virtual void set_lock_failed_need_fatal_error (bool value) = 0;
};

/// factory interface for Environment
class EnvironmentFactory {
public:
	// �������
	static Environment& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

#pragma pack (push, 1)

// ��������������� ���������, ������� � ������������ ������������� ���� ���������� ������ � �����
// �������, � � ����������� ���������� ��� � false
struct AutoErrorSuppress {
	// ���������� ��������, ������� ������ ���� �������������
	bool saved_value;

	~AutoErrorSuppress ();

	// need_error - ����  false - ������ ����� �����������
	AutoErrorSuppress (bool need_error);
};

#pragma pack (pop)

} // namespace GenSupport

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GenSupport::ProgessIndicatorService> {
	typedef GenSupport::ProgessIndicatorServiceFactory Factory;
};
template <>
struct TypeTraits <GenSupport::PageProxy> {
	typedef GenSupport::PageProxyFactory Factory;
};
template <>
struct TypeTraits <GenSupport::LogManager> {
	typedef GenSupport::LogManagerFactory Factory;
};
template <>
struct TypeTraits <GenSupport::ErrorManager> {
	typedef GenSupport::ErrorManagerFactory Factory;
};
template <>
struct TypeTraits <GenSupport::Environment> {
	typedef GenSupport::EnvironmentFactory Factory;
};
} // namespace Core


#endif //__MDPROCESS_MDAMODEL_GENSUPPORT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
