unit NOT_FINISHED_nsFolders;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Data"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Common/NOT_FINISHED_nsFolders.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 ������� ����������� ���������� �������::LegalDomain::Data::Common::nsFolders
//
// ��� ������ � ����� �����������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TFoldersTree = class
  {* ������ ���� ����������. }
 end;//TFoldersTree

const
  { cInfoCaptions }
 

type
 TFolderSecurity = class
 end;//TFolderSecurity
procedure UserFoldersTree;
   {* ��������� ������ UserFoldersTree }
procedure CheckFolderElementRights;
   {* ��������� ������ CheckFolderElementRights }
procedure NsDeleteBookmark;
   {* ��������� ������ nsDeleteBookmark }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
// unit methods

procedure UserFoldersTree;
//#UC START# *4AC095C002E6_48228EF9010F_var*
//#UC END# *4AC095C002E6_48228EF9010F_var*
begin
//#UC START# *4AC095C002E6_48228EF9010F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC095C002E6_48228EF9010F_impl*
end;//UserFoldersTree
// unit methods

procedure CheckFolderElementRights;
//#UC START# *4C7E77AD014A_48228EF9010F_var*
//#UC END# *4C7E77AD014A_48228EF9010F_var*
begin
//#UC START# *4C7E77AD014A_48228EF9010F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C7E77AD014A_48228EF9010F_impl*
end;//CheckFolderElementRights

procedure NsDeleteBookmark;
//#UC START# *4C879EFC02C7_48228EF9010F_var*
//#UC END# *4C879EFC02C7_48228EF9010F_var*
begin
//#UC START# *4C879EFC02C7_48228EF9010F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C879EFC02C7_48228EF9010F_impl*
end;//NsDeleteBookmark
{$IfEnd} //not Admin AND not Monitorings

end.