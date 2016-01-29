////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/FunctionalTest_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::BuildTestLib::OnBuildDone::FunctionalTest_i
// Заголовок реализации класса серванта для интерфеса FunctionalTest
//
// FunctionalTest_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_FUNCTIONALTEST_I_H__
#define __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_FUNCTIONALTEST_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCL/data/std_defs.h"
#include "MDProcess/BuildTestLib/TestResults/TestResults.h"
#include "MDProcess/BuildTestLib/TestResults/TestResultsS.h"

namespace BuildTestLib {
namespace OnBuildDone {

class FunctionalTest_i; // self forward Var
typedef ::Core::Var<FunctionalTest_i> FunctionalTest_i_var;
typedef ::Core::Var<const FunctionalTest_i> FunctionalTest_i_cvar;

class FunctionalTest_i_factory;

// FunctionalTest_i
class FunctionalTest_i:
	virtual public POA_BuildTestLib::TestResults::FunctionalTest
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (FunctionalTest_i)
	friend class FunctionalTest_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FunctionalTest_i ();

	virtual ~FunctionalTest_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	std::string m_description_link;

	CORBA::Double m_duration;

	std::string m_errors;

	std::string m_exceptions;

	GCL::StrVector m_extra_data;

	std::string m_log_file;

	std::string m_name;

	CORBA::Boolean m_passed;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from TestResults::FunctionalTest
	// продолжительность теста в секундах
	virtual CORBA::Double get_duration ()
		throw (CORBA::SystemException);

	virtual void set_duration (CORBA::Double duration)
		throw (CORBA::SystemException);

	// implemented method from TestResults::FunctionalTest
	// ошибки теста, например в sahi - "did not complete in NNN seconds"
	virtual char* get_errors ()
		throw (CORBA::SystemException);

	virtual void set_errors (const char* errors)
		throw (CORBA::SystemException);

	// implemented method from TestResults::FunctionalTest
	// предупреждения - в sahi есть такое опнятие например
	virtual char* get_exceptions ()
		throw (CORBA::SystemException);

	virtual void set_exceptions (const char* exceptions)
		throw (CORBA::SystemException);

	// implemented method from TestResults::Test
	// ссылка в К на описание теста (скорее всего id страницы описания)
	virtual char* get_description_link ()
		throw (CORBA::SystemException);

	virtual void set_description_link (const char* description_link)
		throw (CORBA::SystemException);

	// implemented method from TestResults::Test
	// extra_data
	virtual TestResults::ExtraDataArray* get_extra_data ()
		throw (CORBA::SystemException);

	virtual void set_extra_data (const TestResults::ExtraDataArray& extra_data)
		throw (CORBA::SystemException);

	// implemented method from TestResults::Test
	// путь-имя лог-файла для подцепления в аттач
	virtual char* get_log_file ()
		throw (CORBA::SystemException);

	virtual void set_log_file (const char* log_file)
		throw (CORBA::SystemException);

	// implemented method from TestResults::Test
	// название теста
	virtual char* get_name ()
		throw (CORBA::SystemException);

	virtual void set_name (const char* name)
		throw (CORBA::SystemException);

	// implemented method from TestResults::Test
	// признак прошел тест/не прошел
	virtual CORBA::Boolean get_passed ()
		throw (CORBA::SystemException);

	virtual void set_passed (CORBA::Boolean passed)
		throw (CORBA::SystemException);
}; // class FunctionalTest_i

} // namespace OnBuildDone
} // namespace BuildTestLib


#endif //__MDPROCESS_BUILDTESTLIB_ONBUILDDONE_FUNCTIONALTEST_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
