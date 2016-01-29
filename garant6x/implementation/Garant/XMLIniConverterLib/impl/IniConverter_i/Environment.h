////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Environment.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Environment::Class>> garant6x::XMLIniConverterLib::IniConverter_i::Converters
//
// Конвертеры типов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_CONVERTERS_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_CONVERTERS_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *45C08B5601C5_CUSTOM_INCLUDES*
#include "shared/Core/data/UnsortedTypeConverter.h"

#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"

namespace XMLIniConverterLib {
namespace IniConverter {
	class ParameterStateConverter : 
		public Core::UnsortedTypeConverter<const char*, ParameterState, Core::ConstCharIsEqual> {
	protected:
		void fill_array  () {
			this->add ("new", IniConverter::PS_NEW);
			this->add ("old", IniConverter::PS_OLD);
			this->add ("removed", IniConverter::PS_REMOVED);
			this->add ("commented", IniConverter::PS_COMMENTED);
			this->add ("exist", IniConverter::PS_EXIST);
		}
	};

	typedef ACE_Singleton<ParameterStateConverter, ACE_SYNCH_NULL_MUTEX> PSConverterSingleton;
}
};
//#UC END# *45C08B5601C5_CUSTOM_INCLUDES*
namespace XMLIniConverterLib {
namespace IniConverter_i {

class Environment;

class Environment_i {
	friend class Environment;
	

private:
	typedef ACE_Singleton<Environment_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton<Environment_i, ACE_SYNCH_RECURSIVE_MUTEX>;

private:
}; // class Environment_i

class Environment {
public:}; // class Environment

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_CONVERTERS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
