// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit iior_int;

interface

uses
  orbtypes,Classes,addr_int,code_int,SysUtils;

type

  IIORProfile = interface
  ['{02F45D6A-203A-11d4-9CCB-204C4F4F5020}']
    function address(): IAddress;
    function clone(): IIORProfile;
    procedure encode(const enc: IEncoder);
    function id(): ProfileId;
    function encode_id(): ProfileId;
    function objkeylen: _ulong;
    function objkey(var len: _ulong): Identifier;
    procedure set_objectkey(const val: Identifier; const len : _ulong);
    procedure print(s: TStream);
    function reachable(): boolean;
    function compare(const p: IIORProfile): boolean;
    function get_components(): IInterface;
  end;

  IIORProfileDecoder = interface
  ['{02F45D6B-203A-11d4-9CCB-204C4F4F5020}']
    function has_id(id: ProfileID): Boolean;
    function decode(const dec: IDecoder;pid: ProfileID;len : _ulong): IIORProfile;
  end;

  {**
    Describes Interoperable Object Reference
  **}
  IIOR = interface
  ['{02F45D6C-203A-11d4-9CCB-204C4F4F5020}']
    procedure clean();
    procedure add_profile(const prof : IIORProfile);
    function decode(const dec: IDecoder): Boolean;
    procedure encode(const enc: IEncoder);
    function from_string(const Value: AnsiString): Boolean;
    function get_profile(id: ProfileID = TAG_ANY; find_unreachable: boolean = false; prev: IIORProfile = nil): IIORProfile;
    function address(id: ProfileID = TAG_ANY; find_unreachable: boolean = false; prev: IIORProfile = nil): IAddress;
    function active_profile(var AIndex: _ulong): IIORProfile; overload;
    procedure active_profile(const AProfile: IIORProfile); overload;
    function addressing_disposition(): AddressingDisposition; overload;
    procedure addressing_disposition(const AddrDisp: AddressingDisposition); overload;
    function objid: AnsiString;
    procedure print(s : TStream);
    function profile(ind: _ulong): IIORProfile;
    procedure set_objectkey(const key: AnsiString; const len: _ulong);
    procedure set_objectid(const oid: AnsiString);
    function size: integer;
    function stringify: AnsiString;
  end;

  IUnknownProfile = interface(IIORProfile)
  ['{1070DE2C-CB15-4D70-830C-AE958F37FD38}']
    function tagdata: OctetSeq;
  end;

implementation

end.
