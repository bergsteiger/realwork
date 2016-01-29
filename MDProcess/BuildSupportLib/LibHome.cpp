////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/BuildSupportLib/LibHome.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> MDProcess::BuildSupportLib
//
// ���������� ��������� ������ �� �������� � ����������, � ��������� �� ���������� ������� ant.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "boost/lexical_cast.hpp"
#include "shared/Core/Params/Params.h"
#include "MDProcess/BuildSupportLib/LibHome.h"
#include "MDProcess/BuildSupportLib/Run.h"

namespace BuildSupportLib {

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
	
} //namespace

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
	this->get_executors ().insert (&Run::get ());
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *47D68BDE0153_ENVIRONMENTS_CONFIG*
	//#UC END# *47D68BDE0153_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
	
void LibHomeImpl::print_usage () const {
	std::cout << "-login: (a-string)       - ����� ������������, �� ����� ��������\n";
	std::cout << "                         �������� ������\n";

	std::cout << "-paswd: (a-string)       - ������ ������������\n";

	std::cout << "-event: (a-string)       - ��� ������� (start, done ��� failure)\n";

	std::cout << "-project: (a-string)     - ���� ������ (MDP, NST � �.�.)\n";

	std::cout << "-tag: (a-string)         - ��� ����, ���������� �� �������\n";

	std::cout << "-build: (a-string)       - ����� ������\n";

	std::cout << "-branch: (a-string)      - ����� �����, 0 - ��������� ���\n";
	std::cout << "                         = 0\n";
	std::cout << "-build_path: (string)    - ���� � ������\n";
	std::cout << "                         = EMPTY_STR\n";
	std::cout << "-build_log: (string)     - ��� ����� � ����� ������\n";
	std::cout << "                         = EMPTY_STR\n";

}

bool LibHomeImpl::check_params () const {
	bool res = check_param<std::string> ("-login", false);
	res &= check_param<std::string> ("-paswd", false);
	res &= check_param<std::string> ("-event", false);
	res &= check_param<std::string> ("-project", false);
	res &= check_param<std::string> ("-tag", false);
	res &= check_param<std::string> ("-build", false);
	res &= check_param<std::string> ("-branch", false);
	res &= check_param<std::string> ("-build_path", false);
	res &= check_param<std::string> ("-build_log", false);

	return res;
}
} // namespace BuildSupportLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
