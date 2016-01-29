unit nsUnderControlNode;

////////////////////////////////////////////////////////////////////////////////
// Библиотека : Проект Немезис;
// Назначение : Корень списка документов на контроле;
// Версия     : $Id: nsUnderControlNode.pas,v 1.7 2015/01/28 12:05:56 kostitsin Exp $
////////////////////////////////////////////////////////////////////////////////

interface

uses
  IOUnit,
  UnderControlUnit,
  BaseTypesUnit,

  l3Tree_TLB,
  l3IID,
  l3Interfaces,

  nsNodes,

  FoldersDomainInterfaces
  ;

type
  TnsUnderControlNode = class(TnsCacheableNode,
                              InsUnderControlNode)
  private
  // fields
   f_CaptionString : IString;
   f_ControlledObj : IControllable;
   f_IsOpenFlag    : Boolean;
  protected
  // InsUnderControlNode
   function  pm_getStatus : Integer;
     {-}
   function  pm_getIsOpened : Boolean;
     {-}
   procedure pm_setIsOpened(aValue : Boolean);
     {-}
   function pm_GetDocumentStatus: TItemStatus;
     {-}
   procedure ResetStatus;
     {-}
  protected
  // methods
   procedure Cleanup;
     override;
     {-}
  public
  // methods
   constructor Create(const aControllable     : IControllable;
                      const aNumInParent      : Integer;
                      const aTotalNumInParent : Integer);
     reintroduce;
     {-}
   class function Make(const aControllable     : IControllable;
                       const aNumInParent      : Integer = -1;
                       const aTotalNumInParent : Integer = -1): Il3Node;
     reintroduce;
     {-}
   function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
     override;
     {-}
   procedure DoDelete;
     override;
     {-}
   function  GetAsPCharLen: Tl3PCharLenPrim;
     override;
     {-}
  end;//TnsUnderControlNode

implementation

uses
  SysUtils,

  l3String,

  DocumentUnit,

  nsTypes
  ;

class function TnsUnderControlNode.Make(const aControllable     : IControllable;
                                        const aNumInParent      : Integer;
                                        const aTotalNumInParent : Integer): Il3Node;
var
 l_Node : TnsUnderControlNode;
begin
 l_Node := Create(aControllable, aNumInParent, aTotalNumInParent);
 try
  Result := l_Node;
 finally
  FreeAndNil(l_Node);
 end;
end;

constructor TnsUnderControlNode.Create(const aControllable     : IControllable;
                                       const aNumInParent      : Integer;
                                       const aTotalNumInParent : Integer);
begin
 inherited Create(nil, aNumInParent, aTotalNumInParent);

 f_ControlledObj := aControllable;
end;

procedure TnsUnderControlNode.Cleanup;
begin
 f_ControlledObj := nil;
 f_CaptionString := nil;
 f_IsOpenFlag := False;
 inherited;
end;

function TnsUnderControlNode.pm_getStatus : Integer;
begin
 Result := f_ControlledObj.GetControlStatus;
end;

function TnsUnderControlNode.pm_getIsOpened : Boolean;
begin
 Result := f_IsOpenFlag;
end;

procedure TnsUnderControlNode.pm_setIsOpened(aValue : Boolean);
begin
 f_IsOpenFlag := aValue;
end;

procedure TnsUnderControlNode.ResetStatus;
begin
 Changing;
 try
  f_ControlledObj.ResetControlStatus;
 finally
  Changed;
 end;
end;

function TnsUnderControlNode.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
begin
 if IID.EQ(IControllable) then
 begin
  if (f_ControlledObj = nil) then
   Result.SetNOINTERFACE
  else
  begin
   Result.SetOk;
   IControllable(Obj) := f_ControlledObj;
  end;//l_Controllable = nil
 end//IID.EQ(IControllable)
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;

procedure TnsUnderControlNode.DoDelete;
begin
 if f_ControlledObj.GetControlled then
  f_ControlledObj.SetControlled(False);
 f_CaptionString := nil;
 inherited;
end;

function TnsUnderControlNode.GetAsPCharLen: Tl3PCharLenPrim;
  //override;
  {-}
begin
 if (f_CaptionString = nil) then
 begin
  if (f_ControlledObj <> nil) then
   f_ControlledObj.GetShortName(f_CaptionString)
  else
  begin
   Result := inherited GetAsPCharLen;
   Exit;
  end;//f_ControlledObj <> nil
 end;//f_CaptionString = nil
 if (f_CaptionString <> nil) then
  Result := nsWStr(f_CaptionString)
 else
  l3AssignNil(Result);
end;

function TnsUnderControlNode.pm_GetDocumentStatus: TItemStatus;
var
 l_Document: IDocument;
begin
 if Supports(f_ControlledObj, IDocument, l_Document) then
  Result := l_Document.GetStatus
 else
  Result := IS_UNKNOWN;
end;

end.