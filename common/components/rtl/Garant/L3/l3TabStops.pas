unit l3TabStops;

{ ���������� "L3 (Low Level Library)" }
{ �����: ����� �.�. � }
{ ������: l3TabStops - }
{ �����: 22.01.2004 17:00 }
{ $Id: l3TabStops.pas,v 1.8 2008/02/28 15:12:11 lulin Exp $ }

// $Log: l3TabStops.pas,v $
// Revision 1.8  2008/02/28 15:12:11  lulin
// - ��������� nevTools �� ������.
//
// Revision 1.7  2008/02/14 17:09:15  lulin
// - cleanup.
//
// Revision 1.6  2007/08/21 11:39:52  lulin
// - ����������� �� �������������� �����������.
//
// Revision 1.5  2007/07/03 16:52:11  lulin
// - ��� ��������� �������� � ����� ������.
//
// Revision 1.4  2004/06/21 17:04:27  law
// - �������������� ��������� ������� ������ �� ��������� - �������������� �������������� �������������� ���������� (��� ���� ������ AQTime, �� �� ���� �� �������).
//
// Revision 1.3  2004/01/27 08:27:46  fireton
// - add: � Il3TabStops ��������� NeedCutByTab - ���������� �� ���������
// - add: � TevCanvas ��������� � ���������� ������� ������ ������ � ����������
// - change: TEnhHeader ������ ��������� �� TevCustomPanel
// - change: TCustomVLister ������ ���������� � �������� ��������� TEnhHeader
//
// Revision 1.2  2004/01/22 14:38:38  law
// - bug fix.
//
// Revision 1.1  2004/01/22 14:31:04  law
// - new unit: l3TabStops.
//

{$Include l3Define.inc }

interface

uses
  l3Types,
  l3Interfaces,
  l3InternalInterfaces,
  l3Base,
  l3CacheableBase
  ;

type
  Tl3TabStopsGetItem = function (anIndex: Integer; out aPos: Integer): Boolean of object;
    {-}

  Tl3TabStops = class(Tl3CacheableBase, Il3TabStops)
    private
    // internal fields
      f_Index     : Integer;
      f_Prev      : Integer;
      f_OnGetItem : Tl3TabStopsGetItem;
      f_NeedCut   : Boolean;
    private
    // interface methods
      // Il3TabStops
      function Clone: Il3TabStops;
        reintroduce;
        {* - ��������� ������� ���������. }
      function Next: Tl3TabStop;
        {* - ��������� ������� ���������. }
      procedure Reset;
        {-}
      function Filler: Tl3WString;
        {* - ��������� ������-�����������. }
      function Style: Tl3TabStopStyle;
        {* - ��������� �����. }
      function NeedCutByTab: Boolean;
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(aGetItem : Tl3TabStopsGetItem;
                         ANeedCut : Boolean = False); 
        reintroduce;
        {-}
      class function Make(aGetItem : Tl3TabStopsGetItem;
                          ANeedCut : Boolean = False): Il3TabStops;
        reintroduce;
        {-}
  end;//Tl3TabStops

implementation

uses
  l3String,

  evConst
  ;

const
 cTabWidth = evInchMul div 2;

// start class Tl3TabStops

constructor Tl3TabStops.Create(aGetItem : Tl3TabStopsGetItem;
                               ANeedCut : Boolean = False);
  //reintroduce;
  {-}
begin
 inherited Create;
 f_OnGetItem := aGetItem;
 f_Index := 0;
 f_Prev := 0;
 f_NeedCut := ANeedCut;
end;

class function Tl3TabStops.Make(aGetItem : Tl3TabStopsGetItem;
                                ANeedCut : Boolean = False): Il3TabStops;
  //reintroduce;
  {-}
var
 l_TabStops : Tl3TabStops;
begin
 l_TabStops := Create(aGetItem, ANeedCut);
 try
  Result := l_TabStops;
 finally
  l3Free(l_TabStops);
 end;//try..finally
end;

procedure Tl3TabStops.Cleanup;
  //override;
  {-}
begin
 f_Prev := 0;
 f_Index := 0;
 f_OnGetItem := nil;
 inherited;
end;

function Tl3TabStops.Clone: Il3TabStops;
  {* - ��������� ������� ���������. }
var
 l_TabStops : Tl3TabStops;
begin
 l_TabStops := Tl3TabStops.Create(f_OnGetItem, f_NeedCut);
 try
  l_TabStops.f_Index := f_Index;
  Result := l_TabStops;
 finally
  l3Free(l_TabStops);
 end;//try..finally
end;

function Tl3TabStops.Next: Tl3TabStop;
  {* - ��������� ������� ���������. }
begin
 Result.rStyle := Style;
 Result.rFiller := Filler;
 try
  if Assigned(f_OnGetItem) then
  begin
   if f_OnGetItem(f_Index, Result.rPosition) then
   begin
    Result.rPosition := f_Prev + Result.rPosition;
    Exit;
   end;//f_OnGetItem
  end;//Assigned(f_OnGetItem)
  Result.rPosition := f_Prev + cTabWidth;
 finally
  Inc(f_Index);
  f_Prev := Result.rPosition;
 end;//try..finally
end;

procedure Tl3TabStops.Reset;
  {-}
begin
 f_Index := 0;
 f_Prev := 0;
end;

function Tl3TabStops.Filler: Tl3WString;
  {* - ��������� ������-�����������. }
begin
 l3AssignNil(Result);
end;

function Tl3TabStops.Style: Tl3TabStopStyle;
  {* - ��������� �����. }
begin
 Result := l3_tssLeft;
end;
 
function Tl3TabStops.NeedCutByTab: Boolean;
begin
 Result := f_NeedCut;
end;

end.

