////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/OfflineConsultingData_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::OfflineConsultingData_i
// Заголовок реализации класса серванта для интерфеса OfflineData
//
// Реализация работы консультаций, доставляемых вручную.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_OFFLINECONSULTINGDATA_I_H__
#define __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_OFFLINECONSULTINGDATA_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfaces.h"

namespace HCAdapterLib {
namespace HCInterfaces_i {

class OfflineConsultingData_i; // self forward Var
typedef ::Core::Var<OfflineConsultingData_i> OfflineConsultingData_i_var;
typedef ::Core::Var<const OfflineConsultingData_i> OfflineConsultingData_i_cvar;

class OfflineConsultingData_i_factory;

// Реализация работы консультаций, доставляемых вручную.
class OfflineConsultingData_i:
	virtual public HCInterfaces::OfflineData
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (OfflineConsultingData_i)
	friend class OfflineConsultingData_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	OfflineConsultingData_i (GCI::IO::Stream* xml_stream);

	virtual ~OfflineConsultingData_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GCI::IO::Stream_var m_xml_stream;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from HCInterfaces::ConsultingData
	// Подтверждение получения данных текущего запроса. При вызове этого метода запрос помечается как
	// переданный на обработку (при получении оценки, как полностью обработанный).
	virtual void data_received () const;

	// implemented method from HCInterfaces::ConsultingData
	// Получение данных запроса. Возвращается запрос (оценка) в XML формате (описание см в реквизите).
	virtual GCI::IO::Stream* get_data ();
}; // class OfflineConsultingData_i

} // namespace HCInterfaces_i
} // namespace HCAdapterLib


#endif //__GARANT6X_HCADAPTERLIB_HCINTERFACES_I_OFFLINECONSULTINGDATA_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
