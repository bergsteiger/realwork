////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/FilePublishLib/FilePublish/FilePublish.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Interfaces::Category>> MDProcess::FilePublishLib::FilePublish
//
// публикация файла как результата теста
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_FILEPUBLISHLIB_FILEPUBLISH_H__
#define __MDPROCESS_FILEPUBLISHLIB_FILEPUBLISH_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <vector>
#include "MDProcess/BuildTestLib/TestResults/TestResults.h"

namespace FilePublishLib {
namespace FilePublish {

// набор результатов функциональных тестов
typedef std::vector < BuildTestLib::TestResults::FunctionalTest_var > FunctionalTestSuite;

class PlainTextPublish;
typedef ::Core::Var<PlainTextPublish> PlainTextPublish_var;
typedef ::Core::Var<const PlainTextPublish> PlainTextPublish_cvar;
// публикует plain text файл как результат теста
class PlainTextPublish
	: virtual public ::Core::IObject
{
public:
	// публикует текстовый файл как результат функционального теста
	virtual void post_as_functional_test (const std::string& file_path, const std::string& page_id) = 0;
};

/// factory interface for PlainTextPublish
class PlainTextPublishFactory {
public:
	// фабрика
	static PlainTextPublish* make ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

class PlainText2FunctionalTest;
typedef ::Core::Var<PlainText2FunctionalTest> PlainText2FunctionalTest_var;
typedef ::Core::Var<const PlainText2FunctionalTest> PlainText2FunctionalTest_cvar;
// конвертер plain-text файла в функциональный тест
class PlainText2FunctionalTest
	: virtual public ::Core::IObject
{
public:
	// собственно метод конвертации plain text в FunctionalTest
	virtual FunctionalTestSuite* convert (const std::string& file_path) const = 0;
};

/// factory interface for PlainText2FunctionalTest
class PlainText2FunctionalTestFactory {
public:
	// фабрика
	static PlainText2FunctionalTest& get ()
		/*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/;
};

} // namespace FilePublish
} // namespace FilePublishLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <FilePublishLib::FilePublish::PlainTextPublish> {
	typedef FilePublishLib::FilePublish::PlainTextPublishFactory Factory;
};
template <>
struct TypeTraits <FilePublishLib::FilePublish::PlainText2FunctionalTest> {
	typedef FilePublishLib::FilePublish::PlainText2FunctionalTestFactory Factory;
};
} // namespace Core


#endif //__MDPROCESS_FILEPUBLISHLIB_FILEPUBLISH_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
