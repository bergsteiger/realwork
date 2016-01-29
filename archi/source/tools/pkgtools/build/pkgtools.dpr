(*
//
// module:  pkgtools.dpr
// author:  Mickael P. Golovin
//
// Copyright (c) 1997-2000 by Archivarius Team, free for non commercial use.
//
// $Id: pkgtools.dpr,v 1.3 2000/01/06 14:39:12 migel Exp $
//
*)
program PKGTools; {$R *.res}


 {$I m0Define.inc}
 {$I m0DefOpt.inc}


 uses
        _MemMgr,

        Windows,Messages,SysUtils,Consts,Classes{$IFDEF _m0USEFORMS1},Forms{$ENDIF},

        m0Const,m0AddTyp,m0EXCLib,
        mgConst,mgJouSrv,

        PKGToolsMF in '.\..\pas\PKGToolsMF.pas';


 procedure   _Begin(
                   );
 begin

  try

   Application.Initialize();
   Application.Title:='Package Tools';
   Application.CreateForm(TMainForm,MainForm);
   Application.Run();

  except

   m0EXCHandleException();

  end;

 end;


 begin _Begin();


end.

