unit d_SrchByDocLink;

{ $Id: d_SrchByDocLink.pas,v 1.2 2010/08/04 08:32:23 voba Exp $ }

// $Log: d_SrchByDocLink.pas,v $
// Revision 1.2  2010/08/04 08:32:23  voba
// - k: 229672814
//
// Revision 1.1  2009/02/20 13:27:27  fireton
// - команда !CHANGE (K 77235676)
// - 131 версия базы
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BottomBtnDlg, StdCtrls, Buttons, ExtCtrls,
  DT_Query;

type
  TSearchByDocLinkDlg = class(TBottomBtnDlg)
    rgSearchType: TRadioGroup;
    Label1: TLabel;
    cbLinkType: TComboBox;
  private
    function pm_GetLinkType: Integer;
    function pm_GetSearchType: TdtDocLinkQuerySearchType;
    { Private declarations }
  public
    property LinkType: Integer read pm_GetLinkType;
    property SearchType: TdtDocLinkQuerySearchType read pm_GetSearchType;
    { Public declarations }
  end;

var
  SearchByDocLinkDlg: TSearchByDocLinkDlg;

implementation
{$R *.dfm}

function TSearchByDocLinkDlg.pm_GetLinkType: Integer;
begin
 Result := cbLinkType.ItemIndex-1;
end;

function TSearchByDocLinkDlg.pm_GetSearchType: TdtDocLinkQuerySearchType;
begin
 Result := TdtDocLinkQuerySearchType(rgSearchType.ItemIndex);
end;

end.
 