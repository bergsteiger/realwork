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
unit localreq_int;

interface

uses
  Classes,orb_int,req_int,code_int,env_int;

type

  ILocalRequest = interface(IORBRequest)
  ['{AF662CC0-4D2E-11d4-9D27-204C4F4F5020}']
    function Request(): IRequest;
  end;

implementation

end.
