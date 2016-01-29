unit nsSignControl;

// $Id: nsSignControl.pas,v 1.9 2004/05/13 18:14:44 law Exp $

// $Log: nsSignControl.pas,v $
// Revision 1.9  2004/05/13 18:14:44  law
// no message
//
// Revision 1.8  2004/05/05 14:37:01  law
// - new build.
//
// Revision 1.7  2004/05/03 11:21:25  law
// - добавлена проверка.
//
// Revision 1.6  2004/05/03 09:49:56  law
// - new version.
//
// Revision 1.5  2004/04/30 15:58:28  law
// - добавлены проверки.
//
// Revision 1.4  2004/04/30 15:47:51  law
// - new directive.
//
// Revision 1.3  2004/04/30 14:52:37  law
// - bug fix.
//
// Revision 1.2  2004/04/30 13:26:09  law
// - bug fix.
//
// Revision 1.1  2004/04/30 10:27:09  law
// - new build.
//

{$Include nsDefine.inc }

interface

uses
  Controls
  ;

function SignControl(aControl: TWinControl): Boolean;
  {-}

implementation

uses
  Windows,
  Messages,

  Math,

  nsSign
  ;
  
function SignControl(aControl: TWinControl): Boolean;
const
 l_MinSize = 50;
 //l_PartSize = 300;
 //l_PartSize = 512;
 //l_PartSize = 256;
 //l_PartSize = 128;
 l_PartSize = 100;
 //l_PartSize = 64;
var
 l_AllControlBmp  : hBitmap;
 l_SignControlBmp : TBMP;
 l_OldAllBitmap   : hBITMAP;
 l_OldSignBitmap  : hBITMAP;
 l_AllControlDC   : hDC;
 l_SignControlDC  : hDC;
 l_PS             : TPaintStruct;
 l_DC             : HDC;
 l_AllH           : Integer;
 l_AllW           : Integer;
 l_SignH          : Integer;
 l_SignW          : Integer;
// l_Rect           : TRect;
begin
 Result := false;
 if (aControl <> nil) AND CanSign then
  with aControl do
   begin
    l_AllW := ClientRect.Right;
    l_AllH := ClientRect.Bottom;
    l_SignW := Min(l_PartSize, l_AllW);
    l_SignH := Min(l_PartSize, l_AllH);
    if (l_SignW >= l_MinSize) AND (l_SignH >= l_MinSize) then
    begin
     Result := true; 
     l_AllControlDC := CreateCompatibleDC(0);
     try
      l_DC := GetDC(0);
      l_AllControlBmp := CreateCompatibleBitmap(l_DC, l_AllW, l_AllH);
      ReleaseDC(0, l_DC);
      //CreateDIB(l_AllW, l_AllH, l_AllControlBmp);
      try
       l_OldAllBitmap := SelectObject(l_AllControlDC, l_AllControlBmp{.Bitmap});
       try
//        GetClipBox(l_AllControlDC, l_Rect);
        FillRect(l_AllControlDC, ClientRect, hBrush(COLOR_WINDOW+1));
        Perform(WM_ERASEBKGND, WParam(l_AllControlDC), LParam(l_AllControlDC));
        Perform(WM_Paint, WParam(l_AllControlDC), 0);
        l_SignControlDC := CreateCompatibleDC(0);
        try
         if CreateDIB(l_SignW, l_SignH, l_SignControlBmp) then
         try
          l_OldSignBitmap := SelectObject(l_SignControlDC, l_SignControlBmp.Bitmap);
          try
           BitBlt(l_SignControlDC, 0, 0, l_SignW, l_SignH, l_AllControlDC, 0, 0, SRCCOPY);
           if SignBitmap(l_SignControlBmp) then
           begin
            {$IfDef Console}
            WriteLn(aControl.Name, ':');
            WriteLn('Real key = ', CheckBitmap(l_SignControlBmp));
            CheckBitmapFake(l_SignControlBmp);
            {$EndIf Console}
            BitBlt(l_AllControlDC, 0, 0, l_SignW, l_SignH, l_SignControlDC, 0, 0, SRCCOPY);
           end;//SignBitmap(l_SignControlBmp)
          finally
           SelectObject(l_SignControlDC, l_OldSignBitmap);
          end;//try..finally
         finally
          FreeDIB(l_SignControlBmp);
         end;//try..finally
        finally
         DeleteDC(l_SignControlDC);
        end;//try..finally
        l_DC := BeginPaint(Handle, l_PS);
        try
         BitBlt(l_DC, 0, 0, l_AllW, l_AllH, l_AllControlDC, 0, 0, SRCCOPY);
        finally
         EndPaint(Handle, l_PS);
        end;//try..finally
       finally
        SelectObject(l_AllControlDC, l_OldAllBitmap);
       end;//try..finally
      finally
       DeleteObject(l_AllControlBmp);//FreeDIB(l_AllControlBmp);
      end;//try..finally
     finally
      DeleteDC(l_AllControlDC);
     end;//try..finally
    end;//l_SignW >= l_MinSize..
   end;//with aControl
end;

end.
