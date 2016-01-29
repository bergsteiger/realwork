////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/XMLIniConverterLib/ConverterStarter.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<LibExecutor::Class>> garant6x::XMLIniConverterLib::LibSupport::ConverterStarter
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_XMLINICONVERTERLIB_LIBSUPPORT_CONVERTERSTARTER_H__
#define __GARANT6X_XMLINICONVERTERLIB_LIBSUPPORT_CONVERTERSTARTER_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/Core/impl/Root_i/ExecutorBase.h"
#include "garant6x/implementation/Garant/XMLIniConverterLib/IniConverter/IniConverter.h"

//#UC START# *45E43FDF02CE_CUSTOM_INCLUDES*
//#UC END# *45E43FDF02CE_CUSTOM_INCLUDES*
namespace XMLIniConverterLib {


class ConverterStarter : virtual public Core::Root_i::ExecutorBase {
	SET_OBJECT_COUNTER (ConverterStarter)		

//////////////////////////////////////////////////////////////////////////////////////////
// static member methods
private:
	REFCOUNT_SINGLETON(ConverterStarter)

public:
	static ConverterStarter& get () {
		return Singleton::instance();
	}		


private:
	static void handle_control (int sig);
	
	void execute_ ();	
	
	void finalize ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:

	virtual void create_path (
		const char* path
		, const char* extension
		, const std::string& version
		, std::string& result
	) const;

	// получить путь к каталогу с бинарником. метод непереносим.
	virtual void get_app_path (char* buf, size_t len) const;

	virtual void print_result (const char* path, const IniConverter::IniFile* file) const;

	// описание командной строки утилиты
	virtual void usage () const;


//#UC START# *45E43FDF02CE*
//#UC END# *45E43FDF02CE*
}; // class ConverterStarter

} // namespace XMLIniConverterLib


#endif //__GARANT6X_XMLINICONVERTERLIB_LIBSUPPORT_CONVERTERSTARTER_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
