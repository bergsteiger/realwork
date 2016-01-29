unit l3GraphicContainerStack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3GraphicContainerStack.pas"
// �����: 18.05.2011 17:43
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3Canvas::Tl3GraphicContainerStack
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ObjectList
  ;

type
 Tl3GraphicContainerStack = class(Tl3ObjectList)
 public
 // public methods
   class function Exists: Boolean;
 public
 // singleton factory method
   class function Instance: Tl3GraphicContainerStack;
    {- ���������� ��������� ����������. }
 end;//Tl3GraphicContainerStack

implementation

uses
  l3Base {a}
  ;


// start class Tl3GraphicContainerStack

var g_Tl3GraphicContainerStack : Tl3GraphicContainerStack = nil;

procedure Tl3GraphicContainerStackFree;
begin
 l3Free(g_Tl3GraphicContainerStack);
end;

class function Tl3GraphicContainerStack.Instance: Tl3GraphicContainerStack;
begin
 if (g_Tl3GraphicContainerStack = nil) then
 begin
  l3System.AddExitProc(Tl3GraphicContainerStackFree);
  g_Tl3GraphicContainerStack := Create;
 end;
 Result := g_Tl3GraphicContainerStack;
end;


class function Tl3GraphicContainerStack.Exists: Boolean;
//#UC START# *4DD3CE6A00B7_4DD3CD0B0193_var*
//#UC END# *4DD3CE6A00B7_4DD3CD0B0193_var*
begin
//#UC START# *4DD3CE6A00B7_4DD3CD0B0193_impl*
 Result := (g_Tl3GraphicContainerStack <> nil);
//#UC END# *4DD3CE6A00B7_4DD3CD0B0193_impl*
end;//Tl3GraphicContainerStack.Exists

end.