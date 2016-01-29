////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/GenSupportImpl/ErrorManagerImpl.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::ErrorManagerImpl
//
// реалиазция менеджера ошибок
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/LibHome.h"
#include "MDProcess/MDAModel/impl/GenSupportImpl/ErrorManagerImpl.h"
// by <<uses>> dependencies
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"
#include "MDProcess/MDAModel/RoseDumpers/RoseAbstractDumper.h"
#include "boost/lambda/bind.hpp"
#include "boost/lambda/lambda.hpp"

namespace GenSupportImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

ErrorManagerImpl::ErrorManagerImpl ()
//#UC START# *4BDFCDCD0213_4BDFDF77036B_4BDFDFB1001F_BASE_INIT*
//#UC END# *4BDFCDCD0213_4BDFDF77036B_4BDFDFB1001F_BASE_INIT*
{
	//#UC START# *4BDFCDCD0213_4BDFDF77036B_4BDFDFB1001F_BODY*
	//#UC END# *4BDFCDCD0213_4BDFDF77036B_4BDFDFB1001F_BODY*
}

ErrorManagerImpl::~ErrorManagerImpl () {
	//#UC START# *4BDFDFB1001F_DESTR_BODY*
	//#UC END# *4BDFDFB1001F_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

const GenSupport::ErrorInfoList& ErrorManagerImpl::get_errors () const {
	//#UC START# *4BDFDFE2032C_GET_ACCESSOR*
	return m_errors;
	//#UC END# *4BDFDFE2032C_GET_ACCESSOR*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from GenSupport::ErrorManager
// очищает список ошибок
void ErrorManagerImpl::clear_errors () {
	//#UC START# *4BDFDF5C0203_4BDFDFB1001F*
	m_errors.clear ();
	//#UC END# *4BDFDF5C0203_4BDFDFB1001F*
}

// implemented method from GenSupport::ErrorManager
// очищает список ошибок, которые случились в контексте какого-то элемента
void ErrorManagerImpl::clear_only_dumper_errors () {
	//#UC START# *4BE25CB60246_4BDFDFB1001F*
	std::remove_if (
		m_errors.begin ()
		, m_errors.end ()
		, boost::lambda::bind (&GenSupport::ErrorInfo::dumper, boost::lambda::_1) != (const Base::Dumper*)0
	);
	//#UC END# *4BE25CB60246_4BDFDFB1001F*
}

// implemented method from GenSupport::ErrorManager
// добавляет информацию о случившейся ошибке
void ErrorManagerImpl::error (const Base::Dumper* dumper, const std::string& message, const std::string& alter_name) {
	//#UC START# *4BDFDDC200EA_4BDFDFB1001F*
	GenSupport::ErrorInfo info;
	info.dumper = dumper;
	info.message = message;
	info.alternative_name = alter_name;

	m_errors.push_back (info);
	//#UC END# *4BDFDDC200EA_4BDFDFB1001F*
}

// implemented method from GenSupport::ErrorManager
// информация о фатальной ошибке, если не отключена реакция на ошибки - выбрасывается исключение
void ErrorManagerImpl::fatal_error (
	const Base::Dumper* dumper
	, const std::string& message
	, const std::string& alter_name
) /*throw (
	Base::FatalError
)*/ {
	//#UC START# *4BDFDDF20148_4BDFDFB1001F*
	this->error (dumper, message, alter_name);

	if (!GenSupport::EnvironmentFactory::get ().get_suppress_generation_errors ()) {
		throw Base::FatalError (message);
	}
	//#UC END# *4BDFDDF20148_4BDFDFB1001F*
}

// implemented method from GenSupport::ErrorManager
// фатальная ошибка при работе с элементом с идентификатором = uid
void ErrorManagerImpl::fatal_error (
	const std::string& uid
	, const std::string& message
	, const std::string& alter_name
) {
	//#UC START# *4BE0F11A0109_4BDFDFB1001F*
	const Base::Dumper* dumper = RoseAbstractDumper::find_in_tree (uid);

	this->fatal_error (dumper, message, alter_name);

	if (!dumper) {
		GenSupport::LogManagerFactory::get ().log_error ("Не удалось найти элемент с идентификатором: \"" + uid + "\"");
	}
	//#UC END# *4BE0F11A0109_4BDFDFB1001F*
}
} // namespace GenSupportImpl

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

