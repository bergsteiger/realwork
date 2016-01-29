////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Writer_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::UsersImportLib::UsersImport_i::Writer_i
// Заголовк реализации фабрик интерфеса DataWriter для серванта Writer_i
//
// передаёт на сервер заданные данные для создания пользователя
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_WRITER_I_FCTR_H__
#define __GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_WRITER_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/UsersImportLib/UsersImport/UsersImportFactories.h"
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/UsersImport_i.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/UsersImportLib/impl/UsersImport_i/Writer_i.h"

/// Servant-factory implementation for Writer_i
class UsersImportMain; //forward friend

namespace UsersImport_i {

class Writer_iServantFactory {
	friend class UsersImportMain;

	static Writer_i* make ();
};

/// Interface-factory implementation for Writer_i
class Writer_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public UsersImport::DataWriterAbstractFactory
{
	friend class Writer_iServantFactory;

public:
	Writer_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static Writer_i_factory* s_instance;

	const char* key () const;

	UsersImport::DataWriter* make ();

};

typedef ::Core::Var<Writer_i_factory> Writer_i_factory_var;

} // namespace UsersImport_i

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <UsersImport_i::Writer_i> {
	typedef UsersImport_i::Writer_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_USERSIMPORTLIB_USERSIMPORT_I_WRITER_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

