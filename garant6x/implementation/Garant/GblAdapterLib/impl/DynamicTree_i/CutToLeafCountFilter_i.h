////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/CutToLeafCountFilter_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::CutToLeafCountFilter_i
// ��������� ���������� ������ �������� ��� ��������� CutToLeafCountFilter
//
// ���������� ������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_CUTTOLEAFCOUNTFILTER_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_CUTTOLEAFCOUNTFILTER_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"

namespace GblAdapterLib {

class CutToLeafCountFilter_i; // self forward Var
typedef ::Core::Var<CutToLeafCountFilter_i> CutToLeafCountFilter_i_var;
typedef ::Core::Var<const CutToLeafCountFilter_i> CutToLeafCountFilter_i_cvar;

class CutToLeafCountFilter_i_factory;

// ���������� ������� ��������
class CutToLeafCountFilter_i:
	virtual public CutToLeafCountFilter
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (CutToLeafCountFilter_i)
	friend class CutToLeafCountFilter_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CutToLeafCountFilter_i (unsigned long leaf_count);

	CutToLeafCountFilter_i ();

	virtual ~CutToLeafCountFilter_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ������������ ����� ������� � ������
	unsigned long m_leaf_count;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from CutToLeafCountFilter
	// �������� ����� ������� ��� �������
	virtual unsigned long get_leaf_count () const;

	virtual void set_leaf_count (unsigned long leaf_count);
}; // class CutToLeafCountFilter_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_CUTTOLEAFCOUNTFILTER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
