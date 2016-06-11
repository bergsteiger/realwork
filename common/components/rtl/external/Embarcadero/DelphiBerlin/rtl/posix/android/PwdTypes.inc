{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}


{ The passwd structure.  }
type
  passwd = {packed} record
    pw_name: PAnsiChar;             { Username.  }
    pw_passwd: PAnsiChar;           { Password.  }
    pw_uid: uid_t;                  { User ID.  }
    pw_gid: gid_t;                  { Group ID.  }    
    pw_dir: PAnsiChar;              { Home directory.  }
    pw_shell: PAnsiChar;            { Shell program.  }
  end;
  {$EXTERNALSYM passwd}
  Ppasswd = ^passwd;
