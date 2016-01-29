unit MemoryUsageKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/MemoryUsageKeywordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Оболочка Без Прецедентов::F1 Without Usecases::View::Main::MemoryUsageKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы MemoryUsage
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
  evMemo,
  eeTreeView,
  vtSizeablePanel,
  vtPanel,
  vtLabel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  MemoryUsage_Form,
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
 Tkw_Form_MemoryUsage = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора формы MemoryUsage
----
*Пример использования*:
[code]
'aControl' форма::MemoryUsage TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_MemoryUsage

// start class Tkw_Form_MemoryUsage

class function Tkw_Form_MemoryUsage.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::MemoryUsage';
end;//Tkw_Form_MemoryUsage.GetWordNameForRegister

function Tkw_Form_MemoryUsage.GetString: AnsiString;
 {-}
begin
 Result := 'MemoryUsageForm';
end;//Tkw_Form_MemoryUsage.GetString

type
 Tkw_MemoryUsage_Control_pnTagTree = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnTagTree
----
*Пример использования*:
[code]
контрол::pnTagTree TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_pnTagTree

// start class Tkw_MemoryUsage_Control_pnTagTree

class function Tkw_MemoryUsage_Control_pnTagTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnTagTree';
end;//Tkw_MemoryUsage_Control_pnTagTree.GetWordNameForRegister

function Tkw_MemoryUsage_Control_pnTagTree.GetString: AnsiString;
 {-}
begin
 Result := 'pnTagTree';
end;//Tkw_MemoryUsage_Control_pnTagTree.GetString

class procedure Tkw_MemoryUsage_Control_pnTagTree.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MemoryUsage_Control_pnTagTree.RegisterInEngine

type
 Tkw_MemoryUsage_Control_pnTagTree_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnTagTree
----
*Пример использования*:
[code]
контрол::pnTagTree:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_pnTagTree_Push

// start class Tkw_MemoryUsage_Control_pnTagTree_Push

procedure Tkw_MemoryUsage_Control_pnTagTree_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnTagTree');
 inherited;
end;//Tkw_MemoryUsage_Control_pnTagTree_Push.DoDoIt

class function Tkw_MemoryUsage_Control_pnTagTree_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnTagTree:push';
end;//Tkw_MemoryUsage_Control_pnTagTree_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_TagTree = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TagTree
----
*Пример использования*:
[code]
контрол::TagTree TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_TagTree

// start class Tkw_MemoryUsage_Control_TagTree

class function Tkw_MemoryUsage_Control_TagTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::TagTree';
end;//Tkw_MemoryUsage_Control_TagTree.GetWordNameForRegister

function Tkw_MemoryUsage_Control_TagTree.GetString: AnsiString;
 {-}
begin
 Result := 'TagTree';
end;//Tkw_MemoryUsage_Control_TagTree.GetString

class procedure Tkw_MemoryUsage_Control_TagTree.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeTreeView);
end;//Tkw_MemoryUsage_Control_TagTree.RegisterInEngine

type
 Tkw_MemoryUsage_Control_TagTree_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола TagTree
----
*Пример использования*:
[code]
контрол::TagTree:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_TagTree_Push

// start class Tkw_MemoryUsage_Control_TagTree_Push

procedure Tkw_MemoryUsage_Control_TagTree_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('TagTree');
 inherited;
end;//Tkw_MemoryUsage_Control_TagTree_Push.DoDoIt

class function Tkw_MemoryUsage_Control_TagTree_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::TagTree:push';
end;//Tkw_MemoryUsage_Control_TagTree_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_pnMemClasses = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnMemClasses
----
*Пример использования*:
[code]
контрол::pnMemClasses TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_pnMemClasses

// start class Tkw_MemoryUsage_Control_pnMemClasses

class function Tkw_MemoryUsage_Control_pnMemClasses.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnMemClasses';
end;//Tkw_MemoryUsage_Control_pnMemClasses.GetWordNameForRegister

function Tkw_MemoryUsage_Control_pnMemClasses.GetString: AnsiString;
 {-}
begin
 Result := 'pnMemClasses';
end;//Tkw_MemoryUsage_Control_pnMemClasses.GetString

class procedure Tkw_MemoryUsage_Control_pnMemClasses.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_MemoryUsage_Control_pnMemClasses.RegisterInEngine

type
 Tkw_MemoryUsage_Control_pnMemClasses_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnMemClasses
----
*Пример использования*:
[code]
контрол::pnMemClasses:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_pnMemClasses_Push

// start class Tkw_MemoryUsage_Control_pnMemClasses_Push

procedure Tkw_MemoryUsage_Control_pnMemClasses_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnMemClasses');
 inherited;
end;//Tkw_MemoryUsage_Control_pnMemClasses_Push.DoDoIt

class function Tkw_MemoryUsage_Control_pnMemClasses_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnMemClasses:push';
end;//Tkw_MemoryUsage_Control_pnMemClasses_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_memClasses = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола memClasses
----
*Пример использования*:
[code]
контрол::memClasses TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_memClasses

// start class Tkw_MemoryUsage_Control_memClasses

class function Tkw_MemoryUsage_Control_memClasses.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::memClasses';
end;//Tkw_MemoryUsage_Control_memClasses.GetWordNameForRegister

function Tkw_MemoryUsage_Control_memClasses.GetString: AnsiString;
 {-}
begin
 Result := 'memClasses';
end;//Tkw_MemoryUsage_Control_memClasses.GetString

class procedure Tkw_MemoryUsage_Control_memClasses.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TevMemo);
end;//Tkw_MemoryUsage_Control_memClasses.RegisterInEngine

type
 Tkw_MemoryUsage_Control_memClasses_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола memClasses
----
*Пример использования*:
[code]
контрол::memClasses:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_memClasses_Push

// start class Tkw_MemoryUsage_Control_memClasses_Push

procedure Tkw_MemoryUsage_Control_memClasses_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('memClasses');
 inherited;
end;//Tkw_MemoryUsage_Control_memClasses_Push.DoDoIt

class function Tkw_MemoryUsage_Control_memClasses_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::memClasses:push';
end;//Tkw_MemoryUsage_Control_memClasses_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_pnSummary = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnSummary
----
*Пример использования*:
[code]
контрол::pnSummary TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_pnSummary

// start class Tkw_MemoryUsage_Control_pnSummary

class function Tkw_MemoryUsage_Control_pnSummary.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnSummary';
end;//Tkw_MemoryUsage_Control_pnSummary.GetWordNameForRegister

function Tkw_MemoryUsage_Control_pnSummary.GetString: AnsiString;
 {-}
begin
 Result := 'pnSummary';
end;//Tkw_MemoryUsage_Control_pnSummary.GetString

class procedure Tkw_MemoryUsage_Control_pnSummary.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_MemoryUsage_Control_pnSummary.RegisterInEngine

type
 Tkw_MemoryUsage_Control_pnSummary_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnSummary
----
*Пример использования*:
[code]
контрол::pnSummary:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_pnSummary_Push

// start class Tkw_MemoryUsage_Control_pnSummary_Push

procedure Tkw_MemoryUsage_Control_pnSummary_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('pnSummary');
 inherited;
end;//Tkw_MemoryUsage_Control_pnSummary_Push.DoDoIt

class function Tkw_MemoryUsage_Control_pnSummary_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::pnSummary:push';
end;//Tkw_MemoryUsage_Control_pnSummary_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_lbLocalMemory = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lbLocalMemory
----
*Пример использования*:
[code]
контрол::lbLocalMemory TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbLocalMemory

// start class Tkw_MemoryUsage_Control_lbLocalMemory

class function Tkw_MemoryUsage_Control_lbLocalMemory.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lbLocalMemory';
end;//Tkw_MemoryUsage_Control_lbLocalMemory.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbLocalMemory.GetString: AnsiString;
 {-}
begin
 Result := 'lbLocalMemory';
end;//Tkw_MemoryUsage_Control_lbLocalMemory.GetString

class procedure Tkw_MemoryUsage_Control_lbLocalMemory.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_MemoryUsage_Control_lbLocalMemory.RegisterInEngine

type
 Tkw_MemoryUsage_Control_lbLocalMemory_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола lbLocalMemory
----
*Пример использования*:
[code]
контрол::lbLocalMemory:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbLocalMemory_Push

// start class Tkw_MemoryUsage_Control_lbLocalMemory_Push

procedure Tkw_MemoryUsage_Control_lbLocalMemory_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lbLocalMemory');
 inherited;
end;//Tkw_MemoryUsage_Control_lbLocalMemory_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbLocalMemory_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lbLocalMemory:push';
end;//Tkw_MemoryUsage_Control_lbLocalMemory_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_lbObjectMemory = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lbObjectMemory
----
*Пример использования*:
[code]
контрол::lbObjectMemory TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbObjectMemory

// start class Tkw_MemoryUsage_Control_lbObjectMemory

class function Tkw_MemoryUsage_Control_lbObjectMemory.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lbObjectMemory';
end;//Tkw_MemoryUsage_Control_lbObjectMemory.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbObjectMemory.GetString: AnsiString;
 {-}
begin
 Result := 'lbObjectMemory';
end;//Tkw_MemoryUsage_Control_lbObjectMemory.GetString

class procedure Tkw_MemoryUsage_Control_lbObjectMemory.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_MemoryUsage_Control_lbObjectMemory.RegisterInEngine

type
 Tkw_MemoryUsage_Control_lbObjectMemory_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола lbObjectMemory
----
*Пример использования*:
[code]
контрол::lbObjectMemory:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbObjectMemory_Push

// start class Tkw_MemoryUsage_Control_lbObjectMemory_Push

procedure Tkw_MemoryUsage_Control_lbObjectMemory_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lbObjectMemory');
 inherited;
end;//Tkw_MemoryUsage_Control_lbObjectMemory_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbObjectMemory_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lbObjectMemory:push';
end;//Tkw_MemoryUsage_Control_lbObjectMemory_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_lbObjectCount = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lbObjectCount
----
*Пример использования*:
[code]
контрол::lbObjectCount TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbObjectCount

// start class Tkw_MemoryUsage_Control_lbObjectCount

class function Tkw_MemoryUsage_Control_lbObjectCount.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lbObjectCount';
end;//Tkw_MemoryUsage_Control_lbObjectCount.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbObjectCount.GetString: AnsiString;
 {-}
begin
 Result := 'lbObjectCount';
end;//Tkw_MemoryUsage_Control_lbObjectCount.GetString

class procedure Tkw_MemoryUsage_Control_lbObjectCount.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_MemoryUsage_Control_lbObjectCount.RegisterInEngine

type
 Tkw_MemoryUsage_Control_lbObjectCount_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола lbObjectCount
----
*Пример использования*:
[code]
контрол::lbObjectCount:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbObjectCount_Push

// start class Tkw_MemoryUsage_Control_lbObjectCount_Push

procedure Tkw_MemoryUsage_Control_lbObjectCount_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lbObjectCount');
 inherited;
end;//Tkw_MemoryUsage_Control_lbObjectCount_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbObjectCount_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lbObjectCount:push';
end;//Tkw_MemoryUsage_Control_lbObjectCount_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_lbGlobalMemory = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lbGlobalMemory
----
*Пример использования*:
[code]
контрол::lbGlobalMemory TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbGlobalMemory

// start class Tkw_MemoryUsage_Control_lbGlobalMemory

class function Tkw_MemoryUsage_Control_lbGlobalMemory.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lbGlobalMemory';
end;//Tkw_MemoryUsage_Control_lbGlobalMemory.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbGlobalMemory.GetString: AnsiString;
 {-}
begin
 Result := 'lbGlobalMemory';
end;//Tkw_MemoryUsage_Control_lbGlobalMemory.GetString

class procedure Tkw_MemoryUsage_Control_lbGlobalMemory.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_MemoryUsage_Control_lbGlobalMemory.RegisterInEngine

type
 Tkw_MemoryUsage_Control_lbGlobalMemory_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола lbGlobalMemory
----
*Пример использования*:
[code]
контрол::lbGlobalMemory:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbGlobalMemory_Push

// start class Tkw_MemoryUsage_Control_lbGlobalMemory_Push

procedure Tkw_MemoryUsage_Control_lbGlobalMemory_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lbGlobalMemory');
 inherited;
end;//Tkw_MemoryUsage_Control_lbGlobalMemory_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbGlobalMemory_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lbGlobalMemory:push';
end;//Tkw_MemoryUsage_Control_lbGlobalMemory_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_lbDocumentsInCacheCount = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lbDocumentsInCacheCount
----
*Пример использования*:
[code]
контрол::lbDocumentsInCacheCount TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount

// start class Tkw_MemoryUsage_Control_lbDocumentsInCacheCount

class function Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lbDocumentsInCacheCount';
end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.GetString: AnsiString;
 {-}
begin
 Result := 'lbDocumentsInCacheCount';
end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.GetString

class procedure Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.RegisterInEngine

type
 Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола lbDocumentsInCacheCount
----
*Пример использования*:
[code]
контрол::lbDocumentsInCacheCount:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push

// start class Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push

procedure Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lbDocumentsInCacheCount');
 inherited;
end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lbDocumentsInCacheCount:push';
end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_lbAllLocalMemory = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lbAllLocalMemory
----
*Пример использования*:
[code]
контрол::lbAllLocalMemory TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbAllLocalMemory

// start class Tkw_MemoryUsage_Control_lbAllLocalMemory

class function Tkw_MemoryUsage_Control_lbAllLocalMemory.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lbAllLocalMemory';
end;//Tkw_MemoryUsage_Control_lbAllLocalMemory.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbAllLocalMemory.GetString: AnsiString;
 {-}
begin
 Result := 'lbAllLocalMemory';
end;//Tkw_MemoryUsage_Control_lbAllLocalMemory.GetString

class procedure Tkw_MemoryUsage_Control_lbAllLocalMemory.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_MemoryUsage_Control_lbAllLocalMemory.RegisterInEngine

type
 Tkw_MemoryUsage_Control_lbAllLocalMemory_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола lbAllLocalMemory
----
*Пример использования*:
[code]
контрол::lbAllLocalMemory:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbAllLocalMemory_Push

// start class Tkw_MemoryUsage_Control_lbAllLocalMemory_Push

procedure Tkw_MemoryUsage_Control_lbAllLocalMemory_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lbAllLocalMemory');
 inherited;
end;//Tkw_MemoryUsage_Control_lbAllLocalMemory_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbAllLocalMemory_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lbAllLocalMemory:push';
end;//Tkw_MemoryUsage_Control_lbAllLocalMemory_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_lbTotalMemory = {final scriptword} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lbTotalMemory
----
*Пример использования*:
[code]
контрол::lbTotalMemory TryFocus ASSERT
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MemoryUsage_Control_lbTotalMemory

// start class Tkw_MemoryUsage_Control_lbTotalMemory

class function Tkw_MemoryUsage_Control_lbTotalMemory.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lbTotalMemory';
end;//Tkw_MemoryUsage_Control_lbTotalMemory.GetWordNameForRegister

function Tkw_MemoryUsage_Control_lbTotalMemory.GetString: AnsiString;
 {-}
begin
 Result := 'lbTotalMemory';
end;//Tkw_MemoryUsage_Control_lbTotalMemory.GetString

class procedure Tkw_MemoryUsage_Control_lbTotalMemory.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_MemoryUsage_Control_lbTotalMemory.RegisterInEngine

type
 Tkw_MemoryUsage_Control_lbTotalMemory_Push = {final scriptword} class(TkwBynameControlPush)
  {* Слово словаря для контрола lbTotalMemory
----
*Пример использования*:
[code]
контрол::lbTotalMemory:push pop:control:SetFocus ASSERT
[code] }
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MemoryUsage_Control_lbTotalMemory_Push

// start class Tkw_MemoryUsage_Control_lbTotalMemory_Push

procedure Tkw_MemoryUsage_Control_lbTotalMemory_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lbTotalMemory');
 inherited;
end;//Tkw_MemoryUsage_Control_lbTotalMemory_Push.DoDoIt

class function Tkw_MemoryUsage_Control_lbTotalMemory_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lbTotalMemory:push';
end;//Tkw_MemoryUsage_Control_lbTotalMemory_Push.GetWordNameForRegister

type
 TkwMemoryUsageFormPnTagTree = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.pnTagTree
[panel]Контрол pnTagTree формы TMemoryUsageForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aMemoryUsageForm .TMemoryUsageForm.pnTagTree >>> l_TvtPanel
[code]  }
 private
 // private methods
   function PnTagTree(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtPanel;
     {* Реализация слова скрипта .TMemoryUsageForm.pnTagTree }
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
 end;//TkwMemoryUsageFormPnTagTree

// start class TkwMemoryUsageFormPnTagTree

function TkwMemoryUsageFormPnTagTree.PnTagTree(const aCtx: TtfwContext;
  aMemoryUsageForm: TMemoryUsageForm): TvtPanel;
 {-}
begin
 Result := aMemoryUsageForm.pnTagTree;
end;//TkwMemoryUsageFormPnTagTree.PnTagTree

procedure TkwMemoryUsageFormPnTagTree.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMemoryUsageForm : TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnTagTree(aCtx, l_aMemoryUsageForm)));
end;//TkwMemoryUsageFormPnTagTree.DoDoIt

class function TkwMemoryUsageFormPnTagTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMemoryUsageForm.pnTagTree';
end;//TkwMemoryUsageFormPnTagTree.GetWordNameForRegister

procedure TkwMemoryUsageFormPnTagTree.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnTagTree', aCtx);
end;//TkwMemoryUsageFormPnTagTree.SetValuePrim

function TkwMemoryUsageFormPnTagTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwMemoryUsageFormPnTagTree.GetResultTypeInfo

function TkwMemoryUsageFormPnTagTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMemoryUsageFormPnTagTree.GetAllParamsCount

function TkwMemoryUsageFormPnTagTree.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormPnTagTree.ParamsTypes

type
 TkwMemoryUsageFormTagTree = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.TagTree
[panel]Контрол TagTree формы TMemoryUsageForm[panel]
*Тип результата:* TeeTreeView
*Пример:*
[code]
OBJECT VAR l_TeeTreeView
 aMemoryUsageForm .TMemoryUsageForm.TagTree >>> l_TeeTreeView
[code]  }
 private
 // private methods
   function TagTree(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TeeTreeView;
     {* Реализация слова скрипта .TMemoryUsageForm.TagTree }
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
 end;//TkwMemoryUsageFormTagTree

// start class TkwMemoryUsageFormTagTree

function TkwMemoryUsageFormTagTree.TagTree(const aCtx: TtfwContext;
  aMemoryUsageForm: TMemoryUsageForm): TeeTreeView;
 {-}
begin
 Result := aMemoryUsageForm.TagTree;
end;//TkwMemoryUsageFormTagTree.TagTree

procedure TkwMemoryUsageFormTagTree.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMemoryUsageForm : TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TagTree(aCtx, l_aMemoryUsageForm)));
end;//TkwMemoryUsageFormTagTree.DoDoIt

class function TkwMemoryUsageFormTagTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMemoryUsageForm.TagTree';
end;//TkwMemoryUsageFormTagTree.GetWordNameForRegister

procedure TkwMemoryUsageFormTagTree.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству TagTree', aCtx);
end;//TkwMemoryUsageFormTagTree.SetValuePrim

function TkwMemoryUsageFormTagTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeTreeView);
end;//TkwMemoryUsageFormTagTree.GetResultTypeInfo

function TkwMemoryUsageFormTagTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMemoryUsageFormTagTree.GetAllParamsCount

function TkwMemoryUsageFormTagTree.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormTagTree.ParamsTypes

type
 TkwMemoryUsageFormPnMemClasses = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.pnMemClasses
[panel]Контрол pnMemClasses формы TMemoryUsageForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aMemoryUsageForm .TMemoryUsageForm.pnMemClasses >>> l_TvtSizeablePanel
[code]  }
 private
 // private methods
   function PnMemClasses(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtSizeablePanel;
     {* Реализация слова скрипта .TMemoryUsageForm.pnMemClasses }
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
 end;//TkwMemoryUsageFormPnMemClasses

// start class TkwMemoryUsageFormPnMemClasses

function TkwMemoryUsageFormPnMemClasses.PnMemClasses(const aCtx: TtfwContext;
  aMemoryUsageForm: TMemoryUsageForm): TvtSizeablePanel;
 {-}
begin
 Result := aMemoryUsageForm.pnMemClasses;
end;//TkwMemoryUsageFormPnMemClasses.PnMemClasses

procedure TkwMemoryUsageFormPnMemClasses.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMemoryUsageForm : TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnMemClasses(aCtx, l_aMemoryUsageForm)));
end;//TkwMemoryUsageFormPnMemClasses.DoDoIt

class function TkwMemoryUsageFormPnMemClasses.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMemoryUsageForm.pnMemClasses';
end;//TkwMemoryUsageFormPnMemClasses.GetWordNameForRegister

procedure TkwMemoryUsageFormPnMemClasses.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnMemClasses', aCtx);
end;//TkwMemoryUsageFormPnMemClasses.SetValuePrim

function TkwMemoryUsageFormPnMemClasses.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwMemoryUsageFormPnMemClasses.GetResultTypeInfo

function TkwMemoryUsageFormPnMemClasses.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMemoryUsageFormPnMemClasses.GetAllParamsCount

function TkwMemoryUsageFormPnMemClasses.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormPnMemClasses.ParamsTypes

type
 TkwMemoryUsageFormMemClasses = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.memClasses
[panel]Контрол memClasses формы TMemoryUsageForm[panel]
*Тип результата:* TevMemo
*Пример:*
[code]
OBJECT VAR l_TevMemo
 aMemoryUsageForm .TMemoryUsageForm.memClasses >>> l_TevMemo
[code]  }
 private
 // private methods
   function MemClasses(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TevMemo;
     {* Реализация слова скрипта .TMemoryUsageForm.memClasses }
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
 end;//TkwMemoryUsageFormMemClasses

// start class TkwMemoryUsageFormMemClasses

function TkwMemoryUsageFormMemClasses.MemClasses(const aCtx: TtfwContext;
  aMemoryUsageForm: TMemoryUsageForm): TevMemo;
 {-}
begin
 Result := aMemoryUsageForm.memClasses;
end;//TkwMemoryUsageFormMemClasses.MemClasses

procedure TkwMemoryUsageFormMemClasses.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMemoryUsageForm : TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((MemClasses(aCtx, l_aMemoryUsageForm)));
end;//TkwMemoryUsageFormMemClasses.DoDoIt

class function TkwMemoryUsageFormMemClasses.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMemoryUsageForm.memClasses';
end;//TkwMemoryUsageFormMemClasses.GetWordNameForRegister

procedure TkwMemoryUsageFormMemClasses.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству memClasses', aCtx);
end;//TkwMemoryUsageFormMemClasses.SetValuePrim

function TkwMemoryUsageFormMemClasses.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TevMemo);
end;//TkwMemoryUsageFormMemClasses.GetResultTypeInfo

function TkwMemoryUsageFormMemClasses.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMemoryUsageFormMemClasses.GetAllParamsCount

function TkwMemoryUsageFormMemClasses.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormMemClasses.ParamsTypes

type
 TkwMemoryUsageFormPnSummary = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.pnSummary
[panel]Контрол pnSummary формы TMemoryUsageForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aMemoryUsageForm .TMemoryUsageForm.pnSummary >>> l_TvtSizeablePanel
[code]  }
 private
 // private methods
   function PnSummary(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtSizeablePanel;
     {* Реализация слова скрипта .TMemoryUsageForm.pnSummary }
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
 end;//TkwMemoryUsageFormPnSummary

// start class TkwMemoryUsageFormPnSummary

function TkwMemoryUsageFormPnSummary.PnSummary(const aCtx: TtfwContext;
  aMemoryUsageForm: TMemoryUsageForm): TvtSizeablePanel;
 {-}
begin
 Result := aMemoryUsageForm.pnSummary;
end;//TkwMemoryUsageFormPnSummary.PnSummary

procedure TkwMemoryUsageFormPnSummary.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMemoryUsageForm : TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((PnSummary(aCtx, l_aMemoryUsageForm)));
end;//TkwMemoryUsageFormPnSummary.DoDoIt

class function TkwMemoryUsageFormPnSummary.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMemoryUsageForm.pnSummary';
end;//TkwMemoryUsageFormPnSummary.GetWordNameForRegister

procedure TkwMemoryUsageFormPnSummary.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnSummary', aCtx);
end;//TkwMemoryUsageFormPnSummary.SetValuePrim

function TkwMemoryUsageFormPnSummary.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwMemoryUsageFormPnSummary.GetResultTypeInfo

function TkwMemoryUsageFormPnSummary.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMemoryUsageFormPnSummary.GetAllParamsCount

function TkwMemoryUsageFormPnSummary.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormPnSummary.ParamsTypes

type
 TkwMemoryUsageFormLbLocalMemory = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbLocalMemory
[panel]Контрол lbLocalMemory формы TMemoryUsageForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbLocalMemory >>> l_TvtLabel
[code]  }
 private
 // private methods
   function LbLocalMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
     {* Реализация слова скрипта .TMemoryUsageForm.lbLocalMemory }
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
 end;//TkwMemoryUsageFormLbLocalMemory

// start class TkwMemoryUsageFormLbLocalMemory

function TkwMemoryUsageFormLbLocalMemory.LbLocalMemory(const aCtx: TtfwContext;
  aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {-}
begin
 Result := aMemoryUsageForm.lbLocalMemory;
end;//TkwMemoryUsageFormLbLocalMemory.LbLocalMemory

procedure TkwMemoryUsageFormLbLocalMemory.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMemoryUsageForm : TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LbLocalMemory(aCtx, l_aMemoryUsageForm)));
end;//TkwMemoryUsageFormLbLocalMemory.DoDoIt

class function TkwMemoryUsageFormLbLocalMemory.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMemoryUsageForm.lbLocalMemory';
end;//TkwMemoryUsageFormLbLocalMemory.GetWordNameForRegister

procedure TkwMemoryUsageFormLbLocalMemory.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lbLocalMemory', aCtx);
end;//TkwMemoryUsageFormLbLocalMemory.SetValuePrim

function TkwMemoryUsageFormLbLocalMemory.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwMemoryUsageFormLbLocalMemory.GetResultTypeInfo

function TkwMemoryUsageFormLbLocalMemory.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMemoryUsageFormLbLocalMemory.GetAllParamsCount

function TkwMemoryUsageFormLbLocalMemory.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormLbLocalMemory.ParamsTypes

type
 TkwMemoryUsageFormLbObjectMemory = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbObjectMemory
[panel]Контрол lbObjectMemory формы TMemoryUsageForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbObjectMemory >>> l_TvtLabel
[code]  }
 private
 // private methods
   function LbObjectMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
     {* Реализация слова скрипта .TMemoryUsageForm.lbObjectMemory }
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
 end;//TkwMemoryUsageFormLbObjectMemory

// start class TkwMemoryUsageFormLbObjectMemory

function TkwMemoryUsageFormLbObjectMemory.LbObjectMemory(const aCtx: TtfwContext;
  aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {-}
begin
 Result := aMemoryUsageForm.lbObjectMemory;
end;//TkwMemoryUsageFormLbObjectMemory.LbObjectMemory

procedure TkwMemoryUsageFormLbObjectMemory.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMemoryUsageForm : TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LbObjectMemory(aCtx, l_aMemoryUsageForm)));
end;//TkwMemoryUsageFormLbObjectMemory.DoDoIt

class function TkwMemoryUsageFormLbObjectMemory.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMemoryUsageForm.lbObjectMemory';
end;//TkwMemoryUsageFormLbObjectMemory.GetWordNameForRegister

procedure TkwMemoryUsageFormLbObjectMemory.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lbObjectMemory', aCtx);
end;//TkwMemoryUsageFormLbObjectMemory.SetValuePrim

function TkwMemoryUsageFormLbObjectMemory.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwMemoryUsageFormLbObjectMemory.GetResultTypeInfo

function TkwMemoryUsageFormLbObjectMemory.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMemoryUsageFormLbObjectMemory.GetAllParamsCount

function TkwMemoryUsageFormLbObjectMemory.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormLbObjectMemory.ParamsTypes

type
 TkwMemoryUsageFormLbObjectCount = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbObjectCount
[panel]Контрол lbObjectCount формы TMemoryUsageForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbObjectCount >>> l_TvtLabel
[code]  }
 private
 // private methods
   function LbObjectCount(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
     {* Реализация слова скрипта .TMemoryUsageForm.lbObjectCount }
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
 end;//TkwMemoryUsageFormLbObjectCount

// start class TkwMemoryUsageFormLbObjectCount

function TkwMemoryUsageFormLbObjectCount.LbObjectCount(const aCtx: TtfwContext;
  aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {-}
begin
 Result := aMemoryUsageForm.lbObjectCount;
end;//TkwMemoryUsageFormLbObjectCount.LbObjectCount

procedure TkwMemoryUsageFormLbObjectCount.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMemoryUsageForm : TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LbObjectCount(aCtx, l_aMemoryUsageForm)));
end;//TkwMemoryUsageFormLbObjectCount.DoDoIt

class function TkwMemoryUsageFormLbObjectCount.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMemoryUsageForm.lbObjectCount';
end;//TkwMemoryUsageFormLbObjectCount.GetWordNameForRegister

procedure TkwMemoryUsageFormLbObjectCount.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lbObjectCount', aCtx);
end;//TkwMemoryUsageFormLbObjectCount.SetValuePrim

function TkwMemoryUsageFormLbObjectCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwMemoryUsageFormLbObjectCount.GetResultTypeInfo

function TkwMemoryUsageFormLbObjectCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMemoryUsageFormLbObjectCount.GetAllParamsCount

function TkwMemoryUsageFormLbObjectCount.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormLbObjectCount.ParamsTypes

type
 TkwMemoryUsageFormLbGlobalMemory = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbGlobalMemory
[panel]Контрол lbGlobalMemory формы TMemoryUsageForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbGlobalMemory >>> l_TvtLabel
[code]  }
 private
 // private methods
   function LbGlobalMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
     {* Реализация слова скрипта .TMemoryUsageForm.lbGlobalMemory }
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
 end;//TkwMemoryUsageFormLbGlobalMemory

// start class TkwMemoryUsageFormLbGlobalMemory

function TkwMemoryUsageFormLbGlobalMemory.LbGlobalMemory(const aCtx: TtfwContext;
  aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {-}
begin
 Result := aMemoryUsageForm.lbGlobalMemory;
end;//TkwMemoryUsageFormLbGlobalMemory.LbGlobalMemory

procedure TkwMemoryUsageFormLbGlobalMemory.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMemoryUsageForm : TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LbGlobalMemory(aCtx, l_aMemoryUsageForm)));
end;//TkwMemoryUsageFormLbGlobalMemory.DoDoIt

class function TkwMemoryUsageFormLbGlobalMemory.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMemoryUsageForm.lbGlobalMemory';
end;//TkwMemoryUsageFormLbGlobalMemory.GetWordNameForRegister

procedure TkwMemoryUsageFormLbGlobalMemory.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lbGlobalMemory', aCtx);
end;//TkwMemoryUsageFormLbGlobalMemory.SetValuePrim

function TkwMemoryUsageFormLbGlobalMemory.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwMemoryUsageFormLbGlobalMemory.GetResultTypeInfo

function TkwMemoryUsageFormLbGlobalMemory.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMemoryUsageFormLbGlobalMemory.GetAllParamsCount

function TkwMemoryUsageFormLbGlobalMemory.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormLbGlobalMemory.ParamsTypes

type
 TkwMemoryUsageFormLbDocumentsInCacheCount = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbDocumentsInCacheCount
[panel]Контрол lbDocumentsInCacheCount формы TMemoryUsageForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbDocumentsInCacheCount >>> l_TvtLabel
[code]  }
 private
 // private methods
   function LbDocumentsInCacheCount(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
     {* Реализация слова скрипта .TMemoryUsageForm.lbDocumentsInCacheCount }
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
 end;//TkwMemoryUsageFormLbDocumentsInCacheCount

// start class TkwMemoryUsageFormLbDocumentsInCacheCount

function TkwMemoryUsageFormLbDocumentsInCacheCount.LbDocumentsInCacheCount(const aCtx: TtfwContext;
  aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {-}
begin
 Result := aMemoryUsageForm.lbDocumentsInCacheCount;
end;//TkwMemoryUsageFormLbDocumentsInCacheCount.LbDocumentsInCacheCount

procedure TkwMemoryUsageFormLbDocumentsInCacheCount.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMemoryUsageForm : TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LbDocumentsInCacheCount(aCtx, l_aMemoryUsageForm)));
end;//TkwMemoryUsageFormLbDocumentsInCacheCount.DoDoIt

class function TkwMemoryUsageFormLbDocumentsInCacheCount.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMemoryUsageForm.lbDocumentsInCacheCount';
end;//TkwMemoryUsageFormLbDocumentsInCacheCount.GetWordNameForRegister

procedure TkwMemoryUsageFormLbDocumentsInCacheCount.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lbDocumentsInCacheCount', aCtx);
end;//TkwMemoryUsageFormLbDocumentsInCacheCount.SetValuePrim

function TkwMemoryUsageFormLbDocumentsInCacheCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwMemoryUsageFormLbDocumentsInCacheCount.GetResultTypeInfo

function TkwMemoryUsageFormLbDocumentsInCacheCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMemoryUsageFormLbDocumentsInCacheCount.GetAllParamsCount

function TkwMemoryUsageFormLbDocumentsInCacheCount.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormLbDocumentsInCacheCount.ParamsTypes

type
 TkwMemoryUsageFormLbAllLocalMemory = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbAllLocalMemory
[panel]Контрол lbAllLocalMemory формы TMemoryUsageForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbAllLocalMemory >>> l_TvtLabel
[code]  }
 private
 // private methods
   function LbAllLocalMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
     {* Реализация слова скрипта .TMemoryUsageForm.lbAllLocalMemory }
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
 end;//TkwMemoryUsageFormLbAllLocalMemory

// start class TkwMemoryUsageFormLbAllLocalMemory

function TkwMemoryUsageFormLbAllLocalMemory.LbAllLocalMemory(const aCtx: TtfwContext;
  aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {-}
begin
 Result := aMemoryUsageForm.lbAllLocalMemory;
end;//TkwMemoryUsageFormLbAllLocalMemory.LbAllLocalMemory

procedure TkwMemoryUsageFormLbAllLocalMemory.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMemoryUsageForm : TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LbAllLocalMemory(aCtx, l_aMemoryUsageForm)));
end;//TkwMemoryUsageFormLbAllLocalMemory.DoDoIt

class function TkwMemoryUsageFormLbAllLocalMemory.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMemoryUsageForm.lbAllLocalMemory';
end;//TkwMemoryUsageFormLbAllLocalMemory.GetWordNameForRegister

procedure TkwMemoryUsageFormLbAllLocalMemory.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lbAllLocalMemory', aCtx);
end;//TkwMemoryUsageFormLbAllLocalMemory.SetValuePrim

function TkwMemoryUsageFormLbAllLocalMemory.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwMemoryUsageFormLbAllLocalMemory.GetResultTypeInfo

function TkwMemoryUsageFormLbAllLocalMemory.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMemoryUsageFormLbAllLocalMemory.GetAllParamsCount

function TkwMemoryUsageFormLbAllLocalMemory.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormLbAllLocalMemory.ParamsTypes

type
 TkwMemoryUsageFormLbTotalMemory = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта .TMemoryUsageForm.lbTotalMemory
[panel]Контрол lbTotalMemory формы TMemoryUsageForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbTotalMemory >>> l_TvtLabel
[code]  }
 private
 // private methods
   function LbTotalMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
     {* Реализация слова скрипта .TMemoryUsageForm.lbTotalMemory }
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
 end;//TkwMemoryUsageFormLbTotalMemory

// start class TkwMemoryUsageFormLbTotalMemory

function TkwMemoryUsageFormLbTotalMemory.LbTotalMemory(const aCtx: TtfwContext;
  aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
 {-}
begin
 Result := aMemoryUsageForm.lbTotalMemory;
end;//TkwMemoryUsageFormLbTotalMemory.LbTotalMemory

procedure TkwMemoryUsageFormLbTotalMemory.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMemoryUsageForm : TMemoryUsageForm;
begin
 try
  l_aMemoryUsageForm := TMemoryUsageForm(aCtx.rEngine.PopObjAs(TMemoryUsageForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LbTotalMemory(aCtx, l_aMemoryUsageForm)));
end;//TkwMemoryUsageFormLbTotalMemory.DoDoIt

class function TkwMemoryUsageFormLbTotalMemory.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TMemoryUsageForm.lbTotalMemory';
end;//TkwMemoryUsageFormLbTotalMemory.GetWordNameForRegister

procedure TkwMemoryUsageFormLbTotalMemory.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lbTotalMemory', aCtx);
end;//TkwMemoryUsageFormLbTotalMemory.SetValuePrim

function TkwMemoryUsageFormLbTotalMemory.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwMemoryUsageFormLbTotalMemory.GetResultTypeInfo

function TkwMemoryUsageFormLbTotalMemory.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMemoryUsageFormLbTotalMemory.GetAllParamsCount

function TkwMemoryUsageFormLbTotalMemory.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMemoryUsageForm)]);
end;//TkwMemoryUsageFormLbTotalMemory.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_MemoryUsage
 Tkw_Form_MemoryUsage.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_pnTagTree
 Tkw_MemoryUsage_Control_pnTagTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_pnTagTree_Push
 Tkw_MemoryUsage_Control_pnTagTree_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_TagTree
 Tkw_MemoryUsage_Control_TagTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_TagTree_Push
 Tkw_MemoryUsage_Control_TagTree_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_pnMemClasses
 Tkw_MemoryUsage_Control_pnMemClasses.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_pnMemClasses_Push
 Tkw_MemoryUsage_Control_pnMemClasses_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_memClasses
 Tkw_MemoryUsage_Control_memClasses.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_memClasses_Push
 Tkw_MemoryUsage_Control_memClasses_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_pnSummary
 Tkw_MemoryUsage_Control_pnSummary.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_pnSummary_Push
 Tkw_MemoryUsage_Control_pnSummary_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_lbLocalMemory
 Tkw_MemoryUsage_Control_lbLocalMemory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_lbLocalMemory_Push
 Tkw_MemoryUsage_Control_lbLocalMemory_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_lbObjectMemory
 Tkw_MemoryUsage_Control_lbObjectMemory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_lbObjectMemory_Push
 Tkw_MemoryUsage_Control_lbObjectMemory_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_lbObjectCount
 Tkw_MemoryUsage_Control_lbObjectCount.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_lbObjectCount_Push
 Tkw_MemoryUsage_Control_lbObjectCount_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_lbGlobalMemory
 Tkw_MemoryUsage_Control_lbGlobalMemory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_lbGlobalMemory_Push
 Tkw_MemoryUsage_Control_lbGlobalMemory_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_lbDocumentsInCacheCount
 Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push
 Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_lbAllLocalMemory
 Tkw_MemoryUsage_Control_lbAllLocalMemory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_lbAllLocalMemory_Push
 Tkw_MemoryUsage_Control_lbAllLocalMemory_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_lbTotalMemory
 Tkw_MemoryUsage_Control_lbTotalMemory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_MemoryUsage_Control_lbTotalMemory_Push
 Tkw_MemoryUsage_Control_lbTotalMemory_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MemoryUsageForm_pnTagTree
 TkwMemoryUsageFormPnTagTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MemoryUsageForm_TagTree
 TkwMemoryUsageFormTagTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MemoryUsageForm_pnMemClasses
 TkwMemoryUsageFormPnMemClasses.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MemoryUsageForm_memClasses
 TkwMemoryUsageFormMemClasses.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MemoryUsageForm_pnSummary
 TkwMemoryUsageFormPnSummary.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MemoryUsageForm_lbLocalMemory
 TkwMemoryUsageFormLbLocalMemory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MemoryUsageForm_lbObjectMemory
 TkwMemoryUsageFormLbObjectMemory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MemoryUsageForm_lbObjectCount
 TkwMemoryUsageFormLbObjectCount.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MemoryUsageForm_lbGlobalMemory
 TkwMemoryUsageFormLbGlobalMemory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MemoryUsageForm_lbDocumentsInCacheCount
 TkwMemoryUsageFormLbDocumentsInCacheCount.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MemoryUsageForm_lbAllLocalMemory
 TkwMemoryUsageFormLbAllLocalMemory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация MemoryUsageForm_lbTotalMemory
 TkwMemoryUsageFormLbTotalMemory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа MemoryUsage
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMemoryUsageForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TeeTreeView
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtSizeablePanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TevMemo
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevMemo));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.