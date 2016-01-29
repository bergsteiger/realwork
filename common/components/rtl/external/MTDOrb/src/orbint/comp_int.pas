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
unit comp_int;

interface

uses
  orbtypes,SysUtils,Classes,{$IFDEF WIN32}winsock{$ENDIF} {$IFDEF LINUX}Libc{$ENDIF},
  code_int;

type

  IORBComponent = interface
  ['{61252F60-4D23-11d4-9D27-204C4F4F5020}']
    procedure print(s: TStream);
    procedure encode(const enc: IEncoder);
    function _id(): ComponentID;
    procedure set_id(id:ComponentID);
  end;

  ICodesetComponent = interface(IORBComponent)
  ['{61252F61-4D23-11d4-9D27-204C4F4F5020}']
    function selected_cs(): CodesetID;
    function selected_wcs(): CodesetID;
  end;

  IORBComponentDecoder = interface
  ['{61252F62-4D23-11d4-9D27-204C4F4F5020}']
    function has_id(id: ComponentID): Boolean;
    function decode(dec: IDecoder; cid: ComponentID; len: _ulong): IORBComponent;
  end;

implementation

end.
