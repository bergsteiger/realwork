unit AACContainerPrim_AACContentsContainer_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/AAC/Forms/AACContainerPrim_AACContentsContainer_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ���������������� �������::AAC::View::AAC::AACContainerPrim::AACContentsContainer
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
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  AACContainerPrim_AACContainer_UserType
  ;

const
   { ��������� ��� ���� ����� AACContentsContainer }
  AACContentsContainerName = 'AACContentsContainer';
   { ��������� ������������� ����������������� ���� "" }
  AACContentsContainer = TvcmUserType(AACContainer + 1);
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_AACContentsContainer = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� AACContentsContainer }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_AACContentsContainer
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_AACContentsContainer

class function Tkw_FormUserType_AACContentsContainer.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::AACContentsContainer';
end;//Tkw_FormUserType_AACContentsContainer.GetWordNameForRegister

function Tkw_FormUserType_AACContentsContainer.GetInteger: Integer;
 {-}
begin
 Result := AACContentsContainer;
end;//Tkw_FormUserType_AACContentsContainer.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_AACContentsContainer
 Tkw_FormUserType_AACContentsContainer.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.