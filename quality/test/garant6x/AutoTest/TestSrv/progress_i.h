#ifndef _GBLADAPTER_PROGRESS_I_H_
#define _GBLADAPTER_PROGRESS_I_H_

#include "ace/ACE.h"
#include "Garant/GblAdapter/GblAdapter.h"
#include "Garant/GblAdapter/ApplicationHelper.h"
//#include "Garant/GblAdapter/ProgressIndicatorSupport/ProgressIndicatorSupportUnit.h"
#include "common/utils/StopWatch.h"
#include "helpers/RefCountBase.h"

#include "Garant/GblAdapter/ApplicationHelper.h"

class MyStopWatch: public GCL::StopWatchBase {
public:
	MyStopWatch():m_file(0)
	{
		this->init_counter();
	}
	MyStopWatch (const char *format_str, ... ):m_file(0) {	
		if (format_str) {
			va_list argp;
			va_start (argp, format_str);
			vsprintf(m_format_buf, format_str, argp);
			va_end (argp);
		} 
		this->init_counter();
	}
	void SetFileOutput(const char* file_name, const char OPEN_KEY[] = "a") {
		m_file = fopen (file_name, OPEN_KEY);
	}
	void stop()
	{
		GCL::HiResCounterSingl::instance()->tiks_to_time(GCL::HiResCounter::get_count() - m_start_count, sec, msec, usec);
	}
	virtual ~MyStopWatch()
	{
		__int64 count = GCL::HiResCounter::get_count() - m_start_count;
		this->finish (count);
		GCL::HiResCounterSingl::instance()->tiks_to_time(count, sec, msec, usec);
		if (m_file)
		{
			double out = double(sec)+double(msec/1000)+double(usec/10000000);
			if (m_format_buf[0])
				fprintf(m_file, "%s: %f;", m_format_buf, out);
			else
				fprintf(m_file, "%f;", out);

			fclose(m_file);
		}
		
	}
public:
	unsigned sec;
	unsigned msec;
	unsigned usec;
protected:
	FILE* m_file;
};
namespace GblAdapter {

extern "C" const GCL::ComIID IID_IQueryexecuteProgressIndicator;

class Progress_i:
	public IQueryexecuteProgressIndicator
	, virtual public GCL::RefCountObjectBase
{

public:
	// Базовый метод создания реализации интерфейса
	static IQueryexecuteProgressIndicator* make_interface (IQuery* aQuery, IList* aFiltrateList, MyStopWatch* sw);	

protected:
	// Базовый конструктор
	Progress_i ();
	// Базовый деструктор
	virtual ~Progress_i (
		void
	);
public:
	Progress_i (IQuery* aQuery, IList* aFiltrateList, MyStopWatch* sw);
	virtual unsigned long __stdcall query_interface (
		const GCL::ComIID& iid
		, GCL::IObject*& object
	) const;
	void execute (IList*& aList);

	virtual unsigned long __stdcall addref () const;

	virtual unsigned long __stdcall release ();

	// Операции доступа к аттрибуту max_count - Максимальное количество 
	// шагов долгого процесса.

	virtual long __stdcall get_max_count () const;

	// Изменение состояния длительного процесса. В качестве параметра 
	// cur_count подается либо число уже обработанных элементов, принимающих 
	// участие в длительном процессе, либо число <=100 (при индикации 
	// в %).
	virtual void __stdcall set_current (
		long cur_count
		, long arg
	);
	virtual void __stdcall finish_process (IList*);
protected:
	MyStopWatch* m_sw;
	IQuery* f_Query;
    IList_var f_FiltrateList;
    IList_var f_Result;
	bool m_finishSearch;
	

}; // class Progress_i

} // namespace GblAdapter

#endif //_GBLADAPTER_PROGRESS_I_H_

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////