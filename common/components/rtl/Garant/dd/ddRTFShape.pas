unit ddRTFShape;
 {* Объект для работы с Shape и извлечением из них нужной информации. }

// Модуль: "w:\common\components\rtl\Garant\dd\ddRTFShape.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddRTFShape" MUID: (5596481703C3)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddDocumentAtom
 , ddDocumentAtomList
 , ddTextParagraph
 , ddRTFState
 , destNorm
 , ddPicture
 , ddCustomDestination
 , k2Interfaces
 , ddTypes
;

type
 TddRTFShape = class(TddDocumentAtom)
  {* Объект для работы с Shape и извлечением из них нужной информации. }
  private
   f_Children: TddDocumentAtomList;
   f_Top: Integer;
   f_Left: Integer;
   f_Bottom: Integer;
   f_Right: Integer;
  protected
   procedure pm_SetTop(aValue: Integer);
   procedure pm_SetLeft(aValue: Integer);
   procedure pm_SetBottom(aValue: Integer);
   procedure pm_SetRight(aValue: Integer);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure Append(aState: TddRTFState;
    aDest: TdestNorm);
   procedure AddPicture(aPicture: TddPicture;
    aState: TddRTFState);
   function BottomAndRight(aShape: TddRTFShape): Boolean;
   function AddTextPara: TddTextParagraph;
   function LastPara: TddTextParagraph;
   procedure Write2Generator(const Generator: Ik2TagGenerator;
    aNeedProcessRow: Boolean;
    LiteVersion: TddLiteVersion); override;
   procedure Clear; override;
   constructor Create(aDetination: TddCustomDestination); override;
  public
   property Top: Integer
    read f_Top
    write pm_SetTop;
   property Left: Integer
    read f_Left
    write pm_SetLeft;
   property Bottom: Integer
    read f_Bottom
    write pm_SetBottom;
   property Right: Integer
    read f_Right
    write pm_SetRight;
 end;//TddRTFShape

implementation

uses
 l3ImplUses
 , SysUtils
 , ddParagraphProperty
 , l3MinMax
 , ddTable
 //#UC START# *5596481703C3impl_uses*
 //#UC END# *5596481703C3impl_uses*
;

procedure TddRTFShape.pm_SetTop(aValue: Integer);
//#UC START# *55964C48010D_5596481703C3set_var*
//#UC END# *55964C48010D_5596481703C3set_var*
begin
//#UC START# *55964C48010D_5596481703C3set_impl*
 f_Top := aValue;
//#UC END# *55964C48010D_5596481703C3set_impl*
end;//TddRTFShape.pm_SetTop

procedure TddRTFShape.pm_SetLeft(aValue: Integer);
//#UC START# *55964C5C0042_5596481703C3set_var*
//#UC END# *55964C5C0042_5596481703C3set_var*
begin
//#UC START# *55964C5C0042_5596481703C3set_impl*
 f_Left := aValue;
//#UC END# *55964C5C0042_5596481703C3set_impl*
end;//TddRTFShape.pm_SetLeft

procedure TddRTFShape.pm_SetBottom(aValue: Integer);
//#UC START# *55964C6E0015_5596481703C3set_var*
//#UC END# *55964C6E0015_5596481703C3set_var*
begin
//#UC START# *55964C6E0015_5596481703C3set_impl*
 f_Bottom := aValue;
//#UC END# *55964C6E0015_5596481703C3set_impl*
end;//TddRTFShape.pm_SetBottom

procedure TddRTFShape.pm_SetRight(aValue: Integer);
//#UC START# *55964C9D0290_5596481703C3set_var*
//#UC END# *55964C9D0290_5596481703C3set_var*
begin
//#UC START# *55964C9D0290_5596481703C3set_impl*
 f_Right := aValue;
//#UC END# *55964C9D0290_5596481703C3set_impl*
end;//TddRTFShape.pm_SetRight

procedure TddRTFShape.Append(aState: TddRTFState;
 aDest: TdestNorm);
//#UC START# *55966CB60326_5596481703C3_var*

 procedure lp_AddTable(const aPara: TddDocumentAtom);
 var
  l_Table: TddTable;
 begin
  l_Table := TddTable.Create(f_Destination);
  try
   l_Table.Assign(aPara);
   f_Children.Add(l_Table);
   if aPara.Closed then
    l_Table.Closed := True;
  finally
   FreeAndNil(l_Table);
  end;
 end;

 procedure lp_AddTextPara(const aPara: TddDocumentAtom);
 var
  l_NewPara : TddTextParagraph;
 begin
  l_NewPara := TddTextParagraph.Create(f_Destination);
  try
   l_NewPara.Assign(aPara);
   f_Children.Add(l_NewPara);
   if aPara.Closed then
    l_NewPara.Closed := True;
  finally
   FreeAndNil(l_NewPara);
  end;
 end;

var
 i     : Integer;
 l_Para: TddDocumentAtom;
//#UC END# *55966CB60326_5596481703C3_var*
begin
//#UC START# *55966CB60326_5596481703C3_impl*
 for i := 0 to aDest.GetParagraphsCount - 1 do
 begin
  l_Para := aDest.Paragraph[i];
  if l_Para.IsTable then
   lp_AddTable(l_Para)
  else
   lp_AddTextPara(l_Para);
 end; // for i
//#UC END# *55966CB60326_5596481703C3_impl*
end;//TddRTFShape.Append

procedure TddRTFShape.AddPicture(aPicture: TddPicture;
 aState: TddRTFState);
//#UC START# *559B95E00118_5596481703C3_var*
var
 l_Prop   : TddParagraphProperty;
 l_Picture: TddPicture;
//#UC END# *559B95E00118_5596481703C3_var*
begin
//#UC START# *559B95E00118_5596481703C3_impl*
 if aState = nil then
  l_Prop := nil
 else
  l_Prop := aState.PAP;
 l_Picture := aPicture.Clone(l_Prop);
 try
  f_Children.Add(l_Picture);
 finally
  FreeAndNil(l_Picture);
 end;
//#UC END# *559B95E00118_5596481703C3_impl*
end;//TddRTFShape.AddPicture

function TddRTFShape.BottomAndRight(aShape: TddRTFShape): Boolean;
//#UC START# *559BDC0701B1_5596481703C3_var*
var
 l_Top     : Integer;
 l_Left    : Integer;
 l_Right   : Integer;
 l_Bottom  : Integer;
 l_Intercet: Boolean;
//#UC END# *559BDC0701B1_5596481703C3_var*
begin
//#UC START# *559BDC0701B1_5596481703C3_impl*
 l_Top := Max(Self.Top, aShape.Top);
 l_Bottom := Min(Self.Bottom, aShape.Bottom);
 l_Intercet := (l_Top < l_Bottom);
 if l_Intercet then
 begin
  l_Left := Max(Self.Left, aShape.Left);
  l_Right := Min(Self.Right, Self.Right);
  l_Intercet := (l_Left < l_Right);
 end; // if l_Intercet then
 if l_Intercet then
 begin
  Result := (Self.Left > aShape.Left);
  if not Result and (Self.Left = aShape.Left) then
   Result := (Self.Top > aShape.Top);
 end // if l_Intercet then
 else
  Result := (Self.Top > aShape.Top);
//#UC END# *559BDC0701B1_5596481703C3_impl*
end;//TddRTFShape.BottomAndRight

function TddRTFShape.AddTextPara: TddTextParagraph;
//#UC START# *55C4744E00CC_5596481703C3_var*
var
 l_TextPara: TddTextParagraph;
//#UC END# *55C4744E00CC_5596481703C3_var*
begin
//#UC START# *55C4744E00CC_5596481703C3_impl*
 l_TextPara := TddTextParagraph.Create(f_Destination);
 try
  f_Children.Add(l_TextPara);
  Result := TddTextParagraph(f_Children.Last);
 finally
  FreeAndNil(l_TextPara);
 end;
//#UC END# *55C4744E00CC_5596481703C3_impl*
end;//TddRTFShape.AddTextPara

function TddRTFShape.LastPara: TddTextParagraph;
//#UC START# *55C4746C0398_5596481703C3_var*
//#UC END# *55C4746C0398_5596481703C3_var*
begin
//#UC START# *55C4746C0398_5596481703C3_impl*
 if f_Children.Count = 0 then
  Result := nil
 else
  Result := f_Children.Last as TddTextParagraph;
//#UC END# *55C4746C0398_5596481703C3_impl*
end;//TddRTFShape.LastPara

procedure TddRTFShape.Write2Generator(const Generator: Ik2TagGenerator;
 aNeedProcessRow: Boolean;
 LiteVersion: TddLiteVersion);
//#UC START# *518A504F00F5_5596481703C3_var*
var
 i: Integer;
//#UC END# *518A504F00F5_5596481703C3_var*
begin
//#UC START# *518A504F00F5_5596481703C3_impl*
 for i := 0 to f_Children.Count - 1 do
  f_Children[i].Write2Generator(Generator, aNeedProcessRow, LiteVersion);
//#UC END# *518A504F00F5_5596481703C3_impl*
end;//TddRTFShape.Write2Generator

procedure TddRTFShape.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5596481703C3_var*
//#UC END# *479731C50290_5596481703C3_var*
begin
//#UC START# *479731C50290_5596481703C3_impl*
 FreeAndNil(f_Children);
 inherited;
//#UC END# *479731C50290_5596481703C3_impl*
end;//TddRTFShape.Cleanup

procedure TddRTFShape.Clear;
//#UC START# *518A48F500CF_5596481703C3_var*
//#UC END# *518A48F500CF_5596481703C3_var*
begin
//#UC START# *518A48F500CF_5596481703C3_impl*
 f_Children.Clear;
 inherited;
//#UC END# *518A48F500CF_5596481703C3_impl*
end;//TddRTFShape.Clear

constructor TddRTFShape.Create(aDetination: TddCustomDestination);
//#UC START# *51E91BA80051_5596481703C3_var*
//#UC END# *51E91BA80051_5596481703C3_var*
begin
//#UC START# *51E91BA80051_5596481703C3_impl*
 inherited;
 f_Children := TddDocumentAtomList.Make;
//#UC END# *51E91BA80051_5596481703C3_impl*
end;//TddRTFShape.Create

end.
