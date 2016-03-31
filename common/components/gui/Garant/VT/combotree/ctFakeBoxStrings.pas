unit ctFakeBoxStrings;

// Модуль: "w:\common\components\gui\Garant\VT\ComboTree\ctFakeBoxStrings.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TctFakeBoxStrings" MUID: (487268A90374)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , ComboBoxStrings
 , FakeBox
 , Classes
;

type
 TctFakeBoxStrings = class(TComboBoxStrings)
  private
   f_SubOwner: TFakeBox;
  public
   constructor Create(anOwner: TFakeBox); reintroduce;
   procedure Assign(Source: TPersistent); override;
   procedure Clear; override;
  protected
   property SubOwner: TFakeBox
    read f_SubOwner;
 end;//TctFakeBoxStrings

implementation

uses
 l3ImplUses
 , l3String
;

constructor TctFakeBoxStrings.Create(anOwner: TFakeBox);
//#UC START# *487268F8027E_487268A90374_var*
//#UC END# *487268F8027E_487268A90374_var*
begin
//#UC START# *487268F8027E_487268A90374_impl*
 inherited Create;
 f_SubOwner := anOwner;
//#UC END# *487268F8027E_487268A90374_impl*
end;//TctFakeBoxStrings.Create

procedure TctFakeBoxStrings.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_487268A90374_var*
var
 l_Index : Integer;
 l_Same  : Boolean;
//#UC END# *478CF34E02CE_487268A90374_var*
begin
//#UC START# *478CF34E02CE_487268A90374_impl*
 if (Source is TStrings) then
 begin
  if (Count = TStrings(Source).Count) then
  begin
   l_Same := true;
   for l_Index := 0 to Pred(Count) do
    if not l3Same(ItemW[l_Index], TStrings(Source)[l_Index]) then
    begin
     l_Same := false;
     break;
    end;//not l3Same(ItemW[l_Index], TStrings(Source)[l_Index])
   if l_Same then
    Exit;
  end;//Count = TStrings(Source).Count
 end;//Source is TStrings
 inherited;
//#UC END# *478CF34E02CE_487268A90374_impl*
end;//TctFakeBoxStrings.Assign

procedure TctFakeBoxStrings.Clear;
//#UC START# *47B1C16D0188_487268A90374_var*
//#UC END# *47B1C16D0188_487268A90374_var*
begin
//#UC START# *47B1C16D0188_487268A90374_impl*
 if (Count > 0) then
  f_SubOwner.ItemIndex := -1;
 inherited;
//#UC END# *47B1C16D0188_487268A90374_impl*
end;//TctFakeBoxStrings.Clear

end.
