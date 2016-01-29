unit d_BatchDelAttr;

{ $Id: d_BatchDelAttr.pas,v 1.5 2012/02/17 09:32:44 kostitsin Exp $ }

// $Log: d_BatchDelAttr.pas,v $
// Revision 1.5  2012/02/17 09:32:44  kostitsin
// Переименовываем NumOfSelect в SelectedCount
//
// Revision 1.4  2010/09/24 12:15:44  voba
// - k : 235046326
//
// Revision 1.3  2009/02/03 07:39:35  narry
// - переименование заголовка
//
// Revision 1.2  2008/05/05 10:33:41  voba
// no message
//
// Revision 1.1  2007/12/18 08:48:17  fireton
// - первый коммит
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BtnDlg, StdCtrls, Buttons, ExtCtrls, OvcBase, afwControl,
  afwInputControl, vtLister,
  dt_Types, dt_AttrSchema, DictsSup,

  l3Base,
  l3Interfaces, afwControlPrim, afwBaseControl;

type
  TBADDResult = array of TdtAttribute;

  TBatchAttrDelDlg = class(TBtnDlg)
    lstAttrTypes: TvtLister;
    procedure FormCreate(Sender: TObject);
    procedure lstAttrTypesSelectChanged(Sender: TObject; Index: Integer;
      var SelectedState: Integer);
    procedure lstAttrTypesGetStrItem(Sender: TObject; Index: Integer;
      var ItemString: Il3CString);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetSelectedAttrTypes(var theArray: TBADDResult);
  end;

  

implementation

{$R *.dfm}
const
 cDeletableAttrSet : array[0..10] of TdtAttribute =
    (atSources, atTypes, atTerritories, atAccGroups, atBases, atNorms, atClasses,
     atPrefixes, atKeyWords, atAnnoClasses, atServiceInfo);

procedure TBatchAttrDelDlg.FormCreate(Sender: TObject);
begin
 inherited;
 lstAttrTypes.Total := High(cDeletableAttrSet);
end;

procedure TBatchAttrDelDlg.GetSelectedAttrTypes(var theArray: TBADDResult);
var
 l_Idx: Integer;
 I: Integer;
begin
 SetLength(theArray, High(cDeletableAttrSet));
 l_Idx := 0;
 for I := 0 to Pred(High(cDeletableAttrSet)) do
  if lstAttrTypes.Selected[I] then
  begin
   theArray[l_Idx] := cDeletableAttrSet[I];
   Inc(l_Idx);
  end;
 SetLength(theArray, l_Idx); 
end;

procedure TBatchAttrDelDlg.lstAttrTypesSelectChanged(Sender: TObject;
  Index: Integer; var SelectedState: Integer);
begin
 Ok.Enabled := lstAttrTypes.SelectedCount > 0;
end;

procedure TBatchAttrDelDlg.lstAttrTypesGetStrItem(Sender: TObject;
  Index: Integer; var ItemString: Il3CString);
begin
  inherited;
  ItemString := l3CStr(GetAttrName(cDeletableAttrSet[Index]));
end;

end.

