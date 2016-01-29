unit GroupPropertyKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/GroupPropertyKeywordsPack.pas"
// �����: 07.09.2009 18:00
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 �������������::Admin::View::Admin::Admin::GroupPropertyKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� GroupProperty
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin) AND not defined(NoScripts)}
uses
  GroupProperty_Form
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtLabel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //Admin AND not NoScripts

implementation

{$If defined(Admin) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_GroupProperty = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� GroupProperty
----
*������ �������������*:
[code]
'aControl' �����::GroupProperty TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_GroupProperty

// start class Tkw_Form_GroupProperty

class function Tkw_Form_GroupProperty.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::GroupProperty';
end;//Tkw_Form_GroupProperty.GetWordNameForRegister

function Tkw_Form_GroupProperty.GetString: AnsiString;
 {-}
begin
 Result := 'efGroupProperty';
end;//Tkw_Form_GroupProperty.GetString

type
  Tkw_GroupProperty_Control_edName = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� edName
----
*������ �������������*:
[code]
�������::edName TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_GroupProperty_Control_edName

// start class Tkw_GroupProperty_Control_edName

class function Tkw_GroupProperty_Control_edName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edName';
end;//Tkw_GroupProperty_Control_edName.GetWordNameForRegister

function Tkw_GroupProperty_Control_edName.GetString: AnsiString;
 {-}
begin
 Result := 'edName';
end;//Tkw_GroupProperty_Control_edName.GetString

class procedure Tkw_GroupProperty_Control_edName.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_GroupProperty_Control_edName.RegisterInEngine

type
  Tkw_GroupProperty_Control_edName_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� edName
----
*������ �������������*:
[code]
�������::edName:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_GroupProperty_Control_edName_Push

// start class Tkw_GroupProperty_Control_edName_Push

procedure Tkw_GroupProperty_Control_edName_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edName');
 inherited;
end;//Tkw_GroupProperty_Control_edName_Push.DoDoIt

class function Tkw_GroupProperty_Control_edName_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::edName:push';
end;//Tkw_GroupProperty_Control_edName_Push.GetWordNameForRegister

type
  Tkw_GroupProperty_Control_Label1 = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� Label1
----
*������ �������������*:
[code]
�������::Label1 TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_GroupProperty_Control_Label1

// start class Tkw_GroupProperty_Control_Label1

class function Tkw_GroupProperty_Control_Label1.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Label1';
end;//Tkw_GroupProperty_Control_Label1.GetWordNameForRegister

function Tkw_GroupProperty_Control_Label1.GetString: AnsiString;
 {-}
begin
 Result := 'Label1';
end;//Tkw_GroupProperty_Control_Label1.GetString

class procedure Tkw_GroupProperty_Control_Label1.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_GroupProperty_Control_Label1.RegisterInEngine

type
  Tkw_GroupProperty_Control_Label1_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� Label1
----
*������ �������������*:
[code]
�������::Label1:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_GroupProperty_Control_Label1_Push

// start class Tkw_GroupProperty_Control_Label1_Push

procedure Tkw_GroupProperty_Control_Label1_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Label1');
 inherited;
end;//Tkw_GroupProperty_Control_Label1_Push.DoDoIt

class function Tkw_GroupProperty_Control_Label1_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Label1:push';
end;//Tkw_GroupProperty_Control_Label1_Push.GetWordNameForRegister

type
  TkwEfGroupPropertyEdName = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefGroupProperty.edName
[panel]������� edName ����� TefGroupProperty[panel]
*��� ����������:* TnscEdit
*������:*
[code]
OBJECT VAR l_TnscEdit
 aefGroupProperty .TefGroupProperty.edName >>> l_TnscEdit
[code]  }
  private
  // private methods
   function EdName(const aCtx: TtfwContext;
     aefGroupProperty: TefGroupProperty): TnscEdit;
     {* ���������� ����� ������� .TefGroupProperty.edName }
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
  end;//TkwEfGroupPropertyEdName

// start class TkwEfGroupPropertyEdName

function TkwEfGroupPropertyEdName.EdName(const aCtx: TtfwContext;
  aefGroupProperty: TefGroupProperty): TnscEdit;
 {-}
begin
 Result := aefGroupProperty.edName;
end;//TkwEfGroupPropertyEdName.EdName

procedure TkwEfGroupPropertyEdName.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefGroupProperty : TefGroupProperty;
begin
 try
  l_aefGroupProperty := TefGroupProperty(aCtx.rEngine.PopObjAs(TefGroupProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefGroupProperty: TefGroupProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdName(aCtx, l_aefGroupProperty)));
end;//TkwEfGroupPropertyEdName.DoDoIt

class function TkwEfGroupPropertyEdName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefGroupProperty.edName';
end;//TkwEfGroupPropertyEdName.GetWordNameForRegister

procedure TkwEfGroupPropertyEdName.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� edName', aCtx);
end;//TkwEfGroupPropertyEdName.SetValuePrim

function TkwEfGroupPropertyEdName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEdit);
end;//TkwEfGroupPropertyEdName.GetResultTypeInfo

function TkwEfGroupPropertyEdName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfGroupPropertyEdName.GetAllParamsCount

function TkwEfGroupPropertyEdName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefGroupProperty)]);
end;//TkwEfGroupPropertyEdName.ParamsTypes

type
  TkwEfGroupPropertyLabel1 = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefGroupProperty.Label1
[panel]������� Label1 ����� TefGroupProperty[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefGroupProperty .TefGroupProperty.Label1 >>> l_TvtLabel
[code]  }
  private
  // private methods
   function Label1(const aCtx: TtfwContext;
     aefGroupProperty: TefGroupProperty): TvtLabel;
     {* ���������� ����� ������� .TefGroupProperty.Label1 }
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
  end;//TkwEfGroupPropertyLabel1

// start class TkwEfGroupPropertyLabel1

function TkwEfGroupPropertyLabel1.Label1(const aCtx: TtfwContext;
  aefGroupProperty: TefGroupProperty): TvtLabel;
 {-}
begin
 Result := aefGroupProperty.Label1;
end;//TkwEfGroupPropertyLabel1.Label1

procedure TkwEfGroupPropertyLabel1.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefGroupProperty : TefGroupProperty;
begin
 try
  l_aefGroupProperty := TefGroupProperty(aCtx.rEngine.PopObjAs(TefGroupProperty));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefGroupProperty: TefGroupProperty : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Label1(aCtx, l_aefGroupProperty)));
end;//TkwEfGroupPropertyLabel1.DoDoIt

class function TkwEfGroupPropertyLabel1.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefGroupProperty.Label1';
end;//TkwEfGroupPropertyLabel1.GetWordNameForRegister

procedure TkwEfGroupPropertyLabel1.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Label1', aCtx);
end;//TkwEfGroupPropertyLabel1.SetValuePrim

function TkwEfGroupPropertyLabel1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfGroupPropertyLabel1.GetResultTypeInfo

function TkwEfGroupPropertyLabel1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfGroupPropertyLabel1.GetAllParamsCount

function TkwEfGroupPropertyLabel1.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefGroupProperty)]);
end;//TkwEfGroupPropertyLabel1.ParamsTypes
{$IfEnd} //Admin AND not NoScripts

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_Form_GroupProperty
 Tkw_Form_GroupProperty.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_GroupProperty_Control_edName
 Tkw_GroupProperty_Control_edName.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_GroupProperty_Control_edName_Push
 Tkw_GroupProperty_Control_edName_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_GroupProperty_Control_Label1
 Tkw_GroupProperty_Control_Label1.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_GroupProperty_Control_Label1_Push
 Tkw_GroupProperty_Control_Label1_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efGroupProperty_edName
 TkwEfGroupPropertyEdName.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efGroupProperty_Label1
 TkwEfGroupPropertyLabel1.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� GroupProperty
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefGroupProperty));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TnscEdit
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //Admin AND not NoScripts

end.