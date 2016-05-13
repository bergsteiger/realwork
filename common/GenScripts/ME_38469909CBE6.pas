unit MedicMainMenuKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы MedicMainMenu }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\MedicMainMenuKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "MedicMainMenuKeywordsPack" MUID: (38469909CBE6)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If Defined(Nemesis)}
 , nscHideField
 {$IfEnd} // Defined(Nemesis)
 , nscTreeViewWithAdapterDragDrop
 {$If Defined(Nemesis)}
 , nscTreeViewHotTruck
 {$IfEnd} // Defined(Nemesis)
 , vtPanel
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , MedicMainMenu_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , TypInfo
 , tfwTypeInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
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
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_MedicMainMenu

 Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола hfReferencesAndDictionaries
----
*Пример использования*:
[code]
контрол::hfReferencesAndDictionaries TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries

 Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries

 Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation

 Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation

 Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_hfMainFeatures

 Tkw_MedicMainMenu_Control_hfMainFeatures_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_tvMainFeatures

 Tkw_MedicMainMenu_Control_tvMainFeatures_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation

 Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation

 Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_pnlMain

 Tkw_MedicMainMenu_Control_pnlMain_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs

 Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs

 Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
  {* Слово скрипта .Ten_MedicMainMenu.hfReferencesAndDictionaries }
  private
   function hfReferencesAndDictionaries(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
    {* Реализация слова скрипта .Ten_MedicMainMenu.hfReferencesAndDictionaries }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicMainMenuHfReferencesAndDictionaries

 TkwEnMedicMainMenuTvReferencesAndDictionaries = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.tvReferencesAndDictionaries }
  private
   function tvReferencesAndDictionaries(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .Ten_MedicMainMenu.tvReferencesAndDictionaries }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicMainMenuTvReferencesAndDictionaries

 TkwEnMedicMainMenuHfReferencePharmaceuticalInformation = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.hfReferencePharmaceuticalInformation }
  private
   function hfReferencePharmaceuticalInformation(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
    {* Реализация слова скрипта .Ten_MedicMainMenu.hfReferencePharmaceuticalInformation }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation

 TkwEnMedicMainMenuTvReferencePharmaceuticalInformation = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.tvReferencePharmaceuticalInformation }
  private
   function tvReferencePharmaceuticalInformation(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .Ten_MedicMainMenu.tvReferencePharmaceuticalInformation }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation

 TkwEnMedicMainMenuHfMainFeatures = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.hfMainFeatures }
  private
   function hfMainFeatures(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
    {* Реализация слова скрипта .Ten_MedicMainMenu.hfMainFeatures }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicMainMenuHfMainFeatures

 TkwEnMedicMainMenuTvMainFeatures = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.tvMainFeatures }
  private
   function tvMainFeatures(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewHotTruck;
    {* Реализация слова скрипта .Ten_MedicMainMenu.tvMainFeatures }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicMainMenuTvMainFeatures

 TkwEnMedicMainMenuHfRegulatoryInformation = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.hfRegulatoryInformation }
  private
   function hfRegulatoryInformation(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
    {* Реализация слова скрипта .Ten_MedicMainMenu.hfRegulatoryInformation }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicMainMenuHfRegulatoryInformation

 TkwEnMedicMainMenuTvRegulatoryInformation = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.tvRegulatoryInformation }
  private
   function tvRegulatoryInformation(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .Ten_MedicMainMenu.tvRegulatoryInformation }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicMainMenuTvRegulatoryInformation

 TkwEnMedicMainMenuPnlMain = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.pnlMain }
  private
   function pnlMain(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TvtPanel;
    {* Реализация слова скрипта .Ten_MedicMainMenu.pnlMain }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicMainMenuPnlMain

 TkwEnMedicMainMenuHfLastOpenDocs = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.hfLastOpenDocs }
  private
   function hfLastOpenDocs(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
    {* Реализация слова скрипта .Ten_MedicMainMenu.hfLastOpenDocs }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicMainMenuHfLastOpenDocs

 TkwEnMedicMainMenuTvLastOpenDocs = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicMainMenu.tvLastOpenDocs }
  private
   function tvLastOpenDocs(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewHotTruck;
    {* Реализация слова скрипта .Ten_MedicMainMenu.tvLastOpenDocs }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMedicMainMenuTvLastOpenDocs

function Tkw_Form_MedicMainMenu.GetString: AnsiString;
begin
 Result := 'en_MedicMainMenu';
end;//Tkw_Form_MedicMainMenu.GetString

class function Tkw_Form_MedicMainMenu.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::MedicMainMenu';
end;//Tkw_Form_MedicMainMenu.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.GetString: AnsiString;
begin
 Result := 'hfReferencesAndDictionaries';
end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.GetString

class procedure Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.RegisterInEngine

class function Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfReferencesAndDictionaries';
end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfReferencesAndDictionaries');
 inherited;
end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfReferencesAndDictionaries:push';
end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.GetString: AnsiString;
begin
 Result := 'tvReferencesAndDictionaries';
end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.GetString

class procedure Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.RegisterInEngine

class function Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvReferencesAndDictionaries';
end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvReferencesAndDictionaries');
 inherited;
end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvReferencesAndDictionaries:push';
end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.GetString: AnsiString;
begin
 Result := 'hfReferencePharmaceuticalInformation';
end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.GetString

class procedure Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.RegisterInEngine

class function Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfReferencePharmaceuticalInformation';
end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfReferencePharmaceuticalInformation');
 inherited;
end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfReferencePharmaceuticalInformation:push';
end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.GetString: AnsiString;
begin
 Result := 'tvReferencePharmaceuticalInformation';
end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.GetString

class procedure Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.RegisterInEngine

class function Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvReferencePharmaceuticalInformation';
end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvReferencePharmaceuticalInformation');
 inherited;
end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvReferencePharmaceuticalInformation:push';
end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_hfMainFeatures.GetString: AnsiString;
begin
 Result := 'hfMainFeatures';
end;//Tkw_MedicMainMenu_Control_hfMainFeatures.GetString

class procedure Tkw_MedicMainMenu_Control_hfMainFeatures.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MedicMainMenu_Control_hfMainFeatures.RegisterInEngine

class function Tkw_MedicMainMenu_Control_hfMainFeatures.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfMainFeatures';
end;//Tkw_MedicMainMenu_Control_hfMainFeatures.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_hfMainFeatures_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfMainFeatures');
 inherited;
end;//Tkw_MedicMainMenu_Control_hfMainFeatures_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfMainFeatures_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfMainFeatures:push';
end;//Tkw_MedicMainMenu_Control_hfMainFeatures_Push.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_tvMainFeatures.GetString: AnsiString;
begin
 Result := 'tvMainFeatures';
end;//Tkw_MedicMainMenu_Control_tvMainFeatures.GetString

class procedure Tkw_MedicMainMenu_Control_tvMainFeatures.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_MedicMainMenu_Control_tvMainFeatures.RegisterInEngine

class function Tkw_MedicMainMenu_Control_tvMainFeatures.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvMainFeatures';
end;//Tkw_MedicMainMenu_Control_tvMainFeatures.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_tvMainFeatures_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvMainFeatures');
 inherited;
end;//Tkw_MedicMainMenu_Control_tvMainFeatures_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvMainFeatures_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvMainFeatures:push';
end;//Tkw_MedicMainMenu_Control_tvMainFeatures_Push.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_hfRegulatoryInformation.GetString: AnsiString;
begin
 Result := 'hfRegulatoryInformation';
end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation.GetString

class procedure Tkw_MedicMainMenu_Control_hfRegulatoryInformation.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation.RegisterInEngine

class function Tkw_MedicMainMenu_Control_hfRegulatoryInformation.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfRegulatoryInformation';
end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfRegulatoryInformation');
 inherited;
end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfRegulatoryInformation:push';
end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_tvRegulatoryInformation.GetString: AnsiString;
begin
 Result := 'tvRegulatoryInformation';
end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation.GetString

class procedure Tkw_MedicMainMenu_Control_tvRegulatoryInformation.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation.RegisterInEngine

class function Tkw_MedicMainMenu_Control_tvRegulatoryInformation.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvRegulatoryInformation';
end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvRegulatoryInformation');
 inherited;
end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvRegulatoryInformation:push';
end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_pnlMain.GetString: AnsiString;
begin
 Result := 'pnlMain';
end;//Tkw_MedicMainMenu_Control_pnlMain.GetString

class procedure Tkw_MedicMainMenu_Control_pnlMain.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MedicMainMenu_Control_pnlMain.RegisterInEngine

class function Tkw_MedicMainMenu_Control_pnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlMain';
end;//Tkw_MedicMainMenu_Control_pnlMain.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_pnlMain_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlMain');
 inherited;
end;//Tkw_MedicMainMenu_Control_pnlMain_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_pnlMain_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlMain:push';
end;//Tkw_MedicMainMenu_Control_pnlMain_Push.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_hfLastOpenDocs.GetString: AnsiString;
begin
 Result := 'hfLastOpenDocs';
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs.GetString

class procedure Tkw_MedicMainMenu_Control_hfLastOpenDocs.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs.RegisterInEngine

class function Tkw_MedicMainMenu_Control_hfLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfLastOpenDocs';
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfLastOpenDocs');
 inherited;
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfLastOpenDocs:push';
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.GetWordNameForRegister

function Tkw_MedicMainMenu_Control_tvLastOpenDocs.GetString: AnsiString;
begin
 Result := 'tvLastOpenDocs';
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs.GetString

class procedure Tkw_MedicMainMenu_Control_tvLastOpenDocs.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs.RegisterInEngine

class function Tkw_MedicMainMenu_Control_tvLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvLastOpenDocs';
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvLastOpenDocs');
 inherited;
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvLastOpenDocs:push';
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.GetWordNameForRegister

function TkwEnMedicMainMenuHfReferencesAndDictionaries.hfReferencesAndDictionaries(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {* Реализация слова скрипта .Ten_MedicMainMenu.hfReferencesAndDictionaries }
begin
 Result := aen_MedicMainMenu.hfReferencesAndDictionaries;
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.hfReferencesAndDictionaries

class function TkwEnMedicMainMenuHfReferencesAndDictionaries.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.hfReferencesAndDictionaries';
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.ParamsTypes

procedure TkwEnMedicMainMenuHfReferencesAndDictionaries.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству hfReferencesAndDictionaries', aCtx);
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.SetValuePrim

procedure TkwEnMedicMainMenuHfReferencesAndDictionaries.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfReferencesAndDictionaries(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.DoDoIt

function TkwEnMedicMainMenuTvReferencesAndDictionaries.tvReferencesAndDictionaries(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .Ten_MedicMainMenu.tvReferencesAndDictionaries }
begin
 Result := aen_MedicMainMenu.tvReferencesAndDictionaries;
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.tvReferencesAndDictionaries

class function TkwEnMedicMainMenuTvReferencesAndDictionaries.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.tvReferencesAndDictionaries';
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.ParamsTypes

procedure TkwEnMedicMainMenuTvReferencesAndDictionaries.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvReferencesAndDictionaries', aCtx);
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.SetValuePrim

procedure TkwEnMedicMainMenuTvReferencesAndDictionaries.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvReferencesAndDictionaries(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.DoDoIt

function TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.hfReferencePharmaceuticalInformation(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {* Реализация слова скрипта .Ten_MedicMainMenu.hfReferencePharmaceuticalInformation }
begin
 Result := aen_MedicMainMenu.hfReferencePharmaceuticalInformation;
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.hfReferencePharmaceuticalInformation

class function TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.hfReferencePharmaceuticalInformation';
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.ParamsTypes

procedure TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству hfReferencePharmaceuticalInformation', aCtx);
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.SetValuePrim

procedure TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfReferencePharmaceuticalInformation(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.DoDoIt

function TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.tvReferencePharmaceuticalInformation(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .Ten_MedicMainMenu.tvReferencePharmaceuticalInformation }
begin
 Result := aen_MedicMainMenu.tvReferencePharmaceuticalInformation;
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.tvReferencePharmaceuticalInformation

class function TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.tvReferencePharmaceuticalInformation';
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.ParamsTypes

procedure TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvReferencePharmaceuticalInformation', aCtx);
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.SetValuePrim

procedure TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvReferencePharmaceuticalInformation(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.DoDoIt

function TkwEnMedicMainMenuHfMainFeatures.hfMainFeatures(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {* Реализация слова скрипта .Ten_MedicMainMenu.hfMainFeatures }
begin
 Result := aen_MedicMainMenu.hfMainFeatures;
end;//TkwEnMedicMainMenuHfMainFeatures.hfMainFeatures

class function TkwEnMedicMainMenuHfMainFeatures.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.hfMainFeatures';
end;//TkwEnMedicMainMenuHfMainFeatures.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuHfMainFeatures.ParamsTypes

procedure TkwEnMedicMainMenuHfMainFeatures.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству hfMainFeatures', aCtx);
end;//TkwEnMedicMainMenuHfMainFeatures.SetValuePrim

procedure TkwEnMedicMainMenuHfMainFeatures.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfMainFeatures(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuHfMainFeatures.DoDoIt

function TkwEnMedicMainMenuTvMainFeatures.tvMainFeatures(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewHotTruck;
 {* Реализация слова скрипта .Ten_MedicMainMenu.tvMainFeatures }
begin
 Result := aen_MedicMainMenu.tvMainFeatures;
end;//TkwEnMedicMainMenuTvMainFeatures.tvMainFeatures

class function TkwEnMedicMainMenuTvMainFeatures.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.tvMainFeatures';
end;//TkwEnMedicMainMenuTvMainFeatures.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuTvMainFeatures.ParamsTypes

procedure TkwEnMedicMainMenuTvMainFeatures.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvMainFeatures', aCtx);
end;//TkwEnMedicMainMenuTvMainFeatures.SetValuePrim

procedure TkwEnMedicMainMenuTvMainFeatures.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvMainFeatures(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuTvMainFeatures.DoDoIt

function TkwEnMedicMainMenuHfRegulatoryInformation.hfRegulatoryInformation(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {* Реализация слова скрипта .Ten_MedicMainMenu.hfRegulatoryInformation }
begin
 Result := aen_MedicMainMenu.hfRegulatoryInformation;
end;//TkwEnMedicMainMenuHfRegulatoryInformation.hfRegulatoryInformation

class function TkwEnMedicMainMenuHfRegulatoryInformation.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.hfRegulatoryInformation';
end;//TkwEnMedicMainMenuHfRegulatoryInformation.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuHfRegulatoryInformation.ParamsTypes

procedure TkwEnMedicMainMenuHfRegulatoryInformation.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству hfRegulatoryInformation', aCtx);
end;//TkwEnMedicMainMenuHfRegulatoryInformation.SetValuePrim

procedure TkwEnMedicMainMenuHfRegulatoryInformation.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfRegulatoryInformation(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuHfRegulatoryInformation.DoDoIt

function TkwEnMedicMainMenuTvRegulatoryInformation.tvRegulatoryInformation(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .Ten_MedicMainMenu.tvRegulatoryInformation }
begin
 Result := aen_MedicMainMenu.tvRegulatoryInformation;
end;//TkwEnMedicMainMenuTvRegulatoryInformation.tvRegulatoryInformation

class function TkwEnMedicMainMenuTvRegulatoryInformation.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.tvRegulatoryInformation';
end;//TkwEnMedicMainMenuTvRegulatoryInformation.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuTvRegulatoryInformation.ParamsTypes

procedure TkwEnMedicMainMenuTvRegulatoryInformation.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvRegulatoryInformation', aCtx);
end;//TkwEnMedicMainMenuTvRegulatoryInformation.SetValuePrim

procedure TkwEnMedicMainMenuTvRegulatoryInformation.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvRegulatoryInformation(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuTvRegulatoryInformation.DoDoIt

function TkwEnMedicMainMenuPnlMain.pnlMain(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TvtPanel;
 {* Реализация слова скрипта .Ten_MedicMainMenu.pnlMain }
begin
 Result := aen_MedicMainMenu.pnlMain;
end;//TkwEnMedicMainMenuPnlMain.pnlMain

class function TkwEnMedicMainMenuPnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.pnlMain';
end;//TkwEnMedicMainMenuPnlMain.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuPnlMain.ParamsTypes

procedure TkwEnMedicMainMenuPnlMain.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlMain', aCtx);
end;//TkwEnMedicMainMenuPnlMain.SetValuePrim

procedure TkwEnMedicMainMenuPnlMain.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlMain(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuPnlMain.DoDoIt

function TkwEnMedicMainMenuHfLastOpenDocs.hfLastOpenDocs(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {* Реализация слова скрипта .Ten_MedicMainMenu.hfLastOpenDocs }
begin
 Result := aen_MedicMainMenu.hfLastOpenDocs;
end;//TkwEnMedicMainMenuHfLastOpenDocs.hfLastOpenDocs

class function TkwEnMedicMainMenuHfLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.hfLastOpenDocs';
end;//TkwEnMedicMainMenuHfLastOpenDocs.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuHfLastOpenDocs.ParamsTypes

procedure TkwEnMedicMainMenuHfLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству hfLastOpenDocs', aCtx);
end;//TkwEnMedicMainMenuHfLastOpenDocs.SetValuePrim

procedure TkwEnMedicMainMenuHfLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfLastOpenDocs(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuHfLastOpenDocs.DoDoIt

function TkwEnMedicMainMenuTvLastOpenDocs.tvLastOpenDocs(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewHotTruck;
 {* Реализация слова скрипта .Ten_MedicMainMenu.tvLastOpenDocs }
begin
 Result := aen_MedicMainMenu.tvLastOpenDocs;
end;//TkwEnMedicMainMenuTvLastOpenDocs.tvLastOpenDocs

class function TkwEnMedicMainMenuTvLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.tvLastOpenDocs';
end;//TkwEnMedicMainMenuTvLastOpenDocs.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuTvLastOpenDocs.ParamsTypes

procedure TkwEnMedicMainMenuTvLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvLastOpenDocs', aCtx);
end;//TkwEnMedicMainMenuTvLastOpenDocs.SetValuePrim

procedure TkwEnMedicMainMenuTvLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvLastOpenDocs(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuTvLastOpenDocs.DoDoIt

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
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_MedicMainMenu));
 {* Регистрация типа Ten_MedicMainMenu }
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
