unit destShp;

// Модуль: "w:\common\components\rtl\Garant\dd\destShp.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdestShp" MUID: (5461CBCB01F3)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddRTFdestination
 , destShapeTxt
 , destShapeInst
 , destNorm
 , destShapeRslt
 , ddRTFState
 , RTFtypes
 , l3Base
;

type
 TdestShp = class(TddRTFDestination)
  private
   f_ShapeTxt: TdestShapeTxt;
   f_ShapeInst: TdestShapeInst;
   f_Norm: TdestNorm;
   f_ShapeRslt: TdestShapeRslt;
  protected
   procedure pm_SetShapeTxt(aValue: TdestShapeTxt);
   procedure pm_SetShapeInst(aValue: TdestShapeInst);
   procedure pm_SetShapeRslt(aValue: TdestShapeRslt);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure Close(aState: TddRTFState;
    aNewDest: TddRTFDestination); override;
   procedure WriteText(aRDS: TRDS;
    aText: Tl3String;
    aState: TddRTFState); override;
   procedure Clear; override;
  public
   property ShapeTxt: TdestShapeTxt
    read f_ShapeTxt
    write pm_SetShapeTxt;
   property ShapeInst: TdestShapeInst
    read f_ShapeInst
    write pm_SetShapeInst;
   property Norm: TdestNorm
    read f_Norm
    write f_Norm;
   property ShapeRslt: TdestShapeRslt
    read f_ShapeRslt
    write pm_SetShapeRslt;
 end;//TdestShp

implementation

uses
 l3ImplUses
 , ddRTFShape
 , ddPicture
 , SysUtils
 //#UC START# *5461CBCB01F3impl_uses*
 //#UC END# *5461CBCB01F3impl_uses*
;

procedure TdestShp.pm_SetShapeTxt(aValue: TdestShapeTxt);
//#UC START# *5461CC6202E0_5461CBCB01F3set_var*
//#UC END# *5461CC6202E0_5461CBCB01F3set_var*
begin
//#UC START# *5461CC6202E0_5461CBCB01F3set_impl*
 f_ShapeTxt := aValue;
//#UC END# *5461CC6202E0_5461CBCB01F3set_impl*
end;//TdestShp.pm_SetShapeTxt

procedure TdestShp.pm_SetShapeInst(aValue: TdestShapeInst);
//#UC START# *5461CC9100A1_5461CBCB01F3set_var*
//#UC END# *5461CC9100A1_5461CBCB01F3set_var*
begin
//#UC START# *5461CC9100A1_5461CBCB01F3set_impl*
 f_ShapeInst := aValue;
//#UC END# *5461CC9100A1_5461CBCB01F3set_impl*
end;//TdestShp.pm_SetShapeInst

procedure TdestShp.pm_SetShapeRslt(aValue: TdestShapeRslt);
//#UC START# *557579970327_5461CBCB01F3set_var*
//#UC END# *557579970327_5461CBCB01F3set_var*
begin
//#UC START# *557579970327_5461CBCB01F3set_impl*
 f_ShapeRslt := aValue;
//#UC END# *557579970327_5461CBCB01F3set_impl*
end;//TdestShp.pm_SetShapeRslt

procedure TdestShp.Close(aState: TddRTFState;
 aNewDest: TddRTFDestination);
//#UC START# *5461BEC2017D_5461CBCB01F3_var*
var
 l_Shape: TddRTFShape;
//#UC END# *5461BEC2017D_5461CBCB01F3_var*
begin
//#UC START# *5461BEC2017D_5461CBCB01F3_impl*
 if (f_ShapeInst = nil) then
 begin
  if f_ShapeTxt <> nil then
   f_ShapeTxt.Close(aState, f_Norm);
 end // if (f_ShapeInst = nil) then
 else
  if f_ShapeInst.NeedImport then
  begin
   l_Shape := TddRTFShape.Create(Self);
   try
    f_ShapeInst.Apply2Shape(l_Shape);
    if f_ShapeTxt <> nil then
     f_ShapeTxt.Apply2Shape(aState, l_Shape);
    if f_ShapeRslt <> nil then
     f_ShapeRslt.Apply2Shape(aState, l_Shape);
    f_Norm.AddShape(aState, l_Shape);
    l_Shape.Closed := True;
   finally
    FreeAndNil(l_Shape);
   end;
  end // if f_ShapeInst.NeedImport then
  else
  begin
   if f_ShapeTxt <> nil then
    f_ShapeTxt.Clear;
   if f_ShapeRslt <> nil then
    f_ShapeRslt.Clear;
  end;
//#UC END# *5461BEC2017D_5461CBCB01F3_impl*
end;//TdestShp.Close

procedure TdestShp.WriteText(aRDS: TRDS;
 aText: Tl3String;
 aState: TddRTFState);
//#UC START# *54E1F08400F9_5461CBCB01F3_var*
//#UC END# *54E1F08400F9_5461CBCB01F3_var*
begin
//#UC START# *54E1F08400F9_5461CBCB01F3_impl*
 Assert(False);
//#UC END# *54E1F08400F9_5461CBCB01F3_impl*
end;//TdestShp.WriteText

procedure TdestShp.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5461CBCB01F3_var*
//#UC END# *479731C50290_5461CBCB01F3_var*
begin
//#UC START# *479731C50290_5461CBCB01F3_impl*
 Clear;
 inherited;
//#UC END# *479731C50290_5461CBCB01F3_impl*
end;//TdestShp.Cleanup

procedure TdestShp.Clear;
//#UC START# *51D27A48038E_5461CBCB01F3_var*
//#UC END# *51D27A48038E_5461CBCB01F3_var*
begin
//#UC START# *51D27A48038E_5461CBCB01F3_impl*
 f_ShapeInst := nil;
 f_ShapeTxt := nil;
 f_ShapeRslt := nil;
//#UC END# *51D27A48038E_5461CBCB01F3_impl*
end;//TdestShp.Clear

end.
