unit MainMenuNewKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы MainMenuNew }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\MainMenuNewKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , MainMenu_Module
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
 Tkw_Form_MainMenuNew = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы MainMenuNew
----
*Пример использования*:
[code]
'aControl' форма::MainMenuNew TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_MainMenuNew

 Tkw_MainMenuNew_Control_pnlBaseSearch = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlBaseSearch
----
*Пример использования*:
[code]
контрол::pnlBaseSearch TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_pnlBaseSearch

 Tkw_MainMenuNew_Control_pnlBaseSearch_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_pnlBaseSearchZone

 Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_pnlLogo

 Tkw_MainMenuNew_Control_pnlLogo_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_pbLogo

 Tkw_MainMenuNew_Control_pbLogo_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_pnlSearches

 Tkw_MainMenuNew_Control_pnlSearches_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_flAttributeSearch

 Tkw_MainMenuNew_Control_flAttributeSearch_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_flSituationSearch

 Tkw_MainMenuNew_Control_flSituationSearch_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_flPublishedSourceSearch

 Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_flDictionSearch

 Tkw_MainMenuNew_Control_flDictionSearch_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_pnlExpert

 Tkw_MainMenuNew_Control_pnlExpert_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_pbExpert

 Tkw_MainMenuNew_Control_pbExpert_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_pnlOnLine

 Tkw_MainMenuNew_Control_pnlOnLine_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_pbOnLine

 Tkw_MainMenuNew_Control_pbOnLine_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_pbIntranet

 Tkw_MainMenuNew_Control_pbIntranet_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_pbCourtsOnline

 Tkw_MainMenuNew_Control_pbCourtsOnline_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_hfTaxes

 Tkw_MainMenuNew_Control_hfTaxes_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_tvTaxes

 Tkw_MainMenuNew_Control_tvTaxes_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_pnlBanner

 Tkw_MainMenuNew_Control_pnlBanner_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_ieBanner

 Tkw_MainMenuNew_Control_ieBanner_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge

 Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Component_ieIO

 Tkw_MainMenuNew_Control_hfReferences = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола hfReferences
----
*Пример использования*:
[code]
контрол::hfReferences TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_hfReferences

 Tkw_MainMenuNew_Control_hfReferences_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_tvReferences

 Tkw_MainMenuNew_Control_tvReferences_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_hfLawNews

 Tkw_MainMenuNew_Control_hfLawNews_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_tvLawNews

 Tkw_MainMenuNew_Control_tvLawNews_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_pnlMain

 Tkw_MainMenuNew_Control_pnlMain_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_hfLastOpenDocs

 Tkw_MainMenuNew_Control_hfLastOpenDocs_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MainMenuNew_Control_tvLastOpenDocs

 Tkw_MainMenuNew_Control_tvLastOpenDocs_Push = {final} class(TkwBynameControlPush)
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

class function Tkw_Form_MainMenuNew.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::MainMenuNew';
end;//Tkw_Form_MainMenuNew.GetWordNameForRegister

function Tkw_Form_MainMenuNew.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5963EF1982DB_var*
//#UC END# *4DDFD2EA0116_5963EF1982DB_var*
begin
//#UC START# *4DDFD2EA0116_5963EF1982DB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5963EF1982DB_impl*
end;//Tkw_Form_MainMenuNew.GetString

class function Tkw_MainMenuNew_Control_pnlBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBaseSearch';
end;//Tkw_MainMenuNew_Control_pnlBaseSearch.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlBaseSearch.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_CA0CABFB8A9A_var*
//#UC END# *4DDFD2EA0116_CA0CABFB8A9A_var*
begin
//#UC START# *4DDFD2EA0116_CA0CABFB8A9A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_CA0CABFB8A9A_impl*
end;//Tkw_MainMenuNew_Control_pnlBaseSearch.GetString

class procedure Tkw_MainMenuNew_Control_pnlBaseSearch.RegisterInEngine;
//#UC START# *52A086150180_CA0CABFB8A9A_var*
//#UC END# *52A086150180_CA0CABFB8A9A_var*
begin
//#UC START# *52A086150180_CA0CABFB8A9A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_CA0CABFB8A9A_impl*
end;//Tkw_MainMenuNew_Control_pnlBaseSearch.RegisterInEngine

procedure Tkw_MainMenuNew_Control_pnlBaseSearch_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_291D12F6F906_var*
//#UC END# *4DAEEDE10285_291D12F6F906_var*
begin
//#UC START# *4DAEEDE10285_291D12F6F906_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_291D12F6F906_impl*
end;//Tkw_MainMenuNew_Control_pnlBaseSearch_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlBaseSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBaseSearch:push';
end;//Tkw_MainMenuNew_Control_pnlBaseSearch_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_pnlBaseSearchZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBaseSearchZone';
end;//Tkw_MainMenuNew_Control_pnlBaseSearchZone.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlBaseSearchZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_35B3CB85727A_var*
//#UC END# *4DDFD2EA0116_35B3CB85727A_var*
begin
//#UC START# *4DDFD2EA0116_35B3CB85727A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_35B3CB85727A_impl*
end;//Tkw_MainMenuNew_Control_pnlBaseSearchZone.GetString

class procedure Tkw_MainMenuNew_Control_pnlBaseSearchZone.RegisterInEngine;
//#UC START# *52A086150180_35B3CB85727A_var*
//#UC END# *52A086150180_35B3CB85727A_var*
begin
//#UC START# *52A086150180_35B3CB85727A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_35B3CB85727A_impl*
end;//Tkw_MainMenuNew_Control_pnlBaseSearchZone.RegisterInEngine

procedure Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EA4FDA23998D_var*
//#UC END# *4DAEEDE10285_EA4FDA23998D_var*
begin
//#UC START# *4DAEEDE10285_EA4FDA23998D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EA4FDA23998D_impl*
end;//Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBaseSearchZone:push';
end;//Tkw_MainMenuNew_Control_pnlBaseSearchZone_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_pnlLogo.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlLogo';
end;//Tkw_MainMenuNew_Control_pnlLogo.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlLogo.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_946DADC5F369_var*
//#UC END# *4DDFD2EA0116_946DADC5F369_var*
begin
//#UC START# *4DDFD2EA0116_946DADC5F369_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_946DADC5F369_impl*
end;//Tkw_MainMenuNew_Control_pnlLogo.GetString

class procedure Tkw_MainMenuNew_Control_pnlLogo.RegisterInEngine;
//#UC START# *52A086150180_946DADC5F369_var*
//#UC END# *52A086150180_946DADC5F369_var*
begin
//#UC START# *52A086150180_946DADC5F369_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_946DADC5F369_impl*
end;//Tkw_MainMenuNew_Control_pnlLogo.RegisterInEngine

procedure Tkw_MainMenuNew_Control_pnlLogo_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_66F9EE4199B8_var*
//#UC END# *4DAEEDE10285_66F9EE4199B8_var*
begin
//#UC START# *4DAEEDE10285_66F9EE4199B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_66F9EE4199B8_impl*
end;//Tkw_MainMenuNew_Control_pnlLogo_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlLogo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlLogo:push';
end;//Tkw_MainMenuNew_Control_pnlLogo_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_pbLogo.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbLogo';
end;//Tkw_MainMenuNew_Control_pbLogo.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pbLogo.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B6FE4344DD88_var*
//#UC END# *4DDFD2EA0116_B6FE4344DD88_var*
begin
//#UC START# *4DDFD2EA0116_B6FE4344DD88_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B6FE4344DD88_impl*
end;//Tkw_MainMenuNew_Control_pbLogo.GetString

class procedure Tkw_MainMenuNew_Control_pbLogo.RegisterInEngine;
//#UC START# *52A086150180_B6FE4344DD88_var*
//#UC END# *52A086150180_B6FE4344DD88_var*
begin
//#UC START# *52A086150180_B6FE4344DD88_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B6FE4344DD88_impl*
end;//Tkw_MainMenuNew_Control_pbLogo.RegisterInEngine

procedure Tkw_MainMenuNew_Control_pbLogo_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3329FF91AD58_var*
//#UC END# *4DAEEDE10285_3329FF91AD58_var*
begin
//#UC START# *4DAEEDE10285_3329FF91AD58_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3329FF91AD58_impl*
end;//Tkw_MainMenuNew_Control_pbLogo_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pbLogo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbLogo:push';
end;//Tkw_MainMenuNew_Control_pbLogo_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_pnlSearches.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlSearches';
end;//Tkw_MainMenuNew_Control_pnlSearches.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlSearches.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6A49C4B1278B_var*
//#UC END# *4DDFD2EA0116_6A49C4B1278B_var*
begin
//#UC START# *4DDFD2EA0116_6A49C4B1278B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6A49C4B1278B_impl*
end;//Tkw_MainMenuNew_Control_pnlSearches.GetString

class procedure Tkw_MainMenuNew_Control_pnlSearches.RegisterInEngine;
//#UC START# *52A086150180_6A49C4B1278B_var*
//#UC END# *52A086150180_6A49C4B1278B_var*
begin
//#UC START# *52A086150180_6A49C4B1278B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6A49C4B1278B_impl*
end;//Tkw_MainMenuNew_Control_pnlSearches.RegisterInEngine

procedure Tkw_MainMenuNew_Control_pnlSearches_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F9DDE6D099B3_var*
//#UC END# *4DAEEDE10285_F9DDE6D099B3_var*
begin
//#UC START# *4DAEEDE10285_F9DDE6D099B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F9DDE6D099B3_impl*
end;//Tkw_MainMenuNew_Control_pnlSearches_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlSearches_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlSearches:push';
end;//Tkw_MainMenuNew_Control_pnlSearches_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_flAttributeSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flAttributeSearch';
end;//Tkw_MainMenuNew_Control_flAttributeSearch.GetWordNameForRegister

function Tkw_MainMenuNew_Control_flAttributeSearch.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7D0CB385796F_var*
//#UC END# *4DDFD2EA0116_7D0CB385796F_var*
begin
//#UC START# *4DDFD2EA0116_7D0CB385796F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7D0CB385796F_impl*
end;//Tkw_MainMenuNew_Control_flAttributeSearch.GetString

class procedure Tkw_MainMenuNew_Control_flAttributeSearch.RegisterInEngine;
//#UC START# *52A086150180_7D0CB385796F_var*
//#UC END# *52A086150180_7D0CB385796F_var*
begin
//#UC START# *52A086150180_7D0CB385796F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_7D0CB385796F_impl*
end;//Tkw_MainMenuNew_Control_flAttributeSearch.RegisterInEngine

procedure Tkw_MainMenuNew_Control_flAttributeSearch_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FF987E9128FE_var*
//#UC END# *4DAEEDE10285_FF987E9128FE_var*
begin
//#UC START# *4DAEEDE10285_FF987E9128FE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FF987E9128FE_impl*
end;//Tkw_MainMenuNew_Control_flAttributeSearch_Push.DoDoIt

class function Tkw_MainMenuNew_Control_flAttributeSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flAttributeSearch:push';
end;//Tkw_MainMenuNew_Control_flAttributeSearch_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_flSituationSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flSituationSearch';
end;//Tkw_MainMenuNew_Control_flSituationSearch.GetWordNameForRegister

function Tkw_MainMenuNew_Control_flSituationSearch.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_EC9932E88713_var*
//#UC END# *4DDFD2EA0116_EC9932E88713_var*
begin
//#UC START# *4DDFD2EA0116_EC9932E88713_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_EC9932E88713_impl*
end;//Tkw_MainMenuNew_Control_flSituationSearch.GetString

class procedure Tkw_MainMenuNew_Control_flSituationSearch.RegisterInEngine;
//#UC START# *52A086150180_EC9932E88713_var*
//#UC END# *52A086150180_EC9932E88713_var*
begin
//#UC START# *52A086150180_EC9932E88713_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_EC9932E88713_impl*
end;//Tkw_MainMenuNew_Control_flSituationSearch.RegisterInEngine

procedure Tkw_MainMenuNew_Control_flSituationSearch_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C638A2D7ADCD_var*
//#UC END# *4DAEEDE10285_C638A2D7ADCD_var*
begin
//#UC START# *4DAEEDE10285_C638A2D7ADCD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C638A2D7ADCD_impl*
end;//Tkw_MainMenuNew_Control_flSituationSearch_Push.DoDoIt

class function Tkw_MainMenuNew_Control_flSituationSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flSituationSearch:push';
end;//Tkw_MainMenuNew_Control_flSituationSearch_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_flPublishedSourceSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flPublishedSourceSearch';
end;//Tkw_MainMenuNew_Control_flPublishedSourceSearch.GetWordNameForRegister

function Tkw_MainMenuNew_Control_flPublishedSourceSearch.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2B6A8E2B3AF3_var*
//#UC END# *4DDFD2EA0116_2B6A8E2B3AF3_var*
begin
//#UC START# *4DDFD2EA0116_2B6A8E2B3AF3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2B6A8E2B3AF3_impl*
end;//Tkw_MainMenuNew_Control_flPublishedSourceSearch.GetString

class procedure Tkw_MainMenuNew_Control_flPublishedSourceSearch.RegisterInEngine;
//#UC START# *52A086150180_2B6A8E2B3AF3_var*
//#UC END# *52A086150180_2B6A8E2B3AF3_var*
begin
//#UC START# *52A086150180_2B6A8E2B3AF3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2B6A8E2B3AF3_impl*
end;//Tkw_MainMenuNew_Control_flPublishedSourceSearch.RegisterInEngine

procedure Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6C1A0500E6ED_var*
//#UC END# *4DAEEDE10285_6C1A0500E6ED_var*
begin
//#UC START# *4DAEEDE10285_6C1A0500E6ED_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6C1A0500E6ED_impl*
end;//Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push.DoDoIt

class function Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flPublishedSourceSearch:push';
end;//Tkw_MainMenuNew_Control_flPublishedSourceSearch_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_flDictionSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flDictionSearch';
end;//Tkw_MainMenuNew_Control_flDictionSearch.GetWordNameForRegister

function Tkw_MainMenuNew_Control_flDictionSearch.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_91A71E7A0822_var*
//#UC END# *4DDFD2EA0116_91A71E7A0822_var*
begin
//#UC START# *4DDFD2EA0116_91A71E7A0822_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_91A71E7A0822_impl*
end;//Tkw_MainMenuNew_Control_flDictionSearch.GetString

class procedure Tkw_MainMenuNew_Control_flDictionSearch.RegisterInEngine;
//#UC START# *52A086150180_91A71E7A0822_var*
//#UC END# *52A086150180_91A71E7A0822_var*
begin
//#UC START# *52A086150180_91A71E7A0822_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_91A71E7A0822_impl*
end;//Tkw_MainMenuNew_Control_flDictionSearch.RegisterInEngine

procedure Tkw_MainMenuNew_Control_flDictionSearch_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6D8FCB63C281_var*
//#UC END# *4DAEEDE10285_6D8FCB63C281_var*
begin
//#UC START# *4DAEEDE10285_6D8FCB63C281_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6D8FCB63C281_impl*
end;//Tkw_MainMenuNew_Control_flDictionSearch_Push.DoDoIt

class function Tkw_MainMenuNew_Control_flDictionSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flDictionSearch:push';
end;//Tkw_MainMenuNew_Control_flDictionSearch_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_pnlExpert.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlExpert';
end;//Tkw_MainMenuNew_Control_pnlExpert.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlExpert.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B89642443122_var*
//#UC END# *4DDFD2EA0116_B89642443122_var*
begin
//#UC START# *4DDFD2EA0116_B89642443122_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B89642443122_impl*
end;//Tkw_MainMenuNew_Control_pnlExpert.GetString

class procedure Tkw_MainMenuNew_Control_pnlExpert.RegisterInEngine;
//#UC START# *52A086150180_B89642443122_var*
//#UC END# *52A086150180_B89642443122_var*
begin
//#UC START# *52A086150180_B89642443122_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B89642443122_impl*
end;//Tkw_MainMenuNew_Control_pnlExpert.RegisterInEngine

procedure Tkw_MainMenuNew_Control_pnlExpert_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2DF088439F46_var*
//#UC END# *4DAEEDE10285_2DF088439F46_var*
begin
//#UC START# *4DAEEDE10285_2DF088439F46_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2DF088439F46_impl*
end;//Tkw_MainMenuNew_Control_pnlExpert_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlExpert_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlExpert:push';
end;//Tkw_MainMenuNew_Control_pnlExpert_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_pbExpert.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbExpert';
end;//Tkw_MainMenuNew_Control_pbExpert.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pbExpert.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5B32B4744006_var*
//#UC END# *4DDFD2EA0116_5B32B4744006_var*
begin
//#UC START# *4DDFD2EA0116_5B32B4744006_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5B32B4744006_impl*
end;//Tkw_MainMenuNew_Control_pbExpert.GetString

class procedure Tkw_MainMenuNew_Control_pbExpert.RegisterInEngine;
//#UC START# *52A086150180_5B32B4744006_var*
//#UC END# *52A086150180_5B32B4744006_var*
begin
//#UC START# *52A086150180_5B32B4744006_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5B32B4744006_impl*
end;//Tkw_MainMenuNew_Control_pbExpert.RegisterInEngine

procedure Tkw_MainMenuNew_Control_pbExpert_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_480FC8E28E3A_var*
//#UC END# *4DAEEDE10285_480FC8E28E3A_var*
begin
//#UC START# *4DAEEDE10285_480FC8E28E3A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_480FC8E28E3A_impl*
end;//Tkw_MainMenuNew_Control_pbExpert_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pbExpert_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbExpert:push';
end;//Tkw_MainMenuNew_Control_pbExpert_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_pnlOnLine.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlOnLine';
end;//Tkw_MainMenuNew_Control_pnlOnLine.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlOnLine.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_93273AA8B771_var*
//#UC END# *4DDFD2EA0116_93273AA8B771_var*
begin
//#UC START# *4DDFD2EA0116_93273AA8B771_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_93273AA8B771_impl*
end;//Tkw_MainMenuNew_Control_pnlOnLine.GetString

class procedure Tkw_MainMenuNew_Control_pnlOnLine.RegisterInEngine;
//#UC START# *52A086150180_93273AA8B771_var*
//#UC END# *52A086150180_93273AA8B771_var*
begin
//#UC START# *52A086150180_93273AA8B771_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_93273AA8B771_impl*
end;//Tkw_MainMenuNew_Control_pnlOnLine.RegisterInEngine

procedure Tkw_MainMenuNew_Control_pnlOnLine_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F29FCB839478_var*
//#UC END# *4DAEEDE10285_F29FCB839478_var*
begin
//#UC START# *4DAEEDE10285_F29FCB839478_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F29FCB839478_impl*
end;//Tkw_MainMenuNew_Control_pnlOnLine_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlOnLine_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlOnLine:push';
end;//Tkw_MainMenuNew_Control_pnlOnLine_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_pbOnLine.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbOnLine';
end;//Tkw_MainMenuNew_Control_pbOnLine.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pbOnLine.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_489C63E45DAB_var*
//#UC END# *4DDFD2EA0116_489C63E45DAB_var*
begin
//#UC START# *4DDFD2EA0116_489C63E45DAB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_489C63E45DAB_impl*
end;//Tkw_MainMenuNew_Control_pbOnLine.GetString

class procedure Tkw_MainMenuNew_Control_pbOnLine.RegisterInEngine;
//#UC START# *52A086150180_489C63E45DAB_var*
//#UC END# *52A086150180_489C63E45DAB_var*
begin
//#UC START# *52A086150180_489C63E45DAB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_489C63E45DAB_impl*
end;//Tkw_MainMenuNew_Control_pbOnLine.RegisterInEngine

procedure Tkw_MainMenuNew_Control_pbOnLine_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F97D669A3840_var*
//#UC END# *4DAEEDE10285_F97D669A3840_var*
begin
//#UC START# *4DAEEDE10285_F97D669A3840_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F97D669A3840_impl*
end;//Tkw_MainMenuNew_Control_pbOnLine_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pbOnLine_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbOnLine:push';
end;//Tkw_MainMenuNew_Control_pbOnLine_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_pbIntranet.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbIntranet';
end;//Tkw_MainMenuNew_Control_pbIntranet.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pbIntranet.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_CB667F21D413_var*
//#UC END# *4DDFD2EA0116_CB667F21D413_var*
begin
//#UC START# *4DDFD2EA0116_CB667F21D413_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_CB667F21D413_impl*
end;//Tkw_MainMenuNew_Control_pbIntranet.GetString

class procedure Tkw_MainMenuNew_Control_pbIntranet.RegisterInEngine;
//#UC START# *52A086150180_CB667F21D413_var*
//#UC END# *52A086150180_CB667F21D413_var*
begin
//#UC START# *52A086150180_CB667F21D413_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_CB667F21D413_impl*
end;//Tkw_MainMenuNew_Control_pbIntranet.RegisterInEngine

procedure Tkw_MainMenuNew_Control_pbIntranet_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5326C967FEE2_var*
//#UC END# *4DAEEDE10285_5326C967FEE2_var*
begin
//#UC START# *4DAEEDE10285_5326C967FEE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5326C967FEE2_impl*
end;//Tkw_MainMenuNew_Control_pbIntranet_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pbIntranet_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbIntranet:push';
end;//Tkw_MainMenuNew_Control_pbIntranet_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_pbCourtsOnline.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbCourtsOnline';
end;//Tkw_MainMenuNew_Control_pbCourtsOnline.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pbCourtsOnline.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6D92BF886EB4_var*
//#UC END# *4DDFD2EA0116_6D92BF886EB4_var*
begin
//#UC START# *4DDFD2EA0116_6D92BF886EB4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6D92BF886EB4_impl*
end;//Tkw_MainMenuNew_Control_pbCourtsOnline.GetString

class procedure Tkw_MainMenuNew_Control_pbCourtsOnline.RegisterInEngine;
//#UC START# *52A086150180_6D92BF886EB4_var*
//#UC END# *52A086150180_6D92BF886EB4_var*
begin
//#UC START# *52A086150180_6D92BF886EB4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6D92BF886EB4_impl*
end;//Tkw_MainMenuNew_Control_pbCourtsOnline.RegisterInEngine

procedure Tkw_MainMenuNew_Control_pbCourtsOnline_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DD10E210A151_var*
//#UC END# *4DAEEDE10285_DD10E210A151_var*
begin
//#UC START# *4DAEEDE10285_DD10E210A151_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DD10E210A151_impl*
end;//Tkw_MainMenuNew_Control_pbCourtsOnline_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pbCourtsOnline_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbCourtsOnline:push';
end;//Tkw_MainMenuNew_Control_pbCourtsOnline_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_hfTaxes.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfTaxes';
end;//Tkw_MainMenuNew_Control_hfTaxes.GetWordNameForRegister

function Tkw_MainMenuNew_Control_hfTaxes.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_FF6D755ED6A0_var*
//#UC END# *4DDFD2EA0116_FF6D755ED6A0_var*
begin
//#UC START# *4DDFD2EA0116_FF6D755ED6A0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_FF6D755ED6A0_impl*
end;//Tkw_MainMenuNew_Control_hfTaxes.GetString

class procedure Tkw_MainMenuNew_Control_hfTaxes.RegisterInEngine;
//#UC START# *52A086150180_FF6D755ED6A0_var*
//#UC END# *52A086150180_FF6D755ED6A0_var*
begin
//#UC START# *52A086150180_FF6D755ED6A0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_FF6D755ED6A0_impl*
end;//Tkw_MainMenuNew_Control_hfTaxes.RegisterInEngine

procedure Tkw_MainMenuNew_Control_hfTaxes_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0EAFCA430F9A_var*
//#UC END# *4DAEEDE10285_0EAFCA430F9A_var*
begin
//#UC START# *4DAEEDE10285_0EAFCA430F9A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0EAFCA430F9A_impl*
end;//Tkw_MainMenuNew_Control_hfTaxes_Push.DoDoIt

class function Tkw_MainMenuNew_Control_hfTaxes_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfTaxes:push';
end;//Tkw_MainMenuNew_Control_hfTaxes_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_tvTaxes.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvTaxes';
end;//Tkw_MainMenuNew_Control_tvTaxes.GetWordNameForRegister

function Tkw_MainMenuNew_Control_tvTaxes.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_BCF68A6897EE_var*
//#UC END# *4DDFD2EA0116_BCF68A6897EE_var*
begin
//#UC START# *4DDFD2EA0116_BCF68A6897EE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_BCF68A6897EE_impl*
end;//Tkw_MainMenuNew_Control_tvTaxes.GetString

class procedure Tkw_MainMenuNew_Control_tvTaxes.RegisterInEngine;
//#UC START# *52A086150180_BCF68A6897EE_var*
//#UC END# *52A086150180_BCF68A6897EE_var*
begin
//#UC START# *52A086150180_BCF68A6897EE_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_BCF68A6897EE_impl*
end;//Tkw_MainMenuNew_Control_tvTaxes.RegisterInEngine

procedure Tkw_MainMenuNew_Control_tvTaxes_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7E0519E136D7_var*
//#UC END# *4DAEEDE10285_7E0519E136D7_var*
begin
//#UC START# *4DAEEDE10285_7E0519E136D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7E0519E136D7_impl*
end;//Tkw_MainMenuNew_Control_tvTaxes_Push.DoDoIt

class function Tkw_MainMenuNew_Control_tvTaxes_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvTaxes:push';
end;//Tkw_MainMenuNew_Control_tvTaxes_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_pnlBanner.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBanner';
end;//Tkw_MainMenuNew_Control_pnlBanner.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlBanner.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AC35FD95E2FF_var*
//#UC END# *4DDFD2EA0116_AC35FD95E2FF_var*
begin
//#UC START# *4DDFD2EA0116_AC35FD95E2FF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AC35FD95E2FF_impl*
end;//Tkw_MainMenuNew_Control_pnlBanner.GetString

class procedure Tkw_MainMenuNew_Control_pnlBanner.RegisterInEngine;
//#UC START# *52A086150180_AC35FD95E2FF_var*
//#UC END# *52A086150180_AC35FD95E2FF_var*
begin
//#UC START# *52A086150180_AC35FD95E2FF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_AC35FD95E2FF_impl*
end;//Tkw_MainMenuNew_Control_pnlBanner.RegisterInEngine

procedure Tkw_MainMenuNew_Control_pnlBanner_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_78F26344F7B2_var*
//#UC END# *4DAEEDE10285_78F26344F7B2_var*
begin
//#UC START# *4DAEEDE10285_78F26344F7B2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_78F26344F7B2_impl*
end;//Tkw_MainMenuNew_Control_pnlBanner_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlBanner_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBanner:push';
end;//Tkw_MainMenuNew_Control_pnlBanner_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_ieBanner.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ieBanner';
end;//Tkw_MainMenuNew_Control_ieBanner.GetWordNameForRegister

function Tkw_MainMenuNew_Control_ieBanner.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E72CB040002C_var*
//#UC END# *4DDFD2EA0116_E72CB040002C_var*
begin
//#UC START# *4DDFD2EA0116_E72CB040002C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E72CB040002C_impl*
end;//Tkw_MainMenuNew_Control_ieBanner.GetString

class procedure Tkw_MainMenuNew_Control_ieBanner.RegisterInEngine;
//#UC START# *52A086150180_E72CB040002C_var*
//#UC END# *52A086150180_E72CB040002C_var*
begin
//#UC START# *52A086150180_E72CB040002C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E72CB040002C_impl*
end;//Tkw_MainMenuNew_Control_ieBanner.RegisterInEngine

procedure Tkw_MainMenuNew_Control_ieBanner_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_99C70B21362B_var*
//#UC END# *4DAEEDE10285_99C70B21362B_var*
begin
//#UC START# *4DAEEDE10285_99C70B21362B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_99C70B21362B_impl*
end;//Tkw_MainMenuNew_Control_ieBanner_Push.DoDoIt

class function Tkw_MainMenuNew_Control_ieBanner_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ieBanner:push';
end;//Tkw_MainMenuNew_Control_ieBanner_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfLastOpenDocsRightEdge';
end;//Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge.GetWordNameForRegister

function Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7864E0F56DC5_var*
//#UC END# *4DDFD2EA0116_7864E0F56DC5_var*
begin
//#UC START# *4DDFD2EA0116_7864E0F56DC5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7864E0F56DC5_impl*
end;//Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge.GetString

class procedure Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge.RegisterInEngine;
//#UC START# *52A086150180_7864E0F56DC5_var*
//#UC END# *52A086150180_7864E0F56DC5_var*
begin
//#UC START# *52A086150180_7864E0F56DC5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_7864E0F56DC5_impl*
end;//Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge.RegisterInEngine

procedure Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AAE60B265804_var*
//#UC END# *4DAEEDE10285_AAE60B265804_var*
begin
//#UC START# *4DAEEDE10285_AAE60B265804_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AAE60B265804_impl*
end;//Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push.DoDoIt

class function Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfLastOpenDocsRightEdge:push';
end;//Tkw_MainMenuNew_Control_hfLastOpenDocsRightEdge_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Component_ieIO.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::ieIO';
end;//Tkw_MainMenuNew_Component_ieIO.GetWordNameForRegister

function Tkw_MainMenuNew_Component_ieIO.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AD3C356D8EF8_var*
//#UC END# *4DDFD2EA0116_AD3C356D8EF8_var*
begin
//#UC START# *4DDFD2EA0116_AD3C356D8EF8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AD3C356D8EF8_impl*
end;//Tkw_MainMenuNew_Component_ieIO.GetString

class procedure Tkw_MainMenuNew_Component_ieIO.RegisterInEngine;
//#UC START# *52A086150180_AD3C356D8EF8_var*
//#UC END# *52A086150180_AD3C356D8EF8_var*
begin
//#UC START# *52A086150180_AD3C356D8EF8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_AD3C356D8EF8_impl*
end;//Tkw_MainMenuNew_Component_ieIO.RegisterInEngine

class function Tkw_MainMenuNew_Control_hfReferences.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfReferences';
end;//Tkw_MainMenuNew_Control_hfReferences.GetWordNameForRegister

function Tkw_MainMenuNew_Control_hfReferences.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_DDD621F531C9_var*
//#UC END# *4DDFD2EA0116_DDD621F531C9_var*
begin
//#UC START# *4DDFD2EA0116_DDD621F531C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_DDD621F531C9_impl*
end;//Tkw_MainMenuNew_Control_hfReferences.GetString

class procedure Tkw_MainMenuNew_Control_hfReferences.RegisterInEngine;
//#UC START# *52A086150180_DDD621F531C9_var*
//#UC END# *52A086150180_DDD621F531C9_var*
begin
//#UC START# *52A086150180_DDD621F531C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_DDD621F531C9_impl*
end;//Tkw_MainMenuNew_Control_hfReferences.RegisterInEngine

procedure Tkw_MainMenuNew_Control_hfReferences_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AD61BB063A8A_var*
//#UC END# *4DAEEDE10285_AD61BB063A8A_var*
begin
//#UC START# *4DAEEDE10285_AD61BB063A8A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AD61BB063A8A_impl*
end;//Tkw_MainMenuNew_Control_hfReferences_Push.DoDoIt

class function Tkw_MainMenuNew_Control_hfReferences_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfReferences:push';
end;//Tkw_MainMenuNew_Control_hfReferences_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_tvReferences.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvReferences';
end;//Tkw_MainMenuNew_Control_tvReferences.GetWordNameForRegister

function Tkw_MainMenuNew_Control_tvReferences.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2AC09FB44495_var*
//#UC END# *4DDFD2EA0116_2AC09FB44495_var*
begin
//#UC START# *4DDFD2EA0116_2AC09FB44495_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2AC09FB44495_impl*
end;//Tkw_MainMenuNew_Control_tvReferences.GetString

class procedure Tkw_MainMenuNew_Control_tvReferences.RegisterInEngine;
//#UC START# *52A086150180_2AC09FB44495_var*
//#UC END# *52A086150180_2AC09FB44495_var*
begin
//#UC START# *52A086150180_2AC09FB44495_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2AC09FB44495_impl*
end;//Tkw_MainMenuNew_Control_tvReferences.RegisterInEngine

procedure Tkw_MainMenuNew_Control_tvReferences_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A6B923DFC979_var*
//#UC END# *4DAEEDE10285_A6B923DFC979_var*
begin
//#UC START# *4DAEEDE10285_A6B923DFC979_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A6B923DFC979_impl*
end;//Tkw_MainMenuNew_Control_tvReferences_Push.DoDoIt

class function Tkw_MainMenuNew_Control_tvReferences_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvReferences:push';
end;//Tkw_MainMenuNew_Control_tvReferences_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_hfLawNews.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfLawNews';
end;//Tkw_MainMenuNew_Control_hfLawNews.GetWordNameForRegister

function Tkw_MainMenuNew_Control_hfLawNews.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8C2C7192F75D_var*
//#UC END# *4DDFD2EA0116_8C2C7192F75D_var*
begin
//#UC START# *4DDFD2EA0116_8C2C7192F75D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8C2C7192F75D_impl*
end;//Tkw_MainMenuNew_Control_hfLawNews.GetString

class procedure Tkw_MainMenuNew_Control_hfLawNews.RegisterInEngine;
//#UC START# *52A086150180_8C2C7192F75D_var*
//#UC END# *52A086150180_8C2C7192F75D_var*
begin
//#UC START# *52A086150180_8C2C7192F75D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_8C2C7192F75D_impl*
end;//Tkw_MainMenuNew_Control_hfLawNews.RegisterInEngine

procedure Tkw_MainMenuNew_Control_hfLawNews_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2CB0E984001D_var*
//#UC END# *4DAEEDE10285_2CB0E984001D_var*
begin
//#UC START# *4DAEEDE10285_2CB0E984001D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2CB0E984001D_impl*
end;//Tkw_MainMenuNew_Control_hfLawNews_Push.DoDoIt

class function Tkw_MainMenuNew_Control_hfLawNews_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfLawNews:push';
end;//Tkw_MainMenuNew_Control_hfLawNews_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_tvLawNews.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvLawNews';
end;//Tkw_MainMenuNew_Control_tvLawNews.GetWordNameForRegister

function Tkw_MainMenuNew_Control_tvLawNews.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_21D6C5298DAB_var*
//#UC END# *4DDFD2EA0116_21D6C5298DAB_var*
begin
//#UC START# *4DDFD2EA0116_21D6C5298DAB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_21D6C5298DAB_impl*
end;//Tkw_MainMenuNew_Control_tvLawNews.GetString

class procedure Tkw_MainMenuNew_Control_tvLawNews.RegisterInEngine;
//#UC START# *52A086150180_21D6C5298DAB_var*
//#UC END# *52A086150180_21D6C5298DAB_var*
begin
//#UC START# *52A086150180_21D6C5298DAB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_21D6C5298DAB_impl*
end;//Tkw_MainMenuNew_Control_tvLawNews.RegisterInEngine

procedure Tkw_MainMenuNew_Control_tvLawNews_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_03EC88AD0EAA_var*
//#UC END# *4DAEEDE10285_03EC88AD0EAA_var*
begin
//#UC START# *4DAEEDE10285_03EC88AD0EAA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_03EC88AD0EAA_impl*
end;//Tkw_MainMenuNew_Control_tvLawNews_Push.DoDoIt

class function Tkw_MainMenuNew_Control_tvLawNews_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvLawNews:push';
end;//Tkw_MainMenuNew_Control_tvLawNews_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_pnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlMain';
end;//Tkw_MainMenuNew_Control_pnlMain.GetWordNameForRegister

function Tkw_MainMenuNew_Control_pnlMain.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_71ED5C021B24_var*
//#UC END# *4DDFD2EA0116_71ED5C021B24_var*
begin
//#UC START# *4DDFD2EA0116_71ED5C021B24_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_71ED5C021B24_impl*
end;//Tkw_MainMenuNew_Control_pnlMain.GetString

class procedure Tkw_MainMenuNew_Control_pnlMain.RegisterInEngine;
//#UC START# *52A086150180_71ED5C021B24_var*
//#UC END# *52A086150180_71ED5C021B24_var*
begin
//#UC START# *52A086150180_71ED5C021B24_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_71ED5C021B24_impl*
end;//Tkw_MainMenuNew_Control_pnlMain.RegisterInEngine

procedure Tkw_MainMenuNew_Control_pnlMain_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_66CE5FFA0EC3_var*
//#UC END# *4DAEEDE10285_66CE5FFA0EC3_var*
begin
//#UC START# *4DAEEDE10285_66CE5FFA0EC3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_66CE5FFA0EC3_impl*
end;//Tkw_MainMenuNew_Control_pnlMain_Push.DoDoIt

class function Tkw_MainMenuNew_Control_pnlMain_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlMain:push';
end;//Tkw_MainMenuNew_Control_pnlMain_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_hfLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfLastOpenDocs';
end;//Tkw_MainMenuNew_Control_hfLastOpenDocs.GetWordNameForRegister

function Tkw_MainMenuNew_Control_hfLastOpenDocs.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_72AD75ADE92C_var*
//#UC END# *4DDFD2EA0116_72AD75ADE92C_var*
begin
//#UC START# *4DDFD2EA0116_72AD75ADE92C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_72AD75ADE92C_impl*
end;//Tkw_MainMenuNew_Control_hfLastOpenDocs.GetString

class procedure Tkw_MainMenuNew_Control_hfLastOpenDocs.RegisterInEngine;
//#UC START# *52A086150180_72AD75ADE92C_var*
//#UC END# *52A086150180_72AD75ADE92C_var*
begin
//#UC START# *52A086150180_72AD75ADE92C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_72AD75ADE92C_impl*
end;//Tkw_MainMenuNew_Control_hfLastOpenDocs.RegisterInEngine

procedure Tkw_MainMenuNew_Control_hfLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0AF17BDCCC68_var*
//#UC END# *4DAEEDE10285_0AF17BDCCC68_var*
begin
//#UC START# *4DAEEDE10285_0AF17BDCCC68_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0AF17BDCCC68_impl*
end;//Tkw_MainMenuNew_Control_hfLastOpenDocs_Push.DoDoIt

class function Tkw_MainMenuNew_Control_hfLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfLastOpenDocs:push';
end;//Tkw_MainMenuNew_Control_hfLastOpenDocs_Push.GetWordNameForRegister

class function Tkw_MainMenuNew_Control_tvLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvLastOpenDocs';
end;//Tkw_MainMenuNew_Control_tvLastOpenDocs.GetWordNameForRegister

function Tkw_MainMenuNew_Control_tvLastOpenDocs.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B150CA407FA0_var*
//#UC END# *4DDFD2EA0116_B150CA407FA0_var*
begin
//#UC START# *4DDFD2EA0116_B150CA407FA0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B150CA407FA0_impl*
end;//Tkw_MainMenuNew_Control_tvLastOpenDocs.GetString

class procedure Tkw_MainMenuNew_Control_tvLastOpenDocs.RegisterInEngine;
//#UC START# *52A086150180_B150CA407FA0_var*
//#UC END# *52A086150180_B150CA407FA0_var*
begin
//#UC START# *52A086150180_B150CA407FA0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B150CA407FA0_impl*
end;//Tkw_MainMenuNew_Control_tvLastOpenDocs.RegisterInEngine

procedure Tkw_MainMenuNew_Control_tvLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F96789E37468_var*
//#UC END# *4DAEEDE10285_F96789E37468_var*
begin
//#UC START# *4DAEEDE10285_F96789E37468_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F96789E37468_impl*
end;//Tkw_MainMenuNew_Control_tvLastOpenDocs_Push.DoDoIt

class function Tkw_MainMenuNew_Control_tvLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvLastOpenDocs:push';
end;//Tkw_MainMenuNew_Control_tvLastOpenDocs_Push.GetWordNameForRegister

function TkwEnMainMenuNewPnlBaseSearch.pnlBaseSearch(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuNew.pnlBaseSearch }
//#UC START# *9D2E00D27940_50CDDA57514E_var*
//#UC END# *9D2E00D27940_50CDDA57514E_var*
begin
//#UC START# *9D2E00D27940_50CDDA57514E_impl*
 !!! Needs to be implemented !!!
//#UC END# *9D2E00D27940_50CDDA57514E_impl*
end;//TkwEnMainMenuNewPnlBaseSearch.pnlBaseSearch

procedure TkwEnMainMenuNewPnlBaseSearch.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_50CDDA57514E_var*
//#UC END# *4DAEEDE10285_50CDDA57514E_var*
begin
//#UC START# *4DAEEDE10285_50CDDA57514E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_50CDDA57514E_impl*
end;//TkwEnMainMenuNewPnlBaseSearch.DoDoIt

class function TkwEnMainMenuNewPnlBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pnlBaseSearch';
end;//TkwEnMainMenuNewPnlBaseSearch.GetWordNameForRegister

procedure TkwEnMainMenuNewPnlBaseSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_50CDDA57514E_var*
//#UC END# *52D00B00031A_50CDDA57514E_var*
begin
//#UC START# *52D00B00031A_50CDDA57514E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_50CDDA57514E_impl*
end;//TkwEnMainMenuNewPnlBaseSearch.SetValuePrim

function TkwEnMainMenuNewPnlBaseSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_50CDDA57514E_var*
//#UC END# *551544E2001A_50CDDA57514E_var*
begin
//#UC START# *551544E2001A_50CDDA57514E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_50CDDA57514E_impl*
end;//TkwEnMainMenuNewPnlBaseSearch.GetResultTypeInfo

function TkwEnMainMenuNewPnlBaseSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPnlBaseSearch.GetAllParamsCount

function TkwEnMainMenuNewPnlBaseSearch.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_50CDDA57514E_var*
//#UC END# *5617F4D00243_50CDDA57514E_var*
begin
//#UC START# *5617F4D00243_50CDDA57514E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_50CDDA57514E_impl*
end;//TkwEnMainMenuNewPnlBaseSearch.ParamsTypes

function TkwEnMainMenuNewPnlBaseSearchZone.pnlBaseSearchZone(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuNew.pnlBaseSearchZone }
//#UC START# *A99EB448D904_BECB5C9375F9_var*
//#UC END# *A99EB448D904_BECB5C9375F9_var*
begin
//#UC START# *A99EB448D904_BECB5C9375F9_impl*
 !!! Needs to be implemented !!!
//#UC END# *A99EB448D904_BECB5C9375F9_impl*
end;//TkwEnMainMenuNewPnlBaseSearchZone.pnlBaseSearchZone

procedure TkwEnMainMenuNewPnlBaseSearchZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BECB5C9375F9_var*
//#UC END# *4DAEEDE10285_BECB5C9375F9_var*
begin
//#UC START# *4DAEEDE10285_BECB5C9375F9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BECB5C9375F9_impl*
end;//TkwEnMainMenuNewPnlBaseSearchZone.DoDoIt

class function TkwEnMainMenuNewPnlBaseSearchZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pnlBaseSearchZone';
end;//TkwEnMainMenuNewPnlBaseSearchZone.GetWordNameForRegister

procedure TkwEnMainMenuNewPnlBaseSearchZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_BECB5C9375F9_var*
//#UC END# *52D00B00031A_BECB5C9375F9_var*
begin
//#UC START# *52D00B00031A_BECB5C9375F9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_BECB5C9375F9_impl*
end;//TkwEnMainMenuNewPnlBaseSearchZone.SetValuePrim

function TkwEnMainMenuNewPnlBaseSearchZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_BECB5C9375F9_var*
//#UC END# *551544E2001A_BECB5C9375F9_var*
begin
//#UC START# *551544E2001A_BECB5C9375F9_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_BECB5C9375F9_impl*
end;//TkwEnMainMenuNewPnlBaseSearchZone.GetResultTypeInfo

function TkwEnMainMenuNewPnlBaseSearchZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPnlBaseSearchZone.GetAllParamsCount

function TkwEnMainMenuNewPnlBaseSearchZone.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_BECB5C9375F9_var*
//#UC END# *5617F4D00243_BECB5C9375F9_var*
begin
//#UC START# *5617F4D00243_BECB5C9375F9_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_BECB5C9375F9_impl*
end;//TkwEnMainMenuNewPnlBaseSearchZone.ParamsTypes

function TkwEnMainMenuNewPnlLogo.pnlLogo(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuNew.pnlLogo }
//#UC START# *22C999207A28_D95353F03F28_var*
//#UC END# *22C999207A28_D95353F03F28_var*
begin
//#UC START# *22C999207A28_D95353F03F28_impl*
 !!! Needs to be implemented !!!
//#UC END# *22C999207A28_D95353F03F28_impl*
end;//TkwEnMainMenuNewPnlLogo.pnlLogo

procedure TkwEnMainMenuNewPnlLogo.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D95353F03F28_var*
//#UC END# *4DAEEDE10285_D95353F03F28_var*
begin
//#UC START# *4DAEEDE10285_D95353F03F28_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D95353F03F28_impl*
end;//TkwEnMainMenuNewPnlLogo.DoDoIt

class function TkwEnMainMenuNewPnlLogo.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pnlLogo';
end;//TkwEnMainMenuNewPnlLogo.GetWordNameForRegister

procedure TkwEnMainMenuNewPnlLogo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_D95353F03F28_var*
//#UC END# *52D00B00031A_D95353F03F28_var*
begin
//#UC START# *52D00B00031A_D95353F03F28_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_D95353F03F28_impl*
end;//TkwEnMainMenuNewPnlLogo.SetValuePrim

function TkwEnMainMenuNewPnlLogo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D95353F03F28_var*
//#UC END# *551544E2001A_D95353F03F28_var*
begin
//#UC START# *551544E2001A_D95353F03F28_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D95353F03F28_impl*
end;//TkwEnMainMenuNewPnlLogo.GetResultTypeInfo

function TkwEnMainMenuNewPnlLogo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPnlLogo.GetAllParamsCount

function TkwEnMainMenuNewPnlLogo.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D95353F03F28_var*
//#UC END# *5617F4D00243_D95353F03F28_var*
begin
//#UC START# *5617F4D00243_D95353F03F28_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D95353F03F28_impl*
end;//TkwEnMainMenuNewPnlLogo.ParamsTypes

function TkwEnMainMenuNewPbLogo.pbLogo(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
 {* Реализация слова скрипта .Ten_MainMenuNew.pbLogo }
//#UC START# *7F0CC28E3F38_A351443C9199_var*
//#UC END# *7F0CC28E3F38_A351443C9199_var*
begin
//#UC START# *7F0CC28E3F38_A351443C9199_impl*
 !!! Needs to be implemented !!!
//#UC END# *7F0CC28E3F38_A351443C9199_impl*
end;//TkwEnMainMenuNewPbLogo.pbLogo

procedure TkwEnMainMenuNewPbLogo.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A351443C9199_var*
//#UC END# *4DAEEDE10285_A351443C9199_var*
begin
//#UC START# *4DAEEDE10285_A351443C9199_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A351443C9199_impl*
end;//TkwEnMainMenuNewPbLogo.DoDoIt

class function TkwEnMainMenuNewPbLogo.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pbLogo';
end;//TkwEnMainMenuNewPbLogo.GetWordNameForRegister

procedure TkwEnMainMenuNewPbLogo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_A351443C9199_var*
//#UC END# *52D00B00031A_A351443C9199_var*
begin
//#UC START# *52D00B00031A_A351443C9199_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_A351443C9199_impl*
end;//TkwEnMainMenuNewPbLogo.SetValuePrim

function TkwEnMainMenuNewPbLogo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_A351443C9199_var*
//#UC END# *551544E2001A_A351443C9199_var*
begin
//#UC START# *551544E2001A_A351443C9199_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_A351443C9199_impl*
end;//TkwEnMainMenuNewPbLogo.GetResultTypeInfo

function TkwEnMainMenuNewPbLogo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPbLogo.GetAllParamsCount

function TkwEnMainMenuNewPbLogo.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_A351443C9199_var*
//#UC END# *5617F4D00243_A351443C9199_var*
begin
//#UC START# *5617F4D00243_A351443C9199_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A351443C9199_impl*
end;//TkwEnMainMenuNewPbLogo.ParamsTypes

function TkwEnMainMenuNewPnlSearches.pnlSearches(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuNew.pnlSearches }
//#UC START# *A6DA5CA05461_418582140883_var*
//#UC END# *A6DA5CA05461_418582140883_var*
begin
//#UC START# *A6DA5CA05461_418582140883_impl*
 !!! Needs to be implemented !!!
//#UC END# *A6DA5CA05461_418582140883_impl*
end;//TkwEnMainMenuNewPnlSearches.pnlSearches

procedure TkwEnMainMenuNewPnlSearches.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_418582140883_var*
//#UC END# *4DAEEDE10285_418582140883_var*
begin
//#UC START# *4DAEEDE10285_418582140883_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_418582140883_impl*
end;//TkwEnMainMenuNewPnlSearches.DoDoIt

class function TkwEnMainMenuNewPnlSearches.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pnlSearches';
end;//TkwEnMainMenuNewPnlSearches.GetWordNameForRegister

procedure TkwEnMainMenuNewPnlSearches.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_418582140883_var*
//#UC END# *52D00B00031A_418582140883_var*
begin
//#UC START# *52D00B00031A_418582140883_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_418582140883_impl*
end;//TkwEnMainMenuNewPnlSearches.SetValuePrim

function TkwEnMainMenuNewPnlSearches.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_418582140883_var*
//#UC END# *551544E2001A_418582140883_var*
begin
//#UC START# *551544E2001A_418582140883_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_418582140883_impl*
end;//TkwEnMainMenuNewPnlSearches.GetResultTypeInfo

function TkwEnMainMenuNewPnlSearches.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPnlSearches.GetAllParamsCount

function TkwEnMainMenuNewPnlSearches.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_418582140883_var*
//#UC END# *5617F4D00243_418582140883_var*
begin
//#UC START# *5617F4D00243_418582140883_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_418582140883_impl*
end;//TkwEnMainMenuNewPnlSearches.ParamsTypes

function TkwEnMainMenuNewFlAttributeSearch.flAttributeSearch(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscFocusLabel;
 {* Реализация слова скрипта .Ten_MainMenuNew.flAttributeSearch }
//#UC START# *D2711768FD85_CBDFAF1BC938_var*
//#UC END# *D2711768FD85_CBDFAF1BC938_var*
begin
//#UC START# *D2711768FD85_CBDFAF1BC938_impl*
 !!! Needs to be implemented !!!
//#UC END# *D2711768FD85_CBDFAF1BC938_impl*
end;//TkwEnMainMenuNewFlAttributeSearch.flAttributeSearch

procedure TkwEnMainMenuNewFlAttributeSearch.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CBDFAF1BC938_var*
//#UC END# *4DAEEDE10285_CBDFAF1BC938_var*
begin
//#UC START# *4DAEEDE10285_CBDFAF1BC938_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CBDFAF1BC938_impl*
end;//TkwEnMainMenuNewFlAttributeSearch.DoDoIt

class function TkwEnMainMenuNewFlAttributeSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.flAttributeSearch';
end;//TkwEnMainMenuNewFlAttributeSearch.GetWordNameForRegister

procedure TkwEnMainMenuNewFlAttributeSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_CBDFAF1BC938_var*
//#UC END# *52D00B00031A_CBDFAF1BC938_var*
begin
//#UC START# *52D00B00031A_CBDFAF1BC938_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_CBDFAF1BC938_impl*
end;//TkwEnMainMenuNewFlAttributeSearch.SetValuePrim

function TkwEnMainMenuNewFlAttributeSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_CBDFAF1BC938_var*
//#UC END# *551544E2001A_CBDFAF1BC938_var*
begin
//#UC START# *551544E2001A_CBDFAF1BC938_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_CBDFAF1BC938_impl*
end;//TkwEnMainMenuNewFlAttributeSearch.GetResultTypeInfo

function TkwEnMainMenuNewFlAttributeSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewFlAttributeSearch.GetAllParamsCount

function TkwEnMainMenuNewFlAttributeSearch.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_CBDFAF1BC938_var*
//#UC END# *5617F4D00243_CBDFAF1BC938_var*
begin
//#UC START# *5617F4D00243_CBDFAF1BC938_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_CBDFAF1BC938_impl*
end;//TkwEnMainMenuNewFlAttributeSearch.ParamsTypes

function TkwEnMainMenuNewFlSituationSearch.flSituationSearch(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscFocusLabel;
 {* Реализация слова скрипта .Ten_MainMenuNew.flSituationSearch }
//#UC START# *A444AFAC2974_926DA446DC57_var*
//#UC END# *A444AFAC2974_926DA446DC57_var*
begin
//#UC START# *A444AFAC2974_926DA446DC57_impl*
 !!! Needs to be implemented !!!
//#UC END# *A444AFAC2974_926DA446DC57_impl*
end;//TkwEnMainMenuNewFlSituationSearch.flSituationSearch

procedure TkwEnMainMenuNewFlSituationSearch.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_926DA446DC57_var*
//#UC END# *4DAEEDE10285_926DA446DC57_var*
begin
//#UC START# *4DAEEDE10285_926DA446DC57_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_926DA446DC57_impl*
end;//TkwEnMainMenuNewFlSituationSearch.DoDoIt

class function TkwEnMainMenuNewFlSituationSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.flSituationSearch';
end;//TkwEnMainMenuNewFlSituationSearch.GetWordNameForRegister

procedure TkwEnMainMenuNewFlSituationSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_926DA446DC57_var*
//#UC END# *52D00B00031A_926DA446DC57_var*
begin
//#UC START# *52D00B00031A_926DA446DC57_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_926DA446DC57_impl*
end;//TkwEnMainMenuNewFlSituationSearch.SetValuePrim

function TkwEnMainMenuNewFlSituationSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_926DA446DC57_var*
//#UC END# *551544E2001A_926DA446DC57_var*
begin
//#UC START# *551544E2001A_926DA446DC57_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_926DA446DC57_impl*
end;//TkwEnMainMenuNewFlSituationSearch.GetResultTypeInfo

function TkwEnMainMenuNewFlSituationSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewFlSituationSearch.GetAllParamsCount

function TkwEnMainMenuNewFlSituationSearch.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_926DA446DC57_var*
//#UC END# *5617F4D00243_926DA446DC57_var*
begin
//#UC START# *5617F4D00243_926DA446DC57_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_926DA446DC57_impl*
end;//TkwEnMainMenuNewFlSituationSearch.ParamsTypes

function TkwEnMainMenuNewFlPublishedSourceSearch.flPublishedSourceSearch(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscFocusLabel;
 {* Реализация слова скрипта .Ten_MainMenuNew.flPublishedSourceSearch }
//#UC START# *D847DB61F982_C2E87697DDD2_var*
//#UC END# *D847DB61F982_C2E87697DDD2_var*
begin
//#UC START# *D847DB61F982_C2E87697DDD2_impl*
 !!! Needs to be implemented !!!
//#UC END# *D847DB61F982_C2E87697DDD2_impl*
end;//TkwEnMainMenuNewFlPublishedSourceSearch.flPublishedSourceSearch

procedure TkwEnMainMenuNewFlPublishedSourceSearch.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C2E87697DDD2_var*
//#UC END# *4DAEEDE10285_C2E87697DDD2_var*
begin
//#UC START# *4DAEEDE10285_C2E87697DDD2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C2E87697DDD2_impl*
end;//TkwEnMainMenuNewFlPublishedSourceSearch.DoDoIt

class function TkwEnMainMenuNewFlPublishedSourceSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.flPublishedSourceSearch';
end;//TkwEnMainMenuNewFlPublishedSourceSearch.GetWordNameForRegister

procedure TkwEnMainMenuNewFlPublishedSourceSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C2E87697DDD2_var*
//#UC END# *52D00B00031A_C2E87697DDD2_var*
begin
//#UC START# *52D00B00031A_C2E87697DDD2_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C2E87697DDD2_impl*
end;//TkwEnMainMenuNewFlPublishedSourceSearch.SetValuePrim

function TkwEnMainMenuNewFlPublishedSourceSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_C2E87697DDD2_var*
//#UC END# *551544E2001A_C2E87697DDD2_var*
begin
//#UC START# *551544E2001A_C2E87697DDD2_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_C2E87697DDD2_impl*
end;//TkwEnMainMenuNewFlPublishedSourceSearch.GetResultTypeInfo

function TkwEnMainMenuNewFlPublishedSourceSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewFlPublishedSourceSearch.GetAllParamsCount

function TkwEnMainMenuNewFlPublishedSourceSearch.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C2E87697DDD2_var*
//#UC END# *5617F4D00243_C2E87697DDD2_var*
begin
//#UC START# *5617F4D00243_C2E87697DDD2_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C2E87697DDD2_impl*
end;//TkwEnMainMenuNewFlPublishedSourceSearch.ParamsTypes

function TkwEnMainMenuNewFlDictionSearch.flDictionSearch(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscFocusLabel;
 {* Реализация слова скрипта .Ten_MainMenuNew.flDictionSearch }
//#UC START# *58025AA2B6DF_F4802B3524B8_var*
//#UC END# *58025AA2B6DF_F4802B3524B8_var*
begin
//#UC START# *58025AA2B6DF_F4802B3524B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *58025AA2B6DF_F4802B3524B8_impl*
end;//TkwEnMainMenuNewFlDictionSearch.flDictionSearch

procedure TkwEnMainMenuNewFlDictionSearch.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F4802B3524B8_var*
//#UC END# *4DAEEDE10285_F4802B3524B8_var*
begin
//#UC START# *4DAEEDE10285_F4802B3524B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F4802B3524B8_impl*
end;//TkwEnMainMenuNewFlDictionSearch.DoDoIt

class function TkwEnMainMenuNewFlDictionSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.flDictionSearch';
end;//TkwEnMainMenuNewFlDictionSearch.GetWordNameForRegister

procedure TkwEnMainMenuNewFlDictionSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_F4802B3524B8_var*
//#UC END# *52D00B00031A_F4802B3524B8_var*
begin
//#UC START# *52D00B00031A_F4802B3524B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_F4802B3524B8_impl*
end;//TkwEnMainMenuNewFlDictionSearch.SetValuePrim

function TkwEnMainMenuNewFlDictionSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F4802B3524B8_var*
//#UC END# *551544E2001A_F4802B3524B8_var*
begin
//#UC START# *551544E2001A_F4802B3524B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F4802B3524B8_impl*
end;//TkwEnMainMenuNewFlDictionSearch.GetResultTypeInfo

function TkwEnMainMenuNewFlDictionSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewFlDictionSearch.GetAllParamsCount

function TkwEnMainMenuNewFlDictionSearch.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F4802B3524B8_var*
//#UC END# *5617F4D00243_F4802B3524B8_var*
begin
//#UC START# *5617F4D00243_F4802B3524B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F4802B3524B8_impl*
end;//TkwEnMainMenuNewFlDictionSearch.ParamsTypes

function TkwEnMainMenuNewPnlExpert.pnlExpert(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuNew.pnlExpert }
//#UC START# *670597296045_0A37772FD527_var*
//#UC END# *670597296045_0A37772FD527_var*
begin
//#UC START# *670597296045_0A37772FD527_impl*
 !!! Needs to be implemented !!!
//#UC END# *670597296045_0A37772FD527_impl*
end;//TkwEnMainMenuNewPnlExpert.pnlExpert

procedure TkwEnMainMenuNewPnlExpert.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0A37772FD527_var*
//#UC END# *4DAEEDE10285_0A37772FD527_var*
begin
//#UC START# *4DAEEDE10285_0A37772FD527_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0A37772FD527_impl*
end;//TkwEnMainMenuNewPnlExpert.DoDoIt

class function TkwEnMainMenuNewPnlExpert.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pnlExpert';
end;//TkwEnMainMenuNewPnlExpert.GetWordNameForRegister

procedure TkwEnMainMenuNewPnlExpert.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_0A37772FD527_var*
//#UC END# *52D00B00031A_0A37772FD527_var*
begin
//#UC START# *52D00B00031A_0A37772FD527_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_0A37772FD527_impl*
end;//TkwEnMainMenuNewPnlExpert.SetValuePrim

function TkwEnMainMenuNewPnlExpert.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0A37772FD527_var*
//#UC END# *551544E2001A_0A37772FD527_var*
begin
//#UC START# *551544E2001A_0A37772FD527_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0A37772FD527_impl*
end;//TkwEnMainMenuNewPnlExpert.GetResultTypeInfo

function TkwEnMainMenuNewPnlExpert.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPnlExpert.GetAllParamsCount

function TkwEnMainMenuNewPnlExpert.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0A37772FD527_var*
//#UC END# *5617F4D00243_0A37772FD527_var*
begin
//#UC START# *5617F4D00243_0A37772FD527_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0A37772FD527_impl*
end;//TkwEnMainMenuNewPnlExpert.ParamsTypes

function TkwEnMainMenuNewPbExpert.pbExpert(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
 {* Реализация слова скрипта .Ten_MainMenuNew.pbExpert }
//#UC START# *F7EB817BFE93_86C02AC743C9_var*
//#UC END# *F7EB817BFE93_86C02AC743C9_var*
begin
//#UC START# *F7EB817BFE93_86C02AC743C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *F7EB817BFE93_86C02AC743C9_impl*
end;//TkwEnMainMenuNewPbExpert.pbExpert

procedure TkwEnMainMenuNewPbExpert.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_86C02AC743C9_var*
//#UC END# *4DAEEDE10285_86C02AC743C9_var*
begin
//#UC START# *4DAEEDE10285_86C02AC743C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_86C02AC743C9_impl*
end;//TkwEnMainMenuNewPbExpert.DoDoIt

class function TkwEnMainMenuNewPbExpert.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pbExpert';
end;//TkwEnMainMenuNewPbExpert.GetWordNameForRegister

procedure TkwEnMainMenuNewPbExpert.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_86C02AC743C9_var*
//#UC END# *52D00B00031A_86C02AC743C9_var*
begin
//#UC START# *52D00B00031A_86C02AC743C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_86C02AC743C9_impl*
end;//TkwEnMainMenuNewPbExpert.SetValuePrim

function TkwEnMainMenuNewPbExpert.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_86C02AC743C9_var*
//#UC END# *551544E2001A_86C02AC743C9_var*
begin
//#UC START# *551544E2001A_86C02AC743C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_86C02AC743C9_impl*
end;//TkwEnMainMenuNewPbExpert.GetResultTypeInfo

function TkwEnMainMenuNewPbExpert.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPbExpert.GetAllParamsCount

function TkwEnMainMenuNewPbExpert.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_86C02AC743C9_var*
//#UC END# *5617F4D00243_86C02AC743C9_var*
begin
//#UC START# *5617F4D00243_86C02AC743C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_86C02AC743C9_impl*
end;//TkwEnMainMenuNewPbExpert.ParamsTypes

function TkwEnMainMenuNewPnlOnLine.pnlOnLine(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuNew.pnlOnLine }
//#UC START# *1003C79CCFE0_D419C7FCFCA6_var*
//#UC END# *1003C79CCFE0_D419C7FCFCA6_var*
begin
//#UC START# *1003C79CCFE0_D419C7FCFCA6_impl*
 !!! Needs to be implemented !!!
//#UC END# *1003C79CCFE0_D419C7FCFCA6_impl*
end;//TkwEnMainMenuNewPnlOnLine.pnlOnLine

procedure TkwEnMainMenuNewPnlOnLine.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D419C7FCFCA6_var*
//#UC END# *4DAEEDE10285_D419C7FCFCA6_var*
begin
//#UC START# *4DAEEDE10285_D419C7FCFCA6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D419C7FCFCA6_impl*
end;//TkwEnMainMenuNewPnlOnLine.DoDoIt

class function TkwEnMainMenuNewPnlOnLine.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pnlOnLine';
end;//TkwEnMainMenuNewPnlOnLine.GetWordNameForRegister

procedure TkwEnMainMenuNewPnlOnLine.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_D419C7FCFCA6_var*
//#UC END# *52D00B00031A_D419C7FCFCA6_var*
begin
//#UC START# *52D00B00031A_D419C7FCFCA6_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_D419C7FCFCA6_impl*
end;//TkwEnMainMenuNewPnlOnLine.SetValuePrim

function TkwEnMainMenuNewPnlOnLine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D419C7FCFCA6_var*
//#UC END# *551544E2001A_D419C7FCFCA6_var*
begin
//#UC START# *551544E2001A_D419C7FCFCA6_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D419C7FCFCA6_impl*
end;//TkwEnMainMenuNewPnlOnLine.GetResultTypeInfo

function TkwEnMainMenuNewPnlOnLine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPnlOnLine.GetAllParamsCount

function TkwEnMainMenuNewPnlOnLine.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D419C7FCFCA6_var*
//#UC END# *5617F4D00243_D419C7FCFCA6_var*
begin
//#UC START# *5617F4D00243_D419C7FCFCA6_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D419C7FCFCA6_impl*
end;//TkwEnMainMenuNewPnlOnLine.ParamsTypes

function TkwEnMainMenuNewPbOnLine.pbOnLine(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
 {* Реализация слова скрипта .Ten_MainMenuNew.pbOnLine }
//#UC START# *8B540A5037CA_49BE6064B3BD_var*
//#UC END# *8B540A5037CA_49BE6064B3BD_var*
begin
//#UC START# *8B540A5037CA_49BE6064B3BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *8B540A5037CA_49BE6064B3BD_impl*
end;//TkwEnMainMenuNewPbOnLine.pbOnLine

procedure TkwEnMainMenuNewPbOnLine.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_49BE6064B3BD_var*
//#UC END# *4DAEEDE10285_49BE6064B3BD_var*
begin
//#UC START# *4DAEEDE10285_49BE6064B3BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_49BE6064B3BD_impl*
end;//TkwEnMainMenuNewPbOnLine.DoDoIt

class function TkwEnMainMenuNewPbOnLine.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pbOnLine';
end;//TkwEnMainMenuNewPbOnLine.GetWordNameForRegister

procedure TkwEnMainMenuNewPbOnLine.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_49BE6064B3BD_var*
//#UC END# *52D00B00031A_49BE6064B3BD_var*
begin
//#UC START# *52D00B00031A_49BE6064B3BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_49BE6064B3BD_impl*
end;//TkwEnMainMenuNewPbOnLine.SetValuePrim

function TkwEnMainMenuNewPbOnLine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_49BE6064B3BD_var*
//#UC END# *551544E2001A_49BE6064B3BD_var*
begin
//#UC START# *551544E2001A_49BE6064B3BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_49BE6064B3BD_impl*
end;//TkwEnMainMenuNewPbOnLine.GetResultTypeInfo

function TkwEnMainMenuNewPbOnLine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPbOnLine.GetAllParamsCount

function TkwEnMainMenuNewPbOnLine.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_49BE6064B3BD_var*
//#UC END# *5617F4D00243_49BE6064B3BD_var*
begin
//#UC START# *5617F4D00243_49BE6064B3BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_49BE6064B3BD_impl*
end;//TkwEnMainMenuNewPbOnLine.ParamsTypes

function TkwEnMainMenuNewPbIntranet.pbIntranet(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
 {* Реализация слова скрипта .Ten_MainMenuNew.pbIntranet }
//#UC START# *7EE27C8E9254_0A87C2239063_var*
//#UC END# *7EE27C8E9254_0A87C2239063_var*
begin
//#UC START# *7EE27C8E9254_0A87C2239063_impl*
 !!! Needs to be implemented !!!
//#UC END# *7EE27C8E9254_0A87C2239063_impl*
end;//TkwEnMainMenuNewPbIntranet.pbIntranet

procedure TkwEnMainMenuNewPbIntranet.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0A87C2239063_var*
//#UC END# *4DAEEDE10285_0A87C2239063_var*
begin
//#UC START# *4DAEEDE10285_0A87C2239063_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0A87C2239063_impl*
end;//TkwEnMainMenuNewPbIntranet.DoDoIt

class function TkwEnMainMenuNewPbIntranet.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pbIntranet';
end;//TkwEnMainMenuNewPbIntranet.GetWordNameForRegister

procedure TkwEnMainMenuNewPbIntranet.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_0A87C2239063_var*
//#UC END# *52D00B00031A_0A87C2239063_var*
begin
//#UC START# *52D00B00031A_0A87C2239063_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_0A87C2239063_impl*
end;//TkwEnMainMenuNewPbIntranet.SetValuePrim

function TkwEnMainMenuNewPbIntranet.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0A87C2239063_var*
//#UC END# *551544E2001A_0A87C2239063_var*
begin
//#UC START# *551544E2001A_0A87C2239063_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0A87C2239063_impl*
end;//TkwEnMainMenuNewPbIntranet.GetResultTypeInfo

function TkwEnMainMenuNewPbIntranet.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPbIntranet.GetAllParamsCount

function TkwEnMainMenuNewPbIntranet.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0A87C2239063_var*
//#UC END# *5617F4D00243_0A87C2239063_var*
begin
//#UC START# *5617F4D00243_0A87C2239063_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0A87C2239063_impl*
end;//TkwEnMainMenuNewPbIntranet.ParamsTypes

function TkwEnMainMenuNewPbCourtsOnline.pbCourtsOnline(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TPaintBox;
 {* Реализация слова скрипта .Ten_MainMenuNew.pbCourtsOnline }
//#UC START# *F3E47A6786D7_A993F8476345_var*
//#UC END# *F3E47A6786D7_A993F8476345_var*
begin
//#UC START# *F3E47A6786D7_A993F8476345_impl*
 !!! Needs to be implemented !!!
//#UC END# *F3E47A6786D7_A993F8476345_impl*
end;//TkwEnMainMenuNewPbCourtsOnline.pbCourtsOnline

procedure TkwEnMainMenuNewPbCourtsOnline.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A993F8476345_var*
//#UC END# *4DAEEDE10285_A993F8476345_var*
begin
//#UC START# *4DAEEDE10285_A993F8476345_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A993F8476345_impl*
end;//TkwEnMainMenuNewPbCourtsOnline.DoDoIt

class function TkwEnMainMenuNewPbCourtsOnline.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pbCourtsOnline';
end;//TkwEnMainMenuNewPbCourtsOnline.GetWordNameForRegister

procedure TkwEnMainMenuNewPbCourtsOnline.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_A993F8476345_var*
//#UC END# *52D00B00031A_A993F8476345_var*
begin
//#UC START# *52D00B00031A_A993F8476345_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_A993F8476345_impl*
end;//TkwEnMainMenuNewPbCourtsOnline.SetValuePrim

function TkwEnMainMenuNewPbCourtsOnline.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_A993F8476345_var*
//#UC END# *551544E2001A_A993F8476345_var*
begin
//#UC START# *551544E2001A_A993F8476345_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_A993F8476345_impl*
end;//TkwEnMainMenuNewPbCourtsOnline.GetResultTypeInfo

function TkwEnMainMenuNewPbCourtsOnline.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPbCourtsOnline.GetAllParamsCount

function TkwEnMainMenuNewPbCourtsOnline.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_A993F8476345_var*
//#UC END# *5617F4D00243_A993F8476345_var*
begin
//#UC START# *5617F4D00243_A993F8476345_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A993F8476345_impl*
end;//TkwEnMainMenuNewPbCourtsOnline.ParamsTypes

function TkwEnMainMenuNewHfTaxes.hfTaxes(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscHideField;
 {* Реализация слова скрипта .Ten_MainMenuNew.hfTaxes }
//#UC START# *86986D8FE51A_534F868AB68F_var*
//#UC END# *86986D8FE51A_534F868AB68F_var*
begin
//#UC START# *86986D8FE51A_534F868AB68F_impl*
 !!! Needs to be implemented !!!
//#UC END# *86986D8FE51A_534F868AB68F_impl*
end;//TkwEnMainMenuNewHfTaxes.hfTaxes

procedure TkwEnMainMenuNewHfTaxes.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_534F868AB68F_var*
//#UC END# *4DAEEDE10285_534F868AB68F_var*
begin
//#UC START# *4DAEEDE10285_534F868AB68F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_534F868AB68F_impl*
end;//TkwEnMainMenuNewHfTaxes.DoDoIt

class function TkwEnMainMenuNewHfTaxes.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.hfTaxes';
end;//TkwEnMainMenuNewHfTaxes.GetWordNameForRegister

procedure TkwEnMainMenuNewHfTaxes.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_534F868AB68F_var*
//#UC END# *52D00B00031A_534F868AB68F_var*
begin
//#UC START# *52D00B00031A_534F868AB68F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_534F868AB68F_impl*
end;//TkwEnMainMenuNewHfTaxes.SetValuePrim

function TkwEnMainMenuNewHfTaxes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_534F868AB68F_var*
//#UC END# *551544E2001A_534F868AB68F_var*
begin
//#UC START# *551544E2001A_534F868AB68F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_534F868AB68F_impl*
end;//TkwEnMainMenuNewHfTaxes.GetResultTypeInfo

function TkwEnMainMenuNewHfTaxes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewHfTaxes.GetAllParamsCount

function TkwEnMainMenuNewHfTaxes.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_534F868AB68F_var*
//#UC END# *5617F4D00243_534F868AB68F_var*
begin
//#UC START# *5617F4D00243_534F868AB68F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_534F868AB68F_impl*
end;//TkwEnMainMenuNewHfTaxes.ParamsTypes

function TkwEnMainMenuNewTvTaxes.tvTaxes(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscTreeViewHotTruck;
 {* Реализация слова скрипта .Ten_MainMenuNew.tvTaxes }
//#UC START# *0394519FA7EA_9BD9B91CACF0_var*
//#UC END# *0394519FA7EA_9BD9B91CACF0_var*
begin
//#UC START# *0394519FA7EA_9BD9B91CACF0_impl*
 !!! Needs to be implemented !!!
//#UC END# *0394519FA7EA_9BD9B91CACF0_impl*
end;//TkwEnMainMenuNewTvTaxes.tvTaxes

procedure TkwEnMainMenuNewTvTaxes.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9BD9B91CACF0_var*
//#UC END# *4DAEEDE10285_9BD9B91CACF0_var*
begin
//#UC START# *4DAEEDE10285_9BD9B91CACF0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9BD9B91CACF0_impl*
end;//TkwEnMainMenuNewTvTaxes.DoDoIt

class function TkwEnMainMenuNewTvTaxes.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.tvTaxes';
end;//TkwEnMainMenuNewTvTaxes.GetWordNameForRegister

procedure TkwEnMainMenuNewTvTaxes.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_9BD9B91CACF0_var*
//#UC END# *52D00B00031A_9BD9B91CACF0_var*
begin
//#UC START# *52D00B00031A_9BD9B91CACF0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_9BD9B91CACF0_impl*
end;//TkwEnMainMenuNewTvTaxes.SetValuePrim

function TkwEnMainMenuNewTvTaxes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_9BD9B91CACF0_var*
//#UC END# *551544E2001A_9BD9B91CACF0_var*
begin
//#UC START# *551544E2001A_9BD9B91CACF0_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_9BD9B91CACF0_impl*
end;//TkwEnMainMenuNewTvTaxes.GetResultTypeInfo

function TkwEnMainMenuNewTvTaxes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewTvTaxes.GetAllParamsCount

function TkwEnMainMenuNewTvTaxes.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_9BD9B91CACF0_var*
//#UC END# *5617F4D00243_9BD9B91CACF0_var*
begin
//#UC START# *5617F4D00243_9BD9B91CACF0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_9BD9B91CACF0_impl*
end;//TkwEnMainMenuNewTvTaxes.ParamsTypes

function TkwEnMainMenuNewPnlBanner.pnlBanner(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuNew.pnlBanner }
//#UC START# *37F88AEF6682_3F46F1F0A311_var*
//#UC END# *37F88AEF6682_3F46F1F0A311_var*
begin
//#UC START# *37F88AEF6682_3F46F1F0A311_impl*
 !!! Needs to be implemented !!!
//#UC END# *37F88AEF6682_3F46F1F0A311_impl*
end;//TkwEnMainMenuNewPnlBanner.pnlBanner

procedure TkwEnMainMenuNewPnlBanner.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3F46F1F0A311_var*
//#UC END# *4DAEEDE10285_3F46F1F0A311_var*
begin
//#UC START# *4DAEEDE10285_3F46F1F0A311_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3F46F1F0A311_impl*
end;//TkwEnMainMenuNewPnlBanner.DoDoIt

class function TkwEnMainMenuNewPnlBanner.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pnlBanner';
end;//TkwEnMainMenuNewPnlBanner.GetWordNameForRegister

procedure TkwEnMainMenuNewPnlBanner.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_3F46F1F0A311_var*
//#UC END# *52D00B00031A_3F46F1F0A311_var*
begin
//#UC START# *52D00B00031A_3F46F1F0A311_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_3F46F1F0A311_impl*
end;//TkwEnMainMenuNewPnlBanner.SetValuePrim

function TkwEnMainMenuNewPnlBanner.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_3F46F1F0A311_var*
//#UC END# *551544E2001A_3F46F1F0A311_var*
begin
//#UC START# *551544E2001A_3F46F1F0A311_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_3F46F1F0A311_impl*
end;//TkwEnMainMenuNewPnlBanner.GetResultTypeInfo

function TkwEnMainMenuNewPnlBanner.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPnlBanner.GetAllParamsCount

function TkwEnMainMenuNewPnlBanner.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_3F46F1F0A311_var*
//#UC END# *5617F4D00243_3F46F1F0A311_var*
begin
//#UC START# *5617F4D00243_3F46F1F0A311_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3F46F1F0A311_impl*
end;//TkwEnMainMenuNewPnlBanner.ParamsTypes

function TkwEnMainMenuNewIeBanner.ieBanner(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TImageEnView;
 {* Реализация слова скрипта .Ten_MainMenuNew.ieBanner }
//#UC START# *385E8544DC82_A6B4B101958D_var*
//#UC END# *385E8544DC82_A6B4B101958D_var*
begin
//#UC START# *385E8544DC82_A6B4B101958D_impl*
 !!! Needs to be implemented !!!
//#UC END# *385E8544DC82_A6B4B101958D_impl*
end;//TkwEnMainMenuNewIeBanner.ieBanner

procedure TkwEnMainMenuNewIeBanner.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A6B4B101958D_var*
//#UC END# *4DAEEDE10285_A6B4B101958D_var*
begin
//#UC START# *4DAEEDE10285_A6B4B101958D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A6B4B101958D_impl*
end;//TkwEnMainMenuNewIeBanner.DoDoIt

class function TkwEnMainMenuNewIeBanner.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.ieBanner';
end;//TkwEnMainMenuNewIeBanner.GetWordNameForRegister

procedure TkwEnMainMenuNewIeBanner.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_A6B4B101958D_var*
//#UC END# *52D00B00031A_A6B4B101958D_var*
begin
//#UC START# *52D00B00031A_A6B4B101958D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_A6B4B101958D_impl*
end;//TkwEnMainMenuNewIeBanner.SetValuePrim

function TkwEnMainMenuNewIeBanner.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_A6B4B101958D_var*
//#UC END# *551544E2001A_A6B4B101958D_var*
begin
//#UC START# *551544E2001A_A6B4B101958D_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_A6B4B101958D_impl*
end;//TkwEnMainMenuNewIeBanner.GetResultTypeInfo

function TkwEnMainMenuNewIeBanner.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewIeBanner.GetAllParamsCount

function TkwEnMainMenuNewIeBanner.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_A6B4B101958D_var*
//#UC END# *5617F4D00243_A6B4B101958D_var*
begin
//#UC START# *5617F4D00243_A6B4B101958D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A6B4B101958D_impl*
end;//TkwEnMainMenuNewIeBanner.ParamsTypes

function TkwEnMainMenuNewHfLastOpenDocsRightEdge.hfLastOpenDocsRightEdge(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuNew.hfLastOpenDocsRightEdge }
//#UC START# *63CD1E59E54A_134990BEA7A4_var*
//#UC END# *63CD1E59E54A_134990BEA7A4_var*
begin
//#UC START# *63CD1E59E54A_134990BEA7A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *63CD1E59E54A_134990BEA7A4_impl*
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.hfLastOpenDocsRightEdge

procedure TkwEnMainMenuNewHfLastOpenDocsRightEdge.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_134990BEA7A4_var*
//#UC END# *4DAEEDE10285_134990BEA7A4_var*
begin
//#UC START# *4DAEEDE10285_134990BEA7A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_134990BEA7A4_impl*
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.DoDoIt

class function TkwEnMainMenuNewHfLastOpenDocsRightEdge.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.hfLastOpenDocsRightEdge';
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.GetWordNameForRegister

procedure TkwEnMainMenuNewHfLastOpenDocsRightEdge.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_134990BEA7A4_var*
//#UC END# *52D00B00031A_134990BEA7A4_var*
begin
//#UC START# *52D00B00031A_134990BEA7A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_134990BEA7A4_impl*
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.SetValuePrim

function TkwEnMainMenuNewHfLastOpenDocsRightEdge.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_134990BEA7A4_var*
//#UC END# *551544E2001A_134990BEA7A4_var*
begin
//#UC START# *551544E2001A_134990BEA7A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_134990BEA7A4_impl*
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.GetResultTypeInfo

function TkwEnMainMenuNewHfLastOpenDocsRightEdge.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.GetAllParamsCount

function TkwEnMainMenuNewHfLastOpenDocsRightEdge.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_134990BEA7A4_var*
//#UC END# *5617F4D00243_134990BEA7A4_var*
begin
//#UC START# *5617F4D00243_134990BEA7A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_134990BEA7A4_impl*
end;//TkwEnMainMenuNewHfLastOpenDocsRightEdge.ParamsTypes

function TkwEnMainMenuNewIeIO.ieIO(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TImageEnIO;
 {* Реализация слова скрипта .Ten_MainMenuNew.ieIO }
//#UC START# *73E85A05F176_034E50E6C286_var*
//#UC END# *73E85A05F176_034E50E6C286_var*
begin
//#UC START# *73E85A05F176_034E50E6C286_impl*
 !!! Needs to be implemented !!!
//#UC END# *73E85A05F176_034E50E6C286_impl*
end;//TkwEnMainMenuNewIeIO.ieIO

procedure TkwEnMainMenuNewIeIO.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_034E50E6C286_var*
//#UC END# *4DAEEDE10285_034E50E6C286_var*
begin
//#UC START# *4DAEEDE10285_034E50E6C286_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_034E50E6C286_impl*
end;//TkwEnMainMenuNewIeIO.DoDoIt

class function TkwEnMainMenuNewIeIO.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.ieIO';
end;//TkwEnMainMenuNewIeIO.GetWordNameForRegister

procedure TkwEnMainMenuNewIeIO.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_034E50E6C286_var*
//#UC END# *52D00B00031A_034E50E6C286_var*
begin
//#UC START# *52D00B00031A_034E50E6C286_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_034E50E6C286_impl*
end;//TkwEnMainMenuNewIeIO.SetValuePrim

function TkwEnMainMenuNewIeIO.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_034E50E6C286_var*
//#UC END# *551544E2001A_034E50E6C286_var*
begin
//#UC START# *551544E2001A_034E50E6C286_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_034E50E6C286_impl*
end;//TkwEnMainMenuNewIeIO.GetResultTypeInfo

function TkwEnMainMenuNewIeIO.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewIeIO.GetAllParamsCount

function TkwEnMainMenuNewIeIO.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_034E50E6C286_var*
//#UC END# *5617F4D00243_034E50E6C286_var*
begin
//#UC START# *5617F4D00243_034E50E6C286_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_034E50E6C286_impl*
end;//TkwEnMainMenuNewIeIO.ParamsTypes

function TkwEnMainMenuNewHfReferences.hfReferences(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscHideField;
 {* Реализация слова скрипта .Ten_MainMenuNew.hfReferences }
//#UC START# *6E8215817852_4709A2EA77C1_var*
//#UC END# *6E8215817852_4709A2EA77C1_var*
begin
//#UC START# *6E8215817852_4709A2EA77C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *6E8215817852_4709A2EA77C1_impl*
end;//TkwEnMainMenuNewHfReferences.hfReferences

procedure TkwEnMainMenuNewHfReferences.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4709A2EA77C1_var*
//#UC END# *4DAEEDE10285_4709A2EA77C1_var*
begin
//#UC START# *4DAEEDE10285_4709A2EA77C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4709A2EA77C1_impl*
end;//TkwEnMainMenuNewHfReferences.DoDoIt

class function TkwEnMainMenuNewHfReferences.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.hfReferences';
end;//TkwEnMainMenuNewHfReferences.GetWordNameForRegister

procedure TkwEnMainMenuNewHfReferences.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_4709A2EA77C1_var*
//#UC END# *52D00B00031A_4709A2EA77C1_var*
begin
//#UC START# *52D00B00031A_4709A2EA77C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_4709A2EA77C1_impl*
end;//TkwEnMainMenuNewHfReferences.SetValuePrim

function TkwEnMainMenuNewHfReferences.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4709A2EA77C1_var*
//#UC END# *551544E2001A_4709A2EA77C1_var*
begin
//#UC START# *551544E2001A_4709A2EA77C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_4709A2EA77C1_impl*
end;//TkwEnMainMenuNewHfReferences.GetResultTypeInfo

function TkwEnMainMenuNewHfReferences.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewHfReferences.GetAllParamsCount

function TkwEnMainMenuNewHfReferences.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_4709A2EA77C1_var*
//#UC END# *5617F4D00243_4709A2EA77C1_var*
begin
//#UC START# *5617F4D00243_4709A2EA77C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4709A2EA77C1_impl*
end;//TkwEnMainMenuNewHfReferences.ParamsTypes

function TkwEnMainMenuNewTvReferences.tvReferences(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscTreeViewHotTruck;
 {* Реализация слова скрипта .Ten_MainMenuNew.tvReferences }
//#UC START# *E59EF43361A6_FC8F183F2522_var*
//#UC END# *E59EF43361A6_FC8F183F2522_var*
begin
//#UC START# *E59EF43361A6_FC8F183F2522_impl*
 !!! Needs to be implemented !!!
//#UC END# *E59EF43361A6_FC8F183F2522_impl*
end;//TkwEnMainMenuNewTvReferences.tvReferences

procedure TkwEnMainMenuNewTvReferences.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FC8F183F2522_var*
//#UC END# *4DAEEDE10285_FC8F183F2522_var*
begin
//#UC START# *4DAEEDE10285_FC8F183F2522_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FC8F183F2522_impl*
end;//TkwEnMainMenuNewTvReferences.DoDoIt

class function TkwEnMainMenuNewTvReferences.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.tvReferences';
end;//TkwEnMainMenuNewTvReferences.GetWordNameForRegister

procedure TkwEnMainMenuNewTvReferences.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_FC8F183F2522_var*
//#UC END# *52D00B00031A_FC8F183F2522_var*
begin
//#UC START# *52D00B00031A_FC8F183F2522_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_FC8F183F2522_impl*
end;//TkwEnMainMenuNewTvReferences.SetValuePrim

function TkwEnMainMenuNewTvReferences.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_FC8F183F2522_var*
//#UC END# *551544E2001A_FC8F183F2522_var*
begin
//#UC START# *551544E2001A_FC8F183F2522_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_FC8F183F2522_impl*
end;//TkwEnMainMenuNewTvReferences.GetResultTypeInfo

function TkwEnMainMenuNewTvReferences.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewTvReferences.GetAllParamsCount

function TkwEnMainMenuNewTvReferences.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_FC8F183F2522_var*
//#UC END# *5617F4D00243_FC8F183F2522_var*
begin
//#UC START# *5617F4D00243_FC8F183F2522_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_FC8F183F2522_impl*
end;//TkwEnMainMenuNewTvReferences.ParamsTypes

function TkwEnMainMenuNewHfLawNews.hfLawNews(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscHideField;
 {* Реализация слова скрипта .Ten_MainMenuNew.hfLawNews }
//#UC START# *4F48BF5AE0B5_E2AD37F05605_var*
//#UC END# *4F48BF5AE0B5_E2AD37F05605_var*
begin
//#UC START# *4F48BF5AE0B5_E2AD37F05605_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F48BF5AE0B5_E2AD37F05605_impl*
end;//TkwEnMainMenuNewHfLawNews.hfLawNews

procedure TkwEnMainMenuNewHfLawNews.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E2AD37F05605_var*
//#UC END# *4DAEEDE10285_E2AD37F05605_var*
begin
//#UC START# *4DAEEDE10285_E2AD37F05605_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E2AD37F05605_impl*
end;//TkwEnMainMenuNewHfLawNews.DoDoIt

class function TkwEnMainMenuNewHfLawNews.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.hfLawNews';
end;//TkwEnMainMenuNewHfLawNews.GetWordNameForRegister

procedure TkwEnMainMenuNewHfLawNews.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E2AD37F05605_var*
//#UC END# *52D00B00031A_E2AD37F05605_var*
begin
//#UC START# *52D00B00031A_E2AD37F05605_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E2AD37F05605_impl*
end;//TkwEnMainMenuNewHfLawNews.SetValuePrim

function TkwEnMainMenuNewHfLawNews.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E2AD37F05605_var*
//#UC END# *551544E2001A_E2AD37F05605_var*
begin
//#UC START# *551544E2001A_E2AD37F05605_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E2AD37F05605_impl*
end;//TkwEnMainMenuNewHfLawNews.GetResultTypeInfo

function TkwEnMainMenuNewHfLawNews.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewHfLawNews.GetAllParamsCount

function TkwEnMainMenuNewHfLawNews.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E2AD37F05605_var*
//#UC END# *5617F4D00243_E2AD37F05605_var*
begin
//#UC START# *5617F4D00243_E2AD37F05605_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E2AD37F05605_impl*
end;//TkwEnMainMenuNewHfLawNews.ParamsTypes

function TkwEnMainMenuNewTvLawNews.tvLawNews(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscTreeViewHotTruck;
 {* Реализация слова скрипта .Ten_MainMenuNew.tvLawNews }
//#UC START# *A1896A6FC372_91D5686CB0B7_var*
//#UC END# *A1896A6FC372_91D5686CB0B7_var*
begin
//#UC START# *A1896A6FC372_91D5686CB0B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *A1896A6FC372_91D5686CB0B7_impl*
end;//TkwEnMainMenuNewTvLawNews.tvLawNews

procedure TkwEnMainMenuNewTvLawNews.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_91D5686CB0B7_var*
//#UC END# *4DAEEDE10285_91D5686CB0B7_var*
begin
//#UC START# *4DAEEDE10285_91D5686CB0B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_91D5686CB0B7_impl*
end;//TkwEnMainMenuNewTvLawNews.DoDoIt

class function TkwEnMainMenuNewTvLawNews.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.tvLawNews';
end;//TkwEnMainMenuNewTvLawNews.GetWordNameForRegister

procedure TkwEnMainMenuNewTvLawNews.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_91D5686CB0B7_var*
//#UC END# *52D00B00031A_91D5686CB0B7_var*
begin
//#UC START# *52D00B00031A_91D5686CB0B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_91D5686CB0B7_impl*
end;//TkwEnMainMenuNewTvLawNews.SetValuePrim

function TkwEnMainMenuNewTvLawNews.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_91D5686CB0B7_var*
//#UC END# *551544E2001A_91D5686CB0B7_var*
begin
//#UC START# *551544E2001A_91D5686CB0B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_91D5686CB0B7_impl*
end;//TkwEnMainMenuNewTvLawNews.GetResultTypeInfo

function TkwEnMainMenuNewTvLawNews.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewTvLawNews.GetAllParamsCount

function TkwEnMainMenuNewTvLawNews.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_91D5686CB0B7_var*
//#UC END# *5617F4D00243_91D5686CB0B7_var*
begin
//#UC START# *5617F4D00243_91D5686CB0B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_91D5686CB0B7_impl*
end;//TkwEnMainMenuNewTvLawNews.ParamsTypes

function TkwEnMainMenuNewPnlMain.pnlMain(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuNew.pnlMain }
//#UC START# *4B06EA39CA64_660CB551C1D7_var*
//#UC END# *4B06EA39CA64_660CB551C1D7_var*
begin
//#UC START# *4B06EA39CA64_660CB551C1D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B06EA39CA64_660CB551C1D7_impl*
end;//TkwEnMainMenuNewPnlMain.pnlMain

procedure TkwEnMainMenuNewPnlMain.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_660CB551C1D7_var*
//#UC END# *4DAEEDE10285_660CB551C1D7_var*
begin
//#UC START# *4DAEEDE10285_660CB551C1D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_660CB551C1D7_impl*
end;//TkwEnMainMenuNewPnlMain.DoDoIt

class function TkwEnMainMenuNewPnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.pnlMain';
end;//TkwEnMainMenuNewPnlMain.GetWordNameForRegister

procedure TkwEnMainMenuNewPnlMain.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_660CB551C1D7_var*
//#UC END# *52D00B00031A_660CB551C1D7_var*
begin
//#UC START# *52D00B00031A_660CB551C1D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_660CB551C1D7_impl*
end;//TkwEnMainMenuNewPnlMain.SetValuePrim

function TkwEnMainMenuNewPnlMain.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_660CB551C1D7_var*
//#UC END# *551544E2001A_660CB551C1D7_var*
begin
//#UC START# *551544E2001A_660CB551C1D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_660CB551C1D7_impl*
end;//TkwEnMainMenuNewPnlMain.GetResultTypeInfo

function TkwEnMainMenuNewPnlMain.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewPnlMain.GetAllParamsCount

function TkwEnMainMenuNewPnlMain.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_660CB551C1D7_var*
//#UC END# *5617F4D00243_660CB551C1D7_var*
begin
//#UC START# *5617F4D00243_660CB551C1D7_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_660CB551C1D7_impl*
end;//TkwEnMainMenuNewPnlMain.ParamsTypes

function TkwEnMainMenuNewHfLastOpenDocs.hfLastOpenDocs(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscHideField;
 {* Реализация слова скрипта .Ten_MainMenuNew.hfLastOpenDocs }
//#UC START# *F1370C44C9AD_F53122A8A951_var*
//#UC END# *F1370C44C9AD_F53122A8A951_var*
begin
//#UC START# *F1370C44C9AD_F53122A8A951_impl*
 !!! Needs to be implemented !!!
//#UC END# *F1370C44C9AD_F53122A8A951_impl*
end;//TkwEnMainMenuNewHfLastOpenDocs.hfLastOpenDocs

procedure TkwEnMainMenuNewHfLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F53122A8A951_var*
//#UC END# *4DAEEDE10285_F53122A8A951_var*
begin
//#UC START# *4DAEEDE10285_F53122A8A951_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F53122A8A951_impl*
end;//TkwEnMainMenuNewHfLastOpenDocs.DoDoIt

class function TkwEnMainMenuNewHfLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.hfLastOpenDocs';
end;//TkwEnMainMenuNewHfLastOpenDocs.GetWordNameForRegister

procedure TkwEnMainMenuNewHfLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_F53122A8A951_var*
//#UC END# *52D00B00031A_F53122A8A951_var*
begin
//#UC START# *52D00B00031A_F53122A8A951_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_F53122A8A951_impl*
end;//TkwEnMainMenuNewHfLastOpenDocs.SetValuePrim

function TkwEnMainMenuNewHfLastOpenDocs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F53122A8A951_var*
//#UC END# *551544E2001A_F53122A8A951_var*
begin
//#UC START# *551544E2001A_F53122A8A951_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F53122A8A951_impl*
end;//TkwEnMainMenuNewHfLastOpenDocs.GetResultTypeInfo

function TkwEnMainMenuNewHfLastOpenDocs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewHfLastOpenDocs.GetAllParamsCount

function TkwEnMainMenuNewHfLastOpenDocs.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F53122A8A951_var*
//#UC END# *5617F4D00243_F53122A8A951_var*
begin
//#UC START# *5617F4D00243_F53122A8A951_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F53122A8A951_impl*
end;//TkwEnMainMenuNewHfLastOpenDocs.ParamsTypes

function TkwEnMainMenuNewTvLastOpenDocs.tvLastOpenDocs(const aCtx: TtfwContext;
 aen_MainMenuNew: Ten_MainMenuNew): TnscTreeViewHotTruck;
 {* Реализация слова скрипта .Ten_MainMenuNew.tvLastOpenDocs }
//#UC START# *C76C1C009E14_3E87A671A6AA_var*
//#UC END# *C76C1C009E14_3E87A671A6AA_var*
begin
//#UC START# *C76C1C009E14_3E87A671A6AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *C76C1C009E14_3E87A671A6AA_impl*
end;//TkwEnMainMenuNewTvLastOpenDocs.tvLastOpenDocs

procedure TkwEnMainMenuNewTvLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3E87A671A6AA_var*
//#UC END# *4DAEEDE10285_3E87A671A6AA_var*
begin
//#UC START# *4DAEEDE10285_3E87A671A6AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3E87A671A6AA_impl*
end;//TkwEnMainMenuNewTvLastOpenDocs.DoDoIt

class function TkwEnMainMenuNewTvLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuNew.tvLastOpenDocs';
end;//TkwEnMainMenuNewTvLastOpenDocs.GetWordNameForRegister

procedure TkwEnMainMenuNewTvLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_3E87A671A6AA_var*
//#UC END# *52D00B00031A_3E87A671A6AA_var*
begin
//#UC START# *52D00B00031A_3E87A671A6AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_3E87A671A6AA_impl*
end;//TkwEnMainMenuNewTvLastOpenDocs.SetValuePrim

function TkwEnMainMenuNewTvLastOpenDocs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_3E87A671A6AA_var*
//#UC END# *551544E2001A_3E87A671A6AA_var*
begin
//#UC START# *551544E2001A_3E87A671A6AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_3E87A671A6AA_impl*
end;//TkwEnMainMenuNewTvLastOpenDocs.GetResultTypeInfo

function TkwEnMainMenuNewTvLastOpenDocs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuNewTvLastOpenDocs.GetAllParamsCount

function TkwEnMainMenuNewTvLastOpenDocs.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_3E87A671A6AA_var*
//#UC END# *5617F4D00243_3E87A671A6AA_var*
begin
//#UC START# *5617F4D00243_3E87A671A6AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3E87A671A6AA_impl*
end;//TkwEnMainMenuNewTvLastOpenDocs.ParamsTypes

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
