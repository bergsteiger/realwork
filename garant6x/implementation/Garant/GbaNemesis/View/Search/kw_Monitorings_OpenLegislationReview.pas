unit kw_Monitorings_OpenLegislationReview;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/kw_Monitorings_OpenLegislationReview.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ���������������� �������::Autoreferat::View::Search::Tkw_Monitorings_OpenLegislationReview
//
// ����� ������� ��� ������ �������� ������ Monitorings.OpenLegislationReview (����������� �����
// ��������� ����������������)
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
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwModuleOperationWord.imp.pas}
 Tkw_Monitorings_OpenLegislationReview = class(_tfwModuleOperationWord_)
  {* ����� ������� ��� ������ �������� ������ Monitorings.OpenLegislationReview (����������� ����� ��������� ����������������) }
 protected
 // overridden protected methods
   {$If not defined(NoScripts)}
   class function GetModuleOperationCode: TvcmMOPID; override;
   {$IfEnd} //not NoScripts
 public
 // overridden public methods
   {$If not defined(NoScripts)}
   class function GetWordNameForRegister: AnsiString; override;
   {$IfEnd} //not NoScripts
 end;//Tkw_Monitorings_OpenLegislationReview
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  tfwAutoregisteredDiction
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptEngine,
  kwString,
  vcmModulesCollectionItem,
  vcmBaseOperationsCollectionItem,
  l3Except,
  vcmBaseMenuManager
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = Tkw_Monitorings_OpenLegislationReview;

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwModuleOperationWord.imp.pas}

// start class Tkw_Monitorings_OpenLegislationReview

{$If not defined(NoScripts)}
class function Tkw_Monitorings_OpenLegislationReview.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���::�����������_�����_���������_����������������';
end;//Tkw_Monitorings_OpenLegislationReview.GetWordNameForRegister
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
class function Tkw_Monitorings_OpenLegislationReview.GetModuleOperationCode: TvcmMOPID;
 {-}
begin
 Result := TdmStdRes.mod_opcode_Monitorings_OpenLegislationReview;
end;//Tkw_Monitorings_OpenLegislationReview.GetModuleOperationCode
{$IfEnd} //not NoScripts

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwModuleOperationWord.imp.pas}
{$IfEnd} //not Admin AND not Monitorings

end.