unit k2TagByHandleView;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2TagByHandleView.pas"
// Начат: 09.08.2011 17:17
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::TagViews::Tk2TagByHandleView
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2CustomTagView,
  l3PureMixIns
  ;

type
 Tk2TagByHandleView = class(Tk2CustomTagView)
 protected
 // realized methods
   function CompareData(const anItem1: _ItemType_;
     const anItem2: _ItemType_): Integer; override;
 end;//Tk2TagByHandleView

implementation

uses
  k2Tags
  ;

// start class Tk2TagByHandleView

function Tk2TagByHandleView.CompareData(const anItem1: _ItemType_;
  const anItem2: _ItemType_): Integer;
//#UC START# *4DEFB2D90167_4DF0C6BE0166_var*
//#UC END# *4DEFB2D90167_4DF0C6BE0166_var*
begin
//#UC START# *4DEFB2D90167_4DF0C6BE0166_impl*
 Result := anItem1.IntA[k2_tiHandle] - anItem2.IntA[k2_tiHandle];
//#UC END# *4DEFB2D90167_4DF0C6BE0166_impl*
end;//Tk2TagByHandleView.CompareData

end.