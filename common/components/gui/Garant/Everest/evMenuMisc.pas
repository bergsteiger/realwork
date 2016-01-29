unit evMenuMisc;
{* ��������������� ������� ��� ������ � ����. }

{ ���������� "�������"    }
{ �����: ����� �.�. �     }
{ ������: evMenuMisc -    }
{ �����: 10.11.2000 15:47 }
{ $Id: evMenuMisc.pas,v 1.3 2002/07/09 12:02:20 law Exp $ }

// $Log: evMenuMisc.pas,v $
// Revision 1.3  2002/07/09 12:02:20  law
// - rename unit: evUnits -> l3Units.
//
// Revision 1.2  2000/12/15 15:10:36  law
// - ��������� ��������� Log.
//

{$I evDefine.inc }

interface

uses
  Menus,

  l3Types
  ;

procedure evPopupMenu(aMenu: TPopupMenu);
  {* - ���������� ���� �� ����������� ����. }
function  evPopupMenuEx(const aTarget : IUnknown;
                        const anIID   : array of TGUID;
                        const aMenu   : array of TPopupMenu;
                        out Obj): Bool;
  {* - ���������� ���� aMenu[i] �� ����������� ���� ��� anIID[i] �� aTarget. }

implementation

uses
  l3Base,
  
  l3Units
  ;

procedure evPopupMenu(aMenu: TPopupMenu);
  {* - ���������� ���� �� ����������� ����. }
var
 Pt : Tl3SPoint;
begin
 if (aMenu <> nil) then begin
  Pt.GetCursorPos;
  with Pt do
   aMenu.Popup(X, Y);
 end;//aMenu <> nil
end;

function evPopupMenuEx(const aTarget : IUnknown;
                       const anIID   : array of TGUID;
                       const aMenu   : array of TPopupMenu;
                       out Obj): Bool;
  {* - ���������� ���� aMenu[i] �� ����������� ���� ��� anIID[i] �� aTarget. }
var
 i : Long;  
begin
 Result := false;
 if (aTarget <> nil) then
  for i := Low(anIID) to High(anIID) do
   if (i > High(aMenu)) then
    break
   else if l3IOk(aTarget.QueryInterface(anIID[i], Obj)) then begin
    evPopupMenu(aMenu[i]);
    Result := true;
    break;
   end;//l3IOk..
end;

end.

