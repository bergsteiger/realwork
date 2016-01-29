////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicTree_i/FindIterator_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicTree_i::FindIterator_i
// ��������� ���������� ������ �������� ��� ��������� FindIterator
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_FINDITERATOR_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_FINDITERATOR_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicTree/DynamicTree.h"
#include "garantServer/src/Global/Core/GTreeC.h"

namespace GblAdapterLib {

class FindIterator_i; // self forward Var
typedef ::Core::Var<FindIterator_i> FindIterator_i_var;
typedef ::Core::Var<const FindIterator_i> FindIterator_i_cvar;

class FindIterator_i_factory;

class FindIterator_i:
	virtual public FindIterator
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (FindIterator_i)
	friend class FindIterator_i_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declarations
private:
	enum IteratorDirection {
		ID_FORWARD
		, ID_BACKWARD
	};

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	FindIterator_i (GTree::FindIterator* iterator);

	virtual ~FindIterator_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	GTree::NodePointer m_cur_node;

	GTree::FindPositionList_var m_cur_pos;

	IteratorDirection m_dir;

	GTree::FindIterator_var m_srv_iter;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from FindIterator
	// ���������� ��������� ����������
	virtual const unsigned long get_count () const;

	// implemented method from FindIterator
	virtual FindPositionList* get_position () const;

	// implemented method from FindIterator
	// ���������� true, ���� ������ ������� �� ���������� ��������
	virtual bool is_first () const;

	// implemented method from FindIterator
	// ���������� true, ���� �� ��������� ����� �������� ������, �.�. position. ����� �������� ��
	// ������, �.�. ����� end ��� ������ ����
	virtual bool is_good () const;

	// implemented method from FindIterator
	// ����������� ��������� �� ��������� �������.
	virtual void next ();

	// implemented method from FindIterator
	// ����������� ��������� �� ���������� �������.
	virtual void prev ();
}; // class FindIterator_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICTREE_I_FINDITERATOR_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
