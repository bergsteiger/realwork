unit NOT_FINISHED_l3Filer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3Filer.pas"
// Начат: 08.04.1997 18:33
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3Filer
//
// Реализация компонента-обертки вокруг потока.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ProgressComponent
  ;

type
 Tl3CustomFiler = class(Tl3ProgressComponent)
  {* Реализация компонента-обертки вокруг потока. }
 protected
 // protected methods
   function DoOpen: Boolean; virtual;
   procedure DoClose; virtual;
     {* Сигнатура метода DoClose }
 end;//Tl3CustomFiler

 Tl3CustomDosFiler = class(Tl3CustomFiler)
 end;//Tl3CustomDosFiler

 Tl3NextTokenFlag = (
   
 );//Tl3NextTokenFlag

 Tl3DOSFiler = class(Tl3CustomDosFiler)
 end;//Tl3DOSFiler

implementation

uses
  l3FilerRes
  ;

// start class Tl3CustomFiler

function Tl3CustomFiler.DoOpen: Boolean;
//#UC START# *555C888301B0_47A0679D00E4_var*
//#UC END# *555C888301B0_47A0679D00E4_var*
begin
//#UC START# *555C888301B0_47A0679D00E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *555C888301B0_47A0679D00E4_impl*
end;//Tl3CustomFiler.DoOpen

procedure Tl3CustomFiler.DoClose;
//#UC START# *555C88B703E7_47A0679D00E4_var*
//#UC END# *555C88B703E7_47A0679D00E4_var*
begin
//#UC START# *555C88B703E7_47A0679D00E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *555C88B703E7_47A0679D00E4_impl*
end;//Tl3CustomFiler.DoClose
end.