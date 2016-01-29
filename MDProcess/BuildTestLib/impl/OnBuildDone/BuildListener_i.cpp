////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/BuildTestLib/impl/OnBuildDone/BuildListener_i.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::BuildTestLib::OnBuildDone::BuildListener_i
//
// ждет события окончания сборки, по приходу события копирует файлв сборки в локальное место,
// запускает тестовый сценарий
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/BuildTestLib/LibHome.h"
#include "MDProcess/BuildTestLib/impl/OnBuildDone/BuildListener_i.h"
// by <<uses>> dependencies
#include "MDProcess/BuildTestLib/impl/OnBuildDone/ListenerParams.h"
#include "boost/filesystem/operations.hpp"
#include "boost/filesystem/path.hpp"
#include "shared/GCL/data/std_defs.h"
#include "boost/lexical_cast.hpp"

namespace BuildTestLib {
namespace OnBuildDone {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

BuildListener_i::BuildListener_i ()
//#UC START# *47EA43D801F0_47EA50F2007F_4C878F1F0394_BASE_INIT*
//#UC END# *47EA43D801F0_47EA50F2007F_4C878F1F0394_BASE_INIT*
{
	//#UC START# *47EA43D801F0_47EA50F2007F_4C878F1F0394_BODY*
	LOG_I (("%s ()", GDS_CURRENT_FUNCTION));
	//#UC END# *47EA43D801F0_47EA50F2007F_4C878F1F0394_BODY*
}

BuildListener_i::~BuildListener_i () {
	//#UC START# *4C878F1F0394_DESTR_BODY*
	LOG_I (("%s ()", GDS_CURRENT_FUNCTION));
	//#UC END# *4C878F1F0394_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// асинхронно запускает тесты только что завершившейся сборки
void BuildListener_i::build_success_async_ (const std::string& cur_build_path) {
	//#UC START# *4C8F71A402E9*
	LOG_I (("%s (): cur_build_path = %s Sleep", GDS_CURRENT_FUNCTION, cur_build_path.c_str ()));
	::Sleep (10000);
	StringVectorMap::iterator cur_it = m_scripts_to_run.find (cur_build_path);
	if (cur_it == m_scripts_to_run.end ()) {
		LOG_E (("%s (): cur_build_path = %s not found", GDS_CURRENT_FUNCTION, cur_build_path));
		return;
	}
	GCL::StrVector scripts_to_run = m_scripts_to_run [cur_build_path];
	m_scripts_to_run.erase (cur_it);
	this->run_scripts (cur_build_path, scripts_to_run);
	//#UC END# *4C8F71A402E9*
}

// проверяет есть ли тестовые скрипты в директории сборки
CORBA::Boolean BuildListener_i::check_scripts (const std::string& root_dir, GCL::StrVector& found_scripts) {
	//#UC START# *4C8E3CA502D7*
	LOG_I (("%s (): root_dir = %s", GDS_CURRENT_FUNCTION, root_dir.c_str ()));
	std::string root_dir_win = root_dir;
	GCL::str_replace (root_dir_win, "/", "\\");
	CORBA::Boolean result = false;
	found_scripts.clear ();
	::boost::filesystem::path root_path (root_dir.c_str(), ::boost::filesystem::native);
	::boost::filesystem::directory_iterator end_iter;
	for (::boost::filesystem::directory_iterator dir_itr (root_path); dir_itr != end_iter; ++dir_itr) {		
		if (::boost::filesystem::is_directory (dir_itr->status ())) {
			std::string script_rel_path_name = dir_itr->path().filename ().string() + "\\" + ListenerParams::get_script_name ();
			std::string script_abs_path_name = root_dir + "\\" + script_rel_path_name;
			LOG_I (("script_abs_path_name = %s", script_abs_path_name.c_str ()));
			std::ifstream ss (script_abs_path_name.c_str ());
			if (ss) {
				LOG_I (("script_rel_path_name = %s opened, push_back", script_rel_path_name.c_str ()));
				result = true;
				found_scripts.push_back (script_rel_path_name);
			}
		}
	}
	LOG_I (("%s (): found_scripts.size () = %u", GDS_CURRENT_FUNCTION, found_scripts.size ()));
	return result;
	//#UC END# *4C8E3CA502D7*
}

// копирует файлы сборки из удаленного места на локальное, если
// сборка подлежит тестированию
CORBA::Boolean BuildListener_i::copy_files (const std::string& from_path, const std::string& to_path) {
	//#UC START# *4C8E21B0026A*
	LOG_I (("%s (): from_path = %s, to_path = %s", GDS_CURRENT_FUNCTION, from_path.c_str (), to_path.c_str ()));
	GCL::StrVector cur_found_scripts;
	if (!this->check_scripts (from_path, cur_found_scripts)) {
		return false;
	}
	m_scripts_to_run [to_path] = cur_found_scripts;
	std::string from_path_win = from_path;
	GCL::str_replace (from_path_win, "/", "\\");
	std::string to_path_win = to_path;
	GCL::str_replace (to_path_win, "/", "\\");
	std::string mkdir_cmd = std::string ("mkdir ") +  to_path_win;
	int res = ACE_OS::system (mkdir_cmd.c_str ());
	if (res == -1) {
		LOG_E ((
			"%s (): can't mkdir_cmd = %s"
			, GDS_CURRENT_FUNCTION
			, mkdir_cmd.c_str ()
		));
	}
	std::string del_cmd = std::string ("del /F /S /Q ") +  to_path_win + "\\" + std::string ("*.*");
	res = ACE_OS::system (del_cmd.c_str ());
	if (res == -1) {
		LOG_E ((
			"%s (): can't del_cmd = %s"
			, GDS_CURRENT_FUNCTION
			, del_cmd.c_str ()
		));
	}
	std::string xcopy_cmd = std::string ("xcopy /S /Y ") + from_path_win + " " + to_path_win + "\\";
	res = ACE_OS::system (xcopy_cmd.c_str ());
	if (res == -1) {
		LOG_E ((
			"%s (): can't xcopy_cmd = %s"
			, GDS_CURRENT_FUNCTION
			, xcopy_cmd.c_str ()
		));
	}
	std::string attrib_cmd = std::string ("attrib -R " + to_path_win + "\\*.*" + " /S /D");
	res = ACE_OS::system (attrib_cmd.c_str ());
	if (res == -1) {
		LOG_E ((
			"%s (): can't attrib_cmd = %s"
			, GDS_CURRENT_FUNCTION
			, attrib_cmd.c_str ()
		));
	}
	return true;
	//#UC END# *4C8E21B0026A*
}

// запускает один скрипт по полному пути-имени
void BuildListener_i::run_script (const std::string& path_prefix, const std::string& path_name) const {
	//#UC START# *4C8F5C0F013D*
	LOG_I (("%s (): path_prefix = %s, path_name = %s", GDS_CURRENT_FUNCTION, path_prefix.c_str (), path_name.c_str ()));
	std::string path_prefix_win = path_prefix;
	GCL::str_replace (path_prefix_win, "/", "\\");
	std::string path_name_win = path_name;
	GCL::str_replace (path_name_win, "/", "\\");
	std::string path_name_cmd = path_name_win + std::string (" ") + std::string ("-prefix_path") + std::string (" ") + path_prefix_win;
	int res = ACE_OS::system (path_name_cmd.c_str ());
	if (res == -1) {
		LOG_E ((
			"%s (): can't path_name_cmd = %s"
			, GDS_CURRENT_FUNCTION
			, path_name.c_str ()
		));
	}
	//#UC END# *4C8F5C0F013D*
}

// запускает (тестировочные) скрипты для тех <<ExeTarget>> где они определены
void BuildListener_i::run_scripts (const std::string& path_prefix, const GCL::StrVector& found_scripts) const {
	//#UC START# *4C8E2245039E*
	LOG_I (("%s (): path_prefix = %s, found_scripts.size () = %u", GDS_CURRENT_FUNCTION, path_prefix.c_str (), found_scripts.size ()));
	for (GCL::StrVector::const_iterator it = found_scripts.begin (); it != found_scripts.end (); ++it) {
		std::string script_path_name = path_prefix + "/" + (*it);
		this->run_script (path_prefix, script_path_name);
	}
	//#UC END# *4C8E2245039E*
}
//////////////////////////////////////////////////////////////////////////////////////////
// oneway methods impl
struct BuildSuccessAsyncParams_ {
	BuildListener_i_var self;
	const std::string cur_build_path;
	BuildSuccessAsyncParams_ (
		BuildListener_i* self_
		, const std::string& cur_build_path_
	) :
		self(BuildListener_i::_duplicate(self_))
		, cur_build_path(cur_build_path_)
	{
	}
};

void BuildListener_i::thr_build_success_async_ (void* arg) {
	try {
		Core::Aptr<BuildSuccessAsyncParams_> arg_ (reinterpret_cast<BuildSuccessAsyncParams_*>(arg));
		arg_->self->build_success_async_ (arg_->cur_build_path);
	} catch (Core::Exception& ex) {
		LOG_SEX ((ex, "while execute BuildListener_i::build_success_async oneway function"));
	} catch (...) {
		LOG_UEX (("while execute BuildListener_i::build_success_async oneway function"));
	}
}

/*oneway*/ Core::ThreadHandle BuildListener_i::build_success_async (const std::string& cur_build_path) {
	Core::Aptr<BuildSuccessAsyncParams_> arg = new BuildSuccessAsyncParams_ (this, cur_build_path);
	Core::ThreadHandle ret = Core::ThreadPoolFactory::def().spawn_thread (
		reinterpret_cast<ACE_THR_FUNC> (BuildListener_i::thr_build_success_async_), arg.in ()
	);
	if (ret == 0) {
		throw; //CantSpawnThread ();
	} else {
		arg.forget ();
	}
	return ret;
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ServerGate::Comm::BuildListner
// сигнал о том что сборка завершена. Вызывает сигнал сервер MDP в качестве параметра передается
// интерфейс ндлс джоступа к странице сборки
void BuildListener_i::build_success (
	ServerGate::Contents::KPage* build_page
	, const char* build_path
	, CORBA::Boolean is_modified
) throw (
	CORBA::SystemException
) {
	//#UC START# *47EA442D03DA_4C878F1F0394*
	LOG_I (("%s (): build_page->get_id = %Q, build_path = %s, is_modified = %d", GDS_CURRENT_FUNCTION, build_page->get_id (), build_path, is_modified));
	if(!is_modified) {
		LOG_I (("%s (): current build wasn't modified, cancel", GDS_CURRENT_FUNCTION));
		return;
	}
	std::string release_name = ListenerParams::get_release_name ();
	std::string build_name = build_page->get_name ();
	if (build_name.find (release_name) != 0) {
		LOG_I (("%s (): release_name = %s, not found at pos 0 in build_name = %s, cancel", GDS_CURRENT_FUNCTION, release_name.c_str (), build_name.c_str ()));
		return ;
	}
	ServerGate::Contents::PageId id = build_page->get_id ();
	std::string strid = ::boost::lexical_cast <std::string> (id);
	std::string local_build_path = ListenerParams::get_local_path () + "/" + strid;
	this->copy_files (build_path, local_build_path);
	this->build_success_async (local_build_path);
	//#UC END# *47EA442D03DA_4C878F1F0394*
}
} // namespace OnBuildDone
} // namespace BuildTestLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

