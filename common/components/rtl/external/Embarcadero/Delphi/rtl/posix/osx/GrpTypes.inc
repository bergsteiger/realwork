{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

type
  group = record
    gr_name: MarshaledAString;      { Group name.	}
    gr_passwd: MarshaledAString;    { Password.	}
    gr_gid: gid_t;                  { Group ID.	}
    gr_mem: PMarshaledAString;      { Member list.	}
  end;
  {$EXTERNALSYM group}
  Pgroup = ^group;

