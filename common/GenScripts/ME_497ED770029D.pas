unit PrimCommonDiction_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\PrimCommonDiction_Form.pas"
// Стереотип: "VCMForm"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , CommonDictionInterfaces
 , DocumentAndListInterfaces
 , l3StringIDEx
;

type
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\BaseDocument.imp.pas}
 TPrimCommonDictionForm = class(_BaseDocument_)
  protected
   dsCommonDiction: IdsCommonDiction;
  protected
   procedure FinishDataUpdate; override;
   {$If NOT Defined(NoVCM)}
   function IsAcceptable(aDataUpdate: Boolean): Boolean; override;
    {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   function NeedDrawCaption: Boolean; override;
    {* Нужно ли рисовать заголовок зоны }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimCommonDictionForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , Common_FormDefinitions_Controls
 , DataAdapter
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки utTipsLocalConstants }
 str_utTipsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utTipsCaption'; rValue : 'Совет дня');
  {* Заголовок пользовательского типа "Совет дня" }
 str_utTipsSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utTipsSettingsCaption'; rValue : 'Совет дня: Список советов (вкладка)');
  {* Заголовок пользовательского типа "Совет дня" для настройки панелей инструментов }
 {* Локализуемые строки utMedicDictionLocalConstants }
 str_utMedicDictionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utMedicDictionCaption'; rValue : 'Словарь медицинских терминов');
  {* Заголовок пользовательского типа "Словарь медицинских терминов" }
 str_utMedicDictionSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utMedicDictionSettingsCaption'; rValue : 'Словарь медицинских терминов: Список терминов (вкладка)');
  {* Заголовок пользовательского типа "Словарь медицинских терминов" для настройки панелей инструментов }

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\BaseDocument.imp.pas}

procedure TPrimCommonDictionForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_497ED770029D_var*
//#UC END# *47EA4E9002C6_497ED770029D_var*
begin
//#UC START# *47EA4E9002C6_497ED770029D_impl*
 if not IsAcceptable(True) then
  if vcmDispatcher.History.CanBack then
   vcmDispatcher.History.Back(True);
//#UC END# *47EA4E9002C6_497ED770029D_impl*
end;//TPrimCommonDictionForm.FinishDataUpdate

{$If NOT Defined(NoVCM)}
function TPrimCommonDictionForm.NeedDrawCaption: Boolean;
 {* Нужно ли рисовать заголовок зоны }
//#UC START# *4A84183701B9_497ED770029D_var*
//#UC END# *4A84183701B9_497ED770029D_var*
begin
//#UC START# *4A84183701B9_497ED770029D_impl*
 Result := false;
//#UC END# *4A84183701B9_497ED770029D_impl*
end;//TPrimCommonDictionForm.NeedDrawCaption
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimCommonDictionForm.IsAcceptable(aDataUpdate: Boolean): Boolean;
 {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
//#UC START# *55127A5401DE_497ED770029D_var*
//#UC END# *55127A5401DE_497ED770029D_var*
begin
//#UC START# *55127A5401DE_497ED770029D_impl*
 Result := dsCommonDiction.IsDataAvailable;
//#UC END# *55127A5401DE_497ED770029D_impl*
end;//TPrimCommonDictionForm.IsAcceptable
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_utTipsCaption.Init;
 {* Инициализация str_utTipsCaption }
 str_utTipsSettingsCaption.Init;
 {* Инициализация str_utTipsSettingsCaption }
 str_utMedicDictionCaption.Init;
 {* Инициализация str_utMedicDictionCaption }
 str_utMedicDictionSettingsCaption.Init;
 {* Инициализация str_utMedicDictionSettingsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimCommonDictionForm);
 {* Регистрация PrimCommonDiction }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
