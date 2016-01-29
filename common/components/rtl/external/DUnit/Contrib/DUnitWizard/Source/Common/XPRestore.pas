unit XPRestore;

{
 $Source: /export/home/cvs/common/components/rtl/external/DUnit/Contrib/DUnitWizard/Source/Common/XPRestore.pas,v $
 $Revision: 1.1 $
 $Date: 2009/03/11 15:16:49 $
 Last amended by $Author: lulin $
 $State: Exp $

 XPRestore:
 Interface and base class to allow automated saving and restoring of state
 within the current scope.

 Thanks go out to Malcolm Groves of Madrigal Technologies,
 http://www.madrigal.com.au, who brought the concept of IRestore to our
 attention.

 Copyright (c) 2001 by The Excellent Programming Company Pty Ltd
 (Australia) (ABN 27 005 394 918).

 Contact Don Macrae via email: din@xpro.com.au

 This unit is free software; you can redistribute it and/or
 modify it under the terms of the GNU Lesser General Public
 License as published by the Free Software Foundation; either
 version 2.1 of the License, or (at your option) any later version.

 This unit is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 Lesser General Public License for more details.

 You should have received a copy of the GNU Lesser General Public
 License along with this unit; if not, the license can be viewed at:
 http://www.gnu.org/copyleft/lesser.html
 or write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 Boston, MA  02111-1307  USA
}

interface

type

  IXPRestore = interface
    end;

  TXPRestore = class( TInterfacedObject, IXPRestore )
    end;

implementation

const CVSID: string = '$Header: /export/home/cvs/common/components/rtl/external/DUnit/Contrib/DUnitWizard/Source/Common/XPRestore.pas,v 1.1 2009/03/11 15:16:49 lulin Exp $';

end.


