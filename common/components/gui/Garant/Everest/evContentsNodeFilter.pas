unit evContentsNodeFilter;
 {* фильтр оглваления документа }

// Модуль: "w:\common\components\gui\Garant\Everest\evContentsNodeFilter.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevContentsNodeFilter" MUID: (4DFEF1DF009F)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3Base
 , evInternalInterfaces
 , l3Variant
 , k2SimpleTagList
 , nevTools
 , nevBase
;

type
 TevContentsNodeFilter = class(Tl3Base, InevContentsNodeFilter)
  {* фильтр оглваления документа }
  private
   f_FilteredNodeFlag: Integer;
   f_Document: Tl3Tag;
   f_FilterTagList: Tk2SimpleTagList;
    {* Список удаленных тегов. }
  private
   function NeedColor(const aNode: InevNode): Boolean;
   function GetDocContentLevel: Integer;
  protected
   procedure ColorNode(const aNode: InevNode);
   function pm_GetFilteredNodeFlag: Integer;
   procedure pm_SetFilteredNodeFlag(aValue: Integer);
   procedure CheckTagList;
   procedure AddFilterTag(aTag: Tl3Variant);
   procedure ChangeDocument(aDocument: Tl3Variant);
   function NeedCreate(aTag: Tl3Variant): Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aDocument: Tl3Variant); reintroduce; virtual;
   class function Make(aDocument: Tl3Variant): InevContentsNodeFilter;
 end;//TevContentsNodeFilter

implementation

uses
 l3ImplUses
 , evdTypes
 , l3TreeInterfaces
 , SysUtils
 , l3Bits
 , l3Types
 , l3MinMax
 , k2Tags
 , evContentsUtils
;

function TevContentsNodeFilter.NeedColor(const aNode: InevNode): Boolean;
//#UC START# *4ECA574B02DB_4DFEF1DF009F_var*
var
 l_Part          : IevDocumentPart;
 l_Level         : Integer;
 l_CurLevel      : Integer;
 l_ParentNode    : InevNode;
 l_ContentsLevel : Integer;
//#UC END# *4ECA574B02DB_4DFEF1DF009F_var*
begin
//#UC START# *4ECA574B02DB_4DFEF1DF009F_impl*
 Result := False;
 l_ContentsLevel := GetDocContentLevel;
 if (l_ContentsLevel > 0) then
 begin
  Inc(l_ContentsLevel);
  l_CurLevel := aNode.GetLevel;                                                          
  l_ParentNode := aNode;
  l_Level := cnUndefLevel;
  while l_ParentNode.GetLevel > 1 do
  begin
   if (l_ParentNode <> nil) and Supports(l_ParentNode, IevDocumentPart, l_Part) then
    try
     if (l_Part.ContentsRec.rLevel6 = 0) and (l_ParentNode <> aNode) then
     begin
      l_ContentsLevel := 0;
      Break;
     end // if l_Part.ContentsRec.rLevel6 = 0 then
     else
     if (l_Part.ContentsRec.rLevel6 < cnUndefLevel) then
     begin
      l_Level := l_ParentNode.GetLevel;
      l_Level := l_Level + l_Part.ContentsRec.rLevel6;
     end; // if (l_Part.ContentsRec.rLevel6 < Pred(High(Long))) then
    finally
     l_Part := nil;
    end;//try..finally
   if l_Level < cnUndefLevel then
   begin
    l_ContentsLevel := l_Level;
    Break;
   end; // if l_Level < cnUndefLevel then
   l_ParentNode := l_ParentNode.ParentNode;
  end; // while l_ParentNode.GetLevel > 1 do
  if (l_ContentsLevel = 0) or (l_CurLevel > l_ContentsLevel) then
   Result := True;
 end // if l_ContentsLevel then
 else
  Result := True;
//#UC END# *4ECA574B02DB_4DFEF1DF009F_impl*
end;//TevContentsNodeFilter.NeedColor

function TevContentsNodeFilter.GetDocContentLevel: Integer;
//#UC START# *532BF0C70311_4DFEF1DF009F_var*
//#UC END# *532BF0C70311_4DFEF1DF009F_var*
begin
//#UC START# *532BF0C70311_4DFEF1DF009F_impl*
 Result := EvGetContentLevel(f_Document.IntA[k2_tiContentsLevel6], True);
//#UC END# *532BF0C70311_4DFEF1DF009F_impl*
end;//TevContentsNodeFilter.GetDocContentLevel

constructor TevContentsNodeFilter.Create(aDocument: Tl3Variant);
//#UC START# *4DFEF2F303DD_4DFEF1DF009F_var*
//#UC END# *4DFEF2F303DD_4DFEF1DF009F_var*
begin
//#UC START# *4DFEF2F303DD_4DFEF1DF009F_impl*
 f_FilteredNodeFlag := nfHidden;
 aDocument.SetRef(f_Document);
 f_FilterTagList := Tk2SimpleTagList.Make;
 inherited Create;
//#UC END# *4DFEF2F303DD_4DFEF1DF009F_impl*
end;//TevContentsNodeFilter.Create

class function TevContentsNodeFilter.Make(aDocument: Tl3Variant): InevContentsNodeFilter;
//#UC START# *4DFEF31A0273_4DFEF1DF009F_var*
var
 l_Filter: TevContentsNodeFilter;
//#UC END# *4DFEF31A0273_4DFEF1DF009F_var*
begin
//#UC START# *4DFEF31A0273_4DFEF1DF009F_impl*
 l_Filter := TevContentsNodeFilter.Create(aDocument);
 try
  Result := l_Filter;
 finally
  l3Free(l_Filter);
 end;
//#UC END# *4DFEF31A0273_4DFEF1DF009F_impl*
end;//TevContentsNodeFilter.Make

procedure TevContentsNodeFilter.ColorNode(const aNode: InevNode);
//#UC START# *4A2628130085_4DFEF1DF009F_var*
var
 l_Flags : Integer;
//#UC END# *4A2628130085_4DFEF1DF009F_var*
begin
//#UC START# *4A2628130085_4DFEF1DF009F_impl*
 if (aNode = nil) then
  Exit;
 l_Flags := aNode.Flags;
 if NeedColor(aNode) then
  l3SetMask(l_Flags, f_FilteredNodeFlag)
 else
  l3ClearMask(l_Flags, f_FilteredNodeFlag);
 aNode.Flags := l_Flags;
//#UC END# *4A2628130085_4DFEF1DF009F_impl*
end;//TevContentsNodeFilter.ColorNode

function TevContentsNodeFilter.pm_GetFilteredNodeFlag: Integer;
//#UC START# *4A26284D0339_4DFEF1DF009Fget_var*
//#UC END# *4A26284D0339_4DFEF1DF009Fget_var*
begin
//#UC START# *4A26284D0339_4DFEF1DF009Fget_impl*
 Result := f_FilteredNodeFlag;
//#UC END# *4A26284D0339_4DFEF1DF009Fget_impl*
end;//TevContentsNodeFilter.pm_GetFilteredNodeFlag

procedure TevContentsNodeFilter.pm_SetFilteredNodeFlag(aValue: Integer);
//#UC START# *4A26284D0339_4DFEF1DF009Fset_var*
//#UC END# *4A26284D0339_4DFEF1DF009Fset_var*
begin
//#UC START# *4A26284D0339_4DFEF1DF009Fset_impl*
 f_FilteredNodeFlag := aValue;
//#UC END# *4A26284D0339_4DFEF1DF009Fset_impl*
end;//TevContentsNodeFilter.pm_SetFilteredNodeFlag

procedure TevContentsNodeFilter.CheckTagList;
//#UC START# *4E09B99A0384_4DFEF1DF009F_var*
//#UC END# *4E09B99A0384_4DFEF1DF009F_var*
begin
//#UC START# *4E09B99A0384_4DFEF1DF009F_impl*
 if f_FilterTagList <> nil then
  f_FilterTagList.Clear;
//#UC END# *4E09B99A0384_4DFEF1DF009F_impl*
end;//TevContentsNodeFilter.CheckTagList

procedure TevContentsNodeFilter.AddFilterTag(aTag: Tl3Variant);
//#UC START# *4E09BCEA0004_4DFEF1DF009F_var*
//#UC END# *4E09BCEA0004_4DFEF1DF009F_var*
begin
//#UC START# *4E09BCEA0004_4DFEF1DF009F_impl*
 f_FilterTagList.Add(aTag);
//#UC END# *4E09BCEA0004_4DFEF1DF009F_impl*
end;//TevContentsNodeFilter.AddFilterTag

procedure TevContentsNodeFilter.ChangeDocument(aDocument: Tl3Variant);
//#UC START# *4EAE94530363_4DFEF1DF009F_var*
//#UC END# *4EAE94530363_4DFEF1DF009F_var*
begin
//#UC START# *4EAE94530363_4DFEF1DF009F_impl*
 aDocument.SetRef(f_Document);
//#UC END# *4EAE94530363_4DFEF1DF009F_impl*
end;//TevContentsNodeFilter.ChangeDocument

function TevContentsNodeFilter.NeedCreate(aTag: Tl3Variant): Boolean;
//#UC START# *4ECA564903B7_4DFEF1DF009F_var*
//#UC END# *4ECA564903B7_4DFEF1DF009F_var*
begin
//#UC START# *4ECA564903B7_4DFEF1DF009F_impl*
 if aTag = nil then
  Result := True
 else
  Result := f_FilterTagList.IndexOf(aTag) < 0;
//#UC END# *4ECA564903B7_4DFEF1DF009F_impl*
end;//TevContentsNodeFilter.NeedCreate

procedure TevContentsNodeFilter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4DFEF1DF009F_var*
//#UC END# *479731C50290_4DFEF1DF009F_var*
begin
//#UC START# *479731C50290_4DFEF1DF009F_impl*
 FreeAndNil(f_Document);
 CheckTagList;
 l3Free(f_FilterTagList);
 inherited;
//#UC END# *479731C50290_4DFEF1DF009F_impl*
end;//TevContentsNodeFilter.Cleanup

end.
