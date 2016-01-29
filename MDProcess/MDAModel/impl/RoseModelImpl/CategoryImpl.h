////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/RoseModelImpl/CategoryImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::CategoryImpl
// ��������� ���������� ������ �������� ��� ��������� Category
//
// ���������� ��������-�����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_CATEGORYIMPL_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_CATEGORYIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"

namespace RoseModelImpl {

class CategoryImpl; // self forward Var
typedef ::Core::Var<CategoryImpl> CategoryImpl_var;
typedef ::Core::Var<const CategoryImpl> CategoryImpl_cvar;

class CategoryImpl_factory;

// ���������� ��������-�����
class CategoryImpl:
	virtual public Category
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (CategoryImpl)
	friend class CategoryImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	CategoryImpl (IRoseCategoryPtr cat);

	virtual ~CategoryImpl ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ��������� �������, ��� ������� ������� ������
	IRoseCategoryPtr m_cat;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Category
	// ���������� ����� �� ����� ������ � ��������� ���
	virtual bool can_control () const;

	// implemented method from Category
	// ���������� ������ ���� ����� - ����� (����������)
	virtual CategoryList* get_all_categories () const;

	// implemented method from Category
	// ���������� ������ ����� - ���������������� ����� ��������
	virtual CategoryList* get_categories () const;

	// implemented method from Category
	// ���������� ������ ��� ��������
	virtual const std::string get_full_name () const;

	// implemented method from Category
	// ���������� true, ���� ���� �� ���� ������� (����������) "�����" � ����������� cat
	virtual bool has_controlled_child () const;

	// implemented method from Category
	// ���������� true, ���� ���� �������� �������� �� ��������� ��� ��������������, �.� �� �����
	// ��������� ��� ����, ����� ������ �������������
	virtual bool has_ro_child () const;

	// implemented method from Category
	// ���������� true, ���� ������� "�����" � ����������� cat
	virtual bool is_controlled () const;

	// implemented method from Element
	// ���������� true, ���� ������� �������� ��� ��������������
	virtual bool can_modify () const;

	// implemented method from Element
	// ���������� ������ ���� ����� �������� (� ������ �����������)
	virtual ElementList* get_all_childs () const;

	// implemented method from Element
	// ���������� ������ ���������������� ����� ��������
	virtual ElementList* get_childs () const;
}; // class CategoryImpl

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_CATEGORYIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
