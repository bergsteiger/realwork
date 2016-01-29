////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ������: "w:/shared/WinGUI/Controls/Controls.h"
// ��������� ������������ ������ C++ (.h)
// Generated from UML model, root element: <<Views::Category>> shared::WinGUI::Controls
//
// ����� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_WINGUI_CONTROLS_H__
#define __SHARED_WINGUI_CONTROLS_H__

#include "shared/Core/sys/std_inc.h"

//forward decl
namespace WinGUI {
	class ProgressIndicator;
} // namespace WinGUI


namespace WinGUI {

class ProgressIndicatorDelegate;
typedef ::Core::Var<ProgressIndicatorDelegate> ProgressIndicatorDelegate_var;
typedef ::Core::Var<const ProgressIndicatorDelegate> ProgressIndicatorDelegate_cvar;
// ������� ��� ����������
class ProgressIndicatorDelegate
	: virtual public ::Core::IObject
{
public:
	// ���������� ������� ������ "CANCEL" ��� ���� ������� progress_indicator_closed �� ����������!
	virtual void progress_indicator_canceled (const ProgressIndicator& indicator) = 0;

	// ������� � �������� ���� �������� ����������
	virtual void progress_indicator_closed (const ProgressIndicator& indicator) = 0;

	// �������  � ���, ��� �������� ��� ����� �� �����
	virtual void progress_indicator_finished (const ProgressIndicator& indicator) = 0;

	// ������ ��������-����������
	virtual unsigned int get_progress_size () const = 0;

	virtual void set_progress_size (unsigned int progress_size) = 0;

	// ������������� ������ ����
	virtual unsigned int get_step_size () const = 0;

	virtual void set_step_size (unsigned int step_size) = 0;
};

} // namespace WinGUI


#endif //__SHARED_WINGUI_CONTROLS_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

