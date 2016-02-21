unit DocumentUserTypes_dftAnnotation_UserType;
 {* ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftAnnotation_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftDictSubEntry_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� dftAnnotation }
 dftAnnotationName = 'dftAnnotation';
  {* ��������� ������������� ����������������� ���� "���������" }
 dftAnnotation = TvcmUserType(dftDictSubEntry + 1);
  {* ��������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAnnotation = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� dftAnnotation }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dftAnnotation
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dftAnnotation.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::dftAnnotation';
end;//Tkw_FormUserType_dftAnnotation.GetWordNameForRegister

function Tkw_FormUserType_dftAnnotation.GetInteger: Integer;
begin
 Result := dftAnnotation;
end;//Tkw_FormUserType_dftAnnotation.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftAnnotation.RegisterInEngine;
 {* ����������� Tkw_FormUserType_dftAnnotation }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
