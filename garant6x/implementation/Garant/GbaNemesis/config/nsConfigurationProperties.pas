unit nsConfigurationProperties;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Config"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Config/nsConfigurationProperties.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 �������� ����������::Settings::Config::Config::TnsConfigurationProperties
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
  
  {$If not defined(NoVCM)}
  ,
  vcmStringList
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsConfigurationProperties = class(TvcmStringList)
 public
 // public methods
   class function HasInstance: Boolean;
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TnsConfigurationProperties;
    {- ���������� ��������� ����������. }
 end;//TnsConfigurationProperties
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class TnsConfigurationProperties

var g_TnsConfigurationProperties : TnsConfigurationProperties = nil;

procedure TnsConfigurationPropertiesFree;
begin
 l3Free(g_TnsConfigurationProperties);
end;

class function TnsConfigurationProperties.Instance: TnsConfigurationProperties;
begin
 if (g_TnsConfigurationProperties = nil) then
 begin
  l3System.AddExitProc(TnsConfigurationPropertiesFree);
  g_TnsConfigurationProperties := Create;
 end;
 Result := g_TnsConfigurationProperties;
end;


class function TnsConfigurationProperties.HasInstance: Boolean;
//#UC START# *5231A23D03D2_5231A17601FD_var*
//#UC END# *5231A23D03D2_5231A17601FD_var*
begin
//#UC START# *5231A23D03D2_5231A17601FD_impl*
 Result := Assigned(g_TnsConfigurationProperties);
//#UC END# *5231A23D03D2_5231A17601FD_impl*
end;//TnsConfigurationProperties.HasInstance

class function TnsConfigurationProperties.Exists: Boolean;
 {-}
begin
 Result := g_TnsConfigurationProperties <> nil;
end;//TnsConfigurationProperties.Exists

{$IfEnd} //not Admin AND not Monitorings

end.