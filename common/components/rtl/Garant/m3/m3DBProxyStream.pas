unit m3DBProxyStream;
 {* Поток, знающий про базу, с которой он работает }

// Модуль: "w:\common\components\rtl\Garant\m3\m3DBProxyStream.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tm3DBProxyStream" MUID: (49BFBF3E00CD)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , l3ProxyStream
 , m3PrimDB
 , m3DBInterfaces
 , l3Interfaces
;

type
 Tm3DBProxyStream = class(Tl3ProxyStream)
  {* Поток, знающий про базу, с которой он работает }
  private
   f_DB: Tm3PrimDB;
    {* База, с которой работает поток }
   f_ID: Tm3DBStreamIndexEx;
    {* Идентификатор потока }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aStream: IStream;
    aDB: Tm3PrimDB;
    const anID: Tm3DBStreamIndexEx); reintroduce;
   class function Make(const aStream: IStream;
    aDB: Tm3PrimDB;
    const anID: Tm3DBStreamIndexEx): IStream; reintroduce;
    {* Создаёт обёртку }
  protected
   property DB: Tm3PrimDB
    read f_DB;
    {* База, с которой работает поток }
  public
   property ID: Tm3DBStreamIndexEx
    read f_ID;
    {* Идентификатор потока }
 end;//Tm3DBProxyStream

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

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
 {* Создаёт обёртку }
var
 l_Inst : Tm3DBProxyStream;
begin
 l_Inst := Create(aStream, aDB, anID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tm3DBProxyStream.Make

procedure Tm3DBProxyStream.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_49BFBF3E00CD_var*
//#UC END# *479731C50290_49BFBF3E00CD_var*
begin
//#UC START# *479731C50290_49BFBF3E00CD_impl*
 l3Free(f_DB);
 inherited;
//#UC END# *479731C50290_49BFBF3E00CD_impl*
end;//Tm3DBProxyStream.Cleanup

procedure Tm3DBProxyStream.ClearFields;
begin
 Finalize(f_ID);
 inherited;
end;//Tm3DBProxyStream.ClearFields

end.
