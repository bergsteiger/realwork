unit D_Undo;

{ $Id: D_UNDO.PAS,v 1.12 2009/07/23 17:40:13 lulin Exp $ }

// $Log: D_UNDO.PAS,v $
// Revision 1.12  2009/07/23 17:40:13  lulin
// - переносим процессор операций туда куда надо.
//
// Revision 1.11  2008/03/24 09:16:58  lulin
// - new build.
//
// Revision 1.10  2007/12/03 09:47:53  dinishev
// »спользуем редактор из ветки
//
// Revision 1.8  2007/02/28 10:05:45  lulin
// - bug fix: падал јрчи из-за несоответстви€ типов параметров.
//
// Revision 1.7  2006/12/07 11:37:13  voba
// - remove l3Control, l3InputControl;
//
// Revision 1.6  2005/10/18 11:54:46  lulin
// - исправлено, то что не компилировалось в св€зи с переездом модулей.
//
// Revision 1.5  2005/05/27 14:44:22  lulin
// - базовый контрол переехал в быблиотеку L3.
//
// Revision 1.4  2005/03/25 17:11:00  lulin
// - избавл€емс€ от метода Tk2AtomW.sLong.
//
// Revision 1.3  2004/11/09 15:59:37  lulin
// - bug fix: не компилировалось.
//
// Revision 1.2  2004/03/05 13:00:48  voba
// TCustomVLister -> TvtCustomLister
//
// Revision 1.1  2002/11/01 16:47:40  law
// - move unit: D_Undo переехал в Common.
//
// Revision 1.7  2001/06/05 15:26:16  law
// - new behavior: сделано объединение соседних блоков.
//
// Revision 1.6  2001/05/23 14:00:45  law
// - new behavior: подстраиваемс€ под изменени€ ¬ована, относительно PopupWindow.
//
// Revision 1.5  2000/12/15 16:22:06  law
// - вставлены директивы Log.
//

interface

{$I evDefine.inc}

uses
  SysUtils, 
  WinTypes, 
  WinProcs, 
  Messages, 
  Classes, 
  Graphics, 
  Controls,
  Forms, 
  Dialogs, 
  ExtCtrls, 
  
  RXSplit, 

  OvcBase, 

  vtlister,
  
  l3Types,
  l3Base,
  l3Interfaces,
  
  evOpProc, 

  nevBase,
  nevTools,

  afwControl, 
  afwInputControl, afwControlPrim, afwBaseControl
  ;

type
  (*TUndoContentsForm = class;

  TevFormListner = class(Tl3Base, InevUndoBufferListner)
  private
   f_Owner : TUndoContentsForm;
  protected
    //interface InevUndoBufferListner
   procedure Changed;
  public 
   constructor Create(anOwner: TObject = nil);
     override;{!v4}  
  end;*)

  TUndoContentsForm = class(TForm)
    lstContainers: TvtLister;
    Splitter: TRxSplitter;
    lstOperations: TvtLister;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lstContainersGetStrItem(Sender: TObject; Index: Longint;
      var ItemString: Il3CString);
    procedure lstOperationsGetStrItem(Sender: TObject; Index: Longint;
      var ItemString: Il3CString);
    procedure FormDestroy(Sender: TObject);
    procedure lstContainersCurrentChanged(Sender: TObject; aNewCurrent,
      aOldCurrent: Integer);
  private
    { Private declarations }                      
    f_Processor : InevProcessor;                            
    //f_FormListner : TevFormListner;
  protected
    //interface InevUndoBufferListner
    procedure Changed;
  public
    { Public declarations }
    constructor Make(anOwner          : TComponent;
                     const aProcessor : InevProcessor);
      {-}
  end;

{var
  UndoContentsForm: TUndoContentsForm;}

implementation

uses
  l3String,

  k2Base,
  k2AtomOperation,
  k2ChildOperation,
  k2Op,
  k2OperationContainer,

  evTypes,
  evBseOp,
  evCursorContext
  ;

{$R *.DFM}

// start class TUndoContentsForm

constructor TUndoContentsForm.Make(anOwner          : TComponent;
                                   const aProcessor : InevProcessor);
  {-}
begin
 Create(anOwner);
 f_Processor := aProcessor;
 (*Stub
 f_Processor.UndoBuffer.OnContentsChange := TextSourceUndoBufferChange;
 f_Processor.UndoBuffer.LinkListner(f_FormListner);*)
 //f_FormListner := TevFormListner.Create(Self);
end;

procedure TUndoContentsForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Action := caHide;
end;

procedure TUndoContentsForm.lstContainersGetStrItem(Sender: TObject;
  Index: Longint; var ItemString: Il3CString);
(*var
 OC : Tk2OperationContainer;*)
begin
 Assert(False);
 (*OC := Tk2OperationContainer(
         f_Processor.UndoBuffer.Items[Index]);
 with OC do 
  if (Count > 0) then
   ItemString := l3CStr(Format('%s (%d)', [TObject(Items[0]).ClassName, Count]))
  else
   ItemString := l3CStr(Format('%s', [OC.ClassName]));*)
end;

procedure TUndoContentsForm.lstContainersCurrentChanged(Sender: TObject; aNewCurrent, aOldCurrent: Integer);
(*var
 OC : Tk2OperationContainer;*)
begin
 Assert(False)
(* if (aNewCurrent >= 0) then
 begin
  OC := Tk2OperationContainer(f_Processor.UndoBuffer.Items[aNewCurrent]);
  if (OC.Count = 0) AND (OC Is TevCursorContext) then
   lstOperations.Total := TevCursorContext(OC).SavedCursors.Count
  else
   lstOperations.Total := OC.Count;
  lstOperations.Invalidate;
 end
 else
  lstOperations.Total := 0;*)
end;

procedure TUndoContentsForm.lstOperationsGetStrItem(Sender: TObject;
  Index: Longint; var ItemString: Il3CString);
var
 O  : Tk2Op;
 AO : Tk2AtomOperation absolute O;
 OC : Tk2OperationContainer;
 CC : TevCursorContext absolute OC;
begin
 Assert(False);
 (*if (lstContainers.Current >= 0) then begin
  OC := Tk2OperationContainer(
          f_Processor.UndoBuffer.Items[lstContainers.Current]);
  with OC do begin
   if (Count = 0) AND (OC Is TevCursorContext) then 
    ItemString := l3CStr(Format('%d', [Index]))
   else begin
    O := Tl3Op(Items[Index]);
    if (O Is Tk2AtomOperation) then begin
     ItemString := l3CStr(Format('%s (%d) %s:%s',
                          [O.ClassName, O.InstanceSize,
                           AO.Prop.ParentType.Name,
                           AO.Prop.Name]));
     if (O Is Ok2AddChild) then
      ItemString := l3Cat(ItemString, Format(' Index = %d', [Ok2AddChild(O).Index]));
    end else
     ItemString := l3CStr(Format('%s (%d)', [O.ClassName, O.InstanceSize]));
   end
  end;{with OC}
 end else*)
  ItemString := nil;
end;

procedure TUndoContentsForm.FormDestroy(Sender: TObject);
begin       
 (*Stub
 f_Processor.UndoBuffer.UnLinkListner;*)
 //l3Free(f_FormListner);
 f_Processor := nil;
end;

procedure TUndoContentsForm.Changed;
begin
 if not (csDestroying in ComponentState) then 
 begin
  (*Stub
  lstContainers.Total := f_Processor.UndoBuffer.Get_Total;
  lstContainers.Current := f_Processor.UndoBuffer.Active; *)
  lstContainers.Invalidate;
  lstContainersCurrentChanged(Self, lstContainers.Current, -1);
 end;//not (csDestroying in ComponentState)
end;

{ TevFormListner }

(*procedure TevFormListner.Changed;
begin
 f_Owner.Changed;
end;

constructor TevFormListner.Create(anOwner: TObject);
begin
 inherited;
 if anOwner <> nil then 
  f_Owner := anOwner as TUndoContentsForm;
end;*)

end.
