unit l3FilerRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3FilerRes.pas"
// Начат: 18.10.2010 13:56
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3FilerRes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3StringIDEx
  ;

{$If not defined(Nemesis)}
var
  { Локализуемые строки Local }
 str_l3mmFileOp : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmFileOp'; rValue : 'Файловая операция');
  { 'Файловая операция' }
 str_l3mmFileOpFmt : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmFileOpFmt'; rValue : 'Файловая операция [%s]');
  { 'Файловая операция [%s]' }
{$IfEnd} //not Nemesis

{$If defined(Nemesis)}
var
  { Локализуемые строки LocalNemesis }
 str_l3mmFileOp : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmFileOp'; rValue : 'Загрузка документа');
  { 'Загрузка документа' }
 str_l3mmFileOpFmt : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmFileOpFmt'; rValue : 'Загрузка документа [%s]');
  { 'Загрузка документа [%s]' }
{$IfEnd} //Nemesis

implementation

uses
  l3MessageID
  ;


initialization
{$If not defined(Nemesis)}
// Инициализация str_l3mmFileOp
 str_l3mmFileOp.Init;
{$IfEnd} //not Nemesis
{$If not defined(Nemesis)}
// Инициализация str_l3mmFileOpFmt
 str_l3mmFileOpFmt.Init;
{$IfEnd} //not Nemesis
{$If defined(Nemesis)}
// Инициализация str_l3mmFileOp
 str_l3mmFileOp.Init;
{$IfEnd} //Nemesis
{$If defined(Nemesis)}
// Инициализация str_l3mmFileOpFmt
 str_l3mmFileOpFmt.Init;
{$IfEnd} //Nemesis

end.