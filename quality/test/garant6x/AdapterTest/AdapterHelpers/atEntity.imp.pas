{$IfNDef atEntity_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/AdapterHelpers/atEntity.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> garant6x_test::AdapterTest::AdapterHelpers::atEntity
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define atEntity_imp}
 _atEntity_ = {mixin} class(Tl3_Base)
 private
 // private fields
   f_Entity : _EntityInterface_;
    {* Поле для свойства Entity}
 protected
 // overridden protected methods
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   class function IsItMe(const anEntity: IEntityBase): Boolean; virtual;
   constructor Create(const anEntityBase: IEntityBase); reintroduce; overload;  virtual;
   constructor Create(const anEntity: _EntityInterface_); reintroduce; overload;  virtual;
   constructor Create(const aNodeBase: INodeBase); reintroduce; overload;  virtual;
 public
 // public properties
   property Entity: _EntityInterface_
     read f_Entity;
 end;//_atEntity_

{$Else atEntity_imp}

// start class _atEntity_

class function _atEntity_.IsItMe(const anEntity: IEntityBase): Boolean;
//#UC START# *4FC8E4970307_4FC8E3BF0125_var*
//#UC END# *4FC8E4970307_4FC8E3BF0125_var*
begin
//#UC START# *4FC8E4970307_4FC8E3BF0125_impl*
  Result := Supports(anEntity, _EntityInterface_);
//#UC END# *4FC8E4970307_4FC8E3BF0125_impl*
end;//_atEntity_.IsItMe

constructor _atEntity_.Create(const anEntityBase: IEntityBase);
//#UC START# *4FC8E5780345_4FC8E3BF0125_var*
//#UC END# *4FC8E5780345_4FC8E3BF0125_var*
begin
//#UC START# *4FC8E5780345_4FC8E3BF0125_impl*
  if NOT Supports(anEntityBase, _EntityInterface_, f_Entity) then
    Raise Exception.Create('Interface unsupported!');
//#UC END# *4FC8E5780345_4FC8E3BF0125_impl*
end;//_atEntity_.Create

constructor _atEntity_.Create(const anEntity: _EntityInterface_);
//#UC START# *4FD0E3B80139_4FC8E3BF0125_var*
//#UC END# *4FD0E3B80139_4FC8E3BF0125_var*
begin
//#UC START# *4FD0E3B80139_4FC8E3BF0125_impl*
  f_Entity := anEntity;
//#UC END# *4FD0E3B80139_4FC8E3BF0125_impl*
end;//_atEntity_.Create

constructor _atEntity_.Create(const aNodeBase: INodeBase);
//#UC START# *5051EAD80280_4FC8E3BF0125_var*
  var
    l_Entity : IEntityBase;
//#UC END# *5051EAD80280_4FC8E3BF0125_var*
begin
//#UC START# *5051EAD80280_4FC8E3BF0125_impl*
  aNodeBase.GetEntity(l_Entity); // если не получится, то должно быть исключение ENoEntity
  Create(l_Entity);
//#UC END# *5051EAD80280_4FC8E3BF0125_impl*
end;//_atEntity_.Create

{$If not defined(DesignTimeLibrary)}
class function _atEntity_.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_4FC8E3BF0125_var*
//#UC END# *47A6FEE600FC_4FC8E3BF0125_var*
begin
//#UC START# *47A6FEE600FC_4FC8E3BF0125_impl*
  Result := true;
//#UC END# *47A6FEE600FC_4FC8E3BF0125_impl*
end;//_atEntity_.IsCacheable
{$IfEnd} //not DesignTimeLibrary

procedure _atEntity_.ClearFields;
//#UC START# *5000565C019C_4FC8E3BF0125_var*
//#UC END# *5000565C019C_4FC8E3BF0125_var*
begin
//#UC START# *5000565C019C_4FC8E3BF0125_impl*
  f_Entity := nil;
  //
  inherited;
//#UC END# *5000565C019C_4FC8E3BF0125_impl*
end;//_atEntity_.ClearFields

{$EndIf atEntity_imp}
