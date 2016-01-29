////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/MDProcess/MDAModel/impl/GenSupportImpl/ProgessIndicatorServiceImpl.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Servant::Class>> MDProcess::MDAModel::GenSupportImpl::ProgessIndicatorServiceImpl
// ��������� ���������� ������ �������� ��� ��������� ProgessIndicatorService
//
// ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_PROGESSINDICATORSERVICEIMPL_H__
#define __MDPROCESS_MDAMODEL_GENSUPPORTIMPL_PROGESSINDICATORSERVICEIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/GenSupport/GenSupport.h"
#include "shared/WinGUI/Controls/ProgressIndicator.h"

namespace GenSupportImpl {

class ProgessIndicatorServiceImpl; // self forward Var
typedef ::Core::Var<ProgessIndicatorServiceImpl> ProgessIndicatorServiceImpl_var;
typedef ::Core::Var<const ProgessIndicatorServiceImpl> ProgessIndicatorServiceImpl_cvar;

class ProgessIndicatorServiceImpl_factory;

// ����������
class ProgessIndicatorServiceImpl:
	virtual public GenSupport::ProgessIndicatorService
	, virtual public ::Core::RefCountObjectBase
{
	SET_OBJECT_COUNTER (ProgessIndicatorServiceImpl)
	friend class ProgessIndicatorServiceImpl_factory; // self factory
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	ProgessIndicatorServiceImpl ();

	virtual ~ProgessIndicatorServiceImpl ();
//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// ���������� ��������
	WinGUI::ProgressIndicator* m_indicator;

	// ������� ��� �������������
	mutable Core::Mutex m_mutex;

	// ������ ��������-����������
	unsigned int m_progress_size;

	// ������������� ������ ����
	unsigned int m_step_size;

//////////////////////////////////////////////////////////////////////////////////////////
// implemented interface's methods
protected:

	// implemented method from GenSupport::ProgessIndicatorService
	// ������� ���������� ���������
	virtual void end () /*throw (GenSupport::GenerationNotStarted)*/;

	// implemented method from GenSupport::ProgessIndicatorService
	// ���������� true, ���� �������� �������, �� ��� �� ��������
	virtual bool is_started () const;

	// implemented method from GenSupport::ProgessIndicatorService
	// ������ ��������� - ���������� �������� ���������
	virtual void start () /*throw (GenSupport::GenerationAlreadyStarted)*/;

	// implemented method from GenSupport::ProgessIndicatorService
	// ��������� ��� ���������. ���� �� ��� ������� start, �� �������� ���
	virtual void step ();

	// implemented method from GenSupport::ProgessIndicatorService
	// ���������� ���, �������� ��������� ����������� ���. ���� �� ��� ������� start, �� �������� ���
	virtual void step (const std::string& message);

	// implemented method from GenSupport::ProgessIndicatorService
	// ��������� ���������� � �������� ����������
	virtual void update_message (const std::string& mess);

	// implemented method from WinGUI::ProgressIndicatorDelegate
	// ���������� ������� ������ "CANCEL" ��� ���� ������� progress_indicator_closed �� ����������!
	virtual void progress_indicator_canceled (const WinGUI::ProgressIndicator& indicator);

	// implemented method from WinGUI::ProgressIndicatorDelegate
	// ������� � �������� ���� �������� ����������
	virtual void progress_indicator_closed (const WinGUI::ProgressIndicator& indicator);

	// implemented method from WinGUI::ProgressIndicatorDelegate
	// �������  � ���, ��� �������� ��� ����� �� �����
	virtual void progress_indicator_finished (const WinGUI::ProgressIndicator& indicator);

	// implemented method from WinGUI::ProgressIndicatorDelegate
	// ������ ��������-����������
	virtual unsigned int get_progress_size () const;

	virtual void set_progress_size (unsigned int progress_size);

	// implemented method from WinGUI::ProgressIndicatorDelegate
	// ������������� ������ ����
	virtual unsigned int get_step_size () const;

	virtual void set_step_size (unsigned int step_size);
}; // class ProgessIndicatorServiceImpl

} // namespace GenSupportImpl


#endif //__MDPROCESS_MDAMODEL_GENSUPPORTIMPL_PROGESSINDICATORSERVICEIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
