SELECT
case  when ((m8013.enb>='655360' and m8013.enb<='656383' ) or (m8013.enb>= '686080' and m8013.enb<='686591' ) or (m8013.enb>= '696320' and m8013.enb<='696831' )or (m8013.enb>= '119296' and m8013.enb<='120831' )or (m8013.enb>= '198912' and m8013.enb<='199423' )or (m8013.enb >='809728' and m8013.enb <='812543')or (m8013.enb >='838912' and m8013.enb <='839423')or (m8013.enb >='335872' and m8013.enb <='336639')or (m8013.enb >='557056' and m8013.enb <='557567') or (m8013.enb>= '567552' and m8013.enb<= '568063')) then '湛江'
when ((m8013.enb>='656384' and m8013.enb<='657151' ) or (m8013.enb>= '683520' and m8013.enb<='683775' ) or (m8013.enb>= '698880' and m8013.enb<='699647' ) or (m8013.enb>= '711168' and m8013.enb<='712191' )or (m8013.enb>= '199680' and m8013.enb<='199935' )or (m8013.enb >='815616' and m8013.enb <='817663')or (m8013.enb >='337664' and m8013.enb <='338175')or (m8013.enb >='559360' and m8013.enb <='559871')or (m8013.enb >='570368' and m8013.enb <='571135')) then '茂名'
when ((m8013.enb>='659712' and m8013.enb<='660223' ) or (m8013.enb >= '684032' and m8013.enb <='684287' ) or(m8013.enb>= '701184' and m8013.enb<='701951' ) or (m8013.enb>= '716800' and m8013.enb<='717055' )or (m8013.enb>= '201728' and m8013.enb<='201983' )or (m8013.enb >='822528' and m8013.enb <='823807')or (m8013.enb >='837888' and m8013.enb <='838399')or (m8013.enb >='340736' and m8013.enb <='341247')or (m8013.enb >='561920' and m8013.enb <='562431')) then '潮州'
when ((m8013.enb>='660736' and m8013.enb<='661247' ) or (m8013.enb >= '683776' and m8013.enb <='684031' ) or(m8013.enb>= '702464' and m8013.enb<='703487' )or (m8013.enb>= '202496' and m8013.enb<='203007' )or (m8013.enb >='824832' and m8013.enb <='826879')or (m8013.enb >='838400' and m8013.enb <='838911')or (m8013.enb >='562944' and m8013.enb <='563455')or (m8013.enb >='567040' and m8013.enb <='567551')) then '梅州'
when ((m8013.enb>='662272' and m8013.enb<='662783' ) or (m8013.enb>= '704000' and m8013.enb<='704511' ) or (m8013.enb >='719616' and m8013.enb <='720127')or (m8013.enb >='203776' and m8013.enb <='204031')or (m8013.enb >='829440' and m8013.enb <='831231')or (m8013.enb >='841216' and m8013.enb <='841727')or (m8013.enb >='564480' and m8013.enb <='564991')or (m8013.enb >='571136' and m8013.enb <='571647')or (m8013.enb >='707072' and  m8013.enb >='707327')) then '阳江'
else 'NA'
end "City"
, TO_CHAR(sysdate,'yyyymmddhh24')   sdatetime
--,M8013.sdatetime
,m8013.enb || '_' || m8013.cell_id As "enb_cell"
,m8013.CellName As "CellName"

,M8013.ver "软件版本"
,count(m8013.enb) As "休眠时段数"
,sum(M8013C17+M8013C18+M8013C19+M8013C20+ M8013C21) as RRC连接建立尝试次数
,sum(M8013C5) as RRC连接建立成功次数
,sum(M8007C7) as SRB1建立尝试次数
,sum(M8007C8) as SRB1建立成功次数
,sum(M8007C9) as SRB1建立失败次数
,sum(M8013C24) as DRX激活子帧数
,sum(M8013C25) as DRX睡眠子帧数


FROM

--#############################
--M8007_Radio_Bearer (full)
--#############################
(
Select
to_char(period_start_time,'yyyymmddhh24') sdatetime
,lnbts.co_OBJECT_INSTANCE enb
,lncel.co_OBJECT_INSTANCE cell_id
,COUNT(DISTINCT MRBTS_ID) MRBTS_COUNT
,COUNT(DISTINCT LNBTS_ID) LNBTS_COUNT
,COUNT(DISTINCT LNCEL_ID) LNCEL_COUNT
--,LNCEL_ID
,to_char(period_start_time,'yyyymmddhh24')||LNCEL_ID cel_key_id
,sum(nvl(DATA_RB_STP_ATT,0)) M8007C0        --The number of Data Radio Bearers attempted to set up per cell. &#10;&#10;It comprises also attempted Data Radio Bearer setups up during an incoming Handover at the target cell.
,sum(nvl(DATA_RB_STP_COMP,0)) M8007C1       --The number of successfully established Data Radio Bearers per cell. &#10;&#10;It comprises also the successfully established Data Radio Bearers due to an incoming Handover at the target cell.
,sum(nvl(DATA_RB_STP_FAIL,0)) M8007C2       --The number of Data Radio Bearers failed to setup per cell. &#10;&#10;It comprises also the Data Radio Bearers failed to setup during incoming Handover at the target cell.
,sum(nvl(RB_REL_REQ_NORM_REL,0)) M8007C3    --The number of released Data Radio Bearers due to normal release per cell. &#10;&#10;It comprises also the released Data Radio Bearers originally setup due to an incoming Handover.
,sum(nvl(RB_REL_REQ_DETACH_PROC,0)) M8007C4 --The number of Radio Bearer Release requests due to Detach procedure
,sum(nvl(RB_REL_REQ_RNL,0)) M8007C5         --The number of released Data Radio Bearers due to lost radio connection between UE and eNB.&#10;&#10;It comprises also the release of Data Radio Bearers originally setup due to an incoming Handover.
,sum(nvl(RB_REL_REQ_OTHER,0)) M8007C6       --The number of released Data Radio Bearers due to other reasons. &#10;&#10;It comprises also the release of Data Radio Bearers originally setup due to an incoming Handover.
,sum(nvl(SRB1_SETUP_ATT,0)) M8007C7         --The number of Signalling Radio Bearer 1 setup attempts. SRB1 for most RRC messages using the DCCH.
,sum(nvl(SRB1_SETUP_SUCC,0)) M8007C8         --The number of Signalling Radio Bearer 1 setup completions. SRB1 for most RRC messages using the DCCH.
,sum(nvl(SRB1_SETUP_FAIL,0)) M8007C9         --The number of Signalling Radio Bearer 1 setup failures. SRB1 for most RRC messages using the DCCH.
,sum(nvl(SRB2_SETUP_ATT,0)) M8007C10         --The number of Signalling Radio Bearer 2 setup attempts. SRB2 is for NAS messages using the DCCH (if AS security has been activated).
,sum(nvl(SRB2_SETUP_SUCC,0)) M8007C11       --The number of Signalling Radio Bearer 2 setup completions. SRB2 is for NAS messages using the DCCH (if AS security has been activated).
,sum(nvl(SRB2_SETUP_FAIL,0)) M8007C12       --The number of Signalling Radio Bearer 2 setup failures. SRB2 is for NAS messages using the DCCH (if AS security has been activated).
,sum(nvl(RB_REL_REQ_RNL_REDIR,0)) M8007C13   --The number of released Data Radio Bearers due to Radio Network Layer cause Redirect.
From
NOKLTE_PS_LRDB_lncel_hour p  --PM8007
,utp_common_objects lnbts
,utp_common_objects lncel
Where
PERIOD_START_TIME>=TO_DATE(TO_CHAR(SYSDATE-4/24,'YYYY-MM-DD HH24'),'YYYY-MM-DD HH24')
AND PERIOD_START_TIME<TO_DATE(TO_CHAR(SYSDATE-0,'YYYY-MM-DD HH24'),'YYYY-MM-DD HH24')
AND p.LNCEL_ID=lncel.co_gid
and lncel.co_parent_gid=lnbts.co_gid
AND lnbts.CO_STATE<>9     and lncel.CO_STATE<>9
Group by
to_char(period_start_time,'yyyymmddhh24')
--,LNCEL_ID
,to_char(period_start_time,'yyyymmddhh24')||LNCEL_ID
,lnbts.co_OBJECT_INSTANCE
,lncel.co_OBJECT_INSTANCE
)M8007

--#############################
--M8013_UE_State (full)
--#############################
,(
Select
to_char(period_start_time,'yyyymmddhh24') sdatetime
,lnbts.co_OBJECT_INSTANCE enb
,lncel.co_OBJECT_INSTANCE cell_id
,lncel.co_name CellName
,lnbts.co_gid lnbtsco_gid
,lncel.Co_Ocv_Sys_Version ver
,to_char(period_start_time,'yyyymmddhh24')||LNCEL_ID cel_key_id
,sum(nvl(SIGN_CONN_ESTAB_COMP,0)) M8013C5 --The number of Signaling Connection Establishment completions with the UE target to be in the ECM-CONNECTED state.
,sum(nvl(SIGN_EST_F_RRCCOMPL_MISSING,0)) M8013C6 --The number of Signaling Connection Establishment failures due to a missing RRC CONNECTION SETUP COMPLETE message. The UE has not reached the ECM-CONNECTED state.
,sum(nvl(SIGN_EST_F_RRCCOMPL_ERROR,0)) M8013C7 --The number of Signaling Connection Establishment failures due to the Erroneous or incomplete RRC CONNECTION SETUP COMPLETE message. The UE has not reached the ECM-CONNECTED state.
,sum(nvl(SIGN_CONN_ESTAB_FAIL_RRMRAC,0)) M8013C8 --The number of Signaling Connection Establishment failures due to Rejection by RRM RAC. The UE has not reached the ECM-CONNECTED state.
,sum(nvl(EPC_INIT_TO_IDLE_UE_NORM_REL,0)) M8013C9 --The number of EPC-initiated transitions to the ECM-IDLE state due to a Normal release by the UE .
,sum(nvl(EPC_INIT_TO_IDLE_DETACH,0)) M8013C10 --The number of EPC-initiated transitions to the ECM-IDLE state due to the Detach procedure by the UE or the MME .
,sum(nvl(EPC_INIT_TO_IDLE_RNL,0)) M8013C11 --The number of EPC initiated transitions to ECM-IDLE state due to Radio Network Layer cause. The UE-associated logical S1-connection is released.
,sum(nvl(EPC_INIT_TO_IDLE_OTHER,0)) M8013C12 --The number of EPC-initiated transitions to the ECM-IDLE state due to Other causes.
,sum(nvl(ENB_INIT_TO_IDLE_NORM_REL,0)) M8013C13 --The number of eNB-initiated transitions from the ECM-CONNECTED to ECM-IDLE state due to User Inactivity or Redirect. The UE-associated logical S1-connection is released.
,sum(nvl(ENB_INIT_TO_IDLE_RNL,0)) M8013C15 --The number of eNB initiated transitions from the ECM-CONNECTED to ECM-IDLE state when the Radio Connection to the UE is lost. The UE-associated logical S1-connection is released.
,sum(nvl(ENB_INIT_TO_IDLE_OTHER,0)) M8013C16 --The number of eNB-initiated transitions from the ECM-CONNECTED to ECM-IDLE state due to Other causes than User Inactivity, Redirect or Radio Connection Lost.
,sum(nvl(SIGN_CONN_ESTAB_ATT_MO_S,0)) M8013C17 --The number of Signaling Connection Establishment attempts for mobile originated signaling. From UE's point of view, the transition from ECM-IDLE to ECM-CONNECTED has started.
,sum(nvl(SIGN_CONN_ESTAB_ATT_MT,0)) M8013C18 --The number of Signaling Connection Establishment attempts for mobile terminated connections. From UE's point of view, the transition from ECM-IDLE to ECM-CONNECTED is started.
,sum(nvl(SIGN_CONN_ESTAB_ATT_MO_D,0)) M8013C19 --The number of Signaling Connection Establishment attempts for mobile originated data connections. From UE's point of view, the transition from ECM-IDLE to ECM-CONNECTED is started.
,sum(nvl(SIGN_CONN_ESTAB_ATT_OTHERS,0)) M8013C20 --The number of Signaling Connection Establishment attempts due to other reasons. From UE's point of view, the transition from ECM-IDLE to ECM-CONNECTED is started.
,sum(nvl(SIGN_CONN_ESTAB_ATT_EMG,0)) M8013C21 --Number of Signalling Connection Establishment attempts for emergency calls
,sum(nvl(SUBFRAME_DRX_ACTIVE_UE,0)) M8013C24 --The number of subframes, when UE is DRX Active.
,sum(nvl(SUBFRAME_DRX_SLEEP_UE,0)) M8013C25 --The number of subframes, when UE is DRX Sleep (i.e. not DRX Active).
,sum(nvl(SIGN_CONN_ESTAB_COMP_EMG,0)) M8013C26 --The number of Signalling Connection Establishment completions for emergency calls
,sum(nvl(SIGN_CONN_ESTAB_FAIL_RB_EMG,0)) M8013C27 --The number of Signalling Connection Establishment failures for emergency calls due to missing RB (Radio Bearer) resources
,sum(nvl(PRE_EMPT_UE_CONTEXT_NON_GBR,0)) M8013C28 --This measurement provides the number of UE contexts being released due to lack of radio resources.
From
NOKLTE_PS_LUEST_lncel_hour p   --PM8013
,utp_common_objects lnbts
,utp_common_objects lncel

Where
PERIOD_START_TIME>=TO_DATE(TO_CHAR(SYSDATE-2/24,'YYYY-MM-DD HH24'),'YYYY-MM-DD HH24')
AND PERIOD_START_TIME<TO_DATE(TO_CHAR(SYSDATE-0,'YYYY-MM-DD HH24'),'YYYY-MM-DD HH24')
AND p.LNCEL_ID=lncel.co_gid
and lncel.co_parent_gid=lnbts.co_gid
AND lnbts.CO_STATE<>9   and lncel.CO_STATE<>9
group by
to_char(period_start_time,'yyyymmddhh24')
,lnbts.co_OBJECT_INSTANCE
,lncel.co_OBJECT_INSTANCE
,lncel.co_name
,to_char(period_start_time,'yyyymmddhh24')||LNCEL_ID
,lnbts.co_gid  ,lncel.Co_Ocv_Sys_Version
)M8013


WHERE
M8013.sdatetime=M8007.sdatetime(+)  and M8013.cel_key_id=M8007.cel_key_id(+)

And ((M8007C8=0 and M8007C7>5) or( M8013C5=0 and (M8013C24)+(M8013C25)>1000) or (M8007C8=0 and (M8013C24)+(M8013C25)>1000))

Having
count(m8013.enb)>1      --休眠时段数

GROUP BY
case  when ((m8013.enb>='655360' and m8013.enb<='656383' ) or (m8013.enb>= '686080' and m8013.enb<='686591' ) or (m8013.enb>= '696320' and m8013.enb<='696831' )or (m8013.enb>= '119296' and m8013.enb<='120831' )or (m8013.enb>= '198912' and m8013.enb<='199423' )or (m8013.enb >='809728' and m8013.enb <='812543')or (m8013.enb >='838912' and m8013.enb <='839423')or (m8013.enb >='335872' and m8013.enb <='336639')or (m8013.enb >='557056' and m8013.enb <='557567') or (m8013.enb>= '567552' and m8013.enb<= '568063') ) then '湛江'
when ((m8013.enb>='656384' and m8013.enb<='657151' ) or (m8013.enb>= '683520' and m8013.enb<='683775' ) or (m8013.enb>= '698880' and m8013.enb<='699647' ) or (m8013.enb>= '711168' and m8013.enb<='712191' )or (m8013.enb>= '199680' and m8013.enb<='199935' )or (m8013.enb >='815616' and m8013.enb <='817663')or (m8013.enb >='337664' and m8013.enb <='338175')or (m8013.enb >='559360' and m8013.enb <='559871')or (m8013.enb >='570368' and m8013.enb <='571135')) then '茂名'
when ((m8013.enb>='659712' and m8013.enb<='660223' ) or (m8013.enb >= '684032' and m8013.enb <='684287' ) or(m8013.enb>= '701184' and m8013.enb<='701951' ) or (m8013.enb>= '716800' and m8013.enb<='717055' )or (m8013.enb>= '201728' and m8013.enb<='201983' )or (m8013.enb >='822528' and m8013.enb <='823807')or (m8013.enb >='837888' and m8013.enb <='838399')or (m8013.enb >='340736' and m8013.enb <='341247')or (m8013.enb >='561920' and m8013.enb <='562431')) then '潮州'
when ((m8013.enb>='660736' and m8013.enb<='661247' ) or (m8013.enb >= '683776' and m8013.enb <='684031' ) or(m8013.enb>= '702464' and m8013.enb<='703487' )or (m8013.enb>= '202496' and m8013.enb<='203007' )or (m8013.enb >='824832' and m8013.enb <='826879')or (m8013.enb >='838400' and m8013.enb <='838911')or (m8013.enb >='562944' and m8013.enb <='563455')or (m8013.enb >='567040' and m8013.enb <='567551')) then '梅州'
when ((m8013.enb>='662272' and m8013.enb<='662783' ) or (m8013.enb>= '704000' and m8013.enb<='704511' ) or (m8013.enb >='719616' and m8013.enb <='720127')or (m8013.enb >='203776' and m8013.enb <='204031')or (m8013.enb >='829440' and m8013.enb <='831231')or (m8013.enb >='841216' and m8013.enb <='841727')or (m8013.enb >='564480' and m8013.enb <='564991')or (m8013.enb >='571136' and m8013.enb <='571647')or (m8013.enb >='707072' and  m8013.enb >='707327')) then '阳江'
else 'NA'
end
--   ,M8013.sdatetime
,m8013.enb || '_' || m8013.cell_id
,m8013.CellName
,M8013.ver

--&1&2
