unit l3ProxyStream;
 {* Поток служащий обёрткой над другим потоком }

// Модуль: "w:\common\components\rtl\Garant\L3\l3ProxyStream.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3ProxyStream" MUID: (49BE68B201D1)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3BaseStream
 , l3Interfaces
 , Classes
;

type
 Tl3ProxyStream = class(Tl3Stream)
  {* Поток служащий обёрткой над другим потоком }
  private
   f_Inner: IStream;
    {* Поток, над которым мы оборачиваемся }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aStream: IStream); reintroduce;
   class function Make(const aStream: IStream): IStream; reintroduce;
    {* Создаёт обёртку над потоком }
   procedure CloseInner;
    {* Освобождает внутренний поток }
   function Read(var Buffer;
    Count: Integer): Integer; override;
   function Write(const Buffer;
    Count: Integer): Integer; override;
   function Seek(const Offset: Int64;
    Origin: TSeekOrigin): Int64; override;
 end;//Tl3ProxyStream

implementation

uses
 l3ImplUses
 , ComObj
 , l3Types
;

constructor Tl3ProxyStream.Create(const aStream: IStream);
//#UC START# *49BE699000B0_49BE68B201D1_var*
//#UC END# *49BE699000B0_49BE68B201D1_var*
begin
//#UC START# *49BE699000B0_49BE68B201D1_impl*
 Assert(aStream <> nil);
 inherited Create;
 f_Inner := aStream;
//#UC END# *49BE699000B0_49BE68B201D1_impl*
end;//Tl3ProxyStream.Create

class function Tl3ProxyStream.Make(const aStream: IStream): IStream;
 {* Создаёт обёртку над потоком }
var
 l_Inst : Tl3ProxyStream;
begin
 l_Inst := Create(aStream);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tl3ProxyStream.Make

procedure Tl3ProxyStream.CloseInner;
 {* Освобождает внутренний поток }
//#UC START# *49C0DA3F015D_49BE68B201D1_var*
//#UC END# *49C0DA3F015D_49BE68B201D1_var*
begin
//#UC START# *49C0DA3F015D_49BE68B201D1_impl*
 f_Inner := nil;
//#UC END# *49C0DA3F015D_49BE68B201D1_impl*
end;//Tl3ProxyStream.CloseInner

procedure Tl3ProxyStream.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_49BE68B201D1_var*
//#UC END# *479731C50290_49BE68B201D1_var*
begin
//#UC START# *479731C50290_49BE68B201D1_impl*
 f_Inner := nil;
 inherited;
//#UC END# *479731C50290_49BE68B201D1_impl*
end;//Tl3ProxyStream.Cleanup

function Tl3ProxyStream.Read(var Buffer;
 Count: Integer): Integer;
//#UC START# *49BE656C006E_49BE68B201D1_var*
//#UC END# *49BE656C006E_49BE68B201D1_var*
begin
//#UC START# *49BE656C006E_49BE68B201D1_impl*
 OleCheck(f_Inner.Read(@Buffer, Count, @Result));
//#UC END# *49BE656C006E_49BE68B201D1_impl*
end;//Tl3ProxyStream.Read

function Tl3ProxyStream.Write(const Buffer;
 Count: Integer): Integer;
//#UC START# *49BE658C0261_49BE68B201D1_var*
//#UC END# *49BE658C0261_49BE68B201D1_var*
begin
//#UC START# *49BE658C0261_49BE68B201D1_impl*
 OleCheck(f_Inner.Write(@Buffer, Count, @Result));
//#UC END# *49BE658C0261_49BE68B201D1_impl*
end;//Tl3ProxyStream.Write

function Tl3ProxyStream.Seek(const Offset: Int64;
 Origin: TSeekOrigin): Int64;
//#UC START# *49BE65E80020_49BE68B201D1_var*

 function ConvertOrigin: Integer;
 begin
  Case Origin of
   soBeginning:
    Result := STREAM_SEEK_SET;
   soCurrent:
    Result := STREAM_SEEK_CUR;
   soEnd:
    Result := STREAM_SEEK_END;
   else
   begin
    Result := -1;
    Assert(false);
   end;//else
  end;//Case Origin
 end;

//#UC END# *49BE65E80020_49BE68B201D1_var*
begin
//#UC START# *49BE65E80020_49BE68B201D1_impl*
 OleCheck(f_Inner.Seek(Offset, ConvertOrigin, Result));
//#UC END# *49BE65E80020_49BE68B201D1_impl*
end;//Tl3ProxyStream.Seek

end.
