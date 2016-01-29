unit PrimFoldersTree_utSaveOpen_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/Forms/PrimFoldersTree_utSaveOpen_UserType.pas"
// �����: 26.01.2009 18:19
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������� ����������::Folders::View::Folders::PrimFoldersTree::utSaveOpen
//
// ��� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  PrimFoldersTree_utFoldersTree_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� utSaveOpen }
  utSaveOpenName = 'utSaveOpen';
   { ��������� ������������� ����������������� ���� "��� ���������" }
  utSaveOpen = TvcmUserType(utFoldersTree + 1);
   { ��� ��������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utSaveOpen = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utSaveOpen }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utSaveOpen
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utSaveOpen

class function Tkw_FormUserType_utSaveOpen.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utSaveOpen';
end;//Tkw_FormUserType_utSaveOpen.GetWordNameForRegister

function Tkw_FormUserType_utSaveOpen.GetInteger: Integer;
 {-}
begin
 Result := utSaveOpen;
end;//Tkw_FormUserType_utSaveOpen.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utSaveOpen
 Tkw_FormUserType_utSaveOpen.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.