{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit AzureUI;

interface

uses System.Classes, Vcl.ComCtrls, Vcl.Controls, DSAzure, Vcl.Graphics, Vcl.ValEdit, Xml.XMLIntf;

type

  ///<summary>
  ///  Base class for Azure management components which provides common functionality.
  ///</summary>
  TAzureManagement = class abstract(TCustomTreeView)
  protected
    FConnectionInfo: TAzureConnectionString;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    /// <summary> Azure connection information </summary>
    property ConnectionInfo: TAzureConnectionString read FConnectionInfo write FConnectionInfo;
  end;


  ///<summary>
  ///  Tree node which Frees the data held by it when it is destroyed.
  ///</summary>
  TAzureTreeNode = class(TTreeNode)
  public
    destructor Destroy; override;
  end;

  ///<summary> Returns the bitmap for the given image key </summary>
  function GetAzureImage(Key: String): TBitmap;

  ///<summary> Returns the first child node of the given parent with the specified node name. </summary>
  function GetFirstMatchingChildNode(Parent: IXMLNode; ChildName: String): IXMLNode;

  ///<summary> Helper function for confirming the deletion of one or more items. </summary>
  function ConfirmDeleteItem(Plural: Boolean = False): Boolean;

  ///<summary> Selects either the bottom left or bottom right cell of the given table </summary>
  procedure SelectBottomCell(Table: TValueListEditor; LeftCell: Boolean);
  ///<summary> Selects either the top left or top right cell of the given table </summary>
  procedure SelectTopCell(Table: TValueListEditor; LeftCell: Boolean);

  ///<summary> Show an error message dialog with the given message. </summary>
  procedure ShowErrorMessage(const Msg: String);

  ///<summary> Show an information message dialog with the given message. </summary>
  procedure ShowInformationMessage(const Msg: String);

implementation

uses Data.DBXClientResStrs, Vcl.Dialogs, System.SysUtils, System.UITypes;

{$R dsazurereg.res}

function ConfirmDeleteItem(Plural: Boolean): Boolean;
var
  MessageStr: String;
begin
  if Plural then
    MessageStr := SDeleteConfirmPlural
  else
    MessageStr := SDeleteConfirm;
  Result := MessageDlg(MessageStr, mtConfirmation, [mbYes, mbNo], 0) = mrYes;
end;

function GetAzureImage(Key: String): TBitmap;
begin
  Result := TBitmap.Create;
  Result.LoadFromResourceName(HInstance, Key);
end;

function GetFirstMatchingChildNode(Parent: IXMLNode; ChildName: String): IXMLNode;
var
  Child: IXMLNode;
begin
  Result := nil;

  if (Parent <> nil) and Parent.HasChildNodes and (ChildName <> EmptyStr) then
  begin
    Child := Parent.ChildNodes.First;

    while Child <> nil do
    begin
      if Child.NodeName = ChildName then
        Exit(Child);
      Child := Child.NextSibling;
    end;
  end;
end;

procedure SelectBottomCell(Table: TValueListEditor; LeftCell: Boolean);
var
  RowIndex: Integer;
  ColumnIndex: Integer;
begin
  if (Table <> nil) and (Table.RowCount > 1) and (Table.ColCount > 0) and (Table.Strings.Count > 0) then
  begin
    if LeftCell then
      ColumnIndex := 0
    else
      ColumnIndex := 1;

    RowIndex := Table.RowCount - 1;
    Table.Row := RowIndex;
    Table.Col := ColumnIndex;
  end;
end;

procedure SelectTopCell(Table: TValueListEditor; LeftCell: Boolean);
begin
  if (Table <> nil) and (Table.RowCount > 1) and (Table.ColCount > 0) and (Table.Strings.Count > 0) then
  begin
    Table.Row := 1;
    if LeftCell then
      Table.Col := 0
    else
      Table.Col := 1;
  end;
end;

procedure ShowErrorMessage(const Msg: String);
begin
  TThread.Synchronize(nil, procedure
    begin
      MessageDlg(Msg, mtError, [mbOK], 0);
    end );
end;

procedure ShowInformationMessage(const Msg: String);
begin
  TThread.Synchronize(nil, procedure
    begin
      MessageDlg(Msg, mtInformation, [mbOK], 0);
    end );
end;

{ TAzureTreeNode }

destructor TAzureTreeNode.Destroy;
begin
  if Data <> nil then
  begin
    TObject(Pointer((IntPtr(Data) shr 1) shl 1)).Free;
    Data := nil;
  end;
  inherited;
end;

{ TAzureManagement }

procedure TAzureManagement.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) then
    if (AComponent = ConnectionInfo) then
      ConnectionInfo := nil;
end;

end.
