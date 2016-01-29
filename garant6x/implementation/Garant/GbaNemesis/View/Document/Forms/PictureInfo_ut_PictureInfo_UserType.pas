unit PictureInfo_ut_PictureInfo_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/Forms/PictureInfo_ut_PictureInfo_UserType.pas"
// Начат: 11 июля 2007
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Работа с документом и списком документов::Document::View::Document::Document::PictureInfo::ut_PictureInfo
//
// Информация о картинке
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
    { Константы для типа формы ut_PictureInfo }
   ut_PictureInfoName = 'ut_PictureInfo';
    { Строковый идентификатор пользовательского типа "Информация о картинке" }
   ut_PictureInfo = TvcmUserType(0);
    { Информация о картинке }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_PictureInfo = {final scriptword} class(TtfwInteger)
    {* Слово словаря для типа формы ut_PictureInfo }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_PictureInfo
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_PictureInfo

class function Tkw_FormUserType_ut_PictureInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::ut_PictureInfo';
end;//Tkw_FormUserType_ut_PictureInfo.GetWordNameForRegister

function Tkw_FormUserType_ut_PictureInfo.GetInteger: Integer;
 {-}
begin
 Result := ut_PictureInfo;
end;//Tkw_FormUserType_ut_PictureInfo.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_ut_PictureInfo
 Tkw_FormUserType_ut_PictureInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.