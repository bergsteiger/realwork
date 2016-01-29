unit StartupTipsKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/DayTips/StartupTipsKeywordsPack.pas"
// �����: 04.09.2009 12:52
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������������ ��������::DayTips::View::DayTips::DayTips::StartupTipsKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� StartupTips
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
  ,
  vtPanel,
  vtFocusLabel,
  StartupTips_Form,
  vtLabel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  vtCheckBox,
  ElPopBtn,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_StartupTips = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� StartupTips
----
*������ �������������*:
[code]
'aControl' �����::StartupTips TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_StartupTips

// start class Tkw_Form_StartupTips

class function Tkw_Form_StartupTips.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::StartupTips';
end;//Tkw_Form_StartupTips.GetWordNameForRegister

function Tkw_Form_StartupTips.GetString: AnsiString;
 {-}
begin
 Result := 'efStartupTips';
end;//Tkw_Form_StartupTips.GetString

type
  Tkw_StartupTips_Control_TopPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� TopPanel
----
*������ �������������*:
[code]
�������::TopPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StartupTips_Control_TopPanel

// start class Tkw_StartupTips_Control_TopPanel

class function Tkw_StartupTips_Control_TopPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::TopPanel';
end;//Tkw_StartupTips_Control_TopPanel.GetWordNameForRegister

function Tkw_StartupTips_Control_TopPanel.GetString: AnsiString;
 {-}
begin
 Result := 'TopPanel';
end;//Tkw_StartupTips_Control_TopPanel.GetString

class procedure Tkw_StartupTips_Control_TopPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_StartupTips_Control_TopPanel.RegisterInEngine

type
  Tkw_StartupTips_Control_TopPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� TopPanel
----
*������ �������������*:
[code]
�������::TopPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StartupTips_Control_TopPanel_Push

// start class Tkw_StartupTips_Control_TopPanel_Push

procedure Tkw_StartupTips_Control_TopPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('TopPanel');
 inherited;
end;//Tkw_StartupTips_Control_TopPanel_Push.DoDoIt

class function Tkw_StartupTips_Control_TopPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::TopPanel:push';
end;//Tkw_StartupTips_Control_TopPanel_Push.GetWordNameForRegister

type
  Tkw_StartupTips_Control_TitlePaintBox = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� TitlePaintBox
----
*������ �������������*:
[code]
�������::TitlePaintBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StartupTips_Control_TitlePaintBox

// start class Tkw_StartupTips_Control_TitlePaintBox

class function Tkw_StartupTips_Control_TitlePaintBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::TitlePaintBox';
end;//Tkw_StartupTips_Control_TitlePaintBox.GetWordNameForRegister

function Tkw_StartupTips_Control_TitlePaintBox.GetString: AnsiString;
 {-}
begin
 Result := 'TitlePaintBox';
end;//Tkw_StartupTips_Control_TitlePaintBox.GetString

class procedure Tkw_StartupTips_Control_TitlePaintBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_StartupTips_Control_TitlePaintBox.RegisterInEngine

type
  Tkw_StartupTips_Control_TitlePaintBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� TitlePaintBox
----
*������ �������������*:
[code]
�������::TitlePaintBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StartupTips_Control_TitlePaintBox_Push

// start class Tkw_StartupTips_Control_TitlePaintBox_Push

procedure Tkw_StartupTips_Control_TitlePaintBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('TitlePaintBox');
 inherited;
end;//Tkw_StartupTips_Control_TitlePaintBox_Push.DoDoIt

class function Tkw_StartupTips_Control_TitlePaintBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::TitlePaintBox:push';
end;//Tkw_StartupTips_Control_TitlePaintBox_Push.GetWordNameForRegister

type
  Tkw_StartupTips_Control_TitleLabel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� TitleLabel
----
*������ �������������*:
[code]
�������::TitleLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StartupTips_Control_TitleLabel

// start class Tkw_StartupTips_Control_TitleLabel

class function Tkw_StartupTips_Control_TitleLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::TitleLabel';
end;//Tkw_StartupTips_Control_TitleLabel.GetWordNameForRegister

function Tkw_StartupTips_Control_TitleLabel.GetString: AnsiString;
 {-}
begin
 Result := 'TitleLabel';
end;//Tkw_StartupTips_Control_TitleLabel.GetString

class procedure Tkw_StartupTips_Control_TitleLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StartupTips_Control_TitleLabel.RegisterInEngine

type
  Tkw_StartupTips_Control_TitleLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� TitleLabel
----
*������ �������������*:
[code]
�������::TitleLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StartupTips_Control_TitleLabel_Push

// start class Tkw_StartupTips_Control_TitleLabel_Push

procedure Tkw_StartupTips_Control_TitleLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('TitleLabel');
 inherited;
end;//Tkw_StartupTips_Control_TitleLabel_Push.DoDoIt

class function Tkw_StartupTips_Control_TitleLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::TitleLabel:push';
end;//Tkw_StartupTips_Control_TitleLabel_Push.GetWordNameForRegister

type
  Tkw_StartupTips_Control_BottomPanel = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_StartupTips_Control_BottomPanel

// start class Tkw_StartupTips_Control_BottomPanel

class function Tkw_StartupTips_Control_BottomPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BottomPanel';
end;//Tkw_StartupTips_Control_BottomPanel.GetWordNameForRegister

function Tkw_StartupTips_Control_BottomPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BottomPanel';
end;//Tkw_StartupTips_Control_BottomPanel.GetString

class procedure Tkw_StartupTips_Control_BottomPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_StartupTips_Control_BottomPanel.RegisterInEngine

type
  Tkw_StartupTips_Control_BottomPanel_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_StartupTips_Control_BottomPanel_Push

// start class Tkw_StartupTips_Control_BottomPanel_Push

procedure Tkw_StartupTips_Control_BottomPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BottomPanel');
 inherited;
end;//Tkw_StartupTips_Control_BottomPanel_Push.DoDoIt

class function Tkw_StartupTips_Control_BottomPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BottomPanel:push';
end;//Tkw_StartupTips_Control_BottomPanel_Push.GetWordNameForRegister

type
  Tkw_StartupTips_Control_HintPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� HintPanel
----
*������ �������������*:
[code]
�������::HintPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StartupTips_Control_HintPanel

// start class Tkw_StartupTips_Control_HintPanel

class function Tkw_StartupTips_Control_HintPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::HintPanel';
end;//Tkw_StartupTips_Control_HintPanel.GetWordNameForRegister

function Tkw_StartupTips_Control_HintPanel.GetString: AnsiString;
 {-}
begin
 Result := 'HintPanel';
end;//Tkw_StartupTips_Control_HintPanel.GetString

class procedure Tkw_StartupTips_Control_HintPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_StartupTips_Control_HintPanel.RegisterInEngine

type
  Tkw_StartupTips_Control_HintPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� HintPanel
----
*������ �������������*:
[code]
�������::HintPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StartupTips_Control_HintPanel_Push

// start class Tkw_StartupTips_Control_HintPanel_Push

procedure Tkw_StartupTips_Control_HintPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('HintPanel');
 inherited;
end;//Tkw_StartupTips_Control_HintPanel_Push.DoDoIt

class function Tkw_StartupTips_Control_HintPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::HintPanel:push';
end;//Tkw_StartupTips_Control_HintPanel_Push.GetWordNameForRegister

type
  Tkw_StartupTips_Control_TipLabel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� TipLabel
----
*������ �������������*:
[code]
�������::TipLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StartupTips_Control_TipLabel

// start class Tkw_StartupTips_Control_TipLabel

class function Tkw_StartupTips_Control_TipLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::TipLabel';
end;//Tkw_StartupTips_Control_TipLabel.GetWordNameForRegister

function Tkw_StartupTips_Control_TipLabel.GetString: AnsiString;
 {-}
begin
 Result := 'TipLabel';
end;//Tkw_StartupTips_Control_TipLabel.GetString

class procedure Tkw_StartupTips_Control_TipLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StartupTips_Control_TipLabel.RegisterInEngine

type
  Tkw_StartupTips_Control_TipLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� TipLabel
----
*������ �������������*:
[code]
�������::TipLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StartupTips_Control_TipLabel_Push

// start class Tkw_StartupTips_Control_TipLabel_Push

procedure Tkw_StartupTips_Control_TipLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('TipLabel');
 inherited;
end;//Tkw_StartupTips_Control_TipLabel_Push.DoDoIt

class function Tkw_StartupTips_Control_TipLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::TipLabel:push';
end;//Tkw_StartupTips_Control_TipLabel_Push.GetWordNameForRegister

type
  Tkw_StartupTips_Control_DetailLabel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� DetailLabel
----
*������ �������������*:
[code]
�������::DetailLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StartupTips_Control_DetailLabel

// start class Tkw_StartupTips_Control_DetailLabel

class function Tkw_StartupTips_Control_DetailLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::DetailLabel';
end;//Tkw_StartupTips_Control_DetailLabel.GetWordNameForRegister

function Tkw_StartupTips_Control_DetailLabel.GetString: AnsiString;
 {-}
begin
 Result := 'DetailLabel';
end;//Tkw_StartupTips_Control_DetailLabel.GetString

class procedure Tkw_StartupTips_Control_DetailLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_StartupTips_Control_DetailLabel.RegisterInEngine

type
  Tkw_StartupTips_Control_DetailLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� DetailLabel
----
*������ �������������*:
[code]
�������::DetailLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StartupTips_Control_DetailLabel_Push

// start class Tkw_StartupTips_Control_DetailLabel_Push

procedure Tkw_StartupTips_Control_DetailLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('DetailLabel');
 inherited;
end;//Tkw_StartupTips_Control_DetailLabel_Push.DoDoIt

class function Tkw_StartupTips_Control_DetailLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::DetailLabel:push';
end;//Tkw_StartupTips_Control_DetailLabel_Push.GetWordNameForRegister

type
  Tkw_StartupTips_Control_ShowCheckBox = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ShowCheckBox
----
*������ �������������*:
[code]
�������::ShowCheckBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StartupTips_Control_ShowCheckBox

// start class Tkw_StartupTips_Control_ShowCheckBox

class function Tkw_StartupTips_Control_ShowCheckBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ShowCheckBox';
end;//Tkw_StartupTips_Control_ShowCheckBox.GetWordNameForRegister

function Tkw_StartupTips_Control_ShowCheckBox.GetString: AnsiString;
 {-}
begin
 Result := 'ShowCheckBox';
end;//Tkw_StartupTips_Control_ShowCheckBox.GetString

class procedure Tkw_StartupTips_Control_ShowCheckBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_StartupTips_Control_ShowCheckBox.RegisterInEngine

type
  Tkw_StartupTips_Control_ShowCheckBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ShowCheckBox
----
*������ �������������*:
[code]
�������::ShowCheckBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StartupTips_Control_ShowCheckBox_Push

// start class Tkw_StartupTips_Control_ShowCheckBox_Push

procedure Tkw_StartupTips_Control_ShowCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ShowCheckBox');
 inherited;
end;//Tkw_StartupTips_Control_ShowCheckBox_Push.DoDoIt

class function Tkw_StartupTips_Control_ShowCheckBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ShowCheckBox:push';
end;//Tkw_StartupTips_Control_ShowCheckBox_Push.GetWordNameForRegister

type
  Tkw_StartupTips_Control_wwwPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� wwwPanel
----
*������ �������������*:
[code]
�������::wwwPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StartupTips_Control_wwwPanel

// start class Tkw_StartupTips_Control_wwwPanel

class function Tkw_StartupTips_Control_wwwPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::wwwPanel';
end;//Tkw_StartupTips_Control_wwwPanel.GetWordNameForRegister

function Tkw_StartupTips_Control_wwwPanel.GetString: AnsiString;
 {-}
begin
 Result := 'wwwPanel';
end;//Tkw_StartupTips_Control_wwwPanel.GetString

class procedure Tkw_StartupTips_Control_wwwPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_StartupTips_Control_wwwPanel.RegisterInEngine

type
  Tkw_StartupTips_Control_wwwPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� wwwPanel
----
*������ �������������*:
[code]
�������::wwwPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StartupTips_Control_wwwPanel_Push

// start class Tkw_StartupTips_Control_wwwPanel_Push

procedure Tkw_StartupTips_Control_wwwPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('wwwPanel');
 inherited;
end;//Tkw_StartupTips_Control_wwwPanel_Push.DoDoIt

class function Tkw_StartupTips_Control_wwwPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::wwwPanel:push';
end;//Tkw_StartupTips_Control_wwwPanel_Push.GetWordNameForRegister

type
  Tkw_StartupTips_Control_wwwPaintBox = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� wwwPaintBox
----
*������ �������������*:
[code]
�������::wwwPaintBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StartupTips_Control_wwwPaintBox

// start class Tkw_StartupTips_Control_wwwPaintBox

class function Tkw_StartupTips_Control_wwwPaintBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::wwwPaintBox';
end;//Tkw_StartupTips_Control_wwwPaintBox.GetWordNameForRegister

function Tkw_StartupTips_Control_wwwPaintBox.GetString: AnsiString;
 {-}
begin
 Result := 'wwwPaintBox';
end;//Tkw_StartupTips_Control_wwwPaintBox.GetString

class procedure Tkw_StartupTips_Control_wwwPaintBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_StartupTips_Control_wwwPaintBox.RegisterInEngine

type
  Tkw_StartupTips_Control_wwwPaintBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� wwwPaintBox
----
*������ �������������*:
[code]
�������::wwwPaintBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StartupTips_Control_wwwPaintBox_Push

// start class Tkw_StartupTips_Control_wwwPaintBox_Push

procedure Tkw_StartupTips_Control_wwwPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('wwwPaintBox');
 inherited;
end;//Tkw_StartupTips_Control_wwwPaintBox_Push.DoDoIt

class function Tkw_StartupTips_Control_wwwPaintBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::wwwPaintBox:push';
end;//Tkw_StartupTips_Control_wwwPaintBox_Push.GetWordNameForRegister

type
  Tkw_StartupTips_Control_wwwLabel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� wwwLabel
----
*������ �������������*:
[code]
�������::wwwLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StartupTips_Control_wwwLabel

// start class Tkw_StartupTips_Control_wwwLabel

class function Tkw_StartupTips_Control_wwwLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::wwwLabel';
end;//Tkw_StartupTips_Control_wwwLabel.GetWordNameForRegister

function Tkw_StartupTips_Control_wwwLabel.GetString: AnsiString;
 {-}
begin
 Result := 'wwwLabel';
end;//Tkw_StartupTips_Control_wwwLabel.GetString

class procedure Tkw_StartupTips_Control_wwwLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_StartupTips_Control_wwwLabel.RegisterInEngine

type
  Tkw_StartupTips_Control_wwwLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� wwwLabel
----
*������ �������������*:
[code]
�������::wwwLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StartupTips_Control_wwwLabel_Push

// start class Tkw_StartupTips_Control_wwwLabel_Push

procedure Tkw_StartupTips_Control_wwwLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('wwwLabel');
 inherited;
end;//Tkw_StartupTips_Control_wwwLabel_Push.DoDoIt

class function Tkw_StartupTips_Control_wwwLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::wwwLabel:push';
end;//Tkw_StartupTips_Control_wwwLabel_Push.GetWordNameForRegister

type
  Tkw_StartupTips_Control_NextButton = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� NextButton
----
*������ �������������*:
[code]
�������::NextButton TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StartupTips_Control_NextButton

// start class Tkw_StartupTips_Control_NextButton

class function Tkw_StartupTips_Control_NextButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::NextButton';
end;//Tkw_StartupTips_Control_NextButton.GetWordNameForRegister

function Tkw_StartupTips_Control_NextButton.GetString: AnsiString;
 {-}
begin
 Result := 'NextButton';
end;//Tkw_StartupTips_Control_NextButton.GetString

class procedure Tkw_StartupTips_Control_NextButton.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StartupTips_Control_NextButton.RegisterInEngine

type
  Tkw_StartupTips_Control_NextButton_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� NextButton
----
*������ �������������*:
[code]
�������::NextButton:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StartupTips_Control_NextButton_Push

// start class Tkw_StartupTips_Control_NextButton_Push

procedure Tkw_StartupTips_Control_NextButton_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('NextButton');
 inherited;
end;//Tkw_StartupTips_Control_NextButton_Push.DoDoIt

class function Tkw_StartupTips_Control_NextButton_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::NextButton:push';
end;//Tkw_StartupTips_Control_NextButton_Push.GetWordNameForRegister

type
  Tkw_StartupTips_Control_PrevButton = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� PrevButton
----
*������ �������������*:
[code]
�������::PrevButton TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StartupTips_Control_PrevButton

// start class Tkw_StartupTips_Control_PrevButton

class function Tkw_StartupTips_Control_PrevButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::PrevButton';
end;//Tkw_StartupTips_Control_PrevButton.GetWordNameForRegister

function Tkw_StartupTips_Control_PrevButton.GetString: AnsiString;
 {-}
begin
 Result := 'PrevButton';
end;//Tkw_StartupTips_Control_PrevButton.GetString

class procedure Tkw_StartupTips_Control_PrevButton.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StartupTips_Control_PrevButton.RegisterInEngine

type
  Tkw_StartupTips_Control_PrevButton_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� PrevButton
----
*������ �������������*:
[code]
�������::PrevButton:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StartupTips_Control_PrevButton_Push

// start class Tkw_StartupTips_Control_PrevButton_Push

procedure Tkw_StartupTips_Control_PrevButton_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('PrevButton');
 inherited;
end;//Tkw_StartupTips_Control_PrevButton_Push.DoDoIt

class function Tkw_StartupTips_Control_PrevButton_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::PrevButton:push';
end;//Tkw_StartupTips_Control_PrevButton_Push.GetWordNameForRegister

type
  Tkw_StartupTips_Control_CloseButton = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� CloseButton
----
*������ �������������*:
[code]
�������::CloseButton TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StartupTips_Control_CloseButton

// start class Tkw_StartupTips_Control_CloseButton

class function Tkw_StartupTips_Control_CloseButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::CloseButton';
end;//Tkw_StartupTips_Control_CloseButton.GetWordNameForRegister

function Tkw_StartupTips_Control_CloseButton.GetString: AnsiString;
 {-}
begin
 Result := 'CloseButton';
end;//Tkw_StartupTips_Control_CloseButton.GetString

class procedure Tkw_StartupTips_Control_CloseButton.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StartupTips_Control_CloseButton.RegisterInEngine

type
  Tkw_StartupTips_Control_CloseButton_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� CloseButton
----
*������ �������������*:
[code]
�������::CloseButton:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StartupTips_Control_CloseButton_Push

// start class Tkw_StartupTips_Control_CloseButton_Push

procedure Tkw_StartupTips_Control_CloseButton_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('CloseButton');
 inherited;
end;//Tkw_StartupTips_Control_CloseButton_Push.DoDoIt

class function Tkw_StartupTips_Control_CloseButton_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::CloseButton:push';
end;//Tkw_StartupTips_Control_CloseButton_Push.GetWordNameForRegister

type
  TkwEfStartupTipsTopPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefStartupTips.TopPanel
[panel]������� TopPanel ����� TefStartupTips[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefStartupTips .TefStartupTips.TopPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function TopPanel(const aCtx: TtfwContext;
     aefStartupTips: TefStartupTips): TvtPanel;
     {* ���������� ����� ������� .TefStartupTips.TopPanel }
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
  end;//TkwEfStartupTipsTopPanel

// start class TkwEfStartupTipsTopPanel

function TkwEfStartupTipsTopPanel.TopPanel(const aCtx: TtfwContext;
  aefStartupTips: TefStartupTips): TvtPanel;
 {-}
begin
 Result := aefStartupTips.TopPanel;
end;//TkwEfStartupTipsTopPanel.TopPanel

procedure TkwEfStartupTipsTopPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefStartupTips : TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TopPanel(aCtx, l_aefStartupTips)));
end;//TkwEfStartupTipsTopPanel.DoDoIt

class function TkwEfStartupTipsTopPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefStartupTips.TopPanel';
end;//TkwEfStartupTipsTopPanel.GetWordNameForRegister

procedure TkwEfStartupTipsTopPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� TopPanel', aCtx);
end;//TkwEfStartupTipsTopPanel.SetValuePrim

function TkwEfStartupTipsTopPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfStartupTipsTopPanel.GetResultTypeInfo

function TkwEfStartupTipsTopPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfStartupTipsTopPanel.GetAllParamsCount

function TkwEfStartupTipsTopPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsTopPanel.ParamsTypes

type
  TkwEfStartupTipsTitlePaintBox = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefStartupTips.TitlePaintBox
[panel]������� TitlePaintBox ����� TefStartupTips[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aefStartupTips .TefStartupTips.TitlePaintBox >>> l_TPaintBox
[code]  }
  private
  // private methods
   function TitlePaintBox(const aCtx: TtfwContext;
     aefStartupTips: TefStartupTips): TPaintBox;
     {* ���������� ����� ������� .TefStartupTips.TitlePaintBox }
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
  end;//TkwEfStartupTipsTitlePaintBox

// start class TkwEfStartupTipsTitlePaintBox

function TkwEfStartupTipsTitlePaintBox.TitlePaintBox(const aCtx: TtfwContext;
  aefStartupTips: TefStartupTips): TPaintBox;
 {-}
begin
 Result := aefStartupTips.TitlePaintBox;
end;//TkwEfStartupTipsTitlePaintBox.TitlePaintBox

procedure TkwEfStartupTipsTitlePaintBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefStartupTips : TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TitlePaintBox(aCtx, l_aefStartupTips)));
end;//TkwEfStartupTipsTitlePaintBox.DoDoIt

class function TkwEfStartupTipsTitlePaintBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefStartupTips.TitlePaintBox';
end;//TkwEfStartupTipsTitlePaintBox.GetWordNameForRegister

procedure TkwEfStartupTipsTitlePaintBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� TitlePaintBox', aCtx);
end;//TkwEfStartupTipsTitlePaintBox.SetValuePrim

function TkwEfStartupTipsTitlePaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEfStartupTipsTitlePaintBox.GetResultTypeInfo

function TkwEfStartupTipsTitlePaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfStartupTipsTitlePaintBox.GetAllParamsCount

function TkwEfStartupTipsTitlePaintBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsTitlePaintBox.ParamsTypes

type
  TkwEfStartupTipsTitleLabel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefStartupTips.TitleLabel
[panel]������� TitleLabel ����� TefStartupTips[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefStartupTips .TefStartupTips.TitleLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function TitleLabel(const aCtx: TtfwContext;
     aefStartupTips: TefStartupTips): TvtLabel;
     {* ���������� ����� ������� .TefStartupTips.TitleLabel }
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
  end;//TkwEfStartupTipsTitleLabel

// start class TkwEfStartupTipsTitleLabel

function TkwEfStartupTipsTitleLabel.TitleLabel(const aCtx: TtfwContext;
  aefStartupTips: TefStartupTips): TvtLabel;
 {-}
begin
 Result := aefStartupTips.TitleLabel;
end;//TkwEfStartupTipsTitleLabel.TitleLabel

procedure TkwEfStartupTipsTitleLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefStartupTips : TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TitleLabel(aCtx, l_aefStartupTips)));
end;//TkwEfStartupTipsTitleLabel.DoDoIt

class function TkwEfStartupTipsTitleLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefStartupTips.TitleLabel';
end;//TkwEfStartupTipsTitleLabel.GetWordNameForRegister

procedure TkwEfStartupTipsTitleLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� TitleLabel', aCtx);
end;//TkwEfStartupTipsTitleLabel.SetValuePrim

function TkwEfStartupTipsTitleLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfStartupTipsTitleLabel.GetResultTypeInfo

function TkwEfStartupTipsTitleLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfStartupTipsTitleLabel.GetAllParamsCount

function TkwEfStartupTipsTitleLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsTitleLabel.ParamsTypes

type
  TkwEfStartupTipsBottomPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefStartupTips.BottomPanel
[panel]������� BottomPanel ����� TefStartupTips[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefStartupTips .TefStartupTips.BottomPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function BottomPanel(const aCtx: TtfwContext;
     aefStartupTips: TefStartupTips): TvtPanel;
     {* ���������� ����� ������� .TefStartupTips.BottomPanel }
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
  end;//TkwEfStartupTipsBottomPanel

// start class TkwEfStartupTipsBottomPanel

function TkwEfStartupTipsBottomPanel.BottomPanel(const aCtx: TtfwContext;
  aefStartupTips: TefStartupTips): TvtPanel;
 {-}
begin
 Result := aefStartupTips.BottomPanel;
end;//TkwEfStartupTipsBottomPanel.BottomPanel

procedure TkwEfStartupTipsBottomPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefStartupTips : TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BottomPanel(aCtx, l_aefStartupTips)));
end;//TkwEfStartupTipsBottomPanel.DoDoIt

class function TkwEfStartupTipsBottomPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefStartupTips.BottomPanel';
end;//TkwEfStartupTipsBottomPanel.GetWordNameForRegister

procedure TkwEfStartupTipsBottomPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� BottomPanel', aCtx);
end;//TkwEfStartupTipsBottomPanel.SetValuePrim

function TkwEfStartupTipsBottomPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfStartupTipsBottomPanel.GetResultTypeInfo

function TkwEfStartupTipsBottomPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfStartupTipsBottomPanel.GetAllParamsCount

function TkwEfStartupTipsBottomPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsBottomPanel.ParamsTypes

type
  TkwEfStartupTipsHintPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefStartupTips.HintPanel
[panel]������� HintPanel ����� TefStartupTips[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefStartupTips .TefStartupTips.HintPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function HintPanel(const aCtx: TtfwContext;
     aefStartupTips: TefStartupTips): TvtPanel;
     {* ���������� ����� ������� .TefStartupTips.HintPanel }
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
  end;//TkwEfStartupTipsHintPanel

// start class TkwEfStartupTipsHintPanel

function TkwEfStartupTipsHintPanel.HintPanel(const aCtx: TtfwContext;
  aefStartupTips: TefStartupTips): TvtPanel;
 {-}
begin
 Result := aefStartupTips.HintPanel;
end;//TkwEfStartupTipsHintPanel.HintPanel

procedure TkwEfStartupTipsHintPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefStartupTips : TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((HintPanel(aCtx, l_aefStartupTips)));
end;//TkwEfStartupTipsHintPanel.DoDoIt

class function TkwEfStartupTipsHintPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefStartupTips.HintPanel';
end;//TkwEfStartupTipsHintPanel.GetWordNameForRegister

procedure TkwEfStartupTipsHintPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� HintPanel', aCtx);
end;//TkwEfStartupTipsHintPanel.SetValuePrim

function TkwEfStartupTipsHintPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfStartupTipsHintPanel.GetResultTypeInfo

function TkwEfStartupTipsHintPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfStartupTipsHintPanel.GetAllParamsCount

function TkwEfStartupTipsHintPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsHintPanel.ParamsTypes

type
  TkwEfStartupTipsTipLabel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefStartupTips.TipLabel
[panel]������� TipLabel ����� TefStartupTips[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefStartupTips .TefStartupTips.TipLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function TipLabel(const aCtx: TtfwContext;
     aefStartupTips: TefStartupTips): TvtLabel;
     {* ���������� ����� ������� .TefStartupTips.TipLabel }
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
  end;//TkwEfStartupTipsTipLabel

// start class TkwEfStartupTipsTipLabel

function TkwEfStartupTipsTipLabel.TipLabel(const aCtx: TtfwContext;
  aefStartupTips: TefStartupTips): TvtLabel;
 {-}
begin
 Result := aefStartupTips.TipLabel;
end;//TkwEfStartupTipsTipLabel.TipLabel

procedure TkwEfStartupTipsTipLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefStartupTips : TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TipLabel(aCtx, l_aefStartupTips)));
end;//TkwEfStartupTipsTipLabel.DoDoIt

class function TkwEfStartupTipsTipLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefStartupTips.TipLabel';
end;//TkwEfStartupTipsTipLabel.GetWordNameForRegister

procedure TkwEfStartupTipsTipLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� TipLabel', aCtx);
end;//TkwEfStartupTipsTipLabel.SetValuePrim

function TkwEfStartupTipsTipLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfStartupTipsTipLabel.GetResultTypeInfo

function TkwEfStartupTipsTipLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfStartupTipsTipLabel.GetAllParamsCount

function TkwEfStartupTipsTipLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsTipLabel.ParamsTypes

type
  TkwEfStartupTipsDetailLabel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefStartupTips.DetailLabel
[panel]������� DetailLabel ����� TefStartupTips[panel]
*��� ����������:* TvtFocusLabel
*������:*
[code]
OBJECT VAR l_TvtFocusLabel
 aefStartupTips .TefStartupTips.DetailLabel >>> l_TvtFocusLabel
[code]  }
  private
  // private methods
   function DetailLabel(const aCtx: TtfwContext;
     aefStartupTips: TefStartupTips): TvtFocusLabel;
     {* ���������� ����� ������� .TefStartupTips.DetailLabel }
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
  end;//TkwEfStartupTipsDetailLabel

// start class TkwEfStartupTipsDetailLabel

function TkwEfStartupTipsDetailLabel.DetailLabel(const aCtx: TtfwContext;
  aefStartupTips: TefStartupTips): TvtFocusLabel;
 {-}
begin
 Result := aefStartupTips.DetailLabel;
end;//TkwEfStartupTipsDetailLabel.DetailLabel

procedure TkwEfStartupTipsDetailLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefStartupTips : TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((DetailLabel(aCtx, l_aefStartupTips)));
end;//TkwEfStartupTipsDetailLabel.DoDoIt

class function TkwEfStartupTipsDetailLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefStartupTips.DetailLabel';
end;//TkwEfStartupTipsDetailLabel.GetWordNameForRegister

procedure TkwEfStartupTipsDetailLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� DetailLabel', aCtx);
end;//TkwEfStartupTipsDetailLabel.SetValuePrim

function TkwEfStartupTipsDetailLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwEfStartupTipsDetailLabel.GetResultTypeInfo

function TkwEfStartupTipsDetailLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfStartupTipsDetailLabel.GetAllParamsCount

function TkwEfStartupTipsDetailLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsDetailLabel.ParamsTypes

type
  TkwEfStartupTipsShowCheckBox = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefStartupTips.ShowCheckBox
[panel]������� ShowCheckBox ����� TefStartupTips[panel]
*��� ����������:* TvtCheckBox
*������:*
[code]
OBJECT VAR l_TvtCheckBox
 aefStartupTips .TefStartupTips.ShowCheckBox >>> l_TvtCheckBox
[code]  }
  private
  // private methods
   function ShowCheckBox(const aCtx: TtfwContext;
     aefStartupTips: TefStartupTips): TvtCheckBox;
     {* ���������� ����� ������� .TefStartupTips.ShowCheckBox }
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
  end;//TkwEfStartupTipsShowCheckBox

// start class TkwEfStartupTipsShowCheckBox

function TkwEfStartupTipsShowCheckBox.ShowCheckBox(const aCtx: TtfwContext;
  aefStartupTips: TefStartupTips): TvtCheckBox;
 {-}
begin
 Result := aefStartupTips.ShowCheckBox;
end;//TkwEfStartupTipsShowCheckBox.ShowCheckBox

procedure TkwEfStartupTipsShowCheckBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefStartupTips : TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ShowCheckBox(aCtx, l_aefStartupTips)));
end;//TkwEfStartupTipsShowCheckBox.DoDoIt

class function TkwEfStartupTipsShowCheckBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefStartupTips.ShowCheckBox';
end;//TkwEfStartupTipsShowCheckBox.GetWordNameForRegister

procedure TkwEfStartupTipsShowCheckBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ShowCheckBox', aCtx);
end;//TkwEfStartupTipsShowCheckBox.SetValuePrim

function TkwEfStartupTipsShowCheckBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwEfStartupTipsShowCheckBox.GetResultTypeInfo

function TkwEfStartupTipsShowCheckBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfStartupTipsShowCheckBox.GetAllParamsCount

function TkwEfStartupTipsShowCheckBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsShowCheckBox.ParamsTypes

type
  TkwEfStartupTipsWwwPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefStartupTips.wwwPanel
[panel]������� wwwPanel ����� TefStartupTips[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefStartupTips .TefStartupTips.wwwPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function WwwPanel(const aCtx: TtfwContext;
     aefStartupTips: TefStartupTips): TvtPanel;
     {* ���������� ����� ������� .TefStartupTips.wwwPanel }
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
  end;//TkwEfStartupTipsWwwPanel

// start class TkwEfStartupTipsWwwPanel

function TkwEfStartupTipsWwwPanel.WwwPanel(const aCtx: TtfwContext;
  aefStartupTips: TefStartupTips): TvtPanel;
 {-}
begin
 Result := aefStartupTips.wwwPanel;
end;//TkwEfStartupTipsWwwPanel.WwwPanel

procedure TkwEfStartupTipsWwwPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefStartupTips : TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((WwwPanel(aCtx, l_aefStartupTips)));
end;//TkwEfStartupTipsWwwPanel.DoDoIt

class function TkwEfStartupTipsWwwPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefStartupTips.wwwPanel';
end;//TkwEfStartupTipsWwwPanel.GetWordNameForRegister

procedure TkwEfStartupTipsWwwPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� wwwPanel', aCtx);
end;//TkwEfStartupTipsWwwPanel.SetValuePrim

function TkwEfStartupTipsWwwPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfStartupTipsWwwPanel.GetResultTypeInfo

function TkwEfStartupTipsWwwPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfStartupTipsWwwPanel.GetAllParamsCount

function TkwEfStartupTipsWwwPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsWwwPanel.ParamsTypes

type
  TkwEfStartupTipsWwwPaintBox = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefStartupTips.wwwPaintBox
[panel]������� wwwPaintBox ����� TefStartupTips[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aefStartupTips .TefStartupTips.wwwPaintBox >>> l_TPaintBox
[code]  }
  private
  // private methods
   function WwwPaintBox(const aCtx: TtfwContext;
     aefStartupTips: TefStartupTips): TPaintBox;
     {* ���������� ����� ������� .TefStartupTips.wwwPaintBox }
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
  end;//TkwEfStartupTipsWwwPaintBox

// start class TkwEfStartupTipsWwwPaintBox

function TkwEfStartupTipsWwwPaintBox.WwwPaintBox(const aCtx: TtfwContext;
  aefStartupTips: TefStartupTips): TPaintBox;
 {-}
begin
 Result := aefStartupTips.wwwPaintBox;
end;//TkwEfStartupTipsWwwPaintBox.WwwPaintBox

procedure TkwEfStartupTipsWwwPaintBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefStartupTips : TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((WwwPaintBox(aCtx, l_aefStartupTips)));
end;//TkwEfStartupTipsWwwPaintBox.DoDoIt

class function TkwEfStartupTipsWwwPaintBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefStartupTips.wwwPaintBox';
end;//TkwEfStartupTipsWwwPaintBox.GetWordNameForRegister

procedure TkwEfStartupTipsWwwPaintBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� wwwPaintBox', aCtx);
end;//TkwEfStartupTipsWwwPaintBox.SetValuePrim

function TkwEfStartupTipsWwwPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEfStartupTipsWwwPaintBox.GetResultTypeInfo

function TkwEfStartupTipsWwwPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfStartupTipsWwwPaintBox.GetAllParamsCount

function TkwEfStartupTipsWwwPaintBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsWwwPaintBox.ParamsTypes

type
  TkwEfStartupTipsWwwLabel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefStartupTips.wwwLabel
[panel]������� wwwLabel ����� TefStartupTips[panel]
*��� ����������:* TvtFocusLabel
*������:*
[code]
OBJECT VAR l_TvtFocusLabel
 aefStartupTips .TefStartupTips.wwwLabel >>> l_TvtFocusLabel
[code]  }
  private
  // private methods
   function WwwLabel(const aCtx: TtfwContext;
     aefStartupTips: TefStartupTips): TvtFocusLabel;
     {* ���������� ����� ������� .TefStartupTips.wwwLabel }
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
  end;//TkwEfStartupTipsWwwLabel

// start class TkwEfStartupTipsWwwLabel

function TkwEfStartupTipsWwwLabel.WwwLabel(const aCtx: TtfwContext;
  aefStartupTips: TefStartupTips): TvtFocusLabel;
 {-}
begin
 Result := aefStartupTips.wwwLabel;
end;//TkwEfStartupTipsWwwLabel.WwwLabel

procedure TkwEfStartupTipsWwwLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefStartupTips : TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((WwwLabel(aCtx, l_aefStartupTips)));
end;//TkwEfStartupTipsWwwLabel.DoDoIt

class function TkwEfStartupTipsWwwLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefStartupTips.wwwLabel';
end;//TkwEfStartupTipsWwwLabel.GetWordNameForRegister

procedure TkwEfStartupTipsWwwLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� wwwLabel', aCtx);
end;//TkwEfStartupTipsWwwLabel.SetValuePrim

function TkwEfStartupTipsWwwLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwEfStartupTipsWwwLabel.GetResultTypeInfo

function TkwEfStartupTipsWwwLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfStartupTipsWwwLabel.GetAllParamsCount

function TkwEfStartupTipsWwwLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsWwwLabel.ParamsTypes

type
  TkwEfStartupTipsNextButton = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefStartupTips.NextButton
[panel]������� NextButton ����� TefStartupTips[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aefStartupTips .TefStartupTips.NextButton >>> l_TElPopupButton
[code]  }
  private
  // private methods
   function NextButton(const aCtx: TtfwContext;
     aefStartupTips: TefStartupTips): TElPopupButton;
     {* ���������� ����� ������� .TefStartupTips.NextButton }
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
  end;//TkwEfStartupTipsNextButton

// start class TkwEfStartupTipsNextButton

function TkwEfStartupTipsNextButton.NextButton(const aCtx: TtfwContext;
  aefStartupTips: TefStartupTips): TElPopupButton;
 {-}
begin
 Result := aefStartupTips.NextButton;
end;//TkwEfStartupTipsNextButton.NextButton

procedure TkwEfStartupTipsNextButton.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefStartupTips : TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((NextButton(aCtx, l_aefStartupTips)));
end;//TkwEfStartupTipsNextButton.DoDoIt

class function TkwEfStartupTipsNextButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefStartupTips.NextButton';
end;//TkwEfStartupTipsNextButton.GetWordNameForRegister

procedure TkwEfStartupTipsNextButton.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� NextButton', aCtx);
end;//TkwEfStartupTipsNextButton.SetValuePrim

function TkwEfStartupTipsNextButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwEfStartupTipsNextButton.GetResultTypeInfo

function TkwEfStartupTipsNextButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfStartupTipsNextButton.GetAllParamsCount

function TkwEfStartupTipsNextButton.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsNextButton.ParamsTypes

type
  TkwEfStartupTipsPrevButton = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefStartupTips.PrevButton
[panel]������� PrevButton ����� TefStartupTips[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aefStartupTips .TefStartupTips.PrevButton >>> l_TElPopupButton
[code]  }
  private
  // private methods
   function PrevButton(const aCtx: TtfwContext;
     aefStartupTips: TefStartupTips): TElPopupButton;
     {* ���������� ����� ������� .TefStartupTips.PrevButton }
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
  end;//TkwEfStartupTipsPrevButton

// start class TkwEfStartupTipsPrevButton

function TkwEfStartupTipsPrevButton.PrevButton(const aCtx: TtfwContext;
  aefStartupTips: TefStartupTips): TElPopupButton;
 {-}
begin
 Result := aefStartupTips.PrevButton;
end;//TkwEfStartupTipsPrevButton.PrevButton

procedure TkwEfStartupTipsPrevButton.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefStartupTips : TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PrevButton(aCtx, l_aefStartupTips)));
end;//TkwEfStartupTipsPrevButton.DoDoIt

class function TkwEfStartupTipsPrevButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefStartupTips.PrevButton';
end;//TkwEfStartupTipsPrevButton.GetWordNameForRegister

procedure TkwEfStartupTipsPrevButton.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� PrevButton', aCtx);
end;//TkwEfStartupTipsPrevButton.SetValuePrim

function TkwEfStartupTipsPrevButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwEfStartupTipsPrevButton.GetResultTypeInfo

function TkwEfStartupTipsPrevButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfStartupTipsPrevButton.GetAllParamsCount

function TkwEfStartupTipsPrevButton.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsPrevButton.ParamsTypes

type
  TkwEfStartupTipsCloseButton = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefStartupTips.CloseButton
[panel]������� CloseButton ����� TefStartupTips[panel]
*��� ����������:* TElPopupButton
*������:*
[code]
OBJECT VAR l_TElPopupButton
 aefStartupTips .TefStartupTips.CloseButton >>> l_TElPopupButton
[code]  }
  private
  // private methods
   function CloseButton(const aCtx: TtfwContext;
     aefStartupTips: TefStartupTips): TElPopupButton;
     {* ���������� ����� ������� .TefStartupTips.CloseButton }
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
  end;//TkwEfStartupTipsCloseButton

// start class TkwEfStartupTipsCloseButton

function TkwEfStartupTipsCloseButton.CloseButton(const aCtx: TtfwContext;
  aefStartupTips: TefStartupTips): TElPopupButton;
 {-}
begin
 Result := aefStartupTips.CloseButton;
end;//TkwEfStartupTipsCloseButton.CloseButton

procedure TkwEfStartupTipsCloseButton.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefStartupTips : TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((CloseButton(aCtx, l_aefStartupTips)));
end;//TkwEfStartupTipsCloseButton.DoDoIt

class function TkwEfStartupTipsCloseButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefStartupTips.CloseButton';
end;//TkwEfStartupTipsCloseButton.GetWordNameForRegister

procedure TkwEfStartupTipsCloseButton.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� CloseButton', aCtx);
end;//TkwEfStartupTipsCloseButton.SetValuePrim

function TkwEfStartupTipsCloseButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwEfStartupTipsCloseButton.GetResultTypeInfo

function TkwEfStartupTipsCloseButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfStartupTipsCloseButton.GetAllParamsCount

function TkwEfStartupTipsCloseButton.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsCloseButton.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_StartupTips
 Tkw_Form_StartupTips.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_TopPanel
 Tkw_StartupTips_Control_TopPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_TopPanel_Push
 Tkw_StartupTips_Control_TopPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_TitlePaintBox
 Tkw_StartupTips_Control_TitlePaintBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_TitlePaintBox_Push
 Tkw_StartupTips_Control_TitlePaintBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_TitleLabel
 Tkw_StartupTips_Control_TitleLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_TitleLabel_Push
 Tkw_StartupTips_Control_TitleLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_BottomPanel
 Tkw_StartupTips_Control_BottomPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_BottomPanel_Push
 Tkw_StartupTips_Control_BottomPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_HintPanel
 Tkw_StartupTips_Control_HintPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_HintPanel_Push
 Tkw_StartupTips_Control_HintPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_TipLabel
 Tkw_StartupTips_Control_TipLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_TipLabel_Push
 Tkw_StartupTips_Control_TipLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_DetailLabel
 Tkw_StartupTips_Control_DetailLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_DetailLabel_Push
 Tkw_StartupTips_Control_DetailLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_ShowCheckBox
 Tkw_StartupTips_Control_ShowCheckBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_ShowCheckBox_Push
 Tkw_StartupTips_Control_ShowCheckBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_wwwPanel
 Tkw_StartupTips_Control_wwwPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_wwwPanel_Push
 Tkw_StartupTips_Control_wwwPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_wwwPaintBox
 Tkw_StartupTips_Control_wwwPaintBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_wwwPaintBox_Push
 Tkw_StartupTips_Control_wwwPaintBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_wwwLabel
 Tkw_StartupTips_Control_wwwLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_wwwLabel_Push
 Tkw_StartupTips_Control_wwwLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_NextButton
 Tkw_StartupTips_Control_NextButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_NextButton_Push
 Tkw_StartupTips_Control_NextButton_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_PrevButton
 Tkw_StartupTips_Control_PrevButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_PrevButton_Push
 Tkw_StartupTips_Control_PrevButton_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_CloseButton
 Tkw_StartupTips_Control_CloseButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_StartupTips_Control_CloseButton_Push
 Tkw_StartupTips_Control_CloseButton_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efStartupTips_TopPanel
 TkwEfStartupTipsTopPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efStartupTips_TitlePaintBox
 TkwEfStartupTipsTitlePaintBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efStartupTips_TitleLabel
 TkwEfStartupTipsTitleLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efStartupTips_BottomPanel
 TkwEfStartupTipsBottomPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efStartupTips_HintPanel
 TkwEfStartupTipsHintPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efStartupTips_TipLabel
 TkwEfStartupTipsTipLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efStartupTips_DetailLabel
 TkwEfStartupTipsDetailLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efStartupTips_ShowCheckBox
 TkwEfStartupTipsShowCheckBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efStartupTips_wwwPanel
 TkwEfStartupTipsWwwPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efStartupTips_wwwPaintBox
 TkwEfStartupTipsWwwPaintBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efStartupTips_wwwLabel
 TkwEfStartupTipsWwwLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efStartupTips_NextButton
 TkwEfStartupTipsNextButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efStartupTips_PrevButton
 TkwEfStartupTipsPrevButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efStartupTips_CloseButton
 TkwEfStartupTipsCloseButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� StartupTips
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefStartupTips));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TPaintBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtFocusLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtFocusLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtCheckBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCheckBox));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TElPopupButton
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElPopupButton));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.