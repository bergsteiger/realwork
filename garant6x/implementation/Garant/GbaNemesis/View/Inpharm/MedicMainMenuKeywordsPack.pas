unit MedicMainMenuKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� MedicMainMenu }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\MedicMainMenuKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "MedicMainMenuKeywordsPack" MUID: (38469909CBE6)

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
 , tfwTypeInfo
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_MedicMainMenu = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� MedicMainMenu
----
*������ �������������*:
[code]
'aControl' �����::MedicMainMenu TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_MedicMainMenu

 Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� hfReferencesAndDictionaries
----
*������ �������������*:
[code]
�������::hfReferencesAndDictionaries TryFocus ASSERT
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
  {* ����� ������� ��� �������� hfReferencesAndDictionaries
----
*������ �������������*:
[code]
�������::hfReferencesAndDictionaries:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push

 Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvReferencesAndDictionaries
----
*������ �������������*:
[code]
�������::tvReferencesAndDictionaries TryFocus ASSERT
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
  {* ����� ������� ��� �������� tvReferencesAndDictionaries
----
*������ �������������*:
[code]
�������::tvReferencesAndDictionaries:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push

 Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� hfReferencePharmaceuticalInformation
----
*������ �������������*:
[code]
�������::hfReferencePharmaceuticalInformation TryFocus ASSERT
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
  {* ����� ������� ��� �������� hfReferencePharmaceuticalInformation
----
*������ �������������*:
[code]
�������::hfReferencePharmaceuticalInformation:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push

 Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvReferencePharmaceuticalInformation
----
*������ �������������*:
[code]
�������::tvReferencePharmaceuticalInformation TryFocus ASSERT
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
  {* ����� ������� ��� �������� tvReferencePharmaceuticalInformation
----
*������ �������������*:
[code]
�������::tvReferencePharmaceuticalInformation:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push

 Tkw_MedicMainMenu_Control_hfMainFeatures = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� hfMainFeatures
----
*������ �������������*:
[code]
�������::hfMainFeatures TryFocus ASSERT
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
  {* ����� ������� ��� �������� hfMainFeatures
----
*������ �������������*:
[code]
�������::hfMainFeatures:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_hfMainFeatures_Push

 Tkw_MedicMainMenu_Control_tvMainFeatures = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvMainFeatures
----
*������ �������������*:
[code]
�������::tvMainFeatures TryFocus ASSERT
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
  {* ����� ������� ��� �������� tvMainFeatures
----
*������ �������������*:
[code]
�������::tvMainFeatures:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_tvMainFeatures_Push

 Tkw_MedicMainMenu_Control_hfRegulatoryInformation = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� hfRegulatoryInformation
----
*������ �������������*:
[code]
�������::hfRegulatoryInformation TryFocus ASSERT
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
  {* ����� ������� ��� �������� hfRegulatoryInformation
----
*������ �������������*:
[code]
�������::hfRegulatoryInformation:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push

 Tkw_MedicMainMenu_Control_tvRegulatoryInformation = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� tvRegulatoryInformation
----
*������ �������������*:
[code]
�������::tvRegulatoryInformation TryFocus ASSERT
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
  {* ����� ������� ��� �������� tvRegulatoryInformation
----
*������ �������������*:
[code]
�������::tvRegulatoryInformation:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push

 Tkw_MedicMainMenu_Control_pnlMain = {final} class(TtfwControlString)
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
 end;//Tkw_MedicMainMenu_Control_pnlMain

 Tkw_MedicMainMenu_Control_pnlMain_Push = {final} class({$If NOT Defined(NoVCL)}
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
 end;//Tkw_MedicMainMenu_Control_pnlMain_Push

 Tkw_MedicMainMenu_Control_hfLastOpenDocs = {final} class(TtfwControlString)
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
 end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs

 Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push = {final} class({$If NOT Defined(NoVCL)}
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
 end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push

 Tkw_MedicMainMenu_Control_tvLastOpenDocs = {final} class(TtfwControlString)
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
 end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs

 Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push = {final} class({$If NOT Defined(NoVCL)}
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
 end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push

 TkwEnMedicMainMenuHfReferencesAndDictionaries = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MedicMainMenu.hfReferencesAndDictionaries
[panel]������� hfReferencesAndDictionaries ����� Ten_MedicMainMenu[panel]
*��� ����������:* TnscHideField
*������:*
[code]
OBJECT VAR l_TnscHideField
 aen_MedicMainMenu .Ten_MedicMainMenu.hfReferencesAndDictionaries >>> l_TnscHideField
[code]  }
  private
   function hfReferencesAndDictionaries(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
    {* ���������� ����� ������� .Ten_MedicMainMenu.hfReferencesAndDictionaries }
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
  {* ����� ������� .Ten_MedicMainMenu.tvReferencesAndDictionaries
[panel]������� tvReferencesAndDictionaries ����� Ten_MedicMainMenu[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aen_MedicMainMenu .Ten_MedicMainMenu.tvReferencesAndDictionaries >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function tvReferencesAndDictionaries(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .Ten_MedicMainMenu.tvReferencesAndDictionaries }
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
  {* ����� ������� .Ten_MedicMainMenu.hfReferencePharmaceuticalInformation
[panel]������� hfReferencePharmaceuticalInformation ����� Ten_MedicMainMenu[panel]
*��� ����������:* TnscHideField
*������:*
[code]
OBJECT VAR l_TnscHideField
 aen_MedicMainMenu .Ten_MedicMainMenu.hfReferencePharmaceuticalInformation >>> l_TnscHideField
[code]  }
  private
   function hfReferencePharmaceuticalInformation(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
    {* ���������� ����� ������� .Ten_MedicMainMenu.hfReferencePharmaceuticalInformation }
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
  {* ����� ������� .Ten_MedicMainMenu.tvReferencePharmaceuticalInformation
[panel]������� tvReferencePharmaceuticalInformation ����� Ten_MedicMainMenu[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aen_MedicMainMenu .Ten_MedicMainMenu.tvReferencePharmaceuticalInformation >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function tvReferencePharmaceuticalInformation(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .Ten_MedicMainMenu.tvReferencePharmaceuticalInformation }
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
  {* ����� ������� .Ten_MedicMainMenu.hfMainFeatures
[panel]������� hfMainFeatures ����� Ten_MedicMainMenu[panel]
*��� ����������:* TnscHideField
*������:*
[code]
OBJECT VAR l_TnscHideField
 aen_MedicMainMenu .Ten_MedicMainMenu.hfMainFeatures >>> l_TnscHideField
[code]  }
  private
   function hfMainFeatures(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
    {* ���������� ����� ������� .Ten_MedicMainMenu.hfMainFeatures }
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
  {* ����� ������� .Ten_MedicMainMenu.tvMainFeatures
[panel]������� tvMainFeatures ����� Ten_MedicMainMenu[panel]
*��� ����������:* TnscTreeViewHotTruck
*������:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aen_MedicMainMenu .Ten_MedicMainMenu.tvMainFeatures >>> l_TnscTreeViewHotTruck
[code]  }
  private
   function tvMainFeatures(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewHotTruck;
    {* ���������� ����� ������� .Ten_MedicMainMenu.tvMainFeatures }
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
  {* ����� ������� .Ten_MedicMainMenu.hfRegulatoryInformation
[panel]������� hfRegulatoryInformation ����� Ten_MedicMainMenu[panel]
*��� ����������:* TnscHideField
*������:*
[code]
OBJECT VAR l_TnscHideField
 aen_MedicMainMenu .Ten_MedicMainMenu.hfRegulatoryInformation >>> l_TnscHideField
[code]  }
  private
   function hfRegulatoryInformation(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
    {* ���������� ����� ������� .Ten_MedicMainMenu.hfRegulatoryInformation }
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
  {* ����� ������� .Ten_MedicMainMenu.tvRegulatoryInformation
[panel]������� tvRegulatoryInformation ����� Ten_MedicMainMenu[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aen_MedicMainMenu .Ten_MedicMainMenu.tvRegulatoryInformation >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function tvRegulatoryInformation(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .Ten_MedicMainMenu.tvRegulatoryInformation }
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
  {* ����� ������� .Ten_MedicMainMenu.pnlMain
[panel]������� pnlMain ����� Ten_MedicMainMenu[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aen_MedicMainMenu .Ten_MedicMainMenu.pnlMain >>> l_TvtPanel
[code]  }
  private
   function pnlMain(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TvtPanel;
    {* ���������� ����� ������� .Ten_MedicMainMenu.pnlMain }
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
  {* ����� ������� .Ten_MedicMainMenu.hfLastOpenDocs
[panel]������� hfLastOpenDocs ����� Ten_MedicMainMenu[panel]
*��� ����������:* TnscHideField
*������:*
[code]
OBJECT VAR l_TnscHideField
 aen_MedicMainMenu .Ten_MedicMainMenu.hfLastOpenDocs >>> l_TnscHideField
[code]  }
  private
   function hfLastOpenDocs(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
    {* ���������� ����� ������� .Ten_MedicMainMenu.hfLastOpenDocs }
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
  {* ����� ������� .Ten_MedicMainMenu.tvLastOpenDocs
[panel]������� tvLastOpenDocs ����� Ten_MedicMainMenu[panel]
*��� ����������:* TnscTreeViewHotTruck
*������:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aen_MedicMainMenu .Ten_MedicMainMenu.tvLastOpenDocs >>> l_TnscTreeViewHotTruck
[code]  }
  private
   function tvLastOpenDocs(const aCtx: TtfwContext;
    aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewHotTruck;
    {* ���������� ����� ������� .Ten_MedicMainMenu.tvLastOpenDocs }
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

function Tkw_Form_MedicMainMenu.GetString: AnsiString;
begin
 Result := 'en_MedicMainMenu';
end;//Tkw_Form_MedicMainMenu.GetString

class function Tkw_Form_MedicMainMenu.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::MedicMainMenu';
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
 Result := '�������::hfReferencesAndDictionaries';
end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfReferencesAndDictionaries');
 inherited;
end;//Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::hfReferencesAndDictionaries:push';
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
 Result := '�������::tvReferencesAndDictionaries';
end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvReferencesAndDictionaries');
 inherited;
end;//Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvReferencesAndDictionaries:push';
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
 Result := '�������::hfReferencePharmaceuticalInformation';
end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfReferencePharmaceuticalInformation');
 inherited;
end;//Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::hfReferencePharmaceuticalInformation:push';
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
 Result := '�������::tvReferencePharmaceuticalInformation';
end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvReferencePharmaceuticalInformation');
 inherited;
end;//Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvReferencePharmaceuticalInformation:push';
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
 Result := '�������::hfMainFeatures';
end;//Tkw_MedicMainMenu_Control_hfMainFeatures.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_hfMainFeatures_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfMainFeatures');
 inherited;
end;//Tkw_MedicMainMenu_Control_hfMainFeatures_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfMainFeatures_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::hfMainFeatures:push';
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
 Result := '�������::tvMainFeatures';
end;//Tkw_MedicMainMenu_Control_tvMainFeatures.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_tvMainFeatures_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvMainFeatures');
 inherited;
end;//Tkw_MedicMainMenu_Control_tvMainFeatures_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvMainFeatures_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvMainFeatures:push';
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
 Result := '�������::hfRegulatoryInformation';
end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfRegulatoryInformation');
 inherited;
end;//Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::hfRegulatoryInformation:push';
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
 Result := '�������::tvRegulatoryInformation';
end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvRegulatoryInformation');
 inherited;
end;//Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvRegulatoryInformation:push';
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
 Result := '�������::pnlMain';
end;//Tkw_MedicMainMenu_Control_pnlMain.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_pnlMain_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlMain');
 inherited;
end;//Tkw_MedicMainMenu_Control_pnlMain_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_pnlMain_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlMain:push';
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
 Result := '�������::hfLastOpenDocs';
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('hfLastOpenDocs');
 inherited;
end;//Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::hfLastOpenDocs:push';
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
 Result := '�������::tvLastOpenDocs';
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs.GetWordNameForRegister

procedure Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvLastOpenDocs');
 inherited;
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.DoDoIt

class function Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::tvLastOpenDocs:push';
end;//Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.GetWordNameForRegister

function TkwEnMedicMainMenuHfReferencesAndDictionaries.hfReferencesAndDictionaries(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {* ���������� ����� ������� .Ten_MedicMainMenu.hfReferencesAndDictionaries }
begin
 Result := aen_MedicMainMenu.hfReferencesAndDictionaries;
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.hfReferencesAndDictionaries

procedure TkwEnMedicMainMenuHfReferencesAndDictionaries.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfReferencesAndDictionaries(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.DoDoIt

procedure TkwEnMedicMainMenuHfReferencesAndDictionaries.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� hfReferencesAndDictionaries', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.ParamsTypes

class function TkwEnMedicMainMenuHfReferencesAndDictionaries.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.hfReferencesAndDictionaries';
end;//TkwEnMedicMainMenuHfReferencesAndDictionaries.GetWordNameForRegister

function TkwEnMedicMainMenuTvReferencesAndDictionaries.tvReferencesAndDictionaries(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .Ten_MedicMainMenu.tvReferencesAndDictionaries }
begin
 Result := aen_MedicMainMenu.tvReferencesAndDictionaries;
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.tvReferencesAndDictionaries

procedure TkwEnMedicMainMenuTvReferencesAndDictionaries.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvReferencesAndDictionaries(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.DoDoIt

procedure TkwEnMedicMainMenuTvReferencesAndDictionaries.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvReferencesAndDictionaries', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.ParamsTypes

class function TkwEnMedicMainMenuTvReferencesAndDictionaries.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.tvReferencesAndDictionaries';
end;//TkwEnMedicMainMenuTvReferencesAndDictionaries.GetWordNameForRegister

function TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.hfReferencePharmaceuticalInformation(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {* ���������� ����� ������� .Ten_MedicMainMenu.hfReferencePharmaceuticalInformation }
begin
 Result := aen_MedicMainMenu.hfReferencePharmaceuticalInformation;
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.hfReferencePharmaceuticalInformation

procedure TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfReferencePharmaceuticalInformation(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.DoDoIt

procedure TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� hfReferencePharmaceuticalInformation', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.ParamsTypes

class function TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.hfReferencePharmaceuticalInformation';
end;//TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.GetWordNameForRegister

function TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.tvReferencePharmaceuticalInformation(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .Ten_MedicMainMenu.tvReferencePharmaceuticalInformation }
begin
 Result := aen_MedicMainMenu.tvReferencePharmaceuticalInformation;
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.tvReferencePharmaceuticalInformation

procedure TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvReferencePharmaceuticalInformation(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.DoDoIt

procedure TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvReferencePharmaceuticalInformation', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.ParamsTypes

class function TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.tvReferencePharmaceuticalInformation';
end;//TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.GetWordNameForRegister

function TkwEnMedicMainMenuHfMainFeatures.hfMainFeatures(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {* ���������� ����� ������� .Ten_MedicMainMenu.hfMainFeatures }
begin
 Result := aen_MedicMainMenu.hfMainFeatures;
end;//TkwEnMedicMainMenuHfMainFeatures.hfMainFeatures

procedure TkwEnMedicMainMenuHfMainFeatures.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfMainFeatures(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuHfMainFeatures.DoDoIt

procedure TkwEnMedicMainMenuHfMainFeatures.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� hfMainFeatures', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuHfMainFeatures.ParamsTypes

class function TkwEnMedicMainMenuHfMainFeatures.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.hfMainFeatures';
end;//TkwEnMedicMainMenuHfMainFeatures.GetWordNameForRegister

function TkwEnMedicMainMenuTvMainFeatures.tvMainFeatures(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewHotTruck;
 {* ���������� ����� ������� .Ten_MedicMainMenu.tvMainFeatures }
begin
 Result := aen_MedicMainMenu.tvMainFeatures;
end;//TkwEnMedicMainMenuTvMainFeatures.tvMainFeatures

procedure TkwEnMedicMainMenuTvMainFeatures.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvMainFeatures(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuTvMainFeatures.DoDoIt

procedure TkwEnMedicMainMenuTvMainFeatures.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvMainFeatures', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuTvMainFeatures.ParamsTypes

class function TkwEnMedicMainMenuTvMainFeatures.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.tvMainFeatures';
end;//TkwEnMedicMainMenuTvMainFeatures.GetWordNameForRegister

function TkwEnMedicMainMenuHfRegulatoryInformation.hfRegulatoryInformation(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {* ���������� ����� ������� .Ten_MedicMainMenu.hfRegulatoryInformation }
begin
 Result := aen_MedicMainMenu.hfRegulatoryInformation;
end;//TkwEnMedicMainMenuHfRegulatoryInformation.hfRegulatoryInformation

procedure TkwEnMedicMainMenuHfRegulatoryInformation.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfRegulatoryInformation(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuHfRegulatoryInformation.DoDoIt

procedure TkwEnMedicMainMenuHfRegulatoryInformation.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� hfRegulatoryInformation', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuHfRegulatoryInformation.ParamsTypes

class function TkwEnMedicMainMenuHfRegulatoryInformation.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.hfRegulatoryInformation';
end;//TkwEnMedicMainMenuHfRegulatoryInformation.GetWordNameForRegister

function TkwEnMedicMainMenuTvRegulatoryInformation.tvRegulatoryInformation(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .Ten_MedicMainMenu.tvRegulatoryInformation }
begin
 Result := aen_MedicMainMenu.tvRegulatoryInformation;
end;//TkwEnMedicMainMenuTvRegulatoryInformation.tvRegulatoryInformation

procedure TkwEnMedicMainMenuTvRegulatoryInformation.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvRegulatoryInformation(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuTvRegulatoryInformation.DoDoIt

procedure TkwEnMedicMainMenuTvRegulatoryInformation.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvRegulatoryInformation', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuTvRegulatoryInformation.ParamsTypes

class function TkwEnMedicMainMenuTvRegulatoryInformation.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.tvRegulatoryInformation';
end;//TkwEnMedicMainMenuTvRegulatoryInformation.GetWordNameForRegister

function TkwEnMedicMainMenuPnlMain.pnlMain(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TvtPanel;
 {* ���������� ����� ������� .Ten_MedicMainMenu.pnlMain }
begin
 Result := aen_MedicMainMenu.pnlMain;
end;//TkwEnMedicMainMenuPnlMain.pnlMain

procedure TkwEnMedicMainMenuPnlMain.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlMain(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuPnlMain.DoDoIt

procedure TkwEnMedicMainMenuPnlMain.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlMain', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuPnlMain.ParamsTypes

class function TkwEnMedicMainMenuPnlMain.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.pnlMain';
end;//TkwEnMedicMainMenuPnlMain.GetWordNameForRegister

function TkwEnMedicMainMenuHfLastOpenDocs.hfLastOpenDocs(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscHideField;
 {* ���������� ����� ������� .Ten_MedicMainMenu.hfLastOpenDocs }
begin
 Result := aen_MedicMainMenu.hfLastOpenDocs;
end;//TkwEnMedicMainMenuHfLastOpenDocs.hfLastOpenDocs

procedure TkwEnMedicMainMenuHfLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(hfLastOpenDocs(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuHfLastOpenDocs.DoDoIt

procedure TkwEnMedicMainMenuHfLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� hfLastOpenDocs', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuHfLastOpenDocs.ParamsTypes

class function TkwEnMedicMainMenuHfLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.hfLastOpenDocs';
end;//TkwEnMedicMainMenuHfLastOpenDocs.GetWordNameForRegister

function TkwEnMedicMainMenuTvLastOpenDocs.tvLastOpenDocs(const aCtx: TtfwContext;
 aen_MedicMainMenu: Ten_MedicMainMenu): TnscTreeViewHotTruck;
 {* ���������� ����� ������� .Ten_MedicMainMenu.tvLastOpenDocs }
begin
 Result := aen_MedicMainMenu.tvLastOpenDocs;
end;//TkwEnMedicMainMenuTvLastOpenDocs.tvLastOpenDocs

procedure TkwEnMedicMainMenuTvLastOpenDocs.DoDoIt(const aCtx: TtfwContext);
var l_aen_MedicMainMenu: Ten_MedicMainMenu;
begin
 try
  l_aen_MedicMainMenu := Ten_MedicMainMenu(aCtx.rEngine.PopObjAs(Ten_MedicMainMenu));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MedicMainMenu: Ten_MedicMainMenu : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvLastOpenDocs(aCtx, l_aen_MedicMainMenu));
end;//TkwEnMedicMainMenuTvLastOpenDocs.DoDoIt

procedure TkwEnMedicMainMenuTvLastOpenDocs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� tvLastOpenDocs', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicMainMenu)]);
end;//TkwEnMedicMainMenuTvLastOpenDocs.ParamsTypes

class function TkwEnMedicMainMenuTvLastOpenDocs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicMainMenu.tvLastOpenDocs';
end;//TkwEnMedicMainMenuTvLastOpenDocs.GetWordNameForRegister

initialization
 Tkw_Form_MedicMainMenu.RegisterInEngine;
 {* ����������� Tkw_Form_MedicMainMenu }
 Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries }
 Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_hfReferencesAndDictionaries_Push }
 Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries }
 Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_tvReferencesAndDictionaries_Push }
 Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation }
 Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_hfReferencePharmaceuticalInformation_Push }
 Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation }
 Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_tvReferencePharmaceuticalInformation_Push }
 Tkw_MedicMainMenu_Control_hfMainFeatures.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_hfMainFeatures }
 Tkw_MedicMainMenu_Control_hfMainFeatures_Push.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_hfMainFeatures_Push }
 Tkw_MedicMainMenu_Control_tvMainFeatures.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_tvMainFeatures }
 Tkw_MedicMainMenu_Control_tvMainFeatures_Push.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_tvMainFeatures_Push }
 Tkw_MedicMainMenu_Control_hfRegulatoryInformation.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_hfRegulatoryInformation }
 Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_hfRegulatoryInformation_Push }
 Tkw_MedicMainMenu_Control_tvRegulatoryInformation.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_tvRegulatoryInformation }
 Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_tvRegulatoryInformation_Push }
 Tkw_MedicMainMenu_Control_pnlMain.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_pnlMain }
 Tkw_MedicMainMenu_Control_pnlMain_Push.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_pnlMain_Push }
 Tkw_MedicMainMenu_Control_hfLastOpenDocs.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_hfLastOpenDocs }
 Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_hfLastOpenDocs_Push }
 Tkw_MedicMainMenu_Control_tvLastOpenDocs.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_tvLastOpenDocs }
 Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push.RegisterInEngine;
 {* ����������� Tkw_MedicMainMenu_Control_tvLastOpenDocs_Push }
 TkwEnMedicMainMenuHfReferencesAndDictionaries.RegisterInEngine;
 {* ����������� en_MedicMainMenu_hfReferencesAndDictionaries }
 TkwEnMedicMainMenuTvReferencesAndDictionaries.RegisterInEngine;
 {* ����������� en_MedicMainMenu_tvReferencesAndDictionaries }
 TkwEnMedicMainMenuHfReferencePharmaceuticalInformation.RegisterInEngine;
 {* ����������� en_MedicMainMenu_hfReferencePharmaceuticalInformation }
 TkwEnMedicMainMenuTvReferencePharmaceuticalInformation.RegisterInEngine;
 {* ����������� en_MedicMainMenu_tvReferencePharmaceuticalInformation }
 TkwEnMedicMainMenuHfMainFeatures.RegisterInEngine;
 {* ����������� en_MedicMainMenu_hfMainFeatures }
 TkwEnMedicMainMenuTvMainFeatures.RegisterInEngine;
 {* ����������� en_MedicMainMenu_tvMainFeatures }
 TkwEnMedicMainMenuHfRegulatoryInformation.RegisterInEngine;
 {* ����������� en_MedicMainMenu_hfRegulatoryInformation }
 TkwEnMedicMainMenuTvRegulatoryInformation.RegisterInEngine;
 {* ����������� en_MedicMainMenu_tvRegulatoryInformation }
 TkwEnMedicMainMenuPnlMain.RegisterInEngine;
 {* ����������� en_MedicMainMenu_pnlMain }
 TkwEnMedicMainMenuHfLastOpenDocs.RegisterInEngine;
 {* ����������� en_MedicMainMenu_hfLastOpenDocs }
 TkwEnMedicMainMenuTvLastOpenDocs.RegisterInEngine;
 {* ����������� en_MedicMainMenu_tvLastOpenDocs }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_MedicMainMenu));
 {* ����������� ���� MedicMainMenu }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscHideField));
 {* ����������� ���� TnscHideField }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewHotTruck));
 {* ����������� ���� TnscTreeViewHotTruck }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
