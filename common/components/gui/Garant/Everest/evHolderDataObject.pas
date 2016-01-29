unit evHolderDataObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evHolderDataObject.pas"
// Начат: 25.01.2011 17:40
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::DataObjects::TevHolderDataObject
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
  evStreamedDataObject,
  nevBase,
  evdInterfaces
  ;

type
 TevHolderDataObject = class(TevStreamedDataObject)
 protected
 // realized methods
   procedure DoStore(const G: InevTagGenerator;
    aFlags: TevdStoreFlags); override;
     {* сохраняет поток в G }
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected fields
   f_Holder : InevObjectHolder;
 public
 // public methods
   constructor Create(const aHolder: InevObjectHolder); reintroduce;
   class function Make(const aHolder: InevObjectHolder): InevStorable; reintroduce;
     {* Сигнатура фабрики TevHolderDataObject.Make }
 end;//TevHolderDataObject

implementation

// start class TevHolderDataObject

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
end;

procedure TevHolderDataObject.DoStore(const G: InevTagGenerator;
  aFlags: TevdStoreFlags);
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
 {-}
begin
 f_Holder := nil;
 inherited;
end;//TevHolderDataObject.ClearFields

end.