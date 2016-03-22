unit m3CustomStream;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3CustomStream.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::m3::Streams::Tm3CustomStream
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  ActiveX,
  m3StorageInterfaces,
  m3BaseStream
  ;

type
 Tm3CustomStream = {abstract} class(Tm3BaseStream)
 private
 // private fields
   f_InnerStream : IStream;
    {* Поле для свойства InnerStream}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // overridden public methods
   procedure Commit(aFlags: Integer;
     var theReturn: hResult); override;
 public
 // public methods
   constructor Create(const aStream: IStream;
     anAccess: Tm3StoreAccess); reintroduce;
 protected
 // protected properties
   property InnerStream: IStream
     read f_InnerStream;
 end;//Tm3CustomStream

implementation

uses
  m3Exceptions
  ;

// start class Tm3CustomStream

constructor Tm3CustomStream.Create(const aStream: IStream;
  anAccess: Tm3StoreAccess);
//#UC START# *5480895501A0_53FDCE880154_var*
//#UC END# *5480895501A0_53FDCE880154_var*
begin
//#UC START# *5480895501A0_53FDCE880154_impl*
 Em3NilStream.Check(AStream <> nil, 'Пустой поток');
 Assert(AStream <> nil);
 inherited Create(anAccess);
 f_InnerStream := aStream;
//#UC END# *5480895501A0_53FDCE880154_impl*
end;//Tm3CustomStream.Create

procedure Tm3CustomStream.Cleanup;
//#UC START# *479731C50290_53FDCE880154_var*
//#UC END# *479731C50290_53FDCE880154_var*
begin
//#UC START# *479731C50290_53FDCE880154_impl*
 f_InnerStream := nil;
 inherited;
//#UC END# *479731C50290_53FDCE880154_impl*
end;//Tm3CustomStream.Cleanup

procedure Tm3CustomStream.Commit(aFlags: Integer;
  var theReturn: hResult);
//#UC START# *4FA280DB0288_53FDCE880154_var*
//#UC END# *4FA280DB0288_53FDCE880154_var*
begin
//#UC START# *4FA280DB0288_53FDCE880154_impl*
 if (f_InnerStream = nil) then
  theReturn := E_NOTIMPL
 else
  theReturn := f_InnerStream.Commit(aFlags); 
//#UC END# *4FA280DB0288_53FDCE880154_impl*
end;//Tm3CustomStream.Commit

procedure Tm3CustomStream.ClearFields;
 {-}
begin
 f_InnerStream := nil;
 inherited;
end;//Tm3CustomStream.ClearFields

end.