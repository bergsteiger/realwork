unit evNodeStorable;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evNodeStorable.pas"
// Начат: 26.12.2006 14:45
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::DataObjects::TevNodeStorable
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  nevBase,
  nevTools,
  evStringStorable,
  evdInterfaces,
  l3Interfaces
  ;

type
 TevNodeStorable = class(TevStringStorable)
 private
 // private fields
   f_Node : InevSimpleNode;
    {* Поле для свойства Node}
 protected
 // realized methods
   function Text: Tl3WString; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aData: InevSimpleNode;
    const aReader: InevTagReader); reintroduce;
   class function Make(const aData: InevSimpleNode;
    const aReader: InevTagReader): IevdDataObject; reintroduce;
 protected
 // protected properties
   property Node: InevSimpleNode
     read f_Node;
 end;//TevNodeStorable

implementation

// start class TevNodeStorable

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
end;

function TevNodeStorable.Text: Tl3WString;
//#UC START# *48F494FD001D_48F4D8230366_var*
//#UC END# *48F494FD001D_48F4D8230366_var*
begin
//#UC START# *48F494FD001D_48F4D8230366_impl*
 Result := f_Node.Text;
//#UC END# *48F494FD001D_48F4D8230366_impl*
end;//TevNodeStorable.Text

procedure TevNodeStorable.Cleanup;
//#UC START# *479731C50290_48F4D8230366_var*
//#UC END# *479731C50290_48F4D8230366_var*
begin
//#UC START# *479731C50290_48F4D8230366_impl*
 inherited;
 f_Node := nil;
//#UC END# *479731C50290_48F4D8230366_impl*
end;//TevNodeStorable.Cleanup

procedure TevNodeStorable.ClearFields;
 {-}
begin
 f_Node := nil;
 inherited;
end;//TevNodeStorable.ClearFields

end.