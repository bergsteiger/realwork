unit eeEditorExportModelPart;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest Engine"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest_Engine/eeEditorExportModelPart.pas"
// �����: 26.02.2010 11:02
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Everest Engine::Editor::TeeEditorExportModelPart
//
// ����� TeeEditorExport ������������ �� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

uses
  afwInterfaces,
  Classes,
  evTunedEditor,
  eeInterfaces,
  eeInterfacesEx,
  nevGUIInterfaces
  {$If defined(Nemesis)}
  ,
  eeDocumentTool
  {$IfEnd} //Nemesis
  ,
  l3IID,
  evdTypes,
  l3Interfaces,
  k2Base,
  evCustomEditorModelPart,
  evTypes,
  nevTools,
  Windows
  ;

type

{$If defined(Nemesis)}
 TeeBlock = class(TeeDocumentTool, IeeBlock)
 private
 // private fields
   f_ID : Integer;
   f_LayerID : Integer;
 protected
 // realized methods
   function Delete: Boolean;
   function Exists: Boolean;
   function Select: Boolean;
   function IsSame(const aSub: IeeSub): Boolean;
   function Get_SubPlace: TevSubPlace;
   function Get_ID: Integer;
   function Get_LayerID: Integer;
   function Get_Flag: Integer;
   function Get_Flags: Integer;
   function Get_Name: Tl3WString;
   procedure Set_Name(const aValue: Tl3WString);
   function Get_Next: IeeSub;
   function Get_LeafPara: IeeLeafPara;
   function Get_Para: IeePara;
   function Get_Document: IeeDocument;
   function Get_ParentBlock: IeeBlock;
   function IsKindOf(aType: Tk2Type): Boolean;
 protected
 // overridden protected methods
   function COMQueryInterface(const IID: Tl3GUID;
   out Obj): Tl3HResult; override;
     {* ���������� ������� ���������� }
 public
 // public methods
   constructor Create(const aDocument: IeeDocumentEx;
     anID: Integer;
     aLayerID: Integer); reintroduce;
   class function Make(const aDocument: IeeDocumentEx;
     anID: Integer;
     aLayerID: Integer): IeeBlock; reintroduce;
     {* ��������� ������� TeeBlock.Make }
 end;//TeeBlock
{$IfEnd} //Nemesis

 TeeCanSplitParaEvent = procedure (aSender: TObject;
  const aPara: IeePara;
  var Allow: Boolean) of object;

 TeeBlockChangeEvent = Classes.TNotifyEvent;

 TeeBlockScrollEvent = procedure (aSender: TObject;
  aDown: Boolean) of object;

 TeeEditorExportModelPart = class(TevTunedEditor, IeeEditor, IeeDocument, IeeData, IeeCommands)
  {* ����� TeeEditorExport ������������ �� ������ }
 private
 // private fields
   f_OnCanSplitPara : TeeCanSplitParaEvent;
    {* ���� ��� �������� OnCanSplitPara}
   f_OnBlockChange : TeeBlockChangeEvent;
    {* ���� ��� �������� OnBlockChange}
   f_OnBlockScroll : TeeBlockScrollEvent;
    {* ���� ��� �������� OnBlockScroll}
 protected
 // realized methods
   function CanInsertParaOnMove: Boolean;
     {* ����� �� ��������� ��������� ��� �������� ������� }
   function IsInReadOnlyPara(const aPara: InevPara;
    NeedDeleteIfReadOnly: Boolean): Boolean;
     {* ��������� �� � ���������, � ������� ��������� �������������� }
   function Get_Block(anID: Integer): IeeBlock;
   function Get_BlockEx(anID: Integer; aLayerID: Integer): IeeBlock;
   function Get_Subs: IeeSubList;
   function Get_Markers: IeeSubList;
   function Get_Bookmarks: IeeSubList;
   function Get_Marks: IeeSubList;
   function Get_ExternalHandle: Integer;
   function Get_Document: IeeDocument;
   procedure Cut;
     {* ��������� ������ Cut }
   procedure Copy;
     {* ��������� ������ Copy }
   procedure Delete;
     {* ��������� ������ Delete }
   function Paste: Boolean;
   procedure SelectAll;
     {* ��������� ������ SelectAll }
   procedure HideSelection;
     {* ��������� ������ HideSelection }
   function GetHotspotOnPoint(const aPt: TPoint;
     out theHotSpot: IeeHotSpot): Boolean;
   function CanSplitPara(const aPara: IeePara): Boolean;
   function Get_Commands: IeeCommands;
   function Get_Data: IeeData;
 protected
 // overridden property methods
   function pm_GetAllowParaType: TevAllowParaTypes; override;
 protected
 // overridden protected methods
   function DoSearchHyperLink(const anOption: TevSearchOptionSetEx): Boolean; override;
 protected
 // protected methods
   function AsIeeDocumentEx: IeeDocumentEx; virtual; abstract;
 public
 // public methods
   function MakeHotSpot(const aPt: TafwPoint;
     const aHotSpot: IevHotSpot;
     out theHotSpot: IeeHotSpot): Boolean;
 protected
 // protected properties
   property OnCanSplitPara: TeeCanSplitParaEvent
     read f_OnCanSplitPara
     write f_OnCanSplitPara;
   property OnBlockChange: TeeBlockChangeEvent
     read f_OnBlockChange
     write f_OnBlockChange;
   property OnBlockScroll: TeeBlockScrollEvent
     read f_OnBlockScroll
     write f_OnBlockScroll;
 end;//TeeEditorExportModelPart

implementation

uses
  l3InterfacesMisc
  {$If defined(Nemesis)}
  ,
  eeSub
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  eePara
  {$IfEnd} //Nemesis
  ,
  l3String,
  l3Variant,
  nevNavigation,
  SysUtils
  {$If defined(Nemesis)}
  ,
  eeHotSpot
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  eeSubList
  {$IfEnd} //Nemesis
  
  {$If defined(evNeedDisp)}
  ,
  evStandardActions
  {$IfEnd} //evNeedDisp
  ,
  nevBase
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TeeEditorExportModelPart

function TeeEditorExportModelPart.MakeHotSpot(const aPt: TafwPoint;
  const aHotSpot: IevHotSpot;
  out theHotSpot: IeeHotSpot): Boolean;
//#UC START# *54BFFE5B0166_4B877FE00340_var*
var
 l_Cursor: InevBasePoint;
 l_Hyperlink: IevHyperlink;
//#UC END# *54BFFE5B0166_4B877FE00340_var*
begin
//#UC START# *54BFFE5B0166_4B877FE00340_impl*
 if Document.AsObject.IsValid then
 begin
  Result := true;
  if not Supports(aHotSpot, IevHyperlink, l_Hyperlink) then
   l_Hyperlink := nil;
  if GetPtPoint(aPt, l_Cursor) AND (Selection <> nil) then
   try
    {$IfDef Nemesis}
    theHotSpot := TeeHotSpot.Make(l_Cursor.MostInner.Obj^.AsObject,
                                  Self.AsIeeDocumentEx,
                                  l_Hyperlink,
                                  InevSelection(Selection).Contains(l_Cursor));
    {$Else}
    theHotSpot := nil;
    Result := false;
    {$EndIf}
   finally
    l_Cursor := nil;
   end//try..finally
  else
   Result := false; 
 end//Document.IsValid
 else
  Result := false; 
//#UC END# *54BFFE5B0166_4B877FE00340_impl*
end;//TeeEditorExportModelPart.MakeHotSpot
{$If defined(Nemesis)}

// start class TeeBlock

constructor TeeBlock.Create(const aDocument: IeeDocumentEx;
  anID: Integer;
  aLayerID: Integer);
//#UC START# *54BF89AF0252_54BF88B903AF_var*
//#UC END# *54BF89AF0252_54BF88B903AF_var*
begin
//#UC START# *54BF89AF0252_54BF88B903AF_impl*
 inherited Create(aDocument);
 f_ID := anID;
 f_LayerID := aLayerID;
//#UC END# *54BF89AF0252_54BF88B903AF_impl*
end;//TeeBlock.Create

class function TeeBlock.Make(const aDocument: IeeDocumentEx;
  anID: Integer;
  aLayerID: Integer): IeeBlock;
var
 l_Inst : TeeBlock;
begin
 l_Inst := Create(aDocument, anID, aLayerID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TeeBlock.Delete: Boolean;
//#UC START# *548188CE0291_54BF88B903AF_var*
var
 l_Block: IevDocumentPart;
//#UC END# *548188CE0291_54BF88B903AF_var*
begin
//#UC START# *548188CE0291_54BF88B903AF_impl*
 Result := false;
 if (Document <> nil) then
 begin
  l_Block := Document.DocumentPartEx[f_ID, f_LayerID];
  if (l_Block <> nil) then
   Result := l_Block.Delete(nil);
 end;//Document <> nil
//#UC END# *548188CE0291_54BF88B903AF_impl*
end;//TeeBlock.Delete

function TeeBlock.Exists: Boolean;
//#UC START# *548188E50006_54BF88B903AF_var*
var
 l_Block: IevDocumentPart;
//#UC END# *548188E50006_54BF88B903AF_var*
begin
//#UC START# *548188E50006_54BF88B903AF_impl*
 Result := false;
 if (Document <> nil) then
 begin
  l_Block := Document.DocumentPartEx[f_ID, f_LayerID];
  if (l_Block <> nil) then
   Result := l_Block.Exists;
 end;//Document <> nil
//#UC END# *548188E50006_54BF88B903AF_impl*
end;//TeeBlock.Exists

function TeeBlock.Select: Boolean;
//#UC START# *548188FC0305_54BF88B903AF_var*
//#UC END# *548188FC0305_54BF88B903AF_var*
begin
//#UC START# *548188FC0305_54BF88B903AF_impl*
 Result := Exists;
 if Result then
  with Document do
   DocumentPartEx[f_ID, f_LayerID].Select(Selection);
//#UC END# *548188FC0305_54BF88B903AF_impl*
end;//TeeBlock.Select

function TeeBlock.IsSame(const aSub: IeeSub): Boolean;
//#UC START# *5481891302A1_54BF88B903AF_var*
//#UC END# *5481891302A1_54BF88B903AF_var*
begin
//#UC START# *5481891302A1_54BF88B903AF_impl*
 Result := l3IEQ(Self, aSub) OR
           ((aSub <> nil) AND (Get_ID = aSub.ID) AND (Get_LayerID = aSub.LayerID) AND
            (Get_Flag = aSub.Flag));
//#UC END# *5481891302A1_54BF88B903AF_impl*
end;//TeeBlock.IsSame

function TeeBlock.Get_SubPlace: TevSubPlace;
//#UC START# *548189A0022F_54BF88B903AFget_var*
var
 l_Sub: IevSub;
//#UC END# *548189A0022F_54BF88B903AFget_var*
begin
//#UC START# *548189A0022F_54BF88B903AFget_impl*
 l_Sub := Document.SubEx[f_ID, Get_LayerID];
 if (l_Sub = nil) then
  Result := ev_spNoWhere
 else
  Result := l_Sub.SubPlace;
//#UC END# *548189A0022F_54BF88B903AFget_impl*
end;//TeeBlock.Get_SubPlace

function TeeBlock.Get_ID: Integer;
//#UC START# *548189BC01DF_54BF88B903AFget_var*
//#UC END# *548189BC01DF_54BF88B903AFget_var*
begin
//#UC START# *548189BC01DF_54BF88B903AFget_impl*
 Result := f_ID;
//#UC END# *548189BC01DF_54BF88B903AFget_impl*
end;//TeeBlock.Get_ID

function TeeBlock.Get_LayerID: Integer;
//#UC START# *548189D0014C_54BF88B903AFget_var*
//#UC END# *548189D0014C_54BF88B903AFget_var*
begin
//#UC START# *548189D0014C_54BF88B903AFget_impl*
 Result := f_LayerID;
//#UC END# *548189D0014C_54BF88B903AFget_impl*
end;//TeeBlock.Get_LayerID

function TeeBlock.Get_Flag: Integer;
//#UC START# *548189EE0355_54BF88B903AFget_var*
//#UC END# *548189EE0355_54BF88B903AFget_var*
begin
//#UC START# *548189EE0355_54BF88B903AFget_impl*
 Result := 0;
//#UC END# *548189EE0355_54BF88B903AFget_impl*
end;//TeeBlock.Get_Flag

function TeeBlock.Get_Flags: Integer;
//#UC START# *548189F9001A_54BF88B903AFget_var*
var
 l_Sub: IevSub;
//#UC END# *548189F9001A_54BF88B903AFget_var*
begin
//#UC START# *548189F9001A_54BF88B903AFget_impl*
 l_Sub := Document.SubEx[f_ID, Get_LayerID];
 if (l_Sub = nil) then
  Result := 0
 else
  Result := l_Sub.Flags;
//#UC END# *548189F9001A_54BF88B903AFget_impl*
end;//TeeBlock.Get_Flags

function TeeBlock.Get_Name: Tl3WString;
//#UC START# *54818A59008A_54BF88B903AFget_var*
//#UC END# *54818A59008A_54BF88B903AFget_var*
begin
//#UC START# *54818A59008A_54BF88B903AFget_impl*
 if Exists then
  Result := Document.DocumentPartEx[f_ID, f_LayerID].Name
 else
  l3AssignNil(Result);
//#UC END# *54818A59008A_54BF88B903AFget_impl*
end;//TeeBlock.Get_Name

procedure TeeBlock.Set_Name(const aValue: Tl3WString);
//#UC START# *54818A59008A_54BF88B903AFset_var*
//#UC END# *54818A59008A_54BF88B903AFset_var*
begin
//#UC START# *54818A59008A_54BF88B903AFset_impl*
 if Exists then
  Document.DocumentPartEx[f_ID, f_LayerID].Name := aValue;
//#UC END# *54818A59008A_54BF88B903AFset_impl*
end;//TeeBlock.Set_Name

function TeeBlock.Get_Next: IeeSub;
//#UC START# *54818A7B0210_54BF88B903AFget_var*
var
 l_Sub: IevSub;
//#UC END# *54818A7B0210_54BF88B903AFget_var*
begin
//#UC START# *54818A7B0210_54BF88B903AFget_impl*
 if Exists then
 begin
  l_Sub := Document.DocumentPartEx[f_ID, f_LayerID].Next;
  if (l_Sub = nil) then
   Result := nil
  else
   Result := TeeSub.Make(Document, l_Sub.ID, l_Sub.LayerID, 0);
 end
 else
  Result := nil;
//#UC END# *54818A7B0210_54BF88B903AFget_impl*
end;//TeeBlock.Get_Next

function TeeBlock.Get_LeafPara: IeeLeafPara;
//#UC START# *54818A9700C3_54BF88B903AFget_var*
var
 l_Sub: IevSub;
//#UC END# *54818A9700C3_54BF88B903AFget_var*
begin
//#UC START# *54818A9700C3_54BF88B903AFget_impl*
 if Exists then
 begin
  l_Sub := Document.DocumentPartEx[f_ID, f_LayerID];
  if (l_Sub = nil) then
   Result := nil
  else
   Result := TeePara.Make(l_Sub.LeafPara, Document) As IeeLeafPara;
 end
 else
  Result := nil;
//#UC END# *54818A9700C3_54BF88B903AFget_impl*
end;//TeeBlock.Get_LeafPara

function TeeBlock.Get_Para: IeePara;
//#UC START# *54818AA901FF_54BF88B903AFget_var*
var
 l_Sub: IevSub;
//#UC END# *54818AA901FF_54BF88B903AFget_var*
begin
//#UC START# *54818AA901FF_54BF88B903AFget_impl*
 if Exists then
 begin
  l_Sub := Document.DocumentPartEx[f_ID, f_LayerID];
  if (l_Sub = nil) then
   Result := nil
  else
   Result := TeePara.Make(l_Sub.Para, Document);
 end
 else
  Result := nil;
//#UC END# *54818AA901FF_54BF88B903AFget_impl*
end;//TeeBlock.Get_Para

function TeeBlock.Get_Document: IeeDocument;
//#UC START# *5481960900A7_54BF88B903AFget_var*
//#UC END# *5481960900A7_54BF88B903AFget_var*
begin
//#UC START# *5481960900A7_54BF88B903AFget_impl*
 Result := Document;
//#UC END# *5481960900A7_54BF88B903AFget_impl*
end;//TeeBlock.Get_Document

function TeeBlock.Get_ParentBlock: IeeBlock;
//#UC START# *548196150340_54BF88B903AFget_var*
var
 l_ParentBlock: IevDocumentPart;
//#UC END# *548196150340_54BF88B903AFget_var*
begin
//#UC START# *548196150340_54BF88B903AFget_impl*
 Result := nil;
 if Exists then 
 begin
  l_ParentBlock := Document.DocumentPartEx[f_ID, f_LayerID].ParentDocumentPart;
  if (l_ParentBlock <> nil) then
   Result := IeeDocument(Document).BlockEx[l_ParentBlock.ID, l_ParentBlock.LayerID];
 end;//Exists
//#UC END# *548196150340_54BF88B903AFget_impl*
end;//TeeBlock.Get_ParentBlock

function TeeBlock.IsKindOf(aType: Tk2Type): Boolean;
//#UC START# *5481962D00FB_54BF88B903AF_var*
var
 l_Block: IevDocumentPart;
//#UC END# *5481962D00FB_54BF88B903AF_var*
begin
//#UC START# *5481962D00FB_54BF88B903AF_impl*
 Result := false;
 if (Document <> nil) then
 begin
  l_Block := Document.DocumentPartEx[f_ID, f_LayerID];
  if (l_Block <> nil) then
   Result := l_Block.Para.IsKindOf(aType);
 end;//Document <> nil
//#UC END# *5481962D00FB_54BF88B903AF_impl*
end;//TeeBlock.IsKindOf

function TeeBlock.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_54BF88B903AF_var*
//#UC END# *4A60B23E00C3_54BF88B903AF_var*
begin
//#UC START# *4A60B23E00C3_54BF88B903AF_impl*
 if IID.EQ(Il3TagRef) then
  if Exists then
   Result := Tl3HResult_C(Document.DocumentPartEx[f_ID, f_LayerID].QueryInterface(IID.IID, Obj))
  else
   Result.SetNoInterface
 else
 if IID.EQ(IeePara) then
 begin
  IeePara(Obj) := Get_Para;
  if (IeePara(Obj) = nil) then
   Result.SetNoInterface
  else
   Result.SetOk;
 end//IID.EQ(IeePara)
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_54BF88B903AF_impl*
end;//TeeBlock.COMQueryInterface

{$IfEnd} //Nemesis

function TeeEditorExportModelPart.CanInsertParaOnMove: Boolean;
//#UC START# *4A8C083300C3_4B877FE00340_var*
//#UC END# *4A8C083300C3_4B877FE00340_var*
begin
//#UC START# *4A8C083300C3_4B877FE00340_impl*
 Result := False;
//#UC END# *4A8C083300C3_4B877FE00340_impl*
end;//TeeEditorExportModelPart.CanInsertParaOnMove

function TeeEditorExportModelPart.IsInReadOnlyPara(const aPara: InevPara;
  NeedDeleteIfReadOnly: Boolean): Boolean;
//#UC START# *4A8C24130193_4B877FE00340_var*
//#UC END# *4A8C24130193_4B877FE00340_var*
begin
//#UC START# *4A8C24130193_4B877FE00340_impl*
 Result := False;
//#UC END# *4A8C24130193_4B877FE00340_impl*
end;//TeeEditorExportModelPart.IsInReadOnlyPara

function TeeEditorExportModelPart.Get_Block(anID: Integer): IeeBlock;
//#UC START# *548196F902DF_4B877FE00340get_var*
//#UC END# *548196F902DF_4B877FE00340get_var*
begin
//#UC START# *548196F902DF_4B877FE00340get_impl*
 {$If Declared(TeeBlock)}
 Result := TeeBlock.Make(Self.AsIeeDocumentEx, anID, Ord(ev_sbtSub));
 {$IfEnd}
//#UC END# *548196F902DF_4B877FE00340get_impl*
end;//TeeEditorExportModelPart.Get_Block

function TeeEditorExportModelPart.Get_BlockEx(anID: Integer; aLayerID: Integer): IeeBlock;
//#UC START# *5481973F00EA_4B877FE00340get_var*
//#UC END# *5481973F00EA_4B877FE00340get_var*
begin
//#UC START# *5481973F00EA_4B877FE00340get_impl*
 {$If Declared(TeeBlock)}
 Result := TeeBlock.Make(Self.AsIeeDocumentEx, anID, aLayerID);
 {$IfEnd}
//#UC END# *5481973F00EA_4B877FE00340get_impl*
end;//TeeEditorExportModelPart.Get_BlockEx

function TeeEditorExportModelPart.Get_Subs: IeeSubList;
//#UC START# *548197920363_4B877FE00340get_var*
//#UC END# *548197920363_4B877FE00340get_var*
begin
//#UC START# *548197920363_4B877FE00340get_impl*
 {$If Declared(TeeSubList)}
 Result := TeeSubList.Make(Document.AsObject, Self.AsIeeDocumentEx, Ord(ev_sbtSub));
 {$IfEnd}
//#UC END# *548197920363_4B877FE00340get_impl*
end;//TeeEditorExportModelPart.Get_Subs

function TeeEditorExportModelPart.Get_Markers: IeeSubList;
//#UC START# *548197A50084_4B877FE00340get_var*
//#UC END# *548197A50084_4B877FE00340get_var*
begin
//#UC START# *548197A50084_4B877FE00340get_impl*
 {$If Declared(TeeSubList)}
 Result := TeeSubList.Make(Document.AsObject, Self.AsIeeDocumentEx, Ord(ev_sbtMarker));
 {$IfEnd}
//#UC END# *548197A50084_4B877FE00340get_impl*
end;//TeeEditorExportModelPart.Get_Markers

function TeeEditorExportModelPart.Get_Bookmarks: IeeSubList;
//#UC START# *548197AE02B9_4B877FE00340get_var*
//#UC END# *548197AE02B9_4B877FE00340get_var*
begin
//#UC START# *548197AE02B9_4B877FE00340get_impl*
 {$If Declared(TeeSubList)}
 Result := TeeSubList.Make(Document.AsObject, Self.AsIeeDocumentEx, Ord(ev_sbtBookmark));
 {$IfEnd}
//#UC END# *548197AE02B9_4B877FE00340get_impl*
end;//TeeEditorExportModelPart.Get_Bookmarks

function TeeEditorExportModelPart.Get_Marks: IeeSubList;
//#UC START# *548197B8028C_4B877FE00340get_var*
//#UC END# *548197B8028C_4B877FE00340get_var*
begin
//#UC START# *548197B8028C_4B877FE00340get_impl*
 {$If Declared(TeeSubList)}
 Result := TeeSubList.Make(Document.AsObject, Self.AsIeeDocumentEx, Ord(ev_sbtMark));
 {$IfEnd}
//#UC END# *548197B8028C_4B877FE00340get_impl*
end;//TeeEditorExportModelPart.Get_Marks

function TeeEditorExportModelPart.Get_ExternalHandle: Integer;
//#UC START# *548197F202C4_4B877FE00340get_var*
//#UC END# *548197F202C4_4B877FE00340get_var*
begin
//#UC START# *548197F202C4_4B877FE00340get_impl*
  if (TextSource = nil) then
  Result := 0
 else
  Result := TextSource.DocumentContainer.SubList.Block[0].ExternalHandle;
//#UC END# *548197F202C4_4B877FE00340get_impl*
end;//TeeEditorExportModelPart.Get_ExternalHandle

function TeeEditorExportModelPart.Get_Document: IeeDocument;
//#UC START# *5481988203C9_4B877FE00340get_var*
//#UC END# *5481988203C9_4B877FE00340get_var*
begin
//#UC START# *5481988203C9_4B877FE00340get_impl*
 Result := Self;
//#UC END# *5481988203C9_4B877FE00340get_impl*
end;//TeeEditorExportModelPart.Get_Document

procedure TeeEditorExportModelPart.Cut;
//#UC START# *548198C00194_4B877FE00340_var*
//#UC END# *548198C00194_4B877FE00340_var*
begin
//#UC START# *548198C00194_4B877FE00340_impl*
 inherited;
//#UC END# *548198C00194_4B877FE00340_impl*
end;//TeeEditorExportModelPart.Cut

procedure TeeEditorExportModelPart.Copy;
//#UC START# *548198CA0185_4B877FE00340_var*
//#UC END# *548198CA0185_4B877FE00340_var*
begin
//#UC START# *548198CA0185_4B877FE00340_impl*
 inherited;
//#UC END# *548198CA0185_4B877FE00340_impl*
end;//TeeEditorExportModelPart.Copy

procedure TeeEditorExportModelPart.Delete;
//#UC START# *548198D20380_4B877FE00340_var*
//#UC END# *548198D20380_4B877FE00340_var*
begin
//#UC START# *548198D20380_4B877FE00340_impl*
 Range.Delete;
//#UC END# *548198D20380_4B877FE00340_impl*
end;//TeeEditorExportModelPart.Delete

function TeeEditorExportModelPart.Paste: Boolean;
//#UC START# *548198D902BA_4B877FE00340_var*
//#UC END# *548198D902BA_4B877FE00340_var*
begin
//#UC START# *548198D902BA_4B877FE00340_impl*
 Result := inherited Paste;
//#UC END# *548198D902BA_4B877FE00340_impl*
end;//TeeEditorExportModelPart.Paste

procedure TeeEditorExportModelPart.SelectAll;
//#UC START# *548198ED0189_4B877FE00340_var*
//#UC END# *548198ED0189_4B877FE00340_var*
begin
//#UC START# *548198ED0189_4B877FE00340_impl*
 {$IfDef evNeedDisp}
 Process(Self, Self, Ord(ev_ccSelectAll), false);
 {$Else  evNeedDisp}
 Select(ev_stDocument);
 {$EndIf evNeedDisp}
//#UC END# *548198ED0189_4B877FE00340_impl*
end;//TeeEditorExportModelPart.SelectAll

procedure TeeEditorExportModelPart.HideSelection;
//#UC START# *548198F403CE_4B877FE00340_var*
//#UC END# *548198F403CE_4B877FE00340_var*
begin
//#UC START# *548198F403CE_4B877FE00340_impl*
 {$IfDef evNeedDisp}
 Process(Self, Self, Ord(ev_ccHideSelection), false);
 {$Else  evNeedDisp}
 InevSelection(Selection).Unselect;
 {$EndIf evNeedDisp}
//#UC END# *548198F403CE_4B877FE00340_impl*
end;//TeeEditorExportModelPart.HideSelection

function TeeEditorExportModelPart.GetHotspotOnPoint(const aPt: TPoint;
  out theHotSpot: IeeHotSpot): Boolean;
//#UC START# *54819F7C006B_4B877FE00340_var*
var
 l_HotSpot: IevHotSpot;
//#UC END# *54819F7C006B_4B877FE00340_var*
begin
//#UC START# *54819F7C006B_4B877FE00340_impl*
 if inherited GetHotspotOnPoint(aPt, l_HotSpot, False) then
  Result := MakeHotSpot(DP2LP(aPt, False), l_HotSpot, theHotSpot)
 else
  Result := False;
//#UC END# *54819F7C006B_4B877FE00340_impl*
end;//TeeEditorExportModelPart.GetHotspotOnPoint

function TeeEditorExportModelPart.CanSplitPara(const aPara: IeePara): Boolean;
//#UC START# *54819FA40295_4B877FE00340_var*
var
 l_Result: Boolean;
//#UC END# *54819FA40295_4B877FE00340_var*
begin
//#UC START# *54819FA40295_4B877FE00340_impl*
 l_Result := true;
 if not ShowUserComments then
 begin
  Result := false;
  Exit;
 end;//not ShowUserComments
 if Assigned(f_OnCanSplitPara) then
  f_OnCanSplitPara(Self, aPara, l_Result);
 Result := l_Result;
//#UC END# *54819FA40295_4B877FE00340_impl*
end;//TeeEditorExportModelPart.CanSplitPara

function TeeEditorExportModelPart.Get_Commands: IeeCommands;
//#UC START# *54819FB9026A_4B877FE00340get_var*
//#UC END# *54819FB9026A_4B877FE00340get_var*
begin
//#UC START# *54819FB9026A_4B877FE00340get_impl*
 Result := Self;
//#UC END# *54819FB9026A_4B877FE00340get_impl*
end;//TeeEditorExportModelPart.Get_Commands

function TeeEditorExportModelPart.Get_Data: IeeData;
//#UC START# *54819FC5013E_4B877FE00340get_var*
//#UC END# *54819FC5013E_4B877FE00340get_var*
begin
//#UC START# *54819FC5013E_4B877FE00340get_impl*
 Result := Self;
//#UC END# *54819FC5013E_4B877FE00340get_impl*
end;//TeeEditorExportModelPart.Get_Data

function TeeEditorExportModelPart.pm_GetAllowParaType: TevAllowParaTypes;
//#UC START# *4B877E7B0330_4B877FE00340get_var*
//#UC END# *4B877E7B0330_4B877FE00340get_var*
begin
//#UC START# *4B877E7B0330_4B877FE00340get_impl*
 Result := [Low(TevAllowParaType) .. High(TevAllowParaType)] - [ev_aptSBS];
//#UC END# *4B877E7B0330_4B877FE00340get_impl*
end;//TeeEditorExportModelPart.pm_GetAllowParaType

function TeeEditorExportModelPart.DoSearchHyperLink(const anOption: TevSearchOptionSetEx): Boolean;
//#UC START# *55CDBD7600D4_4B877FE00340_var*
var
 l_NewOption: TevSearchOptionSetEx;
//#UC END# *55CDBD7600D4_4B877FE00340_var*
begin
//#UC START# *55CDBD7600D4_4B877FE00340_impl*
 l_NewOption := anOption + [ev_soCheckOwnerCollapsed];
 if (AACLike = nev_aacLeft) then
  l_NewOption := l_NewOption + [ev_soIngoreExternalLink];
 Result := inherited DoSearchHyperLink(l_NewOption);
//#UC END# *55CDBD7600D4_4B877FE00340_impl*
end;//TeeEditorExportModelPart.DoSearchHyperLink

initialization
{$If not defined(NoScripts)}
// ����������� TeeEditorExportModelPart
 TtfwClassRef.Register(TeeEditorExportModelPart);
{$IfEnd} //not NoScripts

end.