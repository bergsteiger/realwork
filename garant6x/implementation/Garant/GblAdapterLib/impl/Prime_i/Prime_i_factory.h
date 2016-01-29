////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Prime_i/Prime_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Prime_i::Prime_i
// �������� ���������� ������ ��������� Prime ��� �������� Prime_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PRIME_I_PRIME_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_PRIME_I_PRIME_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Prime/PrimeFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for Prime_i
class Prime_i_factory: virtual public ::Core::RefCountObjectBase, virtual public PrimeAbstractFactory {
public:
	Prime_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	Prime* make (PrimeKey key, const char* name, GblFoldersAdap::SavedQueryData query);

};

typedef ::Core::Var<Prime_i_factory> Prime_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PRIME_I_PRIME_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

