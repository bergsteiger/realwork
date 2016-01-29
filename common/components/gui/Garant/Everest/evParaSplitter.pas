unit evParaSplitter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evParaSplitter.pas"
// Начат: 11.02.2011 16:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Searchers::TevParaSplitter
//
// {RequestLink:253668344}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  nevTools,
  evTypes,
  evSearch,
  l3Variant,
  nevBase
  ;

type
 TevParaSplitter = class(TevBaseReplacer)
  {* [RequestLink:253668344] }
 private
 // private fields
   f_G : Ik2TagGenerator;
 protected
 // realized methods
   function ReplaceFunc(const aView: InevView;
     const Container: InevOp;
     const aBlock: InevRange): Boolean; override;
     {* абстрактная функция для замены блока Block на что-то еще.
             Наследники - должны перекрывать данную функцию }
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aGen: Ik2TagGenerator;
     anOptions: TevSearchOptionSet = []); reintroduce;
   class function Make(const aGen: Ik2TagGenerator;
     anOptions: TevSearchOptionSet = []): IevReplacer; reintroduce;
     {* Сигнатура фабрики TevParaSplitter.Make }
 end;//TevParaSplitter

implementation

// start class TevParaSplitter

constructor TevParaSplitter.Create(const aGen: Ik2TagGenerator;
  anOptions: TevSearchOptionSet = []);
//#UC START# *4D553BBA0140_4D553B19023C_var*
//#UC END# *4D553BBA0140_4D553B19023C_var*
begin
//#UC START# *4D553BBA0140_4D553B19023C_impl*
 inherited Create;
 f_G := aGen;
 Options := anOptions;
//#UC END# *4D553BBA0140_4D553B19023C_impl*
end;//TevParaSplitter.Create

class function TevParaSplitter.Make(const aGen: Ik2TagGenerator;
  anOptions: TevSearchOptionSet = []): IevReplacer;
var
 l_Inst : TevParaSplitter;
begin
 l_Inst := Create(aGen, anOptions);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TevParaSplitter.ReplaceFunc(const aView: InevView;
  const Container: InevOp;
  const aBlock: InevRange): Boolean;
//#UC START# *4D553AC103A3_4D553B19023C_var*
var
 l_R : InevRange;
 l_StartRange : InevRange;
 l_FinishRange : InevRange;
 l_S, l_F : InevBasePoint;
//#UC END# *4D553AC103A3_4D553B19023C_var*
begin
//#UC START# *4D553AC103A3_4D553B19023C_impl*
 l_R := aBlock.BottomChildBlock(aView);
 l_R.GetBorderPoints(l_S, l_F);
 l_StartRange := l_R.Obj.Range(nil, l_S);
 l_StartRange.AsStorable.Store(aView, f_G);
 l_FinishRange := l_R.Obj.Range(nil, l_F);
 l_FinishRange.Modify.Delete(aView, Container);
 Result := true;
//#UC END# *4D553AC103A3_4D553B19023C_impl*
end;//TevParaSplitter.ReplaceFunc

procedure TevParaSplitter.ClearFields;
 {-}
begin
 f_G := nil;
 inherited;
end;//TevParaSplitter.ClearFields

end.