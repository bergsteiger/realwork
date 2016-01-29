////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/ParamsCore/ParamsCore.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Core::ParamsCore
//
// пакет с основным типами, используемыми при работе с параметрами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_PARAMSCORE_H__
#define __SHARED_CORE_PARAMSCORE_H__

#include "shared/Core/sys/core_std_inc.h"
#include <vector>

namespace Core {

// input data is not correct
class DataNotCorrect : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// input data is not found
class DataNotFound : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Parameter is missing
class ParameterIsMissing : public ::Core::Exception {
public:
	ParameterIsMissing (const std::string& parameter_name);

	virtual ~ParameterIsMissing () throw ();

	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

private:
	mutable char m_message[256];
	// имя пропущенного параметра
	std::string m_parameter_name;
};

// can't save input data
class SaveDataFailed : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// пписок параметров
typedef std::vector < std::string > ParamArgs;

} // namespace Core


#endif //__SHARED_CORE_PARAMSCORE_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
