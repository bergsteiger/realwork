////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/WinGUI/Helpers/LayoutHelper.cpp"
// генератор файлов реализации C++ (.cpp)
// Generated from UML model, root element: <<SimpleClass::Class>> shared::WinGUI::Helpers::LayoutHelper
//
// вспомогательный класс для контроля расположения и размеров контрола
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "shared/Core/sys/std_inc.h"
#include "shared/WinGUI/Helpers/LayoutHelper.h"
// by <<uses>> dependencies
#include "shared/WinGUI/Helpers/WinControlHelper.h"

namespace WinGUI {

//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor

// конструктор
LayoutHelper::LayoutHelper ()
//#UC START# *4652B8C90280_BASE_INIT*
: m_attach_wnd (NULL)
, m_layout_style (LayoutHelper::DEFAULT_LAYOUT)
, m_reference_size (0, 0)
, m_minimum_size (0, 0)
, m_step_size (0)
, m_prev_wnd_width (0)
, m_prev_wnd_height (0)
//#UC END# *4652B8C90280_BASE_INIT*
{
	//#UC START# *4652B8C90280_BODY*
	//#UC END# *4652B8C90280_BODY*
}

LayoutHelper::~LayoutHelper () {
	//#UC START# *4652B774030D_DESTR_BODY*
	this->detach_wnd ();
	//#UC END# *4652B774030D_DESTR_BODY*
}

//////////////////////////////////////////////////////////////////////////////////////////
// self implementation

// добавялет в список все дочерние контролы, связанного окно
bool LayoutHelper::add_child_controls () {
	//#UC START# *4652BB9202CE*
	if (m_attach_wnd == NULL) {
        return false;
	}

    // Loop through all the child windows of the attach wnd
    // and add each one with default (empty) layout info.
    CWnd* pChildWnd = m_attach_wnd->GetWindow(GW_CHILD);
    while (pChildWnd != NULL && ::IsWindow(pChildWnd->m_hWnd)) {
		this->add_control (*pChildWnd);
        pChildWnd = pChildWnd->GetWindow(GW_HWNDNEXT);
    }

    return true;
	//#UC END# *4652BB9202CE*
}

// добавляет ctrl в список объектов
bool LayoutHelper::add_control (CWnd& ctrl) {
	//#UC START# *4652BADC001F*
	LayoutInfo empty_info;
	bool status = this->add_control_info (ctrl, empty_info);
    return status;
	//#UC END# *4652BADC001F*
}

// добавялет ctrl в список контролов info - информация о расположении
bool LayoutHelper::add_control_info (CWnd& ctrl, const LayoutInfo& info) {
	//#UC START# *4652BB0E02BF*

	if (m_attach_wnd == NULL) {
        return false;
	}

    // The control must be created already in order to add it.
	if (!::IsWindow(ctrl.m_hWnd)) {
        return false;
	}

    // Don't add the control if it is a CGroupLine instance.
    // We don't want to add these because CGroupLine instances
    // are managed by the CGroupBox control.
    /*if ( IsGroupLineControl(pControl) )
        return false;
	*/
    // Check for valid reference rect from the layout info.
	CRect rect (info.reference_rect ());
    if (rect.Width() <= 0 || rect.Height() <= 0) {
        // The rect from the info instance is not valid.
        // We need to get the rect from the control itself.
        ctrl.GetWindowRect(&rect);

        // Convert rect to client coordinates relative to attach wnd.
        m_attach_wnd->ScreenToClient(&rect);

        // If this control is a combo box, we extend its
        // rect by the height of its drop down box too.
		if (WinControlHelper::is_combobox (ctrl)) {
            CRect rectDropDown;
            CComboBox* pBox = (CComboBox *)&ctrl;
            pBox->GetDroppedControlRect(&rectDropDown);
            rect.bottom += rectDropDown.Height();
        }
    }

    // Look for existing entry for this control in our map.
    Controls::iterator result = m_controls.find (ctrl.m_hWnd);
    if (result == m_controls.end() ) {
        // Add new entry to map.
        LayoutInfo* pInfo = new LayoutInfo(info);
		pInfo->reference_rect () = rect;        
		m_controls.insert(Controls::value_type (ctrl.m_hWnd, pInfo));
    } else {
        // Update existing entry in map.
        result->second.replace (new LayoutInfo (info));
        result->second->reference_rect () = rect;
    }

    return true;
	//#UC END# *4652BB0E02BF*
}

// применят соотношение размеров
void LayoutHelper::apply_aspect_ratio (const LayoutInfo& info, int& width, int& height) {
	//#UC START# *4652BFC403D8*
	int value = 0;

    if ( !info.get_option (LayoutInfo::OT_ASPECT_RATIO, value) )
        return;

    int newWidth  = width;
    int newHeight = height;
    
    if ( newHeight > 0 && value > 0 ) {
        double newRatio = pow(10.0, (int)(-1 * info.get_precision ())) * value;

        newWidth = (int)(height * newRatio);
        newHeight = (int)(1.0 * width / newRatio);

        if ( newWidth < width )
            newHeight = height;
        else
            newWidth = width;
    }
    
    width  = newWidth;
    height = newHeight;
	//#UC END# *4652BFC403D8*
}

// применяет ограничения центрирования по x
void LayoutHelper::apply_centering_constraint_x (const LayoutInfo& info, double scaleX, int& x, int width) {
	//#UC START# *4652BFFE00CB*
	int newX = x;

    int value = 0;

    int scrollOffset = m_attach_wnd->GetScrollPos(SB_HORZ);

    if ( info.get_option (LayoutInfo::OT_CENTER_XPOS, value) )
    {
        int center = (int)((value - scrollOffset) * scaleX);
        newX = center - width / 2;
    }

    x = newX;
	//#UC END# *4652BFFE00CB*
}

// применяет ограчения центрирования по Y
void LayoutHelper::apply_centering_constraint_y (const LayoutInfo& info, double scaleY, int& y, int height) {
	//#UC START# *4652C02401E4*
	int newY = y;

    int value = 0;

    int scrollOffset = m_attach_wnd->GetScrollPos(SB_VERT);

    if ( info.get_option(LayoutInfo::OT_CENTER_YPOS, value) )
    {
        int center = (int)((value - scrollOffset) * scaleY);
        newY = center - height / 2;
    }

    y = newY;
	//#UC END# *4652C02401E4*
}

// применить ограничения по X
void LayoutHelper::apply_constraint_x (const LayoutInfo& info, int cx, double scaleX, int& x, int& width) {
	//#UC START# *4652BF270213*
	int newX = x;
    int newWidth = width;

    int value = 0;
    int value2 = 0;

    int scrollOffset = m_attach_wnd->GetScrollPos(SB_HORZ);

    // Apply sizing constraints.
	if (info.get_option (LayoutInfo::OT_MIN_WIDTH, value)) {
		newWidth = std::max(value, newWidth);
	}
    
	if (info.get_option (LayoutInfo::OT_MAX_WIDTH, value)) {
        newWidth = std::min(value, newWidth);
	}
    
    // Apply positioning constraints.
	if (info.get_option(LayoutInfo::OT_MIN_LEFT, value)) {
        newX = std::max(value - scrollOffset, newX);
	}

	if (info.get_option(LayoutInfo::OT_MAX_LEFT, value)) {
        newX = std::min(value - scrollOffset, newX);
	}

    // Apply anchoring constraints.
    if (info.get_option(LayoutInfo::OT_LEFT_OFFSET, value)) {
        // Check if we anchor to the left side of attach wnd
        // or to a moveable point.
		if (info.get_option(LayoutInfo::OT_LEFT_ANCHOR, value2)) {
            newX = value + (int)((value2-scrollOffset) * scaleX);
		} else {
            newX = value - scrollOffset;
		}
    }

    if (info.get_option (LayoutInfo::OT_RIGHT_OFFSET, value)) {
        // Check if we anchor to the right side of attach wnd
        // or to a moveable point.
		if (info.get_option(LayoutInfo::OT_RIGHT_ANCHOR, value2)) {
            newWidth = std::max((int)((value2-scrollOffset) * scaleX) - value - newX, 0);
		} else {
            newWidth = std::max((int)((m_reference_size.cx - scrollOffset) * scaleX) - value - newX, 0);
		}

        // Re-check sizing constraints.
		if (info.get_option (LayoutInfo::OT_MAX_WIDTH, value)) {
            if ( newWidth > value )
            {
                newX = newX + newWidth - value;
                newWidth = value;
            }
        }

        if (info.get_option (LayoutInfo::OT_MIN_WIDTH, value)) {
            if (newWidth < value) {
                newX = newX + newWidth - value;
                newWidth = value;
            }
        }
    }

    x = newX;
    width = newWidth;
	//#UC END# *4652BF270213*
}

// применить ограничения по Y
void LayoutHelper::apply_constraint_y (const LayoutInfo& info, int cy, double scaleY, int& y, int& height) {
	//#UC START# *4652BF91038A*
	int newY = y;
    int newHeight = height;

    int value = 0;
    int value2 = 0;

    int scrollOffset = m_attach_wnd->GetScrollPos(SB_VERT);

    // Apply sizing constraints.
    if ( info.get_option(LayoutInfo::OT_MIN_HEIGHT, value) )
        newHeight = std::max(value, newHeight);
    if ( info.get_option(LayoutInfo::OT_MAX_HEIGHT, value) )
        newHeight = std::min(value, newHeight);

    // Apply positioning constraints.
    if ( info.get_option(LayoutInfo::OT_MIN_TOP, value) )
        newY = std::max(value - scrollOffset, newY);
    if ( info.get_option(LayoutInfo::OT_MAX_TOP, value) )
        newY = std::min(value - scrollOffset, newY);
    
    // Apply anchoring constraints.
    if ( info.get_option(LayoutInfo::OT_TOP_OFFSET, value) )
    {
        // Check if we anchor to the top side of attach wnd
        // or to a moveable point.
        if ( info.get_option(LayoutInfo::OT_TOP_ANCHOR, value2) )
            newY = value + (int)((value2-scrollOffset) * scaleY);
        else
            newY = value - scrollOffset;
    }
    if ( info.get_option(LayoutInfo::OT_BOTTOM_OFFSET, value) )
    {
        // Check if we anchor to the bottom side of attach wnd
        // or to a moveable point.
        if ( info.get_option(LayoutInfo::OT_BOTTOM_ANCHOR, value2) )
            newHeight = std::max((int)((value2-scrollOffset) * scaleY) - value - newY, 0);
        else
            newHeight = std::max((int)((m_reference_size.cy - scrollOffset) * scaleY) - value - newY, 0);

        // Re-check sizing constraints.
        if ( info.get_option(LayoutInfo::OT_MAX_HEIGHT, value) )
        {
            if ( newHeight > value )
            {
                newY = newY + newHeight - value;
                newHeight = value;
            }
        }
        if ( info.get_option(LayoutInfo::OT_MIN_HEIGHT, value) )
        {
            if ( newHeight < value )
            {
                newY = newY + newHeight - value;
                newHeight = value;
            }
        }
    }

    y = newY;
    height = newHeight;
	//#UC END# *4652BF91038A*
}

// присоединяет окно
void LayoutHelper::attach_wnd (CWnd& wnd) {
	//#UC START# *4652B8E00157*
	m_attach_wnd = &wnd;
	//#UC END# *4652B8E00157*
}

// отцепляет окно
void LayoutHelper::detach_wnd () {
	//#UC START# *4652B93B00CB*
	m_attach_wnd = NULL;
	//#UC END# *4652B93B00CB*
}

// получение информации о расположении связанной с контролом
bool LayoutHelper::get_layout_info (CWnd& ctrl, LayoutInfo& info) const {
	//#UC START# *4652BC2C00FA*

    Controls::const_iterator result = m_controls.find (ctrl.m_hWnd);
	if (result == m_controls.end() ) {
        return false;    
	}

    info = *(result->second);
    return true;
	//#UC END# *4652BC2C00FA*
}

// выполняет перерасчет размеров
void LayoutHelper::layout_controls () {
	//#UC START# *4652CF0202BF*
	if (m_attach_wnd == NULL || !::IsWindow(m_attach_wnd->m_hWnd)) {
        return;
	}

	Core::Aptr<CRect> rect = WinControlHelper::get_client_rect_sb (*m_attach_wnd);

	this->perfom_layout (rect->Width(), rect->Height());
	//#UC END# *4652CF0202BF*
}

// пересчет размеров
void LayoutHelper::on_size (unsigned int type, int cx, int cy) {
	//#UC START# *4652BD680232*
	if (m_attach_wnd == NULL || !::IsWindow(m_attach_wnd->m_hWnd)) {
        return;
	}

    if ( (type == SIZE_RESTORED || type == SIZE_MAXIMIZED) && cx > 0 && cy > 0 ) {
        // If step size option, we only allow layout at fixed size increments.
		Core::Aptr<CRect> rect = WinControlHelper::get_client_rect_sb (*m_attach_wnd);
        if (m_step_size > 1) {
			int diffWidth = abs(m_prev_wnd_width - rect->Width());
			int diffHeight = abs(m_prev_wnd_height - rect->Height());

            // The difference in width or height has to be larger than
            // step size, except for one special case which we allow
            // when the difference is zero.
            if ( 
				diffWidth > m_step_size 
				|| diffHeight > m_step_size 
				|| (diffWidth == 0 && diffHeight == 0) 
			) {
				this->perfom_layout (rect->Width(), rect->Height());
                m_prev_wnd_width = rect->Width();
                m_prev_wnd_height = rect->Height();
            }
        } else {
            this->perfom_layout (rect->Width(), rect->Height());
            m_prev_wnd_width = rect->Width();
            m_prev_wnd_height = rect->Height();
        }
    }
	//#UC END# *4652BD680232*
}

// запускает алгоритм центровки для определения расположения элементов окна при ресайзе
void LayoutHelper::perfom_centered_layout (int cx, int cy) {
	//#UC START# *4652BDD003C8*
	bool doLayoutX = true;
	if (m_minimum_size.cx > 0) {
        doLayoutX = (cx > m_minimum_size.cx);
	}

    bool doLayoutY = true;
	if (m_minimum_size.cy > 0) {
        doLayoutY = (cy > m_minimum_size.cy);
	}

    // Find the min and max extent covered by all the child controls.
    int minX = INT_MAX;
    int minY = INT_MAX;
    int maxX = 0;
    int maxY = 0;
    Controls::iterator i = m_controls.begin();
    for ( ; i != m_controls.end(); ++i) {
        CWnd* pControl = m_attach_wnd->FromHandle(i->first);
        LayoutInfo* pInfo = i->second.ptr ();

        // Control's reference rect must be valid.
        const CRect& refRect = pInfo->reference_rect();
		if (refRect.Width() <= 0 || refRect.Height() <= 0) {
            continue;
		}

		minX = std::min((int)minX, (int)refRect.left);
        minY = std::min((int)minY, (int)refRect.top);
        maxX = std::max((int)maxX, (int)refRect.right);

        // If combobox, use its real height for extent calculation.
		if (WinControlHelper::is_combobox (*pControl)) {
            maxY = std::max ((int)maxY, (int)refRect.top + 21);
		} else {
            maxY = std::max ((int)maxY, (int)refRect.bottom);
		}
    }

    // Compute the width of this extent.
    int extentWidth = abs(minX - maxX);
    int extentHeight = abs(minY - maxY);

    // Compute the absolute offset to center the extent.
    int absOffsetX = std::max((cx - extentWidth) / 2, 0);
    int absOffsetY = std::max((cy - extentHeight) / 2, 0);

    // Compute the relative offset needed to move each child window control.
    int relOffsetX = absOffsetX - minX;
    int relOffsetY = absOffsetY - minY;

    // Now move each child control.
    for(i = m_controls.begin(); i != m_controls.end(); ++i) {
        HWND controlHWND = i->first;
        LayoutInfo* pInfo = i->second.ptr ();

        // Control's reference rect must be valid.
        const CRect& refRect = pInfo->reference_rect();
		if (refRect.Width() <= 0 || refRect.Height() <= 0) {
            continue;
		}

        // Begin calculating the parameters for the new control rect.
        int newX = refRect.left;
        int newY = refRect.top;
        int newWidth = refRect.Width();
        int newHeight = refRect.Height();

        // Adjust positioning due to scrolling.
        newX -= m_attach_wnd->GetScrollPos(SB_HORZ);
        newY -= m_attach_wnd->GetScrollPos(SB_VERT);

        // Apply the relative offsets for centering.
		if (doLayoutX) {
            newX += relOffsetX;
		}
		if (doLayoutY) {
            newY += relOffsetY;
		}

        // Reposition and resize the control.
        UINT flags = SWP_NOZORDER | SWP_NOACTIVATE;
        ::SetWindowPos(controlHWND, 0, newX, newY, newWidth, newHeight, flags);
    }
	//#UC END# *4652BDD003C8*
}

// запускает алгоритм по умолчанию для определения расположения элементов окна при ресайзе
void LayoutHelper::perfom_default_layout (int cx, int cy) {
	//#UC START# *4652BDCA02DE*
	double scaleX = cx * 1.0 / m_reference_size.cx;
    double scaleY = cy * 1.0 / m_reference_size.cy;

    // Check if we should apply layouts based on minimum size specification.
    bool doLayoutX = true;
	if (m_minimum_size.cx > 0) {
        doLayoutX = (cx > m_minimum_size.cx);
	}
    
	if (!doLayoutX) {
        scaleX = 1.0;
	}

    bool doLayoutY = true;
	if (m_minimum_size.cy > 0) {
        doLayoutY = (cy > m_minimum_size.cy);
	}

	if (!doLayoutY) {
        scaleY = 1.0;
	}
    // For each child control...
    Controls::iterator i = m_controls.begin();
    for ( ; i != m_controls.end(); ++i) {
        HWND controlHWND = i->first;
        LayoutInfo* pInfo = i->second.ptr ();

        // Control's reference rect must be valid.
        const CRect& refRect = pInfo->reference_rect ();
		if (refRect.Width() <= 0 || refRect.Height() <= 0) {
            continue;
		}

        // Begin calculating the parameters for the new control rect.
        int newX = refRect.left;
        int newY = refRect.top;
        int newWidth = refRect.Width();
        int newHeight = refRect.Height();

        // Adjust positioning due to scrolling.
        newX -= m_attach_wnd->GetScrollPos(SB_HORZ);
        newY -= m_attach_wnd->GetScrollPos(SB_VERT);

        // X-direction reposition and scaling.
        if (doLayoutX) {
            // Apply scaling to position and size.
            newX     = (int)(newX * scaleX);
            newWidth = (int)(refRect.Width() * scaleX);
        }

        // Y-direction reposition and scaling.
        if (doLayoutY) {
            // Apply scaling to position and size.
            newY      = (int)(newY * scaleY);
            newHeight = (int)(refRect.Height() * scaleY);
        }

        // Apply layout constraints.
		int saved_x = newX;
		int saved_y = newY;
		int saved_w = newWidth;
		int saved_h = newHeight;
		do {
			saved_x = newX;
			saved_y = newY;
			saved_w = newWidth;
			saved_h = newHeight;

			this->apply_constraint_x (*pInfo, cx, scaleX, newX, newWidth);
			this->apply_constraint_y (*pInfo, cy, scaleY, newY, newHeight);
			this->apply_aspect_ratio (*pInfo, newWidth, newHeight);
			this->apply_centering_constraint_x (*pInfo, scaleX, newX, newWidth);
			this->apply_centering_constraint_x (*pInfo, scaleY, newY, newHeight);
		} while (
			saved_x != newX
			|| saved_y != newY
			|| saved_w != newWidth
			|| saved_h != newHeight
		);

        // Reposition and resize the control.
        UINT flags = SWP_NOZORDER | SWP_NOACTIVATE;
        ::SetWindowPos(controlHWND, 0, newX, newY, newWidth, newHeight, flags);
    }
	//#UC END# *4652BDCA02DE*
}

// алгоритм
void LayoutHelper::perfom_layout (int cx, int cy) {
	//#UC START# *4652BDA6032C*
	if (m_controls.size() == 0) {
        return;
	}
	if (m_attach_wnd == NULL || !::IsWindow(m_attach_wnd->m_hWnd)) {
		return;
	}

	if ( m_reference_size.cx <= 0 || m_reference_size.cy <= 0 ) {
        return;
	}
    // Choose the layout algorithm/style to invoke.
	switch (m_layout_style) {
		case LayoutHelper::CENTERED_LAYOUT:
			this->perfom_centered_layout (cx, cy);
			break;
		case LayoutHelper::DEFAULT_LAYOUT:
			this->perfom_default_layout (cx, cy);
			break;
	}    
	//#UC END# *4652BDA6032C*
}

// удаляет ctrl из списка
bool LayoutHelper::remove_control (CWnd& ctrl) {
	//#UC START# *4652BBF0029F*

    Controls::iterator result = m_controls.find (ctrl.m_hWnd);
	if (result == m_controls.end()) {
        return false;
	}

    m_controls.erase (ctrl.m_hWnd);
    return true;
	//#UC END# *4652BBF0029F*
}
//////////////////////////////////////////////////////////////////////////////////////////
// self data accessors

int LayoutHelper::get_prev_wnd_height () const {
	//#UC START# *4652BF110119_GET_ACCESSOR*
	return m_prev_wnd_height;
	//#UC END# *4652BF110119_GET_ACCESSOR*
}

void LayoutHelper::set_prev_wnd_height (int prev_wnd_height) {
	//#UC START# *4652BF110119_SET_ACCESSOR*
	m_prev_wnd_height = prev_wnd_height;
	//#UC END# *4652BF110119_SET_ACCESSOR*
}

int LayoutHelper::get_step_size () const {
	//#UC START# *4652BCBD00DA_GET_ACCESSOR*
	return m_step_size;
	//#UC END# *4652BCBD00DA_GET_ACCESSOR*
}

void LayoutHelper::set_step_size (int step_size) {
	//#UC START# *4652BCBD00DA_SET_ACCESSOR*
	m_step_size = step_size;
	//#UC END# *4652BCBD00DA_SET_ACCESSOR*
}


} // namespace WinGUI

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

