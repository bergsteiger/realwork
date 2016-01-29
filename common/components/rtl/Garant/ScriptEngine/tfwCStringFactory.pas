unit tfwCStringFactory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Parsing"
// ������: "tfwCStringFactory.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Parsing::CString::TtfwCStringFactory
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

uses
  l3Interfaces,
  tfwCStringList,
  l3Variant
  ;

type
 TtfwCStringFactory = class(TtfwCStringList)
 private
 // private methods
   procedure CacheString(var theIndex: Integer;
     const aString: Il3CString);
 protected
 // overridden protected methods
   procedure InitFields; override;
 public
 // public methods
   class function C(const aString: AnsiString): Il3CString; overload; 
   class function C(const aString: Tl3WString): Il3CString; overload; 
   class function C(aString: Tl3PrimString): Il3CString; overload; 
   class function C(aChar: AnsiChar): Il3CString; overload; 
   class function C(const aString: Il3CString): Il3CString; overload; 
     {* ���������� ������������ ����� ������. �������� ��� ��������� ����� Cat }
   class function Cat(const aA: Il3CString;
     const aB: Il3CString): Il3CString; overload; 
   class function Cat(const aStrings: array of Il3CString): Il3CString; overload; 
   class function ViewOf(const aString: Tl3WString): Il3CString; overload; 
   class function CatSep(const aA: Il3CString;
     const aSep: Il3CString;
     const aB: Il3CString): Il3CString;
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TtfwCStringFactory;
    {- ���������� ��������� ����������. }
 end;//TtfwCStringFactory

implementation

uses
  l3Base {a},
  l3String,
  tfwCStringArraySing,
  tfwCStringArraySing2,
  l3Types
  ;


// start class TtfwCStringFactory

var g_TtfwCStringFactory : TtfwCStringFactory = nil;

procedure TtfwCStringFactoryFree;
begin
 l3Free(g_TtfwCStringFactory);
end;

class function TtfwCStringFactory.Instance: TtfwCStringFactory;
begin
 if (g_TtfwCStringFactory = nil) then
 begin
  l3System.AddExitProc(TtfwCStringFactoryFree);
  g_TtfwCStringFactory := Create;
 end;
 Result := g_TtfwCStringFactory;
end;

const
   { Local }
  cLimit = 200;

// start class TtfwCStringFactory

procedure TtfwCStringFactory.CacheString(var theIndex: Integer;
  const aString: Il3CString);
//#UC START# *56011A85035E_4F473F9402D8_var*
const
 cCountLimit = 5000;
//#UC END# *56011A85035E_4F473F9402D8_var*
begin
//#UC START# *56011A85035E_4F473F9402D8_impl*
 if (Count >= cCountLimit) then
 begin
  Clear;
  theIndex := 0;
 end;//Count >= cCountLimit
 DirectInsert(theIndex, aString);
//#UC END# *56011A85035E_4F473F9402D8_impl*
end;//TtfwCStringFactory.CacheString

class function TtfwCStringFactory.C(const aString: AnsiString): Il3CString;
//#UC START# *4F47405B02FD_4F473F9402D8_var*
var
 i : Integer;
 l_Len : Integer;
 l_W   : Word;
//#UC END# *4F47405B02FD_4F473F9402D8_var*
begin
//#UC START# *4F47405B02FD_4F473F9402D8_impl*
 {.$IfNDef XE}
 l_Len := Length(aString);
 if (l_Len < cLimit) then
 begin
  if (l_Len = 1) then
   Result := C(aString[1])
  else
  if (l_Len = 2) then
  begin
   l_W := PWord(@(aString[1]))^;
   Result := TtfwCStringArraySing2.Instance.Items[l_W];
   if (Result = nil) then
   begin
    Result := l3CStr(aString);
    TtfwCStringArraySing2.Instance.Items[l_W] := Result;
   end;//Result = nil
  end//l_Len = 2
  else
   with Instance do
   begin
    if FindData(l3PCharLen(aString), i, SortIndex) then
     Result := Items[i]
    else
    begin
     Result := l3CStr(aString);
     CacheString(i, Result);
    end;//FindData(l3PCharLen(aString), i)
   end;//with Instance
 end//Length(aString) < cLimit
 else
 {.$EndIf XE}
  Result := l3CStr(aString);
//#UC END# *4F47405B02FD_4F473F9402D8_impl*
end;//TtfwCStringFactory.C

class function TtfwCStringFactory.C(const aString: Tl3WString): Il3CString;
//#UC START# *4F47407D0052_4F473F9402D8_var*
var
 i : Integer;
 l_W : Word;
//#UC END# *4F47407D0052_4F473F9402D8_var*
begin
//#UC START# *4F47407D0052_4F473F9402D8_impl*
 {.$IfNDef XE}
 if (aString.SLen < cLimit) AND l3IsANSI(aString.SCodePage) then
 begin
  if (aString.SLen = 1) {AND l3IsANSI(aString.SCodePage)} then
  begin
   Assert(aString.S <> nil);
   Result := C(aString.S[0]);
  end//aString.SLen = 1
  else
  if (aString.SLen = 2) {AND l3IsANSI(aString.SCodePage)} then
  begin
   Assert(aString.S <> nil);
   l_W := PWord(aString.S)^;
   Result := TtfwCStringArraySing2.Instance.Items[l_W];
   if (Result = nil) then
   begin
    Result := l3CStr(aString);
    TtfwCStringArraySing2.Instance.Items[l_W] := Result;
   end;//Result = nil
  end//aString.SLen = 2
  else
   with Instance do
   begin
    if {l3IsANSI(aString.SCodePage) AND }FindData(aString, i, SortIndex) then
     Result := Items[i]
    else
    begin
     Result := l3CStr(aString);
     CacheString(i, Result);
    end;//FindData(l3PCharLen(aString), i)
   end;//with Instance
 end//Length(aString) < cLimit
 else
 {.$EndIf XE}
  Result := l3CStr(aString);
//#UC END# *4F47407D0052_4F473F9402D8_impl*
end;//TtfwCStringFactory.C

class function TtfwCStringFactory.C(aString: Tl3PrimString): Il3CString;
//#UC START# *4F4740A802A8_4F473F9402D8_var*
var
 l_S : Tl3WString;
//#UC END# *4F4740A802A8_4F473F9402D8_var*
begin
//#UC START# *4F4740A802A8_4F473F9402D8_impl*
 if (aString = nil) then
  Result := l3CStr('')
 else
 begin
  l_S := aString.AsWStr;
  if (l_S.SLen < cLimit) then
   Result := C(l_S)
  else
   Result := l3CStr(aString);
 end;//aString = nil
//#UC END# *4F4740A802A8_4F473F9402D8_impl*
end;//TtfwCStringFactory.C

class function TtfwCStringFactory.C(aChar: AnsiChar): Il3CString;
//#UC START# *4F50782700AA_4F473F9402D8_var*
//#UC END# *4F50782700AA_4F473F9402D8_var*
begin
//#UC START# *4F50782700AA_4F473F9402D8_impl*
 Result := TtfwCStringArraySing.Instance.Items[Ord(aChar)];
 if (Result = nil) then
 begin
  Result := l3CStr(aChar);
  TtfwCStringArraySing.Instance.Items[Ord(aChar)] := Result;
 end;//Result = nil
//#UC END# *4F50782700AA_4F473F9402D8_impl*
end;//TtfwCStringFactory.C

class function TtfwCStringFactory.C(const aString: Il3CString): Il3CString;
//#UC START# *559F726001FC_4F473F9402D8_var*
var
 l_W : Tl3WString;
 i : Integer;
//#UC END# *559F726001FC_4F473F9402D8_var*
begin
//#UC START# *559F726001FC_4F473F9402D8_impl*
 l_W := aString.AsWStr;
 if (l_W.SLen < 50{cLimit}) then
 begin
  if (l_W.SLen < 5) then
   Result := C(l_W)
  else
  begin
   with Instance do
   begin
    if FindData({aString}l_W, i, SortIndex) then
     Result := Items[i]
    else
    begin
     Result := aString;
     CacheString(i, Result);
    end;//FindData(l3PCharLen(aString), i)
   end;//with Instance
  end;//l_W.SLen < 5
 end
 else
  Result := aString;
//#UC END# *559F726001FC_4F473F9402D8_impl*
end;//TtfwCStringFactory.C

class function TtfwCStringFactory.Cat(const aA: Il3CString;
  const aB: Il3CString): Il3CString;
//#UC START# *56028D1B01AC_4F473F9402D8_var*
//#UC END# *56028D1B01AC_4F473F9402D8_var*
begin
//#UC START# *56028D1B01AC_4F473F9402D8_impl*
 Result := l3Cat([aA, aB]);
 if (Result <> aA) AND (Result <> aB) then
  Result := C(Result);
//#UC END# *56028D1B01AC_4F473F9402D8_impl*
end;//TtfwCStringFactory.Cat

class function TtfwCStringFactory.Cat(const aStrings: array of Il3CString): Il3CString;
//#UC START# *56028DB8038D_4F473F9402D8_var*
//#UC END# *56028DB8038D_4F473F9402D8_var*
begin
//#UC START# *56028DB8038D_4F473F9402D8_impl*
 Result := C(l3Cat(aStrings));
//#UC END# *56028DB8038D_4F473F9402D8_impl*
end;//TtfwCStringFactory.Cat

class function TtfwCStringFactory.ViewOf(const aString: Tl3WString): Il3CString;
//#UC START# *56029758029D_4F473F9402D8_var*
//#UC END# *56029758029D_4F473F9402D8_var*
begin
//#UC START# *56029758029D_4F473F9402D8_impl*
 Result := C(aString);
 //Result := Tl3ConstString.MakeI(aString);
//#UC END# *56029758029D_4F473F9402D8_impl*
end;//TtfwCStringFactory.ViewOf

class function TtfwCStringFactory.CatSep(const aA: Il3CString;
  const aSep: Il3CString;
  const aB: Il3CString): Il3CString;
//#UC START# *5602A7F8015D_4F473F9402D8_var*
//#UC END# *5602A7F8015D_4F473F9402D8_var*
begin
//#UC START# *5602A7F8015D_4F473F9402D8_impl*
 if l3IsNil(aA) then
  Result := aB
 else
 if l3IsNil(aB) then
  Result := aA
 else
  Result := Cat([aA, aSep, aB]);
//#UC END# *5602A7F8015D_4F473F9402D8_impl*
end;//TtfwCStringFactory.CatSep

class function TtfwCStringFactory.Exists: Boolean;
 {-}
begin
 Result := g_TtfwCStringFactory <> nil;
end;//TtfwCStringFactory.Exists

procedure TtfwCStringFactory.InitFields;
//#UC START# *47A042E100E2_4F473F9402D8_var*
//#UC END# *47A042E100E2_4F473F9402D8_var*
begin
//#UC START# *47A042E100E2_4F473F9402D8_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_4F473F9402D8_impl*
end;//TtfwCStringFactory.InitFields

end.