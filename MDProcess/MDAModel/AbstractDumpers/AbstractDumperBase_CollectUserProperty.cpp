////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase_CollectUserProperty.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> MDProcess::MDAModel::AbstractDumpers::AbstractDumperBase::CollectUserProperty
//
// �������� ���������� ��� ������ ������, �������� ��� ����-�������� � ���� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"

class AbstractDumperBase;
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

AbstractDumperBase::CollectUserProperty::~CollectUserProperty () {
	//#UC START# *46FC8A6202CE_DESTR_BODY*
	//#UC END# *46FC8A6202CE_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// �������, ���������� �� ������ �������� ������
void AbstractDumperBase::CollectUserProperty::each_func (const GCL::StaticNode* item, UserPropertyMap& prop_map) {
	//#UC START# *46FC8AF4030D*
	const AbstractDumperBase::PropertyGroupTreeItem* group = 
		dynamic_cast<const AbstractDumperBase::PropertyGroupTreeItem*> (item);
	const AbstractDumperBase::UserPropertyMap& item_map = group->get_properties ();
	prop_map.insert (item_map.begin (), item_map.end ());
	//#UC END# *46FC8AF4030D*
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

