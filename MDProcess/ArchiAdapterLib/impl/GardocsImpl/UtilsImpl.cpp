////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/ArchiAdapterLib/impl/GardocsImpl/UtilsImpl.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::ArchiAdapterLib::GardocsImpl::UtilsImpl
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/ArchiAdapterLib/LibHome.h"
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/UtilsImpl.h"
// by <<uses>> dependencies
#include "MDProcess/ArchiAdapterLib/impl/GardocsImpl/DataConverter.h"
#include "MDProcess/ArchiGate/DocCardRemote/DocCardRemote.h"

namespace ArchiAdapterLib {
namespace GardocsImpl {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

UtilsImpl::UtilsImpl ()
//#UC START# *54999FBD0023_54999FC6024E_5499A0AB0227_BASE_INIT*
//#UC END# *54999FBD0023_54999FC6024E_5499A0AB0227_BASE_INIT*
{
	//#UC START# *54999FBD0023_54999FC6024E_5499A0AB0227_BODY*
	//#UC END# *54999FBD0023_54999FC6024E_5499A0AB0227_BODY*
}

UtilsImpl::~UtilsImpl () {
	//#UC START# *5499A0AB0227_DESTR_BODY*
	//#UC END# *5499A0AB0227_DESTR_BODY*
}


//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods

// implemented method from Gardocs::Utils
// ����������� ������ ������� ����������� � ��� ��� �� ������� �������� ��� ��������� � ���������
// ���� � ���������� Searcher2::get_xxxx, � ����� ���������� ������ (�������� ��������� ��
// ��������). ���� �����, ������� ������ ������ ������� ������, �� ��������� ����� ��������
// ��������� �������� �����. ������� ������� ������������ � ������, ���� ��� �� Searcher2::get_xxxx
// �� �������� �� ���� ��������, ������� update_old_last_created_time � ��������� ��������� � ����.
// ������ ����� �������� �� �������� ������� 30-�� ����� � ��������� ���������� �������. ����
// ������������ ����� ������ �������� ���������, �� ������ �������� time.
GCI::IO::DateTimeBox* UtilsImpl::update_old_last_created_time (
	const GCI::IO::DateTimeBox& date
) const /*throw (
	Gardocs::CommunicationFailure
)*/ {
	//#UC START# *54999FCF0337_5499A0AB0227*
	LOG_D(("%s - START", GDS_CURRENT_FUNCTION));
	try {
		InvocationAspect<ArchiGate::DocCardRemote::Utils> action;

		CORBA::LongLong time = action.impl->update_old_last_created_time (
			DataConverter::total_second_since_1st_jan_1970 (date)
			);
		return new GCI::IO::DateTimeBox (DataConverter::from_total_second_since_1st_jan_1970 (time));
	} catch (...) {
		LOG_D(("%s - EXCEPTION", GDS_CURRENT_FUNCTION));
		throw Gardocs::CommunicationFailure();
	}
	//#UC END# *54999FCF0337_5499A0AB0227*
}
} // namespace GardocsImpl
} // namespace ArchiAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

