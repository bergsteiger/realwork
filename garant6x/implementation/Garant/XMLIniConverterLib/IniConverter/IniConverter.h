////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::XMLIniConverterLib::IniConverter
//
// ���������� ��� ����������� ini-������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_H__

#include "shared/Core/sys/std_inc.h"
#include <vector>
#include "shared/XercesHelpers/wrappers/DOMNodeEx.h"
#include <ostream>

namespace XMLIniConverterLib {
namespace IniConverter {

// ��������� ��������� ���������
enum ParameterState {
	PS_EXIST // �������� ���� � �����
	, PS_REMOVED // �������� ����� �� ��������
	, PS_COMMENTED // �������� ���������������
	, PS_OLD // ��������� ����� ��, ��� � ������ ��������
	, PS_NEW // ��������� ����� ��, ��� � ����� ��������
};

// ������ �����
typedef std::vector < std::string > ValuesList;

class Parameter;
typedef ::Core::Var<Parameter> Parameter_var;
typedef ::Core::Var<const Parameter> Parameter_cvar;
// ��������� ��� ������ � ���������� ���-�����
class Parameter
	: virtual public ::Core::IObject
{
public:
	// �������� ���������
	virtual const std::string& get_value () const = 0;

	virtual void set_value (const std::string& value) = 0;

	// ��� ���������
	virtual const std::string& get_name () const = 0;

	// �����������, �� ��������� ���� �����
	virtual const char* get_delimiter () const = 0;

	// ��������� ��������
	virtual ParameterState get_state () const = 0;

	virtual void set_state (ParameterState state) = 0;

	// ������������������ �������� ���������
	virtual const ValuesList& get_commented_values () const = 0;

	// ����� ���������� � ���������� �����
	virtual void print (std::ostream& stream) const = 0;

	// �������� ������������������ ��������
	virtual void add_commented_value (const std::string& value) = 0;
};

/// factory interface for Parameter
class ParameterFactory {
public:
	// �������
	static Parameter* make (const char* name, const char* value, ParameterState state, const char* delimiter)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class Section;
typedef ::Core::Var<Section> Section_var;
typedef ::Core::Var<const Section> Section_cvar;
// ��������� ������ � ������� ���-�����
class Section
	: virtual public ::Core::IObject
{
public:
	// ��� ������
	virtual const std::string& get_name () const = 0;

	// ��������� ������
	virtual ParameterState get_state () const = 0;

	// �������� �������� � ������
	virtual void add_parameter (Parameter* parameter) = 0;

	// ������� �������� �� ������
	virtual void delete_parameter (const char* name) = 0;

	// �������� �������� � �������� ������
	virtual Parameter* get_cached_parameter (const char* name) = 0;

	// ���������� ���������� 2-�� ������ (��, �� ������� ������ �������� ����� ���������, �
	// ���������� ����������� � ��������)
	virtual void merge (Section* section) = 0;

	// ����� ���������� � ���������� �����
	virtual void print (std::ostream& stream) const = 0;
};

/// factory interface for Section
class SectionFactory {
public:
	// �������
	static Section* make (const char* name)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;

	// ������� ��� xml-��� ������
	static Section* make (const char* name, ParameterState state)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class IniFile;
typedef ::Core::Var<IniFile> IniFile_var;
typedef ::Core::Var<const IniFile> IniFile_cvar;
// ��������� ��� ������ � ���-������
class IniFile
	: virtual public ::Core::IObject
{
public:
	// �������� ������ � �������
	virtual void add_section (Section* section) = 0;

	// �������� ������ �� �����
	virtual Section* get_cached_section (const char* name) = 0;

	// �������� �������� �� ������ � �����
	virtual Parameter* get_cached_parameter (const char* section_name, const char* parameter_name) = 0;

	// ������� ������ �� ��������
	virtual void delete_section (const char* name) = 0;

	// ���������� ���������� 2-�� ��������� (���, �� ������� ������ �������� ����� ���������, ���
	// ���������� ����������� � ��������)
	virtual void merge (IniFile* inifile) = 0;

	// ������������� ����������� � ����� (������ � ��� ������, ���� �� ��� �� ����������)
	virtual void set_comment (const std::string& comment) = 0;

	// ����� �������� � �����
	virtual void print (std::ostream& stream) const = 0;
};

/// factory interface for IniFile
class IniFileFactory {
public:
	// �������
	static IniFile* make (const char* filename)
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ������ ������ XML
class BadXMLFormat : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// �� ������ �������� ����������
class CantFindVariable : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

class Rule;
typedef ::Core::Var<Rule> Rule_var;
typedef ::Core::Var<const Rule> Rule_cvar;
// �������, ���������� �� xml
class Rule
	: virtual public ::Core::IObject
{
public:
	// ��������� ������� �� �������� ���-������
	virtual void apply (IniFile* old_file, IniFile* new_file) const = 0;
};

/// factory interface for Rule
class RuleFactory {
public:
	typedef std::vector<std::string> KeySet;
	
	static KeySet* keys ();
public:
	// ������� �������
	static Rule* make (XercesHelpers::DOMNodeEx& rule_node, const char* key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

class RulesManager;
typedef ::Core::Var<RulesManager> RulesManager_var;
typedef ::Core::Var<const RulesManager> RulesManager_cvar;
// �������� ������. ���������� �� �� ����� � ��������� � ����������� �������.
class RulesManager
	: virtual public ::Core::IObject
{
public:
	// ������������� ��������� xml-���� ���������
	virtual void init (const char* filename) /*throw (BadXMLFormat)*/ = 0;

	// ��������� ������ ������ ��� ��������� ��������� ��������.
	virtual void apply (IniFile* old_file, IniFile* new_file) const = 0;

	// �������� ����� �������
	virtual void add_rule (const Rule* rule) = 0;

	// ���������� �������� ����������
	virtual void set_variable (const std::string& name, const std::string& value) = 0;

	// �������� �������� ����������
	virtual const std::string& get_variable_value (const std::string& name) const /*throw (CantFindVariable)*/ = 0;
};

/// factory interface for RulesManager
class RulesManagerFactory {
public:
	// ������� �������� ������
	static RulesManager* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ��������� � ������� ����������
static const std::string UPDATE_PATH = "update_path"; // ���� � ������. ������������  � ������ �������������, �������� � ����� ��� �������������
static const char COMMENT_CHAR = ';'; // ������ �����������
static const char* COMMENT_STRING = ";"; // ������ � �������� �����������

class XMLRuleParser;
typedef ::Core::Var<XMLRuleParser> XMLRuleParser_var;
typedef ::Core::Var<const XMLRuleParser> XMLRuleParser_cvar;
// ��������� ������ �� xml
class XMLRuleParser
	: virtual public ::Core::IObject
{
};

/// factory interface for XMLRuleParser
class XMLRuleParserFactory {
public:
	typedef std::vector<std::string> KeySet;
	
	static KeySet* keys ();
public:
	// ������� ������� �������� �� xml
	static XMLRuleParser* make (RulesManager* manager, XercesHelpers::DOMNodeEx& rule_node, const char* key)
		/*throw (Core::Root::UnknownFactoryKey, Core::Root::FactoryManagerWasDestroyed)*/;
};

// ������ ��� ������ �����
class FileReadingError : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

} // namespace IniConverter
} // namespace XMLIniConverterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <XMLIniConverterLib::IniConverter::Parameter> {
	typedef XMLIniConverterLib::IniConverter::ParameterFactory Factory;
};
template <>
struct TypeTraits <XMLIniConverterLib::IniConverter::Section> {
	typedef XMLIniConverterLib::IniConverter::SectionFactory Factory;
};
template <>
struct TypeTraits <XMLIniConverterLib::IniConverter::IniFile> {
	typedef XMLIniConverterLib::IniConverter::IniFileFactory Factory;
};
template <>
struct TypeTraits <XMLIniConverterLib::IniConverter::Rule> {
	typedef XMLIniConverterLib::IniConverter::RuleFactory Factory;
};
template <>
struct TypeTraits <XMLIniConverterLib::IniConverter::RulesManager> {
	typedef XMLIniConverterLib::IniConverter::RulesManagerFactory Factory;
};
template <>
struct TypeTraits <XMLIniConverterLib::IniConverter::XMLRuleParser> {
	typedef XMLIniConverterLib::IniConverter::XMLRuleParserFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
