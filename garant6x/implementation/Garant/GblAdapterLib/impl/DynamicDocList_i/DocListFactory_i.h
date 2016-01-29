////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/impl/DynamicDocList_i/DocListFactory_i.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> garant6x::GblAdapterLib::DynamicDocList_i::DocListFactory_i
// ��������� ���������� ������ �������� ��� ��������� DocListFactory
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DOCLISTFACTORY_I_H__
#define __GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DOCLISTFACTORY_I_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "ace/Singleton.h"
#include "garant6x/implementation/Garant/GblAdapterLib/DynamicDocList/DynamicDocList.h"

//#UC START# *4D95C9DD0174_CUSTOM_INCLUDES*
//#UC END# *4D95C9DD0174_CUSTOM_INCLUDES*

namespace GblAdapterLib {

class DocListFactory_i; // self forward Var
typedef ::Core::Var<DocListFactory_i> DocListFactory_i_var;
typedef ::Core::Var<const DocListFactory_i> DocListFactory_i_cvar;

class DocListFactory_i_factory;

class DocListFactory_i:
	virtual public DocListFactory
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (DocListFactory_i)
	friend class DocListFactory_i_factory; // self factory

	// singleton declaration
	typedef ACE_Singleton <DocListFactory_i, ACE_SYNCH_RECURSIVE_MUTEX> Singleton;
	friend class ACE_Singleton <DocListFactory_i, ACE_SYNCH_RECURSIVE_MUTEX>;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DocListFactory_i ();

	virtual ~DocListFactory_i ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DocListFactory
	// ��������� ������ �� ������ �� ����� file_name.
	// inner_numbers - ���� ����������� ����� ������ ���������� ������������ (���� inner_numbers=true
	// - ����������)
	// 
	// ������ ����� (�195757811):
	// <����� ������>{.<����� ����/�����>}{<������ ��� ���������><����� �������>}
	// <����� ������>{.<����� ����/�����>}{<������ ��� ���������><����� �������>}
	// <����� ������>{.<����� ����/�����>}{<������ ��� ���������><����� �������>}
	// ...
	// 
	// ����������:
	// AccessDenied - �� ������ ��������� ������ �� �����
	// InvalidType - � ����� ������������ ������
	virtual DynList* make_list (const char* file_name, bool inner_numbers) const /*throw (AccessDenied, InvalidType)*/;

//#UC START# *4D95C9DD0174*
private:
	void create_docs_container (std::ifstream& data, GblPilotDef::DocPointContainer& docs) const;
//#UC END# *4D95C9DD0174*
}; // class DocListFactory_i

} // namespace GblAdapterLib


#endif //__GARANT6X_GBLADAPTERLIB_DYNAMICDOCLIST_I_DOCLISTFACTORY_I_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
