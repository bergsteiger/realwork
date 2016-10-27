unit ListUserTypes_lftSimilarDocuments_UserType;
 {* ������� ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftSimilarDocuments_UserType.pas"
// ���������: "UserType"
// ������� ������: "lftSimilarDocuments" MUID: (4BD589E40083)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftConsultation_UserType
 , l3StringIDEx
;

const
 {* ������������ ������ lftSimilarDocumentsLocalConstants }
 str_lftSimilarDocumentsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsCaption'; rValue : '������� ���������');
  {* ��������� ����������������� ���� "������� ���������" }
 str_lftSimilarDocumentsSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsSettingsCaption'; rValue : '������: ������� ���������');
  {* ��������� ����������������� ���� "������� ���������" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� lftSimilarDocuments }
 lftSimilarDocumentsName = 'lftSimilarDocuments';
  {* ��������� ������������� ����������������� ���� "������� ���������" }
 lftSimilarDocuments = TvcmUserType(lftConsultation + 1);
  {* ������� ��������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_lftSimilarDocuments = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftSimilarDocuments }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftSimilarDocuments
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftSimilarDocuments.GetInteger: Integer;
begin
 Result := lftSimilarDocuments;
end;//Tkw_FormUserType_lftSimilarDocuments.GetInteger

class function Tkw_FormUserType_lftSimilarDocuments.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftSimilarDocuments';
end;//Tkw_FormUserType_lftSimilarDocuments.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_lftSimilarDocumentsCaption.Init;
 {* ������������� str_lftSimilarDocumentsCaption }
 str_lftSimilarDocumentsSettingsCaption.Init;
 {* ������������� str_lftSimilarDocumentsSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftSimilarDocuments.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftSimilarDocuments }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
