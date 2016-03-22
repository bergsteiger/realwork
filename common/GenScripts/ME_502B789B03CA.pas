unit evTextInTableCorrector;
 {* Вычищает всякую "кривизну" из текста в таблицах: стиль "обычный", отрицательные отступы, рамки вокруг текста. }

// Модуль: "w:\common\components\gui\Garant\Everest\evTextInTableCorrector.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevTextInTableCorrector" MUID: (502B789B03CA)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , k2TagFilter
 , k2Base
 , l3Variant
;

type
 TevTextInTableCorrector = class(Tk2TagFilter)
  {* Вычищает всякую "кривизну" из текста в таблицах: стиль "обычный", отрицательные отступы, рамки вокруг текста. }
  private
   f_WasStyle: Boolean;
  private
   function InCell: Boolean;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure DoStartChild(TypeID: Tk2Type); override;
   procedure DoAddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
   procedure DoCloseStructure(NeedUndo: Boolean); override;
 end;//TevTextInTableCorrector

implementation

uses
 l3ImplUses
 , TableCell_Const
 , TextPara_Const
 , k2Tags
 , evdStyles
 , Document_Const
;

function TevTextInTableCorrector.InCell: Boolean;
//#UC START# *539003570066_502B789B03CA_var*
//#UC END# *539003570066_502B789B03CA_var*
begin
//#UC START# *539003570066_502B789B03CA_impl*
 Result := CurrentType.IsKindOf(k2_typTextPara) and TopType[1].IsKindOf(k2_typTableCell);
//#UC END# *539003570066_502B789B03CA_impl*
end;//TevTextInTableCorrector.InCell

procedure TevTextInTableCorrector.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_502B789B03CA_var*
//#UC END# *479731C50290_502B789B03CA_var*
begin
//#UC START# *479731C50290_502B789B03CA_impl*
 f_WasStyle := False;
 inherited;
//#UC END# *479731C50290_502B789B03CA_impl*
end;//TevTextInTableCorrector.Cleanup

procedure TevTextInTableCorrector.InitFields;
//#UC START# *47A042E100E2_502B789B03CA_var*
//#UC END# *47A042E100E2_502B789B03CA_var*
begin
//#UC START# *47A042E100E2_502B789B03CA_impl*
 inherited;
 f_WasStyle := False;
//#UC END# *47A042E100E2_502B789B03CA_impl*
end;//TevTextInTableCorrector.InitFields

procedure TevTextInTableCorrector.DoStartChild(TypeID: Tk2Type);
//#UC START# *4A2D1217037A_502B789B03CA_var*
//#UC END# *4A2D1217037A_502B789B03CA_var*
begin
//#UC START# *4A2D1217037A_502B789B03CA_impl*
 if InCell then
  f_WasStyle := False;
 inherited DoStartChild(TypeID);
//#UC END# *4A2D1217037A_502B789B03CA_impl*
end;//TevTextInTableCorrector.DoStartChild

procedure TevTextInTableCorrector.DoAddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4A2D1634025B_502B789B03CA_var*
const cnMaxIndent = 1000;
//#UC END# *4A2D1634025B_502B789B03CA_var*
begin
//#UC START# *4A2D1634025B_502B789B03CA_impl*
 if InCell then
  case AtomIndex of
   k2_tiFrame: Exit;
   k2_tiStyle: if (Value.AsInteger = ev_saTxtNormalANSI) then
               begin
                f_WasStyle := True;
                AddIntegerAtom(AtomIndex, ev_saNormalTable);
                Exit;
               end // if Value.AsInteger = ev_saTxtNormalANSI then
               else
                f_WasStyle := True;
   k2_tiLeftIndent: if Value.AsInteger < 0 then Exit;
  end;
 if (AtomIndex = k2_tiFrame) and CurrentType.IsKindOf(k2_typDocument) then Exit;
 if (AtomIndex = k2_tiRightIndent) and (Abs(Value.AsInteger) > cnMaxIndent) then Exit;
 inherited;
//#UC END# *4A2D1634025B_502B789B03CA_impl*
end;//TevTextInTableCorrector.DoAddAtomEx

procedure TevTextInTableCorrector.DoCloseStructure(NeedUndo: Boolean);
//#UC START# *4E45166B0156_502B789B03CA_var*
//#UC END# *4E45166B0156_502B789B03CA_var*
begin
//#UC START# *4E45166B0156_502B789B03CA_impl*
 if InCell then
  if not f_WasStyle then
   Generator.AddIntegerAtom(k2_tiStyle, ev_saNormalTable);
 inherited;
//#UC END# *4E45166B0156_502B789B03CA_impl*
end;//TevTextInTableCorrector.DoCloseStructure

end.
