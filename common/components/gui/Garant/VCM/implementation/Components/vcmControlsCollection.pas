unit vcmControlsCollection;
{* ��������� ����������� ���������, ����������� � ���������. }

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcmControlsCollection - }
{ �����: 11.03.2003 16:12 }
{ $Id: vcmControlsCollection.pas,v 1.10 2015/06/03 12:26:27 lulin Exp $ }

// $Log: vcmControlsCollection.pas,v $
// Revision 1.10  2015/06/03 12:26:27  lulin
// - �������� ��������� �����������.
//
// Revision 1.9  2014/04/23 12:05:10  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.8  2008/04/02 14:22:13  lulin
// - cleanup.
//
// Revision 1.7  2005/01/27 13:43:28  lulin
// - bug fix: �� ��� �������� ������������ �� �������� (CQ OIT5-11924).
//
// Revision 1.6  2004/12/23 15:34:09  lulin
// - ����������� �������� ���������� � ����� _Preview �� ������ _Preview.
//
// Revision 1.5  2004/12/21 11:37:44  mmorozov
// new: methods _IsTComponents, _FirstTComponent;
//
// Revision 1.4  2004/11/24 12:35:55  lulin
// - new behavior: ����������� �������� �� ��������� ������ ������������� � ���������.
//
// Revision 1.3  2003/11/19 11:38:25  law
// - new behavior: ������������ ��� �������� � �������� � MenuManager'� ��� ���������� ������������� ��������������. ���� �������������� ���� �� ��������.
//
// Revision 1.2  2003/07/25 10:45:43  law
// - new unit: vcmBaseCollection.
//
// Revision 1.1  2003/04/01 12:54:44  law
// - ��������������� MVC � VCM.
//
// Revision 1.2  2003/03/26 12:13:41  law
// - cleanup.
//
// Revision 1.1  2003/03/11 13:37:24  law
// - new behavior: ������� ������������ ����������� ��������� � ���������.
//

{$I vcmDefine.inc }

interface

{$If not defined(NoVCM)}
uses
  Classes,

  vcmBaseCollection,
  vcmControlsCollectionItem
  ;

type
  TvcmControlsCollection = class(TvcmBaseCollection)
   {* ��������� ����������� ���������, ����������� � ���������. }
    public
    // public methods
      class function GetItemClass: TCollectionItemClass;
        override;
        {-}
      function  LinkedToForm: Boolean;
        {-}
      function  FindItemByControl(const aControl: TComponent): TvcmControlsCollectionItem;
        {-}
      function  IsTComponents : Boolean;
        {* - ���������� ���� �� � ������ ������������� ������ TComponent. }
      function  FirstTComponent : TComponent;
        {* - ������ TComponent � ������. }
  end;//TvcmControlsCollection
{$IfEnd}

implementation

{$If not defined(NoVCM)}
uses
  Controls
  ;

// start class TvcmControlsCollection

class function TvcmControlsCollection.GetItemClass: TCollectionItemClass;
  //override;
  {-}
begin
 Result := TvcmControlsCollectionItem;
end;

function TvcmControlsCollection.LinkedToForm: Boolean;
  {-}
var
 l_Index : Integer;
begin
 Result := false;
 if (Count = 0) then
  Result := true
 else begin
  for l_Index := 0 to Pred(Count) do begin
   if (TvcmControlsCollectionItem(Items[l_Index]).Control = nil) then begin
    Result := true;
    break;
   end;//TvcmControlsCollectionItem(Items[l_Index]).Control = nil
  end;//for l_ControlIndex
 end;//Count = 0
end;

function TvcmControlsCollection.FirstTComponent : TComponent;
{* - ������ TComponent � ������. }
var
 l_Index : Integer;
begin
 Result := nil;
 for l_Index := 0 to Pred(Count) do
  // ������ �������� ������������� TComponent
  with TvcmControlsCollectionItem(Items[l_Index]) do
   if Assigned(Control) {and not (Control is TControl)} then
   begin
    Result := TvcmControlsCollectionItem(Items[l_Index]).Control;
    Break;
   end;
end;

function TvcmControlsCollection.IsTComponents : Boolean;
{* - ���������� ���� �� � ������ ������������� ������ TComponent. }
var
 l_Index : Integer;
begin
 if (Count <= 1) then
  Result := true
 else
 begin
  Result := false;
  for l_Index := 0 to Pred(Count) do
   // ������ �������� ������������� TComponent
   if not (TvcmControlsCollectionItem(Items[l_Index]).Control is TControl) then
   begin
    Result := true;
    Break;
   end;//not (TvcmControlsCollectionItem(Items[l_Index]).Control is TControl)
 end;//Count <= 1
end;

function TvcmControlsCollection.FindItemByControl(const aControl: TComponent): TvcmControlsCollectionItem;
  {-}
var
 l_Item  : TvcmControlsCollectionItem;
 l_Index : Integer;
begin
 Result := nil;
 if (f_FoundItem Is TvcmControlsCollectionItem) AND
    (TvcmControlsCollectionItem(f_FoundItem).Control = aControl) then
  Result := TvcmControlsCollectionItem(f_FoundItem)
 else
 for l_Index := 0 to Pred(Count) do
 begin
  l_Item := TvcmControlsCollectionItem(Items[l_Index]);
  if (l_Item.Control = aControl) then
  begin
   Result := l_Item;
   f_FoundItem := Result;
   break;
  end;//l_Item Is TevBaseCollectionItem
 end;//for l_Item
end;
{$IfEnd}

end.

