unit PrimWorkJournal_utWorkJournal_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/WorkJournal/Forms/PrimWorkJournal_utWorkJournal_UserType.pas"
// �����: 27.04.2010 16:22
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������� ����������::WorkJournal::View::WorkJournal::PrimWorkJournal::utWorkJournal
//
// ������ ������
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
  
  ;

const
   { ��������� ��� ���� ����� utWorkJournal }
  utWorkJournalName = 'utWorkJournal';
   { ��������� ������������� ����������������� ���� "������ ������" }
  utWorkJournal = TvcmUserType(0);
   { ������ ������ }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utWorkJournal = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utWorkJournal }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utWorkJournal
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utWorkJournal

class function Tkw_FormUserType_utWorkJournal.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utWorkJournal';
end;//Tkw_FormUserType_utWorkJournal.GetWordNameForRegister

function Tkw_FormUserType_utWorkJournal.GetInteger: Integer;
 {-}
begin
 Result := utWorkJournal;
end;//Tkw_FormUserType_utWorkJournal.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utWorkJournal
 Tkw_FormUserType_utWorkJournal.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.