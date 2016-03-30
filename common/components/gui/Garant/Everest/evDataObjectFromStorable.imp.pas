{$IfNDef evDataObjectFromStorable_imp}

// Модуль: "w:\common\components\gui\Garant\Everest\evDataObjectFromStorable.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "evDataObjectFromStorable" MUID: (48F8C3780325)
// Имя типа: "_evDataObjectFromStorable_"

{$Define evDataObjectFromStorable_imp}

type
 RStorable = class of _StorableClass_;

 // _StorableClass_

 _evDataObjectFromStorable_ = class(TevPersistentDataObjectEx)
  private
   f_Data: _DataType_;
  protected
   function DataClass: RStorable; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aData: _DataType_); reintroduce;
   class function Make(const aData: _DataType_): IDataObject; reintroduce;
  protected
   property Data: _DataType_
    read f_Data;
 end;//_evDataObjectFromStorable_

{$Else evDataObjectFromStorable_imp}

{$IfNDef evDataObjectFromStorable_imp_impl}

{$Define evDataObjectFromStorable_imp_impl}

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
end;//_evDataObjectFromStorable_.Make

function _evDataObjectFromStorable_.DataClass: RStorable;
//#UC START# *48F8CD5401AD_48F8C3780325_var*
//#UC END# *48F8CD5401AD_48F8C3780325_var*
begin
//#UC START# *48F8CD5401AD_48F8C3780325_impl*
 Result := _StorableClass_;
//#UC END# *48F8CD5401AD_48F8C3780325_impl*
end;//_evDataObjectFromStorable_.DataClass

procedure _evDataObjectFromStorable_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48F8C3780325_var*
//#UC END# *479731C50290_48F8C3780325_var*
begin
//#UC START# *479731C50290_48F8C3780325_impl*
 Finalize(f_Data);
 inherited;
//#UC END# *479731C50290_48F8C3780325_impl*
end;//_evDataObjectFromStorable_.Cleanup

procedure _evDataObjectFromStorable_.ClearFields;
begin
 Finalize(f_Data);
 inherited;
end;//_evDataObjectFromStorable_.ClearFields

{$EndIf evDataObjectFromStorable_imp_impl}

{$EndIf evDataObjectFromStorable_imp}

