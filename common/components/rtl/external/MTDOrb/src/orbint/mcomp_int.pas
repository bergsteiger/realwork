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
unit mcomp_int;

interface

uses
  orbtypes,code_int,iior_int,comp_int;

type

  IMultiComponent = interface;

  IMultiComponentProfile = interface(IIORProfile)
  ['{094BE462-218A-11d4-9CCE-204C4F4F5020}']
  end;

  IMultiComponent = interface(IORBComponent)
  ['{094BE461-218A-11d4-9CCE-204C4F4F5020}']
    function decode(const dec: IDecoder): Boolean;
    procedure add_component(const comp : IORBComponent);
    function get_component(id: ComponentID): IORBComponent;
    procedure Clear();
    function size: _ulong;
  end;

implementation

end.
