unit FoldersElementInfoKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/FoldersElementInfoKeywordsPack.pas"
// Начат: 27.08.2009 20:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Основные прецеденты::Folders::View::Folders::PrimFolders$UC::FoldersElementInfoKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы FoldersElementInfo
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
  FoldersElementInfo_Form,
  eeMemoWithEditOperations,
  vtLabel
  {$If defined(Nemesis)}
  ,
  nscComboBoxWithReadOnly
  {$IfEnd} //Nemesis
  ,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  vtCheckBox,
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
  Tkw_Form_FoldersElementInfo = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы FoldersElementInfo
----
*Пример использования*:
[code]
'aControl' форма::FoldersElementInfo TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_FoldersElementInfo

// start class Tkw_Form_FoldersElementInfo

class function Tkw_Form_FoldersElementInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::FoldersElementInfo';
end;//Tkw_Form_FoldersElementInfo.GetWordNameForRegister

function Tkw_Form_FoldersElementInfo.GetString: AnsiString;
 {-}
begin
 Result := 'enFoldersElementInfo';
end;//Tkw_Form_FoldersElementInfo.GetString

type
  Tkw_FoldersElementInfo_Control_CommentPanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола CommentPanel
----
*Пример использования*:
[code]
контрол::CommentPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_FoldersElementInfo_Control_CommentPanel

// start class Tkw_FoldersElementInfo_Control_CommentPanel

class function Tkw_FoldersElementInfo_Control_CommentPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::CommentPanel';
end;//Tkw_FoldersElementInfo_Control_CommentPanel.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_CommentPanel.GetString: AnsiString;
 {-}
begin
 Result := 'CommentPanel';
end;//Tkw_FoldersElementInfo_Control_CommentPanel.GetString

class procedure Tkw_FoldersElementInfo_Control_CommentPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_FoldersElementInfo_Control_CommentPanel.RegisterInEngine

type
  Tkw_FoldersElementInfo_Control_CommentPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола CommentPanel
----
*Пример использования*:
[code]
контрол::CommentPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_FoldersElementInfo_Control_CommentPanel_Push

// start class Tkw_FoldersElementInfo_Control_CommentPanel_Push

procedure Tkw_FoldersElementInfo_Control_CommentPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('CommentPanel');
 inherited;
end;//Tkw_FoldersElementInfo_Control_CommentPanel_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_CommentPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::CommentPanel:push';
end;//Tkw_FoldersElementInfo_Control_CommentPanel_Push.GetWordNameForRegister

type
  Tkw_FoldersElementInfo_Control_ElementComment = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола ElementComment
----
*Пример использования*:
[code]
контрол::ElementComment TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_FoldersElementInfo_Control_ElementComment

// start class Tkw_FoldersElementInfo_Control_ElementComment

class function Tkw_FoldersElementInfo_Control_ElementComment.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ElementComment';
end;//Tkw_FoldersElementInfo_Control_ElementComment.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_ElementComment.GetString: AnsiString;
 {-}
begin
 Result := 'ElementComment';
end;//Tkw_FoldersElementInfo_Control_ElementComment.GetString

class procedure Tkw_FoldersElementInfo_Control_ElementComment.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeMemoWithEditOperations);
end;//Tkw_FoldersElementInfo_Control_ElementComment.RegisterInEngine

type
  Tkw_FoldersElementInfo_Control_ElementComment_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола ElementComment
----
*Пример использования*:
[code]
контрол::ElementComment:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_FoldersElementInfo_Control_ElementComment_Push

// start class Tkw_FoldersElementInfo_Control_ElementComment_Push

procedure Tkw_FoldersElementInfo_Control_ElementComment_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ElementComment');
 inherited;
end;//Tkw_FoldersElementInfo_Control_ElementComment_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_ElementComment_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ElementComment:push';
end;//Tkw_FoldersElementInfo_Control_ElementComment_Push.GetWordNameForRegister

type
  Tkw_FoldersElementInfo_Control_CaptionPanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола CaptionPanel
----
*Пример использования*:
[code]
контрол::CaptionPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_FoldersElementInfo_Control_CaptionPanel

// start class Tkw_FoldersElementInfo_Control_CaptionPanel

class function Tkw_FoldersElementInfo_Control_CaptionPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::CaptionPanel';
end;//Tkw_FoldersElementInfo_Control_CaptionPanel.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_CaptionPanel.GetString: AnsiString;
 {-}
begin
 Result := 'CaptionPanel';
end;//Tkw_FoldersElementInfo_Control_CaptionPanel.GetString

class procedure Tkw_FoldersElementInfo_Control_CaptionPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_FoldersElementInfo_Control_CaptionPanel.RegisterInEngine

type
  Tkw_FoldersElementInfo_Control_CaptionPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола CaptionPanel
----
*Пример использования*:
[code]
контрол::CaptionPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_FoldersElementInfo_Control_CaptionPanel_Push

// start class Tkw_FoldersElementInfo_Control_CaptionPanel_Push

procedure Tkw_FoldersElementInfo_Control_CaptionPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('CaptionPanel');
 inherited;
end;//Tkw_FoldersElementInfo_Control_CaptionPanel_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_CaptionPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::CaptionPanel:push';
end;//Tkw_FoldersElementInfo_Control_CaptionPanel_Push.GetWordNameForRegister

type
  Tkw_FoldersElementInfo_Control_lblComment = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола lblComment
----
*Пример использования*:
[code]
контрол::lblComment TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_FoldersElementInfo_Control_lblComment

// start class Tkw_FoldersElementInfo_Control_lblComment

class function Tkw_FoldersElementInfo_Control_lblComment.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblComment';
end;//Tkw_FoldersElementInfo_Control_lblComment.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_lblComment.GetString: AnsiString;
 {-}
begin
 Result := 'lblComment';
end;//Tkw_FoldersElementInfo_Control_lblComment.GetString

class procedure Tkw_FoldersElementInfo_Control_lblComment.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_FoldersElementInfo_Control_lblComment.RegisterInEngine

type
  Tkw_FoldersElementInfo_Control_lblComment_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола lblComment
----
*Пример использования*:
[code]
контрол::lblComment:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_FoldersElementInfo_Control_lblComment_Push

// start class Tkw_FoldersElementInfo_Control_lblComment_Push

procedure Tkw_FoldersElementInfo_Control_lblComment_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lblComment');
 inherited;
end;//Tkw_FoldersElementInfo_Control_lblComment_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_lblComment_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblComment:push';
end;//Tkw_FoldersElementInfo_Control_lblComment_Push.GetWordNameForRegister

type
  Tkw_FoldersElementInfo_Control_TopPanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола TopPanel
----
*Пример использования*:
[code]
контрол::TopPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_FoldersElementInfo_Control_TopPanel

// start class Tkw_FoldersElementInfo_Control_TopPanel

class function Tkw_FoldersElementInfo_Control_TopPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::TopPanel';
end;//Tkw_FoldersElementInfo_Control_TopPanel.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_TopPanel.GetString: AnsiString;
 {-}
begin
 Result := 'TopPanel';
end;//Tkw_FoldersElementInfo_Control_TopPanel.GetString

class procedure Tkw_FoldersElementInfo_Control_TopPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_FoldersElementInfo_Control_TopPanel.RegisterInEngine

type
  Tkw_FoldersElementInfo_Control_TopPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола TopPanel
----
*Пример использования*:
[code]
контрол::TopPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_FoldersElementInfo_Control_TopPanel_Push

// start class Tkw_FoldersElementInfo_Control_TopPanel_Push

procedure Tkw_FoldersElementInfo_Control_TopPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('TopPanel');
 inherited;
end;//Tkw_FoldersElementInfo_Control_TopPanel_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_TopPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::TopPanel:push';
end;//Tkw_FoldersElementInfo_Control_TopPanel_Push.GetWordNameForRegister

type
  Tkw_FoldersElementInfo_Control_NamePanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола NamePanel
----
*Пример использования*:
[code]
контрол::NamePanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_FoldersElementInfo_Control_NamePanel

// start class Tkw_FoldersElementInfo_Control_NamePanel

class function Tkw_FoldersElementInfo_Control_NamePanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::NamePanel';
end;//Tkw_FoldersElementInfo_Control_NamePanel.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_NamePanel.GetString: AnsiString;
 {-}
begin
 Result := 'NamePanel';
end;//Tkw_FoldersElementInfo_Control_NamePanel.GetString

class procedure Tkw_FoldersElementInfo_Control_NamePanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_FoldersElementInfo_Control_NamePanel.RegisterInEngine

type
  Tkw_FoldersElementInfo_Control_NamePanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола NamePanel
----
*Пример использования*:
[code]
контрол::NamePanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_FoldersElementInfo_Control_NamePanel_Push

// start class Tkw_FoldersElementInfo_Control_NamePanel_Push

procedure Tkw_FoldersElementInfo_Control_NamePanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('NamePanel');
 inherited;
end;//Tkw_FoldersElementInfo_Control_NamePanel_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_NamePanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::NamePanel:push';
end;//Tkw_FoldersElementInfo_Control_NamePanel_Push.GetWordNameForRegister

type
  Tkw_FoldersElementInfo_Control_lblElementName = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола lblElementName
----
*Пример использования*:
[code]
контрол::lblElementName TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_FoldersElementInfo_Control_lblElementName

// start class Tkw_FoldersElementInfo_Control_lblElementName

class function Tkw_FoldersElementInfo_Control_lblElementName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblElementName';
end;//Tkw_FoldersElementInfo_Control_lblElementName.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_lblElementName.GetString: AnsiString;
 {-}
begin
 Result := 'lblElementName';
end;//Tkw_FoldersElementInfo_Control_lblElementName.GetString

class procedure Tkw_FoldersElementInfo_Control_lblElementName.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_FoldersElementInfo_Control_lblElementName.RegisterInEngine

type
  Tkw_FoldersElementInfo_Control_lblElementName_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола lblElementName
----
*Пример использования*:
[code]
контрол::lblElementName:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_FoldersElementInfo_Control_lblElementName_Push

// start class Tkw_FoldersElementInfo_Control_lblElementName_Push

procedure Tkw_FoldersElementInfo_Control_lblElementName_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lblElementName');
 inherited;
end;//Tkw_FoldersElementInfo_Control_lblElementName_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_lblElementName_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblElementName:push';
end;//Tkw_FoldersElementInfo_Control_lblElementName_Push.GetWordNameForRegister

type
  Tkw_FoldersElementInfo_Control_ElementName = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола ElementName
----
*Пример использования*:
[code]
контрол::ElementName TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_FoldersElementInfo_Control_ElementName

// start class Tkw_FoldersElementInfo_Control_ElementName

class function Tkw_FoldersElementInfo_Control_ElementName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ElementName';
end;//Tkw_FoldersElementInfo_Control_ElementName.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_ElementName.GetString: AnsiString;
 {-}
begin
 Result := 'ElementName';
end;//Tkw_FoldersElementInfo_Control_ElementName.GetString

class procedure Tkw_FoldersElementInfo_Control_ElementName.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscComboBoxWithReadOnly);
end;//Tkw_FoldersElementInfo_Control_ElementName.RegisterInEngine

type
  Tkw_FoldersElementInfo_Control_ElementName_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола ElementName
----
*Пример использования*:
[code]
контрол::ElementName:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_FoldersElementInfo_Control_ElementName_Push

// start class Tkw_FoldersElementInfo_Control_ElementName_Push

procedure Tkw_FoldersElementInfo_Control_ElementName_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ElementName');
 inherited;
end;//Tkw_FoldersElementInfo_Control_ElementName_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_ElementName_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ElementName:push';
end;//Tkw_FoldersElementInfo_Control_ElementName_Push.GetWordNameForRegister

type
  Tkw_FoldersElementInfo_Control_cbShared = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола cbShared
----
*Пример использования*:
[code]
контрол::cbShared TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_FoldersElementInfo_Control_cbShared

// start class Tkw_FoldersElementInfo_Control_cbShared

class function Tkw_FoldersElementInfo_Control_cbShared.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::cbShared';
end;//Tkw_FoldersElementInfo_Control_cbShared.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_cbShared.GetString: AnsiString;
 {-}
begin
 Result := 'cbShared';
end;//Tkw_FoldersElementInfo_Control_cbShared.GetString

class procedure Tkw_FoldersElementInfo_Control_cbShared.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_FoldersElementInfo_Control_cbShared.RegisterInEngine

type
  Tkw_FoldersElementInfo_Control_cbShared_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола cbShared
----
*Пример использования*:
[code]
контрол::cbShared:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_FoldersElementInfo_Control_cbShared_Push

// start class Tkw_FoldersElementInfo_Control_cbShared_Push

procedure Tkw_FoldersElementInfo_Control_cbShared_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('cbShared');
 inherited;
end;//Tkw_FoldersElementInfo_Control_cbShared_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_cbShared_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::cbShared:push';
end;//Tkw_FoldersElementInfo_Control_cbShared_Push.GetWordNameForRegister

type
  Tkw_FoldersElementInfo_Control_InfoName = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола InfoName
----
*Пример использования*:
[code]
контрол::InfoName TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_FoldersElementInfo_Control_InfoName

// start class Tkw_FoldersElementInfo_Control_InfoName

class function Tkw_FoldersElementInfo_Control_InfoName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::InfoName';
end;//Tkw_FoldersElementInfo_Control_InfoName.GetWordNameForRegister

function Tkw_FoldersElementInfo_Control_InfoName.GetString: AnsiString;
 {-}
begin
 Result := 'InfoName';
end;//Tkw_FoldersElementInfo_Control_InfoName.GetString

class procedure Tkw_FoldersElementInfo_Control_InfoName.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_FoldersElementInfo_Control_InfoName.RegisterInEngine

type
  Tkw_FoldersElementInfo_Control_InfoName_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола InfoName
----
*Пример использования*:
[code]
контрол::InfoName:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_FoldersElementInfo_Control_InfoName_Push

// start class Tkw_FoldersElementInfo_Control_InfoName_Push

procedure Tkw_FoldersElementInfo_Control_InfoName_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('InfoName');
 inherited;
end;//Tkw_FoldersElementInfo_Control_InfoName_Push.DoDoIt

class function Tkw_FoldersElementInfo_Control_InfoName_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::InfoName:push';
end;//Tkw_FoldersElementInfo_Control_InfoName_Push.GetWordNameForRegister

type
  TkwEnFoldersElementInfoCommentPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenFoldersElementInfo.CommentPanel
[panel]Контрол CommentPanel формы TenFoldersElementInfo[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aenFoldersElementInfo .TenFoldersElementInfo.CommentPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function CommentPanel(const aCtx: TtfwContext;
     aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
     {* Реализация слова скрипта .TenFoldersElementInfo.CommentPanel }
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
  end;//TkwEnFoldersElementInfoCommentPanel

// start class TkwEnFoldersElementInfoCommentPanel

function TkwEnFoldersElementInfoCommentPanel.CommentPanel(const aCtx: TtfwContext;
  aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
 {-}
begin
 Result := aenFoldersElementInfo.CommentPanel;
end;//TkwEnFoldersElementInfoCommentPanel.CommentPanel

procedure TkwEnFoldersElementInfoCommentPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenFoldersElementInfo : TenFoldersElementInfo;
begin
 try
  l_aenFoldersElementInfo := TenFoldersElementInfo(aCtx.rEngine.PopObjAs(TenFoldersElementInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersElementInfo: TenFoldersElementInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((CommentPanel(aCtx, l_aenFoldersElementInfo)));
end;//TkwEnFoldersElementInfoCommentPanel.DoDoIt

class function TkwEnFoldersElementInfoCommentPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenFoldersElementInfo.CommentPanel';
end;//TkwEnFoldersElementInfoCommentPanel.GetWordNameForRegister

procedure TkwEnFoldersElementInfoCommentPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству CommentPanel', aCtx);
end;//TkwEnFoldersElementInfoCommentPanel.SetValuePrim

function TkwEnFoldersElementInfoCommentPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnFoldersElementInfoCommentPanel.GetResultTypeInfo

function TkwEnFoldersElementInfoCommentPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnFoldersElementInfoCommentPanel.GetAllParamsCount

function TkwEnFoldersElementInfoCommentPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersElementInfo)]);
end;//TkwEnFoldersElementInfoCommentPanel.ParamsTypes

type
  TkwEnFoldersElementInfoElementComment = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenFoldersElementInfo.ElementComment
[panel]Контрол ElementComment формы TenFoldersElementInfo[panel]
*Тип результата:* TeeMemoWithEditOperations
*Пример:*
[code]
OBJECT VAR l_TeeMemoWithEditOperations
 aenFoldersElementInfo .TenFoldersElementInfo.ElementComment >>> l_TeeMemoWithEditOperations
[code]  }
  private
  // private methods
   function ElementComment(const aCtx: TtfwContext;
     aenFoldersElementInfo: TenFoldersElementInfo): TeeMemoWithEditOperations;
     {* Реализация слова скрипта .TenFoldersElementInfo.ElementComment }
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
  end;//TkwEnFoldersElementInfoElementComment

// start class TkwEnFoldersElementInfoElementComment

function TkwEnFoldersElementInfoElementComment.ElementComment(const aCtx: TtfwContext;
  aenFoldersElementInfo: TenFoldersElementInfo): TeeMemoWithEditOperations;
 {-}
begin
 Result := aenFoldersElementInfo.ElementComment;
end;//TkwEnFoldersElementInfoElementComment.ElementComment

procedure TkwEnFoldersElementInfoElementComment.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenFoldersElementInfo : TenFoldersElementInfo;
begin
 try
  l_aenFoldersElementInfo := TenFoldersElementInfo(aCtx.rEngine.PopObjAs(TenFoldersElementInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersElementInfo: TenFoldersElementInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ElementComment(aCtx, l_aenFoldersElementInfo)));
end;//TkwEnFoldersElementInfoElementComment.DoDoIt

class function TkwEnFoldersElementInfoElementComment.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenFoldersElementInfo.ElementComment';
end;//TkwEnFoldersElementInfoElementComment.GetWordNameForRegister

procedure TkwEnFoldersElementInfoElementComment.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ElementComment', aCtx);
end;//TkwEnFoldersElementInfoElementComment.SetValuePrim

function TkwEnFoldersElementInfoElementComment.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeMemoWithEditOperations);
end;//TkwEnFoldersElementInfoElementComment.GetResultTypeInfo

function TkwEnFoldersElementInfoElementComment.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnFoldersElementInfoElementComment.GetAllParamsCount

function TkwEnFoldersElementInfoElementComment.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersElementInfo)]);
end;//TkwEnFoldersElementInfoElementComment.ParamsTypes

type
  TkwEnFoldersElementInfoCaptionPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenFoldersElementInfo.CaptionPanel
[panel]Контрол CaptionPanel формы TenFoldersElementInfo[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aenFoldersElementInfo .TenFoldersElementInfo.CaptionPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function CaptionPanel(const aCtx: TtfwContext;
     aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
     {* Реализация слова скрипта .TenFoldersElementInfo.CaptionPanel }
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
  end;//TkwEnFoldersElementInfoCaptionPanel

// start class TkwEnFoldersElementInfoCaptionPanel

function TkwEnFoldersElementInfoCaptionPanel.CaptionPanel(const aCtx: TtfwContext;
  aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
 {-}
begin
 Result := aenFoldersElementInfo.CaptionPanel;
end;//TkwEnFoldersElementInfoCaptionPanel.CaptionPanel

procedure TkwEnFoldersElementInfoCaptionPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenFoldersElementInfo : TenFoldersElementInfo;
begin
 try
  l_aenFoldersElementInfo := TenFoldersElementInfo(aCtx.rEngine.PopObjAs(TenFoldersElementInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersElementInfo: TenFoldersElementInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((CaptionPanel(aCtx, l_aenFoldersElementInfo)));
end;//TkwEnFoldersElementInfoCaptionPanel.DoDoIt

class function TkwEnFoldersElementInfoCaptionPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenFoldersElementInfo.CaptionPanel';
end;//TkwEnFoldersElementInfoCaptionPanel.GetWordNameForRegister

procedure TkwEnFoldersElementInfoCaptionPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству CaptionPanel', aCtx);
end;//TkwEnFoldersElementInfoCaptionPanel.SetValuePrim

function TkwEnFoldersElementInfoCaptionPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnFoldersElementInfoCaptionPanel.GetResultTypeInfo

function TkwEnFoldersElementInfoCaptionPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnFoldersElementInfoCaptionPanel.GetAllParamsCount

function TkwEnFoldersElementInfoCaptionPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersElementInfo)]);
end;//TkwEnFoldersElementInfoCaptionPanel.ParamsTypes

type
  TkwEnFoldersElementInfoLblComment = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenFoldersElementInfo.lblComment
[panel]Контрол lblComment формы TenFoldersElementInfo[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aenFoldersElementInfo .TenFoldersElementInfo.lblComment >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LblComment(const aCtx: TtfwContext;
     aenFoldersElementInfo: TenFoldersElementInfo): TvtLabel;
     {* Реализация слова скрипта .TenFoldersElementInfo.lblComment }
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
  end;//TkwEnFoldersElementInfoLblComment

// start class TkwEnFoldersElementInfoLblComment

function TkwEnFoldersElementInfoLblComment.LblComment(const aCtx: TtfwContext;
  aenFoldersElementInfo: TenFoldersElementInfo): TvtLabel;
 {-}
begin
 Result := aenFoldersElementInfo.lblComment;
end;//TkwEnFoldersElementInfoLblComment.LblComment

procedure TkwEnFoldersElementInfoLblComment.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenFoldersElementInfo : TenFoldersElementInfo;
begin
 try
  l_aenFoldersElementInfo := TenFoldersElementInfo(aCtx.rEngine.PopObjAs(TenFoldersElementInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersElementInfo: TenFoldersElementInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LblComment(aCtx, l_aenFoldersElementInfo)));
end;//TkwEnFoldersElementInfoLblComment.DoDoIt

class function TkwEnFoldersElementInfoLblComment.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenFoldersElementInfo.lblComment';
end;//TkwEnFoldersElementInfoLblComment.GetWordNameForRegister

procedure TkwEnFoldersElementInfoLblComment.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblComment', aCtx);
end;//TkwEnFoldersElementInfoLblComment.SetValuePrim

function TkwEnFoldersElementInfoLblComment.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnFoldersElementInfoLblComment.GetResultTypeInfo

function TkwEnFoldersElementInfoLblComment.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnFoldersElementInfoLblComment.GetAllParamsCount

function TkwEnFoldersElementInfoLblComment.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersElementInfo)]);
end;//TkwEnFoldersElementInfoLblComment.ParamsTypes

type
  TkwEnFoldersElementInfoTopPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenFoldersElementInfo.TopPanel
[panel]Контрол TopPanel формы TenFoldersElementInfo[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aenFoldersElementInfo .TenFoldersElementInfo.TopPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function TopPanel(const aCtx: TtfwContext;
     aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
     {* Реализация слова скрипта .TenFoldersElementInfo.TopPanel }
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
  end;//TkwEnFoldersElementInfoTopPanel

// start class TkwEnFoldersElementInfoTopPanel

function TkwEnFoldersElementInfoTopPanel.TopPanel(const aCtx: TtfwContext;
  aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
 {-}
begin
 Result := aenFoldersElementInfo.TopPanel;
end;//TkwEnFoldersElementInfoTopPanel.TopPanel

procedure TkwEnFoldersElementInfoTopPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenFoldersElementInfo : TenFoldersElementInfo;
begin
 try
  l_aenFoldersElementInfo := TenFoldersElementInfo(aCtx.rEngine.PopObjAs(TenFoldersElementInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersElementInfo: TenFoldersElementInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TopPanel(aCtx, l_aenFoldersElementInfo)));
end;//TkwEnFoldersElementInfoTopPanel.DoDoIt

class function TkwEnFoldersElementInfoTopPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenFoldersElementInfo.TopPanel';
end;//TkwEnFoldersElementInfoTopPanel.GetWordNameForRegister

procedure TkwEnFoldersElementInfoTopPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству TopPanel', aCtx);
end;//TkwEnFoldersElementInfoTopPanel.SetValuePrim

function TkwEnFoldersElementInfoTopPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnFoldersElementInfoTopPanel.GetResultTypeInfo

function TkwEnFoldersElementInfoTopPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnFoldersElementInfoTopPanel.GetAllParamsCount

function TkwEnFoldersElementInfoTopPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersElementInfo)]);
end;//TkwEnFoldersElementInfoTopPanel.ParamsTypes

type
  TkwEnFoldersElementInfoNamePanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenFoldersElementInfo.NamePanel
[panel]Контрол NamePanel формы TenFoldersElementInfo[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aenFoldersElementInfo .TenFoldersElementInfo.NamePanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function NamePanel(const aCtx: TtfwContext;
     aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
     {* Реализация слова скрипта .TenFoldersElementInfo.NamePanel }
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
  end;//TkwEnFoldersElementInfoNamePanel

// start class TkwEnFoldersElementInfoNamePanel

function TkwEnFoldersElementInfoNamePanel.NamePanel(const aCtx: TtfwContext;
  aenFoldersElementInfo: TenFoldersElementInfo): TvtPanel;
 {-}
begin
 Result := aenFoldersElementInfo.NamePanel;
end;//TkwEnFoldersElementInfoNamePanel.NamePanel

procedure TkwEnFoldersElementInfoNamePanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenFoldersElementInfo : TenFoldersElementInfo;
begin
 try
  l_aenFoldersElementInfo := TenFoldersElementInfo(aCtx.rEngine.PopObjAs(TenFoldersElementInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersElementInfo: TenFoldersElementInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((NamePanel(aCtx, l_aenFoldersElementInfo)));
end;//TkwEnFoldersElementInfoNamePanel.DoDoIt

class function TkwEnFoldersElementInfoNamePanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenFoldersElementInfo.NamePanel';
end;//TkwEnFoldersElementInfoNamePanel.GetWordNameForRegister

procedure TkwEnFoldersElementInfoNamePanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству NamePanel', aCtx);
end;//TkwEnFoldersElementInfoNamePanel.SetValuePrim

function TkwEnFoldersElementInfoNamePanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnFoldersElementInfoNamePanel.GetResultTypeInfo

function TkwEnFoldersElementInfoNamePanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnFoldersElementInfoNamePanel.GetAllParamsCount

function TkwEnFoldersElementInfoNamePanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersElementInfo)]);
end;//TkwEnFoldersElementInfoNamePanel.ParamsTypes

type
  TkwEnFoldersElementInfoLblElementName = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenFoldersElementInfo.lblElementName
[panel]Контрол lblElementName формы TenFoldersElementInfo[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aenFoldersElementInfo .TenFoldersElementInfo.lblElementName >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LblElementName(const aCtx: TtfwContext;
     aenFoldersElementInfo: TenFoldersElementInfo): TvtLabel;
     {* Реализация слова скрипта .TenFoldersElementInfo.lblElementName }
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
  end;//TkwEnFoldersElementInfoLblElementName

// start class TkwEnFoldersElementInfoLblElementName

function TkwEnFoldersElementInfoLblElementName.LblElementName(const aCtx: TtfwContext;
  aenFoldersElementInfo: TenFoldersElementInfo): TvtLabel;
 {-}
begin
 Result := aenFoldersElementInfo.lblElementName;
end;//TkwEnFoldersElementInfoLblElementName.LblElementName

procedure TkwEnFoldersElementInfoLblElementName.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenFoldersElementInfo : TenFoldersElementInfo;
begin
 try
  l_aenFoldersElementInfo := TenFoldersElementInfo(aCtx.rEngine.PopObjAs(TenFoldersElementInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersElementInfo: TenFoldersElementInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LblElementName(aCtx, l_aenFoldersElementInfo)));
end;//TkwEnFoldersElementInfoLblElementName.DoDoIt

class function TkwEnFoldersElementInfoLblElementName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenFoldersElementInfo.lblElementName';
end;//TkwEnFoldersElementInfoLblElementName.GetWordNameForRegister

procedure TkwEnFoldersElementInfoLblElementName.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblElementName', aCtx);
end;//TkwEnFoldersElementInfoLblElementName.SetValuePrim

function TkwEnFoldersElementInfoLblElementName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnFoldersElementInfoLblElementName.GetResultTypeInfo

function TkwEnFoldersElementInfoLblElementName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnFoldersElementInfoLblElementName.GetAllParamsCount

function TkwEnFoldersElementInfoLblElementName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersElementInfo)]);
end;//TkwEnFoldersElementInfoLblElementName.ParamsTypes

type
  TkwEnFoldersElementInfoElementName = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenFoldersElementInfo.ElementName
[panel]Контрол ElementName формы TenFoldersElementInfo[panel]
*Тип результата:* TnscComboBoxWithReadOnly
*Пример:*
[code]
OBJECT VAR l_TnscComboBoxWithReadOnly
 aenFoldersElementInfo .TenFoldersElementInfo.ElementName >>> l_TnscComboBoxWithReadOnly
[code]  }
  private
  // private methods
   function ElementName(const aCtx: TtfwContext;
     aenFoldersElementInfo: TenFoldersElementInfo): TnscComboBoxWithReadOnly;
     {* Реализация слова скрипта .TenFoldersElementInfo.ElementName }
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
  end;//TkwEnFoldersElementInfoElementName

// start class TkwEnFoldersElementInfoElementName

function TkwEnFoldersElementInfoElementName.ElementName(const aCtx: TtfwContext;
  aenFoldersElementInfo: TenFoldersElementInfo): TnscComboBoxWithReadOnly;
 {-}
begin
 Result := aenFoldersElementInfo.ElementName;
end;//TkwEnFoldersElementInfoElementName.ElementName

procedure TkwEnFoldersElementInfoElementName.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenFoldersElementInfo : TenFoldersElementInfo;
begin
 try
  l_aenFoldersElementInfo := TenFoldersElementInfo(aCtx.rEngine.PopObjAs(TenFoldersElementInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersElementInfo: TenFoldersElementInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ElementName(aCtx, l_aenFoldersElementInfo)));
end;//TkwEnFoldersElementInfoElementName.DoDoIt

class function TkwEnFoldersElementInfoElementName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenFoldersElementInfo.ElementName';
end;//TkwEnFoldersElementInfoElementName.GetWordNameForRegister

procedure TkwEnFoldersElementInfoElementName.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ElementName', aCtx);
end;//TkwEnFoldersElementInfoElementName.SetValuePrim

function TkwEnFoldersElementInfoElementName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscComboBoxWithReadOnly);
end;//TkwEnFoldersElementInfoElementName.GetResultTypeInfo

function TkwEnFoldersElementInfoElementName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnFoldersElementInfoElementName.GetAllParamsCount

function TkwEnFoldersElementInfoElementName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersElementInfo)]);
end;//TkwEnFoldersElementInfoElementName.ParamsTypes

type
  TkwEnFoldersElementInfoCbShared = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenFoldersElementInfo.cbShared
[panel]Контрол cbShared формы TenFoldersElementInfo[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aenFoldersElementInfo .TenFoldersElementInfo.cbShared >>> l_TvtCheckBox
[code]  }
  private
  // private methods
   function CbShared(const aCtx: TtfwContext;
     aenFoldersElementInfo: TenFoldersElementInfo): TvtCheckBox;
     {* Реализация слова скрипта .TenFoldersElementInfo.cbShared }
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
  end;//TkwEnFoldersElementInfoCbShared

// start class TkwEnFoldersElementInfoCbShared

function TkwEnFoldersElementInfoCbShared.CbShared(const aCtx: TtfwContext;
  aenFoldersElementInfo: TenFoldersElementInfo): TvtCheckBox;
 {-}
begin
 Result := aenFoldersElementInfo.cbShared;
end;//TkwEnFoldersElementInfoCbShared.CbShared

procedure TkwEnFoldersElementInfoCbShared.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenFoldersElementInfo : TenFoldersElementInfo;
begin
 try
  l_aenFoldersElementInfo := TenFoldersElementInfo(aCtx.rEngine.PopObjAs(TenFoldersElementInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersElementInfo: TenFoldersElementInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((CbShared(aCtx, l_aenFoldersElementInfo)));
end;//TkwEnFoldersElementInfoCbShared.DoDoIt

class function TkwEnFoldersElementInfoCbShared.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenFoldersElementInfo.cbShared';
end;//TkwEnFoldersElementInfoCbShared.GetWordNameForRegister

procedure TkwEnFoldersElementInfoCbShared.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству cbShared', aCtx);
end;//TkwEnFoldersElementInfoCbShared.SetValuePrim

function TkwEnFoldersElementInfoCbShared.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwEnFoldersElementInfoCbShared.GetResultTypeInfo

function TkwEnFoldersElementInfoCbShared.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnFoldersElementInfoCbShared.GetAllParamsCount

function TkwEnFoldersElementInfoCbShared.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersElementInfo)]);
end;//TkwEnFoldersElementInfoCbShared.ParamsTypes

type
  TkwEnFoldersElementInfoInfoName = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TenFoldersElementInfo.InfoName
[panel]Контрол InfoName формы TenFoldersElementInfo[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aenFoldersElementInfo .TenFoldersElementInfo.InfoName >>> l_TvtLabel
[code]  }
  private
  // private methods
   function InfoName(const aCtx: TtfwContext;
     aenFoldersElementInfo: TenFoldersElementInfo): TvtLabel;
     {* Реализация слова скрипта .TenFoldersElementInfo.InfoName }
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
  end;//TkwEnFoldersElementInfoInfoName

// start class TkwEnFoldersElementInfoInfoName

function TkwEnFoldersElementInfoInfoName.InfoName(const aCtx: TtfwContext;
  aenFoldersElementInfo: TenFoldersElementInfo): TvtLabel;
 {-}
begin
 Result := aenFoldersElementInfo.InfoName;
end;//TkwEnFoldersElementInfoInfoName.InfoName

procedure TkwEnFoldersElementInfoInfoName.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aenFoldersElementInfo : TenFoldersElementInfo;
begin
 try
  l_aenFoldersElementInfo := TenFoldersElementInfo(aCtx.rEngine.PopObjAs(TenFoldersElementInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenFoldersElementInfo: TenFoldersElementInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((InfoName(aCtx, l_aenFoldersElementInfo)));
end;//TkwEnFoldersElementInfoInfoName.DoDoIt

class function TkwEnFoldersElementInfoInfoName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TenFoldersElementInfo.InfoName';
end;//TkwEnFoldersElementInfoInfoName.GetWordNameForRegister

procedure TkwEnFoldersElementInfoInfoName.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству InfoName', aCtx);
end;//TkwEnFoldersElementInfoInfoName.SetValuePrim

function TkwEnFoldersElementInfoInfoName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEnFoldersElementInfoInfoName.GetResultTypeInfo

function TkwEnFoldersElementInfoInfoName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnFoldersElementInfoInfoName.GetAllParamsCount

function TkwEnFoldersElementInfoInfoName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TenFoldersElementInfo)]);
end;//TkwEnFoldersElementInfoInfoName.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_FoldersElementInfo
 Tkw_Form_FoldersElementInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersElementInfo_Control_CommentPanel
 Tkw_FoldersElementInfo_Control_CommentPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersElementInfo_Control_CommentPanel_Push
 Tkw_FoldersElementInfo_Control_CommentPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersElementInfo_Control_ElementComment
 Tkw_FoldersElementInfo_Control_ElementComment.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersElementInfo_Control_ElementComment_Push
 Tkw_FoldersElementInfo_Control_ElementComment_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersElementInfo_Control_CaptionPanel
 Tkw_FoldersElementInfo_Control_CaptionPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersElementInfo_Control_CaptionPanel_Push
 Tkw_FoldersElementInfo_Control_CaptionPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersElementInfo_Control_lblComment
 Tkw_FoldersElementInfo_Control_lblComment.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersElementInfo_Control_lblComment_Push
 Tkw_FoldersElementInfo_Control_lblComment_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersElementInfo_Control_TopPanel
 Tkw_FoldersElementInfo_Control_TopPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersElementInfo_Control_TopPanel_Push
 Tkw_FoldersElementInfo_Control_TopPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersElementInfo_Control_NamePanel
 Tkw_FoldersElementInfo_Control_NamePanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersElementInfo_Control_NamePanel_Push
 Tkw_FoldersElementInfo_Control_NamePanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersElementInfo_Control_lblElementName
 Tkw_FoldersElementInfo_Control_lblElementName.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersElementInfo_Control_lblElementName_Push
 Tkw_FoldersElementInfo_Control_lblElementName_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersElementInfo_Control_ElementName
 Tkw_FoldersElementInfo_Control_ElementName.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersElementInfo_Control_ElementName_Push
 Tkw_FoldersElementInfo_Control_ElementName_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersElementInfo_Control_cbShared
 Tkw_FoldersElementInfo_Control_cbShared.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersElementInfo_Control_cbShared_Push
 Tkw_FoldersElementInfo_Control_cbShared_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersElementInfo_Control_InfoName
 Tkw_FoldersElementInfo_Control_InfoName.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FoldersElementInfo_Control_InfoName_Push
 Tkw_FoldersElementInfo_Control_InfoName_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enFoldersElementInfo_CommentPanel
 TkwEnFoldersElementInfoCommentPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enFoldersElementInfo_ElementComment
 TkwEnFoldersElementInfoElementComment.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enFoldersElementInfo_CaptionPanel
 TkwEnFoldersElementInfoCaptionPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enFoldersElementInfo_lblComment
 TkwEnFoldersElementInfoLblComment.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enFoldersElementInfo_TopPanel
 TkwEnFoldersElementInfoTopPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enFoldersElementInfo_NamePanel
 TkwEnFoldersElementInfoNamePanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enFoldersElementInfo_lblElementName
 TkwEnFoldersElementInfoLblElementName.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enFoldersElementInfo_ElementName
 TkwEnFoldersElementInfoElementName.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enFoldersElementInfo_cbShared
 TkwEnFoldersElementInfoCbShared.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация enFoldersElementInfo_InfoName
 TkwEnFoldersElementInfoInfoName.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа FoldersElementInfo
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenFoldersElementInfo));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TeeMemoWithEditOperations
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeMemoWithEditOperations));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscComboBoxWithReadOnly
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscComboBoxWithReadOnly));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtCheckBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCheckBox));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.