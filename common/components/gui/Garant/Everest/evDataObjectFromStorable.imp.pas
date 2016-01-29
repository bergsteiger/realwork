{$IfNDef evDataObjectFromStorable_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evDataObjectFromStorable.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::DataObjects::evDataObjectFromStorable
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define evDataObjectFromStorable_imp}
 RStorable = class of _StorableClass_;

 _evDataObjectFromStorable_ = {mixin} class(TevPersistentDataObjectEx)
 private
 // private fields
   f_Data : _DataType_;
    {* Поле для свойства Data}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected methods
   function DataClass: RStorable; virtual;
 public
 // public methods
   constructor Create(const aData: _DataType_); reintroduce;
   class function Make(const aData: _DataType_): IDataObject; reintroduce;
     {* Сигнатура фабрики evDataObjectFromStorable.Make }
 protected
 // protected properties
   property Data: _DataType_
     read f_Data;
 end;//_evDataObjectFromStorable_

{$Else evDataObjectFromStorable_imp}

// start class _evDataObjectFromStorable_

constructor _evDataObjectFromStorable_.Create(const aData: _DataType_);
//#UC START# *4CDD6F4403CD_48F8C3780325_var*
var
 l_OH : InevObjectHolder;
//#UC END# *4CDD6F4403CD_48F8C3780325_var*
begin
//#UC START# *4CDD6F4403CD_48F8C3780325_impl*
 l_OH := Holder;
 f_Data := aData;
 inherited Create(DataClass.Make(aData, l_OH.TagReader),
                  true,
                  cf_EverestBin, l_OH.TagReader, l_OH.TagWriter,
                  l3FormatArray(evAllFormats),
                  nil);
//#UC END# *4CDD6F4403CD_48F8C3780325_impl*
end;//_evDataObjectFromStorable_.Create

class function _evDataObjectFromStorable_.Make(const aData: _DataType_): IDataObject;
var
 l_Inst : _evDataObjectFromStorable_;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst As IDataObject;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function _evDataObjectFromStorable_.DataClass: RStorable;
//#UC START# *48F8CD5401AD_48F8C3780325_var*
//#UC END# *48F8CD5401AD_48F8C3780325_var*
begin
//#UC START# *48F8CD5401AD_48F8C3780325_impl*
 Result := _StorableClass_;
//#UC END# *48F8CD5401AD_48F8C3780325_impl*
end;//_evDataObjectFromStorable_.DataClass

procedure _evDataObjectFromStorable_.Cleanup;
//#UC START# *479731C50290_48F8C3780325_var*
//#UC END# *479731C50290_48F8C3780325_var*
begin
//#UC START# *479731C50290_48F8C3780325_impl*
 Finalize(f_Data);
 inherited;
//#UC END# *479731C50290_48F8C3780325_impl*
end;//_evDataObjectFromStorable_.Cleanup

{$EndIf evDataObjectFromStorable_imp}
