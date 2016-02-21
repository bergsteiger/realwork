unit eeRenderFormula;

// Модуль: "w:\common\components\rtl\Garant\RenderEVD\eeRenderFormula.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\rtl\Garant\RenderEVD\evDefine.inc}

interface

uses
 l3IntfUses
 , l3InternalInterfaces
 , l3Variant
 , ActiveX
;

type
 TeeRenderTarget = (
  ee_rtPNG
  , ee_rtBMP
  , ee_rtRawBMP
 );//TeeRenderTarget

function RenderFormula(aBuf: PAnsiChar;
 aSize: Integer;
 aNumber: Integer;
 aZoom: Integer;
 const aPicture: IStream): Boolean; stdcall;
function RenderFormulaPrim(aBuf: PAnsiChar;
 aSize: Integer;
 aNumber: Integer;
 aZoom: Integer;
 const aPicture: IStream;
 aTarget: TeeRenderTarget): Boolean; stdcall;

implementation

uses
 l3ImplUses
 , nevDocumentContainer
 , evdSchema
 , l3StringIDEx
 , Table_Const
 , TableRow_Const
 , TableCell_Const
 {$If NOT Defined(notDebugStackTrace)}
 , jclDebug
 {$IfEnd} // NOT Defined(notDebugStackTrace)
 , l3Memory
 , Classes
 , k2DocumentBuffer
 , evdNativeReader
 , l3BitmapContainer
 {$If NOT Defined(NoImageEn)}
 , imageenio
 {$IfEnd} // NOT Defined(NoImageEn)
 , k2Tags
 , evdTypes
 , SysUtils
 , l3Stream
 , l3Base
 , l3Math
 , l3Interfaces
 , evdVer
 , TextPara_Const
 , l3Units
 , nevTools
 , nevBase
 , Document_Const
 , nevVirtualDrawView
 , l3ScreenIC
 , Formula_Const
 , Graphics
 , l3ImageUtils
;

type
 TnevDocumentContainerHack = {abstract} class(TnevDocumentContainer)
 end;//TnevDocumentContainerHack

function DoRender(aText: Tl3Variant;
 aFormula: Tl3Variant;
 aZoom: Integer): Il3Bitmap;
 {* Собствеено рендерит формулу }
//#UC START# *4EF0A285035D_4B72DF7B0164_var*
var
 l_TextO    : InevObject;
 l_FormulaO : InevObject;
 l_TextFI   : TnevFormatInfoPrim;
 l_View     : TnevVirtualDrawView;
 l_Doc      : Tl3Variant;
 l_DocO     : InevObject;
 l_Cont     : TnevDocumentContainer;
 l_Text     : Tl3Variant;
 l_TableO   : InevObject;
 l_RowO     : InevObject;
 l_CellO    : InevObject;
 l_Table    : Tl3Variant;
 l_Row      : Tl3Variant;
 l_Cell     : Tl3Variant;
//#UC END# *4EF0A285035D_4B72DF7B0164_var*
begin
//#UC START# *4EF0A285035D_4B72DF7B0164_impl*
 l_Doc := k2_typDocument.MakeTag.AsObject;
 try
  l_Text := aText;
  if (aZoom > 0) AND (aZoom < 100) then
  begin
   l_Table := k2_typTable.MakeTag.AsObject;
   l_Row := k2_typTableRow.MakeTag.AsObject;
   l_Cell := k2_typTableCell.MakeTag.AsObject;
   l_Table.IntA[k2_tiZoom] := aZoom;
   l_Doc.AddChild(l_Table.AsObject);
   l_Table.AddChild(l_Row.AsObject);
   l_Row.AddChild(l_Cell.AsObject);
   l_Cell.AddChild(l_Text.AsObject);
   if not l_Table.QT(InevObject, l_TableO) then
    Assert(false);
   if not l_Row.QT(InevObject, l_RowO) then
    Assert(false);
   if not l_Cell.QT(InevObject, l_CellO) then
    Assert(false);
  end//aZoom > 0..
  else
   l_Doc.AddChild(l_Text.AsObject);
  l_Cont := TnevDocumentContainer.Create;
  try
   TnevDocumentContainerHack(l_Cont).Document := l_Doc;
   if not l_Doc.QT(InevObject, l_DocO) then
    Assert(false);
   if not l_Text.QT(InevObject, l_TextO) then
    Assert(false);
   if not aFormula.QT(InevObject, l_FormulaO) then
    Assert(false);
   l_View := TnevVirtualDrawView.Create(l_DocO, nil, L3CrtIC As Il3Canvas, nil);
   try
    if (aZoom > 0) AND (aZoom < 100) then
     l_TextFI := InevObjectHolder(l_Cont).FormatPool.
                  FormatInfoForView(l_View).
                   InfoForChild(l_TableO).
                   InfoForChild(l_RowO).
                   InfoForChild(l_CellO).
                   InfoForChild(l_TextO)
    else
     l_TextFI := InevObjectHolder(l_Cont).FormatPool.
                  FormatInfoForView(l_View).
                   InfoForChild(l_TextO);
    Result := l_TextFI.InfoForChild(l_FormulaO).Rendered;
   finally
    FreeAndNil(l_View);
   end;//try..finally
  finally
   FreeAndNil(l_Cont);
  end;//try..finally
 finally
  l_Doc := nil;
 end;//try..finally
//#UC END# *4EF0A285035D_4B72DF7B0164_impl*
end;//DoRender

function RenderFormula(aBuf: PAnsiChar;
 aSize: Integer;
 aNumber: Integer;
 aZoom: Integer;
 const aPicture: IStream): Boolean;
//#UC START# *53BE8DDD026E_4B72DF7B0164_var*
//#UC END# *53BE8DDD026E_4B72DF7B0164_var*
begin
//#UC START# *53BE8DDD026E_4B72DF7B0164_impl*
 Result := RenderFormulaPrim(aBuf, aSize, aNumber, aZoom, aPicture, ee_rtPNG);
//#UC END# *53BE8DDD026E_4B72DF7B0164_impl*
end;//RenderFormula

function RenderFormulaPrim(aBuf: PAnsiChar;
 aSize: Integer;
 aNumber: Integer;
 aZoom: Integer;
 const aPicture: IStream;
 aTarget: TeeRenderTarget): Boolean;
//#UC START# *4B72DF930061_4B72DF7B0164_var*

 {$IfNDef notDebugStackTrace}
 procedure SaveStack(var S: String; AStackList: TJclStackInfoList);
 var
  I : Integer;
 begin//SaveStack
  try
   if (AStackList = nil) or (AStackList.Count <= 0) then
    S := S + '  [Stack is absent]'
   else
    with AStackList do
     for I := 0 to Count - 1 do
      S := S + #13#10 +  Format('  [Stack #%3d] %s',
       [I, GetLocationInfoStr(Pointer(Items[I].StackInfo.CallerAddr))]);
  except
  end;//try..except
 end;//SaveStack
 {$EndIf notDebugStackTrace}

var
 l_In      : Tl3ConstMemoryStream;
 l_Out     : TStream;
 l_Buf     : Tk2DocumentBuffer;
 l_Reader  : TevdNativeReader;
 l_Bmp     : Tl3BitmapContainer;
 l_Formula : Tl3Variant;
 l_Objects : Tl3Variant;
 l_Pic     : Il3Bitmap;
 l_C       : Il3Canvas;
// {$IfNDef nsTest}
 l_IO      : TImageEnIO;
// {$EndIf  nsTest}
 l_Written : Longint;
 l_S       : String;
 l_Seg     : Tl3Variant;
 l_Text    : Tl3Variant;
 l_Count   : Integer;
//#UC END# *4B72DF930061_4B72DF7B0164_var*
begin
//#UC START# *4B72DF930061_4B72DF7B0164_impl*
 l3System.EnterGlobalCS;
 try
  Result := true;
  // - будем оптимистами
  try
   l_In := Tl3ConstMemoryStream.Create(aBuf, aSize);
   try
    l_Buf := Tk2DocumentBuffer.Create;
    try
     l_Reader := TevdNativeReader.Create;
     try
      l_Reader.ForceBinary := true;
      l_Reader.CurrentVersion := evNonPackedVer;
      l_Reader.Generator := l_Buf;
      l_Reader.Filer.COMStream := l_In;
      try
       l_Reader.ForceBinary := true;
       l_Reader.Start;
       try
        l_Reader.StartChild(k2_typTextPara);
        try
         l_Reader.Execute;
        finally
         l_Reader.Finish;
        end;//try..finally
       finally
        l_Reader.Finish;
       end;//try..finally
      finally
       l_Reader.Filer.COMStream := nil;
      end;//try..finally
     finally
      FreeAndNil(l_Reader);
     end;//try..finally
     l_Bmp := Tl3BitmapContainer.Create;
     try
      l_Text := l_Buf.Root;
      Assert(l_Text.IsValid);                                
      l_Objects := l_Text.rAtomEx([k2_tiSegments,
                                      k2_tiChildren, k2_tiHandle, Ord(ev_slObjects)]);
      Assert(l_Objects.IsValid);                                
      Assert(l_Objects.ChildrenCount > 0);
      Assert(aNumber < l_Objects.ChildrenCount, 'Invalid number: ' + IntToStr(aNumber));
      
      l_Formula := nil;
      l_Count := 0;

      while (aNumber >= 0) do
      begin
       l_Formula := l_Objects.Child[l_Count];
       Assert(l_Formula.ChildrenCount > 0);
       l_Seg := l_Formula;
       l_Formula := l_Seg.Child[0];

       if l_Formula.IsKindOf(k2_typFormula) then
        Dec(aNumber)
       else
        l_Formula := nil;
       Inc(l_Count);
      end;//aNumber >= 0

      Assert(l_Formula.IsValid);
      Assert(l_Formula.IsKindOf(k2_typFormula));
      l_Pic := DoRender(l_Text, l_Formula, aZoom);
      Assert(l_Pic <> nil);
      l_Bmp.Width := l_Pic.Width;
      l_Bmp.Height := l_Pic.Height;
      Assert(l_Bmp.Width > 0);
      Assert(l_Bmp.Bitmap.Width > 0);
      l_C := l_Bmp.Canvas;
      try
       l_C.DrawEnabled := true;
       l_C.BeginPaint;
       try
        l_C.BackColor := clWhite;
//        l_C.FillRect(l3SRect(0, 0, l_Bmp.Width, l_Bmp.Height));
//        l_C.Canvas.FillRect(Rect(0, 0, l_Bmp.Width - 1, l_Bmp.Height - 1));
        l_C.Canvas.Brush.Color := clWhite;
(*        l_C.Canvas.FillRect(Rect(0, 0, l_Bmp.Width, l_Bmp.Height));
        l_C.FillRect(l3SRect(0, 0, l_Bmp.Width - 1, l_Bmp.Height - 1));
        l_C.FillRect(l3SRect(0, 0, l_Bmp.Width + 1, l_Bmp.Height + 1));
        l_C.FillRect(l3Rect(0, 0, l_Pic.InchWidth, l_Pic.InchHeight));*)
        l_Pic.StretchDraw(l3Rect(0, 0, l_Pic.InchWidth, l_Pic.InchHeight), l_C);
       finally
        l_C.EndPaint;
       end;//try..finally
      finally
       l_C := nil;
      end;//try..finally
      Assert(l_Bmp.Width > 0);
      Assert(l_Bmp.Bitmap.Width > 0);
      //l_Out := Tl3FileStream.Create('c:\1.png', l3_fmWrite);
      l3IStream2Stream(aPicture, l_Out);
      try
       if (aTarget = ee_rtRawBMP) then
        l_Bmp.Bitmap.SaveToStream(l_Out)
       else
       if (aTarget = ee_rtPNG) then
        l3BitmapToAlphaPNG(l_Bmp.Bitmap, l_Out)
       else
       begin
        l_IO := TImageEnIO.Create(nil);
        try
         //l_IO.AttachedBitmap := l_Bmp.Bitmap;
         l_IO.Bitmap := l_Bmp.Bitmap;
         l_IO.Params.BitsPerSample := 8;
         l_IO.Params.SamplesPerPixel := 1;
         l_IO.Params.Width := l_Bmp.Width;
         l_IO.Params.Height := l_Bmp.Height;
//         l_IO.Params.DPI := 72{l_Pic.DPI};
         if (aTarget = ee_rtBMP) then
          l_IO.SaveToStreamBMP(l_Out)
         else
         if (aTarget = ee_rtPNG) then
          l_IO.SaveToStreamPNG(l_Out)
         else
          Assert(false); 
         //l_IO.SaveToStreamJPEG(l_Out);
         //l_IO.SaveToStreamGif(l_Out);
         //l_IO.SaveToStreamBMP(l_Out);
        finally
         FreeAndNil(l_IO);
        end;//try..finally
       end;//aTarget = ee_rtRawBMP
      finally
       FreeAndNil(l_Out);
      end;//try..finally
     finally
      FreeAndNil(l_Bmp);
     end;//try..finally
    finally
     FreeAndNil(l_Buf);
    end;//try..finally
   finally
    FreeAndNil(l_In);
   end;//try..finally
  except
   on E : Exception do
   begin
    Result := false;
    // - все плохо :-(
    l_S := E.ClassName + ': ' + E.Message;
    {$IfNDef notDebugStackTrace}
    SaveStack(l_S, JclLastExceptStackList);
    {$EndIf  notDebugStackTrace}
    aPicture.Write(PAnsiChar(AnsiString(l_S)), Length(l_S), @l_Written);
   end;//on E : Exception
   else
    Result := false;
    // - совсем все плохо :-(
  end;//try..except
 finally
  l3System.LeaveGlobalCS;
 end;//try..finally
//#UC END# *4B72DF930061_4B72DF7B0164_impl*
end;//RenderFormulaPrim

end.
