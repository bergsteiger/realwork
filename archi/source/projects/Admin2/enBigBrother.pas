unit enBigBrother;

{ $Id: enBigBrother.pas,v 1.11 2015/07/09 10:35:01 lukyanets Exp $}

// $Log: enBigBrother.pas,v $
// Revision 1.11  2015/07/09 10:35:01  lukyanets
// Готовимся вычитывать данные
//
// Revision 1.10  2015/04/30 11:14:36  lukyanets
// Заготовки Большого Брата
//
// Revision 1.9  2010/10/26 09:25:06  fireton
// - используем операцию для записи результатов Большого Брата
//
// Revision 1.8  2008/09/29 08:47:27  fireton
// - bugfix: название пункта меню
//
// Revision 1.7  2008/06/30 14:35:24  fireton
// - удалил masked edit из строки ввода DocID в ББ
//
// Revision 1.6  2008/04/25 07:52:41  fireton
// - запись результатов ББ в файл
//
// Revision 1.5  2007/09/26 07:59:12  fireton
// - При вызове Большого Брата теперь не производится автоматический запрос с параметрами по умолчанию (иногда это приводило к длительному ожиданию)
// - Убран пункт меню "Переключение базы"
//
// Revision 1.4  2007/05/24 14:42:10  fireton
// - Большой Брат теперь умеет выдавать статистику по всем пользователям
// - Большой Брат умеет сводить статистику по пользователям и документам
//
// Revision 1.3  2006/12/06 13:45:15  fireton
// - удаление l3Control из uses
// - поддержка "отстрела" с сервера
// - импорт и экспорт пользователей теперь совместимы
//
// Revision 1.2  2006/02/14 11:20:44  fireton
// - реализация Большого Брата
//
// Revision 1.1  2006/02/09 13:39:23  fireton
// - первый коммит
//

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, vcmInterfaces, vcmBase, vcmEntityForm, vcmEntities,
  vcmComponent, vcmBaseEntities, StdCtrls, Mask, vtCombo, vtDateEdit,
  ExtCtrls, OvcBase, vtLister, vtOutliner,

  a2Interfaces, afwControl, afwInputControl, Buttons, afwControlPrim,
  afwBaseControl, l3InterfacedComponent;

type
  TenBigBrotherForm = class(TvcmEntityForm)
    Entities : TvcmEntities;
    BigBrotherTree: TvtOutliner;
    Panel1: TPanel;
    lblTarget: TLabel;
    deStart: TvtDateEdit;
    deFinish: TvtDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnRefresh: TButton;
    SaveDialog: TSaveDialog;
    edDocNum: TEdit;
    procedure vcmEntityFormChangedDataSource(aSender: TObject; const aOld,
      aNew: IvcmFormDataSource; const aFromHistory: Boolean);
    procedure vcmEntityFormCreate(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure edDocNumKeyPress(Sender: TObject; var Key: Char);
    procedure enFileopSaveExecute(var aParams: IvcmExecuteParams);
    procedure enFileopSaveTest(const aParams: IvcmTestParams);
    private
     { Private declarations }
     f_DS: Ia2dsBigBrother;
    f_SaveEnabled: Boolean;
    procedure BBRefresh;
    public
      { Public declarations }
  end;

implementation
uses
 l3Date,
 vcmExternalInterfaces;

{$R *.DFM}

procedure TenBigBrotherForm.BBRefresh;
var
 l_DocNum: Integer;
begin
 l_DocNum := StrToIntDef(Trim(edDocNum.Text), 0);
 f_DS.Refresh(deStart.StDate, deFinish.StDate, l_DocNum);
end;

procedure TenBigBrotherForm.vcmEntityFormChangedDataSource(aSender: TObject; const aOld,
  aNew: IvcmFormDataSource; const aFromHistory: Boolean);
var
 l_UProfile: Ia2UserProfile;
 l_GProfile: Ia2UsergroupProfile;
begin
 if Supports(aNew, Ia2dsBigBrother, f_DS) then
 begin
  f_SaveEnabled := False;
  BigBrotherTree.TreeStruct := f_DS.Tree;
  if not Assigned(f_DS.Profile) then
   lblTarget.Caption := 'Все пользователи'
  else
  begin
   if Supports(f_DS.Profile, Ia2UserProfile, l_UProfile) then
    lblTarget.Caption := l_UProfile.Name
   else
    if Supports(f_DS.Profile, Ia2UserGroupProfile, l_GProfile) then
     lblTarget.Caption := 'Группа: '+l_GProfile.Name
    else
     lblTarget.Caption := 'Все пользователи';
  end;
 end
 else
  lblTarget.Caption := '';
end;

procedure TenBigBrotherForm.vcmEntityFormCreate(Sender: TObject);
begin
 deStart.StDate := IncDate(CurrentDate, -7, 0, 0);
 deFinish.StDate := CurrentDate;
end;

procedure TenBigBrotherForm.btnRefreshClick(Sender: TObject);
var
 l_DocNum: Integer;
begin
 BBRefresh;
 BigBrotherTree.TreeStruct := f_DS.Tree;
 btnRefresh.Caption := 'Обновить';
 f_SaveEnabled := True;
end;

procedure TenBigBrotherForm.edDocNumKeyPress(Sender: TObject;
  var Key: Char);
begin
 if not (Key in ['0'..'9']) then
  Key := #0;
end;

procedure TenBigBrotherForm.enFileopSaveExecute(var aParams: IvcmExecuteParams);
begin
 if SaveDialog.Execute then
  f_DS.SaveResult(SaveDialog.FileName);
end;

procedure TenBigBrotherForm.enFileopSaveTest(const aParams: IvcmTestParams);
begin
 aParams.Op.Flag[vcm_ofEnabled] := f_SaveEnabled;
end;

end.
