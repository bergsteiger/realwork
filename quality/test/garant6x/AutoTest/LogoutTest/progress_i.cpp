#include "ace/ACE.h"
#include "Garant/GblAdapter/CommonDefines.h"
#include "Garant/GblAdapter/GblAdapter.h"
#include "progress_i.h"

namespace GblAdapter {

IQueryexecuteProgressIndicator* Progress_i::make_interface (IQuery* aQuery, IList* aFiltrateList, GCL::StopWatch* sw)
{
	return new Progress_i(aQuery, aFiltrateList, sw);
}

void Progress_i::execute (IList*& aList)
{
	ICancelLongProcess_var cancel;
	f_Query->execute(f_FiltrateList, this, cancel.out());
	while (!m_finishSearch);
	aList = IList::_narrow(f_Result);
}
unsigned long __stdcall Progress_i::query_interface (
	const GCL::ComIID& iid
	, GCL::IObject*& object
) const {
	try {
		object = IQueryexecuteProgressIndicator::_narrow (dynamic_cast <const IQueryexecuteProgressIndicator*> (this));
		return 0x00000000UL; // S_OK
	} catch (...) {
		return 0x8000FFFFUL; // E_UNEXPECTED
	}
}

unsigned long __stdcall Progress_i::addref () const {
	return RefCountObjectBase::addref ();
}

unsigned long __stdcall Progress_i::release () {
	return RefCountObjectBase::release ();
}

long __stdcall Progress_i::get_max_count () const {

	return 0;

}

// »зменение состо€ни€ длительного процесса. ¬ качестве параметра 
// cur_count подаетс€ либо число уже обработанных элементов, принимающих 
// участие в длительном процессе, либо число <=100 (при индикации 
// в %).
void __stdcall Progress_i::set_current (
	long cur_count
	, long arg
) {

}

void __stdcall Progress_i::finish_process(IList* aList)
{
	f_Result = IList::_narrow(aList);
	delete m_sw;
	m_sw = NULL;
	m_finishSearch = true;
}

Progress_i::Progress_i (IQuery* aQuery, IList* aFiltrateList, GCL::StopWatch* sw) :
	RefCountObjectBase ()
{
		f_FiltrateList = IList::_narrow(aFiltrateList);
		f_Query = aQuery;
		m_sw = sw;
		m_finishSearch = false;

}

Progress_i::~Progress_i () {
	
}

}// namespace GblAdapter
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////