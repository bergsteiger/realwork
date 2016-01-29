////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CMDAToolbar.h"
// C++ header files (.h)
// Generated from UML model, root element: <<ComServant::Class>> MDProcess::MDAAddinLib::Addin_i::CMDAToolbar
// Заголовок реализации класса серванта для интерфеса IMDAToolbar
//
// реализация интерйеса IMDAToolbar
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_CMDATOOLBAR_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_CMDATOOLBAR_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"	
#include "MDProcess/MDAAddinLib/LibHome.h"
#include "MDProcess/MDAAddinLib/impl/Addin_i/ATLControls.h"
//#UC START# *45B5C72202AF_PRE_CUSTOM_INCLUDES*
#include "MDProcess/MDAModel/RoseDumpers/RationalRoseTlb.h"
//#UC END# *45B5C72202AF_PRE_CUSTOM_INCLUDES*
#include "MDProcess/MDAAddinLib/Addin/Addin_i.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *45B5C72202AF_CUSTOM_INCLUDES*
#include <atlctl.h>
//#UC END# *45B5C72202AF_CUSTOM_INCLUDES*



// реализация интерйеса IMDAToolbar
class ATL_NO_VTABLE CMDAToolbar:
	public ATL::CComObjectRootEx<ATL::CComSingleThreadModel>
	, public ATL::CComCoClass<CMDAToolbar, &CLSID_CoIMDAToolbar>
	, public ISupportErrorInfo
	, public ATL::IDispatchImpl<IMDAToolbar, &IID_IMDAToolbar, &LIBID_AddinLib>
	, public ATL::CComControl<CMDAToolbar>		
	, public ATL::ISpecifyPropertyPagesImpl<CMDAToolbar>
	, public ATL::IPersistStreamInitImpl<CMDAToolbar>
	, public ATL::IOleControlImpl<CMDAToolbar>
	, public ATL::IOleObjectImpl<CMDAToolbar>
	, public ATL::IOleInPlaceActiveObjectImpl<CMDAToolbar>
	, public ATL::IViewObjectExImpl<CMDAToolbar>
	, public ATL::IOleInPlaceObjectWindowlessImpl<CMDAToolbar>
	, public ATL::IProvideClassInfo2Impl<&CLSID_CoIMDAToolbar, NULL>		
	, public ATL::IObjectSafetyImpl<CMDAToolbar, INTERFACESAFE_FOR_UNTRUSTED_CALLER>
{
	SET_OBJECT_COUNTER (CMDAToolbar)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~CMDAToolbar ();

//////////////////////////////////////////////////////////////////////////////////////////
// self methods
private:
	// функция скрывает заголовок контейнера
	virtual void hide_container_caption ();

	// обработчик события WM_CREATE
	virtual LRESULT on_create (UINT u_msg, WPARAM w_param, LPARAM l_param, BOOL& handled);

	// обработчик события WM_LBUTTONDBLCLK
	virtual LRESULT on_dbl_click (UINT u_msg, WPARAM w_param, LPARAM l_param, BOOL& handled);

	// обработчик нажатия кнопки тулбара: вызывает дилог генерации выделенного
	// элемента на модели (если выделенного элемента нет - генерация
	// запускается для рута)
	virtual LRESULT on_mda_generate (WORD notify_code, WORD id, HWND ctrl, BOOL& handled);

	// обработчик нажатия кнопки тулбара: вызывает дилог свойств выделенного
	// элемента на модели (если выделенного элемента нет - свойства показываются
	// для рута)
	virtual LRESULT on_mda_property (WORD notify_code, WORD id, HWND ctrl, BOOL& handled);

	// обработчик нажатия кнопки тулбара: вызывает дилог построения отчета
	// выделенного элемента на модели (если выделенного элемента нет
	// - отчет строится для рута)
	virtual LRESULT on_mda_report (WORD notify_code, WORD id, HWND ctrl, BOOL& handled);

	// обработчик нажатия кнопки тулбара: вызывает дилог поиска выделенного
	// элемента на модели (если выделенного элемента нет - поиск для
	// рута)
	virtual LRESULT on_mda_search (WORD notify_code, WORD id, HWND ctrl, BOOL& handled);

	// обработчик команды ID_MDA_VIEW_LOCKED_COMMAND
	virtual LRESULT on_view_locked (WORD notify_code, WORD id, HWND ctrl, BOOL& handled);

	// функция показывает заголовок контейнера
	virtual void show_container_caption ();

//////////////////////////////////////////////////////////////////////////////////////////
// self data
private:
	// флаг - показан или нет кэпшн контейнера ActiveX
	bool m_container_caption_show;

	// тулбар
	ATLControls::CToolBarCtrl m_toolbar;

	// контрол для рисования всплывающих подсказок
	ATLControls::CToolTipCtrl m_tooltip;
//////////////////////////////////////////////////////////////////////////////////////////
// ComServant declaration
public:
	//#UC START# *45B5C72202AFREGISTRY_RESOURCEID*
	DECLARE_REGISTRY_RESOURCEID(IDR_GENERATION)
	//#UC END# *45B5C72202AFREGISTRY_RESOURCEID*
	DECLARE_PROTECT_FINAL_CONSTRUCT()
	
	BEGIN_COM_MAP(CMDAToolbar)
		COM_INTERFACE_ENTRY(IMDAToolbar)
		COM_INTERFACE_ENTRY(IDispatch)
		COM_INTERFACE_ENTRY(ISupportErrorInfo)
		COM_INTERFACE_ENTRY(IViewObject)
		COM_INTERFACE_ENTRY(IViewObject2)
		COM_INTERFACE_ENTRY(IViewObjectEx)
		COM_INTERFACE_ENTRY(ISpecifyPropertyPages)
		COM_INTERFACE_ENTRY2(IOleWindow, IOleInPlaceObjectWindowless)
		COM_INTERFACE_ENTRY(IOleInPlaceObject)
		COM_INTERFACE_ENTRY(IOleInPlaceObjectWindowless)
		COM_INTERFACE_ENTRY(IOleInPlaceActiveObject)
		COM_INTERFACE_ENTRY(IOleControl)
		COM_INTERFACE_ENTRY(IOleObject)
		COM_INTERFACE_ENTRY(IPersistStreamInit)
		COM_INTERFACE_ENTRY2(IPersist, IPersistStreamInit)
		COM_INTERFACE_ENTRY(IProvideClassInfo)
		COM_INTERFACE_ENTRY(IProvideClassInfo2)
		COM_INTERFACE_ENTRY(IObjectSafety)
		
	END_COM_MAP()
	
	BEGIN_PROP_MAP(CMDAToolbar)
		PROP_DATA_ENTRY("_cx", m_sizeExtent.cx, VT_UI4)
		PROP_DATA_ENTRY("_cy", m_sizeExtent.cy, VT_UI4)
	END_PROP_MAP()
	
	BEGIN_MSG_MAP(CMDAToolbar)
		//#UC START# *45B5C72202AFMSG_MAP*
			MESSAGE_HANDLER(WM_CREATE, on_create)		
			MESSAGE_HANDLER(WM_LBUTTONDBLCLK, on_dbl_click)
			COMMAND_ID_HANDLER (ID_MDAPROP_COMMAND, on_mda_property);
			COMMAND_ID_HANDLER (ID_MDAGEN_COMMAND, on_mda_generate);
			COMMAND_ID_HANDLER (ID_MDAREP_COMMAND, on_mda_report);
			COMMAND_ID_HANDLER (ID_MDASRCH_COMMAND, on_mda_search);
			COMMAND_ID_HANDLER (ID_MDA_VIEW_LOCKED_COMMAND, on_view_locked);
			
			REFLECT_NOTIFICATIONS()
			DEFAULT_REFLECTION_HANDLER()	
		//#UC END# *45B5C72202AFMSG_MAP*
	END_MSG_MAP()
	
	// ISupportsErrorInfo
	STDMETHOD(InterfaceSupportsErrorInfo)(REFIID riid) {
		return S_FALSE;
	}

//#UC START# *45B5C72202AF*	
public:
	DECLARE_WND_CLASS_EX(NULL, CS_HREDRAW | CS_VREDRAW | CS_DBLCLKS, COLOR_BTNFACE);

DECLARE_OLEMISC_STATUS(OLEMISC_RECOMPOSEONRESIZE | 
	OLEMISC_CANTLINKINSIDE | 
	OLEMISC_INSIDEOUT | 
	OLEMISC_ACTIVATEWHENVISIBLE | 
	OLEMISC_SETCLIENTSITEFIRST
)

//#UC END# *45B5C72202AF*
}; // class CMDAToolbar



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_CMDATOOLBAR_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
