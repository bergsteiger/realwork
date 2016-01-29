////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/FunctionalTest_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::BuildTestLib::OnBuildDone::FunctionalTest_i
//
// FunctionalTest_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/BuildTestLib/LibHome.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/FunctionalTest_i.h"

namespace BuildTestLib {
namespace OnBuildDone {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

FunctionalTest_i::FunctionalTest_i ()
//#UC START# *4C878D4E02C4_4C90C74B0101_4C9200830056_BASE_INIT*
: m_passed (0)
, m_duration (0.0)
//#UC END# *4C878D4E02C4_4C90C74B0101_4C9200830056_BASE_INIT*
{
	//#UC START# *4C878D4E02C4_4C90C74B0101_4C9200830056_BODY*
	LOG_I (("%s ()", GDS_CURRENT_FUNCTION));
	//#UC END# *4C878D4E02C4_4C90C74B0101_4C9200830056_BODY*
}

FunctionalTest_i::~FunctionalTest_i () {
	//#UC START# *4C9200830056_DESTR_BODY*
	LOG_I (("%s ()", GDS_CURRENT_FUNCTION));
	//#UC END# *4C9200830056_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from TestResults::FunctionalTest
// продолжительность теста в секундах
CORBA::Double FunctionalTest_i::get_duration ()
	throw (CORBA::SystemException)
{
	//#UC START# *4C90C2A001B6_4C9200830056_GET*
	return m_duration;
	//#UC END# *4C90C2A001B6_4C9200830056_GET*
}

void FunctionalTest_i::set_duration (CORBA::Double duration)
	throw (CORBA::SystemException)
{
	//#UC START# *4C90C2A001B6_4C9200830056_SET*
	m_duration = duration;
	//#UC END# *4C90C2A001B6_4C9200830056_SET*
}

// implemented method from TestResults::FunctionalTest
// ошибки теста, например в sahi - "did not complete in NNN seconds"
char* FunctionalTest_i::get_errors ()
	throw (CORBA::SystemException)
{
	//#UC START# *4C90C2CA00B8_4C9200830056_GET*
	return const_cast <char *> (m_errors.data ());
	//#UC END# *4C90C2CA00B8_4C9200830056_GET*
}

void FunctionalTest_i::set_errors (const char* errors)
	throw (CORBA::SystemException)
{
	//#UC START# *4C90C2CA00B8_4C9200830056_SET*
	m_errors = errors;
	//#UC END# *4C90C2CA00B8_4C9200830056_SET*
}

// implemented method from TestResults::FunctionalTest
// предупреждения - в sahi есть такое опнятие например
char* FunctionalTest_i::get_exceptions ()
	throw (CORBA::SystemException)
{
	//#UC START# *4C90C25702B8_4C9200830056_GET*
	return const_cast <char *> (m_exceptions.data ());
	//#UC END# *4C90C25702B8_4C9200830056_GET*
}

void FunctionalTest_i::set_exceptions (const char* exceptions)
	throw (CORBA::SystemException)
{
	//#UC START# *4C90C25702B8_4C9200830056_SET*
	m_exceptions = exceptions;
	//#UC END# *4C90C25702B8_4C9200830056_SET*
}

// implemented method from TestResults::Test
// ссылка в К на описание теста (скорее всего id страницы описания)
char* FunctionalTest_i::get_description_link ()
	throw (CORBA::SystemException)
{
	//#UC START# *4C878D7902DD_4C9200830056_GET*
	return const_cast <char *> (m_description_link.data ());
	//#UC END# *4C878D7902DD_4C9200830056_GET*
}

void FunctionalTest_i::set_description_link (const char* description_link)
	throw (CORBA::SystemException)
{
	//#UC START# *4C878D7902DD_4C9200830056_SET*
	m_description_link = description_link;
	//#UC END# *4C878D7902DD_4C9200830056_SET*
}

// implemented method from TestResults::Test
// extra_data
TestResults::ExtraDataArray* FunctionalTest_i::get_extra_data ()
	throw (CORBA::SystemException)
{
	//#UC START# *4CD9407C02A0_4C9200830056_GET*
	char* buf [1000];
	GDS_ASSERT (m_extra_data.size () <= 1000);
	for (CORBA::ULong i = 0; i < m_extra_data.size (); ++i) {
		buf [i] = const_cast <char *> (m_extra_data [i].c_str ());
	}
	TestResults::ExtraDataArray_var result = new TestResults::ExtraDataArray (1000, m_extra_data.size (), buf, 0);
	return result._retn ();
	//#UC END# *4CD9407C02A0_4C9200830056_GET*
}

void FunctionalTest_i::set_extra_data (const TestResults::ExtraDataArray& extra_data)
	throw (CORBA::SystemException)
{
	//#UC START# *4CD9407C02A0_4C9200830056_SET*
	m_extra_data.clear ();
	for (CORBA::ULong i = 0; i < extra_data.length (); ++i) {
		m_extra_data.push_back (extra_data [i].in ());
	}
	//#UC END# *4CD9407C02A0_4C9200830056_SET*
}

// implemented method from TestResults::Test
// путь-имя лог-файла для подцепления в аттач
char* FunctionalTest_i::get_log_file ()
	throw (CORBA::SystemException)
{
	//#UC START# *4C878DD0005F_4C9200830056_GET*
	return const_cast <char *> (m_log_file.data ());
	//#UC END# *4C878DD0005F_4C9200830056_GET*
}

void FunctionalTest_i::set_log_file (const char* log_file)
	throw (CORBA::SystemException)
{
	//#UC START# *4C878DD0005F_4C9200830056_SET*
	m_log_file = log_file;
	//#UC END# *4C878DD0005F_4C9200830056_SET*
}

// implemented method from TestResults::Test
// название теста
char* FunctionalTest_i::get_name ()
	throw (CORBA::SystemException)
{
	//#UC START# *4C878D1B0152_4C9200830056_GET*
	return const_cast <char *> (m_name.data ());
	//#UC END# *4C878D1B0152_4C9200830056_GET*
}

void FunctionalTest_i::set_name (const char* name)
	throw (CORBA::SystemException)
{
	//#UC START# *4C878D1B0152_4C9200830056_SET*
	m_name = name;
	//#UC END# *4C878D1B0152_4C9200830056_SET*
}

// implemented method from TestResults::Test
// признак прошел тест/не прошел
CORBA::Boolean FunctionalTest_i::get_passed ()
	throw (CORBA::SystemException)
{
	//#UC START# *4C878D360210_4C9200830056_GET*
	return m_passed;
	//#UC END# *4C878D360210_4C9200830056_GET*
}

void FunctionalTest_i::set_passed (CORBA::Boolean passed)
	throw (CORBA::SystemException)
{
	//#UC START# *4C878D360210_4C9200830056_SET*
	m_passed = passed;
	//#UC END# *4C878D360210_4C9200830056_SET*
}
} // namespace OnBuildDone
} // namespace BuildTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

