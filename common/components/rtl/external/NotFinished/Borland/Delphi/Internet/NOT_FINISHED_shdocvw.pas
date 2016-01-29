unit NOT_FINISHED_shdocvw;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Internet"
// Модуль: "w:/common/components/rtl/external/NotFinished/Borland/Delphi/Internet/NOT_FINISHED_shdocvw.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Core::Internet::Web::shdocvw
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

interface

uses
  Classes
  {$If not defined(NoVCL)}
  ,
  OleCtrls
  {$IfEnd} //not NoVCL
  
  ;

type
 TWebBrowser = class(TOleControl)
 end;//TWebBrowser

implementation

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;


initialization
{$If not defined(NoScripts)}
// Регистрация TWebBrowser
 TtfwClassRef.Register(TWebBrowser);
{$IfEnd} //not NoScripts

end.