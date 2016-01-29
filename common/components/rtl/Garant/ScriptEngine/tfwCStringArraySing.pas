unit tfwCStringArraySing;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Parsing"
// ������: "tfwCStringArraySing.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Parsing::CString::TtfwCStringArraySing
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

uses
  tfwCStringArray
  ;

type
 TtfwCStringArraySing = class(TtfwCStringArray)
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TtfwCStringArraySing;
    {- ���������� ��������� ����������. }
 end;//TtfwCStringArraySing

implementation

uses
  l3Base {a}
  ;


// start class TtfwCStringArraySing

var g_TtfwCStringArraySing : TtfwCStringArraySing = nil;

procedure TtfwCStringArraySingFree;
begin
 l3Free(g_TtfwCStringArraySing);
end;

class function TtfwCStringArraySing.Instance: TtfwCStringArraySing;
begin
 if (g_TtfwCStringArraySing = nil) then
 begin
  l3System.AddExitProc(TtfwCStringArraySingFree);
  g_TtfwCStringArraySing := Create;
 end;
 Result := g_TtfwCStringArraySing;
end;


class function TtfwCStringArraySing.Exists: Boolean;
 {-}
begin
 Result := g_TtfwCStringArraySing <> nil;
end;//TtfwCStringArraySing.Exists

end.