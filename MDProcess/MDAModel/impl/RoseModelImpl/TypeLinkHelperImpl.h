////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/RoseModelImpl/TypeLinkHelperImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::TypeLinkHelperImpl
// ��������� ���������� ������ �������� ��� ��������� TypeLinkHelper
//
// �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_TYPELINKHELPERIMPL_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_TYPELINKHELPERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"

namespace RoseModelImpl {

class TypeLinkHelperImpl; // self forward Var
typedef ::Core::Var<TypeLinkHelperImpl> TypeLinkHelperImpl_var;
typedef ::Core::Var<const TypeLinkHelperImpl> TypeLinkHelperImpl_cvar;

class TypeLinkHelperImpl_factory;

// �������
class TypeLinkHelperImpl:
	virtual public TypeLinkHelper
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (TypeLinkHelperImpl)
	friend class TypeLinkHelperImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	TypeLinkHelperImpl ();

	virtual ~TypeLinkHelperImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from TypeLinkHelper
	// ���������� ������������ ��������, � ������� ������ �������
	virtual const std::string get_linked (IRoseElementPtr source) const;

	// implemented method from TypeLinkHelper
	// ����������� � �������� ��������, ��� �� ������ � ���������, ������� ���� target_uid
	virtual void link (IRoseElementPtr source, const std::string& target_uid) const;

	// implemented method from TypeLinkHelper
	// ��������� ����� ��� ��������
	virtual void unlink (IRoseElementPtr source) const;
}; // class TypeLinkHelperImpl

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_TYPELINKHELPERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
