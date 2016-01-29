#ifndef _GBLADAPTER_PROGRESS_I_H_
#define _GBLADAPTER_PROGRESS_I_H_

#include "ace/ACE.h"
#include "Garant/GblAdapter/GblAdapter.h"
#include "Garant/GblAdapter/ApplicationHelper.h"
//#include "Garant/GblAdapter/ProgressIndicatorSupport/ProgressIndicatorSupportUnit.h"
#include "common/utils/StopWatch.h"
#include "helpers/RefCountBase.h"

#include "Garant/GblAdapter/ApplicationHelper.h"


namespace GblAdapter {

extern "C" const GCL::ComIID IID_IQueryexecuteProgressIndicator;

class Progress_i:
	public IQueryexecuteProgressIndicator
	, virtual public GCL::RefCountObjectBase
{

public:
	// ������� ����� �������� ���������� ����������
	static IQueryexecuteProgressIndicator* make_interface (IQuery* aQuery, IList* aFiltrateList, GCL::StopWatch* sw);	

protected:
	// ������� �����������
	Progress_i ();
	// ������� ����������
	virtual ~Progress_i (
		void
	);
public:
	Progress_i (IQuery* aQuery, IList* aFiltrateList, GCL::StopWatch* sw);
	virtual unsigned long __stdcall query_interface (
		const GCL::ComIID& iid
		, GCL::IObject*& object
	) const;
	void execute (IList*& aList);

	virtual unsigned long __stdcall addref () const;

	virtual unsigned long __stdcall release ();

	// �������� ������� � ��������� max_count - ������������ ���������� 
	// ����� ������� ��������.

	virtual long __stdcall get_max_count () const;

	// ��������� ��������� ����������� ��������. � �������� ��������� 
	// cur_count �������� ���� ����� ��� ������������ ���������, ����������� 
	// ������� � ���������� ��������, ���� ����� <=100 (��� ��������� 
	// � %).
	virtual void __stdcall set_current (
		long cur_count
		, long arg
	);
	virtual void __stdcall finish_process (IList*);
protected:
	GCL::StopWatch* m_sw;
	IQuery* f_Query;
    IList_var f_FiltrateList;
    IList_var f_Result;
	bool m_finishSearch;
	

}; // class Progress_i

} // namespace GblAdapter

#endif //_GBLADAPTER_PROGRESS_I_H_

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////