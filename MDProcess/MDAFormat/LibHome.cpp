////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAFormat/LibHome.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> MDProcess::MDAFormat
//
// �������� ������� �������� ������. ������ ��������� � 3-� ������:
// - �����������
// - ������������
// - ���������������
// 
// ������ ����� ����������� ����������� ��������, ��� ����� ���������� � ���� "������� ����"
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "MDProcess/MDAFormat/LibHome.h"
#include "MDProcess/MDAFormat/Executor.h"

namespace MDAFormat {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
	this->get_executors ().insert (&Executor::get ());
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *48902AAF011F_ENVIRONMENTS_CONFIG*
	//#UC END# *48902AAF011F_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
} // namespace MDAFormat

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
