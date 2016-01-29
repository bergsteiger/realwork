unit evConstStringStorable;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Лукьянец Р.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evConstStringStorable.pas"
// Начат: 16.07.2007
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::DataObjects::TevConstStringStorable
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
  evStringStorable,
  evdInterfaces,
  l3Interfaces,
  afwNavigation
  ;

type
 TevConstStringStorable = class(TevStringStorable)
 private
 // private fields
   f_Data : IevdHyperlinkInfo;
    {* Поле для свойства Data}
 protected
 // realized methods
   function Text: Tl3WString; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure GetAddress(var Addr: TevAddress); override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aData: IevdHyperlinkInfo;
     const aReader: InevTagReader); reintroduce;
   class function Make(const aData: IevdHyperlinkInfo;
     const aReader: InevTagReader): IevdDataObject; reintroduce;
     {* Сигнатура фабрики TevConstStringStorable.Make }
 public
 // public properties
   property Data: IevdHyperlinkInfo
     read f_Data;
 end;//TevConstStringStorable

implementation

uses
  l3Base,
  l3String
  ;

// start class TevConstStringStorable

constructor TevConstStringStorable.Create(const aData: IevdHyperlinkInfo;
  const aReader: InevTagReader);
//#UC START# *4CDD2A59034A_48F49EEA0008_var*
//#UC END# *4CDD2A59034A_48F49EEA0008_var*
begin
//#UC START# *4CDD2A59034A_48F49EEA0008_impl*
 inherited Create(aReader);
 f_Data := aData;
//#UC END# *4CDD2A59034A_48F49EEA0008_impl*
end;//TevConstStringStorable.Create

class function TevConstStringStorable.Make(const aData: IevdHyperlinkInfo;
  const aReader: InevTagReader): IevdDataObject;
var
 l_Inst : TevConstStringStorable;
begin
 l_Inst := Create(aData, aReader);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TevConstStringStorable.Text: Tl3WString;
//#UC START# *48F494FD001D_48F49EEA0008_var*
//#UC END# *48F494FD001D_48F49EEA0008_var*
begin
//#UC START# *48F494FD001D_48F49EEA0008_impl*
 Result := l3PCharLen(Data.Text);
//#UC END# *48F494FD001D_48F49EEA0008_impl*
end;//TevConstStringStorable.Text

procedure TevConstStringStorable.Cleanup;
//#UC START# *479731C50290_48F49EEA0008_var*
//#UC END# *479731C50290_48F49EEA0008_var*
begin
//#UC START# *479731C50290_48F49EEA0008_impl*
 inherited;
 f_Data := nil;
//#UC END# *479731C50290_48F49EEA0008_impl*
end;//TevConstStringStorable.Cleanup

procedure TevConstStringStorable.GetAddress(var Addr: TevAddress);
//#UC START# *48F494F102DD_48F49EEA0008_var*
//#UC END# *48F494F102DD_48F49EEA0008_var*
begin
//#UC START# *48F494F102DD_48F49EEA0008_impl*
 TevdAddress(Addr) := Data.Address;
//#UC END# *48F494F102DD_48F49EEA0008_impl*
end;//TevConstStringStorable.GetAddress

procedure TevConstStringStorable.ClearFields;
 {-}
begin
 f_Data := nil;
 inherited;
end;//TevConstStringStorable.ClearFields

end.