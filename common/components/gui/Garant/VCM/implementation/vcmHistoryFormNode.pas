unit vcmHistoryFormNode;

{ Библиотека "vcm"           }
{ Модуль: vcmHistoryFormNode }
{ Начат: 07.10.2015 14:00    }
{ $Id: vcmHistoryFormNode.pas,v 1.3 2015/10/07 11:46:38 morozov Exp $ }

// $Log: vcmHistoryFormNode.pas,v $
// Revision 1.3  2015/10/07 11:46:38  morozov
// {RequestLink: 606827062}
//
// Revision 1.2  2015/10/07 11:35:20  morozov
// {RequestLink: 606827062}
//

{$Include vcmDefine.inc }

interface

{$If not defined(NoVCM)}

uses
  vcmBaseTypes,
  vcmInterfaces,
  vcmEntityForm,
  vcmUserControls,
  vcmBase;

type

 // Элемент "пути" к форме для записи данных о её контейнере в истории
 TvcmHistoryFormNode = class(TvcmCacheableBase)
 private
   f_FormClass : RvcmEntityForm;
   f_ZoneType : TvcmZoneType;
   f_UserType : TvcmUserType;
   f_SubUserType : TvcmUserType;
   f_ContainerNode : TvcmHistoryFormNode;
   f_ChildNode : TvcmHistoryFormNode;
 private
   procedure FillNode(const aForm: IvcmEntityForm);
 protected
   procedure Cleanup; override;
 public
   function FindContainer(const aMainForm: IvcmContainer): IvcmContainer;
   constructor Create(const aForm: IvcmEntityForm;
     aChildNode: TvcmHistoryFormNode = nil); reintroduce;
 public
   property FormClass: RvcmEntityForm
     read f_FormClass;
   property ZoneType: TvcmZoneType
     read f_ZoneType;
   property UserType: TvcmUserType
     read f_UserType;
   property SubUserType: TvcmUserType
     read f_SubUserType;
   property ContainerNode: TvcmHistoryFormNode
     read f_ContainerNode;
   property ChildNode: TvcmHistoryFormNode
     read f_ChildNode;
 end;//TvcmHistoryFormNode

implementation 
uses
  SysUtils;
 
procedure TvcmHistoryFormNode.FillNode(const aForm: IvcmEntityForm);
begin
 f_FormClass := RvcmEntityForm(aForm.VCLWinControl.ClassType);
 f_ZoneType := aForm.ZoneType;
 f_UserType := aForm.UserType;
 f_SubUserType := aForm.SubUserType;
 if (aForm.Container <> nil) and (not (aForm.Container.IsNull)) then
  f_ContainerNode := TvcmHistoryFormNode.Create(aForm.Container.AsForm, Self);
end;

function TvcmHistoryFormNode.FindContainer(const aMainForm: IvcmContainer): IvcmContainer;

 function lp_GetChildForm(const aContainerForm: IvcmEntityForm;
                       aNode: TvcmHistoryFormNode; out aChildForm: IvcmEntityForm): Boolean;
 var
  l_Iterator: IvcmEntityFormIterator;
  l_Form: IvcmEntityForm;
 begin
  aChildForm := nil;
  l_Iterator := aContainerForm.AsContainer.EntityFormIterator;
  l_Form := l_Iterator.Next;
  while (l_Form <> nil) do
  begin
   Result := (l_Form.ZoneType = aNode.ZoneType) and
             (l_Form.UserType = aNode.UserType) and
             (l_Form.SubUserType = aNode.SubUserType) and
             (RvcmEntityForm(l_Form.VCLWinControl.ClassType) = aNode.FormClass);
   if Result then
   begin
    aChildForm := l_Form;
    Break;
   end
   else
   if (l_Form.AsContainer <> nil) then
   begin
    Result := lp_GetChildForm(l_Form, aNode, aChildForm);
   end;
   l_Form := l_Iterator.Next;
  end;//while (l_Form <> nil)...
 end;//lp_GetChildForm...

var
 l_RootNode: TvcmHistoryFormNode;
 l_ParentForm: IvcmEntityForm;
 l_ChildForm: IvcmEntityForm;
begin
 Result := nil;
 l_RootNode := Self;
 while (l_RootNode.ContainerNode <> nil) do
  l_RootNode := l_RootNode.ContainerNode;
 l_ParentForm := aMainForm.AsForm;
 l_ChildForm := nil;
 while (l_RootNode.ChildNode <> nil) do
 begin
  if not lp_GetChildForm(l_ParentForm, l_RootNode.ChildNode, l_ChildForm) then
   Break;
  if (l_RootNode.ChildNode = ContainerNode) then
   Break; 
  l_RootNode := l_RootNode.ChildNode;
  l_ParentForm := l_ChildForm;
 end;//while (l_RootNode.ChildNode <> nil)...
 if (l_ChildForm <> nil) then
  Result := l_ChildForm.AsContainer;
 if (Result = nil) then
  Result := aMainForm;
end;

constructor TvcmHistoryFormNode.Create(const aForm: IvcmEntityForm;
  aChildNode: TvcmHistoryFormNode = nil);
begin
 inherited Create;
 FillNode(aForm);
 f_ChildNode := aChildNode;
end;//TvcmHistoryFormNode.Create

procedure TvcmHistoryFormNode.Cleanup;
begin
 FreeAndNil(f_ContainerNode);
 inherited CleanUp;
end;//TvcmHistoryFormNode.Cleanup

{$IfEnd}

end.