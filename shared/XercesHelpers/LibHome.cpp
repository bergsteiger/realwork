////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/XercesHelpers/LibHome.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Library::Category>> shared::XercesHelpers
//
// ����� ��� ������� xerces-�
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/XercesHelpers/LibHome.h"

namespace XercesHelpers {

Core::Root::LibHome& LibHomeFactory::get () {
	return LibHomeImpl::Singleton::instance();
}

LibHomeImpl::LibHomeImpl () {
}

void LibHomeImpl::registrate_all_factories () const {
	//#UC START# *491C05CA0197_ENVIRONMENTS_CONFIG*
	//#UC END# *491C05CA0197_ENVIRONMENTS_CONFIG*

}
	
void LibHomeImpl::finalize () {
}
} // namespace XercesHelpers

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
