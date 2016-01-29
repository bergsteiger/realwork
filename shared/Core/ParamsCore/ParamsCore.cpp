////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/ParamsCore/ParamsCore.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> shared::Core::ParamsCore
//
// пакет с основным типами, используемыми при работе с параметрами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Core/sys/core_std_inc.h"
#include "shared/Core/ParamsCore/ParamsCore.h"

namespace Core {


const char* DataNotCorrect::uid () const /*throw ()*/ {
	return "409C1ED1-4FD7-45B2-991C-55B9C18B35E1";
}

const char* DataNotCorrect::what () const throw () {
	//#UC START# *470652F6030D_WHAT_IMPL*
	return "DataNotCorrect (input data is not correct)";
	//#UC END# *470652F6030D_WHAT_IMPL*
}


const char* DataNotFound::uid () const /*throw ()*/ {
	return "09B78C10-4C00-4DF5-8997-0F7F1EAABBAF";
}

const char* DataNotFound::what () const throw () {
	//#UC START# *470651D900FA_WHAT_IMPL*
	return "DataNotFound (input data is not found)";
	//#UC END# *470651D900FA_WHAT_IMPL*
}


ParameterIsMissing::ParameterIsMissing (const std::string& parameter_name)
	: m_parameter_name (parameter_name)
//#UC START# *48CFA9CE037B_BASE_INIT*
//#UC END# *48CFA9CE037B_BASE_INIT*
{
	//#UC START# *48CFA9CE037B_BODY*
	//#UC END# *48CFA9CE037B_BODY*
}

ParameterIsMissing::~ParameterIsMissing () throw () {
}

const char* ParameterIsMissing::uid () const /*throw ()*/ {
	return "9D09FCA8-9A3B-41F2-97BE-6A1DB18228FF";
}

const char* ParameterIsMissing::what () const throw () {
	//#UC START# *48CFA9CE037B_WHAT_IMPL*
	ACE_OS::snprintf (
		m_message
		, 256
		, "Parameter <%s> is missing"
		, m_parameter_name.c_str ()
	);
	return m_message;
	//#UC END# *48CFA9CE037B_WHAT_IMPL*
}


const char* SaveDataFailed::uid () const /*throw ()*/ {
	return "9FB5C317-DF9C-4E5B-9D3B-62F5B9D96E1B";
}

const char* SaveDataFailed::what () const throw () {
	//#UC START# *4706531E0196_WHAT_IMPL*
	return "SaveDataFailed (can't save input data)";
	//#UC END# *4706531E0196_WHAT_IMPL*
}

} // namespace Core

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

