unit PrimChangesBetweenEditons_DocumentChanges_UserType;
 {* Изменения в документе }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ChangesBetweenEditons\Forms\PrimChangesBetweenEditons_DocumentChanges_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "DocumentChanges" MUID: (4DDCDE8F01B8)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки DocumentChangesLocalConstants }
 str_DocumentChangesCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'DocumentChangesCaption'; rValue : 'Изменения в документе');
  {* Заголовок пользовательского типа "Изменения в документе" }
 {* Константы для типа формы DocumentChanges }
 DocumentChangesName = 'DocumentChanges';
  {* Строковый идентификатор пользовательского типа "Изменения в документе" }
 DocumentChanges = TvcmUserType(0);
  {* Изменения в документе }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_DocumentChanges = {final} class(TtfwInteger)
  {* Слово словаря для типа формы DocumentChanges }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_DocumentChanges
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_DocumentChanges.GetInteger: Integer;
begin
 Result := DocumentChanges;
end;//Tkw_FormUserType_DocumentChanges.GetInteger

class function Tkw_FormUserType_DocumentChanges.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::DocumentChanges';
end;//Tkw_FormUserType_DocumentChanges.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_DocumentChangesCaption.Init;
 {* Инициализация str_DocumentChangesCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_DocumentChanges.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_DocumentChanges }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
