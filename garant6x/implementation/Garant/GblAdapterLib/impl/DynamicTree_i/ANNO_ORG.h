////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ANNO_ORG.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::ANNO_ORG
// ��������� ���������� ������ �������� ��� ��������� 
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ANNO_ORG_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ANNO_ORG_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class ANNO_ORG; // self forward Var
typedef ::Core::Var<ANNO_ORG> ANNO_ORG_var;
typedef ::Core::Var<const ANNO_ORG> ANNO_ORG_cvar;

class ANNO_ORG_factory;

class ANNO_ORG:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (ANNO_ORG)
	friend class ANNO_ORG_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~ANNO_ORG ();
}; // class ANNO_ORG

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ANNO_ORG_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
