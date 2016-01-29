////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/GCI/impl/I18N_i/Messages_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> shared::GCI::I18N_i::Messages_i
// ��������� ���������� ������ �������� ��� ��������� Messages
//
// ���������� ������ � ��������������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCI_I18N_I_MESSAGES_I_H__
#define __SHARED_GCI_I18N_I_MESSAGES_I_H__

#include "shared/Core/sys/std_inc.h"
#include <map>
#include "shared/GCI/I18N/I18N.h"
#include "shared/GCI/impl/I18N_i/I18N_i.h"

//#UC START# *452CCF1602FD_CUSTOM_INCLUDES*
//#UC END# *452CCF1602FD_CUSTOM_INCLUDES*

namespace GCI {
namespace I18N_i {

class Messages_i; // self forward Var
typedef ::Core::Var<Messages_i> Messages_i_var;
typedef ::Core::Var<const Messages_i> Messages_i_cvar;

class Messages_i_factory;

// ���������� ������ � ��������������� ��������
class Messages_i:
	virtual public I18N::Messages
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Messages_i)
	friend class Messages_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// ���� - ������, �������� - ������ �� ����� ���� ������
	typedef std::map < I18N::SupportedLocales, const std::wstring > L10NStrings;

	// ���� - ������, �������� - ���� ������-������.
	typedef std::map < std::string, L10NStrings > I18NStrings;

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// ������� ������ utf � �������� ������
	static const std::string utf_to_locale (const char* utf_string, I18N::SupportedLocales locale);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~Messages_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ������� ������� ������
	virtual I18N::SupportedLocales get_current_locale () const;

	// �������� �� ������ ������
	virtual const char* get_string (const CharBuffer& buffer, size_t offset, size_t& length) const;

	// �������� �� ������ 4-�� �������� ����������� �����
	virtual unsigned long get_uint32 (const CharBuffer& buffer, size_t offset) const;

	// ����� ���� ��� �������� �� ������������� ������
	virtual const char* locale_to_path (I18N::SupportedLocales locale) const;

	// ��������� ���� � ����������
	virtual void read_file (const CharBuffer& buffer, I18N::SupportedLocales locale);

	// ��������� ������� ���������
	virtual void read_messages (const CharBuffer& buffer, I18N::SupportedLocales locale);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	I18N::SupportedLocales m_default_locale;

	EndianType m_endian;

	I18NStrings m_string_table;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from I18N::Messages
	// �������� ��� ������ ��� ��������� �����
	virtual void close (I18N::SupportedLocales locale);

	// implemented method from I18N::Messages
	// �������� �������������� ������ �� � unicode
	virtual const std::string get (const char* key, I18N::SupportedLocales locale) const;

	// implemented method from I18N::Messages
	// �������� �������������� ������  �� � unicode ��� ������� ��������� ������ (������������
	// �������� LC_ALL!!!)
	virtual const std::string get (const char* key) const;

	// implemented method from I18N::Messages
	// �������� �������������� ��������� ������ � �������������� ����������� �� � unicode ��� �������
	// ��������� ������ (������������ �������� LC_ALL!!!)
	virtual const std::string get (const char* key, const I18N::TemplateParamsList& template_params) const;

	// implemented method from I18N::Messages
	// �������� �������������� ������ � utf16
	virtual const std::wstring getw (const char* key, I18N::SupportedLocales locale) const;

	// implemented method from I18N::Messages
	// �������� �������������� ������ ��� ������� ��������� ������ (������������ �������� LC_ALL!!!)
	virtual const std::wstring getw (const char* key) const;

	// implemented method from I18N::Messages
	// �������� ������ �� �����
	virtual void open (
		const char* file
		, I18N::SupportedLocales locale
	) /*throw (
		I18N::BadFileFormat
		, I18N::CantFindFile
	)*/;

//#UC START# *452CCF1602FD*
public:
	void dump () const; // for test
//#UC END# *452CCF1602FD*
}; // class Messages_i

} // namespace I18N_i
} // namespace GCI


#endif //__SHARED_GCI_I18N_I_MESSAGES_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
