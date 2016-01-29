unit MainMDIEx;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: MainMDI -       }
{ Начат: 02.10.2001 12:46 }
{ $Id: MainMDIEx.pas,v 1.24 2014/10/16 11:00:27 lukyanets Exp $ }

// $Log: MainMDIEx.pas,v $
// Revision 1.24  2014/10/16 11:00:27  lukyanets
// Более контролируемо создаем конфиги
//
// Revision 1.23  2013/10/30 13:30:57  lulin
// {RequestLink:496335963}
//
// Revision 1.22  2013/10/23 12:26:00  lulin
// - автоматически определяемые типы тоже генерируем с модели.
//
// Revision 1.21  2013/02/26 15:09:33  lulin
// - не грузим файл по ключам от тестов.
// - создаём map-файл.
//
// Revision 1.20  2012/10/29 16:55:39  lulin
// - вычищаем поддержку ветки редактора.
//
// Revision 1.19  2011/12/05 12:00:13  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.18  2011/11/15 08:25:45  dinishev
// Bug fix: падали при открытии документа.
//
// Revision 1.17  2009/03/04 14:17:45  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.16  2008/04/15 17:36:13  lulin
// - автоматизируем переключение между версиями редактора.
//
// Revision 1.15  2007/12/05 13:51:26  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.12.4.4  2007/09/20 14:08:08  lulin
// - bug fix: не сохранялись параметры.
//
// Revision 1.12.4.3  2007/08/29 18:43:08  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.12.4.2  2006/12/21 16:18:47  dinishev
// Bug fix: Everest в ветке не компилировался
//
// Revision 1.12.4.1  2006/02/08 14:47:50  lulin
// - собрал Everest в ветке.
//
// Revision 1.12  2005/03/04 18:47:12  lulin
// - bug fix: использовалась неправильная константа типа документа.
//
// Revision 1.11  2005/03/03 17:30:34  lulin
// - в Эвересте теперь есть возможность задания типа вновь создаваемого файла.
//
// Revision 1.10  2004/12/23 11:47:09  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.9  2002/11/22 13:15:12  law
// - change: DocBar переехал в MainEditor.
//
// Revision 1.8  2002/10/15 11:43:50  law
// - new action: acAdjustMargin.
//
// Revision 1.7  2002/10/10 13:52:30  law
// - cleanup.
//
// Revision 1.6  2002/09/18 12:37:23  law
// - new behavior: добавлена возможность просмотра документа как в Web.
//
// Revision 1.5  2002/04/23 15:50:50  law
// - new proc: UpdateItems.
//
// Revision 1.4  2002/04/08 11:48:30  law
// no message
//
// Revision 1.3  2002/04/06 16:20:17  law
// - new library: Express Bars 4.1.
//
// Revision 1.2  2002/04/06 11:33:49  law
// - Delphi 6.0.
//
// Revision 1.1.2.7  2002/04/06 11:25:14  law
// - cleanup & bugfix.
//
// Revision 1.1.2.6  2002/01/08 08:11:49  law
// - cleanup: убрано использование agOpenDialog.
//
// Revision 1.1.2.5  2001/12/18 14:13:56  law
// - new unit: evSaveDocumentManager.
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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MainMDI, l3Types, l3InternalInterfaces, k2Reader, EdWin, 
  evLoadDocumentManager, evSaveDocumentManager, l3InterfacedComponent;

const
 gNewDocName = 'НОВЫЙ ДОКУМЕНТ';

type
  TevMainMDIFormEx = class(TevMainMDIForm, Il3ActionProcessor)
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    SaveManager: TevSaveDocumentManager;
    LoadManager: TevLoadDocumentManager;
  protected
  // internal methods
      procedure BeforeRelease;
        override;
        {-}
      procedure DoCreate;
        override;
        {-}
  public
  // public methods
    function CreateMDIChild(aSender       : TObject;
                            const WinName : string = gNewDocName): TForm;
      virtual;
      {-}
    function  SaveToFile(aEditor : TEditorWindow = nil): String;
      virtual;
      {-}
    procedure UpdateName(aEditor : TCustomForm; const aName: String);
      virtual;
      {-}
    procedure UpdateItems;
      virtual;
      {-}  
    function Process(Sender : TObject;
                     Target : TObject;
                     Action : Long; 
                     Down   : Bool): Bool;
      overload;               
      virtual;               
      {-}
    function Process(Action : Long;
                     Down   : Bool = false): Bool;
      overload;
      {-}
    procedure CloseMDIChild(Form: TForm);
      virtual;
      {-}
  end;//TevMainMDIFormEx

implementation

{$R *.dfm}

uses
  l3Base,
  l3String,
  l3Chars,
  l3FileUtils,

{$IFDEF EverestLite}
 dmStdResLite,
{$ELSE}
 dmStdRes,
{$ENDIF EverestLite}

  evStandardActions,
  evDisp,

  k2Tags,
  k2Base,
  k2TagGen,
  k2Facade,
  k2Empty_Const,
  
  ddHTML_r,

  vtVerInf,
  
  l3IniFile,
  IniShop,
  
  Document_Const
  ;

// start class TevMainMDIFormEx

function TevMainMDIFormEx.CreateMDIChild(aSender       : TObject;
                                         const WinName : string = gNewDocName): TForm;
  {-}
var
 l_Type              : Tk2Type;
 l_Index             : Long;
 l_ShowSpecial       : Bool;
 l_ShowDocumentParts : Bool;
 l_AdjustMargin      : Bool;
 l_PrintPreview      : Bool;
 {$IfNDef evExternalProduct}
 l_Time              : TDateTime;
 {$EndIf  evExternalProduct}
begin
 Result := nil;
 if (LoadManager.FileName <> '') AND (LoadManager.FileName[1] = '-') then
 begin
  LoadManager.FileName := '';
  Exit;
 end;
 l_ShowDocumentParts := ShowDocumentParts;
 IniRec^.WebStyle := WebStyle;
 l_PrintPreview := PrintPreview;
 l_ShowSpecial := ShowSpecial;
 l_AdjustMargin := AdjustMargin;
 if (LoadManager.FileName <> '') then begin
  with OpenDialog.HistoryList do begin
   l_Index := IndexOf(LoadManager.FileName);
   if (l_Index = -1) then Insert(0, LoadManager.FileName) else Move(l_Index, 0);
  end;{with HistoryList}
  UpdateMRU;
 end;{LoadManager.FileName <> ''}
 ActiveEditor := TEditorWindow.Create(Self);
 Result := ActiveEditor;
 DocBarInsert(WinName);
 with ActiveEditor do begin
  VSubPanel1.SubDescriptors := dmStandardRes.SubDescriptors;
  VSubPanel1.Width := 5;
  VSubPanel2.SubDescriptors := dmStandardRes.SubDescriptors;
  VSubPanel2.Width := 5;
  Editor1.Process(nil, nil, Ord(ev_ccShowDocumentParts), l_ShowDocumentParts);
  Editor1.Process(nil, nil, Ord(ev_ccPrintPreview), l_PrintPreview);
  Editor1.Canvas.DrawSpecial := l_ShowSpecial;
  Editor2.Canvas.DrawSpecial := l_ShowSpecial;
  if (Editor1.Selection <> nil) then
   Editor1.Selection.Persistent := IniRec^.PersistentBlocks;
  if (Editor2.Selection <> nil) then
   Editor2.Selection.Persistent := IniRec^.PersistentBlocks;
  AdjustMargin := l_AdjustMargin;
  Editor1.WebStyle := IniRec^.WebStyle;
  Editor2.WebStyle := IniRec^.WebStyle;
  Caption := WinName;
  {$IfNDef evExternalProduct}
  l_Time := Now;
  {$EndIf  evExternalProduct}
  if (aSender Is TComponent) then
   l_Type := k2.TypeTable.TypeByHandle[TComponent(aSender).Tag]
  else
   l_Type := nil;
  if (l_Type = nil) OR (l_Type = k2_typEmpty) then
   l_Type := k2_typDocument;
  LoadManager.Load(TextSource, l_Type);
  {$IfNDef evExternalProduct}
  l_Time := Now - l_Time;
  if (pnMeter.Caption = '') then
   pnMeter.Caption := TimeToStr(l_Time)
  else
   pnMeter.Caption := TimeToStr(l_Time) + ' - ' + pnMeter.Caption;
  {$EndIf  evExternalProduct}
 end;{with ActiveEditor}
 UpdateItems;
end;

procedure TevMainMDIFormEx.UpdateItems;
  //virtual;
  {-}  
begin
end;
  
procedure TevMainMDIFormEx.DoCreate;
  //override;
  {-}
var
 VI : TVersionInfo;
begin
 InitUserConfig;
 New(IniRec);
 l3FillChar(IniRec^, SizeOf(TIniRecord), 0);
 IniRec^.OpenDialog := OpenDialog;
 IniRec^.SaveDialog := SaveDialog;
 SetIniRecord;
 ShowSpecial := IniRec^.ShowSpecial;
 ShowDocumentParts := IniRec^.Preferences.View.ShowDocumentParts;
 PrintPreview := IniRec^.Preferences.View.PrintPreview;
 PersistentBlocks := IniRec^.PersistentBlocks;
 WebStyle := IniRec^.WebStyle;
 AdjustMargin := IniRec^.AdjustMargin;
 inherited;
 if IniRec^.MaxOnStart then WindowState := wsMaximized;
 VI := TVersionInfo.Create;
 try
  Application.Title := Application.Title + cc_HardSpace + VI.FileVersion;
 finally
  l3Free(VI);
 end;{try..finally}
 Caption := Application.Title;
 evOperationDispatcher.IncludeOperations([ev_ccNew, ev_ccOpen]);
 UpdateMRU;
 MakePanelsMenu;
end;

procedure TevMainMDIFormEx.BeforeRelease;
  //override;
  {-}
begin
 inherited;
 IniRec^.Preferences.View.ShowDocumentParts := ShowDocumentParts;
 IniRec^.Preferences.View.PrintPreview := PrintPreview;
 IniRec^.ShowSpecial := ShowSpecial;
 IniRec^.MaxOnStart := (WindowState = wsMaximized);
 IniRec^.PersistentBlocks := PersistentBlocks;
 IniRec^.WebStyle := WebStyle;
 SaveIniRecord;
 DoneUserConfig;
end;

function TevMainMDIFormEx.SaveToFile(aEditor : TEditorWindow): String;
  //virtual;
  {-}
begin
 Result := '';
 if (aEditor = nil) then aEditor := ActiveEditor;
 if (aEditor = nil) then Exit;
 Result := SaveManager.Save(aEditor.TextSource, nil);
 if (Result <> '') then
  UpdateName(aEditor, Result);
end;

procedure TevMainMDIFormEx.UpdateName(aEditor : TCustomForm; const aName: String);
  //virtual;
  {-}
var
 l_Index : Long;  
begin
 aEditor.Caption := aName;
 if (aName <> '') then begin
  with OpenDialog.HistoryList do begin
   l_Index := IndexOf(aName);
   if (l_Index = -1) then Insert(0, aName) else Move(l_Index, 0);
  end;{with HistoryList}
  UpdateMRU;
 end;//aName <> ''
end;

function TevMainMDIFormEx.Process(Sender : TObject;
                           Target : TObject;
                           Action : Long;
                           Down   : Bool): Bool;
  {-}
begin
 Result := true;
 Case TevOperation(Action) of
  ev_ccNew    : begin
   LoadManager.FileName := '';
   CreateMDIChild(Sender);
  end;//ev_ccNew 
  ev_ccOpen   : begin
   with LoadManager do
    if QueryName then
     CreateMDIChild(Sender, FileName);
  end;//ev_ccOpen
  ev_ccSave   : SaveToFile;
  ev_ccSaveAs : begin
   if (ActiveEditor = Nil) then Exit;
   with ActiveEditor do begin
    TextSource.FileName := '';
   end;//with ActiveEditor
   SaveToFile;
  end;//ev_ccSaveAs
  else Result := false;
 end;{Case TevOperation(Action)}
end;

function TevMainMDIFormEx.Process(Action : Long;
                                  Down   : Bool = false): Bool;
  {-}
begin
 Result := Process(nil, nil, Action, Down);
end;

procedure TevMainMDIFormEx.CloseMDIChild(Form: TForm);
  //virtual;
  {-}
begin
end;
  
end.
