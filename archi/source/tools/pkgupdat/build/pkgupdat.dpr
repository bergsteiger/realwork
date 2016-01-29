(*
//
// module:  pkgupdat.dpr
// author:  Mickael P. Golovin
//
// Copyright (c) 1997-2000 by Archivarius Team, free for non commercial use.
//
// $Id: pkgupdat.dpr,v 1.4 2000/01/06 14:39:12 migel Exp $
//
*)
program PKGUpdat; {$R *.res}


 {$I m0Define.inc}
 {$I m0DefOpt.inc}


 uses
        _MemMgr,
        
        Windows,Messages,SysUtils,Consts,Classes{$IFDEF _m0USEFORMS1},Forms{$ENDIF},

        m0Const,m0AddTyp,m0EXCLib,
        mgConst,mgJouSrv,mgPKGSet;


 procedure   _Begin(
                   );
 begin

  try

   if (ParamCount() = 1)
    then
     begin

      WriteLN('Base is updating, pelase wait...');

      with TmgBasePackageSet.Create() do
       try

        Name:=ParamStr(1);
        UpdateExchange(CmgJouSrvAdmLock,False);

       finally

        Free();

       end;

      WriteLN('Update complete.');

     end;

  except

   m0EXCHandleException();

  end;

 end;


 begin _Begin();


end.

