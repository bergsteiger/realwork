unit vcmPopupMenuPrim;

interface

uses
  Messages,
  
  Classes,
  Menus
  ;

type
  _l3Unknown_Parent_ = TPopupMenu;
  {$Define _UnknownIsBaseComponent}
  {$Include l3Unknown.imp.pas}
  TvcmPopupMenuPrim = class(_l3Unknown_)
    private
    // internal fields
      f_OldWndProc: Pointer;
    protected
      procedure SubstWndProc(var Msg: TMessage); virtual;
        {-}
      class function IsCacheable: Boolean;
        override;
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(AOwner: TComponent);
        override;
        {-}
      procedure Popup(X, Y: Integer);
        override;
        {-}
  end;//TvcmPopupMenuPrim

implementation

uses
  Windows,

  SysUtils,
  
  Forms,

  l3Interfaces,
  l3Base,
  l3Interlocked,

  vcmExternalInterfaces,
  vcmAction,
  vcmUtils,
  vcmMenuManager,
  vcmMenus
  ;

{$Include l3Unknown.imp.pas}
  
// start class TvcmPopupMenuPrim

constructor TvcmPopupMenuPrim.Create(AOwner: TComponent);
  //override;
begin
 inherited Create(aOwner);
 AutoHotkeys := maManual;
 {$IfDef Nemesis}
 Images := //vcmAction.vcmGetActionList.Images;
           vcmGetMenuImages;
 // Заплатка для http://mdp.garant.ru/pages/viewpage.action?pageId=272668827
 // ибо ни сил, ни желания разбираться ни у кого не было.
 // (+) http://mdp.garant.ru/pages/viewpage.action?pageId=272668827&focusedCommentId=276546490#comment-276546490
 {$EndIf Nemesis}
end;

procedure TvcmPopupMenuPrim.Cleanup;
  //override;
begin
 f_OldWndProc := nil;
 inherited;
end;

class function TvcmPopupMenuPrim.IsCacheable: Boolean;
  //override;
  {-}
begin
 Result := true;
end;

procedure TvcmPopupMenuPrim.SubstWndProc(var Msg: TMessage);
var
 l_Str: string;
begin
 if (Msg.Msg = WM_HELP) then
 begin
  if (Application <> nil) then
  begin
   l_Str := vcmGetHelpKeyword(TWMHelp(Msg).HelpInfo, nil, Self);
   if (l_Str <> '') then
   begin
    Application.HelpKeyword(l_Str);
    Msg.Result := 1;
    exit;
   end;//l_Str <> ''
  end;//Application <> nil
 end;//Msg.Msg = WM_HELP
 Msg.Result := CallWindowProc(f_OldWndProc, PopupList.Window, Msg.Msg, Msg.WParam, Msg.LParam);
end;

procedure TvcmPopupMenuPrim.Popup(X, Y: Integer);
  //override;
  {-}
var
 l_Action : IvcmAction;
 l_Instance : Pointer;
begin
 l_Instance := MakeObjectInstance(SubstWndProc);
 try
  f_OldWndProc := Pointer(GetWindowLong(PopupList.Window, GWL_WNDPROC));
  SetWindowLong(PopupList.Window, GWL_WNDPROC, LongInt(l_Instance));
  try
   if (Owner Is TvcmToolButtonDef) AND
    Supports(TvcmToolButtonDef(Owner).Action, IvcmAction, l_Action) then
   try
    l_Action.LockUpdate;
    try
     inherited;
    finally
     l_Action.UnlockUpdate;
    end;//try..finally
   finally
    l_Action := nil;
   end//Owner Is TvcmToolButtonDef
   else
    inherited;
  finally
   SetWindowLong(PopupList.Window, GWL_WNDPROC, LongInt(f_OldWndProc));
  end;//try..finally
 finally
  FreeObjectInstance(l_Instance);
 end;//try..finally
end;//Popup

end.
