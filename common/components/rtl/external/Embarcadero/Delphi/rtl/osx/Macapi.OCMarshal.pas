{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Macapi.OCMarshal;

interface

type
  ///
  ///  Procedure type for the transform procedure used by <code>moXForm<code>
  ///  marshaling operations.
  TXFormProc = procedure(Src: Pointer; Dest: Pointer);

  ///
  ///  Method type for the transform procedure used by <code>moXFormWithContext</code>
  ///  marshaling operations.
  TXFormWithContextProc = procedure(Src: Pointer; Dest: Pointer) of object;

  ///
  ///  Kind of marshal operations that we support.
  TMarshalOpKind = (
    ///
    ///  Copy data from source to destination.  Size is specified in the operation.
    moCopy,

    ///  Store a reference to the destination buffer at the given location.
    ///  Used for when you need to allocate a local buffer, and include a
    ///  pointer to that local buffer in your marshaled arguments.
    moLocalRef,

    ///  Stores a constant value at the given location in the destination
    ///  buffer.  No data from the source buffer is used.
    moStore,

    ///  Applies a transform function to get data from the source buffer
    ///  to the destination buffer.  The size of the transformation is
    ///  arbitrary.  The contents of the source buffer may or may not be
    ///  used.
    moXForm,

    ///  Applies a transform function as per <code>moXForm</code>, but
    ///  instead of the function being a flat function, it's a method.
    ///  Thus you can capture some context when you are creating the
    ///  marhsaler, and have that context available when the marshaler
    ///  is executed.
    moXFormWithContext
                   );

  ///
  ///  Each marshal operation in a marshaler is specified with a separate
  ///  record.  Each operation will be applied to a source buffer and
  ///  a destination buffer.  The marshaler will use the data from the
  ///  marshal operations to determine the fixed up source and destination
  ///  buffers to apply the operation to.
  TMarshalOp = record
  private
    function GetXFormContextProc: TXFormWithContextProc; inline;
  public
    ///
    ///  The kind of the operation.
    Kind: TMarshalOpKind;

    ///
    ///  The offset from the start of the source buffer to apply this
    ///  operation to.
    Src: Integer;

    ///
    ///  The offset from the start of the destination buffer to apply this
    ///  operation to.
    Dest: Integer;

    ///
    ///  This field optionally hold the context instance used to assemble
    ///  a TXFormWithContextProc method pointer using the _XFormContextProc
    ///  field.
    Context: IInterface;

    property XFormContextProc: TXFormWithContextProc read GetXFormContextProc;
  public
    case TMarshalOpKind of
      moCopy: (
        ///
        ///  Size, in bytes, of data to copy.
        Size: Integer;
              );

      moLocalRef: (
        ///
        ///  The offset from the start of the destination buffer to be used
        ///  to compute the pointer to be stored.  When the operation is
        ///  executed, the marshaler will add <code>Offset</code> to the
        ///  destination buffer, and store it at the offset in the buffer
        ///  specified by the <code>Dest</code> field.
        ///  When using this operation, the <code>Src</code> field is not used.
        Offset: Integer;
              );

      moStore: (
        ///
        ///  The value to be stored at the offset specified by <code>Dest</code>.
        ///  When using this operation, the <code>Src</code> field is not used.
        Value: NativeInt;
              );

      moXForm: (
        ///
        ///  The procedure to call to perform the transform.  It will be
        ///  passed the buffers specified by the <code>Src</code> and <code>Dest</code>
        ///  fields.
        XFormProc: TXFormProc;
              );

      moXFormWithContext: (
        ///
        ///  The method to call to perform the transform.  It will be
        ///  passed the buffers specified by the <code>Src</code> and <code>Dest</code>
        ///  fields.
        _XFormContextProc: Pointer;
              );
  end;
  PMarshalOp = ^TMarshalOp;

  ///
  ///  A general purpose marshaling class that can marshal data from an
  ///  input buffer to an output buffer given a set of marshaling operations
  ///  that are configured by the client.
  TMarshaler = class
  private
    FOps: TArray<TMarshalOp>;
  public
    ///
    ///  Create the marshaler with an array of marshal operations.
    constructor Create(Ops: TArray<TMarshalOp>);

    ///
    ///  Executes the marshaling operations on the given source and destination
    ///  buffers.
    ///  <param name="Src">Pointer to an input buffer.  The buffer must be large
    ///  enough to be accesible by all the marhsaling operations.</param>
    ///  <param name="Dest">Pointer to the destination buffer.  The buffer
    ///  must be large enough to accept all the data from the marshaling
    ///  operations.</param>
    procedure Execute(Src: Pointer; Dest: Pointer);

    ///
    ///  Returns a string representation of the marshaler.  Useful for diagnostic
    ///  purposes only.
    function ToString: string; override;

    ///
    ///  Marshaling operations frequently include multiple operations that can
    ///  be collapsed into one.  This function takes an array of marshaling operations
    ///  and elides all adjacent copy operations that target contiguous regions of
    ///  stack space.  In some cases, this can reduce all the marshaling operations
    ///  in an array down to one.  The array length is modified on the input ops
    ///  array, and operations are shifted down and modified as needed.
    class procedure Optimize(var Ops: TArray<TMarshalOp>); static;
  end;

implementation

uses System.SysUtils;

{ TMarshalOp }

function TMarshalOp.GetXFormContextProc: TXFormWithContextProc;
begin
  TMethod(Result).Data := Pointer(TObject(Context));
  TMethod(Result).Code := _XFormContextProc;
end;

{ TMarshaler }

constructor TMarshaler.Create(Ops: TArray<TMarshalOp>);
begin
  FOps := Ops;
end;

procedure TMarshaler.Execute(Src: Pointer; Dest: Pointer);
var
  I: Integer;
  Op: PMarshalOp;
  S: PByte;
  D: PByte;
begin
  for I:= 0 to Length(FOps) - 1 do
  begin
    Op := @FOps[I];
    S := PByte(Src) + Op.Src;
    D := PByte(Dest) + Op.Dest;
    case Op^.Kind of
      moCopy:
        Move(PPointer(S)^, PPointer(D)^, Op^.Size);
      moLocalRef:
        PPointer(D)^ := Pointer(PByte(Dest) + Op^.Offset);
      moStore:
        PPointer(D)^ := Pointer(Op^.Value);
      moXForm:
        Op^.XFormProc(S, D);
      moXFormWithContext:
        Op^.XFormContextProc(S, D);
    else
      Assert(False);
    end;
  end;
end;

function TMarshaler.ToString: string;
var
  Buff: TStringBuilder;
  I: Integer;
  Op: PMarshalOp;
begin
  Buff := TStringBuilder.Create;
  Buff.Append('[');
  for I:= 0 to Length(FOps) - 1 do
  begin
    Op := @FOps[I];
    if I > 0 then
      Buff.Append(', ');
    case Op^.Kind of
      moCopy:
        Buff.AppendFormat('C(%d,%d,%d)', [Op^.Src, Op^.Dest, Op^.Size]);
      moStore:
        Buff.AppendFormat('S(%d,%ld)', [Op^.Dest, Op^.Value]);
      moLocalRef:
        Buff.AppendFormat('L(%d,%d)', [Op^.Dest, Op^.Offset]);
      moXForm:
        Buff.AppendFormat('X(%d,%d)', [Op^.Src, Op^.Dest]);
      moXFormWithContext:
        Buff.AppendFormat('XC(%d,%d)', [Op^.Src, Op^.Dest]);
    else
      Assert(False);
    end;
  end;
  Buff.Append(']');
  Result := Buff.ToString;
end;

class procedure TMarshaler.Optimize(var Ops: TArray<TMarshalOp>);
var
  I: Integer;
  NextIdx: Integer;
  Last: PMarshalOp;
  RegionSize: Integer;

  procedure InitRegion;
  begin
    Last := @Ops[0];
    NextIdx := 1;
    if Last.Kind = moCopy then
      RegionSize := Last.Size
    else
      RegionSize := 0;
  end;

  procedure CloseRegion;
  begin
    if Last.Kind = moCopy then
    begin
      Assert(RegionSize <> 0);
      Last.Size := RegionSize;
    end
    else
    begin
      Assert(RegionSize = 0);
    end;
    if I - NextIdx > 0 then
      Ops[NextIdx] := Ops[I];
    Last := @Ops[NextIdx];
    if Last.Kind = moCopy then
      RegionSize := Last.Size
    else
      RegionSize := 0;
    Inc(NextIdx);
  end;

begin
  if Length(Ops) = 0 then Exit;

  InitRegion;
  for I:= 1 to Length(Ops) - 1 do
  begin
    case Last.Kind of
       moCopy:
         begin
           if Ops[I].Kind = moCopy then
           begin
             // Check to see if the current op is a copy op that is contiguous
             // with the last op.  If so, we can merge them.
             if (Ops[I].Src = Last^.Src + RegionSize) and
                  (Ops[I].Dest = Last^.Dest + RegionSize) then
               // regions are contiguous - update the region size
               Inc(RegionSize, Ops[I].Size)
             else
               // regions are not contiguous.  Seal off the last copy, and restart.
               CloseRegion;
           end
           else
             // current op is not a copy - can't merge
             CloseRegion;
         end;
       moXForm, moXFormWithContext:
         CloseRegion;
    end;
  end;
  if RegionSize > 0 then
  begin
    // Possibly we merged in copy ops from the end of the list.  RegionSize can
    // only be positive if there was a copy behind us.
    Assert(Last^.Kind = moCopy);
    Last^.Size := RegionSize;
  end;
  SetLength(Ops, NextIdx);
end;

end.
