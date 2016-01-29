////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/BuildListener_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::BuildTestLib::OnBuildDone::BuildListener_i
// Заголовок реализации класса серванта для интерфеса BuildListner
//
// ждет события окончания сборки, по приходу события копирует файлв сборки в локальное место,
// запускает тестовый сценарий
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_BUILDLISTENER_I_H__
#define __MDPROCESS_BUILDTESTLIB_ONBUILDDONE_BUILDLISTENER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include "shared/GCL/data/std_defs.h"
#include "MDProcess/ServerGate/Comm/Comm.h"
#include "MDProcess/ServerGate/Comm/CommS.h"

namespace BuildTestLib {
namespace OnBuildDone {

class BuildListener_i; // self forward Var
typedef ::Core::Var<BuildListener_i> BuildListener_i_var;
typedef ::Core::Var<const BuildListener_i> BuildListener_i_cvar;

class BuildListener_i_factory;

// ждет события окончания сборки, по приходу события копирует файлв сборки в локальное место,
// запускает тестовый сценарий
class BuildListener_i:
	virtual public POA_ServerGate::Comm::BuildListner
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (BuildListener_i)
	friend class BuildListener_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// StringVectorMap
	typedef std::map < std::string, GCL::StrVector > StringVectorMap;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	BuildListener_i ();

	virtual ~BuildListener_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// асинхронно запускает тесты только что завершившейся сборки
	/*oneway*/ Core::ThreadHandle build_success_async (const std::string& cur_build_path);

	// проверяет есть ли тестовые скрипты в директории сборки
	virtual CORBA::Boolean check_scripts (const std::string& root_dir, GCL::StrVector& found_scripts);

	// копирует файлы сборки из удаленного места на локальное, если
	// сборка подлежит тестированию
	virtual CORBA::Boolean copy_files (const std::string& from_path, const std::string& to_path);

	// запускает один скрипт по полному пути-имени
	virtual void run_script (const std::string& path_prefix, const std::string& path_name) const;

	// запускает (тестировочные) скрипты для тех <<ExeTarget>> где они определены
	virtual void run_scripts (const std::string& path_prefix, const GCL::StrVector& found_scripts) const;

//////////////////////////////////////////////////////////////////////////////////////////
// oneway methods impl
private:
	static void thr_build_success_async_ (void* arg);

protected:
	virtual void build_success_async_ (const std::string& cur_build_path);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// скрипты которые надо запустить
	StringVectorMap m_scripts_to_run;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ServerGate::Comm::BuildListner
	// сигнал о том что сборка завершена. Вызывает сигнал сервер MDP в качестве параметра передается
	// интерфейс ндлс джоступа к странице сборки
	virtual void build_success (
		ServerGate::Contents::KPage* build_page
		, const char* build_path
		, CORBA::Boolean is_modified
	) throw (
		CORBA::SystemException
	);
}; // class BuildListener_i

} // namespace OnBuildDone
} // namespace BuildTestLib


#endif //__MDPROCESS_BUILDTESTLIB_ONBUILDDONE_BUILDLISTENER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
