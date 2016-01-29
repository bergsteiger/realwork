unit PrimPicture_pfImage_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimPicture_pfImage_UserType.pas"
// Начат: 15.09.2009 21:32
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Работа с документом и списком документов::Document::View::Picture::PrimPicture::pfImage
//
// Просмотр графического объекта
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
   { Константы для типа формы pfImage }
  pfImageName = 'pfImage';
   { Строковый идентификатор пользовательского типа "Просмотр графического объекта" }
  pfImage = TvcmUserType(0);
   { Просмотр графического объекта }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_pfImage = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы pfImage }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_pfImage
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_pfImage

class function Tkw_FormUserType_pfImage.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::pfImage';
end;//Tkw_FormUserType_pfImage.GetWordNameForRegister

function Tkw_FormUserType_pfImage.GetInteger: Integer;
 {-}
begin
 Result := pfImage;
end;//Tkw_FormUserType_pfImage.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_pfImage
 Tkw_FormUserType_pfImage.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.