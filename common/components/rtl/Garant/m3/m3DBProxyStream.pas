unit m3DBProxyStream;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3$DB"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/m3/m3DBProxyStream.pas"
// Начат: 17.03.2009 18:19
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3$DB::m3DB::Tm3DBProxyStream
//
// Поток, знающий про базу, с которой он работает
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  l3Interfaces,
  m3DBInterfaces,
  l3ProxyStream,
  m3PrimDB
  ;

type
 Tm3DBProxyStream = class(Tl3ProxyStream)
  {* Поток, знающий про базу, с которой он работает }
 private
 // private fields
   f_DB : Tm3PrimDB;
    {* Поле для свойства DB}
   f_ID : Tm3DBStreamIndexEx;
    {* Поле для свойства ID}
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aStream: IStream;
    aDB: Tm3PrimDB;
    const anID: Tm3DBStreamIndexEx); reintroduce;
   class function Make(const aStream: IStream;
    aDB: Tm3PrimDB;
    const anID: Tm3DBStreamIndexEx): IStream; reintroduce;
     {* Создаёт обёртку }
 protected
 // protected properties
   property DB: Tm3PrimDB
     read f_DB;
     {* База, с которой работает поток }
 public
 // public properties
   property ID: Tm3DBStreamIndexEx
     read f_ID;
     {* Идентификатор потока }
 end;//Tm3DBProxyStream

implementation

uses
  SysUtils,
  l3Base
  ;

// start class Tm3DBProxyStream

constructor Tm3DBProxyStream.Create(const aStream: IStream;
  aDB: Tm3PrimDB;
  const anID: Tm3DBStreamIndexEx);
//#UC START# *49BFC03402A2_49BFBF3E00CD_var*
//#UC END# *49BFC03402A2_49BFBF3E00CD_var*
begin
//#UC START# *49BFC03402A2_49BFBF3E00CD_impl*
 Assert(aDB <> nil);
 Assert(anID.{$IfDef XE}rTm3DBStreamIndex.{$EndIf}rID >= 0);
 Assert(anID.{$IfDef XE}rTm3DBStreamIndex.{$EndIf}rIdx >= 0);
 Assert(anID.rVersion >= 0);
 inherited Create(aStream);
 f_ID := anID;
 l3Set(f_DB, aDB);
//#UC END# *49BFC03402A2_49BFBF3E00CD_impl*
end;//Tm3DBProxyStream.Create

class function Tm3DBProxyStream.Make(const aStream: IStream;
  aDB: Tm3PrimDB;
  const anID: Tm3DBStreamIndexEx): IStream;
var
 l_Inst : Tm3DBProxyStream;
begin
 l_Inst := Create(aStream, aDB, anID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure Tm3DBProxyStream.Cleanup;
//#UC START# *479731C50290_49BFBF3E00CD_var*
//#UC END# *479731C50290_49BFBF3E00CD_var*
begin
//#UC START# *479731C50290_49BFBF3E00CD_impl*
 l3Free(f_DB);
 inherited;
//#UC END# *479731C50290_49BFBF3E00CD_impl*
end;//Tm3DBProxyStream.Cleanup

procedure Tm3DBProxyStream.ClearFields;
 {-}
begin
 Finalize(f_ID);
 inherited;
end;//Tm3DBProxyStream.ClearFields

end.