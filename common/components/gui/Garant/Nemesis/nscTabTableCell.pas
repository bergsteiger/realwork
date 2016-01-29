unit nscTabTableCell;
{* ������� �������� ������. }

// ���������� : ���������� ������� �������
// �����      : ������� �.�.
// ������     : nscTabTableCell - ������ ������� �������� ������.
// �����      : 27.03.2007
// ������     : $Id: nscTabTableCell.pas,v 1.9 2013/12/25 15:10:31 lulin Exp $

(*-------------------------------------------------------------------------------
  $Log: nscTabTableCell.pas,v $
  Revision 1.9  2013/12/25 15:10:31  lulin
  {RequestLink:509706011}
  - ����������� ������.

  Revision 1.8  2013/02/06 16:22:20  kostitsin
  [$425044804] - TnscHideField

  Revision 1.7  2011/01/17 19:34:53  lulin
  {RequestLink:248195582}.
  - ������� ��������-style.

  Revision 1.6  2011/01/17 19:28:54  lulin
  {RequestLink:248195582}.
  - � ������� ����������� ������� ������� ���������� � ��.

  Revision 1.5  2007/11/02 12:23:22  mmorozov
  - new: ��� ����������� ����� ��������� ������� �������� ������ ��������� �� ���������� ����� ������ � ������� �� �������� ���������, � ���������� ������ (� ������ ������ ��� CQ: OIT5-27189) + ������������� �����������;

  Revision 1.4  2007/10/30 12:36:29  mmorozov
  � ������ ������ ��� CQ: OIT5-27189:
  - TvtHideField ������ ��������� � ������� �����;
  - ���������� TvtHideField � ��������� ����� � ����������;
  - ���������� TvtHideField � ������� �������� ������;

  Revision 1.3  2007/10/16 11:25:52  mmorozov
  - bugfix: ������� ����� ������ ������������, ��������� ��������� �������� ���������� (CQ: OIT5-27079);

  Revision 1.2  2007/10/13 13:31:55  mmorozov
  - bugfix: ��� ����� ������� ������� ��������, ��� ���������� � (� ������ ������ CQ: OIT5-26997);

  Revision 1.1  2007/03/28 11:02:54  mmorozov
  - "������� �������� ������" ���������� � ���������� ���������� ����������� ������� �������;

-------------------------------------------------------------------------------*)

interface

uses
  Controls,
  Windows,

  l3Base,
  l3Types,
  l3ProtoObject,

  eeTreeView,

  vtLister,
  vtHideField,

  nscInterfaces
  ;

type
  TnscTabCell = class(Tl3ProtoObject, InscTabTableCell)
  {* ������� ���������� ������. }
  private
  // fields
    f_OnProcessKey : TnscOnProcessKey;
    f_Control      : TWinControl;
  protected
  // methods
    function DoNeedProcessCommand(const aOperation: Tl3OperationCode): Boolean;
      {-}
  protected
  // InscTabTableCell
   // private methods
      function pm_GetBounds: TRect;
        {* - ������� ������ � ����������� ������. }
     function pm_GetCurrent: Integer;
       virtual;
       abstract;
       {-}
     procedure pm_SetCurrent(const aValue : Integer);
       virtual;
       abstract;
       {-}
     function pm_GetCount : Integer;
       virtual;
       abstract;
       {-}
     function pm_GetControl : TWinControl;
       {-}
     function pm_GetOnProcessKey : TnscOnProcessKey;
       {-}
     procedure pm_SetOnProcessKey(const aValue : TnscOnProcessKey);
       {-}
   // public methods
     procedure SetFocus(const aFromNext: Boolean = True);
       virtual;
       {* - ���������� �����, ������� ��� � ���������� ��������. ��� ����� ���
            ��������� �� ������\��������� ������� ��������. }
  protected
  // properties
    property OnProcessKey: TnscOnProcessKey
      read f_OnProcessKey;
      {-}
    property Control: TWinControl
      read f_Control;
      {-}
  public
  // methods
    constructor Create(const aControl: TWinControl);
      reintroduce;
      virtual;
      {-}
    class function Make(const aControl : TWinControl) : InscTabTableCell;
      {-}
  end;//TnscTabCell

  TnscTreeViewTabCell = class(TnscTabCell, InscTabTableCell)
  {* - ������� ��� ������ � ����������� TeeTreeView. }
  private
  // internal methods
    function OnNeedProcessCommand(aSender    : TObject;
                                       aOperation : Tl3OperationCode) : Boolean;
    function pm_GetTreeView: TeeTreeView;
      {* - ���������� ������ �� ��������� ������������ �������. }
  protected
  // InscTabTableCell
    function pm_GetCurrent : Integer;
      override;
      {-}
    procedure pm_SetCurrent(const aValue : Integer);
      override;
      {-}
    function pm_GetCount : Integer;
      override;
      {-}
    procedure SetFocus(const aFromNext: Boolean = True);
      override;
      {* - ���������� �����, ������� ��� � ���������� ��������. ��� ����� ���
           ��������� �� ������ ��������� ������� ��������. }
  protected
  // properties
    property TreeView: TeeTreeView
      read pm_GetTreeView;
      {-}
  public
  // public methods
    constructor Create(const aControl : TWinControl);
      override;
      {-}
    class function Make(const aControl : TeeTreeView) : InscTabTableCell;
      {-}
  end;//TnscTreeViewTabCell

  TnscListerTabCell = class(TnscTabCell, InscTabTableCell)
  {* - ������� ��� ������ � ����������� TvtCustomLister. }
  private
  // internal methods
    function OnNeedProcessCommand(aSender    : TObject;
                                  aOperation : Tl3OperationCode) : Boolean;
      {-}
  private
  // InscTabTableCell
    function pm_GetCurrent : Integer;
      override;
      {-}
    procedure pm_SetCurrent(const aValue : Integer);
      override;
      {-}
    function pm_GetCount : Integer;
      override;
      {-}
    procedure SetFocus(const aFromNext: Boolean = True);
      override;
      {* - ���������� �����, ������� ��� � ���������� ��������. ��� ����� ���
           ��������� �� ������ ��������� ������� ��������. }
  private
  // property methods
    function pm_GetLister : TvtLister;
      {-}
  protected
  // methods
    property Lister: TvtLister
      read pm_GetLister;
      {-}
  public
  // public methods
    constructor Create(const aControl : TWinControl);
      reintroduce;
      virtual;
      {-}
    class function Make(const aControl : TWinControl) : InscTabTableCell;
      {-}
  end;//TnscListerTabCell

  TnscHideFieldTabCell = class(TnscTabCell, InscTabTableCell)
  {* ������� ��� ������ � ����������� TvtHideField. }
  private
  // fields
    f_HideField: TvtHideField;
  private
  // methods
    function pm_GetHideField : TvtHideField;
      {-}
  private
  // events
    function OnNeedProcessCommand(aSender    : TObject;
                                  aOperation : Tl3OperationCode): Boolean;
      {* ������� ���������� �������. }
  protected
  // InscTabTableCell
   // private methods
     function pm_GetCurrent : Integer;
       override;
       {-}
     procedure pm_SetCurrent(const aValue : Integer);
       override;
       {-}
     function pm_GetCount : Integer;
       override;
       {-}
  protected
  // property
    property HideField: TvtHideField
      read pm_GetHideField;
      {-}
  public
  // methods
    constructor Create(const aControl: TWinControl);
      override;
      {-}
    class function Make(const aControl: TWinControl): InscTabTableCell;
      {-}
  end;//TnscHideFieldTabCell

implementation

uses
  SysUtils,
  Types,

  OvcConst
  ;

function nscMakeKey(aOperation : Tl3OperationCode) : TnscTabTableKey;
begin
 Result := ns_kNone;
 case aOperation of
  ccUp    : Result := ns_kUp;
  ccDown  : Result := ns_kDown;
  ccLeft  : Result := ns_kLeft;
  ccRight : Result := ns_kRight;
 end;//case aOperation of
end;//nscMakeKey

function nscNeedChangeControl(aKey        : TnscTabTableKey;
                              const aItem : InscTabTableCell) : Boolean;
{* - ���������� ����� �� ������� �� ��������� ���������, ������� ������
     ����������� � ����� ������ ���������� ���������� �� ������ �� �� ���. }
begin
 Result := aKey <> ns_kNone;
 case aKey of
  ns_kUp:
   Result := aItem.Current = 0;
  ns_kDown:
   Result := aItem.Current >= Pred(aItem.Count);
 end;//case aKey of
end;//nscNeedChangeControl

{ TnscTreeViewTabCell }

procedure TnscTreeViewTabCell.SetFocus(const aFromNext: Boolean = True);
{* - ���������� �����, ������� ��� � ���������� ��������. ��� ����� ���
     ��������� �� ������ ��������� ������� ��������. }

  procedure lp_SetCurrent;
  var
   l_Current: Integer;
  begin
   with TreeView, TreeStruct do
   if CountView > 0 then
   begin
    if aFromNext then
     l_Current := Pred(CountView)
    else
     l_Current := 0;
    Current := l_Current;
   end;//if CountView > 0 then
  end;//lp_SetCurrent

begin
 inherited;
 lp_SetCurrent;
end;//SetFocus

class function TnscTreeViewTabCell.Make(const aControl : TeeTreeView) : InscTabTableCell;
{-}
var
 l_Temp : TnscTreeViewTabCell;
begin
 l_Temp := Create(aControl);
 try
  Result := l_Temp;
 finally
  FreeAndNil(l_Temp);
 end;
end;

constructor TnscTreeViewTabCell.Create(const aControl : TWinControl);
// reintroduce;
// virtual;
  {-}
begin
 inherited Create(aControl);
 Assert(aControl is TeeTreeView);
 TreeView.OnIsCommandProcessed := OnNeedProcessCommand;
end;//Create

function TnscTreeViewTabCell.OnNeedProcessCommand(aSender    : TObject;
                                                       aOperation : Tl3OperationCode) : Boolean;
  {-}
begin
 Result := DoNeedProcessCommand(aOperation);
end;//OnNeedProcessCommand

function TnscTreeViewTabCell.pm_GetCurrent : Integer;
  {-}
begin
 Result := TreeView.Current;
end;

procedure TnscTreeViewTabCell.pm_SetCurrent(const aValue : Integer);
  {-}
begin
 TreeView.Current := aValue;
end;

function TnscTreeViewTabCell.pm_GetCount : Integer;
  {-}
begin
 Result := 0;
 if Assigned(TreeView.TreeStruct) then
  Result := TreeView.TreeStruct.CountView;
end;

function TnscTreeViewTabCell.pm_GetTreeView: TeeTreeView;
begin
 Result := TeeTreeView(Control);
end;//pm_GetTreeView

{ TnscListerTabCell }

procedure TnscListerTabCell.SetFocus(const aFromNext: Boolean = True);
{* - ���������� �����, ������� ��� � ���������� ��������. ��� ����� ���
     ��������� �� ������ ��������� ������� ��������. }

 procedure lp_SetCurrent;
 var
  l_Current: Integer;
 begin
  with Lister do
   if Total > 0 then
   begin
    if aFromNext then
     l_Current := Pred(Total)
    else
     l_Current := 0;
    Current := l_Current;
   end;//if Total > 0 then
 end;//lp_SetCurrent

begin
 inherited;
 lp_SetCurrent;
end;//SetFocus

class function TnscListerTabCell.Make(const aControl : TWinControl) : InscTabTableCell;
{-}
var
 l_Temp : TnscListerTabCell;
begin
 l_Temp := TnscListerTabCell.Create(aControl);
 try
  Result := l_Temp;
 finally
  FreeAndNil(l_Temp);
 end;//try.finally
end;//Make

constructor TnscListerTabCell.Create(const aControl : TWinControl);
// reintroduce;
// virtual;
{-}
begin
 inherited Create(aControl);
 Assert(aControl is TvtCustomLister);
 Lister.OnIsCommandProcessed := OnNeedProcessCommand;
end;//Create

function TnscListerTabCell.OnNeedProcessCommand(aSender    : TObject;
                                                     aOperation : Tl3OperationCode) : Boolean;
{-}
begin
 Result := DoNeedProcessCommand(aOperation);
end;//OnNeedProcessCommand

function TnscListerTabCell.pm_GetCurrent : Integer;
  {-}
begin
 Result := Lister.Current;
end;

procedure TnscListerTabCell.pm_SetCurrent(const aValue : Integer);
  {-}
begin
 Lister.Current := aValue;
end;

function TnscListerTabCell.pm_GetCount : Integer;
  {-}
begin
 Result := Lister.Total;
end;

function TnscListerTabCell.pm_GetLister: TvtLister;
begin
 Result := TvtLister(Control);
end;

{ TnscHideFieldTabCell }

constructor TnscHideFieldTabCell.Create(const aControl: TWinControl);
begin
 inherited Create(aControl);
 Assert(aControl is TvtHideField);
 HideField.OnNeedProcessCommand := OnNeedProcessCommand;
end;//Create

class function TnscHideFieldTabCell.Make(const aControl: TWinControl): InscTabTableCell;
var
 l_Class: TnscHideFieldTabCell;
begin
 l_Class := Create(aControl);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

function TnscHideFieldTabCell.pm_GetHideField: TvtHideField;
begin
 Result := TvtHideField(Control);
end;//pm_GetHideField

function TnscHideFieldTabCell.pm_GetCount: Integer;
begin
 Result := 0;
end;

function TnscHideFieldTabCell.OnNeedProcessCommand(aSender    : TObject;
                                                   aOperation : Tl3OperationCode): Boolean;
      {* ������� ���������� �������. }
begin
 Result := DoNeedProcessCommand(aOperation);
end;//OnNeedProcessCommand

function TnscHideFieldTabCell.pm_GetCurrent: Integer;
begin
 Result := 0;
end;

procedure TnscHideFieldTabCell.pm_SetCurrent(const aValue: Integer);
begin

end;

{ TnscTabCell }

constructor TnscTabCell.Create(const aControl: TWinControl);
begin
 inherited Create;
 Assert(aControl <> nil);
 f_Control := aControl;
end;//Create

class function TnscTabCell.Make(const aControl : TWinControl) : InscTabTableCell;
{-}
var
 l_Temp : TnscTabCell;
begin
 l_Temp := Create(aControl);
 try
  Result := l_Temp;
 finally
  FreeAndNil(l_Temp);
 end;
end;

function TnscTabCell.DoNeedProcessCommand(const aOperation: Tl3OperationCode): Boolean;
var
 l_Key : TnscTabTableKey;
begin
 l_Key := nscMakeKey(aOperation);
 if nscNeedChangeControl(l_Key, Self) then
 begin
  Result := False;
  if Assigned(OnProcessKey) then
   OnProcessKey(l_Key);
 end//if nscNeedChangeControl(l_Key, Self) then
 else
  Result := True;
end;//DoNeedProcessCommand

function TnscTabCell.pm_GetBounds: TRect;
  {* - ������� ������ � ����������� ������. }
begin
 Windows.GetWindowRect(Control.Handle, Result);
end;//pm_GetTop

function TnscTabCell.pm_GetControl: TWinControl;
begin
 Result := f_Control;
end;//pm_GetControl

function TnscTabCell.pm_GetOnProcessKey: TnscOnProcessKey;
begin
 Result := f_OnProcessKey;
end;//pm_GetOnProcessKey

procedure TnscTabCell.pm_SetOnProcessKey(const aValue: TnscOnProcessKey);
begin
 f_OnProcessKey := aValue;
end;//pm_SetOnProcessKey

procedure TnscTabCell.SetFocus(const aFromNext: Boolean = True);
begin
 Control.SetFocus;
end;//SetFocus

end.
