////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/Settings/Settings.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Settings
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_SETTINGS_H__
#define __GARANT6X_GBLADAPTERLIB_SETTINGS_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "shared/GCI/IO/IO.h"

namespace GblAdapterLib {

typedef char* PropertyStringID;
typedef const char* PropertyStringID_const;


enum PropertyType {
	PT_LONG
	, PT_STRING
	, PT_INT64
	, PT_ULONG
	, PT_BOOLEAN
};

#pragma pack (push, 1)

// ��������� ������� � ���������� ���������.
struct PropertyDefinition {
	// ���������� "������������" �������. ���������� �������� ����� ���������� �������� �� ����
	// �������������, ������� �������, ���������� �������� ������ ������������ ��� �� � �����
	// ����������.
	// ���������� ������� ������ �������������� ��� �������� �� ��������� �� ������������.
	// �������� �� ���������: false
	bool is_unique;
	// ���������� ����������� ��������� �������� ���������.
	// �������� �� ���������: false
	bool is_constant;
	PropertyType type;
};

#pragma pack (pop)

// ������  �������� ���������� �������� �������� � ����������������� �������������
enum DefaultValuesChangesState {
	NO_CHANGES // �������� �� ����������
	, UPDATED_WITH_COPY_ACTIVE_CONFIGURATION // ������������ � ������ ����� �������� �� ��������� �������� � ����� �� ����������� (�����������������) ������������.    - �������� ����� ������� ������������. ���: <��� ������������> + (�����������). ���� ������������ � ����� ������ ��� c��������� -- ��  (����������� 2).    - ��� ���� ����������� ������������ ��������� ������������ � ��������  �� ���������.
	, UPDATED_WITH_ACTIVATE_PREDEFINED_CONFIGURATION // ������������ � ������ ����� �������� �������� � ����������� ������������� (������ �����������).    - ��� ���� ����������� ������������ ��������� ������������ � �������� �� ���������    - ������������ ������������� � ��� ����������� ������������ �� "�����������" (������ � ������ �����������������)
};

// ������������ ��� ������� ��������� ��� ��������� ����� ��������� ParameterValues �������� ��
// ����, ������� �� ��������� � �������� ����� �������� (�������� ��� ����� �������� ����� ��������
// value_type).
class InvalidValueType : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ��� ������������, ��������� ��� �����������������: ����������� � ������ 5x, ��� ��������� -
// ����������������
enum ConfigurationType {
	CT_STANDARD
	, CT_GARANT5X
	, CT_USER
};

typedef std::vector < GCI::IO::String_var > PropertyStringIDList;

class BaseSettingsManager;
typedef ::Core::Var<BaseSettingsManager> BaseSettingsManager_var;
typedef ::Core::Var<const BaseSettingsManager> BaseSettingsManager_cvar;
class BaseSettingsManager
	: virtual public ::Core::IObject
{
public:
	// ������ �������� ���� Boolean.
	// ��� ������ ���������� true.
	// ���� �������� �� ���������� ���������� false.
	// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
	virtual bool get_bool (PropertyStringID_const id, bool& value) /*throw (InvalidValueType)*/ = 0;

	// ������ �������� ���� int64.
	// ��� ������ ���������� true.
	// ���� �������� �� ���������� ���������� false.
	// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
	virtual bool get_int64 (PropertyStringID_const id, long long& value) /*throw (InvalidValueType)*/ = 0;

	// ������ �������� ���� long.
	// ��� ������ ���������� true.
	// ���� �������� �� ���������� ���������� false.
	// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
	virtual bool get_long (PropertyStringID_const id, long& value) /*throw (InvalidValueType)*/ = 0;

	// ������ �������� ���� String.
	// ��� ������ ���������� true.
	// ���� �������� �� ���������� ���������� false.
	// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
	virtual bool get_string (PropertyStringID_const id, GCI::IO::String*& value) /*throw (InvalidValueType)*/ = 0;

	// ������ �������� ���� unsigned long.
	// ��� ������ ���������� true.
	// ���� �������� �� ���������� ���������� false.
	// ���� ��� �������� �� ������������� ���������� ����������� ���������� InvalidValueType
	virtual bool get_ulong (PropertyStringID_const id, unsigned long& value) /*throw (InvalidValueType)*/ = 0;

	// ������ �������� ���� Boolean.
	// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
	// �������� �� ��������� � ��� ������� ��������.
	// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
	virtual void set_bool (PropertyStringID_const id, bool value) /*throw (InvalidValueType)*/ = 0;

	// ������ �������� ���� int64.
	// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
	// �������� �� ��������� � ��� ������� ��������.
	// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
	virtual void set_int64 (PropertyStringID_const id, long long value) /*throw (InvalidValueType)*/ = 0;

	// ������ �������� ���� long.
	// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
	// �������� �� ��������� � ��� ������� ��������.
	// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
	virtual void set_long (PropertyStringID_const id, long value) /*throw (InvalidValueType)*/ = 0;

	// ������ �������� ���� String.
	// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
	// �������� �� ��������� � ��� ������� ��������.
	// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
	virtual void set_string (PropertyStringID_const id, const char* value) /*throw (InvalidValueType)*/ = 0;

	// ������ �������� ���� unsigned long.
	// ���� �������� �� ����������, �� ��� ��������� � ������� ������������, value ������������ ���
	// �������� �� ��������� � ��� ������� ��������.
	// ���� ��� �������� �� ������������� ���������������� ����������� ���������� InvalidValueType
	virtual void set_ulong (PropertyStringID_const id, unsigned long value) /*throw (InvalidValueType)*/ = 0;

	// ���������� true, ���� �������� � ����� ������ ����������
	virtual bool is_exist (PropertyStringID_const id) const = 0;
};

class SettingsManager;
typedef ::Core::Var<SettingsManager> SettingsManager_var;
typedef ::Core::Var<const SettingsManager> SettingsManager_cvar;
// ��������� ������ � �����������. ������������ �������� ����� ������� � �� ���������. ��������
// ��������������� ��������� ���������������.
// ��������� ����� ���� �������
// 1. �� ���������� Common, � ���� ������ �� ������������ ������ � ��������� �������� ������������.
// 2. �� ���������� Configuration, � ���� ������ �������������� ������ �� ���������� ����������
// ������������.
class SettingsManager
	: virtual public BaseSettingsManager
{
public:
	// ������������� ���������� �������� ������� �������� ������� �������� �� ���������
	virtual void restore_default (PropertyStringID_const id) const /*throw (CanNotFindData)*/ = 0;

	// ���������� ������� �������� �������� � ��������  ��� �������� �� ���������
	virtual void save_as_default (PropertyStringID_const id) const /*throw (CanNotFindData)*/ = 0;

	// ���������� ��������� � ���������� ���������
	virtual bool get_definition (PropertyStringID_const id, PropertyDefinition& definition) const = 0;

	// ���������� true, ���� ������� �������� �� ����� �������� �� ���������, � ��������� ������
	// ���������� false
	virtual bool is_changed (PropertyStringID_const id) const = 0;

	virtual bool is_changed_set (const PropertyStringIDList& id_list) const = 0;
};

/// factory interface for SettingsManager
class SettingsManagerFactory {
public:
	static SettingsManager* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed, NoSession)*/;
};

class ConfigurationIsActiveNow : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class Configuration;
typedef ::Core::Var<Configuration> Configuration_var;
typedef ::Core::Var<const Configuration> Configuration_cvar;
// ��������� �������������� ������ � ���������� �������������, �������� ��������� ������
// ������������.
class Configuration
	: virtual public ::Core::IObject
{
public:
	// ��� ������������
	virtual const GCI::IO::String* get_name () const = 0;
	virtual GCI::IO::String* get_name () = 0;

	virtual void set_name (GCI::IO::String* name) = 0;

	// ����������� ��� ��������� � ������������
	virtual const GCI::IO::String* get_hint () const = 0;
	virtual GCI::IO::String* get_hint () = 0;

	virtual void set_hint (GCI::IO::String* hint) = 0;

	virtual ConfigurationType get_type () const = 0;

	// ���������� ����������� ��������� �������� �� ��������� ��� ������������
	virtual bool get_is_readonly () const = 0;

	virtual unsigned long get_id () const = 0;

	// ������������� ��� ���� ������� ������������ ��������� ��������
	virtual void restore_default_values () const = 0;

	// ���������� ������� �������� ��� ���� ������� � �������� �������� �� ���������
	virtual void save_values_as_default () const = 0;

	// ���������� ����� ������������
	virtual Configuration* copy () const = 0;

	virtual SettingsManager* get_settings () const = 0;
};

/// factory interface for Configuration
class ConfigurationFactory {
public:
	static Configuration* make (long id, const GCI::IO::String* name, const GCI::IO::String* hint, bool readonly)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class ConfigurationsNotDefined : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class DefaultValuesChangesIndicator;
typedef ::Core::Var<DefaultValuesChangesIndicator> DefaultValuesChangesIndicator_var;
typedef ::Core::Var<const DefaultValuesChangesIndicator> DefaultValuesChangesIndicator_cvar;
// ��������� �������� ���������� �������� �������� � ����������������� �������������
// 
// ���� sate == UPDATED_WITH_COPY_ACTIVE_CONFIGURATION, �� configuration �������� ����� ���������
// ���������������� ������������ - ����� �������� �����������������
// 
// ���� state == UPDATED_WITH_ACTIVATE_PREDEFINED_CONFIGURATION, �� configuration ��������
// �����������������, �� ������� ����������� ������������
class DefaultValuesChangesIndicator
	: virtual public ::Core::IObject
{
public:
	virtual DefaultValuesChangesState get_state () const = 0;

	virtual const Configuration* get_configuration () const = 0;
	virtual Configuration* get_configuration () = 0;
};

/// factory interface for DefaultValuesChangesIndicator
class DefaultValuesChangesIndicatorFactory {
public:
	static DefaultValuesChangesIndicator* make (DefaultValuesChangesState state, const Configuration* configuration)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

typedef std::vector < Configuration_var > Configurations;

class ConfigurationManager;
typedef ::Core::Var<ConfigurationManager> ConfigurationManager_var;
typedef ::Core::Var<const ConfigurationManager> ConfigurationManager_cvar;
// ��������� �������������� ������ �� ������� ������������. �������� ����� ��������� Common.
class ConfigurationManager
	: virtual public ::Core::IObject
{
public:
	virtual const Configurations& get_configurations () const = 0;

	// ������������� �������� ������������� �������� (������� ��� ���������� Settings, �����������
	// ����� Common)
	virtual void set_active (const Configuration* configuration) = 0;

	// ������� �������� ������������. � ������ ������� ������� �������� ������������ ����������
	// ���������� ConfigurationIsActiveNow
	virtual void remove (const Configuration* configuration) /*throw (ConstantModify, ConfigurationIsActiveNow)*/ = 0;

	// ���������� �������� ������������
	virtual Configuration* get_active () = 0;

	virtual DefaultValuesChangesIndicator* default_values_update_check () = 0;

	// ���������� ������������� �������� ������������
	virtual long get_active_id () const = 0;

	// ����� �������� ��� ������ �� �������
	virtual void logout () = 0;
};

/// factory interface for ConfigurationManager
class ConfigurationManagerFactory {
public:
	static ConfigurationManager* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class PermanentSettingsManager;
typedef ::Core::Var<PermanentSettingsManager> PermanentSettingsManager_var;
typedef ::Core::Var<const PermanentSettingsManager> PermanentSettingsManager_cvar;
// ���������, �� ��������� �� ������������
class PermanentSettingsManager
	: virtual public BaseSettingsManager
{
};

/// factory interface for PermanentSettingsManager
class PermanentSettingsManagerFactory {
public:
	static PermanentSettingsManager* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::SettingsManager> {
	typedef GblAdapterLib::SettingsManagerFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::Configuration> {
	typedef GblAdapterLib::ConfigurationFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::DefaultValuesChangesIndicator> {
	typedef GblAdapterLib::DefaultValuesChangesIndicatorFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::ConfigurationManager> {
	typedef GblAdapterLib::ConfigurationManagerFactory Factory;
};
template <>
struct TypeTraits <GblAdapterLib::PermanentSettingsManager> {
	typedef GblAdapterLib::PermanentSettingsManagerFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_SETTINGS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
