////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/LockStarageDef/PackageInfo.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::RosePackageLocking::LockStarageDef::PackageInfo
//
// хранимая информация о залоченном пакете
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ROSEPACKAGELOCKING_LOCKSTARAGEDEF_PACKAGEINFO_H__
#define __MDPROCESS_ROSEPACKAGELOCKING_LOCKSTARAGEDEF_PACKAGEINFO_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <ostream>

namespace RosePackageLocking {
namespace LockStarageDef {

// хранимая информация о залоченном пакете
class PackageInfo {
	//////////////////////////////////////////////////////////////////////////////////////////
	// self data accessors
public:
	const std::string& get_guid () const;

	void set_guid (const std::string& guid);

	CORBA::Long get_owner_id () const;

	void set_owner_id (CORBA::Long owner_id);

	const std::string& get_full_name () const;

	void set_full_name (const std::string& full_name);

	const std::string& get_time () const;

	void set_time (const std::string& time);

	//////////////////////////////////////////////////////////////////////////////////////////
	// self data
private:
	// идентификатор захваченного пакета
	std::string m_guid;

	// ID пользователя - владельца пакета (тот кто его захватил)
	CORBA::Long m_owner_id;

	// полное имя пакета
	std::string m_full_name;

	// время захвата пакета
	std::string m_time;


}; //class PackageInfo

std::ostream& operator << (std::ostream& out_stream, const PackageInfo& item);
} // namespace LockStarageDef
} // namespace RosePackageLocking



#endif //__MDPROCESS_ROSEPACKAGELOCKING_LOCKSTARAGEDEF_PACKAGEINFO_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
