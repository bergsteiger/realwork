////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/ANNO_TAX.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::ANNO_TAX
// ��������� ���������� ������ �������� ��� ��������� 
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ANNO_TAX_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ANNO_TAX_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/NodeBase_i.h"

namespace GblAdapterLib {

class ANNO_TAX; // self forward Var
typedef ::Core::Var<ANNO_TAX> ANNO_TAX_var;
typedef ::Core::Var<const ANNO_TAX> ANNO_TAX_cvar;

class ANNO_TAX_factory;

class ANNO_TAX:
	virtual public NodeBase_i
{
	SET_OBJECT_COUNTER (ANNO_TAX)
	friend class ANNO_TAX_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~ANNO_TAX ();
}; // class ANNO_TAX

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_ANNO_TAX_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
