//..........................................................................................................................................................................................................................................................
unit ddAIClientDlg;

// $Id: ddAIClientDlg.pas,v 1.35 2015/01/13 09:25:29 lukyanets Exp $

// $Log: ddAIClientDlg.pas,v $
// Revision 1.35  2015/01/13 09:25:29  lukyanets
// Дополняем SourceFiles вложенными файлами
//
// Revision 1.34  2014/12/29 10:47:36  lukyanets
// Запрещаем дублирование имен
//
// Revision 1.33  2013/04/11 16:46:26  lulin
// - отлаживаем под XE3.
//
// Revision 1.32  2010/07/16 13:51:54  voba
// no message
//
// Revision 1.31  2010/07/09 11:38:03  voba
// k: 212796071
//
// Revision 1.30  2007/01/10 11:08:51  voba
// - сохранение последнего выставленного формата файлов
//
// Revision 1.29  2006/03/07 12:27:34  narry
// - изменение: новая технология передачи заданий
//
// Revision 1.28  2005/03/29 14:00:26  voba
// - bug fix
//
// Revision 1.27  2005/03/25 12:17:26  voba
// - расширение списка параметров задания на импорт
//
// Revision 1.26  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.25  2004/12/23 11:42:08  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.24  2004/01/09 11:55:00  narry
// - bug fix: QC#00005496 - больше нельзя отправить на импорт пустое  задание
//
// Revision 1.23  2003/12/17 12:09:07  narry
// - update
//
// Revision 1.22  2003/12/17 11:53:13  narry
// - add: расширение списка параметров сообщения на импорт - отслеживание Группы Доступа "Передано в регионы"
//
// Revision 1.21  2003/07/21 16:37:23  narry
// - bug fix: неправильно формировалось имя файла для повторяющихся имен из разных папок
//
// Revision 1.20  2003/05/20 09:59:08  narry
// - bug fix: копирование одноименных файлов из разных папок приводило к потере информации
//
// Revision 1.19  2003/04/28 10:11:29  narry
// - new: удаление из списка файлов не nsrc и не Эверест
//
// Revision 1.18  2003/04/19 12:30:36  law
// - new file: ddDefine.inc.
//
// Revision 1.17  2002/07/03 09:00:57  narry
// - update, cleanup и new behavior
//
// Revision 1.16  2002/06/21 15:26:13  voba
// - bug fix
//
// Revision 1.15  2002/06/21 15:23:28  voba
// - bug fix: конфликт в комментариях
//
// Revision 1.14  2002/06/20 12:59:09  narry
// - new behavior: предупреждение о невозможности скопировать файл
//
// Revision 1.13  2002/06/17 09:33:45  narry
// - new behavior: изменение формата вывода имен скопированных файлов
//
// Revision 1.12  2002/06/17 09:23:50  narry
// - new behavior: вывод в лог имен скопированных файлов
//
// Revision 1.11  2002/06/17 09:14:38  narry
// - new behavior: вывод в лог информации о количестве файлов и исключительной ситуации
//
// Revision 1.10  2002/04/08 14:09:50  narry
// - update: новая процедура копирования файлов NSRC
//
// Revision 1.9  2002/02/19 13:53:29  narry
// - update
//
// Revision 1.8  2002/01/21 11:59:01  voba
// no message
//
// Revision 1.7  2001/09/04 13:58:59  voba
// - rename unit: MyUtil -> l3FileUtils.
//
// Revision 1.6  2001/06/08 13:40:35  narry
// - bug fix: генерация ошибки при отсутствии файла картинки
//
// Revision 1.5  2001/06/07 15:12:48  narry
// -new behavior: парсинг передаваемых на импорт файлов на предмет
//                         наличия в них OBJTOPIC и копирования дополнительных
//                         файлов на сервер
//
// Revision 1.4  2000/12/15 15:29:53  law
// - вставлены директивы Log и Id.
//

{$I ddDefine.inc }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, Mask, ToolEdit, vtLister, OvcBase, afwControlPrim,
  afwBaseControl, afwControl, afwInputControl, vtStringLister;

type
  TAIClientDialog = class(TForm)
    GroupBox1: TGroupBox;
    ListBox1: TvtStringLister;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    OpenDialog1: TOpenDialog;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    f_BaseDir: AnsiString;
    f_FileList: TStrings;
    f_FileNameList: TStringList;
    f_IsAnnotation : boolean;

   procedure Check;
//   function MakeDestFileName(const aFileName: AnsiString): AnsiString;
   procedure SetAnnotation(const Value: Boolean);
  public
    { Public declarations }
    function Execute: Boolean;

    property BaseDir: AnsiString read f_BaseDir write f_BaseDir;
    property FileList: TStrings read f_FileList;
    property IsAnnotation : Boolean
     read f_IsAnnotation
     write SetAnnotation;
  end;

var
  AIClientDialog: TAIClientDialog;

implementation

{$R *.DFM}

Uses
 l3IniFile, l3FileUtils, l3Stream, l3Types, l3Base{,
 ddNSRCUtils};

procedure TAIClientDialog.Button1Click(Sender: TObject);
var
 l_WrongExtension, l_Ext, l_Filter: AnsiString;
 i: Integer;
 l_IDX: Integer;
 l_DuplicateFiles: AnsiString;
 l_Dir: AnsiString;
 l_ErrorStr: AnsiString;
begin
  UserConfig.SetSection('AutoImport');
  if UserConfig.ReadParamString('InitialDir', l_Dir) then
    OpenDialog1.InitialDir:= l_Dir;

  if IsAnnotation then
   OpenDialog1.FilterIndex := UserConfig.ReadParamIntDef('FilterIndexAnno', 1)
  else
   OpenDialog1.FilterIndex := UserConfig.ReadParamIntDef('FilterIndexDoc', 1);

  if OpenDialog1.Execute then
  begin
   ListBox1.Items.BeginUpdate;
   try
    l_DuplicateFiles := '';
    for l_IDX := 0 to OpenDialog1.Files.Count - 1 do
     if f_FileNameList.IndexOf(ExtractFileName(OpenDialog1.Files[l_IDX])) = -1 then
     begin
      f_FileNameList.Add(ExtractFileName(OpenDialog1.Files[l_IDX]));
      ListBox1.Items.Add(OpenDialog1.Files[l_IDX]);
     end
     else
     begin
      if l_DuplicateFiles <> '' then
       l_DuplicateFiles := l_DuplicateFiles + #10;
      l_DuplicateFiles := l_DuplicateFiles + ' ' + OpenDialog1.Files[l_IDX];
     end;

    l_ErrorStr := '';
    if l_DuplicateFiles <> '' then
     l_ErrorStr := Format('Дублируются имена: '#10'%s', [l_DuplicateFiles]);
    l_Filter:= UpperCase(OpenDialog1.Filter);
    i:= 0;
    l_WrongExtension:= '';
    while i < ListBox1.Items.Count do
    begin
     l_Ext:= UpperCase('*'+ExtractFileExt(ListBox1.Items.Strings[i]));
     if Pos(l_Ext, l_Filter) = 0 then
     begin
      if l_WrongExtension <> '' then
       l_WrongExtension := l_WrongExtension + #10;
      l_WrongExtension := l_WrongExtension + ' ' + ListBox1.Items.Strings[i];
      ListBox1.Items.Delete(i)
     end
     else
      Inc(i)
    end;
    if l_WrongExtension <> '' then
    begin
     if l_ErrorStr <> '' then
      l_ErrorStr := l_ErrorStr + #10#10;
     l_ErrorStr := Format('%sНе соответствие фильтру "%s": '#10'%s', [l_ErrorStr, OpenDialog1.Filter, l_WrongExtension]);
    end;
    if l_ErrorStr <> '' then
    begin
     l_ErrorStr := Format('Следующие файлы не добавлены: '#10'%s', [l_ErrorStr]);
    end;

   finally
    ListBox1.Items.EndUpdate;
   end;
   if l_ErrorStr <> '' then
    ShowMessage(l_ErrorStr);
   if ListBox1.Items.Count > 0 then
   begin
    UserConfig.WriteParamStr('InitialDir', ExtractFileDir(ListBox1.Items[Pred(ListBox1.Items.Count)]));
    if IsAnnotation then
     UserConfig.WriteParamInt('FilterIndexAnno', OpenDialog1.FilterIndex)
    else
     UserConfig.WriteParamInt('FilterIndexDoc', OpenDialog1.FilterIndex);
   end;
  end;
  Check;
end;

procedure TAIClientDialog.Button2Click(Sender: TObject);
begin
  f_FileNameList.Delete(ListBox1.Current);
  ListBox1.Items.Delete(ListBox1.Current);
  Check;
end;

function TAIClientDialog.Execute: Boolean;
var
 i, j: Integer;
 FileName, l_S: AnsiString;
begin
 Result:= ShowModal = mrOk;
 if Result then
 begin
   { Копировать выбранные файлы в указанный каталог }
   FileList.Clear;
   l3System.Msg2Log(Format('Для импорта выделено %d файлов', [ListBox1.Items.Count]));
   l_S:= '';
   for i:= 0 to Pred(ListBox1.Items.Count) do
   begin
    FileName:= ListBox1.Items.Strings[i];
    try
     FileList.Add(FileName);
//     if not CheckNSRCFile(FileName, FileList) then
//      MessageDlg(Format('Не удалось скопировать файл %s', [FileName]),
//                 mtWarning, [mbOk], 0);
    except
     on E: Exception do
     begin
      l3System.Msg2Log(Format('Ошибка копирования файла %s', [FileName]));
      l3System.Exception2Log(E);
     end; // on E
    end; // try..except
   end; // for i
   l3System.Msg2Log(Format('Скопировано %d файлов: %s', [FileList.Count, l_S]));
   Result:= FileList.Count > 0;
 end; // Result
end;

procedure TAIClientDialog.Check;
begin
  BitBtn1.Enabled:= ListBox1.Items.Count > 0;
  BitBtn4.Enabled:= ListBox1.Items.Count > 0;
end;

procedure TAIClientDialog.FormCreate(Sender: TObject);
begin
  { Установить  начальный каталог для dirImportDir }
  Check;
  f_BaseDir:= '';
  f_FileList := TStringList.Create;
  f_FileNameList := TStringList.Create;
  f_FileNameList.CaseSensitive := False;
  f_FileNameList.Sorted := True;
end;
(*
function TAIClientDialog.MakeDestFileName(const aFileName: AnsiString): AnsiString;
var
 l_Ext: AnsiString;
begin
 Result:= ConcatDirName(BaseDir, ExtractFileName(aFileName));
 if FileExists(Result) then
 begin
  l_Ext:= ExtractFileExt(aFileName);
  Result:= GetUniqFileName(BaseDir, ChangeFileExt(ExtractFileName(aFileName), ''), l_Ext);
 end;
end;
*)
procedure TAIClientDialog.SetAnnotation(const Value: Boolean);
begin
 f_IsAnnotation := Value;
 if Value then
 begin
  Caption := 'Импорт аннотаций';
  OpenDialog1.Filter := 'Файлы аннотаций (*.txt, *.doc, *.rtf)|*.TXT;*.DOC;*.RTF';
 end
 else
 begin
  Caption := 'Импорт документов';
  OpenDialog1.Filter := 'Файлы документов в формате NSRC|*.NSR|Файлы документов в формате Эверест|*.EVD';
 end;
end;

procedure TAIClientDialog.FormDestroy(Sender: TObject);
begin
 inherited;
 FreeAndNil(f_FileList);
 FreeAndNil(f_FileNameList);
end;

end.
