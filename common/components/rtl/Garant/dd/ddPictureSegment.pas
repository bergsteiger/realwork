unit ddPictureSegment;

// Модуль: "w:\common\components\rtl\Garant\dd\ddPictureSegment.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddPictureSegment" MUID: (54D9ACA500F5)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddObjectSegment
 , ddTextSegment
;

type
 TddPictureSegment = class(TddObjectSegment)
  public
   function Clone: TddTextSegment; override;
 end;//TddPictureSegment

implementation

uses
 l3ImplUses
 //#UC START# *54D9ACA500F5impl_uses*
 //#UC END# *54D9ACA500F5impl_uses*
;

function TddPictureSegment.Clone: TddTextSegment;
//#UC START# *54DC46B50110_54D9ACA500F5_var*
//#UC END# *54DC46B50110_54D9ACA500F5_var*
begin
//#UC START# *54DC46B50110_54D9ACA500F5_impl*
 Result := TddPictureSegment.Create;
 Result.Assign(Self);
//#UC END# *54DC46B50110_54D9ACA500F5_impl*
end;//TddPictureSegment.Clone

end.
