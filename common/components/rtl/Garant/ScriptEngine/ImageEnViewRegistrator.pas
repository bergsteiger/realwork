unit ImageEnViewRegistrator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$ImageEn"
// Модуль: "ImageEnViewRegistrator.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi::ScriptEngine$ImageEn::ImageEnView::TImageEnViewRegistrator
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoImageEn) AND not defined(NoScripts)}
uses
  imageenview
  ;
{$IfEnd} //not NoImageEn AND not NoScripts

{$If not defined(NoImageEn) AND not defined(NoScripts)}
type
 TImageEnViewRegistrator = {abstract} class(TImageEnView)
 end;//TImageEnViewRegistrator
{$IfEnd} //not NoImageEn AND not NoScripts

implementation

{$If not defined(NoImageEn) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy
  ;
{$IfEnd} //not NoImageEn AND not NoScripts

{$If not defined(NoImageEn) AND not defined(NoScripts)}


{$IfEnd} //not NoImageEn AND not NoScripts

initialization
{$If not defined(NoImageEn) AND not defined(NoScripts)}
// Регистрация TImageEnViewRegistrator
 TtfwClassRef.Register(TImageEnViewRegistrator);
{$IfEnd} //not NoImageEn AND not NoScripts

end.