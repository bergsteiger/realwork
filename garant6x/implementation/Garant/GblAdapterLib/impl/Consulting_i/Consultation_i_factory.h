////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Consultation_i_factory.h"
// генератор заголовочных файлов для фабрик интерфейсов (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Consulting_i::Consultation_i
// Заголовк реализации фабрик интерфеса Consultation для серванта Consultation_i
//
// реализация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_CONSULTING_I_CONSULTATION_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_CONSULTING_I_CONSULTATION_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Consulting/ConsultingFactories.h"
// by <<uses>> back dependencies
#include "garant6x/implementation/Garant/GblAdapterLib/impl/Consulting_i/Consultation_i.h"

/// Servant-factory implementation for Consultation_i
namespace GblAdapterLib {
	class ConsultationManager_i; //forward friend
} // namespace GblAdapterLib


namespace GblAdapterLib {

class Consultation_iServantFactory {
	friend class ConsultationManager_i;

	static Consultation_i* make (GblConsultingClient::Consultation* server_consultation, FoldersNode* folders_node);
};

/// Interface-factory implementation for Consultation_i
class Consultation_i_factory: virtual public ::Core::RefCountObjectBase, virtual public ConsultationAbstractFactory {
	friend class Consultation_iServantFactory;

public:
	Consultation_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	static Consultation_i_factory* s_instance;

	const char* key () const;

	Consultation* make (GblConsultingClient::Consultation* server_consultation, FoldersNode* folders_node);

};

typedef ::Core::Var<Consultation_i_factory> Consultation_i_factory_var;

} // namespace GblAdapterLib

// TypeTraits specializations
namespace Core {	
template <>
struct TypeTraits <GblAdapterLib::Consultation_i> {
	typedef GblAdapterLib::Consultation_iServantFactory Factory;
};
} // namespace Core


#endif //__GARANT6X_GBLADAPTERLIB_CONSULTING_I_CONSULTATION_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

