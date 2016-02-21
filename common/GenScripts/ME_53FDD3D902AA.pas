unit m3BuffStream;

// Модуль: "w:\common\components\rtl\Garant\m3\m3BuffStream.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3CustomStream
 , l3Memory
 , ActiveX
 , Classes
;

type
 Tm3BuffStream = class(Tm3CustomStream)
  private
   FRealSize: Int64;
   f_Buff: Tl3BufferStreamMemoryPool;
   FBuffSize: Integer;
   FBuffCurPos: Int64;
   FBuffEndPos: Int64;
   FBuffOffset: Integer;
   FBuffModifed: LongBool;
  private
   procedure LoadBuff;
   procedure SaveBuff;
  protected
   procedure Release; override;
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure BeforeRelease; override;
   procedure DoRead(aBuff: Pointer;
    aSize: Integer;
    var theResult: Integer;
    var theReturn: hResult); override;
   procedure DoWrite(aBuff: Pointer;
    aSize: Integer;
    var theResult: Integer;
    var theReturn: hResult); override;
   procedure DoSeek(anOffset: Int64;
    anOrigin: TSeekOrigin;
    var theResult: Int64;
    var theReturn: hResult); override;
   procedure DoSetSize(aSize: Int64;
    var theReturn: hResult); override;
   function DoGetSize: Int64; override;
  public
   constructor Create(const aStream: IStream); reintroduce;
   class function Make(const aStream: IStream): IStream; reintroduce;
   procedure Commit(aFlags: Integer;
    var theReturn: hResult); override;
 end;//Tm3BuffStream

implementation

uses
 l3ImplUses
 , m2COMLib
 , ComObj
 , SysUtils
 , m2S32Lib
 , m2S64Lib
;

procedure Tm3BuffStream.LoadBuff;
//#UC START# *5480693401AA_53FDD3D902AA_var*
 var
        LResult:                  LongInt;
//#UC END# *5480693401AA_53FDD3D902AA_var*
begin
//#UC START# *5480693401AA_53FDD3D902AA_impl*

  if (FBuffCurPos = FBuffEndPos)
   then
    begin

     m2COMSetPosition(FBuffCurPos, InnerStream);

     OleCheck(InnerStream.Read(f_Buff.AsPointer,FBuffSize,@LResult));

     FBuffEndPos:=FBuffCurPos+Int64(LResult);
     FBuffOffset:=0;

     FBuffModifed:=False;

    end;

//#UC END# *5480693401AA_53FDD3D902AA_impl*
end;//Tm3BuffStream.LoadBuff

procedure Tm3BuffStream.SaveBuff;
//#UC START# *5480694400B8_53FDD3D902AA_var*
 var
        LResult:                  LongInt;
//#UC END# *5480694400B8_53FDD3D902AA_var*
begin
//#UC START# *5480694400B8_53FDD3D902AA_impl*

  if FBuffModifed
   then
    begin

     m2COMSetPosition(FBuffCurPos, InnerStream);

     OleCheck(InnerStream.Write(f_Buff.AsPointer,LongInt(FBuffEndPos-FBuffCurPos),@LResult));

     FBuffCurPos:=FBuffCurPos+Int64(LResult);
     FBuffOffset:=0;

     FBuffModifed:=False;

    end
   else
    begin

     FBuffCurPos:=FBuffEndPos;
     FBuffOffset:=0;

    end;

//#UC END# *5480694400B8_53FDD3D902AA_impl*
end;//Tm3BuffStream.SaveBuff

constructor Tm3BuffStream.Create(const aStream: IStream);
//#UC START# *548069970154_53FDD3D902AA_var*
//#UC END# *548069970154_53FDD3D902AA_var*
begin
//#UC START# *548069970154_53FDD3D902AA_impl*
  inherited Create(AStream,m2COMModeAccess(m2COMGetStatStgMode(AStream)));
  FRealSize := m2COMGetSize(InnerStream);
  FBuffCurPos:=m2COMGetPosition(InnerStream);
  FBuffEndPos:=FBuffCurPos;

  if (f_Buff = nil) then
   f_Buff := Tl3BufferStreamMemoryPool.Create;
  FBuffSize := f_Buff.Size;
  LoadBuff;
//#UC END# *548069970154_53FDD3D902AA_impl*
end;//Tm3BuffStream.Create

class function Tm3BuffStream.Make(const aStream: IStream): IStream;
var
 l_Inst : Tm3BuffStream;
begin
 l_Inst := Create(aStream);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tm3BuffStream.Make

procedure Tm3BuffStream.Release;
//#UC START# *479F2AFB0397_53FDD3D902AA_var*
//#UC END# *479F2AFB0397_53FDD3D902AA_var*
begin
//#UC START# *479F2AFB0397_53FDD3D902AA_impl*
 // не станем этого делать в Cleanup,
 //пускай кеширует с буфером, съэкономим на распределении памяти
 FreeAndNil(f_Buff);
 inherited;
//#UC END# *479F2AFB0397_53FDD3D902AA_impl*
end;//Tm3BuffStream.Release

{$If NOT Defined(DesignTimeLibrary)}
class function Tm3BuffStream.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_53FDD3D902AA_var*
//#UC END# *47A6FEE600FC_53FDD3D902AA_var*
begin
//#UC START# *47A6FEE600FC_53FDD3D902AA_impl*
 //Result := false;
 Result := True;
//#UC END# *47A6FEE600FC_53FDD3D902AA_impl*
end;//Tm3BuffStream.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure Tm3BuffStream.BeforeRelease;
//#UC START# *49BFC98902FF_53FDD3D902AA_var*
//#UC END# *49BFC98902FF_53FDD3D902AA_var*
begin
//#UC START# *49BFC98902FF_53FDD3D902AA_impl*
 SaveBuff;
 inherited;
//#UC END# *49BFC98902FF_53FDD3D902AA_impl*
end;//Tm3BuffStream.BeforeRelease

procedure Tm3BuffStream.DoRead(aBuff: Pointer;
 aSize: Integer;
 var theResult: Integer;
 var theReturn: hResult);
//#UC START# *4FA27CF501C4_53FDD3D902AA_var*
 var
  lSize : LongInt;
//#UC END# *4FA27CF501C4_53FDD3D902AA_var*
begin
//#UC START# *4FA27CF501C4_53FDD3D902AA_impl*
  if SUCCEEDED(theReturn) then
  begin
   while (theResult <> ASize) do
    begin
     LoadBuff;
     LSize:=LongInt(FBuffEndPos-(FBuffCurPos+Int64(FBuffOffset)));

     if (lSize = 0) then
      Break
     else
      LSize:=LongInt(m2S32Min(LSize,(ASize-theResult)));

     f_Buff.Read(FBuffOffset, PAnsiChar(aBuff) + theResult, LSize);

     Inc(FBuffOffset,LSize);
     Inc(theResult,LSize);

     if ((FBuffCurPos+Int64(FBuffOffset)) = FBuffEndPos) then
      SaveBuff;
    end;
  end;
//#UC END# *4FA27CF501C4_53FDD3D902AA_impl*
end;//Tm3BuffStream.DoRead

procedure Tm3BuffStream.DoWrite(aBuff: Pointer;
 aSize: Integer;
 var theResult: Integer;
 var theReturn: hResult);
//#UC START# *4FA27D310344_53FDD3D902AA_var*
 var
  LSize : LongInt;
//#UC END# *4FA27D310344_53FDD3D902AA_var*
begin
//#UC START# *4FA27D310344_53FDD3D902AA_impl*
  if SUCCEEDED(theReturn) then
  begin
   while (theResult <> ASize) do
    begin
     LoadBuff;

     lSize := FBuffSize - FBuffOffset;

     if (lSize = 0) then
      Break
     else
      LSize:=LongInt(m2S32Min(LSize,(ASize-theResult)));

     f_Buff.Write(FBuffOffset, PAnsiChar(aBuff) + theResult, LSize);

     Inc(FBuffOffset,LSize);
     Inc(theResult,LSize);

     FBuffModifed:=True;

     FBuffEndPos:=m2S64Max(FBuffEndPos,(FBuffCurPos+Int64(FBuffOffset)));

     FRealSize:=m2S64Max(FBuffEndPos,FRealSize);

     if (FBuffOffset = FBuffSize) then
      SaveBuff;
    end;
  end;
//#UC END# *4FA27D310344_53FDD3D902AA_impl*
end;//Tm3BuffStream.DoWrite

procedure Tm3BuffStream.DoSeek(anOffset: Int64;
 anOrigin: TSeekOrigin;
 var theResult: Int64;
 var theReturn: hResult);
//#UC START# *4FA27D5302C5_53FDD3D902AA_var*

 procedure __Seek(APosition: Int64;
                  var   theResult: Int64);
 begin//__Seek
  if ((APosition >= 0) and (APosition <= FRealSize)) then
  begin
   if (APosition <> (FBuffCurPos+Int64(FBuffOffset))) then
   begin
    if ((APosition >= FBuffCurPos) and (APosition < FBuffEndPos)) then
       FBuffOffset:=LongInt(APosition-FBuffCurPos)
    else
    begin
     SaveBuff;
     FBuffCurPos:=APosition;
     FBuffEndPos:=FBuffCurPos;
    end;//((APosition >= FBuffCurPos) and (APosition < FBuffEndPos))
   end;//APosition <> (FBuffCurPos+Int64(FBuffOffset))
  end//((APosition >= 0) and (APosition <= FRealSize))
  else
   Exit;
  theResult:=APosition;
 end;//__Seek

//#UC END# *4FA27D5302C5_53FDD3D902AA_var*
begin
//#UC START# *4FA27D5302C5_53FDD3D902AA_impl*
 if SUCCEEDED(theReturn) then
  case anOrigin of
   soBeginning:
    __Seek(anOffset,theResult);
   soCurrent:
    __Seek(anOffset+FBuffCurPos+Int64(FBuffOffset),theResult);
   soEnd:
    __Seek(anOffset+FRealSize,theResult);
   else
    OleError(E_UNEXPECTED);
  end;//case AOrigin
//#UC END# *4FA27D5302C5_53FDD3D902AA_impl*
end;//Tm3BuffStream.DoSeek

procedure Tm3BuffStream.DoSetSize(aSize: Int64;
 var theReturn: hResult);
//#UC START# *4FA27DCD02B4_53FDD3D902AA_var*
//#UC END# *4FA27DCD02B4_53FDD3D902AA_var*
begin
//#UC START# *4FA27DCD02B4_53FDD3D902AA_impl*

  if SUCCEEDED(theReturn)
   then
    begin

     SaveBuff;

     m2COMSetSize(ASize, InnerStream);

     FBuffCurPos := ASize;
     FBuffEndPos := FBuffCurPos;

     FRealSize := FBuffEndPos;

    end;

//#UC END# *4FA27DCD02B4_53FDD3D902AA_impl*
end;//Tm3BuffStream.DoSetSize

function Tm3BuffStream.DoGetSize: Int64;
//#UC START# *4FA2802E0231_53FDD3D902AA_var*
//#UC END# *4FA2802E0231_53FDD3D902AA_var*
begin
//#UC START# *4FA2802E0231_53FDD3D902AA_impl*
 Result := FRealSize;
//#UC END# *4FA2802E0231_53FDD3D902AA_impl*
end;//Tm3BuffStream.DoGetSize

procedure Tm3BuffStream.Commit(aFlags: Integer;
 var theReturn: hResult);
//#UC START# *4FA280DB0288_53FDD3D902AA_var*
//#UC END# *4FA280DB0288_53FDD3D902AA_var*
begin
//#UC START# *4FA280DB0288_53FDD3D902AA_impl*
 SaveBuff;
 inherited;
//#UC END# *4FA280DB0288_53FDD3D902AA_impl*
end;//Tm3BuffStream.Commit

end.
