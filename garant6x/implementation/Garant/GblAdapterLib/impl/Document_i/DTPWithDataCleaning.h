////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithDataCleaning.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DTPWithDataCleaning
// Заголовок реализации класса серванта для интерфеса 
//
// провайдер очищает данные о стиле и тексте после того, как прокидывает их оболочке
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DTPWITHDATACLEANING_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DTPWITHDATACLEANING_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentTextProvider_i.h"

namespace GblAdapterLib {

class DTPWithDataCleaning; // self forward Var
typedef ::Core::Var<DTPWithDataCleaning> DTPWithDataCleaning_var;
typedef ::Core::Var<const DTPWithDataCleaning> DTPWithDataCleaning_cvar;

class DTPWithDataCleaning_factory;

// провайдер очищает данные о стиле и тексте после того, как прокидывает их оболочке
class DTPWithDataCleaning:
	virtual public DocumentTextProvider_i
{
	SET_OBJECT_COUNTER (DTPWithDataCleaning)
	friend class DTPWithDataCleaning_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DTPWithDataCleaning (GblPilot::Document* server_doc, const GblPilot::HighlightHandle& handle, bool all_at_once);

	DTPWithDataCleaning (GblPilot::Document* server_doc, unsigned long handle, bool all_at_once);

	virtual ~DTPWithDataCleaning ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DocumentTextProvider
	virtual const EVDStream* get_child_evd_style (const EntryPoint& id) /*throw (InvalidEntryPoint)*/;

	// implemented method from DocumentTextProvider
	virtual const GCI::IO::String* get_child_text (const EntryPoint& id) /*throw (InvalidEntryPoint)*/;
}; // class DTPWithDataCleaning

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DTPWITHDATACLEANING_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
