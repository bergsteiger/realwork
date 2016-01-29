unit PrimEditionsRes_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Editions/Forms/PrimEditionsRes_Form.pas"
// Начат: 15.01.2010 17:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMDataModule::Class>> F1 Пользовательские сервисы::CompareEditions::View::Editions::PrimEditionsRes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  vtPngImgList,
  Classes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimEditionsResForm = {form} class(TDataModule)
 private
 // private fields
   f_EditionsStateIcons : TvtPngImageList;
    {* Поле для свойства EditionsStateIcons}
 protected
 // property methods
   function pm_GetEditionsStateIcons: TvtPngImageList;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // public properties
   property EditionsStateIcons: TvtPngImageList
     read pm_GetEditionsStateIcons;
 public
 // singleton factory method
   class function Instance: TPrimEditionsResForm;
    {- возвращает экземпляр синглетона. }
 end;//TPrimEditionsResForm

 TvcmDataModuleRef = TPrimEditionsResForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a}
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class TPrimEditionsResForm

var g_TPrimEditionsResForm : TPrimEditionsResForm = nil;

procedure TPrimEditionsResFormFree;
begin
 l3Free(g_TPrimEditionsResForm);
end;

class function TPrimEditionsResForm.Instance: TPrimEditionsResForm;
begin
 if (g_TPrimEditionsResForm = nil) then
 begin
  l3System.AddExitProc(TPrimEditionsResFormFree);
  g_TPrimEditionsResForm := Create(nil);
 end;
 Result := g_TPrimEditionsResForm;
end;


function TPrimEditionsResForm.pm_GetEditionsStateIcons: TvtPngImageList;
begin
 if (f_EditionsStateIcons = nil) then
  f_EditionsStateIcons := FindComponent('EditionsStateIcons') As TvtPngImageList;
 Result := f_EditionsStateIcons;
end;

class function TPrimEditionsResForm.Exists: Boolean;
 {-}
begin
 Result := g_TPrimEditionsResForm <> nil;
end;//TPrimEditionsResForm.Exists

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimEditionsRes
 TtfwClassRef.Register(TPrimEditionsResForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.