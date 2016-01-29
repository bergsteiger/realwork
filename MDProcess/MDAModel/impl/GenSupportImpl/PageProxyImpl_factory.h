////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/impl/GenSupportImpl/PageProxyImpl_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::PageProxyImpl
// Заголовк реализации фабрик интерфеса PageProxy для серванта PageProxyImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_PAGEPROXYIMPL_FCTR_H__
#define __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_PAGEPROXYIMPL_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/GenSupport/GenSupportFactories.h"

namespace GenSupportImpl {

/// Interface-factory implementation for PageProxyImpl
class PageProxyImpl_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public GenSupport::PageProxyAbstractFactory
{
public:
	PageProxyImpl_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	GenSupport::PageProxy* get (ServerGate::GenerationContents::ModelElementId_const page_guid);

};

typedef ::Core::Var<PageProxyImpl_factory> PageProxyImpl_factory_var;

} // namespace GenSupportImpl


#endif //__MDPROCESS_MDAMODEL_GENSUPPORTIMPL_PAGEPROXYIMPL_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

