unit AACContainerKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/AAC/AACContainerKeywordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Пользовательские сервисы::AAC::View::AAC::AACPrim::AACContainerKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы AACContainer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

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
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  vtLabel,
  nscSimpleEditorForDialogs,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  AACContainer_Form,
  vtScrollBar,
  tfwControlString,
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
  Tkw_Form_AACContainer = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы AACContainer
----
*Пример использования*:
[code]
'aControl' форма::AACContainer TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_AACContainer

// start class Tkw_Form_AACContainer

class function Tkw_Form_AACContainer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::AACContainer';
end;//Tkw_Form_AACContainer.GetWordNameForRegister

function Tkw_Form_AACContainer.GetString: AnsiString;
 {-}
begin
 Result := 'AACContainerForm';
end;//Tkw_Form_AACContainer.GetString

type
  Tkw_AACContainer_Control_pnWriteToUs = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnWriteToUs
----
*Пример использования*:
[code]
контрол::pnWriteToUs TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AACContainer_Control_pnWriteToUs

// start class Tkw_AACContainer_Control_pnWriteToUs

class function Tkw_AACContainer_Control_pnWriteToUs.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnWriteToUs';
end;//Tkw_AACContainer_Control_pnWriteToUs.GetWordNameForRegister

function Tkw_AACContainer_Control_pnWriteToUs.GetString: AnsiString;
 {-}
begin
 Result := 'pnWriteToUs';
end;//Tkw_AACContainer_Control_pnWriteToUs.GetString

class procedure Tkw_AACContainer_Control_pnWriteToUs.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnWriteToUs.RegisterInEngine

type
  Tkw_AACContainer_Control_pnWriteToUs_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnWriteToUs
----
*Пример использования*:
[code]
контрол::pnWriteToUs:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AACContainer_Control_pnWriteToUs_Push

// start class Tkw_AACContainer_Control_pnWriteToUs_Push

procedure Tkw_AACContainer_Control_pnWriteToUs_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnWriteToUs');
 inherited;
end;//Tkw_AACContainer_Control_pnWriteToUs_Push.DoDoIt

class function Tkw_AACContainer_Control_pnWriteToUs_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnWriteToUs:push';
end;//Tkw_AACContainer_Control_pnWriteToUs_Push.GetWordNameForRegister

type
  Tkw_AACContainer_Control_edWriteToUs = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола edWriteToUs
----
*Пример использования*:
[code]
контрол::edWriteToUs TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AACContainer_Control_edWriteToUs

// start class Tkw_AACContainer_Control_edWriteToUs

class function Tkw_AACContainer_Control_edWriteToUs.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edWriteToUs';
end;//Tkw_AACContainer_Control_edWriteToUs.GetWordNameForRegister

function Tkw_AACContainer_Control_edWriteToUs.GetString: AnsiString;
 {-}
begin
 Result := 'edWriteToUs';
end;//Tkw_AACContainer_Control_edWriteToUs.GetString

class procedure Tkw_AACContainer_Control_edWriteToUs.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscSimpleEditorForDialogs);
end;//Tkw_AACContainer_Control_edWriteToUs.RegisterInEngine

type
  Tkw_AACContainer_Control_edWriteToUs_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола edWriteToUs
----
*Пример использования*:
[code]
контрол::edWriteToUs:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AACContainer_Control_edWriteToUs_Push

// start class Tkw_AACContainer_Control_edWriteToUs_Push

procedure Tkw_AACContainer_Control_edWriteToUs_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edWriteToUs');
 inherited;
end;//Tkw_AACContainer_Control_edWriteToUs_Push.DoDoIt

class function Tkw_AACContainer_Control_edWriteToUs_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edWriteToUs:push';
end;//Tkw_AACContainer_Control_edWriteToUs_Push.GetWordNameForRegister

type
  Tkw_AACContainer_Control_pnSeeAlso = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnSeeAlso
----
*Пример использования*:
[code]
контрол::pnSeeAlso TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AACContainer_Control_pnSeeAlso

// start class Tkw_AACContainer_Control_pnSeeAlso

class function Tkw_AACContainer_Control_pnSeeAlso.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnSeeAlso';
end;//Tkw_AACContainer_Control_pnSeeAlso.GetWordNameForRegister

function Tkw_AACContainer_Control_pnSeeAlso.GetString: AnsiString;
 {-}
begin
 Result := 'pnSeeAlso';
end;//Tkw_AACContainer_Control_pnSeeAlso.GetString

class procedure Tkw_AACContainer_Control_pnSeeAlso.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnSeeAlso.RegisterInEngine

type
  Tkw_AACContainer_Control_pnSeeAlso_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnSeeAlso
----
*Пример использования*:
[code]
контрол::pnSeeAlso:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AACContainer_Control_pnSeeAlso_Push

// start class Tkw_AACContainer_Control_pnSeeAlso_Push

procedure Tkw_AACContainer_Control_pnSeeAlso_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnSeeAlso');
 inherited;
end;//Tkw_AACContainer_Control_pnSeeAlso_Push.DoDoIt

class function Tkw_AACContainer_Control_pnSeeAlso_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnSeeAlso:push';
end;//Tkw_AACContainer_Control_pnSeeAlso_Push.GetWordNameForRegister

type
  Tkw_AACContainer_Control_lblSeeAlso = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола lblSeeAlso
----
*Пример использования*:
[code]
контрол::lblSeeAlso TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AACContainer_Control_lblSeeAlso

// start class Tkw_AACContainer_Control_lblSeeAlso

class function Tkw_AACContainer_Control_lblSeeAlso.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblSeeAlso';
end;//Tkw_AACContainer_Control_lblSeeAlso.GetWordNameForRegister

function Tkw_AACContainer_Control_lblSeeAlso.GetString: AnsiString;
 {-}
begin
 Result := 'lblSeeAlso';
end;//Tkw_AACContainer_Control_lblSeeAlso.GetString

class procedure Tkw_AACContainer_Control_lblSeeAlso.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_AACContainer_Control_lblSeeAlso.RegisterInEngine

type
  Tkw_AACContainer_Control_lblSeeAlso_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола lblSeeAlso
----
*Пример использования*:
[code]
контрол::lblSeeAlso:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AACContainer_Control_lblSeeAlso_Push

// start class Tkw_AACContainer_Control_lblSeeAlso_Push

procedure Tkw_AACContainer_Control_lblSeeAlso_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lblSeeAlso');
 inherited;
end;//Tkw_AACContainer_Control_lblSeeAlso_Push.DoDoIt

class function Tkw_AACContainer_Control_lblSeeAlso_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblSeeAlso:push';
end;//Tkw_AACContainer_Control_lblSeeAlso_Push.GetWordNameForRegister

type
  Tkw_AACContainer_Control_pnLinkToContent = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnLinkToContent
----
*Пример использования*:
[code]
контрол::pnLinkToContent TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AACContainer_Control_pnLinkToContent

// start class Tkw_AACContainer_Control_pnLinkToContent

class function Tkw_AACContainer_Control_pnLinkToContent.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnLinkToContent';
end;//Tkw_AACContainer_Control_pnLinkToContent.GetWordNameForRegister

function Tkw_AACContainer_Control_pnLinkToContent.GetString: AnsiString;
 {-}
begin
 Result := 'pnLinkToContent';
end;//Tkw_AACContainer_Control_pnLinkToContent.GetString

class procedure Tkw_AACContainer_Control_pnLinkToContent.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnLinkToContent.RegisterInEngine

type
  Tkw_AACContainer_Control_pnLinkToContent_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnLinkToContent
----
*Пример использования*:
[code]
контрол::pnLinkToContent:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AACContainer_Control_pnLinkToContent_Push

// start class Tkw_AACContainer_Control_pnLinkToContent_Push

procedure Tkw_AACContainer_Control_pnLinkToContent_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnLinkToContent');
 inherited;
end;//Tkw_AACContainer_Control_pnLinkToContent_Push.DoDoIt

class function Tkw_AACContainer_Control_pnLinkToContent_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnLinkToContent:push';
end;//Tkw_AACContainer_Control_pnLinkToContent_Push.GetWordNameForRegister

type
  Tkw_AACContainer_Control_pbLinkToContent = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pbLinkToContent
----
*Пример использования*:
[code]
контрол::pbLinkToContent TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AACContainer_Control_pbLinkToContent

// start class Tkw_AACContainer_Control_pbLinkToContent

class function Tkw_AACContainer_Control_pbLinkToContent.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pbLinkToContent';
end;//Tkw_AACContainer_Control_pbLinkToContent.GetWordNameForRegister

function Tkw_AACContainer_Control_pbLinkToContent.GetString: AnsiString;
 {-}
begin
 Result := 'pbLinkToContent';
end;//Tkw_AACContainer_Control_pbLinkToContent.GetString

class procedure Tkw_AACContainer_Control_pbLinkToContent.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_AACContainer_Control_pbLinkToContent.RegisterInEngine

type
  Tkw_AACContainer_Control_pbLinkToContent_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pbLinkToContent
----
*Пример использования*:
[code]
контрол::pbLinkToContent:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AACContainer_Control_pbLinkToContent_Push

// start class Tkw_AACContainer_Control_pbLinkToContent_Push

procedure Tkw_AACContainer_Control_pbLinkToContent_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pbLinkToContent');
 inherited;
end;//Tkw_AACContainer_Control_pbLinkToContent_Push.DoDoIt

class function Tkw_AACContainer_Control_pbLinkToContent_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pbLinkToContent:push';
end;//Tkw_AACContainer_Control_pbLinkToContent_Push.GetWordNameForRegister

type
  Tkw_AACContainer_Control_pnBack = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnBack
----
*Пример использования*:
[code]
контрол::pnBack TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AACContainer_Control_pnBack

// start class Tkw_AACContainer_Control_pnBack

class function Tkw_AACContainer_Control_pnBack.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnBack';
end;//Tkw_AACContainer_Control_pnBack.GetWordNameForRegister

function Tkw_AACContainer_Control_pnBack.GetString: AnsiString;
 {-}
begin
 Result := 'pnBack';
end;//Tkw_AACContainer_Control_pnBack.GetString

class procedure Tkw_AACContainer_Control_pnBack.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_AACContainer_Control_pnBack.RegisterInEngine

type
  Tkw_AACContainer_Control_pnBack_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnBack
----
*Пример использования*:
[code]
контрол::pnBack:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AACContainer_Control_pnBack_Push

// start class Tkw_AACContainer_Control_pnBack_Push

procedure Tkw_AACContainer_Control_pnBack_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnBack');
 inherited;
end;//Tkw_AACContainer_Control_pnBack_Push.DoDoIt

class function Tkw_AACContainer_Control_pnBack_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnBack:push';
end;//Tkw_AACContainer_Control_pnBack_Push.GetWordNameForRegister

type
  Tkw_AACContainer_Control_pnRightEx = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnRightEx
----
*Пример использования*:
[code]
контрол::pnRightEx TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AACContainer_Control_pnRightEx

// start class Tkw_AACContainer_Control_pnRightEx

class function Tkw_AACContainer_Control_pnRightEx.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnRightEx';
end;//Tkw_AACContainer_Control_pnRightEx.GetWordNameForRegister

function Tkw_AACContainer_Control_pnRightEx.GetString: AnsiString;
 {-}
begin
 Result := 'pnRightEx';
end;//Tkw_AACContainer_Control_pnRightEx.GetString

class procedure Tkw_AACContainer_Control_pnRightEx.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnRightEx.RegisterInEngine

type
  Tkw_AACContainer_Control_pnRightEx_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnRightEx
----
*Пример использования*:
[code]
контрол::pnRightEx:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AACContainer_Control_pnRightEx_Push

// start class Tkw_AACContainer_Control_pnRightEx_Push

procedure Tkw_AACContainer_Control_pnRightEx_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnRightEx');
 inherited;
end;//Tkw_AACContainer_Control_pnRightEx_Push.DoDoIt

class function Tkw_AACContainer_Control_pnRightEx_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnRightEx:push';
end;//Tkw_AACContainer_Control_pnRightEx_Push.GetWordNameForRegister

type
  Tkw_AACContainer_Control_pnRightForScroll = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnRightForScroll
----
*Пример использования*:
[code]
контрол::pnRightForScroll TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AACContainer_Control_pnRightForScroll

// start class Tkw_AACContainer_Control_pnRightForScroll

class function Tkw_AACContainer_Control_pnRightForScroll.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnRightForScroll';
end;//Tkw_AACContainer_Control_pnRightForScroll.GetWordNameForRegister

function Tkw_AACContainer_Control_pnRightForScroll.GetString: AnsiString;
 {-}
begin
 Result := 'pnRightForScroll';
end;//Tkw_AACContainer_Control_pnRightForScroll.GetString

class procedure Tkw_AACContainer_Control_pnRightForScroll.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnRightForScroll.RegisterInEngine

type
  Tkw_AACContainer_Control_pnRightForScroll_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnRightForScroll
----
*Пример использования*:
[code]
контрол::pnRightForScroll:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AACContainer_Control_pnRightForScroll_Push

// start class Tkw_AACContainer_Control_pnRightForScroll_Push

procedure Tkw_AACContainer_Control_pnRightForScroll_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnRightForScroll');
 inherited;
end;//Tkw_AACContainer_Control_pnRightForScroll_Push.DoDoIt

class function Tkw_AACContainer_Control_pnRightForScroll_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnRightForScroll:push';
end;//Tkw_AACContainer_Control_pnRightForScroll_Push.GetWordNameForRegister

type
  Tkw_AACContainer_Control_pnRight = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnRight
----
*Пример использования*:
[code]
контрол::pnRight TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AACContainer_Control_pnRight

// start class Tkw_AACContainer_Control_pnRight

class function Tkw_AACContainer_Control_pnRight.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnRight';
end;//Tkw_AACContainer_Control_pnRight.GetWordNameForRegister

function Tkw_AACContainer_Control_pnRight.GetString: AnsiString;
 {-}
begin
 Result := 'pnRight';
end;//Tkw_AACContainer_Control_pnRight.GetString

class procedure Tkw_AACContainer_Control_pnRight.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnRight.RegisterInEngine

type
  Tkw_AACContainer_Control_pnRight_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnRight
----
*Пример использования*:
[code]
контрол::pnRight:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AACContainer_Control_pnRight_Push

// start class Tkw_AACContainer_Control_pnRight_Push

procedure Tkw_AACContainer_Control_pnRight_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnRight');
 inherited;
end;//Tkw_AACContainer_Control_pnRight_Push.DoDoIt

class function Tkw_AACContainer_Control_pnRight_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnRight:push';
end;//Tkw_AACContainer_Control_pnRight_Push.GetWordNameForRegister

type
  Tkw_AACContainer_Control_pnlRightTop = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnlRightTop
----
*Пример использования*:
[code]
контрол::pnlRightTop TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AACContainer_Control_pnlRightTop

// start class Tkw_AACContainer_Control_pnlRightTop

class function Tkw_AACContainer_Control_pnlRightTop.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnlRightTop';
end;//Tkw_AACContainer_Control_pnlRightTop.GetWordNameForRegister

function Tkw_AACContainer_Control_pnlRightTop.GetString: AnsiString;
 {-}
begin
 Result := 'pnlRightTop';
end;//Tkw_AACContainer_Control_pnlRightTop.GetString

class procedure Tkw_AACContainer_Control_pnlRightTop.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnlRightTop.RegisterInEngine

type
  Tkw_AACContainer_Control_pnlRightTop_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnlRightTop
----
*Пример использования*:
[code]
контрол::pnlRightTop:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AACContainer_Control_pnlRightTop_Push

// start class Tkw_AACContainer_Control_pnlRightTop_Push

procedure Tkw_AACContainer_Control_pnlRightTop_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlRightTop');
 inherited;
end;//Tkw_AACContainer_Control_pnlRightTop_Push.DoDoIt

class function Tkw_AACContainer_Control_pnlRightTop_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnlRightTop:push';
end;//Tkw_AACContainer_Control_pnlRightTop_Push.GetWordNameForRegister

type
  Tkw_AACContainer_Control_scrRight = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола scrRight
----
*Пример использования*:
[code]
контрол::scrRight TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AACContainer_Control_scrRight

// start class Tkw_AACContainer_Control_scrRight

class function Tkw_AACContainer_Control_scrRight.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::scrRight';
end;//Tkw_AACContainer_Control_scrRight.GetWordNameForRegister

function Tkw_AACContainer_Control_scrRight.GetString: AnsiString;
 {-}
begin
 Result := 'scrRight';
end;//Tkw_AACContainer_Control_scrRight.GetString

class procedure Tkw_AACContainer_Control_scrRight.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtScrollBar);
end;//Tkw_AACContainer_Control_scrRight.RegisterInEngine

type
  Tkw_AACContainer_Control_scrRight_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола scrRight
----
*Пример использования*:
[code]
контрол::scrRight:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AACContainer_Control_scrRight_Push

// start class Tkw_AACContainer_Control_scrRight_Push

procedure Tkw_AACContainer_Control_scrRight_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('scrRight');
 inherited;
end;//Tkw_AACContainer_Control_scrRight_Push.DoDoIt

class function Tkw_AACContainer_Control_scrRight_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::scrRight:push';
end;//Tkw_AACContainer_Control_scrRight_Push.GetWordNameForRegister

type
  Tkw_AACContainer_Control_pnLeftEx = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnLeftEx
----
*Пример использования*:
[code]
контрол::pnLeftEx TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AACContainer_Control_pnLeftEx

// start class Tkw_AACContainer_Control_pnLeftEx

class function Tkw_AACContainer_Control_pnLeftEx.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnLeftEx';
end;//Tkw_AACContainer_Control_pnLeftEx.GetWordNameForRegister

function Tkw_AACContainer_Control_pnLeftEx.GetString: AnsiString;
 {-}
begin
 Result := 'pnLeftEx';
end;//Tkw_AACContainer_Control_pnLeftEx.GetString

class procedure Tkw_AACContainer_Control_pnLeftEx.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_AACContainer_Control_pnLeftEx.RegisterInEngine

type
  Tkw_AACContainer_Control_pnLeftEx_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnLeftEx
----
*Пример использования*:
[code]
контрол::pnLeftEx:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AACContainer_Control_pnLeftEx_Push

// start class Tkw_AACContainer_Control_pnLeftEx_Push

procedure Tkw_AACContainer_Control_pnLeftEx_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnLeftEx');
 inherited;
end;//Tkw_AACContainer_Control_pnLeftEx_Push.DoDoIt

class function Tkw_AACContainer_Control_pnLeftEx_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnLeftEx:push';
end;//Tkw_AACContainer_Control_pnLeftEx_Push.GetWordNameForRegister

type
  Tkw_AACContainer_Control_pnLeftForScroll = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnLeftForScroll
----
*Пример использования*:
[code]
контрол::pnLeftForScroll TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AACContainer_Control_pnLeftForScroll

// start class Tkw_AACContainer_Control_pnLeftForScroll

class function Tkw_AACContainer_Control_pnLeftForScroll.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnLeftForScroll';
end;//Tkw_AACContainer_Control_pnLeftForScroll.GetWordNameForRegister

function Tkw_AACContainer_Control_pnLeftForScroll.GetString: AnsiString;
 {-}
begin
 Result := 'pnLeftForScroll';
end;//Tkw_AACContainer_Control_pnLeftForScroll.GetString

class procedure Tkw_AACContainer_Control_pnLeftForScroll.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnLeftForScroll.RegisterInEngine

type
  Tkw_AACContainer_Control_pnLeftForScroll_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnLeftForScroll
----
*Пример использования*:
[code]
контрол::pnLeftForScroll:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AACContainer_Control_pnLeftForScroll_Push

// start class Tkw_AACContainer_Control_pnLeftForScroll_Push

procedure Tkw_AACContainer_Control_pnLeftForScroll_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnLeftForScroll');
 inherited;
end;//Tkw_AACContainer_Control_pnLeftForScroll_Push.DoDoIt

class function Tkw_AACContainer_Control_pnLeftForScroll_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnLeftForScroll:push';
end;//Tkw_AACContainer_Control_pnLeftForScroll_Push.GetWordNameForRegister

type
  Tkw_AACContainer_Control_pnlLeftTop = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnlLeftTop
----
*Пример использования*:
[code]
контрол::pnlLeftTop TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AACContainer_Control_pnlLeftTop

// start class Tkw_AACContainer_Control_pnlLeftTop

class function Tkw_AACContainer_Control_pnlLeftTop.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnlLeftTop';
end;//Tkw_AACContainer_Control_pnlLeftTop.GetWordNameForRegister

function Tkw_AACContainer_Control_pnlLeftTop.GetString: AnsiString;
 {-}
begin
 Result := 'pnlLeftTop';
end;//Tkw_AACContainer_Control_pnlLeftTop.GetString

class procedure Tkw_AACContainer_Control_pnlLeftTop.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnlLeftTop.RegisterInEngine

type
  Tkw_AACContainer_Control_pnlLeftTop_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnlLeftTop
----
*Пример использования*:
[code]
контрол::pnlLeftTop:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AACContainer_Control_pnlLeftTop_Push

// start class Tkw_AACContainer_Control_pnlLeftTop_Push

procedure Tkw_AACContainer_Control_pnlLeftTop_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlLeftTop');
 inherited;
end;//Tkw_AACContainer_Control_pnlLeftTop_Push.DoDoIt

class function Tkw_AACContainer_Control_pnlLeftTop_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnlLeftTop:push';
end;//Tkw_AACContainer_Control_pnlLeftTop_Push.GetWordNameForRegister

type
  Tkw_AACContainer_Control_pnLeft = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnLeft
----
*Пример использования*:
[code]
контрол::pnLeft TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AACContainer_Control_pnLeft

// start class Tkw_AACContainer_Control_pnLeft

class function Tkw_AACContainer_Control_pnLeft.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnLeft';
end;//Tkw_AACContainer_Control_pnLeft.GetWordNameForRegister

function Tkw_AACContainer_Control_pnLeft.GetString: AnsiString;
 {-}
begin
 Result := 'pnLeft';
end;//Tkw_AACContainer_Control_pnLeft.GetString

class procedure Tkw_AACContainer_Control_pnLeft.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnLeft.RegisterInEngine

type
  Tkw_AACContainer_Control_pnLeft_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnLeft
----
*Пример использования*:
[code]
контрол::pnLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AACContainer_Control_pnLeft_Push

// start class Tkw_AACContainer_Control_pnLeft_Push

procedure Tkw_AACContainer_Control_pnLeft_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnLeft');
 inherited;
end;//Tkw_AACContainer_Control_pnLeft_Push.DoDoIt

class function Tkw_AACContainer_Control_pnLeft_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnLeft:push';
end;//Tkw_AACContainer_Control_pnLeft_Push.GetWordNameForRegister

type
  Tkw_AACContainer_Control_scrLeft = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола scrLeft
----
*Пример использования*:
[code]
контрол::scrLeft TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_AACContainer_Control_scrLeft

// start class Tkw_AACContainer_Control_scrLeft

class function Tkw_AACContainer_Control_scrLeft.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::scrLeft';
end;//Tkw_AACContainer_Control_scrLeft.GetWordNameForRegister

function Tkw_AACContainer_Control_scrLeft.GetString: AnsiString;
 {-}
begin
 Result := 'scrLeft';
end;//Tkw_AACContainer_Control_scrLeft.GetString

class procedure Tkw_AACContainer_Control_scrLeft.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtScrollBar);
end;//Tkw_AACContainer_Control_scrLeft.RegisterInEngine

type
  Tkw_AACContainer_Control_scrLeft_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола scrLeft
----
*Пример использования*:
[code]
контрол::scrLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_AACContainer_Control_scrLeft_Push

// start class Tkw_AACContainer_Control_scrLeft_Push

procedure Tkw_AACContainer_Control_scrLeft_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('scrLeft');
 inherited;
end;//Tkw_AACContainer_Control_scrLeft_Push.DoDoIt

class function Tkw_AACContainer_Control_scrLeft_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::scrLeft:push';
end;//Tkw_AACContainer_Control_scrLeft_Push.GetWordNameForRegister

type
  TkwAACContainerFormPnWriteToUs = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContainerForm.pnWriteToUs
[panel]Контрол pnWriteToUs формы TAACContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnWriteToUs >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnWriteToUs(const aCtx: TtfwContext;
     aAACContainerForm: TAACContainerForm): TvtPanel;
     {* Реализация слова скрипта .TAACContainerForm.pnWriteToUs }
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
  end;//TkwAACContainerFormPnWriteToUs

// start class TkwAACContainerFormPnWriteToUs

function TkwAACContainerFormPnWriteToUs.PnWriteToUs(const aCtx: TtfwContext;
  aAACContainerForm: TAACContainerForm): TvtPanel;
 {-}
begin
 Result := aAACContainerForm.pnWriteToUs;
end;//TkwAACContainerFormPnWriteToUs.PnWriteToUs

procedure TkwAACContainerFormPnWriteToUs.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContainerForm : TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnWriteToUs(aCtx, l_aAACContainerForm)));
end;//TkwAACContainerFormPnWriteToUs.DoDoIt

class function TkwAACContainerFormPnWriteToUs.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContainerForm.pnWriteToUs';
end;//TkwAACContainerFormPnWriteToUs.GetWordNameForRegister

procedure TkwAACContainerFormPnWriteToUs.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnWriteToUs', aCtx);
end;//TkwAACContainerFormPnWriteToUs.SetValuePrim

function TkwAACContainerFormPnWriteToUs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnWriteToUs.GetResultTypeInfo

function TkwAACContainerFormPnWriteToUs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContainerFormPnWriteToUs.GetAllParamsCount

function TkwAACContainerFormPnWriteToUs.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnWriteToUs.ParamsTypes

type
  TkwAACContainerFormEdWriteToUs = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContainerForm.edWriteToUs
[panel]Контрол edWriteToUs формы TAACContainerForm[panel]
*Тип результата:* TnscSimpleEditorForDialogs
*Пример:*
[code]
OBJECT VAR l_TnscSimpleEditorForDialogs
 aAACContainerForm .TAACContainerForm.edWriteToUs >>> l_TnscSimpleEditorForDialogs
[code]  }
  private
  // private methods
   function EdWriteToUs(const aCtx: TtfwContext;
     aAACContainerForm: TAACContainerForm): TnscSimpleEditorForDialogs;
     {* Реализация слова скрипта .TAACContainerForm.edWriteToUs }
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
  end;//TkwAACContainerFormEdWriteToUs

// start class TkwAACContainerFormEdWriteToUs

function TkwAACContainerFormEdWriteToUs.EdWriteToUs(const aCtx: TtfwContext;
  aAACContainerForm: TAACContainerForm): TnscSimpleEditorForDialogs;
 {-}
begin
 Result := aAACContainerForm.edWriteToUs;
end;//TkwAACContainerFormEdWriteToUs.EdWriteToUs

procedure TkwAACContainerFormEdWriteToUs.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContainerForm : TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EdWriteToUs(aCtx, l_aAACContainerForm)));
end;//TkwAACContainerFormEdWriteToUs.DoDoIt

class function TkwAACContainerFormEdWriteToUs.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContainerForm.edWriteToUs';
end;//TkwAACContainerFormEdWriteToUs.GetWordNameForRegister

procedure TkwAACContainerFormEdWriteToUs.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству edWriteToUs', aCtx);
end;//TkwAACContainerFormEdWriteToUs.SetValuePrim

function TkwAACContainerFormEdWriteToUs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscSimpleEditorForDialogs);
end;//TkwAACContainerFormEdWriteToUs.GetResultTypeInfo

function TkwAACContainerFormEdWriteToUs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContainerFormEdWriteToUs.GetAllParamsCount

function TkwAACContainerFormEdWriteToUs.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormEdWriteToUs.ParamsTypes

type
  TkwAACContainerFormPnSeeAlso = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContainerForm.pnSeeAlso
[panel]Контрол pnSeeAlso формы TAACContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnSeeAlso >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnSeeAlso(const aCtx: TtfwContext;
     aAACContainerForm: TAACContainerForm): TvtPanel;
     {* Реализация слова скрипта .TAACContainerForm.pnSeeAlso }
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
  end;//TkwAACContainerFormPnSeeAlso

// start class TkwAACContainerFormPnSeeAlso

function TkwAACContainerFormPnSeeAlso.PnSeeAlso(const aCtx: TtfwContext;
  aAACContainerForm: TAACContainerForm): TvtPanel;
 {-}
begin
 Result := aAACContainerForm.pnSeeAlso;
end;//TkwAACContainerFormPnSeeAlso.PnSeeAlso

procedure TkwAACContainerFormPnSeeAlso.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContainerForm : TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnSeeAlso(aCtx, l_aAACContainerForm)));
end;//TkwAACContainerFormPnSeeAlso.DoDoIt

class function TkwAACContainerFormPnSeeAlso.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContainerForm.pnSeeAlso';
end;//TkwAACContainerFormPnSeeAlso.GetWordNameForRegister

procedure TkwAACContainerFormPnSeeAlso.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnSeeAlso', aCtx);
end;//TkwAACContainerFormPnSeeAlso.SetValuePrim

function TkwAACContainerFormPnSeeAlso.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnSeeAlso.GetResultTypeInfo

function TkwAACContainerFormPnSeeAlso.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContainerFormPnSeeAlso.GetAllParamsCount

function TkwAACContainerFormPnSeeAlso.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnSeeAlso.ParamsTypes

type
  TkwAACContainerFormLblSeeAlso = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContainerForm.lblSeeAlso
[panel]Контрол lblSeeAlso формы TAACContainerForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aAACContainerForm .TAACContainerForm.lblSeeAlso >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LblSeeAlso(const aCtx: TtfwContext;
     aAACContainerForm: TAACContainerForm): TvtLabel;
     {* Реализация слова скрипта .TAACContainerForm.lblSeeAlso }
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
  end;//TkwAACContainerFormLblSeeAlso

// start class TkwAACContainerFormLblSeeAlso

function TkwAACContainerFormLblSeeAlso.LblSeeAlso(const aCtx: TtfwContext;
  aAACContainerForm: TAACContainerForm): TvtLabel;
 {-}
begin
 Result := aAACContainerForm.lblSeeAlso;
end;//TkwAACContainerFormLblSeeAlso.LblSeeAlso

procedure TkwAACContainerFormLblSeeAlso.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContainerForm : TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LblSeeAlso(aCtx, l_aAACContainerForm)));
end;//TkwAACContainerFormLblSeeAlso.DoDoIt

class function TkwAACContainerFormLblSeeAlso.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContainerForm.lblSeeAlso';
end;//TkwAACContainerFormLblSeeAlso.GetWordNameForRegister

procedure TkwAACContainerFormLblSeeAlso.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblSeeAlso', aCtx);
end;//TkwAACContainerFormLblSeeAlso.SetValuePrim

function TkwAACContainerFormLblSeeAlso.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwAACContainerFormLblSeeAlso.GetResultTypeInfo

function TkwAACContainerFormLblSeeAlso.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContainerFormLblSeeAlso.GetAllParamsCount

function TkwAACContainerFormLblSeeAlso.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormLblSeeAlso.ParamsTypes

type
  TkwAACContainerFormPnLinkToContent = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContainerForm.pnLinkToContent
[panel]Контрол pnLinkToContent формы TAACContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnLinkToContent >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnLinkToContent(const aCtx: TtfwContext;
     aAACContainerForm: TAACContainerForm): TvtPanel;
     {* Реализация слова скрипта .TAACContainerForm.pnLinkToContent }
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
  end;//TkwAACContainerFormPnLinkToContent

// start class TkwAACContainerFormPnLinkToContent

function TkwAACContainerFormPnLinkToContent.PnLinkToContent(const aCtx: TtfwContext;
  aAACContainerForm: TAACContainerForm): TvtPanel;
 {-}
begin
 Result := aAACContainerForm.pnLinkToContent;
end;//TkwAACContainerFormPnLinkToContent.PnLinkToContent

procedure TkwAACContainerFormPnLinkToContent.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContainerForm : TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnLinkToContent(aCtx, l_aAACContainerForm)));
end;//TkwAACContainerFormPnLinkToContent.DoDoIt

class function TkwAACContainerFormPnLinkToContent.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContainerForm.pnLinkToContent';
end;//TkwAACContainerFormPnLinkToContent.GetWordNameForRegister

procedure TkwAACContainerFormPnLinkToContent.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnLinkToContent', aCtx);
end;//TkwAACContainerFormPnLinkToContent.SetValuePrim

function TkwAACContainerFormPnLinkToContent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnLinkToContent.GetResultTypeInfo

function TkwAACContainerFormPnLinkToContent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContainerFormPnLinkToContent.GetAllParamsCount

function TkwAACContainerFormPnLinkToContent.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnLinkToContent.ParamsTypes

type
  TkwAACContainerFormPbLinkToContent = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContainerForm.pbLinkToContent
[panel]Контрол pbLinkToContent формы TAACContainerForm[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aAACContainerForm .TAACContainerForm.pbLinkToContent >>> l_TPaintBox
[code]  }
  private
  // private methods
   function PbLinkToContent(const aCtx: TtfwContext;
     aAACContainerForm: TAACContainerForm): TPaintBox;
     {* Реализация слова скрипта .TAACContainerForm.pbLinkToContent }
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
  end;//TkwAACContainerFormPbLinkToContent

// start class TkwAACContainerFormPbLinkToContent

function TkwAACContainerFormPbLinkToContent.PbLinkToContent(const aCtx: TtfwContext;
  aAACContainerForm: TAACContainerForm): TPaintBox;
 {-}
begin
 Result := aAACContainerForm.pbLinkToContent;
end;//TkwAACContainerFormPbLinkToContent.PbLinkToContent

procedure TkwAACContainerFormPbLinkToContent.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContainerForm : TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PbLinkToContent(aCtx, l_aAACContainerForm)));
end;//TkwAACContainerFormPbLinkToContent.DoDoIt

class function TkwAACContainerFormPbLinkToContent.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContainerForm.pbLinkToContent';
end;//TkwAACContainerFormPbLinkToContent.GetWordNameForRegister

procedure TkwAACContainerFormPbLinkToContent.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pbLinkToContent', aCtx);
end;//TkwAACContainerFormPbLinkToContent.SetValuePrim

function TkwAACContainerFormPbLinkToContent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TPaintBox);
end;//TkwAACContainerFormPbLinkToContent.GetResultTypeInfo

function TkwAACContainerFormPbLinkToContent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContainerFormPbLinkToContent.GetAllParamsCount

function TkwAACContainerFormPbLinkToContent.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPbLinkToContent.ParamsTypes

type
  TkwAACContainerFormPnBack = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContainerForm.pnBack
[panel]Контрол pnBack формы TAACContainerForm[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aAACContainerForm .TAACContainerForm.pnBack >>> l_TvtProportionalPanel
[code]  }
  private
  // private methods
   function PnBack(const aCtx: TtfwContext;
     aAACContainerForm: TAACContainerForm): TvtProportionalPanel;
     {* Реализация слова скрипта .TAACContainerForm.pnBack }
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
  end;//TkwAACContainerFormPnBack

// start class TkwAACContainerFormPnBack

function TkwAACContainerFormPnBack.PnBack(const aCtx: TtfwContext;
  aAACContainerForm: TAACContainerForm): TvtProportionalPanel;
 {-}
begin
 Result := aAACContainerForm.pnBack;
end;//TkwAACContainerFormPnBack.PnBack

procedure TkwAACContainerFormPnBack.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContainerForm : TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnBack(aCtx, l_aAACContainerForm)));
end;//TkwAACContainerFormPnBack.DoDoIt

class function TkwAACContainerFormPnBack.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContainerForm.pnBack';
end;//TkwAACContainerFormPnBack.GetWordNameForRegister

procedure TkwAACContainerFormPnBack.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnBack', aCtx);
end;//TkwAACContainerFormPnBack.SetValuePrim

function TkwAACContainerFormPnBack.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwAACContainerFormPnBack.GetResultTypeInfo

function TkwAACContainerFormPnBack.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContainerFormPnBack.GetAllParamsCount

function TkwAACContainerFormPnBack.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnBack.ParamsTypes

type
  TkwAACContainerFormPnRightEx = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContainerForm.pnRightEx
[panel]Контрол pnRightEx формы TAACContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnRightEx >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnRightEx(const aCtx: TtfwContext;
     aAACContainerForm: TAACContainerForm): TvtPanel;
     {* Реализация слова скрипта .TAACContainerForm.pnRightEx }
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
  end;//TkwAACContainerFormPnRightEx

// start class TkwAACContainerFormPnRightEx

function TkwAACContainerFormPnRightEx.PnRightEx(const aCtx: TtfwContext;
  aAACContainerForm: TAACContainerForm): TvtPanel;
 {-}
begin
 Result := aAACContainerForm.pnRightEx;
end;//TkwAACContainerFormPnRightEx.PnRightEx

procedure TkwAACContainerFormPnRightEx.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContainerForm : TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnRightEx(aCtx, l_aAACContainerForm)));
end;//TkwAACContainerFormPnRightEx.DoDoIt

class function TkwAACContainerFormPnRightEx.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContainerForm.pnRightEx';
end;//TkwAACContainerFormPnRightEx.GetWordNameForRegister

procedure TkwAACContainerFormPnRightEx.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnRightEx', aCtx);
end;//TkwAACContainerFormPnRightEx.SetValuePrim

function TkwAACContainerFormPnRightEx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnRightEx.GetResultTypeInfo

function TkwAACContainerFormPnRightEx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContainerFormPnRightEx.GetAllParamsCount

function TkwAACContainerFormPnRightEx.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnRightEx.ParamsTypes

type
  TkwAACContainerFormPnRightForScroll = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContainerForm.pnRightForScroll
[panel]Контрол pnRightForScroll формы TAACContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnRightForScroll >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnRightForScroll(const aCtx: TtfwContext;
     aAACContainerForm: TAACContainerForm): TvtPanel;
     {* Реализация слова скрипта .TAACContainerForm.pnRightForScroll }
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
  end;//TkwAACContainerFormPnRightForScroll

// start class TkwAACContainerFormPnRightForScroll

function TkwAACContainerFormPnRightForScroll.PnRightForScroll(const aCtx: TtfwContext;
  aAACContainerForm: TAACContainerForm): TvtPanel;
 {-}
begin
 Result := aAACContainerForm.pnRightForScroll;
end;//TkwAACContainerFormPnRightForScroll.PnRightForScroll

procedure TkwAACContainerFormPnRightForScroll.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContainerForm : TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnRightForScroll(aCtx, l_aAACContainerForm)));
end;//TkwAACContainerFormPnRightForScroll.DoDoIt

class function TkwAACContainerFormPnRightForScroll.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContainerForm.pnRightForScroll';
end;//TkwAACContainerFormPnRightForScroll.GetWordNameForRegister

procedure TkwAACContainerFormPnRightForScroll.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnRightForScroll', aCtx);
end;//TkwAACContainerFormPnRightForScroll.SetValuePrim

function TkwAACContainerFormPnRightForScroll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnRightForScroll.GetResultTypeInfo

function TkwAACContainerFormPnRightForScroll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContainerFormPnRightForScroll.GetAllParamsCount

function TkwAACContainerFormPnRightForScroll.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnRightForScroll.ParamsTypes

type
  TkwAACContainerFormPnRight = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContainerForm.pnRight
[panel]Контрол pnRight формы TAACContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnRight >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnRight(const aCtx: TtfwContext;
     aAACContainerForm: TAACContainerForm): TvtPanel;
     {* Реализация слова скрипта .TAACContainerForm.pnRight }
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
  end;//TkwAACContainerFormPnRight

// start class TkwAACContainerFormPnRight

function TkwAACContainerFormPnRight.PnRight(const aCtx: TtfwContext;
  aAACContainerForm: TAACContainerForm): TvtPanel;
 {-}
begin
 Result := aAACContainerForm.pnRight;
end;//TkwAACContainerFormPnRight.PnRight

procedure TkwAACContainerFormPnRight.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContainerForm : TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnRight(aCtx, l_aAACContainerForm)));
end;//TkwAACContainerFormPnRight.DoDoIt

class function TkwAACContainerFormPnRight.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContainerForm.pnRight';
end;//TkwAACContainerFormPnRight.GetWordNameForRegister

procedure TkwAACContainerFormPnRight.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnRight', aCtx);
end;//TkwAACContainerFormPnRight.SetValuePrim

function TkwAACContainerFormPnRight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnRight.GetResultTypeInfo

function TkwAACContainerFormPnRight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContainerFormPnRight.GetAllParamsCount

function TkwAACContainerFormPnRight.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnRight.ParamsTypes

type
  TkwAACContainerFormPnlRightTop = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContainerForm.pnlRightTop
[panel]Контрол pnlRightTop формы TAACContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnlRightTop >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlRightTop(const aCtx: TtfwContext;
     aAACContainerForm: TAACContainerForm): TvtPanel;
     {* Реализация слова скрипта .TAACContainerForm.pnlRightTop }
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
  end;//TkwAACContainerFormPnlRightTop

// start class TkwAACContainerFormPnlRightTop

function TkwAACContainerFormPnlRightTop.PnlRightTop(const aCtx: TtfwContext;
  aAACContainerForm: TAACContainerForm): TvtPanel;
 {-}
begin
 Result := aAACContainerForm.pnlRightTop;
end;//TkwAACContainerFormPnlRightTop.PnlRightTop

procedure TkwAACContainerFormPnlRightTop.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContainerForm : TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlRightTop(aCtx, l_aAACContainerForm)));
end;//TkwAACContainerFormPnlRightTop.DoDoIt

class function TkwAACContainerFormPnlRightTop.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContainerForm.pnlRightTop';
end;//TkwAACContainerFormPnlRightTop.GetWordNameForRegister

procedure TkwAACContainerFormPnlRightTop.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlRightTop', aCtx);
end;//TkwAACContainerFormPnlRightTop.SetValuePrim

function TkwAACContainerFormPnlRightTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnlRightTop.GetResultTypeInfo

function TkwAACContainerFormPnlRightTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContainerFormPnlRightTop.GetAllParamsCount

function TkwAACContainerFormPnlRightTop.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnlRightTop.ParamsTypes

type
  TkwAACContainerFormScrRight = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContainerForm.scrRight
[panel]Контрол scrRight формы TAACContainerForm[panel]
*Тип результата:* TvtScrollBar
*Пример:*
[code]
OBJECT VAR l_TvtScrollBar
 aAACContainerForm .TAACContainerForm.scrRight >>> l_TvtScrollBar
[code]  }
  private
  // private methods
   function ScrRight(const aCtx: TtfwContext;
     aAACContainerForm: TAACContainerForm): TvtScrollBar;
     {* Реализация слова скрипта .TAACContainerForm.scrRight }
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
  end;//TkwAACContainerFormScrRight

// start class TkwAACContainerFormScrRight

function TkwAACContainerFormScrRight.ScrRight(const aCtx: TtfwContext;
  aAACContainerForm: TAACContainerForm): TvtScrollBar;
 {-}
begin
 Result := aAACContainerForm.scrRight;
end;//TkwAACContainerFormScrRight.ScrRight

procedure TkwAACContainerFormScrRight.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContainerForm : TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ScrRight(aCtx, l_aAACContainerForm)));
end;//TkwAACContainerFormScrRight.DoDoIt

class function TkwAACContainerFormScrRight.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContainerForm.scrRight';
end;//TkwAACContainerFormScrRight.GetWordNameForRegister

procedure TkwAACContainerFormScrRight.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству scrRight', aCtx);
end;//TkwAACContainerFormScrRight.SetValuePrim

function TkwAACContainerFormScrRight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtScrollBar);
end;//TkwAACContainerFormScrRight.GetResultTypeInfo

function TkwAACContainerFormScrRight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContainerFormScrRight.GetAllParamsCount

function TkwAACContainerFormScrRight.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormScrRight.ParamsTypes

type
  TkwAACContainerFormPnLeftEx = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContainerForm.pnLeftEx
[panel]Контрол pnLeftEx формы TAACContainerForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aAACContainerForm .TAACContainerForm.pnLeftEx >>> l_TvtSizeablePanel
[code]  }
  private
  // private methods
   function PnLeftEx(const aCtx: TtfwContext;
     aAACContainerForm: TAACContainerForm): TvtSizeablePanel;
     {* Реализация слова скрипта .TAACContainerForm.pnLeftEx }
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
  end;//TkwAACContainerFormPnLeftEx

// start class TkwAACContainerFormPnLeftEx

function TkwAACContainerFormPnLeftEx.PnLeftEx(const aCtx: TtfwContext;
  aAACContainerForm: TAACContainerForm): TvtSizeablePanel;
 {-}
begin
 Result := aAACContainerForm.pnLeftEx;
end;//TkwAACContainerFormPnLeftEx.PnLeftEx

procedure TkwAACContainerFormPnLeftEx.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContainerForm : TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnLeftEx(aCtx, l_aAACContainerForm)));
end;//TkwAACContainerFormPnLeftEx.DoDoIt

class function TkwAACContainerFormPnLeftEx.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContainerForm.pnLeftEx';
end;//TkwAACContainerFormPnLeftEx.GetWordNameForRegister

procedure TkwAACContainerFormPnLeftEx.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnLeftEx', aCtx);
end;//TkwAACContainerFormPnLeftEx.SetValuePrim

function TkwAACContainerFormPnLeftEx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwAACContainerFormPnLeftEx.GetResultTypeInfo

function TkwAACContainerFormPnLeftEx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContainerFormPnLeftEx.GetAllParamsCount

function TkwAACContainerFormPnLeftEx.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnLeftEx.ParamsTypes

type
  TkwAACContainerFormPnLeftForScroll = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContainerForm.pnLeftForScroll
[panel]Контрол pnLeftForScroll формы TAACContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnLeftForScroll >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnLeftForScroll(const aCtx: TtfwContext;
     aAACContainerForm: TAACContainerForm): TvtPanel;
     {* Реализация слова скрипта .TAACContainerForm.pnLeftForScroll }
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
  end;//TkwAACContainerFormPnLeftForScroll

// start class TkwAACContainerFormPnLeftForScroll

function TkwAACContainerFormPnLeftForScroll.PnLeftForScroll(const aCtx: TtfwContext;
  aAACContainerForm: TAACContainerForm): TvtPanel;
 {-}
begin
 Result := aAACContainerForm.pnLeftForScroll;
end;//TkwAACContainerFormPnLeftForScroll.PnLeftForScroll

procedure TkwAACContainerFormPnLeftForScroll.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContainerForm : TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnLeftForScroll(aCtx, l_aAACContainerForm)));
end;//TkwAACContainerFormPnLeftForScroll.DoDoIt

class function TkwAACContainerFormPnLeftForScroll.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContainerForm.pnLeftForScroll';
end;//TkwAACContainerFormPnLeftForScroll.GetWordNameForRegister

procedure TkwAACContainerFormPnLeftForScroll.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnLeftForScroll', aCtx);
end;//TkwAACContainerFormPnLeftForScroll.SetValuePrim

function TkwAACContainerFormPnLeftForScroll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnLeftForScroll.GetResultTypeInfo

function TkwAACContainerFormPnLeftForScroll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContainerFormPnLeftForScroll.GetAllParamsCount

function TkwAACContainerFormPnLeftForScroll.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnLeftForScroll.ParamsTypes

type
  TkwAACContainerFormPnlLeftTop = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContainerForm.pnlLeftTop
[panel]Контрол pnlLeftTop формы TAACContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnlLeftTop >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlLeftTop(const aCtx: TtfwContext;
     aAACContainerForm: TAACContainerForm): TvtPanel;
     {* Реализация слова скрипта .TAACContainerForm.pnlLeftTop }
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
  end;//TkwAACContainerFormPnlLeftTop

// start class TkwAACContainerFormPnlLeftTop

function TkwAACContainerFormPnlLeftTop.PnlLeftTop(const aCtx: TtfwContext;
  aAACContainerForm: TAACContainerForm): TvtPanel;
 {-}
begin
 Result := aAACContainerForm.pnlLeftTop;
end;//TkwAACContainerFormPnlLeftTop.PnlLeftTop

procedure TkwAACContainerFormPnlLeftTop.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContainerForm : TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlLeftTop(aCtx, l_aAACContainerForm)));
end;//TkwAACContainerFormPnlLeftTop.DoDoIt

class function TkwAACContainerFormPnlLeftTop.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContainerForm.pnlLeftTop';
end;//TkwAACContainerFormPnlLeftTop.GetWordNameForRegister

procedure TkwAACContainerFormPnlLeftTop.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlLeftTop', aCtx);
end;//TkwAACContainerFormPnlLeftTop.SetValuePrim

function TkwAACContainerFormPnlLeftTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnlLeftTop.GetResultTypeInfo

function TkwAACContainerFormPnlLeftTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContainerFormPnlLeftTop.GetAllParamsCount

function TkwAACContainerFormPnlLeftTop.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnlLeftTop.ParamsTypes

type
  TkwAACContainerFormPnLeft = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContainerForm.pnLeft
[panel]Контрол pnLeft формы TAACContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnLeft >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnLeft(const aCtx: TtfwContext;
     aAACContainerForm: TAACContainerForm): TvtPanel;
     {* Реализация слова скрипта .TAACContainerForm.pnLeft }
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
  end;//TkwAACContainerFormPnLeft

// start class TkwAACContainerFormPnLeft

function TkwAACContainerFormPnLeft.PnLeft(const aCtx: TtfwContext;
  aAACContainerForm: TAACContainerForm): TvtPanel;
 {-}
begin
 Result := aAACContainerForm.pnLeft;
end;//TkwAACContainerFormPnLeft.PnLeft

procedure TkwAACContainerFormPnLeft.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContainerForm : TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnLeft(aCtx, l_aAACContainerForm)));
end;//TkwAACContainerFormPnLeft.DoDoIt

class function TkwAACContainerFormPnLeft.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContainerForm.pnLeft';
end;//TkwAACContainerFormPnLeft.GetWordNameForRegister

procedure TkwAACContainerFormPnLeft.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnLeft', aCtx);
end;//TkwAACContainerFormPnLeft.SetValuePrim

function TkwAACContainerFormPnLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnLeft.GetResultTypeInfo

function TkwAACContainerFormPnLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContainerFormPnLeft.GetAllParamsCount

function TkwAACContainerFormPnLeft.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnLeft.ParamsTypes

type
  TkwAACContainerFormScrLeft = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContainerForm.scrLeft
[panel]Контрол scrLeft формы TAACContainerForm[panel]
*Тип результата:* TvtScrollBar
*Пример:*
[code]
OBJECT VAR l_TvtScrollBar
 aAACContainerForm .TAACContainerForm.scrLeft >>> l_TvtScrollBar
[code]  }
  private
  // private methods
   function ScrLeft(const aCtx: TtfwContext;
     aAACContainerForm: TAACContainerForm): TvtScrollBar;
     {* Реализация слова скрипта .TAACContainerForm.scrLeft }
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
  end;//TkwAACContainerFormScrLeft

// start class TkwAACContainerFormScrLeft

function TkwAACContainerFormScrLeft.ScrLeft(const aCtx: TtfwContext;
  aAACContainerForm: TAACContainerForm): TvtScrollBar;
 {-}
begin
 Result := aAACContainerForm.scrLeft;
end;//TkwAACContainerFormScrLeft.ScrLeft

procedure TkwAACContainerFormScrLeft.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContainerForm : TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ScrLeft(aCtx, l_aAACContainerForm)));
end;//TkwAACContainerFormScrLeft.DoDoIt

class function TkwAACContainerFormScrLeft.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContainerForm.scrLeft';
end;//TkwAACContainerFormScrLeft.GetWordNameForRegister

procedure TkwAACContainerFormScrLeft.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству scrLeft', aCtx);
end;//TkwAACContainerFormScrLeft.SetValuePrim

function TkwAACContainerFormScrLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtScrollBar);
end;//TkwAACContainerFormScrLeft.GetResultTypeInfo

function TkwAACContainerFormScrLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContainerFormScrLeft.GetAllParamsCount

function TkwAACContainerFormScrLeft.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormScrLeft.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_AACContainer
 Tkw_Form_AACContainer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnWriteToUs
 Tkw_AACContainer_Control_pnWriteToUs.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnWriteToUs_Push
 Tkw_AACContainer_Control_pnWriteToUs_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_edWriteToUs
 Tkw_AACContainer_Control_edWriteToUs.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_edWriteToUs_Push
 Tkw_AACContainer_Control_edWriteToUs_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnSeeAlso
 Tkw_AACContainer_Control_pnSeeAlso.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnSeeAlso_Push
 Tkw_AACContainer_Control_pnSeeAlso_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_lblSeeAlso
 Tkw_AACContainer_Control_lblSeeAlso.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_lblSeeAlso_Push
 Tkw_AACContainer_Control_lblSeeAlso_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnLinkToContent
 Tkw_AACContainer_Control_pnLinkToContent.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnLinkToContent_Push
 Tkw_AACContainer_Control_pnLinkToContent_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pbLinkToContent
 Tkw_AACContainer_Control_pbLinkToContent.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pbLinkToContent_Push
 Tkw_AACContainer_Control_pbLinkToContent_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnBack
 Tkw_AACContainer_Control_pnBack.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnBack_Push
 Tkw_AACContainer_Control_pnBack_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnRightEx
 Tkw_AACContainer_Control_pnRightEx.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnRightEx_Push
 Tkw_AACContainer_Control_pnRightEx_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnRightForScroll
 Tkw_AACContainer_Control_pnRightForScroll.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnRightForScroll_Push
 Tkw_AACContainer_Control_pnRightForScroll_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnRight
 Tkw_AACContainer_Control_pnRight.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnRight_Push
 Tkw_AACContainer_Control_pnRight_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnlRightTop
 Tkw_AACContainer_Control_pnlRightTop.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnlRightTop_Push
 Tkw_AACContainer_Control_pnlRightTop_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_scrRight
 Tkw_AACContainer_Control_scrRight.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_scrRight_Push
 Tkw_AACContainer_Control_scrRight_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnLeftEx
 Tkw_AACContainer_Control_pnLeftEx.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnLeftEx_Push
 Tkw_AACContainer_Control_pnLeftEx_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnLeftForScroll
 Tkw_AACContainer_Control_pnLeftForScroll.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnLeftForScroll_Push
 Tkw_AACContainer_Control_pnLeftForScroll_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnlLeftTop
 Tkw_AACContainer_Control_pnlLeftTop.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnlLeftTop_Push
 Tkw_AACContainer_Control_pnlLeftTop_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnLeft
 Tkw_AACContainer_Control_pnLeft.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_pnLeft_Push
 Tkw_AACContainer_Control_pnLeft_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_scrLeft
 Tkw_AACContainer_Control_scrLeft.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContainer_Control_scrLeft_Push
 Tkw_AACContainer_Control_scrLeft_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContainerForm_pnWriteToUs
 TkwAACContainerFormPnWriteToUs.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContainerForm_edWriteToUs
 TkwAACContainerFormEdWriteToUs.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContainerForm_pnSeeAlso
 TkwAACContainerFormPnSeeAlso.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContainerForm_lblSeeAlso
 TkwAACContainerFormLblSeeAlso.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContainerForm_pnLinkToContent
 TkwAACContainerFormPnLinkToContent.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContainerForm_pbLinkToContent
 TkwAACContainerFormPbLinkToContent.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContainerForm_pnBack
 TkwAACContainerFormPnBack.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContainerForm_pnRightEx
 TkwAACContainerFormPnRightEx.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContainerForm_pnRightForScroll
 TkwAACContainerFormPnRightForScroll.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContainerForm_pnRight
 TkwAACContainerFormPnRight.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContainerForm_pnlRightTop
 TkwAACContainerFormPnlRightTop.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContainerForm_scrRight
 TkwAACContainerFormScrRight.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContainerForm_pnLeftEx
 TkwAACContainerFormPnLeftEx.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContainerForm_pnLeftForScroll
 TkwAACContainerFormPnLeftForScroll.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContainerForm_pnlLeftTop
 TkwAACContainerFormPnlLeftTop.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContainerForm_pnLeft
 TkwAACContainerFormPnLeft.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContainerForm_scrLeft
 TkwAACContainerFormScrLeft.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа AACContainer
 TtfwTypeRegistrator.RegisterType(TypeInfo(TAACContainerForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscSimpleEditorForDialogs
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscSimpleEditorForDialogs));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TPaintBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtProportionalPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtScrollBar
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtScrollBar));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtSizeablePanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.