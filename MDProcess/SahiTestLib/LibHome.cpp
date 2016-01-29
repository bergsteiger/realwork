////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/SahiTestLib/LibHome.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> MDProcess::SahiTestLib
//
// ����������, �������������� ���������� ������ sahi � ������ ���������� ������������ ������ ������
// � �������� ����������� ������ ������� ������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "boost/lexical_cast.hpp"
#include "shared/Core/Params/Params.h"
#include "MDProcess/SahiTestLib/LibHome.h"
#include "MDProcess/SahiTestLib/TestExecutor.h"

namespace SahiTestLib {

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
	this->get_executors ().insert (&TestExecutor::get ());
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *4C878C5002A6_ENVIRONMENTS_CONFIG*
	//#UC END# *4C878C5002A6_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
	
void LibHomeImpl::print_usage () const {
	std::cout << "-bat_file_path: (a-string) - bat-���� ����������� ����� sahi\n";

	std::cout << "-text_file_path: (a-string) - ���������� ������ sahi � ��������� �����\n";

	std::cout << "-prefix_path: (a-string) - �������� ���� � ������, ��� ����� ����������\n";
	std::cout << "                         ������ � �� ��������� ����\n";


}

bool LibHomeImpl::check_params () const {
	bool res = check_param<std::string> ("-bat_file_path", false);
	res &= check_param<std::string> ("-text_file_path", false);
	res &= check_param<std::string> ("-prefix_path", false);

	return res;
}
} // namespace SahiTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
