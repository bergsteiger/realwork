unit NOT_FINISHED_tb97GraphicControl;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "tb97"
// Модуль: "w:/common/components/rtl/external/tb97/NOT_FINISHED_tb97GraphicControl.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::tb97::tb97utils::Ttb97GraphicControl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\tb97\TB97VER.INC}

interface

{$If not defined(NoTB97)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  l3PureMixIns
  ;
{$IfEnd} //not NoTB97

{$If not defined(NoTB97)}
type
 _l3Unknown_Parent_ = TGraphicControl;
{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 Ttb97CustomGraphicControl = class(_l3Unknown_)
 end;//Ttb97CustomGraphicControl

 Ttb97GraphicTextControl = class(Ttb97GraphicControl)
 end;//Ttb97GraphicTextControl

 Ttb97GraphicControl = class(Ttb97CustomGraphicControl)
 end;//Ttb97GraphicControl
{$IfEnd} //not NoTB97

implementation

{$If not defined(NoTB97)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base,
  l3Core,
  Windows,
  l3MemUtils,
  l3Interlocked
  ;
{$IfEnd} //not NoTB97

{$If not defined(NoTB97)}

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}


{$IfEnd} //not NoTB97

initialization
{$If not defined(NoScripts) AND not defined(NoTB97)}
// Регистрация Ttb97CustomGraphicControl
 TtfwClassRef.Register(Ttb97CustomGraphicControl);
{$IfEnd} //not NoScripts AND not NoTB97
{$If not defined(NoScripts) AND not defined(NoTB97)}
// Регистрация Ttb97GraphicTextControl
 TtfwClassRef.Register(Ttb97GraphicTextControl);
{$IfEnd} //not NoScripts AND not NoTB97
{$If not defined(NoScripts) AND not defined(NoTB97)}
// Регистрация Ttb97GraphicControl
 TtfwClassRef.Register(Ttb97GraphicControl);
{$IfEnd} //not NoScripts AND not NoTB97

end.