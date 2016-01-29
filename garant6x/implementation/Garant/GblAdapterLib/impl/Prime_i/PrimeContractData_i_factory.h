////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/PrimeContractData_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Prime_i::PrimeContractData_i
// �������� ���������� ������ ��������� PrimeContractData ��� �������� PrimeContractData_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PRIME_I_PRIMECONTRACTDATA_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_PRIME_I_PRIMECONTRACTDATA_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Prime/PrimeFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for PrimeContractData_i
class PrimeContractData_i_factory:
	virtual public ::Core::RefCountObjectBase
	, virtual public PrimeContractDataAbstractFactory
{
public:
	PrimeContractData_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	PrimeContractData* get_contract_data (Query* query);

};

typedef ::Core::Var<PrimeContractData_i_factory> PrimeContractData_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PRIME_I_PRIMECONTRACTDATA_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

