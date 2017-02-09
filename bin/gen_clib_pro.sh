#!/bin/bash
#
# @brief   Generete C Library Project
# @version ver.1.0
# @date    Thu Feb 07 00:46:32 2016
# @company None, free software to use 2016
# @author  Vladimir Roncevic <vladimir.roncevic@frobas.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=${UTIL_ROOT}/sh_util/${UTIL_VERSION}
UTIL_LOG=${UTIL}/log

.	${UTIL}/bin/devel.sh
.	${UTIL}/bin/usage.sh
.	${UTIL}/bin/check_root.sh
.	${UTIL}/bin/check_tool.sh
.	${UTIL}/bin/logging.sh
.	${UTIL}/bin/load_conf.sh
.	${UTIL}/bin/load_util_conf.sh
.	${UTIL}/bin/progress_bar.sh

GEN_CLIB_PRO_TOOL=gen_clib_pro
GEN_CLIB_PRO_VERSION=ver.1.0
GEN_CLIB_PRO_HOME=${UTIL_ROOT}/${GEN_CLIB_PRO_TOOL}/${GEN_CLIB_PRO_VERSION}
GEN_CLIB_PRO_CFG=${GEN_CLIB_PRO_HOME}/conf/${GEN_CLIB_PRO_TOOL}.cfg
GEN_CLIB_PRO_UTIL_CFG=${GEN_CLIB_PRO_HOME}/conf/${GEN_CLIB_PRO_TOOL}_util.cfg
GEN_CLIB_PRO_LOG=${GEN_CLIB_PRO_HOME}/log

declare -A GEN_CLIB_PRO_USAGE=(
	[USAGE_TOOL]="${GEN_CLIB_PRO_TOOL}"
	[USAGE_ARG1]="[PROJECT NAME] Project name for C library"
	[USAGE_EX_PRE]="# Generating C library"
	[USAGE_EX]="${GEN_CLIB_PRO_TOOL} rtp"
)

declare -A GEN_CLIB_PRO_LOGGING=(
	[LOG_TOOL]="${GEN_CLIB_PRO_TOOL}"
	[LOG_FLAG]="info"
	[LOG_PATH]="${GEN_CLIB_PRO_LOG}"
	[LOG_MSGE]="None"
)

declare -A PB_STRUCTURE=(
	[BW]=50
	[MP]=100
	[SLEEP]=0.01
)

TOOL_DBG="false"
TOOL_LOG="false"
TOOL_NOTIFY="false"

#
# @brief   Main function
# @param   Value required project name
# @retval  Function __gen_clib_pro exit with integer value
#			0   - tool finished with success operation
#			128 - missing argument(s) from cli
#			129 - failed to load tool script configuration from files
#			130 - failed to load tool configuration with project set
#			131 - directory with project name already exist
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __gen_clib_pro "rtp"
#
function __gen_clib_pro() {
	local PN=$1
	if [ -n "${PN}" ]; then
		local FUNC=${FUNCNAME[0]} MSG="None" STATUS_CONF STATUS_CONF_UTIL STATUS
		MSG="Loading basic and util configuration!"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		__progress_bar PB_STRUCTURE
		declare -A config_gen_clib_pro=()
		__load_conf "$GEN_CLIB_PRO_CFG" config_gen_clib_pro
		STATUS_CONF=$?
		declare -A config_gen_clib_pro_util=()
		__load_util_conf "$GEN_CLIB_PRO_UTIL_CFG" config_gen_clib_pro_util
		STATUS_CONF_UTIL=$?
		declare -A STATUS_STRUCTURE=(
			[1]=$STATUS_CONF [2]=$STATUS_CONF_UTIL
		)
		__check_status STATUS_STRUCTURE
		STATUS=$?
		if [ $STATUS -eq $NOT_SUCCESS ]; then
			MSG="Force exit!"
			__info_debug_message_end "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
			exit 129
		fi
		TOOL_LOG=${config_gen_clib_pro[LOGGING]}
		TOOL_DBG=${config_gen_clib_pro[DEBUGGING]}
		TOOL_NOTIFY=${config_gen_clib_pro[EMAILING]}
		local V=${config_gen_clib_pro_util[VERSION]} DATE=`date` H="#" BSL="\\"
		local AN=${config_gen_clib_pro_util[AUTHOR_NAME]} T="	"
		local AE=${config_gen_clib_pro_util[AUTHOR_EMAIL]} TREE
		local PROJECT_SET=${config_gen_clib_pro_util[PROJECT_SET]}
		local FN="Project created ${DATE}" RMSG="${H} Readme section"
		local UPN=$(echo ${PN} | tr 'a-z' 'A-Z')
		declare -A project_set=()
		__load_util_conf "${GEN_CLIB_PRO_HOME}/conf/${PROJECT_SET}" project_set
		STATUS=$?
		if [ $STATUS -eq $NOT_SUCCESS ]; then
			MSG="Force exit!"
			__info_debug_message_end "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
			exit 130
		fi
		MSG="Generate project structure!"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		if [ -d "${PN}/" ]; then
			MSG="Directory already exist [${PN}]"
			__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
			MSG="Force exit!"
			__info_debug_message_end "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
			exit 131
		fi
		local CDIR=`pwd`
		local PDIR="${CDIR}/${PN}"
		MSG="Generating directory [${PDIR}/]"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		mkdir "${PDIR}/"
		local ASHT=${project_set[AUTOGEN_SH]} ASHF="${PDIR}/autogen.sh"
		local ASHC=$(cat "${GEN_CLIB_PRO_HOME}/conf/${ASHT}")
		MSG="Generating file [${ASHF}]"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		echo -e "${ASHC}" > "${ASHF}"
		local CT=${project_set[CONFIGURE_AC]} CF="${PDIR}/configure.ac" CL
		local CTF="${GEN_CLIB_PRO_HOME}/conf/${CT}"
		MSG="Generating file [${CF}]"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		while read CL
		do
			eval echo "${CL}" >> ${CF}
		done < ${CTF}
		local PO="${PDIR}/po"
		MSG="Generating directory [${PO}/]"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		mkdir "${PO}/"
		local CHLOG="${PO}/ChangeLog" CLT=${project_set[CHANGELOG]} CLL
		local CLTF="${GEN_CLIB_PRO_HOME}/conf/${CLT}" CHLOG2="${PDIR}/ChangeLog"
		MSG="Generating file [${CHLOG}]"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		while read CLL
		do
			eval echo "${CLL}" >> ${CHLOG}
			eval echo "${CLL}" >> ${CHLOG2}
		done < ${CLTF}
		local DESCRIPTION="# please keep this list sorted alphabetically"
		local LING="${PO}/LINGUAS"
		MSG="Generating file [${LING}]"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		echo -e "${DESCRIPTION}\n#" > ${LING}
		DESCRIPTION="# List of source files containing translatable strings."
		local POTF="${PO}/POTFILES.in"
		MSG="Generate file [${POTF}]"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		echo -e "${DESCRIPTION}\n\nsrc/main.cc" > "${POTF}"
		local SRC="${PDIR}/src"
		MSG="Generating directory [${SRC}/]"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		mkdir "${SRC}/"
		local SCF="${SRC}/lib.c" SCL SCT=${project_set[C_SOURCE]}
		local SCTF="${GEN_CLIB_PRO_HOME}/conf/${SCT}"
		MSG="Generating file [${SCF}]"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		while read SCL
		do
			eval echo "${SCL}" >> ${SCF}
		done < ${SCTF}
		local HCF="${SRC}/${PN}.h" HCL HCT=${project_set[H_HEADER]}
		local HCTF="${GEN_CLIB_PRO_HOME}/conf/${HCT}"
		MSG="Generating file [${HCF}]"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		while read HCL
		do
			eval echo "${HCL}" >> ${HCF}
		done < ${HCTF}
		local PCF="${SRC}/${PN}-0.1.pc.in" PCL PCT=${project_set[PCIN]}
		local PCTF="${GEN_CLIB_PRO_HOME}/conf/${PCT}"
		MSG="Generating file [${PCF}]"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		while read PCL
		do
			eval echo "${PCL}" >> ${PCF}
		done < ${PCTF}
		local MSF="${SRC}/Makefile.am" MST=${project_set[MAKEFILE_AMS]}
		local MSTF="${GEN_CLIB_PRO_HOME}/conf/${MST}" MSL
		MSG="Generating file [${MSF}]"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		while read MSL
		do
			eval echo "${MSL}" >> ${MSF}
		done < ${MSTF}
		local MRF="${PDIR}/Makefile.am" MRL MRT=${project_set[MAKEFILE_AMR]}
		local MRTF="${GEN_CLIB_PRO_HOME}/conf/${MRT}"
		MSG="Generating file [${MRF}]"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		while read MRL
		do
			eval echo "${MRL}" >> ${MRF}
		done < ${MRTF}
		local COT=${project_set[COPYING]} COF="${PDIR}/COPYING"
		local COC=$(cat "${GEN_CLIB_PRO_HOME}/conf/${COT}")
		MSG="Generating file [${COF}]"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		echo -e "${COC}" > "${COF}"
		local AUT=${project_set[AUTHORS]} AUF="${PDIR}/AUTHORS" AUL
		local AUTF="${GEN_CLIB_PRO_HOME}/conf/${AUT}"
		MSG="Generating file [${AUF}]"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		while read AUL
		do
			eval echo "${AUL}" >> ${AUF}
		done < ${AUTF}
		local NT=${project_set[NEWS]} NF="${PDIR}/NEWS" NL
		local FIRST_NEWS="Project created ${DATE}"
		local NTF="${GEN_CLIB_PRO_HOME}/conf/${NT}"
		MSG="Generating file [${NF}]"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		while read NL
		do
			eval echo "${NL}" >> ${NF}
		done < ${NTF}
		local RT=${project_set[README]} RF="${PDIR}/README" RL
		local RMSG="${HASH} Readme section"
		local RTF="${GEN_CLIB_PRO_HOME}/conf/${RT}"
		MSG="Generating file [${RF}]"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		while read RL
		do
			eval echo "${RL}" >> ${RF}
		done < ${RTF}
		local USRID=${config_gen_clib_pro_util[UID]}
		local GRPID=${config_gen_clib_pro_util[GID]}
		eval "chown -R ${USRID}.${GRPID} ${PDIR}/"
		MSG="Set permission!"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		__info_debug_message "$MSG" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		eval "chmod -R 755 ${PDIR}/"
		__info_debug_message_end "Done" "$FUNC" "$GEN_CLIB_PRO_TOOL"
		TREE=$(which tree)
		__check_tool "${TREE}"
		STATUS=$?
		if [ $STATUS -eq $SUCCESS ]; then
			eval "${TREE} -L 3 ${PDIR}/"
		fi
		exit 0
	fi
	__usage GEN_CLIB_PRO_USAGE
	exit 128
}

#
# @brief   Main entry point of script tool
# @param   Value required project name
# @exitval Script tool ossl exit with integer value
#			0   - tool finished with success operation 
# 			127 - run tool script as root user from cli
#			128 - missing argument(s) from cli
#			129 - failed to load tool script configuration from files
#			130 - failed to load tool configuration with project set
#			131 - directory with project name already exist
#
printf "\n%s\n%s\n\n" "${GEN_CLIB_PRO_TOOL} ${GEN_CLIB_PRO_VERSION}" "`date`"
__check_root
STATUS=$?
if [ $STATUS -eq $SUCCESS ]; then
	__gen_clib_pro $1
fi

exit 127

