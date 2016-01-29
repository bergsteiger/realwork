{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit DCActiveXForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls,

  DCButtonPanel, DCdreamLib, DCConsts,
  DCImageListBox, DCActiveXList;


type
  TDCActiveXEditor = class(TForm)
    DesignControlsPanel: TGroupBox;
    MainPanel: TPanel;
    BtnPanel: TDCButtonPanel;
    ComponentsBtn: TBitBtn;
    StatusPanel: TPanel;
    DividerPanel: TPanel;
    DCActiveXListBox: TDCActiveXListBox;
    procedure ComponentsBtnClick(Sender: TObject);
    procedure DCActiveXListBoxSelectionChanged(Sender: TObject);
  private
    Procedure CMApplyOptions( Var Msg : TMessage ); message CM_ApplyOptions;
  public
    Constructor Create( AOwner : TComponent ); override;
  end;

implementation

{$R *.DFM}

{------------------------------------------------------------------}

{ TDCActiveXEditor }

constructor TDCActiveXEditor.Create(AOwner: TComponent);
begin
  Inherited;
  Caption := sDCActiveXEditorCaption;
  DesignControlsPanel.Caption := ' ' + sDCActiveXPanelCaption + ' ';
  ComponentsBtn.Caption := sDCComponentsBtnCaption;
  DCActiveXListBox.ItemIndex := 0;
end;

{------------------------------------------------------------------}

procedure TDCActiveXEditor.ComponentsBtnClick(Sender: TObject);
begin
  Inherited;
  DCActiveXListBox.ShowDetails;
end;

{------------------------------------------------------------------}

procedure TDCActiveXEditor.CMApplyOptions( Var Msg : TMessage );
begin
  DCActiveXListBox.SaveChanges;
end;

{------------------------------------------------------------------}

Procedure TDCActiveXEditor.DCActiveXListBoxSelectionChanged( Sender : TObject );
begin
  Inherited;
  With DCActiveXListBox Do
  begin
    If ItemIndex >= 0 Then
      StatusPanel.Caption := ' ' + TDCActiveXListItem( Items[ ItemIndex ] ).LibraryName;
    ComponentsBtn.Enabled := ItemIndex >= 0;
  end;
end;

{------------------------------------------------------------------}

end.
