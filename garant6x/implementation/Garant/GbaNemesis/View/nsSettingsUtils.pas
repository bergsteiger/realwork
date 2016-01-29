unit nsSettingsUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsSettingsUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Оболочка Без Прецедентов::F1 Without Usecases::View::SettingsUtils::nsSettingsUtils
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
procedure LoadStyleTableFromSettings;
procedure SaveStyleTableToSettings;
procedure InitialLoadStyleTableFromSettings;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  ConfigInterfaces,
  nsStyleEditor,
  evDefaultStylesFontSizes
  ;

// unit methods

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
{$IfEnd} //not Admin AND not Monitorings

end.