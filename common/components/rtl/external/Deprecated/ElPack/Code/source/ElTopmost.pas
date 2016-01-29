{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

(*

Version History

12/08/2002

  Moved funtionality from TElFormPersist

*)

{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

unit ElTopmost;

interface

uses
  Classes,
  SysUtils,
  Windows,
  Messages,
  Graphics,
  Controls,
  Forms,
  Menus,
  StdCtrls,
  ExtCtrls,
{$ifdef VCL_6_USED}
  Types,
{$endif}
  ElHook,
  ElVCLUtils,
  ElTools;

type

  TElTopmost = class(TComponent)
  private
    FTopMost : Boolean;
    FHook : TElHook;
    procedure OnHook(Sender : TObject; var Msg : TMessage; var Handled : boolean);
    procedure OnAfterHook(Sender : TObject; var Msg : TMessage; var Handled : boolean);
    procedure SetTopMost(newValue : Boolean);
    procedure UpdateTopmost;
  protected
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    procedure Loaded; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published
    property TopMost : Boolean read FTopMost write SetTopMost;
  end;

implementation

uses ElList;

var  FormPersList : TElList;

type THackForm = class(TCustomForm)
     end;

procedure TElTopmost.OnAfterHook(Sender : TObject; var Msg : TMessage; var Handled : boolean);
var
  Form : TForm;
  i : DWORD;
begin
  if Msg.Msg = WM_ACTIVATEAPP then
  begin
    if Msg.WParam = 0 then
    begin
      if FTopMost then
      begin
        Form := GetOwnerForm(Self);
        if (Form <> nil) and Form.Visible then
          SetWindowPos(Form.Handle, hwnd_TopMost, 0, 0, 0, 0, swp_NoMove + swp_NoSize + swp_NoActivate);
      end;
    end;
  end;
  if Msg.Msg = CM_DEACTIVATE then
  begin
    if FTopMost then
    begin
      Form := GetOwnerForm(Self);
      if (Form <> nil) and Form.Visible then
      begin
        SetWindowPos(Form.Handle, hwnd_TopMost, 0, 0, 0, 0, swp_NoMove + swp_NoSize + swp_NoActivate);
      end;
    end;
  end;
  if Msg.Msg = WM_CREATE then
  begin
    if TopMost then
    begin
      Form := GetOwnerForm(Self);
      if (Form <> nil) then
      begin
        i := GetWindowLong(Form.Handle, GWL_EXSTYLE);
        i := i or WS_EX_TOPMOST;
        SetWindowLong(Form.Handle, GWL_EXSTYLE, i);
        SetWindowPos(Form.Handle, hwnd_TopMost, 0, 0, 0, 0, swp_NoMove + swp_NoSize + swp_NoActivate);
      end;
    end;
  end;
  if Msg.Msg = WM_SHOWWINDOW then
  begin
    if Msg.WParam <> 0 then
    begin
      if Topmost then
      begin
        FTopmost := false;
        TopMost := true;
      end;
    end;
  end;
end;

procedure TElTopmost.OnHook(Sender : TObject; var Msg : TMessage; var Handled : boolean);
begin
  if (Msg.Msg = WM_CREATE) then
  begin
    if Topmost then
    begin
      FTopmost := false;
      Topmost := true;
    end;
  end;
end;

procedure TElTopmost.Notification(AComponent : TComponent; Operation : TOperation);
var Form : THackForm;
begin
  Form := THackForm(GetOwnerForm(Self));
  if (AComponent = Form) then
  begin
    {$ifdef VCL_5_USED}
    if not (csDestroying in Form.ComponentState) then
      Form.RemoveFreeNotification(Self);
    {$endif}
  end;
  inherited;
end;

procedure TElTopmost.SetTopMost(newValue : Boolean);
var
  Form : TForm;
  i    : integer;
begin
  if (FTopMost <> newValue) then
  begin
    FTopMost := newValue;
    if (not (csDesigning in ComponentState)) then
    begin
      Form := GetOwnerForm(Self);
      if (Form <> nil) and (Form.HandleAllocated) then
      begin
        i := GetWindowLong(Form.Handle, GWL_EXSTYLE);
        if TopMost then
           i := i or WS_EX_TOPMOST
        else
           i := i and not WS_EX_TOPMOST;

        SetWindowLong(Form.Handle, GWL_EXSTYLE, i);
        if FTopMost then
          SetWindowPos(Form.Handle, hwnd_TopMost, 0, 0, 0, 0, swp_NoMove + swp_NoSize + swp_NoActivate)
        else
          SetWindowPos(Form.Handle, hwnd_NoTopMost, 0, 0, 0, 0, swp_NoMove + swp_NoSize + swp_NoActivate);
      end;
    end;
  end; {if}
end; {SetTopMost}

procedure TElTopmost.Loaded;
begin
  inherited;
  if Topmost then
  begin
    FTopmost := false;
    Topmost := true;
  end;
end; {Loaded}

destructor TElTopmost.Destroy;
begin
  if FormPersList <> nil then
     FormPersList.Remove(Self);
  FHook.Free;
  inherited Destroy;
end;

procedure TElTopmost.UpdateTopmost;
var
  Form : TForm;
begin
  if (not (csDesigning in ComponentState)) then
  begin
    Form := GetOwnerForm(Self);
    if (Form <> nil) and (Form.HandleAllocated) and (not (csDesigning in Form.ComponentState)) and Form.Visible then
    begin
      if FTopMost then
        SetWindowPos(Form.Handle, hwnd_TopMost, 0, 0, 0, 0, swp_NoMove + swp_NoSize + swp_NoActivate);
    end;
  end;
end;

constructor TElTopmost.Create(AOwner : TComponent);
var
  Form : THackForm;
begin
  FHook := TElHook.Create(nil);
  Form := THackForm(GetOwnerForm(AOwner));
  if Assigned(Form) then
     Form.FreeNotification(Self);
  inherited Create(AOwner);
  FHook.Control := Form;
  FHook.OnBeforeProcess := OnHook;
  FHook.OnAfterProcess := OnAfterHook;
  if not (csDesigning in ComponentState) then
     FHook.Active := True;
  if FormPersList <> nil then
     FormPersList.Add(Self);
end;

function TopWndProc(This : TObject; var Message: TMessage): boolean;
var i : integer;
    iVisible: Integer;
    Own: TComponent;
begin
  if (Message.Msg = WM_ACTIVATEAPP) and (Message.wParam = 0) then
  begin
    PostMessage(Application.Handle, CM_DEACTIVATE, 0, 0);
    if FormPersList.Count > 0 then
    begin
      iVisible := 0;
      for i := 0 to FormPersList.Count - 1 do
      begin
        Own := TElTopmost(FormPersList[i]).Owner;
        if (Own is TCustomForm) then
        begin
          if (Own as TCustomForm).Visible = True then
            Inc(iVisible);
        end;
      end;
      if iVisible > 0 then
      begin
        if FormPersList <> nil then
        begin
          for i := 0 to FormPersList.Count - 1 do
          begin
            Own := TElTopmost(FormPersList[i]).Owner;
            if (Own is TCustomForm) then
            begin
              if (Own as TCustomForm).Visible = True then
                TElTopmost(FormPersList[i]).UpdateTopMost;
            end;
          end;
        end;
        Message.Msg := WM_NULL;
      end;
    end;
  end;
  result := false;
end;

var HookMethod : TMethod;

initialization
  {$IfNDef Nemesis}
  HookMethod.Code := @TopWndProc;
  HookMethod.Data := nil;
  Application.HookMainWindow(TWindowHook(HookMethod));
  FormPersList := TElList.Create;
  {$EndIf Nemesis}

finalization
  {$IfNDef Nemesis}
  Application.UnhookMainWindow(TWindowHook(HookMethod));
  FormPersList.Free;
  FormPersList := nil;
  {$EndIf Nemesis}


end.
