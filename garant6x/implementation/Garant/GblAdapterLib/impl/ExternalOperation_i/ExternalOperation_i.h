////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/ExternalOperation_i/ExternalOperation_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::ExternalOperation_i::ExternalOperation_i
// Заголовок реализации класса серванта для интерфеса ExternalOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_EXTERNALOPERATION_I_EXTERNALOPERATION_I_H__
#define __GARANT6X_GBLADAPTERLIB_EXTERNALOPERATION_I_EXTERNALOPERATION_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/ExternalOperation/ExternalOperation.h"

namespace GblAdapterLib {

class ExternalOperation_i; // self forward Var
typedef ::Core::Var<ExternalOperation_i> ExternalOperation_i_var;
typedef ::Core::Var<const ExternalOperation_i> ExternalOperation_i_cvar;

class ExternalOperation_i_factory;

class ExternalOperation_i:
	virtual public ExternalOperation
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ExternalOperation_i)
	friend class ExternalOperation_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ExternalOperation_i (ObjectId id);

	virtual ~ExternalOperation_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	ObjectId m_id;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ExternalOperation
	virtual ObjectId get_id () const;
}; // class ExternalOperation_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_EXTERNALOPERATION_I_EXTERNALOPERATION_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
