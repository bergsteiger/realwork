unit AACContentsContainerKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/AAC/AACContentsContainerKeywordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Пользовательские сервисы::AAC::View::AAC::AACPrim::AACContentsContainerKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы AACContentsContainer
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
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  AACContentsContainer_Form,
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
  Tkw_Form_AACContentsContainer = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы AACContentsContainer
----
*Пример использования*:
[code]
'aControl' форма::AACContentsContainer TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_AACContentsContainer

// start class Tkw_Form_AACContentsContainer

class function Tkw_Form_AACContentsContainer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::AACContentsContainer';
end;//Tkw_Form_AACContentsContainer.GetWordNameForRegister

function Tkw_Form_AACContentsContainer.GetString: AnsiString;
 {-}
begin
 Result := 'AACContentsContainerForm';
end;//Tkw_Form_AACContentsContainer.GetString

type
  Tkw_AACContentsContainer_Control_pnBack = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_AACContentsContainer_Control_pnBack

// start class Tkw_AACContentsContainer_Control_pnBack

class function Tkw_AACContentsContainer_Control_pnBack.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnBack';
end;//Tkw_AACContentsContainer_Control_pnBack.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnBack.GetString: AnsiString;
 {-}
begin
 Result := 'pnBack';
end;//Tkw_AACContentsContainer_Control_pnBack.GetString

class procedure Tkw_AACContentsContainer_Control_pnBack.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_AACContentsContainer_Control_pnBack.RegisterInEngine

type
  Tkw_AACContentsContainer_Control_pnBack_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_AACContentsContainer_Control_pnBack_Push

// start class Tkw_AACContentsContainer_Control_pnBack_Push

procedure Tkw_AACContentsContainer_Control_pnBack_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnBack');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnBack_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnBack_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnBack:push';
end;//Tkw_AACContentsContainer_Control_pnBack_Push.GetWordNameForRegister

type
  Tkw_AACContentsContainer_Control_pnRightEx = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_AACContentsContainer_Control_pnRightEx

// start class Tkw_AACContentsContainer_Control_pnRightEx

class function Tkw_AACContentsContainer_Control_pnRightEx.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnRightEx';
end;//Tkw_AACContentsContainer_Control_pnRightEx.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnRightEx.GetString: AnsiString;
 {-}
begin
 Result := 'pnRightEx';
end;//Tkw_AACContentsContainer_Control_pnRightEx.GetString

class procedure Tkw_AACContentsContainer_Control_pnRightEx.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnRightEx.RegisterInEngine

type
  Tkw_AACContentsContainer_Control_pnRightEx_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_AACContentsContainer_Control_pnRightEx_Push

// start class Tkw_AACContentsContainer_Control_pnRightEx_Push

procedure Tkw_AACContentsContainer_Control_pnRightEx_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnRightEx');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnRightEx_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnRightEx_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnRightEx:push';
end;//Tkw_AACContentsContainer_Control_pnRightEx_Push.GetWordNameForRegister

type
  Tkw_AACContentsContainer_Control_pnRightForScroll = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_AACContentsContainer_Control_pnRightForScroll

// start class Tkw_AACContentsContainer_Control_pnRightForScroll

class function Tkw_AACContentsContainer_Control_pnRightForScroll.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnRightForScroll';
end;//Tkw_AACContentsContainer_Control_pnRightForScroll.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnRightForScroll.GetString: AnsiString;
 {-}
begin
 Result := 'pnRightForScroll';
end;//Tkw_AACContentsContainer_Control_pnRightForScroll.GetString

class procedure Tkw_AACContentsContainer_Control_pnRightForScroll.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnRightForScroll.RegisterInEngine

type
  Tkw_AACContentsContainer_Control_pnRightForScroll_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_AACContentsContainer_Control_pnRightForScroll_Push

// start class Tkw_AACContentsContainer_Control_pnRightForScroll_Push

procedure Tkw_AACContentsContainer_Control_pnRightForScroll_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnRightForScroll');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnRightForScroll_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnRightForScroll_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnRightForScroll:push';
end;//Tkw_AACContentsContainer_Control_pnRightForScroll_Push.GetWordNameForRegister

type
  Tkw_AACContentsContainer_Control_pnRight = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_AACContentsContainer_Control_pnRight

// start class Tkw_AACContentsContainer_Control_pnRight

class function Tkw_AACContentsContainer_Control_pnRight.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnRight';
end;//Tkw_AACContentsContainer_Control_pnRight.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnRight.GetString: AnsiString;
 {-}
begin
 Result := 'pnRight';
end;//Tkw_AACContentsContainer_Control_pnRight.GetString

class procedure Tkw_AACContentsContainer_Control_pnRight.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnRight.RegisterInEngine

type
  Tkw_AACContentsContainer_Control_pnRight_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_AACContentsContainer_Control_pnRight_Push

// start class Tkw_AACContentsContainer_Control_pnRight_Push

procedure Tkw_AACContentsContainer_Control_pnRight_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnRight');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnRight_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnRight_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnRight:push';
end;//Tkw_AACContentsContainer_Control_pnRight_Push.GetWordNameForRegister

type
  Tkw_AACContentsContainer_Control_pnlRightTop = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_AACContentsContainer_Control_pnlRightTop

// start class Tkw_AACContentsContainer_Control_pnlRightTop

class function Tkw_AACContentsContainer_Control_pnlRightTop.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnlRightTop';
end;//Tkw_AACContentsContainer_Control_pnlRightTop.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnlRightTop.GetString: AnsiString;
 {-}
begin
 Result := 'pnlRightTop';
end;//Tkw_AACContentsContainer_Control_pnlRightTop.GetString

class procedure Tkw_AACContentsContainer_Control_pnlRightTop.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnlRightTop.RegisterInEngine

type
  Tkw_AACContentsContainer_Control_pnlRightTop_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_AACContentsContainer_Control_pnlRightTop_Push

// start class Tkw_AACContentsContainer_Control_pnlRightTop_Push

procedure Tkw_AACContentsContainer_Control_pnlRightTop_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlRightTop');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnlRightTop_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnlRightTop_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnlRightTop:push';
end;//Tkw_AACContentsContainer_Control_pnlRightTop_Push.GetWordNameForRegister

type
  Tkw_AACContentsContainer_Control_scrRight = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_AACContentsContainer_Control_scrRight

// start class Tkw_AACContentsContainer_Control_scrRight

class function Tkw_AACContentsContainer_Control_scrRight.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::scrRight';
end;//Tkw_AACContentsContainer_Control_scrRight.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_scrRight.GetString: AnsiString;
 {-}
begin
 Result := 'scrRight';
end;//Tkw_AACContentsContainer_Control_scrRight.GetString

class procedure Tkw_AACContentsContainer_Control_scrRight.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtScrollBar);
end;//Tkw_AACContentsContainer_Control_scrRight.RegisterInEngine

type
  Tkw_AACContentsContainer_Control_scrRight_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_AACContentsContainer_Control_scrRight_Push

// start class Tkw_AACContentsContainer_Control_scrRight_Push

procedure Tkw_AACContentsContainer_Control_scrRight_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('scrRight');
 inherited;
end;//Tkw_AACContentsContainer_Control_scrRight_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_scrRight_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::scrRight:push';
end;//Tkw_AACContentsContainer_Control_scrRight_Push.GetWordNameForRegister

type
  Tkw_AACContentsContainer_Control_pnLeftEx = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_AACContentsContainer_Control_pnLeftEx

// start class Tkw_AACContentsContainer_Control_pnLeftEx

class function Tkw_AACContentsContainer_Control_pnLeftEx.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnLeftEx';
end;//Tkw_AACContentsContainer_Control_pnLeftEx.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnLeftEx.GetString: AnsiString;
 {-}
begin
 Result := 'pnLeftEx';
end;//Tkw_AACContentsContainer_Control_pnLeftEx.GetString

class procedure Tkw_AACContentsContainer_Control_pnLeftEx.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_AACContentsContainer_Control_pnLeftEx.RegisterInEngine

type
  Tkw_AACContentsContainer_Control_pnLeftEx_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_AACContentsContainer_Control_pnLeftEx_Push

// start class Tkw_AACContentsContainer_Control_pnLeftEx_Push

procedure Tkw_AACContentsContainer_Control_pnLeftEx_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnLeftEx');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnLeftEx_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnLeftEx_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnLeftEx:push';
end;//Tkw_AACContentsContainer_Control_pnLeftEx_Push.GetWordNameForRegister

type
  Tkw_AACContentsContainer_Control_pnLeftForScroll = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_AACContentsContainer_Control_pnLeftForScroll

// start class Tkw_AACContentsContainer_Control_pnLeftForScroll

class function Tkw_AACContentsContainer_Control_pnLeftForScroll.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnLeftForScroll';
end;//Tkw_AACContentsContainer_Control_pnLeftForScroll.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnLeftForScroll.GetString: AnsiString;
 {-}
begin
 Result := 'pnLeftForScroll';
end;//Tkw_AACContentsContainer_Control_pnLeftForScroll.GetString

class procedure Tkw_AACContentsContainer_Control_pnLeftForScroll.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnLeftForScroll.RegisterInEngine

type
  Tkw_AACContentsContainer_Control_pnLeftForScroll_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_AACContentsContainer_Control_pnLeftForScroll_Push

// start class Tkw_AACContentsContainer_Control_pnLeftForScroll_Push

procedure Tkw_AACContentsContainer_Control_pnLeftForScroll_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnLeftForScroll');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnLeftForScroll_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnLeftForScroll_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnLeftForScroll:push';
end;//Tkw_AACContentsContainer_Control_pnLeftForScroll_Push.GetWordNameForRegister

type
  Tkw_AACContentsContainer_Control_pnlLeftTop = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_AACContentsContainer_Control_pnlLeftTop

// start class Tkw_AACContentsContainer_Control_pnlLeftTop

class function Tkw_AACContentsContainer_Control_pnlLeftTop.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnlLeftTop';
end;//Tkw_AACContentsContainer_Control_pnlLeftTop.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnlLeftTop.GetString: AnsiString;
 {-}
begin
 Result := 'pnlLeftTop';
end;//Tkw_AACContentsContainer_Control_pnlLeftTop.GetString

class procedure Tkw_AACContentsContainer_Control_pnlLeftTop.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnlLeftTop.RegisterInEngine

type
  Tkw_AACContentsContainer_Control_pnlLeftTop_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_AACContentsContainer_Control_pnlLeftTop_Push

// start class Tkw_AACContentsContainer_Control_pnlLeftTop_Push

procedure Tkw_AACContentsContainer_Control_pnlLeftTop_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlLeftTop');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnlLeftTop_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnlLeftTop_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnlLeftTop:push';
end;//Tkw_AACContentsContainer_Control_pnlLeftTop_Push.GetWordNameForRegister

type
  Tkw_AACContentsContainer_Control_pnLeft = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_AACContentsContainer_Control_pnLeft

// start class Tkw_AACContentsContainer_Control_pnLeft

class function Tkw_AACContentsContainer_Control_pnLeft.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnLeft';
end;//Tkw_AACContentsContainer_Control_pnLeft.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnLeft.GetString: AnsiString;
 {-}
begin
 Result := 'pnLeft';
end;//Tkw_AACContentsContainer_Control_pnLeft.GetString

class procedure Tkw_AACContentsContainer_Control_pnLeft.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnLeft.RegisterInEngine

type
  Tkw_AACContentsContainer_Control_pnLeft_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_AACContentsContainer_Control_pnLeft_Push

// start class Tkw_AACContentsContainer_Control_pnLeft_Push

procedure Tkw_AACContentsContainer_Control_pnLeft_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnLeft');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnLeft_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnLeft_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnLeft:push';
end;//Tkw_AACContentsContainer_Control_pnLeft_Push.GetWordNameForRegister

type
  Tkw_AACContentsContainer_Control_scrLeft = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_AACContentsContainer_Control_scrLeft

// start class Tkw_AACContentsContainer_Control_scrLeft

class function Tkw_AACContentsContainer_Control_scrLeft.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::scrLeft';
end;//Tkw_AACContentsContainer_Control_scrLeft.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_scrLeft.GetString: AnsiString;
 {-}
begin
 Result := 'scrLeft';
end;//Tkw_AACContentsContainer_Control_scrLeft.GetString

class procedure Tkw_AACContentsContainer_Control_scrLeft.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtScrollBar);
end;//Tkw_AACContentsContainer_Control_scrLeft.RegisterInEngine

type
  Tkw_AACContentsContainer_Control_scrLeft_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_AACContentsContainer_Control_scrLeft_Push

// start class Tkw_AACContentsContainer_Control_scrLeft_Push

procedure Tkw_AACContentsContainer_Control_scrLeft_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('scrLeft');
 inherited;
end;//Tkw_AACContentsContainer_Control_scrLeft_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_scrLeft_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::scrLeft:push';
end;//Tkw_AACContentsContainer_Control_scrLeft_Push.GetWordNameForRegister

type
  TkwAACContentsContainerFormPnBack = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContentsContainerForm.pnBack
[panel]Контрол pnBack формы TAACContentsContainerForm[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aAACContentsContainerForm .TAACContentsContainerForm.pnBack >>> l_TvtProportionalPanel
[code]  }
  private
  // private methods
   function PnBack(const aCtx: TtfwContext;
     aAACContentsContainerForm: TAACContentsContainerForm): TvtProportionalPanel;
     {* Реализация слова скрипта .TAACContentsContainerForm.pnBack }
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
  end;//TkwAACContentsContainerFormPnBack

// start class TkwAACContentsContainerFormPnBack

function TkwAACContentsContainerFormPnBack.PnBack(const aCtx: TtfwContext;
  aAACContentsContainerForm: TAACContentsContainerForm): TvtProportionalPanel;
 {-}
begin
 Result := aAACContentsContainerForm.pnBack;
end;//TkwAACContentsContainerFormPnBack.PnBack

procedure TkwAACContentsContainerFormPnBack.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContentsContainerForm : TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnBack(aCtx, l_aAACContentsContainerForm)));
end;//TkwAACContentsContainerFormPnBack.DoDoIt

class function TkwAACContentsContainerFormPnBack.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContentsContainerForm.pnBack';
end;//TkwAACContentsContainerFormPnBack.GetWordNameForRegister

procedure TkwAACContentsContainerFormPnBack.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnBack', aCtx);
end;//TkwAACContentsContainerFormPnBack.SetValuePrim

function TkwAACContentsContainerFormPnBack.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwAACContentsContainerFormPnBack.GetResultTypeInfo

function TkwAACContentsContainerFormPnBack.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContentsContainerFormPnBack.GetAllParamsCount

function TkwAACContentsContainerFormPnBack.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnBack.ParamsTypes

type
  TkwAACContentsContainerFormPnRightEx = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContentsContainerForm.pnRightEx
[panel]Контрол pnRightEx формы TAACContentsContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContentsContainerForm .TAACContentsContainerForm.pnRightEx >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnRightEx(const aCtx: TtfwContext;
     aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
     {* Реализация слова скрипта .TAACContentsContainerForm.pnRightEx }
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
  end;//TkwAACContentsContainerFormPnRightEx

// start class TkwAACContentsContainerFormPnRightEx

function TkwAACContentsContainerFormPnRightEx.PnRightEx(const aCtx: TtfwContext;
  aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {-}
begin
 Result := aAACContentsContainerForm.pnRightEx;
end;//TkwAACContentsContainerFormPnRightEx.PnRightEx

procedure TkwAACContentsContainerFormPnRightEx.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContentsContainerForm : TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnRightEx(aCtx, l_aAACContentsContainerForm)));
end;//TkwAACContentsContainerFormPnRightEx.DoDoIt

class function TkwAACContentsContainerFormPnRightEx.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContentsContainerForm.pnRightEx';
end;//TkwAACContentsContainerFormPnRightEx.GetWordNameForRegister

procedure TkwAACContentsContainerFormPnRightEx.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnRightEx', aCtx);
end;//TkwAACContentsContainerFormPnRightEx.SetValuePrim

function TkwAACContentsContainerFormPnRightEx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnRightEx.GetResultTypeInfo

function TkwAACContentsContainerFormPnRightEx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContentsContainerFormPnRightEx.GetAllParamsCount

function TkwAACContentsContainerFormPnRightEx.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnRightEx.ParamsTypes

type
  TkwAACContentsContainerFormPnRightForScroll = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContentsContainerForm.pnRightForScroll
[panel]Контрол pnRightForScroll формы TAACContentsContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContentsContainerForm .TAACContentsContainerForm.pnRightForScroll >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnRightForScroll(const aCtx: TtfwContext;
     aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
     {* Реализация слова скрипта .TAACContentsContainerForm.pnRightForScroll }
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
  end;//TkwAACContentsContainerFormPnRightForScroll

// start class TkwAACContentsContainerFormPnRightForScroll

function TkwAACContentsContainerFormPnRightForScroll.PnRightForScroll(const aCtx: TtfwContext;
  aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {-}
begin
 Result := aAACContentsContainerForm.pnRightForScroll;
end;//TkwAACContentsContainerFormPnRightForScroll.PnRightForScroll

procedure TkwAACContentsContainerFormPnRightForScroll.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContentsContainerForm : TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnRightForScroll(aCtx, l_aAACContentsContainerForm)));
end;//TkwAACContentsContainerFormPnRightForScroll.DoDoIt

class function TkwAACContentsContainerFormPnRightForScroll.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContentsContainerForm.pnRightForScroll';
end;//TkwAACContentsContainerFormPnRightForScroll.GetWordNameForRegister

procedure TkwAACContentsContainerFormPnRightForScroll.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnRightForScroll', aCtx);
end;//TkwAACContentsContainerFormPnRightForScroll.SetValuePrim

function TkwAACContentsContainerFormPnRightForScroll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnRightForScroll.GetResultTypeInfo

function TkwAACContentsContainerFormPnRightForScroll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContentsContainerFormPnRightForScroll.GetAllParamsCount

function TkwAACContentsContainerFormPnRightForScroll.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnRightForScroll.ParamsTypes

type
  TkwAACContentsContainerFormPnRight = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContentsContainerForm.pnRight
[panel]Контрол pnRight формы TAACContentsContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContentsContainerForm .TAACContentsContainerForm.pnRight >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnRight(const aCtx: TtfwContext;
     aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
     {* Реализация слова скрипта .TAACContentsContainerForm.pnRight }
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
  end;//TkwAACContentsContainerFormPnRight

// start class TkwAACContentsContainerFormPnRight

function TkwAACContentsContainerFormPnRight.PnRight(const aCtx: TtfwContext;
  aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {-}
begin
 Result := aAACContentsContainerForm.pnRight;
end;//TkwAACContentsContainerFormPnRight.PnRight

procedure TkwAACContentsContainerFormPnRight.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContentsContainerForm : TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnRight(aCtx, l_aAACContentsContainerForm)));
end;//TkwAACContentsContainerFormPnRight.DoDoIt

class function TkwAACContentsContainerFormPnRight.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContentsContainerForm.pnRight';
end;//TkwAACContentsContainerFormPnRight.GetWordNameForRegister

procedure TkwAACContentsContainerFormPnRight.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnRight', aCtx);
end;//TkwAACContentsContainerFormPnRight.SetValuePrim

function TkwAACContentsContainerFormPnRight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnRight.GetResultTypeInfo

function TkwAACContentsContainerFormPnRight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContentsContainerFormPnRight.GetAllParamsCount

function TkwAACContentsContainerFormPnRight.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnRight.ParamsTypes

type
  TkwAACContentsContainerFormPnlRightTop = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContentsContainerForm.pnlRightTop
[panel]Контрол pnlRightTop формы TAACContentsContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContentsContainerForm .TAACContentsContainerForm.pnlRightTop >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlRightTop(const aCtx: TtfwContext;
     aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
     {* Реализация слова скрипта .TAACContentsContainerForm.pnlRightTop }
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
  end;//TkwAACContentsContainerFormPnlRightTop

// start class TkwAACContentsContainerFormPnlRightTop

function TkwAACContentsContainerFormPnlRightTop.PnlRightTop(const aCtx: TtfwContext;
  aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {-}
begin
 Result := aAACContentsContainerForm.pnlRightTop;
end;//TkwAACContentsContainerFormPnlRightTop.PnlRightTop

procedure TkwAACContentsContainerFormPnlRightTop.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContentsContainerForm : TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlRightTop(aCtx, l_aAACContentsContainerForm)));
end;//TkwAACContentsContainerFormPnlRightTop.DoDoIt

class function TkwAACContentsContainerFormPnlRightTop.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContentsContainerForm.pnlRightTop';
end;//TkwAACContentsContainerFormPnlRightTop.GetWordNameForRegister

procedure TkwAACContentsContainerFormPnlRightTop.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlRightTop', aCtx);
end;//TkwAACContentsContainerFormPnlRightTop.SetValuePrim

function TkwAACContentsContainerFormPnlRightTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnlRightTop.GetResultTypeInfo

function TkwAACContentsContainerFormPnlRightTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContentsContainerFormPnlRightTop.GetAllParamsCount

function TkwAACContentsContainerFormPnlRightTop.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnlRightTop.ParamsTypes

type
  TkwAACContentsContainerFormScrRight = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContentsContainerForm.scrRight
[panel]Контрол scrRight формы TAACContentsContainerForm[panel]
*Тип результата:* TvtScrollBar
*Пример:*
[code]
OBJECT VAR l_TvtScrollBar
 aAACContentsContainerForm .TAACContentsContainerForm.scrRight >>> l_TvtScrollBar
[code]  }
  private
  // private methods
   function ScrRight(const aCtx: TtfwContext;
     aAACContentsContainerForm: TAACContentsContainerForm): TvtScrollBar;
     {* Реализация слова скрипта .TAACContentsContainerForm.scrRight }
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
  end;//TkwAACContentsContainerFormScrRight

// start class TkwAACContentsContainerFormScrRight

function TkwAACContentsContainerFormScrRight.ScrRight(const aCtx: TtfwContext;
  aAACContentsContainerForm: TAACContentsContainerForm): TvtScrollBar;
 {-}
begin
 Result := aAACContentsContainerForm.scrRight;
end;//TkwAACContentsContainerFormScrRight.ScrRight

procedure TkwAACContentsContainerFormScrRight.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContentsContainerForm : TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ScrRight(aCtx, l_aAACContentsContainerForm)));
end;//TkwAACContentsContainerFormScrRight.DoDoIt

class function TkwAACContentsContainerFormScrRight.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContentsContainerForm.scrRight';
end;//TkwAACContentsContainerFormScrRight.GetWordNameForRegister

procedure TkwAACContentsContainerFormScrRight.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству scrRight', aCtx);
end;//TkwAACContentsContainerFormScrRight.SetValuePrim

function TkwAACContentsContainerFormScrRight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtScrollBar);
end;//TkwAACContentsContainerFormScrRight.GetResultTypeInfo

function TkwAACContentsContainerFormScrRight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContentsContainerFormScrRight.GetAllParamsCount

function TkwAACContentsContainerFormScrRight.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormScrRight.ParamsTypes

type
  TkwAACContentsContainerFormPnLeftEx = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContentsContainerForm.pnLeftEx
[panel]Контрол pnLeftEx формы TAACContentsContainerForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aAACContentsContainerForm .TAACContentsContainerForm.pnLeftEx >>> l_TvtSizeablePanel
[code]  }
  private
  // private methods
   function PnLeftEx(const aCtx: TtfwContext;
     aAACContentsContainerForm: TAACContentsContainerForm): TvtSizeablePanel;
     {* Реализация слова скрипта .TAACContentsContainerForm.pnLeftEx }
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
  end;//TkwAACContentsContainerFormPnLeftEx

// start class TkwAACContentsContainerFormPnLeftEx

function TkwAACContentsContainerFormPnLeftEx.PnLeftEx(const aCtx: TtfwContext;
  aAACContentsContainerForm: TAACContentsContainerForm): TvtSizeablePanel;
 {-}
begin
 Result := aAACContentsContainerForm.pnLeftEx;
end;//TkwAACContentsContainerFormPnLeftEx.PnLeftEx

procedure TkwAACContentsContainerFormPnLeftEx.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContentsContainerForm : TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnLeftEx(aCtx, l_aAACContentsContainerForm)));
end;//TkwAACContentsContainerFormPnLeftEx.DoDoIt

class function TkwAACContentsContainerFormPnLeftEx.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContentsContainerForm.pnLeftEx';
end;//TkwAACContentsContainerFormPnLeftEx.GetWordNameForRegister

procedure TkwAACContentsContainerFormPnLeftEx.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnLeftEx', aCtx);
end;//TkwAACContentsContainerFormPnLeftEx.SetValuePrim

function TkwAACContentsContainerFormPnLeftEx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwAACContentsContainerFormPnLeftEx.GetResultTypeInfo

function TkwAACContentsContainerFormPnLeftEx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContentsContainerFormPnLeftEx.GetAllParamsCount

function TkwAACContentsContainerFormPnLeftEx.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnLeftEx.ParamsTypes

type
  TkwAACContentsContainerFormPnLeftForScroll = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContentsContainerForm.pnLeftForScroll
[panel]Контрол pnLeftForScroll формы TAACContentsContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContentsContainerForm .TAACContentsContainerForm.pnLeftForScroll >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnLeftForScroll(const aCtx: TtfwContext;
     aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
     {* Реализация слова скрипта .TAACContentsContainerForm.pnLeftForScroll }
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
  end;//TkwAACContentsContainerFormPnLeftForScroll

// start class TkwAACContentsContainerFormPnLeftForScroll

function TkwAACContentsContainerFormPnLeftForScroll.PnLeftForScroll(const aCtx: TtfwContext;
  aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {-}
begin
 Result := aAACContentsContainerForm.pnLeftForScroll;
end;//TkwAACContentsContainerFormPnLeftForScroll.PnLeftForScroll

procedure TkwAACContentsContainerFormPnLeftForScroll.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContentsContainerForm : TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnLeftForScroll(aCtx, l_aAACContentsContainerForm)));
end;//TkwAACContentsContainerFormPnLeftForScroll.DoDoIt

class function TkwAACContentsContainerFormPnLeftForScroll.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContentsContainerForm.pnLeftForScroll';
end;//TkwAACContentsContainerFormPnLeftForScroll.GetWordNameForRegister

procedure TkwAACContentsContainerFormPnLeftForScroll.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnLeftForScroll', aCtx);
end;//TkwAACContentsContainerFormPnLeftForScroll.SetValuePrim

function TkwAACContentsContainerFormPnLeftForScroll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnLeftForScroll.GetResultTypeInfo

function TkwAACContentsContainerFormPnLeftForScroll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContentsContainerFormPnLeftForScroll.GetAllParamsCount

function TkwAACContentsContainerFormPnLeftForScroll.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnLeftForScroll.ParamsTypes

type
  TkwAACContentsContainerFormPnlLeftTop = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContentsContainerForm.pnlLeftTop
[panel]Контрол pnlLeftTop формы TAACContentsContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContentsContainerForm .TAACContentsContainerForm.pnlLeftTop >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlLeftTop(const aCtx: TtfwContext;
     aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
     {* Реализация слова скрипта .TAACContentsContainerForm.pnlLeftTop }
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
  end;//TkwAACContentsContainerFormPnlLeftTop

// start class TkwAACContentsContainerFormPnlLeftTop

function TkwAACContentsContainerFormPnlLeftTop.PnlLeftTop(const aCtx: TtfwContext;
  aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {-}
begin
 Result := aAACContentsContainerForm.pnlLeftTop;
end;//TkwAACContentsContainerFormPnlLeftTop.PnlLeftTop

procedure TkwAACContentsContainerFormPnlLeftTop.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContentsContainerForm : TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlLeftTop(aCtx, l_aAACContentsContainerForm)));
end;//TkwAACContentsContainerFormPnlLeftTop.DoDoIt

class function TkwAACContentsContainerFormPnlLeftTop.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContentsContainerForm.pnlLeftTop';
end;//TkwAACContentsContainerFormPnlLeftTop.GetWordNameForRegister

procedure TkwAACContentsContainerFormPnlLeftTop.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlLeftTop', aCtx);
end;//TkwAACContentsContainerFormPnlLeftTop.SetValuePrim

function TkwAACContentsContainerFormPnlLeftTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnlLeftTop.GetResultTypeInfo

function TkwAACContentsContainerFormPnlLeftTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContentsContainerFormPnlLeftTop.GetAllParamsCount

function TkwAACContentsContainerFormPnlLeftTop.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnlLeftTop.ParamsTypes

type
  TkwAACContentsContainerFormPnLeft = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContentsContainerForm.pnLeft
[panel]Контрол pnLeft формы TAACContentsContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContentsContainerForm .TAACContentsContainerForm.pnLeft >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnLeft(const aCtx: TtfwContext;
     aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
     {* Реализация слова скрипта .TAACContentsContainerForm.pnLeft }
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
  end;//TkwAACContentsContainerFormPnLeft

// start class TkwAACContentsContainerFormPnLeft

function TkwAACContentsContainerFormPnLeft.PnLeft(const aCtx: TtfwContext;
  aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {-}
begin
 Result := aAACContentsContainerForm.pnLeft;
end;//TkwAACContentsContainerFormPnLeft.PnLeft

procedure TkwAACContentsContainerFormPnLeft.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContentsContainerForm : TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnLeft(aCtx, l_aAACContentsContainerForm)));
end;//TkwAACContentsContainerFormPnLeft.DoDoIt

class function TkwAACContentsContainerFormPnLeft.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContentsContainerForm.pnLeft';
end;//TkwAACContentsContainerFormPnLeft.GetWordNameForRegister

procedure TkwAACContentsContainerFormPnLeft.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnLeft', aCtx);
end;//TkwAACContentsContainerFormPnLeft.SetValuePrim

function TkwAACContentsContainerFormPnLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnLeft.GetResultTypeInfo

function TkwAACContentsContainerFormPnLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContentsContainerFormPnLeft.GetAllParamsCount

function TkwAACContentsContainerFormPnLeft.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnLeft.ParamsTypes

type
  TkwAACContentsContainerFormScrLeft = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TAACContentsContainerForm.scrLeft
[panel]Контрол scrLeft формы TAACContentsContainerForm[panel]
*Тип результата:* TvtScrollBar
*Пример:*
[code]
OBJECT VAR l_TvtScrollBar
 aAACContentsContainerForm .TAACContentsContainerForm.scrLeft >>> l_TvtScrollBar
[code]  }
  private
  // private methods
   function ScrLeft(const aCtx: TtfwContext;
     aAACContentsContainerForm: TAACContentsContainerForm): TvtScrollBar;
     {* Реализация слова скрипта .TAACContentsContainerForm.scrLeft }
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
  end;//TkwAACContentsContainerFormScrLeft

// start class TkwAACContentsContainerFormScrLeft

function TkwAACContentsContainerFormScrLeft.ScrLeft(const aCtx: TtfwContext;
  aAACContentsContainerForm: TAACContentsContainerForm): TvtScrollBar;
 {-}
begin
 Result := aAACContentsContainerForm.scrLeft;
end;//TkwAACContentsContainerFormScrLeft.ScrLeft

procedure TkwAACContentsContainerFormScrLeft.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAACContentsContainerForm : TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ScrLeft(aCtx, l_aAACContentsContainerForm)));
end;//TkwAACContentsContainerFormScrLeft.DoDoIt

class function TkwAACContentsContainerFormScrLeft.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TAACContentsContainerForm.scrLeft';
end;//TkwAACContentsContainerFormScrLeft.GetWordNameForRegister

procedure TkwAACContentsContainerFormScrLeft.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству scrLeft', aCtx);
end;//TkwAACContentsContainerFormScrLeft.SetValuePrim

function TkwAACContentsContainerFormScrLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtScrollBar);
end;//TkwAACContentsContainerFormScrLeft.GetResultTypeInfo

function TkwAACContentsContainerFormScrLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwAACContentsContainerFormScrLeft.GetAllParamsCount

function TkwAACContentsContainerFormScrLeft.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormScrLeft.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_AACContentsContainer
 Tkw_Form_AACContentsContainer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_pnBack
 Tkw_AACContentsContainer_Control_pnBack.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_pnBack_Push
 Tkw_AACContentsContainer_Control_pnBack_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_pnRightEx
 Tkw_AACContentsContainer_Control_pnRightEx.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_pnRightEx_Push
 Tkw_AACContentsContainer_Control_pnRightEx_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_pnRightForScroll
 Tkw_AACContentsContainer_Control_pnRightForScroll.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_pnRightForScroll_Push
 Tkw_AACContentsContainer_Control_pnRightForScroll_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_pnRight
 Tkw_AACContentsContainer_Control_pnRight.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_pnRight_Push
 Tkw_AACContentsContainer_Control_pnRight_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_pnlRightTop
 Tkw_AACContentsContainer_Control_pnlRightTop.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_pnlRightTop_Push
 Tkw_AACContentsContainer_Control_pnlRightTop_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_scrRight
 Tkw_AACContentsContainer_Control_scrRight.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_scrRight_Push
 Tkw_AACContentsContainer_Control_scrRight_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_pnLeftEx
 Tkw_AACContentsContainer_Control_pnLeftEx.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_pnLeftEx_Push
 Tkw_AACContentsContainer_Control_pnLeftEx_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_pnLeftForScroll
 Tkw_AACContentsContainer_Control_pnLeftForScroll.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_pnLeftForScroll_Push
 Tkw_AACContentsContainer_Control_pnLeftForScroll_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_pnlLeftTop
 Tkw_AACContentsContainer_Control_pnlLeftTop.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_pnlLeftTop_Push
 Tkw_AACContentsContainer_Control_pnlLeftTop_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_pnLeft
 Tkw_AACContentsContainer_Control_pnLeft.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_pnLeft_Push
 Tkw_AACContentsContainer_Control_pnLeft_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_scrLeft
 Tkw_AACContentsContainer_Control_scrLeft.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_AACContentsContainer_Control_scrLeft_Push
 Tkw_AACContentsContainer_Control_scrLeft_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContentsContainerForm_pnBack
 TkwAACContentsContainerFormPnBack.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContentsContainerForm_pnRightEx
 TkwAACContentsContainerFormPnRightEx.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContentsContainerForm_pnRightForScroll
 TkwAACContentsContainerFormPnRightForScroll.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContentsContainerForm_pnRight
 TkwAACContentsContainerFormPnRight.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContentsContainerForm_pnlRightTop
 TkwAACContentsContainerFormPnlRightTop.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContentsContainerForm_scrRight
 TkwAACContentsContainerFormScrRight.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContentsContainerForm_pnLeftEx
 TkwAACContentsContainerFormPnLeftEx.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContentsContainerForm_pnLeftForScroll
 TkwAACContentsContainerFormPnLeftForScroll.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContentsContainerForm_pnlLeftTop
 TkwAACContentsContainerFormPnlLeftTop.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContentsContainerForm_pnLeft
 TkwAACContentsContainerFormPnLeft.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация AACContentsContainerForm_scrLeft
 TkwAACContentsContainerFormScrLeft.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа AACContentsContainer
 TtfwTypeRegistrator.RegisterType(TypeInfo(TAACContentsContainerForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtProportionalPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
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