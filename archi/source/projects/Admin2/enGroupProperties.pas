unit enGroupProperties;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, vcmInterfaces, vcmBase, vcmEntityForm, vcmEntities, StdCtrls,
  ExtCtrls, vcmComponent, vcmBaseEntities, OvcBase, vtLister,
  vtStringLister,

  a2Interfaces, afwControl, afwInputControl, l3InterfacedComponent,
  afwControlPrim, afwBaseControl;

type
  TenUserGroupPropetriesForm = class(TvcmEntityForm)
    Entities : TvcmEntities;
    edName: TLabeledEdit;
    lstFlags: TvtStringLister;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Label5: TLabel;
    cbImportPriority: TComboBox;
    cbExportPriority: TComboBox;
    procedure vcmEntityFormChangedDataSource(aSender: TObject; const aOld,
      aNew: IvcmFormDataSource; const aFromHistory : Boolean);
    procedure lstFlagsIsSelected(Sender: TObject; Index: Integer;
      var SelectedState: Integer);
    procedure lstFlagsSelect(Sender: TObject; Index: Integer;
      var SelectedState: Integer);
    procedure edNameChange(Sender: TObject);
    procedure cbImportPriorityChange(Sender: TObject);
    procedure cbExportPriorityChange(Sender: TObject);
    private
     { Private declarations }
     f_DS: Ia2dsUserGroupProfile;
    public
     { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TenUserGroupPropetriesForm.vcmEntityFormChangedDataSource(
  aSender: TObject; const aOld, aNew: IvcmFormDataSource; const aFromHistory : Boolean);
 function Priority2ItemIndex(aPriority: Ta2Priority): Integer;
 begin
  case aPriority of
   pvLowest : Result:= 4;
   pvLow    : Result:= 3;
   pvNormal : Result:= 2;
   pvHigh   : Result:= 1;
   pvHighest: Result:= 0;
  end;
 end;
begin
 if Supports(aNew, Ia2dsUserGroupProfile, f_DS) then
 begin
  edName.Text := f_DS.UserGroupProfile.Name;
  cbImportPriority.ItemIndex := Priority2ItemIndex(f_DS.UserGroupProfile.ImportPriority);
  cbExportPriority.ItemIndex := Priority2ItemIndex(f_DS.UserGroupProfile.ExportPriority);
  lstFlags.Refresh;
 end;
end;

procedure TenUserGroupPropetriesForm.lstFlagsIsSelected(Sender: TObject;
  Index: Integer; var SelectedState: Integer);
begin
 if Assigned(f_DS) then
 begin
  case Index of
   0: SelectedState := f_DS.UserGroupProfile.CanChangeDataGroup;
   1: SelectedState := f_DS.UserGroupProfile.CanDelete;
  end;
 end;
end;

procedure TenUserGroupPropetriesForm.lstFlagsSelect(Sender: TObject;
  Index: Integer; var SelectedState: Integer);
begin
 if Assigned(f_DS) then
 begin
  case Index of
   0: f_DS.UserGroupProfile.CanChangeDataGroup := SelectedState;
   1: f_DS.UserGroupProfile.CanDelete := SelectedState;
  end;
 end;
end;

procedure TenUserGroupPropetriesForm.edNameChange(Sender: TObject);
begin
 if Assigned(f_DS) then
  f_DS.UserGroupProfile.Name := edName.Text;
end;

function ItemIndex2Priority(aItemIndex: Integer): Ta2Priority;
begin
 case aItemIndex of
  0: Result := pvHighest;
  1: Result := pvHigh;
  3: Result := pvLow;
  4: Result := pvLowest;
 else
  Result := pvNormal
 end;
end;

procedure TenUserGroupPropetriesForm.cbImportPriorityChange(
  Sender: TObject);
begin
 f_DS.UserGroupProfile.ImportPriority := ItemIndex2Priority(cbImportPriority.ItemIndex);
end;

procedure TenUserGroupPropetriesForm.cbExportPriorityChange(
  Sender: TObject);
begin
 f_DS.UserGroupProfile.ExportPriority := ItemIndex2Priority(cbExportPriority.ItemIndex);
end;

end.
