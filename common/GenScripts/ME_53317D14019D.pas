unit l3Variant;

// ������: "w:\common\components\rtl\Garant\L3\l3Variant.pas"
// ���������: "UtilityPack"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , Classes
 , l3Variants
 , l3Types
 , l3DataContainerWithoutIUnknownPrim
 , l3Const
 , k2BaseTypes
 , l3PureMixIns
 , l3ProtoObject
;

 (*
 Mk2Storable = interface
  {* ������ ���� ���������� �� ����������/�������������� }
  procedure DoLoad;
  procedure ForceStore;
 end;//Mk2Storable
 *)

type
 Tk2VarKind = (
  k2_vkInteger
  , k2_vkString
  , k2_vkTransparent
  , k2_vkStream
 );//Tk2VarKind

 Il3OpPack = interface;

 Ik2Variant = interface;

 Tl3Variant = class;

 Tl3VariantDef = class;

 Ik2TagGenerator = interface
  {* ��������� ����� }
  ['{694DAEA5-80F3-4E12-9CCF-2B9950479734}']
  procedure pm_SetCharsInLine(aValue: Integer);
  function pm_GetCurrentStartLevel: Integer;
  function pm_GetContext: Il3OpPack;
  function pm_GetNextGenerator: Ik2TagGenerator;
  procedure pm_SetNextGenerator(const aValue: Ik2TagGenerator);
  function Get_CurrentVersion: Integer;
  procedure Set_CurrentVersion(aValue: Integer);
  procedure AddStringAtom(TagID: Integer;
   const Value: AnsiString;
   aCodePage: Integer = CP_ANSI); overload;
   {* �������� ��������� ����. }
  procedure AddStringAtom(TagID: Integer;
   const Value: Tl3WString); overload;
   {* �������� ��������� ����. }
  procedure AddStreamAtom(TagID: Integer;
   aStream: TStream);
   {* �������� ���� �� ������. }
  procedure AddTransparentAtom(TagID: Integer);
   {* �������� "����������" ����. }
  procedure AddIntegerAtom(TagID: Integer;
   Value: Integer);
   {* �������� ������������� ����. }
  procedure AddBoolAtom(TagID: Integer;
   Value: Boolean);
  procedure AddAtom(AtomIndex: Integer;
   aValue: Tl3Variant);
   {* �������� ����. }
  procedure AddAtomEx(AtomIndex: Integer;
   const Value: Ik2Variant);
  procedure Start;
   {* ������ ���������. }
  procedure StartChild(TypeID: Tl3VariantDef);
   {* ������ �������� ������ ����. }
  procedure StartDefaultChild;
   {* ������ �������� ������ ���� � ����� ��-���������. }
  procedure StartTag(TagID: Integer);
   {* ������ �������� ���. }
  procedure Finish(NeedUndo: Boolean = False);
   {* ������� ������ ����� ���������. }
  procedure Rollback(CheckBrackets: Boolean = False);
   {* �������� ��� �������� "������". }
  function Pixel2Char(Pixel: Integer): Integer;
  procedure AddInt64Atom(aTagID: Integer;
   aValue: Int64);
   {* ��������� 64-������ ���� }
  function Char2Pixel(aCh: Integer): Integer;
  property CharsInLine: Integer
   write pm_SetCharsInLine;
  property CurrentStartLevel: Integer
   read pm_GetCurrentStartLevel;
  property Context: Il3OpPack
   read pm_GetContext;
  property NextGenerator: Ik2TagGenerator
   read pm_GetNextGenerator
   write pm_SetNextGenerator;
   {* ��������� ��������� � �������. }
  property CurrentVersion: Integer
   read Get_CurrentVersion
   write Set_CurrentVersion;
   {* ������� ������ ������� }
 end;//Ik2TagGenerator

 Ik2UndoBuffer = interface
  {* Undo-����� }
  ['{957F4AF4-F09C-40BA-B4C1-030462DC0F2C}']
  function pm_GetCanUndo: Boolean;
  function pm_GetCanRedo: Boolean;
  function Get_Last: TObject;
  function Get_Empty: Boolean;
  function Get_Disabled: Boolean;
  procedure Set_Disabled(aValue: Boolean);
  function GetActiveObject(aSucc: Boolean): TObject;
  procedure ExecutedOperation(aContainer: TObject);
   {* ����������� ������ � ����� ����� ��������. }
  function Undo(const aProcessor: Ik2Processor): Boolean;
   {* �������� ���������� ��������. }
  function Redo(const aProcessor: Ik2Processor): Boolean;
   {* ������� ���������� ��������. }
  procedure Clear;
   {* �������� ����� ��������. }
  property CanUndo: Boolean
   read pm_GetCanUndo;
   {* ����� �� �������� ��������? }
  property CanRedo: Boolean
   read pm_GetCanRedo;
   {* ����� �� ������� ��������? }
  property Last: TObject
   read Get_Last;
  property Empty: Boolean
   read Get_Empty;
   {* ������ "������"? }
  property Disabled: Boolean
   read Get_Disabled
   write Set_Disabled;
 end;//Ik2UndoBuffer

 Ik2Processor = interface(Il3ChangeNotifier)
  {* ��������� ��������. }
  ['{D7993D78-8C13-45D0-8000-F65721D67FC7}']
  function pm_GetDefaultStyle: Tl3StyleId;
  procedure pm_SetDefaultStyle(aValue: Tl3StyleId);
  function pm_GetCanUndo: Boolean;
  function pm_GetCanRedo: Boolean;
  function Get_UndoBuffer: Ik2UndoBuffer;
  function StartOp(OpCode: Integer = 0;
   DoLock: Boolean = True): Il3OpPack;
   {* ������ ��������. }
  function FinishOp(anOp: TObject): Boolean;
   {* ��������� ��������. }
  function LastOp: Il3OpPack;
   {* ���������� ��������. }
  function InOp: Boolean;
   {* ����� �������� �������. }
  procedure Lock;
   {* �������. }
  procedure Unlock;
   {* �������. }
  function Undo: Boolean;
   {* �������� ���������� ��������. }
  function Redo: Boolean;
   {* ������� ���������� ��������. }
  procedure CheckInsert(aParent: Tl3Variant;
   var aChild: Tl3Variant;
   var anIndex: Integer);
   {* ��������� �������� � ����������. }
  procedure CheckDelete(aParent: Tl3Variant;
   aChild: Tl3Variant;
   anIndex: Integer);
   {* ��������� �������� � ����������. }
  procedure NotifyCompleted(aList: Tl3Variant;
   aChild: Tl3Variant);
  procedure NotifyInsert(aList: Tl3Variant;
   aProp: TObject;
   aChild: Tl3Variant;
   anIndex: Integer;
   const anOpPack: Il3OpPack);
  procedure NotifyDelete(aList: Tl3Variant;
   aProp: TObject;
   aChild: Tl3Variant;
   anIndex: Integer;
   const anOpPack: Il3OpPack);
  function NeedReplaceQuotes: Boolean;
   {* ���������� - ����� �� �������� ������� ��� �����. }
  procedure NotifyPropChanged(aProp: TObject;
   aValues;
   const anOp: Il3OpPack);
   {* �������� �� ��������� �������� ������� }
  property DefaultStyle: Tl3StyleId
   read pm_GetDefaultStyle
   write pm_SetDefaultStyle;
   {* ����� ��-���������. }
  property CanUndo: Boolean
   read pm_GetCanUndo;
   {* �������� �� Undo. }
  property CanRedo: Boolean
   read pm_GetCanRedo;
   {* �������� �� Redo. }
  property UndoBuffer: Ik2UndoBuffer
   read Get_UndoBuffer;
 end;//Ik2Processor

 Il3OpPackMode = interface
  {* ����� ��������. }
  ['{5A1F0786-3718-4890-BB08-5CC705FF8CEE}']
  function Get_InUndo: Boolean;
  function Get_SaveUndo: Boolean;
  procedure Set_SaveUndo(aValue: Boolean);
  function pm_GetDeleteMapped: Boolean;
  procedure pm_SetDeleteMapped(aValue: Boolean);
  function pm_GetOptimize: Boolean;
  procedure pm_SetOptimize(aValue: Boolean);
  function pm_GetInIOProcess: Boolean;
  procedure pm_SetInIOProcess(aValue: Boolean);
  procedure pm_SetReadOnly(aValue: Boolean);
  function pm_GetProcessor: Ik2Processor;
  procedure MarkModified(aTarget: Tl3Variant);
  procedure InvertModified;
  function GetModified: Boolean;
  procedure CheckReadOnly;
  procedure DisableReadonly;
   {* ��������� ����� �������� ReadOnly }
  procedure EnableReadOnly;
   {* �������� ����� �������� ReadOnly }
  procedure CheckOn;
  procedure CheckOff;
  function IsCheckOff: Boolean;
  property InUndo: Boolean
   read Get_InUndo;
  property SaveUndo: Boolean
   read Get_SaveUndo
   write Set_SaveUndo;
  property DeleteMapped: Boolean
   read pm_GetDeleteMapped
   write pm_SetDeleteMapped;
  property Optimize: Boolean
   read pm_GetOptimize
   write pm_SetOptimize;
  property InIOProcess: Boolean
   read pm_GetInIOProcess
   write pm_SetInIOProcess;
  property ReadOnly: Boolean
   write pm_SetReadOnly;
  property Processor: Ik2Processor
   read pm_GetProcessor;
   {* ��������� �������� � ��������� �������� ����������� ������ �����. }
 end;//Il3OpPackMode

 Il3OpPack = interface(Il3OpPackMode)
  {* ����� ��������. }
  ['{EA3D40DD-EE9F-4E2E-ABE1-B414C09E87FD}']
  function Get_Code: Integer;
  function Undo(const aProcessor: Ik2Processor): Integer;
   {* ���������� ��� �������� � ���������� �� ����������. }
  function Redo(const aProcessor: Ik2Processor): Integer;
   {* ���������� ��� �������� � ���������� �� ����������. }
  procedure Lock;
   {* �������. }
  procedure Unlock;
   {* �������. }
  property Code: Integer
   read Get_Code;
   {* ��� �������� }
 end;//Il3OpPack

 Mk2Children_IterateChildrenF_Action = function(anItem: Tl3Variant;
  anIndex: Integer): Boolean;
  {* ��� �������������� ������� ��� Mk2Children.IterateChildrenF }

 Mk2Children_IterateChildrenBack_Action = function(anItem: Tl3Variant;
  anIndex: Integer): Boolean;
  {* ��� �������������� ������� ��� Mk2Children.IterateChildrenBack }

 Il3TagRef = interface;

 (*
 Mk2Children = interface
  {* ��������� ����� }
  function Get_ChildrenCount: Integer;
  function pm_GetChild(anIndex: Integer): Tl3Variant;
  procedure Set_ChildrenCapacity(aValue: Integer);
  function IterateChildrenF(anAction: Mk2Children_IterateChildrenF_Action;
   aLo: Tl3Index = l3Interfaces.l3MinIndex;
   aHi: Tl3Index = l3Interfaces.l3MaxIndex;
   aLoadedOnly: Boolean = False): Integer;
  function IterateChildrenBack(anAction: Mk2Children_IterateChildrenBack_Action;
   aHi: Tl3Index = l3Interfaces.l3MaxIndex;
   aLo: Tl3Index = l3Interfaces.l3MinIndex;
   aLoadedOnly: Boolean = False): Integer;
  function IterateChildrenBackF(anAction: Mk2Children_IterateChildrenBack_Action;
   aHi: Tl3Index = l3Interfaces.l3MaxIndex;
   aLo: Tl3Index = l3Interfaces.l3MinIndex;
   aLoadedOnly: Boolean = False): Integer;
  function AddChild(aChild: Tl3Variant;
   const aContext: Il3OpPack = nil): Integer;
   {* �������� �������. }
  function DeleteChild(anIndex: Integer;
   const anOp: Il3OpPack;
   out theChild: Il3TagRef): Boolean; overload;
   {* ������� �������. }
  function DeleteChild(aChild: Tl3Variant;
   const Context: Il3OpPack = nil): Boolean; overload;
   {* ������� �������. }
  function DeleteChild(anIndex: Integer;
   const anOp: Il3OpPack = nil): Boolean; overload;
  property ChildrenCount: Integer
   read Get_ChildrenCount;
   {* ���������� �������� �����. }
  property Child[anIndex: Integer]: Tl3Variant
   read pm_GetChild;
  property ChildrenCapacity: Integer
   write Set_ChildrenCapacity;
   {* ������������ ��������� ����� ����� }
 end;//Mk2Children
 *)

 (*
 Mk2RefCount = interface
  {* ������� ������ }
  procedure SetRef(var aRef: Tl3Variant);
 end;//Mk2RefCount
 *)

 (*
 Mk2TypeInfoEx = interface(Mk2TypeInfo)
  function IsSame(aType: Tl3VariantDef): Boolean;
 end;//Mk2TypeInfoEx
 *)

 (*
 Mk2Owned = interface
  function Get_Owner: Tl3Variant;
  procedure Set_Owner(aValue: Tl3Variant);
  property Owner: Tl3Variant
   read Get_Owner
   write Set_Owner;
 end;//Mk2Owned
 *)

 (*
 Mk2IntegerHolder = interface
  function pm_GetIntA(anIndex: Integer): Integer;
  procedure pm_SetIntA(anIndex: Integer;
   aValue: Integer);
  procedure pm_SetIntW(anIndex: Integer;
   const aContext: Il3OpPack;
   aValue: Integer);
  function rLong(anIndex: Integer;
   aDefault: Integer): Integer;
  property IntA[anIndex: Integer]: Integer
   read pm_GetIntA
   write pm_SetIntA;
  property IntW[anIndex: Integer; const aContext: Il3OpPack]: Integer
   write pm_SetIntW;
 end;//Mk2IntegerHolder
 *)

 (*
 Mk2PCharLenHolder = interface
  function pm_GetPCharLenA(anIndex: Integer): Tl3PCharLen;
  procedure pm_SetPCharLenA(anIndex: Integer;
   const aValue: Tl3PCharLen);
  procedure pm_SetPCharLenW(anIndex: Integer;
   const aContext: Il3OpPack;
   const aValue: Tl3WString);
  property PCharLenA[anIndex: Integer]: Tl3PCharLen
   read pm_GetPCharLenA
   write pm_SetPCharLenA;
  property PCharLenW[anIndex: Integer; const aContext: Il3OpPack]: Tl3WString
   write pm_SetPCharLenW;
 end;//Mk2PCharLenHolder
 *)

 (*
 Mk2BooleanHolder = interface
  function pm_GetBoolA(anIndex: Integer): Boolean;
  procedure pm_SetBoolA(anIndex: Integer;
   aValue: Boolean);
  procedure pm_SetBoolW(anIndex: Integer;
   const aContext: Il3OpPack;
   aValue: Boolean);
  property BoolA[anIndex: Integer]: Boolean
   read pm_GetBoolA
   write pm_SetBoolA;
  property BoolW[anIndex: Integer; const aContext: Il3OpPack]: Boolean
   write pm_SetBoolW;
 end;//Mk2BooleanHolder
 *)

 (*
 Mk2StringHolder = interface
  function pm_GetStrA(anIndex: Integer): AnsiString;
  procedure pm_SetStrA(anIndex: Integer;
   const aValue: AnsiString);
  procedure pm_SetStrW(anIndex: Integer;
   const aContext: Il3OpPack;
   const aValue: AnsiString);
  property StrA[anIndex: Integer]: AnsiString
   read pm_GetStrA
   write pm_SetStrA;
  property StrW[anIndex: Integer; const aContext: Il3OpPack]: AnsiString
   write pm_SetStrW;
 end;//Mk2StringHolder
 *)

 (*
 Mk2TypeHolder = interface
  function pm_GetTagType: Tl3VariantDef;
  property TagType: Tl3VariantDef
   read pm_GetTagType;
 end;//Mk2TypeHolder
 *)

 (*
 Mk2TagHolder = interface
  function pm_GetAttr(anIndex: Integer): Tl3Variant;
  function rAtomEx(const Path: TOpenLongArray;
   theIndex: PLongint = nil): Tl3Variant;
   {* ������� ������. }
  function cAtom(anIndex: Integer;
   const aContext: Il3OpPack = nil;
   anAtomType: Tl3VariantDef = nil): Tl3Variant;
   {* ��������� ������������� ������� � ������� ��� ��� �������������. }
  function cAtomEx(const aPath: TOpenLongArray;
   const aContext: Il3OpPack;
   theIndex: PLongint = nil): Tl3Variant;
   {* ��������� ������������� ������� � ������� ��� ��� �������������. }
  property Attr[anIndex: Integer]: Tl3Variant
   read pm_GetAttr;
   default;
 end;//Mk2TagHolder
 *)

 (*
 Mk2TagToolProvider = interface
  function QT(const IID: TGUID;
   out Obj;
   const aProcessor: Ik2Processor = nil): Boolean;
   {* ���������� ���������� ��� ������ � �����, � �������� �������� �������� ����������. }
 end;//Mk2TagToolProvider
 *)

 (*
 Mk2Int64Holder = interface
  function Get_Int64A(aTagID: Integer): Int64;
  procedure Set_Int64A(aTagID: Integer;
   aValue: Int64);
  procedure Set_Int64W(aTagID: Integer;
   const aContext: Il3OpPack;
   aValue: Int64);
  function Get_DateTimeA(aTagID: Integer): TDateTime;
  procedure Set_DateTimeA(aTagID: Integer;
   aValue: TDateTime);
  procedure Set_DateTimeW(aTagID: Integer;
   const aContext: Il3OpPack;
   aValue: TDateTime);
  property Int64A[aTagID: Integer]: Int64
   read Get_Int64A
   write Set_Int64A;
  property Int64W[aTagID: Integer; const aContext: Il3OpPack]: Int64
   write Set_Int64W;
  property DateTimeA[aTagID: Integer]: TDateTime
   read Get_DateTimeA
   write Set_DateTimeA;
  property DateTimeW[aTagID: Integer; const aContext: Il3OpPack]: TDateTime
   write Set_DateTimeW;
 end;//Mk2Int64Holder
 *)

 (*
 Mk2TypeInfoPrim = interface
  function IsKindOf(anID: Tl3VariantDef): Boolean; overload;
   {* ��������� ������������. }
  function IsKindOf(const anIDs: array of Tk2TypePrim): Boolean; overload;
   {* ��������� ������������. }
  function IsKindOf(anAtomTypeID: Tl3VariantDef;
   const Exclude: array of Tk2TypePrim): Boolean; overload;
   {* ��������� ������������. }
 end;//Mk2TypeInfoPrim
 *)

 (*
 Ml3VariantSame = interface
  function IsSame(anOther: Tl3Variant): Boolean; overload;
 end;//Ml3VariantSame
 *)

 (*
 Ml3Tag = interface
  function GetOwnInterface(const IID: TGUID;
   out Obj): Boolean;
   {* ���������� ��������� ��������������� �������������� ����������� �����������. }
  function Box: Tl3Variant;
   {* ������ �� ��� - ��� ����������. }
 end;//Ml3Tag
 *)

 //#UC START# *53319F9C002Fci*
 //Tl3VariantDef = class;
 //#UC END# *53319F9C002Fci*
 //#UC START# *53319F9C002Fcit*
 //#UC END# *53319F9C002Fcit*
 Tl3VariantPrim = {abstract} class(Tl3DataContainerWithoutIUnknownPrim)
  protected
   function GetAsString: AnsiString; virtual;
   function GetIsOrd: Boolean; virtual;
   function GetIsKindOfPrim(aType: Tl3VariantDef): Boolean; virtual;
   function GetAsPCharLen: Tl3WString; virtual;
  public
   function QI(const aGUID: TGUID;
    out theObj): Boolean;
   function IsOrd: Boolean;
   function IsKindOf(anID: Tl3VariantDef): Boolean; overload;
    {* ��������� ������������. }
   function IsKindOf(const anIDs: array of Tk2TypePrim): Boolean; overload;
    {* ��������� ������������. }
   function IsKindOf(anAtomTypeID: Tl3VariantDef;
    const Exclude: array of Tk2TypePrim): Boolean; overload;
    {* ��������� ������������. }
 //#UC START# *53319F9C002Fpubl*
 //#UC END# *53319F9C002Fpubl*
 end;//Tl3VariantPrim

 Tl3VariantDef = {abstract} class(Tl3VariantPrim)
  protected
   procedure pm_SetIDw(aValue: Integer); virtual;
   function pm_GetAsString: AnsiString;
   function pm_GetAsWStr: Tl3WString;
   function DoDoMakeTag(aRef: Integer): Il3TagRef; virtual;
   function GetIsProp: Boolean; virtual;
   function GetAsString: AnsiString; override;
  public
   function IsProp: Boolean;
   function IsNull: Boolean;
   function MakeTag(aRef: Integer = l3NilLong): Il3TagRef;
   function IsSame(aType: Tl3VariantDef): Boolean;
  public
   property IDw: Integer
    write pm_SetIDw;
   property AsString: AnsiString
    read pm_GetAsString;
   property AsWStr: Tl3WString
    read pm_GetAsWStr;
 end;//Tl3VariantDef

 Ml3TagHolder_IterateProperties_Action = function(anItem: Tl3Variant;
  anIndex: Tl3VariantDef): Boolean;
  {* ��� �������������� ������� ��� Ml3TagHolder.IterateProperties }

 (*
 Ml3TagHolder = interface
  procedure pm_SetAttrW(anIndex: Integer;
   const aContext: Il3OpPack;
   aValue: Tl3Variant);
  procedure IterateProperties(anAction: Ml3TagHolder_IterateProperties_Action;
   anAll: Boolean
   {* ���������� ��� ��������� �������� ��� ������ ������� �������� });
   {* ���������� ��� ������������ �������� }
  procedure IteratePropertiesF(anAction: Ml3TagHolder_IterateProperties_Action;
   anAll: Boolean
   {* ���������� ��� ��������� �������� ��� ������ ������� �������� });
   {* ���������� ��� ������������ �������� }
  property AttrW[anIndex: Integer; const aContext: Il3OpPack]: Tl3Variant
   write pm_SetAttrW;
 end;//Ml3TagHolder
 *)

 (*
 Ml3TagBox = interface
  function AsObject: Tl3Variant;
 end;//Ml3TagBox
 *)

 //#UC START# *532031160122ci*
 //#UC END# *532031160122ci*
 _l3Changing_Parent_ = Tl3VariantPrim;
 {$Include l3Changing.imp.pas}
 //#UC START# *532031160122cit*
 //#UC END# *532031160122cit*
 Tl3Variant = {abstract} class(_l3Changing_)
  protected
   function pm_GetTagOwner: Tl3Variant; virtual;
   procedure pm_SetTagOwner(aValue: Tl3Variant); virtual;
   function pm_GetChildrenCount: Integer; virtual;
   procedure pm_SetChildrenCapacity(aValue: Integer); virtual;
   function pm_GetChildPrim(anIndex: Integer): Tl3Variant; virtual;
   function GetAsLong: Integer; virtual;
   function GetIsNull: Boolean; virtual;
   function GetIsTransparent: Boolean; virtual;
   function GetIsStream(out theStream: IStream): Boolean; virtual;
   function DoGetHasSubAtom(anIndex: Integer): Boolean; virtual;
   procedure DoSetRef(var theRef: Tl3Variant); virtual;
   function GetTagType: Tl3VariantDef; virtual;
   procedure SetAttr(anIndex: Integer;
    const aContext: Il3OpPack;
    aValue: Tl3Variant); virtual;
   function GetAttr(anIndex: Integer;
    out theValue: Tl3Variant): Boolean; virtual;
   procedure SetBoolAttr(anIndex: Integer;
    const aContext: Il3OpPack;
    aValue: Boolean); virtual;
   procedure SetIntAttr(anIndex: Integer;
    const aContext: Il3OpPack;
    aValue: Integer); virtual;
   procedure SetWStrAttr(anIndex: Integer;
    const aContext: Il3OpPack;
    const aValue: Tl3WString); virtual;
   procedure DoDoLoad; virtual;
   procedure DoForceStore; virtual;
   function DoIterateChildrenBack(Action: Mk2Children_IterateChildrenBack_Action;
    aHi: Tl3Index;
    aLo: Tl3Index;
    aLoadedOnly: Boolean): Integer; virtual;
   function DoAddChild(aChild: Tl3Variant;
    const aContext: Il3OpPack): Integer; virtual;
   function CheckAttr(const aPath: array of Integer;
    const aContext: Il3OpPack;
    DoCheck: Boolean;
    theIndex: PLongint): Tl3Variant; virtual;
   function DoCAtom(anIndex: Integer;
    const aContext: Il3OpPack;
    anAtomType: Tl3VariantDef): Tl3Variant; virtual;
   function GetAsBox: Tl3Variant; virtual;
   function GetAsRef: Il3TagRef; virtual;
   function GetInt64A(anIndex: Integer): Int64; virtual;
   procedure SetInt64A(anIndex: Integer;
    const aContext: Il3OpPack;
    aValue: Int64); virtual;
   function DoMarkModified: Boolean; virtual;
   procedure DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
    All: Boolean); virtual;
   function DeleteChildPrim(anIndex: Integer;
    aChild: Tl3Variant;
    const aContext: Il3OpPack): Boolean; virtual;
   function DoIterateChildrenF(Action: Mk2Children_IterateChildrenF_Action;
    aLo: Tl3Index;
    aHi: Tl3Index;
    aLoadedOnly: Boolean): Integer; virtual;
   function pm_GetAttr(anIndex: Integer): Tl3Variant;
   function pm_GetBoolA(anIndex: Integer): Boolean;
   procedure pm_SetBoolA(anIndex: Integer;
    aValue: Boolean);
   function pm_GetIntA(anIndex: Integer): Integer;
   procedure pm_SetIntA(anIndex: Integer;
    aValue: Integer);
   function pm_GetStrA(anIndex: Integer): AnsiString;
   procedure pm_SetStrA(anIndex: Integer;
    const aValue: AnsiString);
   function pm_GetChild(anIndex: Integer): Tl3Variant;
   procedure pm_SetBoolW(anIndex: Integer;
    const aContext: Il3OpPack;
    aValue: Boolean);
   procedure pm_SetIntW(anIndex: Integer;
    const aContext: Il3OpPack;
    aValue: Integer);
   procedure pm_SetStrW(anIndex: Integer;
    const aContext: Il3OpPack;
    const aValue: AnsiString);
   function pm_GetPCharLenA(anIndex: Integer): Tl3PCharLen;
   procedure pm_SetPCharLenA(anIndex: Integer;
    const aValue: Tl3PCharLen);
   procedure pm_SetPCharLenW(anIndex: Integer;
    const aContext: Il3OpPack;
    const aValue: Tl3WString);
   function pm_GetAsString: AnsiString;
   function pm_GetAsWStr: Tl3WString;
   function Get_ChildrenCount: Integer;
   procedure Set_ChildrenCapacity(aValue: Integer);
   function Get_Owner: Tl3Variant;
   procedure Set_Owner(aValue: Tl3Variant);
   function Get_Int64A(aTagID: Integer): Int64;
   procedure Set_Int64A(aTagID: Integer;
    aValue: Int64);
   procedure Set_Int64W(aTagID: Integer;
    const aContext: Il3OpPack;
    aValue: Int64);
   procedure pm_SetAttrW(anIndex: Integer;
    const aContext: Il3OpPack;
    aValue: Tl3Variant);
   function pm_GetTagType: Tl3VariantDef;
   function Get_DateTimeA(aTagID: Integer): TDateTime;
   procedure Set_DateTimeA(aTagID: Integer;
    aValue: TDateTime);
   procedure Set_DateTimeW(aTagID: Integer;
    const aContext: Il3OpPack;
    aValue: TDateTime);
   function GetIsKindOfPrim(aType: Tl3VariantDef): Boolean; override;
  public
   function TagType: Tl3VariantDef;
   function AsRef: Il3TagRef;
   function DoQT(const IID: TGUID;
    out Obj;
    const aProcessor: Ik2Processor): Boolean; virtual;
   procedure CheckSort(aProp: Tl3VariantDef); virtual;
   function FindChild(anAtom: Integer;
    aValue: Integer;
    const aContext: Il3OpPack;
    aNeedCreate: Boolean;
    theIndex: PLongint): Tl3Variant; virtual;
   function CloneTag: Il3TagRef; virtual;
   procedure WriteTag(const G: Ik2TagGenerator;
    Flags: Tk2StorePropertyFlags = k2BaseTypes.l3_spfAll;
    Exclude: TByteSet = []); virtual;
    {* �������� ��� � ���������. }
   function AssignTag(Source: Tl3Variant;
    AssignMode: Tk2AssignModes = k2BaseTypes.k2_amAll;
    const Context: Il3OpPack = nil): Boolean; virtual;
   procedure AssignCloneParams(aSource: Tl3Variant;
    AssignMode: Tk2AssignModes = k2BaseTypes.k2_amAll;
    const Context: Il3OpPack = nil); virtual;
   procedure DeleteChildren(const Context: Il3OpPack = nil); virtual;
    {* ������� ���� �����. }
   procedure InsertChildTag(anIndex: Integer;
    aChild: Tl3Variant;
    const aContext: Il3OpPack = nil); virtual;
    {* �������� �������. }
   function IndexOfChild(aChild: Tl3Variant): Integer; virtual;
   function rOwnAtom(anIndex: Integer): Tl3Variant; virtual;
   function GetLinkedInterface(const IID: TGUID;
    out Obj): Boolean; virtual;
   function CompareWithInt(aValue: Integer;
    anIndex: Integer): Integer; virtual;
    {* ���������� ��� � �����. }
   function CompareWithTag(aTag: Tl3Variant;
    aSortIndex: Tl3SortIndex): Integer; virtual;
   function Box: Tl3Variant;
    {* ������ �� ��� - ��� ����������. }
   function AsBool: Boolean;
    {* ������������� � Boolean. }
   function AsLong: Integer;
   function AsObject: Tl3Variant;
   function AddChild(aChild: Tl3Variant;
    const aContext: Il3OpPack = nil): Integer;
    {* �������� �������. }
   procedure SetRef(var aRef: Tl3Variant);
   function DeleteChild(anIndex: Integer;
    const anOp: Il3OpPack;
    out theChild: Il3TagRef): Boolean; overload;
    {* ������� �������. }
   function DeleteChild(aChild: Tl3Variant;
    const Context: Il3OpPack = nil): Boolean; overload;
    {* ������� �������. }
   function DeleteChild(anIndex: Integer;
    const anOp: Il3OpPack = nil): Boolean; overload;
   procedure DoLoad;
   procedure ForceStore;
   function MarkModified: Boolean;
   function IterateChildrenF(anAction: Mk2Children_IterateChildrenF_Action;
    aLo: Tl3Index = l3Interfaces.l3MinIndex;
    aHi: Tl3Index = l3Interfaces.l3MaxIndex;
    aLoadedOnly: Boolean = False): Integer;
   function IterateChildrenBack(anAction: Mk2Children_IterateChildrenBack_Action;
    aHi: Tl3Index = l3Interfaces.l3MaxIndex;
    aLo: Tl3Index = l3Interfaces.l3MinIndex;
    aLoadedOnly: Boolean = False): Integer;
   function IterateChildrenBackF(anAction: Mk2Children_IterateChildrenBack_Action;
    aHi: Tl3Index = l3Interfaces.l3MaxIndex;
    aLo: Tl3Index = l3Interfaces.l3MinIndex;
    aLoadedOnly: Boolean = False): Integer;
   procedure IterateProperties(anAction: Ml3TagHolder_IterateProperties_Action;
    anAll: Boolean
    {* ���������� ��� ��������� �������� ��� ������ ������� �������� });
    {* ���������� ��� ������������ �������� }
   procedure IteratePropertiesF(anAction: Ml3TagHolder_IterateProperties_Action;
    anAll: Boolean
    {* ���������� ��� ��������� �������� ��� ������ ������� �������� });
    {* ���������� ��� ������������ �������� }
   function rLong(anIndex: Integer;
    aDefault: Integer): Integer;
   function rAtomEx(const Path: TOpenLongArray;
    theIndex: PLongint = nil): Tl3Variant;
    {* ������� ������. }
   function cAtom(anIndex: Integer;
    const aContext: Il3OpPack = nil;
    anAtomType: Tl3VariantDef = nil): Tl3Variant;
    {* ��������� ������������� ������� � ������� ��� ��� �������������. }
   function cAtomEx(const aPath: TOpenLongArray;
    const aContext: Il3OpPack;
    theIndex: PLongint = nil): Tl3Variant;
    {* ��������� ������������� ������� � ������� ��� ��� �������������. }
   function HasSubAtom(anIndex: Integer): Boolean;
   function IsNull: Boolean;
    {* ������ ���? }
   function IsValid: Boolean;
    {* ��� ����� ��������? }
   function IsTransparent: Boolean;
    {* ��� "����������"? }
   function IsStream(out theStream: IStream): Boolean;
    {* ��������� ����� �� ��� ����������� � ������. � �������� � ������ - ���� ��������� �� ����� - �� �������. }
   function QT(const IID: TGUID;
    out Obj;
    const aProcessor: Ik2Processor = nil): Boolean;
    {* ���������� ���������� ��� ������ � �����, � �������� �������� �������� ����������. }
   function GetOwnInterface(const IID: TGUID;
    out Obj): Boolean;
    {* ���������� ��������� ��������������� �������������� ����������� �����������. }
   function IsSame(anOther: Tl3Variant): Boolean; overload;
  protected
   property TagOwner: Tl3Variant
    read pm_GetTagOwner
    write pm_SetTagOwner;
  public
   property ChildrenCount: Integer
    read pm_GetChildrenCount;
   property ChildrenCapacity: Integer
    write pm_SetChildrenCapacity;
   property ChildPrim[anIndex: Integer]: Tl3Variant
    read pm_GetChildPrim;
 //#UC START# *532031160122publ*
 public
   property Child[anIndex: Integer]: Tl3Variant
     read pm_GetChild;
   property AsWStr: Tl3WString
     read pm_GetAsWStr;
   property AsString: AnsiString
     read pm_GetAsString;
   property AttrW[anIndex  : Integer;
                  const aContext : Il3OpPack]: Tl3Variant
     write pm_SetAttrW;
     {-}
   property BoolA[anIndex  : Integer]: Boolean
     read pm_GetBoolA
     write pm_SetBoolA;
     {* - �������� ��������. }
   property BoolW[anIndex  : Integer;
                  const aContext : Il3OpPack]: Boolean
     write pm_SetBoolW;
     {* - �������� ��������. }
  property IntW[anIndex  : Integer;
                const aContext : Il3OpPack]: Integer
    write pm_SetIntW;
    {* - �������� ��������. }
  property IntA[anIndex: Integer]: Integer
    read pm_GetIntA
    write pm_SetIntA;
    {* - �������� ��������. }
  property PCharLenA[anIndex: Integer]: Tl3PCharLen
    read pm_GetPCharLenA
    write pm_SetPCharLenA;
    {-}
  property PCharLenW[anIndex  : Integer;
                     const aContext : Il3OpPack]: Tl3WString
    write pm_SetPCharLenW;
    {-}
  property StrA[anIndex: Integer]: AnsiString
    read pm_GetStrA
    write pm_SetStrA;
    {-}
  property StrW[anIndex  : Integer;
                const aContext : Il3OpPack]: AnsiString
    write pm_SetStrW;
    {-}
  property Owner: Tl3Variant
    read Get_Owner
    write Set_Owner;
  property Attr[anIndex: Integer]: Tl3Variant
    read pm_GetAttr;
    {-}
  property Int64A[aTagID: Integer]: Int64
    read Get_Int64A
    write Set_Int64A;
  property Int64W[aTagID: Integer; const aContext: Il3OpPack]: Int64
    write Set_Int64W;
  property DateTimeA[aTagID: Integer]: TDateTime
    read Get_DateTimeA
    write Set_DateTimeA;
  property DateTimeW[aTagID: Integer; const aContext: Il3OpPack]: TDateTime
    write Set_DateTimeW;
 //#UC END# *532031160122publ*
 end;//Tl3Variant

 Tl3Tag = Tl3Variant;

 Tl3PrimString = {abstract} class(Tl3Tag)
  protected
   function pm_GetAsString: AnsiString;
   procedure pm_SetAsString(const aValue: AnsiString);
   function pm_GetAsWStr: Tl3WString;
   procedure pm_SetAsWStr(const aValue: Tl3WString);
   function pm_GetStringID: Integer; virtual;
   procedure pm_SetStringID(aValue: Integer); virtual;
   function pm_GetLinkedObject: TObject; virtual;
   procedure pm_SetLinkedObject(aValue: TObject); virtual;
   procedure DoSetAsPCharLen(const Value: Tl3PCharLen); virtual;
   function GetAsPCharLen: Tl3WString; override;
   function GetEmpty: Boolean; override;
   function GetAsString: AnsiString; override;
  public
   procedure Clear; virtual;
    {* ������� ������� �������.  ��� ���������� � ��������. }
   procedure AssignString(aStr: Tl3PrimString); virtual;
    {* �������� ������ ������ ������. }
   function Clone: Pointer; virtual;
    {* ������� ����� ������. }
  public
   property AsString: AnsiString
    read pm_GetAsString
    write pm_SetAsString;
    {* �������� ��� �������������� � ������� Delphi � �������. }
   property AsWStr: Tl3WString
    read pm_GetAsWStr
    write pm_SetAsWStr;
   property StringID: Integer
    read pm_GetStringID
    write pm_SetStringID;
    {* �������������. }
   property LinkedObject: TObject
    read pm_GetLinkedObject
    write pm_SetLinkedObject;
    {* ������, ����������� � ������. }
 end;//Tl3PrimString

 Ik2Variant = interface
  ['{20DEC442-9EE5-44F0-9864-C00BA36614BD}']
  function Get_AsString: Tl3PrimString;
  function Get_AsInteger: Integer;
  function Get_AsStream: TStream;
  function Get_AsVariant: Tl3Variant;
  function Get_Kind: Tk2VarKind;
  property AsString: Tl3PrimString
   read Get_AsString;
  property AsInteger: Integer
   read Get_AsInteger;
  property AsStream: TStream
   read Get_AsStream;
  property AsVariant: Tl3Variant
   read Get_AsVariant;
  property Kind: Tk2VarKind
   read Get_Kind;
 end;//Ik2Variant

 Il3TagRef = interface
  ['{16D0331A-45FA-4609-B8AC-C7C1B101B169}']
  function AsObject: Tl3Variant;
 end;//Il3TagRef

 Tl3Type = Tl3VariantDef;

 Ik2Tag = interface(Il3TagRef)
  {* ������ ���������� ���������� � ��������� �������� }
  ['{2345D08B-36E3-4B6A-ABA8-82C74B3431DF}']
  function Get_ChildrenCount: Integer;
  function pm_GetChild(anIndex: Integer): Tl3Variant;
  procedure Set_ChildrenCapacity(aValue: Integer);
  function Get_Owner: Tl3Variant;
  procedure Set_Owner(aValue: Tl3Variant);
  function pm_GetIntA(anIndex: Integer): Integer;
  procedure pm_SetIntA(anIndex: Integer;
   aValue: Integer);
  procedure pm_SetIntW(anIndex: Integer;
   const aContext: Il3OpPack;
   aValue: Integer);
  function pm_GetPCharLenA(anIndex: Integer): Tl3PCharLen;
  procedure pm_SetPCharLenA(anIndex: Integer;
   const aValue: Tl3PCharLen);
  procedure pm_SetPCharLenW(anIndex: Integer;
   const aContext: Il3OpPack;
   const aValue: Tl3WString);
  function pm_GetBoolA(anIndex: Integer): Boolean;
  procedure pm_SetBoolA(anIndex: Integer;
   aValue: Boolean);
  procedure pm_SetBoolW(anIndex: Integer;
   const aContext: Il3OpPack;
   aValue: Boolean);
  function pm_GetStrA(anIndex: Integer): AnsiString;
  procedure pm_SetStrA(anIndex: Integer;
   const aValue: AnsiString);
  procedure pm_SetStrW(anIndex: Integer;
   const aContext: Il3OpPack;
   const aValue: AnsiString);
  function pm_GetTagType: Tl3VariantDef;
  function pm_GetAttr(anIndex: Integer): Tl3Variant;
  function Get_Int64A(aTagID: Integer): Int64;
  procedure Set_Int64A(aTagID: Integer;
   aValue: Int64);
  procedure Set_Int64W(aTagID: Integer;
   const aContext: Il3OpPack;
   aValue: Int64);
  function Get_DateTimeA(aTagID: Integer): TDateTime;
  procedure Set_DateTimeA(aTagID: Integer;
   aValue: TDateTime);
  procedure Set_DateTimeW(aTagID: Integer;
   const aContext: Il3OpPack;
   aValue: TDateTime);
  function pm_GetAsWStr: Tl3WString;
  function pm_GetAsString: AnsiString;
  procedure pm_SetAttrW(anIndex: Integer;
   const aContext: Il3OpPack;
   aValue: Tl3Variant);
  function IsOrd: Boolean;
  function IterateChildrenF(anAction: Mk2Children_IterateChildrenF_Action;
   aLo: Tl3Index = l3Interfaces.l3MinIndex;
   aHi: Tl3Index = l3Interfaces.l3MaxIndex;
   aLoadedOnly: Boolean = False): Integer;
  function IterateChildrenBack(anAction: Mk2Children_IterateChildrenBack_Action;
   aHi: Tl3Index = l3Interfaces.l3MaxIndex;
   aLo: Tl3Index = l3Interfaces.l3MinIndex;
   aLoadedOnly: Boolean = False): Integer;
  function IterateChildrenBackF(anAction: Mk2Children_IterateChildrenBack_Action;
   aHi: Tl3Index = l3Interfaces.l3MaxIndex;
   aLo: Tl3Index = l3Interfaces.l3MinIndex;
   aLoadedOnly: Boolean = False): Integer;
  function AddChild(aChild: Tl3Variant;
   const aContext: Il3OpPack = nil): Integer;
   {* �������� �������. }
  function DeleteChild(anIndex: Integer;
   const anOp: Il3OpPack;
   out theChild: Il3TagRef): Boolean; overload;
   {* ������� �������. }
  function DeleteChild(aChild: Tl3Variant;
   const Context: Il3OpPack = nil): Boolean; overload;
   {* ������� �������. }
  function DeleteChild(anIndex: Integer;
   const anOp: Il3OpPack = nil): Boolean; overload;
  procedure SetRef(var aRef: Tl3Variant);
  procedure DoLoad;
  procedure ForceStore;
  function rLong(anIndex: Integer;
   aDefault: Integer): Integer;
  function rAtomEx(const Path: TOpenLongArray;
   theIndex: PLongint = nil): Tl3Variant;
   {* ������� ������. }
  function cAtom(anIndex: Integer;
   const aContext: Il3OpPack = nil;
   anAtomType: Tl3VariantDef = nil): Tl3Variant;
   {* ��������� ������������� ������� � ������� ��� ��� �������������. }
  function cAtomEx(const aPath: TOpenLongArray;
   const aContext: Il3OpPack;
   theIndex: PLongint = nil): Tl3Variant;
   {* ��������� ������������� ������� � ������� ��� ��� �������������. }
  function HasSubAtom(anIndex: Integer): Boolean;
  function QT(const IID: TGUID;
   out Obj;
   const aProcessor: Ik2Processor = nil): Boolean;
   {* ���������� ���������� ��� ������ � �����, � �������� �������� �������� ����������. }
  function AsBool: Boolean;
   {* ������������� � Boolean. }
  function AsLong: Integer;
  function IsNull: Boolean;
   {* ������ ���? }
  function IsTransparent: Boolean;
   {* ��� "����������"? }
  function IsValid: Boolean;
   {* ��� ����� ��������? }
  function IsStream(out theStream: IStream): Boolean;
   {* ��������� ����� �� ��� ����������� � ������. � �������� � ������ - ���� ��������� �� ����� - �� �������. }
  function MarkModified: Boolean;
  function IsKindOf(anID: Tl3VariantDef): Boolean; overload;
   {* ��������� ������������. }
  function IsKindOf(const anIDs: array of Tk2TypePrim): Boolean; overload;
   {* ��������� ������������. }
  function IsKindOf(anAtomTypeID: Tl3VariantDef;
   const Exclude: array of Tk2TypePrim): Boolean; overload;
   {* ��������� ������������. }
  function IsSame(anOther: Tl3Variant): Boolean; overload;
  function GetOwnInterface(const IID: TGUID;
   out Obj): Boolean;
   {* ���������� ��������� ��������������� �������������� ����������� �����������. }
  function Box: Tl3Variant;
   {* ������ �� ��� - ��� ����������. }
  procedure IterateProperties(anAction: Ml3TagHolder_IterateProperties_Action;
   anAll: Boolean
   {* ���������� ��� ��������� �������� ��� ������ ������� �������� });
   {* ���������� ��� ������������ �������� }
  procedure IteratePropertiesF(anAction: Ml3TagHolder_IterateProperties_Action;
   anAll: Boolean
   {* ���������� ��� ��������� �������� ��� ������ ������� �������� });
   {* ���������� ��� ������������ �������� }
  property ChildrenCount: Integer
   read Get_ChildrenCount;
   {* ���������� �������� �����. }
  property Child[anIndex: Integer]: Tl3Variant
   read pm_GetChild;
  property ChildrenCapacity: Integer
   write Set_ChildrenCapacity;
   {* ������������ ��������� ����� ����� }
  property Owner: Tl3Variant
   read Get_Owner
   write Set_Owner;
  property IntA[anIndex: Integer]: Integer
   read pm_GetIntA
   write pm_SetIntA;
  property IntW[anIndex: Integer; const aContext: Il3OpPack]: Integer
   write pm_SetIntW;
  property PCharLenA[anIndex: Integer]: Tl3PCharLen
   read pm_GetPCharLenA
   write pm_SetPCharLenA;
  property PCharLenW[anIndex: Integer; const aContext: Il3OpPack]: Tl3WString
   write pm_SetPCharLenW;
  property BoolA[anIndex: Integer]: Boolean
   read pm_GetBoolA
   write pm_SetBoolA;
  property BoolW[anIndex: Integer; const aContext: Il3OpPack]: Boolean
   write pm_SetBoolW;
  property StrA[anIndex: Integer]: AnsiString
   read pm_GetStrA
   write pm_SetStrA;
  property StrW[anIndex: Integer; const aContext: Il3OpPack]: AnsiString
   write pm_SetStrW;
  property TagType: Tl3VariantDef
   read pm_GetTagType;
  property Attr[anIndex: Integer]: Tl3Variant
   read pm_GetAttr;
   default;
  property Int64A[aTagID: Integer]: Int64
   read Get_Int64A
   write Set_Int64A;
  property Int64W[aTagID: Integer; const aContext: Il3OpPack]: Int64
   write Set_Int64W;
  property DateTimeA[aTagID: Integer]: TDateTime
   read Get_DateTimeA
   write Set_DateTimeA;
  property DateTimeW[aTagID: Integer; const aContext: Il3OpPack]: TDateTime
   write Set_DateTimeW;
  property AsWStr: Tl3WString
   read pm_GetAsWStr;
   {* �������� ��� �������������� � ���� Tl3PCharLen }
  property AsString: AnsiString
   read pm_GetAsString;
   {* �������� ��� �������������� � ������� Delphi }
  property AttrW[anIndex: Integer; const aContext: Il3OpPack]: Tl3Variant
   write pm_SetAttrW;
 end;//Ik2Tag

 Pl3Variant = ^Tl3Variant;

 Tl3NullTag = class(Tl3ProtoObject, Il3TagRef)
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   function AsObject: Tl3Variant;
   class function Instance: Tl3NullTag;
    {* ����� ��������� ���������� ���������� Tl3NullTag }
 end;//Tl3NullTag

 Tl3TagRef = class(Tl3ProtoObject, Il3TagRef)
  private
   f_Tag: Tl3Tag;
  protected
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   constructor Create(aTag: Tl3Tag); reintroduce;
   class function Make(aTag: Tl3Tag): Il3TagRef; reintroduce;
   function AsObject: Tl3Variant;
   function QueryInterface(const IID: TGUID;
    out Obj): HResult; override;
    {* �������� ������� ��������� � ��������������, ���� ��� ��������. }
 end;//Tl3TagRef

 Tk2In64Converter = packed record
  rLo: Integer;
  rHi: Integer;
 end;//Tk2In64Converter

function L2Mk2ChildrenIterateChildrenFAction(anAction: pointer): Mk2Children_IterateChildrenF_Action;
 {* ������� ������������ �������� ��� ��������� �������������� ������� ��� Mk2Children.IterateChildrenF }
function L2Mk2ChildrenIterateChildrenBackAction(anAction: pointer): Mk2Children_IterateChildrenBack_Action;
 {* ������� ������������ �������� ��� ��������� �������������� ������� ��� Mk2Children.IterateChildrenBack }
function L2Ml3TagHolderIteratePropertiesAction(anAction: pointer): Ml3TagHolder_IterateProperties_Action;
 {* ������� ������������ �������� ��� ��������� �������������� ������� ��� Ml3TagHolder.IterateProperties }
function Supports(anObject: Tl3VariantPrim;
 const aGUID: TGUID;
 out theObj): Boolean; overload;

implementation

uses
 l3ImplUses
 , l3Base
 , Windows
 , l3String
 , l3Chars
 , SysUtils
 , l3Date
;

var g_Tl3NullTag: Tl3NullTag = nil;
 {* ��������� ���������� Tl3NullTag }

function L2Mk2ChildrenIterateChildrenFAction(anAction: pointer): Mk2Children_IterateChildrenF_Action;
 {* ������� ������������ �������� ��� ��������� �������������� ������� ��� Mk2Children.IterateChildrenF }
asm
 jmp l3LocalStub
end;//L2Mk2ChildrenIterateChildrenFAction

function L2Mk2ChildrenIterateChildrenBackAction(anAction: pointer): Mk2Children_IterateChildrenBack_Action;
 {* ������� ������������ �������� ��� ��������� �������������� ������� ��� Mk2Children.IterateChildrenBack }
asm
 jmp l3LocalStub
end;//L2Mk2ChildrenIterateChildrenBackAction

function L2Ml3TagHolderIteratePropertiesAction(anAction: pointer): Ml3TagHolder_IterateProperties_Action;
 {* ������� ������������ �������� ��� ��������� �������������� ������� ��� Ml3TagHolder.IterateProperties }
asm
 jmp l3LocalStub
end;//L2Ml3TagHolderIteratePropertiesAction

procedure Tl3NullTagFree;
 {* ����� ������������ ���������� ���������� Tl3NullTag }
begin
 l3Free(g_Tl3NullTag);
end;//Tl3NullTagFree

function Supports(anObject: Tl3VariantPrim;
 const aGUID: TGUID;
 out theObj): Boolean;
//#UC START# *5342A452039F_53317D14019D_var*
var
 l_Unknown : IUnknown;
//#UC END# *5342A452039F_53317D14019D_var*
begin
//#UC START# *5342A452039F_53317D14019D_impl*
 Result := SysUtils.Supports(anObject, aGUID, theObj);
 Assert(Result OR (anObject = nil) OR anObject.GetInterface(IUnknown, l_Unknown));
 if not Result then
  Result := anObject.QI(aGUID, theObj);
//#UC END# *5342A452039F_53317D14019D_impl*
end;//Supports

function Tl3VariantPrim.GetAsString: AnsiString;
//#UC START# *5329CD1A020E_53319F9C002F_var*
//#UC END# *5329CD1A020E_53319F9C002F_var*
begin
//#UC START# *5329CD1A020E_53319F9C002F_impl*
 Result := '';
 Assert(false, '���������� ������������� ' + ClassName + ' � AnsiString');
//#UC END# *5329CD1A020E_53319F9C002F_impl*
end;//Tl3VariantPrim.GetAsString

function Tl3VariantPrim.GetIsOrd: Boolean;
//#UC START# *532AE8F2009A_53319F9C002F_var*
//#UC END# *532AE8F2009A_53319F9C002F_var*
begin
//#UC START# *532AE8F2009A_53319F9C002F_impl*
 Result := false;
 Assert(false, '���������� ��������� IsOrd ��� ' + ClassName);
//#UC END# *532AE8F2009A_53319F9C002F_impl*
end;//Tl3VariantPrim.GetIsOrd

function Tl3VariantPrim.GetIsKindOfPrim(aType: Tl3VariantDef): Boolean;
//#UC START# *533129DC037C_53319F9C002F_var*
//#UC END# *533129DC037C_53319F9C002F_var*
begin
//#UC START# *533129DC037C_53319F9C002F_impl*
 Result := false;
 Assert(false, '�� �������� GetIsKindOfPrim ��� ' + ClassName);
//#UC END# *533129DC037C_53319F9C002F_impl*
end;//Tl3VariantPrim.GetIsKindOfPrim

function Tl3VariantPrim.QI(const aGUID: TGUID;
 out theObj): Boolean;
//#UC START# *5342ACBB023A_53319F9C002F_var*
//#UC END# *5342ACBB023A_53319F9C002F_var*
begin
//#UC START# *5342ACBB023A_53319F9C002F_impl*
 if (Self = nil) then
  Result := false
 else
 if Succeeded(Self.QueryInterface(aGUID, theObj)) then
  Result := true
 else
  Result := false;
//#UC END# *5342ACBB023A_53319F9C002F_impl*
end;//Tl3VariantPrim.QI

function Tl3VariantPrim.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_53319F9C002F_var*
//#UC END# *47A869BB02DE_53319F9C002F_var*
begin
//#UC START# *47A869BB02DE_53319F9C002F_impl*
 l3AssignNil(Result);
 Assert(false, '���������� ������������� ' + ClassName + ' � Tl3WString');
//#UC END# *47A869BB02DE_53319F9C002F_impl*
end;//Tl3VariantPrim.GetAsPCharLen

function Tl3VariantPrim.IsOrd: Boolean;
//#UC START# *4A421BE201A9_53319F9C002F_var*
//#UC END# *4A421BE201A9_53319F9C002F_var*
begin
//#UC START# *4A421BE201A9_53319F9C002F_impl*
 if (Self = nil) then
  Result := true
 else
  Result := GetIsOrd;
//#UC END# *4A421BE201A9_53319F9C002F_impl*
end;//Tl3VariantPrim.IsOrd

function Tl3VariantPrim.IsKindOf(anID: Tl3VariantDef): Boolean;
 {* ��������� ������������. }
//#UC START# *4A421BED00FF_53319F9C002F_var*
//#UC END# *4A421BED00FF_53319F9C002F_var*
begin
//#UC START# *4A421BED00FF_53319F9C002F_impl*
 if (Self = nil) then
  Result := (anID = nil)
 else
  Result := GetIsKindOfPrim(anID);
//#UC END# *4A421BED00FF_53319F9C002F_impl*
end;//Tl3VariantPrim.IsKindOf

function Tl3VariantPrim.IsKindOf(const anIDs: array of Tk2TypePrim): Boolean;
 {* ��������� ������������. }
//#UC START# *4A421BF200BF_53319F9C002F_var*
var
 l_Index : Integer;
//#UC END# *4A421BF200BF_53319F9C002F_var*
begin
//#UC START# *4A421BF200BF_53319F9C002F_impl*
 Result := false;
 for l_Index := Low(anIDs) to High(anIDs) do
  if IsKindOf(anIDs[l_Index]) then
  begin
   Result := true;
   break;
  end;//IsKindOf(ID[l_Index])
//#UC END# *4A421BF200BF_53319F9C002F_impl*
end;//Tl3VariantPrim.IsKindOf

function Tl3VariantPrim.IsKindOf(anAtomTypeID: Tl3VariantDef;
 const Exclude: array of Tk2TypePrim): Boolean;
 {* ��������� ������������. }
//#UC START# *4A421C12034A_53319F9C002F_var*
var
 l_Index : Integer;
//#UC END# *4A421C12034A_53319F9C002F_var*
begin
//#UC START# *4A421C12034A_53319F9C002F_impl*
 Result := IsKindOf(anAtomTypeID);
 if Result then
  for l_Index := Low(Exclude) to High(Exclude) do
   if IsKindOf(Exclude[l_Index]) then
   begin
    Result := false;
    break;
   end;//IsKindOf(ID[l_Index])
//#UC END# *4A421C12034A_53319F9C002F_impl*
end;//Tl3VariantPrim.IsKindOf

//#UC START# *53319F9C002Fimpl*
//#UC END# *53319F9C002Fimpl*

procedure Tl3VariantDef.pm_SetIDw(aValue: Integer);
//#UC START# *5331A12D0103_5331A06F028Aset_var*
//#UC END# *5331A12D0103_5331A06F028Aset_var*
begin
//#UC START# *5331A12D0103_5331A06F028Aset_impl*
 Assert(false, '���������� ��������� ������������� � ' + ClassName)
//#UC END# *5331A12D0103_5331A06F028Aset_impl*
end;//Tl3VariantDef.pm_SetIDw

function Tl3VariantDef.pm_GetAsString: AnsiString;
//#UC START# *5331A15E00B3_5331A06F028Aget_var*
//#UC END# *5331A15E00B3_5331A06F028Aget_var*
begin
//#UC START# *5331A15E00B3_5331A06F028Aget_impl*
 if (Self = nil) then
  Result := ''
 else
  Result := GetAsString;
//#UC END# *5331A15E00B3_5331A06F028Aget_impl*
end;//Tl3VariantDef.pm_GetAsString

function Tl3VariantDef.pm_GetAsWStr: Tl3WString;
//#UC START# *5331A8F1002E_5331A06F028Aget_var*
//#UC END# *5331A8F1002E_5331A06F028Aget_var*
begin
//#UC START# *5331A8F1002E_5331A06F028Aget_impl*
 if (Self = nil) then
  l3AssignNil(Result)
 else
  Result := GetAsPCharLen;
//#UC END# *5331A8F1002E_5331A06F028Aget_impl*
end;//Tl3VariantDef.pm_GetAsWStr

function Tl3VariantDef.IsProp: Boolean;
//#UC START# *4A4DE21A0276_5331A06F028A_var*
//#UC END# *4A4DE21A0276_5331A06F028A_var*
begin
//#UC START# *4A4DE21A0276_5331A06F028A_impl*
 Result := (Self <> nil) AND GetIsProp;
//#UC END# *4A4DE21A0276_5331A06F028A_impl*
end;//Tl3VariantDef.IsProp

function Tl3VariantDef.IsNull: Boolean;
//#UC START# *4A4DE23F0106_5331A06F028A_var*
//#UC END# *4A4DE23F0106_5331A06F028A_var*
begin
//#UC START# *4A4DE23F0106_5331A06F028A_impl*
 Result := (Self = nil);
//#UC END# *4A4DE23F0106_5331A06F028A_impl*
end;//Tl3VariantDef.IsNull

function Tl3VariantDef.MakeTag(aRef: Integer = l3NilLong): Il3TagRef;
//#UC START# *535690980333_5331A06F028A_var*
//#UC END# *535690980333_5331A06F028A_var*
begin
//#UC START# *535690980333_5331A06F028A_impl*
 Assert(Self <> nil);
 Result := DoDoMakeTag(aRef);
//#UC END# *535690980333_5331A06F028A_impl*
end;//Tl3VariantDef.MakeTag

function Tl3VariantDef.DoDoMakeTag(aRef: Integer): Il3TagRef;
//#UC START# *5356910A0042_5331A06F028A_var*
//#UC END# *5356910A0042_5331A06F028A_var*
begin
//#UC START# *5356910A0042_5331A06F028A_impl*
 Result := nil;
 Assert(false, '�� ������������ ����� DoDoMakeTag � ' + ClassName);
//#UC END# *5356910A0042_5331A06F028A_impl*
end;//Tl3VariantDef.DoDoMakeTag

function Tl3VariantDef.GetIsProp: Boolean;
//#UC START# *4A4DE1FE035C_5331A06F028A_var*
//#UC END# *4A4DE1FE035C_5331A06F028A_var*
begin
//#UC START# *4A4DE1FE035C_5331A06F028A_impl*
 Result := false;
//#UC END# *4A4DE1FE035C_5331A06F028A_impl*
end;//Tl3VariantDef.GetIsProp

function Tl3VariantDef.IsSame(aType: Tl3VariantDef): Boolean;
//#UC START# *4A51E39F033B_5331A06F028A_var*
//#UC END# *4A51E39F033B_5331A06F028A_var*
begin
//#UC START# *4A51E39F033B_5331A06F028A_impl*
 Result := (Self = aType);
//#UC END# *4A51E39F033B_5331A06F028A_impl*
end;//Tl3VariantDef.IsSame

function Tl3VariantDef.GetAsString: AnsiString;
//#UC START# *5329CD1A020E_5331A06F028A_var*
var
 l_S : Tl3WString;
//#UC END# *5329CD1A020E_5331A06F028A_var*
begin
//#UC START# *5329CD1A020E_5331A06F028A_impl*
 l_S := GetAsPCharLen;
 if (l_S.SCodePage = CP_Unicode) then
  Result := l3PCharLen2String(l_S, CP_ANSI)
 else
  Result := l3PCharLen2String(l_S, l_S.SCodePage);
//#UC END# *5329CD1A020E_5331A06F028A_impl*
end;//Tl3VariantDef.GetAsString

{$Include l3Changing.imp.pas}

function Tl3Variant.pm_GetTagOwner: Tl3Variant;
//#UC START# *53343980014A_532031160122get_var*
//#UC END# *53343980014A_532031160122get_var*
begin
//#UC START# *53343980014A_532031160122get_impl*
 Result := nil;
//#UC END# *53343980014A_532031160122get_impl*
end;//Tl3Variant.pm_GetTagOwner

procedure Tl3Variant.pm_SetTagOwner(aValue: Tl3Variant);
//#UC START# *53343980014A_532031160122set_var*
//#UC END# *53343980014A_532031160122set_var*
begin
//#UC START# *53343980014A_532031160122set_impl*
 Assert(false, 'pm_SetTagOwner ������ ���� �������� � ' + ClassName);
//#UC END# *53343980014A_532031160122set_impl*
end;//Tl3Variant.pm_SetTagOwner

function Tl3Variant.pm_GetChildrenCount: Integer;
//#UC START# *5335815D03DC_532031160122get_var*
//#UC END# *5335815D03DC_532031160122get_var*
begin
//#UC START# *5335815D03DC_532031160122get_impl*
 Result := 0;
 Assert(false, 'pm_GetChildrenCount ������ ���� �������� � ' + ClassName);
//#UC END# *5335815D03DC_532031160122get_impl*
end;//Tl3Variant.pm_GetChildrenCount

procedure Tl3Variant.pm_SetChildrenCapacity(aValue: Integer);
//#UC START# *533581770377_532031160122set_var*
//#UC END# *533581770377_532031160122set_var*
begin
//#UC START# *533581770377_532031160122set_impl*
 Assert(false, 'pm_SetChildrenCapacity ������ ���� �������� � ' + ClassName);
//#UC END# *533581770377_532031160122set_impl*
end;//Tl3Variant.pm_SetChildrenCapacity

function Tl3Variant.pm_GetChildPrim(anIndex: Integer): Tl3Variant;
//#UC START# *53358545012C_532031160122get_var*
//#UC END# *53358545012C_532031160122get_var*
begin
//#UC START# *53358545012C_532031160122get_impl*
 Result := nil;
 Assert(false, 'pm_GetChildPrim ������ ���� �������� � ' + ClassName);
//#UC END# *53358545012C_532031160122get_impl*
end;//Tl3Variant.pm_GetChildPrim

function Tl3Variant.GetAsLong: Integer;
//#UC START# *5326D7B603A3_532031160122_var*
//#UC END# *5326D7B603A3_532031160122_var*
begin
//#UC START# *5326D7B603A3_532031160122_impl*
 Assert(false, '���������� ������������� ' + ClassName + ' � Integer');
 Result := 0;
//#UC END# *5326D7B603A3_532031160122_impl*
end;//Tl3Variant.GetAsLong

function Tl3Variant.GetIsNull: Boolean;
//#UC START# *5327E77D0084_532031160122_var*
//#UC END# *5327E77D0084_532031160122_var*
begin
//#UC START# *5327E77D0084_532031160122_impl*
 Result := false;
//#UC END# *5327E77D0084_532031160122_impl*
end;//Tl3Variant.GetIsNull

function Tl3Variant.GetIsTransparent: Boolean;
//#UC START# *5327E7AA01F1_532031160122_var*
//#UC END# *5327E7AA01F1_532031160122_var*
begin
//#UC START# *5327E7AA01F1_532031160122_impl*
 Result := false;
//#UC END# *5327E7AA01F1_532031160122_impl*
end;//Tl3Variant.GetIsTransparent

function Tl3Variant.GetIsStream(out theStream: IStream): Boolean;
//#UC START# *530B20AC019A_532031160122_var*
//#UC END# *530B20AC019A_532031160122_var*
begin
//#UC START# *530B20AC019A_532031160122_impl*
 Result := false;
//#UC END# *530B20AC019A_532031160122_impl*
end;//Tl3Variant.GetIsStream

function Tl3Variant.DoGetHasSubAtom(anIndex: Integer): Boolean;
//#UC START# *532AD5480329_532031160122_var*
//#UC END# *532AD5480329_532031160122_var*
begin
//#UC START# *532AD5480329_532031160122_impl*
 Result := false;
//#UC END# *532AD5480329_532031160122_impl*
end;//Tl3Variant.DoGetHasSubAtom

function Tl3Variant.TagType: Tl3VariantDef;
//#UC START# *533121900355_532031160122_var*
//#UC END# *533121900355_532031160122_var*
begin
//#UC START# *533121900355_532031160122_impl*
 if (Self = nil) then
  Result := nil
 else
  Result := GetTagType; 
//#UC END# *533121900355_532031160122_impl*
end;//Tl3Variant.TagType

function Tl3Variant.AsRef: Il3TagRef;
//#UC START# *5346C0B5023A_532031160122_var*
//#UC END# *5346C0B5023A_532031160122_var*
begin
//#UC START# *5346C0B5023A_532031160122_impl*
 if (Self = nil) then
  Result := Tl3NullTag.Instance
 else
  Result := GetAsRef;
//#UC END# *5346C0B5023A_532031160122_impl*
end;//Tl3Variant.AsRef

procedure Tl3Variant.DoSetRef(var theRef: Tl3Variant);
//#UC START# *533069050153_532031160122_var*
//#UC END# *533069050153_532031160122_var*
begin
//#UC START# *533069050153_532031160122_impl*
 Self.SetRefTo(theRef);
//#UC END# *533069050153_532031160122_impl*
end;//Tl3Variant.DoSetRef

function Tl3Variant.DoQT(const IID: TGUID;
 out Obj;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *532C4D4102D8_532031160122_var*
//#UC END# *532C4D4102D8_532031160122_var*
begin
//#UC START# *532C4D4102D8_532031160122_impl*
 Result := false;
//#UC END# *532C4D4102D8_532031160122_impl*
end;//Tl3Variant.DoQT

function Tl3Variant.GetTagType: Tl3VariantDef;
//#UC START# *533121AF0203_532031160122_var*
//#UC END# *533121AF0203_532031160122_var*
begin
//#UC START# *533121AF0203_532031160122_impl*
 Result := nil;
 Assert(false, '���������� �������� ��� ��� ' + ClassName);
//#UC END# *533121AF0203_532031160122_impl*
end;//Tl3Variant.GetTagType

procedure Tl3Variant.SetAttr(anIndex: Integer;
 const aContext: Il3OpPack;
 aValue: Tl3Variant);
//#UC START# *5331961F0280_532031160122_var*
//#UC END# *5331961F0280_532031160122_var*
begin
//#UC START# *5331961F0280_532031160122_impl*
 Assert(false, '���������� ��������� ������� � ' + ClassName);
//#UC END# *5331961F0280_532031160122_impl*
end;//Tl3Variant.SetAttr

function Tl3Variant.GetAttr(anIndex: Integer;
 out theValue: Tl3Variant): Boolean;
//#UC START# *53319C270138_532031160122_var*
//#UC END# *53319C270138_532031160122_var*
begin
//#UC START# *53319C270138_532031160122_impl*
 Result := false;
 theValue := nil;
 Assert(false, '���������� �������� ������� � ' + ClassName);
//#UC END# *53319C270138_532031160122_impl*
end;//Tl3Variant.GetAttr

procedure Tl3Variant.SetBoolAttr(anIndex: Integer;
 const aContext: Il3OpPack;
 aValue: Boolean);
//#UC START# *5331B00B02DD_532031160122_var*
//#UC END# *5331B00B02DD_532031160122_var*
begin
//#UC START# *5331B00B02DD_532031160122_impl*
 Assert(false, '���������� ��������� ������� � ' + ClassName);
//#UC END# *5331B00B02DD_532031160122_impl*
end;//Tl3Variant.SetBoolAttr

procedure Tl3Variant.SetIntAttr(anIndex: Integer;
 const aContext: Il3OpPack;
 aValue: Integer);
//#UC START# *5332CD8801A6_532031160122_var*
//#UC END# *5332CD8801A6_532031160122_var*
begin
//#UC START# *5332CD8801A6_532031160122_impl*
 Assert(false, '���������� ��������� ������� � ' + ClassName);
//#UC END# *5332CD8801A6_532031160122_impl*
end;//Tl3Variant.SetIntAttr

procedure Tl3Variant.SetWStrAttr(anIndex: Integer;
 const aContext: Il3OpPack;
 const aValue: Tl3WString);
//#UC START# *5332FB8403B6_532031160122_var*
//#UC END# *5332FB8403B6_532031160122_var*
begin
//#UC START# *5332FB8403B6_532031160122_impl*
 Assert(false, '���������� ��������� ������� � ' + ClassName);
//#UC END# *5332FB8403B6_532031160122_impl*
end;//Tl3Variant.SetWStrAttr

procedure Tl3Variant.DoDoLoad;
//#UC START# *4CEFA0BA0233_532031160122_var*
//#UC END# *4CEFA0BA0233_532031160122_var*
begin
//#UC START# *4CEFA0BA0233_532031160122_impl*
 Assert(false, '�� ������������ ����� DoDoLoad � ' + ClassName);
//#UC END# *4CEFA0BA0233_532031160122_impl*
end;//Tl3Variant.DoDoLoad

procedure Tl3Variant.DoForceStore;
//#UC START# *5321B9DF011A_532031160122_var*
//#UC END# *5321B9DF011A_532031160122_var*
begin
//#UC START# *5321B9DF011A_532031160122_impl*
 Assert(false, '�� ������������ ����� DoForceStore � ' + ClassName);
//#UC END# *5321B9DF011A_532031160122_impl*
end;//Tl3Variant.DoForceStore

function Tl3Variant.DoIterateChildrenBack(Action: Mk2Children_IterateChildrenBack_Action;
 aHi: Tl3Index;
 aLo: Tl3Index;
 aLoadedOnly: Boolean): Integer;
//#UC START# *5081632303E6_532031160122_var*
//#UC END# *5081632303E6_532031160122_var*
begin
//#UC START# *5081632303E6_532031160122_impl*
 Result := -1;
 Assert(false, '�� ������������ ����� DoIterateChildrenBack � ' + ClassName);
//#UC END# *5081632303E6_532031160122_impl*
end;//Tl3Variant.DoIterateChildrenBack

function Tl3Variant.DoAddChild(aChild: Tl3Variant;
 const aContext: Il3OpPack): Integer;
//#UC START# *533D587B0359_532031160122_var*
//#UC END# *533D587B0359_532031160122_var*
begin
//#UC START# *533D587B0359_532031160122_impl*
 Result := -1;
 Assert(false, '�� ������������ ����� DoAddChild � ' + ClassName);
//#UC END# *533D587B0359_532031160122_impl*
end;//Tl3Variant.DoAddChild

function Tl3Variant.CheckAttr(const aPath: array of Integer;
 const aContext: Il3OpPack;
 DoCheck: Boolean;
 theIndex: PLongint): Tl3Variant;
//#UC START# *533D6FD80051_532031160122_var*
//#UC END# *533D6FD80051_532031160122_var*
begin
//#UC START# *533D6FD80051_532031160122_impl*
 Result := nil;
 Assert(false, '�� ������������ ����� CheckAttr � ' + ClassName);
//#UC END# *533D6FD80051_532031160122_impl*
end;//Tl3Variant.CheckAttr

function Tl3Variant.DoCAtom(anIndex: Integer;
 const aContext: Il3OpPack;
 anAtomType: Tl3VariantDef): Tl3Variant;
//#UC START# *533D791300DA_532031160122_var*
//#UC END# *533D791300DA_532031160122_var*
begin
//#UC START# *533D791300DA_532031160122_impl*
 Result := nil;
 Assert(false, '�� ������������ ����� DoCAtom � ' + ClassName);
//#UC END# *533D791300DA_532031160122_impl*
end;//Tl3Variant.DoCAtom

function Tl3Variant.GetAsBox: Tl3Variant;
//#UC START# *532FFF230250_532031160122_var*
//#UC END# *532FFF230250_532031160122_var*
begin
//#UC START# *532FFF230250_532031160122_impl*
 Result := Self;
//#UC END# *532FFF230250_532031160122_impl*
end;//Tl3Variant.GetAsBox

function Tl3Variant.GetAsRef: Il3TagRef;
//#UC START# *53568FCA01E8_532031160122_var*
//#UC END# *53568FCA01E8_532031160122_var*
begin
//#UC START# *53568FCA01E8_532031160122_impl*
 //Result := AsTag;
 Result := Tl3TagRef.Make(Self);
//#UC END# *53568FCA01E8_532031160122_impl*
end;//Tl3Variant.GetAsRef

function Tl3Variant.GetInt64A(anIndex: Integer): Int64;
//#UC START# *5360CE4B026A_532031160122_var*
//#UC END# *5360CE4B026A_532031160122_var*
begin
//#UC START# *5360CE4B026A_532031160122_impl*
 Result := 0;
 Assert(false, '�� ������������ ����� GetInt64A � ' + ClassName);
//#UC END# *5360CE4B026A_532031160122_impl*
end;//Tl3Variant.GetInt64A

procedure Tl3Variant.SetInt64A(anIndex: Integer;
 const aContext: Il3OpPack;
 aValue: Int64);
//#UC START# *5360CE910025_532031160122_var*
//#UC END# *5360CE910025_532031160122_var*
begin
//#UC START# *5360CE910025_532031160122_impl*
 Assert(false, '�� ������������ ����� SetInt64A � ' + ClassName);
//#UC END# *5360CE910025_532031160122_impl*
end;//Tl3Variant.SetInt64A

function Tl3Variant.DoMarkModified: Boolean;
//#UC START# *4C6D1C29031F_532031160122_var*
//#UC END# *4C6D1C29031F_532031160122_var*
begin
//#UC START# *4C6D1C29031F_532031160122_impl*
 Assert(false, 'DoMarkModified ������ ���� �������� � ' + ClassName);
 Result := false;
//#UC END# *4C6D1C29031F_532031160122_impl*
end;//Tl3Variant.DoMarkModified

procedure Tl3Variant.DoIterateProperties(Action: Ml3TagHolder_IterateProperties_Action;
 All: Boolean);
//#UC START# *49A545D501F6_532031160122_var*
//#UC END# *49A545D501F6_532031160122_var*
begin
//#UC START# *49A545D501F6_532031160122_impl*
 // - ������ �� ������
//#UC END# *49A545D501F6_532031160122_impl*
end;//Tl3Variant.DoIterateProperties

function Tl3Variant.DeleteChildPrim(anIndex: Integer;
 aChild: Tl3Variant;
 const aContext: Il3OpPack): Boolean;
//#UC START# *4C6CE735026E_532031160122_var*
//#UC END# *4C6CE735026E_532031160122_var*
begin
//#UC START# *4C6CE735026E_532031160122_impl*
 Result := false;
 Assert(false, 'DeleteChildPrim ������ ���� �������� � ' + ClassName);
//#UC END# *4C6CE735026E_532031160122_impl*
end;//Tl3Variant.DeleteChildPrim

function Tl3Variant.DoIterateChildrenF(Action: Mk2Children_IterateChildrenF_Action;
 aLo: Tl3Index;
 aHi: Tl3Index;
 aLoadedOnly: Boolean): Integer;
//#UC START# *48CF96D80241_532031160122_var*
//#UC END# *48CF96D80241_532031160122_var*
begin
//#UC START# *48CF96D80241_532031160122_impl*
 Result := -1;
 Assert(false, 'DoIterateChildrenF ������ ���� �������� � ' + ClassName);
//#UC END# *48CF96D80241_532031160122_impl*
end;//Tl3Variant.DoIterateChildrenF

procedure Tl3Variant.CheckSort(aProp: Tl3VariantDef);
//#UC START# *47612CD10380_532031160122_var*
//#UC END# *47612CD10380_532031160122_var*
begin
//#UC START# *47612CD10380_532031160122_impl*
 Assert(false, 'CheckSort ������ ���� �������� � ' + ClassName);
//#UC END# *47612CD10380_532031160122_impl*
end;//Tl3Variant.CheckSort

function Tl3Variant.FindChild(anAtom: Integer;
 aValue: Integer;
 const aContext: Il3OpPack;
 aNeedCreate: Boolean;
 theIndex: PLongint): Tl3Variant;
//#UC START# *4A42374B0371_532031160122_var*
//#UC END# *4A42374B0371_532031160122_var*
begin
//#UC START# *4A42374B0371_532031160122_impl*
 Result := nil;
 Assert(false, 'FindChild ������ ���� �������� � ' + ClassName);
//#UC END# *4A42374B0371_532031160122_impl*
end;//Tl3Variant.FindChild

function Tl3Variant.CloneTag: Il3TagRef;
//#UC START# *47612DF00301_532031160122_var*
//#UC END# *47612DF00301_532031160122_var*
begin
//#UC START# *47612DF00301_532031160122_impl*
 Result := nil;
 Assert(false, 'CloneTag ������ ���� �������� � ' + ClassName);
//#UC END# *47612DF00301_532031160122_impl*
end;//Tl3Variant.CloneTag

procedure Tl3Variant.WriteTag(const G: Ik2TagGenerator;
 Flags: Tk2StorePropertyFlags = k2BaseTypes.l3_spfAll;
 Exclude: TByteSet = []);
 {* �������� ��� � ���������. }
//#UC START# *4761324203B8_532031160122_var*
//#UC END# *4761324203B8_532031160122_var*
begin
//#UC START# *4761324203B8_532031160122_impl*
 Assert(false, 'Write ������ ���� �������� � ' + ClassName);
//#UC END# *4761324203B8_532031160122_impl*
end;//Tl3Variant.WriteTag

function Tl3Variant.AssignTag(Source: Tl3Variant;
 AssignMode: Tk2AssignModes = k2BaseTypes.k2_amAll;
 const Context: Il3OpPack = nil): Boolean;
//#UC START# *47612DD0012B_532031160122_var*
//#UC END# *47612DD0012B_532031160122_var*
begin
//#UC START# *47612DD0012B_532031160122_impl*
 Result := false;
 Assert(false, 'AssignTag ������ ���� �������� � ' + ClassName);
//#UC END# *47612DD0012B_532031160122_impl*
end;//Tl3Variant.AssignTag

procedure Tl3Variant.AssignCloneParams(aSource: Tl3Variant;
 AssignMode: Tk2AssignModes = k2BaseTypes.k2_amAll;
 const Context: Il3OpPack = nil);
//#UC START# *47612E530082_532031160122_var*
//#UC END# *47612E530082_532031160122_var*
begin
//#UC START# *47612E530082_532031160122_impl*
 Assert(false, 'AssignCloneParams ������ ���� �������� � ' + ClassName);
//#UC END# *47612E530082_532031160122_impl*
end;//Tl3Variant.AssignCloneParams

procedure Tl3Variant.DeleteChildren(const Context: Il3OpPack = nil);
 {* ������� ���� �����. }
//#UC START# *4A42378D0030_532031160122_var*
//#UC END# *4A42378D0030_532031160122_var*
begin
//#UC START# *4A42378D0030_532031160122_impl*
 Assert(false, 'DeleteChildren ������ ���� �������� � ' + ClassName);
//#UC END# *4A42378D0030_532031160122_impl*
end;//Tl3Variant.DeleteChildren

procedure Tl3Variant.InsertChildTag(anIndex: Integer;
 aChild: Tl3Variant;
 const aContext: Il3OpPack = nil);
 {* �������� �������. }
//#UC START# *4A42358A00C2_532031160122_var*
//#UC END# *4A42358A00C2_532031160122_var*
begin
//#UC START# *4A42358A00C2_532031160122_impl*
 Assert(false, 'InsertChildTag ������ ���� �������� � ' + ClassName);
//#UC END# *4A42358A00C2_532031160122_impl*
end;//Tl3Variant.InsertChildTag

function Tl3Variant.IndexOfChild(aChild: Tl3Variant): Integer;
//#UC START# *4A4235B70288_532031160122_var*
//#UC END# *4A4235B70288_532031160122_var*
begin
//#UC START# *4A4235B70288_532031160122_impl*
 Result := -1;
 Assert(false, 'IndexOfChild ������ ���� �������� � ' + ClassName);
//#UC END# *4A4235B70288_532031160122_impl*
end;//Tl3Variant.IndexOfChild

function Tl3Variant.rOwnAtom(anIndex: Integer): Tl3Variant;
//#UC START# *4BC843C40240_532031160122_var*
//#UC END# *4BC843C40240_532031160122_var*
begin
//#UC START# *4BC843C40240_532031160122_impl*
 Result := nil;
 Assert(false, 'ROwnAtom ������ ���� �������� � ' + ClassName);
//#UC END# *4BC843C40240_532031160122_impl*
end;//Tl3Variant.rOwnAtom

function Tl3Variant.GetLinkedInterface(const IID: TGUID;
 out Obj): Boolean;
//#UC START# *4BC84CF702F5_532031160122_var*
//#UC END# *4BC84CF702F5_532031160122_var*
begin
//#UC START# *4BC84CF702F5_532031160122_impl*
 Result := GetInterface(IID, Obj);
//#UC END# *4BC84CF702F5_532031160122_impl*
end;//Tl3Variant.GetLinkedInterface

function Tl3Variant.CompareWithInt(aValue: Integer;
 anIndex: Integer): Integer;
 {* ���������� ��� � �����. }
//#UC START# *4BC8415802B6_532031160122_var*
//#UC END# *4BC8415802B6_532031160122_var*
begin
//#UC START# *4BC8415802B6_532031160122_impl*
 Result := -1;
 Assert(false, 'CompareWithInt ������ ���� �������� � ' + ClassName);
//#UC END# *4BC8415802B6_532031160122_impl*
end;//Tl3Variant.CompareWithInt

function Tl3Variant.CompareWithTag(aTag: Tl3Variant;
 aSortIndex: Tl3SortIndex): Integer;
//#UC START# *4BC8415E021A_532031160122_var*
//#UC END# *4BC8415E021A_532031160122_var*
begin
//#UC START# *4BC8415E021A_532031160122_impl*
 Result := -1;
 Assert(false, 'CompareWithTag ������ ���� �������� � ' + ClassName);
//#UC END# *4BC8415E021A_532031160122_impl*
end;//Tl3Variant.CompareWithTag

function Tl3Variant.Box: Tl3Variant;
 {* ������ �� ��� - ��� ����������. }
//#UC START# *47612ACF0081_532031160122_var*
//#UC END# *47612ACF0081_532031160122_var*
begin
//#UC START# *47612ACF0081_532031160122_impl*
 if (Self = nil) then
  Result := nil
 else
  Result := GetAsBox;  
//#UC END# *47612ACF0081_532031160122_impl*
end;//Tl3Variant.Box

function Tl3Variant.pm_GetAttr(anIndex: Integer): Tl3Variant;
//#UC START# *476133660285_532031160122get_var*
//#UC END# *476133660285_532031160122get_var*
begin
//#UC START# *476133660285_532031160122get_impl*
 if (Self = nil) then
  Result := nil
 else 
 if not GetAttr(anIndex, Result) then
  Result := nil;
//#UC END# *476133660285_532031160122get_impl*
end;//Tl3Variant.pm_GetAttr

function Tl3Variant.pm_GetBoolA(anIndex: Integer): Boolean;
//#UC START# *4761365402FF_532031160122get_var*
var
 l_Value : Tl3Variant;
//#UC END# *4761365402FF_532031160122get_var*
begin
//#UC START# *4761365402FF_532031160122get_impl*
 if GetAttr(anIndex, l_Value) AND not l_Value.IsNull then
  Result := l_Value.AsBool
 else
  Result := false;
//#UC END# *4761365402FF_532031160122get_impl*
end;//Tl3Variant.pm_GetBoolA

procedure Tl3Variant.pm_SetBoolA(anIndex: Integer;
 aValue: Boolean);
//#UC START# *4761365402FF_532031160122set_var*
//#UC END# *4761365402FF_532031160122set_var*
begin
//#UC START# *4761365402FF_532031160122set_impl*
 BoolW[anIndex, nil] := aValue;
//#UC END# *4761365402FF_532031160122set_impl*
end;//Tl3Variant.pm_SetBoolA

function Tl3Variant.pm_GetIntA(anIndex: Integer): Integer;
//#UC START# *4761368701AB_532031160122get_var*
var
 l_Value : Tl3Variant;
//#UC END# *4761368701AB_532031160122get_var*
begin
//#UC START# *4761368701AB_532031160122get_impl*
 if GetAttr(anIndex, l_Value) AND not l_Value.IsNull then
  Result := l_Value.AsLong
 else
  Result := 0;
//#UC END# *4761368701AB_532031160122get_impl*
end;//Tl3Variant.pm_GetIntA

procedure Tl3Variant.pm_SetIntA(anIndex: Integer;
 aValue: Integer);
//#UC START# *4761368701AB_532031160122set_var*
//#UC END# *4761368701AB_532031160122set_var*
begin
//#UC START# *4761368701AB_532031160122set_impl*
 IntW[anIndex, nil] := aValue;
//#UC END# *4761368701AB_532031160122set_impl*
end;//Tl3Variant.pm_SetIntA

function Tl3Variant.pm_GetStrA(anIndex: Integer): AnsiString;
//#UC START# *4761370F0048_532031160122get_var*
var
 l_Value : Tl3Variant;
//#UC END# *4761370F0048_532031160122get_var*
begin
//#UC START# *4761370F0048_532031160122get_impl*
 if GetAttr(anIndex, l_Value) then
  Result := l_Value.AsString
 else
  Result := '';
//#UC END# *4761370F0048_532031160122get_impl*
end;//Tl3Variant.pm_GetStrA

procedure Tl3Variant.pm_SetStrA(anIndex: Integer;
 const aValue: AnsiString);
//#UC START# *4761370F0048_532031160122set_var*
//#UC END# *4761370F0048_532031160122set_var*
begin
//#UC START# *4761370F0048_532031160122set_impl*
 StrW[anIndex, nil] := aValue;
//#UC END# *4761370F0048_532031160122set_impl*
end;//Tl3Variant.pm_SetStrA

function Tl3Variant.pm_GetChild(anIndex: Integer): Tl3Variant;
//#UC START# *47613B8303CC_532031160122get_var*
//#UC END# *47613B8303CC_532031160122get_var*
begin
//#UC START# *47613B8303CC_532031160122get_impl*
 if (Self = nil) then
  Result := nil
 else
  Result := pm_GetChildPrim(anIndex);
//#UC END# *47613B8303CC_532031160122get_impl*
end;//Tl3Variant.pm_GetChild

procedure Tl3Variant.pm_SetBoolW(anIndex: Integer;
 const aContext: Il3OpPack;
 aValue: Boolean);
//#UC START# *47613C0F02F4_532031160122set_var*
//#UC END# *47613C0F02F4_532031160122set_var*
begin
//#UC START# *47613C0F02F4_532031160122set_impl*
 SetBoolAttr(anIndex, aContext, aValue);
//#UC END# *47613C0F02F4_532031160122set_impl*
end;//Tl3Variant.pm_SetBoolW

procedure Tl3Variant.pm_SetIntW(anIndex: Integer;
 const aContext: Il3OpPack;
 aValue: Integer);
//#UC START# *47613C6A001F_532031160122set_var*
//#UC END# *47613C6A001F_532031160122set_var*
begin
//#UC START# *47613C6A001F_532031160122set_impl*
 SetIntAttr(anIndex, aContext, aValue);
//#UC END# *47613C6A001F_532031160122set_impl*
end;//Tl3Variant.pm_SetIntW

procedure Tl3Variant.pm_SetStrW(anIndex: Integer;
 const aContext: Il3OpPack;
 const aValue: AnsiString);
//#UC START# *47613D4E02B3_532031160122set_var*
//#UC END# *47613D4E02B3_532031160122set_var*
begin
//#UC START# *47613D4E02B3_532031160122set_impl*
 if (aValue = '') then
  pm_SetAttrW(anIndex, aContext, nil)
 else
  PCharLenW[anIndex, aContext] := l3PCharLen(aValue);
//#UC END# *47613D4E02B3_532031160122set_impl*
end;//Tl3Variant.pm_SetStrW

function Tl3Variant.pm_GetPCharLenA(anIndex: Integer): Tl3PCharLen;
//#UC START# *47613DB001A3_532031160122get_var*
var
 l_Value : Tl3Variant;
//#UC END# *47613DB001A3_532031160122get_var*
begin
//#UC START# *47613DB001A3_532031160122get_impl*
 if GetAttr(anIndex, l_Value) then
  Tl3WString(Result) := l_Value.AsWStr
 else
  l3AssignNil(Result);
//#UC END# *47613DB001A3_532031160122get_impl*
end;//Tl3Variant.pm_GetPCharLenA

procedure Tl3Variant.pm_SetPCharLenA(anIndex: Integer;
 const aValue: Tl3PCharLen);
//#UC START# *47613DB001A3_532031160122set_var*
//#UC END# *47613DB001A3_532031160122set_var*
begin
//#UC START# *47613DB001A3_532031160122set_impl*
 PCharLenW[anIndex, nil] := aValue;
//#UC END# *47613DB001A3_532031160122set_impl*
end;//Tl3Variant.pm_SetPCharLenA

procedure Tl3Variant.pm_SetPCharLenW(anIndex: Integer;
 const aContext: Il3OpPack;
 const aValue: Tl3WString);
//#UC START# *47613E120125_532031160122set_var*
//#UC END# *47613E120125_532031160122set_var*
begin
//#UC START# *47613E120125_532031160122set_impl*
 SetWStrAttr(anIndex, aContext, aValue);
//#UC END# *47613E120125_532031160122set_impl*
end;//Tl3Variant.pm_SetPCharLenW

function Tl3Variant.pm_GetAsString: AnsiString;
//#UC START# *4A42149A01FE_532031160122get_var*
//#UC END# *4A42149A01FE_532031160122get_var*
begin
//#UC START# *4A42149A01FE_532031160122get_impl*
 if (Self = nil) then
  Result := ''
 else
  Result := GetAsString;
//#UC END# *4A42149A01FE_532031160122get_impl*
end;//Tl3Variant.pm_GetAsString

function Tl3Variant.pm_GetAsWStr: Tl3WString;
//#UC START# *4A4216790331_532031160122get_var*
//#UC END# *4A4216790331_532031160122get_var*
begin
//#UC START# *4A4216790331_532031160122get_impl*
 if (Self = nil) then
  l3AssignNil(Result)
 else
  Result := GetAsPCharLen;
//#UC END# *4A4216790331_532031160122get_impl*
end;//Tl3Variant.pm_GetAsWStr

function Tl3Variant.AsBool: Boolean;
 {* ������������� � Boolean. }
//#UC START# *4A42195A0244_532031160122_var*
//#UC END# *4A42195A0244_532031160122_var*
begin
//#UC START# *4A42195A0244_532031160122_impl*
 Result := (AsLong <> 0);
//#UC END# *4A42195A0244_532031160122_impl*
end;//Tl3Variant.AsBool

function Tl3Variant.AsLong: Integer;
//#UC START# *4A42196201B8_532031160122_var*
//#UC END# *4A42196201B8_532031160122_var*
begin
//#UC START# *4A42196201B8_532031160122_impl*
 if (Self = nil) then
 begin
  // - ������� ��� http://mdp.garant.ru/pages/viewpage.action?pageId=560734656&focusedCommentId=560996809#comment-560996809
  Result := 0;
  l3System.Msg2Log('������� ��� http://mdp.garant.ru/pages/viewpage.action?pageId=560734656&focusedCommentId=560996809#comment-560996809');
 end
 else 
  Result := GetAsLong;
//#UC END# *4A42196201B8_532031160122_impl*
end;//Tl3Variant.AsLong

function Tl3Variant.AsObject: Tl3Variant;
//#UC START# *4A42196C01CE_532031160122_var*
//#UC END# *4A42196C01CE_532031160122_var*
begin
//#UC START# *4A42196C01CE_532031160122_impl*
 if (Self = nil) then
  Result := nil
 else
  Result := Self; 
//#UC END# *4A42196C01CE_532031160122_impl*
end;//Tl3Variant.AsObject

function Tl3Variant.AddChild(aChild: Tl3Variant;
 const aContext: Il3OpPack = nil): Integer;
 {* �������� �������. }
//#UC START# *4A422C1D00FE_532031160122_var*
//#UC END# *4A422C1D00FE_532031160122_var*
begin
//#UC START# *4A422C1D00FE_532031160122_impl*
 Result := DoAddChild(aChild, aContext);
//#UC END# *4A422C1D00FE_532031160122_impl*
end;//Tl3Variant.AddChild

function Tl3Variant.Get_ChildrenCount: Integer;
//#UC START# *4A42356B0022_532031160122get_var*
//#UC END# *4A42356B0022_532031160122get_var*
begin
//#UC START# *4A42356B0022_532031160122get_impl*
 if (Self = nil) then
  Result := 0
 else
  Result := pm_GetChildrenCount;
//#UC END# *4A42356B0022_532031160122get_impl*
end;//Tl3Variant.Get_ChildrenCount

procedure Tl3Variant.SetRef(var aRef: Tl3Variant);
//#UC START# *4A423C670156_532031160122_var*
//#UC END# *4A423C670156_532031160122_var*
begin
//#UC START# *4A423C670156_532031160122_impl*
 if (Self = nil) then
  Self.SetRefTo(aRef)
 else
  Self.DoSetRef(aRef);
//#UC END# *4A423C670156_532031160122_impl*
end;//Tl3Variant.SetRef

function Tl3Variant.DeleteChild(anIndex: Integer;
 const anOp: Il3OpPack;
 out theChild: Il3TagRef): Boolean;
 {* ������� �������. }
//#UC START# *4A423EC900C2_532031160122_var*
//#UC END# *4A423EC900C2_532031160122_var*
begin
//#UC START# *4A423EC900C2_532031160122_impl*
 theChild := Child[anIndex].AsRef;
 if (anOp <> nil) AND not anOp.InUndo AND not anOp.InIOProcess then
  anOp.Processor.CheckDelete(Self, theChild.AsObject, anIndex);
 Result := DeleteChildPrim(anIndex, theChild.AsObject, anOp);
//#UC END# *4A423EC900C2_532031160122_impl*
end;//Tl3Variant.DeleteChild

function Tl3Variant.DeleteChild(aChild: Tl3Variant;
 const Context: Il3OpPack = nil): Boolean;
 {* ������� �������. }
//#UC START# *4A423ECE03A6_532031160122_var*
var
 l_Index : Integer;
//#UC END# *4A423ECE03A6_532031160122_var*
begin
//#UC START# *4A423ECE03A6_532031160122_impl*
 l_Index := IndexOfChild(aChild);
 if (l_Index >= 0) then
  Result := DeleteChild(l_Index, Context)
 else
  Result := false; 
//#UC END# *4A423ECE03A6_532031160122_impl*
end;//Tl3Variant.DeleteChild

function Tl3Variant.DeleteChild(anIndex: Integer;
 const anOp: Il3OpPack = nil): Boolean;
//#UC START# *4A423F0002E2_532031160122_var*
var
 l_Child : Il3TagRef;
//#UC END# *4A423F0002E2_532031160122_var*
begin
//#UC START# *4A423F0002E2_532031160122_impl*
 l_Child := nil;
 Result := DeleteChild(anIndex, anOp, l_Child);
 l_Child := nil;
//#UC END# *4A423F0002E2_532031160122_impl*
end;//Tl3Variant.DeleteChild

procedure Tl3Variant.DoLoad;
//#UC START# *4A42489800D0_532031160122_var*
//#UC END# *4A42489800D0_532031160122_var*
begin
//#UC START# *4A42489800D0_532031160122_impl*
 if (Self <> nil) then
  DoDoLoad;
//#UC END# *4A42489800D0_532031160122_impl*
end;//Tl3Variant.DoLoad

procedure Tl3Variant.ForceStore;
//#UC START# *4A4248A501C8_532031160122_var*
//#UC END# *4A4248A501C8_532031160122_var*
begin
//#UC START# *4A4248A501C8_532031160122_impl*
 if (Self <> nil) then
  DoForceStore;
//#UC END# *4A4248A501C8_532031160122_impl*
end;//Tl3Variant.ForceStore

function Tl3Variant.MarkModified: Boolean;
//#UC START# *4A4248C902F1_532031160122_var*
//#UC END# *4A4248C902F1_532031160122_var*
begin
//#UC START# *4A4248C902F1_532031160122_impl*
 if (Self = nil) then
  Result := false
 else
  Result := DoMarkModified; 
//#UC END# *4A4248C902F1_532031160122_impl*
end;//Tl3Variant.MarkModified

procedure Tl3Variant.Set_ChildrenCapacity(aValue: Integer);
//#UC START# *4A6039AA0172_532031160122set_var*
//#UC END# *4A6039AA0172_532031160122set_var*
begin
//#UC START# *4A6039AA0172_532031160122set_impl*
 if (Self <> nil) then
  pm_SetChildrenCapacity(aValue);
//#UC END# *4A6039AA0172_532031160122set_impl*
end;//Tl3Variant.Set_ChildrenCapacity

function Tl3Variant.Get_Owner: Tl3Variant;
//#UC START# *4A6475C4026D_532031160122get_var*
//#UC END# *4A6475C4026D_532031160122get_var*
begin
//#UC START# *4A6475C4026D_532031160122get_impl*
 if (Self = nil) then
  Result := nil
 else
  Result := TagOwner;
//#UC END# *4A6475C4026D_532031160122get_impl*
end;//Tl3Variant.Get_Owner

procedure Tl3Variant.Set_Owner(aValue: Tl3Variant);
//#UC START# *4A6475C4026D_532031160122set_var*
//#UC END# *4A6475C4026D_532031160122set_var*
begin
//#UC START# *4A6475C4026D_532031160122set_impl*
 if (Self <> nil) then
  TagOwner := aValue;
//#UC END# *4A6475C4026D_532031160122set_impl*
end;//Tl3Variant.Set_Owner

function Tl3Variant.IterateChildrenF(anAction: Mk2Children_IterateChildrenF_Action;
 aLo: Tl3Index = l3Interfaces.l3MinIndex;
 aHi: Tl3Index = l3Interfaces.l3MaxIndex;
 aLoadedOnly: Boolean = False): Integer;
//#UC START# *4BB21F9D022F_532031160122_var*
//#UC END# *4BB21F9D022F_532031160122_var*
begin
//#UC START# *4BB21F9D022F_532031160122_impl*
 Result := DoIterateChildrenF(anAction, aLo, aHi, aLoadedOnly);
//#UC END# *4BB21F9D022F_532031160122_impl*
end;//Tl3Variant.IterateChildrenF

function Tl3Variant.IterateChildrenBack(anAction: Mk2Children_IterateChildrenBack_Action;
 aHi: Tl3Index = l3Interfaces.l3MaxIndex;
 aLo: Tl3Index = l3Interfaces.l3MinIndex;
 aLoadedOnly: Boolean = False): Integer;
//#UC START# *4BBF49EB0260_532031160122_var*
//#UC END# *4BBF49EB0260_532031160122_var*
begin
//#UC START# *4BBF49EB0260_532031160122_impl*
 Result := DoIterateChildrenBack(anAction, aHi, aLo, aLoadedOnly);
//#UC END# *4BBF49EB0260_532031160122_impl*
end;//Tl3Variant.IterateChildrenBack

function Tl3Variant.IterateChildrenBackF(anAction: Mk2Children_IterateChildrenBack_Action;
 aHi: Tl3Index = l3Interfaces.l3MaxIndex;
 aLo: Tl3Index = l3Interfaces.l3MinIndex;
 aLoadedOnly: Boolean = False): Integer;
var
 Hack : Pointer absolute anAction;
begin
 try
  Result := IterateChildrenBack(anAction, aHi, aLo, aLoadedOnly);
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
end;//Tl3Variant.IterateChildrenBackF

procedure Tl3Variant.IterateProperties(anAction: Ml3TagHolder_IterateProperties_Action;
 anAll: Boolean
 {* ���������� ��� ��������� �������� ��� ������ ������� �������� });
 {* ���������� ��� ������������ �������� }
//#UC START# *4BC31A730293_532031160122_var*
//#UC END# *4BC31A730293_532031160122_var*
begin
//#UC START# *4BC31A730293_532031160122_impl*
 DoIterateProperties(anAction, anAll);
//#UC END# *4BC31A730293_532031160122_impl*
end;//Tl3Variant.IterateProperties

procedure Tl3Variant.IteratePropertiesF(anAction: Ml3TagHolder_IterateProperties_Action;
 anAll: Boolean
 {* ���������� ��� ��������� �������� ��� ������ ������� �������� });
 {* ���������� ��� ������������ �������� }
var
 Hack : Pointer absolute anAction;
begin
 try
  IterateProperties(anAction, anAll);
 finally
  l3FreeLocalStub(Hack);
 end;//try..finally
end;//Tl3Variant.IteratePropertiesF

function Tl3Variant.rLong(anIndex: Integer;
 aDefault: Integer): Integer;
//#UC START# *4BC71B0A028C_532031160122_var*
var
 l_Value : Tl3Variant;
//#UC END# *4BC71B0A028C_532031160122_var*
begin
//#UC START# *4BC71B0A028C_532031160122_impl*
 if GetAttr(anIndex, l_Value) AND not l_Value.IsNull then
  Result := l_Value.AsLong
 else
  Result := aDefault;
//#UC END# *4BC71B0A028C_532031160122_impl*
end;//Tl3Variant.rLong

function Tl3Variant.rAtomEx(const Path: TOpenLongArray;
 theIndex: PLongint = nil): Tl3Variant;
 {* ������� ������. }
//#UC START# *4BC843A5011F_532031160122_var*
//#UC END# *4BC843A5011F_532031160122_var*
begin
//#UC START# *4BC843A5011F_532031160122_impl*
 Result := CheckAttr(Path, nil, false, theIndex);
//#UC END# *4BC843A5011F_532031160122_impl*
end;//Tl3Variant.rAtomEx

function Tl3Variant.cAtom(anIndex: Integer;
 const aContext: Il3OpPack = nil;
 anAtomType: Tl3VariantDef = nil): Tl3Variant;
 {* ��������� ������������� ������� � ������� ��� ��� �������������. }
//#UC START# *4BC843C80301_532031160122_var*
//#UC END# *4BC843C80301_532031160122_var*
begin
//#UC START# *4BC843C80301_532031160122_impl*
 Result := DoCAtom(anIndex, aContext, anAtomType);
 Assert(Result.TagType <> nil);
//#UC END# *4BC843C80301_532031160122_impl*
end;//Tl3Variant.cAtom

function Tl3Variant.cAtomEx(const aPath: TOpenLongArray;
 const aContext: Il3OpPack;
 theIndex: PLongint = nil): Tl3Variant;
 {* ��������� ������������� ������� � ������� ��� ��� �������������. }
//#UC START# *4BC843CE00EF_532031160122_var*
//#UC END# *4BC843CE00EF_532031160122_var*
begin
//#UC START# *4BC843CE00EF_532031160122_impl*
 Result := CheckAttr(aPath, aContext, true, theIndex);
//#UC END# *4BC843CE00EF_532031160122_impl*
end;//Tl3Variant.cAtomEx

function Tl3Variant.HasSubAtom(anIndex: Integer): Boolean;
//#UC START# *4BC8441500B7_532031160122_var*
//#UC END# *4BC8441500B7_532031160122_var*
begin
//#UC START# *4BC8441500B7_532031160122_impl*
 if (Self = nil) then
  Result := false
 else
  Result := DoGetHasSubAtom(anIndex); 
//#UC END# *4BC8441500B7_532031160122_impl*
end;//Tl3Variant.HasSubAtom

function Tl3Variant.IsNull: Boolean;
 {* ������ ���? }
//#UC START# *4BC8446D010E_532031160122_var*
//#UC END# *4BC8446D010E_532031160122_var*
begin
//#UC START# *4BC8446D010E_532031160122_impl*
 if (Self = nil) then
  Result := true
 else
  Result := GetIsNull;
//#UC END# *4BC8446D010E_532031160122_impl*
end;//Tl3Variant.IsNull

function Tl3Variant.IsValid: Boolean;
 {* ��� ����� ��������? }
//#UC START# *4BC8447200B0_532031160122_var*
//#UC END# *4BC8447200B0_532031160122_var*
begin
//#UC START# *4BC8447200B0_532031160122_impl*
 Result := not IsNull AND not IsTransparent;
//#UC END# *4BC8447200B0_532031160122_impl*
end;//Tl3Variant.IsValid

function Tl3Variant.IsTransparent: Boolean;
 {* ��� "����������"? }
//#UC START# *4BC8447501CB_532031160122_var*
//#UC END# *4BC8447501CB_532031160122_var*
begin
//#UC START# *4BC8447501CB_532031160122_impl*
 if (Self = nil) then
  Result := false
 else
  Result := GetIsTransparent;  
//#UC END# *4BC8447501CB_532031160122_impl*
end;//Tl3Variant.IsTransparent

function Tl3Variant.IsStream(out theStream: IStream): Boolean;
 {* ��������� ����� �� ��� ����������� � ������. � �������� � ������ - ���� ��������� �� ����� - �� �������. }
//#UC START# *4BC8447A0046_532031160122_var*
//#UC END# *4BC8447A0046_532031160122_var*
begin
//#UC START# *4BC8447A0046_532031160122_impl*
 if (Self = nil) then
  Result := false
 else
  Result := GetIsStream(theStream); 
//#UC END# *4BC8447A0046_532031160122_impl*
end;//Tl3Variant.IsStream

function Tl3Variant.QT(const IID: TGUID;
 out Obj;
 const aProcessor: Ik2Processor = nil): Boolean;
 {* ���������� ���������� ��� ������ � �����, � �������� �������� �������� ����������. }
//#UC START# *4BC84CA1035B_532031160122_var*
//#UC END# *4BC84CA1035B_532031160122_var*
begin
//#UC START# *4BC84CA1035B_532031160122_impl*
 if (Self = nil) then
  Result := false
 else
  Result := DoQT(IID, Obj, aProcessor); 
//#UC END# *4BC84CA1035B_532031160122_impl*
end;//Tl3Variant.QT

function Tl3Variant.GetOwnInterface(const IID: TGUID;
 out Obj): Boolean;
 {* ���������� ��������� ��������������� �������������� ����������� �����������. }
//#UC START# *4BC84CEE0329_532031160122_var*
//#UC END# *4BC84CEE0329_532031160122_var*
begin
//#UC START# *4BC84CEE0329_532031160122_impl*
 if (Self = nil) then
  Result := false
 else
  Result := Self.GetInterface(IID, Obj);
//#UC END# *4BC84CEE0329_532031160122_impl*
end;//Tl3Variant.GetOwnInterface

function Tl3Variant.Get_Int64A(aTagID: Integer): Int64;
//#UC START# *4E2EA8B10353_532031160122get_var*
//#UC END# *4E2EA8B10353_532031160122get_var*
begin
//#UC START# *4E2EA8B10353_532031160122get_impl*
 Result := GetInt64A(aTagID);
//#UC END# *4E2EA8B10353_532031160122get_impl*
end;//Tl3Variant.Get_Int64A

procedure Tl3Variant.Set_Int64A(aTagID: Integer;
 aValue: Int64);
//#UC START# *4E2EA8B10353_532031160122set_var*
//#UC END# *4E2EA8B10353_532031160122set_var*
begin
//#UC START# *4E2EA8B10353_532031160122set_impl*
 Set_Int64W(aTagID, nil, aValue);
//#UC END# *4E2EA8B10353_532031160122set_impl*
end;//Tl3Variant.Set_Int64A

procedure Tl3Variant.Set_Int64W(aTagID: Integer;
 const aContext: Il3OpPack;
 aValue: Int64);
//#UC START# *4E2EA93E029A_532031160122set_var*
//#UC END# *4E2EA93E029A_532031160122set_var*
begin
//#UC START# *4E2EA93E029A_532031160122set_impl*
 SetInt64A(aTagID, aContext, aValue);
//#UC END# *4E2EA93E029A_532031160122set_impl*
end;//Tl3Variant.Set_Int64W

function Tl3Variant.IsSame(anOther: Tl3Variant): Boolean;
//#UC START# *532C4B8E00CC_532031160122_var*
//#UC END# *532C4B8E00CC_532031160122_var*
begin
//#UC START# *532C4B8E00CC_532031160122_impl*
 if (Self = nil) then
  Result := (anOther = nil) OR anOther.IsNull
 else
 if (Self = anOther) then
  Result := true
 else
 begin
  if Self.IsNull then
   Result := (anOther = nil) OR anOther.IsNull
  else
  if not TagType.IsSame(anOther.TagType) then
   Result := false
  else
  begin
   if Self.IsTransparent then
    Result := anOther.IsTransparent
   else
   if TagType.IsOrd then
    Result := (Self.AsLong = anOther.AsLong)
   else
    Result := (Self.Box = anOther.Box);
  end;//not TagType.IsSame(aTag.TagType)
 end;//Self = anOther
//#UC END# *532C4B8E00CC_532031160122_impl*
end;//Tl3Variant.IsSame

procedure Tl3Variant.pm_SetAttrW(anIndex: Integer;
 const aContext: Il3OpPack;
 aValue: Tl3Variant);
//#UC START# *533195830003_532031160122set_var*
//#UC END# *533195830003_532031160122set_var*
begin
//#UC START# *533195830003_532031160122set_impl*
 SetAttr(anIndex, aContext, aValue);
//#UC END# *533195830003_532031160122set_impl*
end;//Tl3Variant.pm_SetAttrW

function Tl3Variant.pm_GetTagType: Tl3VariantDef;
//#UC START# *533413FC02FC_532031160122get_var*
//#UC END# *533413FC02FC_532031160122get_var*
begin
//#UC START# *533413FC02FC_532031160122get_impl*
 Result := Self.TagType;
//#UC END# *533413FC02FC_532031160122get_impl*
end;//Tl3Variant.pm_GetTagType

function Tl3Variant.Get_DateTimeA(aTagID: Integer): TDateTime;
//#UC START# *53B444D80378_532031160122get_var*
(*var
 l_DT : TStDateTimeRec;*)
var
 l_V : Int64;
//#UC END# *53B444D80378_532031160122get_var*
begin
//#UC START# *53B444D80378_532031160122get_impl*
 Result := 0;
 l_V := Self.Int64A[aTagID];
 l3Move(l_V, Result, SizeOf(Result));
(* Int64(l_DT) := Self.Int64A[aTagID];
 Result := StDateTimeRecToDateTime(l_DT);*)
//#UC END# *53B444D80378_532031160122get_impl*
end;//Tl3Variant.Get_DateTimeA

procedure Tl3Variant.Set_DateTimeA(aTagID: Integer;
 aValue: TDateTime);
//#UC START# *53B444D80378_532031160122set_var*
//#UC END# *53B444D80378_532031160122set_var*
begin
//#UC START# *53B444D80378_532031160122set_impl*
 Self.DateTimeW[aTagID, nil] := aValue;
//#UC END# *53B444D80378_532031160122set_impl*
end;//Tl3Variant.Set_DateTimeA

procedure Tl3Variant.Set_DateTimeW(aTagID: Integer;
 const aContext: Il3OpPack;
 aValue: TDateTime);
//#UC START# *53B52B130172_532031160122set_var*
(*var
 l_DT : TStDateTimeRec;*)
var
 l_V : Int64;
//#UC END# *53B52B130172_532031160122set_var*
begin
//#UC START# *53B52B130172_532031160122set_impl*
 l_V := 0;
 l3Move(aValue, l_V, SizeOf(aValue));
 Self.Int64W[aTagID, aContext] := l_V;
(* l_DT := DateTimeToStDateTimeRec(aValue);
 Self.Int64A[aTagID] := Int64(l_DT);*)
//#UC END# *53B52B130172_532031160122set_impl*
end;//Tl3Variant.Set_DateTimeW

function Tl3Variant.GetIsKindOfPrim(aType: Tl3VariantDef): Boolean;
//#UC START# *533129DC037C_532031160122_var*
//#UC END# *533129DC037C_532031160122_var*
begin
//#UC START# *533129DC037C_532031160122_impl*
 Result := TagType.IsKindOf(aType);
//#UC END# *533129DC037C_532031160122_impl*
end;//Tl3Variant.GetIsKindOfPrim

//#UC START# *532031160122impl*
//#UC END# *532031160122impl*

function Tl3PrimString.pm_GetAsString: AnsiString;
//#UC START# *47A869930282_47A8693601A1get_var*
//#UC END# *47A869930282_47A8693601A1get_var*
begin
//#UC START# *47A869930282_47A8693601A1get_impl*
 if (Self = nil) then
  Result := ''
 else
  Result := GetAsString;
//#UC END# *47A869930282_47A8693601A1get_impl*
end;//Tl3PrimString.pm_GetAsString

procedure Tl3PrimString.pm_SetAsString(const aValue: AnsiString);
//#UC START# *47A869930282_47A8693601A1set_var*
//#UC END# *47A869930282_47A8693601A1set_var*
begin
//#UC START# *47A869930282_47A8693601A1set_impl*
 if (Self <> nil) then
 begin
  if (aValue = '') then
   Clear
  else
   AsWStr := l3PCharLen(aValue, AsWStr.SCodePage);
 end;//Self <> nil
//#UC END# *47A869930282_47A8693601A1set_impl*
end;//Tl3PrimString.pm_SetAsString

function Tl3PrimString.pm_GetAsWStr: Tl3WString;
//#UC START# *47A869A600BF_47A8693601A1get_var*
//#UC END# *47A869A600BF_47A8693601A1get_var*
begin
//#UC START# *47A869A600BF_47A8693601A1get_impl*
 if (Self = nil) then
  l3AssignNil(Result)
 else
  Result := GetAsPCharLen;
//#UC END# *47A869A600BF_47A8693601A1get_impl*
end;//Tl3PrimString.pm_GetAsWStr

procedure Tl3PrimString.pm_SetAsWStr(const aValue: Tl3WString);
//#UC START# *47A869A600BF_47A8693601A1set_var*
//#UC END# *47A869A600BF_47A8693601A1set_var*
begin
//#UC START# *47A869A600BF_47A8693601A1set_impl*
 if (Self <> nil) then
  DoSetAsPCharLen(Tl3PCharLen(aValue));
//#UC END# *47A869A600BF_47A8693601A1set_impl*
end;//Tl3PrimString.pm_SetAsWStr

function Tl3PrimString.pm_GetStringID: Integer;
//#UC START# *47BC3BFD017F_47A8693601A1get_var*
//#UC END# *47BC3BFD017F_47A8693601A1get_var*
begin
//#UC START# *47BC3BFD017F_47A8693601A1get_impl*
 Result := 0;
//#UC END# *47BC3BFD017F_47A8693601A1get_impl*
end;//Tl3PrimString.pm_GetStringID

procedure Tl3PrimString.pm_SetStringID(aValue: Integer);
//#UC START# *47BC3BFD017F_47A8693601A1set_var*
//#UC END# *47BC3BFD017F_47A8693601A1set_var*
begin
//#UC START# *47BC3BFD017F_47A8693601A1set_impl*
//#UC END# *47BC3BFD017F_47A8693601A1set_impl*
end;//Tl3PrimString.pm_SetStringID

function Tl3PrimString.pm_GetLinkedObject: TObject;
//#UC START# *47BC3CCE00A6_47A8693601A1get_var*
//#UC END# *47BC3CCE00A6_47A8693601A1get_var*
begin
//#UC START# *47BC3CCE00A6_47A8693601A1get_impl*
 Result := nil;
//#UC END# *47BC3CCE00A6_47A8693601A1get_impl*
end;//Tl3PrimString.pm_GetLinkedObject

procedure Tl3PrimString.pm_SetLinkedObject(aValue: TObject);
//#UC START# *47BC3CCE00A6_47A8693601A1set_var*
//#UC END# *47BC3CCE00A6_47A8693601A1set_var*
begin
//#UC START# *47BC3CCE00A6_47A8693601A1set_impl*
//#UC END# *47BC3CCE00A6_47A8693601A1set_impl*
end;//Tl3PrimString.pm_SetLinkedObject

procedure Tl3PrimString.DoSetAsPCharLen(const Value: Tl3PCharLen);
//#UC START# *47A869D10074_47A8693601A1_var*
//#UC END# *47A869D10074_47A8693601A1_var*
begin
//#UC START# *47A869D10074_47A8693601A1_impl*
 Assert(false);
//#UC END# *47A869D10074_47A8693601A1_impl*
end;//Tl3PrimString.DoSetAsPCharLen

procedure Tl3PrimString.Clear;
 {* ������� ������� �������.  ��� ���������� � ��������. }
//#UC START# *47BC02A50131_47A8693601A1_var*
//#UC END# *47BC02A50131_47A8693601A1_var*
begin
//#UC START# *47BC02A50131_47A8693601A1_impl*
 // - ������ �� ������
//#UC END# *47BC02A50131_47A8693601A1_impl*
end;//Tl3PrimString.Clear

procedure Tl3PrimString.AssignString(aStr: Tl3PrimString);
 {* �������� ������ ������ ������. }
//#UC START# *47BC3C950296_47A8693601A1_var*
//#UC END# *47BC3C950296_47A8693601A1_var*
begin
//#UC START# *47BC3C950296_47A8693601A1_impl*
 StringID := aStr.StringID;
 AsWStr := aStr.AsWStr;
 LinkedObject := aStr.LinkedObject;
//#UC END# *47BC3C950296_47A8693601A1_impl*
end;//Tl3PrimString.AssignString

function Tl3PrimString.Clone: Pointer;
 {* ������� ����� ������. }
//#UC START# *47BC3FC40111_47A8693601A1_var*
type
  Rl3PrimString = class of Tl3PrimString;
//#UC END# *47BC3FC40111_47A8693601A1_var*
begin
//#UC START# *47BC3FC40111_47A8693601A1_impl*
 Result := Rl3PrimString(ClassType).Create;
 Tl3PrimString(Result).AssignString(Self);
//#UC END# *47BC3FC40111_47A8693601A1_impl*
end;//Tl3PrimString.Clone

function Tl3PrimString.GetAsPCharLen: Tl3WString;
//#UC START# *47A869BB02DE_47A8693601A1_var*
//#UC END# *47A869BB02DE_47A8693601A1_var*
begin
//#UC START# *47A869BB02DE_47A8693601A1_impl*
 l3AssignNil(Result);
//#UC END# *47A869BB02DE_47A8693601A1_impl*
end;//Tl3PrimString.GetAsPCharLen

function Tl3PrimString.GetEmpty: Boolean;
//#UC START# *4A54E03B009A_47A8693601A1_var*
//#UC END# *4A54E03B009A_47A8693601A1_var*
begin
//#UC START# *4A54E03B009A_47A8693601A1_impl*
 Result := l3IsNil(AsWStr);
//#UC END# *4A54E03B009A_47A8693601A1_impl*
end;//Tl3PrimString.GetEmpty

function Tl3PrimString.GetAsString: AnsiString;
//#UC START# *5329CD1A020E_47A8693601A1_var*
var
 l_S : Tl3WString;
//#UC END# *5329CD1A020E_47A8693601A1_var*
begin
//#UC START# *5329CD1A020E_47A8693601A1_impl*
 l_S := GetAsPCharLen;
 if (l_S.SCodePage = CP_Unicode) then
  Result := l3PCharLen2String(l_S, CP_ANSI)
 else
  Result := l3PCharLen2String(l_S, l_S.SCodePage);
//#UC END# *5329CD1A020E_47A8693601A1_impl*
end;//Tl3PrimString.GetAsString

class function Tl3NullTag.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tl3NullTag <> nil;
end;//Tl3NullTag.Exists

function Tl3NullTag.AsObject: Tl3Variant;
//#UC START# *4A42196C01CE_5347F19F0007_var*
//#UC END# *4A42196C01CE_5347F19F0007_var*
begin
//#UC START# *4A42196C01CE_5347F19F0007_impl*
 Result := nil;
//#UC END# *4A42196C01CE_5347F19F0007_impl*
end;//Tl3NullTag.AsObject

class function Tl3NullTag.Instance: Tl3NullTag;
 {* ����� ��������� ���������� ���������� Tl3NullTag }
begin
 if (g_Tl3NullTag = nil) then
 begin
  l3System.AddExitProc(Tl3NullTagFree);
  g_Tl3NullTag := Create;
 end;
 Result := g_Tl3NullTag;
end;//Tl3NullTag.Instance

constructor Tl3TagRef.Create(aTag: Tl3Tag);
//#UC START# *535FD1080328_535FD0BB03C3_var*
//#UC END# *535FD1080328_535FD0BB03C3_var*
begin
//#UC START# *535FD1080328_535FD0BB03C3_impl*
 Assert(aTag <> nil);
 inherited Create;
 aTag.SetRefTo(f_Tag);
//#UC END# *535FD1080328_535FD0BB03C3_impl*
end;//Tl3TagRef.Create

class function Tl3TagRef.Make(aTag: Tl3Tag): Il3TagRef;
var
 l_Inst : Tl3TagRef;
begin
 l_Inst := Create(aTag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tl3TagRef.Make

function Tl3TagRef.AsObject: Tl3Variant;
//#UC START# *4A42196C01CE_535FD0BB03C3_var*
//#UC END# *4A42196C01CE_535FD0BB03C3_var*
begin
//#UC START# *4A42196C01CE_535FD0BB03C3_impl*
 Result := f_Tag;
//#UC END# *4A42196C01CE_535FD0BB03C3_impl*
end;//Tl3TagRef.AsObject

procedure Tl3TagRef.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_535FD0BB03C3_var*
//#UC END# *479731C50290_535FD0BB03C3_var*
begin
//#UC START# *479731C50290_535FD0BB03C3_impl*
 FreeAndNil(f_Tag);
 inherited;
//#UC END# *479731C50290_535FD0BB03C3_impl*
end;//Tl3TagRef.Cleanup

function Tl3TagRef.QueryInterface(const IID: TGUID;
 out Obj): HResult;
 {* �������� ������� ��������� � ��������������, ���� ��� ��������. }
//#UC START# *47A0AD3A01F7_535FD0BB03C3_var*
//#UC END# *47A0AD3A01F7_535FD0BB03C3_var*
begin
//#UC START# *47A0AD3A01F7_535FD0BB03C3_impl*
 Result := inherited QueryInterface(IID, Obj);
 if not Succeeded(Result) then
  if f_Tag.QI(IID, Obj) then
   Result := S_Ok;
//#UC END# *47A0AD3A01F7_535FD0BB03C3_impl*
end;//Tl3TagRef.QueryInterface

{$If NOT Defined(DesignTimeLibrary)}
class function Tl3TagRef.IsCacheable: Boolean;
 {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
//#UC START# *47A6FEE600FC_535FD0BB03C3_var*
//#UC END# *47A6FEE600FC_535FD0BB03C3_var*
begin
//#UC START# *47A6FEE600FC_535FD0BB03C3_impl*
 Result := true;
//#UC END# *47A6FEE600FC_535FD0BB03C3_impl*
end;//Tl3TagRef.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
