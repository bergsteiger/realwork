unit NOT_FINISHED_l3AsincMessageWindow;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Тучнин Д.А.
// Модуль: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3AsincMessageWindow.pas"
// Начат: 2005/03/30 09:16:59
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3AsincMessageWindow
//
// Вывод ассинхронного окна с сообщением в отдельной триаде
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
  ;

type
 Tl3AsincMessageWindow = class(TThread)
 protected
 // realized methods
   procedure Execute; override;
 end;//Tl3AsincMessageWindow

implementation

uses
  l3AsincMessageWindowRes
  ;

// start class Tl3AsincMessageWindow

procedure Tl3AsincMessageWindow.Execute;
//#UC START# *499D3BE0004D_4787FD4002B4_var*
//#UC END# *499D3BE0004D_4787FD4002B4_var*
begin
//#UC START# *499D3BE0004D_4787FD4002B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *499D3BE0004D_4787FD4002B4_impl*
end;//Tl3AsincMessageWindow.Execute

end.