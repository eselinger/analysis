      subroutine GetMass(mass,at)
      implicit none
      real*8 mass
      character*2 at
      call LowCase(at)
      mass=-1.0D0
      if(at.eq.'h')  mass=1.00794D0
      if(at.eq.'d')  mass=2.00D0
      if(at.eq.'he') mass=4.003D0
      if(at.eq.'li') mass=6.941D0
      if(at.eq.'be') mass=9.012182D0
      if(at.eq.'b')  mass=10.811D0
      if(at.eq.'c')  mass=12.0107D0
      if(at.eq.'n')  mass=14.00674D0
      if(at.eq.'o')  mass=15.9994D0
      if(at.eq.'f')  mass=18.9984032D0
      if(at.eq.'ne') mass=20.1797D0
      if(at.eq.'na') mass=22.989770D0
      if(at.eq.'mg') mass=24.3050D0
      if(at.eq.'al') mass=26.981538D0
      if(at.eq.'si') mass=28.0855D0
      if(at.eq.'p')  mass=30.973761D0
      if(at.eq.'s')  mass=32.066D0
      if(at.eq.'cl') mass=35.4527D0
      if(at.eq.'ar') mass=39.948D0
      if(at.eq.'pt') mass=195.084D0
      if(at.eq.'ca') mass=40.078
      if(at.eq.'lp') mass=0.0D0
      
      if(mass.eq.-1.0D0) then
        write(*,*) "Unknown atom: ",at
        stop
      endif
      return
      end
