////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/RosePackageLocking/LockStarageDef/PackageInfo.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<DataElement::Class>> MDProcess::RosePackageLocking::LockStarageDef::PackageInfo
//
// хранимая информация о залоченном пакете
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/RosePackageLocking/LockStarageDef/PackageInfo.h"


namespace RosePackageLocking {
namespace LockStarageDef {

std::ostream& operator << (std::ostream& out_stream, const PackageInfo& item) {
	out_stream << "\"" << item.get_guid () << "\"" << " {" << std::endl;
	out_stream << "owner " << item.get_owner_id () << " ;" << std::endl;
	out_stream << "name " << "\"" << item.get_full_name () << "\"" << " ;" << std::endl;
	out_stream << "time " << "\"" << item.get_time () << "\"" << " ;" << std::endl;
	out_stream << "}" << std::endl;
	return out_stream;
}

//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors
const std::string& PackageInfo::get_guid () const {
	//#UC START# *487AE914028F_GET_ACCESSOR*
	return m_guid;
	//#UC END# *487AE914028F_GET_ACCESSOR*
}

void PackageInfo::set_guid (const std::string& guid) {
	//#UC START# *487AE914028F_SET_ACCESSOR*
	m_guid = guid;
	//#UC END# *487AE914028F_SET_ACCESSOR*
}

CORBA::Long PackageInfo::get_owner_id () const {
	//#UC START# *487AE942028A_GET_ACCESSOR*
	return m_owner_id;
	//#UC END# *487AE942028A_GET_ACCESSOR*
}

void PackageInfo::set_owner_id (CORBA::Long owner_id) {
	//#UC START# *487AE942028A_SET_ACCESSOR*
	m_owner_id = owner_id;
	//#UC END# *487AE942028A_SET_ACCESSOR*
}

const std::string& PackageInfo::get_full_name () const {
	//#UC START# *487AE9FE0144_GET_ACCESSOR*
	return m_full_name;
	//#UC END# *487AE9FE0144_GET_ACCESSOR*
}

void PackageInfo::set_full_name (const std::string& full_name) {
	//#UC START# *487AE9FE0144_SET_ACCESSOR*
	m_full_name = full_name;
	//#UC END# *487AE9FE0144_SET_ACCESSOR*
}

const std::string& PackageInfo::get_time () const {
	//#UC START# *487AEA2000B6_GET_ACCESSOR*
	return m_time;
	//#UC END# *487AEA2000B6_GET_ACCESSOR*
}

void PackageInfo::set_time (const std::string& time) {
	//#UC START# *487AEA2000B6_SET_ACCESSOR*
	m_time = time;
	//#UC END# *487AEA2000B6_SET_ACCESSOR*
}



} // namespace LockStarageDef
} // namespace RosePackageLocking


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

