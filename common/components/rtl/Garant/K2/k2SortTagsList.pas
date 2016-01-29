unit k2SortTagsList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/K2/k2SortTagsList.pas"
// �����: 23.05.2011 18:59
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2PrimObjects::Tk2SortTagsList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2SortTagsListPrim
  ;

type
 Tk2SortTagsList = class(Tk2SortTagsListPrim)
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: Tk2SortTagsList;
    {- ���������� ��������� ����������. }
 end;//Tk2SortTagsList

implementation

uses
  l3Base {a}
  ;


// start class Tk2SortTagsList

var g_Tk2SortTagsList : Tk2SortTagsList = nil;

procedure Tk2SortTagsListFree;
begin
 l3Free(g_Tk2SortTagsList);
end;

class function Tk2SortTagsList.Instance: Tk2SortTagsList;
begin
 if (g_Tk2SortTagsList = nil) then
 begin
  l3System.AddExitProc(Tk2SortTagsListFree);
  g_Tk2SortTagsList := Create;
 end;
 Result := g_Tk2SortTagsList;
end;


class function Tk2SortTagsList.Exists: Boolean;
 {-}
begin
 Result := g_Tk2SortTagsList <> nil;
end;//Tk2SortTagsList.Exists

end.