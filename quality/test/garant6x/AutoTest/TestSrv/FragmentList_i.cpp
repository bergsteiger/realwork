#include "ace/ACE.h"
#include "Garant/GblAdapter/CommonDefines.h"
#include "Garant/GblAdapter/GblAdapter.h"
#include "FragmentList_i.h"

GblAdapter::IFragmentList* FragmentList_i::make_interface (long count) {
	return new FragmentList_i (count);
}
//#UC START# *40C05D870007CUSTOM_MAKE_INTERFACE_IMPL*
//#UC END# *40C05D870007CUSTOM_MAKE_INTERFACE_IMPL*
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

FragmentList_i::FragmentList_i (long count) :
	m_count (count)
{
	ACE_Auto_Basic_Array_Ptr <GblAdapter::Fragment> buffer; {
		buffer.reset (new GblAdapter::Fragment[m_count]);
		ACE_OS_String::memset (buffer.get (), 0, m_count*sizeof (GblAdapter::Fragment));
	}
	m_buffer.reset (buffer.release ());
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

unsigned long __stdcall FragmentList_i::query_interface (const GCL::ComIID& iid, GCL::IObject*& object) const {
	try {
		/*if (iid == GblAdapter::IID_IFragmentList_i) {
		*/	object = IFragmentList::_narrow (dynamic_cast <const GblAdapter::IFragmentList*> (this));
		/*} else {
			return RefCountObjectBase::query_interface (iid, object);
		}*/
		return 0x00000000UL; // S_OK
	} catch (...) {
		return 0x8000FFFFUL; // E_UNEXPECTED
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

unsigned long __stdcall FragmentList_i::addref () const {
	return RefCountObjectBase::addref ();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

unsigned long __stdcall FragmentList_i::release () {
	return RefCountObjectBase::release ();
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long __stdcall FragmentList_i::get_count () const {
	return m_count;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

GblAdapter::Fragment* __stdcall FragmentList_i::get_data_ptr (long index) const {
	if ((index >= 0) && (index < m_count)) {
		return &(m_buffer [index]);
	} else {
		return NULL;
	}
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

FragmentList_i::~FragmentList_i () {
	//#UC START# *40C05D870007_CUSTOM_DESTRUCTOR_FIX*
	//#UC END# *40C05D870007_CUSTOM_DESTRUCTOR_FIX*
}