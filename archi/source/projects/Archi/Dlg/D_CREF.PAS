unit D_CRef;

{ $Id: D_CREF.PAS,v 1.27 2013/05/31 07:20:26 lulin Exp $ }

{$Include l3XE.inc}

interface

uses
  WinTypes, 
  WinProcs, 
  Classes, 
  Graphics, 
  Forms, 
  Controls, 
  Buttons, 
  StdCtrls, 

  OvcBase, 
  OVCConst,

  l3Interfaces,

  vtLister,  
  vtHeader, 
  vtCtrls,

  nevTools,
  nevNavigation,
  evInternalInterfaces,

  DT_Const, 
  DT_Types, 
  DT_Doc
  ;

type
  TChoiceRefDlg = class(TvtPopupList)
   private
    f_Hyperlink : IevHyperlink;
    f_Family    : TFamilyID;
   protected
    function RefListUserCommand(Sender: TObject; Command: Word) : Boolean;
    //procedure RefListActionElement(Sender: TObject; Index: Longint);
    procedure RefListCurrentChanged(Sender: TObject; aNewCurrent: Integer; aOldCurrent: Integer);
    procedure AdjustPopUp(Sender: TObject);
   public
    constructor Create(AOwner: TComponent); reintroduce;
    Function Execute(aFamily : TFamilyID; aHyperlink : IevHyperlink; var aDestLink : TDestHLinkRec) : Boolean;
  end;

implementation

//{$R *.DFM}
uses 

 SysUtils,

 l3Types, 
 l3Base,
 l3InternalInterfaces,

 StrShop,
 dt_LinkServ,
 CustEditWin;

type
 T_Il3ViewStringList_Wrapper = class(Tl3Base, Il3ViewStringList)
  private
   f_Hyperlink : IevHyperlink;
  protected
   function  pm_GetCount: Longint;
   function  pm_GetViewString(anIndex: Longint): Il3CString;
  public
   class function MakeIl3ViewStringList(const aHyperlink : IevHyperlink) : Il3ViewStringList;
 end;

{T_Il3ViewStringList_Wrapper}
function  T_Il3ViewStringList_Wrapper.pm_GetCount: Longint;
begin
 Result := f_Hyperlink.AddressList.Count;
end;

function  T_Il3ViewStringList_Wrapper.pm_GetViewString(anIndex: Longint): Il3CString;
begin
 Result := l3CStr(f_Hyperlink.AddressList.Name[anIndex]);
end;

class function T_Il3ViewStringList_Wrapper.MakeIl3ViewStringList(const aHyperlink : IevHyperlink) : Il3ViewStringList;
var
 l_Wrapper : T_Il3ViewStringList_Wrapper;
begin
 Assert(aHyperlink <> nil);

 l_Wrapper := T_Il3ViewStringList_Wrapper.Create;
 try
  l_Wrapper.f_Hyperlink := aHyperlink;
  Result := l_Wrapper;
 finally
  l3Free(l_Wrapper);
 end;
end;

{TChoiceRefDlg}
constructor TChoiceRefDlg.Create(aOwner: TComponent);
begin
 inherited Create(aOwner, TvtCustomIStrListLister, [vt_plShowFooter]);
 fLister.OnUserCommand   := RefListUserCommand;
 //fLister.OnActionElement := RefListActionElement;
 fLister.OnCurrentChanged:= RefListCurrentChanged;
 OnAdjustCtrl := AdjustPopUp;
 fLister.MultiStrokeItem := True;
end;

function TChoiceRefDlg.Execute(aFamily : TFamilyID;
                              aHyperlink : IevHyperlink;
                              var aDestLink : TDestHLinkRec) : Boolean;
var
 lIt : Integer;
begin
 f_Family := aFamily;

 f_Hyperlink := aHyperlink;
 (fLister as TvtCustomIStrListLister).Items := T_Il3ViewStringList_Wrapper.MakeIl3ViewStringList(aHyperlink);

 RefListCurrentChanged(Self, fLister.Current, fLister.Current);
 lIt := inherited Execute;
 Result := lIt >= 0;
 if Result then
  with f_Hyperlink.AddressList[fLister.Current]{$IfDef XE4}.rTafwAddress{$EndIf} do
  begin
   aDestLink.Doc := DocID;
   aDestLink.Sub := SubID;
  end;
end;

procedure TChoiceRefDlg.AdjustPopUp(Sender: TObject);
var
 l_Pt : TPoint;
begin
 if Width < 260 then 
  Width := 260;
 GetCursorPos(l_Pt);
 AdjustCtrl(Self, l_Pt);
end;

function TChoiceRefDlg.RefListUserCommand(Sender: TObject; Command: Word): Boolean;
var
 lDestLink : TDestHLinkRec;
begin
case Command of
 ccDel :
  begin
    if f_Hyperlink.AddressList.Count = 1 then
   begin
     f_Hyperlink.Delete;
    Close;
   end
   else
   begin
    // сейчас так нельзя из-за проблем с синхронизацией ссылок
     //with f_Hyperlink.AddressList do Delete(Items[fLister.Current]);

    //из-за проблем с синхронизацией ссылок делаем так  (+ lHLServ.DelHyperLink(Doc, Sub);)
     with f_Hyperlink.AddressList[fLister.Current]{$IfDef XE4}.rTafwAddress{$EndIf} do
    begin
     lDestLink.Doc := DocID;
     lDestLink.Sub := SubID;
    end;
     TCustomEditorWindow(Owner).RemoveReference(@lDestLink, f_Hyperlink);

     fLister.Total := f_Hyperlink.AddressList.Count;
   end;
   Result := True;
  end
 else
  Result := False;
end;
end;

{procedure TChoiceRefDlg.RefListActionElement(Sender: TObject; Index: Longint);
begin
 ModalResult:=mrOk;
end;}

procedure TChoiceRefDlg.RefListCurrentChanged(Sender      : TObject; 
                                              aNewCurrent : Integer; 
                                              aOldCurrent : Integer);
begin
 if fLister.Total > 0 then
  begin
  fFooter.Sections[0].Caption := Format(scFmtFuterCounter, [aNewCurrent + 1, fLister.Total]);
  if f_Family = 0 then
   fFooter.Sections[1].Caption := ''
  else
   with f_Hyperlink.AddressList[aNewCurrent]{$IfDef XE4}.rTafwAddress{$EndIf} do
   begin
     if DocID = 0 then
      fFooter.Sections[1].Caption := Format('SubID : %d',[SubID])
     else
      fFooter.Sections[1].Caption := Format('DocID : %d   SubID : %d',[LinkServer(f_Family).Renum.GetExtDocID(DocID), SubID]);
   end;
  end
  else
  begin
   fFooter.Sections[0].Caption := '';
   fFooter.Sections[1].Caption := '';
  end;
end;

end.
