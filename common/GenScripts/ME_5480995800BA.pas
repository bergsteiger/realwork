unit evSubPanelTools;

// Модуль: "w:\common\components\gui\Garant\Everest\evSubPanelTools.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evSubPanelTools" MUID: (5480995800BA)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , Windows
 , l3Units
;

procedure evInvalidateRect(H: THandle;
 const R: Tl3Rect);

implementation

uses
 l3ImplUses
 , nevFacade
;

procedure evInvalidateRect(H: THandle;
 const R: Tl3Rect);
//#UC START# *4B87BB100265_5480995800BA_var*
//#UC END# *4B87BB100265_5480995800BA_var*
begin
//#UC START# *4B87BB100265_5480995800BA_impl*
  nev.CrtIC.LR2DR(R).Invalidate(H, False);
//#UC END# *4B87BB100265_5480995800BA_impl*
end;//evInvalidateRect

end.
