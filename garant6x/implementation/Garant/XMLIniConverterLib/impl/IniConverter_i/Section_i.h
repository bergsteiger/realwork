////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Section_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::Section_i
// ��������� ���������� ������ �������� ��� ��������� Section
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_SECTION_I_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_SECTION_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/IniConverter_i.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

class Section_i; // self forward Var
typedef ::Core::Var<Section_i> Section_i_var;
typedef ::Core::Var<const Section_i> Section_i_cvar;

class Section_i_factory;

class Section_i:
	virtual public IniConverter::Section
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Section_i)
	friend class Section_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Section_i (const char* name);

	Section_i (const char* name, IniConverter::ParameterState state);

	virtual ~Section_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	std::string m_name;

	ParameterTable m_parameters;

	IniConverter::ParameterState m_state;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from IniConverter::Section
	// �������� �������� � ������
	virtual void add_parameter (IniConverter::Parameter* parameter);

	// implemented method from IniConverter::Section
	// ������� �������� �� ������
	virtual void delete_parameter (const char* name);

	// implemented method from IniConverter::Section
	// �������� �������� � �������� ������
	virtual IniConverter::Parameter* get_cached_parameter (const char* name);

	// implemented method from IniConverter::Section
	// ���������� ���������� 2-�� ������ (��, �� ������� ������ �������� ����� ���������, �
	// ���������� ����������� � ��������)
	virtual void merge (IniConverter::Section* section);

	// implemented method from IniConverter::Section
	// ��� ������
	virtual const std::string& get_name () const;

	// implemented method from IniConverter::Section
	// ����� ���������� � ���������� �����
	virtual void print (std::ostream& stream) const;

	// implemented method from IniConverter::Section
	// ��������� ������
	virtual IniConverter::ParameterState get_state () const;
}; // class Section_i

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_SECTION_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
