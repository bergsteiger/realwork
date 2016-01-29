{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}


{ The passwd structure.  }
type
  passwd = record
    pw_name: MarshaledAString;      { Username.  }
    pw_passwd: MarshaledAString;    { Password.  }
    pw_uid: uid_t;                  { User ID.  }
    pw_gid: gid_t;                  { Group ID.  }
    pw_change: time_t;              { password change time }
    pw_class: MarshaledAString;     { user access class }
    pw_gecos: MarshaledAString;     { Honeywell login info  }
    pw_dir: MarshaledAString;       { Home directory.  }
    pw_shell: MarshaledAString;     { Shell program.  }
    pw_expire: time_t;              { account expiration }
  end;
  {$EXTERNALSYM passwd}
  Ppasswd = ^passwd;
