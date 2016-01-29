unit RightEditionKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Editions/RightEditionKeywordsPack.pas"
// �����: 27.07.2009 12:03
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ���������������� �������::CompareEditions::View::Editions::BaseEditions::RightEditionKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� RightEdition
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  
  {$If defined(Nemesis)}
  ,
  nscEditor
  {$IfEnd} //Nemesis
  ,
  RightEdition_Form,
  vtPanel,
  vtFocusLabel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  vtComboBoxQS
  {$If defined(Nemesis)}
  ,
  nscTextSource
  {$IfEnd} //Nemesis
  ,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_RightEdition = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� RightEdition
----
*������ �������������*:
[code]
'aControl' �����::RightEdition TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_RightEdition

// start class Tkw_Form_RightEdition

class function Tkw_Form_RightEdition.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::RightEdition';
end;//Tkw_Form_RightEdition.GetWordNameForRegister

function Tkw_Form_RightEdition.GetString: AnsiString;
 {-}
begin
 Result := 'RightEditionForm';
end;//Tkw_Form_RightEdition.GetString

type
  Tkw_RightEdition_Control_Header = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� Header
----
*������ �������������*:
[code]
�������::Header TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_RightEdition_Control_Header

// start class Tkw_RightEdition_Control_Header

class function Tkw_RightEdition_Control_Header.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Header';
end;//Tkw_RightEdition_Control_Header.GetWordNameForRegister

function Tkw_RightEdition_Control_Header.GetString: AnsiString;
 {-}
begin
 Result := 'Header';
end;//Tkw_RightEdition_Control_Header.GetString

class procedure Tkw_RightEdition_Control_Header.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_RightEdition_Control_Header.RegisterInEngine

type
  Tkw_RightEdition_Control_Header_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� Header
----
*������ �������������*:
[code]
�������::Header:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_RightEdition_Control_Header_Push

// start class Tkw_RightEdition_Control_Header_Push

procedure Tkw_RightEdition_Control_Header_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Header');
 inherited;
end;//Tkw_RightEdition_Control_Header_Push.DoDoIt

class function Tkw_RightEdition_Control_Header_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Header:push';
end;//Tkw_RightEdition_Control_Header_Push.GetWordNameForRegister

type
  Tkw_RightEdition_Control_pnLeft = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pnLeft
----
*������ �������������*:
[code]
�������::pnLeft TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_RightEdition_Control_pnLeft

// start class Tkw_RightEdition_Control_pnLeft

class function Tkw_RightEdition_Control_pnLeft.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnLeft';
end;//Tkw_RightEdition_Control_pnLeft.GetWordNameForRegister

function Tkw_RightEdition_Control_pnLeft.GetString: AnsiString;
 {-}
begin
 Result := 'pnLeft';
end;//Tkw_RightEdition_Control_pnLeft.GetString

class procedure Tkw_RightEdition_Control_pnLeft.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_RightEdition_Control_pnLeft.RegisterInEngine

type
  Tkw_RightEdition_Control_pnLeft_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pnLeft
----
*������ �������������*:
[code]
�������::pnLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_RightEdition_Control_pnLeft_Push

// start class Tkw_RightEdition_Control_pnLeft_Push

procedure Tkw_RightEdition_Control_pnLeft_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnLeft');
 inherited;
end;//Tkw_RightEdition_Control_pnLeft_Push.DoDoIt

class function Tkw_RightEdition_Control_pnLeft_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnLeft:push';
end;//Tkw_RightEdition_Control_pnLeft_Push.GetWordNameForRegister

type
  Tkw_RightEdition_Control_EditionLink = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� EditionLink
----
*������ �������������*:
[code]
�������::EditionLink TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_RightEdition_Control_EditionLink

// start class Tkw_RightEdition_Control_EditionLink

class function Tkw_RightEdition_Control_EditionLink.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::EditionLink';
end;//Tkw_RightEdition_Control_EditionLink.GetWordNameForRegister

function Tkw_RightEdition_Control_EditionLink.GetString: AnsiString;
 {-}
begin
 Result := 'EditionLink';
end;//Tkw_RightEdition_Control_EditionLink.GetString

class procedure Tkw_RightEdition_Control_EditionLink.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_RightEdition_Control_EditionLink.RegisterInEngine

type
  Tkw_RightEdition_Control_EditionLink_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� EditionLink
----
*������ �������������*:
[code]
�������::EditionLink:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_RightEdition_Control_EditionLink_Push

// start class Tkw_RightEdition_Control_EditionLink_Push

procedure Tkw_RightEdition_Control_EditionLink_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('EditionLink');
 inherited;
end;//Tkw_RightEdition_Control_EditionLink_Push.DoDoIt

class function Tkw_RightEdition_Control_EditionLink_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::EditionLink:push';
end;//Tkw_RightEdition_Control_EditionLink_Push.GetWordNameForRegister

type
  Tkw_RightEdition_Control_pbIcon = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pbIcon
----
*������ �������������*:
[code]
�������::pbIcon TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_RightEdition_Control_pbIcon

// start class Tkw_RightEdition_Control_pbIcon

class function Tkw_RightEdition_Control_pbIcon.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pbIcon';
end;//Tkw_RightEdition_Control_pbIcon.GetWordNameForRegister

function Tkw_RightEdition_Control_pbIcon.GetString: AnsiString;
 {-}
begin
 Result := 'pbIcon';
end;//Tkw_RightEdition_Control_pbIcon.GetString

class procedure Tkw_RightEdition_Control_pbIcon.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_RightEdition_Control_pbIcon.RegisterInEngine

type
  Tkw_RightEdition_Control_pbIcon_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pbIcon
----
*������ �������������*:
[code]
�������::pbIcon:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_RightEdition_Control_pbIcon_Push

// start class Tkw_RightEdition_Control_pbIcon_Push

procedure Tkw_RightEdition_Control_pbIcon_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pbIcon');
 inherited;
end;//Tkw_RightEdition_Control_pbIcon_Push.DoDoIt

class function Tkw_RightEdition_Control_pbIcon_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pbIcon:push';
end;//Tkw_RightEdition_Control_pbIcon_Push.GetWordNameForRegister

type
  Tkw_RightEdition_Control_pnCaption = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� pnCaption
----
*������ �������������*:
[code]
�������::pnCaption TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_RightEdition_Control_pnCaption

// start class Tkw_RightEdition_Control_pnCaption

class function Tkw_RightEdition_Control_pnCaption.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnCaption';
end;//Tkw_RightEdition_Control_pnCaption.GetWordNameForRegister

function Tkw_RightEdition_Control_pnCaption.GetString: AnsiString;
 {-}
begin
 Result := 'pnCaption';
end;//Tkw_RightEdition_Control_pnCaption.GetString

class procedure Tkw_RightEdition_Control_pnCaption.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_RightEdition_Control_pnCaption.RegisterInEngine

type
  Tkw_RightEdition_Control_pnCaption_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� pnCaption
----
*������ �������������*:
[code]
�������::pnCaption:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_RightEdition_Control_pnCaption_Push

// start class Tkw_RightEdition_Control_pnCaption_Push

procedure Tkw_RightEdition_Control_pnCaption_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnCaption');
 inherited;
end;//Tkw_RightEdition_Control_pnCaption_Push.DoDoIt

class function Tkw_RightEdition_Control_pnCaption_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnCaption:push';
end;//Tkw_RightEdition_Control_pnCaption_Push.GetWordNameForRegister

type
  Tkw_RightEdition_Control_EditionChoose = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� EditionChoose
----
*������ �������������*:
[code]
�������::EditionChoose TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_RightEdition_Control_EditionChoose

// start class Tkw_RightEdition_Control_EditionChoose

class function Tkw_RightEdition_Control_EditionChoose.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::EditionChoose';
end;//Tkw_RightEdition_Control_EditionChoose.GetWordNameForRegister

function Tkw_RightEdition_Control_EditionChoose.GetString: AnsiString;
 {-}
begin
 Result := 'EditionChoose';
end;//Tkw_RightEdition_Control_EditionChoose.GetString

class procedure Tkw_RightEdition_Control_EditionChoose.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_RightEdition_Control_EditionChoose.RegisterInEngine

type
  Tkw_RightEdition_Control_EditionChoose_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� EditionChoose
----
*������ �������������*:
[code]
�������::EditionChoose:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_RightEdition_Control_EditionChoose_Push

// start class Tkw_RightEdition_Control_EditionChoose_Push

procedure Tkw_RightEdition_Control_EditionChoose_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('EditionChoose');
 inherited;
end;//Tkw_RightEdition_Control_EditionChoose_Push.DoDoIt

class function Tkw_RightEdition_Control_EditionChoose_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::EditionChoose:push';
end;//Tkw_RightEdition_Control_EditionChoose_Push.GetWordNameForRegister

type
  Tkw_RightEdition_Control_Text = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� Text
----
*������ �������������*:
[code]
�������::Text TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_RightEdition_Control_Text

// start class Tkw_RightEdition_Control_Text

class function Tkw_RightEdition_Control_Text.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Text';
end;//Tkw_RightEdition_Control_Text.GetWordNameForRegister

function Tkw_RightEdition_Control_Text.GetString: AnsiString;
 {-}
begin
 Result := 'Text';
end;//Tkw_RightEdition_Control_Text.GetString

class procedure Tkw_RightEdition_Control_Text.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_RightEdition_Control_Text.RegisterInEngine

type
  Tkw_RightEdition_Control_Text_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� Text
----
*������ �������������*:
[code]
�������::Text:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_RightEdition_Control_Text_Push

// start class Tkw_RightEdition_Control_Text_Push

procedure Tkw_RightEdition_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Text');
 inherited;
end;//Tkw_RightEdition_Control_Text_Push.DoDoIt

class function Tkw_RightEdition_Control_Text_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Text:push';
end;//Tkw_RightEdition_Control_Text_Push.GetWordNameForRegister

type
  Tkw_RightEdition_Component_TextSource = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� TextSource
----
*������ �������������*:
[code]
���������::TextSource TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_RightEdition_Component_TextSource

// start class Tkw_RightEdition_Component_TextSource

class function Tkw_RightEdition_Component_TextSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���������::TextSource';
end;//Tkw_RightEdition_Component_TextSource.GetWordNameForRegister

function Tkw_RightEdition_Component_TextSource.GetString: AnsiString;
 {-}
begin
 Result := 'TextSource';
end;//Tkw_RightEdition_Component_TextSource.GetString

class procedure Tkw_RightEdition_Component_TextSource.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTextSource);
end;//Tkw_RightEdition_Component_TextSource.RegisterInEngine

type
  TkwRightEditionFormHeader = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TRightEditionForm.Header
[panel]������� Header ����� TRightEditionForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aRightEditionForm .TRightEditionForm.Header >>> l_TvtPanel
[code]  }
  private
  // private methods
   function Header(const aCtx: TtfwContext;
     aRightEditionForm: TRightEditionForm): TvtPanel;
     {* ���������� ����� ������� .TRightEditionForm.Header }
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
  end;//TkwRightEditionFormHeader

// start class TkwRightEditionFormHeader

function TkwRightEditionFormHeader.Header(const aCtx: TtfwContext;
  aRightEditionForm: TRightEditionForm): TvtPanel;
 {-}
begin
 Result := aRightEditionForm.Header;
end;//TkwRightEditionFormHeader.Header

procedure TkwRightEditionFormHeader.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRightEditionForm : TRightEditionForm;
begin
 try
  l_aRightEditionForm := TRightEditionForm(aCtx.rEngine.PopObjAs(TRightEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRightEditionForm: TRightEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Header(aCtx, l_aRightEditionForm)));
end;//TkwRightEditionFormHeader.DoDoIt

class function TkwRightEditionFormHeader.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TRightEditionForm.Header';
end;//TkwRightEditionFormHeader.GetWordNameForRegister

procedure TkwRightEditionFormHeader.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Header', aCtx);
end;//TkwRightEditionFormHeader.SetValuePrim

function TkwRightEditionFormHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwRightEditionFormHeader.GetResultTypeInfo

function TkwRightEditionFormHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwRightEditionFormHeader.GetAllParamsCount

function TkwRightEditionFormHeader.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TRightEditionForm)]);
end;//TkwRightEditionFormHeader.ParamsTypes

type
  TkwRightEditionFormPnLeft = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TRightEditionForm.pnLeft
[panel]������� pnLeft ����� TRightEditionForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aRightEditionForm .TRightEditionForm.pnLeft >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnLeft(const aCtx: TtfwContext;
     aRightEditionForm: TRightEditionForm): TvtPanel;
     {* ���������� ����� ������� .TRightEditionForm.pnLeft }
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
  end;//TkwRightEditionFormPnLeft

// start class TkwRightEditionFormPnLeft

function TkwRightEditionFormPnLeft.PnLeft(const aCtx: TtfwContext;
  aRightEditionForm: TRightEditionForm): TvtPanel;
 {-}
begin
 Result := aRightEditionForm.pnLeft;
end;//TkwRightEditionFormPnLeft.PnLeft

procedure TkwRightEditionFormPnLeft.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRightEditionForm : TRightEditionForm;
begin
 try
  l_aRightEditionForm := TRightEditionForm(aCtx.rEngine.PopObjAs(TRightEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRightEditionForm: TRightEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnLeft(aCtx, l_aRightEditionForm)));
end;//TkwRightEditionFormPnLeft.DoDoIt

class function TkwRightEditionFormPnLeft.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TRightEditionForm.pnLeft';
end;//TkwRightEditionFormPnLeft.GetWordNameForRegister

procedure TkwRightEditionFormPnLeft.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnLeft', aCtx);
end;//TkwRightEditionFormPnLeft.SetValuePrim

function TkwRightEditionFormPnLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwRightEditionFormPnLeft.GetResultTypeInfo

function TkwRightEditionFormPnLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwRightEditionFormPnLeft.GetAllParamsCount

function TkwRightEditionFormPnLeft.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TRightEditionForm)]);
end;//TkwRightEditionFormPnLeft.ParamsTypes

type
  TkwRightEditionFormEditionLink = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TRightEditionForm.EditionLink
[panel]������� EditionLink ����� TRightEditionForm[panel]
*��� ����������:* TvtFocusLabel
*������:*
[code]
OBJECT VAR l_TvtFocusLabel
 aRightEditionForm .TRightEditionForm.EditionLink >>> l_TvtFocusLabel
[code]  }
  private
  // private methods
   function EditionLink(const aCtx: TtfwContext;
     aRightEditionForm: TRightEditionForm): TvtFocusLabel;
     {* ���������� ����� ������� .TRightEditionForm.EditionLink }
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
  end;//TkwRightEditionFormEditionLink

// start class TkwRightEditionFormEditionLink

function TkwRightEditionFormEditionLink.EditionLink(const aCtx: TtfwContext;
  aRightEditionForm: TRightEditionForm): TvtFocusLabel;
 {-}
begin
 Result := aRightEditionForm.EditionLink;
end;//TkwRightEditionFormEditionLink.EditionLink

procedure TkwRightEditionFormEditionLink.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRightEditionForm : TRightEditionForm;
begin
 try
  l_aRightEditionForm := TRightEditionForm(aCtx.rEngine.PopObjAs(TRightEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRightEditionForm: TRightEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EditionLink(aCtx, l_aRightEditionForm)));
end;//TkwRightEditionFormEditionLink.DoDoIt

class function TkwRightEditionFormEditionLink.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TRightEditionForm.EditionLink';
end;//TkwRightEditionFormEditionLink.GetWordNameForRegister

procedure TkwRightEditionFormEditionLink.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� EditionLink', aCtx);
end;//TkwRightEditionFormEditionLink.SetValuePrim

function TkwRightEditionFormEditionLink.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwRightEditionFormEditionLink.GetResultTypeInfo

function TkwRightEditionFormEditionLink.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwRightEditionFormEditionLink.GetAllParamsCount

function TkwRightEditionFormEditionLink.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TRightEditionForm)]);
end;//TkwRightEditionFormEditionLink.ParamsTypes

type
  TkwRightEditionFormPbIcon = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TRightEditionForm.pbIcon
[panel]������� pbIcon ����� TRightEditionForm[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aRightEditionForm .TRightEditionForm.pbIcon >>> l_TPaintBox
[code]  }
  private
  // private methods
   function PbIcon(const aCtx: TtfwContext;
     aRightEditionForm: TRightEditionForm): TPaintBox;
     {* ���������� ����� ������� .TRightEditionForm.pbIcon }
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
  end;//TkwRightEditionFormPbIcon

// start class TkwRightEditionFormPbIcon

function TkwRightEditionFormPbIcon.PbIcon(const aCtx: TtfwContext;
  aRightEditionForm: TRightEditionForm): TPaintBox;
 {-}
begin
 Result := aRightEditionForm.pbIcon;
end;//TkwRightEditionFormPbIcon.PbIcon

procedure TkwRightEditionFormPbIcon.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRightEditionForm : TRightEditionForm;
begin
 try
  l_aRightEditionForm := TRightEditionForm(aCtx.rEngine.PopObjAs(TRightEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRightEditionForm: TRightEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PbIcon(aCtx, l_aRightEditionForm)));
end;//TkwRightEditionFormPbIcon.DoDoIt

class function TkwRightEditionFormPbIcon.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TRightEditionForm.pbIcon';
end;//TkwRightEditionFormPbIcon.GetWordNameForRegister

procedure TkwRightEditionFormPbIcon.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pbIcon', aCtx);
end;//TkwRightEditionFormPbIcon.SetValuePrim

function TkwRightEditionFormPbIcon.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwRightEditionFormPbIcon.GetResultTypeInfo

function TkwRightEditionFormPbIcon.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwRightEditionFormPbIcon.GetAllParamsCount

function TkwRightEditionFormPbIcon.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TRightEditionForm)]);
end;//TkwRightEditionFormPbIcon.ParamsTypes

type
  TkwRightEditionFormPnCaption = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TRightEditionForm.pnCaption
[panel]������� pnCaption ����� TRightEditionForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aRightEditionForm .TRightEditionForm.pnCaption >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnCaption(const aCtx: TtfwContext;
     aRightEditionForm: TRightEditionForm): TvtPanel;
     {* ���������� ����� ������� .TRightEditionForm.pnCaption }
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
  end;//TkwRightEditionFormPnCaption

// start class TkwRightEditionFormPnCaption

function TkwRightEditionFormPnCaption.PnCaption(const aCtx: TtfwContext;
  aRightEditionForm: TRightEditionForm): TvtPanel;
 {-}
begin
 Result := aRightEditionForm.pnCaption;
end;//TkwRightEditionFormPnCaption.PnCaption

procedure TkwRightEditionFormPnCaption.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRightEditionForm : TRightEditionForm;
begin
 try
  l_aRightEditionForm := TRightEditionForm(aCtx.rEngine.PopObjAs(TRightEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRightEditionForm: TRightEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnCaption(aCtx, l_aRightEditionForm)));
end;//TkwRightEditionFormPnCaption.DoDoIt

class function TkwRightEditionFormPnCaption.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TRightEditionForm.pnCaption';
end;//TkwRightEditionFormPnCaption.GetWordNameForRegister

procedure TkwRightEditionFormPnCaption.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnCaption', aCtx);
end;//TkwRightEditionFormPnCaption.SetValuePrim

function TkwRightEditionFormPnCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwRightEditionFormPnCaption.GetResultTypeInfo

function TkwRightEditionFormPnCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwRightEditionFormPnCaption.GetAllParamsCount

function TkwRightEditionFormPnCaption.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TRightEditionForm)]);
end;//TkwRightEditionFormPnCaption.ParamsTypes

type
  TkwRightEditionFormText = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TRightEditionForm.Text
[panel]������� Text ����� TRightEditionForm[panel]
*��� ����������:* TnscEditor
*������:*
[code]
OBJECT VAR l_TnscEditor
 aRightEditionForm .TRightEditionForm.Text >>> l_TnscEditor
[code]  }
  private
  // private methods
   function Text(const aCtx: TtfwContext;
     aRightEditionForm: TRightEditionForm): TnscEditor;
     {* ���������� ����� ������� .TRightEditionForm.Text }
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
  end;//TkwRightEditionFormText

// start class TkwRightEditionFormText

function TkwRightEditionFormText.Text(const aCtx: TtfwContext;
  aRightEditionForm: TRightEditionForm): TnscEditor;
 {-}
begin
 Result := aRightEditionForm.Text;
end;//TkwRightEditionFormText.Text

procedure TkwRightEditionFormText.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRightEditionForm : TRightEditionForm;
begin
 try
  l_aRightEditionForm := TRightEditionForm(aCtx.rEngine.PopObjAs(TRightEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRightEditionForm: TRightEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Text(aCtx, l_aRightEditionForm)));
end;//TkwRightEditionFormText.DoDoIt

class function TkwRightEditionFormText.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TRightEditionForm.Text';
end;//TkwRightEditionFormText.GetWordNameForRegister

procedure TkwRightEditionFormText.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Text', aCtx);
end;//TkwRightEditionFormText.SetValuePrim

function TkwRightEditionFormText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEditor);
end;//TkwRightEditionFormText.GetResultTypeInfo

function TkwRightEditionFormText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwRightEditionFormText.GetAllParamsCount

function TkwRightEditionFormText.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TRightEditionForm)]);
end;//TkwRightEditionFormText.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_RightEdition
 Tkw_Form_RightEdition.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_RightEdition_Control_Header
 Tkw_RightEdition_Control_Header.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_RightEdition_Control_Header_Push
 Tkw_RightEdition_Control_Header_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_RightEdition_Control_pnLeft
 Tkw_RightEdition_Control_pnLeft.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_RightEdition_Control_pnLeft_Push
 Tkw_RightEdition_Control_pnLeft_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_RightEdition_Control_EditionLink
 Tkw_RightEdition_Control_EditionLink.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_RightEdition_Control_EditionLink_Push
 Tkw_RightEdition_Control_EditionLink_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_RightEdition_Control_pbIcon
 Tkw_RightEdition_Control_pbIcon.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_RightEdition_Control_pbIcon_Push
 Tkw_RightEdition_Control_pbIcon_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_RightEdition_Control_pnCaption
 Tkw_RightEdition_Control_pnCaption.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_RightEdition_Control_pnCaption_Push
 Tkw_RightEdition_Control_pnCaption_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_RightEdition_Control_EditionChoose
 Tkw_RightEdition_Control_EditionChoose.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_RightEdition_Control_EditionChoose_Push
 Tkw_RightEdition_Control_EditionChoose_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_RightEdition_Control_Text
 Tkw_RightEdition_Control_Text.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_RightEdition_Control_Text_Push
 Tkw_RightEdition_Control_Text_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_RightEdition_Component_TextSource
 Tkw_RightEdition_Component_TextSource.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� RightEditionForm_Header
 TkwRightEditionFormHeader.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� RightEditionForm_pnLeft
 TkwRightEditionFormPnLeft.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� RightEditionForm_EditionLink
 TkwRightEditionFormEditionLink.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� RightEditionForm_pbIcon
 TkwRightEditionFormPbIcon.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� RightEditionForm_pnCaption
 TkwRightEditionFormPnCaption.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� RightEditionForm_Text
 TkwRightEditionFormText.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� RightEdition
 TtfwTypeRegistrator.RegisterType(TypeInfo(TRightEditionForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtFocusLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtFocusLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TPaintBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscEditor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.