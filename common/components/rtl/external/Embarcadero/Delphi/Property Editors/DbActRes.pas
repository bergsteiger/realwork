{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit DBActRes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, StdActns, ActnList, DBActns;

type
  TStandardDatasetActions = class(TDataModule)
    ActionList1: TActionList;
    ImageList1: TImageList;
    DataSetCancel1: TDataSetCancel;
    DataSetDelete1: TDataSetDelete;
    DataSetEdit1: TDataSetEdit;
    DataSetFirst1: TDataSetFirst;
    DataSetInsert1: TDataSetInsert;
    DataSetLast1: TDataSetLast;
    DataSetNext1: TDataSetNext;
    DataSetPost1: TDataSetPost;
    DataSetPrior1: TDataSetPrior;
    DataSetRefresh1: TDataSetRefresh;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StandardDatasetActions: TStandardDatasetActions;

implementation

{$IFDEF MSWINDOWS}
{$R *.dfm}
{$ENDIF}

end.
   
