unit vtNavigatorFormList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VT$WithVCM"
// ������: "w:/common/components/gui/Garant/VT/vtNavigatorFormList.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VT$WithVCM::vtNavigator::TvtNavigatorFormList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vtNavigatorFormListPrim
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvtNavigatorFormList = class(TvtNavigatorFormListPrim)
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TvtNavigatorFormList;
    {- ���������� ��������� ����������. }
 end;//TvtNavigatorFormList
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base {a}
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}


// start class TvtNavigatorFormList

var g_TvtNavigatorFormList : TvtNavigatorFormList = nil;

procedure TvtNavigatorFormListFree;
begin
 l3Free(g_TvtNavigatorFormList);
end;

class function TvtNavigatorFormList.Instance: TvtNavigatorFormList;
begin
 if (g_TvtNavigatorFormList = nil) then
 begin
  l3System.AddExitProc(TvtNavigatorFormListFree);
  g_TvtNavigatorFormList := Create;
 end;
 Result := g_TvtNavigatorFormList;
end;


class function TvtNavigatorFormList.Exists: Boolean;
 {-}
begin
 Result := g_TvtNavigatorFormList <> nil;
end;//TvtNavigatorFormList.Exists

{$IfEnd} //not NoVCM

end.