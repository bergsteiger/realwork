////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DocWithPid.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::Document_i::DocWithPid
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCWITHPID_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCWITHPID_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garantServer/src/Global/Core/gcdC.h"

namespace GblAdapterLib {

class DocWithPid {
// virtual void destructor
public:
	virtual ~DocWithPid () {};

//////////////////////////////////////////////////////////////////////////////////////////
// abstarct methods
public:
	virtual const GCD::PID& get_document_pid () const = 0;

}; // class DocWithPid

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DOCWITHPID_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

