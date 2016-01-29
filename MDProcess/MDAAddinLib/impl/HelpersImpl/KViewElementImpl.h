////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAAddinLib/impl/HelpersImpl/KViewElementImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAAddinLib::HelpersImpl::KViewElementImpl
// ��������� ���������� ������ �������� ��� ��������� KViewElement
//
// ��������� �������� �������� � � ��������� ��������� ������� ShellExecute
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_HELPERSIMPL_KVIEWELEMENTIMPL_H__
#define __MDPROCESS_MDAADDINLIB_HELPERSIMPL_KVIEWELEMENTIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAAddinLib/Helpers/Helpers.h"

namespace HelpersImpl {

class KViewElementImpl; // self forward Var
typedef ::Core::Var<KViewElementImpl> KViewElementImpl_var;
typedef ::Core::Var<const KViewElementImpl> KViewElementImpl_cvar;

class KViewElementImpl_factory;

// ��������� �������� �������� � � ��������� ��������� ������� ShellExecute
class KViewElementImpl:
	virtual public Helpers::KViewElement
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (KViewElementImpl)
	friend class KViewElementImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	KViewElementImpl ();

	virtual ~KViewElementImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Helpers::KViewElement
	// ��������� ������ ��� �������� �������� �������� � �
	virtual const std::string make_view_link (IRoseElementPtr elem) const;

	// implemented method from Helpers::KViewElement
	// ���������� �������� �������� � �
	virtual void view (IRoseElementPtr elem) const;
}; // class KViewElementImpl

} // namespace HelpersImpl


#endif //__MDPROCESS_MDAADDINLIB_HELPERSIMPL_KVIEWELEMENTIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
