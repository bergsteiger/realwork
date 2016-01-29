unit vtStringLister;

{ Библиотека ""            }
{ Начал: Люлин А.В.        }
{ Модуль: vtStringLister - }
{ Начат: 30.05.2005 16:36  }
{ $Id: vtStringLister.pas,v 1.6 2007/03/20 13:38:56 lulin Exp $ }

// $Log: vtStringLister.pas,v $
// Revision 1.6  2007/03/20 13:38:56  lulin
// - избавляемся от лишних преобразований строк.
//
// Revision 1.5  2007/02/16 17:17:26  lulin
// - избавляемся от стандартного строкового типа.
//
// Revision 1.4  2007/02/13 11:44:32  mmorozov
// - new: заголовок дерева (TvtHeader) использует таблицу стилей (CQ: OIT5-24283);
//
// Revision 1.3  2006/12/26 13:14:17  lulin
// - cleanup.
//
// Revision 1.2  2006/12/22 15:10:21  lulin
// - bug fix: не собиралась библиотека.
//
// Revision 1.1  2005/05/30 13:02:22  lulin
// - new unit: vtStringLister.
//

{$Include vtDefine.inc }

interface

uses
  Classes,

  l3Interfaces,
  l3Types,
  
  vtLister
  ;

type
  TvtStringLister = class(TvtCustomLister)
   {*! Видимый элемент для отображения списка строк из TStrings. }
    private
     FAlienSource : Boolean;
     FItems : TStrings;
     procedure ListChange(Sender: TObject);
    protected
     function  DoOnGetItem(Index : LongInt) : Il3CString;
       override;
     procedure SetItems(Value: TStrings);
     function  GetSorted : Boolean;
     Procedure SetSorted(Value : Boolean);
     {procedure CharToItem(Sender : TObject; Var SrchStr : String; var Index : LongInt);}
      procedure Cleanup;
        override;
        {-}
    public
     Constructor Create(AOwner: TComponent); override;
     procedure   SetItemsList(Value : TStrings; NeedDestroy : Boolean);
     property    SelectArray;
    published
     property Items : TStrings Read FItems Write SetItems;
      {* - элементы для отображения. }
     property Sorted : Boolean Read GetSorted Write SetSorted;
      {* - признак сортировки. }
     property AlienSource : Boolean Read FAlienSource Write FAlienSource;
      {* - признак того что этот элемент не владеет Items и не должен освобождать их. }

      property Images;
      property AutoRowHeight;
      property BorderStyle;
      property Columns;
      property Header;
      property IntegralHeight;
      property MultiSelect;
      property ProtectColor;
      property RowHeight;
      property ScrollStyle;
      property SelectColor;
      property SelectNonFocusColor;
      property ShowHeader;
      property UseTabStops;
      property PickedList;
      property TriplePicked;
      property MultiStrokeItem;
      property ReadOnly;
      property ViewOptions;

//      property OnClickHeader;
      property OnGetItemImageIndex;
      property OnGetItemColor;
      property OnGetItemFont;
      property OnGetItemCursor;
      property OnGetItemStatus;
      property OnIsSelected;
      property OnSelect;
      property OnSelectChange;
      property OnSelectChanged;
      property OnTopIndexChanged;
      property OnCurrentChanged;
      property OnCountChanged;
      property OnUserCommand;
      property OnIsCommandProcessed;

      {inherited properties}
      property Align;
      property Color;
      property Controller;
      property Ctl3D;
      property DragCursor;
      property DragMode;
      property Enabled;
      property Font;
      property ParentColor;
      property ParentCtl3D;
      property ParentFont;
      property ParentShowHint;
      property PopupMenu;
      property ShowHint;
      property TabOrder;
      property TabStop;
      property Visible;
      property Anchors;
      property Constraints;

      {inherited events}
      property OnClick;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDrag;
      property OnEnter;
      property OnExit;
      property OnKeyDown;
      property OnKeyPress;
      property OnKeyUp;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property OnActionElement;

    end;//TvtStringLister

implementation

uses
  SysUtils,

  l3Base,
  l3String,

  OvcConst,
  OvcData
  ;

// start class TvtStringLister

constructor TvtStringLister.Create(AOwner: TComponent);
 begin
  inherited;
  fItems := TStringList.Create;
  TStringList(FItems).OnChange:=ListChange;
  OnCharToItem := CharToItem;
 end;

procedure TvtStringLister.Cleanup;
 begin
  if FItems <> nil then
   begin
    if (FItems Is TStringList) then
     TStringList(FItems).OnChange := nil;
    if not FAlienSource then FItems.Free;
   end;
  Inherited;
 end;

procedure TvtStringLister.SetItems(Value: TStrings);
 begin
  if fItems <> Value then
   fItems.Assign(Value);
  Total := fItems.Count;
 end;

procedure TvtStringLister.SetItemsList(Value : TStrings; NeedDestroy : Boolean);
 begin
  if (FItems <> Value) then
   begin
    if FAlienSource
     then
      begin
       if (FItems <> nil) AND (FItems Is TStringList) then
        TStringList(FItems).OnChange := nil;
      end
     else FItems.Free;
   end;
  FItems:=Value;
  if (FItems <> nil)
   then
    begin
     if (FItems Is TStringList) then TStringList(FItems).OnChange:=ListChange;
     Total:=FItems.Count;
    end
   else
    Total:=0;
  AlienSource:=not NeedDestroy;
 end;

function TvtStringLister.GetSorted : Boolean;
 begin
  if (FItems Is TStringList) then Result:=TStringList(FItems).Sorted else Result := false;
 end;

procedure TvtStringLister.SetSorted(Value : Boolean);
 begin
  if (FItems Is TStringList) then TStringList(FItems).Sorted:=Value;
 end;

procedure TvtStringLister.ListChange(Sender: TObject);
begin
 Changing;
 try
  Total := FItems.Count;
 finally
  Changed;
 end;
end;

function TvtStringLister.DoOnGetItem(Index : LongInt) : Il3CString;
begin
 if (csDesigning in ComponentState) and (FItems.Count <= 0) then
  Result := l3Fmt(GetOrphStr(SCSampleListItem), [Index])
 else
  Result := l3CStr(FItems.Strings[Index]);
end;

end.

