unit LeftEditionKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Editions/LeftEditionKeywordsPack.pas"
// �����: 27.07.2009 12:03
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ���������������� �������::CompareEditions::View::Editions::BaseEditions::LeftEditionKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� LeftEdition
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
  LeftEdition_Form,
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
  Tkw_Form_LeftEdition = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� LeftEdition
----
*������ �������������*:
[code]
'aControl' �����::LeftEdition TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_LeftEdition

// start class Tkw_Form_LeftEdition

class function Tkw_Form_LeftEdition.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::LeftEdition';
end;//Tkw_Form_LeftEdition.GetWordNameForRegister

function Tkw_Form_LeftEdition.GetString: AnsiString;
 {-}
begin
 Result := 'LeftEditionForm';
end;//Tkw_Form_LeftEdition.GetString

type
  Tkw_LeftEdition_Control_Header = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_LeftEdition_Control_Header

// start class Tkw_LeftEdition_Control_Header

class function Tkw_LeftEdition_Control_Header.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Header';
end;//Tkw_LeftEdition_Control_Header.GetWordNameForRegister

function Tkw_LeftEdition_Control_Header.GetString: AnsiString;
 {-}
begin
 Result := 'Header';
end;//Tkw_LeftEdition_Control_Header.GetString

class procedure Tkw_LeftEdition_Control_Header.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_LeftEdition_Control_Header.RegisterInEngine

type
  Tkw_LeftEdition_Control_Header_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_LeftEdition_Control_Header_Push

// start class Tkw_LeftEdition_Control_Header_Push

procedure Tkw_LeftEdition_Control_Header_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Header');
 inherited;
end;//Tkw_LeftEdition_Control_Header_Push.DoDoIt

class function Tkw_LeftEdition_Control_Header_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Header:push';
end;//Tkw_LeftEdition_Control_Header_Push.GetWordNameForRegister

type
  Tkw_LeftEdition_Control_pnLeft = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_LeftEdition_Control_pnLeft

// start class Tkw_LeftEdition_Control_pnLeft

class function Tkw_LeftEdition_Control_pnLeft.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnLeft';
end;//Tkw_LeftEdition_Control_pnLeft.GetWordNameForRegister

function Tkw_LeftEdition_Control_pnLeft.GetString: AnsiString;
 {-}
begin
 Result := 'pnLeft';
end;//Tkw_LeftEdition_Control_pnLeft.GetString

class procedure Tkw_LeftEdition_Control_pnLeft.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_LeftEdition_Control_pnLeft.RegisterInEngine

type
  Tkw_LeftEdition_Control_pnLeft_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_LeftEdition_Control_pnLeft_Push

// start class Tkw_LeftEdition_Control_pnLeft_Push

procedure Tkw_LeftEdition_Control_pnLeft_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnLeft');
 inherited;
end;//Tkw_LeftEdition_Control_pnLeft_Push.DoDoIt

class function Tkw_LeftEdition_Control_pnLeft_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnLeft:push';
end;//Tkw_LeftEdition_Control_pnLeft_Push.GetWordNameForRegister

type
  Tkw_LeftEdition_Control_EditionLink = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_LeftEdition_Control_EditionLink

// start class Tkw_LeftEdition_Control_EditionLink

class function Tkw_LeftEdition_Control_EditionLink.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::EditionLink';
end;//Tkw_LeftEdition_Control_EditionLink.GetWordNameForRegister

function Tkw_LeftEdition_Control_EditionLink.GetString: AnsiString;
 {-}
begin
 Result := 'EditionLink';
end;//Tkw_LeftEdition_Control_EditionLink.GetString

class procedure Tkw_LeftEdition_Control_EditionLink.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_LeftEdition_Control_EditionLink.RegisterInEngine

type
  Tkw_LeftEdition_Control_EditionLink_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_LeftEdition_Control_EditionLink_Push

// start class Tkw_LeftEdition_Control_EditionLink_Push

procedure Tkw_LeftEdition_Control_EditionLink_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('EditionLink');
 inherited;
end;//Tkw_LeftEdition_Control_EditionLink_Push.DoDoIt

class function Tkw_LeftEdition_Control_EditionLink_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::EditionLink:push';
end;//Tkw_LeftEdition_Control_EditionLink_Push.GetWordNameForRegister

type
  Tkw_LeftEdition_Control_pbIcon = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_LeftEdition_Control_pbIcon

// start class Tkw_LeftEdition_Control_pbIcon

class function Tkw_LeftEdition_Control_pbIcon.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pbIcon';
end;//Tkw_LeftEdition_Control_pbIcon.GetWordNameForRegister

function Tkw_LeftEdition_Control_pbIcon.GetString: AnsiString;
 {-}
begin
 Result := 'pbIcon';
end;//Tkw_LeftEdition_Control_pbIcon.GetString

class procedure Tkw_LeftEdition_Control_pbIcon.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_LeftEdition_Control_pbIcon.RegisterInEngine

type
  Tkw_LeftEdition_Control_pbIcon_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_LeftEdition_Control_pbIcon_Push

// start class Tkw_LeftEdition_Control_pbIcon_Push

procedure Tkw_LeftEdition_Control_pbIcon_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pbIcon');
 inherited;
end;//Tkw_LeftEdition_Control_pbIcon_Push.DoDoIt

class function Tkw_LeftEdition_Control_pbIcon_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pbIcon:push';
end;//Tkw_LeftEdition_Control_pbIcon_Push.GetWordNameForRegister

type
  Tkw_LeftEdition_Control_pnCaption = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_LeftEdition_Control_pnCaption

// start class Tkw_LeftEdition_Control_pnCaption

class function Tkw_LeftEdition_Control_pnCaption.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnCaption';
end;//Tkw_LeftEdition_Control_pnCaption.GetWordNameForRegister

function Tkw_LeftEdition_Control_pnCaption.GetString: AnsiString;
 {-}
begin
 Result := 'pnCaption';
end;//Tkw_LeftEdition_Control_pnCaption.GetString

class procedure Tkw_LeftEdition_Control_pnCaption.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_LeftEdition_Control_pnCaption.RegisterInEngine

type
  Tkw_LeftEdition_Control_pnCaption_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_LeftEdition_Control_pnCaption_Push

// start class Tkw_LeftEdition_Control_pnCaption_Push

procedure Tkw_LeftEdition_Control_pnCaption_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnCaption');
 inherited;
end;//Tkw_LeftEdition_Control_pnCaption_Push.DoDoIt

class function Tkw_LeftEdition_Control_pnCaption_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::pnCaption:push';
end;//Tkw_LeftEdition_Control_pnCaption_Push.GetWordNameForRegister

type
  Tkw_LeftEdition_Control_EditionChoose = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_LeftEdition_Control_EditionChoose

// start class Tkw_LeftEdition_Control_EditionChoose

class function Tkw_LeftEdition_Control_EditionChoose.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::EditionChoose';
end;//Tkw_LeftEdition_Control_EditionChoose.GetWordNameForRegister

function Tkw_LeftEdition_Control_EditionChoose.GetString: AnsiString;
 {-}
begin
 Result := 'EditionChoose';
end;//Tkw_LeftEdition_Control_EditionChoose.GetString

class procedure Tkw_LeftEdition_Control_EditionChoose.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_LeftEdition_Control_EditionChoose.RegisterInEngine

type
  Tkw_LeftEdition_Control_EditionChoose_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_LeftEdition_Control_EditionChoose_Push

// start class Tkw_LeftEdition_Control_EditionChoose_Push

procedure Tkw_LeftEdition_Control_EditionChoose_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('EditionChoose');
 inherited;
end;//Tkw_LeftEdition_Control_EditionChoose_Push.DoDoIt

class function Tkw_LeftEdition_Control_EditionChoose_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::EditionChoose:push';
end;//Tkw_LeftEdition_Control_EditionChoose_Push.GetWordNameForRegister

type
  Tkw_LeftEdition_Control_Text = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_LeftEdition_Control_Text

// start class Tkw_LeftEdition_Control_Text

class function Tkw_LeftEdition_Control_Text.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Text';
end;//Tkw_LeftEdition_Control_Text.GetWordNameForRegister

function Tkw_LeftEdition_Control_Text.GetString: AnsiString;
 {-}
begin
 Result := 'Text';
end;//Tkw_LeftEdition_Control_Text.GetString

class procedure Tkw_LeftEdition_Control_Text.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_LeftEdition_Control_Text.RegisterInEngine

type
  Tkw_LeftEdition_Control_Text_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_LeftEdition_Control_Text_Push

// start class Tkw_LeftEdition_Control_Text_Push

procedure Tkw_LeftEdition_Control_Text_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Text');
 inherited;
end;//Tkw_LeftEdition_Control_Text_Push.DoDoIt

class function Tkw_LeftEdition_Control_Text_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Text:push';
end;//Tkw_LeftEdition_Control_Text_Push.GetWordNameForRegister

type
  Tkw_LeftEdition_Component_TextSource = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_LeftEdition_Component_TextSource

// start class Tkw_LeftEdition_Component_TextSource

class function Tkw_LeftEdition_Component_TextSource.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���������::TextSource';
end;//Tkw_LeftEdition_Component_TextSource.GetWordNameForRegister

function Tkw_LeftEdition_Component_TextSource.GetString: AnsiString;
 {-}
begin
 Result := 'TextSource';
end;//Tkw_LeftEdition_Component_TextSource.GetString

class procedure Tkw_LeftEdition_Component_TextSource.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTextSource);
end;//Tkw_LeftEdition_Component_TextSource.RegisterInEngine

type
  TkwLeftEditionFormHeader = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TLeftEditionForm.Header
[panel]������� Header ����� TLeftEditionForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aLeftEditionForm .TLeftEditionForm.Header >>> l_TvtPanel
[code]  }
  private
  // private methods
   function Header(const aCtx: TtfwContext;
     aLeftEditionForm: TLeftEditionForm): TvtPanel;
     {* ���������� ����� ������� .TLeftEditionForm.Header }
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
  end;//TkwLeftEditionFormHeader

// start class TkwLeftEditionFormHeader

function TkwLeftEditionFormHeader.Header(const aCtx: TtfwContext;
  aLeftEditionForm: TLeftEditionForm): TvtPanel;
 {-}
begin
 Result := aLeftEditionForm.Header;
end;//TkwLeftEditionFormHeader.Header

procedure TkwLeftEditionFormHeader.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLeftEditionForm : TLeftEditionForm;
begin
 try
  l_aLeftEditionForm := TLeftEditionForm(aCtx.rEngine.PopObjAs(TLeftEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLeftEditionForm: TLeftEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Header(aCtx, l_aLeftEditionForm)));
end;//TkwLeftEditionFormHeader.DoDoIt

class function TkwLeftEditionFormHeader.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLeftEditionForm.Header';
end;//TkwLeftEditionFormHeader.GetWordNameForRegister

procedure TkwLeftEditionFormHeader.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Header', aCtx);
end;//TkwLeftEditionFormHeader.SetValuePrim

function TkwLeftEditionFormHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwLeftEditionFormHeader.GetResultTypeInfo

function TkwLeftEditionFormHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLeftEditionFormHeader.GetAllParamsCount

function TkwLeftEditionFormHeader.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLeftEditionForm)]);
end;//TkwLeftEditionFormHeader.ParamsTypes

type
  TkwLeftEditionFormPnLeft = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TLeftEditionForm.pnLeft
[panel]������� pnLeft ����� TLeftEditionForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aLeftEditionForm .TLeftEditionForm.pnLeft >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnLeft(const aCtx: TtfwContext;
     aLeftEditionForm: TLeftEditionForm): TvtPanel;
     {* ���������� ����� ������� .TLeftEditionForm.pnLeft }
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
  end;//TkwLeftEditionFormPnLeft

// start class TkwLeftEditionFormPnLeft

function TkwLeftEditionFormPnLeft.PnLeft(const aCtx: TtfwContext;
  aLeftEditionForm: TLeftEditionForm): TvtPanel;
 {-}
begin
 Result := aLeftEditionForm.pnLeft;
end;//TkwLeftEditionFormPnLeft.PnLeft

procedure TkwLeftEditionFormPnLeft.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLeftEditionForm : TLeftEditionForm;
begin
 try
  l_aLeftEditionForm := TLeftEditionForm(aCtx.rEngine.PopObjAs(TLeftEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLeftEditionForm: TLeftEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnLeft(aCtx, l_aLeftEditionForm)));
end;//TkwLeftEditionFormPnLeft.DoDoIt

class function TkwLeftEditionFormPnLeft.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLeftEditionForm.pnLeft';
end;//TkwLeftEditionFormPnLeft.GetWordNameForRegister

procedure TkwLeftEditionFormPnLeft.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnLeft', aCtx);
end;//TkwLeftEditionFormPnLeft.SetValuePrim

function TkwLeftEditionFormPnLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwLeftEditionFormPnLeft.GetResultTypeInfo

function TkwLeftEditionFormPnLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLeftEditionFormPnLeft.GetAllParamsCount

function TkwLeftEditionFormPnLeft.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLeftEditionForm)]);
end;//TkwLeftEditionFormPnLeft.ParamsTypes

type
  TkwLeftEditionFormEditionLink = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TLeftEditionForm.EditionLink
[panel]������� EditionLink ����� TLeftEditionForm[panel]
*��� ����������:* TvtFocusLabel
*������:*
[code]
OBJECT VAR l_TvtFocusLabel
 aLeftEditionForm .TLeftEditionForm.EditionLink >>> l_TvtFocusLabel
[code]  }
  private
  // private methods
   function EditionLink(const aCtx: TtfwContext;
     aLeftEditionForm: TLeftEditionForm): TvtFocusLabel;
     {* ���������� ����� ������� .TLeftEditionForm.EditionLink }
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
  end;//TkwLeftEditionFormEditionLink

// start class TkwLeftEditionFormEditionLink

function TkwLeftEditionFormEditionLink.EditionLink(const aCtx: TtfwContext;
  aLeftEditionForm: TLeftEditionForm): TvtFocusLabel;
 {-}
begin
 Result := aLeftEditionForm.EditionLink;
end;//TkwLeftEditionFormEditionLink.EditionLink

procedure TkwLeftEditionFormEditionLink.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLeftEditionForm : TLeftEditionForm;
begin
 try
  l_aLeftEditionForm := TLeftEditionForm(aCtx.rEngine.PopObjAs(TLeftEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLeftEditionForm: TLeftEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EditionLink(aCtx, l_aLeftEditionForm)));
end;//TkwLeftEditionFormEditionLink.DoDoIt

class function TkwLeftEditionFormEditionLink.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLeftEditionForm.EditionLink';
end;//TkwLeftEditionFormEditionLink.GetWordNameForRegister

procedure TkwLeftEditionFormEditionLink.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� EditionLink', aCtx);
end;//TkwLeftEditionFormEditionLink.SetValuePrim

function TkwLeftEditionFormEditionLink.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwLeftEditionFormEditionLink.GetResultTypeInfo

function TkwLeftEditionFormEditionLink.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLeftEditionFormEditionLink.GetAllParamsCount

function TkwLeftEditionFormEditionLink.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLeftEditionForm)]);
end;//TkwLeftEditionFormEditionLink.ParamsTypes

type
  TkwLeftEditionFormPbIcon = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TLeftEditionForm.pbIcon
[panel]������� pbIcon ����� TLeftEditionForm[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aLeftEditionForm .TLeftEditionForm.pbIcon >>> l_TPaintBox
[code]  }
  private
  // private methods
   function PbIcon(const aCtx: TtfwContext;
     aLeftEditionForm: TLeftEditionForm): TPaintBox;
     {* ���������� ����� ������� .TLeftEditionForm.pbIcon }
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
  end;//TkwLeftEditionFormPbIcon

// start class TkwLeftEditionFormPbIcon

function TkwLeftEditionFormPbIcon.PbIcon(const aCtx: TtfwContext;
  aLeftEditionForm: TLeftEditionForm): TPaintBox;
 {-}
begin
 Result := aLeftEditionForm.pbIcon;
end;//TkwLeftEditionFormPbIcon.PbIcon

procedure TkwLeftEditionFormPbIcon.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLeftEditionForm : TLeftEditionForm;
begin
 try
  l_aLeftEditionForm := TLeftEditionForm(aCtx.rEngine.PopObjAs(TLeftEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLeftEditionForm: TLeftEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PbIcon(aCtx, l_aLeftEditionForm)));
end;//TkwLeftEditionFormPbIcon.DoDoIt

class function TkwLeftEditionFormPbIcon.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLeftEditionForm.pbIcon';
end;//TkwLeftEditionFormPbIcon.GetWordNameForRegister

procedure TkwLeftEditionFormPbIcon.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pbIcon', aCtx);
end;//TkwLeftEditionFormPbIcon.SetValuePrim

function TkwLeftEditionFormPbIcon.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwLeftEditionFormPbIcon.GetResultTypeInfo

function TkwLeftEditionFormPbIcon.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLeftEditionFormPbIcon.GetAllParamsCount

function TkwLeftEditionFormPbIcon.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLeftEditionForm)]);
end;//TkwLeftEditionFormPbIcon.ParamsTypes

type
  TkwLeftEditionFormPnCaption = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TLeftEditionForm.pnCaption
[panel]������� pnCaption ����� TLeftEditionForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aLeftEditionForm .TLeftEditionForm.pnCaption >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnCaption(const aCtx: TtfwContext;
     aLeftEditionForm: TLeftEditionForm): TvtPanel;
     {* ���������� ����� ������� .TLeftEditionForm.pnCaption }
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
  end;//TkwLeftEditionFormPnCaption

// start class TkwLeftEditionFormPnCaption

function TkwLeftEditionFormPnCaption.PnCaption(const aCtx: TtfwContext;
  aLeftEditionForm: TLeftEditionForm): TvtPanel;
 {-}
begin
 Result := aLeftEditionForm.pnCaption;
end;//TkwLeftEditionFormPnCaption.PnCaption

procedure TkwLeftEditionFormPnCaption.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLeftEditionForm : TLeftEditionForm;
begin
 try
  l_aLeftEditionForm := TLeftEditionForm(aCtx.rEngine.PopObjAs(TLeftEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLeftEditionForm: TLeftEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnCaption(aCtx, l_aLeftEditionForm)));
end;//TkwLeftEditionFormPnCaption.DoDoIt

class function TkwLeftEditionFormPnCaption.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLeftEditionForm.pnCaption';
end;//TkwLeftEditionFormPnCaption.GetWordNameForRegister

procedure TkwLeftEditionFormPnCaption.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� pnCaption', aCtx);
end;//TkwLeftEditionFormPnCaption.SetValuePrim

function TkwLeftEditionFormPnCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwLeftEditionFormPnCaption.GetResultTypeInfo

function TkwLeftEditionFormPnCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLeftEditionFormPnCaption.GetAllParamsCount

function TkwLeftEditionFormPnCaption.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLeftEditionForm)]);
end;//TkwLeftEditionFormPnCaption.ParamsTypes

type
  TkwLeftEditionFormText = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TLeftEditionForm.Text
[panel]������� Text ����� TLeftEditionForm[panel]
*��� ����������:* TnscEditor
*������:*
[code]
OBJECT VAR l_TnscEditor
 aLeftEditionForm .TLeftEditionForm.Text >>> l_TnscEditor
[code]  }
  private
  // private methods
   function Text(const aCtx: TtfwContext;
     aLeftEditionForm: TLeftEditionForm): TnscEditor;
     {* ���������� ����� ������� .TLeftEditionForm.Text }
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
  end;//TkwLeftEditionFormText

// start class TkwLeftEditionFormText

function TkwLeftEditionFormText.Text(const aCtx: TtfwContext;
  aLeftEditionForm: TLeftEditionForm): TnscEditor;
 {-}
begin
 Result := aLeftEditionForm.Text;
end;//TkwLeftEditionFormText.Text

procedure TkwLeftEditionFormText.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLeftEditionForm : TLeftEditionForm;
begin
 try
  l_aLeftEditionForm := TLeftEditionForm(aCtx.rEngine.PopObjAs(TLeftEditionForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLeftEditionForm: TLeftEditionForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Text(aCtx, l_aLeftEditionForm)));
end;//TkwLeftEditionFormText.DoDoIt

class function TkwLeftEditionFormText.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLeftEditionForm.Text';
end;//TkwLeftEditionFormText.GetWordNameForRegister

procedure TkwLeftEditionFormText.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Text', aCtx);
end;//TkwLeftEditionFormText.SetValuePrim

function TkwLeftEditionFormText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEditor);
end;//TkwLeftEditionFormText.GetResultTypeInfo

function TkwLeftEditionFormText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLeftEditionFormText.GetAllParamsCount

function TkwLeftEditionFormText.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLeftEditionForm)]);
end;//TkwLeftEditionFormText.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_LeftEdition
 Tkw_Form_LeftEdition.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_LeftEdition_Control_Header
 Tkw_LeftEdition_Control_Header.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_LeftEdition_Control_Header_Push
 Tkw_LeftEdition_Control_Header_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_LeftEdition_Control_pnLeft
 Tkw_LeftEdition_Control_pnLeft.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_LeftEdition_Control_pnLeft_Push
 Tkw_LeftEdition_Control_pnLeft_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_LeftEdition_Control_EditionLink
 Tkw_LeftEdition_Control_EditionLink.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_LeftEdition_Control_EditionLink_Push
 Tkw_LeftEdition_Control_EditionLink_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_LeftEdition_Control_pbIcon
 Tkw_LeftEdition_Control_pbIcon.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_LeftEdition_Control_pbIcon_Push
 Tkw_LeftEdition_Control_pbIcon_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_LeftEdition_Control_pnCaption
 Tkw_LeftEdition_Control_pnCaption.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_LeftEdition_Control_pnCaption_Push
 Tkw_LeftEdition_Control_pnCaption_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_LeftEdition_Control_EditionChoose
 Tkw_LeftEdition_Control_EditionChoose.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_LeftEdition_Control_EditionChoose_Push
 Tkw_LeftEdition_Control_EditionChoose_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_LeftEdition_Control_Text
 Tkw_LeftEdition_Control_Text.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_LeftEdition_Control_Text_Push
 Tkw_LeftEdition_Control_Text_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_LeftEdition_Component_TextSource
 Tkw_LeftEdition_Component_TextSource.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� LeftEditionForm_Header
 TkwLeftEditionFormHeader.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� LeftEditionForm_pnLeft
 TkwLeftEditionFormPnLeft.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� LeftEditionForm_EditionLink
 TkwLeftEditionFormEditionLink.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� LeftEditionForm_pbIcon
 TkwLeftEditionFormPbIcon.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� LeftEditionForm_pnCaption
 TkwLeftEditionFormPnCaption.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� LeftEditionForm_Text
 TkwLeftEditionFormText.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� LeftEdition
 TtfwTypeRegistrator.RegisterType(TypeInfo(TLeftEditionForm));
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