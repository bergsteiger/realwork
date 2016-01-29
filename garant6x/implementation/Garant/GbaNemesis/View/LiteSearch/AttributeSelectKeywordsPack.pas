unit AttributeSelectKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/AttributeSelectKeywordsPack.pas"
// �����: 04.09.2009 14:23
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������� ����������� ���������� �������::SearchLite::View::LiteSearch::LiteSearch::AttributeSelectKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� AttributeSelect
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  AttributeSelect_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator,
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

type
  Tkw_Form_AttributeSelect = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� AttributeSelect
----
*������ �������������*:
[code]
'aControl' �����::AttributeSelect TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_AttributeSelect

// start class Tkw_Form_AttributeSelect

class function Tkw_Form_AttributeSelect.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::AttributeSelect';
end;//Tkw_Form_AttributeSelect.GetWordNameForRegister

function Tkw_Form_AttributeSelect.GetString: AnsiString;
 {-}
begin
 Result := 'cfAttributeSelect';
end;//Tkw_Form_AttributeSelect.GetString

type
  Tkw_AttributeSelect_Control_BackgroundPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AttributeSelect_Control_BackgroundPanel

// start class Tkw_AttributeSelect_Control_BackgroundPanel

class function Tkw_AttributeSelect_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_AttributeSelect_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_AttributeSelect_Control_BackgroundPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BackgroundPanel';
end;//Tkw_AttributeSelect_Control_BackgroundPanel.GetString

class procedure Tkw_AttributeSelect_Control_BackgroundPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_AttributeSelect_Control_BackgroundPanel.RegisterInEngine

type
  Tkw_AttributeSelect_Control_BackgroundPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AttributeSelect_Control_BackgroundPanel_Push

// start class Tkw_AttributeSelect_Control_BackgroundPanel_Push

procedure Tkw_AttributeSelect_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_AttributeSelect_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_AttributeSelect_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_AttributeSelect_Control_BackgroundPanel_Push.GetWordNameForRegister

type
  Tkw_AttributeSelect_Control_SelectedZone = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� SelectedZone
----
*������ �������������*:
[code]
�������::SelectedZone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AttributeSelect_Control_SelectedZone

// start class Tkw_AttributeSelect_Control_SelectedZone

class function Tkw_AttributeSelect_Control_SelectedZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::SelectedZone';
end;//Tkw_AttributeSelect_Control_SelectedZone.GetWordNameForRegister

function Tkw_AttributeSelect_Control_SelectedZone.GetString: AnsiString;
 {-}
begin
 Result := 'SelectedZone';
end;//Tkw_AttributeSelect_Control_SelectedZone.GetString

class procedure Tkw_AttributeSelect_Control_SelectedZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_AttributeSelect_Control_SelectedZone.RegisterInEngine

type
  Tkw_AttributeSelect_Control_SelectedZone_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� SelectedZone
----
*������ �������������*:
[code]
�������::SelectedZone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AttributeSelect_Control_SelectedZone_Push

// start class Tkw_AttributeSelect_Control_SelectedZone_Push

procedure Tkw_AttributeSelect_Control_SelectedZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('SelectedZone');
 inherited;
end;//Tkw_AttributeSelect_Control_SelectedZone_Push.DoDoIt

class function Tkw_AttributeSelect_Control_SelectedZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::SelectedZone:push';
end;//Tkw_AttributeSelect_Control_SelectedZone_Push.GetWordNameForRegister

type
  Tkw_AttributeSelect_Control_ValuesZone = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ValuesZone
----
*������ �������������*:
[code]
�������::ValuesZone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AttributeSelect_Control_ValuesZone

// start class Tkw_AttributeSelect_Control_ValuesZone

class function Tkw_AttributeSelect_Control_ValuesZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ValuesZone';
end;//Tkw_AttributeSelect_Control_ValuesZone.GetWordNameForRegister

function Tkw_AttributeSelect_Control_ValuesZone.GetString: AnsiString;
 {-}
begin
 Result := 'ValuesZone';
end;//Tkw_AttributeSelect_Control_ValuesZone.GetString

class procedure Tkw_AttributeSelect_Control_ValuesZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AttributeSelect_Control_ValuesZone.RegisterInEngine

type
  Tkw_AttributeSelect_Control_ValuesZone_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ValuesZone
----
*������ �������������*:
[code]
�������::ValuesZone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AttributeSelect_Control_ValuesZone_Push

// start class Tkw_AttributeSelect_Control_ValuesZone_Push

procedure Tkw_AttributeSelect_Control_ValuesZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ValuesZone');
 inherited;
end;//Tkw_AttributeSelect_Control_ValuesZone_Push.DoDoIt

class function Tkw_AttributeSelect_Control_ValuesZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ValuesZone:push';
end;//Tkw_AttributeSelect_Control_ValuesZone_Push.GetWordNameForRegister

type
  TkwCfAttributeSelectBackgroundPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TcfAttributeSelect.BackgroundPanel
[panel]������� BackgroundPanel ����� TcfAttributeSelect[panel]
*��� ����������:* TvtProportionalPanel
*������:*
[code]
OBJECT VAR l_TvtProportionalPanel
 acfAttributeSelect .TcfAttributeSelect.BackgroundPanel >>> l_TvtProportionalPanel
[code]  }
  private
  // private methods
   function BackgroundPanel(const aCtx: TtfwContext;
     acfAttributeSelect: TcfAttributeSelect): TvtProportionalPanel;
     {* ���������� ����� ������� .TcfAttributeSelect.BackgroundPanel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwCfAttributeSelectBackgroundPanel

// start class TkwCfAttributeSelectBackgroundPanel

function TkwCfAttributeSelectBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
  acfAttributeSelect: TcfAttributeSelect): TvtProportionalPanel;
 {-}
begin
 Result := acfAttributeSelect.BackgroundPanel;
end;//TkwCfAttributeSelectBackgroundPanel.BackgroundPanel

procedure TkwCfAttributeSelectBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfAttributeSelect : TcfAttributeSelect;
begin
 try
  l_acfAttributeSelect := TcfAttributeSelect(aCtx.rEngine.PopObjAs(TcfAttributeSelect));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� acfAttributeSelect: TcfAttributeSelect : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BackgroundPanel(aCtx, l_acfAttributeSelect)));
end;//TkwCfAttributeSelectBackgroundPanel.DoDoIt

class function TkwCfAttributeSelectBackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfAttributeSelect.BackgroundPanel';
end;//TkwCfAttributeSelectBackgroundPanel.GetWordNameForRegister

procedure TkwCfAttributeSelectBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� BackgroundPanel', aCtx);
end;//TkwCfAttributeSelectBackgroundPanel.SetValuePrim

function TkwCfAttributeSelectBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwCfAttributeSelectBackgroundPanel.GetResultTypeInfo

function TkwCfAttributeSelectBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfAttributeSelectBackgroundPanel.GetAllParamsCount

function TkwCfAttributeSelectBackgroundPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfAttributeSelect)]);
end;//TkwCfAttributeSelectBackgroundPanel.ParamsTypes

type
  TkwCfAttributeSelectSelectedZone = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TcfAttributeSelect.SelectedZone
[panel]������� SelectedZone ����� TcfAttributeSelect[panel]
*��� ����������:* TvtSizeablePanel
*������:*
[code]
OBJECT VAR l_TvtSizeablePanel
 acfAttributeSelect .TcfAttributeSelect.SelectedZone >>> l_TvtSizeablePanel
[code]  }
  private
  // private methods
   function SelectedZone(const aCtx: TtfwContext;
     acfAttributeSelect: TcfAttributeSelect): TvtSizeablePanel;
     {* ���������� ����� ������� .TcfAttributeSelect.SelectedZone }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwCfAttributeSelectSelectedZone

// start class TkwCfAttributeSelectSelectedZone

function TkwCfAttributeSelectSelectedZone.SelectedZone(const aCtx: TtfwContext;
  acfAttributeSelect: TcfAttributeSelect): TvtSizeablePanel;
 {-}
begin
 Result := acfAttributeSelect.SelectedZone;
end;//TkwCfAttributeSelectSelectedZone.SelectedZone

procedure TkwCfAttributeSelectSelectedZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfAttributeSelect : TcfAttributeSelect;
begin
 try
  l_acfAttributeSelect := TcfAttributeSelect(aCtx.rEngine.PopObjAs(TcfAttributeSelect));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� acfAttributeSelect: TcfAttributeSelect : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((SelectedZone(aCtx, l_acfAttributeSelect)));
end;//TkwCfAttributeSelectSelectedZone.DoDoIt

class function TkwCfAttributeSelectSelectedZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfAttributeSelect.SelectedZone';
end;//TkwCfAttributeSelectSelectedZone.GetWordNameForRegister

procedure TkwCfAttributeSelectSelectedZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� SelectedZone', aCtx);
end;//TkwCfAttributeSelectSelectedZone.SetValuePrim

function TkwCfAttributeSelectSelectedZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwCfAttributeSelectSelectedZone.GetResultTypeInfo

function TkwCfAttributeSelectSelectedZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfAttributeSelectSelectedZone.GetAllParamsCount

function TkwCfAttributeSelectSelectedZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfAttributeSelect)]);
end;//TkwCfAttributeSelectSelectedZone.ParamsTypes

type
  TkwCfAttributeSelectValuesZone = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TcfAttributeSelect.ValuesZone
[panel]������� ValuesZone ����� TcfAttributeSelect[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 acfAttributeSelect .TcfAttributeSelect.ValuesZone >>> l_TvtPanel
[code]  }
  private
  // private methods
   function ValuesZone(const aCtx: TtfwContext;
     acfAttributeSelect: TcfAttributeSelect): TvtPanel;
     {* ���������� ����� ������� .TcfAttributeSelect.ValuesZone }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwCfAttributeSelectValuesZone

// start class TkwCfAttributeSelectValuesZone

function TkwCfAttributeSelectValuesZone.ValuesZone(const aCtx: TtfwContext;
  acfAttributeSelect: TcfAttributeSelect): TvtPanel;
 {-}
begin
 Result := acfAttributeSelect.ValuesZone;
end;//TkwCfAttributeSelectValuesZone.ValuesZone

procedure TkwCfAttributeSelectValuesZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_acfAttributeSelect : TcfAttributeSelect;
begin
 try
  l_acfAttributeSelect := TcfAttributeSelect(aCtx.rEngine.PopObjAs(TcfAttributeSelect));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� acfAttributeSelect: TcfAttributeSelect : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ValuesZone(aCtx, l_acfAttributeSelect)));
end;//TkwCfAttributeSelectValuesZone.DoDoIt

class function TkwCfAttributeSelectValuesZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TcfAttributeSelect.ValuesZone';
end;//TkwCfAttributeSelectValuesZone.GetWordNameForRegister

procedure TkwCfAttributeSelectValuesZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ValuesZone', aCtx);
end;//TkwCfAttributeSelectValuesZone.SetValuePrim

function TkwCfAttributeSelectValuesZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfAttributeSelectValuesZone.GetResultTypeInfo

function TkwCfAttributeSelectValuesZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwCfAttributeSelectValuesZone.GetAllParamsCount

function TkwCfAttributeSelectValuesZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TcfAttributeSelect)]);
end;//TkwCfAttributeSelectValuesZone.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_Form_AttributeSelect
 Tkw_Form_AttributeSelect.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_AttributeSelect_Control_BackgroundPanel
 Tkw_AttributeSelect_Control_BackgroundPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_AttributeSelect_Control_BackgroundPanel_Push
 Tkw_AttributeSelect_Control_BackgroundPanel_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_AttributeSelect_Control_SelectedZone
 Tkw_AttributeSelect_Control_SelectedZone.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_AttributeSelect_Control_SelectedZone_Push
 Tkw_AttributeSelect_Control_SelectedZone_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_AttributeSelect_Control_ValuesZone
 Tkw_AttributeSelect_Control_ValuesZone.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_AttributeSelect_Control_ValuesZone_Push
 Tkw_AttributeSelect_Control_ValuesZone_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� cfAttributeSelect_BackgroundPanel
 TkwCfAttributeSelectBackgroundPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� cfAttributeSelect_SelectedZone
 TkwCfAttributeSelectSelectedZone.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� cfAttributeSelect_ValuesZone
 TkwCfAttributeSelectValuesZone.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� AttributeSelect
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfAttributeSelect));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TvtProportionalPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TvtSizeablePanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not NoScripts

end.