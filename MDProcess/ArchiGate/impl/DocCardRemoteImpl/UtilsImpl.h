////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/ArchiGate/impl/DocCardRemoteImpl/UtilsImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiGate::DocCardRemoteImpl::UtilsImpl
// ��������� ���������� ������ �������� ��� ��������� Utils
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_UTILSIMPL_H__
#define __MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_UTILSIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemote.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemoteS.h"

namespace ArchiGate {
namespace DocCardRemoteImpl {

class UtilsImpl; // self forward Var
typedef ::Core::Var<UtilsImpl> UtilsImpl_var;
typedef ::Core::Var<const UtilsImpl> UtilsImpl_cvar;

class UtilsImpl_factory;

class UtilsImpl:
	virtual public POA_ArchiGate::DocCardRemote::Utils
	, virtual public ::CoreSrv::RefCountServantBase
{
	SET_OBJECT_COUNTER (UtilsImpl)
	friend class UtilsImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	UtilsImpl ();

	virtual void release () throw (CORBA::SystemException, CoreSrv::ForeignObject);

	virtual void release_i () throw (CORBA::SystemException, CoreSrv::ForeignObject);

	virtual ~UtilsImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from DocCardRemote::Utils
	// ����������� ������ ������� ����������� � ��� ��� �� ������� �������� ��� ��������� � ���������
	// ���� � ���������� Searcher2::get_xxxx, � ����� ���������� ������ (�������� ��������� ��
	// ��������). ���� �����, ������� ������ ������ ������� ������, �� ��������� ����� ��������
	// ��������� �������� �����. ������� ������� ������������ � ������, ���� ��� ��
	// Searcher2::get_xxxx �� �������� �� ���� ��������, ������� update_old_last_created_time �
	// ��������� ��������� � ����.
	// ������ ����� �������� �� �������� ������� 30-�� ����� � ��������� ���������� �������. ����
	// ������������ ����� ������ �������� ���������, �� ������ �������� time.
	virtual const CORBA::LongLong update_old_last_created_time (
		CORBA::LongLong date
	) throw (
		CORBA::SystemException
		, DocCardRemote::IllegalStateExceptionRemote
	);
}; // class UtilsImpl

} // namespace DocCardRemoteImpl
} // namespace ArchiGate


#endif //__MDPROCESS_ARCHIGATE_DOCCARDREMOTEIMPL_UTILSIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
