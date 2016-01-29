{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{       Standard VCL OLE Interfaces                     }
{*******************************************************}

unit System.Win.StdVCL;

{ Borland standard VCL type library }
{ Version 1.0 }

{ Bring in definition of IDispatch }
(*$HPPEMIT '#include <oaidl.h>'*)


interface

const
  LIBID_StdVCL: TGUID = '{EE05DFE0-5549-11D0-9EA9-0020AF3D82DA}';
  IID_IProvider: TGUID = '{6E644935-51F7-11D0-8D41-00A0248E4B9A}';
  IID_IStrings: TGUID = '{EE05DFE2-5549-11D0-9EA9-0020AF3D82DA}';
  IID_IDataBroker: TGUID = '{6539BF65-6FE7-11D0-9E8C-00A02457621F}';

type

{ Forward declarations }
{ Forward declarations: Interfaces }
  IProvider = interface;
  IProviderDisp = dispinterface;
  IStrings = interface;
  IStringsDisp = dispinterface;
  IDataBroker = interface;
  IDataBrokerDisp = dispinterface;

{ Provider interface for TClientDataSet }

  IProvider = interface(IDispatch)
    ['{6E644935-51F7-11D0-8D41-00A0248E4B9A}']
    function Get_Data: OleVariant; safecall;
    function ApplyUpdates(Delta: OleVariant; MaxErrors: Integer; out ErrorCount: Integer): OleVariant; safecall;
    function GetMetaData: OleVariant; safecall;
    function GetRecords(Count: Integer; out RecsOut: Integer): OleVariant; safecall;
    function DataRequest(Input: OleVariant): OleVariant; safecall;
    function Get_Constraints: WordBool; safecall;
    procedure Set_Constraints(Value: WordBool); safecall;
    procedure Reset(MetaData: WordBool); safecall;
    procedure SetParams(Values: OleVariant); safecall;
    property Data: OleVariant read Get_Data;
    property Constraints: WordBool read Get_Constraints write Set_Constraints;
  end;

{ DispInterface declaration for Dual Interface IProvider }

  IProviderDisp = dispinterface
    ['{6E644935-51F7-11D0-8D41-00A0248E4B9A}']
    property Data: OleVariant readonly dispid 1;
    function ApplyUpdates(Delta: OleVariant; MaxErrors: Integer; out ErrorCount: Integer): OleVariant; dispid 2;
    function GetMetaData: OleVariant; dispid 3;
    function GetRecords(Count: Integer; out RecsOut: Integer): OleVariant; dispid 4;
    function DataRequest(Input: OleVariant): OleVariant; dispid 5;
    property Constraints: WordBool dispid 6;
    procedure Reset(MetaData: WordBool); dispid 7;
    procedure SetParams(Values: OleVariant); dispid 8;
  end;

{ Collection Interface for TStrings }

  IStrings = interface(IDispatch)
    ['{EE05DFE2-5549-11D0-9EA9-0020AF3D82DA}']
    function Get_ControlDefault(Index: Integer): OleVariant; safecall;
    procedure Set_ControlDefault(Index: Integer; Value: OleVariant); safecall;
    function Count: Integer; safecall;
    function Get_Item(Index: Integer): OleVariant; safecall;
    procedure Set_Item(Index: Integer; Value: OleVariant); safecall;
    procedure Remove(Index: Integer); safecall;
    procedure Clear; safecall;
    function Add(Item: OleVariant): Integer; safecall;
    function _NewEnum: IUnknown; safecall;
    property ControlDefault[Index: Integer]: OleVariant read Get_ControlDefault write Set_ControlDefault; default;
    property Item[Index: Integer]: OleVariant read Get_Item write Set_Item;
  end;

{ DispInterface declaration for Dual Interface IStrings }

  IStringsDisp = dispinterface
    ['{EE05DFE2-5549-11D0-9EA9-0020AF3D82DA}']
    property ControlDefault[Index: Integer]: OleVariant dispid 0; default;
    function Count: Integer; dispid 1;
    property Item[Index: Integer]: OleVariant dispid 2;
    procedure Remove(Index: Integer); dispid 3;
    procedure Clear; dispid 4;
    function Add(Item: OleVariant): Integer; dispid 5;
    function _NewEnum: IUnknown; dispid -4;
  end;

{ Design-time interface for remote data modules }

  IDataBroker = interface(IDispatch)
    ['{6539BF65-6FE7-11D0-9E8C-00A02457621F}']
    function GetProviderNames: OleVariant; safecall;
  end;

{ DispInterface declaration for Dual Interface IDataBroker }

  IDataBrokerDisp = dispinterface
    ['{6539BF65-6FE7-11D0-9E8C-00A02457621F}']
    function GetProviderNames: OleVariant; dispid 22929905;
  end;

implementation


end.
