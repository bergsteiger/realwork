unit D_Base;

{ Автор: Люлин А.В. ©     }
{ Модуль: D_Base -        }
{ Начат: 21.02.2001 12:02 }
{ $Id: D_Base.pas,v 1.8 2015/04/28 14:59:47 lulin Exp $ }

// $Log: D_Base.pas,v $
// Revision 1.8  2015/04/28 14:59:47  lulin
// - рефакторим.
//
// Revision 1.7  2015/04/28 13:25:00  lulin
// - рефакторим.
//
// Revision 1.6  2015/04/28 10:44:44  lulin
// - рефакторим.
//
// Revision 1.5  2015/03/17 10:08:54  lulin
// - перетряхиваем зависимости.
//
// Revision 1.4  2014/05/08 07:14:39  dinishev
// {Requestlink:515834360}
//
// Revision 1.3  2014/01/31 03:08:57  fireton
// - не собиралось
//
// Revision 1.2  2014/01/30 12:39:26  dinishev
// Делаем окно установки границ тестируемым.
//
// Revision 1.1  2002/10/18 11:31:28  law
// - new folder: Meta.
//
// Revision 1.3  2001/05/07 08:54:36  law
// - new behavior: Tl3Tree ->Il3RootNode.
// - cleanup: убраны ненужные ссылки на RXSpin.
//
// Revision 1.2  2001/02/21 14:26:41  law
// - убраны ненужные ссылки на модуль vbSpin.
//
// Revision 1.1  2001/02/21 12:27:19  law
// - добавлен диалог со свойствами документа.
//

interface

{$Include l3Define.inc}

uses WinTypes, WinProcs, Classes, Graphics, Forms, Controls, Buttons,
  StdCtrls, ExtCtrls, OvcBase, l3Types;

type
  TBaseDlg = class(TForm)
    pnButtons: TPanel;
    btOk: TBitBtn;
    btCancel: TBitBtn;
    pnMain: TPanel;
  public
   {$IfDef InsiderTest}
    g_AllowModal : Integer;
     {-}
   function ShowModal: integer;
     override;
     {-}
   {$IfDef l3HackedVCL}
   function NeedCancelModal: Boolean;
     override;
     {-}
   {$EndIf l3HackedVCL}
  {$EndIf InsiderTest}
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.DFM}

{$IFDEF InsiderTest}
uses
 afwAnswer,
 seModalSupport,
 l3BatchService
 ;
{$ENDIF InsiderTest}

constructor TBaseDlg.Create(AOwner: TComponent);
begin
 inherited;
 {$IfDef InsiderTest}
 g_AllowModal := 0;
 {$EndIf InsiderTest}
end;

{$IfDef InsiderTest}
{$IfDef l3HackedVCL}
function TBaseDlg.NeedCancelModal: Boolean;
begin
 Result := False;
 {$IfDef InsiderTest}
 if Tl3BatchService.Instance.IsBatchMode then
 begin
  if Tl3BatchService.Instance.ExecuteCurrentModalWorker then
  begin
   if (ModalResult = 0) then
   begin
    Result := true;
    Exit;
   end;//ModalResult = 0
  end//seExecuteCurrentModalWorker
  else
  begin
   Result := true;
  end;//seExecuteCurrentModalWorker
 end;//g_BatchMode
 {$EndIf InsiderTest}
end;
{$EndIf l3HackedVCL}

function TBaseDlg.ShowModal: integer;
begin
 {$IfDef InsiderTest}
 Assert(g_AllowModal >= 0);
 if Tl3BatchService.Instance.IsBatchMode then
  if (g_AllowModal <= 0) then
   if (Application.MainForm <> nil) then
    if not Tl3BatchService.Instance.HasModalWorker then
     raise EafwTryEnterModalState.Create('Здесь надо обрабатывать модальность формы');
 {$EndIf InsiderTest}
 Result := inherited ShowModal;
end;
{$ENDIF InsiderTest}

end.
