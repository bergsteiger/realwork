unit nsSettingsUtils;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsSettingsUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsSettingsUtils" MUID: (4AD5BB450335)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
;

procedure InitialLoadStyleTableFromSettings;
procedure LoadStyleTableFromSettings;
procedure SaveStyleTableToSettings;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , ConfigInterfaces
 , nsStyleEditor
 , evDefaultStylesFontSizes
 //#UC START# *4AD5BB450335impl_uses*
 //#UC END# *4AD5BB450335impl_uses*
;

procedure InitialLoadStyleTableFromSettings;
//#UC START# *4E32B50601F3_4AD5BB450335_var*
var
 l_Editor: InsEditSettingsInfo;
//#UC END# *4E32B50601F3_4AD5BB450335_var*
begin
//#UC START# *4E32B50601F3_4AD5BB450335_impl*
 l_Editor := TnsStyleTableSettingsInfo.Make;
 try
  l_Editor.InitialLoadStyleTableFromSettings;
 finally
  l_Editor := nil;
 end;
//#UC END# *4E32B50601F3_4AD5BB450335_impl*
end;//InitialLoadStyleTableFromSettings

procedure LoadStyleTableFromSettings;
//#UC START# *4AD5BB7002A2_4AD5BB450335_var*
var
 l_Editor: InsEditSettingsInfo;
//#UC END# *4AD5BB7002A2_4AD5BB450335_var*
begin
//#UC START# *4AD5BB7002A2_4AD5BB450335_impl*
 l_Editor := TnsStyleTableSettingsInfo.Make;
 try
  l_Editor.Load;
 finally
  l_Editor := nil;
 end;
//#UC END# *4AD5BB7002A2_4AD5BB450335_impl*
end;//LoadStyleTableFromSettings

procedure SaveStyleTableToSettings;
//#UC START# *4AD5BB7F00E5_4AD5BB450335_var*
var
 l_Editor: InsEditSettingsInfo;
//#UC END# *4AD5BB7F00E5_4AD5BB450335_var*
begin
//#UC START# *4AD5BB7F00E5_4AD5BB450335_impl*
 l_Editor := TnsStyleTableSettingsInfo.Make;
 try
  l_Editor.Save;
 finally
  l_Editor := nil;
 end;
//#UC END# *4AD5BB7F00E5_4AD5BB450335_impl*
end;//SaveStyleTableToSettings
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
