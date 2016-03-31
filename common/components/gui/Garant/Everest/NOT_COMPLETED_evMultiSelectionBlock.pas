unit NOT_COMPLETED_evMultiSelectionBlock;

// ������: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_evMultiSelectionBlock.pas"
// ���������: "SimpleClass"
// ������� ������: "TevMultiSelectionBlock" MUID: (48E3B83B0187)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evMultiSelectionText
 , evdInterfaces
 , nevTools
 , nevBase
 , l3Interfaces
;

type
 TevMultiSelectionBlock = class(TevMultiSelectionText, IevdDataObject, InevDataObjectPrim2)
  protected
   procedure DoStore(const aView: InevView;
    const G: InevTagGenerator;
    aFlags: TevdStoreFlags); virtual;
    {* ��������� ��������� � G }
   procedure Store(const aView: InevView;
    const G: InevTagGenerator;
    aFlags: TevdStoreFlags = evDefaultStoreFlags); overload;
    {* ��������� ��������� � G. }
   function Store(aFormat: TevdClipboardFormat;
    const aPool: IStream;
    const aFilters: TevdTagGenerator;
    aFlags: TevdStoreFlags = [evd_sfStoreParaEnd]): Boolean; overload;
    {* ��������� ��������� � ������� aFormat � Pool, ������� ������ ������������� IStream. }
   function GetData: IevdDataObject; override;
   function GetAsStorable: InevDataObjectPrim2; override;
 end;//TevMultiSelectionBlock

implementation

uses
 l3ImplUses
 , l3InterfacedString
 , k2BaseTypes
 , l3Base
 , nevFacade
 , ContentsElement_Const
 , Block_Const
 , Document_Const
 , k2Tags
;

procedure TevMultiSelectionBlock.DoStore(const aView: InevView;
 const G: InevTagGenerator;
 aFlags: TevdStoreFlags);
 {* ��������� ��������� � G }
//#UC START# *48ECE4420180_48E3B83B0187_var*
  
  function StoreSel(const aSel: InevRange; anIndex: Integer): Boolean;
  begin//StoreSel
   Result := true;
   aSel.AsStorable.Store(aView, G, aFlags - [evd_sfChildrenOnly]);
  end;//StoreSel

var
 l_Tag : Tl3Variant;
//#UC END# *48ECE4420180_48E3B83B0187_var*
begin
//#UC START# *48ECE4420180_48E3B83B0187_impl*
 l_Tag := GetRedirect;
 if (evd_sfChildrenOnly in aFlags) then
 begin
  {$IfDef Nemesis}
  with l_Tag do
   if IsKindOf(k2_typDocument) then
   begin
    if HasSubAtom(k2_tiInContents) then
     G.AddBoolAtom(k2_tiInContents, BoolA[k2_tiInContents]);
    if HasSubAtom(k2_tiName) then
     G.AddStringAtom(k2_tiName, PCharLenA[k2_tiName]);
    if HasSubAtom(k2_tiShortName) then
     G.AddStringAtom(k2_tiShortName, PCharLenA[k2_tiShortName]);
    if HasSubAtom(k2_tiExternalHandle) then
     G.AddIntegerAtom(k2_tiExternalHandle, IntA[k2_tiExternalHandle]);
   end;//IsKindOf(k2_typDocument)
  {$EndIf Nemesis}
  IterateF(evL2TSA(@StoreSel));
 end//evd_sfChildrenOnly in aFlags
 else
 begin
  with l_Tag.AsObject do
  begin
   if TagType.IsKindOf(k2_typBlock) AND
      not TagType.IsKindOf(k2_typDocument) then
    G.StartChild(k2_typContentsElement)
   // - �.�. �� �� Solid (��. TevMultiSelectionBlock.Store), �� ���� ���������������
   //   �� ���� �������� ����� �� ��� ��������� ����� ��������, �������� - http://mdp.garant.ru/pages/viewpage.action?pageId=151588139
   else
    G.StartChild(TagType);
   try
    WriteTag(G, l3_spfAll - [l3_spfChildren]);
    IterateF(evL2TSA(@StoreSel));
   finally
    G.Finish;
   end;//try..finally
  end;//with l_Tag
 end;//ChildrenOnly
//#UC END# *48ECE4420180_48E3B83B0187_impl*
end;//TevMultiSelectionBlock.DoStore

procedure TevMultiSelectionBlock.Store(const aView: InevView;
 const G: InevTagGenerator;
 aFlags: TevdStoreFlags = evDefaultStoreFlags);
 {* ��������� ��������� � G. }
//#UC START# *47C68BFD011C_48E3B83B0187_var*
var
 l_Tag : Tl3Variant;
//#UC END# *47C68BFD011C_48E3B83B0187_var*
begin
//#UC START# *47C68BFD011C_48E3B83B0187_impl*
 if (Blocks <> nil) AND (Blocks.Count = 1) then
  Blocks.First.AsStorable.Store(aView, G, aFlags)
 else
 begin
  aFlags := aFlags - [evd_sfStoreParaEnd];
  l_Tag := GetRedirect;
  if Solid(aView) then
  begin
   if not (evd_sfChildrenOnly in aFlags) then
   begin
    with l_Tag.AsObject do
    begin
     G.StartChild(TagType);
     try
      WriteTag(G, l3_spfAll);
     finally
      G.Finish;
     end;{try..finally}
    end;//with l_Tag
    Exit;
   end;//not ChildrenOnly
  end;//Solid
  DoStore(aView, G, aFlags);
 end;//(f_Blocks <> nil) AND (f_Blocks.Count = 1) 
//#UC END# *47C68BFD011C_48E3B83B0187_impl*
end;//TevMultiSelectionBlock.Store

function TevMultiSelectionBlock.Store(aFormat: TevdClipboardFormat;
 const aPool: IStream;
 const aFilters: TevdTagGenerator;
 aFlags: TevdStoreFlags = [evd_sfStoreParaEnd]): Boolean;
 {* ��������� ��������� � ������� aFormat � Pool, ������� ������ ������������� IStream. }
//#UC START# *47C68C6701AF_48E3B83B0187_var*
var
 l_TSR : InevTagReader;
//#UC END# *47C68C6701AF_48E3B83B0187_var*
begin
//#UC START# *47C68C6701AF_48E3B83B0187_impl*
 l_TSR := ParaX.DocumentContainer.TagReader;
 if (l_TSR <> nil) then
  try
   Result := (l_TSR.ReadTag(aFormat, aPool, aFilters, Self, aFlags) > 0);
  finally
   l_TSR := nil;
  end//try..finally
 else
  Result := false;
//#UC END# *47C68C6701AF_48E3B83B0187_impl*
end;//TevMultiSelectionBlock.Store

function TevMultiSelectionBlock.GetData: IevdDataObject;
//#UC START# *48ECD89F02EA_48E3B83B0187_var*
//#UC END# *48ECD89F02EA_48E3B83B0187_var*
begin
//#UC START# *48ECD89F02EA_48E3B83B0187_impl*
 Result := Self;
//#UC END# *48ECD89F02EA_48E3B83B0187_impl*
end;//TevMultiSelectionBlock.GetData

function TevMultiSelectionBlock.GetAsStorable: InevDataObjectPrim2;
//#UC START# *48ECD8FE0184_48E3B83B0187_var*
//#UC END# *48ECD8FE0184_48E3B83B0187_var*
begin
//#UC START# *48ECD8FE0184_48E3B83B0187_impl*
 Result := Self;
//#UC END# *48ECD8FE0184_48E3B83B0187_impl*
end;//TevMultiSelectionBlock.GetAsStorable

end.
