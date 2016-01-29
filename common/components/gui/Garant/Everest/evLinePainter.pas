unit evLinePainter;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evLinePainter - }
{ Начат: 18.03.2004 11:49 }
{ $Id: evLinePainter.pas,v 1.20 2009/06/29 17:45:20 lulin Exp $ }

// $Log: evLinePainter.pas,v $
// Revision 1.20  2009/06/29 17:45:20  lulin
// {RequestLink:141262980}. №2c.
//
// Revision 1.19  2009/06/29 16:32:35  lulin
// - убираем лишнее приведение к интерфейсу.
//
// Revision 1.18  2009/04/01 11:45:32  lulin
// [$141262980]. Вкладываем интерфейсы друг в друга. Утилиты переносим в отдельный модуль.
//
// Revision 1.17  2008/08/26 12:18:35  lulin
// - используем стереотип итератора.
//
// Revision 1.16  2008/08/26 11:58:47  lulin
// - переносим на модель.
//
// Revision 1.15  2008/08/26 11:41:28  lulin
// - чистка кода.
//
// Revision 1.14  2008/08/26 11:22:03  lulin
// - чистка кода.
//
// Revision 1.13  2008/04/11 12:26:08  lulin
// - <K>: 89100752.
//
// Revision 1.12  2008/02/14 17:08:54  lulin
// - cleanup.
//
// Revision 1.11  2007/12/04 12:47:02  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.9.14.8  2007/04/17 12:34:45  oman
// Warning fix
//
// Revision 1.9.14.7  2006/03/17 14:28:40  dinishev
// Cleanup
//
// Revision 1.9.14.6  2005/10/12 07:26:25  lulin
// - bug fix: при вставке комментария при наличии выделения после строки параграфа рисовался мусор (CQ OIT5-16874).
//
// Revision 1.9.14.5  2005/10/06 07:31:53  lulin
// - cleanup.
//
// Revision 1.9.14.4  2005/07/11 06:07:06  lulin
// - упорядочены названия интерфейсов.
//
// Revision 1.9.14.3  2005/06/15 11:45:21  lulin
// - cleanup.
//
// Revision 1.9.14.2  2005/06/02 16:38:47  lulin
// - cleanup.
//
// Revision 1.9.14.1  2005/06/01 16:22:25  lulin
// - remove unit: evIntf.
//
// Revision 1.9  2005/01/24 11:43:15  lulin
// - new behavior: при освобождении заглушки очищаем указатель на нее.
//
// Revision 1.8  2004/12/03 16:07:22  lulin
// - new interfaces: InevRange, IevTextSource, IevPrintableTextSource.
//
// Revision 1.7  2004/06/09 09:53:36  law
// - change: переходим к типу TevPair от пары параметров Start, Finish.
//
// Revision 1.6  2004/03/18 17:06:28  law
// - new behavior: теперь мульти-выделение корректно рисуется и в пределах текстового параграфа.
//
// Revision 1.5  2004/03/18 15:13:39  law
// - new behavior: реализована отрисовка мульти-выделения внутри одного текстового параграфа (пока только на разных строках).
//
// Revision 1.4  2004/03/18 13:14:02  law
// - new interface: IevSelectionPairs.
//
// Revision 1.3  2004/03/18 10:37:18  law
// - new method: _IevLinePainter.FinishLine.
//
// Revision 1.2  2004/03/18 10:28:34  law
// - new methods: _IevLinePainter.StartPara, FinishPara.
//
// Revision 1.1  2004/03/18 10:01:42  law
// - refactoring: из алгоритма рисования текстового параграфа выделен утилитный интерфейс _IevLinePainter - для рисования отдельной строчки параграфа.
//

{$Include evDefine.inc }

interface

uses
  l3Types,
  l3InternalInterfaces,
  l3Base,
  l3CacheableBase,

  evInternalInterfaces,

  nevTools,
  nevRealTools
  ;

type
  TIevLinePainterDrawAction = function (const anItem: Tl3PCharLen): Boolean;
  TevLinePainter = class(Tl3CacheableBase)
    private
    // internal fields
      f_BlockSolid : Boolean;
      f_ParaBlock  : TevPair;
      f_LineBlock  : TevPair;
      f_Pairs      : IevSelectionPairs;
      f_PairIndex  : Integer;
      f_LineOffset : Integer;
      f_LineLength : Integer;
      f_CharsDrawn : Integer;
    protected
    // interface methods
      function  Draw(const aCanvas : Il3Canvas;
                     aProc : TIevLinePainterDrawAction;
                     aStr  : Tl3CustomString): Integer;
        {-}
    protected
    // internal methods
      function  LoadNextLineBlock: Boolean;
        {-}
    public
    // public methods
      function  DrawF(const aCanvas : Il3Canvas;
                      aProc : TIevLinePainterDrawAction;
                      aStr  : Tl3CustomString): Integer;
        {-}
      procedure StartPara(const aView   : InevView;
                          const aBlock  : InevRange);
        {-}
      procedure FinishPara;
        {-}
      procedure StartLine(aLineOffset : Integer;
                          aLineLength : Integer);
        {-}
  end;//TevLinePainter

function  evL2DLA(Action: Pointer): TIevLinePainterDrawAction;
  {* - делает заглушку для локальной процедуры. }

implementation

uses
  SysUtils,

  l3MinMax
  ;

// start class TevLinePainter

procedure TevLinePainter.StartPara(const aView   : InevView;
                                   const aBlock  : InevRange);
  {-}
begin
 f_BlockSolid := (aBlock = nil) OR aBlock.Solid(aView);
 f_ParaBlock.rStart  := -1;
 f_ParaBlock.rFinish := -1;
 f_PairIndex := 0;
 if f_BlockSolid then
  f_Pairs := nil
 else 
 if Supports(aBlock, IevSelectionPairs, f_Pairs) then
 begin
  if (f_Pairs.PairsCount <= 1) then
   f_Pairs := nil;
 end;//Supports(aBlock, IevSelectionPairs, f_Pairs)
 if not f_BlockSolid then
  if (f_Pairs = nil) then
   if (f_ParaBlock.rStart = -1) then
    f_ParaBlock := aBlock.Borders;
end;

procedure TevLinePainter.FinishPara;
  {-}
begin
 f_Pairs := nil;
end;

procedure TevLinePainter.StartLine(aLineOffset : Integer;
                                   aLineLength : Integer);
  {-}
begin
 f_CharsDrawn := 0;
 f_LineBlock.rStart := 0;
 f_LineBlock.rFinish := 0;
 f_LineOffset := aLineOffset;
 f_LineLength := aLineLength;
 if not f_BlockSolid then
 begin
  if (f_Pairs = nil) then
  begin
   Assert(f_ParaBlock.rStart <> -1);
   f_LineBlock := f_ParaBlock;
   f_LineBlock.Dec(aLineOffset);
  end//f_Pairs = nil
  else
   LoadNextLineBlock;
 end;//not f_BlockSolid
end;

function TevLinePainter.Draw(const aCanvas : Il3Canvas;
                             aProc : TIevLinePainterDrawAction;
                             aStr  : Tl3CustomString): Integer;
  {-}

  function DoDrawLine(const aStr : Tl3PCharLen): Boolean;
    {-}
  begin
   Inc(f_CharsDrawn, aStr.SLen);
   Result := aProc(aStr);
  end;

 function SS: Boolean;
   {-нарисовать текст до выделения}
 var
  S1 : Tl3PCharLen;
 begin//SS
  S1 := aStr.AsPCharLen;
  S1.SLen := Min(f_LineBlock.rStart, S1.SLen);
  if (S1.SLen > 0) then
  begin
   Result := DoDrawLine(S1);
   Dec(f_LineBlock.rStart, S1.SLen);
   Dec(f_LineBlock.rFinish, S1.SLen);
   aStr.Offset(S1.SLen);
  end//S1.SLen > 0
  else
   Result := false;
 end;//SS

 function MS: Boolean;
   {-нарисовать текст выделения}
 var
  S1 : Tl3PCharLen;
 begin//MS
  Result := false;
  S1 := aStr.AsPCharLen;
  if (f_LineBlock.rFinish > f_LineBlock.rStart) then
  begin
   S1.SLen := Min(f_LineBlock.rFinish - f_LineBlock.rStart, S1.SLen);
   if (S1.SLen > 0) then
   begin
    aCanvas.BeginInvert;
    try
     Result := DoDrawLine(S1);
     Dec(f_LineBlock.rFinish, S1.SLen);
     aStr.Offset(S1.SLen);
    finally
     aCanvas.EndInvert;
    end;//try..finally
   end;//S1.SLen > 0
  end;//f_LineBlock.rFinish > f_LineBlock.rStart
 end;//MS

 function FS: Boolean;
   {-нарисовать текст после выделения}
 var
  S1 : Tl3PCharLen;
 begin//FS
  S1 := aStr.AsPCharLen;
  if (S1.SLen > f_LineBlock.rFinish) AND (f_LineBlock.rFinish > 0) then
   Dec(S1.SLen, f_LineBlock.rFinish);
  if (S1.SLen > 0) then
  begin
   Result := DoDrawLine(S1);
   aStr.Offset(S1.SLen);
  end//S1.SLen > 0
  else
   Result := false;
 end;//FS

begin//Draw
 repeat
  SS;
  Result := Ord(MS);
  if not LoadNextLineBlock then
   break;
  if not Boolean(Result) then
   break;
  if (aStr.Len = 0) then
   break;
 until false;
 Result := Ord(not FS AND Boolean(Result));
end;//Draw

procedure evFreeDLA(var aStub: TIevLinePainterDrawAction);
  {* - освобождает заглушку для локальной процедуры. }
  register;
  {-}
asm
          jmp  l3FreeLocalStub
end;{asm}

function TevLinePainter.DrawF(const aCanvas : Il3Canvas;
                              aProc : TIevLinePainterDrawAction;
                              aStr  : Tl3CustomString): Integer;
  {-}
begin
 try
  Result := Draw(aCanvas, aProc, aStr);
 finally
  evFreeDLA(aProc);
 end;//try..finally
end;

function TevLinePainter.LoadNextLineBlock: Boolean;
  {-}
var
 l_Index : Integer;
begin
 Result := false;
 if (f_Pairs <> nil) then
 begin
  for l_Index := f_PairIndex to Pred(f_Pairs.PairsCount) do
  begin
   f_ParaBlock := f_Pairs.Pair[l_Index];
   if (f_ParaBlock.rStart < f_LineOffset + f_LineLength) AND
      (f_ParaBlock.rFinish > f_CharsDrawn + f_LineOffset) then
    // - выделение на нашей строке или за ней
   begin
    Result := true;
    //f_PairIndex := l_Index;
    f_LineBlock := f_ParaBlock;
    f_LineBlock.Dec(f_LineOffset + f_CharsDrawn);
    break;
   end;//f_ParaBlock.rFinish > aLineOffset
  end;//for l_Index
 end;//f_Pairs <> nil
end;

function  evL2DLA(Action: Pointer): TIevLinePainterDrawAction;
  {* - делает заглушку для локальной процедуры. }
  register;
  {-}
asm
          jmp  l3LocalStub
end;{asm}

end.

