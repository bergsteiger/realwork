unit PrimPreview_utPrintPreview_UserType;
 {* Предварительный просмотр печати }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPreview_utPrintPreview_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
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

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utPrintPreview = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utPrintPreview }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utPrintPreview
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utPrintPreview.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utPrintPreview';
end;//Tkw_FormUserType_utPrintPreview.GetWordNameForRegister

function Tkw_FormUserType_utPrintPreview.GetInteger: Integer;
begin
 Result := utPrintPreview;
end;//Tkw_FormUserType_utPrintPreview.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utPrintPreview.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utPrintPreview }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
