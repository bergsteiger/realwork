////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase_TemplateLoader.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractDumperBase::TemplateLoader
//
// класс для загрузки и парсинга шаблона
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/AbstractDumpers/SyntaxDef.h"
#include <algorithm>
#include <fstream>
#include "shared/GCL/os/FileOp.h"
#include "boost/lexical_cast.hpp"

class AbstractDumperBase;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AbstractDumperBase::TemplateLoader::~TemplateLoader () {
	//#UC START# *46E8DFC3038A_DESTR_BODY*
	//#UC END# *46E8DFC3038A_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// метод проверяет менялся ли шаблон со времени последнего вычитывания
// возвращает true, если менялся, иначе - false
// \template_path - полный путь к шаблону
bool AbstractDumperBase::TemplateLoader::check_template_changed (const std::string& template_path) {
	//#UC START# *46E920BF0399*
#ifndef GDS_NLOG_DEBUG
	Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);
#endif

	bool res = false;
	
	AbstractDumperBase::TemplateData data;
	GCL::StrSet parsed_files;	
	this->load_template_data (template_path, data, parsed_files);

	if (
		data.size () != m_template_data.size ()
		|| std::equal (data.begin (), data.end (), m_template_data.begin ()) == false
	) {
		//шаблон поменялся - нужно обновить кэш
		m_template_data = data;
		res = true;
	}
	return res;
	//#UC END# *46E920BF0399*
}

// возвращает прочитанный шаблон в виде списка строк
const AbstractDumperBase::TemplateData AbstractDumperBase::TemplateLoader::get_template_data () {
	//#UC START# *46E8E3D50148*
	return m_template_data;
	//#UC END# *46E8E3D50148*
}

// считывает файл в буфер, included_files - содержит список файлов включенных в шаблон (через
// дериктиву #)
void AbstractDumperBase::TemplateLoader::load_template_data (
	const std::string& template_path
	, TemplateData& data
	, GCL::StrSet& included_files
) {
	//#UC START# *46E8E0CA0177*
	//предотвращаем загрузку одного и того же файла
	char absulute_path_buff [MAXPATHLEN + 1] = {0};

	std::string template_absolute_path;
	if (ACE_OS::realpath (template_path.c_str (), absulute_path_buff) != 0) {
		template_absolute_path = absulute_path_buff;
	} else {
		template_absolute_path = template_path;
	}
	if (included_files.find (template_absolute_path) != included_files.end ()) {
		LOG_D(("File %s has already been loaded", template_absolute_path.c_str ()));
		return;
	}

	std::ifstream templ_file (template_absolute_path.c_str (), std::ios::in);

    if (!templ_file) {
		std::string mess (template_absolute_path);
		mess += " file open error!!! in ";
		mess += GDS_CURRENT_FUNCTION;
		
		GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
		GenSupport::LogManagerFactory::get ().log_error (mess);

		return;
    }

	included_files.insert (template_absolute_path);
	unsigned line_num = 0;
	std::string line;
	
	while (std::getline (templ_file, line)) {
		line_num++;
		if (line.empty () == false) {
			switch (line[0]) {
				case SX_1_INCLUDE: {
					std::string temp = line;
					temp.erase (0, 2);
					std::string included_template_path;
					std::string inc_path = GCL::trim_ws(temp.c_str ());
					
					if (!GCL::end_with (inc_path.data(), ".tpi")) {
						inc_path += ".tpi";
					}

					if ( inc_path[1] == ':' ) {
						included_template_path = inc_path;
					} else {
						// find base dir
						std::string drive;
						std::string dir;
						std::string fname;
						std::string ext;
						GCL::FileOp::splitpath (
							template_path
							, drive
							, dir
							, fname
							, ext
						);
						/*std::string::size_type a = template_path.rfind ('\\');
						std::string::size_type b = template_path.rfind ('/');
						if (a == std::string::npos) {
							a = 0;
						} else {
							a++;
						}
						if (b == std::string::npos) {
							b = 0;
						} else {
							b++;
						}

						included_template_path = template_path.substr (0, a > b ? a : b) + inc_path;*/
						//included_template_path = drive + "\\" + dir + "\\" + inc_path;
						included_template_path = drive + dir + inc_path;
					}
										
					std::ifstream included_templ_file (included_template_path.c_str (), std::ios::in);
					if (!included_templ_file) {
						std::string mess(template_path);
						mess += ":";
						mess += boost::lexical_cast<std::string> (line_num);
						mess += " - Can't load include file \"";
						mess += included_template_path;
						mess += "\"";

						GenSupport::ErrorManagerFactory::get ().fatal_error (0, mess, GDS_CURRENT_FUNCTION);
						GenSupport::LogManagerFactory::get ().log_error (mess);
						
						return;
					}
					included_templ_file.close ();

					
					this->load_template_data (included_template_path, data, included_files);
					
					break;
				}
				case '/':
					break;

				default:
					data.push_back (line);
			}				
		}
	}
	//#UC END# *46E8E0CA0177*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

