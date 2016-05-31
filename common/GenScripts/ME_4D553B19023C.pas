unit evParaSplitter;
 {* [RequestLink:253668344] }

// Модуль: "w:\common\components\gui\Garant\Everest\evParaSplitter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevParaSplitter" MUID: (4D553B19023C)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evSearch
 , l3Variant
 , nevTools
 , evTypes
 , nevBase
;

type
 TevParaSplitter = class(TevBaseReplacer)
  {* [RequestLink:253668344] }
  private
   f_G: Ik2TagGenerator;
  protected
   function ReplaceFunc(const aView: InevView;
    const Container: InevOp;
    const aBlock: InevRange): Boolean; override;
   procedure ClearFields; override;
  public
   constructor Create(const aGen: Ik2TagGenerator;
    anOptions: TevSearchOptionSet = []); reintroduce;
   class function Make(const aGen: Ik2TagGenerator;
    anOptions: TevSearchOptionSet = []): IevReplacer; reintroduce;
 end;//TevParaSplitter

implementation

uses
 l3ImplUses
;

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
end;//TevParaSplitter.Make

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
begin
 f_G := nil;
 inherited;
end;//TevParaSplitter.ClearFields

end.
