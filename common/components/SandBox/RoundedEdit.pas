unit RoundedEdit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "SandBox"
// Модуль: "RoundedEdit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: GuiControl::Class Shared Delphi Sand Box::SandBox::Rounded::TRoundedEdit
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\SandBox\sbDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCL)}
  ,
  StdCtrls
  {$IfEnd} //not NoVCL
  ,
  Messages,
  l3Region,
  Controls {a}
  ;

type
 _RefCounted_Parent_ = TEdit;
 {$Include w:\common\components\rtl\Garant\L3\RefCounted.imp.pas}
 _RoundedControl_Parent_ = _RefCounted_;
 {$Include ..\SandBox\RoundedControl.imp.pas}
 TRoundedEdit = class(_RoundedControl_)
 end;//TRoundedEdit

implementation

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  Windows
  {$If not defined(NoVCL)}
  ,
  Themes
  {$IfEnd} //not NoVCL
  
  ;

{$Include w:\common\components\rtl\Garant\L3\RefCounted.imp.pas}

{$Include ..\SandBox\RoundedControl.imp.pas}


initialization
{$If not defined(NoScripts)}
// Регистрация TRoundedEdit
 TtfwClassRef.Register(TRoundedEdit);
{$IfEnd} //not NoScripts

end.