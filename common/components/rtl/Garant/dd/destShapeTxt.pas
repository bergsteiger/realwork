unit destShapeTxt;

// Модуль: "w:\common\components\rtl\Garant\dd\destShapeTxt.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdestShapeTxt" MUID: (5461C20002DF)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , destNorm
 , ddRTFState
 , ddRTFShape
 , ddTextParagraph
 , ddParagraphProperty
;

type
 TdestShapeTxt = class(TdestNorm)
  protected
   function CanAddTable: Boolean; override;
   function Try2AddShapeWithTextPara(aPAP: TddParagraphProperty): TddTextParagraph; override;
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

function TdestShapeTxt.Try2AddShapeWithTextPara(aPAP: TddParagraphProperty): TddTextParagraph;
//#UC START# *573427280365_5461C20002DF_var*
//#UC END# *573427280365_5461C20002DF_var*
begin
//#UC START# *573427280365_5461C20002DF_impl*
 Result := InternalAddTextPara(aPAP);
//#UC END# *573427280365_5461C20002DF_impl*
end;//TdestShapeTxt.Try2AddShapeWithTextPara

end.
