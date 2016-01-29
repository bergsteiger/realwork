////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAModel/RoseInternal/RoseRichTypeImpl.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> MDProcess::MDAModel::RoseInternal::RoseRichTypeImpl
//
// реализация IRoseRichType
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSERICHTYPEIMPL_H__
#define __MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSERICHTYPEIMPL_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
#include "MDProcess/MDAModel/RoseInternal/RoseItem.h"

//#UC START# *4A3B1C2C01EA_USER_INCLUDES*
#include "shared/Core/fix/win_afx.h"
//#UC END# *4A3B1C2C01EA_USER_INCLUDES*

namespace RoseInternal {

//#UC START# *4A3B1C2C01EA_USER_DEFINITION*
class RoseRichTypeImpl:
	public ATL::CComObjectRootEx<ATL::CComSingleThreadModel>
	, public ATL::CComCoClass<RoseRichTypeImpl>
	, public ATL::IDispatchImpl<IRoseRichType, &__uuidof(IRoseRichType)>
{
	typedef RoseRichTypeImpl ThisClass;
	SET_OBJECT_COUNTER (ThisClass)

public:
	RoseRichTypeImpl ();

	DECLARE_PROTECT_FINAL_CONSTRUCT()
	
	BEGIN_COM_MAP(ThisClass)
		COM_INTERFACE_ENTRY(IRoseRichType)
		COM_INTERFACE_ENTRY(IDispatch)
	END_COM_MAP()

	STDMETHODIMP Invoke(DISPID id, REFIID , LCID , WORD Flags, DISPPARAMS *DispParams, VARIANT* Result, EXCEPINFO* pe, UINT* pu);

	void set_delegate (RoseItem* delegate);
	RoseItem* get_delegate ();
private:
	std::string m_name;
	short m_value;
	RoseItem* m_delegate;
};
//#UC END# *4A3B1C2C01EA_USER_DEFINITION*

} // namespace RoseInternal


#endif //__MDPROCESS_MDAMODEL_ROSEINTERNAL_ROSERICHTYPEIMPL_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
