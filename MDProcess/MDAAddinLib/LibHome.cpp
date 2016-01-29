////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/LibHome.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> MDProcess::MDAAddinLib
//
// бибилиотека классов для работы плагина к Rose
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "boost/lexical_cast.hpp"
#include "shared/Core/Params/Params.h"
#include "MDProcess/MDAAddinLib/LibHome.h"
#include "MDProcess/MDAAddinLib/impl/MDACommands/MDACmdManager_factory.h"
#include "MDProcess/MDAAddinLib/impl/MDACommands/DblClickActionImpl_factory.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/MDPFacadeSrv_factory.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CatLockerSrv_factory.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CatsContainerImpl_factory.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/CatLockerFacadeImpl_factory.h"
#include "MDProcess/MDAAddinLib/impl/HelpersImpl/StereotypeManagerImpl_factory.h"
#include "MDProcess/MDAAddinLib/impl/HelpersImpl/KViewElementImpl_factory.h"
#include "MDProcess/MDAAddinLib/impl/HelpersImpl/ReportBuilderImpl_factory.h"

namespace MDAAddinLib {

namespace {
	template <typename T>
	bool check_param (const char* key, bool is_requared) {
		bool res = true;
		if (Core::ParamManagerFactory::get ().is_exist (key)) {
			std::string value = Core::ParamManagerFactory::get ().get_string (key);
			try {
				boost::lexical_cast<T> (value);
			} catch (boost::bad_lexical_cast&) {
				res = false;
				LOG_E (("Неверное значение параметра %s: %s", key, value.c_str ()));
			}
		} else if (is_requared) {
			res = false;
			LOG_E(("Не задан обязательный параметр: %s", key));
		}
		
		return res;
	}
	
	template <>
	bool check_param<std::string> (const char* key, bool is_requared) {
		if (is_requared && !Core::ParamManagerFactory::get ().is_exist (key)) {
			LOG_E(("Не задан обязательный параметр <%s>", key));
			return false;
		}
		return true;
	}
	
} //namespace

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *456C157B0186_ENVIRONMENTS_CONFIG*
	//#UC END# *456C157B0186_ENVIRONMENTS_CONFIG*

	{
		MDACommands::MDACmdManager_factory_var fctr = new MDACommands::MDACmdManager_factory ();
		fctr->registrate_me(0);
	}
	
	{
		MDACommands::DblClickActionImpl_factory_var fctr = new MDACommands::DblClickActionImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		MDPFacadeSrv_factory_var fctr = new MDPFacadeSrv_factory ();
		fctr->registrate_me(0);
	}
	
	{
		CatLockerSrv_factory_var fctr = new CatLockerSrv_factory ();
		fctr->registrate_me(0);
	}
	
	{
		CatsContainerImpl_factory_var fctr = new CatsContainerImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		CatLockerFacadeImpl_factory_var fctr = new CatLockerFacadeImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		HelpersImpl::StereotypeManagerImpl_factory_var fctr = new HelpersImpl::StereotypeManagerImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		HelpersImpl::KViewElementImpl_factory_var fctr = new HelpersImpl::KViewElementImpl_factory ();
		fctr->registrate_me(0);
	}
	
	{
		HelpersImpl::ReportBuilderImpl_factory_var fctr = new HelpersImpl::ReportBuilderImpl_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void LibHomeImpl::finalize () {
}
	
void LibHomeImpl::print_usage () const {
	std::cout << "-ClassDblClickAction: (string) - ключ настроек определяющий действие при\n";
	std::cout << "                         дабл-клике на классе\n";
	std::cout << "                         = OPEN_DIAGRAM_IF_EXISTS_ELSE_PROPERTIES\n";
	std::cout << "-PackageDblClickAction: (string) - ключ настроек определяющий действие при\n";
	std::cout << "                         дабл-клике на пакете\n";
	std::cout << "                         = OPEN_DIAGRAM\n";
	std::cout << "-LogFile: (string)       - путь к лог-файлу\n";
	std::cout << "                         = C:\\Program\n";
	std::cout << "                         Files\\Rational\\Rose\\Garant\\MDAGenerator\\MDAGen\n";
	std::cout << "                         erator.log\n";
	std::cout << "-TooltipInitialDelay: (unsigned long) - время задержки в мс. перед показом\n";
	std::cout << "                         всплывающей подсказки\n";
	std::cout << "                         = 3000\n";
	std::cout << "-external_command_path: (a-string) - путь к внешнему приложению, которое\n";
	std::cout << "                         должно быть запущено\n";
	std::cout << "                         = EMPTY_STR\n";
	std::cout << "-saved_mdp_login: (string)= EMPTY_STR\n";
	std::cout << "-saved_mdp_paswd: (string)= EMPTY_STR\n";
	std::cout << "-use_saved_mdp_auth: (unsigned long)= 0\n";
	std::cout << "-CanAssociationRelocate: (boolean)= false\n";
	std::cout << "-MDASave: (boolean)= false\n";
	std::cout << "-KLink: (string)         - ссылка K\n";
	std::cout << "                         = http://mdp.garant.ru\n";

}

bool LibHomeImpl::check_params () const {
	bool res = check_param<std::string> ("-ClassDblClickAction", false);
	res &= check_param<std::string> ("-PackageDblClickAction", false);
	res &= check_param<std::string> ("-LogFile", false);
	res &= check_param<unsigned long> ("-TooltipInitialDelay", false);
	res &= check_param<std::string> ("-external_command_path", false);
	res &= check_param<std::string> ("-saved_mdp_login", false);
	res &= check_param<std::string> ("-saved_mdp_paswd", false);
	res &= check_param<unsigned long> ("-use_saved_mdp_auth", false);
	res &= check_param<unsigned long> ("-CanAssociationRelocate", false);
	res &= check_param<unsigned long> ("-MDASave", false);
	res &= check_param<std::string> ("-KLink", false);

	return res;
}
} // namespace MDAAddinLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
