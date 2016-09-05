unit nsConfigurationProperties;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Config\nsConfigurationProperties.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsConfigurationProperties" MUID: (5231A17601FD)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmStringList
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TnsConfigurationProperties = class({$If NOT Defined(NoVCM)}
 TvcmStringList
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , IvcmStrings
 {$IfEnd} // NOT Defined(NoVCM)
 )
  public
   class function HasInstance: Boolean;
   class function Instance: TnsConfigurationProperties;
    {* Метод получения экземпляра синглетона TnsConfigurationProperties }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsConfigurationProperties
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *5231A17601FDimpl_uses*
 //#UC END# *5231A17601FDimpl_uses*
;

{$If NOT Defined(NoVCM)}
var g_TnsConfigurationProperties: TnsConfigurationProperties = nil;
 {* Экземпляр синглетона TnsConfigurationProperties }

procedure TnsConfigurationPropertiesFree;
 {* Метод освобождения экземпляра синглетона TnsConfigurationProperties }
begin
 l3Free(g_TnsConfigurationProperties);
end;//TnsConfigurationPropertiesFree

class function TnsConfigurationProperties.HasInstance: Boolean;
//#UC START# *5231A23D03D2_5231A17601FD_var*
//#UC END# *5231A23D03D2_5231A17601FD_var*
begin
//#UC START# *5231A23D03D2_5231A17601FD_impl*
 Result := Assigned(g_TnsConfigurationProperties);
//#UC END# *5231A23D03D2_5231A17601FD_impl*
end;//TnsConfigurationProperties.HasInstance

class function TnsConfigurationProperties.Instance: TnsConfigurationProperties;
 {* Метод получения экземпляра синглетона TnsConfigurationProperties }
begin
 if (g_TnsConfigurationProperties = nil) then
 begin
  l3System.AddExitProc(TnsConfigurationPropertiesFree);
  g_TnsConfigurationProperties := Create;
 end;
 Result := g_TnsConfigurationProperties;
end;//TnsConfigurationProperties.Instance

class function TnsConfigurationProperties.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsConfigurationProperties <> nil;
end;//TnsConfigurationProperties.Exists
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
