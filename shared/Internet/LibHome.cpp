////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/Internet/LibHome.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> shared::Internet
//
// ���������� ��� ������ � ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/Internet/LibHome.h"
#include "shared/Internet/impl/Inet_i/Connection_i_factory.h"
#include "shared/Internet/impl/Inet_i/Connect_i_factory.h"

namespace Internet {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *4ABCE74603A0_ENVIRONMENTS_CONFIG*
	//#UC END# *4ABCE74603A0_ENVIRONMENTS_CONFIG*

	{
		Inet_i::Connection_i_factory_var fctr = new Inet_i::Connection_i_factory ();
		fctr->registrate_me(0);
	}
	
	{
		Inet_i::Connect_i_factory_var fctr = new Inet_i::Connect_i_factory ();
		fctr->registrate_me(0);
	}
	
}
	
void LibHomeImpl::finalize () {
}
} // namespace Internet

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
