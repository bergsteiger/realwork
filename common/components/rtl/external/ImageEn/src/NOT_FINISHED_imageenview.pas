unit NOT_FINISHED_imageenview;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ImageEn"
// Модуль: "w:/common/components/rtl/external/ImageEn/src/NOT_FINISHED_imageenview.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::ImageEn::Source::imageenview
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

interface

{$If not defined(NoImageEn)}
type
 TImageEnView = class
 end;//TImageEnView
{$IfEnd} //not NoImageEn

implementation

{$If not defined(NoImageEn)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoImageEn) AND not defined(NoScripts)}
  ,
  ImageEnPack
  {$IfEnd} //not NoImageEn AND not NoScripts
  
  ;

{$IfEnd} //not NoImageEn

initialization
{$If not defined(NoImageEn) AND not defined(NoScripts)}
// Регистрация TImageEnView
 TtfwClassRef.Register(TImageEnView);
{$IfEnd} //not NoImageEn AND not NoScripts

end.