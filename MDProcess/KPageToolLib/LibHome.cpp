////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/KPageToolLib/LibHome.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> MDProcess::KPageToolLib
//
// �������� ������ ������/������ �������� � �.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "boost/lexical_cast.hpp"
#include "shared/Core/Params/Params.h"
#include "MDProcess/KPageToolLib/LibHome.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/GetTextAction_factory.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/SetTextAction_factory.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/AppendTextAction_factory.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/AddAttachmentAction_factory.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/GetLabelAction_factory.h"
#include "MDProcess/KPageToolLib/impl/ActionsImpl/SetLabelAction_factory.h"
#include "MDProcess/KPageToolLib/Actions/Actions.h"
#include "MDProcess/KPageToolLib/Executor.h"

namespace KPageToolLib {

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
				LOG_E (("�������� �������� ��������� %s: %s", key, value.c_str ()));
			}
		} else if (is_requared) {
			res = false;
			LOG_E(("�� ����� ������������ ��������: %s", key));
		}
		
		return res;
	}
	
	template <>
	bool check_param<std::string> (const char* key, bool is_requared) {
		if (is_requared && !Core::ParamManagerFactory::get ().is_exist (key)) {
			LOG_E(("�� ����� ������������ �������� <%s>", key));
			return false;
		}
		return true;
	}
	
	template <>
	bool check_param<Actions::PageActionsEnum> (const char* key, bool is_requared) {
		bool res = true;
		if (Core::ParamManagerFactory::get ().is_exist (key)) {
			res = false;
			std::string value = Core::ParamManagerFactory::get ().get_string (key);
			res |= value == "PA_GET";
			res |= value == "PA_SET";
			res |= value == "PA_APPEND";
			res |= value == "PA_ATTACH";
			res |= value == "PA_GET_LABEL";
			res |= value == "PA_SET_LABEL";
			if (!res) {
				LOG_E (("�������� �������� ��������� %s: %s", key, value.c_str ()));
			}
		} else if (is_requared) {
			res = false;
			LOG_E(("�� ����� ������������ ��������: %s", key));
		}
		return res;
	}
} //namespace

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
	this->get_executors ().insert (&Executor::get ());
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *48E496AE01DE_ENVIRONMENTS_CONFIG*
	//#UC END# *48E496AE01DE_ENVIRONMENTS_CONFIG*

	{
		ActionsImpl::GetTextAction_factory_var fctr = new ActionsImpl::GetTextAction_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ActionsImpl::SetTextAction_factory_var fctr = new ActionsImpl::SetTextAction_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ActionsImpl::AppendTextAction_factory_var fctr = new ActionsImpl::AppendTextAction_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ActionsImpl::AddAttachmentAction_factory_var fctr = new ActionsImpl::AddAttachmentAction_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ActionsImpl::GetLabelAction_factory_var fctr = new ActionsImpl::GetLabelAction_factory ();
		fctr->registrate_me(0);
	}
	
	{
		ActionsImpl::SetLabelAction_factory_var fctr = new ActionsImpl::SetLabelAction_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void LibHomeImpl::finalize () {
}
	
void LibHomeImpl::print_usage () const {
	std::cout << "-login: (a-string)       - ����� ��� ����������� �� ������ �\n";

	std::cout << "-password: (a-string)    - ������ ��� ����������� �� ������� �\n";

	std::cout << "-operation: (PageActionsEnum: PA_GET, PA_SET, PA_APPEND, PA_ATTACH,\n";
	std::cout << "                         PA_GET_LABEL, PA_SET_LABEL) - ��������, �������\n";
	std::cout << "                         ����� ���������, �������� �������, ����������� �\n";
	std::cout << "                         ��������� �������������� � ������������,\n";
	std::cout << "                         ��������� �� ������������ �������� � ����\n";
	std::cout << "                         ���������.\n";

	std::cout << "-page_id: (unsigned long)- ID ��������, �������� ����� ���������\n";

	std::cout << "-file: (a-string)        - ���� �� �����, ����������� ������ ���\n";
	std::cout << "                         ���������� �������\n";


}

bool LibHomeImpl::check_params () const {
	bool res = check_param<std::string> ("-login", false);
	res &= check_param<std::string> ("-password", false);
	res &= check_param<Actions::PageActionsEnum> ("-operation", false);
	res &= check_param<unsigned long> ("-page_id", false);
	res &= check_param<std::string> ("-file", false);

	return res;
}
} // namespace KPageToolLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
