unit tfwKConst;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DUnitTuning"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/DUnitTuning/tfwKConst.pas"
// Начат: 14.06.2011 21:36
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi Testing Framework::DUnitTuning::tfwKConst
//
// Константы для общения тестового фреймфорка с К
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DUnitTuning\tfwDefine.inc}

interface

{$If defined(nsTest) AND not defined(NotTunedDUnit)}
{$If defined(Archi) AND defined(nsTest) AND not defined(NotTunedDUnit)}
const
  { Archi }
 KUser = 'architester';
 KUserPassword = '6v2K3024';
{$IfEnd} //Archi AND nsTest AND not NotTunedDUnit

{$If defined(InsiderTest) AND defined(Nemesis) AND defined(nsTest) AND not defined(NotTunedDUnit)}
const
  { Nemesis }
 KUser = 'f1tester';
 KUserPassword = 'f1_tester_user';
{$IfEnd} //InsiderTest AND Nemesis AND nsTest AND not NotTunedDUnit

{$If defined(nsTest) AND not defined(Archi) AND not defined(EverestLite) AND not defined(Nemesis) AND not defined(NotTunedDUnit)}
const
  { Other }
 KUser = '';
 KUserPassword = '';
{$IfEnd} //nsTest AND not Archi AND not EverestLite AND not Nemesis AND not NotTunedDUnit

{$If defined(Nemesis) AND defined(nsTest) AND not defined(InsiderTest) AND not defined(NotTunedDUnit)}
const
  { Daily }
 KUser = 'shdtester';
 KUserPassword = 'shdtester';
{$IfEnd} //Nemesis AND nsTest AND not InsiderTest AND not NotTunedDUnit

{$If defined(EverestLite) AND defined(nsTest) AND not defined(NotTunedDUnit)}
const
  { EverestLite }
 KUser = 'architester';
 KUserPassword = '6v2K3024';
{$IfEnd} //EverestLite AND nsTest AND not NotTunedDUnit
{$IfEnd} //nsTest AND not NotTunedDUnit

implementation

end.