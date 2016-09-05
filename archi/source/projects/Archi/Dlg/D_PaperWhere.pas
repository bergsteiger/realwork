unit D_PaperWhere;

{ $Id: D_PaperWhere.pas,v 1.15 2016/08/10 12:48:40 lukyanets Exp $ }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OvcBase,  evEditorWindow, evEditor, evMemo, StdCtrls, Buttons,
  ExtCtrls,
  DT_Types, DT_Doc,
  BottomBtnDlg, evMultiSelectEditorWindow, evCustomEditor,
  evEditorWithOperations, afwControl, afwControlPrim, afwBaseControl,
  nevControl, evCustomMemo, evCustomEditorWindowPrim, evCustomEditorWindow,
  evCustomEditorWindowModelPart, evCustomEditorModelPart;

type
  TPaperWhereDlg = class(TBottomBtnDlg)
    rbDocPlaceUser: TRadioButton;
    cbDocPlaceUser: TComboBox;
    rbDocPlaceArchieve: TRadioButton;
    memDocPlaceAddr: TevMemo;
    procedure cbDocPlaceUserChange(Sender: TObject);
    procedure rbDocPlaceArchieveClick(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
  private
    { Private declarations }
  public

   function Execute(var aPaperUser : TDictID; var aPaperPlace : String) : Boolean; reintroduce;

  end;

implementation

uses
  l3String,

  daDataProvider
  ;

{$R *.DFM}

 function TPaperWhereDlg.Execute(var aPaperUser : TDictID; var aPaperPlace : String) : Boolean;
  begin
   Try
    Screen.Cursor:=crHourGlass;
    GlobalDataProvider.UserManager.GetFiltredUserList(cbDocPlaceUser.Items, False);
    If aPaperUser = ArchivePlace
     then rbDocPlaceArchieve.Checked := True
     else
      begin
       rbDocPlaceUser.Checked := True;
       cbDocPlaceUser.ItemIndex := cbDocPlaceUser.Items.IndexOfObject(Pointer(aPaperUser));
      end;
    memDocPlaceAddr.Buffer := l3PCharLen(aPaperPlace);
   finally
    Screen.Cursor := crDefault;
   end;

   Result:=(ShowModal = mrOk);

   If Result
    then
     begin
      If rbDocPlaceUser.Checked
       then
        Begin
         If cbDocPlaceUser.ItemIndex > -1
          then aPaperUser := Longint(cbDocPlaceUser.Items.Objects[cbDocPlaceUser.ItemIndex])
          else aPaperUser := 0;
        end
       else
        aPaperUser := ArchivePlace;

      aPaperPlace := StrPas(memDocPlaceAddr.Buffer.S);
     end;
  end;

 procedure TPaperWhereDlg.Panel1Resize(Sender: TObject);
  begin
   cbDocPlaceUser.Width   := Panel1.Width - 42;
   memDocPlaceAddr.Width  := Panel1.Width - 42;
   memDocPlaceAddr.Height := Panel1.Height - 100;
  end;

 procedure TPaperWhereDlg.cbDocPlaceUserChange(Sender: TObject);
  begin
   rbDocPlaceUser.Checked := True;
  end;

 procedure TPaperWhereDlg.rbDocPlaceArchieveClick(Sender: TObject);
  begin
   If rbDocPlaceArchieve.Checked then cbDocPlaceUser.ItemIndex := -1;
  end;

end.
