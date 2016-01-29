unit WarningConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/WarningConst.pas"
// Начат: 18.04.2011 17:31
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Core::Base Operations::View::Common::WarningConst
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3StringIDEx
  ;

var
  { Локализуемые строки WarningConst }
 str_wgJurorCommentHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgJurorCommentHint'; rValue : 'Документ с комментариями юристов');
  { 'Документ с комментариями юристов' }
 str_wgTimeMachineOffHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgTimeMachineOffHint'; rValue : 'Машина времени будет выключена, а текст документа будет представлен в актуальной редакции');
  { 'Машина времени будет выключена, а текст документа будет представлен в актуальной редакции' }
 str_wgNotShureWarningHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgNotShureWarningHint'; rValue : 'Период действия данной редакции документа не может быть определен однозначно');
  { 'Период действия данной редакции документа не может быть определен однозначно' }
 str_wgReferenceHint : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'wgReferenceHint'; rValue : 'Ссылка на справку к документу');
  { 'Ссылка на справку к документу' }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3MessageID
  ;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_wgJurorCommentHint
 str_wgJurorCommentHint.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_wgTimeMachineOffHint
 str_wgTimeMachineOffHint.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_wgNotShureWarningHint
 str_wgNotShureWarningHint.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_wgReferenceHint
 str_wgReferenceHint.Init;
{$IfEnd} //not Admin AND not Monitorings

end.