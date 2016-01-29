unit m3ArcCla;
{* Архивированный поток. }

// $Id: m3arccla.pas,v 1.53 2014/12/08 13:07:44 lulin Exp $

// $Log: m3arccla.pas,v $
// Revision 1.53  2014/12/08 13:07:44  lulin
// - рисуем на модели.
//
// Revision 1.52  2014/12/05 17:49:52  lulin
// - объединяем стримы.
//
// Revision 1.51  2014/12/05 14:56:06  lulin
// - рисуем на модели.
//
// Revision 1.50  2014/12/05 13:52:06  lulin
// - рисуем на модели.
//
// Revision 1.49  2014/12/04 16:59:28  lulin
// - рисуем на модели.
//
// Revision 1.48  2014/11/06 17:05:10  lulin
// - перетряхиваем код.
//
// Revision 1.47  2014/11/06 16:09:53  lulin
// - перетряхиваем код.
//
// Revision 1.46  2014/11/06 13:33:17  lulin
// - перетряхиваем код.
//
// Revision 1.45  2014/11/06 12:16:33  lulin
// - перетряхиваем код.
//
// Revision 1.44  2014/11/05 12:39:36  lulin
// - перетряхиваем код.
//
// Revision 1.43  2014/10/31 17:42:58  lulin
// - перетряхиваем код.
//
// Revision 1.42  2014/10/31 14:14:30  lulin
// - перетряхиваем код.
//
// Revision 1.41  2014/09/23 16:59:33  lulin
// - переносим на модель.
//
// Revision 1.40  2014/09/23 16:20:31  lulin
// - переносим на модель.
//
// Revision 1.39  2014/09/01 14:20:33  lulin
// - вычищаем мусор.
//
// Revision 1.38  2014/08/29 11:22:08  lulin
// - заменяем условную директиву на переменную.
//
// Revision 1.37  2014/08/28 16:52:03  lulin
// - избавляемся от динамического распределения памяти.
//
// Revision 1.36  2014/08/28 16:21:33  lulin
// - избавляемся от динамического распределения памяти.
//
// Revision 1.35  2014/08/28 13:53:17  lulin
// - переносим Tm3CustomHeaderStream на модель.
//
// Revision 1.34  2014/08/28 13:17:55  lulin
// - переносим Tm3CustomHeaderStream на модель.
//
// Revision 1.33  2014/08/28 11:26:46  lulin
// - переносим Tm3CustomHeaderStream на модель.
//
// Revision 1.32  2014/08/28 10:30:01  lulin
// - переносим Tm3CustomHeaderStream на модель.
//
// Revision 1.31  2014/08/27 13:27:48  lulin
// - выпиливаем Tm3CustomHeaderStream в отдельный файл.
//
// Revision 1.30  2014/05/28 07:06:55  lulin
// - чистим код.
//
// Revision 1.29  2013/07/08 16:43:18  lulin
// - выделяем работу с размером куска памяти.
//
// Revision 1.28  2012/11/01 09:43:31  lulin
// - забыл точку с запятой.
//
// Revision 1.27  2012/11/01 07:45:58  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.26  2012/11/01 07:09:33  lulin
// - вычищаем мусор.
//
// Revision 1.25  2012/05/04 10:04:36  lulin
// {RequestLink:361038156}
//
// Revision 1.24  2012/05/04 08:31:15  lulin
// {RequestLink:361038156}
//
// Revision 1.23  2012/01/12 12:08:31  lulin
// {RequestLink:326769483}
// - опираемся на поданную длину буфера для распаковки.
//
// Revision 1.22  2012/01/12 08:57:01  lulin
// {RequestLink:326769483}
// - очищаем распределённые буфера.
//
// Revision 1.21  2012/01/11 18:03:07  lulin
// {RequestLink:326769483}
// - чистка кода.
//
// Revision 1.20  2012/01/11 17:30:01  lulin
// {RequestLink:326769483}
//
// Revision 1.19  2012/01/11 12:34:18  lulin
// - чистим код и вставляем проверки.
//
// Revision 1.18  2011/12/28 11:13:06  lulin
// {RequestLink:325256237}
//
// Revision 1.17  2011/12/28 10:04:39  lulin
// {RequestLink:325257155}
// - рисуем интерфейс на модели.
//
// Revision 1.16  2011/12/28 09:29:10  lulin
// {RequestLink:325257155}
// - чистим код.
//
// Revision 1.15  2011/12/27 15:34:56  lulin
// {RequestLink:324571064}
// - аккуратнее чистим данные перед положением объекта в кеш.
//
// Revision 1.14  2011/10/05 11:14:50  voba
// - k : 281525254 Борьба с утечками
//
// Revision 1.13  2011/09/26 12:16:20  lulin
// {RequestLink:287220465}.
// - дружим разархивирующий поток с кешом.
//
// Revision 1.12  2009/07/20 11:22:23  lulin
// - заставляем работать F1 после - {RequestLink:141264340}. №7, 32, 33.
//
// Revision 1.11  2009/03/19 16:28:30  lulin
// [$139443095].
//
// Revision 1.10  2009/03/12 19:08:25  lulin
// - <K>: 138969458. Чистка устаревшего кода.
//
// Revision 1.9  2008/05/05 10:37:08  voba
// - избавлялся от Hint
//
// Revision 1.8  2008/04/16 10:53:00  lulin
// - синхронизируем список параметров.
//
// Revision 1.7  2008/03/21 12:45:15  lulin
// - убрал лишние проверки.
//
// Revision 1.6  2008/03/21 12:30:41  lulin
// - удаляем излишний подсчёт CRC.
//
// Revision 1.5  2008/02/01 15:14:56  lulin
// - избавляемся от излишней универсальности списков.
//
// Revision 1.4  2006/08/29 11:13:46  fireton
// - bug fix: Tm3ArcDeflateStream.Seek - если размер стрима неизвестен, возвращаем в качестве размера текущую позицию (только при Seek(0, soEnd))
//
// Revision 1.3  2005/02/14 15:12:01  lulin
// - изменены сигнатуры методов.
//
// Revision 1.2  2004/09/21 11:22:27  lulin
// - Release заменил на Cleanup.
//
// Revision 1.1  2004/09/02 08:09:48  law
// - cleanup.
//
// Revision 1.14  2004/05/27 14:32:17  law
// - new methods: _Tl3_CBase.IsCacheable, _NeedStoreInPool.
//
// Revision 1.13  2002/04/05 14:13:33  law
// - optimization.
//
// Revision 1.12  2002/03/12 14:07:39  law
// - new behavior: в списках убран контроль CRC.
//
// Revision 1.11  2002/02/26 15:48:10  law
// - optimization: попытка оптимизации путем уменьшения фрагментации выделяемой памяти.
//
// Revision 1.10  2002/01/18 17:32:41  law
// - cleanup.
//
// Revision 1.9  2002/01/17 18:41:33  law
// - new behavior: сделал логику _Tm3BaseHandleList более похожей на Tl3VList.
//
// Revision 1.8  2002/01/10 16:29:18  law
// - try to optimize: получение размера потока без Seek.
//
// Revision 1.7  2001/11/29 17:02:43  law
// - new directive: _m3NeedStorageFixer.
//
// Revision 1.6  2001/11/29 15:46:16  law
// - bug fix: исправляем некорректное поведение индексатора после прикручивания архивирования потоков. Временная копия. Пока не работает.
//
// Revision 1.5  2001/11/02 09:39:54  law
// - optimization: на основе Tl3MemoryChain.
//
// Revision 1.4  2001/11/01 14:57:24  law
// - change: изменен формат вызова метода Seek.
//
// Revision 1.3  2001/10/26 17:43:32  law
// - comments: xHelpGen.
//

{$I m3Define.inc}

 interface


uses
 Windows,
 SysUtils,

 Classes,

 ActiveX,
 COMObj,

 m1LZOLib,

 m2AddDbg,
 m2AddPrc,
 m2S32Lib,
 m2S64Lib,
 m2MEMLib,
 m2HASLib,
 m2COMLib,

 m3BaseArcStream,
 m3ArcHandleList
 ;


type
 Pm3ArcClaBody = ^Tm3ArcClaBody;
 Tm3ArcClaBody = packed array [0..High(LongInt)-Succ(2*SizeOf(LongInt))] of AnsiChar;

 Pm3ArcClaBuff = ^Tm3ArcClaBuff;
 Tm3ArcClaBuff = packed record
                  RBodyOffset: LongInt;
                  RBodyCRC: LongInt;
                  RBody: Tm3ArcClaBody;
                 end;

 Pm3ArcClaHandle = ^Tm3ArcClaHandle;
 Tm3ArcClaHandle = packed record
                    ROrigSize: LongInt;
                    ROrigBuff: Pm3ArcClaBuff;
                    RCompSize: LongInt;
                    RCompBuff: Pm3ArcClaBuff;
                    RReadEOF: LongBool;
                   end;//Tm3ArcClaHandle


 Tm3ArcInflateStream = class(Tm3BaseArcStream)
  {* Абстрактный распаковывающий поток. }
  private
   _Status : LongWord;

   FHandle:        Pm3ArcClaHandle;
   FArcList:       Tm3ArcHandleList;
   FArcListLoaded: LongBool;
   FPosition:      Int64;

   function  InitProc00000001(const ABitMask: LongWord): LongWord;
   procedure DoneProc00000001;
   function  InitProc00000002(const ABitMask: LongWord): LongWord;
   procedure DoneProc00000002;
   function  InitProc00000004(const ABitMask: LongWord): LongWord;
   procedure DoneProc00000004;

   procedure ReadBuff(const ABuff: Pointer;
                      const ASize: LongInt);
   procedure InflateInit;
   procedure Inflate(const ABuff: Pointer; var ASize: LongInt);
   procedure InflateDone;

  protected
   function  InflateBuff(const ADest: Pointer;
                         var   ADLen: LongInt;
                         const ASour: Pointer;
                         const ASLen: LongInt): LongBool; virtual; abstract;

   function  InflateWorkSize(const ASize: LongInt): LongInt; virtual; abstract;

   procedure DoRead(ABuff: Pointer;
                  ASize: LongInt;
                  var   AResult: LongInt;
                  var   AReturn: HRESULT); override;

   procedure DoSeek(AOffset     : Int64;
                  AOrigin     : TSeekOrigin;
                  var AResult : Int64;
                  var AReturn : HRESULT
                 ); override;

   procedure DoSetSize(ASize: Int64;
                     var   AReturn: HRESULT
                    ); override;

   function DoGetPosition: Int64;
     override;
     {-}
   function DoGetSize: Int64;
     override;
     {-}
   procedure Cleanup;
     override;
     {-}
   public
    constructor Create(const AStream: IStream);
     reintroduce;
     {-}
 end;//Tm3ArcInflateStream

 Tm3ArcDeflateStream = class(Tm3BaseArcStream)
   {* Абстрактный запаковывающий поток. }
  private
   _Status:                LongWord;
   FHandle:                Pm3ArcClaHandle;
   FArcList:               Tm3ArcHandleList;
   FPosition:              Int64;
   FPositionOfData:        Int64;

   function  InitProc00000001(const ABitMask: LongWord): LongWord;
   procedure DoneProc00000001;
   function  InitProc00000002(const ABitMask: LongWord): LongWord;
   procedure DoneProc00000002;
   function  InitProc00000004(const ABitMask: LongWord): LongWord;
   procedure DoneProc00000004;
   procedure WriteBuff(const ABuff: Pointer;
                       const ABLen: LongInt;
                       const AOLen: LongInt);
   procedure DeflateInit;

   procedure Deflate(const ABuff: Pointer; const ASize: LongInt);

   procedure DeflateDone;

 protected
   function  DeflateBuff(const ADest: Pointer;
                         var   ADLen: Integer;
                         const ASour: Pointer;
                         const ASLen: Integer): LongBool; virtual; abstract;

   function  DeflateWorkSize(const ASize: LongInt): LongInt; virtual; abstract;

   procedure DoWrite(ABuff: Pointer;
                   ASize: LongInt;
                   var   AResult: LongInt;
                   var   AReturn: HRESULT
                  ); override;

   procedure DoSeek (AOffset     : Int64;
                   AOrigin     : TSeekOrigin;
                   var AResult : Int64;
                   var AReturn : HRESULT
                  ); override;

   procedure DoSetSize(ASize: Int64;
                     var   AReturn: HRESULT
                    ); override;

  function DoGetSize: Int64;
    override;
    {-}
  procedure Cleanup;
    override;
    {-}
 public
  constructor Create(const AStream: IStream);
    reintroduce;
    {-}
  end;//Tm3ArcDeflateStream

Tm3LZOInflateStream=      class(Tm3ArcInflateStream)
 {* Распаковывающий поток по алгоритму LZO. }
 protected
  function InflateBuff (const ADest: Pointer;
                        var   ADLen: LongInt;
                        const ASour: Pointer;
                        const ASLen: LongInt): LongBool; override;
  function InflateWorkSize(const ASize: LongInt): LongInt; override;
 public
  class function MakeInterface(const AStream: IStream): IStream;
 end;//Tm3LZOInflateStream

Tm3LZODeflateStream=      class(Tm3ArcDeflateStream)
 {* Запаковывающий поток по алгоритму LZO. }
 protected
  function DeflateBuff (const ADest: Pointer;
                        var   ADLen: Integer;
                        const ASour: Pointer;
                        const ASLen: Integer): LongBool; override;
  function DeflateWorkSize(const ASize: LongInt): LongInt; override;
 public
  class function MakeInterface(const AStream: IStream): IStream;
 end;//Tm3LZODeflateStream

const
  m3OrigSize = $00008000;

implementation

uses
 l3Base,
 l3MemorySizeUtils,
 l3Memory,

 m3ArcHandle
 ;

var
 m3ArcBuffers: Pl3MemoryChain = nil;
 m3ArcHandleBuffers: Pl3MemoryChain = nil;

// Tm3ArcInflateStream

 function    Tm3ArcInflateStream.InitProc00000001(const ABitMask: LongWord): LongWord;
 begin
  FArcList := Tm3ArcHandleList.Create;
  Result := ABitMask;
 end;

 procedure   Tm3ArcInflateStream.DoneProc00000001;
 begin
  FreeAndNil(FArcList);
 end;

function Tm3ArcInflateStream.InitProc00000002(const ABitMask: LongWord): LongWord;
begin
 m3ArcHandleBuffers^.AllocItemZ(Pointer(FHandle));
 Result := ABitMask;
end;

 procedure   Tm3ArcInflateStream.DoneProc00000002(
                                                 );
 begin
  m3ArcHandleBuffers^.FreeItem(Pointer(FHandle));
 end;

 function    Tm3ArcInflateStream.InitProc00000004(const ABitMask: LongWord
                                                 ): LongWord;
 begin
  InflateInit;
  Result := ABitMask;
 end;

 procedure   Tm3ArcInflateStream.DoneProc00000004;
 begin
  InflateDone;
 end;

 procedure   Tm3ArcInflateStream.ReadBuff(const ABuff: Pointer;
                                          const ASize: LongInt
                                         );
 begin
  m2COMReadBuffer(InnerStream,ABuff^,ASize);
 end;

 procedure   Tm3ArcInflateStream.InflateInit(
                                            );
 begin

  with FHandle^ do
   begin

    ROrigSize := m3OrigSize;
    RCompSize := InflateWorkSize(ROrigSize);

    m3ArcBuffers^.AllocItemZ(Pointer(ROrigBuff));
     try

      ROrigBuff^.RBodyOffset := 0;
      ROrigBuff^.RBodyCRC := 0;

      m3ArcBuffers^.AllocItemZ(Pointer(RCompBuff),SizeOf(RCompBuff^)-SizeOf(RCompBuff^.RBody)+RCompSize);

      RCompBuff^.RBodyOffset := 0;
      RCompBuff^.RBodyCRC := 0;

     except

      m3ArcBuffers^.FreeItem(Pointer(ROrigBuff));

      raise;

     end;

    RReadEOF := False;

   end;

 end;

procedure   Tm3ArcInflateStream.Inflate(const ABuff: Pointer;
                                        var   ASize: LongInt
                                       );
var
       //LBodyCRC:                 LongInt;
       //LCalcCRC:                 LongInt;
       LDecompress:              LongInt;
       LOffset:                  LongInt;
       LSize:                    LongInt;
begin
 Assert(FHandle <> nil);
 with FHandle^ do
 begin
  Assert(RCompBuff <> nil);
  with RCompBuff^ do
  begin
   LOffset := 0;
   while (((ASize <> 0) or (ABuff = nil)) and not(RReadEOF)) do
   begin
    if ((ROrigBuff^.RBodyOffset = RBodyOffset) or (ABuff = nil)) then
    begin
     LSize := SizeOf(RBodyOffset);
     ReadBuff(RCompBuff,LSize);
     if (RBodyOffset = 0) then
     begin
      RReadEOF := True;
      Break;
     end;//RBodyOffset = 0
     if ((LongWord(RBodyOffset) and $80000000) <> 0) then
     begin
      LSize := RBodyOffset and $7fffffff;
      RBodyOffset := LSize-SizeOf(RBodyCRC);
      with ROrigBuff^ do
      begin
       ReadBuff(Pointer(LongInt(ROrigBuff)+SizeOf(RBodyOffset)),LSize);
       {!}//Dec(LSize,SizeOf(RBodyCRC));
       {!}//LBodyCRC := RBodyCRC;
       {!}//LCalcCRC := 0;{m2HASUpdate32(LSize,@RBody,LSize,Cm2HASVersionCRC);}
      end;//with ROrigBuff^
      {!}{m2CheckValue((LBodyCRC = LCalcCRC) or (LBodyCRC = 0));}
     end//((LongWord(RBodyOffset) and $80000000) <> 0)
     else
     begin
      LSize := RBodyOffset;
      ReadBuff(Pointer(LongInt(RCompBuff)+SizeOf(RBodyOffset)),LSize);
      FHandle^.RCompBuff^.RBodyCRC := 0;
      // - чистим, чтобы l3MemorySize "не думала" (ОПА!!!) что это такой дикий размер
      Dec(LSize,SizeOf(RBodyCRC));
      {!}//LBodyCRC := RBodyCRC;
      {!}//LCalcCRC := 0;{m2HASUpdate32(LSize,@RBody,LSize,Cm2HASVersionCRC);}
      {!}{m2CheckValue((LBodyCRC = LCalcCRC) or (LBodyCRC = 0));}
      Assert(ROrigBuff <> nil);
      Assert(@ROrigBuff^.RBody <> nil);
      Assert(@RBody <> nil);
      //LDecompress := 0;
      LDecompress := l3MemorySize(ROrigBuff) - SizeOf(ROrigBuff.RBodyOffset) - SizeOf(ROrigBuff.RBodyCRC);
      m2CheckValue(InflateBuff(@ROrigBuff^.RBody,LDecompress,@RBody,LSize));
      RBodyOffset := LDecompress;
     end;//((LongWord(RBodyOffset) and $80000000) <> 0)
     ROrigBuff^.RBodyOffset := 0;
    end;//((ROrigBuff^.RBodyOffset = RBodyOffset) or (ABuff = nil))
    
    if (ABuff = nil) then
     Break;

    LSize := m2S32Min(RBodyOffset-ROrigBuff^.RBodyOffset,ASize);

    with ROrigBuff^ do
    begin
     m2MEMCopy(Pointer(LongInt(ABuff)+LOffset),@RBody[RBodyOffset],LSize);
     Inc(RBodyOffset,LSize);
    end;//with ROrigBuff^

    Inc(LOffset,LSize);
    Dec(ASize,LSize);

   end;//while (((ASize <> 0) or (ABuff = nil)) and not(RReadEOF))
   ASize := LOffset;
  end;//with RCompBuff^
 end;//with FHandle^
end;

 procedure   Tm3ArcInflateStream.InflateDone(
                                            );
 begin

  with FHandle^ do
   begin

    try

     m3ArcBuffers^.FreeItem(Pointer(RCompBuff));
     Assert(RCompBuff = nil);

    finally

     m3ArcBuffers^.FreeItem(Pointer(ROrigBuff));
     Assert(ROrigBuff = nil);

    end;//try..finally

   end;//with FHandle^

 end;

 procedure   Tm3ArcInflateStream.DoRead(ABuff: Pointer;
                                      ASize: LongInt;
                                      var   AResult: LongInt;
                                      var   AReturn: HRESULT
                                     );
 var
        LSize:                    LongInt;
 begin

  if SUCCEEDED(AReturn)
   then
    begin

     LSize := LongInt(m2S64Min((HeaderData.RRealSize-FPosition),Int64(ASize)));

     Inflate(ABuff,LSize);

     Inc(FPosition,Int64(LSize));
     Inc(AResult,LSize);

    end;

 end;

procedure Tm3ArcInflateStream.DoSeek(AOffset     : Int64;
                                   AOrigin     : TSeekOrigin;
                                   var AResult : Int64;
                                   var AReturn : HRESULT);

  procedure __Seek(const APosition: Int64;
                   var   AResult: Int64);

   function __FindHandle(const APosition: Int64): Tm3ArcHandle;
   var
    LIndex : LongInt;
   begin//__FindHandle
    Result := nil;
    with FArcList do
    begin
     if FindItemByKey(APosition,LIndex) then
     begin
      Result := Items[LIndex];
      Exit;
     end;//FindItemByKey(APosition,LIndex)
    end;//with FArcList
    OleError(E_UNEXPECTED);
   end;//__FindHandle

   function __GetHandlePosition(const AArcHandle: Tm3ArcHandle): Int64;
   var
    LSize : LongInt;
   begin//__GetHandlePosition
    with AArcHandle.Data do
    begin
     m2COMSetPosition(PositionInStream,InnerStream);
     LSize := 0;
     FHandle^.RReadEOF := False;
     Inflate(nil,LSize);
     Result := Position;
    end;//with AArcHandle.Data
    FPosition := Result;
   end;//__GetHandlePosition

   procedure __ReadDummy(const ASize: LongInt);
   var
    LBuff : Pointer;
   begin//__ReadDummy
    if (ASize <> 0) then
    begin
     m3ArcBuffers^.AllocItem(LBuff,ASize);
     try
      m2COMReadBuffer(Self,LBuff^,ASize);
     finally
      m3ArcBuffers^.FreeItem(LBuff);
     end;//try..finally
    end;//ASize <> 0
   end;//__ReadDummy

  begin//__Seek
   with HeaderData do
   begin
    if ((APosition >= 0) and (APosition <= RRealSize)) then
    begin
     if (APosition <> FPosition) then
     begin
      if (APosition = RRealSize) then
      begin
       FHandle^.RReadEOF := True;
       FPosition := APosition;
      end//APosition = RRealSize
      else
       __ReadDummy(LongInt(APosition-__GetHandlePosition(__FindHandle(APosition))));
     end;//APosition <> FPosition
    end//((APosition >= 0) and (APosition <= RRealSize))
    else
      Exit;
   end;//with HeaderData
   AResult := APosition;
  end;//__Seek

var
 LPosition : Int64;
begin
 if SUCCEEDED(AReturn) then
 begin

(*     case AOrigin of

      STREAM_SEEK_SET:
       ;

      STREAM_SEEK_CUR:
      begin
       if (AOffset = 0) then
       begin
        aResult := fPosition;
        Exit;
        // - надо просто вернуть текущую позицию
       end;//AOffset = 0
      end;//STREAM_SEEK_CUR

      STREAM_SEEK_END:
      begin
       if (AOffset = 0) then
       begin
        aResult := PHeaderData000(HeaderData)^.RRealSize;
        m2COMSeek(_Stream, 0, STREAM_SEEK_END);
        Exit;
        // - надо просто вернуть размер стрима
       end;//AOffset = 0
      end;//STREAM_SEEK_END
     end;//case AOrigin*)

  if not FArcListLoaded then
  begin
   LPosition := m2COMGetPosition(InnerStream);
   try
    FArcList.LoadFromStream(InnerStream, HeaderData.RListPos);
   finally
    m2COMSetPosition(LPosition, InnerStream);
   end;
   FArcListLoaded := True;
  end;//not FArcListLoaded

  case AOrigin of

   soBeginning:
    __Seek(AOffset, AResult);
   soCurrent:
    __Seek(AOffset+FPosition, AResult);
   soEnd:
    __Seek(AOffset+HeaderData.RRealSize, AResult);
   else
    OleError(E_UNEXPECTED);
  end;//case AOrigin

 end;//SUCCEEDED(AReturn)
end;

procedure Tm3ArcInflateStream.DoSetSize(ASize   : Int64;
                                      var   AReturn : HRESULT);
begin
 if SUCCEEDED(AReturn) then
 begin
  if (FPosition <> ASize) then
   AReturn := STG_E_INVALIDFUNCTION;
 end;//SUCCEEDED(AReturn)
end;

function Tm3ArcInflateStream.DoGetPosition: Int64;
  //override;
  {-}
begin
 Result := FPosition;
end;

function Tm3ArcInflateStream.DoGetSize: Int64;
  //override;
  {-}
begin
 Result := HeaderData.RRealSize;
end;

constructor Tm3ArcInflateStream.Create(const AStream: IStream);
begin
 inherited Create(AStream,STGM_READ);
 m2InitOperation(_Status,InitProc00000001($00000001));
 m2InitOperation(_Status,InitProc00000002($00000002));
 m2InitOperation(_Status,InitProc00000004($00000004));
end;

procedure Tm3ArcInflateStream.Cleanup;
begin
 m2DoneOperation(_Status,$00000004,DoneProc00000004);
 m2DoneOperation(_Status,$00000002,DoneProc00000002);
 m2DoneOperation(_Status,$00000001,DoneProc00000001);
 FArcListLoaded := false;
 fPosition := 0;
 Assert(FHandle = nil);
 inherited;
 _Status := 0;
end;

// Tm3ArcDeflateStream

 function    Tm3ArcDeflateStream.InitProc00000001(const ABitMask: LongWord
                                                 ): LongWord;
 begin

  with Self do
   begin

    FArcList := Tm3ArcHandleList.Create;

   end;

  Result := ABitMask;

 end;

 procedure   Tm3ArcDeflateStream.DoneProc00000001(
                                                 );
 begin
  FreeAndNil(FArcList);
 end;

function Tm3ArcDeflateStream.InitProc00000002(const ABitMask: LongWord): LongWord;
begin
 m3ArcHandleBuffers^.AllocItemZ(Pointer(FHandle));
 Result := ABitMask;
end;

 procedure   Tm3ArcDeflateStream.DoneProc00000002(
                                                 );
 begin
  m3ArcHandleBuffers^.FreeItem(Pointer(FHandle));
 end;

 function    Tm3ArcDeflateStream.InitProc00000004(const ABitMask: LongWord
                                                 ): LongWord;
 begin

  with Self do
   begin

    DeflateInit;

   end;

  Result := ABitMask;

 end;

 procedure   Tm3ArcDeflateStream.DoneProc00000004(
                                                 );
 begin

  with Self do
   begin

    DeflateDone;

    with HeaderData do
     begin

      RListPos := FArcList.SaveToStream(InnerStream);
      RRealSize := FPosition;

     end;

   end;

 end;

 procedure   Tm3ArcDeflateStream.WriteBuff(const ABuff: Pointer;
                                           const ABLen: LongInt;
                                           const AOLen: LongInt
                                          );
 var
        LArcHandle:               Tm3ArcHandle;
 begin

  m2COMWriteBuffer(InnerStream,ABuff^,ABLen);

  LArcHandle := Tm3ArcHandle.Create;
   try

    with LArcHandle.Data do
     begin

      Position := FPositionOfData;
      PositionInStream := m2COMGetPosition(InnerStream)-ABLen;

      DataSize := AOLen;

     end;

    FArcList.Add(LArcHandle);

   finally

    FreeAndNil(LArcHandle);

   end;

  Inc(FPositionOfData,AOLen);

 end;

 procedure   Tm3ArcDeflateStream.DeflateInit(
                                            );
 begin

  with FHandle^ do
   begin

    ROrigSize := m3OrigSize;
    RCompSize := DeflateWorkSize(ROrigSize);

    m3ArcBuffers.AllocItemZ(Pointer(ROrigBuff),SizeOf(ROrigBuff^)-SizeOf(ROrigBuff^.RBody)+ROrigSize);
     try

      ROrigBuff^.RBodyOffset := 0;

      m3ArcBuffers.AllocItemZ(Pointer(RCompBuff),SizeOf(RCompBuff^)-SizeOf(RCompBuff^.RBody)+RCompSize);

      RCompBuff^.RBodyOffset := 0;

     except

      m3ArcBuffers.FreeItem(Pointer(ROrigBuff));
      Assert(ROrigBuff = nil);

      raise;

     end;

    RReadEOF := False;

   end;

 end;

 procedure   Tm3ArcDeflateStream.Deflate(const ABuff: Pointer;
                                         const ASize: LongInt
                                        );
 var
        LCompress:                LongInt;
        LOffset:                  LongInt;
        LSize:                    LongInt;
        LSize1:                   LongInt;
        LSize2:                   LongInt;
        LSize3:                   LongInt;
 begin

  with FHandle^ do
   begin

    with ROrigBuff^ do
     begin

      LSize := ASize;

      LSize1 := 0;
      LOffset := 0;

      while ((LSize <> 0) or (ABuff = nil)) do
       begin

        if (ABuff <> nil)
         then
          begin

           LSize1 := m2S32Min(ROrigSize-RBodyOffset,LSize);

           m2MEMCopy(@RBody[RBodyOffset],Pointer(LongInt(ABuff)+LOffset),LSize1);

           Inc(LOffset,LSize1);
           Inc(RBodyOffset,LSize1);

          end;

        if ((RBodyOffset = ROrigSize) or ((ABuff = nil) and (RBodyOffset <> 0)))
         then
          begin

           m2CheckValue(DeflateBuff(@RCompBuff^.RBody,LCompress,@RBody,RBodyOffset));

           if (RBodyOffset < (LCompress+SizeOf(RBodyCRC)))
            then
             begin

              LSize2 := RBodyOffset+SizeOf(RBodyCRC)+SizeOf(RBodyOffset);
              LSize3 := RBodyOffset;

              RBodyCRC := 0;{m2HASUpdate32(RBodyOffset,@RBody,RBodyOffset,Cm2HASVersionCRC);}

              Inc(RBodyOffset,SizeOf(RBodyCRC));
              RBodyOffset := LongInt(LongWord(RBodyOffset) or $80000000);

              WriteBuff(ROrigBuff,LSize2,LSize3);

             end
            else
             begin

              with RCompBuff^ do
               begin

                RBodyOffset := LCompress;

                LSize2 := RBodyOffset+SizeOf(RBodyCRC)+SizeOf(RBodyOffset);
                LSize3 := ROrigBuff^.RBodyOffset;

                RBodyCRC := 0;{m2HASUpdate32(RBodyOffset,@RBody,RBodyOffset,Cm2HASVersionCRC);}

                Inc(RBodyOffset,SizeOf(RBodyCRC));

               end;

              WriteBuff(RCompBuff,LSize2,LSize3);

             end;

           RBodyOffset := 0;

          end;

        if (ABuff = nil)
         then
          begin

           Break;

          end;

        Dec(LSize,LSize1);

       end;

     end;

   end;

 end;

 procedure   Tm3ArcDeflateStream.DeflateDone(
                                            );
 begin

  with FHandle^ do
   begin

    try

     Deflate(nil,0);

     with ROrigBuff^ do
      begin

       WriteBuff(ROrigBuff,SizeOf(RBodyOffset),0);

      end;

    finally

     try

      m3ArcBuffers.FreeItem(Pointer(RCompBuff));

     finally

      m3ArcBuffers.FreeItem(Pointer(ROrigBuff));

     end;

    end;

   end;

 end;

 procedure   Tm3ArcDeflateStream.DoWrite(ABuff: Pointer;
                                       ASize: LongInt;
                                       var   AResult: LongInt;
                                       var   AReturn: HRESULT
                                      );
 begin

  if SUCCEEDED(AReturn)
   then
    begin

     Deflate(ABuff,ASize);

     Inc(FPosition,ASize);
     Inc(AResult,ASize);
     
    end;

 end;

procedure   Tm3ArcDeflateStream.DoSeek(AOffset     : Int64;
                                     AOrigin     : TSeekOrigin;
                                     var AResult : Int64;
                                     var AReturn : HRESULT
                                    );

 procedure   __Seek(const APosition: Int64;
                    var   AResult: Int64
                   );
 begin
  if (APosition = FPosition) then
   AResult := APosition;
 end;

begin
 if SUCCEEDED(AReturn) then
 begin
  case AOrigin of
   soBeginning:
    __Seek(AOffset,AResult);
   soCurrent:
    __Seek(AOffset+FPosition,AResult);
   soEnd:
   begin
    if HeaderData.RRealSize = 0 then
     __Seek(AOffset+FPosition, AResult)
    else
     __Seek(AOffset+HeaderData.RRealSize, AResult);
   end;//soEnd
   else
    OleError(E_UNEXPECTED);
  end;//case AOrigin
 end;//SUCCEEDED(AReturn)
end;

 procedure   Tm3ArcDeflateStream.DoSetSize(ASize: Int64;
                                         var   AReturn: HRESULT
                                        );
 begin

  if SUCCEEDED(AReturn)
   then
    begin

     if (FPosition = ASize)
      then
      else
       begin

        AReturn := STG_E_INVALIDFUNCTION;

       end;

    end;

 end;

function Tm3ArcDeflateStream.DoGetSize: Int64;
  //override;
  {-}
begin
 Result := HeaderData.RRealSize;
end;

// Tm3ArcDeflateStream.public

constructor Tm3ArcDeflateStream.Create(const AStream: IStream);
begin
 inherited Create(AStream,STGM_WRITE);
 m2InitOperation(_Status,InitProc00000001($00000001));
 m2InitOperation(_Status,InitProc00000002($00000002));
 m2InitOperation(_Status,InitProc00000004($00000004));
end;

procedure Tm3ArcDeflateStream.Cleanup;
begin
 m2DoneOperation(_Status,$00000004,DoneProc00000004);
 m2DoneOperation(_Status,$00000002,DoneProc00000002);
 m2DoneOperation(_Status,$00000001,DoneProc00000001);

 fPosition := 0;
 FPositionOfData :=0;
 Assert(FHandle = nil);

 inherited;

 _Status := 0;
end;

// Tm3LZOInflateStream

 function    Tm3LZOInflateStream.InflateBuff(const ADest: Pointer;
                                             var   ADLen: LongInt;
                                             const ASour: Pointer;
                                             const ASLen: LongInt
                                            ): LongBool;
 begin

  Result := m1LZOIsValidResult(m1LZODecode(ADest,ADLen,ASour,ASLen));

 end;

 function    Tm3LZOInflateStream.InflateWorkSize(const ASize: LongInt
                                                ): LongInt;
 begin

  Result := m1LZOMaxMem(ASize){ * 3};

 end;

 class
 function    Tm3LZOInflateStream.MakeInterface(const AStream: IStream
                                              ): IStream;
 var
  l_I : Tm3LZOInflateStream;
 begin

  l_I := Create(AStream);
   try

    Result := l_I;

   finally

    FreeAndNil(l_I);

   end;

 end;

// Tm3LZODeflateStream

  function Tm3LZODeflateStream.DeflateBuff (const ADest: Pointer;
                        var   ADLen: Integer;
                        const ASour: Pointer;
                        const ASLen: Integer): LongBool; //override;
 begin

  Result := m1LZOIsValidResult(m1LZOEncode(ADest,ADLen,ASour,ASLen));

 end;

 function    Tm3LZODeflateStream.DeflateWorkSize(const ASize: LongInt
                                                ): LongInt;
 begin

  Result := m1LZOMaxMem(ASize);

 end;

 class function  Tm3LZODeflateStream.MakeInterface(const AStream: IStream): IStream;
 var
  l_I : Tm3LZODeflateStream;
 begin
   l_I := Create(AStream);
   try
    Result := l_I;
   finally
    FreeAndNil(l_I);
   end;
 end;

// Tm3LZODeflateStream.end

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\m3\m3arccla.pas initialization enter'); {$EndIf}
 m3ArcBuffers := l3NewMemoryChain(m3OrigSize + (m3OrigSize div 5));
 m3ArcHandleBuffers := l3NewMemoryChain(SizeOf(Tm3ArcClaHandle));
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\m3\m3arccla.pas initialization leave'); {$EndIf}
end.

