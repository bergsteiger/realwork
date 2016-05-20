{$IfNDef ContentsUserTypes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ContentsUserTypes.imp.pas"
// Стереотип: "VCMForm"
// Элемент модели: "ContentsUserTypes" MUID: (4FFB039302AA)
// Имя типа: "_ContentsUserTypes_"

{$Define ContentsUserTypes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _ContentsUserTypes_ = {abstract} class(_ContentsUserTypes_Parent_)
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_ContentsUserTypes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

_ContentsUserTypes_ = _ContentsUserTypes_Parent_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else ContentsUserTypes_imp}

{$IfNDef ContentsUserTypes_imp_impl}

{$Define ContentsUserTypes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 {* Локализуемые строки utContentsLocalConstants }
 str_utContentsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utContentsCaption'; rValue : 'Структура документа');
  {* Заголовок пользовательского типа "Структура документа" }
 str_utContentsSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utContentsSettingsCaption'; rValue : 'Документ: Структура (вкладка)');
  {* Заголовок пользовательского типа "Структура документа" для настройки панелей инструментов }
 {* Локализуемые строки utDrugContentsLocalConstants }
 str_utDrugContentsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utDrugContentsCaption'; rValue : 'Структура препарата');
  {* Заголовок пользовательского типа "Структура препарата" }
 str_utDrugContentsSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utDrugContentsSettingsCaption'; rValue : 'Препарат: Структура (вкладка)');
  {* Заголовок пользовательского типа "Структура препарата" для настройки панелей инструментов }

{$If NOT Defined(NoVCM)}
procedure _ContentsUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(utContentsName,
  str_utContentsCaption,
  str_utContentsSettingsCaption,
  False,
  66,
  40,
  '',
  nil,
  nil,
  nil,
  vcm_ccEnable) do
 begin
 end;//with AddUsertype(utContentsName
 with AddUsertype(utDrugContentsName,
  str_utDrugContentsCaption,
  str_utDrugContentsSettingsCaption,
  False,
  66,
  40,
  '',
  nil,
  nil,
  nil,
  vcm_ccEnable) do
 begin
 end;//with AddUsertype(utDrugContentsName
end;//_ContentsUserTypes_.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

{$Else ContentsUserTypes_imp_impl}

 str_utContentsCaption.Init;
 {* Инициализация str_utContentsCaption }
 str_utContentsSettingsCaption.Init;
 {* Инициализация str_utContentsSettingsCaption }
 str_utDrugContentsCaption.Init;
 {* Инициализация str_utDrugContentsCaption }
 str_utDrugContentsSettingsCaption.Init;
 {* Инициализация str_utDrugContentsSettingsCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf ContentsUserTypes_imp_impl}

{$EndIf ContentsUserTypes_imp}

