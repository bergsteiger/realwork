unit destSkip;

// Модуль: "w:\common\components\rtl\Garant\dd\destSkip.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdestSkip" MUID: (5461C67A0207)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddRTFdestination
 , ddRTFState
 , RTFtypes
 , l3Base
;

type
 TdestSkip = class(TddRTFDestination)
  public
   procedure Close(aState: TddRTFState;
    aNewDest: TddRTFDestination); override;
   procedure WriteText(aRDS: TRDS;
    aText: Tl3String;
    aState: TddRTFState); override;
 end;//TdestSkip

implementation

uses
 l3ImplUses
 //#UC START# *5461C67A0207impl_uses*
 //#UC END# *5461C67A0207impl_uses*
;

procedure TdestSkip.Close(aState: TddRTFState;
 aNewDest: TddRTFDestination);
//#UC START# *5461BEC2017D_5461C67A0207_var*
//#UC END# *5461BEC2017D_5461C67A0207_var*
begin
//#UC START# *5461BEC2017D_5461C67A0207_impl*
//#UC END# *5461BEC2017D_5461C67A0207_impl*
end;//TdestSkip.Close

procedure TdestSkip.WriteText(aRDS: TRDS;
 aText: Tl3String;
 aState: TddRTFState);
//#UC START# *54E1F08400F9_5461C67A0207_var*
//#UC END# *54E1F08400F9_5461C67A0207_var*
begin
//#UC START# *54E1F08400F9_5461C67A0207_impl*
 Assert(False);
//#UC END# *54E1F08400F9_5461C67A0207_impl*
end;//TdestSkip.WriteText

end.
