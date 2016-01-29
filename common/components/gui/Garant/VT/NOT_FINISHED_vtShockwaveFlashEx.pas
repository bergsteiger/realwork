unit NOT_FINISHED_vtShockwaveFlashEx;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT"
// Автор: Морозов М.А.
// Модуль: "w:/common/components/gui/Garant/VT/NOT_FINISHED_vtShockwaveFlashEx.pas"
// Начат: 2005/09/29 10:12:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VT::Flash::TvtShockwaveFlashEx
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoFlash)}
type
 TvtShockwaveFlashEx = class
 end;//TvtShockwaveFlashEx
{$IfEnd} //not NoFlash

implementation

{$If not defined(NoFlash)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  vtFlashWordsPack
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoFlash

{$If not defined(NoFlash)}


{$IfEnd} //not NoFlash

initialization
{$If not defined(NoFlash) AND not defined(NoScripts)}
// Регистрация TvtShockwaveFlashEx
 TtfwClassRef.Register(TvtShockwaveFlashEx);
{$IfEnd} //not NoFlash AND not NoScripts

end.