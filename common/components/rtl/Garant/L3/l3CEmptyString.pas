unit l3CEmptyString;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// ������: "w:/common/components/rtl/Garant/L3/l3CEmptyString.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3CEmptyString
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3CEmptyStringPrim
  ;

type
 Tl3CEmptyString = class(Tl3CEmptyStringPrim)
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: Tl3CEmptyString;
    {- ���������� ��������� ����������. }
 end;//Tl3CEmptyString

implementation

uses
  l3Base {a}
  ;


// start class Tl3CEmptyString

var g_Tl3CEmptyString : Tl3CEmptyString = nil;

procedure Tl3CEmptyStringFree;
begin
 l3Free(g_Tl3CEmptyString);
end;

class function Tl3CEmptyString.Instance: Tl3CEmptyString;
begin
 if (g_Tl3CEmptyString = nil) then
 begin
  l3System.AddExitProc(Tl3CEmptyStringFree);
  g_Tl3CEmptyString := Create;
 end;
 Result := g_Tl3CEmptyString;
end;


class function Tl3CEmptyString.Exists: Boolean;
 {-}
begin
 Result := g_Tl3CEmptyString <> nil;
end;//Tl3CEmptyString.Exists

end.