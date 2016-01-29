////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseDumpers/MDAModelParams.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Settings::Class>> MDProcess::MDAModel::RoseDumpers::MDAModelParams
//
// настройки
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEDUMPERS_MDAMODELPARAMS_H__
#define __MDPROCESS_MDAMODEL_ROSEDUMPERS_MDAMODELPARAMS_H__

#include "shared/CoreSrv/sys/std_inc.h"


// настройки
class MDAModelParams {

// static member methods and data
public:
	static const std::string get_image_dir () /* throw (Core::ParameterIsMissing) */;
	static void set_image_dir (const std::string& value);
	static const char* image_dir_param_name ();

	// часть пути файле сохранённой модели, при наличии которой выполняется автоматическая выливка
	// пакетов в cat-ы
	static const std::string get_path_component_to_control () /* throw (Core::ParameterIsMissing) */;
	static void set_path_component_to_control (const std::string& value);
	static const char* path_component_to_control_param_name ();

	static const std::string get_templates_dir () /* throw (Core::ParameterIsMissing) */;
	static void set_templates_dir (const std::string& value);
	static const char* templates_dir_param_name ();

}; // class MDAModelParams



#endif //__MDPROCESS_MDAMODEL_ROSEDUMPERS_MDAMODELPARAMS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

