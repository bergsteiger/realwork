unit ctFakeBoxStrings;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VT/ComboTree/ctFakeBoxStrings.pas"
// Начат: 07.07.2008 23:02
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VT::ComboTree::TctFakeBoxStrings
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
  FakeBox,
  ComboBoxStrings,
  Classes
  ;

type
 TctFakeBoxStrings = class(TComboBoxStrings)
 private
 // private fields
   f_SubOwner : TFakeBox;
    {* Поле для свойства SubOwner}
 public
 // overridden public methods
   procedure Assign(Source: TPersistent); override;
   procedure Clear; override;
 public
 // public methods
   constructor Create(anOwner: TFakeBox); reintroduce;
 protected
 // protected properties
   property SubOwner: TFakeBox
     read f_SubOwner;
 end;//TctFakeBoxStrings

implementation

uses
  l3String
  ;

// start class TctFakeBoxStrings

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