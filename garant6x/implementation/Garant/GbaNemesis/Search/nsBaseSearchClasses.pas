unit nsBaseSearchClasses;

// $Id: nsBaseSearchClasses.pas,v 1.4 2015/11/09 09:42:58 morozov Exp $

// $Log: nsBaseSearchClasses.pas,v $
// Revision 1.4  2015/11/09 09:42:58  morozov
// {RequestLink: 610745801}
//
// Revision 1.3  2015/10/22 11:38:51  morozov
// {RequestLink: 609899254}
//
// Revision 1.2  2015/10/22 06:43:46  morozov
// {RequestLink: 609899254}
//
// Revision 1.1  2015/10/21 12:50:12  morozov
// {RequestLink: 609899254}
//

{$include nsDefine.inc}

interface

{$IfNDef Monitorings}
uses
 l3Interfaces,
 l3TreeInterfaces,
 l3InterfacePtrList,

 afwInterfaces,

 vcmInterfaces,
 vcmExternalInterfaces,
 vcmBase,

 DataAdapterInterfaces,
 DataAdapter,
 DynamicTreeUnit,

 BaseSearchInterfaces,
 l3Base,

 nsBaseSearchClassList
 ;

type
  TnsBaseSearchClass = class(TvcmBase,
                             InsBaseSearchClass)
  private
   f_AdapterNode: INodeBase;
  protected
   function pm_GetName: Il3CString;
   function pm_GetAdapterNode: INodeBase;
   function IsSame(const aAnother: InsBaseSearchClass): Boolean;
  protected
   procedure CleanUp; override;
  public
   class function Make(const AAdapterNode: INodeBase): InsBaseSearchClass;
   constructor Create(const AAdapterNode: INodeBase);
  end;

  TnsBaseSearchClasses = class(TvcmBase,
                                InsBaseSearchClasses,
                                InsDataAdapterListener)
  private
   f_Classes: TnsBaseSearchClassList;
   f_Listeners: Tl3InterfacePtrList;
   f_RootAdapterNode: INodeBase;
   procedure RetrieveClasses;
   procedure NotifyListeners;
   class function Make: InsBaseSearchClasses;
  protected
   // InsBaseSearchClasses
   function GetEnumerator: InsBaseSearchClassesEnumerator;
   function pm_GetRootAdapterNode: INodeBase;
   function pm_GetFirstClass: InsBaseSearchClass;
   procedure Subscribe(const aListener: InsBaseSearchClassesListener);
   procedure Unsubscribe(const aListener: InsBaseSearchClassesListener);
   function GetClassByPath(const aPath: Tl3WString): InsBaseSearchClass;
   // InsDataAdapterListener
   procedure Updated;
  protected
   procedure InitFields; override;
   procedure CleanUp; override;
  public
   class function Instance: InsBaseSearchClasses;
  end;


implementation
uses
 SysUtils,
 IOUnit,

 l3String,
 l3Nodes,

 nsTypes,
 nsTreeStruct;

type
 TnsBaseSearchClassesEnumerator = class(TvcmBase,
                                        InsBaseSearchClassesEnumerator)
 private
  f_List: TnsBaseSearchClassList;
  f_CurrentIndex: Integer;
 protected
  function MoveNext: Boolean;
  function pm_GetCurrent: InsBaseSearchClass;
  procedure Reset;
 public
  class function Make(aList: TnsBaseSearchClassList): InsBaseSearchClassesEnumerator;
  constructor Create(aList: TnsBaseSearchClassList);
 end;

{ TnsBaseSearhClassesEnumerator }

function TnsBaseSearchClassesEnumerator.MoveNext: Boolean;
begin
 Inc(f_CurrentIndex);
 Result := (f_CurrentIndex < f_List.Count);
end;

function TnsBaseSearchClassesEnumerator.pm_GetCurrent: InsBaseSearchClass;
begin
 Result := f_List.Items[f_CurrentIndex];
end;

procedure TnsBaseSearchClassesEnumerator.Reset;
begin
 f_CurrentIndex := -1;
end;

class function TnsBaseSearchClassesEnumerator.Make(aList: TnsBaseSearchClassList): InsBaseSearchClassesEnumerator;
var
 Inst: TnsBaseSearchClassesEnumerator;
begin
 Assert(aList <> nil);
 Inst := Create(aList);
 try
  Result := Inst;
 finally
  FreeAndNil(Inst);
 end;
end;

constructor TnsBaseSearchClassesEnumerator.Create(aList: TnsBaseSearchClassList);
begin
 inherited Create;
 f_List := aList;
 Reset;
end;

{ TnsBaseSearchClass }

function TnsBaseSearchClass.pm_GetName: Il3CString;
var
 l_Name : IString;
begin
 f_AdapterNode.GetCaption(l_Name);
 Result := nsCStr(l_Name);
end;

function TnsBaseSearchClass.pm_GetAdapterNode: INodeBase;
begin
 Result := f_AdapterNode;
end;

function TnsBaseSearchClass.IsSame(const aAnother: InsBaseSearchClass): Boolean;
begin
 Result := (aAnother <> nil) and f_AdapterNode.IsSameNode(aAnother.AdapterNode);
end;

procedure TnsBaseSearchClass.CleanUp;
begin
 f_AdapterNode := nil;
 inherited;
end;

class function TnsBaseSearchClass.Make(const AAdapterNode: INodeBase): InsBaseSearchClass;
var
 Inst: TnsBaseSearchClass;
begin
 Inst := Create(AAdapterNode);
 try
  Result := Inst;
 finally
  FreeAndNil(Inst);
 end;
end;

constructor TnsBaseSearchClass.Create(const AAdapterNode: INodeBase);
begin
 inherited Create;
 f_AdapterNode := AAdapterNode;
end;

{ TnsBaseSearchClasses }

procedure TnsBaseSearchClasses.RetrieveClasses;
var
 l_ValidClasses: INodeBase;
 l_FirstClass: INodeBase;
 l_NextClass: INodeBase;
begin
 f_Classes.Clear;
 DefDataAdapter.NativeAdapter.MakeMainMenu.GetBaseSearchPanes(l_ValidClasses);
 f_RootAdapterNode := l_ValidClasses;
 try
  if (l_ValidClasses <> nil) then
  begin
   l_ValidClasses.GetFirstChild(l_FirstClass);
   if (l_FirstClass <> nil) then
   begin
    f_Classes.Add(TnsBaseSearchClass.Make(l_FirstClass));
    while True do
    begin
     l_FirstClass.GetNext(l_NextClass);
     if (l_NextClass = nil) then
      Break;
     f_Classes.Add(TnsBaseSearchClass.Make(l_NextClass));
     l_FirstClass := l_NextClass;
    end;
   end;
  end;
 finally
  l_ValidClasses := nil;
 end;
end;

procedure TnsBaseSearchClasses.NotifyListeners;
var
 l_Index: Integer;
 l_Listener: InsBaseSearchClassesListener;
begin
 for l_Index := Pred(f_Listeners.Count) downto 0 do
 begin
   l_Listener := InsBaseSearchClassesListener(f_Listeners[l_Index]);
   try
    l_Listener.NotifyClassesChanged;
   finally
    l_Listener := nil;
   end;
 end;
end;

class function TnsBaseSearchClasses.Make: InsBaseSearchClasses;
var
 Inst: TnsBaseSearchClasses;
begin
 Inst := Create;
 try
  Result := Inst;
 finally
  FreeAndNil(Inst);
 end;
end;

function TnsBaseSearchClasses.GetEnumerator: InsBaseSearchClassesEnumerator;
begin
 if (f_Classes.Empty) then
  RetrieveClasses;
 Result := TnsBaseSearchClassesEnumerator.Make(f_Classes);
end;

function TnsBaseSearchClasses.pm_GetRootAdapterNode: INodeBase;
begin
 Result := f_RootAdapterNode;
end;

function TnsBaseSearchClasses.pm_GetFirstClass: InsBaseSearchClass;
begin
 Result := f_Classes.First;
end;

procedure TnsBaseSearchClasses.Subscribe(const aListener: InsBaseSearchClassesListener);
begin
 if (f_Listeners.IndexOf(aListener) = -1) then
  f_Listeners.Add(aListener)
 else
  Assert(False);
end;

procedure TnsBaseSearchClasses.Unsubscribe(const aListener: InsBaseSearchClassesListener);
begin
 if (f_Listeners.IndexOf(aListener) <> -1) then
  f_Listeners.Remove(aListener)
 else
  Assert(False);
end;

function TnsBaseSearchClasses.GetClassByPath(const aPath: Tl3WString): InsBaseSearchClass;

 function lp_FindClassByNode(const ANode: INodeBase): InsBaseSearchClass;
 var
  l_Index: Integer;
 begin
  lp_FindClassByNode := nil;
  for l_Index := 0 to Pred(f_Classes.Count) do
   if f_Classes[l_Index].AdapterNode.IsSameNode(ANode) then
   begin
    lp_FindClassByNode := f_Classes[l_Index];
    Break;
   end;
 end;

const
 cSep = '\';
var
 l_Path: Tl3WString;
 l_Tree: Il3SimpleTree;
 l_Node: Il3SimpleNode;
begin
 l_Path := aPath; 
 l_Tree := TnsTreeStruct.Make(f_RootAdapterNode, false);
 l_Node := l3GetSPartPath(l_Tree, l_Path, cSep);
 Assert(l_Node <> nil);
 if (l_Node.Parent = nil) then
 // - заточка для отсутствующей настройки
 //   возвращаем "Все документы".
 begin
  Result := lp_FindClassByNode(l_Node.Child As INodeBase);
  Exit;
 end;//l_Node.Parent = nil
 Result := lp_FindClassByNode(l_Node as INodeBase);
end;

procedure TnsBaseSearchClasses.Updated;
begin
 f_Classes.Clear;
 NotifyListeners; 
end;

procedure TnsBaseSearchClasses.InitFields;
begin
 inherited;
 f_Classes := TnsBaseSearchClassList.Create;
 f_Listeners := Tl3InterfacePtrList.Create;
 Il3ChangeNotifier(DefDataAdapter).Subscribe(InsDataAdapterListener(Self));
end;

procedure TnsBaseSearchClasses.CleanUp;
begin
 Il3ChangeNotifier(DefDataAdapter).Unsubscribe(InsDataAdapterListener(Self));
 FreeAndNil(f_Classes);
 FreeAndNil(f_Listeners);
 inherited;
end;

var
 g_Instance: InsBaseSearchClasses;

procedure TnsBaseSearchClasses_Free;
begin
 g_Instance := nil;
end; 

class function TnsBaseSearchClasses.Instance: InsBaseSearchClasses;
begin
 if (g_Instance = nil) then
 begin
  g_Instance := Make;
  l3System.AddExitProc(TnsBaseSearchClasses_Free);  
 end;  
 Result := g_Instance;
end;

{$EndIf Monitorings}

end.
