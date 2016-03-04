unit DictionContainerKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� DictionContainer }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\DictionContainerKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtProportionalPanel
 , vtSizeablePanel
 , vtPanel
 , vtLabel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , DictionContainer_Form
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
 Tkw_Form_DictionContainer = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� DictionContainer
----
*������ �������������*:
[code]
'aControl' �����::DictionContainer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_DictionContainer

 Tkw_DictionContainer_Control_pnBackground = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnBackground
----
*������ �������������*:
[code]
�������::pnBackground TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DictionContainer_Control_pnBackground

 Tkw_DictionContainer_Control_pnBackground_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnBackground
----
*������ �������������*:
[code]
�������::pnBackground:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_pnBackground_Push

 Tkw_DictionContainer_Control_NavigatorZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� NavigatorZone
----
*������ �������������*:
[code]
�������::NavigatorZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DictionContainer_Control_NavigatorZone

 Tkw_DictionContainer_Control_NavigatorZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� NavigatorZone
----
*������ �������������*:
[code]
�������::NavigatorZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_NavigatorZone_Push

 Tkw_DictionContainer_Control_pnWorkArea = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnWorkArea
----
*������ �������������*:
[code]
�������::pnWorkArea TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DictionContainer_Control_pnWorkArea

 Tkw_DictionContainer_Control_pnWorkArea_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnWorkArea
----
*������ �������������*:
[code]
�������::pnWorkArea:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_pnWorkArea_Push

 Tkw_DictionContainer_Control_ChildZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ChildZone
----
*������ �������������*:
[code]
�������::ChildZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DictionContainer_Control_ChildZone

 Tkw_DictionContainer_Control_ChildZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ChildZone
----
*������ �������������*:
[code]
�������::ChildZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_ChildZone_Push

 Tkw_DictionContainer_Control_pnHeader = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnHeader
----
*������ �������������*:
[code]
�������::pnHeader TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DictionContainer_Control_pnHeader

 Tkw_DictionContainer_Control_pnHeader_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnHeader
----
*������ �������������*:
[code]
�������::pnHeader:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_pnHeader_Push

 Tkw_DictionContainer_Control_lbHeader = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lbHeader
----
*������ �������������*:
[code]
�������::lbHeader TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DictionContainer_Control_lbHeader

 Tkw_DictionContainer_Control_lbHeader_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lbHeader
----
*������ �������������*:
[code]
�������::lbHeader:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_lbHeader_Push

 Tkw_DictionContainer_Control_pbHeader = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pbHeader
----
*������ �������������*:
[code]
�������::pbHeader TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DictionContainer_Control_pbHeader

 Tkw_DictionContainer_Control_pbHeader_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pbHeader
----
*������ �������������*:
[code]
�������::pbHeader:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_pbHeader_Push

 Tkw_DictionContainer_Control_ParentZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ParentZone
----
*������ �������������*:
[code]
�������::ParentZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DictionContainer_Control_ParentZone

 Tkw_DictionContainer_Control_ParentZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ParentZone
----
*������ �������������*:
[code]
�������::ParentZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_ParentZone_Push

 TkwDictionContainerFormPnBackground = {final} class(TtfwPropertyLike)
  {* ����� ������� .TDictionContainerForm.pnBackground
[panel]������� pnBackground ����� TDictionContainerForm[panel]
*��� ����������:* TvtProportionalPanel
*������:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aDictionContainerForm .TDictionContainerForm.pnBackground >>> l_TvtProportionalPanel
[code]  }
  private
   function pnBackground(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtProportionalPanel;
    {* ���������� ����� ������� .TDictionContainerForm.pnBackground }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDictionContainerFormPnBackground

 TkwDictionContainerFormNavigatorZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TDictionContainerForm.NavigatorZone
[panel]������� NavigatorZone ����� TDictionContainerForm[panel]
*��� ����������:* TvtSizeablePanel
*������:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aDictionContainerForm .TDictionContainerForm.NavigatorZone >>> l_TvtSizeablePanel
[code]  }
  private
   function NavigatorZone(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtSizeablePanel;
    {* ���������� ����� ������� .TDictionContainerForm.NavigatorZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDictionContainerFormNavigatorZone

 TkwDictionContainerFormPnWorkArea = {final} class(TtfwPropertyLike)
  {* ����� ������� .TDictionContainerForm.pnWorkArea
[panel]������� pnWorkArea ����� TDictionContainerForm[panel]
*��� ����������:* TvtProportionalPanel
*������:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aDictionContainerForm .TDictionContainerForm.pnWorkArea >>> l_TvtProportionalPanel
[code]  }
  private
   function pnWorkArea(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtProportionalPanel;
    {* ���������� ����� ������� .TDictionContainerForm.pnWorkArea }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDictionContainerFormPnWorkArea

 TkwDictionContainerFormChildZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TDictionContainerForm.ChildZone
[panel]������� ChildZone ����� TDictionContainerForm[panel]
*��� ����������:* TvtSizeablePanel
*������:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aDictionContainerForm .TDictionContainerForm.ChildZone >>> l_TvtSizeablePanel
[code]  }
  private
   function ChildZone(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtSizeablePanel;
    {* ���������� ����� ������� .TDictionContainerForm.ChildZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDictionContainerFormChildZone

 TkwDictionContainerFormPnHeader = {final} class(TtfwPropertyLike)
  {* ����� ������� .TDictionContainerForm.pnHeader
[panel]������� pnHeader ����� TDictionContainerForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aDictionContainerForm .TDictionContainerForm.pnHeader >>> l_TvtPanel
[code]  }
  private
   function pnHeader(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtPanel;
    {* ���������� ����� ������� .TDictionContainerForm.pnHeader }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDictionContainerFormPnHeader

 TkwDictionContainerFormLbHeader = {final} class(TtfwPropertyLike)
  {* ����� ������� .TDictionContainerForm.lbHeader
[panel]������� lbHeader ����� TDictionContainerForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aDictionContainerForm .TDictionContainerForm.lbHeader >>> l_TvtLabel
[code]  }
  private
   function lbHeader(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtLabel;
    {* ���������� ����� ������� .TDictionContainerForm.lbHeader }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDictionContainerFormLbHeader

 TkwDictionContainerFormPbHeader = {final} class(TtfwPropertyLike)
  {* ����� ������� .TDictionContainerForm.pbHeader
[panel]������� pbHeader ����� TDictionContainerForm[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aDictionContainerForm .TDictionContainerForm.pbHeader >>> l_TPaintBox
[code]  }
  private
   function pbHeader(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TPaintBox;
    {* ���������� ����� ������� .TDictionContainerForm.pbHeader }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDictionContainerFormPbHeader

 TkwDictionContainerFormParentZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TDictionContainerForm.ParentZone
[panel]������� ParentZone ����� TDictionContainerForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aDictionContainerForm .TDictionContainerForm.ParentZone >>> l_TvtPanel
[code]  }
  private
   function ParentZone(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtPanel;
    {* ���������� ����� ������� .TDictionContainerForm.ParentZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDictionContainerFormParentZone

class function Tkw_Form_DictionContainer.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::DictionContainer';
end;//Tkw_Form_DictionContainer.GetWordNameForRegister

function Tkw_Form_DictionContainer.GetString: AnsiString;
begin
 Result := 'DictionContainerForm';
end;//Tkw_Form_DictionContainer.GetString

class function Tkw_DictionContainer_Control_pnBackground.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnBackground';
end;//Tkw_DictionContainer_Control_pnBackground.GetWordNameForRegister

function Tkw_DictionContainer_Control_pnBackground.GetString: AnsiString;
begin
 Result := 'pnBackground';
end;//Tkw_DictionContainer_Control_pnBackground.GetString

class procedure Tkw_DictionContainer_Control_pnBackground.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_DictionContainer_Control_pnBackground.RegisterInEngine

procedure Tkw_DictionContainer_Control_pnBackground_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnBackground');
 inherited;
end;//Tkw_DictionContainer_Control_pnBackground_Push.DoDoIt

class function Tkw_DictionContainer_Control_pnBackground_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnBackground:push';
end;//Tkw_DictionContainer_Control_pnBackground_Push.GetWordNameForRegister

class function Tkw_DictionContainer_Control_NavigatorZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NavigatorZone';
end;//Tkw_DictionContainer_Control_NavigatorZone.GetWordNameForRegister

function Tkw_DictionContainer_Control_NavigatorZone.GetString: AnsiString;
begin
 Result := 'NavigatorZone';
end;//Tkw_DictionContainer_Control_NavigatorZone.GetString

class procedure Tkw_DictionContainer_Control_NavigatorZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_DictionContainer_Control_NavigatorZone.RegisterInEngine

procedure Tkw_DictionContainer_Control_NavigatorZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('NavigatorZone');
 inherited;
end;//Tkw_DictionContainer_Control_NavigatorZone_Push.DoDoIt

class function Tkw_DictionContainer_Control_NavigatorZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NavigatorZone:push';
end;//Tkw_DictionContainer_Control_NavigatorZone_Push.GetWordNameForRegister

class function Tkw_DictionContainer_Control_pnWorkArea.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnWorkArea';
end;//Tkw_DictionContainer_Control_pnWorkArea.GetWordNameForRegister

function Tkw_DictionContainer_Control_pnWorkArea.GetString: AnsiString;
begin
 Result := 'pnWorkArea';
end;//Tkw_DictionContainer_Control_pnWorkArea.GetString

class procedure Tkw_DictionContainer_Control_pnWorkArea.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_DictionContainer_Control_pnWorkArea.RegisterInEngine

procedure Tkw_DictionContainer_Control_pnWorkArea_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnWorkArea');
 inherited;
end;//Tkw_DictionContainer_Control_pnWorkArea_Push.DoDoIt

class function Tkw_DictionContainer_Control_pnWorkArea_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnWorkArea:push';
end;//Tkw_DictionContainer_Control_pnWorkArea_Push.GetWordNameForRegister

class function Tkw_DictionContainer_Control_ChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZone';
end;//Tkw_DictionContainer_Control_ChildZone.GetWordNameForRegister

function Tkw_DictionContainer_Control_ChildZone.GetString: AnsiString;
begin
 Result := 'ChildZone';
end;//Tkw_DictionContainer_Control_ChildZone.GetString

class procedure Tkw_DictionContainer_Control_ChildZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_DictionContainer_Control_ChildZone.RegisterInEngine

procedure Tkw_DictionContainer_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ChildZone');
 inherited;
end;//Tkw_DictionContainer_Control_ChildZone_Push.DoDoIt

class function Tkw_DictionContainer_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZone:push';
end;//Tkw_DictionContainer_Control_ChildZone_Push.GetWordNameForRegister

class function Tkw_DictionContainer_Control_pnHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnHeader';
end;//Tkw_DictionContainer_Control_pnHeader.GetWordNameForRegister

function Tkw_DictionContainer_Control_pnHeader.GetString: AnsiString;
begin
 Result := 'pnHeader';
end;//Tkw_DictionContainer_Control_pnHeader.GetString

class procedure Tkw_DictionContainer_Control_pnHeader.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_DictionContainer_Control_pnHeader.RegisterInEngine

procedure Tkw_DictionContainer_Control_pnHeader_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnHeader');
 inherited;
end;//Tkw_DictionContainer_Control_pnHeader_Push.DoDoIt

class function Tkw_DictionContainer_Control_pnHeader_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnHeader:push';
end;//Tkw_DictionContainer_Control_pnHeader_Push.GetWordNameForRegister

class function Tkw_DictionContainer_Control_lbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lbHeader';
end;//Tkw_DictionContainer_Control_lbHeader.GetWordNameForRegister

function Tkw_DictionContainer_Control_lbHeader.GetString: AnsiString;
begin
 Result := 'lbHeader';
end;//Tkw_DictionContainer_Control_lbHeader.GetString

class procedure Tkw_DictionContainer_Control_lbHeader.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_DictionContainer_Control_lbHeader.RegisterInEngine

procedure Tkw_DictionContainer_Control_lbHeader_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lbHeader');
 inherited;
end;//Tkw_DictionContainer_Control_lbHeader_Push.DoDoIt

class function Tkw_DictionContainer_Control_lbHeader_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lbHeader:push';
end;//Tkw_DictionContainer_Control_lbHeader_Push.GetWordNameForRegister

class function Tkw_DictionContainer_Control_pbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbHeader';
end;//Tkw_DictionContainer_Control_pbHeader.GetWordNameForRegister

function Tkw_DictionContainer_Control_pbHeader.GetString: AnsiString;
begin
 Result := 'pbHeader';
end;//Tkw_DictionContainer_Control_pbHeader.GetString

class procedure Tkw_DictionContainer_Control_pbHeader.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_DictionContainer_Control_pbHeader.RegisterInEngine

procedure Tkw_DictionContainer_Control_pbHeader_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbHeader');
 inherited;
end;//Tkw_DictionContainer_Control_pbHeader_Push.DoDoIt

class function Tkw_DictionContainer_Control_pbHeader_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbHeader:push';
end;//Tkw_DictionContainer_Control_pbHeader_Push.GetWordNameForRegister

class function Tkw_DictionContainer_Control_ParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZone';
end;//Tkw_DictionContainer_Control_ParentZone.GetWordNameForRegister

function Tkw_DictionContainer_Control_ParentZone.GetString: AnsiString;
begin
 Result := 'ParentZone';
end;//Tkw_DictionContainer_Control_ParentZone.GetString

class procedure Tkw_DictionContainer_Control_ParentZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_DictionContainer_Control_ParentZone.RegisterInEngine

procedure Tkw_DictionContainer_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ParentZone');
 inherited;
end;//Tkw_DictionContainer_Control_ParentZone_Push.DoDoIt

class function Tkw_DictionContainer_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZone:push';
end;//Tkw_DictionContainer_Control_ParentZone_Push.GetWordNameForRegister

function TkwDictionContainerFormPnBackground.pnBackground(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtProportionalPanel;
 {* ���������� ����� ������� .TDictionContainerForm.pnBackground }
begin
 Result := aDictionContainerForm.pnBackground;
end;//TkwDictionContainerFormPnBackground.pnBackground

procedure TkwDictionContainerFormPnBackground.DoDoIt(const aCtx: TtfwContext);
var l_aDictionContainerForm: TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnBackground(aCtx, l_aDictionContainerForm));
end;//TkwDictionContainerFormPnBackground.DoDoIt

class function TkwDictionContainerFormPnBackground.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.pnBackground';
end;//TkwDictionContainerFormPnBackground.GetWordNameForRegister

procedure TkwDictionContainerFormPnBackground.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnBackground', aCtx);
end;//TkwDictionContainerFormPnBackground.SetValuePrim

function TkwDictionContainerFormPnBackground.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwDictionContainerFormPnBackground.GetResultTypeInfo

function TkwDictionContainerFormPnBackground.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormPnBackground.GetAllParamsCount

function TkwDictionContainerFormPnBackground.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormPnBackground.ParamsTypes

function TkwDictionContainerFormNavigatorZone.NavigatorZone(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtSizeablePanel;
 {* ���������� ����� ������� .TDictionContainerForm.NavigatorZone }
begin
 Result := aDictionContainerForm.NavigatorZone;
end;//TkwDictionContainerFormNavigatorZone.NavigatorZone

procedure TkwDictionContainerFormNavigatorZone.DoDoIt(const aCtx: TtfwContext);
var l_aDictionContainerForm: TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(NavigatorZone(aCtx, l_aDictionContainerForm));
end;//TkwDictionContainerFormNavigatorZone.DoDoIt

class function TkwDictionContainerFormNavigatorZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.NavigatorZone';
end;//TkwDictionContainerFormNavigatorZone.GetWordNameForRegister

procedure TkwDictionContainerFormNavigatorZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� NavigatorZone', aCtx);
end;//TkwDictionContainerFormNavigatorZone.SetValuePrim

function TkwDictionContainerFormNavigatorZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwDictionContainerFormNavigatorZone.GetResultTypeInfo

function TkwDictionContainerFormNavigatorZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormNavigatorZone.GetAllParamsCount

function TkwDictionContainerFormNavigatorZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormNavigatorZone.ParamsTypes

function TkwDictionContainerFormPnWorkArea.pnWorkArea(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtProportionalPanel;
 {* ���������� ����� ������� .TDictionContainerForm.pnWorkArea }
begin
 Result := aDictionContainerForm.pnWorkArea;
end;//TkwDictionContainerFormPnWorkArea.pnWorkArea

procedure TkwDictionContainerFormPnWorkArea.DoDoIt(const aCtx: TtfwContext);
var l_aDictionContainerForm: TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnWorkArea(aCtx, l_aDictionContainerForm));
end;//TkwDictionContainerFormPnWorkArea.DoDoIt

class function TkwDictionContainerFormPnWorkArea.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.pnWorkArea';
end;//TkwDictionContainerFormPnWorkArea.GetWordNameForRegister

procedure TkwDictionContainerFormPnWorkArea.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnWorkArea', aCtx);
end;//TkwDictionContainerFormPnWorkArea.SetValuePrim

function TkwDictionContainerFormPnWorkArea.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwDictionContainerFormPnWorkArea.GetResultTypeInfo

function TkwDictionContainerFormPnWorkArea.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormPnWorkArea.GetAllParamsCount

function TkwDictionContainerFormPnWorkArea.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormPnWorkArea.ParamsTypes

function TkwDictionContainerFormChildZone.ChildZone(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtSizeablePanel;
 {* ���������� ����� ������� .TDictionContainerForm.ChildZone }
begin
 Result := aDictionContainerForm.ChildZone;
end;//TkwDictionContainerFormChildZone.ChildZone

procedure TkwDictionContainerFormChildZone.DoDoIt(const aCtx: TtfwContext);
var l_aDictionContainerForm: TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ChildZone(aCtx, l_aDictionContainerForm));
end;//TkwDictionContainerFormChildZone.DoDoIt

class function TkwDictionContainerFormChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.ChildZone';
end;//TkwDictionContainerFormChildZone.GetWordNameForRegister

procedure TkwDictionContainerFormChildZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ChildZone', aCtx);
end;//TkwDictionContainerFormChildZone.SetValuePrim

function TkwDictionContainerFormChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwDictionContainerFormChildZone.GetResultTypeInfo

function TkwDictionContainerFormChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormChildZone.GetAllParamsCount

function TkwDictionContainerFormChildZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormChildZone.ParamsTypes

function TkwDictionContainerFormPnHeader.pnHeader(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtPanel;
 {* ���������� ����� ������� .TDictionContainerForm.pnHeader }
begin
 Result := aDictionContainerForm.pnHeader;
end;//TkwDictionContainerFormPnHeader.pnHeader

procedure TkwDictionContainerFormPnHeader.DoDoIt(const aCtx: TtfwContext);
var l_aDictionContainerForm: TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnHeader(aCtx, l_aDictionContainerForm));
end;//TkwDictionContainerFormPnHeader.DoDoIt

class function TkwDictionContainerFormPnHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.pnHeader';
end;//TkwDictionContainerFormPnHeader.GetWordNameForRegister

procedure TkwDictionContainerFormPnHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnHeader', aCtx);
end;//TkwDictionContainerFormPnHeader.SetValuePrim

function TkwDictionContainerFormPnHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwDictionContainerFormPnHeader.GetResultTypeInfo

function TkwDictionContainerFormPnHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormPnHeader.GetAllParamsCount

function TkwDictionContainerFormPnHeader.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormPnHeader.ParamsTypes

function TkwDictionContainerFormLbHeader.lbHeader(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtLabel;
 {* ���������� ����� ������� .TDictionContainerForm.lbHeader }
begin
 Result := aDictionContainerForm.lbHeader;
end;//TkwDictionContainerFormLbHeader.lbHeader

procedure TkwDictionContainerFormLbHeader.DoDoIt(const aCtx: TtfwContext);
var l_aDictionContainerForm: TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lbHeader(aCtx, l_aDictionContainerForm));
end;//TkwDictionContainerFormLbHeader.DoDoIt

class function TkwDictionContainerFormLbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.lbHeader';
end;//TkwDictionContainerFormLbHeader.GetWordNameForRegister

procedure TkwDictionContainerFormLbHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� lbHeader', aCtx);
end;//TkwDictionContainerFormLbHeader.SetValuePrim

function TkwDictionContainerFormLbHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwDictionContainerFormLbHeader.GetResultTypeInfo

function TkwDictionContainerFormLbHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormLbHeader.GetAllParamsCount

function TkwDictionContainerFormLbHeader.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormLbHeader.ParamsTypes

function TkwDictionContainerFormPbHeader.pbHeader(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TPaintBox;
 {* ���������� ����� ������� .TDictionContainerForm.pbHeader }
begin
 Result := aDictionContainerForm.pbHeader;
end;//TkwDictionContainerFormPbHeader.pbHeader

procedure TkwDictionContainerFormPbHeader.DoDoIt(const aCtx: TtfwContext);
var l_aDictionContainerForm: TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbHeader(aCtx, l_aDictionContainerForm));
end;//TkwDictionContainerFormPbHeader.DoDoIt

class function TkwDictionContainerFormPbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.pbHeader';
end;//TkwDictionContainerFormPbHeader.GetWordNameForRegister

procedure TkwDictionContainerFormPbHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pbHeader', aCtx);
end;//TkwDictionContainerFormPbHeader.SetValuePrim

function TkwDictionContainerFormPbHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwDictionContainerFormPbHeader.GetResultTypeInfo

function TkwDictionContainerFormPbHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormPbHeader.GetAllParamsCount

function TkwDictionContainerFormPbHeader.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormPbHeader.ParamsTypes

function TkwDictionContainerFormParentZone.ParentZone(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtPanel;
 {* ���������� ����� ������� .TDictionContainerForm.ParentZone }
begin
 Result := aDictionContainerForm.ParentZone;
end;//TkwDictionContainerFormParentZone.ParentZone

procedure TkwDictionContainerFormParentZone.DoDoIt(const aCtx: TtfwContext);
var l_aDictionContainerForm: TDictionContainerForm;
begin
 try
  l_aDictionContainerForm := TDictionContainerForm(aCtx.rEngine.PopObjAs(TDictionContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aDictionContainerForm: TDictionContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ParentZone(aCtx, l_aDictionContainerForm));
end;//TkwDictionContainerFormParentZone.DoDoIt

class function TkwDictionContainerFormParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.ParentZone';
end;//TkwDictionContainerFormParentZone.GetWordNameForRegister

procedure TkwDictionContainerFormParentZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ParentZone', aCtx);
end;//TkwDictionContainerFormParentZone.SetValuePrim

function TkwDictionContainerFormParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwDictionContainerFormParentZone.GetResultTypeInfo

function TkwDictionContainerFormParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormParentZone.GetAllParamsCount

function TkwDictionContainerFormParentZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TDictionContainerForm)]);
end;//TkwDictionContainerFormParentZone.ParamsTypes

initialization
 Tkw_Form_DictionContainer.RegisterInEngine;
 {* ����������� Tkw_Form_DictionContainer }
 Tkw_DictionContainer_Control_pnBackground.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_pnBackground }
 Tkw_DictionContainer_Control_pnBackground_Push.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_pnBackground_Push }
 Tkw_DictionContainer_Control_NavigatorZone.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_NavigatorZone }
 Tkw_DictionContainer_Control_NavigatorZone_Push.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_NavigatorZone_Push }
 Tkw_DictionContainer_Control_pnWorkArea.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_pnWorkArea }
 Tkw_DictionContainer_Control_pnWorkArea_Push.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_pnWorkArea_Push }
 Tkw_DictionContainer_Control_ChildZone.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_ChildZone }
 Tkw_DictionContainer_Control_ChildZone_Push.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_ChildZone_Push }
 Tkw_DictionContainer_Control_pnHeader.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_pnHeader }
 Tkw_DictionContainer_Control_pnHeader_Push.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_pnHeader_Push }
 Tkw_DictionContainer_Control_lbHeader.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_lbHeader }
 Tkw_DictionContainer_Control_lbHeader_Push.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_lbHeader_Push }
 Tkw_DictionContainer_Control_pbHeader.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_pbHeader }
 Tkw_DictionContainer_Control_pbHeader_Push.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_pbHeader_Push }
 Tkw_DictionContainer_Control_ParentZone.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_ParentZone }
 Tkw_DictionContainer_Control_ParentZone_Push.RegisterInEngine;
 {* ����������� Tkw_DictionContainer_Control_ParentZone_Push }
 TkwDictionContainerFormPnBackground.RegisterInEngine;
 {* ����������� DictionContainerForm_pnBackground }
 TkwDictionContainerFormNavigatorZone.RegisterInEngine;
 {* ����������� DictionContainerForm_NavigatorZone }
 TkwDictionContainerFormPnWorkArea.RegisterInEngine;
 {* ����������� DictionContainerForm_pnWorkArea }
 TkwDictionContainerFormChildZone.RegisterInEngine;
 {* ����������� DictionContainerForm_ChildZone }
 TkwDictionContainerFormPnHeader.RegisterInEngine;
 {* ����������� DictionContainerForm_pnHeader }
 TkwDictionContainerFormLbHeader.RegisterInEngine;
 {* ����������� DictionContainerForm_lbHeader }
 TkwDictionContainerFormPbHeader.RegisterInEngine;
 {* ����������� DictionContainerForm_pbHeader }
 TkwDictionContainerFormParentZone.RegisterInEngine;
 {* ����������� DictionContainerForm_ParentZone }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TDictionContainerForm));
 {* ����������� ���� DictionContainer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* ����������� ���� TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* ����������� ���� TvtSizeablePanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* ����������� ���� TPaintBox }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
