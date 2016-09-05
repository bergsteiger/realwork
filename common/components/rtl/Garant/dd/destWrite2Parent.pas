unit destWrite2Parent;

// Модуль: "w:\common\components\rtl\Garant\dd\destWrite2Parent.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdestWrite2Parent" MUID: (54E3046A00AE)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , destSkip
 , ddRTFdestination
 , ddCustomRTFReader
 , RTFtypes
 , l3Base
 , ddRTFState
;

type
 TdestWrite2Parent = class(TdestSkip)
  private
   f_ParentDestination: TddRTFDestination;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aRTFReader: TddCustomRTFReader;
    aParent: TddRTFDestination); reintroduce;
   procedure WriteText(aRDS: TRDS;
    aText: Tl3String;
    aState: TddRTFState); override;
  public
   property ParentDestination: TddRTFDestination
    read f_ParentDestination;
 end;//TdestWrite2Parent

implementation

uses
 l3ImplUses
 //#UC START# *54E3046A00AEimpl_uses*
 //#UC END# *54E3046A00AEimpl_uses*
;

constructor TdestWrite2Parent.Create(aRTFReader: TddCustomRTFReader;
 aParent: TddRTFDestination);
//#UC START# *54E3055F033C_54E3046A00AE_var*
//#UC END# *54E3055F033C_54E3046A00AE_var*
begin
//#UC START# *54E3055F033C_54E3046A00AE_impl*
 inherited Create(aRTFReader);
 f_ParentDestination := aParent;
//#UC END# *54E3055F033C_54E3046A00AE_impl*
end;//TdestWrite2Parent.Create

procedure TdestWrite2Parent.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_54E3046A00AE_var*
//#UC END# *479731C50290_54E3046A00AE_var*
begin
//#UC START# *479731C50290_54E3046A00AE_impl*
 inherited;
 f_ParentDestination := nil;
//#UC END# *479731C50290_54E3046A00AE_impl*
end;//TdestWrite2Parent.Cleanup

procedure TdestWrite2Parent.WriteText(aRDS: TRDS;
 aText: Tl3String;
 aState: TddRTFState);
//#UC START# *54E1F08400F9_54E3046A00AE_var*
//#UC END# *54E1F08400F9_54E3046A00AE_var*
begin
//#UC START# *54E1F08400F9_54E3046A00AE_impl*
 f_ParentDestination.WriteText(RDS, aText, aState);
//#UC END# *54E1F08400F9_54E3046A00AE_impl*
end;//TdestWrite2Parent.WriteText

end.
