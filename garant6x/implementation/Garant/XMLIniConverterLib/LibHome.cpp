////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> garant6x::XMLIniConverterLib
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "garant6x/implementation/Garant/XMLIniConverterLib/LibHome.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Parameter_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/Section_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/IniFile_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/SectionStateRule_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/StateParser_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/ValueRule_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RenameParser_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RenameRule_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/DequoteParser_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/ParameterStateRule_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/ValueParser_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/DequoteRule_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/VariableParser_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/VariableRule_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/impl/IniConverter_i/RulesManager_i_factory.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/ConverterStarter.h"

namespace XMLIniConverterLib {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
	this->get_executors ().insert (&ConverterStarter::get ());
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *45E43EE50128_ENVIRONMENTS_CONFIG*
	//#UC END# *45E43EE50128_ENVIRONMENTS_CONFIG*

	{
		IniConverter_i::Parameter_i_factory_var fctr = new IniConverter_i::Parameter_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		IniConverter_i::Section_i_factory_var fctr = new IniConverter_i::Section_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		IniConverter_i::IniFile_i_factory_var fctr = new IniConverter_i::IniFile_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		IniConverter_i::SectionStateRule_i_factory_var fctr = new IniConverter_i::SectionStateRule_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		IniConverter_i::StateParser_i_factory_var fctr = new IniConverter_i::StateParser_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		IniConverter_i::ValueRule_i_factory_var fctr = new IniConverter_i::ValueRule_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		IniConverter_i::RenameParser_i_factory_var fctr = new IniConverter_i::RenameParser_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		IniConverter_i::RenameRule_i_factory_var fctr = new IniConverter_i::RenameRule_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		IniConverter_i::DequoteParser_i_factory_var fctr = new IniConverter_i::DequoteParser_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		IniConverter_i::ParameterStateRule_i_factory_var fctr = new IniConverter_i::ParameterStateRule_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		IniConverter_i::ValueParser_i_factory_var fctr = new IniConverter_i::ValueParser_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		IniConverter_i::DequoteRule_i_factory_var fctr = new IniConverter_i::DequoteRule_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		IniConverter_i::VariableParser_i_factory_var fctr = new IniConverter_i::VariableParser_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		IniConverter_i::VariableRule_i_factory_var fctr = new IniConverter_i::VariableRule_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		IniConverter_i::RulesManager_i_factory_var fctr = new IniConverter_i::RulesManager_i_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void LibHomeImpl::finalize () {
}
} // namespace XMLIniConverterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
