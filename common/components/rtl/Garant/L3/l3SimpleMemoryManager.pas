unit l3SimpleMemoryManager;

// ������: "w:\common\components\rtl\Garant\L3\l3SimpleMemoryManager.pas"
// ���������: "SimpleClass"
// ������� ������: "Tl3SimpleMemoryManager" MUID: (5453AE0C0100)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleMemoryManagerPrim
;

type
 Pl3MemoryBlock = ^Tl3MemoryBlock;

 Tl3MemoryBlock = object
  public
   rNext: Pl3MemoryBlock;
   rFree: Cardinal;
 end;//Tl3MemoryBlock

 Tl3SimpleMemoryManager = class(Tl3SimpleMemoryManagerPrim)
  private
   f_Head: Pl3MemoryBlock;
   f_BlockSize: Cardinal;
   f_WasAllocCountWarning: Boolean;
  protected
   f_AllocCount: Integer;
  public
   {$If Defined(MMTrace)}
   f_GlobalAlloc: Integer;
   {$IfEnd} // Defined(MMTrace)
  protected
   function CanFreeBlocks: Boolean; virtual;
   procedure FreeBlocks; virtual;
   procedure DoGetMem(var P;
    aSize: Cardinal); virtual;
   procedure DoFreeMem(var P); virtual;
   procedure AllocNewBlock;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
  public
   constructor Create(aBlockSize: Cardinal); reintroduce;
   procedure GetMem(var P;
    aSize: Cardinal);
   procedure FreeMem(var P);
 end;//Tl3SimpleMemoryManager

implementation

uses
 l3ImplUses
 , l3MemUtils
 , l3ExceptionsLog
 , SysUtils
;

function Tl3SimpleMemoryManager.CanFreeBlocks: Boolean;
//#UC START# *545A2F6800D6_5453AE0C0100_var*
//#UC END# *545A2F6800D6_5453AE0C0100_var*
begin
//#UC START# *545A2F6800D6_5453AE0C0100_impl*
 Result := (f_AllocCount = 0);
//#UC END# *545A2F6800D6_5453AE0C0100_impl*
end;//Tl3SimpleMemoryManager.CanFreeBlocks

procedure Tl3SimpleMemoryManager.FreeBlocks;
//#UC START# *54B69FF202FB_5453AE0C0100_var*
var
 l_Next : Pl3MemoryBlock;
//#UC END# *54B69FF202FB_5453AE0C0100_var*
begin
//#UC START# *54B69FF202FB_5453AE0C0100_impl*
 f_AllocCount := 0;
 while (f_Head <> nil) do begin
  l_Next := f_Head^.rNext;
  Tl3MemUtils.GlobalFreePtr(Pointer(f_Head));
  f_Head := l_Next;
 end;//while (f_Head <> nil)
 {$ifdef  MMTrace}
  f_GlobalAlloc := 0;
 {$EndIf}
//#UC END# *54B69FF202FB_5453AE0C0100_impl*
end;//Tl3SimpleMemoryManager.FreeBlocks

procedure Tl3SimpleMemoryManager.DoGetMem(var P;
 aSize: Cardinal);
//#UC START# *54B6A20201D7_5453AE0C0100_var*
  
 procedure RaiseBlockSizeError;
 begin//RaiseBlockSizeError
  raise EOutOfMemory.Create('������ ����� ������ ������� ��������.');
 end;//RaiseBlockSizeError

var
 l_Free : Cardinal;
//#UC END# *54B6A20201D7_5453AE0C0100_var*
begin
//#UC START# *54B6A20201D7_5453AE0C0100_impl*
 if (aSize > f_BlockSize) then
  RaiseBlockSizeError;
 if (aSize = 0) then
  Pointer(P) := nil
 else
 begin
  if (f_Head = nil) then
   l_Free := 0
  else
   l_Free := f_Head^.rFree;
  if (l_Free < aSize) then
   AllocNewBlock;
  Pointer(P) := PAnsiChar(f_Head) + f_BlockSize - f_Head^.rFree;
  Dec(f_Head^.rFree, aSize);
  Inc(f_AllocCount);
 end;//aSize = 0
//#UC END# *54B6A20201D7_5453AE0C0100_impl*
end;//Tl3SimpleMemoryManager.DoGetMem

procedure Tl3SimpleMemoryManager.DoFreeMem(var P);
//#UC START# *54B6A22902AB_5453AE0C0100_var*
//#UC END# *54B6A22902AB_5453AE0C0100_var*
begin
//#UC START# *54B6A22902AB_5453AE0C0100_impl*
 if (Pointer(P) <> nil) then
 begin
  if (f_AllocCount = 0) then
  begin
   if not f_WasAllocCountWarning then
   begin
    f_WasAllocCountWarning := true;
    l3ExceptionsLog.Stack2Log(ClassName + ': �����-�� ������� ���� ������� �� ��������� ���');
   end;//not f_WasAllocCountWarning
  end//not f_WasAllocCountWarning
  else
   Dec(f_AllocCount);
  Pointer(P) := nil;
  if CanFreeBlocks then
   if not f_WasAllocCountWarning then
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=571638581
   //   � ����������� � ������ - �� ������, � ��� � F1 - ���
    if not Tl3MemUtils.IsDown then
     FreeBlocks;
 end;//Pointer(P) <> nil
//#UC END# *54B6A22902AB_5453AE0C0100_impl*
end;//Tl3SimpleMemoryManager.DoFreeMem

procedure Tl3SimpleMemoryManager.AllocNewBlock;
//#UC START# *54B91C7A027A_5453AE0C0100_var*
var
 l_New  : Pl3MemoryBlock;
//#UC END# *54B91C7A027A_5453AE0C0100_var*
begin
//#UC START# *54B91C7A027A_5453AE0C0100_impl*
 l_New := Tl3MemUtils.GlobalAllocPtr(f_BlockSize);
 {$ifdef  MMTrace}
  inc(f_GlobalAlloc, f_BlockSize);
 {$EndIf}
 Assert(l_New <> nil, '�� ������� ������������ ���� �������� ' + IntToStr(f_BlockSize));
 with l_New^ do 
 begin
  rFree := Tl3MemUtils.GlobalSize(l_New) - SizeOf(l_New^);
  rNext := f_Head;
 end;//with l_New^
 f_Head := l_New;
//#UC END# *54B91C7A027A_5453AE0C0100_impl*
end;//Tl3SimpleMemoryManager.AllocNewBlock

constructor Tl3SimpleMemoryManager.Create(aBlockSize: Cardinal);
//#UC START# *54B91C9103A2_5453AE0C0100_var*
//#UC END# *54B91C9103A2_5453AE0C0100_var*
begin
//#UC START# *54B91C9103A2_5453AE0C0100_impl*
 inherited Create;
 f_BlockSize := aBlockSize;
 AllocNewBlock;
 f_BlockSize := Tl3MemUtils.GlobalSize(f_Head) // - ����� ���, ��� ����� ��������
                //- SizeOf(Tl3MemoryBlock)    // - �������� ������ ���������
                ;
//#UC END# *54B91C9103A2_5453AE0C0100_impl*
end;//Tl3SimpleMemoryManager.Create

procedure Tl3SimpleMemoryManager.GetMem(var P;
 aSize: Cardinal);
//#UC START# *54B91CB0028C_5453AE0C0100_var*
//#UC END# *54B91CB0028C_5453AE0C0100_var*
begin
//#UC START# *54B91CB0028C_5453AE0C0100_impl*
 Self.Lock;
 try
  DoGetMem(P, aSize);
 finally
  Self.Unlock;
 end;//try..finally
//#UC END# *54B91CB0028C_5453AE0C0100_impl*
end;//Tl3SimpleMemoryManager.GetMem

procedure Tl3SimpleMemoryManager.FreeMem(var P);
//#UC START# *54B91CD502DD_5453AE0C0100_var*
//#UC END# *54B91CD502DD_5453AE0C0100_var*
begin
//#UC START# *54B91CD502DD_5453AE0C0100_impl*
 Self.Lock;
 try
  DoFreeMem(P);
 finally
  Self.Unlock;
 end;//try..finally
//#UC END# *54B91CD502DD_5453AE0C0100_impl*
end;//Tl3SimpleMemoryManager.FreeMem

procedure Tl3SimpleMemoryManager.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_5453AE0C0100_var*
//#UC END# *479731C50290_5453AE0C0100_var*
begin
//#UC START# *479731C50290_5453AE0C0100_impl*
 {$IfDef l3AssertSimpleMMCanFreeBlocks}
 try
  Assert(CanFreeBlocks);
 except
  on E: Exception do
   l3ExceptionsLog.Stack2Log(E.Message);
 end;//try..except
 {$EndIf l3AssertSimpleMMCanFreeBlocks}
 FreeBlocks;
 inherited;
//#UC END# *479731C50290_5453AE0C0100_impl*
end;//Tl3SimpleMemoryManager.Cleanup

end.
