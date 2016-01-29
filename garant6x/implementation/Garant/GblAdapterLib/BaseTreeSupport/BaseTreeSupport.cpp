////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport.cpp"
// ��������� ������ ���������� C++ (.cpp)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::BaseTreeSupport
//
// ��������� ������� ������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "shared/CoreSrv/sys/std_inc.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupport.h"
#include "garant6x/implementation/Garant/GblAdapterLib/BaseTreeSupport/BaseTreeSupportFactories.h"

namespace GblAdapterLib {


const char* CopyDisabled::uid () const /*throw ()*/ {
	return "63115710-F088-4EE0-B5B9-00B2E36FBF4C";
}

const char* CopyDisabled::what () const throw () {
	//#UC START# *456FEB35000F_WHAT_IMPL*
	return "CopyDisabled (������������ ���� ���� �� ����� ���� �����������.)";
	//#UC END# *456FEB35000F_WHAT_IMPL*
}


const char* InvalidContainer::uid () const /*throw ()*/ {
	return "454FB780-DCE5-4AD5-AE99-9E41AFEE3248";
}

const char* InvalidContainer::what () const throw () {
	//#UC START# *456FEB350011_WHAT_IMPL*
	return "InvalidContainer (���������� ��� ������� ������������ ���� �� ���������� ���������� ��� ���������.)";
	//#UC END# *456FEB350011_WHAT_IMPL*
}


const char* MoveDisabled::uid () const /*throw ()*/ {
	return "8A0D7774-AA8F-4EAA-A15F-C00D73F7FBD4";
}

const char* MoveDisabled::what () const throw () {
	//#UC START# *456FEB350013_WHAT_IMPL*
	return "MoveDisabled (������������ ���� ���� �� ����� ���� ����������.)";
	//#UC END# *456FEB350013_WHAT_IMPL*
}


const char* InvalidEntityType::uid () const /*throw ()*/ {
	return "0AEC4038-7533-4FB1-A975-58E76E255075";
}

const char* InvalidEntityType::what () const throw () {
	//#UC START# *456FEB350015_WHAT_IMPL*
	return "InvalidEntityType (������������ ��� ������� ��������� ����� �������� �������� ������� ����.)";
	//#UC END# *456FEB350015_WHAT_IMPL*
}


const char* InvalidIndex::uid () const /*throw ()*/ {
	return "56331F0C-AE40-4578-A38C-84316D7ABD7B";
}

const char* InvalidIndex::what () const throw () {
	//#UC START# *456FEB760128_WHAT_IMPL*
	return "InvalidIndex (������������ ��� ������� �������� ������� ������ �� ��������������� �������. �.�. index<0 ��� index>=count.)";
	//#UC END# *456FEB760128_WHAT_IMPL*
}


const char* NotEntityElement::uid () const /*throw ()*/ {
	return "7CA7E5D7-CA70-424A-BB8F-A7753B405C3F";
}

const char* NotEntityElement::what () const throw () {
	//#UC START# *456FEB8C00AB_WHAT_IMPL*
	return "NotEntityElement (������������ ��� ������� ������� �������� open � �������� ��������, �� ����������� ��������� (� ��������� � �����).)";
	//#UC END# *456FEB8C00AB_WHAT_IMPL*
}

// factory interface wrapper for Node
Node* NodeFactory::make () /*throw (Core::Root::NoActiveFactory, Core::Root::FactoryManagerWasDestroyed)*/ {
	return NodeFactoryManager::Singleton::instance ()->make ();
}

} // namespace GblAdapterLib

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

