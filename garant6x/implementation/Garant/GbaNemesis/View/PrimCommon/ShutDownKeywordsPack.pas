unit ShutDownKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/ShutDownKeywordsPack.pas"
// Начат: 21.08.2009 20:15
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Базовые определения предметной области::F1 Application Template::View::PrimCommon::PrimCommon::ShutDownKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы ShutDown
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

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
  ShutDown_Form,
  vtLabel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  vtButton,
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
  Tkw_Form_ShutDown = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы ShutDown
----
*Пример использования*:
[code]
'aControl' форма::ShutDown TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_ShutDown

// start class Tkw_Form_ShutDown

class function Tkw_Form_ShutDown.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::ShutDown';
end;//Tkw_Form_ShutDown.GetWordNameForRegister

function Tkw_Form_ShutDown.GetString: AnsiString;
 {-}
begin
 Result := 'ShutDownForm';
end;//Tkw_Form_ShutDown.GetString

type
  Tkw_ShutDown_Component_ShutdownTimer = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола ShutdownTimer
----
*Пример использования*:
[code]
компонент::ShutdownTimer TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ShutDown_Component_ShutdownTimer

// start class Tkw_ShutDown_Component_ShutdownTimer

class function Tkw_ShutDown_Component_ShutdownTimer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'компонент::ShutdownTimer';
end;//Tkw_ShutDown_Component_ShutdownTimer.GetWordNameForRegister

function Tkw_ShutDown_Component_ShutdownTimer.GetString: AnsiString;
 {-}
begin
 Result := 'ShutdownTimer';
end;//Tkw_ShutDown_Component_ShutdownTimer.GetString

class procedure Tkw_ShutDown_Component_ShutdownTimer.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TTimer);
end;//Tkw_ShutDown_Component_ShutdownTimer.RegisterInEngine

type
  Tkw_ShutDown_Control_vtPanel1 = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола vtPanel1
----
*Пример использования*:
[code]
контрол::vtPanel1 TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ShutDown_Control_vtPanel1

// start class Tkw_ShutDown_Control_vtPanel1

class function Tkw_ShutDown_Control_vtPanel1.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::vtPanel1';
end;//Tkw_ShutDown_Control_vtPanel1.GetWordNameForRegister

function Tkw_ShutDown_Control_vtPanel1.GetString: AnsiString;
 {-}
begin
 Result := 'vtPanel1';
end;//Tkw_ShutDown_Control_vtPanel1.GetString

class procedure Tkw_ShutDown_Control_vtPanel1.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ShutDown_Control_vtPanel1.RegisterInEngine

type
  Tkw_ShutDown_Control_vtPanel1_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола vtPanel1
----
*Пример использования*:
[code]
контрол::vtPanel1:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ShutDown_Control_vtPanel1_Push

// start class Tkw_ShutDown_Control_vtPanel1_Push

procedure Tkw_ShutDown_Control_vtPanel1_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('vtPanel1');
 inherited;
end;//Tkw_ShutDown_Control_vtPanel1_Push.DoDoIt

class function Tkw_ShutDown_Control_vtPanel1_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::vtPanel1:push';
end;//Tkw_ShutDown_Control_vtPanel1_Push.GetWordNameForRegister

type
  Tkw_ShutDown_Control_LeftPanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола LeftPanel
----
*Пример использования*:
[code]
контрол::LeftPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ShutDown_Control_LeftPanel

// start class Tkw_ShutDown_Control_LeftPanel

class function Tkw_ShutDown_Control_LeftPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LeftPanel';
end;//Tkw_ShutDown_Control_LeftPanel.GetWordNameForRegister

function Tkw_ShutDown_Control_LeftPanel.GetString: AnsiString;
 {-}
begin
 Result := 'LeftPanel';
end;//Tkw_ShutDown_Control_LeftPanel.GetString

class procedure Tkw_ShutDown_Control_LeftPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ShutDown_Control_LeftPanel.RegisterInEngine

type
  Tkw_ShutDown_Control_LeftPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола LeftPanel
----
*Пример использования*:
[code]
контрол::LeftPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ShutDown_Control_LeftPanel_Push

// start class Tkw_ShutDown_Control_LeftPanel_Push

procedure Tkw_ShutDown_Control_LeftPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('LeftPanel');
 inherited;
end;//Tkw_ShutDown_Control_LeftPanel_Push.DoDoIt

class function Tkw_ShutDown_Control_LeftPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LeftPanel:push';
end;//Tkw_ShutDown_Control_LeftPanel_Push.GetWordNameForRegister

type
  Tkw_ShutDown_Control_Image = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола Image
----
*Пример использования*:
[code]
контрол::Image TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ShutDown_Control_Image

// start class Tkw_ShutDown_Control_Image

class function Tkw_ShutDown_Control_Image.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::Image';
end;//Tkw_ShutDown_Control_Image.GetWordNameForRegister

function Tkw_ShutDown_Control_Image.GetString: AnsiString;
 {-}
begin
 Result := 'Image';
end;//Tkw_ShutDown_Control_Image.GetString

class procedure Tkw_ShutDown_Control_Image.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TImage);
end;//Tkw_ShutDown_Control_Image.RegisterInEngine

type
  Tkw_ShutDown_Control_Image_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола Image
----
*Пример использования*:
[code]
контрол::Image:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ShutDown_Control_Image_Push

// start class Tkw_ShutDown_Control_Image_Push

procedure Tkw_ShutDown_Control_Image_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('Image');
 inherited;
end;//Tkw_ShutDown_Control_Image_Push.DoDoIt

class function Tkw_ShutDown_Control_Image_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::Image:push';
end;//Tkw_ShutDown_Control_Image_Push.GetWordNameForRegister

type
  Tkw_ShutDown_Control_CenterPanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола CenterPanel
----
*Пример использования*:
[code]
контрол::CenterPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ShutDown_Control_CenterPanel

// start class Tkw_ShutDown_Control_CenterPanel

class function Tkw_ShutDown_Control_CenterPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::CenterPanel';
end;//Tkw_ShutDown_Control_CenterPanel.GetWordNameForRegister

function Tkw_ShutDown_Control_CenterPanel.GetString: AnsiString;
 {-}
begin
 Result := 'CenterPanel';
end;//Tkw_ShutDown_Control_CenterPanel.GetString

class procedure Tkw_ShutDown_Control_CenterPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ShutDown_Control_CenterPanel.RegisterInEngine

type
  Tkw_ShutDown_Control_CenterPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола CenterPanel
----
*Пример использования*:
[code]
контрол::CenterPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ShutDown_Control_CenterPanel_Push

// start class Tkw_ShutDown_Control_CenterPanel_Push

procedure Tkw_ShutDown_Control_CenterPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('CenterPanel');
 inherited;
end;//Tkw_ShutDown_Control_CenterPanel_Push.DoDoIt

class function Tkw_ShutDown_Control_CenterPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::CenterPanel:push';
end;//Tkw_ShutDown_Control_CenterPanel_Push.GetWordNameForRegister

type
  Tkw_ShutDown_Control_TopSpacerPanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола TopSpacerPanel
----
*Пример использования*:
[code]
контрол::TopSpacerPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ShutDown_Control_TopSpacerPanel

// start class Tkw_ShutDown_Control_TopSpacerPanel

class function Tkw_ShutDown_Control_TopSpacerPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::TopSpacerPanel';
end;//Tkw_ShutDown_Control_TopSpacerPanel.GetWordNameForRegister

function Tkw_ShutDown_Control_TopSpacerPanel.GetString: AnsiString;
 {-}
begin
 Result := 'TopSpacerPanel';
end;//Tkw_ShutDown_Control_TopSpacerPanel.GetString

class procedure Tkw_ShutDown_Control_TopSpacerPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ShutDown_Control_TopSpacerPanel.RegisterInEngine

type
  Tkw_ShutDown_Control_TopSpacerPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола TopSpacerPanel
----
*Пример использования*:
[code]
контрол::TopSpacerPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ShutDown_Control_TopSpacerPanel_Push

// start class Tkw_ShutDown_Control_TopSpacerPanel_Push

procedure Tkw_ShutDown_Control_TopSpacerPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('TopSpacerPanel');
 inherited;
end;//Tkw_ShutDown_Control_TopSpacerPanel_Push.DoDoIt

class function Tkw_ShutDown_Control_TopSpacerPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::TopSpacerPanel:push';
end;//Tkw_ShutDown_Control_TopSpacerPanel_Push.GetWordNameForRegister

type
  Tkw_ShutDown_Control_WarningText = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола WarningText
----
*Пример использования*:
[code]
контрол::WarningText TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ShutDown_Control_WarningText

// start class Tkw_ShutDown_Control_WarningText

class function Tkw_ShutDown_Control_WarningText.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WarningText';
end;//Tkw_ShutDown_Control_WarningText.GetWordNameForRegister

function Tkw_ShutDown_Control_WarningText.GetString: AnsiString;
 {-}
begin
 Result := 'WarningText';
end;//Tkw_ShutDown_Control_WarningText.GetString

class procedure Tkw_ShutDown_Control_WarningText.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_ShutDown_Control_WarningText.RegisterInEngine

type
  Tkw_ShutDown_Control_WarningText_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола WarningText
----
*Пример использования*:
[code]
контрол::WarningText:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ShutDown_Control_WarningText_Push

// start class Tkw_ShutDown_Control_WarningText_Push

procedure Tkw_ShutDown_Control_WarningText_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('WarningText');
 inherited;
end;//Tkw_ShutDown_Control_WarningText_Push.DoDoIt

class function Tkw_ShutDown_Control_WarningText_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::WarningText:push';
end;//Tkw_ShutDown_Control_WarningText_Push.GetWordNameForRegister

type
  Tkw_ShutDown_Control_RightSpacerPanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола RightSpacerPanel
----
*Пример использования*:
[code]
контрол::RightSpacerPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ShutDown_Control_RightSpacerPanel

// start class Tkw_ShutDown_Control_RightSpacerPanel

class function Tkw_ShutDown_Control_RightSpacerPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RightSpacerPanel';
end;//Tkw_ShutDown_Control_RightSpacerPanel.GetWordNameForRegister

function Tkw_ShutDown_Control_RightSpacerPanel.GetString: AnsiString;
 {-}
begin
 Result := 'RightSpacerPanel';
end;//Tkw_ShutDown_Control_RightSpacerPanel.GetString

class procedure Tkw_ShutDown_Control_RightSpacerPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ShutDown_Control_RightSpacerPanel.RegisterInEngine

type
  Tkw_ShutDown_Control_RightSpacerPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола RightSpacerPanel
----
*Пример использования*:
[code]
контрол::RightSpacerPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ShutDown_Control_RightSpacerPanel_Push

// start class Tkw_ShutDown_Control_RightSpacerPanel_Push

procedure Tkw_ShutDown_Control_RightSpacerPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('RightSpacerPanel');
 inherited;
end;//Tkw_ShutDown_Control_RightSpacerPanel_Push.DoDoIt

class function Tkw_ShutDown_Control_RightSpacerPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RightSpacerPanel:push';
end;//Tkw_ShutDown_Control_RightSpacerPanel_Push.GetWordNameForRegister

type
  Tkw_ShutDown_Control_pnlBottom = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnlBottom
----
*Пример использования*:
[code]
контрол::pnlBottom TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ShutDown_Control_pnlBottom

// start class Tkw_ShutDown_Control_pnlBottom

class function Tkw_ShutDown_Control_pnlBottom.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnlBottom';
end;//Tkw_ShutDown_Control_pnlBottom.GetWordNameForRegister

function Tkw_ShutDown_Control_pnlBottom.GetString: AnsiString;
 {-}
begin
 Result := 'pnlBottom';
end;//Tkw_ShutDown_Control_pnlBottom.GetString

class procedure Tkw_ShutDown_Control_pnlBottom.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ShutDown_Control_pnlBottom.RegisterInEngine

type
  Tkw_ShutDown_Control_pnlBottom_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnlBottom
----
*Пример использования*:
[code]
контрол::pnlBottom:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ShutDown_Control_pnlBottom_Push

// start class Tkw_ShutDown_Control_pnlBottom_Push

procedure Tkw_ShutDown_Control_pnlBottom_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlBottom');
 inherited;
end;//Tkw_ShutDown_Control_pnlBottom_Push.DoDoIt

class function Tkw_ShutDown_Control_pnlBottom_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnlBottom:push';
end;//Tkw_ShutDown_Control_pnlBottom_Push.GetWordNameForRegister

type
  Tkw_ShutDown_Control_CloseButton = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола CloseButton
----
*Пример использования*:
[code]
контрол::CloseButton TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ShutDown_Control_CloseButton

// start class Tkw_ShutDown_Control_CloseButton

class function Tkw_ShutDown_Control_CloseButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::CloseButton';
end;//Tkw_ShutDown_Control_CloseButton.GetWordNameForRegister

function Tkw_ShutDown_Control_CloseButton.GetString: AnsiString;
 {-}
begin
 Result := 'CloseButton';
end;//Tkw_ShutDown_Control_CloseButton.GetString

class procedure Tkw_ShutDown_Control_CloseButton.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_ShutDown_Control_CloseButton.RegisterInEngine

type
  Tkw_ShutDown_Control_CloseButton_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола CloseButton
----
*Пример использования*:
[code]
контрол::CloseButton:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ShutDown_Control_CloseButton_Push

// start class Tkw_ShutDown_Control_CloseButton_Push

procedure Tkw_ShutDown_Control_CloseButton_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('CloseButton');
 inherited;
end;//Tkw_ShutDown_Control_CloseButton_Push.DoDoIt

class function Tkw_ShutDown_Control_CloseButton_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::CloseButton:push';
end;//Tkw_ShutDown_Control_CloseButton_Push.GetWordNameForRegister

type
  TkwShutDownFormShutdownTimer = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TShutDownForm.ShutdownTimer
[panel]Контрол ShutdownTimer формы TShutDownForm[panel]
*Тип результата:* TTimer
*Пример:*
[code]
OBJECT VAR l_TTimer
 aShutDownForm .TShutDownForm.ShutdownTimer >>> l_TTimer
[code]  }
  private
  // private methods
   function ShutdownTimer(const aCtx: TtfwContext;
     aShutDownForm: TShutDownForm): TTimer;
     {* Реализация слова скрипта .TShutDownForm.ShutdownTimer }
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
  end;//TkwShutDownFormShutdownTimer

// start class TkwShutDownFormShutdownTimer

function TkwShutDownFormShutdownTimer.ShutdownTimer(const aCtx: TtfwContext;
  aShutDownForm: TShutDownForm): TTimer;
 {-}
begin
 Result := aShutDownForm.ShutdownTimer;
end;//TkwShutDownFormShutdownTimer.ShutdownTimer

procedure TkwShutDownFormShutdownTimer.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aShutDownForm : TShutDownForm;
begin
 try
  l_aShutDownForm := TShutDownForm(aCtx.rEngine.PopObjAs(TShutDownForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ShutdownTimer(aCtx, l_aShutDownForm)));
end;//TkwShutDownFormShutdownTimer.DoDoIt

class function TkwShutDownFormShutdownTimer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TShutDownForm.ShutdownTimer';
end;//TkwShutDownFormShutdownTimer.GetWordNameForRegister

procedure TkwShutDownFormShutdownTimer.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ShutdownTimer', aCtx);
end;//TkwShutDownFormShutdownTimer.SetValuePrim

function TkwShutDownFormShutdownTimer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TTimer);
end;//TkwShutDownFormShutdownTimer.GetResultTypeInfo

function TkwShutDownFormShutdownTimer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwShutDownFormShutdownTimer.GetAllParamsCount

function TkwShutDownFormShutdownTimer.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TShutDownForm)]);
end;//TkwShutDownFormShutdownTimer.ParamsTypes

type
  TkwShutDownFormVtPanel1 = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TShutDownForm.vtPanel1
[panel]Контрол vtPanel1 формы TShutDownForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aShutDownForm .TShutDownForm.vtPanel1 >>> l_TvtPanel
[code]  }
  private
  // private methods
   function VtPanel1(const aCtx: TtfwContext;
     aShutDownForm: TShutDownForm): TvtPanel;
     {* Реализация слова скрипта .TShutDownForm.vtPanel1 }
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
  end;//TkwShutDownFormVtPanel1

// start class TkwShutDownFormVtPanel1

function TkwShutDownFormVtPanel1.VtPanel1(const aCtx: TtfwContext;
  aShutDownForm: TShutDownForm): TvtPanel;
 {-}
begin
 Result := aShutDownForm.vtPanel1;
end;//TkwShutDownFormVtPanel1.VtPanel1

procedure TkwShutDownFormVtPanel1.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aShutDownForm : TShutDownForm;
begin
 try
  l_aShutDownForm := TShutDownForm(aCtx.rEngine.PopObjAs(TShutDownForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((VtPanel1(aCtx, l_aShutDownForm)));
end;//TkwShutDownFormVtPanel1.DoDoIt

class function TkwShutDownFormVtPanel1.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TShutDownForm.vtPanel1';
end;//TkwShutDownFormVtPanel1.GetWordNameForRegister

procedure TkwShutDownFormVtPanel1.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству vtPanel1', aCtx);
end;//TkwShutDownFormVtPanel1.SetValuePrim

function TkwShutDownFormVtPanel1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwShutDownFormVtPanel1.GetResultTypeInfo

function TkwShutDownFormVtPanel1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwShutDownFormVtPanel1.GetAllParamsCount

function TkwShutDownFormVtPanel1.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TShutDownForm)]);
end;//TkwShutDownFormVtPanel1.ParamsTypes

type
  TkwShutDownFormLeftPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TShutDownForm.LeftPanel
[panel]Контрол LeftPanel формы TShutDownForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aShutDownForm .TShutDownForm.LeftPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function LeftPanel(const aCtx: TtfwContext;
     aShutDownForm: TShutDownForm): TvtPanel;
     {* Реализация слова скрипта .TShutDownForm.LeftPanel }
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
  end;//TkwShutDownFormLeftPanel

// start class TkwShutDownFormLeftPanel

function TkwShutDownFormLeftPanel.LeftPanel(const aCtx: TtfwContext;
  aShutDownForm: TShutDownForm): TvtPanel;
 {-}
begin
 Result := aShutDownForm.LeftPanel;
end;//TkwShutDownFormLeftPanel.LeftPanel

procedure TkwShutDownFormLeftPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aShutDownForm : TShutDownForm;
begin
 try
  l_aShutDownForm := TShutDownForm(aCtx.rEngine.PopObjAs(TShutDownForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LeftPanel(aCtx, l_aShutDownForm)));
end;//TkwShutDownFormLeftPanel.DoDoIt

class function TkwShutDownFormLeftPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TShutDownForm.LeftPanel';
end;//TkwShutDownFormLeftPanel.GetWordNameForRegister

procedure TkwShutDownFormLeftPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству LeftPanel', aCtx);
end;//TkwShutDownFormLeftPanel.SetValuePrim

function TkwShutDownFormLeftPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwShutDownFormLeftPanel.GetResultTypeInfo

function TkwShutDownFormLeftPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwShutDownFormLeftPanel.GetAllParamsCount

function TkwShutDownFormLeftPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TShutDownForm)]);
end;//TkwShutDownFormLeftPanel.ParamsTypes

type
  TkwShutDownFormImage = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TShutDownForm.Image
[panel]Контрол Image формы TShutDownForm[panel]
*Тип результата:* TImage
*Пример:*
[code]
OBJECT VAR l_TImage
 aShutDownForm .TShutDownForm.Image >>> l_TImage
[code]  }
  private
  // private methods
   function Image(const aCtx: TtfwContext;
     aShutDownForm: TShutDownForm): TImage;
     {* Реализация слова скрипта .TShutDownForm.Image }
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
  end;//TkwShutDownFormImage

// start class TkwShutDownFormImage

function TkwShutDownFormImage.Image(const aCtx: TtfwContext;
  aShutDownForm: TShutDownForm): TImage;
 {-}
begin
 Result := aShutDownForm.Image;
end;//TkwShutDownFormImage.Image

procedure TkwShutDownFormImage.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aShutDownForm : TShutDownForm;
begin
 try
  l_aShutDownForm := TShutDownForm(aCtx.rEngine.PopObjAs(TShutDownForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Image(aCtx, l_aShutDownForm)));
end;//TkwShutDownFormImage.DoDoIt

class function TkwShutDownFormImage.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TShutDownForm.Image';
end;//TkwShutDownFormImage.GetWordNameForRegister

procedure TkwShutDownFormImage.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Image', aCtx);
end;//TkwShutDownFormImage.SetValuePrim

function TkwShutDownFormImage.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TImage);
end;//TkwShutDownFormImage.GetResultTypeInfo

function TkwShutDownFormImage.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwShutDownFormImage.GetAllParamsCount

function TkwShutDownFormImage.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TShutDownForm)]);
end;//TkwShutDownFormImage.ParamsTypes

type
  TkwShutDownFormCenterPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TShutDownForm.CenterPanel
[panel]Контрол CenterPanel формы TShutDownForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aShutDownForm .TShutDownForm.CenterPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function CenterPanel(const aCtx: TtfwContext;
     aShutDownForm: TShutDownForm): TvtPanel;
     {* Реализация слова скрипта .TShutDownForm.CenterPanel }
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
  end;//TkwShutDownFormCenterPanel

// start class TkwShutDownFormCenterPanel

function TkwShutDownFormCenterPanel.CenterPanel(const aCtx: TtfwContext;
  aShutDownForm: TShutDownForm): TvtPanel;
 {-}
begin
 Result := aShutDownForm.CenterPanel;
end;//TkwShutDownFormCenterPanel.CenterPanel

procedure TkwShutDownFormCenterPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aShutDownForm : TShutDownForm;
begin
 try
  l_aShutDownForm := TShutDownForm(aCtx.rEngine.PopObjAs(TShutDownForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((CenterPanel(aCtx, l_aShutDownForm)));
end;//TkwShutDownFormCenterPanel.DoDoIt

class function TkwShutDownFormCenterPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TShutDownForm.CenterPanel';
end;//TkwShutDownFormCenterPanel.GetWordNameForRegister

procedure TkwShutDownFormCenterPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству CenterPanel', aCtx);
end;//TkwShutDownFormCenterPanel.SetValuePrim

function TkwShutDownFormCenterPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwShutDownFormCenterPanel.GetResultTypeInfo

function TkwShutDownFormCenterPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwShutDownFormCenterPanel.GetAllParamsCount

function TkwShutDownFormCenterPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TShutDownForm)]);
end;//TkwShutDownFormCenterPanel.ParamsTypes

type
  TkwShutDownFormTopSpacerPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TShutDownForm.TopSpacerPanel
[panel]Контрол TopSpacerPanel формы TShutDownForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aShutDownForm .TShutDownForm.TopSpacerPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function TopSpacerPanel(const aCtx: TtfwContext;
     aShutDownForm: TShutDownForm): TvtPanel;
     {* Реализация слова скрипта .TShutDownForm.TopSpacerPanel }
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
  end;//TkwShutDownFormTopSpacerPanel

// start class TkwShutDownFormTopSpacerPanel

function TkwShutDownFormTopSpacerPanel.TopSpacerPanel(const aCtx: TtfwContext;
  aShutDownForm: TShutDownForm): TvtPanel;
 {-}
begin
 Result := aShutDownForm.TopSpacerPanel;
end;//TkwShutDownFormTopSpacerPanel.TopSpacerPanel

procedure TkwShutDownFormTopSpacerPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aShutDownForm : TShutDownForm;
begin
 try
  l_aShutDownForm := TShutDownForm(aCtx.rEngine.PopObjAs(TShutDownForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TopSpacerPanel(aCtx, l_aShutDownForm)));
end;//TkwShutDownFormTopSpacerPanel.DoDoIt

class function TkwShutDownFormTopSpacerPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TShutDownForm.TopSpacerPanel';
end;//TkwShutDownFormTopSpacerPanel.GetWordNameForRegister

procedure TkwShutDownFormTopSpacerPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству TopSpacerPanel', aCtx);
end;//TkwShutDownFormTopSpacerPanel.SetValuePrim

function TkwShutDownFormTopSpacerPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwShutDownFormTopSpacerPanel.GetResultTypeInfo

function TkwShutDownFormTopSpacerPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwShutDownFormTopSpacerPanel.GetAllParamsCount

function TkwShutDownFormTopSpacerPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TShutDownForm)]);
end;//TkwShutDownFormTopSpacerPanel.ParamsTypes

type
  TkwShutDownFormWarningText = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TShutDownForm.WarningText
[panel]Контрол WarningText формы TShutDownForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aShutDownForm .TShutDownForm.WarningText >>> l_TvtLabel
[code]  }
  private
  // private methods
   function WarningText(const aCtx: TtfwContext;
     aShutDownForm: TShutDownForm): TvtLabel;
     {* Реализация слова скрипта .TShutDownForm.WarningText }
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
  end;//TkwShutDownFormWarningText

// start class TkwShutDownFormWarningText

function TkwShutDownFormWarningText.WarningText(const aCtx: TtfwContext;
  aShutDownForm: TShutDownForm): TvtLabel;
 {-}
begin
 Result := aShutDownForm.WarningText;
end;//TkwShutDownFormWarningText.WarningText

procedure TkwShutDownFormWarningText.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aShutDownForm : TShutDownForm;
begin
 try
  l_aShutDownForm := TShutDownForm(aCtx.rEngine.PopObjAs(TShutDownForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((WarningText(aCtx, l_aShutDownForm)));
end;//TkwShutDownFormWarningText.DoDoIt

class function TkwShutDownFormWarningText.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TShutDownForm.WarningText';
end;//TkwShutDownFormWarningText.GetWordNameForRegister

procedure TkwShutDownFormWarningText.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству WarningText', aCtx);
end;//TkwShutDownFormWarningText.SetValuePrim

function TkwShutDownFormWarningText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwShutDownFormWarningText.GetResultTypeInfo

function TkwShutDownFormWarningText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwShutDownFormWarningText.GetAllParamsCount

function TkwShutDownFormWarningText.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TShutDownForm)]);
end;//TkwShutDownFormWarningText.ParamsTypes

type
  TkwShutDownFormRightSpacerPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TShutDownForm.RightSpacerPanel
[panel]Контрол RightSpacerPanel формы TShutDownForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aShutDownForm .TShutDownForm.RightSpacerPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function RightSpacerPanel(const aCtx: TtfwContext;
     aShutDownForm: TShutDownForm): TvtPanel;
     {* Реализация слова скрипта .TShutDownForm.RightSpacerPanel }
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
  end;//TkwShutDownFormRightSpacerPanel

// start class TkwShutDownFormRightSpacerPanel

function TkwShutDownFormRightSpacerPanel.RightSpacerPanel(const aCtx: TtfwContext;
  aShutDownForm: TShutDownForm): TvtPanel;
 {-}
begin
 Result := aShutDownForm.RightSpacerPanel;
end;//TkwShutDownFormRightSpacerPanel.RightSpacerPanel

procedure TkwShutDownFormRightSpacerPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aShutDownForm : TShutDownForm;
begin
 try
  l_aShutDownForm := TShutDownForm(aCtx.rEngine.PopObjAs(TShutDownForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RightSpacerPanel(aCtx, l_aShutDownForm)));
end;//TkwShutDownFormRightSpacerPanel.DoDoIt

class function TkwShutDownFormRightSpacerPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TShutDownForm.RightSpacerPanel';
end;//TkwShutDownFormRightSpacerPanel.GetWordNameForRegister

procedure TkwShutDownFormRightSpacerPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству RightSpacerPanel', aCtx);
end;//TkwShutDownFormRightSpacerPanel.SetValuePrim

function TkwShutDownFormRightSpacerPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwShutDownFormRightSpacerPanel.GetResultTypeInfo

function TkwShutDownFormRightSpacerPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwShutDownFormRightSpacerPanel.GetAllParamsCount

function TkwShutDownFormRightSpacerPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TShutDownForm)]);
end;//TkwShutDownFormRightSpacerPanel.ParamsTypes

type
  TkwShutDownFormPnlBottom = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TShutDownForm.pnlBottom
[panel]Контрол pnlBottom формы TShutDownForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aShutDownForm .TShutDownForm.pnlBottom >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlBottom(const aCtx: TtfwContext;
     aShutDownForm: TShutDownForm): TvtPanel;
     {* Реализация слова скрипта .TShutDownForm.pnlBottom }
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
  end;//TkwShutDownFormPnlBottom

// start class TkwShutDownFormPnlBottom

function TkwShutDownFormPnlBottom.PnlBottom(const aCtx: TtfwContext;
  aShutDownForm: TShutDownForm): TvtPanel;
 {-}
begin
 Result := aShutDownForm.pnlBottom;
end;//TkwShutDownFormPnlBottom.PnlBottom

procedure TkwShutDownFormPnlBottom.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aShutDownForm : TShutDownForm;
begin
 try
  l_aShutDownForm := TShutDownForm(aCtx.rEngine.PopObjAs(TShutDownForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlBottom(aCtx, l_aShutDownForm)));
end;//TkwShutDownFormPnlBottom.DoDoIt

class function TkwShutDownFormPnlBottom.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TShutDownForm.pnlBottom';
end;//TkwShutDownFormPnlBottom.GetWordNameForRegister

procedure TkwShutDownFormPnlBottom.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlBottom', aCtx);
end;//TkwShutDownFormPnlBottom.SetValuePrim

function TkwShutDownFormPnlBottom.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwShutDownFormPnlBottom.GetResultTypeInfo

function TkwShutDownFormPnlBottom.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwShutDownFormPnlBottom.GetAllParamsCount

function TkwShutDownFormPnlBottom.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TShutDownForm)]);
end;//TkwShutDownFormPnlBottom.ParamsTypes

type
  TkwShutDownFormCloseButton = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TShutDownForm.CloseButton
[panel]Контрол CloseButton формы TShutDownForm[panel]
*Тип результата:* TvtButton
*Пример:*
[code]
OBJECT VAR l_TvtButton
 aShutDownForm .TShutDownForm.CloseButton >>> l_TvtButton
[code]  }
  private
  // private methods
   function CloseButton(const aCtx: TtfwContext;
     aShutDownForm: TShutDownForm): TvtButton;
     {* Реализация слова скрипта .TShutDownForm.CloseButton }
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
  end;//TkwShutDownFormCloseButton

// start class TkwShutDownFormCloseButton

function TkwShutDownFormCloseButton.CloseButton(const aCtx: TtfwContext;
  aShutDownForm: TShutDownForm): TvtButton;
 {-}
begin
 Result := aShutDownForm.CloseButton;
end;//TkwShutDownFormCloseButton.CloseButton

procedure TkwShutDownFormCloseButton.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aShutDownForm : TShutDownForm;
begin
 try
  l_aShutDownForm := TShutDownForm(aCtx.rEngine.PopObjAs(TShutDownForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((CloseButton(aCtx, l_aShutDownForm)));
end;//TkwShutDownFormCloseButton.DoDoIt

class function TkwShutDownFormCloseButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TShutDownForm.CloseButton';
end;//TkwShutDownFormCloseButton.GetWordNameForRegister

procedure TkwShutDownFormCloseButton.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству CloseButton', aCtx);
end;//TkwShutDownFormCloseButton.SetValuePrim

function TkwShutDownFormCloseButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtButton);
end;//TkwShutDownFormCloseButton.GetResultTypeInfo

function TkwShutDownFormCloseButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwShutDownFormCloseButton.GetAllParamsCount

function TkwShutDownFormCloseButton.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TShutDownForm)]);
end;//TkwShutDownFormCloseButton.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация Tkw_Form_ShutDown
 Tkw_Form_ShutDown.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_ShutDown_Component_ShutdownTimer
 Tkw_ShutDown_Component_ShutdownTimer.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_ShutDown_Control_vtPanel1
 Tkw_ShutDown_Control_vtPanel1.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_ShutDown_Control_vtPanel1_Push
 Tkw_ShutDown_Control_vtPanel1_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_ShutDown_Control_LeftPanel
 Tkw_ShutDown_Control_LeftPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_ShutDown_Control_LeftPanel_Push
 Tkw_ShutDown_Control_LeftPanel_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_ShutDown_Control_Image
 Tkw_ShutDown_Control_Image.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_ShutDown_Control_Image_Push
 Tkw_ShutDown_Control_Image_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_ShutDown_Control_CenterPanel
 Tkw_ShutDown_Control_CenterPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_ShutDown_Control_CenterPanel_Push
 Tkw_ShutDown_Control_CenterPanel_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_ShutDown_Control_TopSpacerPanel
 Tkw_ShutDown_Control_TopSpacerPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_ShutDown_Control_TopSpacerPanel_Push
 Tkw_ShutDown_Control_TopSpacerPanel_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_ShutDown_Control_WarningText
 Tkw_ShutDown_Control_WarningText.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_ShutDown_Control_WarningText_Push
 Tkw_ShutDown_Control_WarningText_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_ShutDown_Control_RightSpacerPanel
 Tkw_ShutDown_Control_RightSpacerPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_ShutDown_Control_RightSpacerPanel_Push
 Tkw_ShutDown_Control_RightSpacerPanel_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_ShutDown_Control_pnlBottom
 Tkw_ShutDown_Control_pnlBottom.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_ShutDown_Control_pnlBottom_Push
 Tkw_ShutDown_Control_pnlBottom_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_ShutDown_Control_CloseButton
 Tkw_ShutDown_Control_CloseButton.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Tkw_ShutDown_Control_CloseButton_Push
 Tkw_ShutDown_Control_CloseButton_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация ShutDownForm_ShutdownTimer
 TkwShutDownFormShutdownTimer.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация ShutDownForm_vtPanel1
 TkwShutDownFormVtPanel1.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация ShutDownForm_LeftPanel
 TkwShutDownFormLeftPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация ShutDownForm_Image
 TkwShutDownFormImage.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация ShutDownForm_CenterPanel
 TkwShutDownFormCenterPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация ShutDownForm_TopSpacerPanel
 TkwShutDownFormTopSpacerPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация ShutDownForm_WarningText
 TkwShutDownFormWarningText.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация ShutDownForm_RightSpacerPanel
 TkwShutDownFormRightSpacerPanel.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация ShutDownForm_pnlBottom
 TkwShutDownFormPnlBottom.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация ShutDownForm_CloseButton
 TkwShutDownFormCloseButton.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа ShutDown
 TtfwTypeRegistrator.RegisterType(TypeInfo(TShutDownForm));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TTimer
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTimer));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TImage
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImage));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TvtButton
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtButton));
{$IfEnd} //not NoScripts

end.