////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/SetUserCodeContent.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::VirtualElementsFuncionsImpl::SetUserCodeContent
// ��������� ���������� ������ �������� ��� ��������� 
//
// %S%f_set_uc_content(gen_id, uc_id,content) - ��������� ���������� ���������� ��� ����������
// gen_id
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETUSERCODECONTENT_H__
#define __MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETUSERCODECONTENT_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/AbstractDumpers/AbstractDumperBase.h"
#include "MDProcess/MDAModel/AbstractDumpers/TemplatePainter.h"
#include "MDProcess/MDAModel/impl/VirtualElementsFuncionsImpl/UCModificationBase.h"

namespace VirtualElementsFuncionsImpl {

class SetUserCodeContent; // self forward Var
typedef ::Core::Var<SetUserCodeContent> SetUserCodeContent_var;
typedef ::Core::Var<const SetUserCodeContent> SetUserCodeContent_cvar;

class SetUserCodeContent_factory;

// %S%f_set_uc_content(gen_id, uc_id,content) - ��������� ���������� ���������� ��� ����������
// gen_id
class SetUserCodeContent:
	virtual public UCModificationBase
{
	SET_OBJECT_COUNTER (SetUserCodeContent)
	friend class SetUserCodeContent_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// static member methods and data
private:
	// ���������� �������
	static const std::string uc_function_impl (const std::string& gen_id, const std::string& uc_id, const std::string& content, const AbstractDumperBase* self, TemplatePainter* painter);

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	SetUserCodeContent ();

	virtual ~SetUserCodeContent ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from UCModificationBase
	// ���������� ���������� ���������� �������
	virtual const UCModificationBase::UCModificationFunctionImpl get_uc_function_impl () const;
}; // class SetUserCodeContent

} // namespace VirtualElementsFuncionsImpl


#endif //__MDPROCESS_MDAMODEL_VIRTUALELEMENTSFUNCIONSIMPL_SETUSERCODECONTENT_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
