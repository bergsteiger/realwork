////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/I18N/I18N.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::GCI::I18N
//
// �������������������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_I18N_H__
#define __SHARED_GCI_I18N_H__

#include "shared/Core/sys/std_inc.h"
#include <list>
//#UC START# *452CBF700271_CUSTOM_INCLUDE*
#define TR(str) (GCI::I18N::MessagesFactory::messages ().getw (str))
#define NOT_UNICODE_TR(str) (GCI::I18N::MessagesFactory::messages ().get (str))
//#UC END# *452CBF700271_CUSTOM_INCLUDE*

namespace GCI {
namespace I18N {

// �������������� ���� ���������
enum SupportedLocales {
	SL_UNKNOWN // ������ ����������
	, SL_RU_CP1251 // ������� ������ ��� �������� ���������
	, SL_ENGLISH // ���������� ������
	, SL_TATAR // ��������� ���������
};

// �� ������ ��������� ���� �� ��������.
class BadFileFormat : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// �� ������ ��������� ����, ���������� ������
class CantFindFile : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// ������ ��������� ���������� ��� ������� �������������������
typedef std::list < std::string > TemplateParamsList;

class LocaleOperations;
typedef ::Core::Var<LocaleOperations> LocaleOperations_var;
typedef ::Core::Var<const LocaleOperations> LocaleOperations_cvar;
// �������-��������� ��� ������ � ������������
class LocaleOperations
	: virtual public ::Core::IObject
{
public:
	// ������������� ������� ������.
	virtual void set_locale (SupportedLocales locale) = 0;

	// ���������� ������� ������
	virtual SupportedLocales get_locale () const = 0;

	// ���������� �������� ������ �� � ���������� �������������
	virtual SupportedLocales string_to_locale (const char* locale_text) const = 0;
};

/// factory interface for LocaleOperations
class LocaleOperationsFactory {
public:
	// ���������� ���������� ��������� �������
	static LocaleOperations& make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class Messages;
typedef ::Core::Var<Messages> Messages_var;
typedef ::Core::Var<const Messages> Messages_cvar;
// ������ �� ��������
class Messages
	: virtual public ::Core::IObject
{
public:
	// �������� ������ �� �����
	virtual void open (const char* file, SupportedLocales locale) /*throw (BadFileFormat, CantFindFile)*/ = 0;

	// �������� ��� ������ ��� ��������� �����
	virtual void close (SupportedLocales locale) = 0;

	// �������� �������������� ������ � utf16
	virtual const std::wstring getw (const char* key, SupportedLocales locale) const = 0;

	// �������� �������������� ������ ��� ������� ��������� ������ (������������ �������� LC_ALL!!!)
	virtual const std::wstring getw (const char* key) const = 0;

	// �������� �������������� ������ �� � unicode
	virtual const std::string get (const char* key, SupportedLocales locale) const = 0;

	// �������� �������������� ������  �� � unicode ��� ������� ��������� ������ (������������
	// �������� LC_ALL!!!)
	virtual const std::string get (const char* key) const = 0;

	// �������� �������������� ��������� ������ � �������������� ����������� �� � unicode ��� �������
	// ��������� ������ (������������ �������� LC_ALL!!!)
	virtual const std::string get (const char* key, const TemplateParamsList& template_params) const = 0;
};

/// factory interface for Messages
class MessagesFactory {
public:
	// ������� ��� ��������� �������, ������������ ��������� Messages
	static Messages& messages ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace I18N
} // namespace GCI

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GCI::I18N::LocaleOperations> {
	typedef GCI::I18N::LocaleOperationsFactory Factory;
};
template <>
struct TypeTraits <GCI::I18N::Messages> {
	typedef GCI::I18N::MessagesFactory Factory;
};
} // namespace Core


#endif //__SHARED_GCI_I18N_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
