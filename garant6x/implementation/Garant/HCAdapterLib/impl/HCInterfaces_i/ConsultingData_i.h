////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/ConsultingData_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::ConsultingData_i
// Заголовок реализации класса серванта для интерфеса OnlineData
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_CONSULTINGDATA_I_H__
#define __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_CONSULTINGDATA_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/GCI/IO/IO.h"
#include "garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfaces.h"
#include "garantServer/src/Business/GblConsulting/GblConsultingDefC.h"

namespace HCAdapterLib {
namespace HCInterfaces_i {

class ConsultingData_i; // self forward Var
typedef ::Core::Var<ConsultingData_i> ConsultingData_i_var;
typedef ::Core::Var<const ConsultingData_i> ConsultingData_i_cvar;

class ConsultingData_i:
	virtual public HCInterfaces::OnlineData
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ConsultingData_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ConsultingData_i (GCI::IO::Stream* xml_stream, const GblConsultingDef::ConsultationID& consultation_id);

	virtual ~ConsultingData_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
protected:
	// получить идентификатор консультации
	virtual const GblConsultingDef::ConsultationID& get_cached_consultation_id () const;

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GblConsultingDef::ConsultationID m_consultation_id;

	GCI::IO::Stream_var m_xml_stream;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from HCInterfaces::ConsultingData
	// Получение данных запроса. Возвращается запрос (оценка) в XML формате (описание см в реквизите).
	virtual GCI::IO::Stream* get_data ();
}; // class ConsultingData_i

} // namespace HCInterfaces_i
} // namespace HCAdapterLib


#endif //__GARANT6X_HCADAPTERLIB_HCINTERFACES_I_CONSULTINGDATA_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
