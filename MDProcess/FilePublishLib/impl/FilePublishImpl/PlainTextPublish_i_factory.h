////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/FilePublishLib/impl/FilePublishImpl/PlainTextPublish_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::FilePublishLib::FilePublishImpl::PlainTextPublish_i
// Заголовк реализации фабрик интерфеса PlainTextPublish для серванта PlainTextPublish_i
//
// конвертит файл в тест и публикует его
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_FILEPUBLISHLIB_FILEPUBLISHIMPL_PLAINTEXTPUBLISH_I_FCTR_H__
#define __MDPROCESS_FILEPUBLISHLIB_FILEPUBLISHIMPL_PLAINTEXTPUBLISH_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/FilePublishLib/FilePublish/FilePublishFactories.h"

namespace FilePublishLib {
namespace FilePublishImpl {

/// Interface-factory implementation for PlainTextPublish_i
class PlainTextPublish_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public FilePublish::PlainTextPublishAbstractFactory
{
public:
	PlainTextPublish_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	FilePublish::PlainTextPublish* make ();

};

typedef ::Core::Var<PlainTextPublish_i_factory> PlainTextPublish_i_factory_var;

} // namespace FilePublishImpl
} // namespace FilePublishLib


#endif //__MDPROCESS_FILEPUBLISHLIB_FILEPUBLISHIMPL_PLAINTEXTPUBLISH_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

