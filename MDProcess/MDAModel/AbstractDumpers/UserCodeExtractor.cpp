////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/AbstractDumpers/UserCodeExtractor.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::UserCodeExtractor
//
// класс для парсинга контента и "вытаскивания" из него юзер-секций
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/UserCodeExtractor.h"


//////////////////////////////////////////////////////////////////////////////////////////
// static member methods

// пустой callback
void UserCodeExtractor::empty_callback (const std::string& uc_id, const AbstractDumperBase::UserCode& uc_content, const std::string& gen_id) {
	//#UC START# *4AA4F5620031*
	//#UC END# *4AA4F5620031*
}


//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

UserCodeExtractor::~UserCodeExtractor () {
	//#UC START# *4AA4F1140398_DESTR_BODY*
	//#UC END# *4AA4F1140398_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// запуск процесса парсинга, возвращает true, если была найдена хоть одна юзер- секция, иначе false
bool UserCodeExtractor::process (
	const std::string& content
	, const AbstractDumperBase::TemplateBody& tp
	, const std::string& element_uid
	, const Callback& callback
) /*throw (
	TemplatePainter::TemplateBadSyntax
)*/ {
	//#UC START# *4AA4F4500363*
	std::string uc_id;
	const char* buf_p = content.c_str ();
	const char* uc_begin = 0;
	const char* uc_end = 0;

	std::string uc_open_start_id = tp.user_code_open_start_id;
	std::string uc_close_start_id = tp.user_code_close_start_id;
	std::string uc_open_end_id = tp.user_code_open_end_id;
	std::string uc_close_end_id = tp.user_code_close_end_id;
	
	bool uc_found = false;
	while (uc_begin = strstr(buf_p, uc_open_start_id.c_str())) {
		std::string uc_end_str;

		if (!tp.user_code_unique) {
			char uc_id_buf [1024];
			sscanf (uc_begin + strlen (uc_open_start_id.c_str()), "%s", uc_id_buf);
			if (*uc_id_buf == '*') {
				char* end = GCL::find_part_end(uc_id_buf
					, uc_id_buf + strlen (uc_id_buf) - 1
					, '*'
				);
				if (end) {
					*(++end) = 0;
					uc_id = uc_id_buf;
				}
			}
			if (uc_id.empty ()) {
				throw TemplatePainter::TemplateBadSyntax (
					std::string ("Invalid format for user code ID ")
					+ std::string (uc_id_buf)
				);
			}
			uc_end_str = uc_open_end_id + uc_id + uc_close_end_id;
		} else {
			uc_id = "*" + element_uid + "*";
			uc_end_str = uc_open_end_id /*+ uc_id */+ uc_close_end_id;
		}

		uc_end = strstr (uc_begin, uc_end_str.c_str());
		if (!uc_end) {
			throw TemplatePainter::TemplateBadSyntax (
				std::string ("Not closed user code section ")
				+ uc_end_str
			);
		}
		
		uc_end += uc_end_str.size();
		AbstractDumperBase::UserCode uc (uc_begin, uc_end);
		buf_p = uc_end;

		std::string current_map;		
		if (*uc_end == '*') {
			current_map = GCL::part (uc_end, uc_end + ACE_OS::strlen (uc_end), '*');
			// need to check id for existance
			if (current_map.empty ()) {
				current_map = AbstractDumperBase::s_current_map;
			}
		} else {
			current_map = AbstractDumperBase::s_current_map;
		}
		
		uc_found = true;
		callback (uc_id, uc, current_map);		
	}

	return uc_found;
	//#UC END# *4AA4F4500363*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

