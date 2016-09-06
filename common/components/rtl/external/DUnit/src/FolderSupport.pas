unit FolderSupport;

// Модуль: "w:\common\components\rtl\external\DUnit\src\FolderSupport.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "FolderSupport" MUID: (5136F46C0163)

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , ComCtrls
 {$IfEnd} // NOT Defined(NoVCL)
;

const
 csRegistryShowFolder = 'ShowFolder';

function IsNodeFolder(aNode: TTreeNode): Boolean;
function AddFolderNode(const aTree: TTreeView;
 const aNode: TTreeNode;
 const aFoldeName: AnsiString): TTreeNode;
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 //#UC START# *5136F46C0163impl_uses*
 //#UC END# *5136F46C0163impl_uses*
;

const
 cnFolderIndex = High(Integer);
  {* Признак папки }

function IsNodeFolder(aNode: TTreeNode): Boolean;
//#UC START# *5136F4820266_5136F46C0163_var*
//#UC END# *5136F4820266_5136F46C0163_var*
begin
//#UC START# *5136F4820266_5136F46C0163_impl*
  if (aNode = nil) then
   Result := false
  else
   Result := Integer(aNode.Data) = cnFolderIndex;
//#UC END# *5136F4820266_5136F46C0163_impl*
end;//IsNodeFolder

function AddFolderNode(const aTree: TTreeView;
 const aNode: TTreeNode;
 const aFoldeName: AnsiString): TTreeNode;
//#UC START# *5136F4DC012D_5136F46C0163_var*
 var
  i      : Integer;
  l_Node : TTreeNode;
//#UC END# *5136F4DC012D_5136F46C0163_var*
begin
//#UC START# *5136F4DC012D_5136F46C0163_impl*
  if (aNode <> nil) and (aNode.Level = 0) and (aFoldeName <> '') then
  begin
   Result := nil;
   for i := 0 to aNode.Count - 1 do
   begin
    l_Node := aNode.Item[i];
    if IsNodeFolder(l_Node) and (l_Node.Text = aFoldeName) then
    begin
     Result := l_Node;
     Break;
    end; // if IsNodeFolder(Result) and (l_Node.Text = aFoldeName) then
   end; // for i := 0 to aNode.Count - 1 do
   if Result = nil then
   begin
    Result := aTree.Items.AddChild(aNode, aFoldeName);
    Result.Data := TObject(cnFolderIndex);
   end // if Result = nil then
  end //if FShowFolder and (aNode <> nil) and (aNode.Level = 0) then
  else
   Result := aNode;
//#UC END# *5136F4DC012D_5136F46C0163_impl*
end;//AddFolderNode
{$IfEnd} // Defined(nsTest)

end.
