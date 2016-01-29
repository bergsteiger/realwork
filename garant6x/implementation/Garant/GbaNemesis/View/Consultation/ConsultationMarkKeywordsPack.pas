unit ConsultationMarkKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Consultation/ConsultationMarkKeywordsPack.pas"
// Начат: 25.09.2009 21:19
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Пользовательские сервисы::Consultation::View::Consultation::Consultation$FP::ConsultationMarkKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы ConsultationMark
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
  vtPanel,
  ConsultationMark_Form,
  eeMemoWithEditOperations,
  vtGroupBox,
  vtLabel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  vtRadioButton,
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
  Tkw_Form_ConsultationMark = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы ConsultationMark
----
*Пример использования*:
[code]
'aControl' форма::ConsultationMark TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_ConsultationMark

// start class Tkw_Form_ConsultationMark

class function Tkw_Form_ConsultationMark.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::ConsultationMark';
end;//Tkw_Form_ConsultationMark.GetWordNameForRegister

function Tkw_Form_ConsultationMark.GetString: AnsiString;
 {-}
begin
 Result := 'en_ConsultationMark';
end;//Tkw_Form_ConsultationMark.GetString

type
  Tkw_ConsultationMark_Control_gbMark = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола gbMark
----
*Пример использования*:
[code]
контрол::gbMark TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ConsultationMark_Control_gbMark

// start class Tkw_ConsultationMark_Control_gbMark

class function Tkw_ConsultationMark_Control_gbMark.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::gbMark';
end;//Tkw_ConsultationMark_Control_gbMark.GetWordNameForRegister

function Tkw_ConsultationMark_Control_gbMark.GetString: AnsiString;
 {-}
begin
 Result := 'gbMark';
end;//Tkw_ConsultationMark_Control_gbMark.GetString

class procedure Tkw_ConsultationMark_Control_gbMark.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_ConsultationMark_Control_gbMark.RegisterInEngine

type
  Tkw_ConsultationMark_Control_gbMark_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола gbMark
----
*Пример использования*:
[code]
контрол::gbMark:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ConsultationMark_Control_gbMark_Push

// start class Tkw_ConsultationMark_Control_gbMark_Push

procedure Tkw_ConsultationMark_Control_gbMark_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('gbMark');
 inherited;
end;//Tkw_ConsultationMark_Control_gbMark_Push.DoDoIt

class function Tkw_ConsultationMark_Control_gbMark_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::gbMark:push';
end;//Tkw_ConsultationMark_Control_gbMark_Push.GetWordNameForRegister

type
  Tkw_ConsultationMark_Control_rbNotSure = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола rbNotSure
----
*Пример использования*:
[code]
контрол::rbNotSure TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ConsultationMark_Control_rbNotSure

// start class Tkw_ConsultationMark_Control_rbNotSure

class function Tkw_ConsultationMark_Control_rbNotSure.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rbNotSure';
end;//Tkw_ConsultationMark_Control_rbNotSure.GetWordNameForRegister

function Tkw_ConsultationMark_Control_rbNotSure.GetString: AnsiString;
 {-}
begin
 Result := 'rbNotSure';
end;//Tkw_ConsultationMark_Control_rbNotSure.GetString

class procedure Tkw_ConsultationMark_Control_rbNotSure.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_ConsultationMark_Control_rbNotSure.RegisterInEngine

type
  Tkw_ConsultationMark_Control_rbNotSure_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола rbNotSure
----
*Пример использования*:
[code]
контрол::rbNotSure:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ConsultationMark_Control_rbNotSure_Push

// start class Tkw_ConsultationMark_Control_rbNotSure_Push

procedure Tkw_ConsultationMark_Control_rbNotSure_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('rbNotSure');
 inherited;
end;//Tkw_ConsultationMark_Control_rbNotSure_Push.DoDoIt

class function Tkw_ConsultationMark_Control_rbNotSure_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rbNotSure:push';
end;//Tkw_ConsultationMark_Control_rbNotSure_Push.GetWordNameForRegister

type
  Tkw_ConsultationMark_Control_rbTwo = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола rbTwo
----
*Пример использования*:
[code]
контрол::rbTwo TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ConsultationMark_Control_rbTwo

// start class Tkw_ConsultationMark_Control_rbTwo

class function Tkw_ConsultationMark_Control_rbTwo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rbTwo';
end;//Tkw_ConsultationMark_Control_rbTwo.GetWordNameForRegister

function Tkw_ConsultationMark_Control_rbTwo.GetString: AnsiString;
 {-}
begin
 Result := 'rbTwo';
end;//Tkw_ConsultationMark_Control_rbTwo.GetString

class procedure Tkw_ConsultationMark_Control_rbTwo.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_ConsultationMark_Control_rbTwo.RegisterInEngine

type
  Tkw_ConsultationMark_Control_rbTwo_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола rbTwo
----
*Пример использования*:
[code]
контрол::rbTwo:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ConsultationMark_Control_rbTwo_Push

// start class Tkw_ConsultationMark_Control_rbTwo_Push

procedure Tkw_ConsultationMark_Control_rbTwo_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('rbTwo');
 inherited;
end;//Tkw_ConsultationMark_Control_rbTwo_Push.DoDoIt

class function Tkw_ConsultationMark_Control_rbTwo_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rbTwo:push';
end;//Tkw_ConsultationMark_Control_rbTwo_Push.GetWordNameForRegister

type
  Tkw_ConsultationMark_Control_rbThree = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола rbThree
----
*Пример использования*:
[code]
контрол::rbThree TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ConsultationMark_Control_rbThree

// start class Tkw_ConsultationMark_Control_rbThree

class function Tkw_ConsultationMark_Control_rbThree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rbThree';
end;//Tkw_ConsultationMark_Control_rbThree.GetWordNameForRegister

function Tkw_ConsultationMark_Control_rbThree.GetString: AnsiString;
 {-}
begin
 Result := 'rbThree';
end;//Tkw_ConsultationMark_Control_rbThree.GetString

class procedure Tkw_ConsultationMark_Control_rbThree.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_ConsultationMark_Control_rbThree.RegisterInEngine

type
  Tkw_ConsultationMark_Control_rbThree_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола rbThree
----
*Пример использования*:
[code]
контрол::rbThree:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ConsultationMark_Control_rbThree_Push

// start class Tkw_ConsultationMark_Control_rbThree_Push

procedure Tkw_ConsultationMark_Control_rbThree_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('rbThree');
 inherited;
end;//Tkw_ConsultationMark_Control_rbThree_Push.DoDoIt

class function Tkw_ConsultationMark_Control_rbThree_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rbThree:push';
end;//Tkw_ConsultationMark_Control_rbThree_Push.GetWordNameForRegister

type
  Tkw_ConsultationMark_Control_rbFour = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола rbFour
----
*Пример использования*:
[code]
контрол::rbFour TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ConsultationMark_Control_rbFour

// start class Tkw_ConsultationMark_Control_rbFour

class function Tkw_ConsultationMark_Control_rbFour.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rbFour';
end;//Tkw_ConsultationMark_Control_rbFour.GetWordNameForRegister

function Tkw_ConsultationMark_Control_rbFour.GetString: AnsiString;
 {-}
begin
 Result := 'rbFour';
end;//Tkw_ConsultationMark_Control_rbFour.GetString

class procedure Tkw_ConsultationMark_Control_rbFour.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_ConsultationMark_Control_rbFour.RegisterInEngine

type
  Tkw_ConsultationMark_Control_rbFour_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола rbFour
----
*Пример использования*:
[code]
контрол::rbFour:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ConsultationMark_Control_rbFour_Push

// start class Tkw_ConsultationMark_Control_rbFour_Push

procedure Tkw_ConsultationMark_Control_rbFour_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('rbFour');
 inherited;
end;//Tkw_ConsultationMark_Control_rbFour_Push.DoDoIt

class function Tkw_ConsultationMark_Control_rbFour_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rbFour:push';
end;//Tkw_ConsultationMark_Control_rbFour_Push.GetWordNameForRegister

type
  Tkw_ConsultationMark_Control_rbFive = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола rbFive
----
*Пример использования*:
[code]
контрол::rbFive TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ConsultationMark_Control_rbFive

// start class Tkw_ConsultationMark_Control_rbFive

class function Tkw_ConsultationMark_Control_rbFive.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rbFive';
end;//Tkw_ConsultationMark_Control_rbFive.GetWordNameForRegister

function Tkw_ConsultationMark_Control_rbFive.GetString: AnsiString;
 {-}
begin
 Result := 'rbFive';
end;//Tkw_ConsultationMark_Control_rbFive.GetString

class procedure Tkw_ConsultationMark_Control_rbFive.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtRadioButton);
end;//Tkw_ConsultationMark_Control_rbFive.RegisterInEngine

type
  Tkw_ConsultationMark_Control_rbFive_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола rbFive
----
*Пример использования*:
[code]
контрол::rbFive:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ConsultationMark_Control_rbFive_Push

// start class Tkw_ConsultationMark_Control_rbFive_Push

procedure Tkw_ConsultationMark_Control_rbFive_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('rbFive');
 inherited;
end;//Tkw_ConsultationMark_Control_rbFive_Push.DoDoIt

class function Tkw_ConsultationMark_Control_rbFive_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::rbFive:push';
end;//Tkw_ConsultationMark_Control_rbFive_Push.GetWordNameForRegister

type
  Tkw_ConsultationMark_Control_pnlHelp = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола pnlHelp
----
*Пример использования*:
[code]
контрол::pnlHelp TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ConsultationMark_Control_pnlHelp

// start class Tkw_ConsultationMark_Control_pnlHelp

class function Tkw_ConsultationMark_Control_pnlHelp.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnlHelp';
end;//Tkw_ConsultationMark_Control_pnlHelp.GetWordNameForRegister

function Tkw_ConsultationMark_Control_pnlHelp.GetString: AnsiString;
 {-}
begin
 Result := 'pnlHelp';
end;//Tkw_ConsultationMark_Control_pnlHelp.GetString

class procedure Tkw_ConsultationMark_Control_pnlHelp.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ConsultationMark_Control_pnlHelp.RegisterInEngine

type
  Tkw_ConsultationMark_Control_pnlHelp_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола pnlHelp
----
*Пример использования*:
[code]
контрол::pnlHelp:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ConsultationMark_Control_pnlHelp_Push

// start class Tkw_ConsultationMark_Control_pnlHelp_Push

procedure Tkw_ConsultationMark_Control_pnlHelp_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnlHelp');
 inherited;
end;//Tkw_ConsultationMark_Control_pnlHelp_Push.DoDoIt

class function Tkw_ConsultationMark_Control_pnlHelp_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnlHelp:push';
end;//Tkw_ConsultationMark_Control_pnlHelp_Push.GetWordNameForRegister

type
  Tkw_ConsultationMark_Control_lblHelp = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола lblHelp
----
*Пример использования*:
[code]
контрол::lblHelp TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ConsultationMark_Control_lblHelp

// start class Tkw_ConsultationMark_Control_lblHelp

class function Tkw_ConsultationMark_Control_lblHelp.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblHelp';
end;//Tkw_ConsultationMark_Control_lblHelp.GetWordNameForRegister

function Tkw_ConsultationMark_Control_lblHelp.GetString: AnsiString;
 {-}
begin
 Result := 'lblHelp';
end;//Tkw_ConsultationMark_Control_lblHelp.GetString

class procedure Tkw_ConsultationMark_Control_lblHelp.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_ConsultationMark_Control_lblHelp.RegisterInEngine

type
  Tkw_ConsultationMark_Control_lblHelp_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола lblHelp
----
*Пример использования*:
[code]
контрол::lblHelp:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ConsultationMark_Control_lblHelp_Push

// start class Tkw_ConsultationMark_Control_lblHelp_Push

procedure Tkw_ConsultationMark_Control_lblHelp_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lblHelp');
 inherited;
end;//Tkw_ConsultationMark_Control_lblHelp_Push.DoDoIt

class function Tkw_ConsultationMark_Control_lblHelp_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblHelp:push';
end;//Tkw_ConsultationMark_Control_lblHelp_Push.GetWordNameForRegister

type
  Tkw_ConsultationMark_Control_gbComment = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола gbComment
----
*Пример использования*:
[code]
контрол::gbComment TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ConsultationMark_Control_gbComment

// start class Tkw_ConsultationMark_Control_gbComment

class function Tkw_ConsultationMark_Control_gbComment.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::gbComment';
end;//Tkw_ConsultationMark_Control_gbComment.GetWordNameForRegister

function Tkw_ConsultationMark_Control_gbComment.GetString: AnsiString;
 {-}
begin
 Result := 'gbComment';
end;//Tkw_ConsultationMark_Control_gbComment.GetString

class procedure Tkw_ConsultationMark_Control_gbComment.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_ConsultationMark_Control_gbComment.RegisterInEngine

type
  Tkw_ConsultationMark_Control_gbComment_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола gbComment
----
*Пример использования*:
[code]
контрол::gbComment:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ConsultationMark_Control_gbComment_Push

// start class Tkw_ConsultationMark_Control_gbComment_Push

procedure Tkw_ConsultationMark_Control_gbComment_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('gbComment');
 inherited;
end;//Tkw_ConsultationMark_Control_gbComment_Push.DoDoIt

class function Tkw_ConsultationMark_Control_gbComment_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::gbComment:push';
end;//Tkw_ConsultationMark_Control_gbComment_Push.GetWordNameForRegister

type
  Tkw_ConsultationMark_Control_mComment = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола mComment
----
*Пример использования*:
[code]
контрол::mComment TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ConsultationMark_Control_mComment

// start class Tkw_ConsultationMark_Control_mComment

class function Tkw_ConsultationMark_Control_mComment.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::mComment';
end;//Tkw_ConsultationMark_Control_mComment.GetWordNameForRegister

function Tkw_ConsultationMark_Control_mComment.GetString: AnsiString;
 {-}
begin
 Result := 'mComment';
end;//Tkw_ConsultationMark_Control_mComment.GetString

class procedure Tkw_ConsultationMark_Control_mComment.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeMemoWithEditOperations);
end;//Tkw_ConsultationMark_Control_mComment.RegisterInEngine

type
  Tkw_ConsultationMark_Control_mComment_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола mComment
----
*Пример использования*:
[code]
контрол::mComment:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ConsultationMark_Control_mComment_Push

// start class Tkw_ConsultationMark_Control_mComment_Push

procedure Tkw_ConsultationMark_Control_mComment_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('mComment');
 inherited;
end;//Tkw_ConsultationMark_Control_mComment_Push.DoDoIt

class function Tkw_ConsultationMark_Control_mComment_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::mComment:push';
end;//Tkw_ConsultationMark_Control_mComment_Push.GetWordNameForRegister

type
  TkwEnConsultationMarkGbMark = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_ConsultationMark.gbMark
[panel]Контрол gbMark формы Ten_ConsultationMark[panel]
*Тип результата:* TvtGroupBox
*Пример:*
[code]
OBJECT VAR l_TvtGroupBox
 aen_ConsultationMark .Ten_ConsultationMark.gbMark >>> l_TvtGroupBox
[code]  }
  private
  // private methods
   function GbMark(const aCtx: TtfwContext;
     aen_ConsultationMark: Ten_ConsultationMark): TvtGroupBox;
     {* Реализация слова скрипта .Ten_ConsultationMark.gbMark }
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
  end;//TkwEnConsultationMarkGbMark

// start class TkwEnConsultationMarkGbMark

function TkwEnConsultationMarkGbMark.GbMark(const aCtx: TtfwContext;
  aen_ConsultationMark: Ten_ConsultationMark): TvtGroupBox;
 {-}
begin
 Result := aen_ConsultationMark.gbMark;
end;//TkwEnConsultationMarkGbMark.GbMark

procedure TkwEnConsultationMarkGbMark.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_ConsultationMark : Ten_ConsultationMark;
begin
 try
  l_aen_ConsultationMark := Ten_ConsultationMark(aCtx.rEngine.PopObjAs(Ten_ConsultationMark));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_ConsultationMark: Ten_ConsultationMark : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((GbMark(aCtx, l_aen_ConsultationMark)));
end;//TkwEnConsultationMarkGbMark.DoDoIt

class function TkwEnConsultationMarkGbMark.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_ConsultationMark.gbMark';
end;//TkwEnConsultationMarkGbMark.GetWordNameForRegister

procedure TkwEnConsultationMarkGbMark.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству gbMark', aCtx);
end;//TkwEnConsultationMarkGbMark.SetValuePrim

function TkwEnConsultationMarkGbMark.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwEnConsultationMarkGbMark.GetResultTypeInfo

function TkwEnConsultationMarkGbMark.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnConsultationMarkGbMark.GetAllParamsCount

function TkwEnConsultationMarkGbMark.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConsultationMark)]);
end;//TkwEnConsultationMarkGbMark.ParamsTypes

type
  TkwEnConsultationMarkRbNotSure = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_ConsultationMark.rbNotSure
[panel]Контрол rbNotSure формы Ten_ConsultationMark[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_ConsultationMark .Ten_ConsultationMark.rbNotSure >>> l_TvtRadioButton
[code]  }
  private
  // private methods
   function RbNotSure(const aCtx: TtfwContext;
     aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
     {* Реализация слова скрипта .Ten_ConsultationMark.rbNotSure }
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
  end;//TkwEnConsultationMarkRbNotSure

// start class TkwEnConsultationMarkRbNotSure

function TkwEnConsultationMarkRbNotSure.RbNotSure(const aCtx: TtfwContext;
  aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
 {-}
begin
 Result := aen_ConsultationMark.rbNotSure;
end;//TkwEnConsultationMarkRbNotSure.RbNotSure

procedure TkwEnConsultationMarkRbNotSure.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_ConsultationMark : Ten_ConsultationMark;
begin
 try
  l_aen_ConsultationMark := Ten_ConsultationMark(aCtx.rEngine.PopObjAs(Ten_ConsultationMark));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_ConsultationMark: Ten_ConsultationMark : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RbNotSure(aCtx, l_aen_ConsultationMark)));
end;//TkwEnConsultationMarkRbNotSure.DoDoIt

class function TkwEnConsultationMarkRbNotSure.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_ConsultationMark.rbNotSure';
end;//TkwEnConsultationMarkRbNotSure.GetWordNameForRegister

procedure TkwEnConsultationMarkRbNotSure.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству rbNotSure', aCtx);
end;//TkwEnConsultationMarkRbNotSure.SetValuePrim

function TkwEnConsultationMarkRbNotSure.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnConsultationMarkRbNotSure.GetResultTypeInfo

function TkwEnConsultationMarkRbNotSure.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnConsultationMarkRbNotSure.GetAllParamsCount

function TkwEnConsultationMarkRbNotSure.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConsultationMark)]);
end;//TkwEnConsultationMarkRbNotSure.ParamsTypes

type
  TkwEnConsultationMarkRbTwo = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_ConsultationMark.rbTwo
[panel]Контрол rbTwo формы Ten_ConsultationMark[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_ConsultationMark .Ten_ConsultationMark.rbTwo >>> l_TvtRadioButton
[code]  }
  private
  // private methods
   function RbTwo(const aCtx: TtfwContext;
     aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
     {* Реализация слова скрипта .Ten_ConsultationMark.rbTwo }
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
  end;//TkwEnConsultationMarkRbTwo

// start class TkwEnConsultationMarkRbTwo

function TkwEnConsultationMarkRbTwo.RbTwo(const aCtx: TtfwContext;
  aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
 {-}
begin
 Result := aen_ConsultationMark.rbTwo;
end;//TkwEnConsultationMarkRbTwo.RbTwo

procedure TkwEnConsultationMarkRbTwo.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_ConsultationMark : Ten_ConsultationMark;
begin
 try
  l_aen_ConsultationMark := Ten_ConsultationMark(aCtx.rEngine.PopObjAs(Ten_ConsultationMark));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_ConsultationMark: Ten_ConsultationMark : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RbTwo(aCtx, l_aen_ConsultationMark)));
end;//TkwEnConsultationMarkRbTwo.DoDoIt

class function TkwEnConsultationMarkRbTwo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_ConsultationMark.rbTwo';
end;//TkwEnConsultationMarkRbTwo.GetWordNameForRegister

procedure TkwEnConsultationMarkRbTwo.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству rbTwo', aCtx);
end;//TkwEnConsultationMarkRbTwo.SetValuePrim

function TkwEnConsultationMarkRbTwo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnConsultationMarkRbTwo.GetResultTypeInfo

function TkwEnConsultationMarkRbTwo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnConsultationMarkRbTwo.GetAllParamsCount

function TkwEnConsultationMarkRbTwo.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConsultationMark)]);
end;//TkwEnConsultationMarkRbTwo.ParamsTypes

type
  TkwEnConsultationMarkRbThree = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_ConsultationMark.rbThree
[panel]Контрол rbThree формы Ten_ConsultationMark[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_ConsultationMark .Ten_ConsultationMark.rbThree >>> l_TvtRadioButton
[code]  }
  private
  // private methods
   function RbThree(const aCtx: TtfwContext;
     aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
     {* Реализация слова скрипта .Ten_ConsultationMark.rbThree }
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
  end;//TkwEnConsultationMarkRbThree

// start class TkwEnConsultationMarkRbThree

function TkwEnConsultationMarkRbThree.RbThree(const aCtx: TtfwContext;
  aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
 {-}
begin
 Result := aen_ConsultationMark.rbThree;
end;//TkwEnConsultationMarkRbThree.RbThree

procedure TkwEnConsultationMarkRbThree.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_ConsultationMark : Ten_ConsultationMark;
begin
 try
  l_aen_ConsultationMark := Ten_ConsultationMark(aCtx.rEngine.PopObjAs(Ten_ConsultationMark));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_ConsultationMark: Ten_ConsultationMark : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RbThree(aCtx, l_aen_ConsultationMark)));
end;//TkwEnConsultationMarkRbThree.DoDoIt

class function TkwEnConsultationMarkRbThree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_ConsultationMark.rbThree';
end;//TkwEnConsultationMarkRbThree.GetWordNameForRegister

procedure TkwEnConsultationMarkRbThree.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству rbThree', aCtx);
end;//TkwEnConsultationMarkRbThree.SetValuePrim

function TkwEnConsultationMarkRbThree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnConsultationMarkRbThree.GetResultTypeInfo

function TkwEnConsultationMarkRbThree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnConsultationMarkRbThree.GetAllParamsCount

function TkwEnConsultationMarkRbThree.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConsultationMark)]);
end;//TkwEnConsultationMarkRbThree.ParamsTypes

type
  TkwEnConsultationMarkRbFour = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_ConsultationMark.rbFour
[panel]Контрол rbFour формы Ten_ConsultationMark[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_ConsultationMark .Ten_ConsultationMark.rbFour >>> l_TvtRadioButton
[code]  }
  private
  // private methods
   function RbFour(const aCtx: TtfwContext;
     aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
     {* Реализация слова скрипта .Ten_ConsultationMark.rbFour }
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
  end;//TkwEnConsultationMarkRbFour

// start class TkwEnConsultationMarkRbFour

function TkwEnConsultationMarkRbFour.RbFour(const aCtx: TtfwContext;
  aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
 {-}
begin
 Result := aen_ConsultationMark.rbFour;
end;//TkwEnConsultationMarkRbFour.RbFour

procedure TkwEnConsultationMarkRbFour.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_ConsultationMark : Ten_ConsultationMark;
begin
 try
  l_aen_ConsultationMark := Ten_ConsultationMark(aCtx.rEngine.PopObjAs(Ten_ConsultationMark));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_ConsultationMark: Ten_ConsultationMark : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RbFour(aCtx, l_aen_ConsultationMark)));
end;//TkwEnConsultationMarkRbFour.DoDoIt

class function TkwEnConsultationMarkRbFour.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_ConsultationMark.rbFour';
end;//TkwEnConsultationMarkRbFour.GetWordNameForRegister

procedure TkwEnConsultationMarkRbFour.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству rbFour', aCtx);
end;//TkwEnConsultationMarkRbFour.SetValuePrim

function TkwEnConsultationMarkRbFour.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnConsultationMarkRbFour.GetResultTypeInfo

function TkwEnConsultationMarkRbFour.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnConsultationMarkRbFour.GetAllParamsCount

function TkwEnConsultationMarkRbFour.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConsultationMark)]);
end;//TkwEnConsultationMarkRbFour.ParamsTypes

type
  TkwEnConsultationMarkRbFive = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_ConsultationMark.rbFive
[panel]Контрол rbFive формы Ten_ConsultationMark[panel]
*Тип результата:* TvtRadioButton
*Пример:*
[code]
OBJECT VAR l_TvtRadioButton
 aen_ConsultationMark .Ten_ConsultationMark.rbFive >>> l_TvtRadioButton
[code]  }
  private
  // private methods
   function RbFive(const aCtx: TtfwContext;
     aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
     {* Реализация слова скрипта .Ten_ConsultationMark.rbFive }
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
  end;//TkwEnConsultationMarkRbFive

// start class TkwEnConsultationMarkRbFive

function TkwEnConsultationMarkRbFive.RbFive(const aCtx: TtfwContext;
  aen_ConsultationMark: Ten_ConsultationMark): TvtRadioButton;
 {-}
begin
 Result := aen_ConsultationMark.rbFive;
end;//TkwEnConsultationMarkRbFive.RbFive

procedure TkwEnConsultationMarkRbFive.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_ConsultationMark : Ten_ConsultationMark;
begin
 try
  l_aen_ConsultationMark := Ten_ConsultationMark(aCtx.rEngine.PopObjAs(Ten_ConsultationMark));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_ConsultationMark: Ten_ConsultationMark : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RbFive(aCtx, l_aen_ConsultationMark)));
end;//TkwEnConsultationMarkRbFive.DoDoIt

class function TkwEnConsultationMarkRbFive.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_ConsultationMark.rbFive';
end;//TkwEnConsultationMarkRbFive.GetWordNameForRegister

procedure TkwEnConsultationMarkRbFive.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству rbFive', aCtx);
end;//TkwEnConsultationMarkRbFive.SetValuePrim

function TkwEnConsultationMarkRbFive.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtRadioButton);
end;//TkwEnConsultationMarkRbFive.GetResultTypeInfo

function TkwEnConsultationMarkRbFive.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnConsultationMarkRbFive.GetAllParamsCount

function TkwEnConsultationMarkRbFive.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConsultationMark)]);
end;//TkwEnConsultationMarkRbFive.ParamsTypes

type
  TkwEnConsultationMarkPnlHelp = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_ConsultationMark.pnlHelp
[panel]Контрол pnlHelp формы Ten_ConsultationMark[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_ConsultationMark .Ten_ConsultationMark.pnlHelp >>> l_TvtPanel
[code]  }
  private
  // private methods
   function PnlHelp(const aCtx: TtfwContext;
     aen_ConsultationMark: Ten_ConsultationMark): TvtPanel;
     {* Реализация слова скрипта .Ten_ConsultationMark.pnlHelp }
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
  end;//TkwEnConsultationMarkPnlHelp

// start class TkwEnConsultationMarkPnlHelp

function TkwEnConsultationMarkPnlHelp.PnlHelp(const aCtx: TtfwContext;
  aen_ConsultationMark: Ten_ConsultationMark): TvtPanel;
 {-}
begin
 Result := aen_ConsultationMark.pnlHelp;
end;//TkwEnConsultationMarkPnlHelp.PnlHelp

procedure TkwEnConsultationMarkPnlHelp.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_ConsultationMark : Ten_ConsultationMark;
begin
 try
  l_aen_ConsultationMark := Ten_ConsultationMark(aCtx.rEngine.PopObjAs(Ten_ConsultationMark));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_ConsultationMark: Ten_ConsultationMark : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnlHelp(aCtx, l_aen_ConsultationMark)));
end;//TkwEnConsultationMarkPnlHelp.DoDoIt

class function TkwEnConsultationMarkPnlHelp.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_ConsultationMark.pnlHelp';
end;//TkwEnConsultationMarkPnlHelp.GetWordNameForRegister

procedure TkwEnConsultationMarkPnlHelp.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlHelp', aCtx);
end;//TkwEnConsultationMarkPnlHelp.SetValuePrim

function TkwEnConsultationMarkPnlHelp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnConsultationMarkPnlHelp.GetResultTypeInfo

function TkwEnConsultationMarkPnlHelp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnConsultationMarkPnlHelp.GetAllParamsCount

function TkwEnConsultationMarkPnlHelp.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConsultationMark)]);
end;//TkwEnConsultationMarkPnlHelp.ParamsTypes

type
  TkwEnConsultationMarkLblHelp = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_ConsultationMark.lblHelp
[panel]Контрол lblHelp формы Ten_ConsultationMark[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aen_ConsultationMark .Ten_ConsultationMark.lblHelp >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LblHelp(const aCtx: TtfwContext;
     aen_ConsultationMark: Ten_ConsultationMark): TvtLabel;
     {* Реализация слова скрипта .Ten_ConsultationMark.lblHelp }
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
  end;//TkwEnConsultationMarkLblHelp

// start class TkwEnConsultationMarkLblHelp

function TkwEnConsultationMarkLblHelp.LblHelp(const aCtx: TtfwContext;
  aen_ConsultationMark: Ten_ConsultationMark): TvtLabel;
 {-}
begin
 Result := aen_ConsultationMark.lblHelp;
end;//TkwEnConsultationMarkLblHelp.LblHelp

procedure TkwEnConsultationMarkLblHelp.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_ConsultationMark : Ten_ConsultationMark;
begin
 try
  l_aen_ConsultationMark := Ten_ConsultationMark(aCtx.rEngine.PopObjAs(Ten_ConsultationMark));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_ConsultationMark: Ten_ConsultationMark : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LblHelp(aCtx, l_aen_ConsultationMark)));
end;//TkwEnConsultationMarkLblHelp.DoDoIt

class function TkwEnConsultationMarkLblHelp.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_ConsultationMark.lblHelp';
end;//TkwEnConsultationMarkLblHelp.GetWordNameForRegister

procedure TkwEnConsultationMarkLblHelp.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblHelp', aCtx);
end;//TkwEnConsultationMarkLblHelp.SetValuePrim

function TkwEnConsultationMarkLblHelp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnConsultationMarkLblHelp.GetResultTypeInfo

function TkwEnConsultationMarkLblHelp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnConsultationMarkLblHelp.GetAllParamsCount

function TkwEnConsultationMarkLblHelp.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConsultationMark)]);
end;//TkwEnConsultationMarkLblHelp.ParamsTypes

type
  TkwEnConsultationMarkGbComment = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_ConsultationMark.gbComment
[panel]Контрол gbComment формы Ten_ConsultationMark[panel]
*Тип результата:* TvtGroupBox
*Пример:*
[code]
OBJECT VAR l_TvtGroupBox
 aen_ConsultationMark .Ten_ConsultationMark.gbComment >>> l_TvtGroupBox
[code]  }
  private
  // private methods
   function GbComment(const aCtx: TtfwContext;
     aen_ConsultationMark: Ten_ConsultationMark): TvtGroupBox;
     {* Реализация слова скрипта .Ten_ConsultationMark.gbComment }
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
  end;//TkwEnConsultationMarkGbComment

// start class TkwEnConsultationMarkGbComment

function TkwEnConsultationMarkGbComment.GbComment(const aCtx: TtfwContext;
  aen_ConsultationMark: Ten_ConsultationMark): TvtGroupBox;
 {-}
begin
 Result := aen_ConsultationMark.gbComment;
end;//TkwEnConsultationMarkGbComment.GbComment

procedure TkwEnConsultationMarkGbComment.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_ConsultationMark : Ten_ConsultationMark;
begin
 try
  l_aen_ConsultationMark := Ten_ConsultationMark(aCtx.rEngine.PopObjAs(Ten_ConsultationMark));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_ConsultationMark: Ten_ConsultationMark : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((GbComment(aCtx, l_aen_ConsultationMark)));
end;//TkwEnConsultationMarkGbComment.DoDoIt

class function TkwEnConsultationMarkGbComment.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_ConsultationMark.gbComment';
end;//TkwEnConsultationMarkGbComment.GetWordNameForRegister

procedure TkwEnConsultationMarkGbComment.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству gbComment', aCtx);
end;//TkwEnConsultationMarkGbComment.SetValuePrim

function TkwEnConsultationMarkGbComment.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwEnConsultationMarkGbComment.GetResultTypeInfo

function TkwEnConsultationMarkGbComment.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnConsultationMarkGbComment.GetAllParamsCount

function TkwEnConsultationMarkGbComment.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConsultationMark)]);
end;//TkwEnConsultationMarkGbComment.ParamsTypes

type
  TkwEnConsultationMarkMComment = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .Ten_ConsultationMark.mComment
[panel]Контрол mComment формы Ten_ConsultationMark[panel]
*Тип результата:* TeeMemoWithEditOperations
*Пример:*
[code]
OBJECT VAR l_TeeMemoWithEditOperations
 aen_ConsultationMark .Ten_ConsultationMark.mComment >>> l_TeeMemoWithEditOperations
[code]  }
  private
  // private methods
   function MComment(const aCtx: TtfwContext;
     aen_ConsultationMark: Ten_ConsultationMark): TeeMemoWithEditOperations;
     {* Реализация слова скрипта .Ten_ConsultationMark.mComment }
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
  end;//TkwEnConsultationMarkMComment

// start class TkwEnConsultationMarkMComment

function TkwEnConsultationMarkMComment.MComment(const aCtx: TtfwContext;
  aen_ConsultationMark: Ten_ConsultationMark): TeeMemoWithEditOperations;
 {-}
begin
 Result := aen_ConsultationMark.mComment;
end;//TkwEnConsultationMarkMComment.MComment

procedure TkwEnConsultationMarkMComment.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_ConsultationMark : Ten_ConsultationMark;
begin
 try
  l_aen_ConsultationMark := Ten_ConsultationMark(aCtx.rEngine.PopObjAs(Ten_ConsultationMark));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_ConsultationMark: Ten_ConsultationMark : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((MComment(aCtx, l_aen_ConsultationMark)));
end;//TkwEnConsultationMarkMComment.DoDoIt

class function TkwEnConsultationMarkMComment.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_ConsultationMark.mComment';
end;//TkwEnConsultationMarkMComment.GetWordNameForRegister

procedure TkwEnConsultationMarkMComment.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству mComment', aCtx);
end;//TkwEnConsultationMarkMComment.SetValuePrim

function TkwEnConsultationMarkMComment.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeMemoWithEditOperations);
end;//TkwEnConsultationMarkMComment.GetResultTypeInfo

function TkwEnConsultationMarkMComment.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnConsultationMarkMComment.GetAllParamsCount

function TkwEnConsultationMarkMComment.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_ConsultationMark)]);
end;//TkwEnConsultationMarkMComment.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_ConsultationMark
 Tkw_Form_ConsultationMark.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConsultationMark_Control_gbMark
 Tkw_ConsultationMark_Control_gbMark.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConsultationMark_Control_gbMark_Push
 Tkw_ConsultationMark_Control_gbMark_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConsultationMark_Control_rbNotSure
 Tkw_ConsultationMark_Control_rbNotSure.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConsultationMark_Control_rbNotSure_Push
 Tkw_ConsultationMark_Control_rbNotSure_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConsultationMark_Control_rbTwo
 Tkw_ConsultationMark_Control_rbTwo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConsultationMark_Control_rbTwo_Push
 Tkw_ConsultationMark_Control_rbTwo_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConsultationMark_Control_rbThree
 Tkw_ConsultationMark_Control_rbThree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConsultationMark_Control_rbThree_Push
 Tkw_ConsultationMark_Control_rbThree_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConsultationMark_Control_rbFour
 Tkw_ConsultationMark_Control_rbFour.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConsultationMark_Control_rbFour_Push
 Tkw_ConsultationMark_Control_rbFour_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConsultationMark_Control_rbFive
 Tkw_ConsultationMark_Control_rbFive.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConsultationMark_Control_rbFive_Push
 Tkw_ConsultationMark_Control_rbFive_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConsultationMark_Control_pnlHelp
 Tkw_ConsultationMark_Control_pnlHelp.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConsultationMark_Control_pnlHelp_Push
 Tkw_ConsultationMark_Control_pnlHelp_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConsultationMark_Control_lblHelp
 Tkw_ConsultationMark_Control_lblHelp.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConsultationMark_Control_lblHelp_Push
 Tkw_ConsultationMark_Control_lblHelp_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConsultationMark_Control_gbComment
 Tkw_ConsultationMark_Control_gbComment.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConsultationMark_Control_gbComment_Push
 Tkw_ConsultationMark_Control_gbComment_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConsultationMark_Control_mComment
 Tkw_ConsultationMark_Control_mComment.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_ConsultationMark_Control_mComment_Push
 Tkw_ConsultationMark_Control_mComment_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_ConsultationMark_gbMark
 TkwEnConsultationMarkGbMark.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_ConsultationMark_rbNotSure
 TkwEnConsultationMarkRbNotSure.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_ConsultationMark_rbTwo
 TkwEnConsultationMarkRbTwo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_ConsultationMark_rbThree
 TkwEnConsultationMarkRbThree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_ConsultationMark_rbFour
 TkwEnConsultationMarkRbFour.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_ConsultationMark_rbFive
 TkwEnConsultationMarkRbFive.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_ConsultationMark_pnlHelp
 TkwEnConsultationMarkPnlHelp.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_ConsultationMark_lblHelp
 TkwEnConsultationMarkLblHelp.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_ConsultationMark_gbComment
 TkwEnConsultationMarkGbComment.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация en_ConsultationMark_mComment
 TkwEnConsultationMarkMComment.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа ConsultationMark
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_ConsultationMark));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtGroupBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtGroupBox));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtRadioButton
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtRadioButton));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TeeMemoWithEditOperations
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeMemoWithEditOperations));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.