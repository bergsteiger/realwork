unit MainMenuNewKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы MainMenuNew }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\MainMenuNewKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "MainMenuNewKeywordsPack" MUID: (867969A10DF8)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtPanel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If Defined(Nemesis)}
 , nscFocusLabel
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscHideField
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTreeViewHotTruck
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoImageEn)}
 , imageenview
 {$IfEnd} // NOT Defined(NoImageEn)
 {$If NOT Defined(NoImageEn)}
 , imageenio
 {$IfEnd} // NOT Defined(NoImageEn)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , MainMenuNew_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_MainMenuNew = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы MainMenuNew
----
*Пример использования*:
[code]
'aControl' форма::MainMenuNew TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_MainMenuNew

 Tkw_MainMenuNew_Control_pnlBaseSearch = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlBaseSearch
----
*Пример использования*:
[code]
контрол::pnlBaseSearch TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pnlBaseSearch

 Tkw_MainMenuNew_Control_pnlBaseSearch_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола pnlBaseSearch
----
*Пример использования*:
[code]
контрол::pnlBaseSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pnlBaseSearch_Push

 Tkw_MainMenuNew_Control_pnlBaseSearchZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlBaseSearchZone
----
*Пример использования*:
[code]
контрол::pnlBaseSearchZone TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pnlBaseSearchZone

 Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола pnlBaseSearchZone
----
*Пример использования*:
[code]
контрол::pnlBaseSearchZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push

 Tkw_MainMenuNew_Control_pnlLogo = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlLogo
----
*Пример использования*:
[code]
контрол::pnlLogo TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pnlLogo

 Tkw_MainMenuNew_Control_pnlLogo_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола pnlLogo
----
*Пример использования*:
[code]
контрол::pnlLogo:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pnlLogo_Push

 Tkw_MainMenuNew_Control_pbLogo = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pbLogo
----
*Пример использования*:
[code]
контрол::pbLogo TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pbLogo

 Tkw_MainMenuNew_Control_pbLogo_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола pbLogo
----
*Пример использования*:
[code]
контрол::pbLogo:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pbLogo_Push

 Tkw_MainMenuNew_Control_pnlSearches = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlSearches
----
*Пример использования*:
[code]
контрол::pnlSearches TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pnlSearches

 Tkw_MainMenuNew_Control_pnlSearches_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола pnlSearches
----
*Пример использования*:
[code]
контрол::pnlSearches:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pnlSearches_Push

 Tkw_MainMenuNew_Control_flAttributeSearch = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола flAttributeSearch
----
*Пример использования*:
[code]
контрол::flAttributeSearch TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_flAttributeSearch

 Tkw_MainMenuNew_Control_flAttributeSearch_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола flAttributeSearch
----
*Пример использования*:
[code]
контрол::flAttributeSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_flAttributeSearch_Push

 Tkw_MainMenuNew_Control_flSituationSearch = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола flSituationSearch
----
*Пример использования*:
[code]
контрол::flSituationSearch TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_flSituationSearch

 Tkw_MainMenuNew_Control_flSituationSearch_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола flSituationSearch
----
*Пример использования*:
[code]
контрол::flSituationSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_flSituationSearch_Push

 Tkw_MainMenuNew_Control_flPublishedSourceSearch = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола flPublishedSourceSearch
----
*Пример использования*:
[code]
контрол::flPublishedSourceSearch TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_flPublishedSourceSearch

 Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола flPublishedSourceSearch
----
*Пример использования*:
[code]
контрол::flPublishedSourceSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push

 Tkw_MainMenuNew_Control_flDictionSearch = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола flDictionSearch
----
*Пример использования*:
[code]
контрол::flDictionSearch TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_flDictionSearch

 Tkw_MainMenuNew_Control_flDictionSearch_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола flDictionSearch
----
*Пример использования*:
[code]
контрол::flDictionSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_flDictionSearch_Push

 Tkw_MainMenuNew_Control_pnlExpert = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlExpert
----
*Пример использования*:
[code]
контрол::pnlExpert TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pnlExpert

 Tkw_MainMenuNew_Control_pnlExpert_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола pnlExpert
----
*Пример использования*:
[code]
контрол::pnlExpert:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pnlExpert_Push

 Tkw_MainMenuNew_Control_pbExpert = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pbExpert
----
*Пример использования*:
[code]
контрол::pbExpert TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pbExpert

 Tkw_MainMenuNew_Control_pbExpert_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола pbExpert
----
*Пример использования*:
[code]
контрол::pbExpert:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pbExpert_Push

 Tkw_MainMenuNew_Control_pnlOnLine = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlOnLine
----
*Пример использования*:
[code]
контрол::pnlOnLine TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pnlOnLine

 Tkw_MainMenuNew_Control_pnlOnLine_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола pnlOnLine
----
*Пример использования*:
[code]
контрол::pnlOnLine:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pnlOnLine_Push

 Tkw_MainMenuNew_Control_pbOnLine = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pbOnLine
----
*Пример использования*:
[code]
контрол::pbOnLine TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pbOnLine

 Tkw_MainMenuNew_Control_pbOnLine_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола pbOnLine
----
*Пример использования*:
[code]
контрол::pbOnLine:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pbOnLine_Push

 Tkw_MainMenuNew_Control_pbIntranet = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pbIntranet
----
*Пример использования*:
[code]
контрол::pbIntranet TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pbIntranet

 Tkw_MainMenuNew_Control_pbIntranet_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола pbIntranet
----
*Пример использования*:
[code]
контрол::pbIntranet:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pbIntranet_Push

 Tkw_MainMenuNew_Control_pbCourtsOnline = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pbCourtsOnline
----
*Пример использования*:
[code]
контрол::pbCourtsOnline TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pbCourtsOnline

 Tkw_MainMenuNew_Control_pbCourtsOnline_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола pbCourtsOnline
----
*Пример использования*:
[code]
контрол::pbCourtsOnline:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pbCourtsOnline_Push

 Tkw_MainMenuNew_Control_hfTaxes = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола hfTaxes
----
*Пример использования*:
[code]
контрол::hfTaxes TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_hfTaxes

 Tkw_MainMenuNew_Control_hfTaxes_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола hfTaxes
----
*Пример использования*:
[code]
контрол::hfTaxes:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_hfTaxes_Push

 Tkw_MainMenuNew_Control_tvTaxes = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvTaxes
----
*Пример использования*:
[code]
контрол::tvTaxes TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_tvTaxes

 Tkw_MainMenuNew_Control_tvTaxes_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола tvTaxes
----
*Пример использования*:
[code]
контрол::tvTaxes:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_tvTaxes_Push

 Tkw_MainMenuNew_Control_pnlBanner = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlBanner
----
*Пример использования*:
[code]
контрол::pnlBanner TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pnlBanner

 Tkw_MainMenuNew_Control_pnlBanner_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола pnlBanner
----
*Пример использования*:
[code]
контрол::pnlBanner:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_pnlBanner_Push

 Tkw_MainMenuNew_Control_ieBanner = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ieBanner
----
*Пример использования*:
[code]
контрол::ieBanner TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_ieBanner

 Tkw_MainMenuNew_Control_ieBanner_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола ieBanner
----
*Пример использования*:
[code]
контрол::ieBanner:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_ieBanner_Push

 Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола hfLastOpenDocsRightEdge
----
*Пример использования*:
[code]
контрол::hfLastOpenDocsRightEdge TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge

 Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола hfLastOpenDocsRightEdge
----
*Пример использования*:
[code]
контрол::hfLastOpenDocsRightEdge:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push

 Tkw_MainMenuNew_Component_ieIO = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ieIO
----
*Пример использования*:
[code]
компонент::ieIO TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Component_ieIO

 Tkw_MainMenuNew_Control_hfReferences = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола hfReferences
----
*Пример использования*:
[code]
контрол::hfReferences TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_hfReferences

 Tkw_MainMenuNew_Control_hfReferences_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола hfReferences
----
*Пример использования*:
[code]
контрол::hfReferences:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_hfReferences_Push

 Tkw_MainMenuNew_Control_tvReferences = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvReferences
----
*Пример использования*:
[code]
контрол::tvReferences TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_tvReferences

 Tkw_MainMenuNew_Control_tvReferences_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола tvReferences
----
*Пример использования*:
[code]
контрол::tvReferences:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_tvReferences_Push

 Tkw_MainMenuNew_Control_hfLawNews = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола hfLawNews
----
*Пример использования*:
[code]
контрол::hfLawNews TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_hfLawNews

 Tkw_MainMenuNew_Control_hfLawNews_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола hfLawNews
----
*Пример использования*:
[code]
контрол::hfLawNews:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_hfLawNews_Push

 Tkw_MainMenuNew_Control_tvLawNews = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvLawNews
----
*Пример использования*:
[code]
контрол::tvLawNews TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_tvLawNews

 Tkw_MainMenuNew_Control_tvLawNews_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола tvLawNews
----
*Пример использования*:
[code]
контрол::tvLawNews:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuNew_Control_tvLawNews_Push

 Tkw_MainMenuNew_Control_pnlMain = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuNew_Control_pnlMain

 Tkw_MainMenuNew_Control_pnlMain_Push = {final} class({$If NOT Defined(NoVCL)}
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
 end;//Tkw_MainMenuNew_Control_pnlMain_Push

 Tkw_MainMenuNew_Control_hfLastOpenDocs = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuNew_Control_hfLastOpenDocs

 Tkw_MainMenuNew_Control_hfLastOpenDocs_Push = {final} class({$If NOT Defined(NoVCL)}
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
 end;//Tkw_MainMenuNew_Control_hfLastOpenDocs_Push

 Tkw_MainMenuNew_Control_tvLastOpenDocs = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuNew_Control_tvLastOpenDocs

 Tkw_MainMenuNew_Control_tvLastOpenDocs_Push = {final} class({$If NOT Defined(NoVCL)}
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
 end;//Tkw_MainMenuNew_Control_tvLastOpenDocs_Push

 TkwEnMainMenuNewPnlBaseSearch = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.pnlBaseSearch
[panel]Контрол pnlBaseSearch формы Ten_MainMenuNew[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuNew .Ten_MainMenuNew.pnlBaseSearch >>> l_TvtPanel
[code]  }
  private
   function pnlBaseSearch(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
    {* Реализация слова скрипта .Ten_MainMenuNew.pnlBaseSearch }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewPnlBaseSearch

 TkwEnMainMenuNewPnlBaseSearchZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.pnlBaseSearchZone
[panel]Контрол pnlBaseSearchZone формы Ten_MainMenuNew[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuNew .Ten_MainMenuNew.pnlBaseSearchZone >>> l_TvtPanel
[code]  }
  private
   function pnlBaseSearchZone(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
    {* Реализация слова скрипта .Ten_MainMenuNew.pnlBaseSearchZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewPnlBaseSearchZone

 TkwEnMainMenuNewPnlLogo = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.pnlLogo
[panel]Контрол pnlLogo формы Ten_MainMenuNew[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuNew .Ten_MainMenuNew.pnlLogo >>> l_TvtPanel
[code]  }
  private
   function pnlLogo(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
    {* Реализация слова скрипта .Ten_MainMenuNew.pnlLogo }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewPnlLogo

 TkwEnMainMenuNewPbLogo = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.pbLogo
[panel]Контрол pbLogo формы Ten_MainMenuNew[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aen_MainMenuNew .Ten_MainMenuNew.pbLogo >>> l_TPaintBox
[code]  }
  private
   function pbLogo(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
    {* Реализация слова скрипта .Ten_MainMenuNew.pbLogo }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewPbLogo

 TkwEnMainMenuNewPnlSearches = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.pnlSearches
[panel]Контрол pnlSearches формы Ten_MainMenuNew[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuNew .Ten_MainMenuNew.pnlSearches >>> l_TvtPanel
[code]  }
  private
   function pnlSearches(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
    {* Реализация слова скрипта .Ten_MainMenuNew.pnlSearches }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewPnlSearches

 TkwEnMainMenuNewFlAttributeSearch = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.flAttributeSearch
[panel]Контрол flAttributeSearch формы Ten_MainMenuNew[panel]
*Тип результата:* TnscFocusLabel
*Пример:*
[code]
OBJECT VAR l_TnscFocusLabel
 aen_MainMenuNew .Ten_MainMenuNew.flAttributeSearch >>> l_TnscFocusLabel
[code]  }
  private
   function flAttributeSearch(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TnscFocusLabel;
    {* Реализация слова скрипта .Ten_MainMenuNew.flAttributeSearch }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewFlAttributeSearch

 TkwEnMainMenuNewFlSituationSearch = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.flSituationSearch
[panel]Контрол flSituationSearch формы Ten_MainMenuNew[panel]
*Тип результата:* TnscFocusLabel
*Пример:*
[code]
OBJECT VAR l_TnscFocusLabel
 aen_MainMenuNew .Ten_MainMenuNew.flSituationSearch >>> l_TnscFocusLabel
[code]  }
  private
   function flSituationSearch(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TnscFocusLabel;
    {* Реализация слова скрипта .Ten_MainMenuNew.flSituationSearch }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewFlSituationSearch

 TkwEnMainMenuNewFlPublishedSourceSearch = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.flPublishedSourceSearch
[panel]Контрол flPublishedSourceSearch формы Ten_MainMenuNew[panel]
*Тип результата:* TnscFocusLabel
*Пример:*
[code]
OBJECT VAR l_TnscFocusLabel
 aen_MainMenuNew .Ten_MainMenuNew.flPublishedSourceSearch >>> l_TnscFocusLabel
[code]  }
  private
   function flPublishedSourceSearch(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TnscFocusLabel;
    {* Реализация слова скрипта .Ten_MainMenuNew.flPublishedSourceSearch }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewFlPublishedSourceSearch

 TkwEnMainMenuNewFlDictionSearch = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.flDictionSearch
[panel]Контрол flDictionSearch формы Ten_MainMenuNew[panel]
*Тип результата:* TnscFocusLabel
*Пример:*
[code]
OBJECT VAR l_TnscFocusLabel
 aen_MainMenuNew .Ten_MainMenuNew.flDictionSearch >>> l_TnscFocusLabel
[code]  }
  private
   function flDictionSearch(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TnscFocusLabel;
    {* Реализация слова скрипта .Ten_MainMenuNew.flDictionSearch }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewFlDictionSearch

 TkwEnMainMenuNewPnlExpert = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.pnlExpert
[panel]Контрол pnlExpert формы Ten_MainMenuNew[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuNew .Ten_MainMenuNew.pnlExpert >>> l_TvtPanel
[code]  }
  private
   function pnlExpert(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
    {* Реализация слова скрипта .Ten_MainMenuNew.pnlExpert }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewPnlExpert

 TkwEnMainMenuNewPbExpert = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.pbExpert
[panel]Контрол pbExpert формы Ten_MainMenuNew[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aen_MainMenuNew .Ten_MainMenuNew.pbExpert >>> l_TPaintBox
[code]  }
  private
   function pbExpert(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
    {* Реализация слова скрипта .Ten_MainMenuNew.pbExpert }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewPbExpert

 TkwEnMainMenuNewPnlOnLine = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.pnlOnLine
[panel]Контрол pnlOnLine формы Ten_MainMenuNew[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuNew .Ten_MainMenuNew.pnlOnLine >>> l_TvtPanel
[code]  }
  private
   function pnlOnLine(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
    {* Реализация слова скрипта .Ten_MainMenuNew.pnlOnLine }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewPnlOnLine

 TkwEnMainMenuNewPbOnLine = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.pbOnLine
[panel]Контрол pbOnLine формы Ten_MainMenuNew[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aen_MainMenuNew .Ten_MainMenuNew.pbOnLine >>> l_TPaintBox
[code]  }
  private
   function pbOnLine(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
    {* Реализация слова скрипта .Ten_MainMenuNew.pbOnLine }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewPbOnLine

 TkwEnMainMenuNewPbIntranet = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.pbIntranet
[panel]Контрол pbIntranet формы Ten_MainMenuNew[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aen_MainMenuNew .Ten_MainMenuNew.pbIntranet >>> l_TPaintBox
[code]  }
  private
   function pbIntranet(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
    {* Реализация слова скрипта .Ten_MainMenuNew.pbIntranet }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewPbIntranet

 TkwEnMainMenuNewPbCourtsOnline = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.pbCourtsOnline
[panel]Контрол pbCourtsOnline формы Ten_MainMenuNew[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aen_MainMenuNew .Ten_MainMenuNew.pbCourtsOnline >>> l_TPaintBox
[code]  }
  private
   function pbCourtsOnline(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
    {* Реализация слова скрипта .Ten_MainMenuNew.pbCourtsOnline }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewPbCourtsOnline

 TkwEnMainMenuNewHfTaxes = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.hfTaxes
[panel]Контрол hfTaxes формы Ten_MainMenuNew[panel]
*Тип результата:* TnscHideField
*Пример:*
[code]
OBJECT VAR l_TnscHideField
 aen_MainMenuNew .Ten_MainMenuNew.hfTaxes >>> l_TnscHideField
[code]  }
  private
   function hfTaxes(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TnscHideField;
    {* Реализация слова скрипта .Ten_MainMenuNew.hfTaxes }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewHfTaxes

 TkwEnMainMenuNewTvTaxes = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.tvTaxes
[panel]Контрол tvTaxes формы Ten_MainMenuNew[panel]
*Тип результата:* TnscTreeViewHotTruck
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aen_MainMenuNew .Ten_MainMenuNew.tvTaxes >>> l_TnscTreeViewHotTruck
[code]  }
  private
   function tvTaxes(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TnscTreeViewHotTruck;
    {* Реализация слова скрипта .Ten_MainMenuNew.tvTaxes }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewTvTaxes

 TkwEnMainMenuNewPnlBanner = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.pnlBanner
[panel]Контрол pnlBanner формы Ten_MainMenuNew[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuNew .Ten_MainMenuNew.pnlBanner >>> l_TvtPanel
[code]  }
  private
   function pnlBanner(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
    {* Реализация слова скрипта .Ten_MainMenuNew.pnlBanner }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewPnlBanner

 TkwEnMainMenuNewIeBanner = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.ieBanner
[panel]Контрол ieBanner формы Ten_MainMenuNew[panel]
*Тип результата:* TImageEnView
*Пример:*
[code]
OBJECT VAR l_TImageEnView
 aen_MainMenuNew .Ten_MainMenuNew.ieBanner >>> l_TImageEnView
[code]  }
  private
   function ieBanner(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TImageEnView;
    {* Реализация слова скрипта .Ten_MainMenuNew.ieBanner }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewIeBanner

 TkwEnMainMenuNewHfLastOpenDocsRightEdge = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.hfLastOpenDocsRightEdge
[panel]Контрол hfLastOpenDocsRightEdge формы Ten_MainMenuNew[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuNew .Ten_MainMenuNew.hfLastOpenDocsRightEdge >>> l_TvtPanel
[code]  }
  private
   function hfLastOpenDocsRightEdge(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
    {* Реализация слова скрипта .Ten_MainMenuNew.hfLastOpenDocsRightEdge }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge

 TkwEnMainMenuNewIeIO = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.ieIO
[panel]Контрол ieIO формы Ten_MainMenuNew[panel]
*Тип результата:* TImageEnIO
*Пример:*
[code]
OBJECT VAR l_TImageEnIO
 aen_MainMenuNew .Ten_MainMenuNew.ieIO >>> l_TImageEnIO
[code]  }
  private
   function ieIO(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TImageEnIO;
    {* Реализация слова скрипта .Ten_MainMenuNew.ieIO }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewIeIO

 TkwEnMainMenuNewHfReferences = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.hfReferences
[panel]Контрол hfReferences формы Ten_MainMenuNew[panel]
*Тип результата:* TnscHideField
*Пример:*
[code]
OBJECT VAR l_TnscHideField
 aen_MainMenuNew .Ten_MainMenuNew.hfReferences >>> l_TnscHideField
[code]  }
  private
   function hfReferences(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TnscHideField;
    {* Реализация слова скрипта .Ten_MainMenuNew.hfReferences }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewHfReferences

 TkwEnMainMenuNewTvReferences = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.tvReferences
[panel]Контрол tvReferences формы Ten_MainMenuNew[panel]
*Тип результата:* TnscTreeViewHotTruck
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aen_MainMenuNew .Ten_MainMenuNew.tvReferences >>> l_TnscTreeViewHotTruck
[code]  }
  private
   function tvReferences(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TnscTreeViewHotTruck;
    {* Реализация слова скрипта .Ten_MainMenuNew.tvReferences }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewTvReferences

 TkwEnMainMenuNewHfLawNews = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.hfLawNews
[panel]Контрол hfLawNews формы Ten_MainMenuNew[panel]
*Тип результата:* TnscHideField
*Пример:*
[code]
OBJECT VAR l_TnscHideField
 aen_MainMenuNew .Ten_MainMenuNew.hfLawNews >>> l_TnscHideField
[code]  }
  private
   function hfLawNews(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TnscHideField;
    {* Реализация слова скрипта .Ten_MainMenuNew.hfLawNews }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewHfLawNews

 TkwEnMainMenuNewTvLawNews = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.tvLawNews
[panel]Контрол tvLawNews формы Ten_MainMenuNew[panel]
*Тип результата:* TnscTreeViewHotTruck
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aen_MainMenuNew .Ten_MainMenuNew.tvLawNews >>> l_TnscTreeViewHotTruck
[code]  }
  private
   function tvLawNews(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TnscTreeViewHotTruck;
    {* Реализация слова скрипта .Ten_MainMenuNew.tvLawNews }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewTvLawNews

 TkwEnMainMenuNewPnlMain = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.pnlMain
[panel]Контрол pnlMain формы Ten_MainMenuNew[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuNew .Ten_MainMenuNew.pnlMain >>> l_TvtPanel
[code]  }
  private
   function pnlMain(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
    {* Реализация слова скрипта .Ten_MainMenuNew.pnlMain }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewPnlMain

 TkwEnMainMenuNewHfLastOpenDocs = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.hfLastOpenDocs
[panel]Контрол hfLastOpenDocs формы Ten_MainMenuNew[panel]
*Тип результата:* TnscHideField
*Пример:*
[code]
OBJECT VAR l_TnscHideField
 aen_MainMenuNew .Ten_MainMenuNew.hfLastOpenDocs >>> l_TnscHideField
[code]  }
  private
   function hfLastOpenDocs(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TnscHideField;
    {* Реализация слова скрипта .Ten_MainMenuNew.hfLastOpenDocs }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewHfLastOpenDocs

 TkwEnMainMenuNewTvLastOpenDocs = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuNew.tvLastOpenDocs
[panel]Контрол tvLastOpenDocs формы Ten_MainMenuNew[panel]
*Тип результата:* TnscTreeViewHotTruck
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aen_MainMenuNew .Ten_MainMenuNew.tvLastOpenDocs >>> l_TnscTreeViewHotTruck
[code]  }
  private
   function tvLastOpenDocs(const aCtx: TtfwContext;
    aen_MainMenuNew: Ten_MainMenuNew): TnscTreeViewHotTruck;
    {* Реализация слова скрипта .Ten_MainMenuNew.tvLastOpenDocs }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuNewTvLastOpenDocs

function Tkw_Form_MainMenuNew.GetString: AnsiString;
begin
 Result := 'en_MainMenuNew';
end;//Tkw_Form_MainMenuNew.GetString

class function Tkw_Form_MainMenuNew.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::MainMenuNew';
end;//Tkw_Form_MainMenuNew.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlBaseSearch.GetString: AnsiString;
begin
 Result := 'pnlBaseSearch';
end;//Tkw_MainMenuNew_Control_pnlBaseSearch.GetString

class procedure Tkw_MainMenuNew_Control_pnlBaseSearch.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuNew_Control_pnlBaseSearch.RegisterInEngine

class function Tkw_MainMenuNew_Control_pnlBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBaseSearch';
end;//Tkw_MainMenuNew_Control_pnlBaseSearch.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_pnlBaseSearch_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlBaseSearch');
 inherited;
end;//Tkw_MainMenuNew_Control_pnlBaseSearch_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlBaseSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBaseSearch:push';
end;//Tkw_MainMenuNew_Control_pnlBaseSearch_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlBaseSearchZone.GetString: AnsiString;
begin
 Result := 'pnlBaseSearchZone';
end;//Tkw_MainMenuNew_Control_pnlBaseSearchZone.GetString

class procedure Tkw_MainMenuNew_Control_pnlBaseSearchZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuNew_Control_pnlBaseSearchZone.RegisterInEngine

class function Tkw_MainMenuNew_Control_pnlBaseSearchZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBaseSearchZone';
end;//Tkw_MainMenuNew_Control_pnlBaseSearchZone.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlBaseSearchZone');
 inherited;
end;//Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBaseSearchZone:push';
end;//Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlLogo.GetString: AnsiString;
begin
 Result := 'pnlLogo';
end;//Tkw_MainMenuNew_Control_pnlLogo.GetString

class procedure Tkw_MainMenuNew_Control_pnlLogo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuNew_Control_pnlLogo.RegisterInEngine

class function Tkw_MainMenuNew_Control_pnlLogo.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlLogo';
end;//Tkw_MainMenuNew_Control_pnlLogo.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_pnlLogo_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlLogo');
 inherited;
end;//Tkw_MainMenuNew_Control_pnlLogo_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlLogo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlLogo:push';
end;//Tkw_MainMenuNew_Control_pnlLogo_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pbLogo.GetString: AnsiString;
begin
 Result := 'pbLogo';
end;//Tkw_MainMenuNew_Control_pbLogo.GetString

class procedure Tkw_MainMenuNew_Control_pbLogo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_MainMenuNew_Control_pbLogo.RegisterInEngine

class function Tkw_MainMenuNew_Control_pbLogo.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbLogo';
end;//Tkw_MainMenuNew_Control_pbLogo.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_pbLogo_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbLogo');
 inherited;
end;//Tkw_MainMenuNew_Control_pbLogo_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pbLogo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbLogo:push';
end;//Tkw_MainMenuNew_Control_pbLogo_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlSearches.GetString: AnsiString;
begin
 Result := 'pnlSearches';
end;//Tkw_MainMenuNew_Control_pnlSearches.GetString

class procedure Tkw_MainMenuNew_Control_pnlSearches.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuNew_Control_pnlSearches.RegisterInEngine

class function Tkw_MainMenuNew_Control_pnlSearches.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlSearches';
end;//Tkw_MainMenuNew_Control_pnlSearches.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_pnlSearches_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlSearches');
 inherited;
end;//Tkw_MainMenuNew_Control_pnlSearches_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlSearches_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlSearches:push';
end;//Tkw_MainMenuNew_Control_pnlSearches_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_flAttributeSearch.GetString: AnsiString;
begin
 Result := 'flAttributeSearch';
end;//Tkw_MainMenuNew_Control_flAttributeSearch.GetString

class procedure Tkw_MainMenuNew_Control_flAttributeSearch.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscFocusLabel);
end;//Tkw_MainMenuNew_Control_flAttributeSearch.RegisterInEngine

class function Tkw_MainMenuNew_Control_flAttributeSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flAttributeSearch';
end;//Tkw_MainMenuNew_Control_flAttributeSearch.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_flAttributeSearch_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('flAttributeSearch');
 inherited;
end;//Tkw_MainMenuNew_Control_flAttributeSearch_Push.DoDoIt

class function Tkw_MainMenuNew_Control_flAttributeSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flAttributeSearch:push';
end;//Tkw_MainMenuNew_Control_flAttributeSearch_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_flSituationSearch.GetString: AnsiString;
begin
 Result := 'flSituationSearch';
end;//Tkw_MainMenuNew_Control_flSituationSearch.GetString

class procedure Tkw_MainMenuNew_Control_flSituationSearch.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscFocusLabel);
end;//Tkw_MainMenuNew_Control_flSituationSearch.RegisterInEngine

class function Tkw_MainMenuNew_Control_flSituationSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flSituationSearch';
end;//Tkw_MainMenuNew_Control_flSituationSearch.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_flSituationSearch_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('flSituationSearch');
 inherited;
end;//Tkw_MainMenuNew_Control_flSituationSearch_Push.DoDoIt

class function Tkw_MainMenuNew_Control_flSituationSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flSituationSearch:push';
end;//Tkw_MainMenuNew_Control_flSituationSearch_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_flPublishedSourceSearch.GetString: AnsiString;
begin
 Result := 'flPublishedSourceSearch';
end;//Tkw_MainMenuNew_Control_flPublishedSourceSearch.GetString

class procedure Tkw_MainMenuNew_Control_flPublishedSourceSearch.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscFocusLabel);
end;//Tkw_MainMenuNew_Control_flPublishedSourceSearch.RegisterInEngine

class function Tkw_MainMenuNew_Control_flPublishedSourceSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flPublishedSourceSearch';
end;//Tkw_MainMenuNew_Control_flPublishedSourceSearch.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('flPublishedSourceSearch');
 inherited;
end;//Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push.DoDoIt

class function Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flPublishedSourceSearch:push';
end;//Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_flDictionSearch.GetString: AnsiString;
begin
 Result := 'flDictionSearch';
end;//Tkw_MainMenuNew_Control_flDictionSearch.GetString

class procedure Tkw_MainMenuNew_Control_flDictionSearch.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscFocusLabel);
end;//Tkw_MainMenuNew_Control_flDictionSearch.RegisterInEngine

class function Tkw_MainMenuNew_Control_flDictionSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flDictionSearch';
end;//Tkw_MainMenuNew_Control_flDictionSearch.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_flDictionSearch_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('flDictionSearch');
 inherited;
end;//Tkw_MainMenuNew_Control_flDictionSearch_Push.DoDoIt

class function Tkw_MainMenuNew_Control_flDictionSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flDictionSearch:push';
end;//Tkw_MainMenuNew_Control_flDictionSearch_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlExpert.GetString: AnsiString;
begin
 Result := 'pnlExpert';
end;//Tkw_MainMenuNew_Control_pnlExpert.GetString

class procedure Tkw_MainMenuNew_Control_pnlExpert.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuNew_Control_pnlExpert.RegisterInEngine

class function Tkw_MainMenuNew_Control_pnlExpert.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlExpert';
end;//Tkw_MainMenuNew_Control_pnlExpert.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_pnlExpert_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlExpert');
 inherited;
end;//Tkw_MainMenuNew_Control_pnlExpert_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlExpert_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlExpert:push';
end;//Tkw_MainMenuNew_Control_pnlExpert_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pbExpert.GetString: AnsiString;
begin
 Result := 'pbExpert';
end;//Tkw_MainMenuNew_Control_pbExpert.GetString

class procedure Tkw_MainMenuNew_Control_pbExpert.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_MainMenuNew_Control_pbExpert.RegisterInEngine

class function Tkw_MainMenuNew_Control_pbExpert.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbExpert';
end;//Tkw_MainMenuNew_Control_pbExpert.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_pbExpert_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbExpert');
 inherited;
end;//Tkw_MainMenuNew_Control_pbExpert_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pbExpert_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbExpert:push';
end;//Tkw_MainMenuNew_Control_pbExpert_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlOnLine.GetString: AnsiString;
begin
 Result := 'pnlOnLine';
end;//Tkw_MainMenuNew_Control_pnlOnLine.GetString

class procedure Tkw_MainMenuNew_Control_pnlOnLine.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuNew_Control_pnlOnLine.RegisterInEngine

class function Tkw_MainMenuNew_Control_pnlOnLine.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlOnLine';
end;//Tkw_MainMenuNew_Control_pnlOnLine.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_pnlOnLine_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlOnLine');
 inherited;
end;//Tkw_MainMenuNew_Control_pnlOnLine_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlOnLine_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlOnLine:push';
end;//Tkw_MainMenuNew_Control_pnlOnLine_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pbOnLine.GetString: AnsiString;
begin
 Result := 'pbOnLine';
end;//Tkw_MainMenuNew_Control_pbOnLine.GetString

class procedure Tkw_MainMenuNew_Control_pbOnLine.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_MainMenuNew_Control_pbOnLine.RegisterInEngine

class function Tkw_MainMenuNew_Control_pbOnLine.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbOnLine';
end;//Tkw_MainMenuNew_Control_pbOnLine.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_pbOnLine_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbOnLine');
 inherited;
end;//Tkw_MainMenuNew_Control_pbOnLine_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pbOnLine_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbOnLine:push';
end;//Tkw_MainMenuNew_Control_pbOnLine_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pbIntranet.GetString: AnsiString;
begin
 Result := 'pbIntranet';
end;//Tkw_MainMenuNew_Control_pbIntranet.GetString

class procedure Tkw_MainMenuNew_Control_pbIntranet.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_MainMenuNew_Control_pbIntranet.RegisterInEngine

class function Tkw_MainMenuNew_Control_pbIntranet.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbIntranet';
end;//Tkw_MainMenuNew_Control_pbIntranet.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_pbIntranet_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbIntranet');
 inherited;
end;//Tkw_MainMenuNew_Control_pbIntranet_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pbIntranet_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbIntranet:push';
end;//Tkw_MainMenuNew_Control_pbIntranet_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pbCourtsOnline.GetString: AnsiString;
begin
 Result := 'pbCourtsOnline';
end;//Tkw_MainMenuNew_Control_pbCourtsOnline.GetString

class procedure Tkw_MainMenuNew_Control_pbCourtsOnline.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_MainMenuNew_Control_pbCourtsOnline.RegisterInEngine

class function Tkw_MainMenuNew_Control_pbCourtsOnline.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbCourtsOnline';
end;//Tkw_MainMenuNew_Control_pbCourtsOnline.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_pbCourtsOnline_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbCourtsOnline');
 inherited;
end;//Tkw_MainMenuNew_Control_pbCourtsOnline_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pbCourtsOnline_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbCourtsOnline:push';
end;//Tkw_MainMenuNew_Control_pbCourtsOnline_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_hfTaxes.GetString: AnsiString;
begin
 Result := 'hfTaxes';
end;//Tkw_MainMenuNew_Control_hfTaxes.GetString

class procedure Tkw_MainMenuNew_Control_hfTaxes.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MainMenuNew_Control_hfTaxes.RegisterInEngine

class function Tkw_MainMenuNew_Control_hfTaxes.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfTaxes';
end;//Tkw_MainMenuNew_Control_hfTaxes.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_hfTaxes_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfTaxes');
 inherited;
end;//Tkw_MainMenuNew_Control_hfTaxes_Push.DoDoIt

class function Tkw_MainMenuNew_Control_hfTaxes_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfTaxes:push';
end;//Tkw_MainMenuNew_Control_hfTaxes_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_tvTaxes.GetString: AnsiString;
begin
 Result := 'tvTaxes';
end;//Tkw_MainMenuNew_Control_tvTaxes.GetString

class procedure Tkw_MainMenuNew_Control_tvTaxes.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_MainMenuNew_Control_tvTaxes.RegisterInEngine

class function Tkw_MainMenuNew_Control_tvTaxes.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvTaxes';
end;//Tkw_MainMenuNew_Control_tvTaxes.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_tvTaxes_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvTaxes');
 inherited;
end;//Tkw_MainMenuNew_Control_tvTaxes_Push.DoDoIt

class function Tkw_MainMenuNew_Control_tvTaxes_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvTaxes:push';
end;//Tkw_MainMenuNew_Control_tvTaxes_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlBanner.GetString: AnsiString;
begin
 Result := 'pnlBanner';
end;//Tkw_MainMenuNew_Control_pnlBanner.GetString

class procedure Tkw_MainMenuNew_Control_pnlBanner.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuNew_Control_pnlBanner.RegisterInEngine

class function Tkw_MainMenuNew_Control_pnlBanner.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBanner';
end;//Tkw_MainMenuNew_Control_pnlBanner.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_pnlBanner_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlBanner');
 inherited;
end;//Tkw_MainMenuNew_Control_pnlBanner_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlBanner_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBanner:push';
end;//Tkw_MainMenuNew_Control_pnlBanner_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_ieBanner.GetString: AnsiString;
begin
 Result := 'ieBanner';
end;//Tkw_MainMenuNew_Control_ieBanner.GetString

class procedure Tkw_MainMenuNew_Control_ieBanner.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TImageEnView);
end;//Tkw_MainMenuNew_Control_ieBanner.RegisterInEngine

class function Tkw_MainMenuNew_Control_ieBanner.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ieBanner';
end;//Tkw_MainMenuNew_Control_ieBanner.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_ieBanner_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ieBanner');
 inherited;
end;//Tkw_MainMenuNew_Control_ieBanner_Push.DoDoIt

class function Tkw_MainMenuNew_Control_ieBanner_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ieBanner:push';
end;//Tkw_MainMenuNew_Control_ieBanner_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge.GetString: AnsiString;
begin
 Result := 'hfLastOpenDocsRightEdge';
end;//Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge.GetString

class procedure Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge.RegisterInEngine

class function Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfLastOpenDocsRightEdge';
end;//Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfLastOpenDocsRightEdge');
 inherited;
end;//Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push.DoDoIt

class function Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfLastOpenDocsRightEdge:push';
end;//Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Component_ieIO.GetString: AnsiString;
begin
 Result := 'ieIO';
end;//Tkw_MainMenuNew_Component_ieIO.GetString

class procedure Tkw_MainMenuNew_Component_ieIO.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TImageEnIO);
end;//Tkw_MainMenuNew_Component_ieIO.RegisterInEngine

class function Tkw_MainMenuNew_Component_ieIO.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::ieIO';
end;//Tkw_MainMenuNew_Component_ieIO.GetWordNameForRegister

function Tkw_MainMenuNew_Control_hfReferences.GetString: AnsiString;
begin
 Result := 'hfReferences';
end;//Tkw_MainMenuNew_Control_hfReferences.GetString

class procedure Tkw_MainMenuNew_Control_hfReferences.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MainMenuNew_Control_hfReferences.RegisterInEngine

class function Tkw_MainMenuNew_Control_hfReferences.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfReferences';
end;//Tkw_MainMenuNew_Control_hfReferences.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_hfReferences_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfReferences');
 inherited;
end;//Tkw_MainMenuNew_Control_hfReferences_Push.DoDoIt

class function Tkw_MainMenuNew_Control_hfReferences_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfReferences:push';
end;//Tkw_MainMenuNew_Control_hfReferences_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_tvReferences.GetString: AnsiString;
begin
 Result := 'tvReferences';
end;//Tkw_MainMenuNew_Control_tvReferences.GetString

class procedure Tkw_MainMenuNew_Control_tvReferences.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_MainMenuNew_Control_tvReferences.RegisterInEngine

class function Tkw_MainMenuNew_Control_tvReferences.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvReferences';
end;//Tkw_MainMenuNew_Control_tvReferences.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_tvReferences_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvReferences');
 inherited;
end;//Tkw_MainMenuNew_Control_tvReferences_Push.DoDoIt

class function Tkw_MainMenuNew_Control_tvReferences_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvReferences:push';
end;//Tkw_MainMenuNew_Control_tvReferences_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_hfLawNews.GetString: AnsiString;
begin
 Result := 'hfLawNews';
end;//Tkw_MainMenuNew_Control_hfLawNews.GetString

class procedure Tkw_MainMenuNew_Control_hfLawNews.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MainMenuNew_Control_hfLawNews.RegisterInEngine

class function Tkw_MainMenuNew_Control_hfLawNews.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfLawNews';
end;//Tkw_MainMenuNew_Control_hfLawNews.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_hfLawNews_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfLawNews');
 inherited;
end;//Tkw_MainMenuNew_Control_hfLawNews_Push.DoDoIt

class function Tkw_MainMenuNew_Control_hfLawNews_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfLawNews:push';
end;//Tkw_MainMenuNew_Control_hfLawNews_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_tvLawNews.GetString: AnsiString;
begin
 Result := 'tvLawNews';
end;//Tkw_MainMenuNew_Control_tvLawNews.GetString

class procedure Tkw_MainMenuNew_Control_tvLawNews.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_MainMenuNew_Control_tvLawNews.RegisterInEngine

class function Tkw_MainMenuNew_Control_tvLawNews.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvLawNews';
end;//Tkw_MainMenuNew_Control_tvLawNews.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_tvLawNews_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvLawNews');
 inherited;
end;//Tkw_MainMenuNew_Control_tvLawNews_Push.DoDoIt

class function Tkw_MainMenuNew_Control_tvLawNews_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvLawNews:push';
end;//Tkw_MainMenuNew_Control_tvLawNews_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlMain.GetString: AnsiString;
begin
 Result := 'pnlMain';
end;//Tkw_MainMenuNew_Control_pnlMain.GetString

class procedure Tkw_MainMenuNew_Control_pnlMain.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuNew_Control_pnlMain.RegisterInEngine

class function Tkw_MainMenuNew_Control_pnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlMain';
end;//Tkw_MainMenuNew_Control_pnlMain.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_pnlMain_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlMain');
 inherited;
end;//Tkw_MainMenuNew_Control_pnlMain_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlMain_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlMain:push';
end;//Tkw_MainMenuNew_Control_pnlMain_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_hfLastOpenDocs.GetString: AnsiString;
begin
 Result := 'hfLastOpenDocs';
end;//Tkw_MainMenuNew_Control_hfLastOpenDocs.GetString

class procedure Tkw_MainMenuNew_Control_hfLastOpenDocs.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MainMenuNew_Control_hfLastOpenDocs.RegisterInEngine

class function Tkw_MainMenuNew_Control_hfLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfLastOpenDocs';
end;//Tkw_MainMenuNew_Control_hfLastOpenDocs.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_hfLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfLastOpenDocs');
 inherited;
end;//Tkw_MainMenuNew_Control_hfLastOpenDocs_Push.DoDoIt

class function Tkw_MainMenuNew_Control_hfLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfLastOpenDocs:push';
end;//Tkw_MainMenuNew_Control_hfLastOpenDocs_Push.GetWordNameForRegister

function Tkw_MainMenuNew_Control_tvLastOpenDocs.GetString: AnsiString;
begin
 Result := 'tvLastOpenDocs';
end;//Tkw_MainMenuNew_Control_tvLastOpenDocs.GetString

class procedure Tkw_MainMenuNew_Control_tvLastOpenDocs.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_MainMenuNew_Control_tvLastOpenDocs.RegisterInEngine

class function Tkw_MainMenuNew_Control_tvLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvLastOpenDocs';
end;//Tkw_MainMenuNew_Control_tvLastOpenDocs.GetWordNameForRegister

procedure Tkw_MainMenuNew_Control_tvLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvLastOpenDocs');
 inherited;
end;//Tkw_MainMenuNew_Control_tvLastOpenDocs_Push.DoDoIt

class function Tkw_MainMenuNew_Control_tvLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvLastOpenDocs:push';
end;//Tkw_MainMenuNew_Control_tvLastOpenDocs_Push.GetWordNameForRegister

function TkwEnMainMenuNewPnlBaseSearch.pnlBaseSearch(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuNew.pnlBaseSearch }
begin
 Result := aen_MainMenuNew.pnlBaseSearch;
end;//TkwEnMainMenuNewPnlBaseSearch.pnlBaseSearch

procedure TkwEnMainMenuNewPnlBaseSearch.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlBaseSearch(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewPnlBaseSearch.DoDoIt

procedure TkwEnMainMenuNewPnlBaseSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlBaseSearch', aCtx);
end;//TkwEnMainMenuNewPnlBaseSearch.SetValuePrim

function TkwEnMainMenuNewPnlBaseSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuNewPnlBaseSearch.GetResultTypeInfo

function TkwEnMainMenuNewPnlBaseSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPnlBaseSearch.GetAllParamsCount

function TkwEnMainMenuNewPnlBaseSearch.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPnlBaseSearch.ParamsTypes

class function TkwEnMainMenuNewPnlBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pnlBaseSearch';
end;//TkwEnMainMenuNewPnlBaseSearch.GetWordNameForRegister

function TkwEnMainMenuNewPnlBaseSearchZone.pnlBaseSearchZone(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuNew.pnlBaseSearchZone }
begin
 Result := aen_MainMenuNew.pnlBaseSearchZone;
end;//TkwEnMainMenuNewPnlBaseSearchZone.pnlBaseSearchZone

procedure TkwEnMainMenuNewPnlBaseSearchZone.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlBaseSearchZone(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewPnlBaseSearchZone.DoDoIt

procedure TkwEnMainMenuNewPnlBaseSearchZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlBaseSearchZone', aCtx);
end;//TkwEnMainMenuNewPnlBaseSearchZone.SetValuePrim

function TkwEnMainMenuNewPnlBaseSearchZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuNewPnlBaseSearchZone.GetResultTypeInfo

function TkwEnMainMenuNewPnlBaseSearchZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPnlBaseSearchZone.GetAllParamsCount

function TkwEnMainMenuNewPnlBaseSearchZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPnlBaseSearchZone.ParamsTypes

class function TkwEnMainMenuNewPnlBaseSearchZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pnlBaseSearchZone';
end;//TkwEnMainMenuNewPnlBaseSearchZone.GetWordNameForRegister

function TkwEnMainMenuNewPnlLogo.pnlLogo(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuNew.pnlLogo }
begin
 Result := aen_MainMenuNew.pnlLogo;
end;//TkwEnMainMenuNewPnlLogo.pnlLogo

procedure TkwEnMainMenuNewPnlLogo.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlLogo(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewPnlLogo.DoDoIt

procedure TkwEnMainMenuNewPnlLogo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlLogo', aCtx);
end;//TkwEnMainMenuNewPnlLogo.SetValuePrim

function TkwEnMainMenuNewPnlLogo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuNewPnlLogo.GetResultTypeInfo

function TkwEnMainMenuNewPnlLogo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPnlLogo.GetAllParamsCount

function TkwEnMainMenuNewPnlLogo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPnlLogo.ParamsTypes

class function TkwEnMainMenuNewPnlLogo.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pnlLogo';
end;//TkwEnMainMenuNewPnlLogo.GetWordNameForRegister

function TkwEnMainMenuNewPbLogo.pbLogo(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
 {* Реализация слова скрипта .Ten_MainMenuNew.pbLogo }
begin
 Result := aen_MainMenuNew.pbLogo;
end;//TkwEnMainMenuNewPbLogo.pbLogo

procedure TkwEnMainMenuNewPbLogo.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbLogo(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewPbLogo.DoDoIt

procedure TkwEnMainMenuNewPbLogo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pbLogo', aCtx);
end;//TkwEnMainMenuNewPbLogo.SetValuePrim

function TkwEnMainMenuNewPbLogo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnMainMenuNewPbLogo.GetResultTypeInfo

function TkwEnMainMenuNewPbLogo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPbLogo.GetAllParamsCount

function TkwEnMainMenuNewPbLogo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPbLogo.ParamsTypes

class function TkwEnMainMenuNewPbLogo.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pbLogo';
end;//TkwEnMainMenuNewPbLogo.GetWordNameForRegister

function TkwEnMainMenuNewPnlSearches.pnlSearches(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuNew.pnlSearches }
begin
 Result := aen_MainMenuNew.pnlSearches;
end;//TkwEnMainMenuNewPnlSearches.pnlSearches

procedure TkwEnMainMenuNewPnlSearches.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlSearches(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewPnlSearches.DoDoIt

procedure TkwEnMainMenuNewPnlSearches.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlSearches', aCtx);
end;//TkwEnMainMenuNewPnlSearches.SetValuePrim

function TkwEnMainMenuNewPnlSearches.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuNewPnlSearches.GetResultTypeInfo

function TkwEnMainMenuNewPnlSearches.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPnlSearches.GetAllParamsCount

function TkwEnMainMenuNewPnlSearches.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPnlSearches.ParamsTypes

class function TkwEnMainMenuNewPnlSearches.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pnlSearches';
end;//TkwEnMainMenuNewPnlSearches.GetWordNameForRegister

function TkwEnMainMenuNewFlAttributeSearch.flAttributeSearch(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscFocusLabel;
 {* Реализация слова скрипта .Ten_MainMenuNew.flAttributeSearch }
begin
 Result := aen_MainMenuNew.flAttributeSearch;
end;//TkwEnMainMenuNewFlAttributeSearch.flAttributeSearch

procedure TkwEnMainMenuNewFlAttributeSearch.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(flAttributeSearch(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewFlAttributeSearch.DoDoIt

procedure TkwEnMainMenuNewFlAttributeSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству flAttributeSearch', aCtx);
end;//TkwEnMainMenuNewFlAttributeSearch.SetValuePrim

function TkwEnMainMenuNewFlAttributeSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscFocusLabel);
end;//TkwEnMainMenuNewFlAttributeSearch.GetResultTypeInfo

function TkwEnMainMenuNewFlAttributeSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewFlAttributeSearch.GetAllParamsCount

function TkwEnMainMenuNewFlAttributeSearch.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewFlAttributeSearch.ParamsTypes

class function TkwEnMainMenuNewFlAttributeSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.flAttributeSearch';
end;//TkwEnMainMenuNewFlAttributeSearch.GetWordNameForRegister

function TkwEnMainMenuNewFlSituationSearch.flSituationSearch(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscFocusLabel;
 {* Реализация слова скрипта .Ten_MainMenuNew.flSituationSearch }
begin
 Result := aen_MainMenuNew.flSituationSearch;
end;//TkwEnMainMenuNewFlSituationSearch.flSituationSearch

procedure TkwEnMainMenuNewFlSituationSearch.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(flSituationSearch(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewFlSituationSearch.DoDoIt

procedure TkwEnMainMenuNewFlSituationSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству flSituationSearch', aCtx);
end;//TkwEnMainMenuNewFlSituationSearch.SetValuePrim

function TkwEnMainMenuNewFlSituationSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscFocusLabel);
end;//TkwEnMainMenuNewFlSituationSearch.GetResultTypeInfo

function TkwEnMainMenuNewFlSituationSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewFlSituationSearch.GetAllParamsCount

function TkwEnMainMenuNewFlSituationSearch.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewFlSituationSearch.ParamsTypes

class function TkwEnMainMenuNewFlSituationSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.flSituationSearch';
end;//TkwEnMainMenuNewFlSituationSearch.GetWordNameForRegister

function TkwEnMainMenuNewFlPublishedSourceSearch.flPublishedSourceSearch(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscFocusLabel;
 {* Реализация слова скрипта .Ten_MainMenuNew.flPublishedSourceSearch }
begin
 Result := aen_MainMenuNew.flPublishedSourceSearch;
end;//TkwEnMainMenuNewFlPublishedSourceSearch.flPublishedSourceSearch

procedure TkwEnMainMenuNewFlPublishedSourceSearch.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(flPublishedSourceSearch(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewFlPublishedSourceSearch.DoDoIt

procedure TkwEnMainMenuNewFlPublishedSourceSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству flPublishedSourceSearch', aCtx);
end;//TkwEnMainMenuNewFlPublishedSourceSearch.SetValuePrim

function TkwEnMainMenuNewFlPublishedSourceSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscFocusLabel);
end;//TkwEnMainMenuNewFlPublishedSourceSearch.GetResultTypeInfo

function TkwEnMainMenuNewFlPublishedSourceSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewFlPublishedSourceSearch.GetAllParamsCount

function TkwEnMainMenuNewFlPublishedSourceSearch.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewFlPublishedSourceSearch.ParamsTypes

class function TkwEnMainMenuNewFlPublishedSourceSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.flPublishedSourceSearch';
end;//TkwEnMainMenuNewFlPublishedSourceSearch.GetWordNameForRegister

function TkwEnMainMenuNewFlDictionSearch.flDictionSearch(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscFocusLabel;
 {* Реализация слова скрипта .Ten_MainMenuNew.flDictionSearch }
begin
 Result := aen_MainMenuNew.flDictionSearch;
end;//TkwEnMainMenuNewFlDictionSearch.flDictionSearch

procedure TkwEnMainMenuNewFlDictionSearch.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(flDictionSearch(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewFlDictionSearch.DoDoIt

procedure TkwEnMainMenuNewFlDictionSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству flDictionSearch', aCtx);
end;//TkwEnMainMenuNewFlDictionSearch.SetValuePrim

function TkwEnMainMenuNewFlDictionSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscFocusLabel);
end;//TkwEnMainMenuNewFlDictionSearch.GetResultTypeInfo

function TkwEnMainMenuNewFlDictionSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewFlDictionSearch.GetAllParamsCount

function TkwEnMainMenuNewFlDictionSearch.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewFlDictionSearch.ParamsTypes

class function TkwEnMainMenuNewFlDictionSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.flDictionSearch';
end;//TkwEnMainMenuNewFlDictionSearch.GetWordNameForRegister

function TkwEnMainMenuNewPnlExpert.pnlExpert(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuNew.pnlExpert }
begin
 Result := aen_MainMenuNew.pnlExpert;
end;//TkwEnMainMenuNewPnlExpert.pnlExpert

procedure TkwEnMainMenuNewPnlExpert.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlExpert(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewPnlExpert.DoDoIt

procedure TkwEnMainMenuNewPnlExpert.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlExpert', aCtx);
end;//TkwEnMainMenuNewPnlExpert.SetValuePrim

function TkwEnMainMenuNewPnlExpert.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuNewPnlExpert.GetResultTypeInfo

function TkwEnMainMenuNewPnlExpert.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPnlExpert.GetAllParamsCount

function TkwEnMainMenuNewPnlExpert.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPnlExpert.ParamsTypes

class function TkwEnMainMenuNewPnlExpert.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pnlExpert';
end;//TkwEnMainMenuNewPnlExpert.GetWordNameForRegister

function TkwEnMainMenuNewPbExpert.pbExpert(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
 {* Реализация слова скрипта .Ten_MainMenuNew.pbExpert }
begin
 Result := aen_MainMenuNew.pbExpert;
end;//TkwEnMainMenuNewPbExpert.pbExpert

procedure TkwEnMainMenuNewPbExpert.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbExpert(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewPbExpert.DoDoIt

procedure TkwEnMainMenuNewPbExpert.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pbExpert', aCtx);
end;//TkwEnMainMenuNewPbExpert.SetValuePrim

function TkwEnMainMenuNewPbExpert.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnMainMenuNewPbExpert.GetResultTypeInfo

function TkwEnMainMenuNewPbExpert.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPbExpert.GetAllParamsCount

function TkwEnMainMenuNewPbExpert.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPbExpert.ParamsTypes

class function TkwEnMainMenuNewPbExpert.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pbExpert';
end;//TkwEnMainMenuNewPbExpert.GetWordNameForRegister

function TkwEnMainMenuNewPnlOnLine.pnlOnLine(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuNew.pnlOnLine }
begin
 Result := aen_MainMenuNew.pnlOnLine;
end;//TkwEnMainMenuNewPnlOnLine.pnlOnLine

procedure TkwEnMainMenuNewPnlOnLine.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlOnLine(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewPnlOnLine.DoDoIt

procedure TkwEnMainMenuNewPnlOnLine.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlOnLine', aCtx);
end;//TkwEnMainMenuNewPnlOnLine.SetValuePrim

function TkwEnMainMenuNewPnlOnLine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuNewPnlOnLine.GetResultTypeInfo

function TkwEnMainMenuNewPnlOnLine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPnlOnLine.GetAllParamsCount

function TkwEnMainMenuNewPnlOnLine.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPnlOnLine.ParamsTypes

class function TkwEnMainMenuNewPnlOnLine.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pnlOnLine';
end;//TkwEnMainMenuNewPnlOnLine.GetWordNameForRegister

function TkwEnMainMenuNewPbOnLine.pbOnLine(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
 {* Реализация слова скрипта .Ten_MainMenuNew.pbOnLine }
begin
 Result := aen_MainMenuNew.pbOnLine;
end;//TkwEnMainMenuNewPbOnLine.pbOnLine

procedure TkwEnMainMenuNewPbOnLine.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbOnLine(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewPbOnLine.DoDoIt

procedure TkwEnMainMenuNewPbOnLine.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pbOnLine', aCtx);
end;//TkwEnMainMenuNewPbOnLine.SetValuePrim

function TkwEnMainMenuNewPbOnLine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnMainMenuNewPbOnLine.GetResultTypeInfo

function TkwEnMainMenuNewPbOnLine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPbOnLine.GetAllParamsCount

function TkwEnMainMenuNewPbOnLine.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPbOnLine.ParamsTypes

class function TkwEnMainMenuNewPbOnLine.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pbOnLine';
end;//TkwEnMainMenuNewPbOnLine.GetWordNameForRegister

function TkwEnMainMenuNewPbIntranet.pbIntranet(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
 {* Реализация слова скрипта .Ten_MainMenuNew.pbIntranet }
begin
 Result := aen_MainMenuNew.pbIntranet;
end;//TkwEnMainMenuNewPbIntranet.pbIntranet

procedure TkwEnMainMenuNewPbIntranet.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbIntranet(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewPbIntranet.DoDoIt

procedure TkwEnMainMenuNewPbIntranet.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pbIntranet', aCtx);
end;//TkwEnMainMenuNewPbIntranet.SetValuePrim

function TkwEnMainMenuNewPbIntranet.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnMainMenuNewPbIntranet.GetResultTypeInfo

function TkwEnMainMenuNewPbIntranet.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPbIntranet.GetAllParamsCount

function TkwEnMainMenuNewPbIntranet.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPbIntranet.ParamsTypes

class function TkwEnMainMenuNewPbIntranet.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pbIntranet';
end;//TkwEnMainMenuNewPbIntranet.GetWordNameForRegister

function TkwEnMainMenuNewPbCourtsOnline.pbCourtsOnline(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
 {* Реализация слова скрипта .Ten_MainMenuNew.pbCourtsOnline }
begin
 Result := aen_MainMenuNew.pbCourtsOnline;
end;//TkwEnMainMenuNewPbCourtsOnline.pbCourtsOnline

procedure TkwEnMainMenuNewPbCourtsOnline.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbCourtsOnline(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewPbCourtsOnline.DoDoIt

procedure TkwEnMainMenuNewPbCourtsOnline.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pbCourtsOnline', aCtx);
end;//TkwEnMainMenuNewPbCourtsOnline.SetValuePrim

function TkwEnMainMenuNewPbCourtsOnline.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnMainMenuNewPbCourtsOnline.GetResultTypeInfo

function TkwEnMainMenuNewPbCourtsOnline.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPbCourtsOnline.GetAllParamsCount

function TkwEnMainMenuNewPbCourtsOnline.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPbCourtsOnline.ParamsTypes

class function TkwEnMainMenuNewPbCourtsOnline.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pbCourtsOnline';
end;//TkwEnMainMenuNewPbCourtsOnline.GetWordNameForRegister

function TkwEnMainMenuNewHfTaxes.hfTaxes(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscHideField;
 {* Реализация слова скрипта .Ten_MainMenuNew.hfTaxes }
begin
 Result := aen_MainMenuNew.hfTaxes;
end;//TkwEnMainMenuNewHfTaxes.hfTaxes

procedure TkwEnMainMenuNewHfTaxes.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfTaxes(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewHfTaxes.DoDoIt

procedure TkwEnMainMenuNewHfTaxes.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству hfTaxes', aCtx);
end;//TkwEnMainMenuNewHfTaxes.SetValuePrim

function TkwEnMainMenuNewHfTaxes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMainMenuNewHfTaxes.GetResultTypeInfo

function TkwEnMainMenuNewHfTaxes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewHfTaxes.GetAllParamsCount

function TkwEnMainMenuNewHfTaxes.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewHfTaxes.ParamsTypes

class function TkwEnMainMenuNewHfTaxes.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.hfTaxes';
end;//TkwEnMainMenuNewHfTaxes.GetWordNameForRegister

function TkwEnMainMenuNewTvTaxes.tvTaxes(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscTreeViewHotTruck;
 {* Реализация слова скрипта .Ten_MainMenuNew.tvTaxes }
begin
 Result := aen_MainMenuNew.tvTaxes;
end;//TkwEnMainMenuNewTvTaxes.tvTaxes

procedure TkwEnMainMenuNewTvTaxes.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvTaxes(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewTvTaxes.DoDoIt

procedure TkwEnMainMenuNewTvTaxes.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvTaxes', aCtx);
end;//TkwEnMainMenuNewTvTaxes.SetValuePrim

function TkwEnMainMenuNewTvTaxes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEnMainMenuNewTvTaxes.GetResultTypeInfo

function TkwEnMainMenuNewTvTaxes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewTvTaxes.GetAllParamsCount

function TkwEnMainMenuNewTvTaxes.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewTvTaxes.ParamsTypes

class function TkwEnMainMenuNewTvTaxes.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.tvTaxes';
end;//TkwEnMainMenuNewTvTaxes.GetWordNameForRegister

function TkwEnMainMenuNewPnlBanner.pnlBanner(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuNew.pnlBanner }
begin
 Result := aen_MainMenuNew.pnlBanner;
end;//TkwEnMainMenuNewPnlBanner.pnlBanner

procedure TkwEnMainMenuNewPnlBanner.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlBanner(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewPnlBanner.DoDoIt

procedure TkwEnMainMenuNewPnlBanner.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlBanner', aCtx);
end;//TkwEnMainMenuNewPnlBanner.SetValuePrim

function TkwEnMainMenuNewPnlBanner.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuNewPnlBanner.GetResultTypeInfo

function TkwEnMainMenuNewPnlBanner.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPnlBanner.GetAllParamsCount

function TkwEnMainMenuNewPnlBanner.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPnlBanner.ParamsTypes

class function TkwEnMainMenuNewPnlBanner.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pnlBanner';
end;//TkwEnMainMenuNewPnlBanner.GetWordNameForRegister

function TkwEnMainMenuNewIeBanner.ieBanner(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TImageEnView;
 {* Реализация слова скрипта .Ten_MainMenuNew.ieBanner }
begin
 Result := aen_MainMenuNew.ieBanner;
end;//TkwEnMainMenuNewIeBanner.ieBanner

procedure TkwEnMainMenuNewIeBanner.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ieBanner(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewIeBanner.DoDoIt

procedure TkwEnMainMenuNewIeBanner.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ieBanner', aCtx);
end;//TkwEnMainMenuNewIeBanner.SetValuePrim

function TkwEnMainMenuNewIeBanner.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TImageEnView);
end;//TkwEnMainMenuNewIeBanner.GetResultTypeInfo

function TkwEnMainMenuNewIeBanner.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewIeBanner.GetAllParamsCount

function TkwEnMainMenuNewIeBanner.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewIeBanner.ParamsTypes

class function TkwEnMainMenuNewIeBanner.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.ieBanner';
end;//TkwEnMainMenuNewIeBanner.GetWordNameForRegister

function TkwEnMainMenuNewHfLastOpenDocsRightEdge.hfLastOpenDocsRightEdge(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuNew.hfLastOpenDocsRightEdge }
begin
 Result := aen_MainMenuNew.hfLastOpenDocsRightEdge;
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.hfLastOpenDocsRightEdge

procedure TkwEnMainMenuNewHfLastOpenDocsRightEdge.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfLastOpenDocsRightEdge(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.DoDoIt

procedure TkwEnMainMenuNewHfLastOpenDocsRightEdge.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству hfLastOpenDocsRightEdge', aCtx);
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.SetValuePrim

function TkwEnMainMenuNewHfLastOpenDocsRightEdge.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.GetResultTypeInfo

function TkwEnMainMenuNewHfLastOpenDocsRightEdge.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.GetAllParamsCount

function TkwEnMainMenuNewHfLastOpenDocsRightEdge.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.ParamsTypes

class function TkwEnMainMenuNewHfLastOpenDocsRightEdge.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.hfLastOpenDocsRightEdge';
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.GetWordNameForRegister

function TkwEnMainMenuNewIeIO.ieIO(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TImageEnIO;
 {* Реализация слова скрипта .Ten_MainMenuNew.ieIO }
begin
 Result := aen_MainMenuNew.ieIO;
end;//TkwEnMainMenuNewIeIO.ieIO

procedure TkwEnMainMenuNewIeIO.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ieIO(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewIeIO.DoDoIt

procedure TkwEnMainMenuNewIeIO.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ieIO', aCtx);
end;//TkwEnMainMenuNewIeIO.SetValuePrim

function TkwEnMainMenuNewIeIO.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TImageEnIO);
end;//TkwEnMainMenuNewIeIO.GetResultTypeInfo

function TkwEnMainMenuNewIeIO.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewIeIO.GetAllParamsCount

function TkwEnMainMenuNewIeIO.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewIeIO.ParamsTypes

class function TkwEnMainMenuNewIeIO.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.ieIO';
end;//TkwEnMainMenuNewIeIO.GetWordNameForRegister

function TkwEnMainMenuNewHfReferences.hfReferences(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscHideField;
 {* Реализация слова скрипта .Ten_MainMenuNew.hfReferences }
begin
 Result := aen_MainMenuNew.hfReferences;
end;//TkwEnMainMenuNewHfReferences.hfReferences

procedure TkwEnMainMenuNewHfReferences.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfReferences(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewHfReferences.DoDoIt

procedure TkwEnMainMenuNewHfReferences.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству hfReferences', aCtx);
end;//TkwEnMainMenuNewHfReferences.SetValuePrim

function TkwEnMainMenuNewHfReferences.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMainMenuNewHfReferences.GetResultTypeInfo

function TkwEnMainMenuNewHfReferences.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewHfReferences.GetAllParamsCount

function TkwEnMainMenuNewHfReferences.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewHfReferences.ParamsTypes

class function TkwEnMainMenuNewHfReferences.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.hfReferences';
end;//TkwEnMainMenuNewHfReferences.GetWordNameForRegister

function TkwEnMainMenuNewTvReferences.tvReferences(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscTreeViewHotTruck;
 {* Реализация слова скрипта .Ten_MainMenuNew.tvReferences }
begin
 Result := aen_MainMenuNew.tvReferences;
end;//TkwEnMainMenuNewTvReferences.tvReferences

procedure TkwEnMainMenuNewTvReferences.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvReferences(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewTvReferences.DoDoIt

procedure TkwEnMainMenuNewTvReferences.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvReferences', aCtx);
end;//TkwEnMainMenuNewTvReferences.SetValuePrim

function TkwEnMainMenuNewTvReferences.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEnMainMenuNewTvReferences.GetResultTypeInfo

function TkwEnMainMenuNewTvReferences.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewTvReferences.GetAllParamsCount

function TkwEnMainMenuNewTvReferences.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewTvReferences.ParamsTypes

class function TkwEnMainMenuNewTvReferences.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.tvReferences';
end;//TkwEnMainMenuNewTvReferences.GetWordNameForRegister

function TkwEnMainMenuNewHfLawNews.hfLawNews(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscHideField;
 {* Реализация слова скрипта .Ten_MainMenuNew.hfLawNews }
begin
 Result := aen_MainMenuNew.hfLawNews;
end;//TkwEnMainMenuNewHfLawNews.hfLawNews

procedure TkwEnMainMenuNewHfLawNews.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfLawNews(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewHfLawNews.DoDoIt

procedure TkwEnMainMenuNewHfLawNews.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству hfLawNews', aCtx);
end;//TkwEnMainMenuNewHfLawNews.SetValuePrim

function TkwEnMainMenuNewHfLawNews.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMainMenuNewHfLawNews.GetResultTypeInfo

function TkwEnMainMenuNewHfLawNews.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewHfLawNews.GetAllParamsCount

function TkwEnMainMenuNewHfLawNews.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewHfLawNews.ParamsTypes

class function TkwEnMainMenuNewHfLawNews.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.hfLawNews';
end;//TkwEnMainMenuNewHfLawNews.GetWordNameForRegister

function TkwEnMainMenuNewTvLawNews.tvLawNews(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscTreeViewHotTruck;
 {* Реализация слова скрипта .Ten_MainMenuNew.tvLawNews }
begin
 Result := aen_MainMenuNew.tvLawNews;
end;//TkwEnMainMenuNewTvLawNews.tvLawNews

procedure TkwEnMainMenuNewTvLawNews.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvLawNews(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewTvLawNews.DoDoIt

procedure TkwEnMainMenuNewTvLawNews.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvLawNews', aCtx);
end;//TkwEnMainMenuNewTvLawNews.SetValuePrim

function TkwEnMainMenuNewTvLawNews.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEnMainMenuNewTvLawNews.GetResultTypeInfo

function TkwEnMainMenuNewTvLawNews.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewTvLawNews.GetAllParamsCount

function TkwEnMainMenuNewTvLawNews.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewTvLawNews.ParamsTypes

class function TkwEnMainMenuNewTvLawNews.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.tvLawNews';
end;//TkwEnMainMenuNewTvLawNews.GetWordNameForRegister

function TkwEnMainMenuNewPnlMain.pnlMain(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuNew.pnlMain }
begin
 Result := aen_MainMenuNew.pnlMain;
end;//TkwEnMainMenuNewPnlMain.pnlMain

procedure TkwEnMainMenuNewPnlMain.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlMain(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewPnlMain.DoDoIt

procedure TkwEnMainMenuNewPnlMain.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlMain', aCtx);
end;//TkwEnMainMenuNewPnlMain.SetValuePrim

function TkwEnMainMenuNewPnlMain.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuNewPnlMain.GetResultTypeInfo

function TkwEnMainMenuNewPnlMain.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPnlMain.GetAllParamsCount

function TkwEnMainMenuNewPnlMain.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewPnlMain.ParamsTypes

class function TkwEnMainMenuNewPnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pnlMain';
end;//TkwEnMainMenuNewPnlMain.GetWordNameForRegister

function TkwEnMainMenuNewHfLastOpenDocs.hfLastOpenDocs(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscHideField;
 {* Реализация слова скрипта .Ten_MainMenuNew.hfLastOpenDocs }
begin
 Result := aen_MainMenuNew.hfLastOpenDocs;
end;//TkwEnMainMenuNewHfLastOpenDocs.hfLastOpenDocs

procedure TkwEnMainMenuNewHfLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfLastOpenDocs(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewHfLastOpenDocs.DoDoIt

procedure TkwEnMainMenuNewHfLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству hfLastOpenDocs', aCtx);
end;//TkwEnMainMenuNewHfLastOpenDocs.SetValuePrim

function TkwEnMainMenuNewHfLastOpenDocs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMainMenuNewHfLastOpenDocs.GetResultTypeInfo

function TkwEnMainMenuNewHfLastOpenDocs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewHfLastOpenDocs.GetAllParamsCount

function TkwEnMainMenuNewHfLastOpenDocs.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewHfLastOpenDocs.ParamsTypes

class function TkwEnMainMenuNewHfLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.hfLastOpenDocs';
end;//TkwEnMainMenuNewHfLastOpenDocs.GetWordNameForRegister

function TkwEnMainMenuNewTvLastOpenDocs.tvLastOpenDocs(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscTreeViewHotTruck;
 {* Реализация слова скрипта .Ten_MainMenuNew.tvLastOpenDocs }
begin
 Result := aen_MainMenuNew.tvLastOpenDocs;
end;//TkwEnMainMenuNewTvLastOpenDocs.tvLastOpenDocs

procedure TkwEnMainMenuNewTvLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuNew: Ten_MainMenuNew;
begin
 try
  l_aen_MainMenuNew := Ten_MainMenuNew(aCtx.rEngine.PopObjAs(Ten_MainMenuNew));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuNew: Ten_MainMenuNew : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvLastOpenDocs(aCtx, l_aen_MainMenuNew));
end;//TkwEnMainMenuNewTvLastOpenDocs.DoDoIt

procedure TkwEnMainMenuNewTvLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvLastOpenDocs', aCtx);
end;//TkwEnMainMenuNewTvLastOpenDocs.SetValuePrim

function TkwEnMainMenuNewTvLastOpenDocs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEnMainMenuNewTvLastOpenDocs.GetResultTypeInfo

function TkwEnMainMenuNewTvLastOpenDocs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewTvLastOpenDocs.GetAllParamsCount

function TkwEnMainMenuNewTvLastOpenDocs.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuNew)]);
end;//TkwEnMainMenuNewTvLastOpenDocs.ParamsTypes

class function TkwEnMainMenuNewTvLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.tvLastOpenDocs';
end;//TkwEnMainMenuNewTvLastOpenDocs.GetWordNameForRegister

initialization
 Tkw_Form_MainMenuNew.RegisterInEngine;
 {* Регистрация Tkw_Form_MainMenuNew }
 Tkw_MainMenuNew_Control_pnlBaseSearch.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pnlBaseSearch }
 Tkw_MainMenuNew_Control_pnlBaseSearch_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pnlBaseSearch_Push }
 Tkw_MainMenuNew_Control_pnlBaseSearchZone.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pnlBaseSearchZone }
 Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push }
 Tkw_MainMenuNew_Control_pnlLogo.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pnlLogo }
 Tkw_MainMenuNew_Control_pnlLogo_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pnlLogo_Push }
 Tkw_MainMenuNew_Control_pbLogo.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pbLogo }
 Tkw_MainMenuNew_Control_pbLogo_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pbLogo_Push }
 Tkw_MainMenuNew_Control_pnlSearches.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pnlSearches }
 Tkw_MainMenuNew_Control_pnlSearches_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pnlSearches_Push }
 Tkw_MainMenuNew_Control_flAttributeSearch.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_flAttributeSearch }
 Tkw_MainMenuNew_Control_flAttributeSearch_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_flAttributeSearch_Push }
 Tkw_MainMenuNew_Control_flSituationSearch.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_flSituationSearch }
 Tkw_MainMenuNew_Control_flSituationSearch_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_flSituationSearch_Push }
 Tkw_MainMenuNew_Control_flPublishedSourceSearch.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_flPublishedSourceSearch }
 Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push }
 Tkw_MainMenuNew_Control_flDictionSearch.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_flDictionSearch }
 Tkw_MainMenuNew_Control_flDictionSearch_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_flDictionSearch_Push }
 Tkw_MainMenuNew_Control_pnlExpert.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pnlExpert }
 Tkw_MainMenuNew_Control_pnlExpert_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pnlExpert_Push }
 Tkw_MainMenuNew_Control_pbExpert.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pbExpert }
 Tkw_MainMenuNew_Control_pbExpert_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pbExpert_Push }
 Tkw_MainMenuNew_Control_pnlOnLine.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pnlOnLine }
 Tkw_MainMenuNew_Control_pnlOnLine_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pnlOnLine_Push }
 Tkw_MainMenuNew_Control_pbOnLine.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pbOnLine }
 Tkw_MainMenuNew_Control_pbOnLine_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pbOnLine_Push }
 Tkw_MainMenuNew_Control_pbIntranet.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pbIntranet }
 Tkw_MainMenuNew_Control_pbIntranet_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pbIntranet_Push }
 Tkw_MainMenuNew_Control_pbCourtsOnline.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pbCourtsOnline }
 Tkw_MainMenuNew_Control_pbCourtsOnline_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pbCourtsOnline_Push }
 Tkw_MainMenuNew_Control_hfTaxes.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_hfTaxes }
 Tkw_MainMenuNew_Control_hfTaxes_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_hfTaxes_Push }
 Tkw_MainMenuNew_Control_tvTaxes.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_tvTaxes }
 Tkw_MainMenuNew_Control_tvTaxes_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_tvTaxes_Push }
 Tkw_MainMenuNew_Control_pnlBanner.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pnlBanner }
 Tkw_MainMenuNew_Control_pnlBanner_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pnlBanner_Push }
 Tkw_MainMenuNew_Control_ieBanner.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_ieBanner }
 Tkw_MainMenuNew_Control_ieBanner_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_ieBanner_Push }
 Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge }
 Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push }
 Tkw_MainMenuNew_Component_ieIO.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Component_ieIO }
 Tkw_MainMenuNew_Control_hfReferences.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_hfReferences }
 Tkw_MainMenuNew_Control_hfReferences_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_hfReferences_Push }
 Tkw_MainMenuNew_Control_tvReferences.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_tvReferences }
 Tkw_MainMenuNew_Control_tvReferences_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_tvReferences_Push }
 Tkw_MainMenuNew_Control_hfLawNews.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_hfLawNews }
 Tkw_MainMenuNew_Control_hfLawNews_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_hfLawNews_Push }
 Tkw_MainMenuNew_Control_tvLawNews.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_tvLawNews }
 Tkw_MainMenuNew_Control_tvLawNews_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_tvLawNews_Push }
 Tkw_MainMenuNew_Control_pnlMain.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pnlMain }
 Tkw_MainMenuNew_Control_pnlMain_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_pnlMain_Push }
 Tkw_MainMenuNew_Control_hfLastOpenDocs.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_hfLastOpenDocs }
 Tkw_MainMenuNew_Control_hfLastOpenDocs_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_hfLastOpenDocs_Push }
 Tkw_MainMenuNew_Control_tvLastOpenDocs.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_tvLastOpenDocs }
 Tkw_MainMenuNew_Control_tvLastOpenDocs_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuNew_Control_tvLastOpenDocs_Push }
 TkwEnMainMenuNewPnlBaseSearch.RegisterInEngine;
 {* Регистрация en_MainMenuNew_pnlBaseSearch }
 TkwEnMainMenuNewPnlBaseSearchZone.RegisterInEngine;
 {* Регистрация en_MainMenuNew_pnlBaseSearchZone }
 TkwEnMainMenuNewPnlLogo.RegisterInEngine;
 {* Регистрация en_MainMenuNew_pnlLogo }
 TkwEnMainMenuNewPbLogo.RegisterInEngine;
 {* Регистрация en_MainMenuNew_pbLogo }
 TkwEnMainMenuNewPnlSearches.RegisterInEngine;
 {* Регистрация en_MainMenuNew_pnlSearches }
 TkwEnMainMenuNewFlAttributeSearch.RegisterInEngine;
 {* Регистрация en_MainMenuNew_flAttributeSearch }
 TkwEnMainMenuNewFlSituationSearch.RegisterInEngine;
 {* Регистрация en_MainMenuNew_flSituationSearch }
 TkwEnMainMenuNewFlPublishedSourceSearch.RegisterInEngine;
 {* Регистрация en_MainMenuNew_flPublishedSourceSearch }
 TkwEnMainMenuNewFlDictionSearch.RegisterInEngine;
 {* Регистрация en_MainMenuNew_flDictionSearch }
 TkwEnMainMenuNewPnlExpert.RegisterInEngine;
 {* Регистрация en_MainMenuNew_pnlExpert }
 TkwEnMainMenuNewPbExpert.RegisterInEngine;
 {* Регистрация en_MainMenuNew_pbExpert }
 TkwEnMainMenuNewPnlOnLine.RegisterInEngine;
 {* Регистрация en_MainMenuNew_pnlOnLine }
 TkwEnMainMenuNewPbOnLine.RegisterInEngine;
 {* Регистрация en_MainMenuNew_pbOnLine }
 TkwEnMainMenuNewPbIntranet.RegisterInEngine;
 {* Регистрация en_MainMenuNew_pbIntranet }
 TkwEnMainMenuNewPbCourtsOnline.RegisterInEngine;
 {* Регистрация en_MainMenuNew_pbCourtsOnline }
 TkwEnMainMenuNewHfTaxes.RegisterInEngine;
 {* Регистрация en_MainMenuNew_hfTaxes }
 TkwEnMainMenuNewTvTaxes.RegisterInEngine;
 {* Регистрация en_MainMenuNew_tvTaxes }
 TkwEnMainMenuNewPnlBanner.RegisterInEngine;
 {* Регистрация en_MainMenuNew_pnlBanner }
 TkwEnMainMenuNewIeBanner.RegisterInEngine;
 {* Регистрация en_MainMenuNew_ieBanner }
 TkwEnMainMenuNewHfLastOpenDocsRightEdge.RegisterInEngine;
 {* Регистрация en_MainMenuNew_hfLastOpenDocsRightEdge }
 TkwEnMainMenuNewIeIO.RegisterInEngine;
 {* Регистрация en_MainMenuNew_ieIO }
 TkwEnMainMenuNewHfReferences.RegisterInEngine;
 {* Регистрация en_MainMenuNew_hfReferences }
 TkwEnMainMenuNewTvReferences.RegisterInEngine;
 {* Регистрация en_MainMenuNew_tvReferences }
 TkwEnMainMenuNewHfLawNews.RegisterInEngine;
 {* Регистрация en_MainMenuNew_hfLawNews }
 TkwEnMainMenuNewTvLawNews.RegisterInEngine;
 {* Регистрация en_MainMenuNew_tvLawNews }
 TkwEnMainMenuNewPnlMain.RegisterInEngine;
 {* Регистрация en_MainMenuNew_pnlMain }
 TkwEnMainMenuNewHfLastOpenDocs.RegisterInEngine;
 {* Регистрация en_MainMenuNew_hfLastOpenDocs }
 TkwEnMainMenuNewTvLastOpenDocs.RegisterInEngine;
 {* Регистрация en_MainMenuNew_tvLastOpenDocs }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_MainMenuNew));
 {* Регистрация типа MainMenuNew }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* Регистрация типа TPaintBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscFocusLabel));
 {* Регистрация типа TnscFocusLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscHideField));
 {* Регистрация типа TnscHideField }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewHotTruck));
 {* Регистрация типа TnscTreeViewHotTruck }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImageEnView));
 {* Регистрация типа TImageEnView }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImageEnIO));
 {* Регистрация типа TImageEnIO }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
