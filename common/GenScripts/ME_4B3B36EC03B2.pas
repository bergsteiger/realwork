unit l3StringIDEx;
 {* ������ ��� ����������� }

// ������: "w:\common\components\rtl\Garant\L3\l3StringIDEx.pas"
// ���������: "UtilityPack"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3Types
 , l3ProtoDataContainer
 , l3Memory
 , l3Core
 , l3Except
 , Classes
 , l3ProtoObject
;

type
 Pl3StringIDEx = ^Tl3StringIDEx;

 Tl3StringIDExPrim = object(Tl3StringID)
  public
   rLocalized: Boolean;
    {* ������ ������������ }
 end;//Tl3StringIDExPrim

 Tl3StringIDEx = object(Tl3StringIDExPrim)
  public
   rKey: AnsiString;
    {* ���� }
   rValue: AnsiString;
    {* �������� }
  public
   procedure Localize(const aRus: AnsiString;
    const anAlien: AnsiString);
    {* ������������ }
   function AsWideString: WideString;
   function AsWStr: Tl3PCharLen;
   function AsCStr: Il3CString;
   function AsStr: AnsiString;
   procedure Init;
    {* �������������� ������ }
 end;//Tl3StringIDEx

 {$Undef l3Items_NoSort}

 _ItemType_ = Pl3StringIDEx;
 _l3AtomicListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3AtomicListPrim.imp.pas}
 Tl3ConstStringsPrim = class(_l3AtomicListPrim_)
  protected
   procedure InitFields; override;
 end;//Tl3ConstStringsPrim

 (*
 Ml3StringIDExHelper = interface
  {* �������� ������� Tl3StringIDExHelper }
  function AsCStr(const aStr: Tl3StringIDEx): Il3CString;
  function AsStr(const aStr: Tl3StringIDEx): AnsiString;
  procedure Init(var theStr: Tl3StringIDEx);
 end;//Ml3StringIDExHelper
 *)

 Il3StringIDExHelper = interface
  {* ��������� ������� Tl3StringIDExHelper }
  ['{8AB76DA9-7B40-4325-8F71-3EAA5DB9E047}']
  function AsCStr(const aStr: Tl3StringIDEx): Il3CString;
  function AsStr(const aStr: Tl3StringIDEx): AnsiString;
  procedure Init(var theStr: Tl3StringIDEx);
 end;//Il3StringIDExHelper

 Tl3StringIDExHelper = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3StringIDExHelper;
    {* ���� ��� �������� Alien }
  protected
   procedure pm_SetAlien(const aValue: Il3StringIDExHelper);
   procedure ClearFields; override;
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   procedure Init(var theStr: Tl3StringIDEx);
   function AsCStr(const aStr: Tl3StringIDEx): Il3CString;
   function AsStr(const aStr: Tl3StringIDEx): AnsiString;
   class function Instance: Tl3StringIDExHelper;
    {* ����� ��������� ���������� ���������� Tl3StringIDExHelper }
  public
   property Alien: Il3StringIDExHelper
    write pm_SetAlien;
    {* ������� ���������� ������� Il3StringIDExHelper }
 end;//Tl3StringIDExHelper

implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 , l3ConstStrings
;

var g_Tl3StringIDExHelper: Tl3StringIDExHelper = nil;
 {* ��������� ���������� Tl3StringIDExHelper }

procedure Tl3StringIDExHelperFree;
 {* ����� ������������ ���������� ���������� Tl3StringIDExHelper }
begin
 l3Free(g_Tl3StringIDExHelper);
end;//Tl3StringIDExHelperFree

procedure Tl3StringIDEx.Localize(const aRus: AnsiString;
 const anAlien: AnsiString);
 {* ������������ }
//#UC START# *4BB9D8550292_4B3B3728004C_var*
//#UC END# *4BB9D8550292_4B3B3728004C_var*
begin
//#UC START# *4BB9D8550292_4B3B3728004C_impl*
 rLocalized := true;
 rValue := anAlien;
//#UC END# *4BB9D8550292_4B3B3728004C_impl*
end;//Tl3StringIDEx.Localize

function Tl3StringIDEx.AsWideString: WideString;
//#UC START# *4CFE25B202FA_4B3B3728004C_var*
//#UC END# *4CFE25B202FA_4B3B3728004C_var*
begin
//#UC START# *4CFE25B202FA_4B3B3728004C_impl*
 Result := l3WideString(AsCStr);
//#UC END# *4CFE25B202FA_4B3B3728004C_impl*
end;//Tl3StringIDEx.AsWideString

function Tl3StringIDEx.AsWStr: Tl3PCharLen;
//#UC START# *4D7258F003D4_4B3B3728004C_var*
//#UC END# *4D7258F003D4_4B3B3728004C_var*
begin
//#UC START# *4D7258F003D4_4B3B3728004C_impl*
 Result := l3PCharLen(AsCStr);
//#UC END# *4D7258F003D4_4B3B3728004C_impl*
end;//Tl3StringIDEx.AsWStr

function Tl3StringIDEx.AsCStr: Il3CString;
//#UC START# *4B3B3B51012A_4B3B3728004C_var*
//#UC END# *4B3B3B51012A_4B3B3728004C_var*
begin
//#UC START# *4B3B3B51012A_4B3B3728004C_impl*
 Result := Tl3StringIDExHelper.Instance.AsCStr(Self);
//#UC END# *4B3B3B51012A_4B3B3728004C_impl*
end;//Tl3StringIDEx.AsCStr

function Tl3StringIDEx.AsStr: AnsiString;
//#UC START# *4B3B3F25003B_4B3B3728004C_var*
//#UC END# *4B3B3F25003B_4B3B3728004C_var*
begin
//#UC START# *4B3B3F25003B_4B3B3728004C_impl*
 Result := Tl3StringIDExHelper.Instance.AsStr(Self);
//#UC END# *4B3B3F25003B_4B3B3728004C_impl*
end;//Tl3StringIDEx.AsStr

procedure Tl3StringIDEx.Init;
 {* �������������� ������ }
//#UC START# *4B3B4D0A0026_4B3B3728004C_var*
//#UC END# *4B3B4D0A0026_4B3B3728004C_var*
begin
//#UC START# *4B3B4D0A0026_4B3B3728004C_impl*
 Tl3StringIDExHelper.Instance.Init(Self);
//#UC END# *4B3B4D0A0026_4B3B3728004C_impl*
end;//Tl3StringIDEx.Init

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* ���������� ��� ������������ ��������. }
//#UC START# *47B99D4503A2_4BA223D801B3_var*
//#UC END# *47B99D4503A2_4BA223D801B3_var*
begin
//#UC START# *47B99D4503A2_4BA223D801B3_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 //Result := CompareStr(CI.rA^.rKey, CI.rB^.rKey);
 //Result := l3Compare(l3PCharLen(CI.rA^.rKey), l3PCharLen(CI.rB^.rKey), CI.rSortIndex);
 Result := Integer(CI.rA^) - Integer(CI.rB^);
 // - ���� ���������� ������ ������, � �� �����, �.�. ����� ����� ���� ����������� - �� ��������
 // http://mdp.garant.ru/pages/viewpage.action?pageId=265404457&focusedCommentId=265407436#comment-265407436
//#UC END# *47B99D4503A2_4BA223D801B3_impl*
end;//CompareExistingItems

type _Instance_R_ = Tl3ConstStringsPrim;

{$Include l3AtomicListPrim.imp.pas}

procedure Tl3ConstStringsPrim.InitFields;
//#UC START# *47A042E100E2_4BA223D801B3_var*
//#UC END# *47A042E100E2_4BA223D801B3_var*
begin
//#UC START# *47A042E100E2_4BA223D801B3_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_4BA223D801B3_impl*
end;//Tl3ConstStringsPrim.InitFields

procedure Tl3StringIDExHelper.pm_SetAlien(const aValue: Il3StringIDExHelper);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3StringIDExHelper.pm_SetAlien

class function Tl3StringIDExHelper.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tl3StringIDExHelper <> nil;
end;//Tl3StringIDExHelper.Exists

procedure Tl3StringIDExHelper.Init(var theStr: Tl3StringIDEx);
//#UC START# *071573E75439_4B98D6C201AD_var*
//#UC END# *071573E75439_4B98D6C201AD_var*
begin
//#UC START# *071573E75439_4B98D6C201AD_impl*
 {$IfDef Nemesis}
  {$IfNDef NoVCM}
   Assert(not g_l3ConstStringsSealed);
  {$EndIf  NoVCM}
 {$EndIf Nemesis}
 {$IfNDef DesignTimeLibrary}
 if (theStr.rValue <> '') then
  Tl3ConstStrings.Instance.Add(@theStr);
 {$EndIf  DesignTimeLibrary}
 theStr.rS := -1;
 if (f_Alien <> nil) then
  f_Alien.Init(theStr);
//#UC END# *071573E75439_4B98D6C201AD_impl*
end;//Tl3StringIDExHelper.Init

function Tl3StringIDExHelper.AsCStr(const aStr: Tl3StringIDEx): Il3CString;
//#UC START# *201B50E5979A_4B98D6C201AD_var*
//#UC END# *201B50E5979A_4B98D6C201AD_var*
begin
//#UC START# *201B50E5979A_4B98D6C201AD_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.AsCStr(aStr)
 else
  Result := l3CStr(aStr.rValue);
//#UC END# *201B50E5979A_4B98D6C201AD_impl*
end;//Tl3StringIDExHelper.AsCStr

function Tl3StringIDExHelper.AsStr(const aStr: Tl3StringIDEx): AnsiString;
//#UC START# *74E80608E1B4_4B98D6C201AD_var*
//#UC END# *74E80608E1B4_4B98D6C201AD_var*
begin
//#UC START# *74E80608E1B4_4B98D6C201AD_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.AsStr(aStr)
 else
  Result := aStr.rValue;
//#UC END# *74E80608E1B4_4B98D6C201AD_impl*
end;//Tl3StringIDExHelper.AsStr

class function Tl3StringIDExHelper.Instance: Tl3StringIDExHelper;
 {* ����� ��������� ���������� ���������� Tl3StringIDExHelper }
begin
 if (g_Tl3StringIDExHelper = nil) then
 begin
  l3System.AddExitProc(Tl3StringIDExHelperFree);
  g_Tl3StringIDExHelper := Create;
 end;
 Result := g_Tl3StringIDExHelper;
end;//Tl3StringIDExHelper.Instance

procedure Tl3StringIDExHelper.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3StringIDExHelper.ClearFields

end.
