unit nevObjectHolder;

// Модуль: "w:\common\components\gui\Garant\Everest\nevObjectHolder.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , nevObjectHolderPrim
 , nevTools
 , nevBase
;

type
 TnevObjectHolder = class(TnevObjectHolderPrim)
  private
   f_Obj: InevObject;
  protected
   procedure DoInvalidateShape(const aShape: InevObject;
    aParts: TnevShapeParts); override;
   function GetTagReader: InevTagReader; override;
   function GetTagWriter: InevTagWriter; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   function GetObj: InevObject; override;
  public
   constructor Create(const anObject: InevObject); reintroduce;
 end;//TnevObjectHolder

implementation

uses
 l3ImplUses
 , l3SimpleObject
;

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
 {* Функция очистки полей объекта. }
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

{$If NOT Defined(DesignTimeLibrary)}
class function TnevObjectHolder.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_481866FC03E0_var*
//#UC END# *47A6FEE600FC_481866FC03E0_var*
begin
//#UC START# *47A6FEE600FC_481866FC03E0_impl*
 Result := true;
//#UC END# *47A6FEE600FC_481866FC03E0_impl*
end;//TnevObjectHolder.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

function TnevObjectHolder.GetObj: InevObject;
//#UC START# *48185EEB0234_481866FC03E0_var*
//#UC END# *48185EEB0234_481866FC03E0_var*
begin
//#UC START# *48185EEB0234_481866FC03E0_impl*
 Result := f_Obj;
//#UC END# *48185EEB0234_481866FC03E0_impl*
end;//TnevObjectHolder.GetObj

end.
