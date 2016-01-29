////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/FilePublishLib/impl/FilePublishImpl/PlainText2FunctionalTest.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::FilePublishLib::FilePublishImpl::PlainText2FunctionalTest
// Заголовок реализации класса серванта для интерфеса PlainText2FunctionalTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_FILEPUBLISHLIB_FILEPUBLISHIMPL_PLAINTEXT2FUNCTIONALTEST_H__
#define __MDPROCESS_FILEPUBLISHLIB_FILEPUBLISHIMPL_PLAINTEXT2FUNCTIONALTEST_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/FilePublishLib/FilePublish/FilePublish.h"

namespace FilePublishLib {
namespace FilePublishImpl {

class PlainText2FunctionalTest; // self forward Var
typedef ::Core::Var<PlainText2FunctionalTest> PlainText2FunctionalTest_var;
typedef ::Core::Var<const PlainText2FunctionalTest> PlainText2FunctionalTest_cvar;

class PlainText2FunctionalTest_factory;

class PlainText2FunctionalTest:
	virtual public FilePublish::PlainText2FunctionalTest
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (PlainText2FunctionalTest)
	friend class PlainText2FunctionalTest_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PlainText2FunctionalTest ();

	virtual ~PlainText2FunctionalTest ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from FilePublish::PlainText2FunctionalTest
	// собственно метод конвертации plain text в FunctionalTest
	virtual FilePublish::FunctionalTestSuite* convert (const std::string& file_path) const;
}; // class PlainText2FunctionalTest

} // namespace FilePublishImpl
} // namespace FilePublishLib


#endif //__MDPROCESS_FILEPUBLISHLIB_FILEPUBLISHIMPL_PLAINTEXT2FUNCTIONALTEST_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
