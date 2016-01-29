{$IfNDef AttributesUserTypes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/AttributesUserTypes.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Core::Base Operations::View::Base Forms::AttributesUserTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define AttributesUserTypes_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 _AttributesUserTypes_ = {abstract form} class(_AttributesUserTypes_Parent_)
 protected
  procedure MakeControls; override;
 protected
 // protected methods
   procedure FDocAttributeQueryClose(aSender: TObject); virtual; abstract;
     {* Обработчик события fDocAttribute.OnQueryClose }
 end;//_AttributesUserTypes_
{$Else}

 _AttributesUserTypes_ = _AttributesUserTypes_Parent_;

{$IfEnd} //not Admin AND not Monitorings

{$Else AttributesUserTypes_imp}

{$IfNDef AttributesUserTypes_imp_impl}
{$Define AttributesUserTypes_imp_impl}

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки fDocAttributeLocalConstants }
  str_fDocAttributeCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fDocAttributeCaption'; rValue : 'Информация о документе');
   { Заголовок пользовательского типа "Информация о документе" }

var
   { Локализуемые строки fAttributeSynchroViewLocalConstants }
  str_fAttributeSynchroViewCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'fAttributeSynchroViewCaption'; rValue : 'Информация о документе (синхронный просмотр)');
   { Заголовок пользовательского типа "Информация о документе (синхронный просмотр)" }

// start class _AttributesUserTypes_

procedure _AttributesUserTypes_.MakeControls;
begin
 inherited;
 with AddUsertype(fDocAttributeName,
  str_fDocAttributeCaption,
  str_fDocAttributeCaption,
  false,
  19,
  20,
  '',
  nil,
  nil,
  FDocAttributeQueryClose,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(fDocAttributeName
 with AddUsertype(fAttributeSynchroViewName,
  str_fAttributeSynchroViewCaption,
  str_fAttributeSynchroViewCaption,
  false,
  19,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(fAttributeSynchroViewName
end;

{$IfEnd} //not Admin AND not Monitorings

{$Else  AttributesUserTypes_imp_impl}
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_fDocAttributeCaption
 str_fDocAttributeCaption.Init;
// Инициализация str_fAttributeSynchroViewCaption
 str_fAttributeSynchroViewCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

{$EndIf AttributesUserTypes_imp_impl}
{$EndIf AttributesUserTypes_imp}
