unit LongProcessKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/LongProcessKeywordsPack.pas"
// �����: 21.08.2009 20:15
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������� ����������� ���������� �������::F1 Application Template::View::PrimCommon::PrimCommon::LongProcessKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� LongProcess
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
  Classes
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  vtPanel,
  LongProcess_Form,
  vtLabel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  vtButton,
  vtGradientWaitbar,
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
  tfwTypeRegistrator
  ;

type
  Tkw_Form_LongProcess = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� LongProcess
----
*������ �������������*:
[code]
'aControl' �����::LongProcess TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_LongProcess

// start class Tkw_Form_LongProcess

class function Tkw_Form_LongProcess.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::LongProcess';
end;//Tkw_Form_LongProcess.GetWordNameForRegister

function Tkw_Form_LongProcess.GetString: AnsiString;
 {-}
begin
 Result := 'LongProcessForm';
end;//Tkw_Form_LongProcess.GetString

type
  Tkw_LongProcess_Control_ClientPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ClientPanel
----
*������ �������������*:
[code]
�������::ClientPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_LongProcess_Control_ClientPanel

// start class Tkw_LongProcess_Control_ClientPanel

class function Tkw_LongProcess_Control_ClientPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ClientPanel';
end;//Tkw_LongProcess_Control_ClientPanel.GetWordNameForRegister

function Tkw_LongProcess_Control_ClientPanel.GetString: AnsiString;
 {-}
begin
 Result := 'ClientPanel';
end;//Tkw_LongProcess_Control_ClientPanel.GetString

class procedure Tkw_LongProcess_Control_ClientPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_LongProcess_Control_ClientPanel.RegisterInEngine

type
  Tkw_LongProcess_Control_ClientPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ClientPanel
----
*������ �������������*:
[code]
�������::ClientPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_LongProcess_Control_ClientPanel_Push

// start class Tkw_LongProcess_Control_ClientPanel_Push

procedure Tkw_LongProcess_Control_ClientPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ClientPanel');
 inherited;
end;//Tkw_LongProcess_Control_ClientPanel_Push.DoDoIt

class function Tkw_LongProcess_Control_ClientPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ClientPanel:push';
end;//Tkw_LongProcess_Control_ClientPanel_Push.GetWordNameForRegister

type
  Tkw_LongProcess_Control_MessageLabel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� MessageLabel
----
*������ �������������*:
[code]
�������::MessageLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_LongProcess_Control_MessageLabel

// start class Tkw_LongProcess_Control_MessageLabel

class function Tkw_LongProcess_Control_MessageLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::MessageLabel';
end;//Tkw_LongProcess_Control_MessageLabel.GetWordNameForRegister

function Tkw_LongProcess_Control_MessageLabel.GetString: AnsiString;
 {-}
begin
 Result := 'MessageLabel';
end;//Tkw_LongProcess_Control_MessageLabel.GetString

class procedure Tkw_LongProcess_Control_MessageLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_LongProcess_Control_MessageLabel.RegisterInEngine

type
  Tkw_LongProcess_Control_MessageLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� MessageLabel
----
*������ �������������*:
[code]
�������::MessageLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_LongProcess_Control_MessageLabel_Push

// start class Tkw_LongProcess_Control_MessageLabel_Push

procedure Tkw_LongProcess_Control_MessageLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('MessageLabel');
 inherited;
end;//Tkw_LongProcess_Control_MessageLabel_Push.DoDoIt

class function Tkw_LongProcess_Control_MessageLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::MessageLabel:push';
end;//Tkw_LongProcess_Control_MessageLabel_Push.GetWordNameForRegister

type
  Tkw_LongProcess_Control_BottomPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� BottomPanel
----
*������ �������������*:
[code]
�������::BottomPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_LongProcess_Control_BottomPanel

// start class Tkw_LongProcess_Control_BottomPanel

class function Tkw_LongProcess_Control_BottomPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BottomPanel';
end;//Tkw_LongProcess_Control_BottomPanel.GetWordNameForRegister

function Tkw_LongProcess_Control_BottomPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BottomPanel';
end;//Tkw_LongProcess_Control_BottomPanel.GetString

class procedure Tkw_LongProcess_Control_BottomPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_LongProcess_Control_BottomPanel.RegisterInEngine

type
  Tkw_LongProcess_Control_BottomPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� BottomPanel
----
*������ �������������*:
[code]
�������::BottomPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_LongProcess_Control_BottomPanel_Push

// start class Tkw_LongProcess_Control_BottomPanel_Push

procedure Tkw_LongProcess_Control_BottomPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BottomPanel');
 inherited;
end;//Tkw_LongProcess_Control_BottomPanel_Push.DoDoIt

class function Tkw_LongProcess_Control_BottomPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BottomPanel:push';
end;//Tkw_LongProcess_Control_BottomPanel_Push.GetWordNameForRegister

type
  Tkw_LongProcess_Control_ProgressBar = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ProgressBar
----
*������ �������������*:
[code]
�������::ProgressBar TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_LongProcess_Control_ProgressBar

// start class Tkw_LongProcess_Control_ProgressBar

class function Tkw_LongProcess_Control_ProgressBar.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ProgressBar';
end;//Tkw_LongProcess_Control_ProgressBar.GetWordNameForRegister

function Tkw_LongProcess_Control_ProgressBar.GetString: AnsiString;
 {-}
begin
 Result := 'ProgressBar';
end;//Tkw_LongProcess_Control_ProgressBar.GetString

class procedure Tkw_LongProcess_Control_ProgressBar.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtGradientWaitbar);
end;//Tkw_LongProcess_Control_ProgressBar.RegisterInEngine

type
  Tkw_LongProcess_Control_ProgressBar_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ProgressBar
----
*������ �������������*:
[code]
�������::ProgressBar:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_LongProcess_Control_ProgressBar_Push

// start class Tkw_LongProcess_Control_ProgressBar_Push

procedure Tkw_LongProcess_Control_ProgressBar_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ProgressBar');
 inherited;
end;//Tkw_LongProcess_Control_ProgressBar_Push.DoDoIt

class function Tkw_LongProcess_Control_ProgressBar_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ProgressBar:push';
end;//Tkw_LongProcess_Control_ProgressBar_Push.GetWordNameForRegister

type
  Tkw_LongProcess_Control_LeftPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� LeftPanel
----
*������ �������������*:
[code]
�������::LeftPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_LongProcess_Control_LeftPanel

// start class Tkw_LongProcess_Control_LeftPanel

class function Tkw_LongProcess_Control_LeftPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::LeftPanel';
end;//Tkw_LongProcess_Control_LeftPanel.GetWordNameForRegister

function Tkw_LongProcess_Control_LeftPanel.GetString: AnsiString;
 {-}
begin
 Result := 'LeftPanel';
end;//Tkw_LongProcess_Control_LeftPanel.GetString

class procedure Tkw_LongProcess_Control_LeftPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_LongProcess_Control_LeftPanel.RegisterInEngine

type
  Tkw_LongProcess_Control_LeftPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� LeftPanel
----
*������ �������������*:
[code]
�������::LeftPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_LongProcess_Control_LeftPanel_Push

// start class Tkw_LongProcess_Control_LeftPanel_Push

procedure Tkw_LongProcess_Control_LeftPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('LeftPanel');
 inherited;
end;//Tkw_LongProcess_Control_LeftPanel_Push.DoDoIt

class function Tkw_LongProcess_Control_LeftPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::LeftPanel:push';
end;//Tkw_LongProcess_Control_LeftPanel_Push.GetWordNameForRegister

type
  Tkw_LongProcess_Control_Image = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� Image
----
*������ �������������*:
[code]
�������::Image TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_LongProcess_Control_Image

// start class Tkw_LongProcess_Control_Image

class function Tkw_LongProcess_Control_Image.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Image';
end;//Tkw_LongProcess_Control_Image.GetWordNameForRegister

function Tkw_LongProcess_Control_Image.GetString: AnsiString;
 {-}
begin
 Result := 'Image';
end;//Tkw_LongProcess_Control_Image.GetString

class procedure Tkw_LongProcess_Control_Image.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TImage);
end;//Tkw_LongProcess_Control_Image.RegisterInEngine

type
  Tkw_LongProcess_Control_Image_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� Image
----
*������ �������������*:
[code]
�������::Image:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_LongProcess_Control_Image_Push

// start class Tkw_LongProcess_Control_Image_Push

procedure Tkw_LongProcess_Control_Image_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Image');
 inherited;
end;//Tkw_LongProcess_Control_Image_Push.DoDoIt

class function Tkw_LongProcess_Control_Image_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::Image:push';
end;//Tkw_LongProcess_Control_Image_Push.GetWordNameForRegister

type
  Tkw_LongProcess_Control_ButtonPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ButtonPanel
----
*������ �������������*:
[code]
�������::ButtonPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_LongProcess_Control_ButtonPanel

// start class Tkw_LongProcess_Control_ButtonPanel

class function Tkw_LongProcess_Control_ButtonPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ButtonPanel';
end;//Tkw_LongProcess_Control_ButtonPanel.GetWordNameForRegister

function Tkw_LongProcess_Control_ButtonPanel.GetString: AnsiString;
 {-}
begin
 Result := 'ButtonPanel';
end;//Tkw_LongProcess_Control_ButtonPanel.GetString

class procedure Tkw_LongProcess_Control_ButtonPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_LongProcess_Control_ButtonPanel.RegisterInEngine

type
  Tkw_LongProcess_Control_ButtonPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ButtonPanel
----
*������ �������������*:
[code]
�������::ButtonPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_LongProcess_Control_ButtonPanel_Push

// start class Tkw_LongProcess_Control_ButtonPanel_Push

procedure Tkw_LongProcess_Control_ButtonPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ButtonPanel');
 inherited;
end;//Tkw_LongProcess_Control_ButtonPanel_Push.DoDoIt

class function Tkw_LongProcess_Control_ButtonPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ButtonPanel:push';
end;//Tkw_LongProcess_Control_ButtonPanel_Push.GetWordNameForRegister

type
  Tkw_LongProcess_Control_btnExit = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� btnExit
----
*������ �������������*:
[code]
�������::btnExit TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_LongProcess_Control_btnExit

// start class Tkw_LongProcess_Control_btnExit

class function Tkw_LongProcess_Control_btnExit.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnExit';
end;//Tkw_LongProcess_Control_btnExit.GetWordNameForRegister

function Tkw_LongProcess_Control_btnExit.GetString: AnsiString;
 {-}
begin
 Result := 'btnExit';
end;//Tkw_LongProcess_Control_btnExit.GetString

class procedure Tkw_LongProcess_Control_btnExit.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_LongProcess_Control_btnExit.RegisterInEngine

type
  Tkw_LongProcess_Control_btnExit_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� btnExit
----
*������ �������������*:
[code]
�������::btnExit:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_LongProcess_Control_btnExit_Push

// start class Tkw_LongProcess_Control_btnExit_Push

procedure Tkw_LongProcess_Control_btnExit_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('btnExit');
 inherited;
end;//Tkw_LongProcess_Control_btnExit_Push.DoDoIt

class function Tkw_LongProcess_Control_btnExit_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::btnExit:push';
end;//Tkw_LongProcess_Control_btnExit_Push.GetWordNameForRegister

type
  TkwLongProcessFormClientPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TLongProcessForm.ClientPanel
[panel]������� ClientPanel ����� TLongProcessForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aLongProcessForm .TLongProcessForm.ClientPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function ClientPanel(const aCtx: TtfwContext;
     aLongProcessForm: TLongProcessForm): TvtPanel;
     {* ���������� ����� ������� .TLongProcessForm.ClientPanel }
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
  end;//TkwLongProcessFormClientPanel

// start class TkwLongProcessFormClientPanel

function TkwLongProcessFormClientPanel.ClientPanel(const aCtx: TtfwContext;
  aLongProcessForm: TLongProcessForm): TvtPanel;
 {-}
begin
 Result := aLongProcessForm.ClientPanel;
end;//TkwLongProcessFormClientPanel.ClientPanel

procedure TkwLongProcessFormClientPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLongProcessForm : TLongProcessForm;
begin
 try
  l_aLongProcessForm := TLongProcessForm(aCtx.rEngine.PopObjAs(TLongProcessForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLongProcessForm: TLongProcessForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ClientPanel(aCtx, l_aLongProcessForm)));
end;//TkwLongProcessFormClientPanel.DoDoIt

class function TkwLongProcessFormClientPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLongProcessForm.ClientPanel';
end;//TkwLongProcessFormClientPanel.GetWordNameForRegister

procedure TkwLongProcessFormClientPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ClientPanel', aCtx);
end;//TkwLongProcessFormClientPanel.SetValuePrim

function TkwLongProcessFormClientPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwLongProcessFormClientPanel.GetResultTypeInfo

function TkwLongProcessFormClientPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLongProcessFormClientPanel.GetAllParamsCount

function TkwLongProcessFormClientPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLongProcessForm)]);
end;//TkwLongProcessFormClientPanel.ParamsTypes

type
  TkwLongProcessFormMessageLabel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TLongProcessForm.MessageLabel
[panel]������� MessageLabel ����� TLongProcessForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aLongProcessForm .TLongProcessForm.MessageLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function MessageLabel(const aCtx: TtfwContext;
     aLongProcessForm: TLongProcessForm): TvtLabel;
     {* ���������� ����� ������� .TLongProcessForm.MessageLabel }
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
  end;//TkwLongProcessFormMessageLabel

// start class TkwLongProcessFormMessageLabel

function TkwLongProcessFormMessageLabel.MessageLabel(const aCtx: TtfwContext;
  aLongProcessForm: TLongProcessForm): TvtLabel;
 {-}
begin
 Result := aLongProcessForm.MessageLabel;
end;//TkwLongProcessFormMessageLabel.MessageLabel

procedure TkwLongProcessFormMessageLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLongProcessForm : TLongProcessForm;
begin
 try
  l_aLongProcessForm := TLongProcessForm(aCtx.rEngine.PopObjAs(TLongProcessForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLongProcessForm: TLongProcessForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((MessageLabel(aCtx, l_aLongProcessForm)));
end;//TkwLongProcessFormMessageLabel.DoDoIt

class function TkwLongProcessFormMessageLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLongProcessForm.MessageLabel';
end;//TkwLongProcessFormMessageLabel.GetWordNameForRegister

procedure TkwLongProcessFormMessageLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� MessageLabel', aCtx);
end;//TkwLongProcessFormMessageLabel.SetValuePrim

function TkwLongProcessFormMessageLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwLongProcessFormMessageLabel.GetResultTypeInfo

function TkwLongProcessFormMessageLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLongProcessFormMessageLabel.GetAllParamsCount

function TkwLongProcessFormMessageLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLongProcessForm)]);
end;//TkwLongProcessFormMessageLabel.ParamsTypes

type
  TkwLongProcessFormBottomPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TLongProcessForm.BottomPanel
[panel]������� BottomPanel ����� TLongProcessForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aLongProcessForm .TLongProcessForm.BottomPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function BottomPanel(const aCtx: TtfwContext;
     aLongProcessForm: TLongProcessForm): TvtPanel;
     {* ���������� ����� ������� .TLongProcessForm.BottomPanel }
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
  end;//TkwLongProcessFormBottomPanel

// start class TkwLongProcessFormBottomPanel

function TkwLongProcessFormBottomPanel.BottomPanel(const aCtx: TtfwContext;
  aLongProcessForm: TLongProcessForm): TvtPanel;
 {-}
begin
 Result := aLongProcessForm.BottomPanel;
end;//TkwLongProcessFormBottomPanel.BottomPanel

procedure TkwLongProcessFormBottomPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLongProcessForm : TLongProcessForm;
begin
 try
  l_aLongProcessForm := TLongProcessForm(aCtx.rEngine.PopObjAs(TLongProcessForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLongProcessForm: TLongProcessForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BottomPanel(aCtx, l_aLongProcessForm)));
end;//TkwLongProcessFormBottomPanel.DoDoIt

class function TkwLongProcessFormBottomPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLongProcessForm.BottomPanel';
end;//TkwLongProcessFormBottomPanel.GetWordNameForRegister

procedure TkwLongProcessFormBottomPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� BottomPanel', aCtx);
end;//TkwLongProcessFormBottomPanel.SetValuePrim

function TkwLongProcessFormBottomPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwLongProcessFormBottomPanel.GetResultTypeInfo

function TkwLongProcessFormBottomPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLongProcessFormBottomPanel.GetAllParamsCount

function TkwLongProcessFormBottomPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLongProcessForm)]);
end;//TkwLongProcessFormBottomPanel.ParamsTypes

type
  TkwLongProcessFormProgressBar = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TLongProcessForm.ProgressBar
[panel]������� ProgressBar ����� TLongProcessForm[panel]
*��� ����������:* TvtGradientWaitbar
*������:*
[code]
OBJECT VAR l_TvtGradientWaitbar
 aLongProcessForm .TLongProcessForm.ProgressBar >>> l_TvtGradientWaitbar
[code]  }
  private
  // private methods
   function ProgressBar(const aCtx: TtfwContext;
     aLongProcessForm: TLongProcessForm): TvtGradientWaitbar;
     {* ���������� ����� ������� .TLongProcessForm.ProgressBar }
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
  end;//TkwLongProcessFormProgressBar

// start class TkwLongProcessFormProgressBar

function TkwLongProcessFormProgressBar.ProgressBar(const aCtx: TtfwContext;
  aLongProcessForm: TLongProcessForm): TvtGradientWaitbar;
 {-}
begin
 Result := aLongProcessForm.ProgressBar;
end;//TkwLongProcessFormProgressBar.ProgressBar

procedure TkwLongProcessFormProgressBar.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLongProcessForm : TLongProcessForm;
begin
 try
  l_aLongProcessForm := TLongProcessForm(aCtx.rEngine.PopObjAs(TLongProcessForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLongProcessForm: TLongProcessForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ProgressBar(aCtx, l_aLongProcessForm)));
end;//TkwLongProcessFormProgressBar.DoDoIt

class function TkwLongProcessFormProgressBar.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLongProcessForm.ProgressBar';
end;//TkwLongProcessFormProgressBar.GetWordNameForRegister

procedure TkwLongProcessFormProgressBar.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ProgressBar', aCtx);
end;//TkwLongProcessFormProgressBar.SetValuePrim

function TkwLongProcessFormProgressBar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtGradientWaitbar);
end;//TkwLongProcessFormProgressBar.GetResultTypeInfo

function TkwLongProcessFormProgressBar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLongProcessFormProgressBar.GetAllParamsCount

function TkwLongProcessFormProgressBar.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLongProcessForm)]);
end;//TkwLongProcessFormProgressBar.ParamsTypes

type
  TkwLongProcessFormLeftPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TLongProcessForm.LeftPanel
[panel]������� LeftPanel ����� TLongProcessForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aLongProcessForm .TLongProcessForm.LeftPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function LeftPanel(const aCtx: TtfwContext;
     aLongProcessForm: TLongProcessForm): TvtPanel;
     {* ���������� ����� ������� .TLongProcessForm.LeftPanel }
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
  end;//TkwLongProcessFormLeftPanel

// start class TkwLongProcessFormLeftPanel

function TkwLongProcessFormLeftPanel.LeftPanel(const aCtx: TtfwContext;
  aLongProcessForm: TLongProcessForm): TvtPanel;
 {-}
begin
 Result := aLongProcessForm.LeftPanel;
end;//TkwLongProcessFormLeftPanel.LeftPanel

procedure TkwLongProcessFormLeftPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLongProcessForm : TLongProcessForm;
begin
 try
  l_aLongProcessForm := TLongProcessForm(aCtx.rEngine.PopObjAs(TLongProcessForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLongProcessForm: TLongProcessForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LeftPanel(aCtx, l_aLongProcessForm)));
end;//TkwLongProcessFormLeftPanel.DoDoIt

class function TkwLongProcessFormLeftPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLongProcessForm.LeftPanel';
end;//TkwLongProcessFormLeftPanel.GetWordNameForRegister

procedure TkwLongProcessFormLeftPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� LeftPanel', aCtx);
end;//TkwLongProcessFormLeftPanel.SetValuePrim

function TkwLongProcessFormLeftPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwLongProcessFormLeftPanel.GetResultTypeInfo

function TkwLongProcessFormLeftPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLongProcessFormLeftPanel.GetAllParamsCount

function TkwLongProcessFormLeftPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLongProcessForm)]);
end;//TkwLongProcessFormLeftPanel.ParamsTypes

type
  TkwLongProcessFormImage = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TLongProcessForm.Image
[panel]������� Image ����� TLongProcessForm[panel]
*��� ����������:* TImage
*������:*
[code]
OBJECT VAR l_TImage
 aLongProcessForm .TLongProcessForm.Image >>> l_TImage
[code]  }
  private
  // private methods
   function Image(const aCtx: TtfwContext;
     aLongProcessForm: TLongProcessForm): TImage;
     {* ���������� ����� ������� .TLongProcessForm.Image }
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
  end;//TkwLongProcessFormImage

// start class TkwLongProcessFormImage

function TkwLongProcessFormImage.Image(const aCtx: TtfwContext;
  aLongProcessForm: TLongProcessForm): TImage;
 {-}
begin
 Result := aLongProcessForm.Image;
end;//TkwLongProcessFormImage.Image

procedure TkwLongProcessFormImage.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLongProcessForm : TLongProcessForm;
begin
 try
  l_aLongProcessForm := TLongProcessForm(aCtx.rEngine.PopObjAs(TLongProcessForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLongProcessForm: TLongProcessForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Image(aCtx, l_aLongProcessForm)));
end;//TkwLongProcessFormImage.DoDoIt

class function TkwLongProcessFormImage.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLongProcessForm.Image';
end;//TkwLongProcessFormImage.GetWordNameForRegister

procedure TkwLongProcessFormImage.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� Image', aCtx);
end;//TkwLongProcessFormImage.SetValuePrim

function TkwLongProcessFormImage.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TImage);
end;//TkwLongProcessFormImage.GetResultTypeInfo

function TkwLongProcessFormImage.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLongProcessFormImage.GetAllParamsCount

function TkwLongProcessFormImage.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLongProcessForm)]);
end;//TkwLongProcessFormImage.ParamsTypes

type
  TkwLongProcessFormButtonPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TLongProcessForm.ButtonPanel
[panel]������� ButtonPanel ����� TLongProcessForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aLongProcessForm .TLongProcessForm.ButtonPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function ButtonPanel(const aCtx: TtfwContext;
     aLongProcessForm: TLongProcessForm): TvtPanel;
     {* ���������� ����� ������� .TLongProcessForm.ButtonPanel }
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
  end;//TkwLongProcessFormButtonPanel

// start class TkwLongProcessFormButtonPanel

function TkwLongProcessFormButtonPanel.ButtonPanel(const aCtx: TtfwContext;
  aLongProcessForm: TLongProcessForm): TvtPanel;
 {-}
begin
 Result := aLongProcessForm.ButtonPanel;
end;//TkwLongProcessFormButtonPanel.ButtonPanel

procedure TkwLongProcessFormButtonPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLongProcessForm : TLongProcessForm;
begin
 try
  l_aLongProcessForm := TLongProcessForm(aCtx.rEngine.PopObjAs(TLongProcessForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLongProcessForm: TLongProcessForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ButtonPanel(aCtx, l_aLongProcessForm)));
end;//TkwLongProcessFormButtonPanel.DoDoIt

class function TkwLongProcessFormButtonPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLongProcessForm.ButtonPanel';
end;//TkwLongProcessFormButtonPanel.GetWordNameForRegister

procedure TkwLongProcessFormButtonPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ButtonPanel', aCtx);
end;//TkwLongProcessFormButtonPanel.SetValuePrim

function TkwLongProcessFormButtonPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwLongProcessFormButtonPanel.GetResultTypeInfo

function TkwLongProcessFormButtonPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLongProcessFormButtonPanel.GetAllParamsCount

function TkwLongProcessFormButtonPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLongProcessForm)]);
end;//TkwLongProcessFormButtonPanel.ParamsTypes

type
  TkwLongProcessFormBtnExit = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TLongProcessForm.btnExit
[panel]������� btnExit ����� TLongProcessForm[panel]
*��� ����������:* TvtButton
*������:*
[code]
OBJECT VAR l_TvtButton
 aLongProcessForm .TLongProcessForm.btnExit >>> l_TvtButton
[code]  }
  private
  // private methods
   function BtnExit(const aCtx: TtfwContext;
     aLongProcessForm: TLongProcessForm): TvtButton;
     {* ���������� ����� ������� .TLongProcessForm.btnExit }
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
  end;//TkwLongProcessFormBtnExit

// start class TkwLongProcessFormBtnExit

function TkwLongProcessFormBtnExit.BtnExit(const aCtx: TtfwContext;
  aLongProcessForm: TLongProcessForm): TvtButton;
 {-}
begin
 Result := aLongProcessForm.btnExit;
end;//TkwLongProcessFormBtnExit.BtnExit

procedure TkwLongProcessFormBtnExit.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLongProcessForm : TLongProcessForm;
begin
 try
  l_aLongProcessForm := TLongProcessForm(aCtx.rEngine.PopObjAs(TLongProcessForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aLongProcessForm: TLongProcessForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BtnExit(aCtx, l_aLongProcessForm)));
end;//TkwLongProcessFormBtnExit.DoDoIt

class function TkwLongProcessFormBtnExit.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TLongProcessForm.btnExit';
end;//TkwLongProcessFormBtnExit.GetWordNameForRegister

procedure TkwLongProcessFormBtnExit.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� btnExit', aCtx);
end;//TkwLongProcessFormBtnExit.SetValuePrim

function TkwLongProcessFormBtnExit.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtButton);
end;//TkwLongProcessFormBtnExit.GetResultTypeInfo

function TkwLongProcessFormBtnExit.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwLongProcessFormBtnExit.GetAllParamsCount

function TkwLongProcessFormBtnExit.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TLongProcessForm)]);
end;//TkwLongProcessFormBtnExit.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_Form_LongProcess
 Tkw_Form_LongProcess.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_LongProcess_Control_ClientPanel
 Tkw_LongProcess_Control_ClientPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_LongProcess_Control_ClientPanel_Push
 Tkw_LongProcess_Control_ClientPanel_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_LongProcess_Control_MessageLabel
 Tkw_LongProcess_Control_MessageLabel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_LongProcess_Control_MessageLabel_Push
 Tkw_LongProcess_Control_MessageLabel_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_LongProcess_Control_BottomPanel
 Tkw_LongProcess_Control_BottomPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_LongProcess_Control_BottomPanel_Push
 Tkw_LongProcess_Control_BottomPanel_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_LongProcess_Control_ProgressBar
 Tkw_LongProcess_Control_ProgressBar.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_LongProcess_Control_ProgressBar_Push
 Tkw_LongProcess_Control_ProgressBar_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_LongProcess_Control_LeftPanel
 Tkw_LongProcess_Control_LeftPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_LongProcess_Control_LeftPanel_Push
 Tkw_LongProcess_Control_LeftPanel_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_LongProcess_Control_Image
 Tkw_LongProcess_Control_Image.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_LongProcess_Control_Image_Push
 Tkw_LongProcess_Control_Image_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_LongProcess_Control_ButtonPanel
 Tkw_LongProcess_Control_ButtonPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_LongProcess_Control_ButtonPanel_Push
 Tkw_LongProcess_Control_ButtonPanel_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_LongProcess_Control_btnExit
 Tkw_LongProcess_Control_btnExit.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_LongProcess_Control_btnExit_Push
 Tkw_LongProcess_Control_btnExit_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� LongProcessForm_ClientPanel
 TkwLongProcessFormClientPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� LongProcessForm_MessageLabel
 TkwLongProcessFormMessageLabel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� LongProcessForm_BottomPanel
 TkwLongProcessFormBottomPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� LongProcessForm_ProgressBar
 TkwLongProcessFormProgressBar.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� LongProcessForm_LeftPanel
 TkwLongProcessFormLeftPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� LongProcessForm_Image
 TkwLongProcessFormImage.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� LongProcessForm_ButtonPanel
 TkwLongProcessFormButtonPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� LongProcessForm_btnExit
 TkwLongProcessFormBtnExit.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� LongProcess
 TtfwTypeRegistrator.RegisterType(TypeInfo(TLongProcessForm));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TvtGradientWaitbar
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtGradientWaitbar));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TImage
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImage));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TvtButton
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtButton));
{$IfEnd} //not NoScripts

end.