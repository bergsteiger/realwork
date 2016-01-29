////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/RoseModelImpl/ModelSearcherImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::RoseModelImpl::ModelSearcherImpl
// ��������� ���������� ������ �������� ��� ��������� ModelSearcher
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEMODELIMPL_MODELSEARCHERIMPL_H__
#define __MDPROCESS_MDAMODEL_ROSEMODELIMPL_MODELSEARCHERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include <map>
#include "MDProcess/MDAModel/RoseModel/RoseModel.h"

namespace RoseModelImpl {

class ModelSearcherImpl; // self forward Var
typedef ::Core::Var<ModelSearcherImpl> ModelSearcherImpl_var;
typedef ::Core::Var<const ModelSearcherImpl> ModelSearcherImpl_cvar;

class ModelSearcherImpl_factory;

class ModelSearcherImpl:
	virtual public ModelSearcher
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ModelSearcherImpl)
	friend class ModelSearcherImpl_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// ���� ������-������
	typedef std::map < std::string, std::string > Str2StrMap;

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ModelSearcherImpl ();

	virtual ~ModelSearcherImpl ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ���� ������ ���� (������������, ������� ������� ������� ��� ������ ��������) - ����� ����,
	// ������� ������� �������� ��� ��������������
	mutable Str2StrMap m_old_uid_to_new_uid;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from ModelSearcher
	// ��������� �������� �������� � ������
	virtual void on_delete_element (IRoseElementPtr elem) const;

	// implemented method from ModelSearcher
	// ��������� �������� ������ �������� (��� �������� �� ������ �������)
	virtual void on_new_element (IRoseElementPtr element) const;

	// implemented method from ModelSearcher
	// ���� ������� ������ �� ��������������, ���� �� ������� - ���������� 0
	virtual IRoseElementPtr search (const std::string& uid) const;
}; // class ModelSearcherImpl

} // namespace RoseModelImpl


#endif //__MDPROCESS_MDAMODEL_ROSEMODELIMPL_MODELSEARCHERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
