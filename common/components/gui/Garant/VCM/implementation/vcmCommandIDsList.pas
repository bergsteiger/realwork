unit vcmCommandIDsList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/implementation/vcmCommandIDsList.pas"
// �����: 20.08.2009 20:15
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::Containers::TvcmCommandIDsList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmCommandIDsListPrim
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmCommandIDsList = {final} class(TvcmCommandIDsListPrim)
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TvcmCommandIDsList;
    {- ���������� ��������� ����������. }
 end;//TvcmCommandIDsList
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base {a}
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}


// start class TvcmCommandIDsList

var g_TvcmCommandIDsList : TvcmCommandIDsList = nil;

procedure TvcmCommandIDsListFree;
begin
 l3Free(g_TvcmCommandIDsList);
end;

class function TvcmCommandIDsList.Instance: TvcmCommandIDsList;
begin
 if (g_TvcmCommandIDsList = nil) then
 begin
  l3System.AddExitProc(TvcmCommandIDsListFree);
  g_TvcmCommandIDsList := Create;
 end;
 Result := g_TvcmCommandIDsList;
end;


class function TvcmCommandIDsList.Exists: Boolean;
 {-}
begin
 Result := g_TvcmCommandIDsList <> nil;
end;//TvcmCommandIDsList.Exists

{$IfEnd} //not NoVCM

end.