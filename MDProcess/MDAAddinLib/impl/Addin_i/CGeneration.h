////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/MDProcess/MDAAddinLib/impl/Addin_i/CGeneration.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<ComServant::Class>> MDProcess::MDAAddinLib::Addin_i::CGeneration
// Заголовок реализации класса серванта для интерфеса IGeneration
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __MDPROCESS_MDAADDINLIB_ADDIN_I_CGENERATION_H__
#define __MDPROCESS_MDAADDINLIB_ADDIN_I_CGENERATION_H__

#include "shared/CoreSrv/sys/std_inc.h"
#include "shared/Core/fix/win_afx.h"	
#include "MDProcess/MDAAddinLib/LibHome.h"
//#UC START# *456C42C601A5_PRE_CUSTOM_INCLUDES*
#include "MDProcess/MDAModel/RoseTypes/RationalRoseTlb.h"
//#UC END# *456C42C601A5_PRE_CUSTOM_INCLUDES*
#include "MDProcess/MDAAddinLib/Addin/Addin_i.h"
#include "MDProcess/MDAGenerator/MDAGenerator.h"
//#UC START# *456C42C601A5_CUSTOM_INCLUDES*
#include <set>
#include <string>
#include <vector>
#include "MDProcess/MDAModel/RoseDumpers/RoseHelper.h"
//#UC END# *456C42C601A5_CUSTOM_INCLUDES*



class ATL_NO_VTABLE CGeneration:
	public ATL::CComObjectRootEx<ATL::CComSingleThreadModel>
	, public ATL::CComCoClass<CGeneration, &CLSID_CoIGeneration>
	, public ISupportErrorInfo
	, public ATL::IDispatchImpl<IGeneration, &IID_IGeneration, &LIBID_AddinLib>
{
	SET_OBJECT_COUNTER (CGeneration)
//////////////////////////////////////////////////////////////////////////////////////////
// constructors and destructor
protected:
	virtual ~CGeneration ();
//////////////////////////////////////////////////////////////////////////////////////////
// ComServant declaration
public:
	//#UC START# *456C42C601A5REGISTRY_RESOURCEID*
	DECLARE_REGISTRY_RESOURCEID(IDR_GENERATION)
	//#UC END# *456C42C601A5REGISTRY_RESOURCEID*
	DECLARE_PROTECT_FINAL_CONSTRUCT()
	
	BEGIN_COM_MAP(CGeneration)
		COM_INTERFACE_ENTRY(IGeneration)
		COM_INTERFACE_ENTRY(IDispatch)
		COM_INTERFACE_ENTRY(ISupportErrorInfo)
	END_COM_MAP()
	
	// ISupportsErrorInfo
	STDMETHOD(InterfaceSupportsErrorInfo)(REFIID riid) {
		return S_FALSE;
	}

//#UC START# *456C42C601A5*
public:
	class MissedGenFileDlg_i : public RoseAbstractDumper::IMissedGenFileDlg {
	public:
		bool do_remove (const std::string& file_name) {
			std::string text = "Генератор не может найти ранее сгенерированный файл:\n \""
				+ file_name
				+ "\"\nдля загрузки User Code секций. Пропустить и продолжить генерацию?\nНажмите Yes для удаления ссылки на файл из модели и продолжения генерации или No для повторной попытки загрузить файл.";
			return MessageBox (NULL, text.data(), "Missing File", MB_YESNO) == IDYES;
		}
	};

// IGeneration
public:
	STDMETHOD(OnGenerate)(IDispatch* pRoseDisp);
	STDMETHOD(OnViewReport)(IDispatch* pRoseDisp);	
	STDMETHOD(OnAdvancedSearch)(IDispatch* pRoseDisp);	
	STDMETHOD(OnAbout)(IDispatch* pRoseDisp);
	STDMETHOD(OnDeactivate)(IRoseApplication* app);
	STDMETHOD(OnActivate)(IRoseApplication* app);		
	STDMETHOD(OnPropertySpecOpen)(IRoseApplication *pRoseApp, IRoseItem *pRoseItem, VARIANT_BOOL *result);
	STDMETHOD(OnMDAProperty)(IDispatch* pRoseDisp);
	STDMETHOD(OnSelectedContextMenuItem)(IRoseApplication *pRoseApp, const BSTR strInternalName, VARIANT_BOOL *result);
	STDMETHOD(OnSaveModel)(IRoseApplication* app, IRoseControllableUnit *unit, BOOLEAN flag);
	STDMETHOD(OnNewModel)(IRoseApplication* app);
	STDMETHOD(OnOpenModel)(IRoseApplication* app);
	STDMETHOD(OnNewModelElement)(IRoseApplication* app, IRoseItem* item);
	STDMETHOD(OnModifiedModelElementEx)(IRoseApplication* app, IRoseItem* item, int reason, VARIANT var);
	STDMETHOD(OnModifiedModelElement(IRoseApplication* app, IRoseItem* item, int reason));
	STDMETHOD(OnDeletedModelElementEx)(IRoseApplication* app, IRoseItem* item, IRoseItem* par);
	STDMETHOD(OnCloseModel)(IRoseApplication* app);
	STDMETHOD(OnEnableContextMenuItems)(IRoseApplication* app, int item_type, VARIANT_BOOL *result);
	STDMETHOD(OnColorizeAllDiagrams)(IDispatch* pRoseDisp);
	STDMETHOD(OnSelectTemplate)(IDispatch* pRoseDisp);
	STDMETHOD(OnMDASave)(IDispatch* pRoseDisp);
	STDMETHOD(OnMDAGeneratorOptions)(IDispatch* pRoseDisp);
	STDMETHOD(OnMDACleanModelProperties)(IDispatch* pRoseDisp);
	STDMETHOD(OnMDACustomWork)(IDispatch* pRoseDisp);

private:
	void reset_model_stereotype (IRoseItem* item);
private:
	typedef ATL::CComPtr<IModelExplorer> IModelExplorerPtr;
	IModelExplorerPtr m_model_explorer;
//#UC END# *456C42C601A5*
}; // class CGeneration



#endif //__MDPROCESS_MDAADDINLIB_ADDIN_I_CGENERATION_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
