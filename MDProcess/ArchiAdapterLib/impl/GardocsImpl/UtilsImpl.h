////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/UtilsImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::UtilsImpl
// ��������� ���������� ������ �������� ��� ��������� Utils
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_UTILSIMPL_H__
#define __MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_UTILSIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/Gardocs/Gardocs.h"

namespace ArchiAdapterLib {
namespace GardocsImpl {

class UtilsImpl; // self forward Var
typedef ::Core::Var<UtilsImpl> UtilsImpl_var;
typedef ::Core::Var<const UtilsImpl> UtilsImpl_cvar;

class UtilsImpl_factory;

class UtilsImpl:
	virtual public Gardocs::Utils
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (UtilsImpl)
	friend class UtilsImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	UtilsImpl ();

	virtual ~UtilsImpl ();

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from Gardocs::Utils
	// ����������� ������ ������� ����������� � ��� ��� �� ������� �������� ��� ��������� � ���������
	// ���� � ���������� Searcher2::get_xxxx, � ����� ���������� ������ (�������� ��������� ��
	// ��������). ���� �����, ������� ������ ������ ������� ������, �� ��������� ����� ��������
	// ��������� �������� �����. ������� ������� ������������ � ������, ���� ��� ��
	// Searcher2::get_xxxx �� �������� �� ���� ��������, ������� update_old_last_created_time �
	// ��������� ��������� � ����.
	// ������ ����� �������� �� �������� ������� 30-�� ����� � ��������� ���������� �������. ����
	// ������������ ����� ������ �������� ���������, �� ������ �������� time.
	virtual GCI::IO::DateTimeBox* update_old_last_created_time (
		const GCI::IO::DateTimeBox& date
	) const /*throw (
		Gardocs::CommunicationFailure
	)*/;
}; // class UtilsImpl

} // namespace GardocsImpl
} // namespace ArchiAdapterLib


#endif //__MDPROCESS_ARCHIADAPTERLIB_GARDOCSIMPL_UTILSIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
