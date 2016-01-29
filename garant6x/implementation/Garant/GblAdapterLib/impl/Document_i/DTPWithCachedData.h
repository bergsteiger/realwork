////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DTPWithCachedData.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DTPWithCachedData
// Заголовок реализации класса серванта для интерфеса 
//
// Провайдер кеширует стиль и текст на адаптере
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DTPWITHCACHEDDATA_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DTPWITHCACHEDDATA_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocumentTextProvider_i.h"

namespace GblAdapterLib {

class DTPWithCachedData; // self forward Var
typedef ::Core::Var<DTPWithCachedData> DTPWithCachedData_var;
typedef ::Core::Var<const DTPWithCachedData> DTPWithCachedData_cvar;

class DTPWithCachedData_factory;

// Провайдер кеширует стиль и текст на адаптере
class DTPWithCachedData:
	virtual public DocumentTextProvider_i
{
	SET_OBJECT_COUNTER (DTPWithCachedData)
	friend class DTPWithCachedData_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DTPWithCachedData (GblPilot::Document* server_doc, const GblPilot::HighlightHandle& handle, bool all_at_once);

	DTPWithCachedData (GblPilot::Document* server_doc, unsigned long handle, bool all_at_once);

	virtual ~DTPWithCachedData ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DocumentTextProvider
	virtual const EVDStream* get_child_evd_style (const EntryPoint& id) /*throw (InvalidEntryPoint)*/;

	// implemented method from DocumentTextProvider
	virtual const GCI::IO::String* get_child_text (const EntryPoint& id) /*throw (InvalidEntryPoint)*/;
}; // class DTPWithCachedData

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DTPWITHCACHEDDATA_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
