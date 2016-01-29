unit DocumentUserTypes_dftAACContentsRight_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftAACContentsRight_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftAACContentsRight
//
// Правая часть оглавления Энциклопедии решений
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
  ,
  DocumentUserTypes_dftAACContentsLeft_UserType
  ;

const
   { Константы для типа формы dftAACContentsRight }
  dftAACContentsRightName = 'dftAACContentsRight';
   { Строковый идентификатор пользовательского типа "Правая часть оглавления Энциклопедии решений" }
  dftAACContentsRight = TvcmUserType(dftAACContentsLeft + 1);
   { Правая часть оглавления Энциклопедии решений }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftAACContentsRight = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы dftAACContentsRight }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftAACContentsRight
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftAACContentsRight

class function Tkw_FormUserType_dftAACContentsRight.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::dftAACContentsRight';
end;//Tkw_FormUserType_dftAACContentsRight.GetWordNameForRegister

function Tkw_FormUserType_dftAACContentsRight.GetInteger: Integer;
 {-}
begin
 Result := dftAACContentsRight;
end;//Tkw_FormUserType_dftAACContentsRight.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_dftAACContentsRight
 Tkw_FormUserType_dftAACContentsRight.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.