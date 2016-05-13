unit MainMenuWithProfNewsKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� MainMenuWithProfNews }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\MainMenuWithProfNewsKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "MainMenuWithProfNewsKeywordsPack" MUID: (483B68B1ABBB)

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
 , nscTreeViewHotTruck
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscComboLabel
 {$IfEnd} // Defined(Nemesis)
 , vtLabel
 {$If Defined(Nemesis)}
 , nscFocusLabel
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoImageEn)}
 , imageenio
 {$IfEnd} // NOT Defined(NoImageEn)
 {$If Defined(Nemesis)}
 , nscHideField
 {$IfEnd} // Defined(Nemesis)
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
 , TypInfo
 , tfwTypeInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 Tkw_Form_MainMenuWithProfNews = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� MainMenuWithProfNews
----
*������ �������������*:
[code]
'aControl' �����::MainMenuWithProfNews TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_MainMenuWithProfNews

 Tkw_MainMenuWithProfNews_Control_pnlLeft = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlLeft
----
*������ �������������*:
[code]
�������::pnlLeft TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlLeft

 Tkw_MainMenuWithProfNews_Control_pnlLeft_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnlLeft
----
*������ �������������*:
[code]
�������::pnlLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlLeft_Push

 Tkw_MainMenuWithProfNews_Control_bvlLeftTop = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� bvlLeftTop
----
*������ �������������*:
[code]
�������::bvlLeftTop TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_bvlLeftTop

 Tkw_MainMenuWithProfNews_Control_bvlLeftTop_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� bvlLeftTop
----
*������ �������������*:
[code]
�������::bvlLeftTop:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_bvlLeftTop_Push

 Tkw_MainMenuWithProfNews_Control_pnlLogo = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlLogo
----
*������ �������������*:
[code]
�������::pnlLogo TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlLogo

 Tkw_MainMenuWithProfNews_Control_pnlLogo_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnlLogo
----
*������ �������������*:
[code]
�������::pnlLogo:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlLogo_Push

 Tkw_MainMenuWithProfNews_Control_pbLogo = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pbLogo
----
*������ �������������*:
[code]
�������::pbLogo TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pbLogo

 Tkw_MainMenuWithProfNews_Control_pbLogo_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pbLogo
----
*������ �������������*:
[code]
�������::pbLogo:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pbLogo_Push

 Tkw_MainMenuWithProfNews_Control_pnlBanner = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlBanner
----
*������ �������������*:
[code]
�������::pnlBanner TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlBanner

 Tkw_MainMenuWithProfNews_Control_pnlBanner_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnlBanner
----
*������ �������������*:
[code]
�������::pnlBanner:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlBanner_Push

 Tkw_MainMenuWithProfNews_Control_ieBanner = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ieBanner
----
*������ �������������*:
[code]
�������::ieBanner TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_ieBanner

 Tkw_MainMenuWithProfNews_Control_ieBanner_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� ieBanner
----
*������ �������������*:
[code]
�������::ieBanner:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_ieBanner_Push

 Tkw_MainMenuWithProfNews_Control_pnlFeedback = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlFeedback
----
*������ �������������*:
[code]
�������::pnlFeedback TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlFeedback

 Tkw_MainMenuWithProfNews_Control_pnlFeedback_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnlFeedback
----
*������ �������������*:
[code]
�������::pnlFeedback:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlFeedback_Push

 Tkw_MainMenuWithProfNews_Control_pbFeedback = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pbFeedback
----
*������ �������������*:
[code]
�������::pbFeedback TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pbFeedback

 Tkw_MainMenuWithProfNews_Control_pbFeedback_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pbFeedback
----
*������ �������������*:
[code]
�������::pbFeedback:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pbFeedback_Push

 Tkw_MainMenuWithProfNews_Control_pnlOnlineResources = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlOnlineResources
----
*������ �������������*:
[code]
�������::pnlOnlineResources TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlOnlineResources

 Tkw_MainMenuWithProfNews_Control_pnlOnlineResources_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnlOnlineResources
----
*������ �������������*:
[code]
�������::pnlOnlineResources:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlOnlineResources_Push

 Tkw_MainMenuWithProfNews_Control_pbOnlineResources = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pbOnlineResources
----
*������ �������������*:
[code]
�������::pbOnlineResources TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pbOnlineResources

 Tkw_MainMenuWithProfNews_Control_pbOnlineResources_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pbOnlineResources
----
*������ �������������*:
[code]
�������::pbOnlineResources:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pbOnlineResources_Push

 Tkw_MainMenuWithProfNews_Control_pnlWebVersion = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlWebVersion
----
*������ �������������*:
[code]
�������::pnlWebVersion TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlWebVersion

 Tkw_MainMenuWithProfNews_Control_pnlWebVersion_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnlWebVersion
----
*������ �������������*:
[code]
�������::pnlWebVersion:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlWebVersion_Push

 Tkw_MainMenuWithProfNews_Control_pbWebVersion = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pbWebVersion
----
*������ �������������*:
[code]
�������::pbWebVersion TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pbWebVersion

 Tkw_MainMenuWithProfNews_Control_pbWebVersion_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pbWebVersion
----
*������ �������������*:
[code]
�������::pbWebVersion:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pbWebVersion_Push

 Tkw_MainMenuWithProfNews_Control_pnlClient = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlClient
----
*������ �������������*:
[code]
�������::pnlClient TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlClient

 Tkw_MainMenuWithProfNews_Control_pnlClient_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnlClient
----
*������ �������������*:
[code]
�������::pnlClient:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlClient_Push

 Tkw_MainMenuWithProfNews_Control_pnlNews = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlNews
----
*������ �������������*:
[code]
�������::pnlNews TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlNews

 Tkw_MainMenuWithProfNews_Control_pnlNews_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnlNews
----
*������ �������������*:
[code]
�������::pnlNews:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlNews_Push

 Tkw_MainMenuWithProfNews_Control_tvProfNews = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvProfNews
----
*������ �������������*:
[code]
�������::tvProfNews TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_tvProfNews

 Tkw_MainMenuWithProfNews_Control_tvProfNews_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� tvProfNews
----
*������ �������������*:
[code]
�������::tvProfNews:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_tvProfNews_Push

 Tkw_MainMenuWithProfNews_Control_lblProfNews = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblProfNews
----
*������ �������������*:
[code]
�������::lblProfNews TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_lblProfNews

 Tkw_MainMenuWithProfNews_Control_lblProfNews_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� lblProfNews
----
*������ �������������*:
[code]
�������::lblProfNews:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_lblProfNews_Push

 Tkw_MainMenuWithProfNews_Control_lblLawNews = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblLawNews
----
*������ �������������*:
[code]
�������::lblLawNews TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_lblLawNews

 Tkw_MainMenuWithProfNews_Control_lblLawNews_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� lblLawNews
----
*������ �������������*:
[code]
�������::lblLawNews:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_lblLawNews_Push

 Tkw_MainMenuWithProfNews_Control_pnlBaseSearch = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlBaseSearch
----
*������ �������������*:
[code]
�������::pnlBaseSearch TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearch

 Tkw_MainMenuWithProfNews_Control_pnlBaseSearch_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnlBaseSearch
----
*������ �������������*:
[code]
�������::pnlBaseSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearch_Push

 Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlBaseSearchZone
----
*������ �������������*:
[code]
�������::pnlBaseSearchZone TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone

 Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnlBaseSearchZone
----
*������ �������������*:
[code]
�������::pnlBaseSearchZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone_Push

 Tkw_MainMenuWithProfNews_Control_pnlSearches = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlSearches
----
*������ �������������*:
[code]
�������::pnlSearches TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlSearches

 Tkw_MainMenuWithProfNews_Control_pnlSearches_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnlSearches
----
*������ �������������*:
[code]
�������::pnlSearches:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlSearches_Push

 Tkw_MainMenuWithProfNews_Control_flAttributeSearch = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� flAttributeSearch
----
*������ �������������*:
[code]
�������::flAttributeSearch TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_flAttributeSearch

 Tkw_MainMenuWithProfNews_Control_flAttributeSearch_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� flAttributeSearch
----
*������ �������������*:
[code]
�������::flAttributeSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_flAttributeSearch_Push

 Tkw_MainMenuWithProfNews_Control_flDictionSearch = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� flDictionSearch
----
*������ �������������*:
[code]
�������::flDictionSearch TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_flDictionSearch

 Tkw_MainMenuWithProfNews_Control_flDictionSearch_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� flDictionSearch
----
*������ �������������*:
[code]
�������::flDictionSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_flDictionSearch_Push

 Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� flPublishedSourceSearch
----
*������ �������������*:
[code]
�������::flPublishedSourceSearch TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch

 Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� flPublishedSourceSearch
----
*������ �������������*:
[code]
�������::flPublishedSourceSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch_Push

 Tkw_MainMenuWithProfNews_Control_flSituationSearch = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� flSituationSearch
----
*������ �������������*:
[code]
�������::flSituationSearch TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_flSituationSearch

 Tkw_MainMenuWithProfNews_Control_flSituationSearch_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� flSituationSearch
----
*������ �������������*:
[code]
�������::flSituationSearch:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_flSituationSearch_Push

 Tkw_MainMenuWithProfNews_Control_pnlTrees = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlTrees
----
*������ �������������*:
[code]
�������::pnlTrees TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlTrees

 Tkw_MainMenuWithProfNews_Control_pnlTrees_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnlTrees
----
*������ �������������*:
[code]
�������::pnlTrees:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlTrees_Push

 Tkw_MainMenuWithProfNews_Control_tvTaxes = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvTaxes
----
*������ �������������*:
[code]
�������::tvTaxes TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_tvTaxes

 Tkw_MainMenuWithProfNews_Control_tvTaxes_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� tvTaxes
----
*������ �������������*:
[code]
�������::tvTaxes:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_tvTaxes_Push

 Tkw_MainMenuWithProfNews_Control_lblReferences = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblReferences
----
*������ �������������*:
[code]
�������::lblReferences TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_lblReferences

 Tkw_MainMenuWithProfNews_Control_lblReferences_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� lblReferences
----
*������ �������������*:
[code]
�������::lblReferences:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_lblReferences_Push

 Tkw_MainMenuWithProfNews_Control_lblTaxes = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblTaxes
----
*������ �������������*:
[code]
�������::lblTaxes TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_lblTaxes

 Tkw_MainMenuWithProfNews_Control_lblTaxes_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� lblTaxes
----
*������ �������������*:
[code]
�������::lblTaxes:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_lblTaxes_Push

 Tkw_MainMenuWithProfNews_Control_pnlLastOpenDocs = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlLastOpenDocs
----
*������ �������������*:
[code]
�������::pnlLastOpenDocs TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlLastOpenDocs

 Tkw_MainMenuWithProfNews_Control_pnlLastOpenDocs_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnlLastOpenDocs
----
*������ �������������*:
[code]
�������::pnlLastOpenDocs:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlLastOpenDocs_Push

 Tkw_MainMenuWithProfNews_Control_lblLastOpenDocs = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lblLastOpenDocs
----
*������ �������������*:
[code]
�������::lblLastOpenDocs TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_lblLastOpenDocs

 Tkw_MainMenuWithProfNews_Control_lblLastOpenDocs_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� lblLastOpenDocs
----
*������ �������������*:
[code]
�������::lblLastOpenDocs:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_lblLastOpenDocs_Push

 Tkw_MainMenuWithProfNews_Control_bvlLeft = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� bvlLeft
----
*������ �������������*:
[code]
�������::bvlLeft TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_bvlLeft

 Tkw_MainMenuWithProfNews_Control_bvlLeft_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� bvlLeft
----
*������ �������������*:
[code]
�������::bvlLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_bvlLeft_Push

 Tkw_MainMenuWithProfNews_Control_bvlRight = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� bvlRight
----
*������ �������������*:
[code]
�������::bvlRight TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_bvlRight

 Tkw_MainMenuWithProfNews_Control_bvlRight_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� bvlRight
----
*������ �������������*:
[code]
�������::bvlRight:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_bvlRight_Push

 Tkw_MainMenuWithProfNews_Component_ieIO = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ieIO
----
*������ �������������*:
[code]
���������::ieIO TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Component_ieIO

 Tkw_MainMenuWithProfNews_Control_hfReferences = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� hfReferences
----
*������ �������������*:
[code]
�������::hfReferences TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_hfReferences

 Tkw_MainMenuWithProfNews_Control_hfReferences_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� hfReferences
----
*������ �������������*:
[code]
�������::hfReferences:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_hfReferences_Push

 Tkw_MainMenuWithProfNews_Control_tvReferences = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvReferences
----
*������ �������������*:
[code]
�������::tvReferences TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_tvReferences

 Tkw_MainMenuWithProfNews_Control_tvReferences_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� tvReferences
----
*������ �������������*:
[code]
�������::tvReferences:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_tvReferences_Push

 Tkw_MainMenuWithProfNews_Control_hfLawNews = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� hfLawNews
----
*������ �������������*:
[code]
�������::hfLawNews TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_hfLawNews

 Tkw_MainMenuWithProfNews_Control_hfLawNews_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� hfLawNews
----
*������ �������������*:
[code]
�������::hfLawNews:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_hfLawNews_Push

 Tkw_MainMenuWithProfNews_Control_tvLawNews = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvLawNews
----
*������ �������������*:
[code]
�������::tvLawNews TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_tvLawNews

 Tkw_MainMenuWithProfNews_Control_tvLawNews_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� tvLawNews
----
*������ �������������*:
[code]
�������::tvLawNews:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_tvLawNews_Push

 Tkw_MainMenuWithProfNews_Control_pnlMain = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlMain
----
*������ �������������*:
[code]
�������::pnlMain TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlMain

 Tkw_MainMenuWithProfNews_Control_pnlMain_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� pnlMain
----
*������ �������������*:
[code]
�������::pnlMain:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_pnlMain_Push

 Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� hfLastOpenDocs
----
*������ �������������*:
[code]
�������::hfLastOpenDocs TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs

 Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� hfLastOpenDocs
----
*������ �������������*:
[code]
�������::hfLastOpenDocs:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push

 Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvLastOpenDocs
----
*������ �������������*:
[code]
�������::tvLastOpenDocs TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs

 Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� tvLastOpenDocs
----
*������ �������������*:
[code]
�������::tvLastOpenDocs:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push

 TkwEnMainMenuWithProfNewsPnlLeft = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.pnlLeft }
  private
   function pnlLeft(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsPnlLeft

 TkwEnMainMenuWithProfNewsBvlLeftTop = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.bvlLeftTop }
  private
   function bvlLeftTop(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TBevel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.bvlLeftTop }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsBvlLeftTop

 TkwEnMainMenuWithProfNewsPnlLogo = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.pnlLogo }
  private
   function pnlLogo(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlLogo }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsPnlLogo

 TkwEnMainMenuWithProfNewsPbLogo = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.pbLogo }
  private
   function pbLogo(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TPaintBox;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pbLogo }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsPbLogo

 TkwEnMainMenuWithProfNewsPnlBanner = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.pnlBanner }
  private
   function pnlBanner(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlBanner }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsPnlBanner

 TkwEnMainMenuWithProfNewsIeBanner = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.ieBanner }
  private
   function ieBanner(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TImageEnView;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.ieBanner }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsIeBanner

 TkwEnMainMenuWithProfNewsPnlFeedback = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.pnlFeedback }
  private
   function pnlFeedback(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlFeedback }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsPnlFeedback

 TkwEnMainMenuWithProfNewsPbFeedback = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.pbFeedback }
  private
   function pbFeedback(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TPaintBox;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pbFeedback }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsPbFeedback

 TkwEnMainMenuWithProfNewsPnlOnlineResources = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.pnlOnlineResources }
  private
   function pnlOnlineResources(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlOnlineResources }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsPnlOnlineResources

 TkwEnMainMenuWithProfNewsPbOnlineResources = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.pbOnlineResources }
  private
   function pbOnlineResources(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TPaintBox;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pbOnlineResources }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsPbOnlineResources

 TkwEnMainMenuWithProfNewsPnlWebVersion = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.pnlWebVersion }
  private
   function pnlWebVersion(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlWebVersion }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsPnlWebVersion

 TkwEnMainMenuWithProfNewsPbWebVersion = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.pbWebVersion }
  private
   function pbWebVersion(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TPaintBox;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pbWebVersion }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsPbWebVersion

 TkwEnMainMenuWithProfNewsPnlClient = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.pnlClient }
  private
   function pnlClient(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlClient }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsPnlClient

 TkwEnMainMenuWithProfNewsPnlNews = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.pnlNews }
  private
   function pnlNews(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlNews }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsPnlNews

 TkwEnMainMenuWithProfNewsTvProfNews = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.tvProfNews }
  private
   function tvProfNews(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.tvProfNews }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsTvProfNews

 TkwEnMainMenuWithProfNewsLblProfNews = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.lblProfNews }
  private
   function lblProfNews(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscComboLabel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.lblProfNews }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsLblProfNews

 TkwEnMainMenuWithProfNewsLblLawNews = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.lblLawNews }
  private
   function lblLawNews(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtStyledLabel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.lblLawNews }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsLblLawNews

 TkwEnMainMenuWithProfNewsPnlBaseSearch = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.pnlBaseSearch }
  private
   function pnlBaseSearch(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlBaseSearch }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsPnlBaseSearch

 TkwEnMainMenuWithProfNewsPnlBaseSearchZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.pnlBaseSearchZone }
  private
   function pnlBaseSearchZone(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlBaseSearchZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsPnlBaseSearchZone

 TkwEnMainMenuWithProfNewsPnlSearches = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.pnlSearches }
  private
   function pnlSearches(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlSearches }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsPnlSearches

 TkwEnMainMenuWithProfNewsFlAttributeSearch = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.flAttributeSearch }
  private
   function flAttributeSearch(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscFocusLabel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.flAttributeSearch }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsFlAttributeSearch

 TkwEnMainMenuWithProfNewsFlDictionSearch = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.flDictionSearch }
  private
   function flDictionSearch(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscFocusLabel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.flDictionSearch }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsFlDictionSearch

 TkwEnMainMenuWithProfNewsFlPublishedSourceSearch = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.flPublishedSourceSearch }
  private
   function flPublishedSourceSearch(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscFocusLabel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.flPublishedSourceSearch }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsFlPublishedSourceSearch

 TkwEnMainMenuWithProfNewsFlSituationSearch = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.flSituationSearch }
  private
   function flSituationSearch(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscFocusLabel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.flSituationSearch }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsFlSituationSearch

 TkwEnMainMenuWithProfNewsPnlTrees = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.pnlTrees }
  private
   function pnlTrees(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlTrees }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsPnlTrees

 TkwEnMainMenuWithProfNewsTvTaxes = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.tvTaxes }
  private
   function tvTaxes(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.tvTaxes }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsTvTaxes

 TkwEnMainMenuWithProfNewsLblReferences = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.lblReferences }
  private
   function lblReferences(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtStyledLabel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.lblReferences }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsLblReferences

 TkwEnMainMenuWithProfNewsLblTaxes = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.lblTaxes }
  private
   function lblTaxes(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscComboLabel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.lblTaxes }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsLblTaxes

 TkwEnMainMenuWithProfNewsPnlLastOpenDocs = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.pnlLastOpenDocs }
  private
   function pnlLastOpenDocs(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlLastOpenDocs }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsPnlLastOpenDocs

 TkwEnMainMenuWithProfNewsLblLastOpenDocs = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.lblLastOpenDocs }
  private
   function lblLastOpenDocs(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtStyledLabel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.lblLastOpenDocs }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsLblLastOpenDocs

 TkwEnMainMenuWithProfNewsBvlLeft = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.bvlLeft }
  private
   function bvlLeft(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TBevel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.bvlLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsBvlLeft

 TkwEnMainMenuWithProfNewsBvlRight = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.bvlRight }
  private
   function bvlRight(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TBevel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.bvlRight }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsBvlRight

 TkwEnMainMenuWithProfNewsIeIO = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.ieIO }
  private
   function ieIO(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TImageEnIO;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.ieIO }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsIeIO

 TkwEnMainMenuWithProfNewsHfReferences = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.hfReferences }
  private
   function hfReferences(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscHideField;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.hfReferences }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsHfReferences

 TkwEnMainMenuWithProfNewsTvReferences = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.tvReferences }
  private
   function tvReferences(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.tvReferences }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsTvReferences

 TkwEnMainMenuWithProfNewsHfLawNews = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.hfLawNews }
  private
   function hfLawNews(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscHideField;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.hfLawNews }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsHfLawNews

 TkwEnMainMenuWithProfNewsTvLawNews = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.tvLawNews }
  private
   function tvLawNews(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.tvLawNews }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsTvLawNews

 TkwEnMainMenuWithProfNewsPnlMain = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.pnlMain }
  private
   function pnlMain(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlMain }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsPnlMain

 TkwEnMainMenuWithProfNewsHfLastOpenDocs = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.hfLastOpenDocs }
  private
   function hfLastOpenDocs(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscHideField;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.hfLastOpenDocs }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsHfLastOpenDocs

 TkwEnMainMenuWithProfNewsTvLastOpenDocs = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MainMenuWithProfNews.tvLastOpenDocs }
  private
   function tvLastOpenDocs(const aCtx: TtfwContext;
    aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
    {* ���������� ����� ������� .Ten_MainMenuWithProfNews.tvLastOpenDocs }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnMainMenuWithProfNewsTvLastOpenDocs

function Tkw_Form_MainMenuWithProfNews.GetString: AnsiString;
begin
 Result := 'en_MainMenuWithProfNews';
end;//Tkw_Form_MainMenuWithProfNews.GetString

class function Tkw_Form_MainMenuWithProfNews.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::MainMenuWithProfNews';
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
 Result := '�������::pnlLeft';
end;//Tkw_MainMenuWithProfNews_Control_pnlLeft.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlLeft_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlLeft');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlLeft_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlLeft:push';
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
 Result := '�������::bvlLeftTop';
end;//Tkw_MainMenuWithProfNews_Control_bvlLeftTop.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_bvlLeftTop_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('bvlLeftTop');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_bvlLeftTop_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_bvlLeftTop_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::bvlLeftTop:push';
end;//Tkw_MainMenuWithProfNews_Control_bvlLeftTop_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pnlLogo.GetString: AnsiString;
begin
 Result := 'pnlLogo';
end;//Tkw_MainMenuWithProfNews_Control_pnlLogo.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pnlLogo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuWithProfNews_Control_pnlLogo.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pnlLogo.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlLogo';
end;//Tkw_MainMenuWithProfNews_Control_pnlLogo.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlLogo_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlLogo');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlLogo_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlLogo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlLogo:push';
end;//Tkw_MainMenuWithProfNews_Control_pnlLogo_Push.GetWordNameForRegister

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
 Result := '�������::pbLogo';
end;//Tkw_MainMenuWithProfNews_Control_pbLogo.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pbLogo_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbLogo');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pbLogo_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pbLogo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbLogo:push';
end;//Tkw_MainMenuWithProfNews_Control_pbLogo_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pnlBanner.GetString: AnsiString;
begin
 Result := 'pnlBanner';
end;//Tkw_MainMenuWithProfNews_Control_pnlBanner.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pnlBanner.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuWithProfNews_Control_pnlBanner.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pnlBanner.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlBanner';
end;//Tkw_MainMenuWithProfNews_Control_pnlBanner.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlBanner_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlBanner');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlBanner_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlBanner_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlBanner:push';
end;//Tkw_MainMenuWithProfNews_Control_pnlBanner_Push.GetWordNameForRegister

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
 Result := '�������::ieBanner';
end;//Tkw_MainMenuWithProfNews_Control_ieBanner.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_ieBanner_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ieBanner');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_ieBanner_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_ieBanner_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ieBanner:push';
end;//Tkw_MainMenuWithProfNews_Control_ieBanner_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pnlFeedback.GetString: AnsiString;
begin
 Result := 'pnlFeedback';
end;//Tkw_MainMenuWithProfNews_Control_pnlFeedback.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pnlFeedback.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuWithProfNews_Control_pnlFeedback.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pnlFeedback.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlFeedback';
end;//Tkw_MainMenuWithProfNews_Control_pnlFeedback.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlFeedback_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlFeedback');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlFeedback_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlFeedback_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlFeedback:push';
end;//Tkw_MainMenuWithProfNews_Control_pnlFeedback_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pbFeedback.GetString: AnsiString;
begin
 Result := 'pbFeedback';
end;//Tkw_MainMenuWithProfNews_Control_pbFeedback.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pbFeedback.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_MainMenuWithProfNews_Control_pbFeedback.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pbFeedback.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbFeedback';
end;//Tkw_MainMenuWithProfNews_Control_pbFeedback.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pbFeedback_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbFeedback');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pbFeedback_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pbFeedback_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbFeedback:push';
end;//Tkw_MainMenuWithProfNews_Control_pbFeedback_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pnlOnlineResources.GetString: AnsiString;
begin
 Result := 'pnlOnlineResources';
end;//Tkw_MainMenuWithProfNews_Control_pnlOnlineResources.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pnlOnlineResources.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuWithProfNews_Control_pnlOnlineResources.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pnlOnlineResources.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlOnlineResources';
end;//Tkw_MainMenuWithProfNews_Control_pnlOnlineResources.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlOnlineResources_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlOnlineResources');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlOnlineResources_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlOnlineResources_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlOnlineResources:push';
end;//Tkw_MainMenuWithProfNews_Control_pnlOnlineResources_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pbOnlineResources.GetString: AnsiString;
begin
 Result := 'pbOnlineResources';
end;//Tkw_MainMenuWithProfNews_Control_pbOnlineResources.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pbOnlineResources.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_MainMenuWithProfNews_Control_pbOnlineResources.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pbOnlineResources.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbOnlineResources';
end;//Tkw_MainMenuWithProfNews_Control_pbOnlineResources.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pbOnlineResources_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbOnlineResources');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pbOnlineResources_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pbOnlineResources_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbOnlineResources:push';
end;//Tkw_MainMenuWithProfNews_Control_pbOnlineResources_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pnlWebVersion.GetString: AnsiString;
begin
 Result := 'pnlWebVersion';
end;//Tkw_MainMenuWithProfNews_Control_pnlWebVersion.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pnlWebVersion.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuWithProfNews_Control_pnlWebVersion.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pnlWebVersion.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlWebVersion';
end;//Tkw_MainMenuWithProfNews_Control_pnlWebVersion.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlWebVersion_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlWebVersion');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlWebVersion_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlWebVersion_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlWebVersion:push';
end;//Tkw_MainMenuWithProfNews_Control_pnlWebVersion_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pbWebVersion.GetString: AnsiString;
begin
 Result := 'pbWebVersion';
end;//Tkw_MainMenuWithProfNews_Control_pbWebVersion.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pbWebVersion.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_MainMenuWithProfNews_Control_pbWebVersion.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pbWebVersion.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbWebVersion';
end;//Tkw_MainMenuWithProfNews_Control_pbWebVersion.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pbWebVersion_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbWebVersion');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pbWebVersion_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pbWebVersion_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbWebVersion:push';
end;//Tkw_MainMenuWithProfNews_Control_pbWebVersion_Push.GetWordNameForRegister

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
 Result := '�������::pnlClient';
end;//Tkw_MainMenuWithProfNews_Control_pnlClient.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlClient_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlClient');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlClient_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlClient_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlClient:push';
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
 Result := '�������::pnlNews';
end;//Tkw_MainMenuWithProfNews_Control_pnlNews.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlNews_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlNews');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlNews_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlNews_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlNews:push';
end;//Tkw_MainMenuWithProfNews_Control_pnlNews_Push.GetWordNameForRegister

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
 Result := '�������::tvProfNews';
end;//Tkw_MainMenuWithProfNews_Control_tvProfNews.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_tvProfNews_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvProfNews');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_tvProfNews_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_tvProfNews_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvProfNews:push';
end;//Tkw_MainMenuWithProfNews_Control_tvProfNews_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_lblProfNews.GetString: AnsiString;
begin
 Result := 'lblProfNews';
end;//Tkw_MainMenuWithProfNews_Control_lblProfNews.GetString

class procedure Tkw_MainMenuWithProfNews_Control_lblProfNews.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscComboLabel);
end;//Tkw_MainMenuWithProfNews_Control_lblProfNews.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_lblProfNews.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblProfNews';
end;//Tkw_MainMenuWithProfNews_Control_lblProfNews.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_lblProfNews_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblProfNews');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_lblProfNews_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_lblProfNews_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblProfNews:push';
end;//Tkw_MainMenuWithProfNews_Control_lblProfNews_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_lblLawNews.GetString: AnsiString;
begin
 Result := 'lblLawNews';
end;//Tkw_MainMenuWithProfNews_Control_lblLawNews.GetString

class procedure Tkw_MainMenuWithProfNews_Control_lblLawNews.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtStyledLabel);
end;//Tkw_MainMenuWithProfNews_Control_lblLawNews.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_lblLawNews.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblLawNews';
end;//Tkw_MainMenuWithProfNews_Control_lblLawNews.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_lblLawNews_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblLawNews');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_lblLawNews_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_lblLawNews_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblLawNews:push';
end;//Tkw_MainMenuWithProfNews_Control_lblLawNews_Push.GetWordNameForRegister

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
 Result := '�������::pnlBaseSearch';
end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearch.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlBaseSearch_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlBaseSearch');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearch_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlBaseSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlBaseSearch:push';
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
 Result := '�������::pnlBaseSearchZone';
end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlBaseSearchZone');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlBaseSearchZone:push';
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
 Result := '�������::pnlSearches';
end;//Tkw_MainMenuWithProfNews_Control_pnlSearches.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlSearches_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlSearches');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlSearches_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlSearches_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlSearches:push';
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
 Result := '�������::flAttributeSearch';
end;//Tkw_MainMenuWithProfNews_Control_flAttributeSearch.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_flAttributeSearch_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('flAttributeSearch');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_flAttributeSearch_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_flAttributeSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::flAttributeSearch:push';
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
 Result := '�������::flDictionSearch';
end;//Tkw_MainMenuWithProfNews_Control_flDictionSearch.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_flDictionSearch_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('flDictionSearch');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_flDictionSearch_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_flDictionSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::flDictionSearch:push';
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
 Result := '�������::flPublishedSourceSearch';
end;//Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('flPublishedSourceSearch');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::flPublishedSourceSearch:push';
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
 Result := '�������::flSituationSearch';
end;//Tkw_MainMenuWithProfNews_Control_flSituationSearch.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_flSituationSearch_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('flSituationSearch');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_flSituationSearch_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_flSituationSearch_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::flSituationSearch:push';
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
 Result := '�������::pnlTrees';
end;//Tkw_MainMenuWithProfNews_Control_pnlTrees.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlTrees_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlTrees');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlTrees_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlTrees_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlTrees:push';
end;//Tkw_MainMenuWithProfNews_Control_pnlTrees_Push.GetWordNameForRegister

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
 Result := '�������::tvTaxes';
end;//Tkw_MainMenuWithProfNews_Control_tvTaxes.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_tvTaxes_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvTaxes');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_tvTaxes_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_tvTaxes_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvTaxes:push';
end;//Tkw_MainMenuWithProfNews_Control_tvTaxes_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_lblReferences.GetString: AnsiString;
begin
 Result := 'lblReferences';
end;//Tkw_MainMenuWithProfNews_Control_lblReferences.GetString

class procedure Tkw_MainMenuWithProfNews_Control_lblReferences.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtStyledLabel);
end;//Tkw_MainMenuWithProfNews_Control_lblReferences.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_lblReferences.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblReferences';
end;//Tkw_MainMenuWithProfNews_Control_lblReferences.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_lblReferences_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblReferences');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_lblReferences_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_lblReferences_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblReferences:push';
end;//Tkw_MainMenuWithProfNews_Control_lblReferences_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_lblTaxes.GetString: AnsiString;
begin
 Result := 'lblTaxes';
end;//Tkw_MainMenuWithProfNews_Control_lblTaxes.GetString

class procedure Tkw_MainMenuWithProfNews_Control_lblTaxes.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscComboLabel);
end;//Tkw_MainMenuWithProfNews_Control_lblTaxes.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_lblTaxes.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblTaxes';
end;//Tkw_MainMenuWithProfNews_Control_lblTaxes.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_lblTaxes_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblTaxes');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_lblTaxes_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_lblTaxes_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblTaxes:push';
end;//Tkw_MainMenuWithProfNews_Control_lblTaxes_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_pnlLastOpenDocs.GetString: AnsiString;
begin
 Result := 'pnlLastOpenDocs';
end;//Tkw_MainMenuWithProfNews_Control_pnlLastOpenDocs.GetString

class procedure Tkw_MainMenuWithProfNews_Control_pnlLastOpenDocs.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MainMenuWithProfNews_Control_pnlLastOpenDocs.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_pnlLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlLastOpenDocs';
end;//Tkw_MainMenuWithProfNews_Control_pnlLastOpenDocs.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlLastOpenDocs');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlLastOpenDocs_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlLastOpenDocs:push';
end;//Tkw_MainMenuWithProfNews_Control_pnlLastOpenDocs_Push.GetWordNameForRegister

function Tkw_MainMenuWithProfNews_Control_lblLastOpenDocs.GetString: AnsiString;
begin
 Result := 'lblLastOpenDocs';
end;//Tkw_MainMenuWithProfNews_Control_lblLastOpenDocs.GetString

class procedure Tkw_MainMenuWithProfNews_Control_lblLastOpenDocs.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtStyledLabel);
end;//Tkw_MainMenuWithProfNews_Control_lblLastOpenDocs.RegisterInEngine

class function Tkw_MainMenuWithProfNews_Control_lblLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblLastOpenDocs';
end;//Tkw_MainMenuWithProfNews_Control_lblLastOpenDocs.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_lblLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblLastOpenDocs');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_lblLastOpenDocs_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_lblLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lblLastOpenDocs:push';
end;//Tkw_MainMenuWithProfNews_Control_lblLastOpenDocs_Push.GetWordNameForRegister

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
 Result := '�������::bvlLeft';
end;//Tkw_MainMenuWithProfNews_Control_bvlLeft.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_bvlLeft_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('bvlLeft');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_bvlLeft_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_bvlLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::bvlLeft:push';
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
 Result := '�������::bvlRight';
end;//Tkw_MainMenuWithProfNews_Control_bvlRight.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_bvlRight_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('bvlRight');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_bvlRight_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_bvlRight_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::bvlRight:push';
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
 Result := '���������::ieIO';
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
 Result := '�������::hfReferences';
end;//Tkw_MainMenuWithProfNews_Control_hfReferences.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_hfReferences_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfReferences');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_hfReferences_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_hfReferences_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::hfReferences:push';
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
 Result := '�������::tvReferences';
end;//Tkw_MainMenuWithProfNews_Control_tvReferences.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_tvReferences_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvReferences');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_tvReferences_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_tvReferences_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvReferences:push';
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
 Result := '�������::hfLawNews';
end;//Tkw_MainMenuWithProfNews_Control_hfLawNews.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_hfLawNews_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfLawNews');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_hfLawNews_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_hfLawNews_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::hfLawNews:push';
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
 Result := '�������::tvLawNews';
end;//Tkw_MainMenuWithProfNews_Control_tvLawNews.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_tvLawNews_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvLawNews');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_tvLawNews_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_tvLawNews_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvLawNews:push';
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
 Result := '�������::pnlMain';
end;//Tkw_MainMenuWithProfNews_Control_pnlMain.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_pnlMain_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlMain');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_pnlMain_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_pnlMain_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlMain:push';
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
 Result := '�������::hfLastOpenDocs';
end;//Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfLastOpenDocs');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::hfLastOpenDocs:push';
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
 Result := '�������::tvLastOpenDocs';
end;//Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs.GetWordNameForRegister

procedure Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvLastOpenDocs');
 inherited;
end;//Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push.DoDoIt

class function Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvLastOpenDocs:push';
end;//Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPnlLeft.pnlLeft(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlLeft }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlLeft(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlLeft.DoDoIt

class function TkwEnMainMenuWithProfNewsPnlLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlLeft';
end;//TkwEnMainMenuWithProfNewsPnlLeft.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsPnlLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlLeft', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlLeft.SetValuePrim

function TkwEnMainMenuWithProfNewsBvlLeftTop.bvlLeftTop(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TBevel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.bvlLeftTop }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(bvlLeftTop(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsBvlLeftTop.DoDoIt

class function TkwEnMainMenuWithProfNewsBvlLeftTop.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.bvlLeftTop';
end;//TkwEnMainMenuWithProfNewsBvlLeftTop.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsBvlLeftTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� bvlLeftTop', aCtx);
end;//TkwEnMainMenuWithProfNewsBvlLeftTop.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlLogo.pnlLogo(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlLogo }
begin
 Result := aen_MainMenuWithProfNews.pnlLogo;
end;//TkwEnMainMenuWithProfNewsPnlLogo.pnlLogo

procedure TkwEnMainMenuWithProfNewsPnlLogo.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlLogo(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlLogo.DoDoIt

class function TkwEnMainMenuWithProfNewsPnlLogo.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlLogo';
end;//TkwEnMainMenuWithProfNewsPnlLogo.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPnlLogo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuWithProfNewsPnlLogo.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPnlLogo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPnlLogo.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPnlLogo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPnlLogo.ParamsTypes

procedure TkwEnMainMenuWithProfNewsPnlLogo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlLogo', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlLogo.SetValuePrim

function TkwEnMainMenuWithProfNewsPbLogo.pbLogo(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TPaintBox;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pbLogo }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbLogo(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPbLogo.DoDoIt

class function TkwEnMainMenuWithProfNewsPbLogo.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pbLogo';
end;//TkwEnMainMenuWithProfNewsPbLogo.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsPbLogo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pbLogo', aCtx);
end;//TkwEnMainMenuWithProfNewsPbLogo.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlBanner.pnlBanner(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlBanner }
begin
 Result := aen_MainMenuWithProfNews.pnlBanner;
end;//TkwEnMainMenuWithProfNewsPnlBanner.pnlBanner

procedure TkwEnMainMenuWithProfNewsPnlBanner.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlBanner(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlBanner.DoDoIt

class function TkwEnMainMenuWithProfNewsPnlBanner.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlBanner';
end;//TkwEnMainMenuWithProfNewsPnlBanner.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPnlBanner.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuWithProfNewsPnlBanner.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPnlBanner.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPnlBanner.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPnlBanner.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPnlBanner.ParamsTypes

procedure TkwEnMainMenuWithProfNewsPnlBanner.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlBanner', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlBanner.SetValuePrim

function TkwEnMainMenuWithProfNewsIeBanner.ieBanner(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TImageEnView;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.ieBanner }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ieBanner(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsIeBanner.DoDoIt

class function TkwEnMainMenuWithProfNewsIeBanner.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.ieBanner';
end;//TkwEnMainMenuWithProfNewsIeBanner.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsIeBanner.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ieBanner', aCtx);
end;//TkwEnMainMenuWithProfNewsIeBanner.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlFeedback.pnlFeedback(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlFeedback }
begin
 Result := aen_MainMenuWithProfNews.pnlFeedback;
end;//TkwEnMainMenuWithProfNewsPnlFeedback.pnlFeedback

procedure TkwEnMainMenuWithProfNewsPnlFeedback.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlFeedback(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlFeedback.DoDoIt

class function TkwEnMainMenuWithProfNewsPnlFeedback.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlFeedback';
end;//TkwEnMainMenuWithProfNewsPnlFeedback.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPnlFeedback.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuWithProfNewsPnlFeedback.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPnlFeedback.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPnlFeedback.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPnlFeedback.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPnlFeedback.ParamsTypes

procedure TkwEnMainMenuWithProfNewsPnlFeedback.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlFeedback', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlFeedback.SetValuePrim

function TkwEnMainMenuWithProfNewsPbFeedback.pbFeedback(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TPaintBox;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pbFeedback }
begin
 Result := aen_MainMenuWithProfNews.pbFeedback;
end;//TkwEnMainMenuWithProfNewsPbFeedback.pbFeedback

procedure TkwEnMainMenuWithProfNewsPbFeedback.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbFeedback(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPbFeedback.DoDoIt

class function TkwEnMainMenuWithProfNewsPbFeedback.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pbFeedback';
end;//TkwEnMainMenuWithProfNewsPbFeedback.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPbFeedback.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnMainMenuWithProfNewsPbFeedback.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPbFeedback.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPbFeedback.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPbFeedback.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPbFeedback.ParamsTypes

procedure TkwEnMainMenuWithProfNewsPbFeedback.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pbFeedback', aCtx);
end;//TkwEnMainMenuWithProfNewsPbFeedback.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlOnlineResources.pnlOnlineResources(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlOnlineResources }
begin
 Result := aen_MainMenuWithProfNews.pnlOnlineResources;
end;//TkwEnMainMenuWithProfNewsPnlOnlineResources.pnlOnlineResources

procedure TkwEnMainMenuWithProfNewsPnlOnlineResources.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlOnlineResources(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlOnlineResources.DoDoIt

class function TkwEnMainMenuWithProfNewsPnlOnlineResources.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlOnlineResources';
end;//TkwEnMainMenuWithProfNewsPnlOnlineResources.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPnlOnlineResources.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuWithProfNewsPnlOnlineResources.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPnlOnlineResources.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPnlOnlineResources.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPnlOnlineResources.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPnlOnlineResources.ParamsTypes

procedure TkwEnMainMenuWithProfNewsPnlOnlineResources.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlOnlineResources', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlOnlineResources.SetValuePrim

function TkwEnMainMenuWithProfNewsPbOnlineResources.pbOnlineResources(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TPaintBox;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pbOnlineResources }
begin
 Result := aen_MainMenuWithProfNews.pbOnlineResources;
end;//TkwEnMainMenuWithProfNewsPbOnlineResources.pbOnlineResources

procedure TkwEnMainMenuWithProfNewsPbOnlineResources.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbOnlineResources(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPbOnlineResources.DoDoIt

class function TkwEnMainMenuWithProfNewsPbOnlineResources.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pbOnlineResources';
end;//TkwEnMainMenuWithProfNewsPbOnlineResources.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPbOnlineResources.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnMainMenuWithProfNewsPbOnlineResources.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPbOnlineResources.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPbOnlineResources.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPbOnlineResources.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPbOnlineResources.ParamsTypes

procedure TkwEnMainMenuWithProfNewsPbOnlineResources.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pbOnlineResources', aCtx);
end;//TkwEnMainMenuWithProfNewsPbOnlineResources.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlWebVersion.pnlWebVersion(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlWebVersion }
begin
 Result := aen_MainMenuWithProfNews.pnlWebVersion;
end;//TkwEnMainMenuWithProfNewsPnlWebVersion.pnlWebVersion

procedure TkwEnMainMenuWithProfNewsPnlWebVersion.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlWebVersion(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlWebVersion.DoDoIt

class function TkwEnMainMenuWithProfNewsPnlWebVersion.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlWebVersion';
end;//TkwEnMainMenuWithProfNewsPnlWebVersion.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPnlWebVersion.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuWithProfNewsPnlWebVersion.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPnlWebVersion.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPnlWebVersion.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPnlWebVersion.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPnlWebVersion.ParamsTypes

procedure TkwEnMainMenuWithProfNewsPnlWebVersion.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlWebVersion', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlWebVersion.SetValuePrim

function TkwEnMainMenuWithProfNewsPbWebVersion.pbWebVersion(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TPaintBox;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pbWebVersion }
begin
 Result := aen_MainMenuWithProfNews.pbWebVersion;
end;//TkwEnMainMenuWithProfNewsPbWebVersion.pbWebVersion

procedure TkwEnMainMenuWithProfNewsPbWebVersion.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbWebVersion(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPbWebVersion.DoDoIt

class function TkwEnMainMenuWithProfNewsPbWebVersion.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pbWebVersion';
end;//TkwEnMainMenuWithProfNewsPbWebVersion.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPbWebVersion.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEnMainMenuWithProfNewsPbWebVersion.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPbWebVersion.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPbWebVersion.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPbWebVersion.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPbWebVersion.ParamsTypes

procedure TkwEnMainMenuWithProfNewsPbWebVersion.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pbWebVersion', aCtx);
end;//TkwEnMainMenuWithProfNewsPbWebVersion.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlClient.pnlClient(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlClient }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlClient(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlClient.DoDoIt

class function TkwEnMainMenuWithProfNewsPnlClient.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlClient';
end;//TkwEnMainMenuWithProfNewsPnlClient.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsPnlClient.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlClient', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlClient.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlNews.pnlNews(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlNews }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlNews(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlNews.DoDoIt

class function TkwEnMainMenuWithProfNewsPnlNews.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlNews';
end;//TkwEnMainMenuWithProfNewsPnlNews.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsPnlNews.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlNews', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlNews.SetValuePrim

function TkwEnMainMenuWithProfNewsTvProfNews.tvProfNews(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.tvProfNews }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvProfNews(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsTvProfNews.DoDoIt

class function TkwEnMainMenuWithProfNewsTvProfNews.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.tvProfNews';
end;//TkwEnMainMenuWithProfNewsTvProfNews.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsTvProfNews.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvProfNews', aCtx);
end;//TkwEnMainMenuWithProfNewsTvProfNews.SetValuePrim

function TkwEnMainMenuWithProfNewsLblProfNews.lblProfNews(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscComboLabel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.lblProfNews }
begin
 Result := aen_MainMenuWithProfNews.lblProfNews;
end;//TkwEnMainMenuWithProfNewsLblProfNews.lblProfNews

procedure TkwEnMainMenuWithProfNewsLblProfNews.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblProfNews(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsLblProfNews.DoDoIt

class function TkwEnMainMenuWithProfNewsLblProfNews.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.lblProfNews';
end;//TkwEnMainMenuWithProfNewsLblProfNews.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsLblProfNews.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscComboLabel);
end;//TkwEnMainMenuWithProfNewsLblProfNews.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsLblProfNews.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsLblProfNews.GetAllParamsCount

function TkwEnMainMenuWithProfNewsLblProfNews.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsLblProfNews.ParamsTypes

procedure TkwEnMainMenuWithProfNewsLblProfNews.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblProfNews', aCtx);
end;//TkwEnMainMenuWithProfNewsLblProfNews.SetValuePrim

function TkwEnMainMenuWithProfNewsLblLawNews.lblLawNews(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtStyledLabel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.lblLawNews }
begin
 Result := aen_MainMenuWithProfNews.lblLawNews;
end;//TkwEnMainMenuWithProfNewsLblLawNews.lblLawNews

procedure TkwEnMainMenuWithProfNewsLblLawNews.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblLawNews(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsLblLawNews.DoDoIt

class function TkwEnMainMenuWithProfNewsLblLawNews.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.lblLawNews';
end;//TkwEnMainMenuWithProfNewsLblLawNews.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsLblLawNews.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtStyledLabel);
end;//TkwEnMainMenuWithProfNewsLblLawNews.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsLblLawNews.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsLblLawNews.GetAllParamsCount

function TkwEnMainMenuWithProfNewsLblLawNews.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsLblLawNews.ParamsTypes

procedure TkwEnMainMenuWithProfNewsLblLawNews.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblLawNews', aCtx);
end;//TkwEnMainMenuWithProfNewsLblLawNews.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlBaseSearch.pnlBaseSearch(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlBaseSearch }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlBaseSearch(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlBaseSearch.DoDoIt

class function TkwEnMainMenuWithProfNewsPnlBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlBaseSearch';
end;//TkwEnMainMenuWithProfNewsPnlBaseSearch.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsPnlBaseSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlBaseSearch', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlBaseSearch.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlBaseSearchZone.pnlBaseSearchZone(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlBaseSearchZone }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlBaseSearchZone(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlBaseSearchZone.DoDoIt

class function TkwEnMainMenuWithProfNewsPnlBaseSearchZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlBaseSearchZone';
end;//TkwEnMainMenuWithProfNewsPnlBaseSearchZone.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsPnlBaseSearchZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlBaseSearchZone', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlBaseSearchZone.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlSearches.pnlSearches(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlSearches }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlSearches(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlSearches.DoDoIt

class function TkwEnMainMenuWithProfNewsPnlSearches.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlSearches';
end;//TkwEnMainMenuWithProfNewsPnlSearches.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsPnlSearches.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlSearches', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlSearches.SetValuePrim

function TkwEnMainMenuWithProfNewsFlAttributeSearch.flAttributeSearch(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscFocusLabel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.flAttributeSearch }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(flAttributeSearch(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsFlAttributeSearch.DoDoIt

class function TkwEnMainMenuWithProfNewsFlAttributeSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.flAttributeSearch';
end;//TkwEnMainMenuWithProfNewsFlAttributeSearch.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsFlAttributeSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� flAttributeSearch', aCtx);
end;//TkwEnMainMenuWithProfNewsFlAttributeSearch.SetValuePrim

function TkwEnMainMenuWithProfNewsFlDictionSearch.flDictionSearch(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscFocusLabel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.flDictionSearch }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(flDictionSearch(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsFlDictionSearch.DoDoIt

class function TkwEnMainMenuWithProfNewsFlDictionSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.flDictionSearch';
end;//TkwEnMainMenuWithProfNewsFlDictionSearch.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsFlDictionSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� flDictionSearch', aCtx);
end;//TkwEnMainMenuWithProfNewsFlDictionSearch.SetValuePrim

function TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.flPublishedSourceSearch(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscFocusLabel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.flPublishedSourceSearch }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(flPublishedSourceSearch(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.DoDoIt

class function TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.flPublishedSourceSearch';
end;//TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� flPublishedSourceSearch', aCtx);
end;//TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.SetValuePrim

function TkwEnMainMenuWithProfNewsFlSituationSearch.flSituationSearch(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscFocusLabel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.flSituationSearch }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(flSituationSearch(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsFlSituationSearch.DoDoIt

class function TkwEnMainMenuWithProfNewsFlSituationSearch.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.flSituationSearch';
end;//TkwEnMainMenuWithProfNewsFlSituationSearch.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsFlSituationSearch.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� flSituationSearch', aCtx);
end;//TkwEnMainMenuWithProfNewsFlSituationSearch.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlTrees.pnlTrees(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlTrees }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlTrees(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlTrees.DoDoIt

class function TkwEnMainMenuWithProfNewsPnlTrees.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlTrees';
end;//TkwEnMainMenuWithProfNewsPnlTrees.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsPnlTrees.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlTrees', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlTrees.SetValuePrim

function TkwEnMainMenuWithProfNewsTvTaxes.tvTaxes(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.tvTaxes }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvTaxes(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsTvTaxes.DoDoIt

class function TkwEnMainMenuWithProfNewsTvTaxes.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.tvTaxes';
end;//TkwEnMainMenuWithProfNewsTvTaxes.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsTvTaxes.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvTaxes', aCtx);
end;//TkwEnMainMenuWithProfNewsTvTaxes.SetValuePrim

function TkwEnMainMenuWithProfNewsLblReferences.lblReferences(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtStyledLabel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.lblReferences }
begin
 Result := aen_MainMenuWithProfNews.lblReferences;
end;//TkwEnMainMenuWithProfNewsLblReferences.lblReferences

procedure TkwEnMainMenuWithProfNewsLblReferences.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblReferences(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsLblReferences.DoDoIt

class function TkwEnMainMenuWithProfNewsLblReferences.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.lblReferences';
end;//TkwEnMainMenuWithProfNewsLblReferences.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsLblReferences.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtStyledLabel);
end;//TkwEnMainMenuWithProfNewsLblReferences.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsLblReferences.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsLblReferences.GetAllParamsCount

function TkwEnMainMenuWithProfNewsLblReferences.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsLblReferences.ParamsTypes

procedure TkwEnMainMenuWithProfNewsLblReferences.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblReferences', aCtx);
end;//TkwEnMainMenuWithProfNewsLblReferences.SetValuePrim

function TkwEnMainMenuWithProfNewsLblTaxes.lblTaxes(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscComboLabel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.lblTaxes }
begin
 Result := aen_MainMenuWithProfNews.lblTaxes;
end;//TkwEnMainMenuWithProfNewsLblTaxes.lblTaxes

procedure TkwEnMainMenuWithProfNewsLblTaxes.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblTaxes(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsLblTaxes.DoDoIt

class function TkwEnMainMenuWithProfNewsLblTaxes.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.lblTaxes';
end;//TkwEnMainMenuWithProfNewsLblTaxes.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsLblTaxes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscComboLabel);
end;//TkwEnMainMenuWithProfNewsLblTaxes.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsLblTaxes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsLblTaxes.GetAllParamsCount

function TkwEnMainMenuWithProfNewsLblTaxes.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsLblTaxes.ParamsTypes

procedure TkwEnMainMenuWithProfNewsLblTaxes.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblTaxes', aCtx);
end;//TkwEnMainMenuWithProfNewsLblTaxes.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlLastOpenDocs.pnlLastOpenDocs(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlLastOpenDocs }
begin
 Result := aen_MainMenuWithProfNews.pnlLastOpenDocs;
end;//TkwEnMainMenuWithProfNewsPnlLastOpenDocs.pnlLastOpenDocs

procedure TkwEnMainMenuWithProfNewsPnlLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlLastOpenDocs(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlLastOpenDocs.DoDoIt

class function TkwEnMainMenuWithProfNewsPnlLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlLastOpenDocs';
end;//TkwEnMainMenuWithProfNewsPnlLastOpenDocs.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsPnlLastOpenDocs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMainMenuWithProfNewsPnlLastOpenDocs.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsPnlLastOpenDocs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsPnlLastOpenDocs.GetAllParamsCount

function TkwEnMainMenuWithProfNewsPnlLastOpenDocs.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsPnlLastOpenDocs.ParamsTypes

procedure TkwEnMainMenuWithProfNewsPnlLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlLastOpenDocs', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlLastOpenDocs.SetValuePrim

function TkwEnMainMenuWithProfNewsLblLastOpenDocs.lblLastOpenDocs(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtStyledLabel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.lblLastOpenDocs }
begin
 Result := aen_MainMenuWithProfNews.lblLastOpenDocs;
end;//TkwEnMainMenuWithProfNewsLblLastOpenDocs.lblLastOpenDocs

procedure TkwEnMainMenuWithProfNewsLblLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
var l_aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews;
begin
 try
  l_aen_MainMenuWithProfNews := Ten_MainMenuWithProfNews(aCtx.rEngine.PopObjAs(Ten_MainMenuWithProfNews));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblLastOpenDocs(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsLblLastOpenDocs.DoDoIt

class function TkwEnMainMenuWithProfNewsLblLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.lblLastOpenDocs';
end;//TkwEnMainMenuWithProfNewsLblLastOpenDocs.GetWordNameForRegister

function TkwEnMainMenuWithProfNewsLblLastOpenDocs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtStyledLabel);
end;//TkwEnMainMenuWithProfNewsLblLastOpenDocs.GetResultTypeInfo

function TkwEnMainMenuWithProfNewsLblLastOpenDocs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMainMenuWithProfNewsLblLastOpenDocs.GetAllParamsCount

function TkwEnMainMenuWithProfNewsLblLastOpenDocs.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MainMenuWithProfNews)]);
end;//TkwEnMainMenuWithProfNewsLblLastOpenDocs.ParamsTypes

procedure TkwEnMainMenuWithProfNewsLblLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lblLastOpenDocs', aCtx);
end;//TkwEnMainMenuWithProfNewsLblLastOpenDocs.SetValuePrim

function TkwEnMainMenuWithProfNewsBvlLeft.bvlLeft(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TBevel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.bvlLeft }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(bvlLeft(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsBvlLeft.DoDoIt

class function TkwEnMainMenuWithProfNewsBvlLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.bvlLeft';
end;//TkwEnMainMenuWithProfNewsBvlLeft.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsBvlLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� bvlLeft', aCtx);
end;//TkwEnMainMenuWithProfNewsBvlLeft.SetValuePrim

function TkwEnMainMenuWithProfNewsBvlRight.bvlRight(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TBevel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.bvlRight }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(bvlRight(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsBvlRight.DoDoIt

class function TkwEnMainMenuWithProfNewsBvlRight.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.bvlRight';
end;//TkwEnMainMenuWithProfNewsBvlRight.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsBvlRight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� bvlRight', aCtx);
end;//TkwEnMainMenuWithProfNewsBvlRight.SetValuePrim

function TkwEnMainMenuWithProfNewsIeIO.ieIO(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TImageEnIO;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.ieIO }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ieIO(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsIeIO.DoDoIt

class function TkwEnMainMenuWithProfNewsIeIO.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.ieIO';
end;//TkwEnMainMenuWithProfNewsIeIO.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsIeIO.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ieIO', aCtx);
end;//TkwEnMainMenuWithProfNewsIeIO.SetValuePrim

function TkwEnMainMenuWithProfNewsHfReferences.hfReferences(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscHideField;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.hfReferences }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfReferences(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsHfReferences.DoDoIt

class function TkwEnMainMenuWithProfNewsHfReferences.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.hfReferences';
end;//TkwEnMainMenuWithProfNewsHfReferences.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsHfReferences.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� hfReferences', aCtx);
end;//TkwEnMainMenuWithProfNewsHfReferences.SetValuePrim

function TkwEnMainMenuWithProfNewsTvReferences.tvReferences(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.tvReferences }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvReferences(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsTvReferences.DoDoIt

class function TkwEnMainMenuWithProfNewsTvReferences.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.tvReferences';
end;//TkwEnMainMenuWithProfNewsTvReferences.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsTvReferences.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvReferences', aCtx);
end;//TkwEnMainMenuWithProfNewsTvReferences.SetValuePrim

function TkwEnMainMenuWithProfNewsHfLawNews.hfLawNews(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscHideField;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.hfLawNews }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfLawNews(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsHfLawNews.DoDoIt

class function TkwEnMainMenuWithProfNewsHfLawNews.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.hfLawNews';
end;//TkwEnMainMenuWithProfNewsHfLawNews.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsHfLawNews.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� hfLawNews', aCtx);
end;//TkwEnMainMenuWithProfNewsHfLawNews.SetValuePrim

function TkwEnMainMenuWithProfNewsTvLawNews.tvLawNews(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.tvLawNews }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvLawNews(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsTvLawNews.DoDoIt

class function TkwEnMainMenuWithProfNewsTvLawNews.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.tvLawNews';
end;//TkwEnMainMenuWithProfNewsTvLawNews.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsTvLawNews.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvLawNews', aCtx);
end;//TkwEnMainMenuWithProfNewsTvLawNews.SetValuePrim

function TkwEnMainMenuWithProfNewsPnlMain.pnlMain(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TvtPanel;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.pnlMain }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlMain(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsPnlMain.DoDoIt

class function TkwEnMainMenuWithProfNewsPnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.pnlMain';
end;//TkwEnMainMenuWithProfNewsPnlMain.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsPnlMain.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlMain', aCtx);
end;//TkwEnMainMenuWithProfNewsPnlMain.SetValuePrim

function TkwEnMainMenuWithProfNewsHfLastOpenDocs.hfLastOpenDocs(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscHideField;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.hfLastOpenDocs }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfLastOpenDocs(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsHfLastOpenDocs.DoDoIt

class function TkwEnMainMenuWithProfNewsHfLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.hfLastOpenDocs';
end;//TkwEnMainMenuWithProfNewsHfLastOpenDocs.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsHfLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� hfLastOpenDocs', aCtx);
end;//TkwEnMainMenuWithProfNewsHfLastOpenDocs.SetValuePrim

function TkwEnMainMenuWithProfNewsTvLastOpenDocs.tvLastOpenDocs(const aCtx: TtfwContext;
 aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews): TnscTreeViewHotTruck;
 {* ���������� ����� ������� .Ten_MainMenuWithProfNews.tvLastOpenDocs }
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
   RunnerError('������ ��� ��������� ��������� aen_MainMenuWithProfNews: Ten_MainMenuWithProfNews : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvLastOpenDocs(aCtx, l_aen_MainMenuWithProfNews));
end;//TkwEnMainMenuWithProfNewsTvLastOpenDocs.DoDoIt

class function TkwEnMainMenuWithProfNewsTvLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MainMenuWithProfNews.tvLastOpenDocs';
end;//TkwEnMainMenuWithProfNewsTvLastOpenDocs.GetWordNameForRegister

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

procedure TkwEnMainMenuWithProfNewsTvLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvLastOpenDocs', aCtx);
end;//TkwEnMainMenuWithProfNewsTvLastOpenDocs.SetValuePrim

initialization
 Tkw_Form_MainMenuWithProfNews.RegisterInEngine;
 {* ����������� Tkw_Form_MainMenuWithProfNews }
 Tkw_MainMenuWithProfNews_Control_pnlLeft.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlLeft }
 Tkw_MainMenuWithProfNews_Control_pnlLeft_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlLeft_Push }
 Tkw_MainMenuWithProfNews_Control_bvlLeftTop.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_bvlLeftTop }
 Tkw_MainMenuWithProfNews_Control_bvlLeftTop_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_bvlLeftTop_Push }
 Tkw_MainMenuWithProfNews_Control_pnlLogo.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlLogo }
 Tkw_MainMenuWithProfNews_Control_pnlLogo_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlLogo_Push }
 Tkw_MainMenuWithProfNews_Control_pbLogo.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pbLogo }
 Tkw_MainMenuWithProfNews_Control_pbLogo_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pbLogo_Push }
 Tkw_MainMenuWithProfNews_Control_pnlBanner.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlBanner }
 Tkw_MainMenuWithProfNews_Control_pnlBanner_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlBanner_Push }
 Tkw_MainMenuWithProfNews_Control_ieBanner.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_ieBanner }
 Tkw_MainMenuWithProfNews_Control_ieBanner_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_ieBanner_Push }
 Tkw_MainMenuWithProfNews_Control_pnlFeedback.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlFeedback }
 Tkw_MainMenuWithProfNews_Control_pnlFeedback_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlFeedback_Push }
 Tkw_MainMenuWithProfNews_Control_pbFeedback.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pbFeedback }
 Tkw_MainMenuWithProfNews_Control_pbFeedback_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pbFeedback_Push }
 Tkw_MainMenuWithProfNews_Control_pnlOnlineResources.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlOnlineResources }
 Tkw_MainMenuWithProfNews_Control_pnlOnlineResources_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlOnlineResources_Push }
 Tkw_MainMenuWithProfNews_Control_pbOnlineResources.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pbOnlineResources }
 Tkw_MainMenuWithProfNews_Control_pbOnlineResources_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pbOnlineResources_Push }
 Tkw_MainMenuWithProfNews_Control_pnlWebVersion.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlWebVersion }
 Tkw_MainMenuWithProfNews_Control_pnlWebVersion_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlWebVersion_Push }
 Tkw_MainMenuWithProfNews_Control_pbWebVersion.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pbWebVersion }
 Tkw_MainMenuWithProfNews_Control_pbWebVersion_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pbWebVersion_Push }
 Tkw_MainMenuWithProfNews_Control_pnlClient.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlClient }
 Tkw_MainMenuWithProfNews_Control_pnlClient_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlClient_Push }
 Tkw_MainMenuWithProfNews_Control_pnlNews.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlNews }
 Tkw_MainMenuWithProfNews_Control_pnlNews_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlNews_Push }
 Tkw_MainMenuWithProfNews_Control_tvProfNews.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_tvProfNews }
 Tkw_MainMenuWithProfNews_Control_tvProfNews_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_tvProfNews_Push }
 Tkw_MainMenuWithProfNews_Control_lblProfNews.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_lblProfNews }
 Tkw_MainMenuWithProfNews_Control_lblProfNews_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_lblProfNews_Push }
 Tkw_MainMenuWithProfNews_Control_lblLawNews.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_lblLawNews }
 Tkw_MainMenuWithProfNews_Control_lblLawNews_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_lblLawNews_Push }
 Tkw_MainMenuWithProfNews_Control_pnlBaseSearch.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlBaseSearch }
 Tkw_MainMenuWithProfNews_Control_pnlBaseSearch_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlBaseSearch_Push }
 Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone }
 Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlBaseSearchZone_Push }
 Tkw_MainMenuWithProfNews_Control_pnlSearches.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlSearches }
 Tkw_MainMenuWithProfNews_Control_pnlSearches_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlSearches_Push }
 Tkw_MainMenuWithProfNews_Control_flAttributeSearch.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_flAttributeSearch }
 Tkw_MainMenuWithProfNews_Control_flAttributeSearch_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_flAttributeSearch_Push }
 Tkw_MainMenuWithProfNews_Control_flDictionSearch.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_flDictionSearch }
 Tkw_MainMenuWithProfNews_Control_flDictionSearch_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_flDictionSearch_Push }
 Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch }
 Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_flPublishedSourceSearch_Push }
 Tkw_MainMenuWithProfNews_Control_flSituationSearch.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_flSituationSearch }
 Tkw_MainMenuWithProfNews_Control_flSituationSearch_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_flSituationSearch_Push }
 Tkw_MainMenuWithProfNews_Control_pnlTrees.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlTrees }
 Tkw_MainMenuWithProfNews_Control_pnlTrees_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlTrees_Push }
 Tkw_MainMenuWithProfNews_Control_tvTaxes.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_tvTaxes }
 Tkw_MainMenuWithProfNews_Control_tvTaxes_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_tvTaxes_Push }
 Tkw_MainMenuWithProfNews_Control_lblReferences.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_lblReferences }
 Tkw_MainMenuWithProfNews_Control_lblReferences_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_lblReferences_Push }
 Tkw_MainMenuWithProfNews_Control_lblTaxes.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_lblTaxes }
 Tkw_MainMenuWithProfNews_Control_lblTaxes_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_lblTaxes_Push }
 Tkw_MainMenuWithProfNews_Control_pnlLastOpenDocs.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlLastOpenDocs }
 Tkw_MainMenuWithProfNews_Control_pnlLastOpenDocs_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlLastOpenDocs_Push }
 Tkw_MainMenuWithProfNews_Control_lblLastOpenDocs.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_lblLastOpenDocs }
 Tkw_MainMenuWithProfNews_Control_lblLastOpenDocs_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_lblLastOpenDocs_Push }
 Tkw_MainMenuWithProfNews_Control_bvlLeft.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_bvlLeft }
 Tkw_MainMenuWithProfNews_Control_bvlLeft_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_bvlLeft_Push }
 Tkw_MainMenuWithProfNews_Control_bvlRight.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_bvlRight }
 Tkw_MainMenuWithProfNews_Control_bvlRight_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_bvlRight_Push }
 Tkw_MainMenuWithProfNews_Component_ieIO.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Component_ieIO }
 Tkw_MainMenuWithProfNews_Control_hfReferences.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_hfReferences }
 Tkw_MainMenuWithProfNews_Control_hfReferences_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_hfReferences_Push }
 Tkw_MainMenuWithProfNews_Control_tvReferences.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_tvReferences }
 Tkw_MainMenuWithProfNews_Control_tvReferences_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_tvReferences_Push }
 Tkw_MainMenuWithProfNews_Control_hfLawNews.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_hfLawNews }
 Tkw_MainMenuWithProfNews_Control_hfLawNews_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_hfLawNews_Push }
 Tkw_MainMenuWithProfNews_Control_tvLawNews.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_tvLawNews }
 Tkw_MainMenuWithProfNews_Control_tvLawNews_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_tvLawNews_Push }
 Tkw_MainMenuWithProfNews_Control_pnlMain.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlMain }
 Tkw_MainMenuWithProfNews_Control_pnlMain_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_pnlMain_Push }
 Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs }
 Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_hfLastOpenDocs_Push }
 Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs }
 Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push.RegisterInEngine;
 {* ����������� Tkw_MainMenuWithProfNews_Control_tvLastOpenDocs_Push }
 TkwEnMainMenuWithProfNewsPnlLeft.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_pnlLeft }
 TkwEnMainMenuWithProfNewsBvlLeftTop.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_bvlLeftTop }
 TkwEnMainMenuWithProfNewsPnlLogo.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_pnlLogo }
 TkwEnMainMenuWithProfNewsPbLogo.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_pbLogo }
 TkwEnMainMenuWithProfNewsPnlBanner.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_pnlBanner }
 TkwEnMainMenuWithProfNewsIeBanner.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_ieBanner }
 TkwEnMainMenuWithProfNewsPnlFeedback.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_pnlFeedback }
 TkwEnMainMenuWithProfNewsPbFeedback.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_pbFeedback }
 TkwEnMainMenuWithProfNewsPnlOnlineResources.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_pnlOnlineResources }
 TkwEnMainMenuWithProfNewsPbOnlineResources.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_pbOnlineResources }
 TkwEnMainMenuWithProfNewsPnlWebVersion.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_pnlWebVersion }
 TkwEnMainMenuWithProfNewsPbWebVersion.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_pbWebVersion }
 TkwEnMainMenuWithProfNewsPnlClient.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_pnlClient }
 TkwEnMainMenuWithProfNewsPnlNews.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_pnlNews }
 TkwEnMainMenuWithProfNewsTvProfNews.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_tvProfNews }
 TkwEnMainMenuWithProfNewsLblProfNews.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_lblProfNews }
 TkwEnMainMenuWithProfNewsLblLawNews.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_lblLawNews }
 TkwEnMainMenuWithProfNewsPnlBaseSearch.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_pnlBaseSearch }
 TkwEnMainMenuWithProfNewsPnlBaseSearchZone.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_pnlBaseSearchZone }
 TkwEnMainMenuWithProfNewsPnlSearches.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_pnlSearches }
 TkwEnMainMenuWithProfNewsFlAttributeSearch.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_flAttributeSearch }
 TkwEnMainMenuWithProfNewsFlDictionSearch.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_flDictionSearch }
 TkwEnMainMenuWithProfNewsFlPublishedSourceSearch.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_flPublishedSourceSearch }
 TkwEnMainMenuWithProfNewsFlSituationSearch.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_flSituationSearch }
 TkwEnMainMenuWithProfNewsPnlTrees.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_pnlTrees }
 TkwEnMainMenuWithProfNewsTvTaxes.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_tvTaxes }
 TkwEnMainMenuWithProfNewsLblReferences.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_lblReferences }
 TkwEnMainMenuWithProfNewsLblTaxes.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_lblTaxes }
 TkwEnMainMenuWithProfNewsPnlLastOpenDocs.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_pnlLastOpenDocs }
 TkwEnMainMenuWithProfNewsLblLastOpenDocs.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_lblLastOpenDocs }
 TkwEnMainMenuWithProfNewsBvlLeft.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_bvlLeft }
 TkwEnMainMenuWithProfNewsBvlRight.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_bvlRight }
 TkwEnMainMenuWithProfNewsIeIO.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_ieIO }
 TkwEnMainMenuWithProfNewsHfReferences.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_hfReferences }
 TkwEnMainMenuWithProfNewsTvReferences.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_tvReferences }
 TkwEnMainMenuWithProfNewsHfLawNews.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_hfLawNews }
 TkwEnMainMenuWithProfNewsTvLawNews.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_tvLawNews }
 TkwEnMainMenuWithProfNewsPnlMain.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_pnlMain }
 TkwEnMainMenuWithProfNewsHfLastOpenDocs.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_hfLastOpenDocs }
 TkwEnMainMenuWithProfNewsTvLastOpenDocs.RegisterInEngine;
 {* ����������� en_MainMenuWithProfNews_tvLastOpenDocs }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_MainMenuWithProfNews));
 {* ����������� ���� Ten_MainMenuWithProfNews }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TBevel));
 {* ����������� ���� TBevel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* ����������� ���� TPaintBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImageEnView));
 {* ����������� ���� TImageEnView }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewHotTruck));
 {* ����������� ���� TnscTreeViewHotTruck }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscComboLabel));
 {* ����������� ���� TnscComboLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtStyledLabel));
 {* ����������� ���� TvtStyledLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscFocusLabel));
 {* ����������� ���� TnscFocusLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImageEnIO));
 {* ����������� ���� TImageEnIO }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscHideField));
 {* ����������� ���� TnscHideField }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
