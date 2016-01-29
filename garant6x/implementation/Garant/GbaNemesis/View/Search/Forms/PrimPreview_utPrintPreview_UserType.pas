unit PrimPreview_utPrintPreview_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimPreview_utPrintPreview_UserType.pas"
// Начат: 15.09.2009 14:41
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimPreview::utPrintPreview
//
// Предварительный просмотр печати
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
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
  
  ;

const
   { Константы для типа формы utPrintPreview }
  utPrintPreviewName = 'utPrintPreview';
   { Строковый идентификатор пользовательского типа "Предварительный просмотр печати" }
  utPrintPreview = TvcmUserType(0);
   { Предварительный просмотр печати }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utPrintPreview = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы utPrintPreview }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utPrintPreview
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utPrintPreview

class function Tkw_FormUserType_utPrintPreview.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::utPrintPreview';
end;//Tkw_FormUserType_utPrintPreview.GetWordNameForRegister

function Tkw_FormUserType_utPrintPreview.GetInteger: Integer;
 {-}
begin
 Result := utPrintPreview;
end;//Tkw_FormUserType_utPrintPreview.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_utPrintPreview
 Tkw_FormUserType_utPrintPreview.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.