unit nsProfilers;

{------------------------------------------------------------------------------}
{ ���������� : ������ ���� ������� "�������";                                  }
{ �����      : ������� �.�.;                                                   }
{ �����      : 05.07.2006;                                                     }
{ ������     : nsProfilers                                                     }
{ ��������   : ������ �������� ���������� ����������� ��������;                }
{------------------------------------------------------------------------------}

// $Id: nsProfilers.pas,v 1.10 2009/02/10 13:34:39 lulin Exp $
// $Log: nsProfilers.pas,v $
// Revision 1.10  2009/02/10 13:34:39  lulin
// - <K>: 133891247. �������� ���������� �����������.
//
// Revision 1.9  2007/10/09 12:31:03  mmorozov
// - new behaviour: � ������� �������� ���������� ���������, ��� �������� � ���������� ����� �������� ����� ��� (CQ: OIT5-26941);
//
// Revision 1.8  2006/07/31 15:04:20  mmorozov
// - new: ��������� �������� ��������� ���� (CQ: OIT500021555);
//
// Revision 1.7  2006/07/28 14:24:54  mmorozov
// - change: const names;
//
// Revision 1.6  2006/07/27 13:39:22  mmorozov
// - new: ������ �������� ������ ����� ������ (CQ: OIT500021557);
// - rename: ���������� �����������, �������� ������, ���������;
//
// Revision 1.5  2006/07/27 11:20:59  mmorozov
// - new: ������ ������� �������� �������� ������� (CQ: OIT500021553);
//
// Revision 1.4  2006/07/20 08:25:50  mmorozov
// - new: ���������� ��������� ���������� � ������� �������� ��������� (� ������ ������ ��� CQ: OIT500021533);
//
// Revision 1.3  2006/07/19 17:58:20  mmorozov
// - new: ������ �������� ��������� - ��������� ��������� ����� ��������� ������, ������ ����� ��������;
//
// Revision 1.2  2006/07/06 06:56:34  mmorozov
// - new: ������� ��������� �����������;
//
// Revision 1.1  2006/07/05 07:51:24  mmorozov
// - new: ���������� �����������;
//

interface

{$Include nsDefine.inc}

{$IfDef vcmUseProfilers}
uses
  vcmBase,

  ProfilersInterfaces
  ;

type
  TnsProfiler = class(TvcmBase, InsProfiler)
  protected
  // InsProfiler
    procedure Start;
      virtual;
      {* - ������ �����, ���������� ����� ��������� ������. }
    procedure Finish;
      {* - ��������� ���������. }
  protected
  // methods
    function Id: Integer;
      virtual;
      abstract;
      {* - ������������� ����������. }
    function UseCaseName: String;
      virtual;
      abstract;
      {* - �������� ����������. }
    function FinishCount: Integer;
      virtual;
      abstract;
      {* - ���������� Finish ��� ��������� ���������. }
  public
  // methods
    class function Make: InsProfiler;
      {-}
  end;

  TprMainMenu = class(TnsProfiler, IprMainMenu)
  {* �������� ��������� ����. }
  protected
  // methods
    function Id: Integer;
      override;
      {* - ������������� ����������. }
    function UseCaseName: String;
      override;
      {* - �������� ����������. }
    function FinishCount: Integer;
      override;
      {* - ���������� Finish ��� ��������� ���������. }
  end;

  TprDocument = class(TnsProfiler, IprDocument)
  private
  // fields
    f_DocumentReceived   : Boolean;
    f_ContentsTreeOpened : Boolean;
  private
  // IprDocument
    procedure FormSetCreated;
      {* - ������ �������. }
    procedure DocumentReceived;
      {* - �������� ������� � ��������. }
    procedure DocumentPainted;
      {* - �������� ���������. }
    procedure ContentsTreeOpened;
      {* - ������� ��������� ���������. }
  protected
  // methods
    procedure Start;
      override;
      {* - ������ �����, ���������� ����� ��������� ������. }
    function Id: Integer;
      override;
      {* - ������������� ����������. }
    function FinishCount: Integer;
      override;
      {* - ���������� Finish ��� ��������� ���������. }
    function UseCaseName: String;
      override;
      {* - �������� ����������. }
  end;//TprDocument

  TprQueryCard = class(TnsProfiler, IprQueryCard)
  {* ������������ ��� ������� �������� �������� ��������. }
  protected
  // methods
    function Id: Integer;
      override;
      {* - ������������� ����������. }
    function UseCaseName: String;
      override;
      {* - �������� ����������. }
    function FinishCount: Integer;
      override;
      {* - ���������� Finish ��� ��������� ���������. }
  end;

  TprListAfterSearch = class(TnsProfiler, IprListAfterSearch)
  {* �������� ������ ����� ������. }
  protected
  // methods
    function Id: Integer;
      override;
      {* - ������������� ����������. }
    function UseCaseName: String;
      override;
      {* - �������� ����������. }
    function FinishCount: Integer;
      override;
      {* - ���������� Finish ��� ��������� ���������. }
  end;

  TnsProfilersManager = class(TvcmBase, InsProfilersManager)
  private
  // fields
    f_Document        : IprDocument;
    f_QueryCard       : IprQueryCard;
    f_ListAfterSearch : IprListAfterSearch;
    f_MainMenu        : IprMainMenu;
  private
  // InsProfilerManager
    function pm_GetDocument: IprDocument;
      {* - ��������� ���������. }
    function pm_GetQueryCard: IprQueryCard;
      {* - ��������� �������� �������. }
    function pm_GetListAfterSearch: IprListAfterSearch;
      {* - �������� ��������� ����� ������. }
    function pm_GetMainMenu: IprMainMenu;
      {* - �������� ��������� ����. }
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  public
  // methods
    class function Make: InsProfilersManager;
      {-}
  end;
{$EndIf vcmUseProfilers}

implementation

{$IfDef vcmUseProfilers}
uses
  SysUtils,

  vcmProfilersCollection,

  bsTypes,
  bsConst,

  DebugStr
  ;

const
  c_fcDocument = 4;
   // - ���������� Finish ���������� ��� ������ �������� ���������:
   //   - FormSetCreated;
   //   - DocumentReceived;
   //   - DocumentPainted;
   //   - ContentsTreeOpened;
  c_fcQueryCard = 1;
   // - ���������� Finish ��� �������� �������� �������;
  c_fcListAfterSearch = 1;
   // - ���������� Finish ��� �������� ������ ����� ������;
  c_fcMainMenu = 1;
   // - ���������� Finish ��� �������� ��������� ����;

{ TprDocument }

procedure TprDocument.Start;
  // override;
  {* - ������ �����, ���������� ����� ��������� ������. }
begin
 inherited;
 f_DocumentReceived := False;
 f_ContentsTreeOpened := False;
end;//Start

function TprDocument.Id: Integer;
  // override;
  {* - ������������� ����������. }
begin
 Result := Ord(ucpDocument);
end;

procedure TprDocument.ContentsTreeOpened;
  {* - ������� ��������� ���������. }
begin
 if not f_ContentsTreeOpened then
 begin
  Finish;
  f_ContentsTreeOpened := True;
 end;//if not f_ContentsTreeOpened then
end;//ContentsTreeOpened

procedure TprDocument.DocumentPainted;
  {* - �������� ���������. }
begin
 Finish;
end;

procedure TprDocument.DocumentReceived;
  {* - �������� ������� � ��������. }
begin
 if not f_DocumentReceived then
 begin
  Finish;
  f_DocumentReceived := True;
 end;//if not f_DocumentReceived then
end;//DocumentReceived

procedure TprDocument.FormSetCreated;
  {* - ������ �������. }
begin
 Finish;
end;

function TprDocument.FinishCount: Integer;
begin
 Result := c_fcDocument;
end;

function TprDocument.UseCaseName: String;
begin
 Result := c_prDocument;
end;

{ TnsProfiler }

procedure TnsProfiler.Start;
  {* - ������ �����, ���������� ����� ��������� ������. }
begin
 vcmProfilers.StartProfile(UseCaseName, Id, FinishCount);
end;

procedure TnsProfiler.Finish;
  {* - ��������� ���������. }
begin
 vcmProfilers.FinishProfile(Id);
end;

class function TnsProfiler.Make: InsProfiler;
var
 l_Class: TnsProfiler;
begin
 l_Class := Create;
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;
end;

{ TnsProfilersManager }

procedure TnsProfilersManager.Cleanup;
begin
 f_MainMenu := nil;
 f_QueryCard := nil;
 f_ListAfterSearch := nil;
 f_Document := nil;
 inherited;
end;

class function TnsProfilersManager.Make: InsProfilersManager;
var
 l_Class: TnsProfilersManager;
begin
 l_Class := TnsProfilersManager.Create;
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;
end;

function TnsProfilersManager.pm_GetMainMenu: IprMainMenu;
  {* - �������� ��������� ����. }
begin
 if not Assigned(f_MainMenu) then
  Supports(TprMainMenu.Make, IprMainMenu, f_MainMenu);
 Result := f_MainMenu;
end;

function TnsProfilersManager.pm_GetListAfterSearch: IprListAfterSearch;
  {* - �������� ��������� ����� ������. }
begin
 if not Assigned(f_ListAfterSearch) then
  Supports(TprListAfterSearch.Make, IprListAfterSearch, f_ListAfterSearch);
 Result := f_ListAfterSearch;
end;

function TnsProfilersManager.pm_GetQueryCard: IprQueryCard;
  {* - ��������� �������� �������. }
begin
 if not Assigned(f_QueryCard) then
  Supports(TprQueryCard.Make, IprQueryCard, f_QueryCard);
 Result := f_QueryCard;
end;

function TnsProfilersManager.pm_GetDocument: IprDocument;
  {* - ��������� ���������. }
begin
 if not Assigned(f_Document) then
  Supports(TprDocument.Make, IprDocument, f_Document);
 Result := f_Document;
end;

{ TprQueryCard }

function TprQueryCard.FinishCount: Integer;
  {* - ���������� Finish ��� ��������� ���������. }
begin
 Result := c_fcQueryCard;
end;

function TprQueryCard.Id: Integer;
  {* - ������������� ����������. }
begin
 Result := Ord(ucpQueryCard);
end;

function TprQueryCard.UseCaseName: String;
  {* - �������� ����������. }
begin
 Result := c_prQueryCard;
end;
{$EndIf vcmUseProfilers}

{ TprListAfterSearch }

function TprListAfterSearch.FinishCount: Integer;
begin
 Result := c_fcListAfterSearch;
end;

function TprListAfterSearch.Id: Integer;
begin
 Result := Ord(ucpOpenListAfterSearch);
end;

function TprListAfterSearch.UseCaseName: String;
begin
 Result := c_prListAfterSearch;
end;

{ TprMainMenu }

function TprMainMenu.FinishCount: Integer;
begin
 Result := c_fcMainMenu;
end;

function TprMainMenu.Id: Integer;
begin
 Result := Ord(ucpMainMenu);
end;

function TprMainMenu.UseCaseName: String;
begin
 Result := c_prMainMenu;
end;

end.