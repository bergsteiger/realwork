unit a2UserGroupTree;

{ $Id: a2UserGroupTree.pas,v 1.40 2011/04/26 14:30:10 fireton Exp $}

// $Log: a2UserGroupTree.pas,v $
// Revision 1.40  2011/04/26 14:30:10  fireton
// - сохранение данных нового пользователя при переходе по дереву
//
// Revision 1.39  2010/10/26 08:17:38  fireton
// - переносим часть операций на главную форму
//
// Revision 1.38  2010/10/19 08:52:59  fireton
// - не теряем стек ошибки
//
// Revision 1.37  2010/02/17 13:09:35  fireton
// - фильтрация импорта/экспорта пользователей по региону
//
// Revision 1.36  2009/06/01 12:36:39  fireton
// - редактирование диапазонов DocID для арбитражной практики
//
// Revision 1.35  2009/04/02 13:11:30  fireton
// - [$137470683]. Правка огрехов в отрисовке дерева пользователей.
//
// Revision 1.34  2009/01/29 15:04:50  fireton
// - скрыл операцию определения диапазонов docid для обработки реестров
//
// Revision 1.33  2008/11/10 14:27:31  fireton
// - новая версия VCM
//
// Revision 1.32  2008/10/07 12:40:55  narry
// - обновление
//
// Revision 1.31  2008/09/29 08:30:20  narry
// - обновление
//
// Revision 1.30  2008/06/30 14:35:24  fireton
// - удалил masked edit из строки ввода DocID в ББ
//
// Revision 1.29  2008/04/04 15:18:19  fireton
// - внешние номера документов из диапазона
//
// Revision 1.28  2007/05/24 14:42:10  fireton
// - Большой Брат теперь умеет выдавать статистику по всем пользователям
// - Большой Брат умеет сводить статистику по пользователям и документам
//
// Revision 1.27  2007/05/14 12:29:11  fireton
// - изменение пароля супервизора - отдельным пунктом в меню
// - bug fix: при схлопывании/раскрытии измененной группы в дереве, предлагалось записать изменения
//
// Revision 1.26  2007/04/27 08:46:18  fireton
// - Мелкая доработка. Порядок пунктов в меню и пункт "Выход".
//
// Revision 1.25  2007/03/26 13:16:30  fireton
// - мелкий багфикс там и сям
//
// Revision 1.24  2007/03/13 09:09:07  fireton
// - не-админ теперь не сможет пользоваться программой
// - мелкие правки
// - чистка кода
//
// Revision 1.23  2007/03/07 13:02:16  narry
// - не компилировалось
//
// Revision 1.22  2007/02/19 15:19:40  fireton
// - "admin" flag теперь экспортируется и импортируется
// - немного улучшена обработка ошибок
// - окошко "О программе" с номером версии
//
// Revision 1.21  2007/01/20 16:22:02  lulin
// - bug fix: админ не собирался в результате изменений в библиотеках.
//
// Revision 1.20  2006/12/06 13:45:15  fireton
// - удаление l3Control из uses
// - поддержка "отстрела" с сервера
// - импорт и экспорт пользователей теперь совместимы
//
// Revision 1.19  2006/12/01 15:30:02  fireton
// - отображение пути к текущей базе в строке статуса
// - инструмент переключения баз задизаблен, если подключились не через серверный конфиг
//
// Revision 1.18  2006/11/27 16:24:39  fireton
// - bugfix
//
// Revision 1.17  2006/11/22 16:22:20  fireton
// - переход на новую инкарнацию VCM
//
// Revision 1.16  2006/06/08 15:55:50  fireton
// - подготовка к переходу на большой User ID
//
// Revision 1.15.2.1  2006/06/08 09:26:49  fireton
// - перевод User ID на Longword
//
// Revision 1.15  2006/02/15 14:15:37  fireton
// - переключение баз и импорт/экспорт пользователей
//
// Revision 1.14  2006/02/14 11:20:44  fireton
// - реализация Большого Брата
//
// Revision 1.13  2006/02/07 15:33:34  fireton
// - поиск пользователей (продолженный)
//
// Revision 1.12  2006/02/07 15:04:25  fireton
// - поиск пользователей
//
// Revision 1.11  2006/02/03 07:17:44  fireton
// - начал вкручивать поиск пользователей
//
// Revision 1.10  2006/02/01 16:08:23  fireton
// - запись в файл и печать
//
// Revision 1.9  2005/11/28 14:12:49  fireton
// - промежуточный коммит
//
// Revision 1.8  2005/09/14 12:50:23  fireton
// - add: операция удаления элементов (групп и пользователей)
//
// Revision 1.7  2005/09/14 10:52:26  fireton
// - add: операция добавление новых элементов (групп и пользователей)
//
// Revision 1.6  2005/09/12 14:10:46  fireton
// - add: адекватные иконки для элементов дерева групп и пользователей
//
// Revision 1.5  2005/08/26 13:16:55  fireton
// - промежуточный коммит (профили группы + bug fix)
//
// Revision 1.4  2005/08/23 13:58:29  fireton
// - промежуточный коммит (реализация сохранения + bug fix)
//
// Revision 1.3  2005/08/20 11:01:53  fireton
// - промежуточный коммит (реализация визуальной части и подгонка под сборки)
//
// Revision 1.2  2005/08/17 14:10:58  fireton
// - промежуточный коммит (подгонка под систему сборок)
//
// Revision 1.1  2005/07/28 13:54:24  fireton
// - первый коммит
//

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, OvcBase,

  ImgList,

  l3Interfaces,
  l3InternalInterfaces,
  l3TreeInterfaces,

  afwInterfaces,

  vcmExternalInterfaces,
  vcmInterfaces,
  vcmBase,
  vcmEntityForm,
  vcmEntities,
  vcmComponent,
  vcmBaseEntities,

  vtLister,
  vtOutliner,

  a2Base,
  a2Interfaces,
  a2UserFindWindow, afwControl, afwInputControl, afwControlPrim,
  afwBaseControl, l3InterfacedComponent;

type
  TenUserTree = class(TvcmEntityForm)
      Entities : TvcmEntities;
    GroupUserTree: TvtOutliner;
    SaveDialog: TSaveDialog;
    PrintDialog: TPrintDialog;
    procedure vcmEntityFormChangedDataSource(aSender: TObject; const aOld,
      aNew: IvcmFormDataSource; const aFromHistory : Boolean);
    procedure GroupUserTreeGetItemFont(Sender: TObject; Index: Integer;
      const aFont: Il3Font);
    procedure GroupUserTreeCurrentChanged(Sender: TObject; aNewCurrent,
      aOldCurrent: Integer);
    function GroupUserTreeGetItemImage(Sender: TObject; Index: Integer;
      var aImages: TCustomImageList): Integer;
    procedure enEditopCreateExecute(var aParams: IvcmExecuteParams);
    procedure enEditopDeleteExecute(var aParams: IvcmExecuteParams);
    procedure enEditopDeleteTest(const aParams: IvcmTestParams);
    procedure enToolsopSaveExecute(var aParams: IvcmExecuteParams);
    procedure enToolsopPrintExecute(var aParams: IvcmExecuteParams);
    procedure enToolsopSearchExecute(var aParams: IvcmExecuteParams);
    procedure vcmEntityFormCreate(Sender: TObject);
    procedure enToolsopSearchMoreExecute(var aParams: IvcmExecuteParams);
    procedure enToolsopSearchMoreTest(const aParams: IvcmTestParams);
    procedure enToolsopBigBrotherExecute(var aParams: IvcmExecuteParams);
    procedure enToolsopBigBrotherTest(const aParams: IvcmTestParams);
    procedure GroupUserTreeValidateCurrent(Sender: TObject;
      var NewCurrent: Integer);
    procedure vcmEntityFormCloseQuery(Sender: TObject;
      var CanClose: Boolean);
    procedure vcmEntityFormGetStatus(aSender: TObject;  out theStatus: TafwStatusInfo);
    procedure enHelpopAboutExecute(var aParams: IvcmExecuteParams);
    private
      { Private declarations }
      f_BO           : Ia2UserGroupTree;
      f_DontRefresh  : Boolean;
      f_LastFound    : Il3SimpleNode;
      f_LastSearchBy : Ta2UserFindMode;
      f_FindForm     : TfrmFind;
      f_InProcess    : Boolean;
      procedure TestSearch;
      function CheckChanges(aToCheck: Integer = -1): Integer;
    protected
     procedure Cleanup; override;
    public
      { Public declarations }
  end;

implementation
uses
 StdRes,

 l3Base,
 l3InterfacesMisc,

 a2ChangePasswordDlg,
 a2AboutBox,
 a2DocIDRangeEditor,
 a2InExUserDlg,

 ddAboutDlg,

 DT_Const;

{$R *.DFM}

const
 sErrorPrint = 'При печати произошла ошибка!';

procedure TenUserTree.Cleanup;
begin
 f_BO := nil;
 f_LastFound := nil;
 l3Free(f_FindForm);
 inherited;
end;

procedure TenUserTree.vcmEntityFormChangedDataSource(aSender: TObject;
  const aOld, aNew: IvcmFormDataSource; const aFromHistory : Boolean);
var
 l_TempRoot: Il3SimpleNode;
begin
 f_DontRefresh := True;
 try
  if aOld = aNew then
   Exit;
  if Supports(aNew, Ia2UserGroupTree, f_BO) then
  begin
   if f_BO.NeedReposition then
    l_TempRoot := GroupUserTree.GetCurrentNode.Parent;
   GroupUserTree.TreeStruct := f_BO.Tree;
   if f_BO.NeedReposition then
   begin
    f_DontRefresh := False;
    GroupUserTree.GotoOnNode(f_BO.Reposition(l_TempRoot));
   end; 
  end;
 finally
  f_DontRefresh := False;
 end; {try..finally}
end;

procedure TenUserTree.GroupUserTreeGetItemFont(Sender: TObject;
  Index: Integer; const aFont: Il3Font);
begin
 aFont.Bold := f_BO.NeedSpecialDraw(GroupUserTree.GetNode(Index));
end;

procedure TenUserTree.GroupUserTreeCurrentChanged(Sender: TObject;
  aNewCurrent, aOldCurrent: Integer);
begin
 if not f_DontRefresh then
 begin
  Screen.Cursor := crHourGlass;
  try
   f_BO.ChangeCurrent(GroupUserTree.GetCurrentNode);
  finally
   Screen.Cursor := crDefault;
  end;
 end;
end;

function TenUserTree.GroupUserTreeGetItemImage(Sender: TObject;
  Index: Integer; var aImages: TCustomImageList): Integer;
begin
 aImages := StdRes.dmStdRes.ilOffice;
 Result := f_BO.GetNodeImage(GroupUserTree.GetNode(Index));
end;

procedure TenUserTree.enEditopCreateExecute(var aParams: IvcmExecuteParams);
begin
 f_BO.CreateNewItem(GroupUserTree.GetCurrentNode);
end;

procedure TenUserTree.enEditopDeleteExecute(var aParams: IvcmExecuteParams);
begin
 f_BO.DeleteItem(GroupUserTree.GetCurrentNode);
end;

procedure TenUserTree.enEditopDeleteTest(const aParams: IvcmTestParams);
begin
 aParams.Op.Flag[vcm_ofEnabled] := f_BO.IsCommonProfileNode(GroupUserTree.GetCurrentNode)
end;

procedure TenUserTree.enToolsopSaveExecute(var aParams: IvcmExecuteParams);
var
 l_Format: Ta2SaveFormat;
begin
 if SaveDialog.Execute then
 try
  Screen.Cursor := crHourGlass;
  case SaveDialog.FilterIndex of
   1: l_Format := sfTextWin;
   2: l_Format := sfTextDos;
   3: l_Format := sfRTF;
   4: l_Format := sfEverest;
  end;
  f_BO.SaveItem(GroupUserTree.GetCurrentNode, SaveDialog.FileName, l_Format);
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TenUserTree.enToolsopPrintExecute(var aParams: IvcmExecuteParams);
var
 I: Integer;
begin
 PrintDialog.Copies := 1;
 if PrintDialog.Execute then
 try
  Screen.Cursor := crHourGlass;
  try
   for I := 1 to PrintDialog.Copies do
    f_BO.SaveItem(GroupUserTree.GetCurrentNode, '', sfPrinter);
   MessageDlg(l3CStr('Данные отправлены на печать'), mtInformation);
  except
   l3System.Stack2Log(sErrorPrint);
   MessageDlg(l3CStr(sErrorPrint), mtError);
  end;
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TenUserTree.enToolsopSearchExecute(var aParams: IvcmExecuteParams);
var
 l_SearchBy: Integer;
begin
 with f_FindForm do
 begin
  l_SearchBy := ShowModal;
  if l_SearchBy = mrCancel then
   Exit;
  case l_SearchBy of
   -1: f_LastSearchBy := ufmName;
   -2: f_LastSearchBy := ufmID;
   -3: f_LastSearchBy := ufmLogin;
  end;
 end;
 f_LastFound := f_BO.FindUser(f_FindForm.Context, f_LastSearchBy);
 TestSearch;
end;

procedure TenUserTree.vcmEntityFormCreate(Sender: TObject);
begin
 f_LastFound := nil;
 f_FindForm := TfrmFind.Create(Self);
 f_InProcess := False;
end;

procedure TenUserTree.enToolsopSearchMoreExecute(var aParams: IvcmExecuteParams);
begin
 f_LastFound := f_BO.FindUser(f_FindForm.Context, f_LastSearchBy, f_LastFound);
 TestSearch;
end;

procedure TenUserTree.enToolsopSearchMoreTest(const aParams: IvcmTestParams);
begin
 aParams.Op.Flag[vcm_ofEnabled] := Assigned(f_LastFound);
end;

procedure TenUserTree.TestSearch;
begin
 if Assigned(f_LastFound) then
  GroupUserTree.GotoOnNode(f_LastFound)
 else
  Say(inf_msgFinishSearch);
end;

procedure TenUserTree.enToolsopBigBrotherExecute(var aParams: IvcmExecuteParams);
begin
 f_BO.TriggerBigBrotherOnCurrent(GroupUserTree.GetCurrentNode);
end;

procedure TenUserTree.enToolsopBigBrotherTest(
  const aParams: IvcmTestParams);
var
 l_Node: Il3SimpleNode;
begin
 aParams.Op.Flag[vcm_ofChecked] := f_BO.IsBigBrother;
 l_Node := GroupUserTree.GetCurrentNode;
 aParams.Op.Flag[vcm_ofEnabled] := f_BO.IsCommonProfileNode(l_Node) or f_BO.IsAllUsersNode(l_Node);
end;

function TenUserTree.CheckChanges(aToCheck: Integer = -1): Integer;
var
 l_Profile: Ia2Profile;
 l_Persistent: Ia2Persistent;
begin
 Result := mrNone;
 l_Profile := f_BO.CurrentProfile;  
 if Supports(l_Profile, Ia2Persistent, l_Persistent) and l_Persistent.Modified then
 begin
  if gSilentClose then
   Result := mrYes
  else
   Result := MessageDlg(l3CStr('Сохранить изменения?'), mtWarning, [mbYes,mbNo,mbCancel]);
  if Result = mrYes then
   l_Persistent.Save;
  if Result = mrNo then
   l_Persistent.Revert;
 end;
end;

procedure TenUserTree.GroupUserTreeValidateCurrent(Sender: TObject;
  var NewCurrent: Integer);
var
 l_CurProfile, l_NewProfile: Ia2Profile;
 l_Res: Integer;
begin
 try
  l_CurProfile := f_BO.GetProfile(GroupUserTree.GetNode(GroupUserTree.Current));
  l_NewProfile := f_BO.GetProfile(GroupUserTree.GetNode(NewCurrent));
  if not l3IEQ(l_CurProfile, l_NewProfile) then
  begin
   l_Res := CheckChanges;
   case l_Res of
    mrYes   :
     begin
      f_BO.RefreshTree(l_NewProfile);
      NewCurrent := GroupUserTree.Current;
     end;
    mrNo    : ;
    mrCancel: NewCurrent := GroupUserTree.Current;
   end;
  end;
 finally
  l_CurProfile := nil;
  l_NewProfile := nil;
 end;
end;


procedure TenUserTree.vcmEntityFormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 CanClose := CheckChanges <> mrCancel;
end;

procedure TenUserTree.vcmEntityFormGetStatus(aSender: TObject; out theStatus: TafwStatusInfo);
var
 l_FP: string;
begin
 SetLength(theStatus.rStrings, 1);
 l_FP := f_BO.GetFamilyPath;
 theStatus.rStrings[0] := l3CStr(Format('Текущая база: %s', [l_FP]));
 //theStatus.rNeedProgress := f_InProcess;
end;

procedure TenUserTree.enHelpopAboutExecute(var aParams: IvcmExecuteParams);
begin
 ddAboutDialog('');
end;


end.
