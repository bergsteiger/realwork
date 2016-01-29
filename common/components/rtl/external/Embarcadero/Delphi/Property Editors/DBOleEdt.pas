{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{            Delphi Visual Component Library            }
{*******************************************************}

unit DBOleEdt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, TypInfo, DesignIntf, DesignEditors, DbOleCtl, OCXReg,
  LibHelp;

type
  TDataBindForm = class(TForm)
    Panel1: TPanel;
    OkBtn: TButton;
    CancelBtn: TButton;
    HelpBtn: TButton;
    Label1: TLabel;
    Label2: TLabel;
    PropNameLB: TListBox;
    FieldNameLB: TListBox;
    BindBtn: TButton;
    Label3: TLabel;
    BoundLB: TListBox;
    DeleteBtn: TButton;
    ClearBtn: TButton;
    procedure BindBtnClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PropNameLBDblClick(Sender: TObject);
    procedure FieldNameLBClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FDbCtl: TDbOleControl;
    procedure ClearBoundList;
    procedure FillDialog;
    procedure EnableButtons;
  public
    function DoEditControl(DbCtl: TDbOleControl): Boolean;
  end;

  TDataBindEditor = class(TOleControlEditor)
  private
    FVerbID: Integer;
  protected
    procedure DoVerb(Verb: Integer); override;
  public
    function GetVerbCount: Integer; override;
  end;

  TDataBindProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

implementation

{$R *.dfm}

uses ActiveX, ComObj, DBConsts, VDBConsts;

type
  PObjRec = ^TObjRec;
  TObjRec = record
    FieldName: string;
    DispID: TDispID;
  end;

{ TDataBindProperty }

procedure TDataBindProperty.Edit;
var
  DataBindForm: TDataBindForm;
begin
  DataBindForm := TDataBindForm.Create(Application);
  try
    if DataBindForm.DoEditControl(GetComponent(0) as TDbOleControl) then
      Modified;
  finally
    DataBindForm.Free;
  end;
end;

function TDataBindProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

{ TDataBindEditor }

procedure TDataBindEditor.DoVerb(Verb: Integer);
var
  DataBindForm: TDataBindForm;
begin
  if Verb = FVerbID then
  begin
    DataBindForm:= TDataBindForm.Create(nil);
    try
      DataBindForm.DoEditControl(Component as TDbOleControl);
    finally
      DataBindForm.Free;
    end;
  end
  else
    inherited DoVerb(Verb);
end;

function TDataBindEditor.GetVerbCount: Integer;
var
  I, MaxVerb: Integer;
begin
  Result := inherited GetVerbCount + 1;
  MaxVerb := 0;
  // Need to find an unused Verb ID to use for the component editor.
  // We just add 1 to the highest Verb ID found.
  for I := 0 to Verbs.Count - 1 do
    if Integer(Verbs.Objects[I]) >= MaxVerb then
      MaxVerb := Integer(Verbs.Objects[I]);
  FVerbID := MaxVerb + 1;
  Verbs.AddObject(SDataBindings, TObject(FVerbID));
end;

{ TDataBindForm }

procedure TDataBindForm.BindBtnClick(Sender: TObject);
var
 ListObjRec: PObjRec;
begin
  if (PropNameLB.ItemIndex >= 0) and (PropNameLB.ItemIndex >= 0) then
  begin
    New(ListObjRec);
    with ListObjRec^ do
    begin
      FieldName := FieldNameLB.Items[FieldNameLB.ItemIndex];
      DispID := Integer(PropNameLB.Items.Objects[PropNameLB.ItemIndex]);
    end;
    BoundLB.Items.AddObject(PropNameLB.Items[PropNameLB.ItemIndex] +
      ' <---> ' + FieldNameLB.Items[FieldNameLB.ItemIndex], TObject(ListObjRec));
  end;
  EnableButtons;
end;

procedure TDataBindForm.ClearBoundList;
var
  I: Integer;
begin
  if BoundLB.Items.Count <> 0 then
  begin
    for I := 0 to BoundLB.Items.Count - 1 do
      if PObjRec(BoundLB.Items.Objects[I]) <> nil then
        Dispose(PObjRec(BoundLB.Items.Objects[I]));
    BoundLB.Clear;
  end;
  EnableButtons;
end;

procedure TDataBindForm.ClearBtnClick(Sender: TObject);
begin
  ClearBoundList;
end;

procedure TDataBindForm.DeleteBtnClick(Sender: TObject);
begin
  if BoundLB.ItemIndex <> -1 then
  begin
    Dispose(PObjRec(BoundLB.Items.Objects[BoundLB.ItemIndex]));
    BoundLB.Items.Delete(BoundLB.ItemIndex);
  end;
end;

function TDataBindForm.DoEditControl(DbCtl: TDbOleControl): Boolean;
var
  I: Integer;
begin
  FDbCtl := DbCtl;
  FillDialog;
  Result := ShowModal = mrOk;
  if Result then
  begin
    FDbCtl.DataBindings.Clear;
    for I:= 0 to BoundLB.Items.Count -1 do
    begin
      FDbCtl.DataBindings.Add;
      FDbCtl.DataBindings.Items[I].DataField := PObjRec(BoundLB.Items.Objects[I]).FieldName;
      FDbCtl.DataBindings.Items[I].DispID := PObjRec(BoundLB.Items.Objects[I]).DispID;
    end;
  end;
end;

procedure TDataBindForm.EnableButtons;

  function CanBindProperty(DispID: TDispID): Boolean;
  var
    I: Integer;
  begin
    Result := True;
    for I := 0 to BoundLB.Items.Count - 1 do
      if PObjRec(BoundLB.Items.Objects[I])^.DispID = DispID then
      begin
        Result := False;
        Exit;
      end;
  end;

begin
  BindBtn.Enabled := (PropNameLB.ItemIndex >= 0) and
    (FieldNameLB.ItemIndex >= 0) and (PropNameLB.Items.Count > 0) and
    (FieldNameLB.Items.Count > 0) and
    CanBindProperty(TDispID(PropNameLB.Items.Objects[PropNameLB.ItemIndex]));
  DeleteBtn.Enabled := BoundLB.Items.Count > 0;
  ClearBtn.Enabled := BoundLB.Items.Count > 0;
end;

procedure TDataBindForm.FillDialog;
const
  PropDisplayStr = '%s (%d)';
  BoundDisplayStr = '%s <---> %s';
var
  TypeAttr: PTypeAttr;
  I, I2: Integer;
  FuncDesc: PFuncDesc;
  VarDesc: PVarDesc;
  PropName, DocString: WideString;
  HelpContext: Longint;
  ListObjRec: PObjRec;
  TI: ITypeInfo;
  InsertStr: string;
begin
  if ((IUnknown(FDbCtl.OleObject) as IDispatch).GetTypeInfo(0,0,TI) = S_OK) then
  begin
    TI.GetTypeAttr(TypeAttr);
    try
      for I := 0 to TypeAttr.cFuncs - 1 do
      begin
        OleCheck(TI.GetFuncDesc(I, FuncDesc));
        try
          // Only show properties which are bindable and marked as either
          // display bindable or default bindable. 
          if (FuncDesc.invkind <> INVOKE_FUNC) and
            (FuncDesc.wFuncFlags and FUNCFLAG_FBINDABLE <> 0)  and
            ((FuncDesc.wFuncFlags and FUNCFLAG_FDISPLAYBIND <> 0) or
            (FuncDesc.wFuncFlags and FUNCFLAG_FDEFAULTBIND <> 0)) then
          begin
            TI.GetDocumentation(FuncDesc.memid, @PropName, @DocString, @HelpContext, nil);
            InsertStr := Format(PropDisplayStr, [PropName, FuncDesc.memid]);
            if PropNameLB.Items.Indexof(InsertStr) = -1 then
              PropNameLB.Items.AddObject(InsertStr, TObject(FuncDesc.memid));
          end;
        finally
          TI.ReleaseFuncDesc(FuncDesc);
        end;
      end;
      for I2 := 0 to TypeAttr.cVars - 1 do
      begin
        OleCheck(TI.GetVarDesc(I2, VarDesc));
        try
          // Only show properties which are bindable and marked as either
          // display bindable or default bindable.
          if (VarDesc.wVarFlags and VARFLAG_FBINDABLE <> 0) and
            ((VarDesc.wVarFlags and VARFLAG_FDISPLAYBIND <> 0) or
            (VarDesc.wVarFlags and VARFLAG_FDEFAULTBIND <> 0)) then
          begin
            TI.GetDocumentation(VarDesc.memid, @PropName, @DocString, @HelpContext, nil);
            InsertStr := Format(PropDisplayStr, [PropName, FuncDesc.memid]);
            if PropNameLB.Items.Indexof(InsertStr) = -1 then
              PropNameLB.Items.AddObject(InsertStr, TObject(VarDesc.memid));
          end;
        finally
          TI.ReleaseVarDesc(VarDesc);
        end;
      end;
    finally
      TI.ReleaseTypeAttr(TypeAttr);
    end;
    if (FDbCtl.DataSource <> nil) and (FDbCtl.DataSource.Dataset <> nil) then
      FDbCtl.DataSource.DataSet.GetFieldNames(FieldNameLB.Items);
    ClearBoundList;
    if FDbCtl.DataBindings.Count > 0 then
    begin
      for I := 0 to FDbCtl.DataBindings.Count - 1 do
      begin
        New(ListObjRec);
        ListObjRec^.FieldName := FDbCtl.DataBindings.Items[I].DataField;
        ListObjRec^.DispID := FDbCtl.DataBindings.Items[I].DispID;
        InsertStr := Format(BoundDisplayStr,
          [PropNameLB.Items[PropNameLB.Items.IndexOfObject(TObject(FDbCtl.DataBindings.Items[I].DispID))],
          (FDbCtl.DataBindings.Items[I].DataField)]);
        BoundLB.Items.AddObject(InsertStr, TObject(ListObjRec));
      end;
    end;
  end;
  EnableButtons;
end;

procedure TDataBindForm.FormDestroy(Sender: TObject);
begin
  ClearBoundList;
end;

procedure TDataBindForm.PropNameLBDblClick(Sender: TObject);
begin
  // Enable double click to do the same thing as the bind button
  if BindBtn.Enabled then BindBtnClick(nil);
end;

procedure TDataBindForm.FieldNameLBClick(Sender: TObject);
begin
  EnableButtons;
end;

procedure TDataBindForm.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TDataBindForm.FormCreate(Sender: TObject);
begin
  HelpContext := hcDAXDataBindings;
end;

end.
