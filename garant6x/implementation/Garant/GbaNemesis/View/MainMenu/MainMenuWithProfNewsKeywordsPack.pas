unit MainMenuWithProfNewsKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы MainMenuWithProfNews }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\MainMenuWithProfNewsKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "MainMenuWithProfNewsKeywordsPack" MUID: (483B68B1ABBB)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtPanel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoImageEn)}
 , imageenview
 {$IfEnd} // NOT Defined(NoImageEn)
 {$If Defined(Nemesis)}
 , nscHideField
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTreeViewHotTruck
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscFocusLabel
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoImageEn)}
 , imageenio
 {$IfEnd} // NOT Defined(NoImageEn)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , MainMenuWithProfNews_Form
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
 Tkw_Form_MainMenuWithProfNews = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы MainMenuWithProfNews
----
*Пример использования*:
[code]
'aControl' форма::MainMenuWithProfNews TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_MainMenuWithProfNews

 Tkw_MainMenuWithProfNews_Control_pnlLeft = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlLeft
----
*Пример использования*:
[code]
контрол::pnlLeft TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlLeft

 Tkw_MainMenuWithProfNews_Control_pnlLeft_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlLeft
----
*Пример использования*:
[code]
контрол::pnlLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlLeft_Push

 Tkw_MainMenuWithProfNews_Control_bvlLeftTop = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола bvlLeftTop
----
*Пример использования*:
[code]
контрол::bvlLeftTop TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_bvlLeftTop

 Tkw_MainMenuWithProfNews_Control_bvlLeftTop_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола bvlLeftTop
----
*Пример использования*:
[code]
контрол::bvlLeftTop:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_bvlLeftTop_Push

 Tkw_MainMenuWithProfNews_Control_pbLogo = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Control_pbLogo

 Tkw_MainMenuWithProfNews_Control_pbLogo_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pbLogo
----
*Пример использования*:
[code]
контрол::pbLogo:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pbLogo_Push

 Tkw_MainMenuWithProfNews_Control_ieBanner = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Control_ieBanner

 Tkw_MainMenuWithProfNews_Control_ieBanner_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ieBanner
----
*Пример использования*:
[code]
контрол::ieBanner:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_ieBanner_Push

 Tkw_MainMenuWithProfNews_Control_pbCourtsOnline = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Control_pbCourtsOnline

 Tkw_MainMenuWithProfNews_Control_pbCourtsOnline_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pbCourtsOnline
----
*Пример использования*:
[code]
контрол::pbCourtsOnline:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pbCourtsOnline_Push

 Tkw_MainMenuWithProfNews_Control_pbIntranet = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Control_pbIntranet

 Tkw_MainMenuWithProfNews_Control_pbIntranet_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pbIntranet
----
*Пример использования*:
[code]
контрол::pbIntranet:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pbIntranet_Push

 Tkw_MainMenuWithProfNews_Control_pbOnline = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pbOnline
----
*Пример использования*:
[code]
контрол::pbOnline TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pbOnline

 Tkw_MainMenuWithProfNews_Control_pbOnline_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pbOnline
----
*Пример использования*:
[code]
контрол::pbOnline:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pbOnline_Push

 Tkw_MainMenuWithProfNews_Control_pnlClient = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlClient
----
*Пример использования*:
[code]
контрол::pnlClient TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlClient

 Tkw_MainMenuWithProfNews_Control_pnlClient_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlClient
----
*Пример использования*:
[code]
контрол::pnlClient:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlClient_Push

 Tkw_MainMenuWithProfNews_Control_pnlNews = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlNews
----
*Пример использования*:
[code]
контрол::pnlNews TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlNews

 Tkw_MainMenuWithProfNews_Control_pnlNews_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlNews
----
*Пример использования*:
[code]
контрол::pnlNews:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlNews_Push

 Tkw_MainMenuWithProfNews_Control_hfProfNews = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола hfProfNews
----
*Пример использования*:
[code]
контрол::hfProfNews TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_hfProfNews

 Tkw_MainMenuWithProfNews_Control_hfProfNews_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола hfProfNews
----
*Пример использования*:
[code]
контрол::hfProfNews:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_hfProfNews_Push

 Tkw_MainMenuWithProfNews_Control_tvProfNews = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvProfNews
----
*Пример использования*:
[code]
контрол::tvProfNews TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_tvProfNews

 Tkw_MainMenuWithProfNews_Control_tvProfNews_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола tvProfNews
----
*Пример использования*:
[code]
контрол::tvProfNews:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_tvProfNews_Push

 Tkw_MainMenuWithProfNews_Control_pnlBaseSearch = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearch

 Tkw_MainMenuWithProfNews_Control_pnlBaseSearch_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlBaseSearch
----
*Пример использования*:
[code]
контрол::pnlBaseSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearch_Push

 Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone

 Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlBaseSearchZone
----
*Пример использования*:
[code]
контрол::pnlBaseSearchZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone_Push

 Tkw_MainMenuWithProfNews_Control_pnlSearches = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Control_pnlSearches

 Tkw_MainMenuWithProfNews_Control_pnlSearches_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlSearches
----
*Пример использования*:
[code]
контрол::pnlSearches:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlSearches_Push

 Tkw_MainMenuWithProfNews_Control_flAttributeSearch = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Control_flAttributeSearch

 Tkw_MainMenuWithProfNews_Control_flAttributeSearch_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола flAttributeSearch
----
*Пример использования*:
[code]
контрол::flAttributeSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_flAttributeSearch_Push

 Tkw_MainMenuWithProfNews_Control_flDictionSearch = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Control_flDictionSearch

 Tkw_MainMenuWithProfNews_Control_flDictionSearch_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола flDictionSearch
----
*Пример использования*:
[code]
контрол::flDictionSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_flDictionSearch_Push

 Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch

 Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола flPublishedSourceSearch
----
*Пример использования*:
[code]
контрол::flPublishedSourceSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch_Push

 Tkw_MainMenuWithProfNews_Control_flSituationSearch = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Control_flSituationSearch

 Tkw_MainMenuWithProfNews_Control_flSituationSearch_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола flSituationSearch
----
*Пример использования*:
[code]
контрол::flSituationSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_flSituationSearch_Push

 Tkw_MainMenuWithProfNews_Control_pnlTrees = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlTrees
----
*Пример использования*:
[code]
контрол::pnlTrees TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlTrees

 Tkw_MainMenuWithProfNews_Control_pnlTrees_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlTrees
----
*Пример использования*:
[code]
контрол::pnlTrees:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlTrees_Push

 Tkw_MainMenuWithProfNews_Control_hfTaxes = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Control_hfTaxes

 Tkw_MainMenuWithProfNews_Control_hfTaxes_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола hfTaxes
----
*Пример использования*:
[code]
контрол::hfTaxes:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_hfTaxes_Push

 Tkw_MainMenuWithProfNews_Control_tvTaxes = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Control_tvTaxes

 Tkw_MainMenuWithProfNews_Control_tvTaxes_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола tvTaxes
----
*Пример использования*:
[code]
контрол::tvTaxes:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_tvTaxes_Push

 Tkw_MainMenuWithProfNews_Control_bvlLeft = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола bvlLeft
----
*Пример использования*:
[code]
контрол::bvlLeft TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_bvlLeft

 Tkw_MainMenuWithProfNews_Control_bvlLeft_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола bvlLeft
----
*Пример использования*:
[code]
контрол::bvlLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_bvlLeft_Push

 Tkw_MainMenuWithProfNews_Control_bvlRight = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола bvlRight
----
*Пример использования*:
[code]
контрол::bvlRight TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_bvlRight

 Tkw_MainMenuWithProfNews_Control_bvlRight_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола bvlRight
----
*Пример использования*:
[code]
контрол::bvlRight:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_bvlRight_Push

 Tkw_MainMenuWithProfNews_Component_ieIO = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Component_ieIO

 Tkw_MainMenuWithProfNews_Control_hfReferences = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Control_hfReferences

 Tkw_MainMenuWithProfNews_Control_hfReferences_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола hfReferences
----
*Пример использования*:
[code]
контрол::hfReferences:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_hfReferences_Push

 Tkw_MainMenuWithProfNews_Control_tvReferences = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Control_tvReferences

 Tkw_MainMenuWithProfNews_Control_tvReferences_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола tvReferences
----
*Пример использования*:
[code]
контрол::tvReferences:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_tvReferences_Push

 Tkw_MainMenuWithProfNews_Control_hfLawNews = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Control_hfLawNews

 Tkw_MainMenuWithProfNews_Control_hfLawNews_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола hfLawNews
----
*Пример использования*:
[code]
контрол::hfLawNews:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_hfLawNews_Push

 Tkw_MainMenuWithProfNews_Control_tvLawNews = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Control_tvLawNews

 Tkw_MainMenuWithProfNews_Control_tvLawNews_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола tvLawNews
----
*Пример использования*:
[code]
контрол::tvLawNews:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_tvLawNews_Push

 Tkw_MainMenuWithProfNews_Control_pnlMain = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Control_pnlMain

 Tkw_MainMenuWithProfNews_Control_pnlMain_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlMain
----
*Пример использования*:
[code]
контрол::pnlMain:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlMain_Push

 Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs

 Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола hfLastOpenDocs
----
*Пример использования*:
[code]
контрол::hfLastOpenDocs:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push

 Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs = {final} class(TtfwControlString)
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
 end;//Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs

 Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола tvLastOpenDocs
----
*Пример использования*:
[code]
контрол::tvLastOpenDocs:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push

 TkwEnMainMenuWithProfNewsPnlLeft = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.pnlLeft
[panel]Контрол pnlLeft формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.pnlLeft >>> l_TvtPanel
[code]  }
  private
   function pnlLeft(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pnlLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsPnlLeft

 TkwEnMainMenuWithProfNewsBvlLeftTop = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.bvlLeftTop
[panel]Контрол bvlLeftTop формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TBevel
*Пример:*
[code]
OBJECT VAR l_TBevel
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.bvlLeftTop >>> l_TBevel
[code]  }
  private
   function bvlLeftTop(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TBevel;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.bvlLeftTop }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsBvlLeftTop

 TkwEnMainMenuWithProfNewsPbLogo = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.pbLogo
[panel]Контрол pbLogo формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.pbLogo >>> l_TPaintBox
[code]  }
  private
   function pbLogo(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TPaintBox;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pbLogo }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsPbLogo

 TkwEnMainMenuWithProfNewsIeBanner = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.ieBanner
[panel]Контрол ieBanner формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TImageEnView
*Пример:*
[code]
OBJECT VAR l_TImageEnView
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.ieBanner >>> l_TImageEnView
[code]  }
  private
   function ieBanner(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TImageEnView;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.ieBanner }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsIeBanner

 TkwEnMainMenuWithProfNewsPbCourtsOnline = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.pbCourtsOnline
[panel]Контрол pbCourtsOnline формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.pbCourtsOnline >>> l_TPaintBox
[code]  }
  private
   function pbCourtsOnline(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TPaintBox;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pbCourtsOnline }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsPbCourtsOnline

 TkwEnMainMenuWithProfNewsPbIntranet = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.pbIntranet
[panel]Контрол pbIntranet формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.pbIntranet >>> l_TPaintBox
[code]  }
  private
   function pbIntranet(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TPaintBox;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pbIntranet }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsPbIntranet

 TkwEnMainMenuWithProfNewsPbOnline = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.pbOnline
[panel]Контрол pbOnline формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.pbOnline >>> l_TPaintBox
[code]  }
  private
   function pbOnline(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TPaintBox;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pbOnline }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsPbOnline

 TkwEnMainMenuWithProfNewsPnlClient = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.pnlClient
[panel]Контрол pnlClient формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.pnlClient >>> l_TvtPanel
[code]  }
  private
   function pnlClient(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pnlClient }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsPnlClient

 TkwEnMainMenuWithProfNewsPnlNews = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.pnlNews
[panel]Контрол pnlNews формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.pnlNews >>> l_TvtPanel
[code]  }
  private
   function pnlNews(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pnlNews }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsPnlNews

 TkwEnMainMenuWithProfNewsHfProfNews = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.hfProfNews
[panel]Контрол hfProfNews формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TnscHideField
*Пример:*
[code]
OBJECT VAR l_TnscHideField
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.hfProfNews >>> l_TnscHideField
[code]  }
  private
   function hfProfNews(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscHideField;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.hfProfNews }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsHfProfNews

 TkwEnMainMenuWithProfNewsTvProfNews = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.tvProfNews
[panel]Контрол tvProfNews формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TnscTreeViewHotTruck
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.tvProfNews >>> l_TnscTreeViewHotTruck
[code]  }
  private
   function tvProfNews(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.tvProfNews }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsTvProfNews

 TkwEnMainMenuWithProfNewsPnlBaseSearch = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.pnlBaseSearch
[panel]Контрол pnlBaseSearch формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.pnlBaseSearch >>> l_TvtPanel
[code]  }
  private
   function pnlBaseSearch(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pnlBaseSearch }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsPnlBaseSearch

 TkwEnMainMenuWithProfNewsPnlBaseSearchZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.pnlBaseSearchZone
[panel]Контрол pnlBaseSearchZone формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.pnlBaseSearchZone >>> l_TvtPanel
[code]  }
  private
   function pnlBaseSearchZone(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pnlBaseSearchZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsPnlBaseSearchZone

 TkwEnMainMenuWithProfNewsPnlSearches = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.pnlSearches
[panel]Контрол pnlSearches формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.pnlSearches >>> l_TvtPanel
[code]  }
  private
   function pnlSearches(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pnlSearches }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsPnlSearches

 TkwEnMainMenuWithProfNewsFlAttributeSearch = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.flAttributeSearch
[panel]Контрол flAttributeSearch формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TnscFocusLabel
*Пример:*
[code]
OBJECT VAR l_TnscFocusLabel
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.flAttributeSearch >>> l_TnscFocusLabel
[code]  }
  private
   function flAttributeSearch(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscFocusLabel;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.flAttributeSearch }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsFlAttributeSearch

 TkwEnMainMenuWithProfNewsFlDictionSearch = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.flDictionSearch
[panel]Контрол flDictionSearch формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TnscFocusLabel
*Пример:*
[code]
OBJECT VAR l_TnscFocusLabel
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.flDictionSearch >>> l_TnscFocusLabel
[code]  }
  private
   function flDictionSearch(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscFocusLabel;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.flDictionSearch }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsFlDictionSearch

 TkwEnMainMenuWithProfNewsFlPublishedSourceSearch = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.flPublishedSourceSearch
[panel]Контрол flPublishedSourceSearch формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TnscFocusLabel
*Пример:*
[code]
OBJECT VAR l_TnscFocusLabel
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.flPublishedSourceSearch >>> l_TnscFocusLabel
[code]  }
  private
   function flPublishedSourceSearch(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscFocusLabel;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.flPublishedSourceSearch }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsFlPublishedSourceSearch

 TkwEnMainMenuWithProfNewsFlSituationSearch = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.flSituationSearch
[panel]Контрол flSituationSearch формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TnscFocusLabel
*Пример:*
[code]
OBJECT VAR l_TnscFocusLabel
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.flSituationSearch >>> l_TnscFocusLabel
[code]  }
  private
   function flSituationSearch(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscFocusLabel;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.flSituationSearch }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsFlSituationSearch

 TkwEnMainMenuWithProfNewsPnlTrees = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.pnlTrees
[panel]Контрол pnlTrees формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.pnlTrees >>> l_TvtPanel
[code]  }
  private
   function pnlTrees(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pnlTrees }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsPnlTrees

 TkwEnMainMenuWithProfNewsHfTaxes = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.hfTaxes
[panel]Контрол hfTaxes формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TnscHideField
*Пример:*
[code]
OBJECT VAR l_TnscHideField
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.hfTaxes >>> l_TnscHideField
[code]  }
  private
   function hfTaxes(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscHideField;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.hfTaxes }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsHfTaxes

 TkwEnMainMenuWithProfNewsTvTaxes = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.tvTaxes
[panel]Контрол tvTaxes формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TnscTreeViewHotTruck
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.tvTaxes >>> l_TnscTreeViewHotTruck
[code]  }
  private
   function tvTaxes(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.tvTaxes }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsTvTaxes

 TkwEnMainMenuWithProfNewsBvlLeft = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.bvlLeft
[panel]Контрол bvlLeft формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TBevel
*Пример:*
[code]
OBJECT VAR l_TBevel
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.bvlLeft >>> l_TBevel
[code]  }
  private
   function bvlLeft(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TBevel;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.bvlLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsBvlLeft

 TkwEnMainMenuWithProfNewsBvlRight = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.bvlRight
[panel]Контрол bvlRight формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TBevel
*Пример:*
[code]
OBJECT VAR l_TBevel
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.bvlRight >>> l_TBevel
[code]  }
  private
   function bvlRight(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TBevel;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.bvlRight }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsBvlRight

 TkwEnMainMenuWithProfNewsIeIO = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.ieIO
[panel]Контрол ieIO формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TImageEnIO
*Пример:*
[code]
OBJECT VAR l_TImageEnIO
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.ieIO >>> l_TImageEnIO
[code]  }
  private
   function ieIO(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TImageEnIO;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.ieIO }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsIeIO

 TkwEnMainMenuWithProfNewsHfReferences = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.hfReferences
[panel]Контрол hfReferences формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TnscHideField
*Пример:*
[code]
OBJECT VAR l_TnscHideField
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.hfReferences >>> l_TnscHideField
[code]  }
  private
   function hfReferences(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscHideField;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.hfReferences }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsHfReferences

 TkwEnMainMenuWithProfNewsTvReferences = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.tvReferences
[panel]Контрол tvReferences формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TnscTreeViewHotTruck
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.tvReferences >>> l_TnscTreeViewHotTruck
[code]  }
  private
   function tvReferences(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.tvReferences }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsTvReferences

 TkwEnMainMenuWithProfNewsHfLawNews = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.hfLawNews
[panel]Контрол hfLawNews формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TnscHideField
*Пример:*
[code]
OBJECT VAR l_TnscHideField
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.hfLawNews >>> l_TnscHideField
[code]  }
  private
   function hfLawNews(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscHideField;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.hfLawNews }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsHfLawNews

 TkwEnMainMenuWithProfNewsTvLawNews = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.tvLawNews
[panel]Контрол tvLawNews формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TnscTreeViewHotTruck
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.tvLawNews >>> l_TnscTreeViewHotTruck
[code]  }
  private
   function tvLawNews(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.tvLawNews }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsTvLawNews

 TkwEnMainMenuWithProfNewsPnlMain = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.pnlMain
[panel]Контрол pnlMain формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.pnlMain >>> l_TvtPanel
[code]  }
  private
   function pnlMain(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pnlMain }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsPnlMain

 TkwEnMainMenuWithProfNewsHfLastOpenDocs = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.hfLastOpenDocs
[panel]Контрол hfLastOpenDocs формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TnscHideField
*Пример:*
[code]
OBJECT VAR l_TnscHideField
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.hfLastOpenDocs >>> l_TnscHideField
[code]  }
  private
   function hfLastOpenDocs(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscHideField;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.hfLastOpenDocs }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsHfLastOpenDocs

 TkwEnMainMenuWithProfNewsTvLastOpenDocs = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MainMenuWithProfNews.tvLastOpenDocs
[panel]Контрол tvLastOpenDocs формы Ten_MainMenuWithProfNews[panel]
*Тип результата:* TnscTreeViewHotTruck
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aen_MainMenuWithProfNews .Ten_MainMenuWithProfNews.tvLastOpenDocs >>> l_TnscTreeViewHotTruck
[code]  }
  private
   function tvLastOpenDocs(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
    {* Реализация слова скрипта .Ten_MainMenuWithProfNews.tvLastOpenDocs }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMainMenuWithProfNewsTvLastOpenDocs

function Tkw_Form_MainMenuWithProfNews.GetString: AnsiString;
begin
 Result := 'en_MainMenuWithProfNews';
end;//Tkw_Form_MainMenuWithProfNews.GetString

class function Tkw_Form_MainMenuWithProfNews.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::MainMenuWithProfNews';
end;//Tkw_Form_MainMenuWithProfNews.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pnlLeft.GetString: AnsiString;
begin
 Result := 'pnlLeft';
end;//Tkw_MainMenuWithProfNews_Control_pnlLeft.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pnlLeft.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuWithProfNews_Control_pnlLeft.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pnlLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlLeft';
end;//Tkw_MainMenuWithProfNews_Control_pnlLeft.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlLeft_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlLeft');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlLeft_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlLeft:push';
end;//Tkw_MainMenuWithProfNews_Control_pnlLeft_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_bvlLeftTop.GetString: AnsiString;
begin
 Result := 'bvlLeftTop';
end;//Tkw_MainMenuWithProfNews_Control_bvlLeftTop.GetString

class procedure Tkw_MainMenuWithProfNews_Control_bvlLeftTop.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TBevel);
end;//Tkw_MainMenuWithProfNews_Control_bvlLeftTop.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_bvlLeftTop.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::bvlLeftTop';
end;//Tkw_MainMenuWithProfNews_Control_bvlLeftTop.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_bvlLeftTop_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('bvlLeftTop');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_bvlLeftTop_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_bvlLeftTop_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::bvlLeftTop:push';
end;//Tkw_MainMenuWithProfNews_Control_bvlLeftTop_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pbLogo.GetString: AnsiString;
begin
 Result := 'pbLogo';
end;//Tkw_MainMenuWithProfNews_Control_pbLogo.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pbLogo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_MainMenuWithProfNews_Control_pbLogo.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pbLogo.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbLogo';
end;//Tkw_MainMenuWithProfNews_Control_pbLogo.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pbLogo_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbLogo');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pbLogo_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pbLogo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbLogo:push';
end;//Tkw_MainMenuWithProfNews_Control_pbLogo_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_ieBanner.GetString: AnsiString;
begin
 Result := 'ieBanner';
end;//Tkw_MainMenuWithProfNews_Control_ieBanner.GetString

class procedure Tkw_MainMenuWithProfNews_Control_ieBanner.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TImageEnView);
end;//Tkw_MainMenuWithProfNews_Control_ieBanner.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_ieBanner.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ieBanner';
end;//Tkw_MainMenuWithProfNews_Control_ieBanner.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_ieBanner_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ieBanner');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_ieBanner_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_ieBanner_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ieBanner:push';
end;//Tkw_MainMenuWithProfNews_Control_ieBanner_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pbCourtsOnline.GetString: AnsiString;
begin
 Result := 'pbCourtsOnline';
end;//Tkw_MainMenuWithProfNews_Control_pbCourtsOnline.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pbCourtsOnline.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_MainMenuWithProfNews_Control_pbCourtsOnline.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pbCourtsOnline.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbCourtsOnline';
end;//Tkw_MainMenuWithProfNews_Control_pbCourtsOnline.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pbCourtsOnline_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbCourtsOnline');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pbCourtsOnline_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pbCourtsOnline_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbCourtsOnline:push';
end;//Tkw_MainMenuWithProfNews_Control_pbCourtsOnline_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pbIntranet.GetString: AnsiString;
begin
 Result := 'pbIntranet';
end;//Tkw_MainMenuWithProfNews_Control_pbIntranet.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pbIntranet.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_MainMenuWithProfNews_Control_pbIntranet.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pbIntranet.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbIntranet';
end;//Tkw_MainMenuWithProfNews_Control_pbIntranet.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pbIntranet_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbIntranet');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pbIntranet_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pbIntranet_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbIntranet:push';
end;//Tkw_MainMenuWithProfNews_Control_pbIntranet_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pbOnline.GetString: AnsiString;
begin
 Result := 'pbOnline';
end;//Tkw_MainMenuWithProfNews_Control_pbOnline.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pbOnline.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_MainMenuWithProfNews_Control_pbOnline.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pbOnline.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbOnline';
end;//Tkw_MainMenuWithProfNews_Control_pbOnline.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pbOnline_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbOnline');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pbOnline_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pbOnline_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbOnline:push';
end;//Tkw_MainMenuWithProfNews_Control_pbOnline_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pnlClient.GetString: AnsiString;
begin
 Result := 'pnlClient';
end;//Tkw_MainMenuWithProfNews_Control_pnlClient.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pnlClient.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuWithProfNews_Control_pnlClient.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pnlClient.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlClient';
end;//Tkw_MainMenuWithProfNews_Control_pnlClient.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlClient_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlClient');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlClient_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlClient_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlClient:push';
end;//Tkw_MainMenuWithProfNews_Control_pnlClient_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pnlNews.GetString: AnsiString;
begin
 Result := 'pnlNews';
end;//Tkw_MainMenuWithProfNews_Control_pnlNews.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pnlNews.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuWithProfNews_Control_pnlNews.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pnlNews.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlNews';
end;//Tkw_MainMenuWithProfNews_Control_pnlNews.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlNews_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlNews');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlNews_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlNews_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlNews:push';
end;//Tkw_MainMenuWithProfNews_Control_pnlNews_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_hfProfNews.GetString: AnsiString;
begin
 Result := 'hfProfNews';
end;//Tkw_MainMenuWithProfNews_Control_hfProfNews.GetString

class procedure Tkw_MainMenuWithProfNews_Control_hfProfNews.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MainMenuWithProfNews_Control_hfProfNews.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_hfProfNews.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfProfNews';
end;//Tkw_MainMenuWithProfNews_Control_hfProfNews.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_hfProfNews_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfProfNews');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_hfProfNews_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_hfProfNews_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfProfNews:push';
end;//Tkw_MainMenuWithProfNews_Control_hfProfNews_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_tvProfNews.GetString: AnsiString;
begin
 Result := 'tvProfNews';
end;//Tkw_MainMenuWithProfNews_Control_tvProfNews.GetString

class procedure Tkw_MainMenuWithProfNews_Control_tvProfNews.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_MainMenuWithProfNews_Control_tvProfNews.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_tvProfNews.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvProfNews';
end;//Tkw_MainMenuWithProfNews_Control_tvProfNews.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_tvProfNews_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvProfNews');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_tvProfNews_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_tvProfNews_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvProfNews:push';
end;//Tkw_MainMenuWithProfNews_Control_tvProfNews_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pnlBaseSearch.GetString: AnsiString;
begin
 Result := 'pnlBaseSearch';
end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearch.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pnlBaseSearch.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearch.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pnlBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBaseSearch';
end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearch.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlBaseSearch_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlBaseSearch');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearch_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlBaseSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBaseSearch:push';
end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearch_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone.GetString: AnsiString;
begin
 Result := 'pnlBaseSearchZone';
end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBaseSearchZone';
end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlBaseSearchZone');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBaseSearchZone:push';
end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pnlSearches.GetString: AnsiString;
begin
 Result := 'pnlSearches';
end;//Tkw_MainMenuWithProfNews_Control_pnlSearches.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pnlSearches.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuWithProfNews_Control_pnlSearches.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pnlSearches.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlSearches';
end;//Tkw_MainMenuWithProfNews_Control_pnlSearches.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlSearches_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlSearches');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlSearches_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlSearches_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlSearches:push';
end;//Tkw_MainMenuWithProfNews_Control_pnlSearches_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_flAttributeSearch.GetString: AnsiString;
begin
 Result := 'flAttributeSearch';
end;//Tkw_MainMenuWithProfNews_Control_flAttributeSearch.GetString

class procedure Tkw_MainMenuWithProfNews_Control_flAttributeSearch.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscFocusLabel);
end;//Tkw_MainMenuWithProfNews_Control_flAttributeSearch.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_flAttributeSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flAttributeSearch';
end;//Tkw_MainMenuWithProfNews_Control_flAttributeSearch.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_flAttributeSearch_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('flAttributeSearch');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_flAttributeSearch_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_flAttributeSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flAttributeSearch:push';
end;//Tkw_MainMenuWithProfNews_Control_flAttributeSearch_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_flDictionSearch.GetString: AnsiString;
begin
 Result := 'flDictionSearch';
end;//Tkw_MainMenuWithProfNews_Control_flDictionSearch.GetString

class procedure Tkw_MainMenuWithProfNews_Control_flDictionSearch.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscFocusLabel);
end;//Tkw_MainMenuWithProfNews_Control_flDictionSearch.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_flDictionSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flDictionSearch';
end;//Tkw_MainMenuWithProfNews_Control_flDictionSearch.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_flDictionSearch_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('flDictionSearch');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_flDictionSearch_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_flDictionSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flDictionSearch:push';
end;//Tkw_MainMenuWithProfNews_Control_flDictionSearch_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch.GetString: AnsiString;
begin
 Result := 'flPublishedSourceSearch';
end;//Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch.GetString

class procedure Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscFocusLabel);
end;//Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flPublishedSourceSearch';
end;//Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('flPublishedSourceSearch');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flPublishedSourceSearch:push';
end;//Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_flSituationSearch.GetString: AnsiString;
begin
 Result := 'flSituationSearch';
end;//Tkw_MainMenuWithProfNews_Control_flSituationSearch.GetString

class procedure Tkw_MainMenuWithProfNews_Control_flSituationSearch.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscFocusLabel);
end;//Tkw_MainMenuWithProfNews_Control_flSituationSearch.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_flSituationSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flSituationSearch';
end;//Tkw_MainMenuWithProfNews_Control_flSituationSearch.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_flSituationSearch_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('flSituationSearch');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_flSituationSearch_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_flSituationSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::flSituationSearch:push';
end;//Tkw_MainMenuWithProfNews_Control_flSituationSearch_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pnlTrees.GetString: AnsiString;
begin
 Result := 'pnlTrees';
end;//Tkw_MainMenuWithProfNews_Control_pnlTrees.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pnlTrees.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuWithProfNews_Control_pnlTrees.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pnlTrees.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlTrees';
end;//Tkw_MainMenuWithProfNews_Control_pnlTrees.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlTrees_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlTrees');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlTrees_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlTrees_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlTrees:push';
end;//Tkw_MainMenuWithProfNews_Control_pnlTrees_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_hfTaxes.GetString: AnsiString;
begin
 Result := 'hfTaxes';
end;//Tkw_MainMenuWithProfNews_Control_hfTaxes.GetString

class procedure Tkw_MainMenuWithProfNews_Control_hfTaxes.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MainMenuWithProfNews_Control_hfTaxes.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_hfTaxes.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfTaxes';
end;//Tkw_MainMenuWithProfNews_Control_hfTaxes.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_hfTaxes_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfTaxes');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_hfTaxes_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_hfTaxes_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfTaxes:push';
end;//Tkw_MainMenuWithProfNews_Control_hfTaxes_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_tvTaxes.GetString: AnsiString;
begin
 Result := 'tvTaxes';
end;//Tkw_MainMenuWithProfNews_Control_tvTaxes.GetString

class procedure Tkw_MainMenuWithProfNews_Control_tvTaxes.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_MainMenuWithProfNews_Control_tvTaxes.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_tvTaxes.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvTaxes';
end;//Tkw_MainMenuWithProfNews_Control_tvTaxes.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_tvTaxes_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvTaxes');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_tvTaxes_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_tvTaxes_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvTaxes:push';
end;//Tkw_MainMenuWithProfNews_Control_tvTaxes_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_bvlLeft.GetString: AnsiString;
begin
 Result := 'bvlLeft';
end;//Tkw_MainMenuWithProfNews_Control_bvlLeft.GetString

class procedure Tkw_MainMenuWithProfNews_Control_bvlLeft.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TBevel);
end;//Tkw_MainMenuWithProfNews_Control_bvlLeft.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_bvlLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::bvlLeft';
end;//Tkw_MainMenuWithProfNews_Control_bvlLeft.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_bvlLeft_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('bvlLeft');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_bvlLeft_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_bvlLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::bvlLeft:push';
end;//Tkw_MainMenuWithProfNews_Control_bvlLeft_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_bvlRight.GetString: AnsiString;
begin
 Result := 'bvlRight';
end;//Tkw_MainMenuWithProfNews_Control_bvlRight.GetString

class procedure Tkw_MainMenuWithProfNews_Control_bvlRight.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TBevel);
end;//Tkw_MainMenuWithProfNews_Control_bvlRight.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_bvlRight.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::bvlRight';
end;//Tkw_MainMenuWithProfNews_Control_bvlRight.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_bvlRight_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('bvlRight');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_bvlRight_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_bvlRight_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::bvlRight:push';
end;//Tkw_MainMenuWithProfNews_Control_bvlRight_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Component_ieIO.GetString: AnsiString;
begin
 Result := 'ieIO';
end;//Tkw_MainMenuWithProfNews_Component_ieIO.GetString

class procedure Tkw_MainMenuWithProfNews_Component_ieIO.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TImageEnIO);
end;//Tkw_MainMenuWithProfNews_Component_ieIO.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Component_ieIO.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::ieIO';
end;//Tkw_MainMenuWithProfNews_Component_ieIO.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_hfReferences.GetString: AnsiString;
begin
 Result := 'hfReferences';
end;//Tkw_MainMenuWithProfNews_Control_hfReferences.GetString

class procedure Tkw_MainMenuWithProfNews_Control_hfReferences.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MainMenuWithProfNews_Control_hfReferences.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_hfReferences.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfReferences';
end;//Tkw_MainMenuWithProfNews_Control_hfReferences.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_hfReferences_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfReferences');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_hfReferences_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_hfReferences_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfReferences:push';
end;//Tkw_MainMenuWithProfNews_Control_hfReferences_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_tvReferences.GetString: AnsiString;
begin
 Result := 'tvReferences';
end;//Tkw_MainMenuWithProfNews_Control_tvReferences.GetString

class procedure Tkw_MainMenuWithProfNews_Control_tvReferences.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_MainMenuWithProfNews_Control_tvReferences.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_tvReferences.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvReferences';
end;//Tkw_MainMenuWithProfNews_Control_tvReferences.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_tvReferences_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvReferences');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_tvReferences_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_tvReferences_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvReferences:push';
end;//Tkw_MainMenuWithProfNews_Control_tvReferences_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_hfLawNews.GetString: AnsiString;
begin
 Result := 'hfLawNews';
end;//Tkw_MainMenuWithProfNews_Control_hfLawNews.GetString

class procedure Tkw_MainMenuWithProfNews_Control_hfLawNews.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MainMenuWithProfNews_Control_hfLawNews.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_hfLawNews.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfLawNews';
end;//Tkw_MainMenuWithProfNews_Control_hfLawNews.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_hfLawNews_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfLawNews');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_hfLawNews_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_hfLawNews_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfLawNews:push';
end;//Tkw_MainMenuWithProfNews_Control_hfLawNews_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_tvLawNews.GetString: AnsiString;
begin
 Result := 'tvLawNews';
end;//Tkw_MainMenuWithProfNews_Control_tvLawNews.GetString

class procedure Tkw_MainMenuWithProfNews_Control_tvLawNews.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_MainMenuWithProfNews_Control_tvLawNews.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_tvLawNews.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvLawNews';
end;//Tkw_MainMenuWithProfNews_Control_tvLawNews.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_tvLawNews_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvLawNews');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_tvLawNews_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_tvLawNews_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvLawNews:push';
end;//Tkw_MainMenuWithProfNews_Control_tvLawNews_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pnlMain.GetString: AnsiString;
begin
 Result := 'pnlMain';
end;//Tkw_MainMenuWithProfNews_Control_pnlMain.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pnlMain.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuWithProfNews_Control_pnlMain.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlMain';
end;//Tkw_MainMenuWithProfNews_Control_pnlMain.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlMain_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlMain');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlMain_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlMain_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlMain:push';
end;//Tkw_MainMenuWithProfNews_Control_pnlMain_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs.GetString: AnsiString;
begin
 Result := 'hfLastOpenDocs';
end;//Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs.GetString

class procedure Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscHideField);
end;//Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfLastOpenDocs';
end;//Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfLastOpenDocs');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::hfLastOpenDocs:push';
end;//Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs.GetString: AnsiString;
begin
 Result := 'tvLastOpenDocs';
end;//Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs.GetString

class procedure Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvLastOpenDocs';
end;//Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvLastOpenDocs');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvLastOpenDocs:push';
end;//Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPnlLeft.pnlLeft(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pnlLeft }
begin
 Result := aen_MainMenuWithProfNews.pnlLeft;
end;//TkwEnMainMenuWithProfNewsPnlLeft.pnlLeft

procedure TkwEnMainMenuWithProfNewsPnlLeft.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlLeft(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlLeft.DoDoIt

procedure TkwEnMainMenuWithProfNewsPnlLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlLeft', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlLeft.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuWithProfNewsPnlLeft.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPnlLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPnlLeft.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPnlLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPnlLeft.ParamsTypes

class function TkwEnMainMenuWithProfNewsPnlLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlLeft';
end;//TkwEnMainMenuWithProfNewsPnlLeft.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsBvlLeftTop.bvlLeftTop(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TBevel;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.bvlLeftTop }
begin
 Result := aen_MainMenuWithProfNews.bvlLeftTop;
end;//TkwEnMainMenuWithProfNewsBvlLeftTop.bvlLeftTop

procedure TkwEnMainMenuWithProfNewsBvlLeftTop.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(bvlLeftTop(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsBvlLeftTop.DoDoIt

procedure TkwEnMainMenuWithProfNewsBvlLeftTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству bvlLeftTop', aCtx);
end;//TkwEnMainMenuWithProfNewsBvlLeftTop.SetValuePrim

function TkwEnMainMenuWithProfNewsBvlLeftTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TBevel);
end;//TkwEnMainMenuWithProfNewsBvlLeftTop.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsBvlLeftTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsBvlLeftTop.GetAllParamsCount

function TkwEnMainMenuWithProfNewsBvlLeftTop.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsBvlLeftTop.ParamsTypes

class function TkwEnMainMenuWithProfNewsBvlLeftTop.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.bvlLeftTop';
end;//TkwEnMainMenuWithProfNewsBvlLeftTop.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPbLogo.pbLogo(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TPaintBox;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pbLogo }
begin
 Result := aen_MainMenuWithProfNews.pbLogo;
end;//TkwEnMainMenuWithProfNewsPbLogo.pbLogo

procedure TkwEnMainMenuWithProfNewsPbLogo.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbLogo(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPbLogo.DoDoIt

procedure TkwEnMainMenuWithProfNewsPbLogo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pbLogo', aCtx);
end;//TkwEnMainMenuWithProfNewsPbLogo.SetValuePrim

function TkwEnMainMenuWithProfNewsPbLogo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnMainMenuWithProfNewsPbLogo.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPbLogo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPbLogo.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPbLogo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPbLogo.ParamsTypes

class function TkwEnMainMenuWithProfNewsPbLogo.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pbLogo';
end;//TkwEnMainMenuWithProfNewsPbLogo.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsIeBanner.ieBanner(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TImageEnView;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.ieBanner }
begin
 Result := aen_MainMenuWithProfNews.ieBanner;
end;//TkwEnMainMenuWithProfNewsIeBanner.ieBanner

procedure TkwEnMainMenuWithProfNewsIeBanner.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ieBanner(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsIeBanner.DoDoIt

procedure TkwEnMainMenuWithProfNewsIeBanner.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ieBanner', aCtx);
end;//TkwEnMainMenuWithProfNewsIeBanner.SetValuePrim

function TkwEnMainMenuWithProfNewsIeBanner.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TImageEnView);
end;//TkwEnMainMenuWithProfNewsIeBanner.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsIeBanner.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsIeBanner.GetAllParamsCount

function TkwEnMainMenuWithProfNewsIeBanner.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsIeBanner.ParamsTypes

class function TkwEnMainMenuWithProfNewsIeBanner.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.ieBanner';
end;//TkwEnMainMenuWithProfNewsIeBanner.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPbCourtsOnline.pbCourtsOnline(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TPaintBox;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pbCourtsOnline }
begin
 Result := aen_MainMenuWithProfNews.pbCourtsOnline;
end;//TkwEnMainMenuWithProfNewsPbCourtsOnline.pbCourtsOnline

procedure TkwEnMainMenuWithProfNewsPbCourtsOnline.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbCourtsOnline(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPbCourtsOnline.DoDoIt

procedure TkwEnMainMenuWithProfNewsPbCourtsOnline.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pbCourtsOnline', aCtx);
end;//TkwEnMainMenuWithProfNewsPbCourtsOnline.SetValuePrim

function TkwEnMainMenuWithProfNewsPbCourtsOnline.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnMainMenuWithProfNewsPbCourtsOnline.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPbCourtsOnline.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPbCourtsOnline.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPbCourtsOnline.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPbCourtsOnline.ParamsTypes

class function TkwEnMainMenuWithProfNewsPbCourtsOnline.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pbCourtsOnline';
end;//TkwEnMainMenuWithProfNewsPbCourtsOnline.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPbIntranet.pbIntranet(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TPaintBox;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pbIntranet }
begin
 Result := aen_MainMenuWithProfNews.pbIntranet;
end;//TkwEnMainMenuWithProfNewsPbIntranet.pbIntranet

procedure TkwEnMainMenuWithProfNewsPbIntranet.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbIntranet(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPbIntranet.DoDoIt

procedure TkwEnMainMenuWithProfNewsPbIntranet.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pbIntranet', aCtx);
end;//TkwEnMainMenuWithProfNewsPbIntranet.SetValuePrim

function TkwEnMainMenuWithProfNewsPbIntranet.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnMainMenuWithProfNewsPbIntranet.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPbIntranet.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPbIntranet.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPbIntranet.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPbIntranet.ParamsTypes

class function TkwEnMainMenuWithProfNewsPbIntranet.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pbIntranet';
end;//TkwEnMainMenuWithProfNewsPbIntranet.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPbOnline.pbOnline(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TPaintBox;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pbOnline }
begin
 Result := aen_MainMenuWithProfNews.pbOnline;
end;//TkwEnMainMenuWithProfNewsPbOnline.pbOnline

procedure TkwEnMainMenuWithProfNewsPbOnline.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbOnline(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPbOnline.DoDoIt

procedure TkwEnMainMenuWithProfNewsPbOnline.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pbOnline', aCtx);
end;//TkwEnMainMenuWithProfNewsPbOnline.SetValuePrim

function TkwEnMainMenuWithProfNewsPbOnline.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnMainMenuWithProfNewsPbOnline.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPbOnline.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPbOnline.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPbOnline.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPbOnline.ParamsTypes

class function TkwEnMainMenuWithProfNewsPbOnline.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pbOnline';
end;//TkwEnMainMenuWithProfNewsPbOnline.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPnlClient.pnlClient(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pnlClient }
begin
 Result := aen_MainMenuWithProfNews.pnlClient;
end;//TkwEnMainMenuWithProfNewsPnlClient.pnlClient

procedure TkwEnMainMenuWithProfNewsPnlClient.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlClient(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlClient.DoDoIt

procedure TkwEnMainMenuWithProfNewsPnlClient.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlClient', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlClient.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlClient.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuWithProfNewsPnlClient.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPnlClient.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPnlClient.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPnlClient.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPnlClient.ParamsTypes

class function TkwEnMainMenuWithProfNewsPnlClient.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlClient';
end;//TkwEnMainMenuWithProfNewsPnlClient.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPnlNews.pnlNews(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pnlNews }
begin
 Result := aen_MainMenuWithProfNews.pnlNews;
end;//TkwEnMainMenuWithProfNewsPnlNews.pnlNews

procedure TkwEnMainMenuWithProfNewsPnlNews.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlNews(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlNews.DoDoIt

procedure TkwEnMainMenuWithProfNewsPnlNews.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlNews', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlNews.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlNews.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuWithProfNewsPnlNews.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPnlNews.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPnlNews.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPnlNews.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPnlNews.ParamsTypes

class function TkwEnMainMenuWithProfNewsPnlNews.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlNews';
end;//TkwEnMainMenuWithProfNewsPnlNews.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsHfProfNews.hfProfNews(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscHideField;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.hfProfNews }
begin
 Result := aen_MainMenuWithProfNews.hfProfNews;
end;//TkwEnMainMenuWithProfNewsHfProfNews.hfProfNews

procedure TkwEnMainMenuWithProfNewsHfProfNews.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfProfNews(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsHfProfNews.DoDoIt

procedure TkwEnMainMenuWithProfNewsHfProfNews.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству hfProfNews', aCtx);
end;//TkwEnMainMenuWithProfNewsHfProfNews.SetValuePrim

function TkwEnMainMenuWithProfNewsHfProfNews.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMainMenuWithProfNewsHfProfNews.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsHfProfNews.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsHfProfNews.GetAllParamsCount

function TkwEnMainMenuWithProfNewsHfProfNews.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsHfProfNews.ParamsTypes

class function TkwEnMainMenuWithProfNewsHfProfNews.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.hfProfNews';
end;//TkwEnMainMenuWithProfNewsHfProfNews.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsTvProfNews.tvProfNews(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.tvProfNews }
begin
 Result := aen_MainMenuWithProfNews.tvProfNews;
end;//TkwEnMainMenuWithProfNewsTvProfNews.tvProfNews

procedure TkwEnMainMenuWithProfNewsTvProfNews.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvProfNews(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsTvProfNews.DoDoIt

procedure TkwEnMainMenuWithProfNewsTvProfNews.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvProfNews', aCtx);
end;//TkwEnMainMenuWithProfNewsTvProfNews.SetValuePrim

function TkwEnMainMenuWithProfNewsTvProfNews.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEnMainMenuWithProfNewsTvProfNews.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsTvProfNews.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsTvProfNews.GetAllParamsCount

function TkwEnMainMenuWithProfNewsTvProfNews.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsTvProfNews.ParamsTypes

class function TkwEnMainMenuWithProfNewsTvProfNews.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.tvProfNews';
end;//TkwEnMainMenuWithProfNewsTvProfNews.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPnlBaseSearch.pnlBaseSearch(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pnlBaseSearch }
begin
 Result := aen_MainMenuWithProfNews.pnlBaseSearch;
end;//TkwEnMainMenuWithProfNewsPnlBaseSearch.pnlBaseSearch

procedure TkwEnMainMenuWithProfNewsPnlBaseSearch.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlBaseSearch(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlBaseSearch.DoDoIt

procedure TkwEnMainMenuWithProfNewsPnlBaseSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlBaseSearch', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlBaseSearch.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlBaseSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuWithProfNewsPnlBaseSearch.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPnlBaseSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPnlBaseSearch.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPnlBaseSearch.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPnlBaseSearch.ParamsTypes

class function TkwEnMainMenuWithProfNewsPnlBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlBaseSearch';
end;//TkwEnMainMenuWithProfNewsPnlBaseSearch.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPnlBaseSearchZone.pnlBaseSearchZone(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pnlBaseSearchZone }
begin
 Result := aen_MainMenuWithProfNews.pnlBaseSearchZone;
end;//TkwEnMainMenuWithProfNewsPnlBaseSearchZone.pnlBaseSearchZone

procedure TkwEnMainMenuWithProfNewsPnlBaseSearchZone.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlBaseSearchZone(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlBaseSearchZone.DoDoIt

procedure TkwEnMainMenuWithProfNewsPnlBaseSearchZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlBaseSearchZone', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlBaseSearchZone.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlBaseSearchZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuWithProfNewsPnlBaseSearchZone.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPnlBaseSearchZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPnlBaseSearchZone.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPnlBaseSearchZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPnlBaseSearchZone.ParamsTypes

class function TkwEnMainMenuWithProfNewsPnlBaseSearchZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlBaseSearchZone';
end;//TkwEnMainMenuWithProfNewsPnlBaseSearchZone.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPnlSearches.pnlSearches(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pnlSearches }
begin
 Result := aen_MainMenuWithProfNews.pnlSearches;
end;//TkwEnMainMenuWithProfNewsPnlSearches.pnlSearches

procedure TkwEnMainMenuWithProfNewsPnlSearches.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlSearches(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlSearches.DoDoIt

procedure TkwEnMainMenuWithProfNewsPnlSearches.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlSearches', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlSearches.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlSearches.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuWithProfNewsPnlSearches.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPnlSearches.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPnlSearches.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPnlSearches.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPnlSearches.ParamsTypes

class function TkwEnMainMenuWithProfNewsPnlSearches.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlSearches';
end;//TkwEnMainMenuWithProfNewsPnlSearches.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsFlAttributeSearch.flAttributeSearch(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscFocusLabel;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.flAttributeSearch }
begin
 Result := aen_MainMenuWithProfNews.flAttributeSearch;
end;//TkwEnMainMenuWithProfNewsFlAttributeSearch.flAttributeSearch

procedure TkwEnMainMenuWithProfNewsFlAttributeSearch.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(flAttributeSearch(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsFlAttributeSearch.DoDoIt

procedure TkwEnMainMenuWithProfNewsFlAttributeSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству flAttributeSearch', aCtx);
end;//TkwEnMainMenuWithProfNewsFlAttributeSearch.SetValuePrim

function TkwEnMainMenuWithProfNewsFlAttributeSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscFocusLabel);
end;//TkwEnMainMenuWithProfNewsFlAttributeSearch.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsFlAttributeSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsFlAttributeSearch.GetAllParamsCount

function TkwEnMainMenuWithProfNewsFlAttributeSearch.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsFlAttributeSearch.ParamsTypes

class function TkwEnMainMenuWithProfNewsFlAttributeSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.flAttributeSearch';
end;//TkwEnMainMenuWithProfNewsFlAttributeSearch.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsFlDictionSearch.flDictionSearch(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscFocusLabel;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.flDictionSearch }
begin
 Result := aen_MainMenuWithProfNews.flDictionSearch;
end;//TkwEnMainMenuWithProfNewsFlDictionSearch.flDictionSearch

procedure TkwEnMainMenuWithProfNewsFlDictionSearch.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(flDictionSearch(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsFlDictionSearch.DoDoIt

procedure TkwEnMainMenuWithProfNewsFlDictionSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству flDictionSearch', aCtx);
end;//TkwEnMainMenuWithProfNewsFlDictionSearch.SetValuePrim

function TkwEnMainMenuWithProfNewsFlDictionSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscFocusLabel);
end;//TkwEnMainMenuWithProfNewsFlDictionSearch.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsFlDictionSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsFlDictionSearch.GetAllParamsCount

function TkwEnMainMenuWithProfNewsFlDictionSearch.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsFlDictionSearch.ParamsTypes

class function TkwEnMainMenuWithProfNewsFlDictionSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.flDictionSearch';
end;//TkwEnMainMenuWithProfNewsFlDictionSearch.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.flPublishedSourceSearch(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscFocusLabel;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.flPublishedSourceSearch }
begin
 Result := aen_MainMenuWithProfNews.flPublishedSourceSearch;
end;//TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.flPublishedSourceSearch

procedure TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(flPublishedSourceSearch(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.DoDoIt

procedure TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству flPublishedSourceSearch', aCtx);
end;//TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.SetValuePrim

function TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscFocusLabel);
end;//TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.GetAllParamsCount

function TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.ParamsTypes

class function TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.flPublishedSourceSearch';
end;//TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsFlSituationSearch.flSituationSearch(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscFocusLabel;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.flSituationSearch }
begin
 Result := aen_MainMenuWithProfNews.flSituationSearch;
end;//TkwEnMainMenuWithProfNewsFlSituationSearch.flSituationSearch

procedure TkwEnMainMenuWithProfNewsFlSituationSearch.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(flSituationSearch(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsFlSituationSearch.DoDoIt

procedure TkwEnMainMenuWithProfNewsFlSituationSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству flSituationSearch', aCtx);
end;//TkwEnMainMenuWithProfNewsFlSituationSearch.SetValuePrim

function TkwEnMainMenuWithProfNewsFlSituationSearch.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscFocusLabel);
end;//TkwEnMainMenuWithProfNewsFlSituationSearch.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsFlSituationSearch.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsFlSituationSearch.GetAllParamsCount

function TkwEnMainMenuWithProfNewsFlSituationSearch.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsFlSituationSearch.ParamsTypes

class function TkwEnMainMenuWithProfNewsFlSituationSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.flSituationSearch';
end;//TkwEnMainMenuWithProfNewsFlSituationSearch.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPnlTrees.pnlTrees(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pnlTrees }
begin
 Result := aen_MainMenuWithProfNews.pnlTrees;
end;//TkwEnMainMenuWithProfNewsPnlTrees.pnlTrees

procedure TkwEnMainMenuWithProfNewsPnlTrees.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlTrees(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlTrees.DoDoIt

procedure TkwEnMainMenuWithProfNewsPnlTrees.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlTrees', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlTrees.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlTrees.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuWithProfNewsPnlTrees.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPnlTrees.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPnlTrees.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPnlTrees.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPnlTrees.ParamsTypes

class function TkwEnMainMenuWithProfNewsPnlTrees.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlTrees';
end;//TkwEnMainMenuWithProfNewsPnlTrees.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsHfTaxes.hfTaxes(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscHideField;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.hfTaxes }
begin
 Result := aen_MainMenuWithProfNews.hfTaxes;
end;//TkwEnMainMenuWithProfNewsHfTaxes.hfTaxes

procedure TkwEnMainMenuWithProfNewsHfTaxes.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfTaxes(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsHfTaxes.DoDoIt

procedure TkwEnMainMenuWithProfNewsHfTaxes.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству hfTaxes', aCtx);
end;//TkwEnMainMenuWithProfNewsHfTaxes.SetValuePrim

function TkwEnMainMenuWithProfNewsHfTaxes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMainMenuWithProfNewsHfTaxes.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsHfTaxes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsHfTaxes.GetAllParamsCount

function TkwEnMainMenuWithProfNewsHfTaxes.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsHfTaxes.ParamsTypes

class function TkwEnMainMenuWithProfNewsHfTaxes.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.hfTaxes';
end;//TkwEnMainMenuWithProfNewsHfTaxes.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsTvTaxes.tvTaxes(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.tvTaxes }
begin
 Result := aen_MainMenuWithProfNews.tvTaxes;
end;//TkwEnMainMenuWithProfNewsTvTaxes.tvTaxes

procedure TkwEnMainMenuWithProfNewsTvTaxes.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvTaxes(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsTvTaxes.DoDoIt

procedure TkwEnMainMenuWithProfNewsTvTaxes.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvTaxes', aCtx);
end;//TkwEnMainMenuWithProfNewsTvTaxes.SetValuePrim

function TkwEnMainMenuWithProfNewsTvTaxes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEnMainMenuWithProfNewsTvTaxes.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsTvTaxes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsTvTaxes.GetAllParamsCount

function TkwEnMainMenuWithProfNewsTvTaxes.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsTvTaxes.ParamsTypes

class function TkwEnMainMenuWithProfNewsTvTaxes.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.tvTaxes';
end;//TkwEnMainMenuWithProfNewsTvTaxes.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsBvlLeft.bvlLeft(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TBevel;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.bvlLeft }
begin
 Result := aen_MainMenuWithProfNews.bvlLeft;
end;//TkwEnMainMenuWithProfNewsBvlLeft.bvlLeft

procedure TkwEnMainMenuWithProfNewsBvlLeft.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(bvlLeft(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsBvlLeft.DoDoIt

procedure TkwEnMainMenuWithProfNewsBvlLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству bvlLeft', aCtx);
end;//TkwEnMainMenuWithProfNewsBvlLeft.SetValuePrim

function TkwEnMainMenuWithProfNewsBvlLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TBevel);
end;//TkwEnMainMenuWithProfNewsBvlLeft.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsBvlLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsBvlLeft.GetAllParamsCount

function TkwEnMainMenuWithProfNewsBvlLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsBvlLeft.ParamsTypes

class function TkwEnMainMenuWithProfNewsBvlLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.bvlLeft';
end;//TkwEnMainMenuWithProfNewsBvlLeft.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsBvlRight.bvlRight(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TBevel;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.bvlRight }
begin
 Result := aen_MainMenuWithProfNews.bvlRight;
end;//TkwEnMainMenuWithProfNewsBvlRight.bvlRight

procedure TkwEnMainMenuWithProfNewsBvlRight.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(bvlRight(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsBvlRight.DoDoIt

procedure TkwEnMainMenuWithProfNewsBvlRight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству bvlRight', aCtx);
end;//TkwEnMainMenuWithProfNewsBvlRight.SetValuePrim

function TkwEnMainMenuWithProfNewsBvlRight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TBevel);
end;//TkwEnMainMenuWithProfNewsBvlRight.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsBvlRight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsBvlRight.GetAllParamsCount

function TkwEnMainMenuWithProfNewsBvlRight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsBvlRight.ParamsTypes

class function TkwEnMainMenuWithProfNewsBvlRight.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.bvlRight';
end;//TkwEnMainMenuWithProfNewsBvlRight.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsIeIO.ieIO(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TImageEnIO;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.ieIO }
begin
 Result := aen_MainMenuWithProfNews.ieIO;
end;//TkwEnMainMenuWithProfNewsIeIO.ieIO

procedure TkwEnMainMenuWithProfNewsIeIO.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ieIO(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsIeIO.DoDoIt

procedure TkwEnMainMenuWithProfNewsIeIO.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ieIO', aCtx);
end;//TkwEnMainMenuWithProfNewsIeIO.SetValuePrim

function TkwEnMainMenuWithProfNewsIeIO.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TImageEnIO);
end;//TkwEnMainMenuWithProfNewsIeIO.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsIeIO.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsIeIO.GetAllParamsCount

function TkwEnMainMenuWithProfNewsIeIO.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsIeIO.ParamsTypes

class function TkwEnMainMenuWithProfNewsIeIO.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.ieIO';
end;//TkwEnMainMenuWithProfNewsIeIO.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsHfReferences.hfReferences(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscHideField;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.hfReferences }
begin
 Result := aen_MainMenuWithProfNews.hfReferences;
end;//TkwEnMainMenuWithProfNewsHfReferences.hfReferences

procedure TkwEnMainMenuWithProfNewsHfReferences.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfReferences(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsHfReferences.DoDoIt

procedure TkwEnMainMenuWithProfNewsHfReferences.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству hfReferences', aCtx);
end;//TkwEnMainMenuWithProfNewsHfReferences.SetValuePrim

function TkwEnMainMenuWithProfNewsHfReferences.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMainMenuWithProfNewsHfReferences.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsHfReferences.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsHfReferences.GetAllParamsCount

function TkwEnMainMenuWithProfNewsHfReferences.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsHfReferences.ParamsTypes

class function TkwEnMainMenuWithProfNewsHfReferences.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.hfReferences';
end;//TkwEnMainMenuWithProfNewsHfReferences.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsTvReferences.tvReferences(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.tvReferences }
begin
 Result := aen_MainMenuWithProfNews.tvReferences;
end;//TkwEnMainMenuWithProfNewsTvReferences.tvReferences

procedure TkwEnMainMenuWithProfNewsTvReferences.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvReferences(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsTvReferences.DoDoIt

procedure TkwEnMainMenuWithProfNewsTvReferences.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvReferences', aCtx);
end;//TkwEnMainMenuWithProfNewsTvReferences.SetValuePrim

function TkwEnMainMenuWithProfNewsTvReferences.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEnMainMenuWithProfNewsTvReferences.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsTvReferences.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsTvReferences.GetAllParamsCount

function TkwEnMainMenuWithProfNewsTvReferences.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsTvReferences.ParamsTypes

class function TkwEnMainMenuWithProfNewsTvReferences.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.tvReferences';
end;//TkwEnMainMenuWithProfNewsTvReferences.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsHfLawNews.hfLawNews(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscHideField;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.hfLawNews }
begin
 Result := aen_MainMenuWithProfNews.hfLawNews;
end;//TkwEnMainMenuWithProfNewsHfLawNews.hfLawNews

procedure TkwEnMainMenuWithProfNewsHfLawNews.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfLawNews(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsHfLawNews.DoDoIt

procedure TkwEnMainMenuWithProfNewsHfLawNews.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству hfLawNews', aCtx);
end;//TkwEnMainMenuWithProfNewsHfLawNews.SetValuePrim

function TkwEnMainMenuWithProfNewsHfLawNews.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMainMenuWithProfNewsHfLawNews.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsHfLawNews.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsHfLawNews.GetAllParamsCount

function TkwEnMainMenuWithProfNewsHfLawNews.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsHfLawNews.ParamsTypes

class function TkwEnMainMenuWithProfNewsHfLawNews.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.hfLawNews';
end;//TkwEnMainMenuWithProfNewsHfLawNews.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsTvLawNews.tvLawNews(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.tvLawNews }
begin
 Result := aen_MainMenuWithProfNews.tvLawNews;
end;//TkwEnMainMenuWithProfNewsTvLawNews.tvLawNews

procedure TkwEnMainMenuWithProfNewsTvLawNews.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvLawNews(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsTvLawNews.DoDoIt

procedure TkwEnMainMenuWithProfNewsTvLawNews.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvLawNews', aCtx);
end;//TkwEnMainMenuWithProfNewsTvLawNews.SetValuePrim

function TkwEnMainMenuWithProfNewsTvLawNews.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEnMainMenuWithProfNewsTvLawNews.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsTvLawNews.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsTvLawNews.GetAllParamsCount

function TkwEnMainMenuWithProfNewsTvLawNews.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsTvLawNews.ParamsTypes

class function TkwEnMainMenuWithProfNewsTvLawNews.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.tvLawNews';
end;//TkwEnMainMenuWithProfNewsTvLawNews.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPnlMain.pnlMain(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.pnlMain }
begin
 Result := aen_MainMenuWithProfNews.pnlMain;
end;//TkwEnMainMenuWithProfNewsPnlMain.pnlMain

procedure TkwEnMainMenuWithProfNewsPnlMain.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlMain(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlMain.DoDoIt

procedure TkwEnMainMenuWithProfNewsPnlMain.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlMain', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlMain.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlMain.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuWithProfNewsPnlMain.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPnlMain.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPnlMain.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPnlMain.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPnlMain.ParamsTypes

class function TkwEnMainMenuWithProfNewsPnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlMain';
end;//TkwEnMainMenuWithProfNewsPnlMain.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsHfLastOpenDocs.hfLastOpenDocs(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscHideField;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.hfLastOpenDocs }
begin
 Result := aen_MainMenuWithProfNews.hfLastOpenDocs;
end;//TkwEnMainMenuWithProfNewsHfLastOpenDocs.hfLastOpenDocs

procedure TkwEnMainMenuWithProfNewsHfLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfLastOpenDocs(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsHfLastOpenDocs.DoDoIt

procedure TkwEnMainMenuWithProfNewsHfLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству hfLastOpenDocs', aCtx);
end;//TkwEnMainMenuWithProfNewsHfLastOpenDocs.SetValuePrim

function TkwEnMainMenuWithProfNewsHfLastOpenDocs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscHideField);
end;//TkwEnMainMenuWithProfNewsHfLastOpenDocs.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsHfLastOpenDocs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsHfLastOpenDocs.GetAllParamsCount

function TkwEnMainMenuWithProfNewsHfLastOpenDocs.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsHfLastOpenDocs.ParamsTypes

class function TkwEnMainMenuWithProfNewsHfLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.hfLastOpenDocs';
end;//TkwEnMainMenuWithProfNewsHfLastOpenDocs.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsTvLastOpenDocs.tvLastOpenDocs(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
 {* Реализация слова скрипта .Ten_MainMenuWithProfNews.tvLastOpenDocs }
begin
 Result := aen_MainMenuWithProfNews.tvLastOpenDocs;
end;//TkwEnMainMenuWithProfNewsTvLastOpenDocs.tvLastOpenDocs

procedure TkwEnMainMenuWithProfNewsTvLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvLastOpenDocs(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsTvLastOpenDocs.DoDoIt

procedure TkwEnMainMenuWithProfNewsTvLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvLastOpenDocs', aCtx);
end;//TkwEnMainMenuWithProfNewsTvLastOpenDocs.SetValuePrim

function TkwEnMainMenuWithProfNewsTvLastOpenDocs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEnMainMenuWithProfNewsTvLastOpenDocs.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsTvLastOpenDocs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsTvLastOpenDocs.GetAllParamsCount

function TkwEnMainMenuWithProfNewsTvLastOpenDocs.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsTvLastOpenDocs.ParamsTypes

class function TkwEnMainMenuWithProfNewsTvLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.tvLastOpenDocs';
end;//TkwEnMainMenuWithProfNewsTvLastOpenDocs.GetWordNameForRegister

initialization
 Tkw_Form_MainMenuWithProfNews.RegisterInEngine;
 {* Регистрация Tkw_Form_MainMenuWithProfNews }
 Tkw_MainMenuWithProfNews_Control_pnlLeft.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pnlLeft }
 Tkw_MainMenuWithProfNews_Control_pnlLeft_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pnlLeft_Push }
 Tkw_MainMenuWithProfNews_Control_bvlLeftTop.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_bvlLeftTop }
 Tkw_MainMenuWithProfNews_Control_bvlLeftTop_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_bvlLeftTop_Push }
 Tkw_MainMenuWithProfNews_Control_pbLogo.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pbLogo }
 Tkw_MainMenuWithProfNews_Control_pbLogo_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pbLogo_Push }
 Tkw_MainMenuWithProfNews_Control_ieBanner.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_ieBanner }
 Tkw_MainMenuWithProfNews_Control_ieBanner_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_ieBanner_Push }
 Tkw_MainMenuWithProfNews_Control_pbCourtsOnline.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pbCourtsOnline }
 Tkw_MainMenuWithProfNews_Control_pbCourtsOnline_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pbCourtsOnline_Push }
 Tkw_MainMenuWithProfNews_Control_pbIntranet.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pbIntranet }
 Tkw_MainMenuWithProfNews_Control_pbIntranet_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pbIntranet_Push }
 Tkw_MainMenuWithProfNews_Control_pbOnline.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pbOnline }
 Tkw_MainMenuWithProfNews_Control_pbOnline_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pbOnline_Push }
 Tkw_MainMenuWithProfNews_Control_pnlClient.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pnlClient }
 Tkw_MainMenuWithProfNews_Control_pnlClient_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pnlClient_Push }
 Tkw_MainMenuWithProfNews_Control_pnlNews.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pnlNews }
 Tkw_MainMenuWithProfNews_Control_pnlNews_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pnlNews_Push }
 Tkw_MainMenuWithProfNews_Control_hfProfNews.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_hfProfNews }
 Tkw_MainMenuWithProfNews_Control_hfProfNews_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_hfProfNews_Push }
 Tkw_MainMenuWithProfNews_Control_tvProfNews.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_tvProfNews }
 Tkw_MainMenuWithProfNews_Control_tvProfNews_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_tvProfNews_Push }
 Tkw_MainMenuWithProfNews_Control_pnlBaseSearch.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pnlBaseSearch }
 Tkw_MainMenuWithProfNews_Control_pnlBaseSearch_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pnlBaseSearch_Push }
 Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone }
 Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone_Push }
 Tkw_MainMenuWithProfNews_Control_pnlSearches.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pnlSearches }
 Tkw_MainMenuWithProfNews_Control_pnlSearches_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pnlSearches_Push }
 Tkw_MainMenuWithProfNews_Control_flAttributeSearch.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_flAttributeSearch }
 Tkw_MainMenuWithProfNews_Control_flAttributeSearch_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_flAttributeSearch_Push }
 Tkw_MainMenuWithProfNews_Control_flDictionSearch.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_flDictionSearch }
 Tkw_MainMenuWithProfNews_Control_flDictionSearch_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_flDictionSearch_Push }
 Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch }
 Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch_Push }
 Tkw_MainMenuWithProfNews_Control_flSituationSearch.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_flSituationSearch }
 Tkw_MainMenuWithProfNews_Control_flSituationSearch_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_flSituationSearch_Push }
 Tkw_MainMenuWithProfNews_Control_pnlTrees.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pnlTrees }
 Tkw_MainMenuWithProfNews_Control_pnlTrees_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pnlTrees_Push }
 Tkw_MainMenuWithProfNews_Control_hfTaxes.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_hfTaxes }
 Tkw_MainMenuWithProfNews_Control_hfTaxes_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_hfTaxes_Push }
 Tkw_MainMenuWithProfNews_Control_tvTaxes.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_tvTaxes }
 Tkw_MainMenuWithProfNews_Control_tvTaxes_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_tvTaxes_Push }
 Tkw_MainMenuWithProfNews_Control_bvlLeft.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_bvlLeft }
 Tkw_MainMenuWithProfNews_Control_bvlLeft_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_bvlLeft_Push }
 Tkw_MainMenuWithProfNews_Control_bvlRight.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_bvlRight }
 Tkw_MainMenuWithProfNews_Control_bvlRight_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_bvlRight_Push }
 Tkw_MainMenuWithProfNews_Component_ieIO.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Component_ieIO }
 Tkw_MainMenuWithProfNews_Control_hfReferences.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_hfReferences }
 Tkw_MainMenuWithProfNews_Control_hfReferences_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_hfReferences_Push }
 Tkw_MainMenuWithProfNews_Control_tvReferences.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_tvReferences }
 Tkw_MainMenuWithProfNews_Control_tvReferences_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_tvReferences_Push }
 Tkw_MainMenuWithProfNews_Control_hfLawNews.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_hfLawNews }
 Tkw_MainMenuWithProfNews_Control_hfLawNews_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_hfLawNews_Push }
 Tkw_MainMenuWithProfNews_Control_tvLawNews.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_tvLawNews }
 Tkw_MainMenuWithProfNews_Control_tvLawNews_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_tvLawNews_Push }
 Tkw_MainMenuWithProfNews_Control_pnlMain.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pnlMain }
 Tkw_MainMenuWithProfNews_Control_pnlMain_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_pnlMain_Push }
 Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs }
 Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push }
 Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs }
 Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push.RegisterInEngine;
 {* Регистрация Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push }
 TkwEnMainMenuWithProfNewsPnlLeft.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_pnlLeft }
 TkwEnMainMenuWithProfNewsBvlLeftTop.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_bvlLeftTop }
 TkwEnMainMenuWithProfNewsPbLogo.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_pbLogo }
 TkwEnMainMenuWithProfNewsIeBanner.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_ieBanner }
 TkwEnMainMenuWithProfNewsPbCourtsOnline.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_pbCourtsOnline }
 TkwEnMainMenuWithProfNewsPbIntranet.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_pbIntranet }
 TkwEnMainMenuWithProfNewsPbOnline.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_pbOnline }
 TkwEnMainMenuWithProfNewsPnlClient.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_pnlClient }
 TkwEnMainMenuWithProfNewsPnlNews.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_pnlNews }
 TkwEnMainMenuWithProfNewsHfProfNews.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_hfProfNews }
 TkwEnMainMenuWithProfNewsTvProfNews.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_tvProfNews }
 TkwEnMainMenuWithProfNewsPnlBaseSearch.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_pnlBaseSearch }
 TkwEnMainMenuWithProfNewsPnlBaseSearchZone.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_pnlBaseSearchZone }
 TkwEnMainMenuWithProfNewsPnlSearches.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_pnlSearches }
 TkwEnMainMenuWithProfNewsFlAttributeSearch.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_flAttributeSearch }
 TkwEnMainMenuWithProfNewsFlDictionSearch.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_flDictionSearch }
 TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_flPublishedSourceSearch }
 TkwEnMainMenuWithProfNewsFlSituationSearch.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_flSituationSearch }
 TkwEnMainMenuWithProfNewsPnlTrees.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_pnlTrees }
 TkwEnMainMenuWithProfNewsHfTaxes.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_hfTaxes }
 TkwEnMainMenuWithProfNewsTvTaxes.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_tvTaxes }
 TkwEnMainMenuWithProfNewsBvlLeft.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_bvlLeft }
 TkwEnMainMenuWithProfNewsBvlRight.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_bvlRight }
 TkwEnMainMenuWithProfNewsIeIO.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_ieIO }
 TkwEnMainMenuWithProfNewsHfReferences.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_hfReferences }
 TkwEnMainMenuWithProfNewsTvReferences.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_tvReferences }
 TkwEnMainMenuWithProfNewsHfLawNews.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_hfLawNews }
 TkwEnMainMenuWithProfNewsTvLawNews.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_tvLawNews }
 TkwEnMainMenuWithProfNewsPnlMain.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_pnlMain }
 TkwEnMainMenuWithProfNewsHfLastOpenDocs.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_hfLastOpenDocs }
 TkwEnMainMenuWithProfNewsTvLastOpenDocs.RegisterInEngine;
 {* Регистрация en_MainMenuWithProfNews_tvLastOpenDocs }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_MainMenuWithProfNews));
 {* Регистрация типа MainMenuWithProfNews }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TBevel));
 {* Регистрация типа TBevel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* Регистрация типа TPaintBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImageEnView));
 {* Регистрация типа TImageEnView }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscHideField));
 {* Регистрация типа TnscHideField }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewHotTruck));
 {* Регистрация типа TnscTreeViewHotTruck }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscFocusLabel));
 {* Регистрация типа TnscFocusLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImageEnIO));
 {* Регистрация типа TImageEnIO }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
