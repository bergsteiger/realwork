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
unit value_int;

interface

uses
  orbtypes,Classes,code_int;

type

  IValueBase = interface
  ['{61252F76-4D23-11d4-9D27-204C4F4F5020}']
    function _copy_value : IValueBase;
    procedure _copy_members(const v: TObject);
    procedure _get_marshal_info(const str: TStrings;out chunked: Boolean);
    procedure _marshal_members(const enc: IEncoder);
    function  _demarshal_members(const dec: Idecoder): Boolean;
    function narrow_helper(const repoid: RepositoryId): Pointer;
  end;

  IValueFactory = interface
  ['{61252F77-4D23-11d4-9D27-204C4F4F5020}']
    function create_for_umarshal(): IValueBase;
    function narrow_helper(const repoid: RepositoryId): Pointer;
  end;

  IStringValue = interface(IValueBase)
  ['{58ACC8BD-888E-4C1E-B7AD-5AD8967BF8F1}']
    function _value : AnsiString; overload;
    procedure _value(val : AnsiString); overload;
  end;

  IWStringValue = interface(IValueBase)
  ['{621219BF-4C23-4AAB-A3C8-41D5A2F5B953}']
    function _value : widestring; overload;
    procedure _value(val : widestring); overload;
  end;

implementation

end.
