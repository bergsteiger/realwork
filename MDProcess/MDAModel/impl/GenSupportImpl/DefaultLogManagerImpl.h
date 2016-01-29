////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/GenSupportImpl/DefaultLogManagerImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::DefaultLogManagerImpl
// ��������� ���������� ������ �������� ��� ��������� LogManager
//
// ���������� ��������� ������������, ����� ��������� � ����. �������� � ���� � ��������� �� �
// �������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_DEFAULTLOGMANAGERIMPL_H__
#define __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_DEFAULTLOGMANAGERIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"

namespace GenSupportImpl {

class DefaultLogManagerImpl; // self forward Var
typedef ::Core::Var<DefaultLogManagerImpl> DefaultLogManagerImpl_var;
typedef ::Core::Var<const DefaultLogManagerImpl> DefaultLogManagerImpl_cvar;

class DefaultLogManagerImpl_factory;

// ���������� ��������� ������������, ����� ��������� � ����. �������� � ���� � ��������� �� �
// �������� ����
class DefaultLogManagerImpl:
	virtual public GenSupport::LogManager
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (DefaultLogManagerImpl)
	friend class DefaultLogManagerImpl_factory; // self factory

//////////////////////////////////////////////////////////////////////////////////////////
// nested declorations
private:
	// ���������
	static const std::string ERROR_TAB_NAME; // ��� �������, ���� ����� �������� ��������� �� �������
	static const std::string WARNING_TAB_NAME; // ��� �������, ���� ����� �������� ��������������
	static const std::string DOMAIN_TAB_NAME; // ������ - ������������� ��� ����������� �����

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	DefaultLogManagerImpl ();

	virtual ~DefaultLogManagerImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// ���������� ��������� � ������ �������
	virtual void write_message_to_tab (const std::string& tab_name, const std::string& message) const;


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from GenSupport::LogManager
	// ������������� ���������, ����� ���������� ��������� ���
	virtual void init () const;

	// implemented method from GenSupport::LogManager
	// ������������ ������
	virtual void log_error (const std::string& message) const;

	// implemented method from GenSupport::LogManager
	// ������������ ��������������� ���������
	virtual void log_info (const std::string& message) const;

	// implemented method from GenSupport::LogManager
	// ������������ ��������������
	virtual void log_warning (const std::string& message) const;
}; // class DefaultLogManagerImpl

} // namespace GenSupportImpl


#endif //__MDPROCESS_MDAMODEL_GENSUPPORTIMPL_DEFAULTLOGMANAGERIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
