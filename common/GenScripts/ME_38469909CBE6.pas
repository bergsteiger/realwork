unit MedicMainMenuKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы MedicMainMenu }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\MedicMainMenuKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Inpharm_Module
 {$If Defined(Nemesis)}
 , nscHideField
 {$IfEnd} // Defined(Nemesis)
 , nscTreeViewWithAdapterDragDrop
 {$If Defined(Nemesis)}
 , nscTreeViewHotTruck
 {$IfEnd} // Defined(Nemesis)
 , vtPanel
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_MedicMainMenu = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы MedicMainMenu
----
*Пример использования*:
[code]
'aControl' форма::MedicMainMenu TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_MedicMainMenu

 Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола hfReferencesAndDictionaries
----
*Пример использования*:
[code]
контрол::hfReferencesAndDictionaries TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries

 Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола hfReferencesAndDictionaries
----
*Пример использования*:
[code]
контрол::hfReferencesAndDictionaries:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push

 Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvReferencesAndDictionaries
----
*Пример использования*:
[code]
контрол::tvReferencesAndDictionaries TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries

 Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола tvReferencesAndDictionaries
----
*Пример использования*:
[code]
контрол::tvReferencesAndDictionaries:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push

 Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола hfReferencePharmaceuticalInformation
----
*Пример использования*:
[code]
контрол::hfReferencePharmaceuticalInformation TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation

 Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола hfReferencePharmaceuticalInformation
----
*Пример использования*:
[code]
контрол::hfReferencePharmaceuticalInformation:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push

 Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvReferencePharmaceuticalInformation
----
*Пример использования*:
[code]
контрол::tvReferencePharmaceuticalInformation TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation

 Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола tvReferencePharmaceuticalInformation
----
*Пример использования*:
[code]
контрол::tvReferencePharmaceuticalInformation:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push

 Tkw_MedicMainMenu_Control_hfMainFeatures = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола hfMainFeatures
----
*Пример использования*:
[code]
контрол::hfMainFeatures TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MedicMainMenu_Control_hfMainFeatures

 Tkw_MedicMainMenu_Control_hfMainFeatures_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола hfMainFeatures
----
*Пример использования*:
[code]
контрол::hfMainFeatures:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_hfMainFeatures_Push

 Tkw_MedicMainMenu_Control_tvMainFeatures = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvMainFeatures
----
*Пример использования*:
[code]
контрол::tvMainFeatures TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MedicMainMenu_Control_tvMainFeatures

 Tkw_MedicMainMenu_Control_tvMainFeatures_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола tvMainFeatures
----
*Пример использования*:
[code]
контрол::tvMainFeatures:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_tvMainFeatures_Push

 Tkw_MedicMainMenu_Control_hfRegulatoryInformation = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола hfRegulatoryInformation
----
*Пример использования*:
[code]
контрол::hfRegulatoryInformation TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation

 Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола hfRegulatoryInformation
----
*Пример использования*:
[code]
контрол::hfRegulatoryInformation:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push

 Tkw_MedicMainMenu_Control_tvRegulatoryInformation = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvRegulatoryInformation
----
*Пример использования*:
[code]
контрол::tvRegulatoryInformation TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation

 Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола tvRegulatoryInformation
----
*Пример использования*:
[code]
контрол::tvRegulatoryInformation:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push

 Tkw_MedicMainMenu_Control_pnlMain = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlMain
----
*Пример использования*:
[code]
контрол::pnlMain TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MedicMainMenu_Control_pnlMain

 Tkw_MedicMainMenu_Control_pnlMain_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlMain
----
*Пример использования*:
[code]
контрол::pnlMain:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_pnlMain_Push

 Tkw_MedicMainMenu_Control_hfLastOpenDocs = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола hfLastOpenDocs
----
*Пример использования*:
[code]
контрол::hfLastOpenDocs TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs

 Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола hfLastOpenDocs
----
*Пример использования*:
[code]
контрол::hfLastOpenDocs:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push

 Tkw_MedicMainMenu_Control_tvLastOpenDocs = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvLastOpenDocs
----
*Пример использования*:
[code]
контрол::tvLastOpenDocs TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs

 Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола tvLastOpenDocs
----
*Пример использования*:
[code]
контрол::tvLastOpenDocs:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push

 TkwEnMedicMainMenuHfReferencesAndDictionaries = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.hfReferencesAndDictionaries
[panel]Контрол hfReferencesAndDictionaries формы Ten_MedicMainMenu[panel]
*Тип результата:* TnscHideField
*Пример:*
[code]
OBJECT VAR l_TnscHideField
 aen_MedicMainMenu .Ten_MedicMainMenu.hfReferencesAndDictionaries >>> l_TnscHideField
[code]  }
  private
   function hfReferencesAndDictionaries(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
    {* Реализация слова скрипта .Ten_MedicMainMenu.hfReferencesAndDictionaries }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMedicMainMenuHfReferencesAndDictionaries

 TkwEnMedicMainMenuTvReferencesAndDictionaries = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.tvReferencesAndDictionaries
[panel]Контрол tvReferencesAndDictionaries формы Ten_MedicMainMenu[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aen_MedicMainMenu .Ten_MedicMainMenu.tvReferencesAndDictionaries >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function tvReferencesAndDictionaries(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .Ten_MedicMainMenu.tvReferencesAndDictionaries }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMedicMainMenuTvReferencesAndDictionaries

 TkwEnMedicMainMenuHfReferencePharmaceuticalInformation = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.hfReferencePharmaceuticalInformation
[panel]Контрол hfReferencePharmaceuticalInformation формы Ten_MedicMainMenu[panel]
*Тип результата:* TnscHideField
*Пример:*
[code]
OBJECT VAR l_TnscHideField
 aen_MedicMainMenu .Ten_MedicMainMenu.hfReferencePharmaceuticalInformation >>> l_TnscHideField
[code]  }
  private
   function hfReferencePharmaceuticalInformation(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
    {* Реализация слова скрипта .Ten_MedicMainMenu.hfReferencePharmaceuticalInformation }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation

 TkwEnMedicMainMenuTvReferencePharmaceuticalInformation = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.tvReferencePharmaceuticalInformation
[panel]Контрол tvReferencePharmaceuticalInformation формы Ten_MedicMainMenu[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aen_MedicMainMenu .Ten_MedicMainMenu.tvReferencePharmaceuticalInformation >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function tvReferencePharmaceuticalInformation(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .Ten_MedicMainMenu.tvReferencePharmaceuticalInformation }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation

 TkwEnMedicMainMenuHfMainFeatures = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.hfMainFeatures
[panel]Контрол hfMainFeatures формы Ten_MedicMainMenu[panel]
*Тип результата:* TnscHideField
*Пример:*
[code]
OBJECT VAR l_TnscHideField
 aen_MedicMainMenu .Ten_MedicMainMenu.hfMainFeatures >>> l_TnscHideField
[code]  }
  private
   function hfMainFeatures(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
    {* Реализация слова скрипта .Ten_MedicMainMenu.hfMainFeatures }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMedicMainMenuHfMainFeatures

 TkwEnMedicMainMenuTvMainFeatures = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.tvMainFeatures
[panel]Контрол tvMainFeatures формы Ten_MedicMainMenu[panel]
*Тип результата:* TnscTreeViewHotTruck
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aen_MedicMainMenu .Ten_MedicMainMenu.tvMainFeatures >>> l_TnscTreeViewHotTruck
[code]  }
  private
   function tvMainFeatures(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewHotTruck;
    {* Реализация слова скрипта .Ten_MedicMainMenu.tvMainFeatures }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMedicMainMenuTvMainFeatures

 TkwEnMedicMainMenuHfRegulatoryInformation = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.hfRegulatoryInformation
[panel]Контрол hfRegulatoryInformation формы Ten_MedicMainMenu[panel]
*Тип результата:* TnscHideField
*Пример:*
[code]
OBJECT VAR l_TnscHideField
 aen_MedicMainMenu .Ten_MedicMainMenu.hfRegulatoryInformation >>> l_TnscHideField
[code]  }
  private
   function hfRegulatoryInformation(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
    {* Реализация слова скрипта .Ten_MedicMainMenu.hfRegulatoryInformation }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMedicMainMenuHfRegulatoryInformation

 TkwEnMedicMainMenuTvRegulatoryInformation = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.tvRegulatoryInformation
[panel]Контрол tvRegulatoryInformation формы Ten_MedicMainMenu[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aen_MedicMainMenu .Ten_MedicMainMenu.tvRegulatoryInformation >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function tvRegulatoryInformation(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .Ten_MedicMainMenu.tvRegulatoryInformation }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMedicMainMenuTvRegulatoryInformation

 TkwEnMedicMainMenuPnlMain = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.pnlMain
[panel]Контрол pnlMain формы Ten_MedicMainMenu[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MedicMainMenu .Ten_MedicMainMenu.pnlMain >>> l_TvtPanel
[code]  }
  private
   function pnlMain(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TvtPanel;
    {* Реализация слова скрипта .Ten_MedicMainMenu.pnlMain }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMedicMainMenuPnlMain

 TkwEnMedicMainMenuHfLastOpenDocs = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.hfLastOpenDocs
[panel]Контрол hfLastOpenDocs формы Ten_MedicMainMenu[panel]
*Тип результата:* TnscHideField
*Пример:*
[code]
OBJECT VAR l_TnscHideField
 aen_MedicMainMenu .Ten_MedicMainMenu.hfLastOpenDocs >>> l_TnscHideField
[code]  }
  private
   function hfLastOpenDocs(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
    {* Реализация слова скрипта .Ten_MedicMainMenu.hfLastOpenDocs }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMedicMainMenuHfLastOpenDocs

 TkwEnMedicMainMenuTvLastOpenDocs = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.tvLastOpenDocs
[panel]Контрол tvLastOpenDocs формы Ten_MedicMainMenu[panel]
*Тип результата:* TnscTreeViewHotTruck
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aen_MedicMainMenu .Ten_MedicMainMenu.tvLastOpenDocs >>> l_TnscTreeViewHotTruck
[code]  }
  private
   function tvLastOpenDocs(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewHotTruck;
    {* Реализация слова скрипта .Ten_MedicMainMenu.tvLastOpenDocs }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMedicMainMenuTvLastOpenDocs

class function Tkw_Form_MedicMainMenu.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::MedicMainMenu';
end;//Tkw_Form_MedicMainMenu.GetWordNameForRegister

function Tkw_Form_MedicMainMenu.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5A6E12660AD2_var*
//#UC END# *4DDFD2EA0116_5A6E12660AD2_var*
begin
//#UC START# *4DDFD2EA0116_5A6E12660AD2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5A6E12660AD2_impl*
end;//Tkw_Form_MedicMainMenu.GetString

class function Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfReferencesAndDictionaries';
end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_ADD06DADA43A_var*
//#UC END# *4DDFD2EA0116_ADD06DADA43A_var*
begin
//#UC START# *4DDFD2EA0116_ADD06DADA43A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_ADD06DADA43A_impl*
end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.GetString

class procedure Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.RegisterInEngine;
//#UC START# *52A086150180_ADD06DADA43A_var*
//#UC END# *52A086150180_ADD06DADA43A_var*
begin
//#UC START# *52A086150180_ADD06DADA43A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_ADD06DADA43A_impl*
end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.RegisterInEngine

procedure Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AA864DC45F0D_var*
//#UC END# *4DAEEDE10285_AA864DC45F0D_var*
begin
//#UC START# *4DAEEDE10285_AA864DC45F0D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AA864DC45F0D_impl*
end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfReferencesAndDictionaries:push';
end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push.GetWordNameForRegister

class function Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvReferencesAndDictionaries';
end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_93BBD3452064_var*
//#UC END# *4DDFD2EA0116_93BBD3452064_var*
begin
//#UC START# *4DDFD2EA0116_93BBD3452064_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_93BBD3452064_impl*
end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.GetString

class procedure Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.RegisterInEngine;
//#UC START# *52A086150180_93BBD3452064_var*
//#UC END# *52A086150180_93BBD3452064_var*
begin
//#UC START# *52A086150180_93BBD3452064_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_93BBD3452064_impl*
end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.RegisterInEngine

procedure Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A9026FF1E14E_var*
//#UC END# *4DAEEDE10285_A9026FF1E14E_var*
begin
//#UC START# *4DAEEDE10285_A9026FF1E14E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A9026FF1E14E_impl*
end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvReferencesAndDictionaries:push';
end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push.GetWordNameForRegister

class function Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfReferencePharmaceuticalInformation';
end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_16B810FBA6B9_var*
//#UC END# *4DDFD2EA0116_16B810FBA6B9_var*
begin
//#UC START# *4DDFD2EA0116_16B810FBA6B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_16B810FBA6B9_impl*
end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.GetString

class procedure Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.RegisterInEngine;
//#UC START# *52A086150180_16B810FBA6B9_var*
//#UC END# *52A086150180_16B810FBA6B9_var*
begin
//#UC START# *52A086150180_16B810FBA6B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_16B810FBA6B9_impl*
end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.RegisterInEngine

procedure Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7437B4A75BAA_var*
//#UC END# *4DAEEDE10285_7437B4A75BAA_var*
begin
//#UC START# *4DAEEDE10285_7437B4A75BAA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7437B4A75BAA_impl*
end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfReferencePharmaceuticalInformation:push';
end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push.GetWordNameForRegister

class function Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvReferencePharmaceuticalInformation';
end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2013B1A32CC9_var*
//#UC END# *4DDFD2EA0116_2013B1A32CC9_var*
begin
//#UC START# *4DDFD2EA0116_2013B1A32CC9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2013B1A32CC9_impl*
end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.GetString

class procedure Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.RegisterInEngine;
//#UC START# *52A086150180_2013B1A32CC9_var*
//#UC END# *52A086150180_2013B1A32CC9_var*
begin
//#UC START# *52A086150180_2013B1A32CC9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2013B1A32CC9_impl*
end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.RegisterInEngine

procedure Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_69B758DCA459_var*
//#UC END# *4DAEEDE10285_69B758DCA459_var*
begin
//#UC START# *4DAEEDE10285_69B758DCA459_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_69B758DCA459_impl*
end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvReferencePharmaceuticalInformation:push';
end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push.GetWordNameForRegister

class function Tkw_MedicMainMenu_Control_hfMainFeatures.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfMainFeatures';
end;//Tkw_MedicMainMenu_Control_hfMainFeatures.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_hfMainFeatures.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_18C16B605E02_var*
//#UC END# *4DDFD2EA0116_18C16B605E02_var*
begin
//#UC START# *4DDFD2EA0116_18C16B605E02_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_18C16B605E02_impl*
end;//Tkw_MedicMainMenu_Control_hfMainFeatures.GetString

class procedure Tkw_MedicMainMenu_Control_hfMainFeatures.RegisterInEngine;
//#UC START# *52A086150180_18C16B605E02_var*
//#UC END# *52A086150180_18C16B605E02_var*
begin
//#UC START# *52A086150180_18C16B605E02_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_18C16B605E02_impl*
end;//Tkw_MedicMainMenu_Control_hfMainFeatures.RegisterInEngine

procedure Tkw_MedicMainMenu_Control_hfMainFeatures_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C202BA02A91A_var*
//#UC END# *4DAEEDE10285_C202BA02A91A_var*
begin
//#UC START# *4DAEEDE10285_C202BA02A91A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C202BA02A91A_impl*
end;//Tkw_MedicMainMenu_Control_hfMainFeatures_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfMainFeatures_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfMainFeatures:push';
end;//Tkw_MedicMainMenu_Control_hfMainFeatures_Push.GetWordNameForRegister

class function Tkw_MedicMainMenu_Control_tvMainFeatures.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvMainFeatures';
end;//Tkw_MedicMainMenu_Control_tvMainFeatures.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_tvMainFeatures.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9ED7F72E2D2D_var*
//#UC END# *4DDFD2EA0116_9ED7F72E2D2D_var*
begin
//#UC START# *4DDFD2EA0116_9ED7F72E2D2D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9ED7F72E2D2D_impl*
end;//Tkw_MedicMainMenu_Control_tvMainFeatures.GetString

class procedure Tkw_MedicMainMenu_Control_tvMainFeatures.RegisterInEngine;
//#UC START# *52A086150180_9ED7F72E2D2D_var*
//#UC END# *52A086150180_9ED7F72E2D2D_var*
begin
//#UC START# *52A086150180_9ED7F72E2D2D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_9ED7F72E2D2D_impl*
end;//Tkw_MedicMainMenu_Control_tvMainFeatures.RegisterInEngine

procedure Tkw_MedicMainMenu_Control_tvMainFeatures_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8D67A2767642_var*
//#UC END# *4DAEEDE10285_8D67A2767642_var*
begin
//#UC START# *4DAEEDE10285_8D67A2767642_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8D67A2767642_impl*
end;//Tkw_MedicMainMenu_Control_tvMainFeatures_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvMainFeatures_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvMainFeatures:push';
end;//Tkw_MedicMainMenu_Control_tvMainFeatures_Push.GetWordNameForRegister

class function Tkw_MedicMainMenu_Control_hfRegulatoryInformation.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfRegulatoryInformation';
end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_hfRegulatoryInformation.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8AC7DAC94242_var*
//#UC END# *4DDFD2EA0116_8AC7DAC94242_var*
begin
//#UC START# *4DDFD2EA0116_8AC7DAC94242_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8AC7DAC94242_impl*
end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation.GetString

class procedure Tkw_MedicMainMenu_Control_hfRegulatoryInformation.RegisterInEngine;
//#UC START# *52A086150180_8AC7DAC94242_var*
//#UC END# *52A086150180_8AC7DAC94242_var*
begin
//#UC START# *52A086150180_8AC7DAC94242_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_8AC7DAC94242_impl*
end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation.RegisterInEngine

procedure Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1B5A2267BE3E_var*
//#UC END# *4DAEEDE10285_1B5A2267BE3E_var*
begin
//#UC START# *4DAEEDE10285_1B5A2267BE3E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1B5A2267BE3E_impl*
end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfRegulatoryInformation:push';
end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push.GetWordNameForRegister

class function Tkw_MedicMainMenu_Control_tvRegulatoryInformation.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvRegulatoryInformation';
end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_tvRegulatoryInformation.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5025C2BC0C4E_var*
//#UC END# *4DDFD2EA0116_5025C2BC0C4E_var*
begin
//#UC START# *4DDFD2EA0116_5025C2BC0C4E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5025C2BC0C4E_impl*
end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation.GetString

class procedure Tkw_MedicMainMenu_Control_tvRegulatoryInformation.RegisterInEngine;
//#UC START# *52A086150180_5025C2BC0C4E_var*
//#UC END# *52A086150180_5025C2BC0C4E_var*
begin
//#UC START# *52A086150180_5025C2BC0C4E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5025C2BC0C4E_impl*
end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation.RegisterInEngine

procedure Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E137E3DE3E6_var*
//#UC END# *4DAEEDE10285_4E137E3DE3E6_var*
begin
//#UC START# *4DAEEDE10285_4E137E3DE3E6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4E137E3DE3E6_impl*
end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvRegulatoryInformation:push';
end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push.GetWordNameForRegister

class function Tkw_MedicMainMenu_Control_pnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlMain';
end;//Tkw_MedicMainMenu_Control_pnlMain.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_pnlMain.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2646A68ADB7F_var*
//#UC END# *4DDFD2EA0116_2646A68ADB7F_var*
begin
//#UC START# *4DDFD2EA0116_2646A68ADB7F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2646A68ADB7F_impl*
end;//Tkw_MedicMainMenu_Control_pnlMain.GetString

class procedure Tkw_MedicMainMenu_Control_pnlMain.RegisterInEngine;
//#UC START# *52A086150180_2646A68ADB7F_var*
//#UC END# *52A086150180_2646A68ADB7F_var*
begin
//#UC START# *52A086150180_2646A68ADB7F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2646A68ADB7F_impl*
end;//Tkw_MedicMainMenu_Control_pnlMain.RegisterInEngine

procedure Tkw_MedicMainMenu_Control_pnlMain_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1EEDBAB21711_var*
//#UC END# *4DAEEDE10285_1EEDBAB21711_var*
begin
//#UC START# *4DAEEDE10285_1EEDBAB21711_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1EEDBAB21711_impl*
end;//Tkw_MedicMainMenu_Control_pnlMain_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_pnlMain_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlMain:push';
end;//Tkw_MedicMainMenu_Control_pnlMain_Push.GetWordNameForRegister

class function Tkw_MedicMainMenu_Control_hfLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfLastOpenDocs';
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_hfLastOpenDocs.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_BF5E243FBDC6_var*
//#UC END# *4DDFD2EA0116_BF5E243FBDC6_var*
begin
//#UC START# *4DDFD2EA0116_BF5E243FBDC6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_BF5E243FBDC6_impl*
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs.GetString

class procedure Tkw_MedicMainMenu_Control_hfLastOpenDocs.RegisterInEngine;
//#UC START# *52A086150180_BF5E243FBDC6_var*
//#UC END# *52A086150180_BF5E243FBDC6_var*
begin
//#UC START# *52A086150180_BF5E243FBDC6_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_BF5E243FBDC6_impl*
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs.RegisterInEngine

procedure Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_802324D66017_var*
//#UC END# *4DAEEDE10285_802324D66017_var*
begin
//#UC START# *4DAEEDE10285_802324D66017_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_802324D66017_impl*
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfLastOpenDocs:push';
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.GetWordNameForRegister

class function Tkw_MedicMainMenu_Control_tvLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvLastOpenDocs';
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_tvLastOpenDocs.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B9D4F9E71F46_var*
//#UC END# *4DDFD2EA0116_B9D4F9E71F46_var*
begin
//#UC START# *4DDFD2EA0116_B9D4F9E71F46_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B9D4F9E71F46_impl*
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs.GetString

class procedure Tkw_MedicMainMenu_Control_tvLastOpenDocs.RegisterInEngine;
//#UC START# *52A086150180_B9D4F9E71F46_var*
//#UC END# *52A086150180_B9D4F9E71F46_var*
begin
//#UC START# *52A086150180_B9D4F9E71F46_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B9D4F9E71F46_impl*
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs.RegisterInEngine

procedure Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_20643B1309F0_var*
//#UC END# *4DAEEDE10285_20643B1309F0_var*
begin
//#UC START# *4DAEEDE10285_20643B1309F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_20643B1309F0_impl*
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvLastOpenDocs:push';
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.GetWordNameForRegister

function TkwEnMedicMainMenuHfReferencesAndDictionaries.hfReferencesAndDictionaries(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {* Реализация слова скрипта .Ten_MedicMainMenu.hfReferencesAndDictionaries }
//#UC START# *CCF260E90401_C91AEE657109_var*
//#UC END# *CCF260E90401_C91AEE657109_var*
begin
//#UC START# *CCF260E90401_C91AEE657109_impl*
 !!! Needs to be implemented !!!
//#UC END# *CCF260E90401_C91AEE657109_impl*
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.hfReferencesAndDictionaries

procedure TkwEnMedicMainMenuHfReferencesAndDictionaries.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C91AEE657109_var*
//#UC END# *4DAEEDE10285_C91AEE657109_var*
begin
//#UC START# *4DAEEDE10285_C91AEE657109_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C91AEE657109_impl*
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.DoDoIt

class function TkwEnMedicMainMenuHfReferencesAndDictionaries.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.hfReferencesAndDictionaries';
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.GetWordNameForRegister

procedure TkwEnMedicMainMenuHfReferencesAndDictionaries.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.SetValuePrim

function TkwEnMedicMainMenuHfReferencesAndDictionaries.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.GetResultTypeInfo

function TkwEnMedicMainMenuHfReferencesAndDictionaries.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.GetAllParamsCount

function TkwEnMedicMainMenuHfReferencesAndDictionaries.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.ParamsTypes

function TkwEnMedicMainMenuTvReferencesAndDictionaries.tvReferencesAndDictionaries(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .Ten_MedicMainMenu.tvReferencesAndDictionaries }
//#UC START# *1C89FF69DF0E_437CE9A2D1E0_var*
//#UC END# *1C89FF69DF0E_437CE9A2D1E0_var*
begin
//#UC START# *1C89FF69DF0E_437CE9A2D1E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *1C89FF69DF0E_437CE9A2D1E0_impl*
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.tvReferencesAndDictionaries

procedure TkwEnMedicMainMenuTvReferencesAndDictionaries.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_437CE9A2D1E0_var*
//#UC END# *4DAEEDE10285_437CE9A2D1E0_var*
begin
//#UC START# *4DAEEDE10285_437CE9A2D1E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_437CE9A2D1E0_impl*
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.DoDoIt

class function TkwEnMedicMainMenuTvReferencesAndDictionaries.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.tvReferencesAndDictionaries';
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.GetWordNameForRegister

procedure TkwEnMedicMainMenuTvReferencesAndDictionaries.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.SetValuePrim

function TkwEnMedicMainMenuTvReferencesAndDictionaries.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.GetResultTypeInfo

function TkwEnMedicMainMenuTvReferencesAndDictionaries.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.GetAllParamsCount

function TkwEnMedicMainMenuTvReferencesAndDictionaries.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.ParamsTypes

function TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.hfReferencePharmaceuticalInformation(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {* Реализация слова скрипта .Ten_MedicMainMenu.hfReferencePharmaceuticalInformation }
//#UC START# *60C63C8EFFA9_0B5AD3386AA9_var*
//#UC END# *60C63C8EFFA9_0B5AD3386AA9_var*
begin
//#UC START# *60C63C8EFFA9_0B5AD3386AA9_impl*
 !!! Needs to be implemented !!!
//#UC END# *60C63C8EFFA9_0B5AD3386AA9_impl*
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.hfReferencePharmaceuticalInformation

procedure TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0B5AD3386AA9_var*
//#UC END# *4DAEEDE10285_0B5AD3386AA9_var*
begin
//#UC START# *4DAEEDE10285_0B5AD3386AA9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0B5AD3386AA9_impl*
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.DoDoIt

class function TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.hfReferencePharmaceuticalInformation';
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.GetWordNameForRegister

procedure TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.SetValuePrim

function TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.GetResultTypeInfo

function TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.GetAllParamsCount

function TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.ParamsTypes

function TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.tvReferencePharmaceuticalInformation(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .Ten_MedicMainMenu.tvReferencePharmaceuticalInformation }
//#UC START# *000FCC58B3DC_723F1F7F4BC5_var*
//#UC END# *000FCC58B3DC_723F1F7F4BC5_var*
begin
//#UC START# *000FCC58B3DC_723F1F7F4BC5_impl*
 !!! Needs to be implemented !!!
//#UC END# *000FCC58B3DC_723F1F7F4BC5_impl*
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.tvReferencePharmaceuticalInformation

procedure TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_723F1F7F4BC5_var*
//#UC END# *4DAEEDE10285_723F1F7F4BC5_var*
begin
//#UC START# *4DAEEDE10285_723F1F7F4BC5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_723F1F7F4BC5_impl*
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.DoDoIt

class function TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.tvReferencePharmaceuticalInformation';
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.GetWordNameForRegister

procedure TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.SetValuePrim

function TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.GetResultTypeInfo

function TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.GetAllParamsCount

function TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.ParamsTypes

function TkwEnMedicMainMenuHfMainFeatures.hfMainFeatures(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {* Реализация слова скрипта .Ten_MedicMainMenu.hfMainFeatures }
//#UC START# *6F93F0E60AEE_6BE515CCE9E4_var*
//#UC END# *6F93F0E60AEE_6BE515CCE9E4_var*
begin
//#UC START# *6F93F0E60AEE_6BE515CCE9E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *6F93F0E60AEE_6BE515CCE9E4_impl*
end;//TkwEnMedicMainMenuHfMainFeatures.hfMainFeatures

procedure TkwEnMedicMainMenuHfMainFeatures.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6BE515CCE9E4_var*
//#UC END# *4DAEEDE10285_6BE515CCE9E4_var*
begin
//#UC START# *4DAEEDE10285_6BE515CCE9E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6BE515CCE9E4_impl*
end;//TkwEnMedicMainMenuHfMainFeatures.DoDoIt

class function TkwEnMedicMainMenuHfMainFeatures.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.hfMainFeatures';
end;//TkwEnMedicMainMenuHfMainFeatures.GetWordNameForRegister

procedure TkwEnMedicMainMenuHfMainFeatures.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEnMedicMainMenuHfMainFeatures.SetValuePrim

function TkwEnMedicMainMenuHfMainFeatures.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMedicMainMenuHfMainFeatures.GetResultTypeInfo

function TkwEnMedicMainMenuHfMainFeatures.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicMainMenuHfMainFeatures.GetAllParamsCount

function TkwEnMedicMainMenuHfMainFeatures.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnMedicMainMenuHfMainFeatures.ParamsTypes

function TkwEnMedicMainMenuTvMainFeatures.tvMainFeatures(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewHotTruck;
 {* Реализация слова скрипта .Ten_MedicMainMenu.tvMainFeatures }
//#UC START# *0BDB5183429C_794F6F0CBB14_var*
//#UC END# *0BDB5183429C_794F6F0CBB14_var*
begin
//#UC START# *0BDB5183429C_794F6F0CBB14_impl*
 !!! Needs to be implemented !!!
//#UC END# *0BDB5183429C_794F6F0CBB14_impl*
end;//TkwEnMedicMainMenuTvMainFeatures.tvMainFeatures

procedure TkwEnMedicMainMenuTvMainFeatures.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_794F6F0CBB14_var*
//#UC END# *4DAEEDE10285_794F6F0CBB14_var*
begin
//#UC START# *4DAEEDE10285_794F6F0CBB14_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_794F6F0CBB14_impl*
end;//TkwEnMedicMainMenuTvMainFeatures.DoDoIt

class function TkwEnMedicMainMenuTvMainFeatures.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.tvMainFeatures';
end;//TkwEnMedicMainMenuTvMainFeatures.GetWordNameForRegister

procedure TkwEnMedicMainMenuTvMainFeatures.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEnMedicMainMenuTvMainFeatures.SetValuePrim

function TkwEnMedicMainMenuTvMainFeatures.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEnMedicMainMenuTvMainFeatures.GetResultTypeInfo

function TkwEnMedicMainMenuTvMainFeatures.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicMainMenuTvMainFeatures.GetAllParamsCount

function TkwEnMedicMainMenuTvMainFeatures.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnMedicMainMenuTvMainFeatures.ParamsTypes

function TkwEnMedicMainMenuHfRegulatoryInformation.hfRegulatoryInformation(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {* Реализация слова скрипта .Ten_MedicMainMenu.hfRegulatoryInformation }
//#UC START# *F2C01E68A530_10352C98F383_var*
//#UC END# *F2C01E68A530_10352C98F383_var*
begin
//#UC START# *F2C01E68A530_10352C98F383_impl*
 !!! Needs to be implemented !!!
//#UC END# *F2C01E68A530_10352C98F383_impl*
end;//TkwEnMedicMainMenuHfRegulatoryInformation.hfRegulatoryInformation

procedure TkwEnMedicMainMenuHfRegulatoryInformation.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_10352C98F383_var*
//#UC END# *4DAEEDE10285_10352C98F383_var*
begin
//#UC START# *4DAEEDE10285_10352C98F383_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_10352C98F383_impl*
end;//TkwEnMedicMainMenuHfRegulatoryInformation.DoDoIt

class function TkwEnMedicMainMenuHfRegulatoryInformation.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.hfRegulatoryInformation';
end;//TkwEnMedicMainMenuHfRegulatoryInformation.GetWordNameForRegister

procedure TkwEnMedicMainMenuHfRegulatoryInformation.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEnMedicMainMenuHfRegulatoryInformation.SetValuePrim

function TkwEnMedicMainMenuHfRegulatoryInformation.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMedicMainMenuHfRegulatoryInformation.GetResultTypeInfo

function TkwEnMedicMainMenuHfRegulatoryInformation.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicMainMenuHfRegulatoryInformation.GetAllParamsCount

function TkwEnMedicMainMenuHfRegulatoryInformation.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnMedicMainMenuHfRegulatoryInformation.ParamsTypes

function TkwEnMedicMainMenuTvRegulatoryInformation.tvRegulatoryInformation(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .Ten_MedicMainMenu.tvRegulatoryInformation }
//#UC START# *4B5265DFEB39_88E38EE631AC_var*
//#UC END# *4B5265DFEB39_88E38EE631AC_var*
begin
//#UC START# *4B5265DFEB39_88E38EE631AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B5265DFEB39_88E38EE631AC_impl*
end;//TkwEnMedicMainMenuTvRegulatoryInformation.tvRegulatoryInformation

procedure TkwEnMedicMainMenuTvRegulatoryInformation.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_88E38EE631AC_var*
//#UC END# *4DAEEDE10285_88E38EE631AC_var*
begin
//#UC START# *4DAEEDE10285_88E38EE631AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_88E38EE631AC_impl*
end;//TkwEnMedicMainMenuTvRegulatoryInformation.DoDoIt

class function TkwEnMedicMainMenuTvRegulatoryInformation.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.tvRegulatoryInformation';
end;//TkwEnMedicMainMenuTvRegulatoryInformation.GetWordNameForRegister

procedure TkwEnMedicMainMenuTvRegulatoryInformation.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEnMedicMainMenuTvRegulatoryInformation.SetValuePrim

function TkwEnMedicMainMenuTvRegulatoryInformation.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnMedicMainMenuTvRegulatoryInformation.GetResultTypeInfo

function TkwEnMedicMainMenuTvRegulatoryInformation.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicMainMenuTvRegulatoryInformation.GetAllParamsCount

function TkwEnMedicMainMenuTvRegulatoryInformation.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnMedicMainMenuTvRegulatoryInformation.ParamsTypes

function TkwEnMedicMainMenuPnlMain.pnlMain(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TvtPanel;
 {* Реализация слова скрипта .Ten_MedicMainMenu.pnlMain }
//#UC START# *13CF5DCD4C18_3053DF0D7F26_var*
//#UC END# *13CF5DCD4C18_3053DF0D7F26_var*
begin
//#UC START# *13CF5DCD4C18_3053DF0D7F26_impl*
 !!! Needs to be implemented !!!
//#UC END# *13CF5DCD4C18_3053DF0D7F26_impl*
end;//TkwEnMedicMainMenuPnlMain.pnlMain

procedure TkwEnMedicMainMenuPnlMain.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3053DF0D7F26_var*
//#UC END# *4DAEEDE10285_3053DF0D7F26_var*
begin
//#UC START# *4DAEEDE10285_3053DF0D7F26_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3053DF0D7F26_impl*
end;//TkwEnMedicMainMenuPnlMain.DoDoIt

class function TkwEnMedicMainMenuPnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.pnlMain';
end;//TkwEnMedicMainMenuPnlMain.GetWordNameForRegister

procedure TkwEnMedicMainMenuPnlMain.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEnMedicMainMenuPnlMain.SetValuePrim

function TkwEnMedicMainMenuPnlMain.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMedicMainMenuPnlMain.GetResultTypeInfo

function TkwEnMedicMainMenuPnlMain.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicMainMenuPnlMain.GetAllParamsCount

function TkwEnMedicMainMenuPnlMain.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnMedicMainMenuPnlMain.ParamsTypes

function TkwEnMedicMainMenuHfLastOpenDocs.hfLastOpenDocs(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {* Реализация слова скрипта .Ten_MedicMainMenu.hfLastOpenDocs }
//#UC START# *5CDEE16E1F6A_56226AEAD4AE_var*
//#UC END# *5CDEE16E1F6A_56226AEAD4AE_var*
begin
//#UC START# *5CDEE16E1F6A_56226AEAD4AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *5CDEE16E1F6A_56226AEAD4AE_impl*
end;//TkwEnMedicMainMenuHfLastOpenDocs.hfLastOpenDocs

procedure TkwEnMedicMainMenuHfLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_56226AEAD4AE_var*
//#UC END# *4DAEEDE10285_56226AEAD4AE_var*
begin
//#UC START# *4DAEEDE10285_56226AEAD4AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_56226AEAD4AE_impl*
end;//TkwEnMedicMainMenuHfLastOpenDocs.DoDoIt

class function TkwEnMedicMainMenuHfLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.hfLastOpenDocs';
end;//TkwEnMedicMainMenuHfLastOpenDocs.GetWordNameForRegister

procedure TkwEnMedicMainMenuHfLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEnMedicMainMenuHfLastOpenDocs.SetValuePrim

function TkwEnMedicMainMenuHfLastOpenDocs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMedicMainMenuHfLastOpenDocs.GetResultTypeInfo

function TkwEnMedicMainMenuHfLastOpenDocs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicMainMenuHfLastOpenDocs.GetAllParamsCount

function TkwEnMedicMainMenuHfLastOpenDocs.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnMedicMainMenuHfLastOpenDocs.ParamsTypes

function TkwEnMedicMainMenuTvLastOpenDocs.tvLastOpenDocs(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewHotTruck;
 {* Реализация слова скрипта .Ten_MedicMainMenu.tvLastOpenDocs }
//#UC START# *3A5BD2842438_A599BAA66CFE_var*
//#UC END# *3A5BD2842438_A599BAA66CFE_var*
begin
//#UC START# *3A5BD2842438_A599BAA66CFE_impl*
 !!! Needs to be implemented !!!
//#UC END# *3A5BD2842438_A599BAA66CFE_impl*
end;//TkwEnMedicMainMenuTvLastOpenDocs.tvLastOpenDocs

procedure TkwEnMedicMainMenuTvLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A599BAA66CFE_var*
//#UC END# *4DAEEDE10285_A599BAA66CFE_var*
begin
//#UC START# *4DAEEDE10285_A599BAA66CFE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A599BAA66CFE_impl*
end;//TkwEnMedicMainMenuTvLastOpenDocs.DoDoIt

class function TkwEnMedicMainMenuTvLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.tvLastOpenDocs';
end;//TkwEnMedicMainMenuTvLastOpenDocs.GetWordNameForRegister

procedure TkwEnMedicMainMenuTvLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEnMedicMainMenuTvLastOpenDocs.SetValuePrim

function TkwEnMedicMainMenuTvLastOpenDocs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEnMedicMainMenuTvLastOpenDocs.GetResultTypeInfo

function TkwEnMedicMainMenuTvLastOpenDocs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicMainMenuTvLastOpenDocs.GetAllParamsCount

function TkwEnMedicMainMenuTvLastOpenDocs.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnMedicMainMenuTvLastOpenDocs.ParamsTypes

initialization
 Tkw_Form_MedicMainMenu.RegisterInEngine;
 {* Регистрация Tkw_Form_MedicMainMenu }
 Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries }
 Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push }
 Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries }
 Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push }
 Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation }
 Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push }
 Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation }
 Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push }
 Tkw_MedicMainMenu_Control_hfMainFeatures.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_hfMainFeatures }
 Tkw_MedicMainMenu_Control_hfMainFeatures_Push.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_hfMainFeatures_Push }
 Tkw_MedicMainMenu_Control_tvMainFeatures.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_tvMainFeatures }
 Tkw_MedicMainMenu_Control_tvMainFeatures_Push.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_tvMainFeatures_Push }
 Tkw_MedicMainMenu_Control_hfRegulatoryInformation.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_hfRegulatoryInformation }
 Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push }
 Tkw_MedicMainMenu_Control_tvRegulatoryInformation.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_tvRegulatoryInformation }
 Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push }
 Tkw_MedicMainMenu_Control_pnlMain.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_pnlMain }
 Tkw_MedicMainMenu_Control_pnlMain_Push.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_pnlMain_Push }
 Tkw_MedicMainMenu_Control_hfLastOpenDocs.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_hfLastOpenDocs }
 Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push }
 Tkw_MedicMainMenu_Control_tvLastOpenDocs.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_tvLastOpenDocs }
 Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.RegisterInEngine;
 {* Регистрация Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push }
 TkwEnMedicMainMenuHfReferencesAndDictionaries.RegisterInEngine;
 {* Регистрация en_MedicMainMenu_hfReferencesAndDictionaries }
 TkwEnMedicMainMenuTvReferencesAndDictionaries.RegisterInEngine;
 {* Регистрация en_MedicMainMenu_tvReferencesAndDictionaries }
 TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.RegisterInEngine;
 {* Регистрация en_MedicMainMenu_hfReferencePharmaceuticalInformation }
 TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.RegisterInEngine;
 {* Регистрация en_MedicMainMenu_tvReferencePharmaceuticalInformation }
 TkwEnMedicMainMenuHfMainFeatures.RegisterInEngine;
 {* Регистрация en_MedicMainMenu_hfMainFeatures }
 TkwEnMedicMainMenuTvMainFeatures.RegisterInEngine;
 {* Регистрация en_MedicMainMenu_tvMainFeatures }
 TkwEnMedicMainMenuHfRegulatoryInformation.RegisterInEngine;
 {* Регистрация en_MedicMainMenu_hfRegulatoryInformation }
 TkwEnMedicMainMenuTvRegulatoryInformation.RegisterInEngine;
 {* Регистрация en_MedicMainMenu_tvRegulatoryInformation }
 TkwEnMedicMainMenuPnlMain.RegisterInEngine;
 {* Регистрация en_MedicMainMenu_pnlMain }
 TkwEnMedicMainMenuHfLastOpenDocs.RegisterInEngine;
 {* Регистрация en_MedicMainMenu_hfLastOpenDocs }
 TkwEnMedicMainMenuTvLastOpenDocs.RegisterInEngine;
 {* Регистрация en_MedicMainMenu_tvLastOpenDocs }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_MedicMainMenu));
 {* Регистрация типа MedicMainMenu }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscHideField));
 {* Регистрация типа TnscHideField }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* Регистрация типа TnscTreeViewWithAdapterDragDrop }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewHotTruck));
 {* Регистрация типа TnscTreeViewHotTruck }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
