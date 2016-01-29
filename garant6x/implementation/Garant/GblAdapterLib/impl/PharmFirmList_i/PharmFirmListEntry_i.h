////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/PharmFirmList_i/PharmFirmListEntry_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::PharmFirmList_i::PharmFirmListEntry_i
// ��������� ���������� ������ �������� ��� ��������� PharmFirmListEntry
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_I_PHARMFIRMLISTENTRY_I_H__
#define __GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_I_PHARMFIRMLISTENTRY_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTypes/BaseTypes.h"
#include "garant6x/implementation/Garant/GblAdapterLib/PharmFirmList/PharmFirmList.h"

namespace GblAdapterLib {

class PharmFirmListEntry_i; // self forward Var
typedef ::Core::Var<PharmFirmListEntry_i> PharmFirmListEntry_i_var;
typedef ::Core::Var<const PharmFirmListEntry_i> PharmFirmListEntry_i_cvar;

class PharmFirmListEntry_i_factory;

class PharmFirmListEntry_i:
	virtual public PharmFirmListEntry
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (PharmFirmListEntry_i)
	friend class PharmFirmListEntry_i_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	PharmFirmListEntry_i (GCD::ObjectID id);

	virtual ~PharmFirmListEntry_i ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ������������� ���������
	ObjectId m_document_id;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from EntityBase
	// ��������� � ����  ���������� ��������� �������.
	// ��������� � � ����� ������������ �������
	virtual EntityStorage* append_to (
		EntityStorage* storage
	) /*throw (
		ConstantModify
		, AccessDenied
		, Unsupported
		, CanNotSave
	)*/;

	// implemented method from EntityBase
	// �������������
	virtual const unsigned long get_eid () const
		/*throw (Unsupported)*/;

	// implemented method from EntityBase
	// �������� �����������
	virtual bool get_is_changed () const;

	// implemented method from EntityBase
	// ������� ���� ��� ������ ������ ��� �������� � ���� ������. ��� �� ����������� ������� �������
	// ���������� ������� ����� �������� (���� ����� �����). ��� �� ����������� �������� �������� save
	// ������ ����������.
	virtual bool get_is_saved () const;

	// implemented method from EntityBase
	// ������������ �������� ������� ���������.
	virtual EntityStorage* save_to (
		EntityStorage* storage
	) /*throw (
		AccessDenied
		, Unsupported
		, NotSaved
		, DuplicateNode
		, CanNotSave
	)*/;

	// implemented method from PharmFirmListEntry
	virtual Document* get_document () const;
}; // class PharmFirmListEntry_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_PHARMFIRMLIST_I_PHARMFIRMLISTENTRY_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
