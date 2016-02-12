unit PictureInfo_ut_PictureInfo_UserType;
 {* Информация о картинке }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\PictureInfo_ut_PictureInfo_UserType.pas"
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
 {* Константы для типа формы ut_PictureInfo }
 ut_PictureInfoName = 'ut_PictureInfo';
  {* Строковый идентификатор пользовательского типа "Информация о картинке" }
 ut_PictureInfo = TvcmUserType(0);
  {* Информация о картинке }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_PictureInfo = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_PictureInfo }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_PictureInfo
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_PictureInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_PictureInfo';
end;//Tkw_FormUserType_ut_PictureInfo.GetWordNameForRegister

function Tkw_FormUserType_ut_PictureInfo.GetInteger: Integer;
begin
 Result := ut_PictureInfo;
end;//Tkw_FormUserType_ut_PictureInfo.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_PictureInfo.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_PictureInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
