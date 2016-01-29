unit vcmStringList;

{ ���������� "vcm"        }
{ �����: ����� �.�. �     }
{ ������: vcmStringList - }
{ �����: 15.09.2004 17:46 }
{ $Id: vcmStringList.pas,v 1.36 2015/01/15 14:08:31 lulin Exp $ }

// $Log: vcmStringList.pas,v $
// Revision 1.36  2015/01/15 14:08:31  lulin
// {RequestLink:585926571}. ���������� Interlocked.
//
// Revision 1.35  2014/02/18 10:01:25  lulin
// - ��� ������������� ������� ������� ����������� ��������� ���� ����������.
//
// Revision 1.34  2012/03/23 13:03:43  lulin
// - ���������� ���������.
//
// Revision 1.33  2011/05/19 17:03:42  lulin
// {RequestLink:266418093}.
//
// Revision 1.32  2008/02/15 10:28:34  lulin
// - bug fix: �� ���������� ����������.
//
// Revision 1.31  2008/02/14 14:12:13  lulin
// - <K>: 83920106.
//
// Revision 1.30  2008/02/07 08:41:27  lulin
// - bug fix: �� ���������� ����������.
//
// Revision 1.29  2008/01/31 10:09:19  lulin
// - bug fix: �� ��������� VCM.
//
// Revision 1.28  2008/01/28 07:04:35  oman
// - fix: �� ���������� ����������
//
// Revision 1.27  2007/07/24 19:43:39  lulin
// - bug fix: �� ��������������� ����������.
//
// Revision 1.26  2007/03/28 19:47:38  lulin
// - bug fix: �� ���������� ����������.
//
// Revision 1.25  2007/02/13 14:51:33  lulin
// - bug fix: �� ���������� ����������.
//
// Revision 1.24  2007/02/13 12:08:58  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.23  2007/02/12 19:41:37  lulin
// - bug fix: �� ��������������� ����������.
//
// Revision 1.22  2007/02/09 13:41:14  lulin
// - � ������ ������ ����� ��������� ������������ ������.
//
// Revision 1.21  2007/02/05 15:08:01  lulin
// - ��������� ����������� �������� � ���������� � ����������.
//
// Revision 1.20  2007/02/02 12:25:37  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.19  2006/12/29 13:57:58  lulin
// - ���������� ����������� ���������� ������ �����.
//
// Revision 1.18  2006/12/29 13:09:21  lulin
// - ��������� ��������� ������������ ������ �����.
//
// Revision 1.17  2006/12/29 10:57:57  lulin
// - ����� �������� ��� "������" ����������� VCL-��� �����.
//
// Revision 1.16  2006/12/29 10:42:19  lulin
// - cleanup.
//
// Revision 1.15  2006/12/29 10:38:42  lulin
// - cleanup.
//
// Revision 1.14  2006/12/29 10:27:03  lulin
// - ��������� ��� ���� ������ ���������� ������ � ������.
//
// Revision 1.13  2006/06/29 10:27:44  mmorozov
// - new: property Il3StringsEx._Sorted;
//
// Revision 1.12  2006/05/12 07:12:16  oman
// warning fix
//
// Revision 1.11  2006/04/14 13:40:19  lulin
// - ��������� ����������� ����������.
//
// Revision 1.10  2006/04/14 12:11:14  lulin
// - ����� � �������� ���� ����� ���������� ��������.
//
// Revision 1.9  2006/04/14 11:53:02  lulin
// - ��������� ��������� � ���������� _Unknown_ � ���� ����.
//
// Revision 1.8  2005/10/20 13:42:41  lulin
// - cleanup.
//
// Revision 1.7  2005/10/20 13:24:54  lulin
// - cleanup.
//
// Revision 1.6  2005/01/12 16:22:27  lulin
// - ����������� ����� ��������� ��������� � �������� VCM �� ���������� AFW.
//
// Revision 1.5  2004/09/17 13:27:38  lulin
// - _TvcmStringList ������ ����������.
//
// Revision 1.4  2004/09/17 10:51:07  lulin
// - new method: _IvcmStrings.Assign.
//
// Revision 1.3  2004/09/17 10:42:07  lulin
// - new interface: _IvcmStrings.
//
// Revision 1.2  2004/09/15 16:20:45  lulin
// - bug fix: AllEverestComponents7 �� ��������� ��-�� Str_Man'�.
// - bug fix: AllEverestComponents7 �� ���������� ��-�� ��������.
//
// Revision 1.1  2004/09/15 13:57:55  lulin
// - new unit: vcmStringList.
//

{$Include vcmDefine.inc }

interface

{$IfDef vcmNeedL3}
uses
  l3VCLStrings
  ;

type
  TvcmStringList = class(Tl3Strings)
  end;//TvcmStringList

implementation
{$Else  vcmNeedL3}
uses
  Windows,

  Classes,

  l3Interfaces,
  {$IfDef vcmNeedL3}
  l3VCLStrings,
  {$EndIf vcmNeedL3}

  vcmInterfaces,
  vcmBase
  ;

type
  _l3Unknown_Parent_ = TStringList;
  {$Define _UnknownNeedsQI}
  {$IfNDef vcmNeedL3}
   {$Define _UnknownNotNeedL3}
  {$EndIf  vcmNeedL3}
  {$Include l3Unknown.imp.pas}
  TvcmStringList = class(_l3UnknownPrim_, IvcmStrings)
    protected
    // interface methods
      // Il3Base
      {$IfNDef vcmNeedL3}
      function  CheckStamp(const aGUID: TGUID): Boolean;
        {-}
      {$EndIf  vcmNeedL3}
      // IvcmStrings
      function IvcmStrings.Get_Count = GetCount;
        {-}
      function  IvcmStrings.Get_Item = Get;
      procedure IvcmStrings.Set_Item = Put;
        {-}
      function  IvcmStrings.Get_Objects = GetObject;
      procedure IvcmStrings.Set_Objects = PutObject;
        {-}
      function  Get_Items: TStrings;
      procedure Set_Items(aValue: TStrings);
        {-}
      procedure Assign(const aStrings: IvcmStrings);
        reintroduce;
        overload;
        {-}
      procedure Assign(aStrings: TStrings);
        reintroduce;
        overload;
        {-}
      function  EQ(const aStrings: IvcmStrings): Boolean;
        {-}
      function  GetW(anIndex: Integer): Tl3WString;
      procedure PutW(anIndex: Integer; const aValue: Tl3WString);
        {-}
      function  Get_ItemC(anIndex: Integer): IvcmCString;
      procedure Set_ItemC(anIndex: Integer; const aValue: IvcmCString);
        {-}
      function  Add(const aStr: string): Integer;
        reintroduce;
        overload;
        {-}
      function  Add(const aStr: Il3CString): Integer;
        reintroduce;
        overload;
        {-}
      function  Add(const aStr: Tl3PCharLenPrim): Integer;
        reintroduce;
        overload;
        {-}
      procedure Insert(aIndex: Integer; const aStr: Il3CString);
        reintroduce;
        overload;
      procedure Insert(aIndex: Integer; const aStr: string);
        reintroduce;
        overload;
        {-}
      function  pm_GetSorted: Boolean;
      procedure pm_SetSorted(aValue: Boolean);
        {-}
      function  IsEquals(aSource : TStrings): Boolean;
        {* - ���������� ������ � ������� � aStrings. }
      function  IndexOf(const aSt: string): Integer;
        overload;
        {-}
      function  IndexOf(const aSt: Tl3WString): Integer;
        overload;
      function  IndexOf(const aSt: Il3CString): Integer;
        overload;
        {-}
      function  AddObject(const aStr: string; anObject: TObject): Integer;
        overload;
      function  AddObject(const aStr: Il3CString; anObject: TObject): Integer;
        overload;
        {-}
    protected
    // internal methods
      class function IsCacheable: Boolean;
        override;
        {-}
    public
    // public methods
      class function Make: IvcmStrings;
        {-}
  end;//TvcmStringList

implementation

uses
  SysUtils

  {$IfDef vcmNeedL3}
  ,
  l3Base,
  l3SimpleMM,
  l3String,
  l3Interlocked
  {$EndIf vcmNeedL3}
  ;

{$Include l3Unknown.imp.pas}

// start class TvcmStringList

class function TvcmStringList.Make: IvcmStrings;
  {-}
var
 l_Strings : TvcmStringList;
begin
 l_Strings := Create;
 try
  Result := l_Strings;
 finally
  vcmFree(l_Strings);
 end;//try..finally
end;

{$IfNDef vcmNeedL3}
function TvcmStringList.CheckStamp(const aGUID: TGUID): Boolean;
  {-}
begin
 Result := false;
end;
{$EndIf  vcmNeedL3}

function TvcmStringList.pm_GetSorted: Boolean;
  {* - ������������� ������. }
begin
 Result := Sorted;
end;

procedure TvcmStringList.pm_SetSorted(aValue: Boolean);
  {* - ������������� ������. }
begin
 Sorted := aValue;
end;

function TvcmStringList.Get_Items: TStrings;
  {-}
begin
 Result := Self;
end;

procedure TvcmStringList.Set_Items(aValue: TStrings);
  {-}
begin
 Assign(aValue); 
end;

procedure TvcmStringList.Assign(const aStrings: IvcmStrings);
  //overload;
  {-}
begin
 if (aStrings = nil) then
  Clear
 else
  inherited Assign(aStrings.Items);
end;

procedure TvcmStringList.Assign(aStrings: TStrings);
  //overload;
  {-}
begin
 if (aStrings = nil) then
  Clear
 else
  inherited Assign(aStrings);
end;

function TvcmStringList.EQ(const aStrings: IvcmStrings): Boolean;
  {-}
begin
 if (aStrings = nil) then
  Result := false
 else
  Result := IsEquals(aStrings.Items);
end;

function TvcmStringList.GetW(anIndex: Integer): Tl3WString;
  {-}
var
 l_S : String;
begin
 l_S := Get(anIndex);
 {$IfDef vcmNeedL3}
 Result := lPCharLen(l_S);
 {$Else  vcmNeedL3}
 Result.S := PChar(l_S);
 Result.SLen := Length(l_S);
 Result.SCodePage := CP_ANSI;
 {$EndIf vcmNeedL3}
end;

procedure TvcmStringList.PutW(anIndex: Integer; const aValue: Tl3WString);
  {-}
begin
 Put(anIndex, vcmStr(aValue));
end;

function TvcmStringList.Get_ItemC(anIndex: Integer): IvcmCString;
  {-}
begin
 Result := vcmCStr(Get(anIndex));
end;

procedure TvcmStringList.Set_ItemC(anIndex: Integer; const aValue: IvcmCString);
  {-}
begin
 Put(anIndex, vcmStr(aValue));
end;

function TvcmStringList.Add(const aStr: string): Integer;
  //overload;
  {-}
begin
 Result := inherited Add(aStr);
end;

function TvcmStringList.Add(const aStr: Il3CString): Integer;
  //reintroduce;
  //overload;
  {-}
begin
 if (aStr = nil) then
  Result := Add('')
 else
  Result := Add(aStr.AsWStr);
end;

procedure TvcmStringList.Insert(aIndex: Integer; const aStr: Il3CString);
  //reintroduce;
  //overload;
begin
 inherited Insert(aIndex, vcmStr(aStr));
end;

procedure TvcmStringList.Insert(aIndex: Integer; const aStr: string);
  //reintroduce;
  //overload;
  {-}
begin
 Insert(aIndex, aStr);
end;

function TvcmStringList.Add(const aStr: Tl3PCharLenPrim): Integer;
  //overload;
  {-}
begin
 Result := Add(vcmStr(aStr));
end;

function TvcmStringList.IsEquals(aSource : TStrings): Boolean;
var
 lIndex : Integer;
begin
 // ���������� ����������
 Result := Count = aSource.Count;
 // �������
 if Result then
  for lIndex := 0 to Pred(Count) do
   // ����� �� ����������
   if (Strings[lIndex] <> aSource[lIndex]) or
     (Objects[lIndex] <> aSource.Objects[lIndex]) then
   begin
    Result := false;
    break;
   end;//Strings[lIndex] <> aSource[lIndex]
end;

function TvcmStringList.IndexOf(const aSt: string): Integer;
  //overload;
  {-}
begin
 Result := inherited IndexOf(aSt);
end;

function TvcmStringList.IndexOf(const aSt: Tl3WString): Integer;
  //overload;
  {-}
begin
 Result := IndexOf(vcmStr(aSt));
end;

function TvcmStringList.IndexOf(const aSt: Il3CString): Integer;
  //overload;
  {-}
begin
 Result := IndexOf(vcmStr(aSt));
end;

function TvcmStringList.AddObject(const aStr: string; anObject: TObject): Integer;
  //overload;
  {-}
begin
 Result := inherited AddObject(aStr, anObject);
end;

function TvcmStringList.AddObject(const aStr: Il3CString; anObject: TObject): Integer;
  //overload;
  {-}
begin
 Result := AddObject(vcmStr(aStr), anObject);
end;

class function TvcmStringList.IsCacheable: Boolean;
  //override;
  {-}
begin
 Result := true;
end;
{$EndIf vcmNeedL3}

end.

