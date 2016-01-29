unit evAppForm;
{* Форма ведущая себя как отдельное окно приложения. }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evAppForm -     }
{ Начат: 14.09.2001 14:13 }
{ $Id: evAppForm.pas,v 1.6 2013/06/03 10:14:03 lulin Exp $ }

// $Log: evAppForm.pas,v $
// Revision 1.6  2013/06/03 10:14:03  lulin
// - портируем под XE4.
//
// Revision 1.5  2013/04/25 14:22:38  lulin
// - портируем.
//
// Revision 1.4  2007/12/04 12:47:43  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.1.58.2  2007/10/03 13:44:05  lulin
// - bug fix: не компилировалось.
//
// Revision 1.1.58.1  2006/12/10 18:58:59  lulin
// - класс формы переименован в соответствии с библиотекой.
//
// Revision 1.1  2001/09/14 10:33:43  law
// - new unit: evAppForm.
//

{$Include evDefine.inc }

interface

uses
  Windows,
  Messages,

  Controls,
  Forms,
  
  l3Types,
  l3Base,

  l3Forms
  ;

type
  TevAppForm = class(Tl3Form)
   {* Форма ведущая себя как отдельное окно приложения. }
    private
    // message handlers
      procedure WMSysCommand(var Message: TWMSysCommand);
        message WM_SysCommand;
        {-}
    protected
    // internal methods
      procedure CreateParams(var Params: TCreateParams);
        override;
        {-}
      procedure DoClose(var Action: TCloseAction);
        override;
        {-}
  end;//TevAppForm

implementation

uses
  Classes
  ;

// start class TevAppForm

procedure TevAppForm.CreateParams(var Params: TCreateParams);
  //override;
  {-}
var
 l_ExtendedStyle : Integer;
begin
 inherited;
// if (Application.MainForm <> nil) AND (Application.MainForm <> Self) then
  with Params do ExStyle := ExStyle or WS_EX_APPWINDOW;
 l_ExtendedStyle := GetWindowLong(Application.Handle, GWL_EXSTYLE);
 SetWindowLong(Application.Handle,
               GWL_EXSTYLE,
               l_ExtendedStyle or WS_EX_TOOLWINDOW {AND NOT WS_EX_APPWINDOW});
end;

type
  {$IfDef XE}
  {$Align 8}
  [RootDesignerSerializerAttribute('', '', False)]
  {$IfDef XE4}
  THackApplication = class(TComponent)
  private type
    TBiDiKeyboard = record
      private
        BiDiKeyboard, NonBiDiKeyboard: string;
        BiDiKeyboardHKL, NonBiDiKeyboardHKL: HKL;
    end;
  private
    FAppIconic: Boolean;
    FBiDiMode: TBiDiMode;
    FBiDiKeyboard: TBiDiKeyboard;
    FDefaultFont: TFont;
    FMainForm: TForm;
  end;//THackApplication
  {$Else  XE4}
  THackApplication = class(TComponent)
  private
    FAppIconic: Boolean;
    FBiDiMode: TBiDiMode;
    FBiDiKeyboard: string;
    FDefaultFont: TFont;
    FNonBiDiKeyboard: string;
    FMainForm: TForm;
  end;//THackApplication
  {$EndIf XE4}
  {$Align 1}
  {$Else XE}
  THackApplication = class(TComponent)
  private
   FHandle          : HWnd;
   FBiDiMode        : TBiDiMode;
   FBiDiKeyboard    : string;
   FNonBiDiKeyboard : string;
   FObjectInstance  : Pointer;
   FMainForm        : TForm;
  end;//THackApplication
  {$EndIf XE}

procedure TevAppForm.DoClose(var Action: TCloseAction);
  //override;
  {-}
var
 i : Long;
 l_Form : TForm;
begin
 if (Application.MainForm = Self) AND (Screen.FormCount > 1) then begin
  for i := 0 to Pred(Screen.FormCount) do begin
   l_Form := Screen.Forms[i];
   if (l_Form <> Self) AND (l_Form Is TevAppForm) then begin
    THackApplication(Application).FMainForm := l_Form;
   end;//l_Form <> Self
  end;//for i
 end;
 Action := caFree;
 inherited;
end;

procedure TevAppForm.WMSysCommand(var Message: TWMSysCommand);
begin
 with Message do begin
  if (CmdType and $FFF0 = SC_MINIMIZE) and (Application.MainForm = Self) then
   DefaultHandler(Message)
  else
   inherited;
 end;//with Message
end;

end.

