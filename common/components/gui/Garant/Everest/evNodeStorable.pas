unit evNodeStorable;

// Модуль: "w:\common\components\gui\Garant\Everest\evNodeStorable.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevNodeStorable" MUID: (48F4D8230366)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evStringStorable
 , nevBase
 , evdInterfaces
 , nevTools
 , l3Interfaces
;

type
 TevNodeStorable = class(TevStringStorable)
  private
   f_Node: InevSimpleNode;
  protected
   function Text: Tl3WString; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aData: InevSimpleNode;
    const aReader: InevTagReader); reintroduce;
   class function Make(const aData: InevSimpleNode;
    const aReader: InevTagReader): IevdDataObject; reintroduce;
  protected
   property Node: InevSimpleNode
    read f_Node;
 end;//TevNodeStorable

implementation

uses
 l3ImplUses
 //#UC START# *48F4D8230366impl_uses*
 //#UC END# *48F4D8230366impl_uses*
;

constructor TevNodeStorable.Create(const aData: InevSimpleNode;
 const aReader: InevTagReader);
//#UC START# *48F4D87E0393_48F4D8230366_var*
//#UC END# *48F4D87E0393_48F4D8230366_var*
begin
//#UC START# *48F4D87E0393_48F4D8230366_impl*
 inherited Create(aReader);
 f_Node := aData;
//#UC END# *48F4D87E0393_48F4D8230366_impl*
end;//TevNodeStorable.Create

class function TevNodeStorable.Make(const aData: InevSimpleNode;
 const aReader: InevTagReader): IevdDataObject;
var
 l_Inst : TevNodeStorable;
begin
 l_Inst := Create(aData, aReader);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevNodeStorable.Make

function TevNodeStorable.Text: Tl3WString;
//#UC START# *48F494FD001D_48F4D8230366_var*
//#UC END# *48F494FD001D_48F4D8230366_var*
begin
//#UC START# *48F494FD001D_48F4D8230366_impl*
 Result := f_Node.Text;
//#UC END# *48F494FD001D_48F4D8230366_impl*
end;//TevNodeStorable.Text

procedure TevNodeStorable.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48F4D8230366_var*
//#UC END# *479731C50290_48F4D8230366_var*
begin
//#UC START# *479731C50290_48F4D8230366_impl*
 inherited;
 f_Node := nil;
//#UC END# *479731C50290_48F4D8230366_impl*
end;//TevNodeStorable.Cleanup

procedure TevNodeStorable.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TevNodeStorable.ClearFields

end.
