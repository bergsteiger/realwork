unit tfwCStringArraySing2;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Parsing"
// ������: "tfwCStringArraySing2.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Parsing::CString::TtfwCStringArraySing2
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

uses
  tfwCStringArray
  ;

type
 TtfwCStringArraySing2 = class(TtfwCStringArray)
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TtfwCStringArraySing2;
    {- ���������� ��������� ����������. }
 end;//TtfwCStringArraySing2

implementation

uses
  l3Base {a}
  ;


// start class TtfwCStringArraySing2

var g_TtfwCStringArraySing2 : TtfwCStringArraySing2 = nil;

procedure TtfwCStringArraySing2Free;
begin
 l3Free(g_TtfwCStringArraySing2);
end;

class function TtfwCStringArraySing2.Instance: TtfwCStringArraySing2;
begin
 if (g_TtfwCStringArraySing2 = nil) then
 begin
  l3System.AddExitProc(TtfwCStringArraySing2Free);
  g_TtfwCStringArraySing2 := Create;
 end;
 Result := g_TtfwCStringArraySing2;
end;


class function TtfwCStringArraySing2.Exists: Boolean;
 {-}
begin
 Result := g_TtfwCStringArraySing2 <> nil;
end;//TtfwCStringArraySing2.Exists

end.