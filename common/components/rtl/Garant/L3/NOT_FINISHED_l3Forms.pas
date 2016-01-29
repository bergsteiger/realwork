unit NOT_FINISHED_l3Forms;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3$Visual"
// Модуль: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3Forms.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3$Visual::VCL::l3Forms
//
// Базовый класс форм, поддерживающих счетчик ссылок и интерфейс IUnknown
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\L3\l3Define.inc}

interface

uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3PureMixIns,
  l3IID,
  l3Interfaces
  ;

type
 _l3Unknown_Parent_ = TForm;
 {$Include ..\L3\l3Unknown.imp.pas}
 _l3COMQueryInterface_Parent_ = _l3Unknown_;
 {$Include ..\L3\l3COMQueryInterface.imp.pas}
 Tl3Form = class(_l3COMQueryInterface_)
  {* Базовый класс форм, поддерживающих счетчик ссылок и интерфейс IUnknown }
 end;//Tl3Form

implementation

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
  l3Interlocked,
  l3InterfacesMisc
  ;

{$Include ..\L3\l3Unknown.imp.pas}

{$Include ..\L3\l3COMQueryInterface.imp.pas}


initialization
{$If not defined(NoScripts)}
// Регистрация Tl3Form
 TtfwClassRef.Register(Tl3Form);
{$IfEnd} //not NoScripts

end.