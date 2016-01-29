unit MainMDI;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: MainMDI -       }
{ Начат: 02.10.2001 12:46 }
{ $Id: MainMDI.pas,v 1.7 2007/12/05 13:51:26 lulin Exp $ }

// $Log: MainMDI.pas,v $
// Revision 1.7  2007/12/05 13:51:26  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.4.6.2  2006/12/21 16:19:01  dinishev
// Bug fix: Everest в ветке не компилировался
//
// Revision 1.4.6.1  2006/02/07 15:15:57  lulin
// - попытка доточить под ветку (пока неудачно).
//
// Revision 1.4  2003/10/13 15:06:38  law
// - rename unit: evEdWnd -> evEditorWindow.
//
// Revision 1.3  2002/09/18 12:37:23  law
// - new behavior: добавлена возможность просмотра документа как в Web.
//
// Revision 1.2  2002/04/06 11:33:49  law
// - Delphi 6.0.
//
// Revision 1.1.2.4  2001/10/11 12:41:29  law
// - new behavior: отрываем функциональность от интерфейса.
//
// Revision 1.1.2.3  2001/10/03 16:54:09  law
// - new behavior: сделаны меню на TAction.
//
// Revision 1.1.2.2  2001/10/02 15:07:16  law
// - new unit: MainEditor.
//
// Revision 1.1.2.1  2001/10/02 12:32:16  law
// - new units: MainMDI и MainMDIEx - в них вынесена часть функциональности с основной формы.
//

{$I evDefine.inc }

interface

uses
  Classes,

  l3Types,
  
  l3Forms,
  evEditorWindow,

  EdWin
  ;

type
  TevMainMDIForm = class(Tl3Form)
    private
    // property fields
      FActiveEditor : TEditorWindow;
      f_Terminating : Bool;
    protected
    // property methods
      procedure SetActiveEditor(Value : TEditorWindow);
        {-}
      function  pm_GetAdjustMargin: Bool;
        virtual;
      procedure pm_SetAdjustMargin(aValue: Bool);
        virtual;
        {-}
      function  pm_GetShowDocumentParts: Bool;
        virtual;
      procedure pm_SetShowDocumentParts(Value: Bool);
        virtual;
        {-}
      function  pm_GetPrintPreview: Bool;
        virtual;
      procedure pm_SetPrintPreview(Value: Bool);
        virtual;
        {-}
      function  pm_GetShowSpecial: Bool;
        virtual;
      procedure pm_SetShowSpecial(Value: Bool);
        virtual;
        {-}
      function  pm_GetPersistentBlocks: Bool;
        virtual;
      procedure pm_SetPersistentBlocks(Value: Bool);
        virtual;
        {-}
      function  pm_GetWebStyle: Bool;
        virtual;
      procedure pm_SetWebStyle(aValue: Bool);
        virtual;
        {-}
    protected
    // internal methods
      procedure UpdateMRU;
        virtual;
        {-}
      procedure MakePanelsMenu;
        virtual;
        {-}
      procedure DocBarInsert(const aDocName: String);
        virtual;
        {-}
    public
    // public methods
      procedure CheckEditorProperties(aEditor: TevCustomEditorWindow);
        virtual;
        {-}
      function CloseQuery: Boolean;
        virtual;
        {-}
    public
    // public properties
      property ActiveEditor: TEditorWindow
        read FActiveEditor
        write SetActiveEditor;
        {-}
      property AdjustMargin: Bool
        read pm_GetAdjustMargin
        write pm_SetAdjustMargin;
        {-}
      property ShowDocumentParts: Bool
        read pm_GetShowDocumentParts
        write pm_SetShowDocumentParts;
        {-}
      property PrintPreview: Bool
        read pm_GetPrintPreview
        write pm_SetPrintPreview;
        {-}
      property ShowSpecial: Bool
        read pm_GetShowSpecial
        write pm_SetShowSpecial;
        {-}
      property PersistentBlocks: Bool
        read pm_GetPersistentBlocks
        write pm_SetPersistentBlocks;
        {-}
      property WebStyle: Bool
        read pm_GetWebStyle
        write pm_SetWebStyle;
        {-}
      property Terminating: Bool
        read f_Terminating
        write f_Terminating;
        {-}  
  end;//TevMainMDIForm

implementation

// start class TevMainMDIForm

procedure TevMainMDIForm.SetActiveEditor(Value : TEditorWindow);
begin
 If (FActiveEditor = Value) or
    (csDestroying in ComponentState) then Exit;
 FActiveEditor := Value;
 if (FActiveEditor <> nil) then
  CheckEditorProperties(FActiveEditor.Editor);
end;

procedure TevMainMDIForm.CheckEditorProperties(aEditor: TevCustomEditorWindow);
  //virtual;
  {-}
begin
end;

procedure TevMainMDIForm.UpdateMRU;
  //virtual;
  {-}
begin
end;

procedure TevMainMDIForm.DocBarInsert(const aDocName: String);
  //virtual;
  {-}
begin
end;

function TevMainMDIForm.pm_GetAdjustMargin: Bool;
  //virtual;
  {-}
begin
 Result := false;
end;

procedure TevMainMDIForm.pm_SetAdjustMargin(aValue: Bool);
  //virtual;
  {-}
begin
end;

function TevMainMDIForm.pm_GetShowDocumentParts: Bool;
  //virtual;
  {-}
begin
 Result := false;
end;

procedure TevMainMDIForm.pm_SetShowDocumentParts(Value: Bool);
  //virtual;
  {-}
begin
end;

function TevMainMDIForm.pm_GetPrintPreview: Bool;
  //virtual;
  {-}
begin
 Result := false;
end;

procedure TevMainMDIForm.pm_SetPrintPreview(Value: Bool);
  //virtual;
  {-}
begin
end;

function TevMainMDIForm.pm_GetShowSpecial: Bool;
  //virtual;
  {-}
begin
 Result := false;
end;

procedure TevMainMDIForm.pm_SetShowSpecial(Value: Bool);
  //virtual;
  {-}
begin
end;

function TevMainMDIForm.pm_GetPersistentBlocks: Bool;
  //virtual;
  {-}
begin
 Result := false;
end;

procedure TevMainMDIForm.pm_SetPersistentBlocks(Value: Bool);
  //virtual;
  {-}
begin
end;

function TevMainMDIForm.pm_GetWebStyle: Bool;
  //virtual;
  {-}
begin
 Result := false;
end;

procedure TevMainMDIForm.pm_SetWebStyle(aValue: Bool);
  //virtual;
  {-}
begin
end;

function TevMainMDIForm.CloseQuery: Boolean;
  //virtual;
  {-}
begin
 Result := inherited CloseQuery;
 if Result then Terminating := true;
end;

procedure TevMainMDIForm.MakePanelsMenu;
  //virtual;
  {-}
begin
end;

end.

