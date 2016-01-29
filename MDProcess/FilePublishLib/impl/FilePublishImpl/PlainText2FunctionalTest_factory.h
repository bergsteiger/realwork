////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/FilePublishLib/impl/FilePublishImpl/PlainText2FunctionalTest_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::FilePublishLib::FilePublishImpl::PlainText2FunctionalTest
// Заголовк реализации фабрик интерфеса PlainText2FunctionalTest для серванта PlainText2FunctionalTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_FILEPUBLISHLIB_FILEPUBLISHIMPL_PLAINTEXT2FUNCTIONALTEST_FCTR_H__
#define __MDPROCESS_FILEPUBLISHLIB_FILEPUBLISHIMPL_PLAINTEXT2FUNCTIONALTEST_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/FilePublishLib/FilePublish/FilePublishFactories.h"

namespace FilePublishLib {
namespace FilePublishImpl {

/// Interface-factory implementation for PlainText2FunctionalTest
class PlainText2FunctionalTest_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public FilePublish::PlainText2FunctionalTestAbstractFactory
{
public:
	PlainText2FunctionalTest_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	FilePublish::PlainText2FunctionalTest* get ();

};

typedef ::Core::Var<PlainText2FunctionalTest_factory> PlainText2FunctionalTest_factory_var;

} // namespace FilePublishImpl
} // namespace FilePublishLib


#endif //__MDPROCESS_FILEPUBLISHLIB_FILEPUBLISHIMPL_PLAINTEXT2FUNCTIONALTEST_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

