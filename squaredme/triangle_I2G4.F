#if 0
* triangle_I2G4.F
* form factors for {S[1, {i}]} -> {S[1, {j}], S[1, {k}]}
* generated by FormCalc 9.9 (7 Jun 2021) on 29-Jul-2021 17:48
#endif

#include "vars.h"
#include "inline.h"
#include "contains.h"


	subroutine triangle_I2G4
	implicit none

#include "vars.h"
#include "inline.h"

	Cloop(1) = Cloop(1) + 
     &    1/Pi**2*(g2**4*v1*
     &       ((-(1/128.D0*(C0i5(Epsi(cc2),I2G4)*
     &                 (Masshh(i)**2 + 3*Masshh(j)**2 - 
     &                   Masshh(k)**2))) + 
     &            1/64.D0*(-B0i5(Epsi(bb0)) + 
     &               C0i5(Epsi(cc1),I2G4)*(Masshh(i) - Masshh(j))*
     &                (Masshh(i) + Masshh(j)) - 
     &               C0i5(Epsi(cc0),I2G4)*
     &                (Masshh(i)**2 + 2*Masshh(j)**2 - 
     &                  Masshh(k)**2 + MassHm(I2G4)**2)))*
     &          Sub274(I2G4)*Sub8(I2G4)*ZH(k,1) + 
     &         (1/64.D0*(-(B0i6(Epsi(bb0),I2G4)*Sub2388(I2G4)) - 
     &               C0i6(Epsi(cc1),I2G4)*
     &                (Masshh(i)**2 + 2*Masshh(j)**2 - 
     &                  2*Masshh(k)**2)*Sub274(I2G4)*ZH(i,1)) + 
     &            (1/128.D0*(C0i6(Epsi(cc2),I2G4)*
     &                  (Masshh(i)**2 - 7*Masshh(j)**2 - 
     &                    Masshh(k)**2)) - 
     &               1/64.D0*
     &                (C0i6(Epsi(cc0),I2G4)*
     &                  (MassVWm**2 - Masshh(i)**2 + 
     &                    3*Masshh(j)**2 + Masshh(k)**2)))*
     &             Sub274(I2G4)*ZH(i,1) - 
     &            (1/128.D0*(C0i7(Epsi(cc2),I2G4)*
     &                  (7*Masshh(i)**2 - Masshh(j)**2 + 
     &                    Masshh(k)**2)) + 
     &               1/64.D0*
     &                (C0i7(Epsi(cc1),I2G4)*
     &                   (2*Masshh(i)**2 + Masshh(j)**2 - 
     &                     2*Masshh(k)**2) + 
     &                  C0i7(Epsi(cc0),I2G4)*
     &                   (MassVWm**2 + 3*Masshh(i)**2 - 
     &                     Masshh(j)**2 + Masshh(k)**2)))*
     &             Sub8(I2G4)*ZH(j,1))*
     &          (ZH(k,1)*ZP(I2G4,1) + ZH(k,2)*ZP(I2G4,2))))

#if DEBUG >= 4
	DEB("triangle_I2G4:Cloop(1)", Cloop(1))
#endif

#include "contains.h"

	end

