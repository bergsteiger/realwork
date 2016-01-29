////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/IniFile_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::XMLIniConverterLib::IniConverter_i::IniFile_i
// Заголовк реализации фабрик интерфеса IniFile для серванта IniFile_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_INIFILE_I_FCTR_H__
#define __GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_INIFILE_I_FCTR_H__

#include "shared/Core/sys/std_inc.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverterFactories.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/IniConverter_i.h"

namespace XMLIniConverterLib {
namespace IniConverter_i {

/// Interface-factory implementation for IniFile_i
class IniFile_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public IniConverter::IniFileAbstractFactory
{
public:
	IniFile_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	IniConverter::IniFile* make (const char* filename);

};

typedef ::Core::Var<IniFile_i_factory> IniFile_i_factory_var;

} // namespace IniConverter_i
} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_INICONVERTER_I_INIFILE_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

