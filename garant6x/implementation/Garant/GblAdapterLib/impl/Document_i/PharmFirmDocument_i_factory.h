////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/Document_i/PharmFirmDocument_i_factory.h"
// ��������� ������������ ������ ��� ������ ����������� (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::Document_i::PharmFirmDocument_i
// �������� ���������� ������ ���������  ��� �������� PharmFirmDocument_i
//
// �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_PHARMFIRMDOCUMENT_I_FCTR_H__
#define __GARANT6X_GBLADAPTERLIB_DOCUMENT_I_PHARMFIRMDOCUMENT_I_FCTR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/Document/DocumentFactories.h"

namespace GblAdapterLib {

/// Interface-factory implementation for PharmFirmDocument_i
class PharmFirmDocument_i_factory: virtual public ::Core::RefCountObjectBase, virtual public DocumentAbstractFactory {
public:
	PharmFirmDocument_i_factory ();

	void registrate_me (Core::Root::FactoryPriority priority) /*throw (Core::Root::DuplicatedFactoryKey)*/;

protected:
	const FactoryKey key () const;

	Document* make (GblPilot::Document* document);

	Document* make (const GCD::PID& pid, bool is_edition, const char* name);

};

typedef ::Core::Var<PharmFirmDocument_i_factory> PharmFirmDocument_i_factory_var;

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DOCUMENT_I_PHARMFIRMDOCUMENT_I_FCTR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

