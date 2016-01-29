unit nevObjectHolder;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/nevObjectHolder.pas"
// Начат: 30.04.2008 16:34
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Document::TnevObjectHolder
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
  nevObjectHolderPrim,
  nevBase
  ;

type
 TnevObjectHolder = class(TnevObjectHolderPrim)
 private
 // private fields
   f_Obj : InevObject;
 protected
 // realized methods
   procedure DoInvalidateShape(const aShape: InevObject;
    aParts: TnevShapeParts); override;
   function GetTagReader: InevTagReader; override;
   function GetTagWriter: InevTagWriter; override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
   function GetObj: InevObject; override;
 public
 // public methods
   constructor Create(const anObject: InevObject); reintroduce;
 end;//TnevObjectHolder

implementation

uses
  l3SimpleObject
  ;

// start class TnevObjectHolder

constructor TnevObjectHolder.Create(const anObject: InevObject);
//#UC START# *481867C20088_481866FC03E0_var*
//#UC END# *481867C20088_481866FC03E0_var*
begin
//#UC START# *481867C20088_481866FC03E0_impl*
 inherited Create;
 f_Obj := anObject;
 f_Obj.AsObject.Owner := Self;
 //(f_Obj.AsObject As _Tl3SimpleObject).Owner := Self;
//#UC END# *481867C20088_481866FC03E0_impl*
end;//TnevObjectHolder.Create

procedure TnevObjectHolder.DoInvalidateShape(const aShape: InevObject;
  aParts: TnevShapeParts);
//#UC START# *4918253C0297_481866FC03E0_var*
//#UC END# *4918253C0297_481866FC03E0_var*
begin
//#UC START# *4918253C0297_481866FC03E0_impl*
 Assert(false);
//#UC END# *4918253C0297_481866FC03E0_impl*
end;//TnevObjectHolder.DoInvalidateShape

function TnevObjectHolder.GetTagReader: InevTagReader;
//#UC START# *491829480128_481866FC03E0_var*
//#UC END# *491829480128_481866FC03E0_var*
begin
//#UC START# *491829480128_481866FC03E0_impl*
 Result := nil;
 Assert(false);
//#UC END# *491829480128_481866FC03E0_impl*
end;//TnevObjectHolder.GetTagReader

function TnevObjectHolder.GetTagWriter: InevTagWriter;
//#UC START# *491829620101_481866FC03E0_var*
//#UC END# *491829620101_481866FC03E0_var*
begin
//#UC START# *491829620101_481866FC03E0_impl*
 Result := nil;
 Assert(false);
//#UC END# *491829620101_481866FC03E0_impl*
end;//TnevObjectHolder.GetTagWriter

procedure TnevObjectHolder.Cleanup;
//#UC START# *479731C50290_481866FC03E0_var*
//#UC END# *479731C50290_481866FC03E0_var*
begin
//#UC START# *479731C50290_481866FC03E0_impl*
 if (f_Obj <> nil) then
 begin
  f_Obj.AsObject.Owner := nil;
  //(f_Obj.AsObject As _Tl3SimpleObject).Owner := nil;
 end;//f_Obj <> nil
 f_Obj := nil;
 inherited;
//#UC END# *479731C50290_481866FC03E0_impl*
end;//TnevObjectHolder.Cleanup

{$If not defined(DesignTimeLibrary)}
class function TnevObjectHolder.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_481866FC03E0_var*
//#UC END# *47A6FEE600FC_481866FC03E0_var*
begin
//#UC START# *47A6FEE600FC_481866FC03E0_impl*
 Result := true;
//#UC END# *47A6FEE600FC_481866FC03E0_impl*
end;//TnevObjectHolder.IsCacheable
{$IfEnd} //not DesignTimeLibrary

function TnevObjectHolder.GetObj: InevObject;
//#UC START# *48185EEB0234_481866FC03E0_var*
//#UC END# *48185EEB0234_481866FC03E0_var*
begin
//#UC START# *48185EEB0234_481866FC03E0_impl*
 Result := f_Obj;
//#UC END# *48185EEB0234_481866FC03E0_impl*
end;//TnevObjectHolder.GetObj

end.