////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/GCL/network/common_network_operations.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::GCL::network::common_network_operations
//
// Общие функции для работы с сетью
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_GCL_NETWORK_COMMON_NETWORK_OPERATIONS_H__
#define __SHARED_GCL_NETWORK_COMMON_NETWORK_OPERATIONS_H__

#include "shared/Core/sys/std_inc.h"

//#UC START# *45753171035B_USER_INCLUDES*
//#UC END# *45753171035B_USER_INCLUDES*

namespace GCL {

// Не смогли получить список айпишников
class CantGetIpList : public ::Core::Exception {
public:
	const char* what () const throw ();

private:
	const char* uid () const /*throw ()*/;

};

// Возвращает true, если на машине настроены ip-адреса, отличные от loopback интерфейса
bool is_ip_adresses_configured () /*throw (CantGetIpList)*/;

//#UC START# *45753171035B_USER_DEFINITION*
//#UC END# *45753171035B_USER_DEFINITION*

} // namespace GCL


#endif //__SHARED_GCL_NETWORK_COMMON_NETWORK_OPERATIONS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
