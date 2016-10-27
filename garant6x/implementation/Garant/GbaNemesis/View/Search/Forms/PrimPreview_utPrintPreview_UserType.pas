unit PrimPreview_utPrintPreview_UserType;
 {* Предварительный просмотр печати }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPreview_utPrintPreview_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utPrintPreview" MUID: (4C6D0F2700E1)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки utPrintPreviewLocalConstants }
 str_utPrintPreviewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utPrintPreviewCaption'; rValue : 'Предварительный просмотр печати');
  {* Заголовок пользовательского типа "Предварительный просмотр печати" }
 {* Константы для типа формы utPrintPreview }
 utPrintPreviewName = 'utPrintPreview';
  {* Строковый идентификатор пользовательского типа "Предварительный просмотр печати" }
 utPrintPreview = TvcmUserType(0);
  {* Предварительный просмотр печати }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_utPrintPreview = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utPrintPreview }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utPrintPreview
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utPrintPreview.GetInteger: Integer;
begin
 Result := utPrintPreview;
end;//Tkw_FormUserType_utPrintPreview.GetInteger

class function Tkw_FormUserType_utPrintPreview.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utPrintPreview';
end;//Tkw_FormUserType_utPrintPreview.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utPrintPreviewCaption.Init;
 {* Инициализация str_utPrintPreviewCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utPrintPreview.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utPrintPreview }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
