unit D_DTFilt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BottomBtnDlg, StdCtrls, OvcBase,  vtlister, Buttons,
  ExtCtrls, DT_Types, vtStringLister, afwControl, afwInputControl,
  afwControlPrim, afwBaseControl;

type
  TDocTypeFilterDlg = class(TBottomBtnDlg)
    lstTypes: TvtStringlister;
    cbxIsDefault: TCheckBox;
   public
   function Execute(var aUserMask : TUserTypeSet;
                    var aDocMask : TDocTypeSet) : Boolean; reintroduce;
  end;


implementation

{$R *.dfm}

Uses
 IniShop
 ;

function TDocTypeFilterDlg.Execute(var aUserMask : TUserTypeSet; var aDocMask : TDocTypeSet) : Boolean;
 var
  I : Integer;
 begin
  If aUserMask = cAllUserTypeSet
   then lstTypes.vlbSelectAllItems
   else
    begin
     lstTypes.vlbDeselectAllItems;
     If dtText in aDocMask then
      For I := 0 to Pred(lstTypes.Total) - 2 do
       lstTypes.Selected[I] := TUserType(Succ(I)) in aUserMask;
    end;

  lstTypes.Selected[Pred(Pred(lstTypes.Total))] := dtObject in aDocMask;
  lstTypes.Selected[Pred(lstTypes.Total)] := dtDictEntry in aDocMask;

  Result := ShowModal = mrOk;
  If Not Result then Exit;

  if lstTypes.SelectedCount = lstTypes.Total then
  begin
   aUserMask := cAllUserTypeSet;
   aDocMask  := cAllDocTypeSet;
  end
  else
  begin
   aUserMask := [];
   for I := 0 to Pred(lstTypes.Total)-2 do
    If lstTypes.Selected[I] then  Include(aUserMask,TUserType(Succ(I)));
   if TUserType(1) in aUserMask then Include(aUserMask,TUserType(0)); {Шаманство с типами}

   aDocMask  := cAllDocTypeSet;
   if aUserMask = [] then Exclude(aDocMask, dtText);

   if Not lstTypes.Selected[Pred(Pred(lstTypes.Total))] then
    Exclude(aDocMask, dtObject);
   if Not lstTypes.Selected[Pred(lstTypes.Total)] then
    Exclude(aDocMask, dtDictEntry);

   if (dtDictEntry in aDocMask) or
      (dtObject in aDocMask) then
    Include(aUserMask,TUserType(0)); {Шаманство с типами}
  end;

  if cbxIsDefault.Checked then
   begin
    IniRec.DocSetTypeFilter := aUserMask;
    IniRec.SysDocSetTypeFilter := aDocMask;
   end;

 end;

end.
