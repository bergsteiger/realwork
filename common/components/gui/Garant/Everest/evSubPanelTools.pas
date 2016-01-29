unit evSubPanelTools;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evSubPanelTools.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::SubPanel::evSubPanelTools
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3Units,
  Windows
  ;

procedure EvInvalidateRect(H: THandle;
  const R: Tl3Rect);

implementation

uses
  nevFacade
  ;

// unit methods

procedure EvInvalidateRect(H: THandle;
  const R: Tl3Rect);
//#UC START# *4B87BB100265_5480995800BA_var*
//#UC END# *4B87BB100265_5480995800BA_var*
begin
//#UC START# *4B87BB100265_5480995800BA_impl*
  nev.CrtIC.LR2DR(R).Invalidate(H, False);
//#UC END# *4B87BB100265_5480995800BA_impl*
end;//EvInvalidateRect

end.