unit PrintDialogKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/PrintDialogKeywordsPack.pas"
// Начат: 10.09.2009 21:03
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::CommonSearch::PrintDialogKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы PrintDialog
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(NoScripts)}
uses
  vtComboBoxQS,
  PrintDialog_Form
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtSpinEdit,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  vtCheckBox,
  vtRadioButton,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_PrintDialog = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы PrintDialog
----
*Пример использования*:
[code]
'aControl' форма::PrintDialog TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Form_PrintDialog

// start class Tkw_Form_PrintDialog

class function Tkw_Form_PrintDialog.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::PrintDialog';
end;//Tkw_Form_PrintDialog.GetWordNameForRegister

function Tkw_Form_PrintDialog.GetString: AnsiString;
 {-}
begin
 Result := 'en_PrintDialog';
end;//Tkw_Form_PrintDialog.GetString

class procedure Tkw_Form_PrintDialog.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(Ten_PrintDialog);
end;//Tkw_Form_PrintDialog.RegisterInEngine

type
  Tkw_PrintDialog_Control_poDocumentNames = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола poDocumentNames
----
*Пример использования*:
[code]
контрол::poDocumentNames TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_PrintDialog_Control_poDocumentNames

// start class Tkw_PrintDialog_Control_poDocumentNames

class function Tkw_PrintDialog_Control_poDocumentNames.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::poDocumentNames';
end;//Tkw_PrintDialog_Control_poDocumentNames.GetWordNameForRegister

function Tkw_PrintDialog_Control_poDocumentNames.GetString: AnsiString;
 {-}
begin
 Result := 'poDocumentNames';
end;//Tkw_PrintDialog_Control_poDocumentNames.GetString

class procedure Tkw_PrintDialog_Control_poDocumentNames.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_PrintDialog_Control_poDocumentNames.RegisterInEngine

type
  Tkw_PrintDialog_Control_poDocumentNames_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола poDocumentNames
----
*Пример использования*:
[code]
контрол::poDocumentNames:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_PrintDialog_Control_poDocumentNames_Push

// start class Tkw_PrintDialog_Control_poDocumentNames_Push

procedure Tkw_PrintDialog_Control_poDocumentNames_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('poDocumentNames');
 inherited;
end;//Tkw_PrintDialog_Control_poDocumentNames_Push.DoDoIt

class function Tkw_PrintDialog_Control_poDocumentNames_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::poDocumentNames:push';
end;//Tkw_PrintDialog_Control_poDocumentNames_Push.GetWordNameForRegister

type
  Tkw_PrintDialog_Control_rbPrintSelected = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола rbPrintSelected
----
*Пример использования*:
[code]
контрол::rbPrintSelected TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_PrintDialog_Control_rbPrintSelected

// start class Tkw_PrintDialog_Control_rbPrintSelected

class function Tkw_PrintDialog_Control_rbPrintSelected.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rbPrintSelected';
end;//Tkw_PrintDialog_Control_rbPrintSelected.GetWordNameForRegister

function Tkw_PrintDialog_Control_rbPrintSelected.GetString: AnsiString;
 {-}
begin
 Result := 'rbPrintSelected';
end;//Tkw_PrintDialog_Control_rbPrintSelected.GetString

class procedure Tkw_PrintDialog_Control_rbPrintSelected.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_PrintDialog_Control_rbPrintSelected.RegisterInEngine

type
  Tkw_PrintDialog_Control_rbPrintSelected_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола rbPrintSelected
----
*Пример использования*:
[code]
контрол::rbPrintSelected:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_PrintDialog_Control_rbPrintSelected_Push

// start class Tkw_PrintDialog_Control_rbPrintSelected_Push

procedure Tkw_PrintDialog_Control_rbPrintSelected_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('rbPrintSelected');
 inherited;
end;//Tkw_PrintDialog_Control_rbPrintSelected_Push.DoDoIt

class function Tkw_PrintDialog_Control_rbPrintSelected_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rbPrintSelected:push';
end;//Tkw_PrintDialog_Control_rbPrintSelected_Push.GetWordNameForRegister

type
  Tkw_PrintDialog_Control_rbPrintCurrent = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола rbPrintCurrent
----
*Пример использования*:
[code]
контрол::rbPrintCurrent TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_PrintDialog_Control_rbPrintCurrent

// start class Tkw_PrintDialog_Control_rbPrintCurrent

class function Tkw_PrintDialog_Control_rbPrintCurrent.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rbPrintCurrent';
end;//Tkw_PrintDialog_Control_rbPrintCurrent.GetWordNameForRegister

function Tkw_PrintDialog_Control_rbPrintCurrent.GetString: AnsiString;
 {-}
begin
 Result := 'rbPrintCurrent';
end;//Tkw_PrintDialog_Control_rbPrintCurrent.GetString

class procedure Tkw_PrintDialog_Control_rbPrintCurrent.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_PrintDialog_Control_rbPrintCurrent.RegisterInEngine

type
  Tkw_PrintDialog_Control_rbPrintCurrent_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола rbPrintCurrent
----
*Пример использования*:
[code]
контрол::rbPrintCurrent:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_PrintDialog_Control_rbPrintCurrent_Push

// start class Tkw_PrintDialog_Control_rbPrintCurrent_Push

procedure Tkw_PrintDialog_Control_rbPrintCurrent_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('rbPrintCurrent');
 inherited;
end;//Tkw_PrintDialog_Control_rbPrintCurrent_Push.DoDoIt

class function Tkw_PrintDialog_Control_rbPrintCurrent_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rbPrintCurrent:push';
end;//Tkw_PrintDialog_Control_rbPrintCurrent_Push.GetWordNameForRegister

type
  Tkw_PrintDialog_Control_edPrintInterval = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола edPrintInterval
----
*Пример использования*:
[code]
контрол::edPrintInterval TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_PrintDialog_Control_edPrintInterval

// start class Tkw_PrintDialog_Control_edPrintInterval

class function Tkw_PrintDialog_Control_edPrintInterval.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edPrintInterval';
end;//Tkw_PrintDialog_Control_edPrintInterval.GetWordNameForRegister

function Tkw_PrintDialog_Control_edPrintInterval.GetString: AnsiString;
 {-}
begin
 Result := 'edPrintInterval';
end;//Tkw_PrintDialog_Control_edPrintInterval.GetString

class procedure Tkw_PrintDialog_Control_edPrintInterval.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEditWithoutPlusMinusShortcut);
end;//Tkw_PrintDialog_Control_edPrintInterval.RegisterInEngine

type
  Tkw_PrintDialog_Control_edPrintInterval_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола edPrintInterval
----
*Пример использования*:
[code]
контрол::edPrintInterval:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_PrintDialog_Control_edPrintInterval_Push

// start class Tkw_PrintDialog_Control_edPrintInterval_Push

procedure Tkw_PrintDialog_Control_edPrintInterval_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edPrintInterval');
 inherited;
end;//Tkw_PrintDialog_Control_edPrintInterval_Push.DoDoIt

class function Tkw_PrintDialog_Control_edPrintInterval_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edPrintInterval:push';
end;//Tkw_PrintDialog_Control_edPrintInterval_Push.GetWordNameForRegister

type
  Tkw_PrintDialog_Control_edCopyCount = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола edCopyCount
----
*Пример использования*:
[code]
контрол::edCopyCount TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_PrintDialog_Control_edCopyCount

// start class Tkw_PrintDialog_Control_edCopyCount

class function Tkw_PrintDialog_Control_edCopyCount.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edCopyCount';
end;//Tkw_PrintDialog_Control_edCopyCount.GetWordNameForRegister

function Tkw_PrintDialog_Control_edCopyCount.GetString: AnsiString;
 {-}
begin
 Result := 'edCopyCount';
end;//Tkw_PrintDialog_Control_edCopyCount.GetString

class procedure Tkw_PrintDialog_Control_edCopyCount.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSpinEdit);
end;//Tkw_PrintDialog_Control_edCopyCount.RegisterInEngine

type
  Tkw_PrintDialog_Control_edCopyCount_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола edCopyCount
----
*Пример использования*:
[code]
контрол::edCopyCount:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_PrintDialog_Control_edCopyCount_Push

// start class Tkw_PrintDialog_Control_edCopyCount_Push

procedure Tkw_PrintDialog_Control_edCopyCount_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edCopyCount');
 inherited;
end;//Tkw_PrintDialog_Control_edCopyCount_Push.DoDoIt

class function Tkw_PrintDialog_Control_edCopyCount_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edCopyCount:push';
end;//Tkw_PrintDialog_Control_edCopyCount_Push.GetWordNameForRegister

type
  Tkw_PrintDialog_Control_CollateCheckBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола CollateCheckBox
----
*Пример использования*:
[code]
контрол::CollateCheckBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_PrintDialog_Control_CollateCheckBox

// start class Tkw_PrintDialog_Control_CollateCheckBox

class function Tkw_PrintDialog_Control_CollateCheckBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::CollateCheckBox';
end;//Tkw_PrintDialog_Control_CollateCheckBox.GetWordNameForRegister

function Tkw_PrintDialog_Control_CollateCheckBox.GetString: AnsiString;
 {-}
begin
 Result := 'CollateCheckBox';
end;//Tkw_PrintDialog_Control_CollateCheckBox.GetString

class procedure Tkw_PrintDialog_Control_CollateCheckBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_PrintDialog_Control_CollateCheckBox.RegisterInEngine

type
  Tkw_PrintDialog_Control_CollateCheckBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола CollateCheckBox
----
*Пример использования*:
[code]
контрол::CollateCheckBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_PrintDialog_Control_CollateCheckBox_Push

// start class Tkw_PrintDialog_Control_CollateCheckBox_Push

procedure Tkw_PrintDialog_Control_CollateCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('CollateCheckBox');
 inherited;
end;//Tkw_PrintDialog_Control_CollateCheckBox_Push.DoDoIt

class function Tkw_PrintDialog_Control_CollateCheckBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::CollateCheckBox:push';
end;//Tkw_PrintDialog_Control_CollateCheckBox_Push.GetWordNameForRegister

type
  Tkw_PrintDialog_Control_cbOddEven = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола cbOddEven
----
*Пример использования*:
[code]
контрол::cbOddEven TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_PrintDialog_Control_cbOddEven

// start class Tkw_PrintDialog_Control_cbOddEven

class function Tkw_PrintDialog_Control_cbOddEven.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::cbOddEven';
end;//Tkw_PrintDialog_Control_cbOddEven.GetWordNameForRegister

function Tkw_PrintDialog_Control_cbOddEven.GetString: AnsiString;
 {-}
begin
 Result := 'cbOddEven';
end;//Tkw_PrintDialog_Control_cbOddEven.GetString

class procedure Tkw_PrintDialog_Control_cbOddEven.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_PrintDialog_Control_cbOddEven.RegisterInEngine

type
  Tkw_PrintDialog_Control_cbOddEven_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола cbOddEven
----
*Пример использования*:
[code]
контрол::cbOddEven:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_PrintDialog_Control_cbOddEven_Push

// start class Tkw_PrintDialog_Control_cbOddEven_Push

procedure Tkw_PrintDialog_Control_cbOddEven_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('cbOddEven');
 inherited;
end;//Tkw_PrintDialog_Control_cbOddEven_Push.DoDoIt

class function Tkw_PrintDialog_Control_cbOddEven_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::cbOddEven:push';
end;//Tkw_PrintDialog_Control_cbOddEven_Push.GetWordNameForRegister

type
  Tkw_PrintDialog_Control_poDocumentTexts = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола poDocumentTexts
----
*Пример использования*:
[code]
контрол::poDocumentTexts TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_PrintDialog_Control_poDocumentTexts

// start class Tkw_PrintDialog_Control_poDocumentTexts

class function Tkw_PrintDialog_Control_poDocumentTexts.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::poDocumentTexts';
end;//Tkw_PrintDialog_Control_poDocumentTexts.GetWordNameForRegister

function Tkw_PrintDialog_Control_poDocumentTexts.GetString: AnsiString;
 {-}
begin
 Result := 'poDocumentTexts';
end;//Tkw_PrintDialog_Control_poDocumentTexts.GetString

class procedure Tkw_PrintDialog_Control_poDocumentTexts.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_PrintDialog_Control_poDocumentTexts.RegisterInEngine

type
  Tkw_PrintDialog_Control_poDocumentTexts_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола poDocumentTexts
----
*Пример использования*:
[code]
контрол::poDocumentTexts:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_PrintDialog_Control_poDocumentTexts_Push

// start class Tkw_PrintDialog_Control_poDocumentTexts_Push

procedure Tkw_PrintDialog_Control_poDocumentTexts_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('poDocumentTexts');
 inherited;
end;//Tkw_PrintDialog_Control_poDocumentTexts_Push.DoDoIt

class function Tkw_PrintDialog_Control_poDocumentTexts_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::poDocumentTexts:push';
end;//Tkw_PrintDialog_Control_poDocumentTexts_Push.GetWordNameForRegister

type
  Tkw_PrintDialog_Control_rbPrintAll = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола rbPrintAll
----
*Пример использования*:
[code]
контрол::rbPrintAll TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_PrintDialog_Control_rbPrintAll

// start class Tkw_PrintDialog_Control_rbPrintAll

class function Tkw_PrintDialog_Control_rbPrintAll.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rbPrintAll';
end;//Tkw_PrintDialog_Control_rbPrintAll.GetWordNameForRegister

function Tkw_PrintDialog_Control_rbPrintAll.GetString: AnsiString;
 {-}
begin
 Result := 'rbPrintAll';
end;//Tkw_PrintDialog_Control_rbPrintAll.GetString

class procedure Tkw_PrintDialog_Control_rbPrintAll.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_PrintDialog_Control_rbPrintAll.RegisterInEngine

type
  Tkw_PrintDialog_Control_rbPrintAll_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола rbPrintAll
----
*Пример использования*:
[code]
контрол::rbPrintAll:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_PrintDialog_Control_rbPrintAll_Push

// start class Tkw_PrintDialog_Control_rbPrintAll_Push

procedure Tkw_PrintDialog_Control_rbPrintAll_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('rbPrintAll');
 inherited;
end;//Tkw_PrintDialog_Control_rbPrintAll_Push.DoDoIt

class function Tkw_PrintDialog_Control_rbPrintAll_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rbPrintAll:push';
end;//Tkw_PrintDialog_Control_rbPrintAll_Push.GetWordNameForRegister

type
  Tkw_PrintDialog_Control_rbPrintInterval = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола rbPrintInterval
----
*Пример использования*:
[code]
контрол::rbPrintInterval TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_PrintDialog_Control_rbPrintInterval

// start class Tkw_PrintDialog_Control_rbPrintInterval

class function Tkw_PrintDialog_Control_rbPrintInterval.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rbPrintInterval';
end;//Tkw_PrintDialog_Control_rbPrintInterval.GetWordNameForRegister

function Tkw_PrintDialog_Control_rbPrintInterval.GetString: AnsiString;
 {-}
begin
 Result := 'rbPrintInterval';
end;//Tkw_PrintDialog_Control_rbPrintInterval.GetString

class procedure Tkw_PrintDialog_Control_rbPrintInterval.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_PrintDialog_Control_rbPrintInterval.RegisterInEngine

type
  Tkw_PrintDialog_Control_rbPrintInterval_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола rbPrintInterval
----
*Пример использования*:
[code]
контрол::rbPrintInterval:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_PrintDialog_Control_rbPrintInterval_Push

// start class Tkw_PrintDialog_Control_rbPrintInterval_Push

procedure Tkw_PrintDialog_Control_rbPrintInterval_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('rbPrintInterval');
 inherited;
end;//Tkw_PrintDialog_Control_rbPrintInterval_Push.DoDoIt

class function Tkw_PrintDialog_Control_rbPrintInterval_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rbPrintInterval:push';
end;//Tkw_PrintDialog_Control_rbPrintInterval_Push.GetWordNameForRegister

type
  Tkw_PrintDialog_Control_cbPrinter = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола cbPrinter
----
*Пример использования*:
[code]
контрол::cbPrinter TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_PrintDialog_Control_cbPrinter

// start class Tkw_PrintDialog_Control_cbPrinter

class function Tkw_PrintDialog_Control_cbPrinter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::cbPrinter';
end;//Tkw_PrintDialog_Control_cbPrinter.GetWordNameForRegister

function Tkw_PrintDialog_Control_cbPrinter.GetString: AnsiString;
 {-}
begin
 Result := 'cbPrinter';
end;//Tkw_PrintDialog_Control_cbPrinter.GetString

class procedure Tkw_PrintDialog_Control_cbPrinter.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_PrintDialog_Control_cbPrinter.RegisterInEngine

type
  Tkw_PrintDialog_Control_cbPrinter_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола cbPrinter
----
*Пример использования*:
[code]
контрол::cbPrinter:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_PrintDialog_Control_cbPrinter_Push

// start class Tkw_PrintDialog_Control_cbPrinter_Push

procedure Tkw_PrintDialog_Control_cbPrinter_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('cbPrinter');
 inherited;
end;//Tkw_PrintDialog_Control_cbPrinter_Push.DoDoIt

class function Tkw_PrintDialog_Control_cbPrinter_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::cbPrinter:push';
end;//Tkw_PrintDialog_Control_cbPrinter_Push.GetWordNameForRegister

type
  Tkw_PrintDialog_Control_cbPrintInfo = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола cbPrintInfo
----
*Пример использования*:
[code]
контрол::cbPrintInfo TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_PrintDialog_Control_cbPrintInfo

// start class Tkw_PrintDialog_Control_cbPrintInfo

class function Tkw_PrintDialog_Control_cbPrintInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::cbPrintInfo';
end;//Tkw_PrintDialog_Control_cbPrintInfo.GetWordNameForRegister

function Tkw_PrintDialog_Control_cbPrintInfo.GetString: AnsiString;
 {-}
begin
 Result := 'cbPrintInfo';
end;//Tkw_PrintDialog_Control_cbPrintInfo.GetString

class procedure Tkw_PrintDialog_Control_cbPrintInfo.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_PrintDialog_Control_cbPrintInfo.RegisterInEngine

type
  Tkw_PrintDialog_Control_cbPrintInfo_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола cbPrintInfo
----
*Пример использования*:
[code]
контрол::cbPrintInfo:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_PrintDialog_Control_cbPrintInfo_Push

// start class Tkw_PrintDialog_Control_cbPrintInfo_Push

procedure Tkw_PrintDialog_Control_cbPrintInfo_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('cbPrintInfo');
 inherited;
end;//Tkw_PrintDialog_Control_cbPrintInfo_Push.DoDoIt

class function Tkw_PrintDialog_Control_cbPrintInfo_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::cbPrintInfo:push';
end;//Tkw_PrintDialog_Control_cbPrintInfo_Push.GetWordNameForRegister

type
  TkwEnPrintDialogPoDocumentNames = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_PrintDialog.poDocumentNames
[panel]Контрол poDocumentNames формы Ten_PrintDialog[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_PrintDialog .Ten_PrintDialog.poDocumentNames >>> l_TvtRadioButton
[code]  }
  private
  // private methods
   function PoDocumentNames(const aCtx: TtfwContext;
     aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
     {* Реализация слова скрипта .Ten_PrintDialog.poDocumentNames }
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
  end;//TkwEnPrintDialogPoDocumentNames

// start class TkwEnPrintDialogPoDocumentNames

function TkwEnPrintDialogPoDocumentNames.PoDocumentNames(const aCtx: TtfwContext;
  aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
 {-}
begin
 Result := aen_PrintDialog.poDocumentNames;
end;//TkwEnPrintDialogPoDocumentNames.PoDocumentNames

procedure TkwEnPrintDialogPoDocumentNames.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_PrintDialog : Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PoDocumentNames(aCtx, l_aen_PrintDialog)));
end;//TkwEnPrintDialogPoDocumentNames.DoDoIt

class function TkwEnPrintDialogPoDocumentNames.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_PrintDialog.poDocumentNames';
end;//TkwEnPrintDialogPoDocumentNames.GetWordNameForRegister

procedure TkwEnPrintDialogPoDocumentNames.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству poDocumentNames', aCtx);
end;//TkwEnPrintDialogPoDocumentNames.SetValuePrim

function TkwEnPrintDialogPoDocumentNames.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnPrintDialogPoDocumentNames.GetResultTypeInfo

function TkwEnPrintDialogPoDocumentNames.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnPrintDialogPoDocumentNames.GetAllParamsCount

function TkwEnPrintDialogPoDocumentNames.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogPoDocumentNames.ParamsTypes

type
  TkwEnPrintDialogRbPrintSelected = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_PrintDialog.rbPrintSelected
[panel]Контрол rbPrintSelected формы Ten_PrintDialog[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_PrintDialog .Ten_PrintDialog.rbPrintSelected >>> l_TvtRadioButton
[code]  }
  private
  // private methods
   function RbPrintSelected(const aCtx: TtfwContext;
     aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
     {* Реализация слова скрипта .Ten_PrintDialog.rbPrintSelected }
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
  end;//TkwEnPrintDialogRbPrintSelected

// start class TkwEnPrintDialogRbPrintSelected

function TkwEnPrintDialogRbPrintSelected.RbPrintSelected(const aCtx: TtfwContext;
  aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
 {-}
begin
 Result := aen_PrintDialog.rbPrintSelected;
end;//TkwEnPrintDialogRbPrintSelected.RbPrintSelected

procedure TkwEnPrintDialogRbPrintSelected.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_PrintDialog : Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RbPrintSelected(aCtx, l_aen_PrintDialog)));
end;//TkwEnPrintDialogRbPrintSelected.DoDoIt

class function TkwEnPrintDialogRbPrintSelected.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_PrintDialog.rbPrintSelected';
end;//TkwEnPrintDialogRbPrintSelected.GetWordNameForRegister

procedure TkwEnPrintDialogRbPrintSelected.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству rbPrintSelected', aCtx);
end;//TkwEnPrintDialogRbPrintSelected.SetValuePrim

function TkwEnPrintDialogRbPrintSelected.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnPrintDialogRbPrintSelected.GetResultTypeInfo

function TkwEnPrintDialogRbPrintSelected.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnPrintDialogRbPrintSelected.GetAllParamsCount

function TkwEnPrintDialogRbPrintSelected.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogRbPrintSelected.ParamsTypes

type
  TkwEnPrintDialogRbPrintCurrent = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_PrintDialog.rbPrintCurrent
[panel]Контрол rbPrintCurrent формы Ten_PrintDialog[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_PrintDialog .Ten_PrintDialog.rbPrintCurrent >>> l_TvtRadioButton
[code]  }
  private
  // private methods
   function RbPrintCurrent(const aCtx: TtfwContext;
     aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
     {* Реализация слова скрипта .Ten_PrintDialog.rbPrintCurrent }
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
  end;//TkwEnPrintDialogRbPrintCurrent

// start class TkwEnPrintDialogRbPrintCurrent

function TkwEnPrintDialogRbPrintCurrent.RbPrintCurrent(const aCtx: TtfwContext;
  aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
 {-}
begin
 Result := aen_PrintDialog.rbPrintCurrent;
end;//TkwEnPrintDialogRbPrintCurrent.RbPrintCurrent

procedure TkwEnPrintDialogRbPrintCurrent.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_PrintDialog : Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RbPrintCurrent(aCtx, l_aen_PrintDialog)));
end;//TkwEnPrintDialogRbPrintCurrent.DoDoIt

class function TkwEnPrintDialogRbPrintCurrent.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_PrintDialog.rbPrintCurrent';
end;//TkwEnPrintDialogRbPrintCurrent.GetWordNameForRegister

procedure TkwEnPrintDialogRbPrintCurrent.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству rbPrintCurrent', aCtx);
end;//TkwEnPrintDialogRbPrintCurrent.SetValuePrim

function TkwEnPrintDialogRbPrintCurrent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnPrintDialogRbPrintCurrent.GetResultTypeInfo

function TkwEnPrintDialogRbPrintCurrent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnPrintDialogRbPrintCurrent.GetAllParamsCount

function TkwEnPrintDialogRbPrintCurrent.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogRbPrintCurrent.ParamsTypes

type
  TkwEnPrintDialogEdPrintInterval = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_PrintDialog.edPrintInterval
[panel]Контрол edPrintInterval формы Ten_PrintDialog[panel]
*Тип результата:* TnscEditWithoutPlusMinusShortcut
*Пример:*
[code]
OBJECT VAR l_TnscEditWithoutPlusMinusShortcut
 aen_PrintDialog .Ten_PrintDialog.edPrintInterval >>> l_TnscEditWithoutPlusMinusShortcut
[code]  }
  private
  // private methods
   function EdPrintInterval(const aCtx: TtfwContext;
     aen_PrintDialog: Ten_PrintDialog): TnscEditWithoutPlusMinusShortcut;
     {* Реализация слова скрипта .Ten_PrintDialog.edPrintInterval }
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
  end;//TkwEnPrintDialogEdPrintInterval

// start class TkwEnPrintDialogEdPrintInterval

function TkwEnPrintDialogEdPrintInterval.EdPrintInterval(const aCtx: TtfwContext;
  aen_PrintDialog: Ten_PrintDialog): TnscEditWithoutPlusMinusShortcut;
 {-}
begin
 Result := aen_PrintDialog.edPrintInterval;
end;//TkwEnPrintDialogEdPrintInterval.EdPrintInterval

procedure TkwEnPrintDialogEdPrintInterval.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_PrintDialog : Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdPrintInterval(aCtx, l_aen_PrintDialog)));
end;//TkwEnPrintDialogEdPrintInterval.DoDoIt

class function TkwEnPrintDialogEdPrintInterval.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_PrintDialog.edPrintInterval';
end;//TkwEnPrintDialogEdPrintInterval.GetWordNameForRegister

procedure TkwEnPrintDialogEdPrintInterval.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству edPrintInterval', aCtx);
end;//TkwEnPrintDialogEdPrintInterval.SetValuePrim

function TkwEnPrintDialogEdPrintInterval.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEditWithoutPlusMinusShortcut);
end;//TkwEnPrintDialogEdPrintInterval.GetResultTypeInfo

function TkwEnPrintDialogEdPrintInterval.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnPrintDialogEdPrintInterval.GetAllParamsCount

function TkwEnPrintDialogEdPrintInterval.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogEdPrintInterval.ParamsTypes

type
  TkwEnPrintDialogEdCopyCount = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_PrintDialog.edCopyCount
[panel]Контрол edCopyCount формы Ten_PrintDialog[panel]
*Тип результата:* TvtSpinEdit
*Пример:*
[code]
OBJECT VAR l_TvtSpinEdit
 aen_PrintDialog .Ten_PrintDialog.edCopyCount >>> l_TvtSpinEdit
[code]  }
  private
  // private methods
   function EdCopyCount(const aCtx: TtfwContext;
     aen_PrintDialog: Ten_PrintDialog): TvtSpinEdit;
     {* Реализация слова скрипта .Ten_PrintDialog.edCopyCount }
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
  end;//TkwEnPrintDialogEdCopyCount

// start class TkwEnPrintDialogEdCopyCount

function TkwEnPrintDialogEdCopyCount.EdCopyCount(const aCtx: TtfwContext;
  aen_PrintDialog: Ten_PrintDialog): TvtSpinEdit;
 {-}
begin
 Result := aen_PrintDialog.edCopyCount;
end;//TkwEnPrintDialogEdCopyCount.EdCopyCount

procedure TkwEnPrintDialogEdCopyCount.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_PrintDialog : Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdCopyCount(aCtx, l_aen_PrintDialog)));
end;//TkwEnPrintDialogEdCopyCount.DoDoIt

class function TkwEnPrintDialogEdCopyCount.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_PrintDialog.edCopyCount';
end;//TkwEnPrintDialogEdCopyCount.GetWordNameForRegister

procedure TkwEnPrintDialogEdCopyCount.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству edCopyCount', aCtx);
end;//TkwEnPrintDialogEdCopyCount.SetValuePrim

function TkwEnPrintDialogEdCopyCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSpinEdit);
end;//TkwEnPrintDialogEdCopyCount.GetResultTypeInfo

function TkwEnPrintDialogEdCopyCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnPrintDialogEdCopyCount.GetAllParamsCount

function TkwEnPrintDialogEdCopyCount.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogEdCopyCount.ParamsTypes

type
  TkwEnPrintDialogCollateCheckBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_PrintDialog.CollateCheckBox
[panel]Контрол CollateCheckBox формы Ten_PrintDialog[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aen_PrintDialog .Ten_PrintDialog.CollateCheckBox >>> l_TvtCheckBox
[code]  }
  private
  // private methods
   function CollateCheckBox(const aCtx: TtfwContext;
     aen_PrintDialog: Ten_PrintDialog): TvtCheckBox;
     {* Реализация слова скрипта .Ten_PrintDialog.CollateCheckBox }
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
  end;//TkwEnPrintDialogCollateCheckBox

// start class TkwEnPrintDialogCollateCheckBox

function TkwEnPrintDialogCollateCheckBox.CollateCheckBox(const aCtx: TtfwContext;
  aen_PrintDialog: Ten_PrintDialog): TvtCheckBox;
 {-}
begin
 Result := aen_PrintDialog.CollateCheckBox;
end;//TkwEnPrintDialogCollateCheckBox.CollateCheckBox

procedure TkwEnPrintDialogCollateCheckBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_PrintDialog : Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((CollateCheckBox(aCtx, l_aen_PrintDialog)));
end;//TkwEnPrintDialogCollateCheckBox.DoDoIt

class function TkwEnPrintDialogCollateCheckBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_PrintDialog.CollateCheckBox';
end;//TkwEnPrintDialogCollateCheckBox.GetWordNameForRegister

procedure TkwEnPrintDialogCollateCheckBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству CollateCheckBox', aCtx);
end;//TkwEnPrintDialogCollateCheckBox.SetValuePrim

function TkwEnPrintDialogCollateCheckBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwEnPrintDialogCollateCheckBox.GetResultTypeInfo

function TkwEnPrintDialogCollateCheckBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnPrintDialogCollateCheckBox.GetAllParamsCount

function TkwEnPrintDialogCollateCheckBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogCollateCheckBox.ParamsTypes

type
  TkwEnPrintDialogCbOddEven = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_PrintDialog.cbOddEven
[panel]Контрол cbOddEven формы Ten_PrintDialog[panel]
*Тип результата:* TvtComboBoxQS
*Пример:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aen_PrintDialog .Ten_PrintDialog.cbOddEven >>> l_TvtComboBoxQS
[code]  }
  private
  // private methods
   function CbOddEven(const aCtx: TtfwContext;
     aen_PrintDialog: Ten_PrintDialog): TvtComboBoxQS;
     {* Реализация слова скрипта .Ten_PrintDialog.cbOddEven }
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
  end;//TkwEnPrintDialogCbOddEven

// start class TkwEnPrintDialogCbOddEven

function TkwEnPrintDialogCbOddEven.CbOddEven(const aCtx: TtfwContext;
  aen_PrintDialog: Ten_PrintDialog): TvtComboBoxQS;
 {-}
begin
 Result := aen_PrintDialog.cbOddEven;
end;//TkwEnPrintDialogCbOddEven.CbOddEven

procedure TkwEnPrintDialogCbOddEven.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_PrintDialog : Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((CbOddEven(aCtx, l_aen_PrintDialog)));
end;//TkwEnPrintDialogCbOddEven.DoDoIt

class function TkwEnPrintDialogCbOddEven.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_PrintDialog.cbOddEven';
end;//TkwEnPrintDialogCbOddEven.GetWordNameForRegister

procedure TkwEnPrintDialogCbOddEven.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству cbOddEven', aCtx);
end;//TkwEnPrintDialogCbOddEven.SetValuePrim

function TkwEnPrintDialogCbOddEven.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwEnPrintDialogCbOddEven.GetResultTypeInfo

function TkwEnPrintDialogCbOddEven.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnPrintDialogCbOddEven.GetAllParamsCount

function TkwEnPrintDialogCbOddEven.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogCbOddEven.ParamsTypes

type
  TkwEnPrintDialogPoDocumentTexts = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_PrintDialog.poDocumentTexts
[panel]Контрол poDocumentTexts формы Ten_PrintDialog[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_PrintDialog .Ten_PrintDialog.poDocumentTexts >>> l_TvtRadioButton
[code]  }
  private
  // private methods
   function PoDocumentTexts(const aCtx: TtfwContext;
     aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
     {* Реализация слова скрипта .Ten_PrintDialog.poDocumentTexts }
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
  end;//TkwEnPrintDialogPoDocumentTexts

// start class TkwEnPrintDialogPoDocumentTexts

function TkwEnPrintDialogPoDocumentTexts.PoDocumentTexts(const aCtx: TtfwContext;
  aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
 {-}
begin
 Result := aen_PrintDialog.poDocumentTexts;
end;//TkwEnPrintDialogPoDocumentTexts.PoDocumentTexts

procedure TkwEnPrintDialogPoDocumentTexts.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_PrintDialog : Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PoDocumentTexts(aCtx, l_aen_PrintDialog)));
end;//TkwEnPrintDialogPoDocumentTexts.DoDoIt

class function TkwEnPrintDialogPoDocumentTexts.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_PrintDialog.poDocumentTexts';
end;//TkwEnPrintDialogPoDocumentTexts.GetWordNameForRegister

procedure TkwEnPrintDialogPoDocumentTexts.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству poDocumentTexts', aCtx);
end;//TkwEnPrintDialogPoDocumentTexts.SetValuePrim

function TkwEnPrintDialogPoDocumentTexts.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnPrintDialogPoDocumentTexts.GetResultTypeInfo

function TkwEnPrintDialogPoDocumentTexts.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnPrintDialogPoDocumentTexts.GetAllParamsCount

function TkwEnPrintDialogPoDocumentTexts.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogPoDocumentTexts.ParamsTypes

type
  TkwEnPrintDialogRbPrintAll = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_PrintDialog.rbPrintAll
[panel]Контрол rbPrintAll формы Ten_PrintDialog[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_PrintDialog .Ten_PrintDialog.rbPrintAll >>> l_TvtRadioButton
[code]  }
  private
  // private methods
   function RbPrintAll(const aCtx: TtfwContext;
     aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
     {* Реализация слова скрипта .Ten_PrintDialog.rbPrintAll }
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
  end;//TkwEnPrintDialogRbPrintAll

// start class TkwEnPrintDialogRbPrintAll

function TkwEnPrintDialogRbPrintAll.RbPrintAll(const aCtx: TtfwContext;
  aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
 {-}
begin
 Result := aen_PrintDialog.rbPrintAll;
end;//TkwEnPrintDialogRbPrintAll.RbPrintAll

procedure TkwEnPrintDialogRbPrintAll.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_PrintDialog : Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RbPrintAll(aCtx, l_aen_PrintDialog)));
end;//TkwEnPrintDialogRbPrintAll.DoDoIt

class function TkwEnPrintDialogRbPrintAll.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_PrintDialog.rbPrintAll';
end;//TkwEnPrintDialogRbPrintAll.GetWordNameForRegister

procedure TkwEnPrintDialogRbPrintAll.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству rbPrintAll', aCtx);
end;//TkwEnPrintDialogRbPrintAll.SetValuePrim

function TkwEnPrintDialogRbPrintAll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnPrintDialogRbPrintAll.GetResultTypeInfo

function TkwEnPrintDialogRbPrintAll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnPrintDialogRbPrintAll.GetAllParamsCount

function TkwEnPrintDialogRbPrintAll.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogRbPrintAll.ParamsTypes

type
  TkwEnPrintDialogRbPrintInterval = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_PrintDialog.rbPrintInterval
[panel]Контрол rbPrintInterval формы Ten_PrintDialog[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_PrintDialog .Ten_PrintDialog.rbPrintInterval >>> l_TvtRadioButton
[code]  }
  private
  // private methods
   function RbPrintInterval(const aCtx: TtfwContext;
     aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
     {* Реализация слова скрипта .Ten_PrintDialog.rbPrintInterval }
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
  end;//TkwEnPrintDialogRbPrintInterval

// start class TkwEnPrintDialogRbPrintInterval

function TkwEnPrintDialogRbPrintInterval.RbPrintInterval(const aCtx: TtfwContext;
  aen_PrintDialog: Ten_PrintDialog): TvtRadioButton;
 {-}
begin
 Result := aen_PrintDialog.rbPrintInterval;
end;//TkwEnPrintDialogRbPrintInterval.RbPrintInterval

procedure TkwEnPrintDialogRbPrintInterval.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_PrintDialog : Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RbPrintInterval(aCtx, l_aen_PrintDialog)));
end;//TkwEnPrintDialogRbPrintInterval.DoDoIt

class function TkwEnPrintDialogRbPrintInterval.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_PrintDialog.rbPrintInterval';
end;//TkwEnPrintDialogRbPrintInterval.GetWordNameForRegister

procedure TkwEnPrintDialogRbPrintInterval.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству rbPrintInterval', aCtx);
end;//TkwEnPrintDialogRbPrintInterval.SetValuePrim

function TkwEnPrintDialogRbPrintInterval.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnPrintDialogRbPrintInterval.GetResultTypeInfo

function TkwEnPrintDialogRbPrintInterval.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnPrintDialogRbPrintInterval.GetAllParamsCount

function TkwEnPrintDialogRbPrintInterval.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogRbPrintInterval.ParamsTypes

type
  TkwEnPrintDialogCbPrinter = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_PrintDialog.cbPrinter
[panel]Контрол cbPrinter формы Ten_PrintDialog[panel]
*Тип результата:* TvtComboBoxQS
*Пример:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aen_PrintDialog .Ten_PrintDialog.cbPrinter >>> l_TvtComboBoxQS
[code]  }
  private
  // private methods
   function CbPrinter(const aCtx: TtfwContext;
     aen_PrintDialog: Ten_PrintDialog): TvtComboBoxQS;
     {* Реализация слова скрипта .Ten_PrintDialog.cbPrinter }
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
  end;//TkwEnPrintDialogCbPrinter

// start class TkwEnPrintDialogCbPrinter

function TkwEnPrintDialogCbPrinter.CbPrinter(const aCtx: TtfwContext;
  aen_PrintDialog: Ten_PrintDialog): TvtComboBoxQS;
 {-}
begin
 Result := aen_PrintDialog.cbPrinter;
end;//TkwEnPrintDialogCbPrinter.CbPrinter

procedure TkwEnPrintDialogCbPrinter.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_PrintDialog : Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((CbPrinter(aCtx, l_aen_PrintDialog)));
end;//TkwEnPrintDialogCbPrinter.DoDoIt

class function TkwEnPrintDialogCbPrinter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_PrintDialog.cbPrinter';
end;//TkwEnPrintDialogCbPrinter.GetWordNameForRegister

procedure TkwEnPrintDialogCbPrinter.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству cbPrinter', aCtx);
end;//TkwEnPrintDialogCbPrinter.SetValuePrim

function TkwEnPrintDialogCbPrinter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwEnPrintDialogCbPrinter.GetResultTypeInfo

function TkwEnPrintDialogCbPrinter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnPrintDialogCbPrinter.GetAllParamsCount

function TkwEnPrintDialogCbPrinter.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogCbPrinter.ParamsTypes

type
  TkwEnPrintDialogCbPrintInfo = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_PrintDialog.cbPrintInfo
[panel]Контрол cbPrintInfo формы Ten_PrintDialog[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aen_PrintDialog .Ten_PrintDialog.cbPrintInfo >>> l_TvtCheckBox
[code]  }
  private
  // private methods
   function CbPrintInfo(const aCtx: TtfwContext;
     aen_PrintDialog: Ten_PrintDialog): TvtCheckBox;
     {* Реализация слова скрипта .Ten_PrintDialog.cbPrintInfo }
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
  end;//TkwEnPrintDialogCbPrintInfo

// start class TkwEnPrintDialogCbPrintInfo

function TkwEnPrintDialogCbPrintInfo.CbPrintInfo(const aCtx: TtfwContext;
  aen_PrintDialog: Ten_PrintDialog): TvtCheckBox;
 {-}
begin
 Result := aen_PrintDialog.cbPrintInfo;
end;//TkwEnPrintDialogCbPrintInfo.CbPrintInfo

procedure TkwEnPrintDialogCbPrintInfo.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_PrintDialog : Ten_PrintDialog;
begin
 try
  l_aen_PrintDialog := Ten_PrintDialog(aCtx.rEngine.PopObjAs(Ten_PrintDialog));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_PrintDialog: Ten_PrintDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((CbPrintInfo(aCtx, l_aen_PrintDialog)));
end;//TkwEnPrintDialogCbPrintInfo.DoDoIt

class function TkwEnPrintDialogCbPrintInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_PrintDialog.cbPrintInfo';
end;//TkwEnPrintDialogCbPrintInfo.GetWordNameForRegister

procedure TkwEnPrintDialogCbPrintInfo.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству cbPrintInfo', aCtx);
end;//TkwEnPrintDialogCbPrintInfo.SetValuePrim

function TkwEnPrintDialogCbPrintInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwEnPrintDialogCbPrintInfo.GetResultTypeInfo

function TkwEnPrintDialogCbPrintInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnPrintDialogCbPrintInfo.GetAllParamsCount

function TkwEnPrintDialogCbPrintInfo.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PrintDialog)]);
end;//TkwEnPrintDialogCbPrintInfo.ParamsTypes
{$IfEnd} //not Admin AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_Form_PrintDialog
 Tkw_Form_PrintDialog.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_poDocumentNames
 Tkw_PrintDialog_Control_poDocumentNames.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_poDocumentNames_Push
 Tkw_PrintDialog_Control_poDocumentNames_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_rbPrintSelected
 Tkw_PrintDialog_Control_rbPrintSelected.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_rbPrintSelected_Push
 Tkw_PrintDialog_Control_rbPrintSelected_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_rbPrintCurrent
 Tkw_PrintDialog_Control_rbPrintCurrent.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_rbPrintCurrent_Push
 Tkw_PrintDialog_Control_rbPrintCurrent_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_edPrintInterval
 Tkw_PrintDialog_Control_edPrintInterval.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_edPrintInterval_Push
 Tkw_PrintDialog_Control_edPrintInterval_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_edCopyCount
 Tkw_PrintDialog_Control_edCopyCount.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_edCopyCount_Push
 Tkw_PrintDialog_Control_edCopyCount_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_CollateCheckBox
 Tkw_PrintDialog_Control_CollateCheckBox.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_CollateCheckBox_Push
 Tkw_PrintDialog_Control_CollateCheckBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_cbOddEven
 Tkw_PrintDialog_Control_cbOddEven.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_cbOddEven_Push
 Tkw_PrintDialog_Control_cbOddEven_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_poDocumentTexts
 Tkw_PrintDialog_Control_poDocumentTexts.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_poDocumentTexts_Push
 Tkw_PrintDialog_Control_poDocumentTexts_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_rbPrintAll
 Tkw_PrintDialog_Control_rbPrintAll.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_rbPrintAll_Push
 Tkw_PrintDialog_Control_rbPrintAll_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_rbPrintInterval
 Tkw_PrintDialog_Control_rbPrintInterval.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_rbPrintInterval_Push
 Tkw_PrintDialog_Control_rbPrintInterval_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_cbPrinter
 Tkw_PrintDialog_Control_cbPrinter.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_cbPrinter_Push
 Tkw_PrintDialog_Control_cbPrinter_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_cbPrintInfo
 Tkw_PrintDialog_Control_cbPrintInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_PrintDialog_Control_cbPrintInfo_Push
 Tkw_PrintDialog_Control_cbPrintInfo_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация en_PrintDialog_poDocumentNames
 TkwEnPrintDialogPoDocumentNames.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация en_PrintDialog_rbPrintSelected
 TkwEnPrintDialogRbPrintSelected.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация en_PrintDialog_rbPrintCurrent
 TkwEnPrintDialogRbPrintCurrent.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация en_PrintDialog_edPrintInterval
 TkwEnPrintDialogEdPrintInterval.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация en_PrintDialog_edCopyCount
 TkwEnPrintDialogEdCopyCount.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация en_PrintDialog_CollateCheckBox
 TkwEnPrintDialogCollateCheckBox.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация en_PrintDialog_cbOddEven
 TkwEnPrintDialogCbOddEven.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация en_PrintDialog_poDocumentTexts
 TkwEnPrintDialogPoDocumentTexts.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация en_PrintDialog_rbPrintAll
 TkwEnPrintDialogRbPrintAll.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация en_PrintDialog_rbPrintInterval
 TkwEnPrintDialogRbPrintInterval.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация en_PrintDialog_cbPrinter
 TkwEnPrintDialogCbPrinter.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация en_PrintDialog_cbPrintInfo
 TkwEnPrintDialogCbPrintInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа PrintDialog
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_PrintDialog));
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TvtRadioButton
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtRadioButton));
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TnscEditWithoutPlusMinusShortcut
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditWithoutPlusMinusShortcut));
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TvtSpinEdit
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSpinEdit));
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TvtCheckBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCheckBox));
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TvtComboBoxQS
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtComboBoxQS));
{$IfEnd} //not Admin AND not NoScripts

end.