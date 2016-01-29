unit evPrintEngine;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evPrintEngine - }
{ Начат: 30.07.2003 16:25 }

// $Log: evPrintEngine.pas,v $
// Revision 1.25  2014/04/21 11:45:00  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.24  2014/04/08 14:16:55  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.23  2014/04/07 08:08:24  dinishev
// Bug fix: не компилировались проекты.
//
// Revision 1.22  2014/04/04 17:53:34  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.21  2014/04/04 06:59:47  dinishev
// Bug fix: не собирался Арчи.
//
// Revision 1.20  2014/03/25 06:16:29  dinishev
// Bug fix: не компилировалось.
//
// Revision 1.19  2013/10/18 15:38:57  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.18  2013/04/19 13:05:00  lulin
// - портируем.
//
// Revision 1.17  2011/05/19 12:17:32  lulin
// {RequestLink:266409354}.
//
// Revision 1.16  2009/04/16 14:27:13  lulin
// [$143396720]. Собираем Архивариус в HEAD.
//
// Revision 1.15  2009/03/04 16:25:52  lulin
// - <K>: 137470629. Bug fix: не собирался Архивариус.
//
// Revision 1.14  2008/12/29 11:23:35  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.13  2008/12/23 11:27:21  lulin
// - bug fix: не собирался Архивариус.
//
// Revision 1.12  2007/12/04 12:47:04  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.9.8.2  2007/11/28 12:58:06  dinishev
// Совместимость с Арчи
//
// Revision 1.9.8.1  2006/02/09 13:54:23  lulin
// - пока безуспешные попытки собрать Archi с Эверестом из ветки.
//
// Revision 1.9  2005/03/28 11:32:08  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.8  2005/03/28 06:37:08  lulin
// - remove object: Tk2AtomW.
//
// Revision 1.7  2005/03/25 17:09:01  lulin
// - избавляемся от метода Tk2AtomW.sLong.
//
// Revision 1.6  2005/03/24 13:14:37  lulin
// - уделена ненужная функция преобразования Tk2AtomR к _Ik2Tag.
//
// Revision 1.5  2005/02/21 18:47:49  lulin
// - в метод TevHAFPainter._TuneHeader добавлен параметр aTop.
//
// Revision 1.4  2004/12/29 15:19:26  lulin
// - с TextSource убрана печать.
//
// Revision 1.3  2004/09/21 12:55:41  lulin
// - Release заменил на Cleanup.
//
// Revision 1.2  2003/11/06 09:29:36  voba
// no message
//
// Revision 1.1  2003/07/30 16:54:22  voba
// no message
//

interface

uses
  l3Chars,
  l3Base,
  l3InternalInterfaces,
  l3String,
  l3ProtoObject,

  evTypes,
  evConst,

  k2Interfaces,
  k2TagGen,
  k2Tags,
  k2DocumentBuffer,

  evSegLst,
  evHAFPainter,
  evSBSPar
  ;

type
  TevPrintEngine = class(Tl3ProtoObject)
   private
    fHeader     : TevHAFPainter;
    fGenerator  : Tk2DocumentBuffer;
    fIsStarted  : Boolean;
   protected
   // internal method
    procedure Cleanup;
      override;
      {-}
    procedure Start;
    procedure Finish;
      {-}
   public
   // public methods
    constructor Create;
      reintroduce;
      {-}
    procedure Print;
    procedure AddPlainPara(const aText: AnsiString);
      {-}
    procedure AddHeader(const aLeftText   : AnsiString;
                        const aRightText  : AnsiString);
      {-}
  end;//TevPrintEngine

implementation

uses
  nevBase,
  nevTools,
  
  evDocumentPreview,

  Document_Const,
  TextPara_Const
  ;

// start class TevPrintEngine

constructor TevPrintEngine.Create;
begin
 inherited Create;
 fGenerator := Tk2DocumentBuffer.Create;
end;

procedure TevPrintEngine.Cleanup;
begin
 Finish;
 l3Free(fGenerator);
 l3Free(fHeader);
 inherited;
end;

procedure TevPrintEngine.Print;
var
 l_Para : InevPara;
begin
 Finish;
 if not fGenerator.Root.QT(InevPara, l_Para) then
  Assert(false);
 TevDocumentPreview.Make(l_Para.AsObject, evDefaultPreviewCacheKey, fHeader).Print;
end;

procedure TevPrintEngine.Start;
begin
 If not fIsStarted then
 begin
  fIsStarted := True;
  fGenerator.Start;
  fGenerator.StartChild(k2_typDocument);
 end;
end;

procedure TevPrintEngine.Finish;
begin
 If fIsStarted then
 begin
  fIsStarted := False;
  fGenerator.Finish;
  fGenerator.Finish;
 end;
end;

procedure TevPrintEngine.AddPlainPara(const aText: AnsiString);
begin
 Start;
 with fGenerator do
 begin
  StartChild(k2_typTextPara);
  try
   AddStringAtom(k2_tiText, l3PCharLen(PAnsiChar(aText), -1, CP_ANSI));
  finally
   Finish;
  end;//try..finally
 end;//with Tk2TagGenerator(aGenerator)
end;

(*
procedure peGenerator_AddTextPair(const aGenerator : TpeGenerator;
                                  aLeftText        : PAnsiChar;
                                  aRightText       : PAnsiChar;
                                  NeedIndent       : Boolean = false);
  //stdcall;
  {* - добавить к тексту текстовый параграф из двух половинок - одна из них выделена. }
var
 l_Text : AnsiString;
begin
 with Tk2TagGenerator(aGenerator) do begin
  StartChild(k2_idTextPara);
  try
   l_Text := AnsiString(aLeftText) + AnsiString(aRightText);
   AddIntegerAtom(k2_tiJustification, Ord(ev_itLeft));
   if NeedIndent then
    AddIntegerAtom(k2_tiLeftIndent, evInchMul div 4)
   else
    AddIntegerAtom(k2_tiLeftIndent, 0);
   AddIntegerAtom(k2_tiFirstIndent, 0);
   AddIntegerAtom(k2_tiSpaceAfter, evInchMul div 11);
   AddStringAtom(k2_tiText, l_Text);
   StartTag(k2_tiSegments);
   try
    StartChild(k2_idSegmentsLayer);
    try
     AddIntegerAtom(k2_tiHandle, ev_slView);
     StartChild(k2_idTextSegment);
     try
      AddIntegerAtom(k2_tiFinish, l3StrLen(aLeftText));
      StartTag(k2_tiFont);
      try
       AddBoolAtom(k2_tiBold, true);
      finally
       Finish;
      end;//try..finally
     finally
      Finish;
     end;//try..finally
    finally
     Finish;
    end;//try..finally
   finally
    Finish;
   end;//try..finally
  finally
   Finish;
  end;//try..finally
 end;//with Tk2TagGenerator(aGenerator)
end;
*)
type
  TevCustomizingHeader = class(TevHAFPainter)
    private
    // internal fields
      f_LeftText  : AnsiString;
      f_RightText : AnsiString;
    public
    // public methods
      constructor Create(const aReplacer : Il3HAFMacroReplacer;
                         const aLeftText  : AnsiString;
                         const aRightText : AnsiString);
        reintroduce;
        {-}
      procedure TuneHeader(const aCanvas : Il3Canvas;
                           aHeader       : Tl3Variant;
                           aTop          : Boolean);
        override;
        {-}
  end;//TevCustomizingHeader

constructor TevCustomizingHeader.Create(const aReplacer : Il3HAFMacroReplacer;
                                        const aLeftText  : AnsiString;
                                        const aRightText : AnsiString);
begin
 inherited Create(aReplacer);
 f_LeftText := aLeftText;
 f_RightText := aRightText;
end;

procedure TevCustomizingHeader.TuneHeader(const aCanvas : Il3Canvas;
                                          aHeader       : Tl3Variant;
                                          aTop          : Boolean);
begin
 if aTop then
 begin
  with evSBS_LeftPara(aHeader) do begin
   StrA[k2_tiText] := f_LeftText;
   cAtom(k2_tiFont).IntA[k2_tiSize] := 8;
  end;//with LeftPara
  with evSBS_RightPara(aHeader) do begin
   StrA[k2_tiText] := f_RightText;
   cAtom(k2_tiFont).IntA[k2_tiSize] := 8;
  end;//with RightPara
 end//aTop
 else
 begin
  evSBS_LeftPara(aHeader).AttrW[k2_tiText, nil] := nil;
  evSBS_RightPara(aHeader).AttrW[k2_tiText, nil] := nil;
 end;//aTop
end;

procedure TevPrintEngine.AddHeader(const aLeftText   : AnsiString;
                                   const aRightText  : AnsiString);
{* - добавить верхний колонтитул. }
var
 l_Header : TevCustomizingHeader;
begin
 l_Header := TevCustomizingHeader.Create(nil, aLeftText, aRightText);
 try
  l3Set(fHeader, l_Header);
 finally
  l3Free(l_Header);
 end;//try..finally
end;

end.

