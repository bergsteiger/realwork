unit ddCellProperty;

// Модуль: "w:\common\components\rtl\Garant\dd\ddCellProperty.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddCellProperty" MUID: (5111FEC00247)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddPropertyObject
 , ddBorder
 , ddTypes
 , k2Interfaces
;

type
 TddOffsetType = (
  dd_otNone
  , dd_otByTab
  , dd_otByColumn
  , dd_otByLeftIndent
  , dd_otByPage
 );//TddOffsetType

 TddCellProperty = class(TddPropertyObject)
  private
   f_ClearBorder: TddClearBoder;
   f_Border: TddBorder;
   f_BottomPad: LongInt;
   f_CellSpan: LongInt;
   f_Index: LongInt;
   f_LeftPad: LongInt;
   f_PatternBackColor: LongInt;
   f_PatternBackColorIndex: LongInt;
   f_PatternForeColor: LongInt;
   f_PatternForeColorIndex: LongInt;
   f_RightPad: LongInt;
   f_CellOffset: LongInt;
    {* На самом деле это не ширина, а смещение (по крайней мере у преобразования из текста в табилцу). }
   f_CellJust: TddCellJust;
   f_IsPercent: Boolean;
   f_Merged: Boolean;
   f_MergeFirst: Boolean;
   f_VMerged: Boolean;
    {* Ячейки принадлежит к объедененым по вертикали. }
   f_VMergeFirst: Boolean;
    {* Флаг устанавливается, чтобы можно было определить вертикальное выравнивание:
          если попадается еще одна ячейка с таким флагом в колонке, то ей устанавливают
          флаг VMerged. Начало объединения VMergeFirst = False. }
   f_RowSpan: LongInt;
   f_TopPad: LongInt;
   f_AlignCell: Boolean;
   f_CellWidth: LongInt;
   f_OffsetType: TddOffsetType;
  protected
   function pm_GetIsBorder: Boolean;
   procedure pm_SetIsBorder(aValue: Boolean);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aClearBorder: TddClearBoder); reintroduce;
   function IsCellOffseDefault: Boolean;
   procedure Assign(aCellProperty: TddCellProperty);
   procedure MergeWith(P: TddPropertyObject); override;
   procedure InheriteFrom(P: TddPropertyObject); override;
   procedure Write2Generator(const Generator: Ik2TagGenerator); override;
   procedure Reset; override;
   function Diff(P: TddPropertyObject;
    aForReader: Boolean): TddPropertyObject; override;
   procedure Clear; override;
  public
   property Border: TddBorder
    read f_Border;
   property BottomPad: LongInt
    read f_BottomPad
    write f_BottomPad;
   property CellSpan: LongInt
    read f_CellSpan
    write f_CellSpan;
   property Index: LongInt
    read f_Index
    write f_Index;
   property LeftPad: LongInt
    read f_LeftPad
    write f_LeftPad;
   property PatternBackColor: LongInt
    read f_PatternBackColor
    write f_PatternBackColor;
   property PatternBackColorIndex: LongInt
    read f_PatternBackColorIndex
    write f_PatternBackColorIndex;
   property PatternForeColor: LongInt
    read f_PatternForeColor
    write f_PatternForeColor;
   property PatternForeColorIndex: LongInt
    read f_PatternForeColorIndex
    write f_PatternForeColorIndex;
   property RightPad: LongInt
    read f_RightPad
    write f_RightPad;
   property CellOffset: LongInt
    read f_CellOffset
    write f_CellOffset;
    {* На самом деле это не ширина, а смещение (по крайней мере у преобразования из текста в табилцу). }
   property CellJust: TddCellJust
    read f_CellJust
    write f_CellJust;
   property IsPercent: Boolean
    read f_IsPercent
    write f_IsPercent;
   property Merged: Boolean
    read f_Merged
    write f_Merged;
   property MergeFirst: Boolean
    read f_MergeFirst
    write f_MergeFirst;
   property VMerged: Boolean
    read f_VMerged
    write f_VMerged;
    {* Ячейки принадлежит к объедененым по вертикали. }
   property VMergeFirst: Boolean
    read f_VMergeFirst
    write f_VMergeFirst;
    {* Флаг устанавливается, чтобы можно было определить вертикальное выравнивание:
          если попадается еще одна ячейка с таким флагом в колонке, то ей устанавливают
          флаг VMerged. Начало объединения VMergeFirst = False. }
   property IsBorder: Boolean
    read pm_GetIsBorder
    write pm_SetIsBorder;
   property RowSpan: LongInt
    read f_RowSpan
    write f_RowSpan;
   property TopPad: LongInt
    read f_TopPad
    write f_TopPad;
   property AlignCell: Boolean
    read f_AlignCell
    write f_AlignCell;
   property CellWidth: LongInt
    read f_CellWidth
    write f_CellWidth;
   property OffsetType: TddOffsetType
    read f_OffsetType
    write f_OffsetType;
 end;//TddCellProperty

implementation

uses
 l3ImplUses
 , l3Base
 , ddBase
;

function TddCellProperty.pm_GetIsBorder: Boolean;
//#UC START# *52CF9F5201BD_5111FEC00247get_var*
//#UC END# *52CF9F5201BD_5111FEC00247get_var*
begin
//#UC START# *52CF9F5201BD_5111FEC00247get_impl*
 Result := f_Border.IsFramed;
//#UC END# *52CF9F5201BD_5111FEC00247get_impl*
end;//TddCellProperty.pm_GetIsBorder

procedure TddCellProperty.pm_SetIsBorder(aValue: Boolean);
//#UC START# *52CF9F5201BD_5111FEC00247set_var*
//#UC END# *52CF9F5201BD_5111FEC00247set_var*
begin
//#UC START# *52CF9F5201BD_5111FEC00247set_impl*
 f_Border.IsFramed := aValue;
//#UC END# *52CF9F5201BD_5111FEC00247set_impl*
end;//TddCellProperty.pm_SetIsBorder

constructor TddCellProperty.Create(aClearBorder: TddClearBoder);
//#UC START# *52CF9FF4019B_5111FEC00247_var*
//#UC END# *52CF9FF4019B_5111FEC00247_var*
begin
//#UC START# *52CF9FF4019B_5111FEC00247_impl*
 inherited Create;
 f_ClearBorder := aClearBorder;
 f_Border := TddBorder.Create;
 f_AlignCell := False;
 Clear;
//#UC END# *52CF9FF4019B_5111FEC00247_impl*
end;//TddCellProperty.Create

function TddCellProperty.IsCellOffseDefault: Boolean;
//#UC START# *5614C68F0041_5111FEC00247_var*
//#UC END# *5614C68F0041_5111FEC00247_var*
begin
//#UC START# *5614C68F0041_5111FEC00247_impl*
 Result := f_CellOffset = ddGetMinimalCellWidth;
//#UC END# *5614C68F0041_5111FEC00247_impl*
end;//TddCellProperty.IsCellOffseDefault

procedure TddCellProperty.Assign(aCellProperty: TddCellProperty);
//#UC START# *52CFA04E02A8_5111FEC00247_var*
//#UC END# *52CFA04E02A8_5111FEC00247_var*
begin
//#UC START# *52CFA04E02A8_5111FEC00247_impl*
 f_Index := aCellProperty.Index;
 F_Border.AssignFrom(aCellProperty.Border);
 f_CellOffset:= aCellProperty.CellOffset;
 f_CellWidth := aCellProperty.CellWidth;
 f_VMerged:= aCellProperty.VMerged;
 f_VMergeFirst:= aCellProperty.VMergeFirst;
 f_Merged:= aCellProperty.Merged;
 f_MergeFirst:= aCellProperty.MergeFirst;
 f_PatternForeColor:= aCellProperty.PatternForeColor;
 f_PatternForeColorIndex:= aCellProperty.PatternForeColorIndex;
 f_PatternBackColor:= aCellProperty.PatternBackColor;
 f_PatternBackColorIndex:= aCellProperty.PatternBackColorIndex;
 f_CellJust:= aCellProperty.CellJust;
 f_IsPercent:= aCellProperty.IsPercent;
 f_CellSpan := aCellProperty.CellSpan;
 f_RowSpan := aCellProperty.RowSpan;
//#UC END# *52CFA04E02A8_5111FEC00247_impl*
end;//TddCellProperty.Assign

procedure TddCellProperty.MergeWith(P: TddPropertyObject);
//#UC START# *525E369F0158_5111FEC00247_var*
//#UC END# *525E369F0158_5111FEC00247_var*
begin
//#UC START# *525E369F0158_5111FEC00247_impl*
 Assert(False);
//#UC END# *525E369F0158_5111FEC00247_impl*
end;//TddCellProperty.MergeWith

procedure TddCellProperty.InheriteFrom(P: TddPropertyObject);
//#UC START# *525E37430345_5111FEC00247_var*
//#UC END# *525E37430345_5111FEC00247_var*
begin
//#UC START# *525E37430345_5111FEC00247_impl*
 Assert(False);
//#UC END# *525E37430345_5111FEC00247_impl*
end;//TddCellProperty.InheriteFrom

procedure TddCellProperty.Write2Generator(const Generator: Ik2TagGenerator);
//#UC START# *525E377B007E_5111FEC00247_var*
//#UC END# *525E377B007E_5111FEC00247_var*
begin
//#UC START# *525E377B007E_5111FEC00247_impl*
 Assert(False);
//#UC END# *525E377B007E_5111FEC00247_impl*
end;//TddCellProperty.Write2Generator

procedure TddCellProperty.Reset;
//#UC START# *525E478A0232_5111FEC00247_var*
//#UC END# *525E478A0232_5111FEC00247_var*
begin
//#UC START# *525E478A0232_5111FEC00247_impl*
 Assert(False);
//#UC END# *525E478A0232_5111FEC00247_impl*
end;//TddCellProperty.Reset

function TddCellProperty.Diff(P: TddPropertyObject;
 aForReader: Boolean): TddPropertyObject;
//#UC START# *525E47E10065_5111FEC00247_var*
//#UC END# *525E47E10065_5111FEC00247_var*
begin
//#UC START# *525E47E10065_5111FEC00247_impl*
 Result := nil;
 Assert(False);
//#UC END# *525E47E10065_5111FEC00247_impl*
end;//TddCellProperty.Diff

procedure TddCellProperty.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5111FEC00247_var*
//#UC END# *479731C50290_5111FEC00247_var*
begin
//#UC START# *479731C50290_5111FEC00247_impl*
 f_AlignCell := False;
 l3Free(f_Border);
 inherited
//#UC END# *479731C50290_5111FEC00247_impl*
end;//TddCellProperty.Cleanup

procedure TddCellProperty.Clear;
//#UC START# *518A13330058_5111FEC00247_var*
//#UC END# *518A13330058_5111FEC00247_var*
begin
//#UC START# *518A13330058_5111FEC00247_impl*
 f_LeftPad:= ddDefaultPad;
 f_RightPad:= ddDefaultPad;
 f_TopPad:= 0;
 f_BottomPad:= 0;
 f_CellOffset:= ddGetMinimalCellWidth;
 f_CellWidth := 0;
 f_VMerged:= False;
 f_VMergeFirst:= False;
 f_CellJust:= cellTop;
 f_Merged:= False;
 f_MergeFirst:= False;
 f_AlignCell := False;
 
 f_Border.BorderOwner := boCell;
 f_Border.IsFramed := Boolean(f_ClearBorder);
 f_PatternForeColor:= propUndefined;
 f_PatternForeColorIndex:= propUndefined;
 f_PatternBackColor:= propUndefined;
 f_PatternBackColorIndex:= propUndefined;
 f_IsPercent:= False;
 f_CellSpan:= 1;
 f_RowSpan := 1;
//#UC END# *518A13330058_5111FEC00247_impl*
end;//TddCellProperty.Clear

end.
