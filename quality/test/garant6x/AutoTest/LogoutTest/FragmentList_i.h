#include "ace/ACE.h"
#include "Garant/GblAdapter/GblAdapter.h"
#include "Garant/GblAdapter/ApplicationHelper.h"
#include "common/utils/StopWatch.h"
#include "helpers/RefCountBase.h"
#include "Garant/GblAdapter/ApplicationHelper.h"


extern "C" const GCL::ComIID IID_IFragmentList_i_i;
class FragmentList_i :
public GblAdapter::IFragmentList
	, virtual public GCL::RefCountObjectBase
{
public:
	static GblAdapter::IFragmentList* make_interface (long count);
	//#UC START# *40C05D870007CUSTOM_MAKE_INTERFACE*
	//#UC END# *40C05D870007CUSTOM_MAKE_INTERFACE*

protected:
	// Базовый конструктор
	FragmentList_i (long count);

public:
	virtual unsigned long __stdcall query_interface (const GCL::ComIID& iid, GCL::IObject*& object) const;
	virtual unsigned long __stdcall addref () const;
	virtual unsigned long __stdcall release ();

	virtual long __stdcall get_count () const;
	virtual GblAdapter::Fragment* __stdcall get_data_ptr (long index) const;
protected:
	// Базовый деструктор
	virtual ~FragmentList_i ();
private:
	long m_count;
	ACE_Auto_Basic_Array_Ptr <GblAdapter::Fragment> m_buffer;
}; // class FragmentList_i

