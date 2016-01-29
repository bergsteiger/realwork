////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/AddCategory.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::AddCategory
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_add_category(�UID�,����������,�����,������������) - ��������� ����� � �������� �������� �
// ���������� � � ����������. ������ �������������:
// {code}
// %S%f_add_category(_UID_SUFFIX,Test,Unit,CAT)  - ��������� ����� �� ����������� Unit, ������ Test
// {code}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDCATEGORY_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDCATEGORY_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/VirtualElementsFunctionBase.h"

namespace VirtualElementsFuncionsImpl {

class AddCategory; // self forward Var
typedef ::Core::Var<AddCategory> AddCategory_var;
typedef ::Core::Var<const AddCategory> AddCategory_cvar;

class AddCategory_factory;

// %S%f_add_category(�UID�,����������,�����,������������) - ��������� ����� � �������� �������� �
// ���������� � � ����������. ������ �������������:
// {code}
// %S%f_add_category(_UID_SUFFIX,Test,Unit,CAT)  - ��������� ����� �� ����������� Unit, ������ Test
// {code}
class AddCategory:
	virtual public VirtualElementsFunctionBase
{
	SET_OBJECT_COUNTER (AddCategory)
	friend class AddCategory_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	AddCategory ();

	virtual ~AddCategory ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from BaseFunctionImpl::InternalStereotypeFunctionBase
	// ���������� ���������� ���������� �������. ������ ���������� ������� ��������� ��� �����
	virtual const std::string execute_impl (
		const AbstractDumperBase* self
		, const TemplateFunctions::FunctionParams& params
		, TemplatePainter* painter
	) const /*throw (
		TemplateFunctions::BadParams
	)*/;
}; // class AddCategory

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_ADDCATEGORY_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
