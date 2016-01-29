unit MemoryUsageKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/MemoryUsageKeywordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 �������� ��� �����������::F1 Without Usecases::View::Main::MemoryUsageKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� MemoryUsage
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
  {* ����� ������� ��� �������������� ����� MemoryUsage
----
*������ �������������*:
[code]
'aControl' �����::MemoryUsage TryFocus ASSERT
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
 Result := '�����::MemoryUsage';
end;//Tkw_Form_MemoryUsage.GetWordNameForRegister

function Tkw_Form_MemoryUsage.GetString: AnsiString;
 {-}
begin
 Result := 'MemoryUsageForm';
end;//Tkw_Form_MemoryUsage.GetString

type
 Tkw_MemoryUsage_Control_pnTagTree = {final scriptword} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnTagTree
----
*������ �������������*:
[code]
�������::pnTagTree TryFocus ASSERT
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
 Result := '�������::pnTagTree';
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
  {* ����� ������� ��� �������� pnTagTree
----
*������ �������������*:
[code]
�������::pnTagTree:push pop:control:SetFocus ASSERT
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
 Result := '�������::pnTagTree:push';
end;//Tkw_MemoryUsage_Control_pnTagTree_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_TagTree = {final scriptword} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TagTree
----
*������ �������������*:
[code]
�������::TagTree TryFocus ASSERT
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
 Result := '�������::TagTree';
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
  {* ����� ������� ��� �������� TagTree
----
*������ �������������*:
[code]
�������::TagTree:push pop:control:SetFocus ASSERT
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
 Result := '�������::TagTree:push';
end;//Tkw_MemoryUsage_Control_TagTree_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_pnMemClasses = {final scriptword} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnMemClasses
----
*������ �������������*:
[code]
�������::pnMemClasses TryFocus ASSERT
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
 Result := '�������::pnMemClasses';
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
  {* ����� ������� ��� �������� pnMemClasses
----
*������ �������������*:
[code]
�������::pnMemClasses:push pop:control:SetFocus ASSERT
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
 Result := '�������::pnMemClasses:push';
end;//Tkw_MemoryUsage_Control_pnMemClasses_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_memClasses = {final scriptword} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� memClasses
----
*������ �������������*:
[code]
�������::memClasses TryFocus ASSERT
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
 Result := '�������::memClasses';
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
  {* ����� ������� ��� �������� memClasses
----
*������ �������������*:
[code]
�������::memClasses:push pop:control:SetFocus ASSERT
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
 Result := '�������::memClasses:push';
end;//Tkw_MemoryUsage_Control_memClasses_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_pnSummary = {final scriptword} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnSummary
----
*������ �������������*:
[code]
�������::pnSummary TryFocus ASSERT
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
 Result := '�������::pnSummary';
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
  {* ����� ������� ��� �������� pnSummary
----
*������ �������������*:
[code]
�������::pnSummary:push pop:control:SetFocus ASSERT
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
 Result := '�������::pnSummary:push';
end;//Tkw_MemoryUsage_Control_pnSummary_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_lbLocalMemory = {final scriptword} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lbLocalMemory
----
*������ �������������*:
[code]
�������::lbLocalMemory TryFocus ASSERT
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
 Result := '�������::lbLocalMemory';
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
  {* ����� ������� ��� �������� lbLocalMemory
----
*������ �������������*:
[code]
�������::lbLocalMemory:push pop:control:SetFocus ASSERT
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
 Result := '�������::lbLocalMemory:push';
end;//Tkw_MemoryUsage_Control_lbLocalMemory_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_lbObjectMemory = {final scriptword} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lbObjectMemory
----
*������ �������������*:
[code]
�������::lbObjectMemory TryFocus ASSERT
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
 Result := '�������::lbObjectMemory';
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
  {* ����� ������� ��� �������� lbObjectMemory
----
*������ �������������*:
[code]
�������::lbObjectMemory:push pop:control:SetFocus ASSERT
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
 Result := '�������::lbObjectMemory:push';
end;//Tkw_MemoryUsage_Control_lbObjectMemory_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_lbObjectCount = {final scriptword} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lbObjectCount
----
*������ �������������*:
[code]
�������::lbObjectCount TryFocus ASSERT
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
 Result := '�������::lbObjectCount';
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
  {* ����� ������� ��� �������� lbObjectCount
----
*������ �������������*:
[code]
�������::lbObjectCount:push pop:control:SetFocus ASSERT
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
 Result := '�������::lbObjectCount:push';
end;//Tkw_MemoryUsage_Control_lbObjectCount_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_lbGlobalMemory = {final scriptword} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lbGlobalMemory
----
*������ �������������*:
[code]
�������::lbGlobalMemory TryFocus ASSERT
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
 Result := '�������::lbGlobalMemory';
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
  {* ����� ������� ��� �������� lbGlobalMemory
----
*������ �������������*:
[code]
�������::lbGlobalMemory:push pop:control:SetFocus ASSERT
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
 Result := '�������::lbGlobalMemory:push';
end;//Tkw_MemoryUsage_Control_lbGlobalMemory_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_lbDocumentsInCacheCount = {final scriptword} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lbDocumentsInCacheCount
----
*������ �������������*:
[code]
�������::lbDocumentsInCacheCount TryFocus ASSERT
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
 Result := '�������::lbDocumentsInCacheCount';
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
  {* ����� ������� ��� �������� lbDocumentsInCacheCount
----
*������ �������������*:
[code]
�������::lbDocumentsInCacheCount:push pop:control:SetFocus ASSERT
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
 Result := '�������::lbDocumentsInCacheCount:push';
end;//Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_lbAllLocalMemory = {final scriptword} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lbAllLocalMemory
----
*������ �������������*:
[code]
�������::lbAllLocalMemory TryFocus ASSERT
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
 Result := '�������::lbAllLocalMemory';
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
  {* ����� ������� ��� �������� lbAllLocalMemory
----
*������ �������������*:
[code]
�������::lbAllLocalMemory:push pop:control:SetFocus ASSERT
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
 Result := '�������::lbAllLocalMemory:push';
end;//Tkw_MemoryUsage_Control_lbAllLocalMemory_Push.GetWordNameForRegister

type
 Tkw_MemoryUsage_Control_lbTotalMemory = {final scriptword} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lbTotalMemory
----
*������ �������������*:
[code]
�������::lbTotalMemory TryFocus ASSERT
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
 Result := '�������::lbTotalMemory';
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
  {* ����� ������� ��� �������� lbTotalMemory
----
*������ �������������*:
[code]
�������::lbTotalMemory:push pop:control:SetFocus ASSERT
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
 Result := '�������::lbTotalMemory:push';
end;//Tkw_MemoryUsage_Control_lbTotalMemory_Push.GetWordNameForRegister

type
 TkwMemoryUsageFormPnTagTree = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� .TMemoryUsageForm.pnTagTree
[panel]������� pnTagTree ����� TMemoryUsageForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aMemoryUsageForm .TMemoryUsageForm.pnTagTree >>> l_TvtPanel
[code]  }
 private
 // private methods
   function PnTagTree(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtPanel;
     {* ���������� ����� ������� .TMemoryUsageForm.pnTagTree }
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
   RunnerError('������ ��� ��������� ��������� aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
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
 RunnerError('������ ����������� �������� readonly �������� pnTagTree', aCtx);
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
  {* ����� ������� .TMemoryUsageForm.TagTree
[panel]������� TagTree ����� TMemoryUsageForm[panel]
*��� ����������:* TeeTreeView
*������:*
[code]
OBJECT VAR l_TeeTreeView
 aMemoryUsageForm .TMemoryUsageForm.TagTree >>> l_TeeTreeView
[code]  }
 private
 // private methods
   function TagTree(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TeeTreeView;
     {* ���������� ����� ������� .TMemoryUsageForm.TagTree }
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
   RunnerError('������ ��� ��������� ��������� aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
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
 RunnerError('������ ����������� �������� readonly �������� TagTree', aCtx);
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
  {* ����� ������� .TMemoryUsageForm.pnMemClasses
[panel]������� pnMemClasses ����� TMemoryUsageForm[panel]
*��� ����������:* TvtSizeablePanel
*������:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aMemoryUsageForm .TMemoryUsageForm.pnMemClasses >>> l_TvtSizeablePanel
[code]  }
 private
 // private methods
   function PnMemClasses(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtSizeablePanel;
     {* ���������� ����� ������� .TMemoryUsageForm.pnMemClasses }
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
   RunnerError('������ ��� ��������� ��������� aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
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
 RunnerError('������ ����������� �������� readonly �������� pnMemClasses', aCtx);
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
  {* ����� ������� .TMemoryUsageForm.memClasses
[panel]������� memClasses ����� TMemoryUsageForm[panel]
*��� ����������:* TevMemo
*������:*
[code]
OBJECT VAR l_TevMemo
 aMemoryUsageForm .TMemoryUsageForm.memClasses >>> l_TevMemo
[code]  }
 private
 // private methods
   function MemClasses(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TevMemo;
     {* ���������� ����� ������� .TMemoryUsageForm.memClasses }
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
   RunnerError('������ ��� ��������� ��������� aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
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
 RunnerError('������ ����������� �������� readonly �������� memClasses', aCtx);
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
  {* ����� ������� .TMemoryUsageForm.pnSummary
[panel]������� pnSummary ����� TMemoryUsageForm[panel]
*��� ����������:* TvtSizeablePanel
*������:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aMemoryUsageForm .TMemoryUsageForm.pnSummary >>> l_TvtSizeablePanel
[code]  }
 private
 // private methods
   function PnSummary(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtSizeablePanel;
     {* ���������� ����� ������� .TMemoryUsageForm.pnSummary }
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
   RunnerError('������ ��� ��������� ��������� aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
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
 RunnerError('������ ����������� �������� readonly �������� pnSummary', aCtx);
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
  {* ����� ������� .TMemoryUsageForm.lbLocalMemory
[panel]������� lbLocalMemory ����� TMemoryUsageForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbLocalMemory >>> l_TvtLabel
[code]  }
 private
 // private methods
   function LbLocalMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
     {* ���������� ����� ������� .TMemoryUsageForm.lbLocalMemory }
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
   RunnerError('������ ��� ��������� ��������� aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
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
 RunnerError('������ ����������� �������� readonly �������� lbLocalMemory', aCtx);
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
  {* ����� ������� .TMemoryUsageForm.lbObjectMemory
[panel]������� lbObjectMemory ����� TMemoryUsageForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbObjectMemory >>> l_TvtLabel
[code]  }
 private
 // private methods
   function LbObjectMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
     {* ���������� ����� ������� .TMemoryUsageForm.lbObjectMemory }
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
   RunnerError('������ ��� ��������� ��������� aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
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
 RunnerError('������ ����������� �������� readonly �������� lbObjectMemory', aCtx);
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
  {* ����� ������� .TMemoryUsageForm.lbObjectCount
[panel]������� lbObjectCount ����� TMemoryUsageForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbObjectCount >>> l_TvtLabel
[code]  }
 private
 // private methods
   function LbObjectCount(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
     {* ���������� ����� ������� .TMemoryUsageForm.lbObjectCount }
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
   RunnerError('������ ��� ��������� ��������� aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
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
 RunnerError('������ ����������� �������� readonly �������� lbObjectCount', aCtx);
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
  {* ����� ������� .TMemoryUsageForm.lbGlobalMemory
[panel]������� lbGlobalMemory ����� TMemoryUsageForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbGlobalMemory >>> l_TvtLabel
[code]  }
 private
 // private methods
   function LbGlobalMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
     {* ���������� ����� ������� .TMemoryUsageForm.lbGlobalMemory }
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
   RunnerError('������ ��� ��������� ��������� aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
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
 RunnerError('������ ����������� �������� readonly �������� lbGlobalMemory', aCtx);
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
  {* ����� ������� .TMemoryUsageForm.lbDocumentsInCacheCount
[panel]������� lbDocumentsInCacheCount ����� TMemoryUsageForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbDocumentsInCacheCount >>> l_TvtLabel
[code]  }
 private
 // private methods
   function LbDocumentsInCacheCount(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
     {* ���������� ����� ������� .TMemoryUsageForm.lbDocumentsInCacheCount }
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
   RunnerError('������ ��� ��������� ��������� aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
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
 RunnerError('������ ����������� �������� readonly �������� lbDocumentsInCacheCount', aCtx);
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
  {* ����� ������� .TMemoryUsageForm.lbAllLocalMemory
[panel]������� lbAllLocalMemory ����� TMemoryUsageForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbAllLocalMemory >>> l_TvtLabel
[code]  }
 private
 // private methods
   function LbAllLocalMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
     {* ���������� ����� ������� .TMemoryUsageForm.lbAllLocalMemory }
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
   RunnerError('������ ��� ��������� ��������� aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
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
 RunnerError('������ ����������� �������� readonly �������� lbAllLocalMemory', aCtx);
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
  {* ����� ������� .TMemoryUsageForm.lbTotalMemory
[panel]������� lbTotalMemory ����� TMemoryUsageForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aMemoryUsageForm .TMemoryUsageForm.lbTotalMemory >>> l_TvtLabel
[code]  }
 private
 // private methods
   function LbTotalMemory(const aCtx: TtfwContext;
    aMemoryUsageForm: TMemoryUsageForm): TvtLabel;
     {* ���������� ����� ������� .TMemoryUsageForm.lbTotalMemory }
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
   RunnerError('������ ��� ��������� ��������� aMemoryUsageForm: TMemoryUsageForm : ' + E.Message, aCtx);
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
 RunnerError('������ ����������� �������� readonly �������� lbTotalMemory', aCtx);
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
// ����������� Tkw_Form_MemoryUsage
 Tkw_Form_MemoryUsage.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_pnTagTree
 Tkw_MemoryUsage_Control_pnTagTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_pnTagTree_Push
 Tkw_MemoryUsage_Control_pnTagTree_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_TagTree
 Tkw_MemoryUsage_Control_TagTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_TagTree_Push
 Tkw_MemoryUsage_Control_TagTree_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_pnMemClasses
 Tkw_MemoryUsage_Control_pnMemClasses.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_pnMemClasses_Push
 Tkw_MemoryUsage_Control_pnMemClasses_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_memClasses
 Tkw_MemoryUsage_Control_memClasses.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_memClasses_Push
 Tkw_MemoryUsage_Control_memClasses_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_pnSummary
 Tkw_MemoryUsage_Control_pnSummary.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_pnSummary_Push
 Tkw_MemoryUsage_Control_pnSummary_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_lbLocalMemory
 Tkw_MemoryUsage_Control_lbLocalMemory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_lbLocalMemory_Push
 Tkw_MemoryUsage_Control_lbLocalMemory_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_lbObjectMemory
 Tkw_MemoryUsage_Control_lbObjectMemory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_lbObjectMemory_Push
 Tkw_MemoryUsage_Control_lbObjectMemory_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_lbObjectCount
 Tkw_MemoryUsage_Control_lbObjectCount.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_lbObjectCount_Push
 Tkw_MemoryUsage_Control_lbObjectCount_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_lbGlobalMemory
 Tkw_MemoryUsage_Control_lbGlobalMemory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_lbGlobalMemory_Push
 Tkw_MemoryUsage_Control_lbGlobalMemory_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_lbDocumentsInCacheCount
 Tkw_MemoryUsage_Control_lbDocumentsInCacheCount.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push
 Tkw_MemoryUsage_Control_lbDocumentsInCacheCount_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_lbAllLocalMemory
 Tkw_MemoryUsage_Control_lbAllLocalMemory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_lbAllLocalMemory_Push
 Tkw_MemoryUsage_Control_lbAllLocalMemory_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_lbTotalMemory
 Tkw_MemoryUsage_Control_lbTotalMemory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MemoryUsage_Control_lbTotalMemory_Push
 Tkw_MemoryUsage_Control_lbTotalMemory_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� MemoryUsageForm_pnTagTree
 TkwMemoryUsageFormPnTagTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� MemoryUsageForm_TagTree
 TkwMemoryUsageFormTagTree.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� MemoryUsageForm_pnMemClasses
 TkwMemoryUsageFormPnMemClasses.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� MemoryUsageForm_memClasses
 TkwMemoryUsageFormMemClasses.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� MemoryUsageForm_pnSummary
 TkwMemoryUsageFormPnSummary.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� MemoryUsageForm_lbLocalMemory
 TkwMemoryUsageFormLbLocalMemory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� MemoryUsageForm_lbObjectMemory
 TkwMemoryUsageFormLbObjectMemory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� MemoryUsageForm_lbObjectCount
 TkwMemoryUsageFormLbObjectCount.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� MemoryUsageForm_lbGlobalMemory
 TkwMemoryUsageFormLbGlobalMemory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� MemoryUsageForm_lbDocumentsInCacheCount
 TkwMemoryUsageFormLbDocumentsInCacheCount.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� MemoryUsageForm_lbAllLocalMemory
 TkwMemoryUsageFormLbAllLocalMemory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� MemoryUsageForm_lbTotalMemory
 TkwMemoryUsageFormLbTotalMemory.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� MemoryUsage
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMemoryUsageForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TeeTreeView
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtSizeablePanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TevMemo
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevMemo));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.