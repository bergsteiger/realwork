unit tb97GraphicControl;

{ Библиотека "Toolbar 97" }
{ Автор: Люлин А.В. ©     }
{ Модуль: tb97GraphicControl - }
{ Начат: 16.09.2004 14:12 }
{ $Id: tb97GraphicControl.pas,v 1.16 2015/01/15 13:50:33 lulin Exp $ }

// $Log: tb97GraphicControl.pas,v $
// Revision 1.16  2015/01/15 13:50:33  lulin
// {RequestLink:585926571}. Используем Interlocked.
//
// Revision 1.15  2008/02/14 19:32:36  lulin
// - изменены имена файлов с примесями.
//
// Revision 1.14  2008/02/14 14:12:21  lulin
// - <K>: 83920106.
//
// Revision 1.13  2008/02/07 08:37:56  lulin
// - каждому базовому объекту по собственному модулю.
//
// Revision 1.12  2008/01/25 12:06:57  lulin
// - синхронизируем имена с моделью.
//
// Revision 1.11  2008/01/25 11:32:12  lulin
// - синхронизируем имена с моделью.
//
// Revision 1.10  2007/04/02 12:27:31  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.9  2007/04/02 08:47:19  lulin
// - для заголовков кнопок используем строки с кодировкой.
//
// Revision 1.8  2007/03/30 12:39:32  lulin
// - cleanup.
//
// Revision 1.7  2007/03/30 08:39:17  lulin
// - используем "родную" канву для рисования.
//
// Revision 1.6  2007/03/30 08:11:43  lulin
// - cleanup.
//
// Revision 1.5  2007/01/18 10:49:39  lulin
// - заменяем объект менеджера памяти на интерфейс.
//
// Revision 1.4  2006/04/14 13:40:30  lulin
// - запрещаем перекрывать деструктор.
//
// Revision 1.3  2006/04/14 12:11:22  lulin
// - файлу с шаблоном дано более правильное название.
//
// Revision 1.2  2006/04/14 11:53:10  lulin
// - объединил интерфейс и реализацию _Unknown_ в один файл.
//
// Revision 1.1  2004/09/16 11:31:13  lulin
// - навел подобие порядка с регистрацией компонент библиотеки.
//

{$Include TB97Ver.inc}

interface

uses
  Messages,
  Windows,
  Classes,
  Controls,

  l3Interfaces,
  l3InternalInterfaces,
  l3GraphicControlCanvas,

  afwInterfaces
  ;

type
  _l3Unknown_Parent_ = TGraphicControl;
  {$Define _UnknownIsComponent}
  {$Include l3Unknown.imp.pas}
  Ttb97CustomGraphicControl = class(_l3Unknown_)
    private
    // internal fields
      f_Canvas : Tl3GraphicControlCanvas;
    protected
    // protected methods
      {$IfDef DesignTimeLibrary}
      function CheckStamp(const aGUID: TGUID): Boolean;
        {-}
      {$EndIf DesignTimeLibrary}
    {$I l3DefineCleanup.inc}
      procedure Paint;
        override;
        {-}
      procedure DoPaint(const aCN: Il3Canvas);
        virtual;
        {-}
    protected
    // internal properties
      property Canvas: Tl3GraphicControlCanvas
        read f_Canvas;
        {-}
    public
    // public methods
      constructor Create(AOwner : TComponent);
        override;
        {-}
  end;//Ttb97CustomGraphicControl

  Ttb97GraphicControl = class(Ttb97CustomGraphicControl)
    protected
    // internal methods
      procedure Paint;
        reintroduce;
        {-}
  end;//Ttb97GraphicControl

  Ttb97GraphicTextControl = class(Ttb97GraphicControl, IafwTextControl)
    private
    // internal fields
      f_Text   : Il3CString;
    protected
    // property methods
      function  pm_GetCCaption: IafwCString;
      procedure pm_SetCCaption(const aValue: Il3CString);
        {-}
      function  pm_GetCaption: Tl3DString;
      procedure pm_SetCaption(const aValue: Tl3DString);
      function  CaptionStored: Boolean;
        {-}
    protected
    // protected methods
      procedure WMGetText(var Msg: TMessage);
        message WM_GetText;
        {-}
      procedure WMGetTextLength(var Msg: TMessage);
        message WM_GetTextLength;
        {-}
      procedure WMSetText(var Msg: TMessage);
        message WM_SetText;
        {-}
      procedure Cleanup;
        override;
        {-}  
    public
    // public properties
      property Caption: Tl3DString
        read pm_GetCaption
        write pm_SetCaption
        stored CaptionStored;
        {-}
      property CCaption: Il3CString
        read f_Text
        write pm_SetCCaption;
        {-}  
  end;//Ttb97GraphicTextControl

implementation

uses
  SysUtils,

  l3Base,
  l3String,
  l3Interlocked,

  afwVCL
  ;

{$Include l3Unknown.imp.pas}

constructor Ttb97CustomGraphicControl.Create(AOwner : TComponent);
begin
 inherited Create(AOwner);
 afwHackControlFont(Self);
 f_Canvas := Tl3GraphicControlCanvas.Create(Self);
end;

type
 _Unknown_Child_ = Ttb97CustomGraphicControl;
{$I l3ImplCleanup.inc}
begin
 l3Free(f_Canvas);
 inherited;
end;

{$IfDef DesignTimeLibrary}
function Ttb97CustomGraphicControl.CheckStamp(const aGUID: TGUID): Boolean;
  {-}
begin
 Result := false;
end;
{$EndIf DesignTimeLibrary}

procedure Ttb97CustomGraphicControl.Paint;
  //override;
  {-}
begin
 Canvas.BeginPaint;
 try
  Canvas.DrawEnabled := true;
  DoPaint(Canvas);
 finally
  Canvas.EndPaint;
 end;//try..finally
end;

procedure Ttb97CustomGraphicControl.DoPaint(const aCN: Il3Canvas);
  //virtual;
  {-}
begin
end;

// start class Ttb97GraphicControl

procedure Ttb97GraphicControl.Paint;
  //reintroduce;
  {-}
begin
 Assert(false);  
end;

// start class Ttb97GraphicTextControl

procedure Ttb97GraphicTextControl.Cleanup;
  //override;
  {-}
begin
 f_Text := nil;
 inherited;
end;

procedure Ttb97GraphicTextControl.WMGetText(var Msg: TMessage);
  {message WM_GetText;}
  {-}
begin
 with Msg do
  Result := StrLen(StrLCopy(PChar(LParam), PChar(l3Str(CCaption)), WParam - 1));
end;

procedure Ttb97GraphicTextControl.WMGetTextLength(var Msg: TMessage);
  {message WM_GetTextLength;}
  {-}
begin
 Msg.Result := l3Len(CCaption);
end;

procedure Ttb97GraphicTextControl.WMSetText(var Msg: TMessage);
  {message WM_SetText;}
  {-}
begin
 if (Msg.lParam <> 0) then
 begin
  Msg.Result := Ord(true);
  CCaption := l3CStr(l3PCharLen(PChar(Msg.lParam)));
 end//Msg.lParam <> 0
 else
  Msg.Result := Ord(false);
end;

function Ttb97GraphicTextControl.pm_GetCCaption: IafwCString;
  {-}
begin
 Result := f_Text;
end;

procedure Ttb97GraphicTextControl.pm_SetCCaption(const aValue: Il3CString);
  {-}
begin
 if not l3Same(f_Text, aValue) then
 begin
  f_Text := aValue;
  Perform(CM_TEXTCHANGED, 0, 0);
  SendDockNotification(afw_CM_TEXTCHANGED, 0, Integer(aValue));
 end;//not l3Same(f_Text, aValue)
end;

function Ttb97GraphicTextControl.pm_GetCaption: Tl3DString;
  {-}
begin
 Result := l3DStr(CCaption);
end;

procedure Ttb97GraphicTextControl.pm_SetCaption(const aValue: Tl3DString);
  {-}
begin
 CCaption := l3CStr(aValue);
end;

type
  THackLink = class(TControlActionLink);

function Ttb97GraphicTextControl.CaptionStored: Boolean;
  {-}
begin
 Result := not l3IsNil(CCaption) AND
           ((ActionLink = nil) or not THackLink(ActionLink).IsCaptionLinked);
end;

end.

