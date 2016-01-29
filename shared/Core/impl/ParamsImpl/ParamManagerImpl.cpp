////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/impl/ParamsImpl/ParamManagerImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> shared::Core::ParamsImpl::ParamManagerImpl
//
// реализация менеджера
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "ace/ACE.h"
#include "shared/Core/LibHome.h"
#include "shared/Core/impl/ParamsImpl/ParamManagerImpl.h"
// by <<uses>> dependencies
#include "shared/Core/os/RegistryHelper.h"
#include "shared/Core/fix/mpcxc.h"
#include "boost/algorithm/string/case_conv.hpp"
#include "ace/ARGV.h"
#include "shared/Core/ParamsHelper/ParamConvert.h"

namespace Core {
namespace ParamsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// nested implementation

// конструктор по-умолчанию
ParamManagerImpl::KeyInfo::KeyInfo ()
//#UC START# *4833B54802B1_INIT_CTOR_BASE_INIT*
: data (""), from (COMMAND_LINE), section ("")
//#UC END# *4833B54802B1_INIT_CTOR_BASE_INIT*
{
	//#UC START# *4833B54802B1_CTOR_BODY*
	//#UC END# *4833B54802B1_CTOR_BODY*
}

// конструктор для инициализации полей
ParamManagerImpl::KeyInfo::KeyInfo (const std::string& value, ReadFrom fr, const std::string& sect)
//#UC START# *4833B559039C_INIT_CTOR_BASE_INIT*
: data (value), from (fr), section (sect)
//#UC END# *4833B559039C_INIT_CTOR_BASE_INIT*
{
	//#UC START# *4833B559039C_CTOR_BODY*
	ParamManagerImpl::substitute_environment_variables (data);
	//#UC END# *4833B559039C_CTOR_BODY*
}


// блок констант для работы с ParamManager'ом
const char* ParamManagerImpl::RUN_PARAM = "-RUN"; // имя ключа, используемого для указания того, что при завершении нужно выполнить какую-нить программу. P.S: совершенно не понятно почему этот параметр нужен ParamManager'у
const char* ParamManagerImpl::RUN_ARGS = "-RUNARGS"; // имя ключ для задания параметров запуска стороннего приложения, еоторое запускается при завершении работы. P.S: также совершненно не понятно какое это отношенеи имеет к ParamManager'у
const char* ParamManagerImpl::ADDITIONAL_CONFIG_SECTION_KEY = "-GPMAdditionalSection"; // ключ в настройках, значение по которому указывает на дополнительную секцию из которой нужно прочитать параметры.
const char* ParamManagerImpl::CONFIG_SECTION_KEY_TEMPLATE = "-GPM%sConfigSection\0"; // шаблон для формирования имени ключа, определяющего секцию в файле настроек.
const char* ParamManagerImpl::CONFIG_FILE_KEY = "-GCMConfigFile"; // ключ, по которому задается путь к файлу настроек
const char* ParamManagerImpl::REGISTRY_SECTION_KEY = "-GPMRegistrySection"; // ключ по которому задаётся секция в реестре

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// если str - являеся переменной окружения, то она заменяется значением этой переменной окружения
void ParamManagerImpl::substitute_environment_variables (std::string& str) {
	//#UC START# *4833ACEB0287*
	std::string::size_type start = str.find ('%');
	while (std::string::npos != start) {
		std::string::size_type end = str.find ('%', start+1);
		if (std::string::npos == end) {
			break;
		}
		std::string var = str.substr (start+1, end-start-1);
		char* env = getenv (var.c_str ());
		if (0 != env) {
			str.replace (start, end-start+1, env);
		}
		start = str.find ('%', start+1);
	}
	//#UC END# *4833ACEB0287*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ParamManagerImpl::ParamManagerImpl ()
//#UC START# *483273860069_483273B30265_48327B8A0355_BASE_INIT*
//#UC END# *483273860069_483273B30265_48327B8A0355_BASE_INIT*
{
	//#UC START# *483273860069_483273B30265_48327B8A0355_BODY*
	//#UC END# *483273860069_483273B30265_48327B8A0355_BODY*
}

ParamManagerImpl::ParamManagerImpl (const std::string& args)
//#UC START# *483273860069_48F57A1100B2_48327B8A0355_BASE_INIT*
//#UC END# *483273860069_48F57A1100B2_48327B8A0355_BASE_INIT*
{
	//#UC START# *483273860069_48F57A1100B2_48327B8A0355_BODY*
	ACE_ARGV argv (args.c_str ());	
	this->parse_command_line (Core::ParamConvert::make_arg_list (argv.argc (), argv.argv ()));
	//#UC END# *483273860069_48F57A1100B2_48327B8A0355_BODY*
}

ParamManagerImpl::~ParamManagerImpl () {
	//#UC START# *48327B8A0355_DESTR_BODY*
	ValuesMap::const_iterator run_after = m_map.find (boost::algorithm::to_upper_copy (std::string (RUN_PARAM)));
	if (m_map.end () != run_after) {
		ValuesMap::const_iterator args_line = m_map.find (boost::algorithm::to_upper_copy (std::string (RUN_ARGS)));
		if (m_map.end () == args_line || args_line->second.data.empty ()) {
			const char* file = run_after->second.data.c_str ();
			char* args [] = {const_cast <char*> (file), 0}; // GARANT_STDC
			ACE_OS::execvp (file, args);
		} else {
			int i;
			ACE_ARGV arg_for_parsing (args_line->second.data.c_str ());
			char** arg = new char*[arg_for_parsing.argc ()+2];
			std::string s = this->convert_string_to_in_quotes (run_after->second.data);
			arg[0] = new char[s.length ()+1];
			strcpy (arg[0], s.c_str ()); 
			arg[0][s.length ()] = 0;
			for (i = 0; i < arg_for_parsing.argc (); i++) {
				std::string converted_string = this->convert_string_to_in_quotes (std::string(arg_for_parsing.argv ()[i]));
				arg[i+1] = new char[converted_string.length ()+1];
				strcpy (arg[i+1], converted_string.c_str ());
				arg[i+1][converted_string.length ()] = 0;
			}
			arg[arg_for_parsing.argc ()+1] = 0;
			ACE_OS::execvp (run_after->second.data.c_str (), arg);
			for (i = 0; i < arg_for_parsing.argc ()+1; i++) {
				delete[] arg[i];
			}
			delete[] arg;
		}
	}
	//#UC END# *48327B8A0355_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// "заворчивает" строку в кавычки, если в ней есть пробелы
const std::string ParamManagerImpl::convert_string_to_in_quotes (const std::string& str) const {
	//#UC START# *4833ACC10049*
	if (std::string::npos == str.find (' ') && std::string::npos == str.find ('\'')) {
		return str;
	}
	char buf[1024];
	sprintf (buf, "\"%s\"\0", str.c_str ());
	return buf;
	//#UC END# *4833ACC10049*
}

// возвращает значение по ключу в секции section конфигурационного файла
const std::string ParamManagerImpl::get_key_value (
	const std::string& file
	, const std::string& section
	, const std::string& key
) const /*throw (
	DataNotCorrect
)*/ {
	//#UC START# *4833ABFF0121*
	const size_t buffer_size = 2048;
	char buffer [buffer_size];

	size_t readed_bytes = MPCXC_GetPrivateProfileString (
		section.c_str () // points to section name
		, key.c_str ()              // points to key name
		, ""                        // points to default string
		, buffer                    // points to destination buffer
		, buffer_size               // size of destination buffer
		, file.c_str ()       // points to initialization filename
	);

	if (readed_bytes == buffer_size - 1) {
		//LOG_E (("GCMManager_i::get_ini_key: There is too big value in ini file, for key %s!", key.c_str ()));
		throw DataNotCorrect ();
	}
	return buffer;
	//#UC END# *4833ABFF0121*
}

// опряделяет задан ли параметр в правильном формате
bool ParamManagerImpl::is_recognized_param (std::string& key) const {
	//#UC START# *48327BB901B8*
	bool ret = false;
	if ('\x2D' == key[0]) {
		ret = true;
	} else if ('\x96' == key[0]) {
		// param not correct, but continue
		key[0] = '\x2D';
		ret = true;
	}
	if (true == ret) {
		//test for negative number
		for (unsigned int i = 1; i < key.size (); i++) {
			if ('.' != key[i] && ('0' > key[i] || '9' < key[i])) {
				return true;
			}
		}
		return false;
	}
	return false;
	//#UC END# *48327BB901B8*
}

// парсит командную строку, находит в ней пары ключ-значение и записывает в мапу
void ParamManagerImpl::parse_command_line (const ParamArgs& args) {
	//#UC START# *4833AB1602B9*
	ParamArgs::size_type i = 0;
	while (i < args.size ()) {
		std::string param = args[i];
		if (true == this->is_recognized_param (param)) {			
			ParamArgs::size_type next = i+1;
			if (next < args.size ()) {
				std::string next_arg = args[next];
				if (RUN_ARGS == boost::algorithm::to_upper_copy (param)) {					
					for (unsigned long i1 = 0; i1 < next_arg.length (); i1++) { // GARANT_FORSCOPING
							if ('\'' == next_arg[i1]) {
								next_arg[i1] = '\"';
						}	
					}
					m_map[boost::algorithm::to_upper_copy (param)] = KeyInfo (next_arg, COMMAND_LINE, "");
					i++;
				} else if (false == this->is_recognized_param (next_arg)) {
					m_map[boost::algorithm::to_upper_copy (param)] = KeyInfo (args[next], COMMAND_LINE, "");
					i++;
				} else {
					// value not defined
					m_map[boost::algorithm::to_upper_copy (param)] = KeyInfo ("", COMMAND_LINE, "");
				}
			} else {
				m_map[boost::algorithm::to_upper_copy (param)] = KeyInfo ("", COMMAND_LINE, "");
			}
		}
		i++;
	}
	//#UC END# *4833AB1602B9*
}

// парсит секцию section в конфигурационном файле, находит пары ключ-значение и записывает в мапу
void ParamManagerImpl::parse_config_file (
	const std::string& file
	, const std::string& section
) /*throw (
	DataNotCorrect
)*/ {
	//#UC START# *4833AB980020*
	const size_t buffer_size = 2048;
	char buffer [buffer_size];

	size_t readed_bytes = MPCXC_GetPrivateProfileString (
		section.c_str () // points to section name
		, 0                         // points to key name
		, ""                        // points to default string
		, buffer                    // points to destination buffer
		, buffer_size               // size of destination buffer
		, file.c_str ()       // points to initialization filename
	);

	if (!readed_bytes) {
		throw DataNotCorrect ();
	}

	if (readed_bytes == buffer_size - 2) {
		throw DataNotCorrect ();
	}
	//
	ReadFrom from = CONFIG_FILE;
	static const char* READ_ONLY_PREFIX= "R/O";
	static const std::string::size_type PREFIX_LEN = strlen (READ_ONLY_PREFIX);
	if (PREFIX_LEN < section.length ()
			&& READ_ONLY_PREFIX == section.substr (section.length () - PREFIX_LEN, PREFIX_LEN)
		)
	{
		from = READ_ONLY_SECTION_IN_CONFIG_FILE;
	}
	const char* ptr = buffer;
	while (strcmp (ptr, "")) {
		std::string key = ptr;

		if (true == this->is_recognized_param (key)) {
			ValuesMap::iterator it = m_map.find (boost::algorithm::to_upper_copy (key));
			if ((ADDITIONAL_CONFIG_SECTION_KEY == key) || (m_map.end () == it)) {
				m_map[boost::algorithm::to_upper_copy (key)] = KeyInfo (get_key_value (file, section, key), from, section);
			} else if ((m_map.end () != it) && (CONFIG_FILE == from) && (COMMAND_LINE == it->second.from)) {
				it->second.from = from;
				it->second.section = section;
			}
		}
		ptr += strlen (ptr) + 1;
	}
	ValuesMap::iterator it = m_map.find (boost::algorithm::to_upper_copy (std::string (ADDITIONAL_CONFIG_SECTION_KEY)));
	if (m_map.end () != it) {
		std::string additional_section = it->second.data;
		m_map.erase (it);
		this->parse_config_file (file, additional_section);
	}
	//#UC END# *4833AB980020*
}

// парсит ветку реестра, по ключу subkey, находит пары ключ-значение и записывает в мапу
void ParamManagerImpl::parse_registry (const std::string& subkey) /*throw (DataNotCorrect)*/ {
	//#UC START# *4833AB580143*
	RegistryHelper::Key key;
	std::string sub;
	if (RegistryHelper::parse_registry_path (subkey, key, sub)) {
		RegistryHelper::KeysArray keys;
		if (false == RegistryHelper::get_keys_array (key, sub.c_str (), keys)) {
			throw DataNotCorrect ();
		}
		for (std::size_t i = 0; i < keys.size (); i++) {
			if (m_map.end () != m_map.find (boost::algorithm::to_upper_copy (keys[i].name))) {
				continue;
			}
			if (true == this->is_recognized_param (keys[i].name)) {
				m_map[boost::algorithm::to_upper_copy (keys[i].name)] = KeyInfo (keys[i].value, REGISTRY, "") ;
			}
		}
	} else {
		throw DataNotCorrect ();
	}
	//#UC END# *4833AB580143*
}

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from ParamManager
// добавить hardcode параметр типа long, который будет записан, только если такого параметра нет
void ParamManagerImpl::add_hardcode_long (const char* key, long value) {
	//#UC START# *483278C2022D_48327B8A0355*
	if (false == this->is_exist (key)) {
		this->add_long (key, value);
	}
	//#UC END# *483278C2022D_48327B8A0355*
}

// implemented method from ParamManager
// добавить hardcode параметр типа string, который будет записан, только если такого параметра нет
void ParamManagerImpl::add_hardcode_string (const char* key, const char* value) {
	//#UC START# *483278B60287_48327B8A0355*
	if (false == this->is_exist (key)) {
		this->add_string (key, value);
	}
	//#UC END# *483278B60287_48327B8A0355*
}

// implemented method from ParamManager
// добавить hardcode параметр типа unsigned long, который будет записан, только если такого
// параметра нет
void ParamManagerImpl::add_hardcode_ulong (const char* key, unsigned long value) {
	//#UC START# *483278D40359_48327B8A0355*
	if (false == this->is_exist (key)) {
		this->add_ulong (key, value);
	}
	//#UC END# *483278D40359_48327B8A0355*
}

// implemented method from ParamManager
// Добавить временный параметр типа long - он не будет сохранён
void ParamManagerImpl::add_long (const char* key, long value) {
	//#UC START# *4832778B01EA_48327B8A0355*
	char buf[255];
	sprintf (buf, "%d\0", value);
	this->add_string (key, buf);
	//#UC END# *4832778B01EA_48327B8A0355*
}

// implemented method from ParamManager
// Добавить временный параметр типа string - он не будет сохранён
void ParamManagerImpl::add_string (const char* key, const char* value) {
	//#UC START# *483277880001_48327B8A0355*
	m_map[boost::algorithm::to_upper_copy (std::string (key))] = KeyInfo (value, TEMP, "");
	//#UC END# *483277880001_48327B8A0355*
}

// implemented method from ParamManager
// Добавить временный параметр типа unsigned long - он не будет сохранён
void ParamManagerImpl::add_ulong (const char* key, unsigned long value) {
	//#UC START# *4832779C02DC_48327B8A0355*
	char buf[255];
	sprintf (buf, "%u\0", value);
	this->add_string (key, buf);
	//#UC END# *4832779C02DC_48327B8A0355*
}

// implemented method from ParamManager
// возвращает список параметров для инициализации ORB'а
ParamArgs* ParamManagerImpl::command_line_for_orb_init () /*throw (DataNotFound)*/ {
	//#UC START# *48327A0501C4_48327B8A0355*
	class Local {
	public:
		static bool is_orb_init_param (const std::string& param) {
			static const char* PARAM_PREFIX = "-ORB";

			return (
				(ACE_OS::strlen (PARAM_PREFIX) < param.length ())
				&& (PARAM_PREFIX == param.substr (0, ACE_OS::strlen (PARAM_PREFIX)))
			);
		}
	};

	m_orb_init_command_line.clear ();

	ValuesMap::iterator it; // GARANT_TMP
	for (it = m_map.begin (); it != m_map.end (); ++it) {
		if (it->first == "-ORBLOGFILE") { // GARANT_PLAN
			it->second.data = platform_independent_path(it->second.data);
		}

		if (true == Local::is_orb_init_param (it->first)) {
			m_orb_init_command_line.push_back (this->convert_string_to_in_quotes (it->first));

			if (false == it->second.data.empty ()) {
				m_orb_init_command_line.push_back (this->convert_string_to_in_quotes (it->second.data));
			}
		}
	}

	if (0 == m_orb_init_command_line.size ()) {
		throw DataNotFound ();
	}

	Core::Aptr<ParamArgs> arg = new ParamArgs (m_orb_init_command_line.begin (), m_orb_init_command_line.end ());
	
	return arg.forget ();
	//#UC END# *48327A0501C4_48327B8A0355*
}

// implemented method from ParamManager
// Возвращает список параметров для подсистемы SBE (Smart BackEnd)
ParamArgs* ParamManagerImpl::command_line_for_sbe_init () {
	//#UC START# *48327A3D02C7_48327B8A0355*
	class Local {
	public:
		static bool is_sbe_init_param (const std::string& param) {
			static const char* PARAM_PREFIX = "-SBE";

			return (
				(ACE_OS::strlen (PARAM_PREFIX) < param.length ())
				&& (PARAM_PREFIX == param.substr (0, ACE_OS::strlen (PARAM_PREFIX)))
			);
		}
	};

	m_sbe_init_command_line.clear ();

	ValuesMap::iterator it; // GARANT_TMP
	for (it = m_map.begin (); it != m_map.end (); ++it) {
		if (it->first == "-SBELOGFILE") { // GARANT_PLAN
			it->second.data = platform_independent_path (it->second.data);
		}

		if (true == Local::is_sbe_init_param (it->first)) {
			m_sbe_init_command_line.push_back (this->convert_string_to_in_quotes (it->first));

			if (false == it->second.data.empty ()) {
				m_sbe_init_command_line.push_back (this->convert_string_to_in_quotes (it->second.data));
			}
		}
	}

	Core::Aptr<ParamArgs> arg = new ParamArgs (m_sbe_init_command_line.begin (), m_sbe_init_command_line.end ());
	
	return arg.forget ();
	//#UC END# *48327A3D02C7_48327B8A0355*
}

// implemented method from ParamManager
// получить значение параметра (key) в виде целого, default_value - значение по умолчанию
// (возвращается в случае, если не найден параметр key)
long ParamManagerImpl::get_long (const char* key, long default_value) const {
	//#UC START# *483276770169_48327B8A0355*
	std::string s = this->get_string (key, "");
	if (true == s.empty ()) {
		return default_value;
	}
	return atoi (s.c_str ());
	//#UC END# *483276770169_48327B8A0355*
}

// implemented method from ParamManager
// получить значение параметра (key) в виде строки, default_value - значение по умолчанию
// (возвращается в случае, если не найден параметр key)
const std::string ParamManagerImpl::get_string (const char* key, const char* default_value) const {
	//#UC START# *48327501038F_48327B8A0355*
	ValuesMap::const_iterator it = m_map.find (boost::algorithm::to_upper_copy (std::string (key)));
	if (m_map.end () == it) {
		return std::string (default_value);
	}
	return it->second.data;
	//#UC END# *48327501038F_48327B8A0355*
}

// implemented method from ParamManager
// получить значение параметра (key) в виде целого без знака, default_value - значение по умолчанию
// (возвращается в случае, если не найден параметр key)
unsigned long ParamManagerImpl::get_ulong (const char* key, unsigned long default_value) const {
	//#UC START# *483276F501F9_48327B8A0355*
	std::string s = this->get_string (key, "");
	if (true == s.empty ()) {
		return default_value;
	}
	char* p = 0;
	return strtoul (s.c_str (), &p, 10);

	//ses: ручной перевод, возможно пригодится для int64
	//unsigned long ret = 0;
	//char c[2];
	//c[1] = 0;
	//for (unsigned long i = 0; i < s.size () && ::isdigit (s[i]); i++) {
	//	c[0] = s[i];
	//	ret = 10*ret+atoi(c);
	//}
	//return ret;
	//#UC END# *483276F501F9_48327B8A0355*
}

// implemented method from ParamManager
// инициализация менеджера:
// args - список параметров, переданных через командную строку
// init_data -
int ParamManagerImpl::init (
	const ParamArgs& args
	, const ParamManagerInitData& init_data
) /*throw (
	DataNotFound
	, DataNotCorrect
)*/ {
	//#UC START# *48327486000E_48327B8A0355*
	m_map.clear ();
	//
	if (args.empty () == false) {
		this->parse_command_line (args);
	}
	std::string registry_subkey;
	ValuesMap::iterator it = m_map.find (boost::algorithm::to_upper_copy (std::string (REGISTRY_SECTION_KEY)));
	if (m_map.end () != it) {
		registry_subkey = it->second.data;
		this->parse_registry (registry_subkey);
	} else {
		registry_subkey = init_data.registry_subkey != 0 ? init_data.registry_subkey : "";
		this->add_string (REGISTRY_SECTION_KEY, registry_subkey.c_str ());
		try {
			this->parse_registry (registry_subkey);
		} catch (DataNotCorrect&) {
		}
	}
	//
	it = m_map.find(boost::algorithm::to_upper_copy (std::string (CONFIG_FILE_KEY)));
	if (m_map.end () != it) {
		std::string file = it->second.data;
		if (true == file.empty ()) {
			throw DataNotCorrect ();
		}
		char config_section[100];
		sprintf (
			config_section
			, CONFIG_SECTION_KEY_TEMPLATE
			, init_data.application_name != 0 ? init_data.application_name : ""
		);
		it = m_map.find (boost::algorithm::to_upper_copy (std::string (config_section)));
		std::string section;
		if (m_map.end () == it) {
			// ses: in future:
			//throw DataNotCorrect ();
			// but now:
			{
				section = init_data.application_name != 0 ? init_data.application_name : "";
				section += " Params";
			}
		} else {
			section = it->second.data;
		}
		if (true == section.empty ()) {
			throw DataNotCorrect ();
		}
		this->parse_config_file (file, section);
	}
	return static_cast<int> (m_map.size () - 1); //minus manual added REGESTRY section
	//#UC END# *48327486000E_48327B8A0355*
}

// implemented method from ParamManager
// возвращает true, если присутствует параметр key
bool ParamManagerImpl::is_exist (const char* key) const {
	//#UC START# *4832775B0029_48327B8A0355*
	return (m_map.end () != m_map.find (boost::algorithm::to_upper_copy (std::string (key))));
	//#UC END# *4832775B0029_48327B8A0355*
}

// implemented method from ParamManager
// добавляет параметр, он будет сохранён в реестре или в ini-файле
void ParamManagerImpl::set_long (const char* key, long value) /*throw (SaveDataFailed)*/ {
	//#UC START# *4832768F02D1_48327B8A0355*
	char buf[255];
	sprintf (buf, "%d\0", value);
	this->set_string (key, buf);
	//#UC END# *4832768F02D1_48327B8A0355*
}

// implemented method from ParamManager
// добавляет параметр, он будет сохранён в реестре или в ini-файле
void ParamManagerImpl::set_string (const char* key, const char* value) /*throw (SaveDataFailed)*/ {
	//#UC START# *4832761902F9_48327B8A0355*
	class Local {
	public:
		static void save_to_registry (
			Core::ParamManager& pm
			, const char* key
			, const char* value
			, ValuesMap& map
		) /*throw (SaveDataFailed)*/ {
			if (false == pm.is_exist (REGISTRY_SECTION_KEY)){
				throw SaveDataFailed ();
			}
			RegistryHelper::Key hkey;
			std::string subkey("");
			if (false == RegistryHelper::parse_registry_path (
						pm.get_string (REGISTRY_SECTION_KEY)
						, hkey
						, subkey
					)
				)
			{
				throw SaveDataFailed ();
			}
			try {
				RegistryHelper::set_option_value (hkey, subkey.c_str (), key, value);
			} catch (...) {
				throw SaveDataFailed ();
			}
			map[boost::algorithm::to_upper_copy (std::string (key))] = ParamManagerImpl::KeyInfo (value, ParamManagerImpl::REGISTRY, "");
		}

		static bool save_to_config_file (
			Core::ParamManager& pm
			, const char* key
			, const char* value
			, const char* section, ValuesMap& map
		) {
			if (false == pm.is_exist (CONFIG_FILE_KEY)) {
				// in that branch we never! never! never! exist 
				GDS_ASSERT (false);
				return false;
			}
			if (
				!MPCXC_WritePrivateProfileString (
					section
					, key
					, value
					, pm.get_string (CONFIG_FILE_KEY).c_str ()
				)
			) {
				return false;
			}
			if (value) {
				map[boost::algorithm::to_upper_copy (std::string (key))] = ParamManagerImpl::KeyInfo (value, ParamManagerImpl::CONFIG_FILE, section);
			} else {
				map.erase (boost::algorithm::to_upper_copy (std::string (key)));
			}
			return true;
		}
	};
	std::string key_string (key);
	if (false == is_recognized_param (key_string)) {
		throw SaveDataFailed ();
	}

	ValuesMap::iterator it = m_map.find (boost::algorithm::to_upper_copy (key_string));
	if (
		m_map.end () == it
		|| REGISTRY == it->second.from
		|| COMMAND_LINE == it->second.from
		|| READ_ONLY_SECTION_IN_CONFIG_FILE == it->second.from
		|| (
			CONFIG_FILE == it->second.from 
			&& false == Local::save_to_config_file (*this, key, value, it->second.section.c_str (), m_map)
		)
	) {
		Local::save_to_registry (*this, key, value, m_map);
	}
	//#UC END# *4832761902F9_48327B8A0355*
}

// implemented method from ParamManager
// добавляет параметр, он будет сохранён в реестре или в ini-файле
void ParamManagerImpl::set_ulong (const char* key, unsigned long value) /*throw (SaveDataFailed)*/ {
	//#UC START# *4832771D0344_48327B8A0355*
	char buf[255];
	sprintf (buf, "%u\0", value);
	this->set_string (key, buf);
	//#UC END# *4832771D0344_48327B8A0355*
}
} // namespace ParamsImpl
} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

