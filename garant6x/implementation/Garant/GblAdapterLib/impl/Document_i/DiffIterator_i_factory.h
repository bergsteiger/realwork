////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/DiffIterator_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::DiffIterator_i
// �������� ���������� ������ ��������� DiffIterator ��� �������� DiffIterator_i
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DIFFITERATOR_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DIFFITERATOR_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for DiffIterator_i
class DiffIterator_i_factory: virtual public ::Core::RefCountObjectBase, virtual public DiffIteratorAbstractFactory {
public:
	DiffIterator_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const char* key () const;

	DiffIterator* make (const GblPilot::DiffData& diff_data);

};

typedef ::Core::Var<DiffIterator_i_factory> DiffIterator_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_DIFFITERATOR_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

