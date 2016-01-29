////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/MarkConsultingData70_i.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::HCAdapterLib::HCInterfaces_i::MarkConsultingData70_i
// Заголовок реализации класса серванта для интерфеса 
//
// оценка для СК версии 7.0
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_MARKCONSULTINGDATA70_I_H__
#define __GARANT6X_HCADAPTERLIB_HCINTERFACES_I_MARKCONSULTINGDATA70_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/HCAdapterLib/HCInterfaces/HCInterfaces.h"
#include "garant6x/implementation/Garant/HCAdapterLib/impl/HCInterfaces_i/ConsultingData_i.h"

//#UC START# *46DD5C5201F4_CUSTOM_INCLUDES*
//#UC END# *46DD5C5201F4_CUSTOM_INCLUDES*

namespace HCAdapterLib {
namespace HCInterfaces_i {

class MarkConsultingData70_i; // self forward Var
typedef ::Core::Var<MarkConsultingData70_i> MarkConsultingData70_i_var;
typedef ::Core::Var<const MarkConsultingData70_i> MarkConsultingData70_i_cvar;

class MarkConsultingData70_i_factory;

// оценка для СК версии 7.0
class MarkConsultingData70_i:
	virtual public ConsultingData_i
{
	SET_OBJECT_COUNTER (MarkConsultingData70_i)
	friend class MarkConsultingData70_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
private:
	MarkConsultingData70_i (GCI::IO::Stream* xml_stream, const GblConsultingDef::ConsultationID& consultation_id);

	~MarkConsultingData70_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from HCInterfaces::ConsultingData
	// Подтверждение получения данных текущего запроса. При вызове этого метода запрос помечается как
	// переданный на обработку (при получении оценки, как полностью обработанный).
	void data_received () const;

//#UC START# *46DD5C5201F4*
//#UC END# *46DD5C5201F4*
}; // class MarkConsultingData70_i

} // namespace HCInterfaces_i
} // namespace HCAdapterLib


#endif //__GARANT6X_HCADAPTERLIB_HCINTERFACES_I_MARKCONSULTINGDATA70_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
