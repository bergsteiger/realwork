{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{               Pascal Invoker Support                  }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.Invoker;

interface

uses
  Soap.IntfInfo, Soap.InvokeRegistry;

type

  TInterfaceInvoker = class
  public
    procedure Invoke(const Obj: TObject; IntfMD: TIntfMetaData;
      const MethNum: Integer; const Context: TInvContext);
  end;

implementation

uses
  Soap.SOAPConst, System.SysUtils, System.TypInfo, System.Rtti;

                                                          
procedure TInterfaceInvoker.Invoke(const Obj: TObject;
      IntfMD: TIntfMetaData; const MethNum: Integer;
      const Context: TInvContext);
var
  cxt: TRTTIContext;
  Method: TRttiMethod;
  MEntry: TIntfMethEntry;
  Args: TArray<TValue>;
  Result: TValue;
  I: Integer;
  Intf: IUnknown;
  Val: TValue;
begin
  MEntry := IntfMD.MDA[MethNum];
  for Method in cxt.GetType(IntfMD.Info).GetMethods do
  begin
    if Method.VirtualIndex = MEntry.Pos then
    begin
      // RTTI needs VMT of the interface, not the Implementation
      if not Supports(Obj, IntfMD.IID, Intf) then
        raise Exception.CreateFmt(SNoInterfaceGUID,
          [Obj.ClassName, GUIDToString(IntfMD.IID)]);
      TValue.Make(@Intf, intfmd.Info, Val);

      SetLength(Args, MEntry.ParamCount);    
      for I := 0 to MEntry.ParamCount - 1 do
          TValue.Make(Context.GetParamPointer(I), MEntry.Params[I].Info, Args[I]);

      Result := Method.Invoke(val, args);
      for I := 0 to MEntry.ParamCount -1 do
        if (pfVar in MEntry.Params[I].Flags) or (pfOut in MEntry.Params[I].Flags)  then
          Args[I].ExtractRawData(Context.GetParamPointer(I));

      if MEntry.ResultInfo <> nil then
        Result.ExtractRawData(Context.GetResultPointer);
      Exit;
    end;
  end;
end;

end.

