unit evHolderDataObject;

// Модуль: "w:\common\components\gui\Garant\Everest\evHolderDataObject.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevHolderDataObject" MUID: (4D3EE0C6003E)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evStreamedDataObject
 , nevTools
 , nevBase
 , evdInterfaces
;

type
 TevHolderDataObject = class(TevStreamedDataObject)
  protected
   f_Holder: InevObjectHolder;
  protected
   procedure DoStore(const G: InevTagGenerator;
    aFlags: TevdStoreFlags); override;
    {* сохраняет поток в G }
   procedure ClearFields; override;
  public
   constructor Create(const aHolder: InevObjectHolder); reintroduce;
   class function Make(const aHolder: InevObjectHolder): InevStorable; reintroduce;
 end;//TevHolderDataObject

implementation

uses
 l3ImplUses
;

constructor TevHolderDataObject.Create(const aHolder: InevObjectHolder);
//#UC START# *4D3EE11B022F_4D3EE0C6003E_var*
//#UC END# *4D3EE11B022F_4D3EE0C6003E_var*
begin
//#UC START# *4D3EE11B022F_4D3EE0C6003E_impl*
 inherited Create;
 f_Holder := aHolder;
//#UC END# *4D3EE11B022F_4D3EE0C6003E_impl*
end;//TevHolderDataObject.Create

class function TevHolderDataObject.Make(const aHolder: InevObjectHolder): InevStorable;
var
 l_Inst : TevHolderDataObject;
begin
 l_Inst := Create(aHolder);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevHolderDataObject.Make

procedure TevHolderDataObject.DoStore(const G: InevTagGenerator;
 aFlags: TevdStoreFlags);
 {* сохраняет поток в G }
//#UC START# *48EA34990191_4D3EE0C6003E_var*
var
 l_Obj : InevObject;
//#UC END# *48EA34990191_4D3EE0C6003E_var*
begin
//#UC START# *48EA34990191_4D3EE0C6003E_impl*
 l_Obj := f_Holder.Obj;
 try
  G.Start;
  try
   G.StartChild(l_Obj.AsObject.TagType);
   try
    l_Obj.AsObject.WriteTag(G);
   finally
    G.Finish;
   end;//try..finally
  finally
   G.Finish;
  end;//try..finally
 finally
  l_Obj := nil;
 end;//try..finally
//#UC END# *48EA34990191_4D3EE0C6003E_impl*
end;//TevHolderDataObject.DoStore

procedure TevHolderDataObject.ClearFields;
begin
 f_Holder := nil;
 inherited;
end;//TevHolderDataObject.ClearFields

end.
