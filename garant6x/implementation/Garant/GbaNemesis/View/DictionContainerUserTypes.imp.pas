{$IfNDef DictionContainerUserTypes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DictionContainerUserTypes.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Встроенные продукты::DictionLike::View::DictionLikeForms::DictionContainerUserTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define DictionContainerUserTypes_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _DictionContainerUserTypes_ = {abstract form} class(_DictionContainerUserTypes_Parent_)
 protected
  procedure MakeControls; override;
 end;//_DictionContainerUserTypes_
{$Else}

 _DictionContainerUserTypes_ = _DictionContainerUserTypes_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else DictionContainerUserTypes_imp}

{$IfNDef DictionContainerUserTypes_imp_impl}
{$Define DictionContainerUserTypes_imp_impl}

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки slqtDictionLocalConstants }
  str_slqtDictionCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtDictionCaption'; rValue : 'Толковый словарь');
   { Заголовок пользовательского типа "Толковый словарь" }

var
   { Локализуемые строки slqtMedicDictionLocalConstants }
  str_slqtMedicDictionCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'slqtMedicDictionCaption'; rValue : 'Словарь медицинских терминов');
   { Заголовок пользовательского типа "Словарь медицинских терминов" }

// start class _DictionContainerUserTypes_

procedure _DictionContainerUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(slqtDictionName,
  str_slqtDictionCaption,
  str_slqtDictionCaption,
  true,
  60,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtDictionName
 with AddUsertype(slqtMedicDictionName,
  str_slqtMedicDictionCaption,
  str_slqtMedicDictionCaption,
  true,
  182,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(slqtMedicDictionName
end;

{$IfEnd} //not Admin AND not Monitorings

{$Else  DictionContainerUserTypes_imp_impl}
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_slqtDictionCaption
 str_slqtDictionCaption.Init;
// Инициализация str_slqtMedicDictionCaption
 str_slqtMedicDictionCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

{$EndIf DictionContainerUserTypes_imp_impl}
{$EndIf DictionContainerUserTypes_imp}
