unit PrimPicture_pfImage_UserType;
 {* Просмотр графического объекта }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimPicture_pfImage_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы pfImage }
 pfImageName = 'pfImage';
  {* Строковый идентификатор пользовательского типа "Просмотр графического объекта" }
 pfImage = TvcmUserType(0);
  {* Просмотр графического объекта }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_pfImage = {final} class(TtfwInteger)
  {* Слово словаря для типа формы pfImage }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_pfImage
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_pfImage.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::pfImage';
end;//Tkw_FormUserType_pfImage.GetWordNameForRegister

function Tkw_FormUserType_pfImage.GetInteger: Integer;
begin
 Result := pfImage;
end;//Tkw_FormUserType_pfImage.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_pfImage.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_pfImage }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
