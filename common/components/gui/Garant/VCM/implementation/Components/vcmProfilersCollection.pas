unit vcmProfilersCollection;

{------------------------------------------------------------------------------}
{ ���������� : vcm;                                                            }
{ �����      : ������� �.�;                                                    }
{ �����      : 21.06.2006;                                                     }
{ ������     : vcmProfilersCollection                                                      }
{ ��������   : ������ �������� ���������� �������� ��� ������������ ������� �  }
{              ���������� vcm;                                                 }
{------------------------------------------------------------------------------}

// $Id: vcmProfilersCollection.pas,v 1.11 2013/04/05 12:02:37 lulin Exp $
// $Log: vcmProfilersCollection.pas,v $
// Revision 1.11  2013/04/05 12:02:37  lulin
// - ���������.
//
// Revision 1.10  2012/11/01 09:42:22  lulin
// - ����� ����� � �������.
//
// Revision 1.9  2012/11/01 07:44:07  lulin
// - ������ ����������� ����������� �������� �������� �������.
//
// Revision 1.8  2011/07/08 15:33:51  vkuprovich
// {RequestLink:271192867}
// ��������� TvcmProfiler �� ������, � �������� ���� ���� RTTI
//
// Revision 1.7  2011/05/19 12:21:15  lulin
// {RequestLink:266409354}.
//
// Revision 1.6  2009/10/01 15:08:23  lulin
// - ������ ����.
//
// Revision 1.5  2009/02/12 13:57:31  lulin
// - <K>: 135604584. ������� ����� ������������ ������.
//
// Revision 1.4  2006/12/29 13:09:23  lulin
// - ��������� ��������� ������������ ������ �����.
//
// Revision 1.3  2006/06/28 12:11:09  mmorozov
// - bugfix: ��� �������� ������� ������������� ������������ ���;
//
// Revision 1.2  2006/06/23 13:15:32  mmorozov
// - new behaviour: ���������� ��������� �� ������� ����������, �� ���  ������� ���������, ������ ��� ��������� ����� ���� ����� �� ������ ���������;
//
// Revision 1.1  2006/06/23 10:42:29  mmorozov
// - new: ���������� � ���������� VCM;
//

interface

uses
  Types,

  l3ProtoPersistent,
  l3ProtoPersistentRefList,

  vcmInterfaces,
  vcmProfilerInterfaces,
  vcmBase
  ;

type
  TvcmProfiler = class(Tl3ProtoPersistent, IvcmProfiler)
  private
  // internal fields
    f_AverageExecuteTime : Integer;
    f_Id                 : Integer;
    f_FinishCount        : Integer;
    f_FinishCalledCount  : Integer;
    f_DisplayName        : AnsiString;
    f_Results            : TvcmLongintList;
    f_StartTime          : DWORD;
  private
  // IvcmProfiler
    function pm_GetId: Integer;
      {* - ������������� ����������. }
    function pm_GetHasFinished: Boolean;
      {* - ���������� �������� �� ��������� ������. }
    function pm_GetExecuteTime: Integer;
      {* - ����� �������� ���������� (� ��������������). }
    function pm_GetExecuteCount: Integer;
      {* - ���������� �������� ����������. ��������� ���������� ����������
           ������� ������. }
    function pm_GetAverageExecuteTime: Integer;
      {* - ������� ����� �������� ����������. }
    function pm_GetDisplayName: AnsiString;
      {* - ������������ ��������. }
    procedure Init(const aDisplayName : AnsiString;
                   aFinishCount : Integer);
      {* - �������������� ���������. }
    procedure Start;
      {* - ������ �����. }
    procedure Finish;
      {* - ��������� �����. }
  private
  // property methods
    function pm_GetResults: TvcmLongintList;
      {* - ������ ����������� ������� ����������, ������ ������� �������� �����
           ExecuteTime. }
  protected
  // protected methods
    procedure Cleanup;
      override;
      {-}
  protected
  // protected methods
    property Results: TvcmLongintList
      read pm_GetResults;
      {* - ������ ����������� ������� ����������, ������ ������� �������� �����
           ExecuteTime. }
  public
  // public methods
    constructor Create(const anId         : Integer;
                       const aDisplayName : AnsiString = '';
                       const aFinishCount : Integer = 0);
      reintroduce;
      {-}
    class function Make(const anId         : Integer;
                        const aDisplayName : AnsiString = '';
                        const aFinishCount : Integer = 0): IvcmProfiler;
      {-}
  published
  // published properties
    property Id: Integer
      read pm_GetId;
      {* - ������������� ����������. }
    property HasFinished: Boolean
      read pm_GetHasFinished;
      {* - ���������� �������� �� ��������� ������. }
    property ExecuteTime: Integer
      read pm_GetExecuteTime;
      {* - ����� �������� ���������� (� ��������������). }
    property ExecuteCount: Integer
      read pm_GetExecuteCount;
      {* - ���������� �������� ����������. ��������� ���������� ����������
           ������� ������. }
    property AverageExecuteTime: Integer
      read pm_GetAverageExecuteTime;
      {* - ������� ����� �������� ����������. }
    property DisplayName: AnsiString
      read pm_GetDisplayName;
      {* - ������������ ��������. }
  end;

  TvcmProfilersCollection = class(Tl3ProtoPersistentRefList, IvcmProfilersCollection)
  private
  // internal methods
    function FindById(anId: Integer): IvcmProfiler;
      {* - ��� ����� ������������� ����������, ��� ����� ������ ���
           �������������. }
    function CreateProfier(const anId: Integer): TvcmProfiler;
      {-}
  public
  // public methods
    class function Make: IvcmProfilersCollection;
      {-}
  public
  // IvcmProfilersCollection
    procedure StartProfile(const aDisplayName : AnsiString;
                           anId         : Integer;
                           aFinishCount : Integer);
      {* - aFinishCount - ������������� ���������� ������� Finish ����� �������
                          ���������, ��� �������� ��������� � ��� ��������
                          HasFinished ����������� � True; }
    procedure FinishProfile(anId: Integer);
      {* - ��������� ������ ����������. }
  public
  // published methods
    function FindProfilerById(anId: Integer): TvcmProfiler;
      {-}
  end;

function vcmProfilers: TvcmProfilersCollection;

implementation

uses
  SysUtils,
  Windows
  ;

var
 g_Profilers: TvcmProfilersCollection;

function vcmProfilers: TvcmProfilersCollection;
begin
 if not Assigned(g_Profilers) then
  g_Profilers := TvcmProfilersCollection.Create;
 Result := g_Profilers;
end;

{ TvcmProfiles }

procedure TvcmProfilersCollection.StartProfile(const aDisplayName : AnsiString;
                                               anId         : Integer;
                                               aFinishCount : Integer);
  {* - aFinishCount - ������������� ���������� ������� Finish ����� �������
                      ���������, ��� �������� ��������� � ��� ��������
                      HasFinished ����������� � True; }
var
 l_Profiler: IvcmProfiler;
begin
 l_Profiler := FindById(anId);
 with l_Profiler do
 begin
  Init(aDisplayName, aFinishCount);
  Start;
 end;
end;

procedure TvcmProfilersCollection.FinishProfile(anId: Integer);
  {* - ��������� ������ ����������. }
begin
 FindById(anId).Finish;
end;

function TvcmProfilersCollection.CreateProfier(const anId: Integer): TvcmProfiler;
  {-}
var
 l_Temp: TvcmProfiler;
begin
 l_Temp := TvcmProfiler.Create(anId);
 try
  Add(l_Temp);
  Result := l_Temp;
 finally
  FreeAndNil(l_Temp);
 end;
end;

function TvcmProfilersCollection.FindById(anId: Integer): IvcmProfiler;
  {* - ��� ����� ������������� ����������, ��� ����� ������ ���
       �������������. }
begin
 Supports(FindProfilerById(anId), IvcmProfiler, Result);
end;

function TvcmProfilersCollection.FindProfilerById(anId: Integer): TvcmProfiler;
var
 l_Index: Integer;
begin
 Result := nil;
 for l_Index := 0 to Pred(Count) do
  if TvcmProfiler(Items[l_Index]).Id = anId then
  begin
   Result := TvcmProfiler(Items[l_Index]);
   Break
  end;
 if not Assigned(Result) then
  Result := CreateProfier(anId);
end;

class function TvcmProfilersCollection.Make: IvcmProfilersCollection;
var
 l_Class: TvcmProfilersCollection;
begin
 l_Class := Create;
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;
end;

{ TvcmProfiler }

constructor TvcmProfiler.Create(const anId         : Integer;
                                const aDisplayName : AnsiString = '';
                                const aFinishCount : Integer = 0);
  // reintroduce;
  {-}
begin
 inherited Create;
 f_DisplayName := aDisplayName;
 f_Id := anId;
 f_FinishCount := aFinishCount;
end;

class function TvcmProfiler.Make(const anId         : Integer;
                                 const aDisplayName : AnsiString = '';
                                 const aFinishCount : Integer = 0): IvcmProfiler;
  {-}
var
 l_Class: TvcmProfiler;
begin
 l_Class := Create(anId, aDisplayName, aFinishCount);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;
end;

function TvcmProfiler.pm_GetAverageExecuteTime: Integer;
  {* - ������� ����� �������� ����������. }
var
 l_Index: Integer;
begin
 // ������� �� ������� ����������:
 if (Results.Count > 0) and (f_AverageExecuteTime = 0) then
  for l_Index := 0 to Pred(Results.Count) do
   Inc(f_AverageExecuteTime, Results.Items[l_Index]);
 Result := f_AverageExecuteTime;
end;

function TvcmProfiler.pm_GetResults: TvcmLongintList;
  {* - ������ ����������� ������� ����������, ������ ������� �������� �����
       ExecuteTime. }
begin
 if not Assigned(f_Results) then
  f_Results := TvcmLongintList.Make;
 Result := f_Results;
end;

procedure TvcmProfiler.Init(const aDisplayName : AnsiString;
                            aFinishCount : Integer);
  {* - �������������� ���������. }
begin
 f_DisplayName := aDisplayName;
 f_FinishCount := aFinishCount;
end;

procedure TvcmProfiler.Start;
  {* - ������ �����. }
begin
 f_FinishCalledCount := 0;
 f_StartTime := GetTickCount;
end;

procedure TvcmProfiler.Finish;
  {* - ��������� �����. }
begin
 // ��������� �� ��� �������:
 if f_StartTime = 0 then
  Exit;
 Inc(f_FinishCalledCount);
 // ��� finish ������� ����� �������:
 if pm_GetHasFinished then
 begin
  f_AverageExecuteTime := 0;
  Results.Add(GetTickCount - f_StartTime);
  f_StartTime := 0;
 end;
end;

function TvcmProfiler.pm_GetDisplayName: AnsiString;
  {* - ������������ ��������. }
begin
 Result := f_DisplayName;
end;

function TvcmProfiler.pm_GetExecuteCount: Integer;
  {* - ���������� �������� ����������. ��������� ���������� ����������
       ������� ������; }
begin
 Result := Results.Count;
end;

function TvcmProfiler.pm_GetExecuteTime: Integer;
  {* - ����� �������� ���������� (� ��������������). }
begin
 Result := 0;
 if Results.Count > 0 then
  Result := Results.Items[Pred(Results.Count)];
end;

function TvcmProfiler.pm_GetId: Integer;
  {* - ������������� ����������. }
begin
 Result := f_Id;
end;

function TvcmProfiler.pm_GetHasFinished: Boolean;
  {* - ���������� �������� �� ��������� ������. }
begin
 Result := f_FinishCalledCount = f_FinishCount;
end;

procedure TvcmProfiler.Cleanup;
begin
 FreeAndNil(f_Results);
 inherited;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VCM\implementation\Components\vcmProfilersCollection.pas initialization enter'); {$EndIf}

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VCM\implementation\Components\vcmProfilersCollection.pas initialization leave'); {$EndIf}
finalization

FreeAndNil(g_Profilers);

end.

