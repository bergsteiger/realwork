unit evTabStopsFilter;

// Модуль: "w:\common\components\gui\Garant\Everest\evTabStopsFilter.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evdBufferedFilter
 , l3Variant
 , k2Base
 , k2Interfaces
;

type
 _DigitalSeparatorSupport_Parent_ = TevdBufferedFilter;
 {$Include w:\common\components\gui\Garant\Everest\DigitalSeparatorSupport.imp.pas}
 TevTabStopsFilter = class(_DigitalSeparatorSupport_)
  protected
   procedure AddAtomEx(AtomIndex: Integer;
    const Value: Ik2Variant); override;
   procedure DoStartChild(TypeID: Tk2Type); override;
   function NeedStartBuffering(aID: Integer): Boolean; override;
   function NeedFlushBuffer(aLeaf: Tl3Variant;
    aTagId: Integer): Boolean; override;
   procedure DoCloseStructure(NeedUndo: Boolean); override;
 end;//TevTabStopsFilter

implementation

uses
 l3ImplUses
 , TabStop_Const
 , TextPara_Const
 , k2Tags
 , l3Interfaces
 , TableCell_Const
 , Table_Const
 , l3String
;

{$Include w:\common\components\gui\Garant\Everest\DigitalSeparatorSupport.imp.pas}

procedure TevTabStopsFilter.AddAtomEx(AtomIndex: Integer;
 const Value: Ik2Variant);
//#UC START# *4836D52400D9_4E5E1032016E_var*
//#UC END# *4836D52400D9_4E5E1032016E_var*
begin
//#UC START# *4836D52400D9_4E5E1032016E_impl*
 if CurrentType.IsKindOf(k2_typTabStop) then
  SetDigitalSeparatorParams(AtomIndex, Value);
 inherited;
//#UC END# *4836D52400D9_4E5E1032016E_impl*
end;//TevTabStopsFilter.AddAtomEx

procedure TevTabStopsFilter.DoStartChild(TypeID: Tk2Type);
//#UC START# *4A2D1217037A_4E5E1032016E_var*
//#UC END# *4A2D1217037A_4E5E1032016E_var*
begin
//#UC START# *4A2D1217037A_4E5E1032016E_impl*
 if (TypeID = k2_typTable) then
  CellFinished;
 if (TypeID = k2_typTableCell) then
  CellStarted;
 inherited; 
//#UC END# *4A2D1217037A_4E5E1032016E_impl*
end;//TevTabStopsFilter.DoStartChild

function TevTabStopsFilter.NeedStartBuffering(aID: Integer): Boolean;
//#UC START# *4C56D54B002A_4E5E1032016E_var*
//#UC END# *4C56D54B002A_4E5E1032016E_var*
begin
//#UC START# *4C56D54B002A_4E5E1032016E_impl*
 Result := aID = k2_tiTabstops;
//#UC END# *4C56D54B002A_4E5E1032016E_impl*
end;//TevTabStopsFilter.NeedStartBuffering

function TevTabStopsFilter.NeedFlushBuffer(aLeaf: Tl3Variant;
 aTagId: Integer): Boolean;
//#UC START# *4CF7BC520161_4E5E1032016E_var*
//#UC END# *4CF7BC520161_4E5E1032016E_var*
begin
//#UC START# *4CF7BC520161_4E5E1032016E_impl*
 Result := not NeedStartBuffering(aTagId);
//#UC END# *4CF7BC520161_4E5E1032016E_impl*
end;//TevTabStopsFilter.NeedFlushBuffer

procedure TevTabStopsFilter.DoCloseStructure(NeedUndo: Boolean);
//#UC START# *4E45166B0156_4E5E1032016E_var*
//#UC END# *4E45166B0156_4E5E1032016E_var*
begin
//#UC START# *4E45166B0156_4E5E1032016E_impl*
 if CurrentType.IsKindOf(k2_typTextPara) and HasDigitalSeparatorAlignment then
 begin
  try
   Generator.StartTag(k2_tiTabStops);
   try
    Generator.StartDefaultChild;
    try
     Generator.AddIntegerAtom(k2_tiType, Ord(l3_tssDecimal));
     Generator.AddIntegerAtom(k2_tiStart, GetDigitalSeparatorOffset);
    finally
     Generator.Finish;
    end;
   finally
    Generator.Finish;
   end;
  finally
   CellFinished;
  end;
 end;
 inherited;
//#UC END# *4E45166B0156_4E5E1032016E_impl*
end;//TevTabStopsFilter.DoCloseStructure

end.
