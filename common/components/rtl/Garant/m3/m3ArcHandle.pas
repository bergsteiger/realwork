unit m3ArcHandle;

// Модуль: "w:\common\components\rtl\Garant\m3\m3ArcHandle.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tm3ArcHandle" MUID: (54539D300254)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3Persistent
 , ActiveX
;

type
 Tm3ArcHandleData = record
  Position: Int64;
  PositionInStream: Int64;
  DataSize: Integer;
 end;//Tm3ArcHandleData

 Tm3ArcHandle = class(Tm3Persistent)
  public
   Data: Tm3ArcHandleData;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   procedure Load(const aStream: IStream); override;
   procedure Save(const aStream: IStream); override;
 end;//Tm3ArcHandle

implementation

uses
 l3ImplUses
 , l3Base
 //#UC START# *54539D300254impl_uses*
 //#UC END# *54539D300254impl_uses*
;

procedure Tm3ArcHandle.Load(const aStream: IStream);
//#UC START# *542194B001E1_54539D300254_var*
//#UC END# *542194B001E1_54539D300254_var*
begin
//#UC START# *542194B001E1_54539D300254_impl*
  with Data do
   begin

    LoadBuff(AStream, @Position,SizeOf(Position));
    LoadBuff(AStream, @PositionInStream,SizeOf(PositionInStream));

    LoadBuff(AStream, @DataSize,SizeOf(DataSize));

   end;
//#UC END# *542194B001E1_54539D300254_impl*
end;//Tm3ArcHandle.Load

procedure Tm3ArcHandle.Save(const aStream: IStream);
//#UC START# *542194C102F7_54539D300254_var*
//#UC END# *542194C102F7_54539D300254_var*
begin
//#UC START# *542194C102F7_54539D300254_impl*
  with Data do
   begin

    SaveBuff(AStream, @Position,SizeOf(Position));
    SaveBuff(AStream, @PositionInStream,SizeOf(PositionInStream));

    SaveBuff(AStream, @DataSize,SizeOf(DataSize));

   end;
//#UC END# *542194C102F7_54539D300254_impl*
end;//Tm3ArcHandle.Save

procedure Tm3ArcHandle.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_54539D300254_var*
//#UC END# *479731C50290_54539D300254_var*
begin
//#UC START# *479731C50290_54539D300254_impl*
 inherited;
 l3FillChar(Data, SizeOf(Data));
//#UC END# *479731C50290_54539D300254_impl*
end;//Tm3ArcHandle.Cleanup

{$If NOT Defined(DesignTimeLibrary)}
class function Tm3ArcHandle.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_54539D300254_var*
//#UC END# *47A6FEE600FC_54539D300254_var*
begin
//#UC START# *47A6FEE600FC_54539D300254_impl*
 Result := true;
//#UC END# *47A6FEE600FC_54539D300254_impl*
end;//Tm3ArcHandle.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
