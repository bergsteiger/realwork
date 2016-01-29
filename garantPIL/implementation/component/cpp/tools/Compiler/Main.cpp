//
// Main.cpp : Defines the entry point for the console application.
//

#include "ace/ACE.h"

#include <iostream>

#include "shared/Core/ParamsHelper/ParamConvert.h"
//#include "shared/GCL/str/str_conv.h"

#include "garantPIL/implementation/component/cpp/Garant/Global/Core/Common/ParamManagerReg.h"
#include "garantPIL/implementation/component/cpp/libs/endt/EndtBuilder.h"

#include "garver.h"
#include "CheckData.h"
#include "BaseCreate.h"
#include "CompileConfig.h"

enum ExecuteStatus { es_Success, es_Error };

/////////////////////////////////////////////////////////////////////////////////////////////////////////

class ACE_initializer {
public:
	ACE_initializer () {
		ACE::init ();
	}
	~ACE_initializer () {
		ACE::fini ();
	}
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
Просматриваются все топики, участвующие в компиляции. 
Набираются вектора документов/объектов. 
Читаются интервалы действия документов и редакций. 
Формируются цепочки редакций. 
Формируется вектор всех встреченных документ.блок/саб. 

Потом:

· Вектор участвующих в компиляции топиков проверяется на непересекаемость с ТВС 
  (таблицей внешних ссылок – список документов.блоков, компилируемых в других регионах)

· Вектора документов/объектов участвуют (второй проход, собственно компиляция) для типизации ссылок

· Интервалы действия и цепочка редакций: проверяется на корректность 
  (цепочка должна быть неразрывной, в ней должен быть и только один doc, не должно быть циклов, 
   не должно быть пересечений в диапазоне действий)

· Всех встреченных документ.блок/саб используется вместе с ТВС при проверке правильности ссылок 
  (на втором проходе, компиляции)


  belongs - сегментный состав базы

*/
/*
1. Кодировка для лога?
*/

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// ConvertRunner implementation

class CompileExecutor {
public:
	CompileExecutor (int argc, char* argv []) {
		m_ini = "C:\\Compiler\\compile.ini";
		m_data_path = "in";

		/*
		Core::ParamManagerInitData id;

		id.application_name = "GC";
		id.registry_subkey = "Core::RegistryHelper::KEY_CURRENT_USER\\";

		Core::ParamManagerReg::instance ();
		Core::ParamManagerFactory::get ().init (Core::ParamConvert::make_arg_list (argc, argv), id);	

		if (Core::ParamManagerFactory::get ().is_exist ("-config")) {
			m_ini = Core::ParamManagerFactory::get ().get_string ("-config");
		}

		if (Core::ParamManagerFactory::get ().is_exist ("-out")) {
			m_data_path = Core::ParamManagerFactory::get ().get_string ("-out");
		}
		*/

		std::cout << "GARANT base compiler. Version " 
		          << GARANT_VERSION 
				  << " (" 
				  << __DATE__ 
				  << ", " 
				  << __TIME__ 
				  << ") " 
				  << std::endl 
				  << std::endl;

		std::cout << "-config: " << m_ini.c_str () << std::endl;
		std::cout << "-out:    " << m_data_path.c_str () << std::endl << std::endl;

	}

	virtual ~CompileExecutor () {
	}

	void execute () {
		if (m_data_path.empty () || m_data_path.empty ()) {
			std::cout << "Invalid arguments" << std::endl;
			return;
		}

		Core::GDS::StopWatch sw ("compiler");

		Compiler::ConfigData config_data;

		bool is_valid = false;

		try {
			Compiler::ConfigReader (m_ini).read (config_data);

			Compiler::CompileInfo compile_info;
			compile_info.init (config_data);

			Compiler::Checker ().execute (compile_info);

			//Core::Aptr <Base> base = Compiler::BaseFactory::make (m_data_path.c_str ());
			//this->write_evd ();

			is_valid = true;

		} catch (Compiler::FileNotFound&) {
			LOG_E (("%s: %s not found", GDS_CURRENT_FUNCTION, m_ini.c_str ()));
		} catch (Compiler::FileImportError&) {
			LOG_E (("%s: %s import error", GDS_CURRENT_FUNCTION, m_ini.c_str ()));
		} catch (Compiler::InvalidBelongs& ex) {
			LOG_E (("%s: %s", GDS_CURRENT_FUNCTION, ex.what ()));
		} catch (Compiler::CantReadFile& ex) {
			LOG_E (("%s: %s", GDS_CURRENT_FUNCTION, ex.what ()));
		} catch (Compiler::BaseCreateError& ex) {
			LOG_E (("%s: %s", GDS_CURRENT_FUNCTION, ex.what ()));
		} catch (...) {
			LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
		}

		if (is_valid == false) {
			throw std::exception ();
		}
	}

	void write_evd () {
		Core::Aptr <YBase> base = new YBase (m_data_path.c_str (), O_RDWR);

		try {
			Core::GDS::StopWatch sw (GDS_CURRENT_FUNCTION);

			std::string evd_path = "C:\\Compiler\\evd";

			EndtTools::IEndtBuilder_var obj = EndtTools::EndtBuilderFactory::make (base.in ());
			obj->build_all (evd_path.c_str ());
		} catch (...) {
			LOG_UEX (("%s", GDS_CURRENT_FUNCTION));
		}
	}

public:
	std::string m_ini;
	std::string m_data_path;
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////

int main (int argc, char* argv []) {
	ACE_initializer init;

	ExecuteStatus ret = es_Success;

	try {
		CompileExecutor (argc, argv).execute ();
	} catch (...) {
		std::cout << std::endl << "Abnormal canceled.." << std::endl << std::endl;
		ret = es_Error;
	}

	return (int) ret;
}

