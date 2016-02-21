unit destShapeTxt;

// Модуль: "w:\common\components\rtl\Garant\dd\destShapeTxt.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , destNorm
 , ddRTFState
 , ddRTFShape
;

type
 TdestShapeTxt = class(TdestNorm)
  protected
   function CanAddTable: Boolean; override;
  public
   procedure Apply2Shape(aState: TddRTFState;
    aShape: TddRTFShape);
   procedure Clear; override;
 end;//TdestShapeTxt

implementation

uses
 l3ImplUses
;

procedure TdestShapeTxt.Apply2Shape(aState: TddRTFState;
 aShape: TddRTFShape);
//#UC START# *559CC89A011D_5461C20002DF_var*
//#UC END# *559CC89A011D_5461C20002DF_var*
begin
//#UC START# *559CC89A011D_5461C20002DF_impl*
 aShape.Append(aState, Self);
 Clear;
//#UC END# *559CC89A011D_5461C20002DF_impl*
end;//TdestShapeTxt.Apply2Shape

procedure TdestShapeTxt.Clear;
//#UC START# *51D27A48038E_5461C20002DF_var*
//#UC END# *51D27A48038E_5461C20002DF_var*
begin
//#UC START# *51D27A48038E_5461C20002DF_impl*
 ParagraphsClear;
 inherited;
//#UC END# *51D27A48038E_5461C20002DF_impl*
end;//TdestShapeTxt.Clear

function TdestShapeTxt.CanAddTable: Boolean;
//#UC START# *559516AA0098_5461C20002DF_var*
//#UC END# *559516AA0098_5461C20002DF_var*
begin
//#UC START# *559516AA0098_5461C20002DF_impl*
 Result := True;
//#UC END# *559516AA0098_5461C20002DF_impl*
end;//TdestShapeTxt.CanAddTable

end.
