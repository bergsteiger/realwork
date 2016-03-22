unit m3ArcHandle;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3ArcHandle.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::m3::ArchiveStreams::Tm3ArcHandle
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3Persistent,
  ActiveX
  ;

type
 Tm3ArcHandleData = record
   Position : Int64;
   PositionInStream : Int64;
   DataSize : Integer;
 end;//Tm3ArcHandleData

 Tm3ArcHandle = class(Tm3Persistent)
 protected
 // realized methods
   procedure Load(const aStream: IStream); override;
   procedure Save(const aStream: IStream); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
     {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} //not DesignTimeLibrary
 public
 // public fields
   Data : Tm3ArcHandleData;
 end;//Tm3ArcHandle

implementation

uses
  l3Base
  ;

// start class Tm3ArcHandle

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
//#UC START# *479731C50290_54539D300254_var*
//#UC END# *479731C50290_54539D300254_var*
begin
//#UC START# *479731C50290_54539D300254_impl*
 inherited;
 l3FillChar(Data, SizeOf(Data));
//#UC END# *479731C50290_54539D300254_impl*
end;//Tm3ArcHandle.Cleanup

{$If not defined(DesignTimeLibrary)}
class function Tm3ArcHandle.IsCacheable: Boolean;
//#UC START# *47A6FEE600FC_54539D300254_var*
//#UC END# *47A6FEE600FC_54539D300254_var*
begin
//#UC START# *47A6FEE600FC_54539D300254_impl*
 Result := true;
//#UC END# *47A6FEE600FC_54539D300254_impl*
end;//Tm3ArcHandle.IsCacheable
{$IfEnd} //not DesignTimeLibrary

end.