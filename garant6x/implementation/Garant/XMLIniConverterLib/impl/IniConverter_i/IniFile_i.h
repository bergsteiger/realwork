////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/IniFile_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::IniFile_i
// ��������� ���������� ������ �������� ��� ��������� IniFile
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_INIFILE_I_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_INIFILE_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/IniConverter_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

class IniFile_i; // self forward Var
typedef ::Core::Var<IniFile_i> IniFile_i_var;
typedef ::Core::Var<const IniFile_i> IniFile_i_cvar;

class IniFile_i_factory;

class IniFile_i:
	virtual public IniConverter::IniFile
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (IniFile_i)
	friend class IniFile_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	IniFile_i (const char* filename);

	virtual ~IniFile_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// �������� �����������
	virtual void add_comment (const std::string& buffer);

	// �������� ��������
	virtual void add_parameter (const std::string& buffer, IniConverter::ParameterState state);

	// �������� ������
	virtual void add_section (const std::string& buffer);

	// ��������� ��������� ������ �� ini �����
	virtual void add_string (const std::string& buffer);

	// ��������� ������ �� ��� � �������� ���������
	virtual void get_name_and_value_by_string (
		const std::string& buffer
		, const std::string& delimiter
		, std::string& name
		, std::string& value
	) const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	IniConverter::Section_var m_current_section;

	// ����������� � ������ �����
	std::string m_file_comment;

	const char* m_file_name;

	SectionTable m_sections;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from IniConverter::IniFile
	// �������� ������ � �������
	virtual void add_section (IniConverter::Section* section);

	// implemented method from IniConverter::IniFile
	// ������� ������ �� ��������
	virtual void delete_section (const char* name);

	// implemented method from IniConverter::IniFile
	// �������� �������� �� ������ � �����
	virtual IniConverter::Parameter* get_cached_parameter (const char* section_name, const char* parameter_name);

	// implemented method from IniConverter::IniFile
	// �������� ������ �� �����
	virtual IniConverter::Section* get_cached_section (const char* name);

	// implemented method from IniConverter::IniFile
	// ���������� ���������� 2-�� ��������� (���, �� ������� ������ �������� ����� ���������, ���
	// ���������� ����������� � ��������)
	virtual void merge (IniConverter::IniFile* inifile);

	// implemented method from IniConverter::IniFile
	// ����� �������� � �����
	virtual void print (std::ostream& stream) const;

	// implemented method from IniConverter::IniFile
	// ������������� ����������� � ����� (������ � ��� ������, ���� �� ��� �� ����������)
	virtual void set_comment (const std::string& comment);
}; // class IniFile_i

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_INIFILE_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
