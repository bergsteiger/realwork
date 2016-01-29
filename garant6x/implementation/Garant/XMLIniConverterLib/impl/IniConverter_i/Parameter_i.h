////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Parameter_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::Parameter_i
// Заголовок реализации класса серванта для интерфеса Parameter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_PARAMETER_I_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_PARAMETER_I_H__

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

class Parameter_i; // self forward Var
typedef ::Core::Var<Parameter_i> Parameter_i_var;
typedef ::Core::Var<const Parameter_i> Parameter_i_cvar;

class Parameter_i_factory;

class Parameter_i:
	virtual public IniConverter::Parameter
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (Parameter_i)
	friend class Parameter_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	Parameter_i (const char* name, const char* value, IniConverter::ParameterState state, const char* delimiter);

	virtual ~Parameter_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	IniConverter::ValuesList m_commented_values;

	std::string m_delimiter;

	std::string m_name;

	IniConverter::ParameterState m_state;

	std::string m_value;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from IniConverter::Parameter
	// добавить закомментированное значение
	virtual void add_commented_value (const std::string& value);

	// implemented method from IniConverter::Parameter
	// закомментированные значения параметра
	virtual const IniConverter::ValuesList& get_commented_values () const;

	// implemented method from IniConverter::Parameter
	// разделитель, по умолчанию знак равно
	virtual const char* get_delimiter () const;

	// implemented method from IniConverter::Parameter
	// имя параметра
	virtual const std::string& get_name () const;

	// implemented method from IniConverter::Parameter
	// вывод информации в отладочных целях
	virtual void print (std::ostream& stream) const;

	// implemented method from IniConverter::Parameter
	// состояние парметра
	virtual IniConverter::ParameterState get_state () const;

	virtual void set_state (IniConverter::ParameterState state);

	// implemented method from IniConverter::Parameter
	// значение параметра
	virtual const std::string& get_value () const;

	virtual void set_value (const std::string& value);
}; // class Parameter_i

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_PARAMETER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
