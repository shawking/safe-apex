#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Environment
MKDIR=mkdir
CP=cp
GREP=grep
NM=nm
CCADMIN=CCadmin
RANLIB=ranlib
CC=gcc
CCC=g++
CXX=g++
FC=gfortran
AS=as

# Macros
CND_PLATFORM=GNU-Linux
CND_DLIB_EXT=so
CND_CONF=Release
CND_DISTDIR=dist
CND_BUILDDIR=build

# Include project Makefile
include Makefile

# Object Directory
OBJECTDIR=${CND_BUILDDIR}/${CND_CONF}/${CND_PLATFORM}

# Object Files
OBJECTFILES= \
	${OBJECTDIR}/src/ACOUT.o \
	${OBJECTDIR}/src/ADAJ.o \
	${OBJECTDIR}/src/ADEALLOCATE.o \
	${OBJECTDIR}/src/ADSTN.o \
	${OBJECTDIR}/src/AEXINT.o \
	${OBJECTDIR}/src/AHEAD.o \
	${OBJECTDIR}/src/AICL.o \
	${OBJECTDIR}/src/AINIX.o \
	${OBJECTDIR}/src/AINLZ.o \
	${OBJECTDIR}/src/AINTRI.o \
	${OBJECTDIR}/src/AINTRIC.o \
	${OBJECTDIR}/src/AINTRO.o \
	${OBJECTDIR}/src/AINTRX.o \
	${OBJECTDIR}/src/AISHFL.o \
	${OBJECTDIR}/src/AISPL.o \
	${OBJECTDIR}/src/ALLOCATE_PARMS.o \
	${OBJECTDIR}/src/ALPYR.o \
	${OBJECTDIR}/src/APAGE.o \
	${OBJECTDIR}/src/APRNTD.o \
	${OBJECTDIR}/src/ARALT.o \
	${OBJECTDIR}/src/ARESET.o \
	${OBJECTDIR}/src/ASCRV.o \
	${OBJECTDIR}/src/ASORT1.o \
	${OBJECTDIR}/src/ASORT3.o \
	${OBJECTDIR}/src/ASORTI.o \
	${OBJECTDIR}/src/ASPLT.o \
	${OBJECTDIR}/src/ASVP.o \
	${OBJECTDIR}/src/ATIMER.o \
	${OBJECTDIR}/src/ATRI.o \
	${OBJECTDIR}/src/ATRIDIAG.o \
	${OBJECTDIR}/src/AUNIF.o \
	${OBJECTDIR}/src/AXMON.o \
	${OBJECTDIR}/src/BSIM.o \
	${OBJECTDIR}/src/BSUB.o \
	${OBJECTDIR}/src/CAGRO.o \
	${OBJECTDIR}/src/CAHU.o \
	${OBJECTDIR}/src/CCONI.o \
	${OBJECTDIR}/src/CFRG.o \
	${OBJECTDIR}/src/CGROW.o \
	${OBJECTDIR}/src/CPTBL.o \
	${OBJECTDIR}/src/CRGBD.o \
	${OBJECTDIR}/src/CROP.o \
	${OBJECTDIR}/src/CRPIO.o \
	${OBJECTDIR}/src/CSTRS.o \
	${OBJECTDIR}/src/DUSTDST.o \
	${OBJECTDIR}/src/DUSTEM.o \
	${OBJECTDIR}/src/EAJL.o \
	${OBJECTDIR}/src/EBUFSA.o \
	${OBJECTDIR}/src/EHYD.o \
	${OBJECTDIR}/src/ERHEM.o \
	${OBJECTDIR}/src/EROWN.o \
	${OBJECTDIR}/src/ESLOS.o \
	${OBJECTDIR}/src/EWEMHKS.o \
	${OBJECTDIR}/src/EWER.o \
	${OBJECTDIR}/src/EWIK.o \
	${OBJECTDIR}/src/EWNINT.o \
	${OBJECTDIR}/src/EYCC.o \
	${OBJECTDIR}/src/EYSED.o \
	${OBJECTDIR}/src/GASDF3.o \
	${OBJECTDIR}/src/GASTRANS2.o \
	${OBJECTDIR}/src/HCNSLP.o \
	${OBJECTDIR}/src/HEVP.o \
	${OBJECTDIR}/src/HFPF.o \
	${OBJECTDIR}/src/HFURD.o \
	${OBJECTDIR}/src/HGASP.o \
	${OBJECTDIR}/src/HGAWY.o \
	${OBJECTDIR}/src/HGWST.o \
	${OBJECTDIR}/src/HIRG.o \
	${OBJECTDIR}/src/HLGB.o \
	${OBJECTDIR}/src/HLGOON.o \
	${OBJECTDIR}/src/HPERC.o \
	${OBJECTDIR}/src/HPERC1.o \
	${OBJECTDIR}/src/HPURK.o \
	${OBJECTDIR}/src/HQDAV.o \
	${OBJECTDIR}/src/HQP.o \
	${OBJECTDIR}/src/HREXP.o \
	${OBJECTDIR}/src/HRFDT.o \
	${OBJECTDIR}/src/HRFDTQ.o \
	${OBJECTDIR}/src/HRFDTS.o \
	${OBJECTDIR}/src/HRFEI.o \
	${OBJECTDIR}/src/HRFIN.o \
	${OBJECTDIR}/src/HRUNF.o \
	${OBJECTDIR}/src/HSGCN.o \
	${OBJECTDIR}/src/HSNOM.o \
	${OBJECTDIR}/src/HSWBL.o \
	${OBJECTDIR}/src/HSWBLD.o \
	${OBJECTDIR}/src/HSWU.o \
	${OBJECTDIR}/src/HTR55.o \
	${OBJECTDIR}/src/HUSE.o \
	${OBJECTDIR}/src/HVOLQ.o \
	${OBJECTDIR}/src/HWTBL.o \
	${OBJECTDIR}/src/HYDUNT.o \
	${OBJECTDIR}/src/ICECALC.o \
	${OBJECTDIR}/src/INIFP.o \
	${OBJECTDIR}/src/MAIN_1501.o \
	${OBJECTDIR}/src/NAJN.o \
	${OBJECTDIR}/src/NBL.o \
	${OBJECTDIR}/src/NCBL.o \
	${OBJECTDIR}/src/NCCONC.o \
	${OBJECTDIR}/src/NCNMI_CENTURY.o \
	${OBJECTDIR}/src/NCNMI_PHOENIX.o \
	${OBJECTDIR}/src/NCNSTD.o \
	${OBJECTDIR}/src/NCONC.o \
	${OBJECTDIR}/src/NCONT.o \
	${OBJECTDIR}/src/NCQYL.o \
	${OBJECTDIR}/src/NDNIT.o \
	${OBJECTDIR}/src/NDNITAK.o \
	${OBJECTDIR}/src/NDNITCI.o \
	${OBJECTDIR}/src/NEVN.o \
	${OBJECTDIR}/src/NEVP.o \
	${OBJECTDIR}/src/NFERT-PADDY.o \
	${OBJECTDIR}/src/NFERT.o \
	${OBJECTDIR}/src/NFIX.o \
	${OBJECTDIR}/src/NFTBL.o \
	${OBJECTDIR}/src/NITVOL.o \
	${OBJECTDIR}/src/NKMIN.o \
	${OBJECTDIR}/src/NKUP.o \
	${OBJECTDIR}/src/NLCH.o \
	${OBJECTDIR}/src/NLGB.o \
	${OBJECTDIR}/src/NLIMA.o \
	${OBJECTDIR}/src/NLIME.o \
	${OBJECTDIR}/src/NMULCH.o \
	${OBJECTDIR}/src/NPCY.o \
	${OBJECTDIR}/src/NPMIN.o \
	${OBJECTDIR}/src/NPMN.o \
	${OBJECTDIR}/src/NPUP.o \
	${OBJECTDIR}/src/NRSPC.o \
	${OBJECTDIR}/src/NSTDFAL.o \
	${OBJECTDIR}/src/NUP.o \
	${OBJECTDIR}/src/NUSE.o \
	${OBJECTDIR}/src/NUTS.o \
	${OBJECTDIR}/src/NYNIT.o \
	${OBJECTDIR}/src/NYON.o \
	${OBJECTDIR}/src/NYPA.o \
	${OBJECTDIR}/src/OPENF.o \
	${OBJECTDIR}/src/OPENV.o \
	${OBJECTDIR}/src/PADDY_WQ.o \
	${OBJECTDIR}/src/PESTF.o \
	${OBJECTDIR}/src/PSTAPP.o \
	${OBJECTDIR}/src/PSTCY.o \
	${OBJECTDIR}/src/PSTEV.o \
	${OBJECTDIR}/src/PSTSUM.o \
	${OBJECTDIR}/src/PSTTBL.o \
	${OBJECTDIR}/src/RATECVM_CM.o \
	${OBJECTDIR}/src/RESPOND.o \
	${OBJECTDIR}/src/RESPQB.o \
	${OBJECTDIR}/src/RESQB.o \
	${OBJECTDIR}/src/RESRT.o \
	${OBJECTDIR}/src/RESYB.o \
	${OBJECTDIR}/src/ROUTE.o \
	${OBJECTDIR}/src/RTADD.o \
	${OBJECTDIR}/src/RTMCCEL.o \
	${OBJECTDIR}/src/RTM_CVC.o \
	${OBJECTDIR}/src/RTM_CVC4.o \
	${OBJECTDIR}/src/RTSED.o \
	${OBJECTDIR}/src/RTSVS.o \
	${OBJECTDIR}/src/RTVSC.o \
	${OBJECTDIR}/src/RTYNP.o \
	${OBJECTDIR}/src/SAJBD.o \
	${OBJECTDIR}/src/SBDSC.o \
	${OBJECTDIR}/src/SDST.o \
	${OBJECTDIR}/src/SLTB.o \
	${OBJECTDIR}/src/SOCIOA.o \
	${OBJECTDIR}/src/SOCIOD.o \
	${OBJECTDIR}/src/SOIL_BDCD.o \
	${OBJECTDIR}/src/SOLIOC.o \
	${OBJECTDIR}/src/SOLIOP.o \
	${OBJECTDIR}/src/SOLT.o \
	${OBJECTDIR}/src/SPLA.o \
	${OBJECTDIR}/src/SPOFC.o \
	${OBJECTDIR}/src/SPRNT.o \
	${OBJECTDIR}/src/SWN1530.o \
	${OBJECTDIR}/src/SWNN.o \
	${OBJECTDIR}/src/SWRTNNW.o \
	${OBJECTDIR}/src/SWRTNR.o \
	${OBJECTDIR}/src/SWRTN_BNW.o \
	${OBJECTDIR}/src/SWTN.o \
	${OBJECTDIR}/src/TBURN.o \
	${OBJECTDIR}/src/TGRAZ.o \
	${OBJECTDIR}/src/THVOR.o \
	${OBJECTDIR}/src/THVRT.o \
	${OBJECTDIR}/src/TILTBL.o \
	${OBJECTDIR}/src/TLOP.o \
	${OBJECTDIR}/src/TMIX.o \
	${OBJECTDIR}/src/TMIX_FLOODED.o \
	${OBJECTDIR}/src/TMXL1.o \
	${OBJECTDIR}/src/TRDST.o \
	${OBJECTDIR}/src/WDLYSTA.o \
	${OBJECTDIR}/src/WGN.o \
	${OBJECTDIR}/src/WHLRMX.o \
	${OBJECTDIR}/src/WNDIR.o \
	${OBJECTDIR}/src/WNSPD.o \
	${OBJECTDIR}/src/WRAIN.o \
	${OBJECTDIR}/src/WREAD.o \
	${OBJECTDIR}/src/WRLHUM.o \
	${OBJECTDIR}/src/WRWD.o \
	${OBJECTDIR}/src/WSOLRA.o \
	${OBJECTDIR}/src/WTAIR.o \
	${OBJECTDIR}/src/WTAIX.o \
	${OBJECTDIR}/src/modparm.o


# C Compiler Flags
CFLAGS=

# CC Compiler Flags
CCFLAGS=
CXXFLAGS=

# Fortran Compiler Flags
FFLAGS=

# Assembler Flags
ASFLAGS=

# Link Libraries and Options
LDLIBSOPTIONS=

# Build Targets
.build-conf: ${BUILD_SUBPROJECTS}
	"${MAKE}"  -f nbproject/Makefile-${CND_CONF}.mk ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/apex1501

${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/apex1501: ${OBJECTFILES}
	${MKDIR} -p ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}
	${LINK.f} -o ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/apex1501 ${OBJECTFILES} ${LDLIBSOPTIONS}

${OBJECTDIR}/src/ACOUT.o: src/ACOUT.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ACOUT.o src/ACOUT.f90

${OBJECTDIR}/src/ADAJ.o: src/ADAJ.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ADAJ.o src/ADAJ.f90

${OBJECTDIR}/src/ADEALLOCATE.o: src/ADEALLOCATE.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ADEALLOCATE.o src/ADEALLOCATE.f90

${OBJECTDIR}/src/ADSTN.o: src/ADSTN.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ADSTN.o src/ADSTN.f90

${OBJECTDIR}/src/AEXINT.o: src/AEXINT.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/AEXINT.o src/AEXINT.f90

${OBJECTDIR}/src/AHEAD.o: src/AHEAD.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/AHEAD.o src/AHEAD.f90

${OBJECTDIR}/src/AICL.o: src/AICL.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/AICL.o src/AICL.f90

${OBJECTDIR}/src/AINIX.o: src/AINIX.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/AINIX.o src/AINIX.f90

${OBJECTDIR}/src/AINLZ.o: src/AINLZ.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/AINLZ.o src/AINLZ.f90

${OBJECTDIR}/src/AINTRI.o: src/AINTRI.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/AINTRI.o src/AINTRI.f90

${OBJECTDIR}/src/AINTRIC.o: src/AINTRIC.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/AINTRIC.o src/AINTRIC.f90

${OBJECTDIR}/src/AINTRO.o: src/AINTRO.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/AINTRO.o src/AINTRO.f90

${OBJECTDIR}/src/AINTRX.o: src/AINTRX.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/AINTRX.o src/AINTRX.f90

${OBJECTDIR}/src/AISHFL.o: src/AISHFL.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/AISHFL.o src/AISHFL.f90

${OBJECTDIR}/src/AISPL.o: src/AISPL.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/AISPL.o src/AISPL.f90

${OBJECTDIR}/src/ALLOCATE_PARMS.o: src/ALLOCATE_PARMS.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ALLOCATE_PARMS.o src/ALLOCATE_PARMS.f90

${OBJECTDIR}/src/ALPYR.o: src/ALPYR.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ALPYR.o src/ALPYR.f90

${OBJECTDIR}/src/APAGE.o: src/APAGE.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/APAGE.o src/APAGE.f90

${OBJECTDIR}/src/APRNTD.o: src/APRNTD.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/APRNTD.o src/APRNTD.f90

${OBJECTDIR}/src/ARALT.o: src/ARALT.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ARALT.o src/ARALT.f90

${OBJECTDIR}/src/ARESET.o: src/ARESET.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ARESET.o src/ARESET.f90

${OBJECTDIR}/src/ASCRV.o: src/ASCRV.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ASCRV.o src/ASCRV.f90

${OBJECTDIR}/src/ASORT1.o: src/ASORT1.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ASORT1.o src/ASORT1.f90

${OBJECTDIR}/src/ASORT3.o: src/ASORT3.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ASORT3.o src/ASORT3.f90

${OBJECTDIR}/src/ASORTI.o: src/ASORTI.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ASORTI.o src/ASORTI.f90

${OBJECTDIR}/src/ASPLT.o: src/ASPLT.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ASPLT.o src/ASPLT.f90

${OBJECTDIR}/src/ASVP.o: src/ASVP.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ASVP.o src/ASVP.f90

${OBJECTDIR}/src/ATIMER.o: src/ATIMER.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ATIMER.o src/ATIMER.f90

${OBJECTDIR}/src/ATRI.o: src/ATRI.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ATRI.o src/ATRI.f90

${OBJECTDIR}/src/ATRIDIAG.o: src/ATRIDIAG.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ATRIDIAG.o src/ATRIDIAG.f90

${OBJECTDIR}/src/AUNIF.o: src/AUNIF.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/AUNIF.o src/AUNIF.f90

${OBJECTDIR}/src/AXMON.o: src/AXMON.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/AXMON.o src/AXMON.f90

${OBJECTDIR}/src/BSIM.o: src/BSIM.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/BSIM.o src/BSIM.f90

${OBJECTDIR}/src/BSUB.o: src/BSUB.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/BSUB.o src/BSUB.f90

${OBJECTDIR}/src/CAGRO.o: src/CAGRO.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/CAGRO.o src/CAGRO.f90

${OBJECTDIR}/src/CAHU.o: src/CAHU.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/CAHU.o src/CAHU.f90

${OBJECTDIR}/src/CCONI.o: src/CCONI.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/CCONI.o src/CCONI.f90

${OBJECTDIR}/src/CFRG.o: src/CFRG.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/CFRG.o src/CFRG.f90

${OBJECTDIR}/src/CGROW.o: src/CGROW.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/CGROW.o src/CGROW.f90

${OBJECTDIR}/src/CPTBL.o: src/CPTBL.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/CPTBL.o src/CPTBL.f90

${OBJECTDIR}/src/CRGBD.o: src/CRGBD.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/CRGBD.o src/CRGBD.f90

${OBJECTDIR}/src/CROP.o: src/CROP.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/CROP.o src/CROP.f90

${OBJECTDIR}/src/CRPIO.o: src/CRPIO.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/CRPIO.o src/CRPIO.f90

${OBJECTDIR}/src/CSTRS.o: src/CSTRS.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/CSTRS.o src/CSTRS.f90

${OBJECTDIR}/src/DUSTDST.o: src/DUSTDST.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/DUSTDST.o src/DUSTDST.f90

${OBJECTDIR}/src/DUSTEM.o: src/DUSTEM.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/DUSTEM.o src/DUSTEM.f90

${OBJECTDIR}/src/EAJL.o: src/EAJL.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/EAJL.o src/EAJL.f90

${OBJECTDIR}/src/EBUFSA.o: src/EBUFSA.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/EBUFSA.o src/EBUFSA.f90

${OBJECTDIR}/src/EHYD.o: src/EHYD.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/EHYD.o src/EHYD.f90

${OBJECTDIR}/src/ERHEM.o: src/ERHEM.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ERHEM.o src/ERHEM.f90

${OBJECTDIR}/src/EROWN.o: src/EROWN.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/EROWN.o src/EROWN.f90

${OBJECTDIR}/src/ESLOS.o: src/ESLOS.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ESLOS.o src/ESLOS.f90

${OBJECTDIR}/src/EWEMHKS.o: src/EWEMHKS.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/EWEMHKS.o src/EWEMHKS.f90

${OBJECTDIR}/src/EWER.o: src/EWER.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/EWER.o src/EWER.f90

${OBJECTDIR}/src/EWIK.o: src/EWIK.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/EWIK.o src/EWIK.f90

${OBJECTDIR}/src/EWNINT.o: src/EWNINT.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/EWNINT.o src/EWNINT.f90

${OBJECTDIR}/src/EYCC.o: src/EYCC.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/EYCC.o src/EYCC.f90

${OBJECTDIR}/src/EYSED.o: src/EYSED.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/EYSED.o src/EYSED.f90

${OBJECTDIR}/src/GASDF3.o: src/GASDF3.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/GASDF3.o src/GASDF3.f90

${OBJECTDIR}/src/GASTRANS2.o: src/GASTRANS2.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/GASTRANS2.o src/GASTRANS2.f90

${OBJECTDIR}/src/HCNSLP.o: src/HCNSLP.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HCNSLP.o src/HCNSLP.f90

${OBJECTDIR}/src/HEVP.o: src/HEVP.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HEVP.o src/HEVP.f90

${OBJECTDIR}/src/HFPF.o: src/HFPF.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HFPF.o src/HFPF.f90

${OBJECTDIR}/src/HFURD.o: src/HFURD.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HFURD.o src/HFURD.f90

${OBJECTDIR}/src/HGASP.o: src/HGASP.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HGASP.o src/HGASP.f90

${OBJECTDIR}/src/HGAWY.o: src/HGAWY.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HGAWY.o src/HGAWY.f90

${OBJECTDIR}/src/HGWST.o: src/HGWST.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HGWST.o src/HGWST.f90

${OBJECTDIR}/src/HIRG.o: src/HIRG.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HIRG.o src/HIRG.f90

${OBJECTDIR}/src/HLGB.o: src/HLGB.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HLGB.o src/HLGB.f90

${OBJECTDIR}/src/HLGOON.o: src/HLGOON.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HLGOON.o src/HLGOON.f90

${OBJECTDIR}/src/HPERC.o: src/HPERC.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HPERC.o src/HPERC.f90

${OBJECTDIR}/src/HPERC1.o: src/HPERC1.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HPERC1.o src/HPERC1.f90

${OBJECTDIR}/src/HPURK.o: src/HPURK.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HPURK.o src/HPURK.f90

${OBJECTDIR}/src/HQDAV.o: src/HQDAV.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HQDAV.o src/HQDAV.f90

${OBJECTDIR}/src/HQP.o: src/HQP.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HQP.o src/HQP.f90

${OBJECTDIR}/src/HREXP.o: src/HREXP.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HREXP.o src/HREXP.f90

${OBJECTDIR}/src/HRFDT.o: src/HRFDT.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HRFDT.o src/HRFDT.f90

${OBJECTDIR}/src/HRFDTQ.o: src/HRFDTQ.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HRFDTQ.o src/HRFDTQ.f90

${OBJECTDIR}/src/HRFDTS.o: src/HRFDTS.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HRFDTS.o src/HRFDTS.f90

${OBJECTDIR}/src/HRFEI.o: src/HRFEI.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HRFEI.o src/HRFEI.f90

${OBJECTDIR}/src/HRFIN.o: src/HRFIN.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HRFIN.o src/HRFIN.f90

${OBJECTDIR}/src/HRUNF.o: src/HRUNF.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HRUNF.o src/HRUNF.f90

${OBJECTDIR}/src/HSGCN.o: src/HSGCN.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HSGCN.o src/HSGCN.f90

${OBJECTDIR}/src/HSNOM.o: src/HSNOM.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HSNOM.o src/HSNOM.f90

${OBJECTDIR}/src/HSWBL.o: src/HSWBL.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HSWBL.o src/HSWBL.f90

${OBJECTDIR}/src/HSWBLD.o: src/HSWBLD.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HSWBLD.o src/HSWBLD.f90

${OBJECTDIR}/src/HSWU.o: src/HSWU.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HSWU.o src/HSWU.f90

${OBJECTDIR}/src/HTR55.o: src/HTR55.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HTR55.o src/HTR55.f90

${OBJECTDIR}/src/HUSE.o: src/HUSE.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HUSE.o src/HUSE.f90

${OBJECTDIR}/src/HVOLQ.o: src/HVOLQ.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HVOLQ.o src/HVOLQ.f90

${OBJECTDIR}/src/HWTBL.o: src/HWTBL.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HWTBL.o src/HWTBL.f90

${OBJECTDIR}/src/HYDUNT.o: src/HYDUNT.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/HYDUNT.o src/HYDUNT.f90

${OBJECTDIR}/src/ICECALC.o: src/ICECALC.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ICECALC.o src/ICECALC.f90

${OBJECTDIR}/src/INIFP.o: src/INIFP.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/INIFP.o src/INIFP.f90

${OBJECTDIR}/src/MAIN_1501.o: src/MAIN_1501.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/MAIN_1501.o src/MAIN_1501.f90

${OBJECTDIR}/src/NAJN.o: src/NAJN.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NAJN.o src/NAJN.f90

${OBJECTDIR}/src/NBL.o: src/NBL.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NBL.o src/NBL.f90

${OBJECTDIR}/src/NCBL.o: src/NCBL.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NCBL.o src/NCBL.f90

${OBJECTDIR}/src/NCCONC.o: src/NCCONC.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NCCONC.o src/NCCONC.f90

${OBJECTDIR}/src/NCNMI_CENTURY.o: src/NCNMI_CENTURY.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NCNMI_CENTURY.o src/NCNMI_CENTURY.f90

${OBJECTDIR}/src/NCNMI_PHOENIX.o: src/NCNMI_PHOENIX.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NCNMI_PHOENIX.o src/NCNMI_PHOENIX.f90

${OBJECTDIR}/src/NCNSTD.o: src/NCNSTD.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NCNSTD.o src/NCNSTD.f90

${OBJECTDIR}/src/NCONC.o: src/NCONC.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NCONC.o src/NCONC.f90

${OBJECTDIR}/src/NCONT.o: src/NCONT.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NCONT.o src/NCONT.f90

${OBJECTDIR}/src/NCQYL.o: src/NCQYL.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NCQYL.o src/NCQYL.f90

${OBJECTDIR}/src/NDNIT.o: src/NDNIT.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NDNIT.o src/NDNIT.f90

${OBJECTDIR}/src/NDNITAK.o: src/NDNITAK.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NDNITAK.o src/NDNITAK.f90

${OBJECTDIR}/src/NDNITCI.o: src/NDNITCI.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NDNITCI.o src/NDNITCI.f90

${OBJECTDIR}/src/NEVN.o: src/NEVN.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NEVN.o src/NEVN.f90

${OBJECTDIR}/src/NEVP.o: src/NEVP.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NEVP.o src/NEVP.f90

${OBJECTDIR}/src/NFERT-PADDY.o: src/NFERT-PADDY.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NFERT-PADDY.o src/NFERT-PADDY.f90

${OBJECTDIR}/src/NFERT.o: src/NFERT.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NFERT.o src/NFERT.f90

${OBJECTDIR}/src/NFIX.o: src/NFIX.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NFIX.o src/NFIX.f90

${OBJECTDIR}/src/NFTBL.o: src/NFTBL.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NFTBL.o src/NFTBL.f90

${OBJECTDIR}/src/NITVOL.o: src/NITVOL.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NITVOL.o src/NITVOL.f90

${OBJECTDIR}/src/NKMIN.o: src/NKMIN.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NKMIN.o src/NKMIN.f90

${OBJECTDIR}/src/NKUP.o: src/NKUP.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NKUP.o src/NKUP.f90

${OBJECTDIR}/src/NLCH.o: src/NLCH.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NLCH.o src/NLCH.f90

${OBJECTDIR}/src/NLGB.o: src/NLGB.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NLGB.o src/NLGB.f90

${OBJECTDIR}/src/NLIMA.o: src/NLIMA.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NLIMA.o src/NLIMA.f90

${OBJECTDIR}/src/NLIME.o: src/NLIME.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NLIME.o src/NLIME.f90

${OBJECTDIR}/src/NMULCH.o: src/NMULCH.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NMULCH.o src/NMULCH.f90

${OBJECTDIR}/src/NPCY.o: src/NPCY.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NPCY.o src/NPCY.f90

${OBJECTDIR}/src/NPMIN.o: src/NPMIN.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NPMIN.o src/NPMIN.f90

${OBJECTDIR}/src/NPMN.o: src/NPMN.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NPMN.o src/NPMN.f90

${OBJECTDIR}/src/NPUP.o: src/NPUP.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NPUP.o src/NPUP.f90

${OBJECTDIR}/src/NRSPC.o: src/NRSPC.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NRSPC.o src/NRSPC.f90

${OBJECTDIR}/src/NSTDFAL.o: src/NSTDFAL.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NSTDFAL.o src/NSTDFAL.f90

${OBJECTDIR}/src/NUP.o: src/NUP.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NUP.o src/NUP.f90

${OBJECTDIR}/src/NUSE.o: src/NUSE.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NUSE.o src/NUSE.f90

${OBJECTDIR}/src/NUTS.o: src/NUTS.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NUTS.o src/NUTS.f90

${OBJECTDIR}/src/NYNIT.o: src/NYNIT.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NYNIT.o src/NYNIT.f90

${OBJECTDIR}/src/NYON.o: src/NYON.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NYON.o src/NYON.f90

${OBJECTDIR}/src/NYPA.o: src/NYPA.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/NYPA.o src/NYPA.f90

${OBJECTDIR}/src/OPENF.o: src/OPENF.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/OPENF.o src/OPENF.f90

${OBJECTDIR}/src/OPENV.o: src/OPENV.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/OPENV.o src/OPENV.f90

${OBJECTDIR}/src/PADDY_WQ.o: src/PADDY_WQ.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/PADDY_WQ.o src/PADDY_WQ.f90

${OBJECTDIR}/src/PESTF.o: src/PESTF.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/PESTF.o src/PESTF.f90

${OBJECTDIR}/src/PSTAPP.o: src/PSTAPP.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/PSTAPP.o src/PSTAPP.f90

${OBJECTDIR}/src/PSTCY.o: src/PSTCY.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/PSTCY.o src/PSTCY.f90

${OBJECTDIR}/src/PSTEV.o: src/PSTEV.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/PSTEV.o src/PSTEV.f90

${OBJECTDIR}/src/PSTSUM.o: src/PSTSUM.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/PSTSUM.o src/PSTSUM.f90

${OBJECTDIR}/src/PSTTBL.o: src/PSTTBL.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/PSTTBL.o src/PSTTBL.f90

${OBJECTDIR}/src/RATECVM_CM.o: src/RATECVM_CM.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/RATECVM_CM.o src/RATECVM_CM.f90

${OBJECTDIR}/src/RESPOND.o: src/RESPOND.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/RESPOND.o src/RESPOND.f90

${OBJECTDIR}/src/RESPQB.o: src/RESPQB.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/RESPQB.o src/RESPQB.f90

${OBJECTDIR}/src/RESQB.o: src/RESQB.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/RESQB.o src/RESQB.f90

${OBJECTDIR}/src/RESRT.o: src/RESRT.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/RESRT.o src/RESRT.f90

${OBJECTDIR}/src/RESYB.o: src/RESYB.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/RESYB.o src/RESYB.f90

${OBJECTDIR}/src/ROUTE.o: src/ROUTE.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/ROUTE.o src/ROUTE.f90

${OBJECTDIR}/src/RTADD.o: src/RTADD.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/RTADD.o src/RTADD.f90

${OBJECTDIR}/src/RTMCCEL.o: src/RTMCCEL.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/RTMCCEL.o src/RTMCCEL.f90

${OBJECTDIR}/src/RTM_CVC.o: src/RTM_CVC.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/RTM_CVC.o src/RTM_CVC.f90

${OBJECTDIR}/src/RTM_CVC4.o: src/RTM_CVC4.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/RTM_CVC4.o src/RTM_CVC4.f90

${OBJECTDIR}/src/RTSED.o: src/RTSED.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/RTSED.o src/RTSED.f90

${OBJECTDIR}/src/RTSVS.o: src/RTSVS.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/RTSVS.o src/RTSVS.f90

${OBJECTDIR}/src/RTVSC.o: src/RTVSC.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/RTVSC.o src/RTVSC.f90

${OBJECTDIR}/src/RTYNP.o: src/RTYNP.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/RTYNP.o src/RTYNP.f90

${OBJECTDIR}/src/SAJBD.o: src/SAJBD.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/SAJBD.o src/SAJBD.f90

${OBJECTDIR}/src/SBDSC.o: src/SBDSC.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/SBDSC.o src/SBDSC.f90

${OBJECTDIR}/src/SDST.o: src/SDST.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/SDST.o src/SDST.f90

${OBJECTDIR}/src/SLTB.o: src/SLTB.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/SLTB.o src/SLTB.f90

${OBJECTDIR}/src/SOCIOA.o: src/SOCIOA.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/SOCIOA.o src/SOCIOA.f90

${OBJECTDIR}/src/SOCIOD.o: src/SOCIOD.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/SOCIOD.o src/SOCIOD.f90

${OBJECTDIR}/src/SOIL_BDCD.o: src/SOIL_BDCD.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/SOIL_BDCD.o src/SOIL_BDCD.f90

${OBJECTDIR}/src/SOLIOC.o: src/SOLIOC.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/SOLIOC.o src/SOLIOC.f90

${OBJECTDIR}/src/SOLIOP.o: src/SOLIOP.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/SOLIOP.o src/SOLIOP.f90

${OBJECTDIR}/src/SOLT.o: src/SOLT.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/SOLT.o src/SOLT.f90

${OBJECTDIR}/src/SPLA.o: src/SPLA.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/SPLA.o src/SPLA.f90

${OBJECTDIR}/src/SPOFC.o: src/SPOFC.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/SPOFC.o src/SPOFC.f90

${OBJECTDIR}/src/SPRNT.o: src/SPRNT.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/SPRNT.o src/SPRNT.f90

${OBJECTDIR}/src/SWN1530.o: src/SWN1530.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/SWN1530.o src/SWN1530.f90

${OBJECTDIR}/src/SWNN.o: src/SWNN.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/SWNN.o src/SWNN.f90

${OBJECTDIR}/src/SWRTNNW.o: src/SWRTNNW.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/SWRTNNW.o src/SWRTNNW.f90

${OBJECTDIR}/src/SWRTNR.o: src/SWRTNR.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/SWRTNR.o src/SWRTNR.f90

${OBJECTDIR}/src/SWRTN_BNW.o: src/SWRTN_BNW.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/SWRTN_BNW.o src/SWRTN_BNW.f90

${OBJECTDIR}/src/SWTN.o: src/SWTN.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/SWTN.o src/SWTN.f90

${OBJECTDIR}/src/TBURN.o: src/TBURN.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/TBURN.o src/TBURN.f90

${OBJECTDIR}/src/TGRAZ.o: src/TGRAZ.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/TGRAZ.o src/TGRAZ.f90

${OBJECTDIR}/src/THVOR.o: src/THVOR.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/THVOR.o src/THVOR.f90

${OBJECTDIR}/src/THVRT.o: src/THVRT.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/THVRT.o src/THVRT.f90

${OBJECTDIR}/src/TILTBL.o: src/TILTBL.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/TILTBL.o src/TILTBL.f90

${OBJECTDIR}/src/TLOP.o: src/TLOP.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/TLOP.o src/TLOP.f90

${OBJECTDIR}/src/TMIX.o: src/TMIX.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/TMIX.o src/TMIX.f90

${OBJECTDIR}/src/TMIX_FLOODED.o: src/TMIX_FLOODED.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/TMIX_FLOODED.o src/TMIX_FLOODED.f90

${OBJECTDIR}/src/TMXL1.o: src/TMXL1.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/TMXL1.o src/TMXL1.f90

${OBJECTDIR}/src/TRDST.o: src/TRDST.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/TRDST.o src/TRDST.f90

${OBJECTDIR}/src/WDLYSTA.o: src/WDLYSTA.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/WDLYSTA.o src/WDLYSTA.f90

${OBJECTDIR}/src/WGN.o: src/WGN.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/WGN.o src/WGN.f90

${OBJECTDIR}/src/WHLRMX.o: src/WHLRMX.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/WHLRMX.o src/WHLRMX.f90

${OBJECTDIR}/src/WNDIR.o: src/WNDIR.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/WNDIR.o src/WNDIR.f90

${OBJECTDIR}/src/WNSPD.o: src/WNSPD.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/WNSPD.o src/WNSPD.f90

${OBJECTDIR}/src/WRAIN.o: src/WRAIN.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/WRAIN.o src/WRAIN.f90

${OBJECTDIR}/src/WREAD.o: src/WREAD.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/WREAD.o src/WREAD.f90

${OBJECTDIR}/src/WRLHUM.o: src/WRLHUM.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/WRLHUM.o src/WRLHUM.f90

${OBJECTDIR}/src/WRWD.o: src/WRWD.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/WRWD.o src/WRWD.f90

${OBJECTDIR}/src/WSOLRA.o: src/WSOLRA.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/WSOLRA.o src/WSOLRA.f90

${OBJECTDIR}/src/WTAIR.o: src/WTAIR.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/WTAIR.o src/WTAIR.f90

${OBJECTDIR}/src/WTAIX.o: src/WTAIX.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/WTAIX.o src/WTAIX.f90

${OBJECTDIR}/src/modparm.o: src/modparm.f90 
	${MKDIR} -p ${OBJECTDIR}/src
	$(COMPILE.f) -O2 -o ${OBJECTDIR}/src/modparm.o src/modparm.f90

# Subprojects
.build-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${CND_BUILDDIR}/${CND_CONF}
	${RM} ${CND_DISTDIR}/${CND_CONF}/${CND_PLATFORM}/apex1501
	${RM} *.mod

# Subprojects
.clean-subprojects:

# Enable dependency checking
.dep.inc: .depcheck-impl

include .dep.inc
