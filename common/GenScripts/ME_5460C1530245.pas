unit destShapeInst;

// Модуль: "w:\common\components\rtl\Garant\dd\destShapeInst.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdestShapeInst" MUID: (5460C1530245)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddRTFdestination
 , ddRTFShape
 , ddRTFState
 , RTFtypes
 , l3Base
 , ddCustomRTFReader
;

type
 TdestShapeInst = class(TddRTFDestination)
  private
   f_ShapeLeft: Integer;
    {* Поле для свойства ShapeLeft }
   f_ShapeRight: Integer;
    {* Поле для свойства ShapeRight }
   f_ShapeTop: Integer;
    {* Поле для свойства ShapeTop }
   f_ShapeBottom: Integer;
    {* Поле для свойства ShapeBottom }
  protected
   procedure pm_SetShapeLeft(aValue: Integer);
   procedure pm_SetShapeRight(aValue: Integer);
   procedure pm_SetShapeTop(aValue: Integer);
   procedure pm_SetShapeBottom(aValue: Integer);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   function NeedImport: Boolean;
    {* Определят должен ли импортироваться текст из Shape. }
   procedure Apply2Shape(aShape: TddRTFShape);
   procedure Close(aState: TddRTFState;
    aNewDest: TddRTFDestination); override;
   procedure WriteText(aRDS: TRDS;
    aText: Tl3String;
    aState: TddRTFState); override;
   procedure Clear; override;
   procedure ApplyProperty(propType: TPropType;
    What: TIProp;
    Value: LongInt;
    aState: TddRTFState); override;
   constructor Create(aRTFReader: TddCustomRTFReader); override;
  public
   property ShapeLeft: Integer
    read f_ShapeLeft
    write pm_SetShapeLeft;
   property ShapeRight: Integer
    read f_ShapeRight
    write pm_SetShapeRight;
   property ShapeTop: Integer
    read f_ShapeTop
    write pm_SetShapeTop;
   property ShapeBottom: Integer
    read f_ShapeBottom
    write pm_SetShapeBottom;
 end;//TdestShapeInst

implementation

uses
 l3ImplUses
;

procedure TdestShapeInst.pm_SetShapeLeft(aValue: Integer);
//#UC START# *5460C19801F4_5460C1530245set_var*
//#UC END# *5460C19801F4_5460C1530245set_var*
begin
//#UC START# *5460C19801F4_5460C1530245set_impl*
 f_ShapeLeft := aValue;
//#UC END# *5460C19801F4_5460C1530245set_impl*
end;//TdestShapeInst.pm_SetShapeLeft

procedure TdestShapeInst.pm_SetShapeRight(aValue: Integer);
//#UC START# *5460C1AE0338_5460C1530245set_var*
//#UC END# *5460C1AE0338_5460C1530245set_var*
begin
//#UC START# *5460C1AE0338_5460C1530245set_impl*
 f_ShapeRight := aValue;
//#UC END# *5460C1AE0338_5460C1530245set_impl*
end;//TdestShapeInst.pm_SetShapeRight

procedure TdestShapeInst.pm_SetShapeTop(aValue: Integer);
//#UC START# *5461DF9D01EE_5460C1530245set_var*
//#UC END# *5461DF9D01EE_5460C1530245set_var*
begin
//#UC START# *5461DF9D01EE_5460C1530245set_impl*
 f_ShapeTop := aValue;
//#UC END# *5461DF9D01EE_5460C1530245set_impl*
end;//TdestShapeInst.pm_SetShapeTop

procedure TdestShapeInst.pm_SetShapeBottom(aValue: Integer);
//#UC START# *5461DFBC0268_5460C1530245set_var*
//#UC END# *5461DFBC0268_5460C1530245set_var*
begin
//#UC START# *5461DFBC0268_5460C1530245set_impl*
 f_ShapeBottom := aValue;
//#UC END# *5461DFBC0268_5460C1530245set_impl*
end;//TdestShapeInst.pm_SetShapeBottom

function TdestShapeInst.NeedImport: Boolean;
 {* Определят должен ли импортироваться текст из Shape. }
//#UC START# *5461BC83030F_5460C1530245_var*
const
 cnIgnoreShapeWidth = 100;
 cnIgnoreShapeLeft = 12000;
 cnIgnoreShapeHeight = 100;
//#UC END# *5461BC83030F_5460C1530245_var*
begin
//#UC START# *5461BC83030F_5460C1530245_impl*
 Result := ((f_ShapeRight - f_ShapeLeft) > cnIgnoreShapeWidth) and (f_ShapeLeft < cnIgnoreShapeLeft) and
           ((f_ShapeBottom > 0) or ((f_ShapeTop >= 0) or ((f_ShapeBottom - f_ShapeTop) > cnIgnoreShapeHeight)));
//#UC END# *5461BC83030F_5460C1530245_impl*
end;//TdestShapeInst.NeedImport

procedure TdestShapeInst.Apply2Shape(aShape: TddRTFShape);
//#UC START# *559CC7FE00EC_5460C1530245_var*
//#UC END# *559CC7FE00EC_5460C1530245_var*
begin
//#UC START# *559CC7FE00EC_5460C1530245_impl*
 aShape.Left := ShapeLeft;
 aShape.Top := ShapeTop;
 aShape.Right := ShapeRight;
 aShape.Bottom := ShapeBottom;
//#UC END# *559CC7FE00EC_5460C1530245_impl*
end;//TdestShapeInst.Apply2Shape

procedure TdestShapeInst.Close(aState: TddRTFState;
 aNewDest: TddRTFDestination);
//#UC START# *5461BEC2017D_5460C1530245_var*
//#UC END# *5461BEC2017D_5460C1530245_var*
begin
//#UC START# *5461BEC2017D_5460C1530245_impl*
//#UC END# *5461BEC2017D_5460C1530245_impl*
end;//TdestShapeInst.Close

procedure TdestShapeInst.WriteText(aRDS: TRDS;
 aText: Tl3String;
 aState: TddRTFState);
//#UC START# *54E1F08400F9_5460C1530245_var*
//#UC END# *54E1F08400F9_5460C1530245_var*
begin
//#UC START# *54E1F08400F9_5460C1530245_impl*
 Assert(False);
//#UC END# *54E1F08400F9_5460C1530245_impl*
end;//TdestShapeInst.WriteText

procedure TdestShapeInst.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5460C1530245_var*
//#UC END# *479731C50290_5460C1530245_var*
begin
//#UC START# *479731C50290_5460C1530245_impl*
 Clear;
 inherited Cleanup;
//#UC END# *479731C50290_5460C1530245_impl*
end;//TdestShapeInst.Cleanup

procedure TdestShapeInst.Clear;
//#UC START# *51D27A48038E_5460C1530245_var*
//#UC END# *51D27A48038E_5460C1530245_var*
begin
//#UC START# *51D27A48038E_5460C1530245_impl*
 f_ShapeLeft := -1;
 f_ShapeRight := -1;
 f_ShapeTop := -1;
 f_ShapeBottom := -1;
 inherited;
//#UC END# *51D27A48038E_5460C1530245_impl*
end;//TdestShapeInst.Clear

procedure TdestShapeInst.ApplyProperty(propType: TPropType;
 What: TIProp;
 Value: LongInt;
 aState: TddRTFState);
//#UC START# *51D27EC50388_5460C1530245_var*
const
 cnMinValue = Low(Integer) div 2;
//#UC END# *51D27EC50388_5460C1530245_var*
begin
//#UC START# *51D27EC50388_5460C1530245_impl*
 if propType = propShape then
 begin
  if cnMinValue > Value then
   Value := 0;
  case What of
   ipropLeft: ShapeLeft := Value;
   ipropRight: ShapeRight := Value;
   ipropTop: ShapeTop := Value;
   ipropBottom: ShapeBottom := Value;
  end;
 end;
//#UC END# *51D27EC50388_5460C1530245_impl*
end;//TdestShapeInst.ApplyProperty

constructor TdestShapeInst.Create(aRTFReader: TddCustomRTFReader);
//#UC START# *51E7C9DB0213_5460C1530245_var*
//#UC END# *51E7C9DB0213_5460C1530245_var*
begin
//#UC START# *51E7C9DB0213_5460C1530245_impl*
 inherited Create(aRTFReader);
 Clear;
//#UC END# *51E7C9DB0213_5460C1530245_impl*
end;//TdestShapeInst.Create

end.
