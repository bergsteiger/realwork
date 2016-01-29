////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/ContextSearch/MorphoBase/PosContainer_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::ContextSearch::MorphoBase::PosContainer_i
//
// ������������� IPosContainer
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CONTEXTSEARCH_MORPHOBASE_POSCONTAINER_I_H__
#define __SHARED_CONTEXTSEARCH_MORPHOBASE_POSCONTAINER_I_H__

#include "shared/Core/sys/std_inc.h"
#include "shared/DB/DBCore/DBCore.h"

namespace ContextSearch {

// ������������� IPosContainer
class PosContainer_i;
typedef Core::Var<PosContainer_i> PosContainer_i_var;
typedef Core::Var<const PosContainer_i> PosContainer_i_cvar;

class PosContainer_i :
	virtual public DBCore::IPosContainer
	, virtual public Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (PosContainer_i)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
public:
	PosContainer_i (size_t max_fragment, size_t sz);

public:
	virtual ~PosContainer_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ��������
	bool check (unsigned long pos);

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	DBCore::ContextPositions m_data;

	bool m_has_block;

	size_t m_max_fragment;

	const DBCore::ULongVector* m_min;

	size_t m_pos;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DBCore::IPosContainer
	// ��������
	virtual bool add (unsigned long val);

	// implemented method from DBCore::IPosContainer
	// ��������
	virtual bool add (unsigned long pos, unsigned long flags);

	// implemented method from DBCore::IPosContainer
	// ������
	virtual const DBCore::ContextPositions& get () const;

	// implemented method from DBCore::IPosContainer
	// ����� ������� �������
	virtual bool has_block () const;

	// implemented method from DBCore::IPosContainer
	// ������ �� ������� �������
	virtual const DBCore::ULongVector& ref () const;

	// implemented method from DBCore::IPosContainer
	// ��������
	virtual void reset ();

	// implemented method from DBCore::IPosContainer
	// ���������� �� �������
	virtual void set (size_t pos);

	// implemented method from DBCore::IPosContainer
	// ��������� �� ������ � ����������� ������� ���������
	virtual void set_min (const DBCore::ULongVector& in);
}; // class PosContainer_i

} // namespace ContextSearch


#endif //__SHARED_CONTEXTSEARCH_MORPHOBASE_POSCONTAINER_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

